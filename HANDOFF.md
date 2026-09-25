# HANDOFF — estado antes do próximo `/ck:build`

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-24, 205ª rodada — 28º lote CONSTRUÍDO)

### 28º LOTE CONSTRUÍDO (205ª) — §T1092…§T1095 `x` (`/ck:build --all`)
Gate `-Build -Quiet` **ALL CHECKS PASSED** (23:12). Bateria §V334/§V353/§V405/§V502: **12/12 mutações VERMELHAS no check
certo & 1/1 sonda VERDE**, hashes dos 3 arquivos mutados = os de antes. **INSTALADO 23:13:44** (3083711 B = `output/`).
Se a ficha estava aberta, FECHAR & REABRIR. **PRÓXIMO:** pedir ao user **§T1096** (tela) junto de §T1090/§T1083/§T1080/
§T1074, que seguem `.`. **Nada commitado.** Backups de antes do build no scratchpad `b3cfaa14…\scratchpad\`:
`WoD20th.before28.lfm`, `WoD20.6.before28.lfm`, `localization.before28.lang`, `gate.before28.ps1`; bateria: `battery28.ps1`
(+ `mutfn28.ps1`, log `battery28.log`, hashes `battery28.hashes.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20th.lfm` — `McRow`: rótulo `Name` 40 & edit 54/256; `dynMcWpTag_` → `<label text="Willpower">` ESTÁTICO; coluna 110;
  barras 198/140; SAÍRAM a escrita em `mcRender` & a entrada em `MC_NAMES`. Esc: `onKeyDown` em `edtPopNote` &
  `edtPopSpec_1…5`; `escClose` acha `popNote`/`popSpec` (fecha por `popClose`); `kbRefocus` ganhou os ramos `popNote` →
  `edtPopNote` & `popSpec` → 1º slot livre (tabela de nomes local c/ laço `SPEC_PER_TRAIT`); `noteOpen`/`specOpen` chamam
  `kbRefocus(from)` depois do `.visible = true`; `specDot` termina em `kbRefocus(form)`. Zoom: `popNote` 490/400, título 20,
  `btnFontDownPopNote` 310 & `btnFontUpPopNote` 335, `X` 360, `edtPopNote` 360; `DESC_PANES` + `edtPopNote`.
- `WoD20.6.lfm:581` & `localization.lang:508` — `Willpower` pt = `Força de Vontade` (sem hífen, §Q94).
- `verify-hunters-hunted.ps1` — §V334 (`edtPopNote` nomeada nas 2 réguas), §V353 (`$FOCUS_PATHS` 4 + perna "ramo em
  `kbRefocus`"), §V405 (4 overlays, piso 10, `escClose` nomeia as 2, perna (d) `specDot`), §V502 (d) folga +10 & (e) 3
  estáticos, 0 `dynMcWpTag_`, valor sem hífen nos 2 lados. `-Literal` do `NeededPx` ficou (§V505 usa).
- 0 desvio do spec no build ∴ 0 emenda pendente.

### 28º LOTE ESPECIFICADO (205ª) — coluna (`Nome` & `Força-de-Vontade`) + Esc & zoom nas janelas do `!` (§I173)
`/ck:spec` só: §C (28º lote + §Q94 ABERTA), §I173a…e, §R172, §B175, §V334/§V353/§V405/§V502 EMENDADAS (0 §V nova),
§T1092…§T1096 (+ nota em §T1083 & marcadores ⚠ em §I171d/§I171e/§Q91). **0 código tocado, nada commitado.** Backup de
antes: `b3cfaa14…\scratchpad\SPEC.before28.md` & `HANDOFF.before28.md`.
- **PRÓXIMO:** `/ck:build` §T1092…§T1095 (os 3 primeiros em `WoD20th.lfm`, o 4º no gate) → 1 install no fim → pedir ao
  user §T1096 (tela) junto de §T1090/§T1083/§T1080/§T1074, que seguem `.`.
- **O que JÁ existia:** Esc (`escClose`/`isEscKey`/`kbRefocus`, §V405/§V353) & zoom (`fontStep`/`descFontSize`/`DESC_PANES`,
  §V334) — o lote só ESTENDE as 2 máquinas p/ `popNote` & `popSpec`; 0 função nova.
- **Armadilhas p/ o build:** (1) §V334 deriva as panes pelo NOME `edt*Desc[B]` — `edtPopNote` ⊥ casa & ! entrar NOMEADA nas
  2 réguas (XML & `DESC_PANES`), senão o par novo acende "8 botões contra 3 panes"; (2) `kbRefocus` é o ÚNICO `setFocus`
  (§V353b) — ⊥ chamar `setFocus` em `specDot`/`noteOpen`/`specOpen`; (3) `-Literal` do `NeededPx` FICA (§V505 usa) — só a
  perna de §V502e que o usava p/ `dynMcWpTag_` sai; (4) a chave `Willpower` JÁ ∃ — ⊥ criar chave; só o VALOR pt muda
  p/ `Força de Vontade` em `WoD20.6:581` & `.lang:508` (§Q94).
- **§Q94 RESPONDIDA** (mesma rodada): SEM hífen → opção (c): valor pt da chave `Willpower` = `Força de Vontade` na ficha
  inteira (`WILLPOWER` já era `FORÇA DE VONTADE`); rótulo da coluna segue estático. Livro (`descNumina_pt.lua`) FORA.

### 27º LOTE CONSTRUÍDO (204ª) — §T1084…§T1089 `x` (`/ck:build --all`)
Gate `-Build -Quiet` **ALL CHECKS PASSED** (60 s, 21:57). Bateria §V503…§V507: **23/23 mutações VERMELHAS no check
certo & 5/5 sondas VERDES**, hashes dos 3 arquivos mutados = os de antes. **INSTALADO 21:58:00** (3082312 B = `output/`).
Se a ficha estava aberta, FECHAR & REABRIR.

**§T1091 `x` (204ª):** exceção de §Q93 DECLARADA — comentário junto de `XP_CUSTOM` + §V507(e) no gate (2/2 mutações
VERMELHAS, sonda VERDE, hashes = os de antes); `-Build` VERDE; **REINSTALADO 22:14:42** (3082689 B = `output/`).
**PRÓXIMO:** pedir ao user **§T1090** (tela); §T1080/§T1083/§T1074 seguem `.` (tela, lotes 24-26). Nada commitado.

Código + gate feitos na mesma sessão do spec. **Nada commitado.** Backups de antes do build no scratchpad
`9b1e1caa…\scratchpad\`: `gate.before27.ps1`, `SPEC.before27b.md`. Bateria: `battery27.ps1` (+ `mutfn27.ps1`, log
`battery27.log`, hashes de antes `battery27.hashes.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20th.lfm` — `popScrim` `#80000000`; `popScrimB` entre `mfSearch` & `mfSearchB` (`onClick` `mfClose`); `mfNames` sem a
  exceção (popScrim gêmeo), `mfFound` sem o override, `mfClose` esconde o scrim nos 2 ramos. `SPECIALITY_ROWS = 325`,
  `SPEC_PER_TRAIT = 5`; `specFreeRow` & `specRowsOf` (globais) antes de `grantSpeciality`, que recusa o 6º do traço; ledger
  `specTraitName(slotName(field))`; `POP_BOX` + `popSpec`/título/10 slots (laço por `SPEC_PER_TRAIT`); `popClose` esconde
  `popSpec` & zera `SPEC_WIN`; `SPEC_WIN` `specKey` `specTraitName` `specOpen` `specPaint(found, withText)` `specType`
  `specDot` depois de `savePopNote`; XML `popSpec` depois de `popNote`; `renderSpecialities` REESCRITA (lista das acesas,
  ordenada); `PICKER_LIST["speciality"]` SAIU; o `<dataLink>` do raiz ficou `{'language'}`.
- `WoD20.1.lfm` — template `Virtue` (= Attribute velho) & as 3 Virtudes nele; `btnSp` em `Attribute`/`AttributeZeroable`
  (100, rótulo 95), `Ability` (140, rótulo 135, bolinha viva) & `CustomAbility` (140, edit 135); `SpecialityRow` & as 10
  linhas SAÍRAM → `dynSpecList` (textEditor readOnly, opacity 0.75, 20/36/290/259).
- `WoD20.2.lfm` — 18 linhas de `FLAWS` viraram TAB de novo (§B173). `WoD20.6.lfm` — `#66000000` fora das 4 paletas,
  `PT["Select Speciality"]` fora. `localization.lang` — as 2 `wod.Select Speciality` fora.
- `verify-hunters-hunted.ps1` — §V503…§V507 no fim; §V5 (sem bolinha XML p/ especialidade), §V146 (caixa + 1 lista),
  §V147 (só a metade Lua), §V148 APOSENTADA, §V161/§V163/§V164/§V165/§V170/§V255/§V287/§V333(5 portas)/§V370/§V374/
  §V378/§V354/§V365/§V436/§V439c(invertida)/$OVERLAY_BOXES(+popSpec)/tabela de §V204 (sem SPECIALITY_ROWS) ajustados.

**✅ SPEC EM DIA — os 6 pontos abaixo foram EMENDADOS pelo `/ck:spec amend` (204ª; marcador `⚠ EMENDADO no build`;
§Q93 RESPONDIDA na mesma escrita; gate VERDE; backup de antes `…\scratchpad\SPEC.before27c.md`):**
1. **47 habilidades, ⊥ 41.** `ABILITY_FIELD` tem 47 (a 154ª pôs 7 & o comentário "41" ficou velho) ∴ `SPEC_TRAIT` = 56,
   chaves = 65 & `SPECIALITY_ROWS` = **325**, ⊥ 295 (§I172f, §V507a, §Q92 RESPONDIDA, §V147/§V504b/§V505a citam 41/50/295).
2. **`dynSpecList` em top 36 / height 259, ⊥ 41/254** — a hairline do título é 36 (15 + 20 + 1; as linhas velhas também
   começavam em 36); & ganhou `opacity="0.75"` (§V111/§V244: texto só-leitura lê apagado) (§I172g, §V507d).
3. **§B173: 18 linhas, ⊥ 16** — as linhas 16-17 do comentário do topo do `WoD20.2` também tinham `FLAWS`.
4. **§V507c**: o ledger chama `specTraitName(slotName(field))` — `slotName` fica p/ o fallback da linha vazia (log idêntico
   ao de hoje p/ livro) & o gate cobra `specTraitName(` como 1º argumento, ⊥ "⊥ slotName(".
5. **§I172g/§T1088: o tamanho `"list"` do picker (`MF_LIST`, ramo de `mfSize`, `mfCustomPane`, a gravação do custom) FICOU**,
   sem chamador — tirar mexe em 4 funções do picker compartilhado & §V359/§V436; §V436(b) agora cobra **0** listas sem pane.
   Rodada própria se o user quiser o código morto fora.
6. **§I172e/§V505c**: nasceu `specRowsOf(key)` (1 dono p/ "linhas de uma chave": janela & grátis) & `specPaint` recebe
   `withText` (texto dos slots SÓ ao abrir — repintar depois de um clique apagaria o que foi digitado num slot livre).

### 27º LOTE ESPECIFICADO (204ª) — scrim a 50% & especializações por traço no `!` (§I172)
`/ck:spec` só: §C (27º lote + §Q92 ABERTA), §I172a…g, §R171, §V503…§V506 (+ §V493 EMENDADA), §T1084…§T1090,
§B173. Gate `-Quiet` VERDE c/ o spec novo (40 s). **0 código tocado, nada commitado.** Backup do spec de antes:
`9b1e1caa…\scratchpad\SPEC.before27.md`.
- **O que JÁ existia** (§R171a): o `popScrim` já escurece (40%) atrás de `?`, `!` de nota, picker & `Settings`.
  O lote muda o tom p/ 50%, põe 1 scrim gêmeo (`popScrimB`) sob o picker-sobre-picker & sobe o scrim na janela nova.
- **§Q92 RESPONDIDA** (mesma rodada) & o lote foi REESCRITO no lugar: (1) box = RESUMO só-leitura (`dynSpecList`),
  o picker de especialização SAI inteiro; (2) `popScrimB` sim; (3) linha digitada GANHA `!` & a chave é o CAMPO
  (`customTalent_3`), ⊥ o nome; (4) teto só de **5 por traço** — `SPECIALITY_ROWS` 10 → **295** (5 × 59).
- **Desenho da janela** (§I172e): VISTA das linhas `speciality_N` de hoje — 0 campo novo, 0 migração; slot
  livre + clique na bolinha = pegar a 1ª linha vazia (`specFreeRow`, extraída de `grantSpeciality`) & chamar o
  `xpClick` de sempre ∴ custo, recusa & log ⊥ mudam. ∀ `!` passa o campo da BOLINHA 1 & `specOpen` tira o `_1`
  (tirar um `_1` opcional quebraria `customTalent_1`).
- **Próximo:** `/ck:build` §T1084 → §T1085 → §T1086 → §T1087 → §T1088 (box → resumo) → §T1089 (gate + bateria;
  ≥ 8 checks do gate amarram `SpecialityRow`, lista em §R171i) → install → §T1090 (tela). **§T1091 aguarda §Q93.**
- ⚠ **§B173**: `WoD20.2.lfm:388-403` tem `FLAWS` no lugar do TAB (16 linhas, já no HEAD `8d76c593`); §T1087
  conserta, §V506 cobre. ⚠ **§B174**: `customTalent_3`/`_4`/`customKnowledge_3` ∉ `XP_CUSTOM` → bolinhas de
  graça & fora do log; §T1091 conserta SE o user disser sim em §Q93 (muda XP de ficha existente).
- Gate `-Quiet` VERDE depois da reescrita (73 s). Backup de antes da reescrita: `…\scratchpad\SPEC.before27b.md`.

## (histórico) 203ª rodada — 25º lote CONSTRUÍDO & BATIDO

### O ESTADO EM UMA LINHA
25º lote (coluna `Characters List` v2 + nota `!`, §I170) CONSTRUÍDO: **§T1075…§T1079 `x`**. Bateria
de §V496…§V501 COMPLETA (§V222): **26/26 mutações VERMELHAS no check certo & 7/7 sondas VERDES**
(202ª rodou 13, a 203ª as 20 que faltavam — log em `212b1d36…\scratchpad\battery25-rest2.log`),
hashes dos 4 arquivos = os de antes. Gate `-Build -Quiet` **ALL CHECKS PASSED** (104 s, 18:49).
**REINSTALADO 18:52:08** a pedido do user (3069436 B, = `output/`; fontes = os da bateria).
**Nada commitado.** Se a ficha estava
aberta, FECHAR & REABRIR p/ ver.

### 26º LOTE CONSTRUÍDO (203ª) — §T1081 & §T1082 `x`, INSTALADO 19:52:47 (3074277 B = `output/`)
Gate `-Build -Quiet` VERDE (58 s); bateria de §V502 **9/9 VERMELHAS & a sonda VERDE**, hashes = os de
antes (log `212b1d36…\scratchpad\battery26.log`). No caminho: **§B172** (o `0.7` do contorno ⊥ estava
na lista NOMEADA de §V244 → virou `0.70`, só em `mcOn_`) & comentário XML DENTRO do `<template
name="McRow">` → `rdk -l` exit 1 MUDO & `.rpk` APAGADO (regra já escrita acima do template; ⊥ ∃ check
no gate — pergunta ao user se vira §V). `NeededPx` ganhou `-Literal` (texto `dyn*` medido como é
mostrado, §V502e). **Falta: §T1083 (tela)** & §T1080. **Nada commitado.**

### (histórico) 26º LOTE ESPECIFICADO (203ª) — ajustes na coluna, §I171/§V502/§T1081…§T1083, §Q91 RESPONDIDA
8 pedidos (Settings maior, traço no lugar da foto, contorno ⊥ selecionado a 70%, rótulos
`Name`/vontade/`Blood`/`Quintessence`, barras alinhadas). §Q91 RESPONDIDA: **(1)** `Vontade` em pt &
`Willpower` em en → rótulo `dynMcWpTag_$(num)` c/ texto escrito por `mcRender` (a ficha ⊥ tem 2
traduções p/ a mesma palavra; precedente `HEALTH_PT`), coluna **85**, barras **173/165**; **(2)** os
70% só no contorno. Próximo: `/ck:build §T1081` & `§T1082` (o 2º é o gate + bateria de 8 mutações
& 1 sonda; ler antes como §V9/§V10/§V28 tratam texto do Lua) → install → §T1083 (tela). Gate VERDE c/ o spec novo (39 s). Backup do
spec antes do lote: `212b1d36…\scratchpad\SPEC.before26.md`.

### O QUE FAZER, NESTA ORDEM
1. Pedir ao user: **§T1080** (tela, alíneas (a)…(i); as que decidem: (a) abas À DIREITA da coluna,
   (d) clicar na barra edita as bolinhas, (h) tooltip à direita do cursor & rolável). §T1074 (o que
   sobrou), §T1068 & §T1066 seguem `.`.
2. ~~§I107a5 com as colunas velhas~~ — EMENDADA na 203ª (nota no fim: 304/421/466, fecha em 516).
   §T1078 segue dizendo que as 4 cores entraram nas paletas: §T feita = histórico, a verdade está
   em §I170c (decisão do user, 203ª).

### ✅ SPEC EM DIA — os 4 pontos abaixo foram EMENDADOS pelo `/ck:spec amend` (203ª, gate VERDE)
Onde: §I170g (helper, título 40/280, chave `!`), §I170c (paletas), §V500e, & 1 nota `⚠ EMENDADA
2026-09-24` no fim de §V40 §V280 §V287 §V290 §V300 §V332 §V333 §V349 §V367 §V392. Backup de antes:
`212b1d36…\scratchpad\SPEC.before-amend25.md`.
- **§I170g/§V500e:** o `!` acende por 1 helper `noteButton(btn, value)` chamado pelos 2
  renderizadores (o texto diz que eles escrevem `.enabled` direto); o gate cobra o helper.
- **§I170g:** título da `popNote` `left="40" width="280"` (⊥ 20/290): §V27 cobra simetria em
  rótulo ≥ 80% do box.
- **§I170i/§I170c:** o `!` ganhou chave idêntica `wod.!=!` nos 2 lados do `.lang` & `["!"] = "!"` no
  `PT` (§V10/§V28, ≡ o `X`); das 4 cores novas SÓ `#80000000` entrou nas paletas (§V53 cobra `color=`
  de `<rectangle>`, ⊥ de `<progressBar>` — as barras ficam na cor fixa pedida).
- **gate que aprendeu os controles novos** (registrar no §V de cada um): §V40 exclui `noteTip` por
  nome; §V287 admite o fundo `contents` de `noteTip` & largou `mcGrip`; §V290 ⊥ conta o `!` como
  coluna & admite a largura dele colada no nome; §V300 isenta `noteTip`/`noteTipScroll`; §V333 = 4
  portas (`btnPopNoteClose`); `$OVERLAY_BOXES` + `popNote` (§V280/§V298 seguem 71); §V367 overlays
  + `mcSettings` + `popNote` & `sheetMain` conta como o portador das abas; §V332/§V392/§V349
  remedidos p/ 1635 (§B171).

### O QUE VIROU CÓDIGO (por arquivo)
- **`WoD20th.lfm`** — `sheetMain` (`client`) envolve `tabStrip` + 11 abas; `mcDock` 370 fixo, sem
  grip; `mcHead` c/ `dynMcTitle` (`(N/10)`, ATUAL/MÁXIMO); `McRow` v2 (346×108, passo 114, contorno
  sempre 1/2 px, nome c/ `onEnter` seleciona, 3 `<progressBar>` azul-claro/carmesim/dourado c/
  `onMouseDown` → `mcSelect` + `mcBarClick`); `popScrim` 2005; `popNote`; 1 `<dataLink>` de 51 campos
  → `mcBarsSoon`; vigias de nome completos (m0…m10, f0…f10, 1…21). Lua: `mcShow` (o ÚNICO
  `setNodeObject`), `mcWipe` (raiz removível: `mcRootGone` + atributos ∉ `MC_KEEP`, entre
  `beginUpdate`/`endUpdate`), `MC_KEEP` `MC_BARS` `mcCount` `mcBarMax` `mcBarsRow` `mcBarsNow`
  `mcBarsSoon` `mcBarClick` (escreve PELAS portas `bloodClick`/`quintClick`/`poolClick`), `NOTE`
  `NOTE_NAMES` `noteKey` `noteOpen` `savePopNote` `noteButton` `noteTipMove/Leave/Hold/Hide`. SAÍRAM
  grip, `mcSetWidth`, `poolFromNumber`, `poolCount`, `mcBloodChanged`, `mcQuintChanged`, sementes de
  número, `return alvo`, ramo `node` de `poolPrefix`. Root segue em **50** locais.
- **`WoD20.2.lfm`** — `!` em `OpenAbility` (bolinhas +20) & `MeritPicked` (entre nome & livro);
  BACKGROUNDS 384, MERITS/FLAWS 556, tudo à direita +40 → Traits fecha em **1635**; hover nos 43
  pickers; `noteTip` último filho do `scrollBox`.
- **`WoD20.6.lfm`** — `#80000000` nas 4 paletas; `["!"] = "!"`. **`localization.lang`** — `wod.!=!` ×2.
- **`verify-hunters-hunted.ps1`** — §V496…§V501 novos; §V488/§V489/§V490/§V491/§V493 emendados;
  §V494/§V495 APAGADOS; os 10 checks da lista acima.
- **`SPEC.md`** — §Q90 RESPONDIDA, §I170/§V496…§V501/§T1075…§T1080 reescritas no lugar, as 8 emendas
  pendentes do 24º aplicadas (6 viraram texto, 2 sem objeto), §B170 & §B171.

### ⚠ AS 4 COISAS QUE CUSTARAM
1. **§B171 — número citado pelo §V errado.** O spec disse que o nome de qualidade tinha 24 px de
   folga citando §V196 (240); o `(N)` de custo já tinha levado o mais longo a 264 & quem mede é
   §V349c. O gate acendeu no 1º run; MERITS/FLAWS alargaram em vez do nome encolher. Lição: citar a
   régua PELO CHECK que a mede.
2. **Install pedido NO MEIO da bateria** — a bateria muta os arquivos da ficha um a um; parar &
   instalar direto empacotaria a mutação. Foi parada, o `WoD20th.lfm` estava MUTADO & voltou do
   `battery-backups\` (hash conferido) ANTES do `rdk -i`. Regra na memória da bateria.
3. **`self` num handler é o FORM, ⊥ o controle** (§R170l) — o tooltip precisava do picker; achado lendo
   o GERADO antes de escrever, ⊥ na tela.
4. **`sed` com `\|`, `$m`/`$M` & pares de mutação numa linha** — 3 armadilhas de ferramenta, 0 dano
   (rascunho, `throw` antes de gravar, SETUP ERROR); as 3 na memória.

---

## CONTEXTO DA RODADA ANTERIOR (2026-09-24, fim da 201ª rodada — 24º lote CONSTRUÍDO)

### O ESTADO EM UMA LINHA
O 24º lote (múltiplos personagens numa ficha, §I169) foi especificado (`/ck:spec` ×2, §Q88 & §Q89
respondidas) & CONSTRUÍDO na mesma sessão pelo `/cavepony:cavepony-build`: **§T1069…§T1073 `x`**,
gate `-Build` VERDE (8 checks novos §V488…§V495 + 16 checks antigos ensinados a ler `dataScopeBox`,
bateria 25 mutações VERMELHAS + 7 sondas VERDES), **INSTALADO 00:30:56** (3060378 B, = `output/`),
c/ o Firecast ABERTO. **Nada commitado.** Se a ficha estava aberta, FECHAR & REABRIR p/ ver.

### O QUE PEDIR, NESTA ORDEM
1. **§T1074** [USER] — teste de tela, alíneas (a)…(n). As que decidem o desenho: **(c)** trocar de
   personagem & voltar: TUDO volta? (§I169k(1): o host re-dispara `onNodeReady`/`dataLink` depois de
   `setNodeObject(filho)`? se ⊥ → `/ck:spec`, `mcSelect` passa a chamar os renderizadores);
   **(h)** mudar `Era` na janela c/ o personagem 2 ativo muda a época p/ TODOS na hora (o espelho
   `mcShared` + `dataLink` dentro de `stSharedScope`); **(l)** reabrir: último clicado ativo & ordem;
   **(n)** arrastar a borda direita (`event.x` em `onMouseMove` de `rectangle` = `?`, §R169i).
2. **`/ck:spec amend`** — o build DESVIOU do texto em 6 pontos, todos por causa de checks/fatos que
   o spec ⊥ conhecia; o spec está ATRÁS do código até absorver:
   - **§I169e(4):** janela `mcSettings` `height="500"` & `mcSettingsScope` `height="450"` (⊥ 440/390:
     as linhas copiadas do box terminam em 416+25); §Q88.10 já dizia que geometria ⊥ é contrato.
   - **§I169b/§I169c (§V190):** o fundo do `mcDock` é `<rectangle align="contents">` (⊥ `client`:
     §V190 recusa 2 filhos `client` no mesmo contêiner) & `mcOn_$(num)` tem `left/top/width/height`
     explícitos; **§I169e(1):** `stSharedScope` tem `left="0" top="0" width="445" height="499"`, ⊥
     `align="client"`, pelo mesmo motivo.
   - **§I169h (§V10/§V22):** as 8 strings novas entraram TAMBÉM em `localization.lang` (`[pt]` &
     `[en]`) — o gate exige o mapa `PT` da `WoD20.6` & o `.lang` em sincronia; o spec só citava o `PT`.
   - **§I169e(4) (§V419/§B153):** os 5 combos `*Mc` entraram em `PICKER_ANCHOR` (`WoD20.6:2529`) —
     sem isso perdem o centro na troca de idioma. Fato novo p/ §R169f.
   - **§I73 (censo de boxes):** 70 → **71** — a janela `mcSettings` é box por construção (retângulo
     preto `innerRound` + título estático + 15/19) & §V280/§V298 já contam 71.
   - **§R169a:** o `?` FECHOU — `gui.fromHandle` (`rrpgGUI.lua:1674-1683`) consulta `objHandlers`
     ANTES de montar tabela ∴ `tabRootOf(from)` também devolveria o objeto do construtor; o código
     segue c/ `self` (§V490a) — a regra fica, a dúvida some.
   - **§V489 sonda:** `text="Current"` → `"Now"` ⊥ é sonda limpa: acende §V10/§V28 (string sem chave
     no `.lang`). Trocar a sonda por `width="55"` → `"56"` no mesmo rótulo.
   - **§V494/§I169l:** `poolPrefix(base, count, alvo, node)` tem 2 ramos — `node == sheet` mantém o
     literal `setField(base .. i, on)` (§V219 casa a string), o outro escreve `node[base .. i]`.
3. Depois: §T1068 (teste de §B169 c/ 2 fichas) & §T1066 seguem `.` — testar junto c/ §T1074(m).

### O QUE VIROU CÓDIGO (por arquivo)
- **`WoD20.10.lfm`** — box `STORYTELLER SETTINGS` inteiro dentro de `<dataScopeBox name="stSharedScope">`
  (pinado na raiz por `mcInit`); 8ª flag `chkMultipleChars` (`multipleCharacters`, top 321); preços &
  `Save` +30, box 469 → 499; `<dataLink fields="{13 + 'multipleCharacters'}" onChange="mcShared(self);"/>`
  DENTRO do scope (precedente `Plugins/Core/rrpginlua/ConfigDice/ConfigDice.lfm:145`).
- **`WoD20th.lfm`** (8127 → 8717 linhas) — `<template name="McRow">` (`:7779`), `mcDock` 1º filho de
  `sheetBody` (`:7855`: fundo `contents`, `mcHead` c/ `Characters List` + `Add Character` + `Settings`,
  `mcGrip`, `mcRows` c/ 10 `<McRow>`), `popScrim` `#66000000`/1945, `mcSettings` + `mcSettingsScope`
  (13 twins `*Mc`); Lua: `MC`, `MC_*`, `MC_SHARED_FIELDS`, `MC_NAMES` & `mcNodes` `mcInit` `mcApply`
  `mcRender` `mcSelect` (`self:setNodeObject`, o ÚNICO) `mcAdd` `mcRemove` `mcShared` `mcSettingsOpen`
  `mcSetWidth` `mcGripDown/Move/Up` `mcBloodChanged` `mcQuintChanged` (`:4640-4960`); `poolClick`
  devolve `alvo`, `bloodClick`/`quintClick` gravam o número, `poolPrefix`/`familyCap` c/ `node`
  opcional, `poolFromNumber`/`poolCount` (`:6728-6840`); `onNodeReady`: 2 `setField` de nascimento +
  `mcInit(self)`. Root segue em **50** locais.
- **`WoD20.6.lfm`** — 8 linhas `PT`, chave `#66000000` nas 4 paletas, `langScope` em volta do combo de
  idioma (`:5400`), `PICKER_ANCHOR` +5.
- **`localization.lang`** — 8 linhas em `[pt]` (antes de `[en]`) & 8 em `[en]` (fim).
- **`verify-hunters-hunted.ps1`** (23202 → 23872) — helpers `BoxKids` (`:5361`, desce por
  `dataScopeBox`) & `ContentRoot` (`:75`, `/form/scrollBox`); §V1 conta por escopo (`mcRow_K/campo`) &
  `$mirrors` +13; §V137 ignora literais entre aspas; `$STATE_COMBOS` p/ §V208/§V211 (+ perna (d):
  `values=` do twin == original); rosters de §V287/§V68/§V234/§V333 (3 portas); §V274 469 → 499;
  censo 71; §V484 procura o diálogo a partir do arm; §V430 passa `NoComments` antes da varredura
  (um comentário Lua citava `<dataLink` & engolia 183 KB); §V488…§V495 (`:23403-23811`).

### ⚠ AS 3 COISAS QUE CUSTARAM
1. **Worker de XML pôs `mcDock` FORA de `sheetBody`** (irmão antes dele) — compilava, gate ⊥ tinha
   check ainda, & na tela o scrim ⊥ cobriria a coluna. Pego na REVISÃO do orquestrador antes do
   gate; movido p/ dentro (`mv-dock.ps1`). §V488a agora acende se sair de lá.
2. **§V190 & os rosters por nome** — 53 FAIL depois da onda 1, TODOS do lado do gate: contêiner c/ 2
   `align="client"`, listas de nomes admitidos (§V287, §V419, §V333), contagens fixas (70 boxes, 469
   de altura, 2 portas), leitores de box por eixo filho (§V238/§V240/§V243/§V274/§V449). Lição:
   controle NOVO no sheet = 1 rodada de gate, sempre — orçar isso no plano, ⊥ descobrir na onda 2.
3. **Comentário Lua que cita XML derruba varredura de XML** (§V430): a regex de `<dataLink` casou o
   `<dataLink` de um comentário `--` & engoliu até o próximo `</dataLink>` real. Toda varredura de
   XML por regex em `.lfm` ! passar por `NoComments` antes.

---

## ⚠ 200ª RODADA (2026-09-08, §B169) — 1 AMBIENTE LUA POR FICHA ABERTA. LEIA ANTES DE TUDO

O user relatou na tela: *"os pickers de specialties, quando eu mudo de uma ficha pra outra pelas
abas do firecast, não estão atualizando… o mesmo com os checkboxes da aba do storyteller… mostram
os valores dos personagens errados"*. **Causa (§B169, MEDIDA no GERADO):** o CDATA do root — & os
`<script>` das abas — é copiado p/ dentro de `constructNew_frmWoD20th()`, logo abaixo de
`local sheet = nil;`. Cada `function nome()` é GLOBAL & a instância mais nova sobrescreve,
fechando sobre o `sheet` DELA. O Firecast abre **1 instância por ficha** ∴ c/ 2 fichas, todo
global (`renderSpecialities`, `applyTabVisibility`, `xpClick`, `setField`, `mfOpen`…) lê/escreve
o nó da ÚLTIMA aberta. Os listeners (`self` = form da própria instância, §R134) & o que o XML liga
por `field=` seguem certos — por isso "os outros pickers estão ok" (só pintam no `onNodeReady`).
**§B168 (causa `?`, `Edit dots freely` ON abrindo "Experiência insuficiente") é o MESMO bug**:
`sheet.stFreeBuy` lido da outra ficha.

**Conserto (§I168, §T1067):** **1 linha**, 1º statement do CDATA de `WoD20th.lfm`:
`local _ENV = setmetatable({}, { __index = _G });` (Lua 5.4 — o Firecast carrega
`lua54x64.dll`, §R168a; `setfenv` ⊥ ∃). Custou 1 local de chunk & o root estava em 50 = teto
do §V347 ∴ `tabRootOf` virou global (mesmo escopo c/ 1 ambiente por instância). **§V487 NOVA**
(1º statement, 1 só no sheet, 0 `setfenv`), 3 mutações VERMELHAS + sonda VERDE.

Gate `-Build` VERDE 20:22, **INSTALADO 20:22:56** (3012986 B, = `output/`), c/ o Firecast ABERTO. **Nada commitado.**

**O QUE PEDIR:** **§T1068** [USER] — teste de tela c/ **2 fichas** abertas (B por último): (a)
especializações de A ao voltar p/ A; (b) `Show Numina` na Storyteller de A mexe só em A; (c) §B168
c/ flags diferentes nas 2; (d) picker de clã/merit em A grava em A; (e) fechar B & seguir em A.
Depois §T1066 (23º lote) & os §T1062/§T1058 que seguem `.` (parte SUPERADA, ver abaixo).

**REGRA nova (vale p/ toda sessão):** "form único" era premissa, ⊥ medida (§B168 escreveu
`form único: sheet é upvalue`). Toda vez que um global do sheet ler `sheet`, a pergunta é
"de QUAL instância?" — & a resposta agora é "da que está rodando", por causa do `_ENV`. Não
religar `sheet` por argumento, não prefixar handler c/ bind, não "recarregar no onShow"
(§I168d/§R168: rejeitados, o dataLink de ficha escondida continuaria errado).

---

## ⚠ CORREÇÃO DENTRO DA 199ª RODADA (2026-09-08, §B167) — LEIA JUNTO COM A SEÇÃO ABAIXO

O 23º lote foi instalado quebrado & o user pegou na tela: *"ta dando erros quando tentei gastar
experience"* — `attempt to index a nil value (field '?')` em `renderXPLedger`, em TODO caminho
que renderiza o log. **JÁ CONSERTADO & REINSTALADO 02:50:38** (3011259 B). Gate `-Build` VERDE.

**A causa (§B167):** `xpFind(node, names, out)` (`WoD20th.lfm:3437`) **⊥ devolve o form** — varre
a árvore & devolve `out`, uma TABELA com `out[nm] = c` **só p/ os nomes que o roster tem**. Eu
registrei em `XP_LOG` apenas `xpRow_` & `btnXpRev_`; os **300** rótulos `dynXp*_N` ficaram fora ∴
`form["dynXpType_1"]` = `nil`. Pior: escrevi no comentário do laço que os 300 ficavam fora *"on
purpose"* — leitura errada virada FATO, **sem abrir `xpFind`**. É §B166 outra vez (o `MEDIDO` que
⊥ foi medido), agora na porta da API interna do próprio sheet.

**O conserto:** o laço do roster registra os **7** nomes por linha (`btnXpRev_`, `xpRow_` & os 5
`dynXp*_`), & **§V486f NOVA** liga os 2 lados — o gate lê os prefixos de `form["<x>_" .. i]` no
código & exige `XP_LOG["<x>_" .. i]` DENTRO do laço que escreve em `XP_LOG` (⊥ o 1º laço sobre a
constante: `xpRowsHide` & `xpRevButtons` também varrem o pool). **2** mutações VERMELHAS.

**REGRA (vale p/ toda sessão):** `rdk -l` sai 0 & o gate fica verde num índice de `nil` em runtime.
Antes de escrever no comentário o que uma função interna FAZ, **abrir a função**. E toda vez que o
código passar a endereçar controle por nome montado (`form["x_" .. i]`), perguntar QUEM resolve
esse nome — neste sheet é o roster, ⊥ o form.

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-08, fim da 199ª rodada)

### O ESTADO EM UMA LINHA
O user mandou **2 prints** & eles derrubaram uma premissa do SPEC: `/ck:spec` escreveu **§B166**
(a causa raiz), **§Q87** & o **23º lote** (§I167, §R167, §V486, §T1063…§T1066) & o build fechou
**§T1063…§T1065** na MESMA rodada. **§V483 & §V485(a)…(d) REVOGADAS.** Gate `-Build` VERDE,
**12 mutações vermelhas no check certo & 1 sonda verde forte** (re-escala 32→24 inteira).
**INSTALADO 02:33:36** (3010707 B, mesmo size do `output/`), c/ o Firecast ABERTO. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **§T1066** (teste de tela do 23º lote, alíneas (a)…(g)) — a (a) & a (b) são as que provam
   §B166 morto. §T1062, §T1058, §T1041/§T1048/§T1052 seguem `.` mas **§T1062 & §T1058 foram em
   parte SUPERADAS**: o log que elas testariam ⊥ ∃ mais na forma antiga.
   FECHAR & REABRIR a ficha antes.
2. **§Q87 ABERTA & ⊥ bloqueia**: o log agora mostra no máximo **60** registros (os mais recentes).
   O lote foi construído PELA recomendação; se o user quiser outro teto, é **1 número** (o
   gerador das 60+60 instâncias & `XP_REV_POOL`), ~6 controles por linha.

### ⚠ O QUE §B166 DERRUBOU (leia antes de mexer no log)
`XP_LINE_H = 16` era declarado *"MEDIDO, ⊥ escolhido"* em §I164b/§V483c — **nunca foi medido**.
§Q84.1 recomendou 16 & §T1052(b), o teste que o mediria, nunca rodou. Nos prints: escala **1,5**
(largura de `xpHiRow`, 720 → ~1075 px), passo do `X` **48**/1,5 = **32** ✔ (confere c/ o XML),
passo do TEXTO **40,8**/1,5 = **27,2** ✗. **~4,8 de erro por registro, ACUMULANDO** — no 13º o `X`
estava ~57 abaixo do registro dele & a caixa de destaque desenhava ao lado de outro registro.
A causa ⊥ é o VALOR, é a DEPENDÊNCIA: altura de linha renderizada é do HOST (§R165b, 0 métrica no
SDK) ∴ inteiro nenhum acerta & QUALQUER passo autorado deriva. Trocar 16 por 13/14 só encurta.

### O que virou código nesta rodada
- **§T1063 `WoD20.9` XML** — `<template name="XpLogRow">` → `<layout name="xpRow_$(num)"
  left="0" top="$(top)" width="735" height="32">` c/ os **5** `<label name="dynXp*_$(num)">`
  (`top="0" height="32" vertTextAlign="center"`, mesmos `left`/`width`/`horzTextAlign`/`fontSize`
  das colunas) & **60** instâncias em `(N−1) × 32`. O `<template name="XpRevRow">` FICA, o botão
  segue IRMÃO da linha (dentro dela o layout precisaria de 765 num scroll de 751 do jogador →
  barra horizontal, §R104) & suas 60 instâncias vão a `(N−1) × 32 + 8`. As **5** `<textEditor>`
  voltam a `top="0" height="470"` & viram CHÃO (as 5 faixas cinzentas + o alcance da rolagem).
- **§T1064 `WoD20.9` Lua** — `XP_LOG_MIN_H` volta a **470**; `xpRowsHide(form)` nova; os 5
  `table.concat(x, "\n\n")` viram 1 laço `for i = 1, XP_REV_POOL` que escreve os 5 `text` da
  linha & o `visible` dela; altura = `math.min(#rows, XP_REV_POOL) * XP_ROW_H`; o roster registra
  `xpRow_` no MESMO laço do `btnXpRev_`. `XP_LINE_H`/`XP_ROW_H` param de nomear texto & passam a
  nomear XML autorado (`btnXpRev.height` & `xpRow.height`).
- **§T1065 gate** — **§V486 NOVA** (5 pernas + zero-guard, a (b) é a EQUAÇÃO DO CENTRO
  `2 * (btnTop − rowTop) + XP_LINE_H == XP_ROW_H`); **§V483 REVOGADA INTEIRA** & **§V485(a)…(d)
  REVOGADAS** (mediam a relação certa contra o número errado — verdes com a tela quebrada);
  §V473(b) passa a medir as 2 listas de instâncias & o `top` da LINHA; §V473(e) lê o laço duplo;
  §V472(e) lê a escrita POR LINHA. §V484, §V485(e)/(f), §V478, §V247, §V68, §V240 INTACTAS.

### ⚠ AS 3 COISAS QUE CUSTARAM
1. **Um `?` de teste de tela que nunca roda vira um FATO falso no SPEC.** §T1052(b) existia desde
   a 196ª rodada exatamente p/ medir isto & ficou `.`; nesse meio tempo §V483, §V484 & §V485
   foram escritas EM CIMA do número não medido, & as 3 passavam verdes. REGRA: número que só a
   tela responde ⊥ pode virar `MEDIDO` no SPEC antes da tela responder — escrever `?` no valor.
2. **Gate verde ⊥ é tela certa quando o dono do número é o host.** 11 pernas mediam a relação
   correta contra 16. O que consertou ⊥ foi um número melhor: foi tirar o host da conta.
3. **Layout dentro de `scrollBox` ⊥ pode ser mais largo que o scroll.** O 1º rascunho pôs o botão
   DENTRO da linha (layout de 765) — no scroll de 751 do jogador isso é barra horizontal, & o SDK
   ⊥ tem propriedade que a recuse (§R104). O botão ficou irmão da linha, colocado pela mesma conta.

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-08, fim da 198ª rodada)

### O ESTADO EM UMA LINHA
`/ck:spec` escreveu o **22º lote** (§I166, §Q86, §R166, §V485, §T1059…§T1062) & o build fechou
**§T1059…§T1061** na MESMA rodada. Gate `-Build` VERDE, **10 mutações vermelhas no check certo &
2 sondas verdes**. **INSTALADO 01:36:37** (2969183 B, mesmo size do `output/`), c/ o Firecast
ABERTO. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **§T1062** (teste de tela do 22º lote, alíneas (a)…(f)) — & §T1058 (21º lote) & §T1041/§T1048/
   §T1052 seguem `.`, do 18º, 19º & 20º lote. FECHAR & REABRIR a ficha antes: a versão velha fica
   na tela até isso.
2. **§Q86 já nasceu RESPONDIDA** & a **(1)** SUPEROU a recomendação (ver ⚠ 2 abaixo). O único
   número que ainda ⊥ dá p/ medir sem tela é a LINHA de 2px na cor do ORNAMENTO nas 4 eras —
   §T1062(b) é quem responde. Se ficar fraca, a saída ⊥ é trocar de chave (o user escolheu o
   ornamento): é o `strokeSize`, & ele emenda em 1 lugar (`WoD20.9`, atributo autorado).

### O que virou código nesta rodada
- **§T1059 `WoD20.9`** — `PAD` = **8** AUTORADO no XML (⊥ ∃ constante Lua p/ ele, de propósito:
  os 60 `top` o carregam & coordenada tem 1 dono, §V383b): as **5** `dynXp*` vão de
  `top="0" height="470"` p/ `top="8" height="462"`; os **60** `<XpRevRow>` ganham +8
  (`8·40·72…1896`); os **5** `dynXpHi*` trocam `vertTextAlign="leading"` por `"center"`; &
  `XP_LOG_MIN_H` **470 → 462** (a ÚNICA linha de Lua do §T). A conta que segura os 3 primeiros
  pedidos é 1 só: `2 * PAD + XP_LINE_H == XP_ROW_H`. **0** mudança em `XP_LINE_H` (16),
  `XP_ROW_H` (32), nos `"\n\n"`, no `+ 12` de cauda, no `xpColsHeight` & no `xpHiRow` (top/height).
- **§T1060 `WoD20.9` + `WoD20.6`** — o `<rectangle align="client" color="black"/>` da faixa vira
  `<rectangle name="xpHiEdge" align="client" color="black" strokeColor="black" strokeSize="2"/>`
  & o ramo `elseif THEME_SHAPES[cls]` de `applyTheme` ganha
  `if nm == "xpHiEdge" then paint(c, "strokeColor", t.ornament, line); else … end;` — a cor do
  ORNAMENTO da era, & o `paint` de `strokeSize` passa a morar SÓ no `else` (senão `THEME_STROKE`
  = 3 cobre o 2 calado). `strokeColor="black"` autorado ⊥ é a cor final: é a TESTEMUNHA sem a
  qual `paint` desiste (guarda de §B21).
- **§T1061 gate** — **§V485 NOVA** (6 pernas + zero-guard) & **§V473(b) EMENDADA**: lê `PAD` de
  `dynXpType.top` & compara `(N − 1) * step + PAD`, ⊥ literal. §V483, §V484, §V68, §V240 & §V247
  INTACTAS (o retângulo nomeado & com stroke ⊥ derrubou `IsBandLayout` — MEDIDO antes, §R166d).

### ⚠ AS 3 COISAS QUE CUSTARAM
1. **`grep -c $'\r'` do Git Bash MENTE, & eu confiei nele.** Deu `0` num `SPEC.md` que era CRLF,
   li isso como "já é LF" & emendei o arquivo por `sed -e ... > SPEC.new` → saiu 100% LF & §V318
   ficou vermelho. Reparo pelo PowerShell (`ReadAllText` → CRLF→LF → LF→CRLF → `WriteAllText`
   sem BOM). REGRA: final de linha SÓ se confere contando os bytes 13 & 10 no PowerShell.
   E o **`Edit` tool PRESERVA CRLF** (medido nesta rodada: 809 → 828 CR com 828 LF) ∴ é a
   ferramenta certa p/ bloco de comentário; `sed`/`awk` ⊥ são, nunca.
2. **A minha recomendação de §Q86.1 era PIOR que a resposta do user.** Recomendei
   `t.stroke["black"]` — a chave de BORDA, `#3A4150` sobre `#12141A` em Modern Nights. O user
   pediu *"a cor dos ornamentos dos boxes da época selecionada"* = `t.ornament` = `#A83232` ali,
   muito mais visível. PREÇO que eu ⊥ tinha visto: `t.ornament` é VALOR & ⊥ chave ∴ ⊥ dá p/
   autorar no XML & deixar a paleta mapear — virou 1 escrita de `applyTheme`. REGRA: antes de
   recomendar chave de cor, abrir as 4 paletas **E o painter que usa a chave** (`ornColour =
   t.ornament`, `:5127` — ⊥ o `accent` de `:5133`, que é da BARRA). É §B165 pelo lado bom.
3. **Âncora de mutação tem de ser única no ARQUIVO INTEIRO, comentário incluído.**
   `strokeSize="2"` apareceu **2×** em `WoD20.9` — a 2ª no comentário que eu tinha acabado de
   escrever — & o harness PULOU a mutação em vez de rodá-la (o guard `hits -ne 1` salvou; sem
   ele teria mutado o comentário & passado verde de graça). Ancorar em
   `strokeColor="black" strokeSize="2"`.

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-08, fim da 197ª rodada)

### O ESTADO EM UMA LINHA
`/ck:spec` escreveu o **21º lote** (§I165, §Q85, §R165, §V484, §T1053…§T1058, §B165) & o build
fechou **§T1054…§T1057** na MESMA rodada; **§T1053 morreu NO PLANO** (§B165), com 0 linha de
código. Gate `-Build` VERDE, **11 mutações vermelhas no check certo & 1 sonda verde**.
**INSTALADO 00:35:11** (2965535 B, mesmo size do `output/`), c/ o Firecast ABERTO. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **§T1058** (teste de tela do 21º lote, alíneas (a)…(g)) — & §T1041/§T1048/§T1052 seguem `.`,
   do 18º, 19º & 20º lote. FECHAR & REABRIR a ficha antes: a versão velha fica na tela até isso.
2. **§Q85 já nasceu RESPONDIDA** (*"siga suas recomendações"*) & a **(2)** foi CORRIGIDA no plano
   (§B165). O único número que ainda ⊥ dá p/ medir sem tela é o `fontSize="14"` do destaque:
   §T1058(b) é quem o responde, & os **5** rótulos emendam JUNTOS (1 número, 5 lugares, §V484c).

### O que virou código nesta rodada
- **§T1054 `WoD20.9` XML** — `<layout name="xpHiRow">` (15,0,720,32, `visible="false"`) como
  ÚLTIMO filho de `xpLogScroll`: 1 `<rectangle align="client" color="black"/>` SEM `xradius` &
  5 `<label name="dynXpHi*">` nos `left`/`width`/`horzTextAlign` das 5 colunas menos os 15 do
  layout (0·143·353·445·500), `fontSize="14"` `fontStyle="bold"` `fontColor="#C2A14D"`
  `opacity="1"` `vertTextAlign="leading"`, **0** `fontFamily`. O `<template name="XpRevRow">`
  ganhou `onMouseEnter="xpHiShow(self, $(num));"` & `onMouseLeave="xpHiHide(self);"`.
- **§T1055 `WoD20.9` Lua** — 6 nomes novos em `XP_LOG`; `xpHiKinds/Traits/Levels/Costs/Whens`
  (cache do render, §V125) & `xpHiArmed`; `xpHiDrop(form)` local + os GLOBAIS `xpHiShow(node,i)`,
  `xpHiHide(node)`, `xpHiArm(node,i)` & `xpHiClear(node)`; `renderXPLedger` chama `xpHiDrop(form)`
  **1×**, ACIMA dos 3 ramos, guarda as 5 listas junto dos `table.concat` & as zera no ramo vazio.
- **§T1056 raiz** — `xpHiArm(form, i)` 1 linha ANTES de `Dialogs.confirmOkCancel` & `xpHiClear(form)`
  na 1ª linha da resposta, ACIMA do `if not ok` ∴ confirmar & cancelar saem iguais. As 2 recusas
  de §V474c & os 3 `return` de guarda ficam ACIMA do arme ∴ ⊥ armam.
- **§T1057 gate** — `IsBandLayout` (função NOVA, declarada 1× acima de §V68: `layout` cujo fundo é
  `align="client"` & cujos demais filhos abrem em `top` 0 com `height` == a do layout) + **§V484
  NOVA**; §V68 & §V240 ganham a isenção CONTADA (1 cada, §V209) & §V473e vai de 11 p/ **17** nomes.

### ⚠ AS 3 COISAS QUE CUSTARAM
1. **A cor recomendada em §Q85.2 estava ERRADA & o user já a tinha aprovado.** `t.stroke["#FFFFFF"]`
   é a chave de BORDA: em Modern Nights vale `#3A4150` sobre o chão `#12141A` — destaque mais
   escuro que o texto que ele destaca. O acento de TEXTO já ∃ nas 4 paletas (`t.font["#C2A14D"]`,
   o rótulo da sub-aba aberta) & ainda dispensa o global, a guarda & a única escrita de fonte em
   Lua do lote ∴ **§T1053 inteira morreu & o lote ficou MENOR**. Pego no PLANO (§B165). REGRA:
   cor de TEXTO sai de `t.font`, cor de BORDA sai de `t.stroke`, & ⊥ se nomeia chave antes de
   abrir as 4 paletas lado a lado.
2. **§V484(f) nasceu apontando p/ os checks errados.** O rascunho ADIVINHOU §V37/§V40; rodando o
   gate, quem acendeu com a faixa foi **§V68** (retângulo preto sem canto), **§V240** (caixa sem
   cabeça nem pé) & **§V473e** (contagem do roster). A perna foi emendada PELO MEDIDO.
3. **O harness de mutação bateu nas 2 armadilhas já documentadas.** `$M` & `$m` são a MESMA
   variável (o loop comeu o array na 2ª volta) & o gate FILHO estoura `$MaximumVariableCount`
   (4096). O filho tem de rodar
   `powershell -Command '$MaximumVariableCount = 32768; & "<gate>" -Quiet'` — sem `-NoProfile` ⊥
   basta. E `'\('` dentro de `"$( )"` derruba o parser do PS 5.1: contar numa variável ANTES.

---
## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-07, fim da 196ª rodada)

### O ESTADO EM UMA LINHA
`/ck:spec` escreveu o **20º lote** (§I164, §Q84, §V482, §V483, §T1049…§T1052, §B163, §B164) & o
build fechou **§T1049…§T1051** na MESMA rodada. Gate `-Build` VERDE, **11 mutações vermelhas no
check certo & 1 sonda verde**. **INSTALADO 23:35:06** (2955662 B, mesmo size do `output/`), c/ o
Firecast ABERTO. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **§T1052** (teste de tela do 20º lote, alíneas (a)(b)(c)) — & §T1041/§T1048 seguem `.`, do 18º
   & do 19º. FECHAR & REABRIR a ficha antes: a versão velha fica na tela até isso.
2. **§Q84.1** é a única pergunta aberta & o lote foi construído pela recomendação (`fontSize="12"`,
   `XP_LINE_H` = 16). §T1052(b) é o que a responde: se o `X` da 10ª linha estiver fora, os **3**
   números (`XP_LINE_H` · `XP_ROW_H` = 2× · `height` do botão) emendam JUNTOS, ⊥ um de cada vez.

### O que virou código nesta rodada
- **§T1049 `WoD20.9`** — 2 `refreshOrnament` no fim de `xpLogWidth`, sob 1 `if refreshOrnament ~= nil then`,
  largura ENTREGUE (`xpWidth0.<k> + add`) & altura LIDA (autorada, nunca escrita).
- **§T1050 `WoD20.9`** — `XP_LINE_H = 16` novo & `XP_ROW_H = 2 * XP_LINE_H`; `fontSize="12"` nas 5
  colunas; os 5 `table.concat` viram `"\n\n"`; `XpRevRow` `height` 20 → **16**; os 60 `top` a passo **32**.
- **§T1051 gate** — §V482 & §V483 NOVAS + 4 emendas de check velho: §V473b (o passo do `top` sai do
  literal 20 & passa a ser lido de `XP_LINE_H`/`XP_ROW_H`), §V261a (`xpLogBox\.height` → exige o `=`:
  a leitura nova da altura era falso positivo), §V472e (o 5º `table.concat` agora é `"\n\n"`),
  §V478c (o `+ add` era contado solto & os 2 refresh o usam — passa a contar só as 5 escritas de largura).

### ⚠ AS 2 COISAS QUE CUSTARAM
1. **A causa raiz do §B163 nasceu ERRADA no 1º rascunho do spec.** "a moldura atualiza mas o box não"
   foi lido como o `<scrollBox>` ⊥ aceitando `.width`; o user corrigiu — *"o que não atualiza são os
   ornamentos"*. As 5 escritas de `xpLogWidth` estavam CERTAS o tempo todo; faltava `refreshOrnament`.
   O lote inteiro (§I164a, §V482, §T1049, §B163) foi reescrito NO LUGAR antes de qualquer build.
2. **O gate ⊥ roda com `-NoProfile`**: estoura `$MaximumVariableCount` (4096) em `$iSt478` (§V478,
   linha ~22664) & morre ANTES dos checks do fim — um harness de mutação que rode `powershell -NoProfile
   -File .\verify...` reporta VERDE em tudo que vem depois. Rodar in-process (`.\verify-hunters-hunted.ps1`)
   ou sem `-NoProfile`.

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-07, fim da 195ª rodada)

### O ESTADO EM UMA LINHA
`/ck:spec` escreveu o **19º lote** & o build fechou **§T1042…§T1047** na MESMA rodada (o user
respondeu *"siga suas recomendações"* ∴ §Q83 nasceu RESPONDIDA pelas 6 recomendações). Gate
`-Build` VERDE, **12 mutações vermelhas no check certo & 3 sondas verdes**. **INSTALADO 22:25:06**
(2953285 B, mesmo size do `output/`), c/ o Firecast ABERTO. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **§T1041** (teste de tela do **18º** lote, ainda `.` — nada da 194ª foi visto rodando).
2. **§T1048** (teste de tela do 19º, alíneas (a)…(h)). Se a ficha estava aberta às 22:25, FECHAR
   & REABRIR antes — a versão velha fica na tela até isso (cosmético).

### O que virou código nesta rodada
- **§T1042 arte** — `research/gen_dot_pending.ps1` (ASCII puro) lê `prime_on_{crimson,gold,silver}.png`
  & escreve `prime_on_pending_*.png` trocando o RGB & PRESERVANDO o alpha (288-300 px de alpha
  parcial sobrevivem). Cores `#7A2E3A` · `#7A6636` · `#6E747A`, 1 constante no topo do script.
- **§T1043 `WoD20.6`** — `dotPending` nas 4 paletas; `xpPendingDots(rows)` & `xpDotArt(c, t, pending)`
  **GLOBAIS** (§B162) acima de `applyTheme`; o ramo `imageCheckBox` passa a `xpDotArt` c/ `pending`
  calculado 1× por varredura ao lado de `levels`; `repaintXpDots(from, rows)` global no fim.
- **§T1044 raiz** — `xpLedgerRefresh` chama `repaintXpDots` FORA do guard de `renderXPLedger`.
- **§T1045 `WoD20.9`** — `XP_REV_W = 30`; roster `XP_LOG` 8 → **11**; `xpRevButtons(form, rows, st)`
  c/ `b.left = st and xpRevX or 0`; `xpLogWidth(form, st)` (carimbo `xpWidth0` + 5 escritas);
  `local st = isStoryteller();` no topo de `renderXPLedger`; XML autora o JOGADOR (scroll **751**,
  box **791**, apply **225**, botão **185** `top=47`), `dynXpEmpty` `178/347/leading`,
  `lblXpLogTitle` ganhou NOME, o `<label APPLY>` & o `visible` da caixa SAÍRAM.
- **§T1046** — a chave `wod.APPLY` saiu das 2 metades do `.lang` & do mapa `PT`.
- **§T1047 gate** — §V477…§V480 NOVAS + **§V481 NOVA** (§B161) + emendas: V64 (`dotPending` na
  regex da arte), V240 & V280 & V298 (censo **71 → 70** + exceção POR CONSTRUÇÃO da caixa sem
  título, CONTADA), V247 (relação vira a do jogador + `XP_REV_W`), V473e (roster 11), V474a
  (`isStoryteller` no topo de `renderXPLedger`, 1× por render), V475b (3 leitores) & V475e
  (a escrita de `visible` INVERTEU: agora VERMELHO se voltar), roster PT sem `APPLY`.

### ⚠ AS 3 COISAS QUE CUSTARAM
1. **`horzTextAlign="left"` ⊥ ∃ (§B161).** O enum é `center`/`leading`/`trailing`. O `rdk -l` saiu
   **1**, APAGOU o `.rpk` & ⊥ nomeou arquivo nem linha — `XmlDocument` valida (é XML legal) & o
   gate estava verde. **6 builds de bisseção.** Virou **§V481** (mutação rodada, vermelha).
   O `.rpk` apagado foi recuperado do INSTALADO (`%APPDATA%\Firecast\Plugins\*.rpk` é ZIP & traz
   os `.lfm` da rodada anterior) — vale guardar essa saída.
2. **§V325 estava em 100 EXATOS (§B162).** As 2 `local function` novas de `WoD20.6` levariam a 102
   & é a MESMA morte calada. Achado pelo GATE, ⊥ por bisseção — a margem de 5 de §V325a pagou-se.
   Corrigido virando as 2 GLOBAIS (`xpPendingDots`, `xpDotArt`).
3. **O check novo reprovou na PRÓPRIA documentação.** `'dataLink[^>]*repaintXpDots'` sobre o texto
   cru casa com um COMENTÁRIO que diz que os 2 ⊥ andam juntos. Ler do ELEMENTO (`//dataLink` &
   `OuterXml`), ⊥ do texto. Idem: contar `xpDotArt(c, t, pending)` conta a DECLARAÇÃO junto (3, ⊥ 2).

### DIVIDAS DE SPEC (nenhuma bloqueia)
1. §I163c/§V478d nasceram dizendo `left = st and 745 or 0` & o construído lê o `745` do TEMPLATE
   (`xpRevX`) p/ ⊥ ter 2 donos da coordenada — as 2 linhas JÁ foram emendadas no lugar.
2. §V475(b) foi de 2 p/ 3 LEITORES; o gate conta **4** ocorrências de `sheet.xpApplied` (o `gsub`
   de `xpRevert` lê a string p/ escrever). A distinção está escrita na emenda.

---

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-07, fim da 194a rodada)

### O ESTADO EM UMA LINHA
`/ck:spec` escreveu o **18o lote** (§I162, §Q82, §R160…§R162, §V472…§V476, §T1036…§T1041) & `/ck:build --all`
fechou **§T1036…§T1039**. Gate `-Build` VERDE, 20 mutações/sondas RODADAS (14 vermelhas no check certo, 6 verdes).
**INSTALADO 20:57:04** (2939472 B, mesmo size do `output/`), c/ o Firecast ABERTO — o user confirmou 2026-09-07 que é
seguro & o `CLAUDE.md` (linhas 40-42) já dizia; §T1040 `x`. **Nada commitado.**

### O QUE PEDIR, NESTA ORDEM
1. **Rodar a §T1041** (`.\spec-slice.ps1 T1041`, alíneas (a)…(g)) — se a ficha estava aberta às 20:57, fechar & reabrir
   a ficha antes (form velho na tela até isso; cosmético). Nada desta rodada foi visto rodando.
2. As 10 perguntas de **§Q82** têm recomendação & o lote foi construído por ela; a resposta do user EMENDA.

### O que virou código nesta rodada
- **§T1036 raiz** — `xpWhen` (4o carimbo, `|traço#nível@AAAA-MM-DD HH:MM|`, escrito COLADO ao `xpOrder` em `xpStep` & `xpSetSpent`,
  lido 1× em `xpLedgerRows` → `rows[i].when`); o piso APLICADO no ramo de venda de `xpStep` (`not free` & fala);
  `XP_REV_POOL = 60` na raiz; `xpRevert(form, i)` abaixo de `xpClick` — pergunta `isStoryteller()`, recusa (`lvl < live`
  / `lvl > live`) ANTES do `confirmOkCancel`, tira a chave de `xpApplied` & VENDE por `xpStep(tabRootOf(form), …, false, base, false)`.
- **§T1037 `WoD20.9`** — coluna `dynXpWhen` `515/0/220/470` + rótulo `Date/Time`; `<template name="XpRevRow">` + 60 instâncias
  no `xpLogScroll` (`745/20`, `visible=false`, `onClick="xpRevert(self, n)"`); scroll `20/65/781/470`, `xpLogBox` `0/125/821/550`;
  caixa `xpApplyBox` **`566/0/255/120`** (vão de **5**, §V298 — ⊥ os 581/240 que a spec trazia, §B160) c/ `btnXpApply` `20/50/215/26`
  `enabled=false opacity=0.50`; `xpRevButtons`, `renderXPApply` (locais, acima de `renderXPLedger`) & `xpApply` (global).
- **§T1038** — 8 chaves nas 2 metades do `.lang` & no mapa `PT` (bloco "18th batch" no fim do mapa).
- **§T1039 gate** — §V472…§V476 NOVAS no fim do arquivo (antes do sumário) + 10 checks velhos emendados: V244 (`0.50` na lista),
  V129 (8 → 9 pop-ups), V135/V444/V136/V260d (o literal da chamada `xpLedgerRows(…)` ganhou o 6o argumento), V247 (relação
  reescrita: filho MAIS À DIREITA do scroll, `EXPERIENCE` fixa em 561, `EXPERIENCE + 5 + APPLY == log`), V261 (4 → 5 colunas),
  V280/V298 (censo 70 → **71** caixas), V112 (2o controle que trava: `btnXpApply`), `$K383` (+`XP_REV_POOL`).

### ⚠ AS 5 COISAS QUE CUSTARAM
1. **§V280(b) dizia vão de 20 & o dono é §V298 (5 desde 2026-08-25).** O gate acendeu V298 na 1a passada; a caixa `APPLY` foi
   p/ 566/255 & o botão p/ 215. Virou **§B160** & a §V280(b) ganhou o aviso de REVOGADA no próprio texto — quem lê pela fatia
   (1 nível) ⊥ via a §V298. §I162f, §V247 (emenda), §Q82.9 & §T1037 foram corrigidas no lugar.
2. **PowerShell 5.1: `'\('` dentro de `"$( … )"` numa string de aspas duplas quebra o PARSER** (`$(subexpression) não tem o ')'`).
   3 mensagens de check tinham `$(([regex]::Matches($x, 'xpLedgerRows\(')).Count)` — o gate inteiro deixou de carregar. Forma
   segura: contar numa variável ANTES & interpolar a variável (memória `powershell-armadilhas-de-script`, item 7).
3. **10 checks velhos vermelhos na 1a passada, todos roster** (lista acima) — ≡ 193a. A sonda "`width` dos 60 botões 20 → 22"
   escrita em §V474 seria VERMELHA por §V247 (a relação mede a borda direita) ∴ a sonda RODADA foi `height` 20 → 18 (VERDE).
4. **`markDot` procura a bolinha DESCENDO do nó recebido** — o `X` mora na Progress & a bolinha noutra aba ∴ `xpRevert` passa
   `tabRootOf(form)` ao `xpStep`, ⊥ `form`. Está em §I162e; ⊥ foi visto rodando (é a alínea (c) de §T1041).
5. **Pulei o `rdk -i` por "Firecast aberto" — regra JÁ revogada no `CLAUDE.md` do disco (linhas 40-42, user 2026-09-07)**
   que a cópia velha no meu contexto ⊥ tinha. O user mandou instalar & registrar: Firecast aberto NUNCA impede o install
   (memória `instalar-com-firecast-aberto`). Antes de agir sobre regra que BLOQUEIA, reler o `CLAUDE.md` do disco.

### DIVIDAS DE SPEC (p/ `/ck:spec`, nenhuma bloqueia)
1. §V474 sonda diz `width` 20 → 22 VERDE — é VERMELHA por §V247; a sonda válida é `height` 20 → 18.
2. §V473(d) descreve a RELAÇÃO de largura & o gate mede isso em §V247 (dono único); o check de §V473(d) mede só "o pool é o
   filho mais à direita do scroll".
3. §V472(c) diz `os.date` ≤1× por passo & ∃ 2o sítio legítimo em `xpSetSpent` (linha MANUAL) — o check conta 1 em `xpStep`
   & aceita o de `xpSetSpent`.
4. §V244 no SPEC fala em `0.60` como 2o literal Lua & o gate carrega `0.80` (`$LUA_OPACITY`) — herdado, ⊥ desta rodada.
5. **§B103 manda "avisar antes de instalar" c/ a ficha aberta & o user revogou isso 2026-09-07** ("é seguro"): emendar §B103
   no lugar — o que fica verdadeiro é só o SINTOMA (form velho na tela até reabrir a ficha), ⊥ a regra de avisar/adiar.

### TESTES DE TELA desta rodada (`.\spec-slice.ps1 T1041`)
**(c)** é o que decide: Força 2 → comprar 3 & 4 como Mestre → `X` da linha 3 = pop-up `Reverta o nível mais alto primeiro`;
`X` da 4 → confirmação → bolinha 4 apaga & `Current` sobe. **(d)/(e)**: `APPLY` invisível sem `baseline`, apagada a 50% sem
compra pendente, acesa depois de comprar; aplicada, a bolinha ⊥ sai (pop-up) a menos que `Edit dots freely` esteja ON.
**(g)**: log c/ > 23 linhas — os `X` rolam c/ as linhas.

---

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-07, fim da 193a rodada)

### O ESTADO EM UMA LINHA
`/ck:build --all` fechou **§T1011** (resto do 12o lote) **& o 13o lote inteiro** (§T1004…§T1009,
picker de armas/armaduras). Gate `-Build` VERDE. **INSTALADO 04:29:53**, Firecast FECHADO,
1 install so (§B103). **Nada commitado.** So falta a **§T1010**, que e teste de tela [USER].

### O QUE PEDIR, NESTA ORDEM
1. **Abrir o Firecast & rodar a §T1010** - a lista de testes esta em `.\spec-slice.ps1 T1010`
   & repetida abaixo em "TESTES DE TELA". **Nada desta rodada foi visto rodando.**
2. Depois disso, o proximo lote. ⊥ ha §T aberta fora da §T1010.

### O que virou codigo nesta rodada
- **§T1011** - `Influence (Mage)` entrou & a lista de antecedente fechou em **59**. A linha de
  essencia ja existia em `bg_essence.tsv:131`; o que faltava era o item, as 3 chaves (mapa PT +
  2 metades do `.lang`), os 2 corpos & rodar `resolve_bg_pick.ps1` -> `gen_bg_desc.ps1`.
  O bloco de decisao do cabecalho da TSV foi corrigido (`Influence 3` -> `4`, total 58 -> 59).
- **§T1004** - `research/gen_combat_data.ps1` (BOM UTF-8, codigo 100% ASCII, acentos por
  `[char]0x..`). Le `weapon.tsv` (189) & `armor.tsv` (33) & escreve em `%TEMP%\combatgen\`:
  `combatData.lua` + os 4 `desc{Weapon,Armor}_{en,pt}.lua` + `picker_combat.txt` +
  `lang_{pt,en}.txt` + `ptmap.txt`. **222 chaves novas** (220 nomes + `Select Weapon`/
  `Select Armor`); `Dodge` & `Tough Hide` foram PULADOS porque ja estavam no mapa PT.
- **§T1005** - `WoD20.3.lfm`: as 11 linhas `Attack` viraram `?` + botao + gemeo escondido; as 7
  celulas & `armorRating`/`armorPenalty` viraram `readOnly + 0.75 + center`; `armorDescription`
  so `readOnly`; `Class` da caixa ARMOR virou picker; `btnQconceal` no cabecalho;
  `renderCombatButtons` + `<dataLink>` + `onNodeReady`.
- **§T1006** - raiz: as 2 listas coladas na regiao marcada, o `require("combatData.lua")` no
  `mfOpen`, `mfConfirm` c/ os 2 ramos, o painel de 18 controles (**+ os 18 gemeos `B`**) &
  3 helpers GLOBAIS novos (`mfWeaponShown` `mfArmorShown` `mfCell`) + 2 tabelas GLOBAIS
  (`MF_WPN_CELL` `MF_ARM_CELL`).
- **§T1007** - os 5 `.lua` copiados p/ a raiz do plugin, as 222 chaves coladas nas 2 metades do
  `.lang` & no mapa PT.
- **§T1008** - §V455…§V461 no gate + **5 rosters de checks VELHOS** que o lote novo obrigou a
  atualizar (ver abaixo).

### ⚠ AS 6 COISAS QUE CUSTARAM, & NENHUMA ESTAVA NO SPEC
1. **O gate REPROVOU 14 vezes na 1a passada, & todas eram roster de check velho.** O lote novo
   ⊥ pede so §V novas: `$DESC_MARKER` (+`Weapon`/`Armor`), `$DESC_BRIGHT`
   (+`armorDescription`), `$V333_SRC` (+`Attack = 11`, & o total 165 -> **176**), `$BARE_Q333`
   (+`btnQconceal`), `$BARE_DYN` (+`dynarmorClass`), `$V354_WAVE` (+ a onda `Attack`, forma
   **`indirect`**), `$K383` (+`ATTACK_ROWS`), o coletor de `Add383` (+`//Attack`) & o padrao de
   §V355(e) (que ganhou o `isMf and`). **Toda onda de picker nova paga esses 9 pedagios.**
2. **`local ATTACK_ROWS = 11` no form ⊥ passa (§V383b).** §I157g manda declarar no form; §V383b
   diz que limite LITERAL de laco de pintura e VERMELHO (e B112). A constante foi p/ a RAIZ, ao
   lado de `BACKGROUND_ROWS`/`DISC_ROWS`, & entrou no `$K383` - assim §V204/§V383 medem ela
   contra o XML, que e exatamente o que §V455d queria. **Divida de spec: §I157g diz `local`.**
3. **§V345 cobra LF em TODO `desc*.lua` da raiz.** §T1004 dizia "CRLF nos 5 `.lua`" & isso vale
   so p/ o `combatData.lua` (irmao do `meritData.lua`). Os 4 `desc*` sao **LF**. Se sairem CRLF
   o gate fica vermelho na hora. **Divida de spec.**
4. **`opacity` em `textEditor` apaga o TEXTO (§V241) & §V111 cobrava 0.75.** `armorDescription`
   entrou no `$DESC_BRIGHT` - e prosa que o jogador ABRE p/ ler, ≡ `edtMfDesc`. §V458b ja
   mandava `readOnly` sem `opacity`; quem ⊥ sabia era o §V111.
5. **As 2 SONDAS de §V458 & §V459 ficam VERMELHAS por OUTRO check, & esta certo.** `opacity`
   0.75->0.80 acende §V111/§V244 (dono do NUMERO) & §V458 fica verde (mede PRESENCA); mudar o
   PT de `Select Armor` acende §V22 (mapa PT x `.lang`) & §V459 fica verde. As 2 invariantes
   se comportaram como a sonda pede - o gate reprova por dono diferente. **Anotado p/ ninguem
   "consertar" o check achando que ele esta apertado demais.**
6. **`$t.Replace($from,$to,1)` ⊥ EXISTE no .NET Framework** (so 2 argumentos) & a excecao ⊥
   para o script: 2 mutacoes sairam "VERDE" sem nunca terem sido aplicadas. O helper de
   mutacao esta em `%TEMP%\claude\...\scratchpad\mut.ps1` & usa `Substring` + splice.

### As 23 MUTACOES & as 7 SONDAS que foram RODADAS (§V20)
Todas as 23 VERMELHAS: tirar `btnQattack` · `ATTACK_ROWS = 10` · plantar `btnQarmorClass` ·
tirar o `pt` de 1 entrada de `combatData` · plantar `Iron Shirt` na lista · apagar 1 entrada de
`descArmor_pt` · tirar o par `clip_` de `MF_WPN_CELL` · voltar o teste do ramo de merit p/
`MF.data ~= nil` · `or "-"` no ramo de livro · custom sem `mfCell` · tirar `readOnly` de
`rate_` · tirar `horzTextAlign` de `clip_` · `opacity` no `textEditor` · renomear a lista so no
`mfOpen` · tirar as celulas de arma de `mfNames` · `mfCustom` sem prefill · ligar arma sem
desligar armadura · apagar a chave `Conceal` do `_pt` · `width=70` de volta no label · `X` numa
celula `conceal` · legenda sem explicar `P` · zero-guard de `MF_WPN_CELL` · zero-guard de
`mfArmorShown`.
As 7 sondas: `left` do `?` 0->2 VERDE · reordenar 2 itens da lista VERDE · trocar a ORDEM das 7
escritas VERDE · `opacity` 0.75->0.80 (§V458 VERDE, gate vermelho por §V111) · PT de
`Select Armor` (§V459 VERDE, gate vermelho por §V22) · mover `left` de `lblMfWpn_rate` VERDE ·
mexer na redacao da legenda VERDE.

### DIVIDAS DE SPEC desta rodada (todas p/ o `/ck:spec`, NENHUMA bloqueia build)
1. **§I157g diz `local ATTACK_ROWS = 11` no form & ele mora na RAIZ** (item 2 acima, §V383b).
2. **§T1004 diz `file` = CRLF nos 5 `.lua` & os 4 `desc*` sao LF** (item 3, §V345).
3. **§V458(a) diz "0.75 byte a byte" & a SONDA da propria §V458 diz que o NUMERO ⊥ e medido.**
   O check mede PRESENCA; o numero e de §V111/§V244. Contradicao DENTRO de §V458.
4. **§I157e diz `elseif` na cadeia do merit** & o carregamento e um `if` guardado no COMECO do
   ramo do `PICKER_LIST` - tinha de ser, ou a pool ⊥ viria de `PICKER_LIST` como §I157e manda.
5. **A mutacao de §V457 ("apagar a escrita de `clip_`") virou "tirar o par de `MF_WPN_CELL`"**:
   as 7 escritas sao dirigidas por tabela (1 dono, §V135) ∴ ⊥ ∃ linha de `clip_` p/ apagar.
6. **§I157i diz 222 chaves & sao 222**, mas a conta e 220 nomes + 2 `Select` (2 nomes PULADOS
   por ja estarem no mapa). O total bate; a quebra ⊥ estava escrita.
7. **`Trash Can Lid` (`m20`) & `Trashcan Lid` (`w20`) sao 2 itens de grafia diferente** ∴ ⊥
   ganham sufixo por §I157c - mas o `name_pt` do segundo carrega `(Lobisomem)` & o EN ⊥.
   Decidir se o EN ganha sufixo ou se o PT perde o dele e trabalho de `/ck:spec`.
8. Herdadas & ⊥ tocadas: §I73 conta 68 caixas & o gate mede 70 · a clausula de SONDA de §V438
   esta FALSA · §I153f mora em §V237 · a emenda de §V295a mede 2 coisas · §I156a quebra 17+11 &
   o medido foi 18+10 · §I156e diz 420x55 & ficou 420x68 · §I156i descreve `pushRise` diferente.

### ⚠ O RISCO CONHECIDO desta rodada, & e o unico
**Nada foi visto rodando.** O gate mede FORMA - "o painel ∃, esta em `mfNames`, `mfConfirm`
escreve pela tabela" - & o que ele ⊥ prova e a tela. O ponto exato a olhar e o **painel CUSTOM
de arma**: os 18 controles nasceram HOJE e a `base = 237` do `mfCustomPane` nunca foi vista com
7 campos em cima dela. Se o `edtMfDesc` cobrir os campos, o conserto e 1 numero (§I157n).

### TESTES DE TELA desta rodada (o `.rpk` novo JA esta instalado - fazer no Firecast)
- **§T1010 inteira** - `.\spec-slice.ps1 T1010` tem as 9 alineas (a)…(i). As 3 que mais importam:
  **(a)** aba Combat, linha 1: o botao abre a caixa; `Sword` -> Roll `Dex + Melee`, Diff. `6`,
  Damage `Str + 2 (L)`, Range/Rate/Clip `-`, Conceal `T`, tudo CENTRADO & a 0.75; clicar numa
  celula ⊥ edita. Em pt: `Des + Armas Brancas` / `For + 2 (L)` / Conceal **`M`**, botao `Espada`.
  **(d)** `-- Custom --` numa linha que ja tem `Sword`: o painel abre c/ os 7 campos JA
  preenchidos; apagar `Conceal` & dar OK -> a celula le `-`.
  **(i)** escolher arma na linha 3 & olhar o NDB: **⊥ pode nascer `book_3`/`type_3`/`costy_3`**.
- **antecedente (§T1011)**: o picker tem **59** itens & `Influence (Mage)` esta entre
  `Influence (Dark Ages)` & `Influence (Modern Nights)`; o `?` dele abre `Mage: The Ascension
  20th Anniversary Edition, p. 316` & a escada vai ate **10** degraus.

---

As rodadas da 192a para tras estao em `HANDOFF-ARCHIVE.md`. Nada foi apagado: este arquivo
guarda as rodadas que ainda dizem o que fazer, e o archive guarda o resto. Ler o historico
inteiro para comecar uma rodada custava 589 KB por sessao, e o bloco do topo e o unico que
o `CLAUDE.md` manda ler.
