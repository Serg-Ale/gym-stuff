# Treino do dia

Assistente de treino para o celular: escolha o treino do dia e acompanhe exercício por exercício, com
ilustração, séries, repetições, carga, RIR, descanso sugerido e um timer que você ajusta na hora.

## O que faz

- **Um exercício por vez**, com cues de execução, técnica (drop set, isometria, tempo) e nota fixada por exercício.
- **Registro de séries**: repetições, carga, tipo da série e RIR. A tela mostra "Última vez".
- **Timer de descanso** que começa ao concluir a série, com ajuste de −30/−15/+15/+30 s, pausar e zerar.
- **Login por link mágico ou senha pessoal**, cadastro fechado (só e-mails convidados).
- **Funciona sem internet**: grava primeiro no aparelho e envia ao banco quando a conexão volta.
  Pode ser instalado na tela inicial.

## Como é feito

- HTML, CSS e JavaScript puro em um único `index.html`. Sem build.
- [Supabase](https://supabase.com) (Auth e Postgres) com RLS: cada pessoa só lê e grava os próprios dados.
  O esquema está em [`supabase/schema.sql`](supabase/schema.sql).
- Hospedado na [Vercel](https://vercel.com), com deploy automático a cada push na `main`.
- `sw.js` (service worker) e `manifest.webmanifest` dão o modo offline e a instalação.
- `vendor/supabase.js` é o `@supabase/supabase-js` 2.117.2, hospedado junto para funcionar offline.

## Rodar localmente

```sh
python3 -m http.server 8000
```

Abra `http://localhost:8000`. Para entrar, o e-mail precisa estar na tabela `allowed_emails` do seu projeto
Supabase, e `SB_URL` e `SB_KEY` em `index.html` precisam apontar para ele. A chave `sb_publishable_…`
é pública por natureza: quem protege os dados é o RLS, não o segredo da chave.

## Ilustrações

As imagens em `img/` foram extraídas de uma ficha de treino em PDF e vêm de sites de terceiros, algumas
com marca d'água. Estão aqui só para uso pessoal, e os direitos são dos autores (veja
[`img/PROVENANCE.md`](img/PROVENANCE.md)). Se você for autor de alguma e quiser a remoção, abra uma issue.

As fontes (Barlow e Big Shoulders Display) são da Google Fonts, sob a licença SIL Open Font License.
