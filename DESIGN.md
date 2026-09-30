---
name: Treino do dia
description: Borracha preta, giz e discos esmaltados nas cores IWF; cada série é um disco que você carrega.
colors:
  rubber: "#121212"
  rubber-2: "#1a1a1b"
  rubber-3: "#252527"
  line: "#36363a"
  chalk: "#f1f1ec"
  muted: "#a6a69f"
  on-plate: "#141414"
  plate-red: "#f0444f"
  plate-blue: "#4a7cf0"
  plate-yellow: "#f2c230"
  plate-green: "#3fbf68"
  plate-white: "#f1f1ec"
  chalk-panel: "#ecebe4"
typography:
  display:
    fontFamily: "Big Shoulders Display, Arial Narrow, Roboto Condensed, sans-serif"
    fontSize: "clamp(23px, 7vw, 31px)"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "0.01em"
  numeral:
    fontFamily: "Big Shoulders Display, Arial Narrow, Roboto Condensed, sans-serif"
    fontSize: "42px"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "0.01em"
  title:
    fontFamily: "Big Shoulders Display, Arial Narrow, Roboto Condensed, sans-serif"
    fontSize: "20px"
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "0.08em"
  body:
    fontFamily: "Barlow, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "17px"
    fontWeight: 400
    lineHeight: 1.45
  label:
    fontFamily: "Barlow, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "15px"
    fontWeight: 500
    lineHeight: 1.25
rounded:
  rail: "3px"
  focus: "6px"
  control: "14px"
  dock: "16px"
  card: "20px"
  pill: "999px"
  disc: "50%"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  dock-height: "84px"
components:
  disc-set:
    backgroundColor: "transparent"
    textColor: "{colors.chalk}"
    rounded: "{rounded.disc}"
    size: "56px"
  disc-set-done:
    backgroundColor: "{colors.plate-red}"
    textColor: "{colors.on-plate}"
  day-disc:
    textColor: "{colors.chalk}"
    rounded: "{rounded.disc}"
    size: "56px"
  day-disc-selected:
    textColor: "{colors.on-plate}"
  block:
    backgroundColor: "{colors.rubber-2}"
    rounded: "{rounded.card}"
    padding: "12px"
  control:
    backgroundColor: "{colors.rubber-3}"
    textColor: "{colors.chalk}"
    rounded: "{rounded.control}"
    height: "52px"
  figure-panel:
    backgroundColor: "{colors.chalk-panel}"
    rounded: "{rounded.card}"
  dock-button-ready:
    backgroundColor: "{colors.plate-red}"
    textColor: "{colors.on-plate}"
    rounded: "{rounded.dock}"
    height: "56px"
  dock:
    backgroundColor: "{colors.rubber}"
    height: "84px"
---

# Design System: Treino do dia

## Overview

**Creative North Star: "Anilhas Calibradas"**

O mundo é um piso de borracha preta fosca com giz por cima. Cada dia da semana é uma cor de anilha IWF (vermelho, azul, amarelo, verde, branco) e cada série é um disco esmaltado plano que se "carrega" ao tocar: anel de 4px vazado, preenchido quando feita. Numerais condensados estampados (Big Shoulders Display) carregam carga, reps, contagem e tempo; Barlow fala o resto. Ilustrações ficam em painéis de giz com multiply, como placa esmaltada.

A densidade é de operação: uma coluna de até 560px, alvos de 44 a 56px, um toque por série. Não há gradiente, brilho, neon nem sombra. Profundidade vem só de camadas tonais de borracha (rubber, rubber-2, rubber-3) e de um filete de 1px na doca.

**Key Characteristics:**
- Uma única cor de dia ativa por vez (`--plate` no body por `data-day`); as demais só aparecem no rack de dias.
- Discos planos: anel 4px, filete interno a 38% da cor, preenchimento sólido quando ativo.
- Numerais condensados em peso 800 para tudo que é número; rótulos em caixa-alta condensada com tracking 0.08em.
- Sem sombras, sem gradientes; superfícies em 3 tons de borracha.
- Um único marcador de passo atual na régua (triângulo de giz).

## Colors

Paleta de ginásio: quase-preto neutro, giz quente e cinco esmaltes saturados usados como código, nunca como decoração.

### Primary
- **Esmalte do Dia** (`plate-*`, varia por `data-day`): segunda vermelho (#f0444f), terça azul (#4a7cf0), quarta amarelo (#f2c230), quinta verde (#3fbf68), sexta branco-giz (#f1f1ec). Preenche séries feitas, segmento da régua, RIR escolhido, marcadores de dica, botão Próximo quando pronto, anel e tempo do descanso concluído, cursor e seleção de texto.

### Neutral
- **Borracha** (#121212): fundo da página e da doca.
- **Borracha 2** (#1a1a1b): blocos, acordeões, linhas da visão do treino.
- **Borracha 3** (#252527): controles, chips, trilho vazio da régua, botões de doca.
- **Filete** (#36363a): borda da doca, botão de reset, estado pressionado de steppers.
- **Giz** (#f1f1ec): texto principal e estado selecionado de controles.
- **Giz Apagado** (#a6a69f): texto secundário, séries não feitas.
- **Tinta de Anilha** (#141414): texto sobre qualquer esmalte preenchido.
- **Painel de Giz** (#ecebe4): fundo das ilustrações.

### Named Rules
**The Code-Only Rule.** Cor de esmalte significa dia ou estado da série. Nunca é usada como decoração de superfície.

**The Ink-On-Enamel Rule.** Sobre qualquer esmalte preenchido, o texto é Tinta de Anilha (#141414), nunca giz.

## Typography

**Display Font:** Big Shoulders Display (com Arial Narrow, Roboto Condensed)
**Body Font:** Barlow (com system-ui)

**Character:** Condensado estampado para tudo que se lê de relance (nome, número, tempo); humanista neutro para prosa de técnica.

### Hierarchy
- **Display** (800, clamp(23px, 7vw, 31px), 1): nome do exercício, caixa-alta.
- **Numeral** (800, 42px / 34px / 32px / 26px, 1): séries x reps, reps do stepper, carga e tempo de descanso, número do disco.
- **Title** (700, 20px, 1.1, tracking 0.08em, caixa-alta): nome do treino, rótulos de bloco, resumos de acordeão. Título da página em 800 26px, tracking 0.04em.
- **Body** (400, 17px, 1.45): notas, cues (máx. 65ch). Texto de apoio em 16px.
- **Label** (500 a 600, 15px a 16px): tags, tipo de série, chips, unidade.

### Named Rules
**The Stamped Numeral Rule.** Todo número que o usuário lê ou edita usa Big Shoulders 800 com `tabular-nums`; prosa nunca usa a face condensada.

## Layout

Coluna única centrada, máx. 560px, padding lateral de 16px. Topo: título e seletor de pessoa, rack de 5 discos de dia com `space-between`, nome do treino, régua. Conteúdo rola por baixo de uma doca fixa de 84px (padding inferior = doca + 28px + safe-area). O herói do exercício é grade de texto + ilustração a 40%, colapsando para coluna única com ilustração 4:3 quando ampliada. Linhas de série: disco 56px, stepper de reps, tipo (68px). Ritmo de espaçamento: 4, 6, 8, 10, 12, 14, 16px. Abaixo de 380px a doca encolhe anel e tipografia. Movimento: slides de 0.2s com ease `cubic-bezier(.16,1,.3,1)`, desligados por `prefers-reduced-motion`.

**The Proportional Rail Rule.** A régua tem um segmento por exercício com `flex-grow` igual ao número de séries; largura é informação.

## Elevation & Depth

Plano. Sem `box-shadow` em nenhum lugar. Hierarquia por tom: borracha, borracha 2, borracha 3, mais o filete de 1px no topo da doca. O estado pressionado usa fundo Filete ou escala .94.

**The Flat Enamel Rule.** Nada brilha, projeta sombra ou degrada; profundidade é troca de tom.

## Shapes

Discos perfeitos para dias, séries, badge de número e botões de ícone (50%). Anel de 4px com filete interno de 2px a 38% da cor do esmalte, que escurece (rgba 0,0,0,.22) quando preenchido. Controles 14px, botões de doca 16px, blocos e painéis 20px, pílulas 999px, segmentos da régua 3px. Ilustrações em painel de giz com `mix-blend-mode: multiply`. O marcador de passo atual é um triângulo de giz (seta CSS de 6px) sobre o segmento da régua.

## Components

### Disco de série
Anel de 56px com numeral condensado 26px; ao marcar, preenche com o esmalte do dia, troca o número por um check e dá um "assentar" (escala .86 a 1.08 a 1, 0.26s). Reps ficam cinza até a série estar feita.

### Disco de dia (rack)
56px, anel 4px na cor IWF do dia, rótulo SEG a SEX em 19px; selecionado preenche e usa Tinta de Anilha.

### Régua e marcador
Trilho de 10px em borracha 3, preenchimento em esmalte do dia; o exercício atual leva um triângulo de giz acima do segmento.

### Steppers, tags e chips
Fundo borracha 3, raio 14px (chips e pílulas 999px), altura 52px (chips 44px). Tipo de série drop ou pausa inverte para giz com tinta escura.

### Painel de ilustração
Fundo #ecebe4, raio 20px, imagem com multiply e 8px de respiro, badge de esmalte de 34px no canto.

### Doca
Fixa, fundo borracha, filete superior. Anterior (48px), descanso (anel de 40px com tempo a 32px, fica em esmalte ao concluir), "+15" e Próximo 56px, que vira esmalte do dia quando o exercício está completo.

### Focus
Contorno de 3px em giz, offset 3px, raio 6px.

## Do's and Don'ts

### Do:
- **Do** usar o esmalte do dia (`--plate`) só para dia e estado de série.
- **Do** escrever texto sobre esmalte em #141414.
- **Do** manter alvos de toque de 44px ou mais (discos 56px, controles 52px).
- **Do** usar Big Shoulders 800 com tabular-nums para qualquer número.
- **Do** separar superfícies por tom de borracha, não por sombra.

### Don't:
- **Don't** usar gradiente, brilho, neon ou `box-shadow`.
- **Don't** usar cor de esmalte como fundo decorativo ou borda de cartão.
- **Don't** empilhar cartões com barra de progresso genérica; a régua proporcional e os discos são o indicador.
- **Don't** usar a face condensada em parágrafos.
