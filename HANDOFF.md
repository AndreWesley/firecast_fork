# HANDOFF — estado antes do próximo `/ck:build`

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
