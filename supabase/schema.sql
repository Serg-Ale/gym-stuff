-- Esquema do banco (Supabase/Postgres) do assistente de treino.
-- Aplique em um projeto novo. Depois cadastre quem pode entrar:
--   insert into public.allowed_emails (email) values ('pessoa@exemplo.com');

-- 1) Cadastro fechado: só e-mails convidados conseguem criar conta.
create table public.allowed_emails (
  email text primary key check (email = lower(email)),
  created_at timestamptz not null default now()
);
alter table public.allowed_emails enable row level security;
revoke all on public.allowed_emails from anon, authenticated;

create function public.gym_block_unlisted_signup()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.email is null
     or not exists (select 1 from public.allowed_emails a where a.email = lower(new.email)) then
    raise exception 'Cadastro fechado: este e-mail não foi convidado.' using errcode = 'P0001';
  end if;
  return new;
end;
$$;
revoke all on function public.gym_block_unlisted_signup() from public, anon, authenticated;

create trigger gym_block_unlisted_signup
  before insert or update of email on auth.users
  for each row execute function public.gym_block_unlisted_signup();

-- 2) Timestamp de atualização.
create function public.gym_set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- 3) Catálogo de exercícios (leitura para usuários logados; sem escrita pelo cliente).
create table public.exercises (
  id text primary key,
  name text not null unique,
  muscle_group text not null check (muscle_group in (
    'peito','costas','ombros','biceps','triceps','quadriceps','posterior',
    'gluteos','adutores','panturrilha','abdomen','trapezio'))
);
alter table public.exercises enable row level security;
create policy exercises_select on public.exercises for select to authenticated using (true);
revoke all on public.exercises from anon;
revoke insert, update, delete, truncate on public.exercises from authenticated;

insert into public.exercises (id, name, muscle_group) values
  ('supino-maquina', 'Supino na máquina', 'peito'),
  ('supino-inclinado-maquina', 'Supino inclinado na máquina', 'peito'),
  ('crucifixo-peck-deck', 'Crucifixo na máquina (peck deck)', 'peito'),
  ('crossover-polia', 'Crossover na polia (pegada baixa)', 'peito'),
  ('triceps-testa', 'Tríceps testa', 'triceps'),
  ('triceps-pulley-corda', 'Tríceps pulley com corda', 'triceps'),
  ('prancha-alta-peso', 'Prancha alta com peso nas costas', 'abdomen'),
  ('agachamento-smith', 'Agachamento no smith', 'quadriceps'),
  ('leg-press', 'Leg press', 'quadriceps'),
  ('hack-squat', 'Hack squat na máquina', 'quadriceps'),
  ('extensora', 'Extensora', 'quadriceps'),
  ('cadeira-abdutora', 'Cadeira abdutora', 'gluteos'),
  ('stiff', 'Stiff', 'posterior'),
  ('panturrilha-carga', 'Panturrilha com carga', 'panturrilha'),
  ('puxada-frente-polia', 'Puxada frente na polia', 'costas'),
  ('remada-sentada-maquina', 'Remada sentada na máquina', 'costas'),
  ('remada-unilateral-maquina', 'Remada unilateral na máquina', 'costas'),
  ('rosca-direta', 'Rosca direta', 'biceps'),
  ('rosca-concentrada', 'Rosca concentrada', 'biceps'),
  ('abdominal-maquina-crunch', 'Abdominal na máquina (crunch)', 'abdomen'),
  ('cadeira-flexora', 'Cadeira flexora', 'posterior'),
  ('agachamento-bulgaro-smith', 'Agachamento búlgaro no smith', 'gluteos'),
  ('hip-thrust', 'Elevação pélvica (hip thrust) com barra', 'gluteos'),
  ('cadeira-adutora', 'Cadeira adutora', 'adutores'),
  ('bom-dia-smith', 'Bom dia na máquina smith', 'posterior'),
  ('panturrilha-em-pe', 'Panturrilha em pé na máquina', 'panturrilha'),
  ('desenvolvimento-maquina', 'Desenvolvimento na máquina', 'ombros'),
  ('elevacao-lateral-polia', 'Elevação lateral na polia', 'ombros'),
  ('elevacao-frontal-halteres', 'Elevação frontal com halteres', 'ombros'),
  ('remada-alta-polia', 'Remada alta na polia', 'ombros'),
  ('encolhimento-smith', 'Encolhimento de ombros no smith', 'trapezio'),
  ('prancha-lateral-peso', 'Prancha lateral com peso', 'abdomen');

-- 4) Séries realizadas. Chave natural => upserts idempotentes (fila offline).
create table public.set_logs (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  session_date date not null,
  workout_id text not null check (workout_id in ('seg','ter','qua','qui','sex')),
  exercise_id text not null references public.exercises (id),
  set_index smallint not null check (set_index >= 0),
  reps smallint not null check (reps >= 0),
  kg numeric(6,2) check (kg >= 0),
  set_type text not null default 'normal' check (set_type in ('normal','drop','pausa')),
  done boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, session_date, workout_id, exercise_id, set_index)
);
create index set_logs_history_idx on public.set_logs (user_id, exercise_id, session_date desc);
create index set_logs_exercise_idx on public.set_logs (exercise_id);
create trigger set_logs_updated_at before update on public.set_logs
  for each row execute function public.gym_set_updated_at();

-- 5) RIR por exercício no dia.
create table public.exercise_logs (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  session_date date not null,
  workout_id text not null check (workout_id in ('seg','ter','qua','qui','sex')),
  exercise_id text not null references public.exercises (id),
  rir smallint check (rir between 0 and 4),
  updated_at timestamptz not null default now(),
  primary key (user_id, session_date, workout_id, exercise_id)
);
create index exercise_logs_exercise_idx on public.exercise_logs (exercise_id);
create trigger exercise_logs_updated_at before update on public.exercise_logs
  for each row execute function public.gym_set_updated_at();

-- 6) Nota fixada por pessoa e exercício.
create table public.exercise_notes (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  exercise_id text not null references public.exercises (id),
  note text not null default '',
  updated_at timestamptz not null default now(),
  primary key (user_id, exercise_id)
);
create index exercise_notes_exercise_idx on public.exercise_notes (exercise_id);
create trigger exercise_notes_updated_at before update on public.exercise_notes
  for each row execute function public.gym_set_updated_at();

-- 7) RLS: cada pessoa só enxerga e altera as próprias linhas.
alter table public.set_logs enable row level security;
alter table public.exercise_logs enable row level security;
alter table public.exercise_notes enable row level security;

create policy set_logs_own on public.set_logs for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy exercise_logs_own on public.exercise_logs for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy exercise_notes_own on public.exercise_notes for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

revoke all on public.set_logs, public.exercise_logs, public.exercise_notes from anon;
