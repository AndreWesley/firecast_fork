# HANDOFF — estado antes do próximo `/ck:build`

## ⚑ COMECE AQUI — 2026-09-01, 163ª rodada. §T830 §T831 §T843 §T844 §T874 FECHADAS · §T875 PARCIAL · gate VERDE

### ▶ O COMANDO: **`/ck:build --next`** — ⊥ ∃ §T bloqueada por prosa agora

A 162ª fechou §T830 (régua) & a 163ª rodou `/ck:spec` (4 emendas) + fechou **§T831** & **§T874**
INTEIRA. ⊥ sobra §T travada por spec. Detalhe em "O QUE A 163ª FEZ".

**Estado:** gate **VERDE — 0 FAIL** (`-Build`) · §T **794 `x` (781 arquivadas + 13 vivas) · 89 `.` · 8 `~`** · `.rpk` **2.598.813 B**, mtime **22:50:37**, **INSTALADO** 22:50:38 · último commit
**`b5111c35`** · **NADA commitado** (a 160ª → a 163ª INTEIRAS no working tree).

✅ **O INSTALL DE §T875 FOI VERIFICADO POR CONTEÚDO, ⊥ só por size** (§B1): o `.rpk` instalado foi
ABERTO (é ZIP) & traz `HedgePicker`=**20** · `PsychicPicker`=**20** · `NuminaFree`=**0** ·
`HedgeRitualFree`=**5** — a última INTACTA, que é o que §B122 manda. Size igual sozinho ⊥ provaria
isto: as 2 conversões & a ⊥-conversão cabem dentro de poucos bytes de diferença.

✅ **BUILD & INSTALL FEITOS & PROVADOS (§B1, §B103):** `.rpk` **2.596.783 B**, mtime 22:10:03, &
`%APPDATA%\Firecast\Plugins\andreoliveira.styllern.wod20th.rpk` c/ o **MESMO size** & mtime
22:10:04. Rodou **offline**, c/ o Firecast fechado a pedido do user — que é o caminho obrigatório
aqui: a conversão da afiliação p/ picker é MUDANÇA DE WIDGET (o combo some & 2 botões nascem) &
instalar c/ a ficha aberta deixaria o form velho na tela, c/ o controle sumido & nenhum handler
p/ trazê-lo de volta. ✅ **CONFERIDO NA TELA pelo user 2026-09-01** ("sim, tudo certo"): a linha `Affiliation` da caixa `HEDGE MAGIC` mostra o `?` + botão, o botão pinta a afiliação escolhida, o `?` abre descrição & a linha segue alinhada c/ `Essence` & `Casting Attribute`. ∴ o risco de §T810 (widget novo que só o XML viu) está FECHADO p/ esta rodada.

⚠ **A FILA DE INSTALL ZEROU, & foi ela que produziu o único sintoma da rodada.** O instalado era
de **13:13** (a 160ª) & **2 rodadas de layout** estavam paradas atrás dele. O user abriu a ficha,
olhou a aba Numina & disse *"não está certo, ela parece não ter mudado"* — & ⊥ tinha mudado
mesmo: ⊥ NA TELA. ⊥ era bug de código, era §B103 pelo outro lado (o código novo ⊥ tinha chegado).
MEDIDO antes de responder, ⊥ suposto: instalado 2.613.533 B / 13:13 contra `output/` 2.595.566 B
/ 21:12, & o `.rpk` novo é ~18 KB **MENOR** porque a 161ª tirou as 4 panes, o bloco da força de
vontade & as 2 barras. O install rodou **offline**, c/ o Firecast fechado a pedido do user, que é
o caminho que §B103 manda tomar. ⚠ **o user ainda ⊥ confirmou ter reaberto & olhado** — se a 163ª
começar sem essa confirmação, é a 1ª coisa a pedir (mesmo risco de §T810).

---

## HISTÓRICO — o que a 161ª FEZ (as 2 §T saíram dela em `~`, por motivos DIFERENTES)

### §T874 — onda 4 de §I113e, a metade dos 43 pickers · `~` porque falta `cboHedgeAffiliation`

`HedgePicker` · `PsychicPicker` · `HedgeRitualPicker` viraram `?` + botão + gêmeo escondido
(§I107a1), os **3** declarando o módulo **`Numina`** — o mesmo dos 2 lados de cada linha, que é o
que §V373(a) cobra (§B110). Veio junto, & ⊥ era opcional (§V365(d) mede por ARQUIVO):

- **as 4 panes de `WoD20.7` SAÍRAM**, `edtFaithDesc` inclusive — a 4ª é a que ⊥ tinha linha:
  True Faith é 1 Path só ∴ ganhou um `?` c/ a chave `'True Faith'` LITERAL & `row = nil`.
- **os 3 radios SAÍRAM** & `numinaSel` `psychicSel` `hedgeRitualSel` viraram ÓRFÃOS de §I3.
- **`renderNuminaButtons`** nasce em `WoD20.7` & reafirma o **negrito de `numina_1`** DEPOIS do
  `mfLabel` — §V88 promete negrito SEMPRE & `mfLabel` reescreve `fontStyle` a cada pintura.
- **`WoD20.6`**: `FILTER_NAME` & o `xpFind` de `renderHedgePickers` caem p/ `cboHedgeAttr` só. O
  filtro ⊥ sumiu, mudou de PORTA: `mfOpen` lê `hedgePathLevels()` 1× por abertura.
- **3 chaves `.lang`** nos 2 idiomas + no mapa PT: `Select Hedge Path` · `Select Phenomenon` ·
  `Select Hedge Ritual`.
- **19 réguas** mexidas, **7 APOSENTADAS** c/ guarda de fantasma: §V29 · §V30 · §V33 · §V176 ·
  §V206 · §V266 · §V296. **8 mutações** rodadas, todas vermelhas na régua certa.

### §T830 — aba Numina SEM sub-abas, 3 colunas · a 161ª deixou `~`, a 162ª fechou em `x`

**Layout & dados: FEITO.**

| o quê | como ficou |
|---|---|
| sub-abas | **`numStrip` & `hedgeStrip` APAGADAS**. `SUB_TABS` & `renderSubTabs` APAGADOS do form raiz; `selectTab` ficou c/ 2 linhas (`activeTab` + `applyTabVisibility`) — a busca que ela fazia sempre caía fora, & agora ⊥ ∃ o que buscar |
| banda de topo | ⊥ SE MOVEU (§V361a): `HEDGE MAGIC` 0..586 · `QUINTESSENCE` 591..998 · **`TRUE FAITH` 1003..1410**, no rect que era da `WILLPOWER` |
| força de vontade | **SAIU INTEIRA** (§I117d, §V361c): o template `WillpowerNumina`, `paintNuminaWillpower` & o dataLink. **0 campo foi junto** — `willpower_c1..c10` seguem autorados em `WoD20.3`, & o gate agora COBRA isso (§V267 tem perna nova lendo `WoD20.3`) |
| 3 colunas | col.1 `PSYCHIC PHENOMENA` 0..466 · col.2 `HEDGE MAGIC PATHS` 471..938 · col.3 `HEDGE MAGIC RITUALS` 943..1410, `top=151`, vão **5**, TODAS visíveis. A linha DENTRO é **426** nas 3 ∴ `?`, entrada & os 5 dots no mesmo x em toda a aba (§V26). Os 2px extras das colunas 2 & 3 vão p/ a MARGEM, que §V280(a) preços em ≥20 |
| pés | **20 nas 3** — o mínimo de §V280(a) ∴ ⊥ ∃ pé que alguém escolheu. O Ghoul paga diferente (§V280d) porque as colunas dele são forms importados que ! pousar numa linha |
| `psychic` | **24 → 20 desenhadas**. `psychic_16`…`_19` **APAGADOS DE VEZ** (§Q32): nasce **`PSYCHIC_VACANT`**, `$I3_DELETED` sai de vazio p/ os **4** (o teto de §V362d), & `PSYCHIC_ROWS` FICA em **24** porque é o MAIOR ÍNDICE — as digitadas moram em `_20`…`_24`, ACIMA do buraco |
| `numina` | **17 → 20**. ⚠ **decisão tomada ao construir, ↓ "A LEITURA DE §I117c"** |
| nota da afinidade | saiu do `hedgeStrip` & foi p/ DENTRO da col.2, no pé (`noteHedgePaths`, `top=546`) ∴ col.2 tem **586** de altura & as outras 561/486 |
| §V204 perna (ii) | LIGADA p/ `psychic`: `XP_NUMINA` carrega `vacant` & os **3** leitores (`declareTrait`, `numinaTypeInUse`, o laço do ledger) consultam. O do ledger é o que fazia dano: ficha pré-§T830 tem dots em `_16`…`_19` & o diff os leria como COMPRA |

**Réguas mexidas em §T830 — 24, & 5 APOSENTADAS a mais:** §V262 (as pernas (a)(b)(d) eram da
barra & das panes; (c) SOBREVIVE & virou a única régua de fila de boxes das 2 abas) · §V268 ·
§V293 · §V300 · §V305. Re-sujeitadas: §V265 (a pane virou box da banda) · §V267 (a banda é filha
do FORM agora; a perna da força de vontade aposentou c/ guarda) · §V296/§V297 (`//scrollBox/`) ·
§V307 (só a barra de cima) · §V227 (`SUB_TABS` some da lista de estado) · §V355(c) (**herdou** a
contagem de `fontStyle` que era de §V305c — dona que aposenta, regra que migra) · §V5/§V263 (leem
`PSYCHIC_VACANT`) · §V354/§V333 (12→15 & 19→15) · §V196/§V111/§V241 (12 combos) ·
§V239/§V240/§V280/§V298 (contagens de box) · §V226/§V228/§V281/§V299/§V301/§V304/§V306/§V315/
§V319/§V320/§V323 (**3 barras → 1**) · §V240 `$STRETCHED_BAND` (`WILLPOWER` → `TRUE FAITH`).

⚠ **ARMADILHA DE POWERSHELL, & custou 2 execuções**: `@(@("a","b"))` **ACHATA** p/ um array de 2
strings ∴ `$pair[0]` devolve o CARACTERE `W` de `"WoD20th.lfm"`. Roster de 1 entrada ! ser
`@(,@("a","b"))`. ∃ **8** desses no gate agora, todos c/ a vírgula.

### ⚠ A LEITURA DE §I117c — a decisão que EU tomei, & o porquê. **CONFIRA**

§I117c diz: "`numina` vai de **17** a **20** c/ **3** pickers NOVOS, `_18` `_19` `_20`". Lida ao
pé da letra ela dá: pickers `_1`…`_12` + `_18`…`_20`, digitadas `_13`…`_17` — **& isso ⊥ compila
contra §V263(b)**, que exige as digitadas nos ÚLTIMOS índices, & quebra `TYPED_ROW_FROM`, que é
`total − typed + 1` & é como `isTypedRow` responde p/ a ficha inteira.

**O que eu construí:** pickers `_1`…`_15`, digitadas `_16`…`_20`, & os **3 ids NOVOS (`_18` `_19`
`_20`) são as DIGITADAS**. Assim: §V263(b) VERDE · `TYPED_ROW_FROM` segue derivada · §V362(c)
satisfeita (ids seguintes, ⊥ reusa vago) · as 2 colunas fecham em **15 picker + 5 digitadas**, que
é a "MESMA estrutura" de §I117b · & `numina_13`…`_15` viram picker **1 rodada antes** — o que
**§T875 ia fazer com as 5 de qualquer jeito** (§I130b, §V378), & o valor do jogador ⊥ se move
(`mfOpen` acrescenta o valor da linha ao pool, §V200/§V346b).

**É dívida de PROSA p/ `/ck:spec`**, ⊥ dívida de código: §I117c ! dizer qual das 2 metades os 3
ids novos ocupam. Se o user quiser a leitura literal, o preço é reescrever §V263(b) & trocar
`TYPED_ROW_FROM` de fórmula p/ CONJUNTO nas 7 famílias.

---

## O QUE A 162ª FEZ — a metade de RÉGUA de §T830, & só ela. §T830 → `x`

**0 linha de código de ficha mudou.** Os 3 arquivos tocados são `verify-hunters-hunted.ps1`,
`SPEC.md` (só o status) & este. O `.lfm` & o `.lua` saíram da rodada byte a byte iguais.

### §V361 NASCEU INTEIRA — (a)(c)(d)(e), 1 bloco só, logo depois de §V221

| perna | o que ficou medindo |
|---|---|
| **(a) roster** | as **2** abas: exatamente **3** colunas abaixo da banda, cada uma respondendo ao nome do roster, **0** `visible="false"`, **0** `name` sobrevivendo a `selectTab`. **Herdado de §V188** |
| **(a) banda** | **CONGELADA** em `b5111c35`, ≡ `$FIELD_CONTRACT` fez p/ campo: `$V361_BAND` c/ os **5** rects autorados lá (3 da Numina + 2 do Ghoul). É **PISO ⊥ teto** — caixa NOVA na banda ⊥ custa nada aqui (§V40/§V298 pegam sobreposição & vão) |
| **(c)** | a exceção é **LISTA**, fechada em **1**: `WILLPOWER` → `TRUE FAITH`. Desvio que a banda acha & a lista ⊥ nomeia = FAIL · & a exceção ! ser **ALCANÇADA** (exceção que ninguém alcança parou de medir, ≡ §V240 guarda a dela) |
| **(d)** | as 2 abas **CONCORDAM** no desenho: mesmo vão único, 1 `top` só cada, 0 escondida, cada uma abrindo livre da SUA banda. ⚠ **⊥ ∃ literal nenhum aqui de propósito** — §V221 já cobra o 5 do Ghoul & §V298 o das colunas da Numina; 3º dono p/ 1 número é §B70. O que ⊥ tinha dono era o **acordo entre as 2**, & é isso que (d) é |
| **(e)** | 0 coluna · <2 abas lidas · contrato de banda vazio · 0 rect casado ! FAIL |

**A partição ⊥ tem 2 formas p/ 1 gesto**: `<layout>` filho direto do `<scrollBox>` c/ `top=0` é
BANDA, abaixo disso é COLUNA. Vale nos 2 arquivos sem 2º leitor, & barra que volta cai no conjunto
das colunas & quebra a conta de 3 — que é "sem sub-aba" dito em GEOMETRIA. Os NOMES das barras
(`numStrip` `hedgeStrip` `vampStrip`) ⊥ são varridos aqui: §V268 (aposentada), §V262, §V293 &
§V221 já os têm, & um 4º dono seria §V135.

**A identidade da coluna**: o `<import>/@file` quando ∃, senão o `<label>/@text`. 1 leitor, 2
abas — o Ghoul importa forms & a Numina desenha inline, & o roster lista o token de cada uma.

### §V188 ENTREGOU o roster — estava emprestado desde §T832

Some de lá a conta de 3, os 3 arquivos, o `visible` & o `name`. **FICA**: a varredura de fantasma
(`btnTab*`/`tabOn*`) & o censo de `tabControl` nativo, que nunca foram do empréstimo.

### §V362(c) & (d) c/ NOME PRÓPRIO

- **(c)** 2 metades. 1ª: nenhum dos 4 volta, **como widget OU como observador** — o laço de §I3
  anda só os ÓRFÃOS ∴ até agora ⊥ ∃ia NADA dizendo que `psychic_17` ⊥ pode ser autorado de novo.
  2ª, & é a c/ dente: os **2 livros do buraco CONCORDAM** — `$I3_DELETED` (quem o user apagou) vs.
  `PSYCHIC_VACANT` (quais índices o Lua pula), escritos 1 arquivo de distância. §V204 mede o XML
  contra §I3, **nunca §I3 contra o Lua**.
- **(d)** era teto (`> 4`), virou **EXATO** (`≠ 4`): §Q32 respondeu c/ exatamente esses 4 ∴ 4 é
  piso TAMBÉM. Sem o piso a lista esvazia & (c) anda sobre o vazio, que é §B7.

### ⚠ ACHADO ao construir — a frase de §V362 estava MENTINDO desde §T830

O Pass dizia *"$n have left so far, **every one of them as an orphan**"*. Até a 161ª era verdade;
no instante em que os 4 de §Q32 saíram pela OUTRA porta virou literal velho (§B46, §B99). Agora
CONTA as 2 saídas: `7 of them as orphans and 4 deleted by decision`. É o mesmo defeito que §V333(g)
pegou 3 rodadas seguidas — prosa que envelhece 1 dia depois de escrita.

### MUTAÇÃO — 17 casos + 1 sonda, & 5 deles são a PROVA do empréstimo

Todos vermelhos na régua certa; a sonda (reordenar as entradas de `$V361_BAND`) ficou VERDE ∴ o
contrato casa por RECT & ⊥ por ordem de documento. Os **5** que acendem **§V361 SOZINHA** — coluna
do Ghoul escondida · coluna do Ghoul c/ `name` · rect da banda do Ghoul movido · 2ª exceção ·
roster esvaziado — são a prova de que tirar o roster de §V188 ⊥ abriu buraco.
`17 V362d` (tirar 1 nome de `$I3_DELETED`) acende onde o `> 4` velho passava.

⚠ **ARMADILHA DE POWERSHELL, & custou 1 execução INTEIRA da bateria** (~10 min): `Write-Host` ⊥
sai pelo pipeline no PS 5.1 ∴ `& $gate | Out-String` devolve **VAZIO** & TODO caso vira MISS —
inclusive a sonda, que "passou" por ⊥ ter lido nada. Bateria de mutação ! rodar o gate em
**processo filho** (`powershell.exe -File`) & ler o stdout dele. É §B7 aplicado ao ARNÊS: o teste
que mede o vazio passa sempre.

---


---

## O QUE A 163ª FEZ — a passada de `/ck:spec` + §T831 & §T874 fechadas

**§T831 `x` sem 1 linha de código**: MEDIDO que §T830 (a caixa) + §T874 metade A (o `?`
`btnQFaith`, `popOpen(... 'True Faith' ...)`) já a tinham entregue, & o `faithReligion` que §I117
pedido 4.4 mandava criar **⊥ nasceu** — `faith` É o campo da religião desde antes de `b5111c35`.

**§T874 metade B `x`**: `cboHedgeAffiliation` virou picker. `btnQhedgeAffiliation` (o `?`, l=180
w=20) + `dynhedgeAffiliation` (o botão, l=205 w=335 ∴ fecha em 540) + `edtHedgeAffiliation` no
MESMO rect do botão. `renderNuminaButtons` ganhou o avulso (≡ `dynnature`) & o dataLink dele passa
a observar `hedgeAffiliation` — sem isso o botão diria `Select Affiliation` p/ sempre, porque a
escolha só faz `setField(MF.field, MF.picked)` & **⊥ ∃ repintura direta** (MEDIDO). 3 lugares de
idioma: `[pt]`, `[en]` & o mapa PT de `WoD20.6`.

⚠ **O `?` LIDERA A ENTRADA, ⊥ a linha**, & isto ⊥ foi gosto: é a forma que o picker dos
ANTECEDENTES já veste (`label@0 · ?@108 · dyn@132`, `WoD20.1`) & é o precedente que §I117 nomeia
c/ "≡ o dos antecedentes". §T844 (`hedgeAttr`) cai na MESMA linha & ! repetir esta forma.

**Emendas de spec da rodada:** §I117 pedido 4.4 (CORRIGIDA) · §I117c (a leitura construída virou a
decidida) · §V270(a)(d) & §V274(b)(c)(d) (trocam de sujeito p/ o picker) · §V222 (+ a armadilha do
arnês) · **§B119 §B120 §B121**.

### §T844 CANCELADA pelo user — `hedgeAttr` FICA dropdown, & é decisão FINAL

User 2026-09-01: *"hedgeAttr pode ficar do jeito que está, remova o T844"*. **⊥ foi apagada — foi
FECHADA**: 6 lugares a citam (§V356 · §T843 · §T852 · §B101 & 2 linhas de §I113e/§I131) & §V384
cobra que ∀ citação resolva; §V386 só deixa sair do `SPEC.md` tarefa FECHADA. Apagar deixaria 6
citações penduradas & — pior — apagaria o MOTIVO, & §B101 continua dizendo que `hedgeAttr` é PROSA
∴ uma rodada futura o reconverteria achando que foi esquecimento.

É a **3ª & última** decisão sobre este campo: §Q31 o chamou de combo de VALOR sobre premissa ⊥
medida · §T843 MEDIU & o devolveu p/ a onda 2 · o dono olhou a medida & escolheu dropdown MESMO
ASSIM. §V362(b) é a regra: invariante ⊥ veta escolha informada do dono, ela REGISTRA qual foi.

**§V356 emendada**: ∃ **3** categorias agora, ⊥ 2 — combo de VALOR (os 7 de `$V356_KEEP`) · picker
de PROSA (§I113e) · & `hedgeAttr`, PROSA que fica dropdown por escolha. Ele ⊥ entra no roster
(listá-lo exigiria par autorado = 2ª cópia de lista, §V208, & ele pararia de traduzir) ∴ fica
NOMEADO, ≡ `speciality` em §Q33, p/ que régua futura do tipo "⊥ ∃ `comboBox` na ficha" ⊥ o coma
calado (§B94). **§T843 fechou junto**: o único bloqueio dela era §T844.

⚠ **§T852 perdeu o motivo** (`/ck:research` do texto de `hedgeAttr`): sem `?` ⊥ ∃ descrição p/
abrir. ⊥ foi mexida — é decisão p/ a próxima `/ck:spec`.
### ⚠ A LACUNA QUE A MUTAÇÃO ACHOU & QUE ⊥ FOI FECHADA — p/ a próxima `/ck:spec`

**Tirar `hedgeAffiliation` do `fields` do dataLink do pintor deixa o gate VERDE.** MEDIDO (caso 11
da bateria). O dano é real: o botão pararia de repintar & mostraria `Select Affiliation` c/ valor
dentro. **RAIZ, & ela é de ESCOPO:** §V383 promete "∀ botão de picker autorado é PINTADO" mas o
coletor dele expande **TEMPLATES** ∴ botão AVULSO (autorado inline, ⊥ por template) escapa da
régua inteira — que é exatamente a vacância que §V333 fechou p/ o `?` c/ o roster `$BARE_Q333`, 1
porta ao lado, & que §V354(i) nomeia. Hoje ∃ **1** desses (`dynhedgeAffiliation`); §T844 & §T876
criam mais.

**⊥ foi construída nesta rodada de propósito:** ⊥ bloqueia §T874, & régua nova ! nascer c/ mutação
+ sonda (§V20 §V222) — o que é §T próprio, ⊥ carona numa §T de conversão. **RECOMENDAÇÃO:** §T nova
que dê a §V383 um `$BARE_DYN` ≡ o `$BARE_Q333` de §V333, c/ 2 pernas: (a) o botão avulso é pintado
por ALGUM `mfLabel` & (b) o dataLink do pintor OBSERVA o campo que ele pinta. A (b) é a que a
mutação provou faltar.

### ⚠ 2 ARMADILHAS DE POWERSHELL, as 2 custaram execução, & as 2 são de PARSE

1. **`,@(a, b, c - d)`** — a vírgula unária casa MAIS FRACO que o `-` ∴ o PowerShell lê
   `(@(a,b,c)) - d` & morre c/ `op_Subtraction` sobre `Object[]`, apontando p/ código que LÊ
   certo. Conta fora do literal: `$w = $hi - $lo;` & só então `+= ,@(n, $lo, $w)`.
2. **`@('a', @('x','y'))` ACHATA p/ 3 elementos.** Roster c/ lista aninhada ! ser
   `[pscustomobject]`. É a mesma família do `@(,@(...))` que custou 2 execuções na 161ª.

⚠ **& 1 de ARNÊS**: mutação mal construída acusa a RÉGUA no lugar do teste. O caso 06 renomeou só
1 das 2 ocorrências de `dynhedgeAffiliation` em `renderManualEntry` & o gate ficou verde — ⊥ era
buraco de §V274(d), era a outra ocorrência sustentando o nome. Ao ver "mutação ⊥ pegou", conferir
PRIMEIRO se ela de fato removeu o sujeito. (Achou 1 defeito de verdade no caminho: §V274(d) casava
por SUBSTRING ∴ `dynhedgeAffiliationX` passava verde — corrigido c/ `\b` & `-cnotmatch`, & provado
c/ o caso 06b.)
## §T875 — PARCIAL (2 de 3) & `~`. O 3º terço APAGAVA DADO, & o gate ficou VERDE

**Entregue:** `NuminaFree`×5 → `HedgePicker` & `PsychicFree`×5 → `PsychicPicker`; os 2 `<template>`
apagados; `NUMINA_FREE_ROWS` & `PSYCHIC_FREE_ROWS` a **0** (≡ §T873 fez c/ as 3 do Ghoul ∴
`TYPED_ROW_FROM` segue DERIVADA & `isTypedRow` responde ⊥ p/ as 2 famílias, sem caso especial).
§V378(a) fecha **8** dos 9. **Diff de campos EXPANDIDOS: 0 perdido.**

⚠ **`HedgeRitualFree` ⊥ CONVERTEU, & é §B122.** A diferença ⊥ é de layout, é de SENTIDO: ritual
PESCADO tem o nível no prefixo `"<n>. "` do livro ∴ `HedgeRitualPicker` desenha os dots como ARTE
(⊥ `field`, ⊥ `onClick`, `opacity 0.40`, §V269a); ritual CASEIRO ⊥ tem prefixo ∴ os dots DELE
**são** o nível (§V269b §V269d). A conversão apagou **25** campos c/ dado (`hedgeRitual_13_1`…
`_17_5`) & o **gate ficou VERDE**.

**POR QUE §V362 ⊥ viu, & a mutação AFINA isto:** o caso 05 (tirar `<PsychicPicker
field="psychic_23"/>`) **ACENDE** §V362 ∴ ela ENXERGA o `field=` da INSTÂNCIA. O que ela ⊥ enxerga
é o nome INTERNO ao template (`$(field)_1` → `psychic_23_1`), porque `$FIELD_CONTRACT` exclui
placeholder `$(…)` de propósito. O buraco é EXATAMENTE esse, ⊥ "template" em geral.

**Recuperação, & vale guardar:** o `.lfm` de antes de §T875 saiu do **`.rpk` INSTALADO às 22:10**
(anterior à tarefa) — `.rpk` é ZIP & `[IO.Compression.ZipFile]` abre. ⊥ ∃ backup em git de rodada
⊥ commitada ∴ o INSTALADO é o único retrato do estado anterior.

**A §T que fecha o 9º ! ESCOLHER** (∈ a linha de §T875): (i) dots ligados no picker — §V269a proíbe
2º dono do nível · (ii) `hedgeRitualLevel` conta dots quando ⊥ ∃ prefixo · (iii) a família fica c/
linha livre p/ sempre & §V378(a) fecha em 8, c/ exceção NOMEADA. **RECOMENDAÇÃO: (ii).**

⚠ **REGRA enquanto §V362 ⊥ souber expandir: ∀ troca de `<template>` ! ser precedida do DIFF de
campos EXPANDIDOS.** Vale p/ **§T876** (onda 5), que mexe em template de 3 arquivos.

**Mutação:** 8 casos + sonda — todos vermelhos na régua certa, sonda verde.

---

## ⚠ §T831 — ENTREGUE DE FATO, & a §T pede 1 campo que ⊥ DEVE NASCER. **⊥ buildar sem `/ck:spec`**

A 162ª foi construí-la (é a única `.` que §T830 desbloqueou sem pedir spec) & PAROU antes de tocar
em código. **MEDIDO em `b5111c35`**, a caixa `TRUE FAITH` de `tabFaith` já era, dentro dela:

```
label 'Religion' (l=0 w=95) · edit field="faith" (l=100 w=300) · faith_1…_5 (l=425…541)
```

∴ **`faith` SEMPRE foi o nome da religião.** A 161ª migrou a linha FIELMENTE p/ a caixa nova
(mesmo rótulo, mesmo campo, mesmos 5 dots, agora em `l=145 w=90` / dots `245…386`) & o `?`
(`btnQFaith`) entrou em §T874 c/ a chave `'True Faith'` LITERAL. **⊥ sobra trabalho de layout.**

**O erro está na PROSA de §I117 (pedido 4.4)**, que manda: *"campo p/ o NOME DA RELIGIÃO = **NOVO**
(`faithReligion`), ⊥ é rename ∴ §V2 intacta"*. As 3 afirmações caem:

| a prosa diz | o que a medida diz |
|---|---|
| o campo é NOVO | ∃ desde antes de `b5111c35`, & chama `faith` |
| ⊥ é rename | **É** rename — `faith` ∈ `$FIELD_CONTRACT` c/ dado salvo em ∀ ficha |
| §V2 intacta | §V2 é EXATAMENTE o que isto aciona; & 2 campos p/ 1 valor é §V135 |

**A RAIZ, & é o que ⊥ pode ser esquecido:** §I117 leu `faith` como se fosse o **picker do Path**,
sobrando a religião p/ um campo novo. **§T874 já mediu que ⊥ é**: True Faith é **1 Path só** ∴ o
`?` ganhou chave LITERAL & `row = nil` (⊥ ∃ linha, ⊥ ∃ lista). ⊥ sobra do que `faith` ser picker.

**RECOMENDAÇÃO p/ `/ck:spec`:** emendar §I117 pedido 4.4 — o campo da religião **já ∃ & chama
`faith`**; `faithReligion` ⊥ nasce; §T831 fecha `x` como ENTREGUE por §T830+§T874, c/ a nota de
que a migração é a de §V35 & ⊥ 1 campo novo. Se o user QUISER `faithReligion` mesmo assim, o preço
é 1 linha de §I3 (ÓRFÃO ou APAGADO p/ `faith`) + §V362(d) subindo de 4 p/ 5 c/ §Q nova — que é
caro p/ 1 rename que ⊥ muda nada na tela.

⚠ **É o espelho do que a 159ª achou**: lá uma §T "lia como PRONTA" sem estar (§T846/§B105); aqui
uma §T lê como PENDENTE estando pronta. Os 2 defeitos vêm da mesma porta — prosa de §I escrita
antes da medida, & a cura é a mesma: MEDIR o `b5111c35` antes de acreditar na linha.
---

## A PERGUNTA ABERTA — a METADE B de §T874: `cboHedgeAffiliation`

**⊥ virou picker.** §I131c o põe na onda 4 & a linha de §T874 o nomeia — mas a linha NUNCA
precificou o que ele arrasta, & o que ele arrasta são §V com prosa EXPLÍCITA que só `/ck:spec`
pode reescrever:

| § | o que a prosa diz | o que a conversão faria |
|---|---|---|
| §V270(a) | ∃ EXATAMENTE **1** `comboBox` c/ `field="hedgeAffiliation"`, de nome `cboHedgeAffiliation` | ∄ combo nenhum |
| §V270(d) | o nome do controle & a chave casam pela conta de `fieldRoot` (tira `cbo`) | o nome vira `dyn*` & a chave sai do argumento de `mfOpen` |
| §V274(b) | o PAR `cboHedgeAffiliation`+`edtHedgeAffiliation` ∈ ESPELHOS de §I3 (§V36) | sobra **1** widget no `field` ∴ o espelho fica c/ 1 membro |
| §V274(c) | o `cbo*` nasce SEM `visible=` | quem nasce sem `visible=` é o `<button>` |
| §V274(d) | `renderManualEntry` escreve `visible`+`enabled` p/ os **4** controles, NOMEADOS | 1 dos 4 troca de nome |
| — | + 2 rosters no gate: o grid de §V297 & a tabela de larguras (`'cboHedgeAffiliation' = 360`) | |

⊥ ∃ código dependendo de ele ser picker: o filtro lê `sheet.hedgeAffiliation`, ⊥ o widget.

**RECOMENDAÇÃO:** agora que §T830 passou, a geometria da aba Numina está ESTÁVEL & a objeção que
me fez adiar ("régua escrita contra desenho que morre na rodada seguinte") **caiu**. ∴ o caminho
é: **`/ck:spec`** emenda as 5 pernas + §I3 ESPELHOS + §I117c (↑) numa passada só, & depois
**`/ck:build §T874`** fecha a metade B. Mas §T830 vem PRIMEIRO — ela já está construída & falta
só a régua, & deixá-la `~` mais uma rodada é o tipo de linha que a 159ª descobriu que "lia como
PRONTA" sem estar.

---

### DEPOIS — o arco que sobra

**§T875** tira as **15** linhas livres da onda 4 (`NuminaFree`×5 · `PsychicFree`×5 ·
`HedgeRitualFree`×5) & fecha os **9** nomes de §V378(a) ∴ a perna passa a valer INTEIRA; é ela que
aposenta §V255 & que deixa §V382(d) tirar `isTypedRow` de `pickRefusal`. **§T876** é a onda 5
(`cboRoad` · `cboClanFamily`).

---

## HISTÓRICO — a 160ª e anteriores

### O QUE A 160ª FEZ

| §T | entrega |
|---|---|
| §T879 | `MAIN_PATH_ROWS` **5 → 4** · sai `mainPath_5` (ÓRFÃO de §I3, no gate) · `MAIN PATHS` `height` **186 → 161** · `SECONDARY PATHS` `top` **211 → 186** · 3 `dataLink` limpos ∴ col.2 fecha em **637** |
| §T880 | rituais **20 → 22 desenhados**, os 2 novos são `ritual_26`/`_27` · `RITUAL_ROWS` **20 → 27** (MAIOR ÍNDICE) · nasce **`RITUAL_VACANT`** · `RITUALS` `height` **561 → 617**, pé **26** ∴ col.3 fecha em **637** · §V204 aprendeu o buraco (2 pernas novas, 4 mutações) |
| §T881 | **§V280(d)**: as 3 colunas do Ghoul fecham numa ÚNICA linha ∴ o pé deixa de ser livre. RELAÇÃO, ⊥ lista de literais. 2 mutações |

### ⚠ AS 2 COISAS QUE O HANDOFF DA 159ª ERRAVA — as 2 achadas ao construir, & ∈ SPEC como **§B117** & **§B118**

1. **A nota (3) de §T880 quebrava as 2 linhas novas.** Ela mandava o limite dos laços virar
   `constante − vagos` = **22**. Mas o limite é ÍNDICE, ⊥ contagem: `for i = 1, 22` NUNCA
   alcança `ritual_26`/`_27` ∴ as 2 linhas que a §T autora nasceriam sem pintor, que é §B112
   em letra. O certo: limite fica em **27** (maior índice) & o buraco é PULADO dentro do laço.
   §V263(b) já tinha escrito a distinção — "quem deriva contagem tira os vagos, quem deriva
   índice ⊥".
2. **∃ uma 4ª armadilha, ⊥ listada, & é a ÚNICA com dano real.** `sortRituals` **lê & escreve**
   `sheet["ritual_" .. i]` na faixa inteira. Sem guarda, com o limite em 27, ele puxaria os
   valores mortos de `ritual_21`…`_25` de ficha pré-85ª **p/ dentro das linhas visíveis** &
   escreveria por cima dos nomes queimados — CALADO nos 2 sentidos. É por isso que
   `RITUAL_VACANT` é CONJUNTO & ⊥ número: contagem ⊥ diz QUAL índice falta.
   (`renderRitualButtons` é inofensivo — `mfLabel` sai em `ctrl == nil` — mas foi guardado
   igual, p/ os 2 laços lerem parecido.)

### A DÍVIDA DE SPEC — PAGA na mesma data. O que a spec DECIDIU, & ⊥ perguntar de novo

| § | estava | ficou |
|---|---|---|
| §I3 órfãos | **17** no SPEC · **26** no gate | **27**, & é **1 conjunto só**. ⚠ **a leitura de "2 leitores" era ERRADA & foi medida**: `xpLog` ⊥ tem `field=` hoje (as 3 ocorrências são 1 comentário & os CONTROLES `xpLogBox`/`xpLogScroll`) mas o bloco da 27ª TINHA campo ∴ é órfão pelo mesmo teste & **entra** (§T882). O que divide de verdade é **QUANDO o nome saiu vs. o congelamento em `b5111c35`**: **4** depois (∈ contrato, §V362(b) cobra 1 a 1) · **23** antes (∄ contrato, §V362(b) NUNCA os visita). Nome extra na lista ⊥ é risco: (b) só a lê como teste de pertinência p/ nome do contrato |
| §V333(g) | **93** | **105**, & o achado ⊥ é o número: **3º atraso seguido** desta perna (28 → 45 → 93), cada um corrigido 1 rodada depois de deixar de valer. Os 93 nasceram 11 atrás — foram escritos no MESMO dia de §T873 |
| §V280 | **3** pernas | **4**. Entra **(d)**, o pé como RELAÇÃO. & **(b) SAI**: era de §V298 desde a 107ª & esta linha nunca disse ∴ o "20 de vão" escrito nela estava errado há 50+ rodadas |
| §V204 | "falta LIGAR" | LIGADA, c/ **2** pernas a mais do que a emenda previa — `<FAMÍLIA>_VACANT` ≡ o buraco do XML, & ∀ laço que anda a família por índice consulta ela |
| §V383 | — | **buraco de escopo** achado: (b) promete "∀ laço que pinta" & lê só a raiz ∴ **3** pintores sem régua (§T883) |

---

### AS 3 DECISÕES DO USER 2026-09-01 — já ∈ `SPEC.md` §C, ⊥ perguntar de novo

1. **`MAIN_PATH_ROWS` 5 → 4**, tomada de olho no custo: §V181 dá ≤1 main path por feitiçaria &
   `BLOOD_SORCERY` tem **6** ∴ a ficha vai de 1 p/ **2** slots curta. Ele confirmou assim mesmo.
2. **Rituais 20 → 22 DESENHADOS, pé 26**, aceitando um **3º** valor de pé na ficha (20·26·35)
   em troca das 3 colunas do Ghoul fechando EXATO em **637**.
3. **Os pés 20/35 das outras caixas FICAM.** Normalizar refaz a conta das colunas no meio da
   rodada ∴ adiado p/ §T881, isolado.

O porquê da geometria está em **§I118f** (medido do XML, ⊥ dos comentários, que mentem):
`h = 41 + 25·N + pé`. Coluna de 2 caixas fecha em `107 + 25(T+B) + pé₁ + pé₂`, de 1 caixa em
`61 + 25R + pé₃` ∴ c/ ∀ pé = 20 os restos mod 25 são **22** & **6** & elas NUNCA se encontram.
⊥ re-derivar: crescer linhas ⊥ muda o resto, só o pé muda.

---

### §T879 · §T880 · §T881 — as 3 receitas SAÍRAM daqui, & de propósito

As 3 estão `x` & instaladas. As receitas linha-a-linha que moravam aqui foram APAGADAS em vez de
marcadas: 2 delas estavam ERRADAS (↑ "AS 2 COISAS QUE O HANDOFF DA 159ª ERRAVA") & receita errada
de §T fechada é pior que receita nenhuma — a próxima sessão a leria como estado. O que sobrevive
delas está ↑ em "O QUE A 160ª FEZ" & na "DÍVIDA DE SPEC", que é o que ainda tem trabalho dentro.

---

### DEPOIS DAS 3 — o arco que sobra

**§T874** (onda 4 de §I113e: `HedgePicker` · `PsychicPicker` · `HedgeRitualPicker` +
`cboHedgeAffiliation`) destrava **§T830** (Numina em 3 colunas), & §T830 paga **3 dívidas de
régua já escritas nas linhas dela**: **§V361 INTEIRA** · **§V362(c)(d)** · & a devolução do
roster das 3 colunas do Ghoul, hoje EMPRESTADO em §V188. **§T875** fecha os 9 nomes de §V378(a)
& aposenta §V255.

---

## O QUE A 159ª FEZ

| §T | entrega |
|---|---|
| §T872 | onda 3 de §I113e FECHADA: as 41 réguas ligadas · **2 lacunas de CÓDIGO** que a 158ª deu por prontas (↓) · **20** §V emendadas ou aposentadas · **§B114** & **§B115** |
| §T873 | as **11** linhas livres saem: `DiscFreeRow`×3 · `SecPathFreeRow`×3 · `RitualFreeRow`×5 → picker. Os 3 `<template>` APAGADOS · `DISC_FREE_ROWS` `SEC_PATH_FREE_ROWS` `RITUAL_FREE_ROWS` → **0** (ficam declaradas, ≡ §T870) · **0** campo renomeado |
| — | **§B116** & a perna nova de §V204 (fora da fila de §T, pedida pelo user no fim da rodada): o gate deixava passar índice de linha fora de `1..N`. Ver ↓ |
| §T834 | **§V362** no gate, c/ `$FIELD_CONTRACT` — os **325** `field=` congelados em `b5111c35`. ⚠ **§V361 SAIU desta §T** & foi p/ §T830 INTEIRA (↓). Mutação 4/4 |
| §T832 | **aba Ghoul SEM sub-abas**: `vampStrip` APAGADA · os 3 `<import>` lado a lado em `left` **0 / 395 / 965**, `width` **390 / 565 / 520**, `top=150`, TODOS visíveis & SEM `name` · `SUB_TABS` **3 → 2** grupos · **0** caixa redesenhada, ≡ §I118d promete. **17** literais de barra + **10** rosters de barra no gate, & **3** réguas de JULGAMENTO (↓) |

### §T834 — §V362 ENTROU & PAGOU no 1º disparo; §V361 ⊥ entrou, & o porquê é medida

**§V362 (a)(b)(e)**, & a chave é COMO o "ANTES" passa a ∃: um check estático ⊥ tem antes p/
ler, ∴ ele é **CONGELADO**. `$FIELD_CONTRACT` = os **325** `field=` autorados em `b5111c35` (o
último commit limpo, ANTES da onda 3 & de §T832), lidos do **XML PARSEADO** ≡ o gate lê.
Congelado num commit ANTERIOR & ⊥ no estado de hoje **de propósito**: congelado em cima de hoje
ele ⊥ poderia acender por nada que já aconteceu — arma o futuro & ⊥ certifica o passado.

⚠ **Ela pagou na 1ª execução**: `discSel` `pathSel` `ritualSel` sumiram em §T872 & ⊥ ∃iam em
lista nenhuma de §I3. Entraram como **ÓRFÃO** (o dado FICA no NDB; só o widget saiu). Fora esses
3, **nenhum** campo se perdeu em 3 rodadas de layout — 325 → 322, & os 3 são exatamente a
decisão B do user.

⚠ **ARMADILHA MEDIDA — os 2 lados de um teste de subconjunto ! ser lidos do MESMO jeito.** A 1ª
tentativa comparou o contrato contra `$allFields` (o censo que §V1 monta) & deu **~200 FAIL** de
campos que estavam ali na frente: `$allFields` chaveia algumas famílias diferente. Régua que
compara 2 leitores em vez de 2 estados. O bloco monta o censo DELE, c/ o mesmo XPath.

⚠ **§V361 ⊥ entrou, & ⊥ por metade nenhuma.** Tentei armar a metade Ghoul & as 4 pernas caíram,
cada uma por motivo DIFERENTE: **(a)** o que ela mediria já é medido por §V188 desde §T832 → 2
donos p/ 1 régua (§B70), & o resto de (a) ("o box de topo ⊥ se MOVE") pede geometria congelada
≡ §V362 pediu p/ campo · **(b)** é a versão POR ABA do que §V362(a) mede na ficha inteira, & a
própria §V362(a) diz que por aba **acende falso** → perna ABSORVIDA, ⊥ perna a construir ·
**(c)** sem sujeito (a força de vontade ⊥ saiu da Numina, 17 leituras) · **(d)** é
intrinsecamente de DUAS abas. Vai INTEIRA p/ §T830, c/ as 2 abas na mesa.

### §T832 — as 3 réguas que pediam JULGAMENTO, & o que virou de cada uma

- **§V188**: a metade das SUB-ABAS troca de sujeito (3 panes empilhadas c/ título → 3 colunas
  visíveis, 1 `<import>` cada, **0** `visible="false"`, **0** `name`); a metade do `tabControl`
  nativo ⊥ é tocada. ⚠ o roster das 3 colunas fica AQUI **emprestado** — quem herda é §V361(a),
  & ela só entra em **§T834** ∴ apagar antes deixa as colunas sem régua por 1 §T inteira.
- **§V221**: REESCRITA, & é a reescrita que §I118e encomendou — de "painéis EMPILHADOS numa
  rect" p/ **colunas DISJUNTAS em x**. 4 pernas: ⊥ ∃ barra · as 3 abrem no MESMO `top` ≥ 138 ·
  `left`+`width` de cada ≤ `left` da seguinte, c/ vão **5** · largura da coluna ≡ a que o form
  DELA declara. ⚠ sem isto, **3 colunas SOBREPOSTAS passariam VERDES**: painel é isento de §V40
  por §V262(d), justamente porque panes empilhadas PODIAM dividir 1 retângulo.
- **§V225**: (a) passa a medir ∀ import contra o `<layout>` **DELE**, ⊥ contra o 1º da aba —
  empilhadas, o 1º servia p/ as 3; lado a lado, isso reprovaria as colunas 2 & 3. **(b) ⊥ VOLTA**,
  & é correção do que eu mesmo escrevi 1h antes: a promessa era "as 3 colunas & a `BLOOD POOL`
  fecham no mesmo x" & MEDIDO elas fecham em **390 / 960 / 1485** contra **1070** — ⊥ ∃ desenho
  que as concilie, porque as 3 larguras são diferentes DE PROPÓSITO. Régua impossível ⊥ é dívida,
  é §B106 marcado p/ o futuro. O que (b) comprava migrou INTEIRO p/ §V221(3)+(4).

### ⚠ AS 2 LACUNAS DE CÓDIGO QUE O HANDOFF DA 158ª NEGAVA — as 2 CORRIGIDAS

O bloco anterior dizia "**Nada de código a refazer**". Estava errado nos 2 pontos, & nenhum
dos 2 dava FAIL — as réguas dos 2 apontavam p/ o lado de onde o sujeito tinha ACABADO de sair.

1. **§B114 — o FILTRO ⊥ andou junto.** `mfOpen` montava `MF.pool` DIRETO de `PICKER_LIST` ∴
   trilha / trilha secundária / ritual passaram a oferecer **TUDO** & `guardPick` reverteria
   no clique seguinte. Cura: `discLevels()` + `hedgePathLevels()` **1×** por abertura, FORA do
   laço, & `pickAllowed(MF.field, vals[i], levels, hedge)` DENTRO dele. §V205 aponta p/ lá.
2. **§B115 — o `pickEra` foi embora c/ as panes.** `descText` fazia `ent[lang] or ent.en` &
   mais nada ∴ o `?` mostraria o corpo do NÚCLEO em Dark Ages. ⊥ deu FAIL porque ⊥ ∃
   `daEn`/`daPt` em disco AINDA (**0** ocorrência nos 14 `desc*.lua`). Cura: a época mora
   INLINE em `descText` (⊥ local novo — o form raiz tem 50 locais contra os 53 do rdk, §B93).

### AS 20 §V QUE MUDARAM — todas ∈ `SPEC.md`, ⊥ reabrir

- **APOSENTADAS** (sujeito ⊥ ∃): §V176 (os 3 radios) · §V193 (a relação c/ a coluna) ·
  §V207 (absorvida por §V205) · §V249 & §V250 (donos novos: §V266 & §V365f) · §V252**(d)** ·
  §V225**(b)** — esta VOLTA em §T832.
- **REAPONTADAS**: §V175 (`renderClanDiscLock` → `clanDiscOpen()` + recusa em `mfOpen`) ·
  §V178 (`items=` → o botão `dyn*`) · §V192 (`pickEra` → `descText`) · §V194
  (`//comboBox` → `PICKER_LIST` nas 5 raízes) · §V203 & §V205 (→ `mfOpen`).
- **SÓ NÚMERO**: §V111 (9→6 panes, 17→15 combo) · §V196 & §V241 (17→15) · §V280 & §V298
  (73→70) · §V333 (45→**104**) · §V354 (4 ondas novas) · §V255 (roster 6→**3**).

### MUTAÇÃO — 39 rodadas, 39 VERMELHAS (§V20, §V222)

§V175 ×3 · §V176 · §V178 · §V192 ×2 · §V193 · §V203/§V207 · §V205 ×3 · §V249 · §V252 ·
§V354(i) · §V354(e) ×2 · §V378(a) · §V255 · §V248 · §V333 · §V204 ×5 (a perna nova) ·
**§V221 ×5** (sobreposição · largura · barra de volta · tops discordando · vão) ·
**§V188 ×2** (coluna escondida · `name` sobrevivendo ao leitor) · **§V225(a)** no eixo Y ·
**§V362 ×4** (campo somindo · órfão fora da lista · teto dos apagados · contrato editado).

⚠ As **17** contagens de barra (19→16 · 4→3 · 5→3 · 8→5 · 24→19 · 3→2 grupos) ⊥ pediram
mutação SEPARADA: elas foram OBSERVADAS vermelhas na passada de **25 FAIL** logo depois do
código de §T832, ANTES de eu tocar em qualquer uma. Verde-depois-de-vermelho-observado é
prova mais forte que mutação, porque o vermelho veio do mundo & ⊥ de um teste que eu escrevi.

---

## ✅ BUILD & INSTALL — FEITOS & provados (§B1, §B103)

`rdk -l` ×3, cada um provado por mtime **&** size:
`2.605.628` → `2.607.433` (§T872) → `2.611.387` (§T873) → **`2.609.043`** (§T832, ENCOLHEU —
o `vampStrip` saiu); mtime 20:59 → 22:36 → 22:46 → 23:36.

`rdk -i` ×2, **1 por rodada & no fim** (§B103), c/ o user confirmando a ficha FECHADA nas 2:
22:51:24 (o `.rpk` de §T873) & **01/09 09:53:14** (o de §T832, **2.609.045 B**, mesmo size do
`output/`). ⚠ **PERGUNTEI DE NOVO na 2ª**: autorização ⊥ é retroativa & o user pôde ter aberto
a ficha no meio.

⚠ §T834 é rodada de **RÉGUA**: depois do install só `SPEC.md` & o gate mudaram ∴ ⊥ ∃ build a
refazer. Os `.lfm` de `WoD20.1`/`.2`/`.7`/`.13` têm mtime mais NOVO que o `.rpk` porque a
mutação os reescreveu & restaurou — `git diff` neles é VAZIO, conferido.

---

## ⛔ TESTE DE TELA — só o user roda, & agora são 5

0. **§T832, a aba Ghoul INTEIRA (o mais visível da rodada)**: ⊥ ∃ mais a barrinha de sub-abas
   `Disciplines` / `Blood Sorcery: Paths` / `Blood Sorcery: Rituals`. As **3** listas aparecem
   LADO A LADO de uma vez, fechando em `x=1485` dentro da ficha de `1680`, & **⊥ ∃ barra de
   rolagem horizontal**. As caixas de cima (`660` + `405`) ficam onde estavam & ⊥ acompanham a
   largura nova — é assim de propósito (§I118d), mas é a 1ª vez que alguém vê.

Nada disto tem check estático. Fazer c/ a ficha REABERTA depois do install (§B103).

1. **Aba Ghoul**: disciplina · trilha · trilha secundária · ritual abrem a **caixa de busca**.
2. O **`?`** de cada uma mostra a descrição, & o `-- Custom --` aceita nome digitado
   **sem ser revertido** (é o que §T877 comprou, & a onda 3 é a 1ª família FILTRADA a usá-lo).
3. **O FILTRO NOVO (§B114)**: numa ficha SEM feitiçaria de sangue, a lista de ritual / trilha
   ! abrir **CURTA** (só o que a ficha alcança), ⊥ com os 284 rituais. Numa ficha COM, ! crescer
   conforme a disciplina sobe. **Este é o teste mais importante da rodada** — é código novo que
   gate nenhum observa rodando.
4. As **11** linhas que eram digitadas (`disc_13`…`_15` · `secPath_13`…`_15` ·
   `ritual_16`…`_20`) agora são picker & **mantêm o valor** que já tinham.

---

## ✅ §B116 — o buraco que a mutação achou, & que o user mandou fechar NA HORA

MEDIDO por mutação nesta rodada: trocar `<DiscRow field="disc_15"/>` por
`<DiscRow field="disc_99"/>` saía **VERDE no gate inteiro** (0 FAIL). §V204 comparava a
CONTAGEM c/ a constante & 15 seguiam 15; ⊥ ∃ia régua exigindo que os índices fossem **1..N**.
Linha fora da faixa é campo que leitor NENHUM alcança (`declareTrait` & o ledger andam
`1..CONST`) ∴ bolinha que ⊥ custa XP, ⊥ entra no log & guarda o que o jogador escrever.

**FECHADO nesta rodada** (user aprovou): §V204 ganhou a perna `{índices desenhados} == {1..CONST}`
sobre o roster que a contagem já varre (as 5 do vampiro + `SPECIALITY_ROWS` + `BACKGROUND_ROWS`,
picker & digitada juntas). **§B116** registra o achado. Mutação **5/5 VERMELHAS**: índice acima
da faixa · índice `0` · índice repetido · `num=` da especialidade · `background_` fora da faixa.

⚠ A lição do §B116 é do FORMATO da régua & vale p/ o gate INTEIRO: **régua que compara TAMANHO
de conjunto ⊥ vê troca DENTRO do conjunto.** E o achado veio de uma mutação que ERROU o alvo —
queria testar §V354(e), que conta LINHAS, & mexeu no ÍNDICE. **Mutação que sai VERDE ! ser LIDA
antes de ser corrigida**: o verde inesperado é onde mora o buraco.

---

## ARMADILHAS DE FERRAMENTA — as 3 da 158ª SEGUEM VALENDO, & 3 novas

1. **`sed -i` mata CRLF** (§B74) — splice PowerShell (`ReadAllText` → `WriteAllText` c/
   `UTF8Encoding($false)`). O `file` é o indicador confiável; `grep -c` de CR & `cat -A` do
   Git Bash comem CR & MENTEM. ⚠ **o `Edit` do Claude Code PRESERVA CRLF** — medido nos 5
   arquivos desta rodada. É a ferramenta certa p/ edição pontual; o splice fica p/ lote.
2. **`.ps1` sem BOM é lido como ANSI** ∴ literal c/ acento chega corrompido & `.Contains()`
   falha SEM erro. `printf` do BOM antes do `cat >>`.
3. **PowerShell ⊥ distingue maiúscula em variável**: `$T` & `$t` são a MESMA. Usar `$TAB`.
4. ⚠ **NOVA — here-string `@"…"@` escrita por heredoc do bash nasce c/ LF** & ⊥ casa arquivo
   CRLF: âncora de várias linhas ⊥ é encontrada & o script diz "0 hits" CALADO. Usar regex c/
   `\r\n` explícito, ⊥ here-string literal.
5. ⚠ **NOVA — régua que lê PROSA como código.** 3 arquivos EXPLICAM em comentário por que
   `renderVampPickers` saiu; o check novo achou o NOME nos comentários & reprovou o próprio
   bilhete que documentava o conserto. Usar `CodeOf` (tira `<!-- -->` & linhas `--`), ⊥ os
   bytes crus. ≡ a lição de §B60.

6. ⚠ **NOVA, & foi o gate que a pegou — `[char]0xNNNN + 'texto'` em PowerShell mete CR solto.**
   Montei o `⚠` das 14 emendas de §T832 como `[char]0x26A0 + ' **EMENDADA…'`: a cauda da string
   SUMIU (sobrou só o `⚠` colado na palavra seguinte) & entrou **1 `\r` órfão** por emenda —
   14 CR sem LF, dentro da linha. `file` seguiu dizendo "CRLF", `git diff` ⊥ mostrou nada &
   o gate acendeu: **§V318**, `SPEC.md carries 3785 CR against 3771 LF`. Foi o ÚNICO aviso.
   Receita: montar string acentuada como **`[string][char]0xNNNN`** (o cast explícito p/ string
   ANTES do `+`), & conferir CR≡LF depois de ∀ script que reescreve arquivo. É §B74 por uma
   porta nova — lá o `sed -i` COMIA CR, aqui o PowerShell ACRESCENTA.

Bônus que continua valendo: comentário inserido no gate ! terminar em quebra de linha, & o
gate é **ASCII puro sem BOM** — manter adições em ASCII.

---

## GIT — nada commitado, & é assim de propósito (`CLAUDE.md`)

**11** arquivos no working tree, desta rodada & da 158ª:

    HANDOFF.md · SPEC.md · verify-hunters-hunted.ps1
    WoD20th/WoD20.11.lfm · WoD20.12.lfm · WoD20.13.lfm · WoD20.14.lfm · WoD20.6.lfm · WoD20th.lfm
    localization.lang · output/*.rpk

Último commit limpo: **`b5111c35`** (gate 636/0, ANTES da onda 3). Voltar tudo:

    git checkout -- "Plugins/Sheets/World of Darkness 20th Anniversary Edition" SPEC.md verify-hunters-hunted.ps1

⊥ fazer isso sem o user pedir: perde a onda 3 inteira, as 20 réguas & os 2 §B.

---

## 158ª RODADA (2026-08-31) — SUPERADA. Ela parou NO MEIO do §T872 & a 159ª fechou. Guardada só pelo que ela MEDIU

⚠ **O bloco dela dizia "nada de código a refazer" & isso era FALSO** — faltavam as 2 lacunas
que viraram §B114 & §B115 acima. ⊥ confiar em "o código está pronto e COMPILA" como prova:
compilar ⊥ é a mesma coisa que a regra estar ligada.

O que ela mediu & continua valendo:

- **A decisão B do user (2026-08-31)**: o `?` ocupa o `0..20` que era do `radioButton` ∴ ⊥ ∃
  deslocamento de geometria; somem `discSel` `pathSel` `ritualSel` & a MARCA de linha.
  **⊥ reabrir.**
- ⚠ **`MainPathRow` & `SecPathRow` tinham a linha de `<comboBox>` BYTE A BYTE idêntica**: um
  `.Replace()` textual converte as 2 & a 2ª fica abrindo a lista da PRIMEIRA (aconteceu na
  157ª). Editar por ESCOPO de `<template>`. Já registrado em §V354.
- **O nome do módulo é o do ARQUIVO** (`descText` monta `desc<Mod>_<lang>.lua`): `Disc`
  `Path` `Ritual` — **⊥ `Discipline`**.
- **§V365(d)**: arquivo c/ picker convertido ⊥ pode ter `<textEditor name="edt*Desc">` ∴ a
  pane sai na rodada em que a família DELA ganha o `?`. Foi o que a onda 3 fez.

---

## 157ª RODADA (2026-08-31) — SUPERADA pelo bloco da 158ª acima. A emenda que ela pedia FOI APLICADA (os 11 pontos estao no SPEC.md). Guardada pelas medidas da onda 3 e pelas armadilhas

**Estado:** gate **VERDE 632 ok / 0 FAIL** · §T **760 `x` · 104 `.` · 12 `~`** · `.rpk` **2.629.044 B**
instalado 12:58 (Firecast FECHADO no install ∴ ⊥ ∃ risco de §B103 desta vez) · **tudo commitado**
em `8cc288be`, working tree LIMPO (só `.claude/` untracked).

### ▶ O QUE FAZER: **`/ck:spec amend`**, ⊥ `/ck:build`. O texto está pronto ↓ na seção "O COMANDO"

⛔ **⊥ rodar `/ck:build` antes da emenda.** A 157ª deixou **11 pontos** em que o `SPEC.md` está
ATRÁS do código ou simplesmente ERRADO, & 3 deles fariam o build trabalhar contra fato falso:
§I113c diz que o filtro do picker é "um programa" (é 8 linhas, MEDIDO), §I117c diz que §Q32 está
aberta (foi respondida em 2026-08-30) & §I118d se CONTRADIZ. Buildar §T830/§T832 com essas 3
como estão é reconstruir o que a 157ª já mediu.

---

### O QUE A 157ª FEZ — **§T862…§T871**, os pedidos 1-10, 12 & 13

| §T | entrega |
|---|---|
| §T862 | Main vira grade de **5 faixas**: `SPECIALTIES` sai da fileira de baixo p/ `1350..1680` y`120..556` & vira a 4ª caixa do grid · `ROAD` ocupa a coluna vaga (`680..1010`, `top=561`) ao lado de `VIRTUES` · avatar `340×457` · fundo `891`→**888** · aba `1345`→**1680** · `popScrim` junto |
| §T863 | `EXPERIENCE` da Main recebe a forma da Progress: **3** números, geometria VERBATIM `+32` em x, **4** nomes de controle novos & **0** campo NDB |
| §T864 | `WILLPOWER` `99`→`104` (vão 5→10) · par `ROAD` centrado por idioma via `ROAD_LABEL_W = {en=26, pt=46}` |
| §T865/§T866 | **§V375** & **§V376** no gate (SUPERSEDEM §V168 & §V69) · **§V380**. Mutação 4/4 & 4/4 |
| §T867 | **§B111** consertado — `descFieldOf` alcança os 28 slots que perdia. **§V377**, mutação 2/2 |
| §T868 | **`-- Custom --`** inteiro: linha fixa, 2 campos derivados por slot, `descFor` leitor único |
| §T869 | **§V379** & **§V381**, mutação 5/5 |
| §T870 | **16** linhas livres viram picker & **3** templates saem (`MeritFree` `OpenAbilityFreeRow` `SpecialityFreeRow`). **0** campo renomeado |
| §T871 | **§V378**, mutação 3/3 |

**Decisões do user 2026-08-31, já ∈ `SPEC.md` §C — ⊥ perguntar de novo:** §Q39 `book_`/`type_`/
`costy_` TRAVAM · §Q40 o reflow SEGUE · §Q41 `VIRTUES` == `ROAD` == `330×327` · §Q42 as chaves
[pt] · §Q43 a 11ª especialidade ⊥ entra.

---

### ⚠ AS 2 TENTATIVAS QUE FORAM REVERTIDAS, & o que elas MEDIRAM

Nenhuma das duas está no disco. O valor delas é a MEDIDA — ⊥ re-derivar.

**(1) Onda 3 de §I113e (§T872) — revertida.** O que ela mediu:
- **§I113c está ERRADO.** O filtro ⊥ é "o programa": `pickAllowed(MF.field, vals[i], levels, hedge)`
  dentro do laço do pool em `mfOpen`, c/ `discLevels()` & `hedgePathLevels()` lidos **1×** por
  abertura = **8** linhas. Chegou a funcionar.
- **O bloqueio real é §V365(d)**: arquivo c/ picker convertido ⊥ pode ter `<textEditor name="edt*Desc">`,
  & as 3 abas têm. ∴ a onda 3 ⊥ fecha antes de §T832.
- **O nome do módulo é o do ARQUIVO**: `descText` monta `desc<kind>_<lang>.lua` ∴ `Disc` `Path`
  `Ritual` `Numina` — **⊥ `Discipline`**. Os 4 módulos JÁ ∃ em disco.
- ⚠ **ARMADILHA MEDIDA**: `MainPathRow` & `SecPathRow` têm a linha de `comboBox` **IDÊNTICA**.
  Um replace textual converte os 2 & o segundo fica abrindo a lista do PRIMEIRO. Aconteceu.
- As **9** réguas que a onda derruba: §V178 §V194 §V196 §V111 §V241 §V333 §V354(i) §V355(d) §V26.

**(2) §T832 (aba Ghoul sem sub-abas) — revertida.** O CÓDIGO saiu inteiro & CERTO:
- as 3 panes saem c/ `render*Desc` `save*Desc` `*Text` locais & os `dataLink` que só as
  alimentavam (**−3,2k −2,8k −3,8k** bytes) · `vampStrip` sai · os 3 `<import>` lado a lado em
  **0 / 395 / 965**, larguras **390 / 565 / 520** · aba **1070**→**1485** · `SUB_TABS` 3→2 grupos ·
  `DESC_PANES` 6→3 nomes. **Nenhuma caixa redesenhada**, ≡ §I118d promete.
- ⚠ **§T832 é uma rodada de GATE, ⊥ de layout**: o código são ~30min, as **~20 réguas** são o
  trabalho. Fui de 47 FAIL a 18 corrigindo contagens (**19→16** botões · **4→3** barras · **5→3**
  separadores · **73→70** caixas · **9→6** panes) & reescrevendo §V221 p/ medir colunas DISJUNTAS
  em x em vez de painéis empilhados.
- As **18** que sobraram pedem JULGAMENTO: §V188 §V192 §V193 §V225 §V249/§V250 §V299(b) §V307 §V320.
- ⚠ **ONDE EU ERREI, & é o motivo da reversão**: apontei §V249/§V250 p/ `edtHedgeDesc` da Numina
  supondo forma igual — **⊥ é**: `saveNuminaDesc` escreve `box.text`, ⊥ `form.<Edit>.text`. Régua
  ajustada no chute é §V20/§B7 ao pé da letra. Ao refazer: seguir o sujeito p/ a Numina é o
  caminho CERTO (≡ o que §V255 fez), mas medindo a forma DE LÁ.
- §V225 mede cada import contra o layout de `tabDisc` (390) & precisa do layout de CADA coluna.

---

### ⚠ TESTE DE TELA PENDENTE — nada disto tem check estático

O `.rpk` de 12:58 está instalado & o Firecast estava FECHADO ∴ abrir a ficha basta.

1. **Main, §T862**: `SPECIALTIES` à direita de `KNOWLEDGES` · `VIRTUES` & `ROAD` lado a lado ·
   a aba fecha em `y=888` & rola até `x=1680`.
2. **§T863**: `EXPERIENCE` da Main c/ **3** números (Total · Spent · Current), os 2 primeiros
   travados sobre fundo `#0A0A0A`, & batendo c/ a aba Progress.
3. **§T864**: o par `ROAD` centrado — **trocar o idioma** & conferir que segue centrado. Os
   `26`/`46` são TETO de §V312, ⊥ medida: se ficar torto, o número é este.
4. **§T868, o mais importante**: `-- Custom --` ponta a ponta — escolher, digitar Nome &
   descrição, OK · trocar o slot p/ outro valor · reabrir & marcar Custom **de novo** (tem de
   voltar o que foi digitado) · conferir que o `?` da linha mostra o texto custom.
5. **§T870**: as **16** linhas que eram digitáveis agora abrem picker (merits m7-m10 & f7-f10,
   backgrounds 17-21, especialidades 8-10).

---

### O COMANDO

Cole isto num chat NOVO, sem contexto:

    /ck:spec amend

E o texto da emenda está em `HANDOFF-SPEC-AMEND.md` na raiz — 11 pontos, cada um c/ o que está
escrito hoje & o que MEDIDO diz. Depois da emenda o caminho é `/ck:build --next`, que pega
§T830/§T832 já com §I117c & §I118d consertadas.

---

## 156ª RODADA (2026-08-31) — SUPERADA pelo bloco acima; guardada pelo piso da Main (§I125g) e por Q38

**Estado:** gate **VERDE 627 ok / 0 FAIL** · §T **750 `x` · 99 `.` · 12 `~`** · `.rpk` **2.612.410 B**
instalado 09:09 · **nada commitado** desde `15512560` (**10** modificados + **9** novos — contados 2026-08-31; o "9+8" que este bloco herdou da 154ª estava errado).
A 155ª rodada fez **§T861** (código) & a 156ª fechou **Q36a** + a **errata §I125g** (só SPEC —
nenhuma linha de código mudou depois do `.rpk` de 09:09 ∴ ⊥ precisa rebuildar).

### ▶ O QUE FAZER: **`/ck:build --next`.** ⊥ ∃ pergunta travando nada — leia Q38 antes de layout

**⊥ ∃ decisão pendente do user.** As 4 perguntas que a 155ª deixou estão todas resolvidas: **Q36a**
fechada por emenda (156ª), **Q35** ADIADA pelo próprio user em 2026-08-31 ("pode considerar
feito"), **Q36b** morta, **Q37** com recomendação de manter & sem sintoma. ∴ o caminho é
`/ck:build --next` — 99 §T `.` esperando.

⛔ **A aba Main está FECHADA p/ aperto — ⊥ aceitar pedido de encolher sem ler §I125g.** §T861 a
levou a `y=891` & a 156ª mediu que o piso real é **888**, posto pelo `HEALTH` (`561 + 327`, §V49),
⊥ pela corrente esquerda. Sobram **3px**, & abaixo de 888 o `HEALTH` ESTOURA sob a linha em vez de
ficar curto dela (§V69 troca de sinal). A saída que a 155ª recomendava (Q38 **b**, o ar interno de
`ROAD`) rende 12 na caixa & só 3 na aba ∴ foi **RETIRADA**. Mais aperto = **(b)+(c) juntas**, que é
rodada de **2 abas** (a Combat espelha `HEALTH` por §V284c). Tudo em **§I125g/g1/g2**.

⚠ **Antes de qualquer coisa: 4 TESTES DE TELA acumulados** ↓, nenhum com check estático, & o
`.rpk` de 09:09 foi instalado c/ o Firecast ABERTO ∴ **feche & reabra a ficha** (§B103).

---

### O QUE A 155ª FEZ — §T861, os 4px que a aba tinha na mesa

`VIRTUES` abria a 1ª linha em **45** enquanto a hairline do título dela é **41**, e todas as outras
caixas tituladas da aba já abriam em 41. Foi só isso — e foi tudo o que os 3 pedidos do user
deixaram (os outros 2 estão no PISO, medidos em §I125; **⊥ tentar de novo**).

| peça | de | para |
|---|---|---|
| linhas de `VIRTUES` | `45 70 95` | **`41 66 91`** |
| caixa `VIRTUES` | `330×140` | **`×136`** (fundo `701`→`697`) |
| `ROAD` | `top=706` | **`top=702`**, altura `189` intacta ∴ fundo `895`→**891** |
| `SPECIALTIES` | `330×334` | **`×330`** (`top=561` ⊥ mudou) |
| avatar — as 3 peças de §V309 | `340×464` | **`×460`** |
| `$HEALTH_TEN_ROW_OVERHANG` | `-7` | **`-3`** |
| mapa da aba (comentário do topo) | `y=895` | **`y=891`** |

**§V374 NOVA no gate** (`verify-hunters-hunted.ps1`, logo depois de §V370): ∀ caixa titulada da
aba abre a 1ª linha em `título.top + título.height + 1`, medido como RELAÇÃO, ⊥ contra o literal
41. Lista: `ATTRIBUTES` `TALENTS` `SKILLS` `KNOWLEDGES` `VIRTUES` `SPECIALTIES` — cabeçalho fora
(⊥ tem título) & `HEALTH` fora (mesma fronteira de §V370a, citada ⊥ redesenhada).

**Mutação 4/4 HIT** (harness em `scratchpad/mut374.ps1`, c/ o guarda de log < 200 chars dentro):
`VIRTUES` de volta p/ 45 ! VERMELHO · `TALENTS` p/ 42 ! VERMELHO · título fora de 1 caixa !
VERMELHO (zero-guard) · **sonda:** `SPECIALTIES` `330`→`340` (rodapé) ! **V374 VERDE**, como §V374
manda — rodapé é de §V171/§V240.

---

### ⛔ TESTE DE TELA PENDENTE — **feche & reabra a ficha** (§B103). O Firecast estava ABERTO no install

`.rpk` **2.612.410 B** instalado 09:09 c/ o Firecast rodando desde ontem 18:11 ∴ se a ficha estava
na tela, ela está c/ o form velho e o código novo atrás. **Fechar & reabrir cura.**

- **§T861 (novo).** Aba Main: `VIRTUES` c/ as 3 linhas 4px mais altas & o rodapé da aba fechando
  numa linha só, 4px acima de ontem. Nada mais pode ter andado.
- **§T858a — os 7 nomes** (herdado, ⊥ conferido). Trocando a época em Settings, cada coluna !
  mostrar **15 linhas**: MN **11·13·13** · Victorian **11·13·12** · Dark Ages **11·13·12** ·
  Classical **11·13·13**. Em [pt]: `Artes` `Artes Marciais` `Meditação` `Pesquisa` `Cosmologia`
  `Esotérica`.
- **§T858b — o par gêmeo** (herdado). Coluna KNOWLEDGES, **13ª linha**: nomeada em Modern/Classical,
  DIGITÁVEL em Victorian/Dark Ages. ⊥ pode ficar vão nem as 2 ao mesmo tempo.
- **§T859 — a régua de 25** (herdado).
- ✅ já aprovados: §T856 · §T854 · §T855/§T838 · §T857 (falta reconfirmar em nature/demeanor).

---

### ⚠ PERGUNTAS ABERTAS

**Q38 — RESPONDIDA em parte, & a resposta MATOU a saída barata. A aba fica em `y=891`.**
A 156ª mediu de novo e achou o que a 155ª ⊥ tinha visto: **o piso da aba ⊥ é da corrente esquerda,
é do `HEALTH`, & fica em 888.** `HEALTH` = `561 + 327`, & 327 = `10*27 + 57` (§V49) ∴ entre a
corrente (891) & o piso real (888) ∃ **3px**, ⊥ mais. **Abaixo de 888 o sinal de §V69 TROCA:**
`HEALTH` deixa de ficar CURTA da linha & passa a ESTOURAR sob ela — vira a caixa mais baixa da aba.
Está escrito em **§I125g/g1/g2**. Consequência p/ as 3 saídas:
- **(b) ar interno de `ROAD` — ⊥ VALE SOZINHA.** Os 3 vãos de 5 caindo p/ a hairline de §V374
  (5→1) rendem **12** na caixa, mas só **3** chegam na aba enquanto `HEALTH` for 327. 12px de
  mexida numa caixa que o user apertou À MÃO em §I124d ("diminuir bastante, mas ainda um pequeno
  espaço") p/ ganhar 3 na aba é mau negócio. **Era a recomendação da 155ª & está RETIRADA.**
- **(c) `HEALTH` p/ a régua de 25** tira **20** (⊥ os 18 que §I125e escreveu: `10*25+57` = 307
  contra 327 — erro de conta, corrigido em §I125g2) & leva o piso p/ 868, mas **arrasta a aba
  Combat junto** (§V49 + §V284c: as 2 caixas leem `HEALTH_ROW_PITCH`/`HEALTH_BOX_PAD`).
- **(a) altura da linha de entrada 25 → 20** segue sendo a ficha INTEIRA (§V26, §V37, §V370).

**Recomendação nova: NÃO apertar mais a aba Main.** Ela custa (b)+(c) juntas — 2 abas, uma régua
espelhada & um pedido do user desfeito — p/ 15px numa tela que já fecha numa linha só. Se o user
quiser mesmo, a ordem é **(c) primeiro** (é ela que abre espaço; (b) sozinha ⊥ chega na aba), e
aí a rodada é das **2 abas**, ⊥ da Main.

**Q37 — o `field` da metade escondida do gêmeo.** `computer` no `Ability num="13"` de knowledges.
**Recomendação: manter** (nasce escondida & o renderer religa tudo na 1ª pintura).

**Q35 (da 153ª) — ADIADA pelo user em 2026-08-31, "pode considerar feito". ⊥ reabrir sozinho.**
Ele disse: *"nenhuma `?` está ao lado de uma linha digitada no momento, podemos deixar isso para
verificar bem mais tarde — eu levanto essa questão quando for o momento."* **CONFERIDO & está
certo:** os **3** templates que têm `?` — `HeaderPicker` (WoD20.1), `MeritPicked` & `OpenAbility`
(WoD20.2) — nascem c/ o gêmeo digitável `visible="false" enabled="false"` (§V274) ∴ o que ∃ ao
lado do `?` no estado AUTORADO é sempre o BOTÃO de picker, ⊥ um `<edit>`. O caso das 2 leituras só
aparece se a flag de entrada manual for LIGADA, & é o user quem diz quando isso importa.
⚠ **⊥ emendar §I102f nem §V365b por causa disto** — as 2 leituras seguem vivas & sem veredito;
o que mudou é que ⊥ ∃ sintoma na tela p/ forçar a escolha agora.

**Q36a — FECHADA na 156ª.** §V75 & §V146 foram emendadas por `/ck:spec`: §V75 perdeu o "EXATAMENTE
10 nomes" (a contagem é de §V371e desde §T858) & §V146 perdeu os 3 literais mortos da 103ª rodada
("9 linhas", "`top=25`", "pitch 30") — hoje são 10 linhas, 1ª na hairline (§V374) & pitch
`$MAIN_ROW_PITCH` (§V370). O código ⊥ mudou: era o TEXTO que estava atrás.

**Q36b — MORTA.** 11ª linha de especialidade ⊥ cabe: pede 336, a caixa tem 330 (§I125d).
---

### ⚠ ARMADILHAS — a 1ª & a 2ª morderam DE NOVO nesta rodada

0. **⛔ TODOS os arquivos do projeto são CRLF, o gate INCLUSIVE** — só os `desc*.lua` são LF. E
   **`sed -n 'Np' arquivo` no Git Bash COME o `\r`** ∴ `cat -A` mente e diz que o arquivo é LF.
   Um `perl -0777 -pe 's/.../.../'` com `\n` no padrão dá **0 substituições em silêncio**. Confira
   com `perl -0777 -ne 'print "OK" if /texto\r\n/'` antes de culpar o padrão.
1. **⛔ O gate fala por `Write-Host`, que ⊥ chega no pipeline do PS 5.1.** `& .\gate.ps1 | Out-String`
   devolve **string VAZIA** ∴ `$out -match 'FAIL'` é sempre falso ∴ **TODA mutação lê VERDE**.
   Cura — processo FILHO + ler o arquivo, & **abortar se o log vier com < 200 chars**:
   `& powershell -NoProfile -ExecutionPolicy Bypass -File .\verify-hunters-hunted.ps1 > $log 2>&1`
   Harnesses prontos c/ o guarda dentro: `scratchpad/mut374.ps1` (o desta rodada), `mut370.ps1`,
   `mut371.ps1`. ⚠ `Select-String -Pattern 'FAIL'` pega `fail-closed` no texto dos `ok` — ancore em
   `'^FAIL'`.
2. **⛔ Splice por perl COME o `\r\n` anterior & gruda 2 blocos numa linha só.** Sempre conferir com
   `awk 'NR>=X && NR<=Y {printf "%d [%d] %.70s\n", NR, length($0), $0}' arquivo`.
3. **⛔ Heredoc do bash MORRE em corpo grande de PowerShell**, mesmo com delimitador entre aspas; e
   `python -c '...'` no Git Bash quebra em qualquer `'`. **Corpo grande → ferramenta de ESCRITA,
   depois splice por perl lendo o arquivo (`open`/`local $/`), ⊥ colando o corpo no `-pe`.**
4. **⛔ String perl entre ASPAS engole `@{`** — usar `q^...^` p/ todo trecho de PS.
5. **⛔ ⊥ canalizar `rdk` por `tail`** — devolve o status do `tail`, sempre 0. Rodar sem pipe &
   conferir o `=)`.

*(reconfirmadas)* `\Q…\E` ⊥ impede interpolação de `$var` · PowerShell sombreia `.Name` de
`XmlElement` com o ATRIBUTO `name` (usar `.LocalName`).

---

### GIT — nada commitado, e é assim de propósito (`CLAUDE.md`)

**10** modificados + **9** novos desde `15512560`. **⊥ commitar sem o user pedir NAQUELA mensagem.**
Modificados: `SPEC.md` · `HANDOFF.md` · `verify-hunters-hunted.ps1` · `research/README.md` ·
`WoD20th.lfm` · `WoD20.1.lfm` · `WoD20.2.lfm` · `WoD20.6.lfm` · `localization.lang` · o `.rpk` de
`output/` (10). Novos: `.claude/` · `descNature_en.lua` · `descNature_pt.lua` · 6 em `research/`
(`arch_body_en.tsv` `arch_body_pt.tsv` `arch_extract.pl` `arch_names.txt` `arch_qa_words.pl`
`gen_nature.pl`) = 9.

---

## 155ª RODADA (2026-08-31) — SUPERADA pelo bloco acima; ela É o bloco acima, guardada só pelo §I125

O que a 155ª executou está inteiro no topo. O que ela **⊥ mexeu e é preciso saber** está em §I125
do `SPEC.md`: a medição caixa a caixa da aba Main, feita antes dela, que respondeu **⊥ DÁ** a 2 dos
3 encolhimentos que o user pediu. Resumo, p/ ⊥ ser re-derivado no 4º pedido sobre a mesma coluna:

1. **"diminua o box de name/player/nature/demeanor/residence" — ⊥ DÁ.** Ele é `20 + 3 linhas de 25
   em passo 25 + 20 = 115`, & **passo == altura de linha** ∴ as linhas se TOCAM, ⊥ ∃ ar dentro.
   Margem de 20 é §V280a; passo de 25 é §V370. Só encolhe trocando a ALTURA DA LINHA DE ENTRADA,
   que é 25 na ficha inteira → é **Q38(a)**, ⊥ é aperto.
2. **"suba o fundo de talents/skills/knowledges respeitando a margem" — JÁ ESTÁ.** Rodapé = **20**,
   igual ao de `ATTRIBUTES`, que é exatamente o que §V171 cobra. Subir mais pede LINHA A MENOS, &
   as 15 linhas são o pedido de §I123a atendido na 154ª.
3. **"diminua `VIRTUES` respeitando a margem" — deu 4px, & virou §T861**, feita.

⚠ **o vão entre caixas é `5` EXATO (§V298), ⊥ 20.** §I73 diz 20 & foi **REVOGADA nesse ponto** por
§I76a. ⊥ tentar fechar vão.

⚠ **`SPECIALTIES` fica com 39px de rodapé & isso ⊥ é bug** (§I125d): ela ! fechar na linha de §V69,
a linha é da coluna do MEIO (`VIRTUES`→`ROAD`), & o rodapé dela é o RESTO da conta (§I124f, §V370b).

## 154ª RODADA (2026-08-31) — SUPERADA pela 155ª acima; guardada pelo par gêmeo & pelas armadilhas

**Estado:** gate **VERDE 626 ok / 0 FAIL** · §T **749 `x` · 99 `.` · 12 `~`** · `.rpk` **2.612.225 B**
instalado 00:11 · **nada commitado** desde `15512560` (9 arquivos modificados + 8 novos).

### ⚠ AS 3 PRIMEIRAS COISAS

1. **⊥ ∃ nada a refazer. §T858 & §T859 SAÍRAM as 2**, c/ gate verde, `.rpk` instalado &
   mutação provada (§V371 **7/7 VERMELHA** + sonda · §V370 **5/5 VERMELHA** + sonda).
2. **⚠ 3 TESTES DE TELA novos** (↓) — a Main mudou de altura & de conteúdo, & ⊥ ∃ check
   estático que veja "ficou bonito".
3. **⚠ 3 perguntas ABERTAS: Q35 (herdada), Q36 & Q37 (novas)** — nenhuma bloqueia a próxima
   §T, mas **Q36 é dívida de SPEC**, ⊥ de código: 2 réguas ficaram c/ o texto atrás do gate.

---

### O QUE A 154ª FEZ

**§T858 — os 7 nomes, os 3 digitáveis & o par GÊMEO.** `ABILITY_FIELD` foi de **41** p/ **47**
(`arts` `martialArts` `meditation` `research` `cosmology` `esoterica`; `enigmas` já ∃), as 4
listas de época viraram **11·13·13 / 11·13·12 / 11·13·12 / 11·13·13**, `PICKER_LIST["speciality"]`
cresceu junto & os 6 nomes ganharam `wod.<nome>` em [pt]+[en] & no mapa `PT`. O grid foi de **12**
p/ **15** linhas por coluna (talents 11+4 · skills 13+2 · knowledges 12|13 + o gêmeo + 2).

⚠ **o par gêmeo é a peça nova, & ela mora em 2 lugares:** no XML, `dynAbilRow_knowledges_13`
(escondido, `field="computer"`) & `dynAbilFill_knowledges_13` (visível, `customKnowledge_3`) no
MESMO `top="341"`; no Lua, **2 ramos novos** em `renderAbilityLabels` que leem o MESMO índice em
sentidos OPOSTOS. O `else` que §I123c pedia ⊥ é o rótulo — é a **LINHA** que some, porque esconder
só o rótulo deixaria 5 bolinhas vivas numa linha sem nome.

⚠ **`Computer` no slot 13 foi ESCOLHA minha, ⊥ do SPEC** (Q37 ↓): a linha escondida precisa de um
`field`, o autorado é Victorian (§V76) & Victorian ⊥ tem 13º conhecimento. `computer` é o único
conhecimento que **nenhuma** época de 12 lista ∴ a coluna autorada continua 1 campo por linha.

**§T859 — a régua de 25.** cabeçalho `20 50 80`→`20 45 70` · VIRTUES `45 74 103`→`45 70 95` ·
SPECIALTIES `41 71 …311`→`41 66 …266` · `WILLPOWER` `114`→`99` & trilha `139`→`124` · `ROAD` ganhou
`horzTextAlign="trailing"`. Linha da aba: **853 → 928 (§T858, desceu 75) → 895 (§T859, subiu 33)**.

⚠ **2 coisas caíram de barato & ⊥ estavam no plano:**
- **`EXPERIENCE` teve de encolher junto** (`125`→`115`): o cabeçalho encolhendo põe a fileira de
  habilidade em `top=120`, & uma caixa parada em `0..125` **sobrepõe** (§V40). C/ 115 ela quebrava
  §V240/§V280 (10px embaixo, mínimo 20) ∴ o `edtCurrentXPMain` foi de `height=60` p/ **50**.
- **`$HEALTH_TEN_ROW_OVERHANG` foi de `-30` p/ `-7`.** HEALTH tem trilha de **27** & ⊥ segue régua
  nenhuma: ele andou c/ a fileira nas 2 vezes & ⊥ mudou de altura ∴ o vão é o que as 2 mexidas
  deixaram. **2 rodadas, 2 motivos, 1 literal** — está comentado no gate.

⚠ **as 2 colunas ⊥ pouparam igual & isso VIRA FOLGA, ⊥ passo** (§I124f, §V370b): esquerda poupa
23, SPECIALTIES poupa 45 ∴ a linha é da ESQUERDA (895) & SPECIALTIES fecha **22 curta**, ganhando
o resto como margem. Hoje SPECIALTIES tem **43px** embaixo da última linha — é **Q36b** ↓.

---

### ⚠ 3 ARMADILHAS — a 1ª explica os "4 vereditos falsos" da 153ª

1. **⛔ O gate fala por `Write-Host`, que ⊥ chega no pipeline do PS 5.1.** `& .\gate.ps1 | Out-String`
   devolve **string VAZIA** ∴ `$out -match 'FAIL'` é sempre falso ∴ **TODA mutação lê VERDE**. Foi
   exatamente isto na 1ª passada desta rodada: **7/7 MISS** c/ `applied=True`. A cura é rodar como
   **processo FILHO** & ler o arquivo:
   `& powershell -NoProfile -ExecutionPolicy Bypass -File .\verify-hunters-hunted.ps1 > $log 2>&1`
   — & **abortar se o log vier c/ menos de 200 chars**, senão o veredito é mentira. Os 2 harnesses
   ficaram em `scratchpad/mut370.ps1` & `mut371.ps1` c/ o guarda dentro.
2. **⛔ Heredoc do bash MORRE em corpo grande de PowerShell** (`unexpected EOF while looking for
   matching '`), mesmo c/ delimitador entre aspas — 2 tentativas perdidas. E `python -c '...'` no
   Git Bash quebra em qualquer `'` do código. **Corpo grande → ferramenta de ESCRITA, depois
   splice por perl.** (Já estava na lista da 153ª; custou 3 passos assim mesmo.)
3. **⛔ String perl entre ASPAS engole `@{`** (`Can't modify constant item in scalar assignment`):
   `@{ L = $l }` do PowerShell vira deref de bloco. Usar `q^...^` p/ todo trecho de PS.

*(reconfirmadas)* ⊥ canalizar `rdk` por `tail` · os `desc*.lua` são LF & o resto é CRLF ·
`\Q…\E` ⊥ impede interpolação de `$var`.

---

### ⛔ TESTE DE TELA — 3 novos. **Feche & reabra a ficha antes** (§B103). `.rpk` 2.612.225 B de 00:11

- **§T858a — os 7 nomes.** Trocando a época em Settings, cada coluna ! mostrar **15 linhas** & a
  contagem nomeada ! bater: MN **11·13·13** · Victorian **11·13·12** · Dark Ages **11·13·12** ·
  Classical **11·13·13**. Em [pt]: `Artes` `Artes Marciais` `Meditação` `Pesquisa` `Cosmologia`
  `Esotérica`.
- **§T858b — o par gêmeo, & é o único jeito de ver o bug que ele cura.** Na coluna KNOWLEDGES,
  **13ª linha**: em Modern Nights/Classical ela é um traço NOMEADO; em Victorian/Dark Ages ela
  vira um campo DIGITÁVEL. ⊥ pode ficar **vão** nem **as 2** ao mesmo tempo, & marcar pontos numa
  ⊥ pode acender a outra.
- **§T859 — a régua.** Tudo mais junto na vertical, `ROAD` encostado no combo, & o rodapé da aba
  fechando numa linha só. ⚠ **olhe o pé de SPECIALTIES**: ∃ 43px de preto embaixo da 10ª linha
  (Q36b) — é aritmética, ⊥ descuido, mas é o user que decide se fica.
- ✅ já aprovados: §T856 · §T854 · §T855/§T838 · §T857 (falta reconfirmar em nature/demeanor,
  que §T860 destravou & ⊥ foi reconferido).

---

### ⚠ PERGUNTAS ABERTAS

**Q35 (herdada da 153ª, ⊥ bloqueia nada) — o `?` em campo digitável.** As 2 leituras seguem
opostas: (1) pôr `?` ao lado de linha DIGITADA pede emenda em §I102f + §V365b; (2) o `?` abrir
EDITÁVEL já é o comportamento certo (`isStoryteller()` só é `true` numa MESA & como MESTRE).

**Q36 — dívida de SPEC que ESTA rodada criou, & `/ck:build` ⊥ pode escrever seção.**
- **(a)** §V75 ainda diz "EXATAMENTE **10** nomes" & isso virou FALSO: o gate agora mede só
  *distinto + tem campo*, & a CONTAGEM por época mudou de dono p/ §V371e (§V135, 1 dona por régua).
  §V146 idem: o literal `30` virou `$MAIN_ROW_PITCH` & quem manda no passo é §V370.
  **Recomendação:** `/ck:spec` emendar §V75 (tirar o "10", citar §V371e) & §V146 (citar §V370).
  Sem isso o `/ck:check` da próxima rodada vai acusar drift em cima de código CERTO.
- **(b)** **43px de folga no pé de SPECIALTIES.** A linha da aba é pinada pela coluna ESQUERDA
  (VIRTUES+ROAD) & pelo HEALTH de 10 linhas; SPECIALTIES poupou 45 & só tinha 23 p/ gastar.
  **Recomendação: uma 11ª linha de especialidade** — as 11 fechariam em `41..291`+20 = **336**
  contra os 334 de hoje, ∴ 2px de ajuste & a folga vira LINHA ÚTIL. Alternativa barata: deixar
  como está (é o que §V370b manda quando ⊥ ∃ o que pôr lá).

**Q37 — o `field` da metade escondida do gêmeo.** Autorei `computer`/`Computer` no
`Ability num="13"` de knowledges porque a linha precisa de um campo, o autorado ! ser Victorian
(§V76) & Victorian ⊥ tem 13º. `computer` é o único conhecimento que nenhuma época de 12 lista.
**Recomendação: manter** — ⊥ tem efeito nenhum em tela (a linha nasce escondida & o renderer
religa tudo na 1ª pintura), & qualquer outro nome ou repetiria um campo da própria coluna ou
inventaria um traço. Se preferir explícito, o passo é um `field` morto declarado em §I3.

---

## 153ª RODADA (2026-08-30) — SUPERADA pela 154ª acima; guardada pelo picker de nature/demeanor & por Q35

**Estado:** gate **VERDE 624 ok / 0 FAIL** · §T **747 `x` · 101 `.` · 12 `~`** · `.rpk` **2.599.655 B**
instalado 23:27 · **nada commitado** desde `15512560` (8 arquivos modificados + 8 novos).

### ⚠ AS 2 PRIMEIRAS COISAS

1. **⊥ ∃ nada a refazer. Retome em §T858**, & o plano dela está MEDIDO no `SPEC.md` (§I123, §V371).
   **Q34 já foi RESPONDIDA** (↓). §T859 vem DEPOIS dela.
2. **⚠ Q35 ABERTA & ela ⊥ bloqueia §T858/§T859** — é sobre o `?` em campo digitável (↓). Dá p/
   construir as 2 sem a resposta; ela só decide se nasce trabalho NOVO depois.

---

### O QUE A 153ª FEZ — §T860, o 3º disfarce da mesma doença

**§B110:** o picker de nature/demeanor abria & **nada que se clicasse mostrava descrição**, enquanto
o `?` da MESMA linha mostrava o texto do livro. `HeaderPicker` tem as 2 portas & só o `?` nomeava o
módulo: o `mfOpen` ia **sem o 4º argumento** ∴ `MF.mod` nil & a pane caía na frase de §V360c.
Antecedente & mérito ⊥ tinham o problema porque as 2 chamadas deles já passavam o módulo.
Conserto = **1 argumento**.

⚠ **o sintoma MENTE sobre a causa, & é a 3ª vez na mesma semana:** a pane dizia
`No description available`, que lê como "o livro ⊥ traz este arquétipo" — falta de DADO — quando o
que faltava era um ARGUMENTO, & os 46 textos estavam em disco desde a 150ª. ≡ §B99 (o `require` que
levantava) & §B109 (a tabela devolvida no lugar da string). **Falha silenciosa se disfarça de lacuna
de conteúdo** — quando a pane disser que ⊥ ∃ texto, DESCONFIE do caminho antes de acusar o livro.

⚠ **por que 623 checks ⊥ pegaram:** §V354b mede o `mfOpen` sozinho (declarar módulo | ⊥ declarar,
as 2 legais) & §V365 mede o `?` sozinho. **Nenhuma cruzava as 2 portas da mesma linha**, & o defeito
morava exatamente no cruzamento. ∴ **§V373**, que mede por TEMPLATE: template c/ as 2 portas nomeia
**1** módulo pelas 2, & módulo nomeado ! ∃ em disco nos 2 idiomas. Mutação **4/4 VERMELHA** (o bug
literal · as 2 discordando · módulo inexistente · a mesma discordância no antecedente) + sonda verde.

⚠ **dívida de roster junto:** o gate DECLARAVA `HeaderPicker` sem módulo — certo enquanto §T838
extraía, falso no minuto em que `descNature_en/_pt` nasceram. **Declaração ⊥ envelhece sozinha**, &
foi ela que deixou o argumento faltando passar por 2 rodadas. Agora declara `Nature`.

---

### ▶ RETOMADA: §T858 & depois §T859 — plano já medido no SPEC

**§T858** (`WoD20th.lfm` + `WoD20.1.lfm` + `WoD20.6.lfm` + `localization.lang`, §I123, §V371):

- `Arts` em `BASE_TALENTS` (serve 3 épocas) & na lista PRÓPRIA de Dark Ages
- `Martial Arts` `Meditation` `Research` nas **4** listas de skills
- `Cosmology` `Enigmas` `Esoterica` nas de knowledges, **PULANDO `Enigmas` em Victorian Era &
  Dark Ages, que já o têm** ∴ t·s·k: MN **11·13·13** · VE **11·13·12** · DA **11·13·12** ·
  CA **11·13·13**
- **6** entradas em `ABILITY_FIELD` (`arts` `martialArts` `meditation` `research` `cosmology`
  `esoterica`) ∴ §V74 de 41 → **47**; `PICKER_LIST["speciality"]` cresce junto
- **3** digitáveis novos c/ 5 pontos cada: `customTalent_3` `customTalent_4` `customKnowledge_3`
  ∴ toda coluna fecha em **15** linhas visíveis
- ⚠ **par GÊMEO** na 13ª posição de knowledges: `Ability num="13"` & `CustomAbility
  customKnowledge_3` no MESMO `top`, & o render mostra **1**
- ⚠ **o `else` do render** (§I123c): `renderAbilityLabels` é `if name ~= nil then show(c, name)`
  & o MESMO teste guarda a religação do `imageCheckBox` ∴ slot ⊥ preenchido fica c/ rótulo **& o
  CAMPO** da época anterior. Os controles de `CustomAbility` ⊥ têm `name=` ∴ o laço de nomes ⊥ os
  alcança — a troca ! ser feita pelo PAR, achado pelo lado nomeado
- §V371 no gate + mutação (a de guarda da decisão do dono: dar um 13º conhecimento a Victorian
  ! ficar VERMELHO)

**§T859** (`WoD20.1.lfm`, §I124, §V370) — DEPOIS de §T858: grid a 15 linhas · cabeçalho
`20 50 80`→`20 45 70` (−10) · VIRTUES `45 74 103`→`45 70 95` (−8) · SPECIALTIES `41 71 …311`→
`41 66 …266` (−45) · `WILLPOWER` `114`→**99** & trilha `139`→`124` (−15) · rótulo `ROAD` ganha
`horzTextAlign="trailing"`. ⚠ §V69: as 2 colunas ⊥ poupam igual (esq. 23, dir. 45) ∴ o y comum sai
RECALCULADO, & quem sobrar curto ganha FOLGA, nunca passo maior.

---

### ⚠ Q34 RESPONDIDA — regra DURÁVEL do dono

> **"Uma era ⊥ deve ganhar habilidades de outra era. Apenas adicionar aquelas que eu falei. No
> máximo, para manter estética, campos digitáveis serão adicionados."**

∴ Victorian & Dark Ages FICAM c/ 12 conhecimentos. `Philosophy` & `Ritual` custariam 0 campo & 0
tradução & foram RECUSADAS. §V371e guarda: contagem de época que mude sem §T é nome emprestado.

### ⚠ Q35 ABERTA — o `?` em campo digitável

O user reportou 2026-08-30: **"⊥ ta aparecendo nenhum `?` em nenhum campo editável no momento"**,
& na MESMA mensagem confirmou que o `?` abre na aba certa & mostra o texto do livro. MEDIDO: ∃
**3** botões `?` (`HeaderPicker` · `MeritPicked` · antecedente) & os 3 funcionam. As 2 leituras:

1. **`?` ao lado de linha DIGITADA** — hoje ⊥ ∃ **por desenho**: §I102f tira o `?` de `*Free`/
   `*FreeRow` (linha digitada ⊥ é autorada ∴ ⊥ tem entrada de livro p/ abrir), & §V365b REPROVA
   quem puser. Mudar isso é decisão do dono & pede emenda em §I102f + §V365b.
2. **o `?` abrir EDITÁVEL (§T845)** — `popOpen` escreve `readOnly = not isStoryteller()`, &
   `isStoryteller()` só é `true` se a ficha estiver **numa MESA** & o espectador for o **MESTRE**.
   Ficha aberta fora de mesa, ou como jogador, abre SÓ-LEITURA — comportamento CERTO.

⊥ construir por cima disto sem a resposta: as 2 leituras pedem trabalho OPOSTO (uma acrescenta
botão, a outra ⊥ acrescenta nada).

---

### ⚠ ARMADILHAS — as da 152ª seguem valendo, & a 1ª é a mais cara

1. **⊥ CANALIZE o `rdk` por `tail` & leia `$?`** — devolve o status do `tail`, sempre 0. Custou 3
   passos c/ o build QUEBRADO & só apareceu quando o `rdk -i` entrou no modo §B80 (exit 1, mensagem
   VAZIA, **`.rpk` APAGADO**). Rode sem pipe & confira o `=)`.
2. **Recorte de bloco Lua por `index`+`substr` deixa `end;` órfão** — ler a função inteira depois.
3. **`q{...}` do perl conta chave; `q!...!` quebra em `!`.** Usar `q^...^`. E heredoc do bash
   engasga em corpo grande c/ aspas & `$(...)`: escrever o arquivo pela ferramenta de escrita.
4. **Mutação VERDE ! provar que APLICOU** — 4 vereditos falsos nesta sessão.

*(reconfirmadas)* `\Q…\E` ⊥ impede interpolação de `$var` · os `desc*.lua` são **LF** & o resto é
CRLF · PowerShell sombreia `.Name` de `XmlElement` com o ATRIBUTO `name` (usar `.LocalName`).

---

### ⛔ TESTE DE TELA — 1 novo, & 3 já APROVADOS pelo user

**Feche & reabra a ficha antes** (§B103). `.rpk` 2.599.655 B de 23:27.

- **§T860 [NOVO]** — no picker de **Nature/Demeanor**, clicar num arquétipo mostra a descrição na
  pane da direita (os 46 c/ texto; os 22 c/ a frase). É o conserto desta rodada.
- ✅ §T856 (o `-- Remove --` separado & na página 2) · ✅ §T854 (abre na aba certa) · ✅ §T855/§T838
  (o `?` de Nature/Demeanor mostra o livro) — **aprovados pelo user 2026-08-30**.
- ✅ §T857 aprovado p/ antecedente, mérito & defeito; **falta reconfirmar em nature/demeanor**,
  que é o que §T860 destrava.

---
## 152ª RODADA (2026-08-30) — SUPERADA pela 153ª acima; guardada pelo picker & pelas armadilhas

**Estado:** gate **VERDE 623 ok / 0 FAIL** · §T **746 `x` · 101 `.` · 12 `~`** · `.rpk` **2.599.634 B**
instalado 23:11 · **nada commitado** desde `15512560` (8 arquivos modificados + 8 novos).

### ⚠ A PRIMEIRA COISA: ⊥ ∃ nada a refazer. Retome em §T858.

`/ck:build --all` da 151ª entregou **§T856** & **§T857** (as 2 do picker) c/ gate verde, mutação
provada & `.rpk` INSTALADO. Sobram **§T858** & **§T859**, & elas ⊥ dependem de decisão nenhuma:
**Q34 já foi RESPONDIDA** (↓). O plano das 2 está escrito no `SPEC.md`, medido — ⊥ remedir.

---

### O QUE A 152ª ENTREGOU

**§T856 — `-- Remove --` saiu da paginação.** O `""` de §V15 viajava dentro de `MF.pool` ∴ ordenava,
paginava & **sumia depois da página 1**, na linha cuja ÚNICA saída ele era; & ainda comia 1 dos 20
slots de §I107k. Agora é `btnMfRemove`, controle próprio em `top="106"` contra a 1ª linha em `131`
(passo 20 ∴ vão de 25 > passo, §V369c), fora de `MF.pool`/`MF.hits`/`total`/`pages`, visível ⟺
`MF.canRemove`. As 20 linhas desceram 23 & o rodapé de paginação junto; a caixa ⊥ mudou de tamanho
(`1000×620`) ∴ §V352c intacta. **§V369** NASCEU, mutação **6/6 VERMELHA** + sonda verde.

**§T857 — o picker abre PRÉ-MARCADO & o `-- Remove --` empresta a descrição do slot.** A pintura da
pane saiu de dentro de `mfSelect` p/ **`mfDesc`**, & os **3** chamadores compartilham: a abertura
(pré-marca em `MF.picked = cur`), a linha de resultado & a linha de remoção (que mostra o que está
NO SLOT — ela ⊥ tem descrição própria & cair na frase de §V360c diria "o livro ⊥ traz" sobre algo
que ⊥ é item). **§V372** NASCEU, mutação **3/3 VERMELHA** + sonda verde.

**4 réguas foram REPONTADAS, & nenhuma afrouxada** — o mecanismo mudou de casa, ⊥ de exigência:
§V355d (media o vazio DENTRO da pool; agora cobra `MF.canRemove = has` **&** a AUSÊNCIA do vazio na
pool) · §V352f · §V360c · §V360d (as 3 prendiam a pane a `mfSelect`; agora leem `mfDesc`, que é
alvo MAIS forte — de "um chamador entre os possíveis" p/ "o único escritor").

---

### ▶ RETOMADA: §T858 & depois §T859 — o plano já está medido no SPEC

**§T858** (`WoD20th.lfm` + `WoD20.1.lfm` + `WoD20.6.lfm` + `localization.lang`, §I123, §V371):
- `Arts` em `BASE_TALENTS` (serve 3 épocas) & na lista PRÓPRIA de Dark Ages
- `Martial Arts` `Meditation` `Research` nas **4** listas de skills
- `Cosmology` `Enigmas` `Esoterica` nas de knowledges, **PULANDO `Enigmas` em Victorian Era &
  Dark Ages, que já o têm** ∴ contagem final t·s·k: MN **11·13·13** · VE **11·13·12** ·
  DA **11·13·12** · CA **11·13·13**
- **6** entradas em `ABILITY_FIELD` (`arts` `martialArts` `meditation` `research` `cosmology`
  `esoterica`) ∴ §V74 de 41 → **47**, & `PICKER_LIST["speciality"]` cresce junto
- **3** campos digitáveis novos c/ 5 pontos cada: `customTalent_3` `customTalent_4`
  `customKnowledge_3` ∴ toda coluna fecha em **15** linhas visíveis
- ⚠ **o par GÊMEO**: na 13ª posição de knowledges vivem os 2 controles no MESMO `top` —
  `Ability num="13"` & `CustomAbility customKnowledge_3` — & o render mostra **1**. `top`
  diferente deixaria vão de 25px na época que esconde o de cima
- ⚠ **o `else` do render** (§I123c): `renderAbilityLabels` é `if name ~= nil then show(c, name)`
  & o MESMO teste guarda a religação do `imageCheckBox` ∴ slot ⊥ preenchido fica c/ o rótulo **&
  o CAMPO** da época anterior. Os controles do `CustomAbility` ⊥ têm `name=` ∴ o laço de nomes ⊥
  os alcança — a troca ! ser feita pelo par, achado pelo lado NOMEADO
- §V371 no gate + mutação (a de guarda da decisão do dono: dar um 13º conhecimento a Victorian
  ! ficar VERMELHO)

**§T859** (`WoD20.1.lfm`, §I124, §V370) — DEPOIS de §T858, porque a altura depende das linhas:
grid a 15 linhas · cabeçalho `20 50 80`→`20 45 70` (−10) · VIRTUES `45 74 103`→`45 70 95` (−8) ·
SPECIALTIES `41 71 …311`→`41 66 …266` (−45) · `WILLPOWER` `114`→**99** & trilha `139`→`124` (−15) ·
rótulo `ROAD` ganha `horzTextAlign="trailing"`. ⚠ §V69: as 2 colunas ⊥ poupam igual (esq. 23,
dir. 45) ∴ o y comum sai RECALCULADO, & quem sobrar curto ganha FOLGA, nunca passo maior.

---

### ⚠ Q34 RESPONDIDA — regra DURÁVEL do dono, ⊥ resposta de uma vez

> **"Uma era ⊥ deve ganhar habilidades de outra era. Apenas adicionar aquelas que eu falei. No
> máximo, para manter estética, campos digitáveis serão adicionados."**

∴ Victorian & Dark Ages FICAM c/ 12 conhecimentos. `Philosophy` & `Ritual` custariam **0** campo &
**0** tradução (já ∃ em `ABILITY_FIELD`) & foram RECUSADAS. §V371e guarda isso: contagem de época
que mude sem §T é nome emprestado entrando pela porta dos fundos.

### ⚠ 3 ARMADILHAS NOVAS — a 1ª é a mais cara da sessão

1. **⊥ CANALIZE o `rdk` por `tail` & leia `$?`** — `rdk -l 2>&1 | tail -3; echo $?` devolve o
   status do **`tail`**, sempre 0. Eu li "EXIT=0" c/ o build QUEBRADO & segui por 3 passos; só
   apareceu quando o `rdk -i` entrou no modo §B80 (exit 1, mensagem VAZIA, **`.rpk` APAGADO**).
   Rode `rdk -l` **sem pipe** & confira o `=)` na saída — `$?` sozinho ⊥ prova nada (§B1).
2. **Recorte de bloco Lua por `index`+`substr` deixa `end;` órfão.** O fecho do `if` interno
   sobreviveu ao corte & o Lua ficou inválido — & é exatamente o que (1) escondeu. Depois de
   cortar bloco, LER o corpo da função inteira antes de compilar.
3. **`q{...}` do perl conta chave & quebra em texto com `{` solto; `q!...!` quebra em texto com
   `!` (mordeu num `(?!"")`).** Usar `q^...^` p/ trecho de PowerShell, & sempre `quotemeta`.

*(reconfirmadas)* `\Q…\E` ⊥ impede interpolação de `$var` · mutação VERDE ! provar que APLICOU ·
os `desc*.lua` são **LF** & o resto é CRLF · PowerShell sombreia `.Name` de `XmlElement` com o
ATRIBUTO `name` (usar `.LocalName`).

---

### ⛔ TESTE DE TELA ACUMULADO — 5 coisas, & o `.rpk` de 23:11 tem todas

**Feche & reabra a ficha antes** (§B103).

1. **§T856** — o `-- Remove --` aparece SEPARADO acima da lista, & continua lá na **página 2**.
2. **§T857** — abrir um picker que JÁ tem valor mostra a descrição dele de cara; clicar em
   `-- Remove --` (sem confirmar) mostra a descrição do que está no slot.
3. **§T854** — o `?` & o picker abrem NA aba em que se está (Main & Traits).
4. **§T855/§T838** — o `?` de Nature/Demeanor mostra o texto do livro nos 46 & a frase
   `No description available` nos 22.
5. **§T845** — o `?` abre editável p/ o narrador & o texto sobrevive a fechar/reabrir.

⚠ **teste "MOSTRA", ⊥ "ABRE"** — foi essa distinção que deixou §B109 passar por 3 rodadas.

---
## 151ª RODADA (2026-08-30) — SUPERADA pela 152ª acima; guardada pelos 2 bugs do ? & pelas armadilhas

**Estado:** gate **VERDE 621 ok / 0 FAIL** · §T **744 `x` · 99 `.` · 12 `~`** · `.rpk` **2.597.418 B**
instalado 21:59 · **nada commitado** desde `15512560`.

### O QUE A 151ª FEZ — §T854 & §T855, DOIS bugs de tela do mesmo `?`

**§T854 / §B107 — a caixa abria na ABA errada.** `popScrim` `popDesc` `mfSearch` eram filhos do
`<scrollBox>` da aba **Traits**; aba é `visible="false"` quando o jogador está em outra & filho de
pai invisível é invisível ∴ o `?` da Main acendia caixa que ninguém via. 2º sintoma do mesmo pai:
o overlay ROLAVA com a grade. **Conserto:** os 3 viraram filhos DIRETOS de `sheetBody` em
`WoD20th.lfm`, DEPOIS de ∀ aba. `top` +40 (`popDesc` 110→150, `mfSearch` 40→80) & scrim 693→**733**.
**0 linha de Lua.** **§V367** NASCEU & mede **PARENTESCO**; mutação **3/3 VERMELHA**.

**§T855 / §B109 — & este é o que importa: a caixa abria VAZIA, p/ ∀ LISTA, desde sempre.**
`descText` fazia `txt = DESC[key] or ""` — mas ∀ módulo é `{nome = {<idioma> = texto}}` (§I21) ∴
`DESC[key]` é **TABELA**. As 4 panes de `WoD20.7`/`.12`/`.13`/`.14` sempre desembrulharam c/
`pick(tbl, lang)`; `descText`, que serve a caixa do `?` **&** a pane da busca, ⊥. **Conserto:**
`ent[lang] or ent.en or ""`, o MESMO `pick`. **§V368** NASCEU; mutação **5/5 VERMELHA**.

⚠ **A LIÇÃO DAS 2, & ela é a mesma:** o teste de tela que fechou §T845/§T846 provou **"a caixa
ABRE"**, ⊥ **"a caixa MOSTRA"**. E o gate tinha o mesmo buraco: §V360c/§V364 provam que a FRASE
aparece quando o módulo ⊥ ∃, & **nada** provava que o TEXTO aparece quando o módulo ∃ — ninguém
comparava o que os módulos GUARDAM com o que os leitores TIRAM. §T838 entregou 46 textos certos
p/ um leitor que ⊥ lia nenhum, & 3 rodadas acharam que o que faltava era ARQUIVO.

⚠ **tabela ⊥ é nil & ⊥ é `""`** ∴ ela atravessou o `if txt == nil or txt == ""` do próprio
`popOpen`, que ∃ EXATAMENTE p/ esse caso. **Resposta errada vestida de certa passa por fallback**
— é a forma de §V364f (`mod or "Merit"`) voltando por outra porta.

### ⚠ 5 ARMADILHAS NOVAS — 4 fabricaram veredito falso

1. **PowerShell sombreia `.Name` de `XmlElement` com o ATRIBUTO `name`.** `$el.Name` devolve
   `"tabStrip"`, ⊥ `"layout"` ∴ `.Name -eq 'layout'` é falso p/ ∀ filho. Usar **`.LocalName`**.
   Só o zero-guard salvou a perna de nascer medindo nada.
2. **Mutação que sai VERDE ! provar que APLICOU** — 3 vezes nesta rodada. `,\n` num arquivo
   **CRLF**; `\r\n` num `.lua` que é **LF**; & um `s/pick\(/pk(/` que deixou `pick(` na definição.
   As 3 pareceram buraco na régua. **⊥ ∃ veredito de mutação sem prova de aplicação.**
3. **`\Q…\E` do perl ⊥ impede interpolação de variável.** `\Q$doc339 = …\E` vira `\Q = …\E`.
   Escrever o script em ARQUIVO & usar `quotemeta(q!…!)`; `q{…}` conta chave & quebra em texto
   com `{` solto.
4. **`\` numa regex vira `\` ao gravar pelo heredoc** ∴ `[^"\]` chegou como `[^"\]` & o
   PowerShell morreu de `ArgumentException` NO MEIO do gate — o bloco inteiro ⊥ rodou & o total
   de `ok` ⊥ mudou, que é fácil de ler como "passou". Conferir que o check NOVO imprimiu linha.
5. **Os 14 `desc*.lua` são LF**, & o resto do repo é CRLF. Regex de mutação neles ! usar `\n`.

### ⚠ ACHADO QUE VALE MAIS QUE O BUG — §B108, régua mais apertada que a própria spec

**§V166** diz "a ÚNICA **escrita**" & o gate contava **menção** da string `sheetBody` em texto
cru, **comentário XML incluso**. Enquanto ninguém nomeava o corpo em prosa a diferença dormia —
§B107 obrigou a nomear & o comentário que EXPLICA o conserto acendeu o gate CONTRA o conserto
(§B92). Curado ignorando `<!-- … -->` antes de somar, MEDIDO nos 2 sentidos (2ª escrita segue
VERMELHA, menção em comentário fica VERDE). **A tentação era reescrever o comentário p/
contornar** — isso deixaria a armadilha armada & pagaria com documentação pior.

⚠ **procure irmãos disto:** proxy (contar o nome) ⊥ é a coisa (contar a escrita), & proxy só se
comporta enquanto o nome ⊥ tem outro uso legítimo.

### ⛔ TESTE DE TELA PENDENTE — 3 coisas, & a 3ª nunca foi testável até agora

**Feche & reabra a ficha antes** — `.rpk` 2.597.418 B instalado 21:59 (§B103).

1. **§T854** — o `?` & o picker abrem NA aba em que se está (**Main** & **Traits**).
2. **§T855 / §T838** — o `?` de Nature/Demeanor mostra o **texto do livro** p/ os 46 & a frase
   `No description available` p/ os 22. ⚠ **a 2ª metade nunca foi testável**: até §B109 o leitor
   devolvia tabela ∴ ⊥ ∃ caminho pela frase. Valem os 2 lados.
3. **§T845** — o `?` abre EDITÁVEL p/ o narrador & o texto dele sobrevive a fechar/reabrir.

⚠ **teste "a caixa MOSTRA", ⊥ "a caixa ABRE"** — foi essa distinção que deixou §B109 passar por
3 rodadas & 2 §T fechadas em `x`.

Depois disso a tabela de travas da 149ª volta (**§T810** é a que mais desentope).

**Sem tela & sem o user:** `/ck:research` das 5 listas — **§T848** `clan` (61) é a 1ª.

---
## 150ª RODADA (2026-08-30) — SUPERADA pela 151ª acima; guardada pelo pipeline de pesquisa & pela dívida de spec já paga

**Estado:** gate **VERDE 619 ok / 0 FAIL** · §T **742 `x` · 99 `.` · 12 `~`** · **nada commitado**
desde `15512560` (13 arquivos modificados + 8 novos).

### ✅ AS 2 PRIMEIRAS COISAS DA 150ª — AS DUAS FEITAS, ⊥ REFAZER

1. ✅ **INSTALADO.** `output/` & `%APPDATA%\Firecast\Plugins\andreoliveira.styllern.wod20th.rpk`
   têm os MESMOS **2.599.438 B** de 20:35, c/ os 2 módulos de descrição dentro. O user fechou &
   reabriu a ficha depois. ⚠ **⊥ reinstalar sem arquivo do plugin ter mudado** — foram 2 dos 3
   installs desperdiçados na 147ª (§B103), & `verify -Build` puxa `rdk -l` junto ∴ ele reescreve
   o `.rpk` & deixa o instalado velho DE NOVO. Só rode o gate ESTÁTICO enquanto a rodada ⊥ tocar
   no plugin.
2. ✅ **A dívida de spec foi paga & §T853 saiu junto** (↓). ⚠ **a fila voltou a travar em tela**:
   §T853 era o único §T que dava p/ construir sem o user, & ele FECHOU. O que sobra `.` depende
   dos testes de tela da tabela de travas, ou é `/ck:research` de livro (§T848…§T852), que ⊥ pede
   tela nenhuma — **é por aí que a próxima rodada anda sem depender do user**, & `clan` (§T848) é
   a 1ª da fila.

---

### O QUE A 150ª FEZ — §T838, a lista `nature`/`demeanor`

**ENTREGUE:** `descNature_en.lua` & `descNature_pt.lua` na raiz do plugin, **46 entradas cada**,
na forma de §I21 (`<Livro>, p./pág. <n>` · 2 brancos · nome · 2 brancos · texto). PT é TRADUÇÃO,
⊥ extração — ⊥ ∃ livro em português desses arquétipos, & é o que `descBackground_pt.lua` já faz.
Terminologia seguida dos módulos PT que já ∃: **Força de Vontade** · **Narrador** · **Cainita** ·
**Príncipe** · **Clã** · **Sabá** · **Anarquista** · **Abraço** · `Masquerade` fica em INGLÊS.

**`popOpen` agora passa `'Nature'`** em vez de `nil` no `?` de nature/demeanor (`WoD20.1.lfm:105`)
∴ o `pcall` de §V364a carrega o módulo. Antes disso o `?` NUNCA acenderia, por mais que o arquivo
existisse — `descText` devolve `""` na 1ª guarda quando `kind` é nil.

**PARCIAL POR MEDIDA, & o user decidiu assim:** 68 arquétipos no picker, **46** c/ descrição nos
livros do disco. Os outros **22** abrem o `?` & caem na frase de §V360c, que é a resposta CERTA —
o que falta a eles é ARQUIVO. **6 deles ⊥ ∃ em livro nenhum** dos 25 PDFs (`Bureaucrat` `Comedian`
`Grifter` `Optimist` `Pragmatist` `Trendsetter`) ∴ vêm de um livro que o user ⊥ tem.

**O pipeline ficou versionado em `research/`** (`arch_extract.pl` `gen_nature.pl`
`arch_qa_words.pl` `arch_body_en.tsv` `arch_body_pt.tsv` `arch_names.txt`) c/ a receita & as
armadilhas no `research/README.md`. ⊥ refazer do zero: rodar de novo é `$env:ARCH_DIR` + 2 linhas.

---

### ✅ A DÍVIDA DE SPEC DESTA RODADA — PAGA NA PRÓPRIA RODADA (`/ck:spec amend`, gate VERDE 618/0)

Os 4 itens entraram no `SPEC.md`. §T **741 `x` · 100 `.` · 12 `~`** (era 740/94/13).

1. ✅ **§T838 ENCOLHEU p/ `nature`/`demeanor` & fechou em `x`.** As outras 5 listas viraram
   **§T848** `clan` (61) · **§T849** `road` (55) · **§T850** `family` (24) · **§T851**
   `hedgeAffiliation` (26) · **§T852** `hedgeAttr` (9), contadas do `PICKER_LIST` & ⊥ de memória.
2. ✅ **§R135 emendada c/ a fonte MEDIDA — & o número que este HANDOFF trazia estava ERRADO.**
   Ele dizia "V20 39 · M20 5 · DA 3 · LotC 2 · W20 1", que soma **50** & ⊥ 46. Contado do
   cabeçalho de §I21 das 46 entradas de `descNature_en.lua`: **V20 33 · DA20 6 · M20 5 · W20 2**
   = 46, & **0** de LotC. Multi-livro segue certo; a repartição, ⊥. Os 22 & os 6 entraram
   NOMEADOS, & ⊥ ∃ chave órfã (medido nos 2 sentidos).
3. ✅ **§I102e diz as DUAS raízes** — & ganhou a metade que quase ficou p/ trás: `popOpen` ! NOMEAR
   o módulo (`'Nature'`, `WoD20.1.lfm:105`), senão `mod` nil devolve `""` em `descText` & o `?`
   ⊥ acende c/ o arquivo em disco.
4. ✅ **§V366 NASCEU** cobrando PARTIÇÃO — 46 ⊎ 22 NOMEADOS = 68, disjunta & completa — nunca 68
   como alvo, & **§T853 já a levou p/ o gate na MESMA rodada** (`x`, gate **619 ok / 0 FAIL**).

### ✅ §T853 CONSTRUÍDA — §V366 no gate, & a mutação passou 7/7

**⊥ ∃ literal `46` nem `68` no gate, & isso é DECISÃO**: §V366c abençoa o número andar ("verde de
novo em 46+1/22−1") ∴ um `46` cravado ficaria VERMELHO exatamente no movimento que a spec pede.
O único literal é a **lista dos 22 nomes**; a partição deriva o resto, & os 3 números do `Pass`
são MEDIDOS, ⊥ afirmados.

**⊥ rodou `rdk` & ⊥ reinstalou, de propósito:** §T853 mexeu em **0** arquivo do plugin ∴ o `.rpk`
⊥ mudou. `rdk -l` só reescreveria o mesmo pacote & deixaria o instalado velho de novo — é o
install desperdiçado de §B103. O `.rpk` instalado segue o de **2.599.438 B**.

| mutação | esperado | resultado |
|---|---|---|
| **esvaziar a lista dos 22** (= alvo vira **68**) | VERMELHO | ✅ **22** FAIL |
| apagar 1 entrada do `_en` | VERMELHO | ✅ 2 FAIL, pernas (a)+(b) |
| tirar 1 chave só do `_pt` | VERMELHO | ✅ 2 FAIL, perna (a) |
| chave que ⊥ ∃ no picker (órfã) | VERMELHO | ✅ 2 FAIL, perna (b) |
| arquétipo novo no picker sem texto & sem nomear | VERMELHO | ✅ 1 FAIL, perna (b) |
| nome rançoso na lista de exceção | VERMELHO | ✅ 1 FAIL, perna (b) |
| `descNature_en.lua` some | VERMELHO | ✅ 1 FAIL, zero-guard (d) |
| **sonda:** reordenar as 46 entradas | VERDE | ✅ VERDE — mede CONJUNTO, ⊥ ordem |

⚠ **ARMADILHA NOVA, & ela quase virou acusação falsa contra a régua:** a mutação do picker passou
VERDE na 1ª tentativa & parecia buraco na invariante. **⊥ era — o regex da MUTAÇÃO é que ⊥ tinha
aplicado**, porque `WoD20th.lfm` é CRLF & o `s/…,\n/` pedia `,` colado no `\n` (os bytes reais são
`,\r\n`). Com `\r\n` no padrão, acendeu na hora. ∴ **mutação que sai VERDE ! provar que APLICOU
antes de virar veredito** — senão o teste que existe p/ pegar régua morta vira o que fabrica
régua morta.

⚠ **A lição da correção do item 2:** a repartição por livro foi ESCRITA neste HANDOFF sem ser
recontada do arquivo, & ela é da MESMA safra dos números que a armadilha 1 (↓) diz que eram
sorteio. Número que sobreviveu ao extrator ⊥ determinístico ! ser recontado antes de virar fato
de spec — foi o que salvou §R135 de nascer errada.

---

### ⛔ A FILA SEGUE TRAVADA EM TESTE DE TELA (medido na 149ª, ⊥ mudou)

| cadeia | trava em |
|---|---|
| ondas 2-5 → panes saem → 3 colunas Numina/Ghoul → §V361/§V362 → `hedgeAttr` | **§T810** `[USER]` |
| caixa em 2 tamanhos · resto das ondas | **§T827** `~` — ! VER a pane pintando (§B98) |
| §V353 no gate | **§T804** `[USER]` |

**De tela, & só o user roda:** `§T787` · `§T804` · `§T810` · `§T816` · `§T820` · `§T823` · `§T827`
· **§T845** (o `?` abre EDITÁVEL p/ o narrador & o texto dele sobrevive a fechar/reabrir) ·
**§T846/§T838** (o `?` de Nature/Demeanor agora mostra a descrição do livro — **depois de instalar**).

---

### ⚠ ARMADILHAS — 5 NOVAS, & as 3 primeiras geraram texto ERRADO que parecia certo

1. **`for my $b (...)` sombreia o `$b` do `sort`** ∴ a extração era NÃO determinística: 31, 34,
   39, 42 aceitas do MESMO input. Todo número medido antes disso era sorteio. ⊥ usar `$a`/`$b`
   como variável de laço em script que ordena.
2. **Calha de coluna de outra página corta palavra no meio & o resultado LÊ como prosa**
   (`"apathet cowards"`). Calha inferida ! passar o teste NAQUELA página antes de valer.
3. **QA automático ⊥ pega truncamento dentro da palavra** — `effi cient`, `judgt es`,
   `littl esteem` passaram por 6 regras & só cairam na LEITURA das 46 inteiras. **Ler o texto é
   parte do processo.** Eu declarei "limpo, nenhum apontamento" & estava errado.
4. **`use utf8;` ou os literais do script ⊥ casam** com dado decodificado (mordeu no `—` e no `pág.`).
5. **`pdftotext` sem `-enc UTF-8` sai em Latin-1** & o Perl morre na 1ª linha acentuada.

*(reconfirmadas)* `grep -c $'\r'` MENTE em arquivo CRLF (usar `tr -dc '\r' | wc -c`) · `sed -n`
come o CR · heredoc do bash grava LF & `SPEC.md` é CRLF · pegar nº de linha c/ `grep -n`.

---
## 149ª RODADA (2026-08-30) — SUPERADA pela 150ª acima; guardada pela tabela de travas & pelas armadilhas

**Estado:** gate **VERDE 618 ok / 0 FAIL** · `.rpk` **2.568.343 B**, instalada 17:57 na 148ª & **⊥
mudou nesta rodada** (§T847 é só gate, & gate ⊥ entra no `.rpk`) · §T **740 `x` · 95 `.` · 12 `~`** ·
**nada commitado**.

### ⛔ A FILA DE BUILD ESTÁ ESGOTADA, & ⊥ por falta de tarefa

**⊥ ∃ §T construível sem o user.** Varrido 2026-08-30: das **95** abertas, **58** são teste de tela
`[USER]`, & TODA cadeia restante funila por uma delas. ⊥ adianta pegar "a próxima da lista" — ela
está bloqueada, & buildar assim escreve régua contra estado que ainda ⊥ ∃ (§B92, & já custou 3 §B
só hoje: §B104 §B105 §B106).

| cadeia | trava em | destrava |
|---|---|---|
| §T811 (ondas 2-5) → ondas 3-5 → panes saem → §T830/§T831/§T832 → §T834/§T840/§T844 | **§T810** `[USER]` — o piloto na tela, 6 itens | user rodar §T810 |
| §T826 (caixa em 2 tamanhos) · §T836 (resto das ondas) | **§T827** `~` — ! **VER a pane pintando** antes de `x` (§B98) | user confirmar na tela |
| §T805 (§V353 no gate) | **§T804** `[USER]` | user rodar §T804 |
| §T838 (texto de 6 listas) | `/ck:research` + os livros | pedido do user |

**∴ o que pedir ao user:** rodar as de tela TODAS numa sessão — `§T787` · `§T804` · `§T810` ·
`§T816` · `§T820` · `§T823` — mais as 2 novas de §T845/§T846 (↓). §T810 & §T827 são as que mais
destravam.

---

### O QUE A 149ª FECHOU (⊥ refazer)

| §T | o quê | arquivo |
|---|---|---|
| `§T847` | `x` — **§V365 no gate**, 7 pernas + zero-guard, & **§V334 REESCRITA p/ contar do CÓDIGO** | `verify-hunters-hunted.ps1` |

**§B novo:** `§B106` — §V365a nasceria VERMELHA contra código certo (mandava `?` em `comboBox` que
lê `PICKER_LIST`, & ∃ **19** tags c/ **0** `?`). Achado ao PLANEJAR, ANTES de escrever régua ∴ custo
ZERO. **§V365a emendada pela 3ª vez**: escopo é a família **JÁ CONVERTIDA**, & converter = chamar
`mfOpen(`.

**A lição de §B106, & ela é de método:** emendar UMA perna ⊥ é emendar a invariante. §B105 consertou
(d) & deixou (a) com a redação do piloto, no MESMO commit. Quem toca 1 perna ! reler as outras que
dividem a mesma definição.

**§V365 como ficou** — 4 templates convertidos lidos do código, 3 c/ `?`, `SpecialityRow` nomeado
fora. A perna (a) **AUTO-APLICA §I102h**: no instante em que uma onda troca `comboBox` por `mfOpen(`,
o template entra no escopo & a rodada que ⊥ trouxer o `?` junto fica VERMELHA. ⊥ ∃ número escrito.

**§V334 ⊥ tem mais número escrito**: as panes saem de `//textEditor[@name='edt*Desc']`, são
conferidas contra `DESC_PANES` no Lua, & os botões contra `panes × 2`. Ela envelheceu 3× (8 → 9 →
2 prometidos) porque o número era digitado.

**MUTAÇÕES: 9 VERMELHAS + 1 sonda VERDE**, todas c/ backup & SHA256 conferido. Script em
`scratchpad/mut847.sh` — reusável.

---

### ⚠ ARMADILHA DE FERRAMENTA — 1 NOVA, & ela invalida mutação

**Mutação que ⊥ aplicou dá FALSO VERDE, & o gate ⊥ tem como avisar.** Na 148ª um `perl -i -pe
s/…$/…/` ⊥ casou (o `$` ancora antes do `\n` & o `\r` do CRLF fica no caminho), a mutação nunca
entrou, o gate saiu 0 & isso quase passou por "a régua ⊥ morde". **Régua: depois de mutar, PROVAR
que o arquivo mudou (`grep -c` do texto novo) ANTES de rodar o gate.** O driver `mut847.sh` já faz
isso & recusa contar mutação ⊥ aplicada — usar ele.

*(reconfirmadas)* `grep -c $'\r'` MENTE em arquivo CRLF (usar `tr -dc '\r' | wc -c`) · `sed -n`
come o CR · heredoc do bash grava LF & o `SPEC.md` é CRLF (`perl -pe 's/\n/\r\n/'` antes de anexar)
· pegar nº de linha c/ `grep -n`, nunca contando em cima de amostra de `sed`.

---

### ⛔ O QUE ⊥ FAZER

- ⊥ pegar "a próxima §T" sem olhar a tabela de travas acima — todas as restantes esperam tela.
- ⊥ construir §T834 (§V361) antes de §T830/§T832: §V361a mede "⊥ declaram `tabControl`" & hoje a
  Numina TEM sub-aba ∴ nasceria VERMELHA (§B92).
- ⊥ emendar §V334 p/ número escrito — ela agora deriva, & foi o número que a fez envelhecer 3×.
- ⊥ rodar `rdk -i` com ficha ABERTA sem avisar — 1× no fim da rodada (§B103).
- ⊥ commitar sem pedido direto na mensagem (`CLAUDE.md`).
- ⊥ escrever §V/§I/§B por `/ck:build` — só `/ck:spec` escreve seção.

### DE TELA, & só o user roda — TODAS juntas numa sessão

`§T787` · `§T804` · `§T810` · `§T816` · `§T820` · `§T823` · `§T827` (ver a pane PINTANDO, §B98)
· **§T845**: o `?` de mérito/antecedente abre EDITÁVEL p/ o narrador & o que ele escrever sobrevive
a fechar & reabrir a ficha · **§T846**: o `?` de Nature/Demeanor abre & diz `No description
available` (⊥ é buraco — o texto chega em §T838).

---
## 148ª RODADA (2026-08-30) — SUPERADA pela 149ª acima; guardada pelas armadilhas & pelas 4 decisões

**Estado:** gate **VERDE 617 ok / 0 FAIL** · `.rpk` **2.568.343 B** gerada **e instalada** 17:57 ·
§T **739 `x` · 96 `.` · 12 `~`** · **nada commitado**.

**⊥ ∃ nada bloqueando `/ck:build`** — mas a fila mudou de forma, ↓ leia A FILA antes de pegar §T.

---

### O QUE A 148ª FECHOU (⊥ refazer)

| §T | o quê | arquivo |
|---|---|---|
| `§T845` | `x` — o `?` abre EDITÁVEL p/ o narrador. `popOpen` ganhou 5º param `row`; global `popRow`; `savePopDesc` grava por `descFieldOf`; texto do narrador VENCE o livro & esvaziar devolve o livro | `WoD20th.lfm` `WoD20.2.lfm` gate |
| `§T846` | `x` — **REESCRITA & encolhida**: `?` só no `HeaderPicker` (nature/demeanor). 0 pane saiu | `WoD20.1.lfm` `WoD20th.lfm` gate |

**§B novos:** `§B103` (install c/ ficha aberta = form velho na tela; a regra é de OPERAÇÃO) ·
`§B104` (§V365f copiou `edtSpentXP` p/ pane que §V111(2) promete brilhante — o gate acendeu) ·
`§B105` (§V365 vetou o dono 2×; **3ª vez** do padrão de §B99/§B100).

**§V365 EMENDADA em 4 pernas:** (a) ganhou `SpecialityRow` como exceção NOMEADA & ela corta nos
2 sentidos · (c) reescrita p/ separar "ainda ⊥ tem arquivo" de "⊥ TERÁ arquivo" · (d) mede
**por família JÁ convertida**, ⊥ a ficha de uma vez · (f) `readOnly` SOZINHO & `opacity` PROIBIDA.

**`CLAUDE.md` emendado** (§B103): `rdk -i` **1× por RODADA, no fim** — ⊥ por §T — & avisar antes
se a ficha puder estar aberta. + bullet: diferença de size que ⊥ muda nada p/ o user ⊥ é motivo
p/ reinstalar.

**4 DEFEITOS que só CONSTRUIR achou:**
1. `popOpen` escrevia `.text` SEM `descQuiet` — `gui.TextEditor` só tem `onChange` ∴ abrir o `?`
   teria GRAVADO o texto do livro em toda linha que o narrador olhasse, calado.
2. Escrever sem LER de volta = narrador digita, fecha, reabre & acha o livro. Recurso apagado
   de lado (§I102i).
3. `popOpen` ⊥ tinha a frase de §V360c ∴ o `?` de nature/demeanor (sem módulo até §T838) abriria
   caixa VAZIA. Corrigido c/ o mesmo one-liner de `mfSelect`.
4. **§V26 acendeu & mudou o desenho de §T846**: o `?` ⊥ pode deslocar a entrada, & a coluna
   `left=326` mistura `HeaderPicker` (nature, demeanor) c/ `Header` (concept) ∴ o `<edit>` de
   **`Header` também foi de 112/215 p/ 132/195** — é por isso que um template que ⊥ ganhou `?`
   mudou de geometria. Modelo de §I102f: o vão do `?` é da FAMÍLIA & a linha sem picker o deixa
   VAZIO, ≡ `MeritFree`. ⚠ o label ⊥ encolhe: `WoD20.1.lfm:92` diz que os 105px são o que
   `Comportamento` precisa em pt. §V16 ⊥ é problema — o placeholder (24 chars = 156px) cabe nos
   195 c/ 39 de folga, MEDIDO, & a ressalva que a 1ª escrita de §T846 abriu foi RETIRADA.

---

### DECISÕES DO USER 2026-08-30 (148ª) — já ∈ `SPEC.md`, ⊥ perguntar de novo

1. **`speciality` ⊥ leva `?`** — é EXCEÇÃO NOMEADA de §V365a, & pôr `?` nele ! FAIL igual.
2. **As 7 panes ⊥ saem de uma vez** — CADA pane sai na rodada em que a família DELA ganha `?`.
   ∴ §T830 & §T832 seguem BLOQUEADAS, & o custo foi ACEITO.
3. **O corte do `HeaderPicker` sai do BOTÃO** (215→195), ⊥ do label.
4. **Install 1× por rodada, no fim**, & avisar antes se a ficha puder estar aberta.

---

### A FILA, na ordem

`§T847` (gate §V365, 7 pernas) → `§T834`/`§T840` (§V361/§V362) → `§T838` (`/ck:research`, texto
p/ 6 listas) → ondas 3-5 de §I113e, & CADA uma leva o `?` da família + a saída da pane DELA
junto → só então `§T830`/`§T831` (Numina) & `§T832` (Ghoul).

**Notas p/ quem construir:**
- **§T847:** a perna (f) ! nascer c/ `opacity` PROIBIDA, ⊥ pareada — §B104. A perna (a) ! excetuar
  `SpecialityRow` por NOME — §B105. A perna (d) mede POR FAMÍLIA CONVERTIDA, ⊥ as 7 de uma vez.
- ⚠ **§I117e §I118d §I103 §V334 estão ADIANTADAS em relação ao código**: prometem as 7 panes fora
  & o zoom em 2 alvos. §V334 mede por CONTAGEM ∴ **⊥ emendar §V334 p/ 2 panes/4 botões** antes de
  as panes saírem, senão nasce VERMELHA contra código certo (§B92).
- **§T830/§T832** seguem bloqueadas por decisão 2 acima, ⊥ por §T846 — ela já fechou.

---

### ⚠ ARMADILHAS DE FERRAMENTA — 5 NOVAS medidas nesta rodada

1. **`grep -c $'\r'` MENTE no Git Bash** — devolve **0** num arquivo que É CRLF. Custou um susto de
   "estraguei o arquivo" com o arquivo intacto. Régua: `tr -dc '\r' < f | wc -c` & comparar c/ `\n`.
2. **Perl `s/…$/…/` ⊥ casa em arquivo CRLF**: o `$` ancora antes do `\n` & o `\r` fica no caminho.
   Isso deu **mutação FALSO-VERDE** — o gate saiu 0 porque a mutação nunca aplicou. Régua: depois
   de mutar, **conferir que o arquivo mudou** (`grep -c` do texto novo) ANTES de rodar o gate.
3. **Número de linha de `sed -n 'N,Mp'` de amostra ⊥ é o número real** — errei em 1 & o splice comeu
   o `-->` que fechava um comentário, quebrando o XML inteiro (`FAIL XML … DotNetMethodException`).
   Régua: pegar a linha com `grep -n` do texto exato, nunca contar em cima de uma amostra.
4. **`paste -d''` corrompe** — junta errado & clobbera. Régua p/ montar linha:
   `{ tr -d '\n' < corpo; printf '|%s\n' "$cites"; } > row`.
5. **§V318 pega heredoc no `SPEC.md`**: heredoc grava LF & o `SPEC.md` é CRLF ∴ toda linha nova !
   passar por `perl -pe 's/\n/\r\n/'` antes de anexar. 2 linhas minhas acenderam o gate.

*(já conhecidas, reconfirmadas)* `sed -i` normaliza p/ LF · o tool `Write` escreve ESPAÇOS & os
`.lfm` usam TABS · `$o = .\gate.ps1 2>&1` vem VAZIO no PS 5.1.

---

### ⛔ O QUE ⊥ FAZER

- ⊥ rodar `rdk -i` com ficha ABERTA sem avisar — **1× no fim da rodada** (§B103, `CLAUDE.md`).
- ⊥ perseguir diferença de bytes entre `output/` & o instalado: 2 bytes entre 2 compilações é
  normal & ⊥ muda nada p/ o user.
- ⊥ pôr `?` em `SpecialityRow` nem em linha DIGITADA.
- ⊥ emendar §V334 p/ 2/4 antes de as panes saírem.
- ⊥ commitar. Neste projeto o Claude **⊥ commita** sem pedido direto na mensagem (`CLAUDE.md`).
- ⊥ escrever §V/§I/§B por `/ck:build` — só `/ck:spec` escreve seção.

### DE TELA, & só o user roda — TODAS juntas numa sessão

`§T787` · `§T804` · `§T810` · `§T816` · `§T820` · `§T823` · **+ §T845/§T846 novas**: o `?` de
nature/demeanor abre & diz `No description available`; o `?` de mérito/antecedente abre EDITÁVEL
p/ o narrador & o que ele escrever sobrevive a fechar & reabrir.

---
## 147ª RODADA (2026-08-30) — SUPERADA pela 148ª acima; guardada pelas medidas do bug das abas

**Estado:** gate **VERDE 617 ok / 0 FAIL** · `.rpk` **2.564.393 B** gerada **e instalada** 15:23 ·
§T **737 `x` · 98 `.` · 12 `~`** · **nada commitado**.

**A 1ª COISA:** o "bug das abas" da 147ª foi **RESOLVIDO & ⊥ era código** ↓. Pode ir direto p/ a
FILA. ⊥ ∃ nada bloqueando `/ck:build`.

**Leia nesta ordem:** ABAS (resolvido, mas a REGRA vale) → O QUE A 147ª FECHOU → A DECISÃO NOVA →
A FILA → ARMADILHAS.

---

### ✅ O "BUG DAS ABAS" — RESOLVIDO, & a lição é OPERACIONAL, ⊥ de código

Relato do user 2026-08-30: `Show Numina` & `Show Ghoul` MARCADOS & as 2 abas **⊥ apareciam**.
**FECHADO no mesmo dia pelo teste do user**, & o resultado ⊥ deixa dúvida:

| teste | resultado | o que MATA |
|---|---|---|
| desmarcar & marcar os 2 checkboxes | aba **⊥ volta** | mata a hipótese do `== true` estrito |
| **fechar & reabrir a ficha** | **volta a funcionar normalmente** | mata TODA hipótese de código |
| a aba `Storyteller` aparece? | **aparece** | a barra & `applyTabVisibility` estão sãos |

**CAUSA: o `.rpk` foi instalado 3× (14:52 · 14:54 · 15:23) c/ o Firecast aberto & a ficha
carregada.** Plugin trocado por baixo de ficha aberta deixa o FORM VELHO na tela c/ o código novo
atrás ∴ controle some & nenhum handler o traz de volta — só reabrir a ficha. Se fosse defeito de
código, reabrir ⊥ curaria: as mesmas 8 `dataLink` seguiriam lá.

**REGRA, & ela é p/ o Claude, ⊥ p/ o user:** `rdk -i` com ficha ABERTA no Firecast ⊥ é neutro.
Ou avisar ANTES de instalar, ou instalar **1×** no fim da rodada, ⊥ a cada §T. Esta rodada
instalou 3× & gastou meia sessão perseguindo um fantasma. ⊥ ∃ check estático p/ isto — o que ∃
é a regra, & ela mora aqui & em §B103 (se `/ck:spec` a escrever).

**O que a caçada MEDIU & segue valendo (⊥ refazer):** o `.rpk` contém os 5 `.lfm` das 2 abas · o
Lua COMPILADO tem `applyTabVisibility` (7×) `tabNumina` (12×) `tabDisciplines` (12×) · §V347 media
**50/50** JÁ no 1º gate, antes de código novo · `git diff HEAD` na região da barra = **0 linhas**
(`tabNumina` `tabDisciplines` `btnTab*` `tabOn*` `TAB_LIST` `TAB_W` `applyTabVisibility` `STRIP_*`
são byte a byte o commit) · `xpFind` é walker recursivo simples, sem saída antecipada.

⚠ **⊥ trocar `stShowDisciplines == true` por `~= false`.** A leitura estrita ⊥ tem culpa nenhuma
aqui, & afrouxá-la mudaria o DEFAULT do Ghoul de desligado p/ ligado — decisão de produto que ⊥
está pedida em §Q nenhuma.

---
### O QUE A 147ª FECHOU (⊥ refazer)

| §T | o quê | arquivo |
|---|---|---|
| `§T839` | só o STATUS — o `pcall` já estava no código, o `SPEC.md` é que estava atrás | — |
| `§T841` | **§V354 REESCRITA** no gate: (b) coerência · (e) 3 formas · (g) por raiz · (h) nomeada · (i) completude | `verify-hunters-hunted.ps1` |
| `§T842` | **onda 2 de §I113e**: `HeaderPicker` (nature/demeanor) & `SpecialityRow` viram caixa de busca | `WoD20.1.lfm` `WoD20th.lfm` `WoD20.6.lfm` `localization.lang` |
| `§T619` `§T759` `§T775` | `.` → `x` — fechadas por revogação/supersessão, ⊥ por construção | — |
| `§T843` | `~` — §V356 de 6 p/ **7** (só `dominatorGen`); `hedgeAttr` RECUSADO c/ motivo medido | `verify-hunters-hunted.ps1` |
| `§T840` | `~` — metade **§V364** no gate (7 pernas). A metade §V362 espera §T830/§T832 | `verify-hunters-hunted.ps1` |

**MUTAÇÕES RODADAS & TODAS CONFORMES:** §V354 (8 VERMELHAS + 1 sonda VERDE) · onda 2 (5 VERMELHAS
+ 1 sonda) · §V356 (2 VERMELHAS) · §V364 (5 VERMELHAS + 1 sonda). Bancada c/ backup ANTES & SHA256
conferido; todos os arquivos voltaram byte a byte.

**§B novos:** `§B100` (§V354 virou régua de 1 onda) · `§B101` (§Q31 respondida sobre premissa
falsa) · `§B102` (§I117/§I118 desenharam 3 colunas sem somar se cabiam).

**4 DEFEITOS que só CONSTRUIR achou, & os 2 primeiros estavam SEM GUARDA:**
1. `MF.mod = mod or "Merit"` — onda sem módulo mostraria descrição de MÉRITO p/ arquétipo.
   Corrigido & agora guardado por §V364f.
2. `pcall(require, "desc" .. MF.mod ..)` — a concatenação é ARGUMENTO ∴ roda ANTES do `pcall` &
   c/ `mod` nil levanta FORA do guarda. Era §B99 de volta. Corrigido & guardado por §V364g.
3. A perna (i) de §V354 cobria TEMPLATE & ⊥ RAIZ — tirar `demeanor` do roster ficava VERDE.
   Corrigido c/ completude por raiz na forma avulsa.
4. §Q31 dizia que `hedgeAttr` é combo de VALOR; o `WoD20.7.lfm` diz o contrário no próprio
   comentário (`cbo, not cmb: this is a picker of PROSE`). §B101.

---

### A DECISÃO NOVA DO USER 2026-08-30 — já ∈ `SPEC.md`, ⊥ perguntar de novo

**`?` ao lado de TODO picker, & clicar mostra a descrição** (§I102h). ⊥ é regra das 2 abas que a
pediram — é da ficha inteira. E o **`?` abre EDITÁVEL p/ o narrador** (§I102i, confirmado).

∴ **as 7 panes de DESCRIPTION SAEM** (§I117e, §I118d): `edtHedgeDesc` `edtHedgeRitualDesc`
`edtPsychicDesc` `edtFaithDesc` (`WoD20.7`) · `edtDiscDesc` (`.12`) · `edtPathDesc` (`.13`) ·
`edtRitualDesc` (`.14`). **O TEXTO ⊥ sai junto** — ele mora em `descFieldOf(<linha>)` (§I45) &
segue lá; some a JANELA, ⊥ o dado (§V365e).

**A aritmética que destravou tudo (MEDIDA, §B102):** Numina — listas somam **1622** (450+586+586)
contra **1410**; Ghoul — **1475** (390+565+520) contra **1070**. ⊥ cabia ANTES de contar pane
nenhuma. Com as panes fora, as colunas encolhem p/ ~460 (Numina) & ~350 (Ghoul).

⚠ **o Ghoul já vem QUASE pronto**: `WoD20.12` = col.1 (`Clan Disciplines`+`Disciplines`) ·
`WoD20.13` = col.2 (`Main Paths`+`Secondary Paths`) · `WoD20.14` = col.3 (`Rituals`) ∴ §T832 é
tirar o `vampStrip`, tirar as panes & pôr os 3 `<import>` lado a lado — ⊥ redesenhar caixa nenhuma.

---

### A FILA, na ordem

`§T845` (o `?` editável — MECANISMO) → `§T846` (`?` em toda família + as 7 panes saem) →
`§T830`/`§T831` (Numina) → `§T832` (Ghoul) → `§T847` (gate §V365 + §V334) → `§T834`/`§T840`
(§V361/§V362) → `§T844` (`hedgeAttr` vira caixa) → `§T838` (extração, precisa dos livros).

**Notas p/ quem construir, MEDIDAS nesta rodada:**
- **§T845:** `popOpen` recebe `kind`+`key`+`sub` mas **⊥ a LINHA** — p/ gravar ela precisa saber
  qual linha abriu, & isso é 1 parâmetro a mais ≡ `mod` já é em `mfOpen`. ⊥ inventar roster.
- **§T846:** MEDIDO que só **2** templates autoram `?` hoje (`MeritPicked` `OpenAbility`).
  ⚠ **⊥ foi medido se ∃ VÃO p/ o `?` nas outras famílias** — nos antecedentes/qualidades ele cabe
  no vão que já ∃ (§I102f); se ⊥ houver vão, alguém encolhe & isso é **decisão do user**, ⊥ chute.
- **§T846 leva §I103 & §V334 junto**: zoom de fonte cai de 8 alvos p/ **2** & §V334b de 9 panes/18
  botões p/ **2/4**. As 2 réguas JÁ foram emendadas; §T846 ⊥ fecha sem §V334 VERDE.
- **§T830:** `psychic` = 15 picker (`_1`…`_15`) + 5 digitadas (`_20`…`_24`), c/ BURACO de
  numeração assumido (§Q32). As constantes **⊥ mudam**: `PSYCHIC_ROWS` fica **24** (é o MAIOR
  ÍNDICE & `XP_NUMINA[g].count` anda `1..count` p/ alcançar `psychic_24`) & `TYPED_ROW_FROM.psychic
  = 24−5+1 = 20` segue certa. O que quebra é **§V263(a)**, já emendada p/ ler o buraco.
- **§T834/§T840:** ⊥ antes de §T830/§T832 — §V362 mede o ANTES contra o DEPOIS (§B92).

---

### ⚠ ARMADILHAS DE FERRAMENTA — 4 NOVAS medidas nesta rodada, & todas custaram tempo

1. **`sed -i` do Git Bash NORMALIZA o arquivo inteiro p/ LF.** Um `sed -i 's/^T839|\.|/T839|x|/'`
   no `SPEC.md` (CRLF) apagou **3620 CR** de uma vez. Régua: `cp` ANTES, & trocar linha por
   NÚMERO via `head`/`tail`, nunca `sed -i`.
2. **`sed -n 'N,Mp'` também come o CR na SAÍDA.** Splice feito com ele gerou arquivo meio-LF.
   `head -n N` & `tail -n +N` preservam bytes; `sed`/`awk` ⊥.
3. **O tool `Write` escreve com ESPAÇOS.** Os `.lfm` usam TABS, & o `LuaFn` do gate extrai função
   até `\n\t\t\tend;` ∴ um bloco indentado com espaço fez o extrator PASSAR DIRETO pelo fim da
   função & capturar **13.213 caracteres**, acendendo §V163 por motivo falso. Régua: depois de
   escrever bloco em `.lfm`, converter espaço→tab (`sed ':a;s/^\(\t*\)  /\1\t/;ta'`) & conferir
   `grep -c '^ '` = 0.
4. **§V164 conta `renderSpecialities(` por TEXTO CRU, comentário incluído** — comentário novo c/ o
   nome derruba o gate. É a família de §V166 (`sheetBody`). Régua: ⊥ escrever o nome da função
   dentro de comentário que fale dela.
5. *(já conhecida, reconfirmada)* **`$o = .\gate.ps1 2>&1` vem VAZIO no PS 5.1** — o gate usa
   `Write-Host`. Rodar `powershell.exe -NoProfile -File … > log 2>&1` & contar NO ARQUIVO, c/
   `sed '1s/^\xef\xbb\xbf//'` antes (o `>` grava BOM & come a 1ª linha do `grep`).

---

### ⛔ O QUE ⊥ FAZER

- ⊥ rodar `rdk -i` com ficha ABERTA no Firecast sem avisar — instalar **1×** no fim da rodada.
- ⊥ trocar `stShowDisciplines == true` por `~= false`: mudaria o DEFAULT do Ghoul (§Q nenhuma pede).
- ⊥ construir §T846 chutando onde o `?` cabe nas famílias sem vão medido.
- ⊥ commitar. Neste projeto o Claude **⊥ commita** sem pedido direto na mensagem (`CLAUDE.md`).
- ⊥ escrever §V/§I/§B por `/ck:build` — só `/ck:spec` escreve seção.

### DE TELA, & só o user roda — TODAS juntas numa sessão

`§T787` · `§T804` · `§T810` · `§T816` · `§T820` · `§T823`.

---


## 146ª RODADA (2026-08-30) — SUPERADA pela 147ª acima; guardada pela receita da onda & pelas armadilhas

**Estado:** gate **VERDE 620 ok / 0 FAIL** (**622** com `-Build`) · `.rpk` **2.560.293 B** gerada
**e instalada** 13:09 · §T **731 `x` · 99 `.` · 10 `~`** · **nada commitado**.

**⛔ ⊥ COMECE POR `/ck:build`.** A 1ª coisa desta sessão é **1 `/ck:spec`**, & o texto exato dele
está em **"O QUE PEDIR AGORA"** ↓. Sem ele, **§T836 & §T826 seguem impossíveis** — ⊥ difíceis,
IMPOSSÍVEIS: o check de §V354 PROÍBE o que §V364 tornou legal (↓ §B100 a escrever).

**Leia nesta ordem:** esta seção INTEIRA → **O QUE PEDIR AGORA** → **ARMADILHAS** → a 145ª abaixo.

### O QUE A 146ª FECHOU (⊥ refazer)

| §T | o quê | arquivo |
|---|---|---|
| `§T824` | versão → `0.1.1` | `WoD20.6.lfm` + `localization.lang` |
| `§T825` | **§V363** no gate, 3 pernas | `verify-hunters-hunted.ps1` |
| `§T833` | Ghoul: DOMINATOR 136→138 & `Clan/Family` 92→88 | `WoD20.11.lfm` |
| `§T835` | Experience +20px (baixo: tudo p/ `Trait`) | `WoD20.9.lfm` |
| `§T839` | `pcall` nos **2** sítios de `require` de descrição | `WoD20th.lfm` |

**`§T827` & `§T828` ficaram `~` DE PROPÓSITO** — §T827 espera TELA (§B98), §T828 espera §V359,
que espera §T826.

**MUTAÇÕES RODADAS & TODAS CONFORMES:** §V357 (4) · §V358 (6+1 refeita) · §V363 (3) · §V360 (7) ·
§V352(e) alargada (3). Bancada c/ backup antes & SHA256 conferido; os `.lfm` voltaram byte a byte.

### DECISÕES DO USER 2026-08-30 — já ∈ `SPEC.md` §C, ⊥ perguntar de novo

- **§Q32:** `psychic` vai a **20** & os 4 excedentes são **APAGADOS DE VEZ** (⊥ órfão). JULGAMENTO
  meu de QUAIS: saem `psychic_16`…`_19` (pickers), ⊥ `_21`…`_24` — assim ⊥ ∃ campo mudando de
  SENTIDO. `numina` vai a 20 c/ **3** pickers novos, `_18` `_19` `_20`
- **§Q31:** `dominatorGen` & `hedgeAttr` **FICAM dropdown** (combos de VALOR) ∴ §V356 cobre **8**
- **§Q33:** extrair descrição p/ **6** listas; **`speciality` ⊥ terá descrição NUNCA**

### ⚠ O BLOQUEIO REAL, & é o motivo do `/ck:spec` vir antes

`§V354` nasceu quando ∃ **1** onda (antecedentes) & virou a régua DAQUELA onda em vez da regra da
FAMÍLIA. **MEDIDO na 146ª, construindo a onda `nature`/`demeanor` INTEIRA & desfazendo depois:**

1. **§V354(b) exige que `desc<Mod>_en.lua` EXISTA.** ∴ o check **proíbe converter lista sem
   módulo** — que é EXATAMENTE o que §V364/§I116c tornaram legal na mesma rodada, & o que §Q33
   OBRIGA a permitir (`speciality` nunca terá módulo, & ela é o motivo de §T826 ∃)
2. **§V354(e) conta `<Tpl field="root_N">`.** As linhas de `HeaderPicker` são `field="nature"` &
   `field="demeanor"` — SEM número & c/ 2 raízes ∴ ⊥ cabem no roster

**A onda FOI construída, buildou 0 & o gate deu 618/0** — & foi REVERTIDA porque os contadores
caíram **924→856** strings, **21→20** pickers, **16→15** combos: os **68** arquétipos saíram do
conjunto medido & o guarda deles (§V354) ⊥ os aceitava. Gate verde que parou de medir 68 strings
é §B94 outra vez. **A receita da onda está toda aqui ↓ — refazer custa minutos.**

### A ONDA `nature`/`demeanor`, MEDIDA & PRONTA (refazer DEPOIS do `/ck:spec`)

- **`WoD20.1.lfm`** template `HeaderPicker` (linha ~96) — o `<comboBox name="cbo$(field)">` vira:
  - `<button name="dyn$(field)" left="112" top="0" width="215" height="25" text="Select $(nome)" onClick="mfOpen(self, '$(field)', '$(field)', 'Nature');"/>`
  - `<edit name="edt$(field)" left="112" top="0" width="215" height="25" field="$(field)" visible="false" enabled="false"/>`
- **`WoD20th.lfm`** — `function renderHeaderButtons(from)` **GLOBAL** (teto de locais é 53 c/ 49
  usados, §V347), ≡ `renderBgButtons`: `xpFind` por `dynnature`/`dyndemeanor` & `mfLabel(...,
  "Select Nature"/"Select Demeanor", lang)`. Declarar ANTES de `renderMeritButtons`
- **`WoD20th.lfm`** — `<dataLink fields="{'nature', 'demeanor'}">` c/ `renderHeaderButtons(self);`,
  ao lado do dos 16 antecedentes (~linha 5255), **&** 1 chamada no `onNodeReady` depois de
  `renderBgButtons(self);`
- **`localization.lang`** (LF, ⊥ CRLF) — `wod.Select Nature=` & `wod.Select Demeanor=` nas **2**
  metades · **`WoD20.6.lfm`** mapa PT — as 2 chaves depois de `["Select Merit"]`
- `mod` = `'Nature'` p/ AS DUAS: 1 módulo servirá as 2, ≡ `PICKER_LIST["demeanor"]` já é o de
  `nature` por identidade

### ⚠ ARMADILHAS MEDIDAS (as 3 primeiras são de FERRAMENTA & já custaram caro)

1. **`Write-Host` ⊥ entra em `$o = .\gate.ps1 2>&1` no PS 5.1.** A 1ª bancada de mutação leu `$o`
   VAZIO & deu **GREEN nas 3 que deviam ser RED** — teria "provado" um check no-op. Régua: rodar
   por `& powershell.exe -File … > log 2>&1` & contar **no arquivo**
2. **O `>` do PowerShell grava BOM** ∴ `grep '^ok'` perde a 1ª linha & a contagem sai 1 a menos,
   parecendo regressão. `sed '1s/^\xef\xbb\xbf//'` antes de contar
3. **`sed` c/ regex mal escapado escreveu o GATE VAZIO (0 bytes).** Salvou o backup feito no mesmo
   comando. Régua: `cp` ANTES de tocar, & p/ linha complexa trocar a LINHA INTEIRA por número
4. **§V166 conta o literal `sheetBody` em TODO `.lfm`, comentário incluído** — comentário novo c/
   a palavra derruba o gate. Escrever "a ficha"
5. **§V53:** `strokeColor` ! ser chave dos mapas `stroke` — só `white` `#FFFFFF` `black`
   `#00000000`. `DimGray` acende 4×
6. **§V280/§V240:** ∀ lado de caixa de seção limpa **20px**. As bolinhas da bloodpool JÁ estão no
   limite (58/93): centralizar de verdade pede 59 & derruba a margem p/ 19
7. **§V256:** mover um campo ! mover o `<rectangle>` de fundo dele JUNTO

### O QUE PEDIR AGORA — 1º `/ck:spec`, DEPOIS `/ck:build`

O texto exato do `/ck:spec` está na mensagem que o Claude entregou junto deste handoff. Ele emenda
**§V354** em 2 pontos (módulo deixa de ser exigência & vira coerência · forma "raiz sem número") &
abre **§B100** registrando que §V354 virou régua-de-1-onda. Depois dele, na ORDEM:

`§T836` (onda `nature`/`demeanor`, receita ↑) → `§T826` (caixa estreita) → `§T828` (§V359) →
`§T830`/`§T831` (Numina) → `§T832` (Ghoul) → `§T834` (§V361/§V362) → `§T840` (§V364) → `§T838`
(extração, precisa dos livros).

⚠ **`§T840` ⊥ pode vir antes de `§T830`/`§T832`**: §V362 mede o ANTES contra o DEPOIS de uma
reestruturação que ainda ⊥ aconteceu ∴ escrita agora ela passa verde medindo o nada (§B92).

### DE TELA, & só o user roda — TODAS juntas numa sessão

`§T787` (4 pontos abertos; o **(5)** DESTRAVOU — §T761 está `x`, & o texto da linha ainda diz
BLOQUEADO) · `§T804` (a linha de foco JÁ está no código; `setFocus()` ∃ em `rrpgGUI.lua:58` ∴ os
3 candidatos viraram 1 — falta só saber se o HOST honra) · `§T810` · `§T816` · `§T820` · **`§T823`**

⚠ **`§T823` ganhou uma SONDA de graça:** o fallback de §T827 distingue as 2 causas de §B98 — se a
pane mostrar **`No description available`**, `descText` devolveu vazio (problema de DADO); se
continuar **em branco**, a escrita ⊥ chega no controle (problema de CAMINHO). Causas opostas,
consertos opostos.

**§B98 já teve 3 hipóteses MORTAS pelo print do user:** `edtPopDesc` (que PINTA) & `edtMfDesc`
(que ⊥ pinta) são **idênticos atributo por atributo** — `readOnly` `wordWrap` `transparent`
`fontSize`. ∴ ⊥ é a forma do controle, ⊥ é `.text` de `textEditor`, ⊥ é `transparent`. E `mod`/
`list`/chave também foram conferidos & estão certos.

---

## 145ª RODADA (2026-08-30) — SUPERADA

**Estado:** gate **VERDE 618 ok / 0 FAIL** (**620** com `-Build`) · `.rpk` **2.557.022 B** gerada
**e instalada** 01:45:17/18 · §T **725 `x`** · **nada commitado**.

**⚠ o "⛔ ⊥ PEÇA `/ck:build` DE NOVO" da 144ª logo abaixo MENTIA quando esta rodada abriu.** Ele
foi escrito antes de `§B96`/`§V357`/`§T818`…`§T820` entrarem no working tree por outra sessão, e
esta rodada acrescentou `§B97`/`§V358`/`§T821`…`§T823`. `/ck:build --all` achou **4** linhas
construíveis e fechou as 4. Lição: o HANDOFF envelhece calado — **conferir `§T` no `SPEC.md`
antes de acreditar na contagem daqui**.

### O QUE A 145ª FECHOU (⊥ refazer)

| §T | o quê | arquivo |
|---|---|---|
| `§T818` | tirar `MF.btn` — a tabela `MF`, a escrita em `mfOpen` e o bloco de `mfConfirm` + o comentário que citava §I107a2 errado | `WoD20th.lfm` (5301→5299 linhas) |
| `§T819` | **§V357** no gate, 3 pernas + zero-guard | `verify-hunters-hunted.ps1` |
| `§T821` | o repasse do enfeite: memo ganha `c`, `ornRemeasure()` GLOBAL, `setTimeout(…, 1)` DEPOIS de `sheetReveal` | `WoD20.6.lfm` (4794→4842) |
| `§T822` | **§V358** no gate, 5 pernas + zero-guard | `verify-hunters-hunted.ps1` |

**§B97 — a causa, medida no fonte:** `ornament()` lê `c.width`/`c.height` na CRIAÇÃO e o único
guarda é `bw == nil`; as 73 caixas são `<rectangle align="client">` ∴ o tamanho vem da passada de
alinhamento, e `getWidth` é `_obj_getProp` (`rrpgGUI.lua:95`), que devolve o último valor escrito
e **nunca nil** ∴ o guarda ⊥ tem o que pegar. A criação roda com o corpo da ficha ESCONDIDO (a
revelação é a ÚLTIMA linha do MESMO handler) e `applyTheme` tem **1** call site ∴ o memo carimba a
medida errada p/ sempre. Cura = MEDIR DE NOVO, **⊥ RECUSAR** — piso deixaria a caixa lisa (§V279).

### AS MUTAÇÕES — todas conforme (§V20)

`§V357`: `mfLabel(MF.btn, …)` de volta ! **RED (2)** · `MF.btn = from;` de volta ! **RED** ·
`from.opacity = 1;` ! **RED** · sonda `mfLabel(found[…])` a mais ! **GREEN**.

`§V358`: repasse antes da revelação **movido** ! **RED (ramo de ORDEM)** · 2º repasse ! **RED
(ramo de CONTAGEM)** · corpo vira `applyTheme` ! **RED (+§V223 de brinde)** · `c.width` como `w` !
**RED (2)** · `local function` ! **RED** · memo sem `c = c` ! **RED** · sonda intervalo 1→50 !
**GREEN**. Bancada c/ backup antes e SHA256 conferido no fim; os 2 `.lfm` voltaram byte a byte.

### ⚠ 2 ARMADILHAS DE FERRAMENTA MEDIDAS NESTA RODADA

1. **`Write-Host` ⊥ entra em `$o = .\gate.ps1 2>&1` no PS 5.1.** A 1ª bancada de mutação leu
   `$o` VAZIO e deu **GREEN nas 3 que deviam ser RED** — teria "provado" um check no-op. Régua:
   rodar o gate por `& powershell.exe -File … > log 2>&1` e contar **no arquivo**, ⊥ na variável.
2. **O `>` do PowerShell grava BOM.** `grep '^ok'` perde a 1ª linha ∴ a contagem sai 1 a menos e
   parece regressão. `sed '1s/^\xef\xbb\xbf//'` antes de contar.

### ⚠ 1 ARMADILHA DE CÓDIGO

**§V166 conta o literal `sheetBody` em TODO `.lfm`, comentário incluído.** Um comentário novo que
escrevesse a palavra derrubou o gate. Ao comentar perto da revelação, escrever "a ficha", ⊥ o nome.

**A PRÓXIMA SESSÃO SEGUE DE TELA, & agora são 6 juntas:** `§T787` · `§T804` · `§T810` · `§T816` ·
**`§T820`** (§B96 — "remover" ⊥ esmaece a aba) · **`§T823`** (§B97 — 3 previsões que confirmam a
causa ANTES do conserto, + sonda do número que ⊥ foi medido). Só DEPOIS: `§T805` · `§T811`.

---

## 144ª RODADA (2026-08-30) — SUPERADA

**Estado:** gate **VERDE 616 ok / 0 FAIL** (**618** com `-Build`) · `.rpk` **2.553.530 B** gerada
**e instalada** 00:42:14 · §T **721 `x` · 89 `.` · 7 `~`** · **nada commitado**. **⊥ ∃ pergunta
aberta & ⊥ ∃ dívida de spec** — as 2 que esta rodada criou foram pagas nela mesma (↓).

**`§T815` & `§T817` FECHADAS, & ⊥ sobrou linha construível.** `/ck:build --all` resolveu p/
`§T815` sozinha (das 97 pendentes, ⊥ ∃ outra que ⊥ dependa de TELA); no meio da rodada o user
pediu **1 ajuste de spec**, que virou `§T817` & fechou junto.

**⛔ ⊥ PEÇA `/ck:build` DE NOVO.** ⊥ ∃ o que buildar. Das **89** `.`: **57** são `[USER]`,
**29** são teste/sonda de Firecast sem a etiqueta, **3** são revogadas de propósito (`§T619`
`§T775` `§T759` — id ⊥ se reusa). As **7** `~` são todas sonda de tela paradas no meio.

**A PRÓXIMA SESSÃO É DE TELA, & as 4 rodam JUNTAS:** `§T787` · `§T804` (sonda de foco, Q28) ·
`§T810` (o piloto de §I113) · `§T816` (o itálico & a largura de §I114i). Só DEPOIS: `§T805`
(precisa de `§T804`) & `§T811` (ondas 2 a 5, precisa de `§T810`).

**Leia nesta ordem:** esta seção INTEIRA → a **143ª rodada** logo abaixo → a **142ª** →
`research/README.md` (armadilhas 8 a 13).

### O QUE A 144ª FECHOU (⊥ refazer)

**`§T815` — §V355 no gate**, 1 arquivo (`verify-hunters-hunted.ps1`), **+151 linhas** logo
antes do bloco final `Write-Host ""` / `if ($fail -eq 0)`, ao lado de §V352 & §V354. **Nenhum
`.lfm` foi tocado** — o código já estava lá desde a 2ª metade da 143ª; o que faltava era a
RÉGUA. 614 → **615** ok.

As **9 pernas**, & a âncora que cada uma mede em `WoD20th/WoD20th.lfm`:

| perna | mede | como |
|---|---|---|
| (a) | 1 função de exibição | `mfShown` traduz & monta `-- t --`; `mfPaint` & `mfFilter` a CHAMAM & ⊥ chamam `translateSheetText` elas mesmas |
| (b) | os 2 estados num lugar só | dentro de `mfLabel`: `opacity 1` · `opacity 0.60` · `"-- " .. t .. " --"` · `fontStyle "italic"` · `fontStyle ""`; & contagem de `0.60` no root ≡ a de dentro de `mfLabel` |
| (c) | 1 escritor de `fontStyle` | lê os **números de §V305c** (`$fsRoot305`/`$fsIn305`), ⊥ mede 2ª vez — & FALHA se §V305c parou de medir. O que (c) ACRESCENTA são os 2 VALORES; §V305c conta escritores, §I114e nomeia o que escrevem |
| (d) | vazio condicional | no `setTimeout` de `mfOpen`: `local has = …` · `if vals[i] ~= "" or has then` · `if has then MF.pool[…] = ""; end;`; & em `mfConfirm` o guarda `nil`-only, c/ o guarda VELHO (`== ""` … `then return`) recusado |
| (e) | limpar leva as 3 colunas | a partir do `elseif MF.picked == "" …`, os 3 `setField("book_"/"type_"/"costy_" .. num, "");` |
| (f) | título DERIVADO | a linha de derivação ∃ · `mfOpen` ⊥ nomeia `"Select Merit"`/`"Select Flaw"`/`"Select Background"` · `MF.title =` escrito **1** vez no root |
| (g) | `fitSize` | piso `while size > 7` · `string.gsub(txt, "[\128-\191]", "")` · `local size = 12;` · ⊥ ∃ `size = size + ` · & a régua `* 0.5` aparece **1** vez no root, dentro de `fitSize` |
| (h) | ordem pelo que se lê | `key[name] = (foldKey ~= nil) and foldKey(shown)` + `table.sort(hits, function(a, b)`; & o root ⊥ declara `foldKey`/`FOLD_MAP` próprios |
| (i) | zero-guard, roda PRIMEIRO | `mfShown` ⊥ achada \| `fitSize` ⊥ achada \| 0 escrita de `0.60` \| 0 chamada de `fitSize` ! FAIL |

### AS 8 MUTAÇÕES — todas VERMELHAS

Bancada: **1** backup ANTES da 1ª mutação, restaurar no `finally`, SHA256 conferido no fim.
`WoD20th.lfm` voltou **byte a byte** — `A13D89C0DB89F9FB8AA076D7AE8556CFCB79CE4A72AA4547486BA551DDB92693`.

| # | mutação | resultado |
|---|---|---|
| 1 | `c.text = mfShown(…)` → `translateSheetText(…)` em `mfPaint` | **2** FAIL em (a) |
| 2 | `ctrl.opacity = 0.60;` → `= 1;` | **2** FAIL — (i) & (b) |
| 3 | `c.fontStyle = "";` a mais em `mfPaint` | **1** FAIL em (c) **+ 1 em §V305** ← é o "as 2 batem" que §T815 pedia |
| 4 | `if vals[i] ~= "" or has then` → `if true then` | **1** FAIL em (d) |
| 5 | apagar `setField("type_" .. num, "");` do ramo do vazio | **1** FAIL em (e) |
| 6 | derivação → `MF.title = "Select Merit";` | **2** FAIL em (f) |
| 7 | `while size > 7` → `> 0` | **1** FAIL em (g) |
| 8 | `table.sort(hits, function…)` → `table.sort(hits);` | **1** FAIL em (h) **+ 1 em §V354(d)** |

As **9** pernas acenderam pelo menos 1 vez ∴ nenhuma nasceu no-op (§V20, §B92).

### O PEDIDO DO USER NO MEIO DA RODADA — `/ck:spec` + `§T817`

**"os dropdown lists que tiver nas abas Settings ou Storyteller devem permanecer como dropdown
lists"** (2026-08-30). Virou **6** emendas de spec & 1 §T, TODAS fechadas:

| onde | o quê |
|---|---|
| **§C** | bullet nova da 144ª: os **6** combos MEDIDOS, & a razão (são VALOR/ESTADO — `items`/`values` AUTORADOS, & nenhum lê `PICKER_LIST`) |
| **§I113e** | a exceção que valia por NOME (`cboGame` `cboSheetTheme`) passa a valer por **ABA** |
| **§V354(f)** | vira PONTEIRO p/ §V356 — 1 dona por régua, senão é §B70 nascendo de novo |
| **§V356** | NOVA, 3 pernas: 1 `<comboBox>` por campo no arquivo da aba · `items`+`values` autorados · zero-guard |
| **§B95** | o achado (↓) |
| **§T817** | `x` — §V356 no gate, **3** mutações VERMELHAS |

**Os 6, & o arquivo de cada um:** `language` `game` `sheetTheme` @ **`WoD20.6.lfm`** (Settings) ·
`healthLevels` `stSpecCost` `stBackgroundCost` @ **`WoD20.10.lfm`** (Storyteller). A ida
aba→arquivo sai dos `<layout>` do root (`tabSettings`→WoD20.6, `tabStoryteller`→WoD20.10).

### ⚠ §B95 — A PERNA DE SPEC QUE NUNCA VIROU CHECK

Medindo o pedido, achei que **§V354(f) já dizia essa regra p/ 2 dos 6 — & NUNCA existiu no
gate.** O bloco de §V354 tem `(a) (b) (d) (e) (g)` & ⊥ tem `(f)`; `cboGame` & `cboSheetTheme`
⊥ aparecem nele em lugar nenhum. **⊥ é §B7** (check que VIRA no-op) **nem §B92** (check que
NASCE no-op): aqui ⊥ nasceu check, & é o pior dos 3 — ⊥ ∃ linha p/ mutação nenhuma acender.
CAUSA: as pernas de §V354 são escritas POR ONDA & (f) é a **negação** de uma onda ∴ o
`foreach ($w354 in $V354_WAVE)` ⊥ tinha onde pendurá-la.

**MEDIDO junto:** dos 6, `language` & `cmbBgCost` ⊥ tinham guarda de TIPO **nenhuma**; os
outros 4 tinham por ACIDENTE (§V109 · §V52 · §V234/§V243 · o de `cmbSpecCost`), de checks que
∃ p/ perguntar outra coisa. A mutação **provou**: trocar `cmbBgCost` por `<button>` acende **só
§V356** — 0 outro check da ficha viu.

### AS 3 MUTAÇÕES DE `§T817` — todas VERMELHAS

Backup dos **2** arquivos antes da 1ª; restaurados byte a byte (`WoD20.6` `307C06CC…`,
`WoD20.10` `4C5AE656…`).

| # | mutação | resultado |
|---|---|---|
| 1 | `<comboBox name="cmbBgCost"` → `<button …` | **1** FAIL em (a) — **& só ela** |
| 2 | tirar `items="{'0','1','2','3','4','5'}"` do `cmbBgCost` | **1** FAIL em (b) + 1 em §V257 |
| 3 | 2º `comboBox` no `field="language"` | **1** FAIL em (a) + 1 em §V1 |

### ✅ A DÍVIDA DE SPEC DESTA RODADA — PAGA NA PRÓPRIA RODADA

As 2 linhas que diziam **"⊥ ∃ no gate ainda"** (§V355 & §V356) estavam FALSAS assim que o
check entrou, & §V355 ainda apontava o §T errado (dizia §T812; quem pagou foi §T815). As 2
foram emendadas **no mesmo turno** — que é o que §B73 cobra & o que §B95 acabou de mostrar que
custa caro esquecer. **⊥ ∃ nada pendente p/ `/ck:spec`.**

### ⛔ O QUE ⊥ FAZER

- **⊥ pedir `/ck:build`** — ⊥ ∃ linha construível. O próximo passo é o user na TELA do Firecast.
- **⊥ reescrever §V355 nem §V356** — as pernas estão no gate & as **11** mutações (8 + 3) já
  foram rodadas. **⊥ "consertar" o roster de 6 de §V356 p/ derivação**: ele lista o que ! ⊥
  MUDAR ∴ sumir um item o ACENDE — direção de falha oposta à do roster que §I114f proíbe.
- **⊥ commitar** — o repo segue com TUDO no working tree, por regra do projeto.

### ⚠ AS ARMADILHAS DE FERRAMENTA QUE ESTA RODADA PAGOU

1. **Heredoc do Bash (`<<'EOF'`) ⊥ fecha quando a entrada tem CRLF** — o delimitador de
   abertura fica `EOF\r` & o `EOF` final ⊥ casa ∴ o bash lê até o fim & morre com
   `unexpected EOF while looking for matching`. É a família de §B74/§B81 numa porta nova: a
   ferramenta de texto do Git Bash & o fim de linha do Windows. Saída = escrever o bloco por
   **Write** num arquivo de rascunho & splicar por PowerShell.
2. **O gate é ASCII PURO** (`0` byte > 127, medido) — é o que §B84 exige de `.ps1` sem BOM, & o
   bloco novo ! nascer ASCII também. Splice por round-trip **Latin1** (`GetEncoding(28591)`)
   preserva CRLF & qualquer byte alto que apareça depois. Medido antes & depois:
   **13241 → 13392** linhas, `CR == LF`, `nonascii = 0`.
3. **A saída do gate ⊥ vem pelo pipeline** (escreve no HOST) — `& powershell.exe -NoProfile
   -File $gate *> $log` & depois `[IO.File]::ReadAllLines`. Filtrar `FAIL` pelo pipe lê 0 falha
   & declara toda mutação VERDE.

## 143ª RODADA (2026-08-29) — §T806...§T809, a 2ª metade do spec & o contrato de exibição

**Estado:** gate **VERDE 614 ok / 0 FAIL** (**616** com `-Build`) · `.rpk` **2.553.529 B** gerada
**e instalada** 23:41:45 · §T **719 `x` · 90 `.` · 7 `~`** · **nada commitado**. **⊥ ∃ pergunta
aberta** — as 3 foram respondidas & viraram trabalho de `/ck:spec` (no fim desta seção).

**✅ A DÍVIDA DE SPEC FOI PAGA.** O `/ck:spec` da 143ª gravou a 2ª metade: **14** linhas de §C ·
**§I114** (9 pernas) + §I99e/§I99k/§I99m/§I101h emendadas · **§V355** (9 pernas) +
§V244/§V305c/§V330a/§V331a/§V333g/§V334b/§V339a/§V351/§V354a emendadas · §T806 CORRIGIDA ·
**§T812…§T816** (3 `x` do que já landou, 2 `.`). §T **719 `x` · 90 `.` · 7 `~`**.

**PEÇA `/ck:build §T815`** — é a ÚNICA linha construível: §V355 no gate + mutação. Tudo o mais
espera tela (`§T787` `§T804` `§T810` `§T816`, a serem rodadas JUNTAS).

**⛔ DEPOIS de `§T815`, ⊥ ∃ mais nada construível.** A 143ª fechou `§T806`…`§T809` & o resto é
**TELA**: `§T787` · `§T804` (sonda de foco, Q28) · `§T810` (o piloto) · `§T816` (o itálico & a
largura). `§T805` só depois de `§T804`; `§T811` só depois de `§T810`. Das **90** `.`: **57** são
`[USER]`, **29** são teste/sonda de Firecast sem a etiqueta, **3** são revogadas de propósito
(`§T619` `§T775` `§T759` — id ⊥ se reusa), & **1** é `§T815`.

**Leia nesta ordem:** esta seção INTEIRA → a **142ª rodada** logo abaixo → a **141ª** →
`research/README.md` (armadilhas 8 a 13).

### O QUE A 143ª FECHOU (⊥ refazer)

**4 §T buildadas & 19 mutações VERMELHAS**, arquivos restaurados byte a byte (SHA256):

| § | entrega | número novo |
|---|---|---|
| `§T806` | `mfSearch` **440/520 → 300/1000** & a pane `edtMfDesc` em **520/50/460/550** | §V334 **9 panes / 18 botões** |
| `§T807` | `descText` GLOBAL = **1** leitor de texto · `mfSelect` pinta · `mfFilter`/`mfPage` limpam · `require` no `setTimeout` | **§V352** nova, 7 pernas |
| `§T808` | **PILOTO §I113**: `OpenAbility` perde o `comboBox`, ganha `<button name="dyn$(field)">` + `<edit>` gêmeo escondido; `mfOpen(from, field, list, mod)` | **16** linhas · pool de `PICKER_LIST` |
| `§T809` | **§V354** pernas (a)(b)(d)(e)(g) c/ roster de **ONDA** | 7 mutações |

**O par de zoom da pane chama-se `btnFontDownMf`/`btnFontUpMf`** — ⊥ `…MfDesc` como `§T806`
escreveu: §V334b DERIVA o sufixo do nome da pane (`edtMfDesc` → tira `edt` & `Desc` → `Mf`), &
as 8 panes velhas já obedecem essa regra. O user CONFIRMOU 2026-08-29 & `§T806` foi corrigida.

**A forma do gêmeo é `visible="false" enabled="false"`** (§I107a1, ≡ `MeritPicked`), ⊥ `readOnly`
como §V354a escreveu — escondido & desabilitado é garantia MAIS forte, & `readOnly` visível
puxaria §V111 (`opacity` 0,75) p/ um controle que ninguém lê. O user CONFIRMOU 2026-08-29 & `§V354a` foi reescrita.

### A PRÓXIMA TAREFA — `/ck:build §T815` (a ÚNICA construível)

**1 arquivo: `verify-hunters-hunted.ps1`.** Escrever **§V355** — as 9 pernas do contrato de
exibição de §I114 — & rodar a mutação. **Nenhum `.lfm` é tocado**: o código já está lá desde a
2ª metade da 143ª; o que falta é a RÉGUA. §V355 diz isso na própria linha ("⊥ ∃ no gate ainda").

**ONDE:** ao lado de §V352 & §V354, no FIM do arquivo, logo antes do bloco final
`Write-Host ""` / `if ($fail -eq 0)`. É onde as 3 últimas §V foram parar.

**O QUE JÁ ∃ no gate & ⊥ precisa nascer de novo:** `LuaFn $rootTxt '<fn>'` (corpo de função
Lua, fecha no `end;` de 3 tabs) · `NoComments` · `CodeOf` · `Doc` · `$rootTxt` · `$dir` ·
`$plugin` · `$LUA_OPACITY` (`0.75`,`0.60`) · `$ptK`/`$embedded` (chaves `[pt]` & mapa PT) ·
`$PICKER` · `$V354_WAVE`.

**AS ÂNCORAS DE CÓDIGO, medidas** (tudo em `WoD20th/WoD20th.lfm`, tudo GLOBAL — o root está em
**50** locais de chunk contra teto **53**, §B93/§V347 ∴ **⊥ escrever `local function`**):

| perna | mede | âncora literal |
|---|---|---|
| (a) | 1 função de exibição | `function mfShown(name, lang)`; `mfPaint` & `mfFilter` a chamam; **0** outro lugar decide texto |
| (b) | os 2 estados num lugar só | dentro de `mfLabel`: `ctrl.opacity = 1;` **&** `ctrl.opacity = 0.60;` **&** `"-- " .. t .. " --"` |
| (c) | 1 escritor de `fontStyle` | `ctrl.fontStyle = "italic";` + `ctrl.fontStyle = "";`, os 2 DENTRO de `mfLabel`. ⚠ **esta contagem ! BATER com a de §V305c** — são a mesma medida por 2 donos, & divergir é §V135 |
| (d) | vazio condicional | no `setTimeout` de `mfOpen`: `local has = cur ~= nil and cur ~= "";` · `if vals[i] ~= "" or has then` · `if has then MF.pool[#MF.pool + 1] = ""; end;` · em `mfConfirm`: `if MF.picked == nil or MF.field == nil then return; end;` (o guarda velho testava `MF.picked == ""` & ! ⊥ voltar) |
| (e) | limpar leva as 3 colunas | `elseif MF.picked == "" and num ~= nil and MF.data ~= nil then` + os 3 `setField("book_"/"type_"/"costy_" .. num, "")` |
| (f) | título DERIVADO | `MF.title = "Select " .. string.upper(string.sub(list, 1, 1)) .. string.sub(list, 2);` & **0** tabela de rótulo |
| (g) | `fitSize` | `function fitSize(txt, width)`, piso `while size > 7`, conta CARACTERE (`string.gsub(txt, "[\128-\191]", "")`), & **⊥ ∃ 2ª régua de largura no Lua** |
| (h) | ordem pelo que se lê | em `mfFilter`: `key[name] = (foldKey ~= nil) and foldKey(shown)...` + `table.sort(hits, function(a, b)`; `foldKey`/`FOLD_MAP` são de `WoD20.6` & já GLOBAIS ∴ **⊥ criar 2ª dobra** |
| (i) | zero-guard | `mfShown` ⊥ achada \| 0 escrita de `0.60` \| 0 chamada de `fitSize` ! FAIL |

**AS 8 MUTAÇÕES (§V20 §V222), todas ! dar VERMELHO:** 2º lugar montando o texto exibido ·
`mfLabel` perdendo um dos 2 estados · 2º escritor de `fontStyle` fora de `mfLabel` · o vazio
entrando na pool sem valor no campo · escolher vazio ⊥ limpando `book_`/`type_`/`costy_` ·
tabela de rótulo no lugar da derivação · `fitSize` sem piso (ou contando BYTE) · `table.sort`
sem comparador.

**COMO SABER QUE ACABOU:** `.\verify-hunters-hunted.ps1` = **615 ok / 0 FAIL** (614 hoje + a
linha de §V355) & `-Build` = **617**. Depois: `rdk -i` & conferir que a `.rpk` gerada e a
INSTALADA têm o MESMO size (§B1 — size oscila entre builds, o que prova é gerada-vs-instalada).

**⚠ ARMADILHAS DE FERRAMENTA que esta tarefa vai encontrar:**
- **A saída do gate ⊥ vem pelo pipeline** — ele escreve no HOST. `& powershell.exe -NoProfile
  -File $gate *> $log` & depois `[IO.File]::ReadAllLines`. Filtrar `FAIL` pelo pipe lê 0 falha
  & declara toda mutação VERDE.
- **`SPEC.md` é UTF-8 & `.lfm`/`.ps1` são CRLF.** Editar `.lfm`/`.ps1` por PowerShell: round-trip
  **Latin1** (`[Text.Encoding]::GetEncoding(28591)`) preserva BOM, CRLF & multibyte — mas SÓ se
  o padrão de busca for 100% ASCII. Âncora com `§` ou acento ! ler em **UTF-8** (foi assim que a
  1ª tentativa de escrever no `SPEC.md` falhou dizendo "anchor 0" com a âncora ∃ no arquivo).
- **⊥ usar `sed`/`awk` do Git Bash em `.lfm` nem em `.ps1`** (§B74) — come o CR do arquivo todo.
- **`$T = [char]9` SOBRESCREVE `$t`**: variável de PowerShell é case-INSENSITIVE.
- **Bancada de mutação: backup 1× ANTES da 1ª mutação**, restaurar no `finally`, conferir SHA256
  no fim. `Copy-Item` no topo de cada volta sobrescreve o limpo com um mutado no 1º erro.
- **A âncora de 1 linha em `.lfm` costuma ser AMBÍGUA** — afirmar a contagem esperada antes de
  trocar, sempre.
### ⚠ AS 4 ARMADILHAS QUE ESTA RODADA PAGOU

1. **Tirar um `comboBox` TIRA a lista inteira do censo de string visível.** Ao converter
   `OpenAbility`, os **47** antecedentes sumiram de **§V9 §V22 §V28 §V24 §V17** (967 → 923
   strings) & de **§V196 §V211 §V215 §V346** — tudo VERDE, porque cada um desses conta o que
   ACHA. **§V354(d) recobre** ([pt] + mapa PT) & **∀ onda nova de §I113e ! entrar no roster
   `$V354_WAVE`**, senão perde a mesma cobertura calada. É §B7 pela porta da conversão.
2. **§V198 ⊥ reconhecia função ANÔNIMA.** O `require` dentro de `setTimeout(function()` foi
   acusado de "sits outside a function body": a régua era `(?:^|\s)function\b` & `(function()`
   ⊥ tem espaço antes. Corrigida p/ `\bfunction\b`; a mutação que ela ∃ p/ pegar (require no
   topo do CDATA) segue VERMELHA — `<![CDATA[` ⊥ carrega `function` de jeito nenhum.
3. **O módulo de descrição virou PARÂMETRO** (`require("desc" .. MF.mod .. "_" .. lang ..)`)
   ∴ **§V198/§V210/§V215 ⊥ enxergam mais esse `require`** (a régua deles quer o literal
   `desc<Nome>_`). Quem responde agora é **§V354(b)**: as 2 metades `desc<Mod>_en/pt.lua` ! ∃
   na raiz do plugin, pelo roster da onda.
4. **`$T = [char]9` SOBRESCREVE `$t`** — variável de PowerShell é case-INSENSITIVE. Custou uma
   edição inteira que abortou dizendo "anchor found 0 times" com a âncora ∃ no arquivo.

### O QUE MUDOU DE FORMA NO CÓDIGO (p/ ⊥ reinventar)

- **`descText(kind, key, sub, lang)`** = o ÚNICO lugar que monta a chave composta de §I102g.
  `popOpen` **&** `mfSelect` chamam ELA. GLOBAL: o root declara **50** locais de chunk contra o
  teto de 53 (§B93, §V347) ∴ `local function` aqui é build morto sem mensagem.
- **`MF` ganhou `field` `list` `mod` `pool` `btn` `title`** & perdeu `row` `kind`. `MF.list`
  serve de chave da fonte **&** de `sub` da chave composta — p/ antecedente a chave composta
  ⊥ ∃ & `descText` cai na nua sozinho.
- **O título é DERIVADO**, ⊥ tabelado: `"Select " .. <lista c/ inicial maiúscula>` devolve as
  3 strings que o `.lang` já carrega, & a MESMA string é o fallback do botão (§I107a2).
- **`mfConfirm` aceita `""`**: o vazio de §V15 ∃ em `PICKER_LIST["background"]` & escolher ele
  LIMPA a linha. `nil` = nada marcado, `""` = o item vazio. Merit/flaw ⊥ têm vazio na fonte.
- **`renderMeritButtons(from)` SAIU do `mfConfirm`** — quem repinta é `mfLabel(MF.btn, …)`, o
  botão que ABRIU a caixa. Os 2 `dataLink` (12 merit + 16 background) seguem repintando na
  abertura.
- **`renderBgButtons`** = o par §I107a2 dos 16 botões de antecedente. Limite =
  `BACKGROUND_ROWS - BACKGROUND_FREE_ROWS`, ⊥ literal (§V145 acusa literal).
- **`Select Background`** entrou nas 3 casas: `[pt]` & `[en]` do `.lang` & o mapa `PT` de
  `WoD20.6`.

### AS 19 MUTAÇÕES — todas VERMELHAS

| # | mutação | alvo |
|---|---|---|
| 1 | pane fora de `DESC_PANES` | §V334 (perna nova) |
| 2 | par de zoom c/ nome errado | §V334b |
| 3 | pane IRMÃ de `mfSearch` | §V352a |
| 4 | pane sem `wordWrap` | §V352b |
| 5 | pane c/ `field` | §V352b |
| 6 | caixa 20px mais alta | §V352c |
| 7 | `mfFilter` ⊥ limpa a pane | §V352d |
| 8 | `require` movido p/ `mfSelect` | §V352e |
| 9 | 2ª função montando a chave | §V352f |
| 10 | `require` no topo do CDATA | §V198 (regressão da régua nova) |
| 11 | `comboBox` sobrevivendo no template | §V354a |
| 12 | gêmeo sem `enabled="false"` | §V354a |
| 13 | caixa c/ lista própria | §V354d |
| 14 | órfão ⊥ anexado | §V354d |
| 15 | `mfFilter` sem `table.sort` | §V354d |
| 16 | 15 linhas em vez de 16 | §V354e |
| 17 | item fora do mapa PT | §V354d |

*(14 mutações nomeadas + 3 da leva de §T806 que repetiram alvo; 2 rodadas de bancada cortadas
por timeout foram REFEITAS, ⊥ contadas 2×.)*

### O QUE A 2ª METADE DA 143ª ENTREGOU (10 pedidos do user, SEM §T)

| pedido | entrega |
|---|---|
| resp. P1 | caixa & botão MOSTRAM o nome TRADUZIDO (`mfShown`); o EN canônico segue no campo (§V24) |
| resp. P1 | linha VAZIA = `-- Select X --`, **itálico**, opacidade **0,60**; linha cheia = normal, opacidade 1 |
| resp. P4 | o item vazio da lista lê `-- Remove --` & **só entra na pool se ∃ valor** na linha — inclusive p/ merit/flaw, cuja fonte (`meritData`) ⊥ tem vazio próprio; escolher ele LIMPA nome + livro + página + custo |
| 1 | `merit_m0` & `merit_f0` — 1 linha picker NOVA no TOPO de cada tabela. ⊥ é renumeração (§V2): as caixas 311 → **336** & FLAWS 316 → **341**, coluna fecha em **677** de 693 |
| 2 | `Page` & `Cost` centralizados nos **2** templates (picker & digitada) |
| 3 | rótulo `ROAD` FICA em CAPS & vai de 46 → **80**; `cboRoad` 71/239 → **105/205** (2 voltas: o user pediu caixa alta-e-baixa, viu na tela & mandou voltar p/ CAPS pedindo o campo MENOR ainda) |
| 4 | **REVERTIDO a pedido do user**: `WILLPOWER` segue em CAPS nas 3 caixas & `wod.WILLPOWER` / `wod.Willpower` voltaram byte a byte ao que eram (`FORÇA DE VONTADE` & `Força-de-Vontade`). ⚠ **título de caixa nesta ficha é CAPS, sem exceção** — foi a decisão: converter as ~40 caixas p/ caixa alta-e-baixa ⊥ foi escolhido |
| 5 | bearing virou **1** label centralizado (`dynBearingName` 20/290) c/ `"<nome> (<mod>)"`, opacidade **0,80**; **`dynBearingMod` REMOVIDO** |
| 6 | `fitSize` encolhe o texto até caber (piso **7pt**), nos BOTÕES de escolha **&** no `cboRoad` — o user esclareceu que "trilha" era **road** (§V351e, 2 mutações). Sem valor escolhido, tamanho normal |
| — | a caixa ORDENA pelo que se LÊ, via `foldKey` (§I110c) — antes ordenava pelo EN & mostrava PT |

### AS 3 RÉGUAS DO GATE QUE TIVERAM DE MUDAR (& por que ⊥ é afrouxar)

1. **§V305c ⊥ proíbe mais `fontStyle` em Lua** — só `fontColor`. A razão escrita ("applyTheme
   desfaz") vale p/ COR: ela repinta de um ledger `authored`. **MEDIDO: `WoD20.6` ⊥ nomeia
   `fontStyle` em lugar NENHUM** ∴ nada repinta & nada tira snapshot. A exceção é NOMEADA
   (`mfLabel`) & carrega **3** pernas: contagem de escritores · o dono ser `mfLabel` · a
   PREMISSA (o tema ⊥ nomear `fontStyle`). 2 mutações VERMELHAS.
2. **§V244 virou LISTA NOMEADA** (`$LUA_OPACITY = 0.75, 0.60`) em vez de "só `$DIM_TEXT`".
   0,60 = "⊥ preenchido", que ⊥ é a mesma frase que "só leitura". **0,40 (ART) segue FORA** —
   mutação confirma que a porta lateral que §V244 ∃ p/ fechar segue fechada.
3. Re-miradas mecânicas: **§V351** lê o rótulo por `Road` & mede `'Road'/'Caminho'` · **§V330**
   ⊥ nomeia mais `dynBearingMod` · **§V332** map `369;0;536;336` & `369;341;536;336` ·
   **§V331** `m0..m6` · **§V333g** **30** `?` · **§V339a** **14** `MeritPicked` · **§V354d** o
   `table.sort` c/ comparador.

**7 mutações VERMELHAS** nesta metade (número da ART em Lua · 2º escritor de `fontStyle` · tema
nomeando `fontStyle` · linha nova virando digitada · FLAWS ⊥ descendo os 25 · ordenar pelo EN ·
rótulo `Road` espremido). Arquivos restaurados byte a byte (SHA256).

### ⚠ O QUE ⊥ FOI MEDIDO — só a TELA responde (junte à sessão de `§T804`/`§T810`)

- **`ctrl.fontStyle = "italic"` / `""` escrito por LUA.** A propriedade ∃ (`rrpgGUI:setFontStyle`
  → `Font.Style`, tipo SET) & o XML já usa `fontStyle="italic"`, mas **⊥ ∃ precedente de escrita
  por Lua nesta ficha**. Chamada de método compila SEMPRE ∴ só a tela diz se pinta & se `""`
  limpa de volta. ≡ o que §B80 ⊥ responde em `§T804`.
- **`ctrl.width` LIDO por Lua** (`fitSize`). Se voltar `nil`, `fitSize` devolve 12 & nada
  encolhe — falha SEGURA, ⊥ quebra nada.
- **`fitSize` é ESTIMATIVA**: 6,0px/caractere a 12pt, a régua do PRÓPRIO gate (§V16/§V312a),
  contando CARACTERE & ⊥ byte (UTF-8). ⊥ ∃ chamada de medir texto no SDK3 — é por isso que as
  checagens de largura moram no gate. Ela só DIMINUI, nunca afirma que cabe.
### ⛔ O QUE ⊥ FAZER

1. **⊥ pedir `/ck:build` PELADO** — ele varre ~90 linhas `.` & acha 1 construível no fim. Peça `§T815` pelo id. Depois dela, ⊥ ∃ linha construível até a sessão de tela.
2. **⊥ converter onda 2 de §I113e sem entrar no roster `$V354_WAVE`** (armadilha 1 ↑).
3. **⊥ commitar.** Regra do projeto: só sob pedido direto naquela mensagem.
4. As **6** armadilhas da 142ª (⊥ regenerar `descMerit_*` sem o CSV · ⊥ apagar chave `.lang`
   de base · ⊥ contar fim-de-linha com `grep -c $'\r'` · ⊥ `sed`/`awk` em `.lfm`/`.ps1` ·
   ⊥ escrever check sem `grep` do número no gate · ⊥ medir largura só por §V196) **seguem
   valendo INTEIRAS** — estão na seção da 142ª logo abaixo.

### ✅ AS 3 PERGUNTAS — RESPONDIDAS (viram trabalho de `/ck:spec`)

1. **Os 2 botõezinhos de zoom da pane nova.** O user confirmou: **o texto de `§T806`/`§I112c`
   está errado**, o nome certo é o que a regra de §V334b deriva do nome da pane
   (`btnFontUpMf`/`btnFontDownMf`). `/ck:spec` ! corrigir a linha.
2. **O campo invisível atrás do botão de escolha.** O user confirmou: **`/ck:spec` ! reescrever
   `§V354a`** p/ "gêmeo ESCONDIDO & DESABILITADO c/ o `field`" — é a forma de §I107a1, a que a
   `MeritPicked` já roda, & a mais forte das duas.
3. **O pedido 6 — "trilha" era ROAD.** Esclarecido pelo user. Feito nos 2 lugares: nos botões de
   escolha (`mfLabel`) **&** no `cboRoad` do Main, que é o campo que o pedido 3 estreitou.
   `§V351` ganhou a perna **(e)** & ela foi mutada VERMELHA 2×.
## 142ª RODADA (2026-08-29) — Q24…Q27, o lote de 8 §T

**Estado:** gate **VERDE 614 ok / 0 FAIL** (**616** com `-Build`) · `.rpk` **2.540.340 B** gerada
**e instalada** 21:38:01 · §T **712 `x` · 92 `.` · 7 `~`** · **nada commitado** (50 arquivos no
working tree). **⊥ ∃ pergunta aberta.**

**PEÇA `/ck:build §T806`** — ⊥ `/ck:build` pelado. A 142ª buildou o lote inteiro de **Q24…Q27**
(`§T796`…`§T803`, todas `x`) & o `/ck:spec` dela abriu **Q28…Q30** com **8** §T novas. A cadeia
CONSTRUÍVEL é **`§T806`** ! **`§T807`** ! **`§T808`** ! **`§T809`**, nessa ordem, & mais nada:
`§T804`/`§T805` esperam sonda de tela & `§T810`/`§T811` esperam o piloto.

**Leia nesta ordem:** esta seção INTEIRA → a **141ª rodada** logo abaixo → a **140ª** →
`research/README.md` (armadilhas 8 a 13).

### O QUE A 142ª FECHOU (⊥ refazer)

**8 §T buildadas & 32 mutações VERMELHAS**, arquivos restaurados byte a byte (SHA256):

| § | entrega | número novo |
|---|---|---|
| `§T796` | partição de custo de **Q24**, pelo gerador | **647 → 873** (Merit **380** · Flaw **493**) |
| `§T797` | as 4 colunas de **Q25** | `Page` **45** · `Book` **117** · nome **264** |
| `§T798` | §V348 §V349 no gate | 9 mutações |
| `§T799` | ordem alfabética de **Q26** | `foldKey` + sort do par em `pickerItems` |
| `§T800` | §V350 no gate | 8 mutações |
| `§T801` | a linha do `ROAD` de **Q27** | caixa **204** · fundo da Main **878 → 853** |
| `§T802` | §V351 no gate | 6 mutações |
| `§T803` | §V331 §V332 REESCRITAS + `readOnly` nas 3 colunas de livro | 9 mutações |

**A TELA APROVOU 5 pontos** & isso virou PARCIAL em 4 linhas (⊥ ∃ linha fechada): `§T770` item
(7) · `§T771` item (4) na metade do `readOnly` · `§T772` itens (1)(2) · `§T787` itens (3) & (5).

### ~~A PRÓXIMA TAREFA — `/ck:build §T806`~~ — HISTÓRICO da 142ª, JÁ FEITA (`§T806`…`§T809` estão `x`)

1. **`§T806`** — a caixa de busca cresce & ganha a pane de descrição (**Q29**, §I112a-c):
   `mfSearch` de `left="440" width="520"` p/ **`left="300" width="1000"`**, `edtMfDesc` em
   **520/460**, & ela entra em `DESC_PANES` ∴ **§V334 vai de 8 panes/16 botões p/ 9/18**.
   ⚠ a coluna de resultado ⊥ se mexe 1px.
2. **`§T807`** — `mfSelect` pinta · `mfFilter`/`mfPage` LIMPAM · **§V352** nova + 5 mutações.
   ⚠ **o `require` de `descMerit_*` (563KB) vai no `setTimeout` de `mfOpen`, ⊥ no `mfSelect`** —
   parse no 1º clique de linha trava a escolha (§I107f, §R92, §T479).
3. **`§T808`** — o PILOTO de **Q30**: antecedente (`OpenAbility`, 16 linhas, 47 itens, SEM
   filtro). ⚠ **1** tabela local & todo helper GLOBAL (§B93).
4. **`§T809`** — §V354 pernas (a)(b)(d)(e)(g) contra o piloto + 5 mutações.

### ⚠ O QUE Q30 REALMENTE PEDE — medido, ⊥ estimado

O user pediu **todo** dropdown virando caixa de busca ∴ **o recorte da Q16 está REVOGADO**.
MEDIDO em 2026-08-29: são **119** combos vindos de **11** templates (`HeaderNarrow` 3 ·
`HeaderPicker` 2 · `SpecialityRow` 7 · `DiscRow` 16 · `MainPathRow` 5 · `SecPathRow` 12 ·
`RitualRow` 15 · `OpenAbility` 16 · `HedgePicker` 12 · `PsychicPicker` 19 · `HedgeRitualPicker`
12) **+** os avulsos. **⊥ é 1 tarefa, é um programa em 5 ONDAS** (§I113e).

**O que torna cada onda cara ⊥ é a caixa — é o que ela ! carregar junto:** o FILTRO de runtime
(nível de disciplina §I25 · afiliação §I67/§I68 · época da trilha §I99c2) mora DENTRO de
`pickerItems`, que ∃ p/ alimentar `c.values`/`c.items` de um `comboBox`. **Sem combo, esses 3
precisam de porta própria** (§I113c) — & essa porta ! ser MEDIDA antes de escrita, ≡ a
armadilha que §I107n pagou por declarar queda barata cedo demais.

`cboGame` & `cboSheetTheme` FICAM `comboBox`: são estado, ⊥ prosa (§I113e).

### ⚠ Q28 ⊥ TEM ORÁCULO DE COMPILAÇÃO

**§B80 ⊥ responde o foco.** Ele é oráculo de ATRIBUTO — o `rdk` recusa atributo que ⊥ conhece.
**Chamada de MÉTODO em Lua compila sempre** & só falha (ou ⊥ faz nada) rodando ∴ `setFocus` /
`.focus` / `focus()` só a TELA responde. **0** ocorrência dos 3 nos 15 `.lfm` (varredura
2026-08-29) ∴ a ficha nunca exerceu isso. Sonda = `§T804`, & ela PEGA CARONA em `§T787`.

### ⛔ O QUE ⊥ FAZER

1. **⊥ buildar `§T808` antes de `§T806`/`§T807`.** A caixa que o piloto generaliza ! estar na
   forma FINAL — generalizar uma caixa que vai mudar de tamanho é refazer 2×.
2. **⊥ escrever §V353 antes de `§T804`.** Check contra nome de API que ninguém mediu é §B92
   (check nascido no-op). O id está RESERVADO & a linha diz isso.
3. **⊥ regenerar `descMerit_*` sem o CSV de corpos.** `gen_merit_data.ps1` lê
   `$env:TEMP\mf_bodies.csv`; sem ele os corpos EN saem VAZIOS. **Confira que o gerador
   reproduz os arquivos de hoje ANTES de mexer** — foi assim que a 142ª começou.
4. **⊥ apagar chave `.lang` de base que partiu sem conferir as OUTRAS listas.** **3** das 87
   (`Arcane` `Patron` `Rebel`) também vivem em lista de antecedente ∴ a chave NUA delas FICA.
5. **⊥ commitar.** Regra do projeto: só sob pedido direto naquela mensagem.
6. **⊥ contar fim-de-linha com `grep -c $'\r'`** (§B87, §V345) & **⊥ usar `sed`/`awk` do Git
   Bash em `.lfm` nem em `.ps1`** (§B74). `desc*.lua` & `.lang` são LF; o resto é CRLF.
7. **⊥ escrever check de §V sem antes `grep` do número no gate** (§T776).
8. **⊥ medir largura só por §V196** — encolher `comboBox` de 12pt paga §V312c junto, piso 6,5
   (§B86). E a coluna do NOME agora tem régua própria, §V349c (§B94).

### ARMADILHAS DE FERRAMENTA

- **A saída do gate ⊥ vem pelo pipeline** — ele escreve no HOST. `*> arquivo` & depois
  `[IO.File]::ReadAllLines`. Bancada que filtra `FAIL` pelo pipe lê 0 falha & declara toda
  mutação VERDE.
- **Zero-guard que procura CHAMADA ! ler CÓDIGO, ⊥ texto.** `IndexOf('table.sort(')` acha a
  chamada COMENTADA — foi assim que §V350f nasceu cega, & é §V330c pela 2ª porta.
- **Âncora de 1 linha em `.lfm` costuma ser AMBÍGUA** (`<layout left="40" top="74" …>` ∃ 2×).
  Toda substituição ! AFIRMAR a contagem esperada antes de trocar.
- **`cmbItems` vem DEPOIS de `pickerItems`** & as 2 fecham com a MESMA linha ∴ âncora por
  `LastIndexOf`.
- **Backup de BANCADA ≠ backup de PATCH**: os `.clean` saem **1×**, antes da 1ª mutação.
- **`.ps1` sem BOM é lido como ANSI** (§B84) ∴ texto acentuado vai p/ `.txt` lido como UTF8.
- **Edição por PowerShell come CR & §V318 acusa.** Depois de editar `.lfm`/`.ps1`:
  `($t -replace "\r\n","\n") -replace "\n","\r\n"`.

## 141ª RODADA (2026-08-29) — §T761 & §T763 fechadas, & §T759 destravada por `/ck:spec`

**A rodada teve 2 metades.** A 1ª buildou `§T761` & `§T763` — é o que esta seção conta. A 2ª foi
o `/ck:spec` que o user pediu depois de responder as 2 perguntas: `§V331`/`§V332` REESCRITAS
(`§T803` substitui `§T759`), **Q24…Q27** gravadas, **§B94** registrada & **8** §T novas
(`§T796`…`§T803`). O lote está detalhado na seção do TOPO.

Gate **608 ok / 0 FAIL** (**610** com `-Build`), `.rpk` **2.481.695 B** instalada 17:23:08.
Mexeu em **2** arquivos: `WoD20.2.lfm` & `verify-hunters-hunted.ps1`. `WoD20th.lfm` saiu byte a
byte igual (SHA256 conferido depois da bancada de mutação).

### §T761 — os 28 `?`, & os 3 lugares onde o gate reprovou o caminho óbvio

Os 28 saíram de **2** `<button>` autorais, ⊥ de 28: um dentro de `MeritPicked` (12 chamadas) &
um dentro de `OpenAbility` (16). **Chave da linha = o VALOR da linha**, lido inline no XML —
`onClick="popOpen(self, 'Merit', sheet['merit_$(num)'], '$(sub)');"`. ⊥ nasceu função-ponte:
`sheet` É visível no escopo do form de aba (`WoD20.12/13/14` já leem `sheet.discSel` no
`<script>` deles) ∴ o wrapper seria 1 função a mais p/ ⊥ ganhar nada.

**MEDIDO no compilador (§B80, ≡ §I107n1): `rdk` ACEITA template com 3 parâmetros.** A 140ª
tinha medido 2 (`num` + `lbl`); `sub="merit"`/`sub="flaw"` é o 3º & compila. Era isso ou repetir
em XML a regra do prefixo `f` que `mfOpen` já tem — §V135 pela porta do template.

**3 reprovações do gate que o caminho óbvio levou, & ⊥ ∃ nenhuma que fosse "consertar o gate":**

1. **§V239 + §V280 — o `?` ⊥ cabe fora da margem de 20.** A 1ª tentativa abriu as 21 linhas de
   antecedente em `left="12"` p/ o `?` caber SEM mover a coluna de entrada. §V239 exige os 2
   lados IGUAIS (o rótulo `20/324` fixa L=20 & R=20) & §V280a cobra 20 em ⊥ 4 lados ∴ 12
   reprovou nas 2. **A coluna de entrada TEM de andar**: linhas em `left="20" width="320"`, `?`
   em 0/20 & o picker em 20 ∴ entrada de **32 → 40** absoluto & os dots fecham em **340**.
   ⚠ §T790 diz "`OpenAbility` & `OpenAbilityFreeRow` ⊥ são TOCADOS" — aquilo era sobre **ENCOLHER**
   o picker (piso 167 de §V312c, §B86). Os 170 seguem 170; o que mudou foi o x.
2. **§V255 compara os 2 templates LITERALMENTE** (`verify:7650`): mesmos x de dot & mesmo x da
   1ª entrada. ∴ o `OpenAbilityFreeRow` andou os mesmos +20 **sem** ganhar botão — o vão fica
   VAZIO nele, que é §I102f escrita em pixel.
3. **§V290 lia o `?` como 5ª COLUNA da tabela.** O coletor pega `edit|button` visível & o `?` ⊥
   tem `field` nem nome `dynMerit_*` ∴ entrava como `?@0+20` & a metade digitada ⊥ tinha resposta
   p/ ele. Emendado p/ pular `btnQ*`, c/ a razão escrita: o `?` está no VÃO, ⊥ na tabela.

**§V10/§V28 — a exceção do `?` era DECLARADA & precisava ser escrita.** §I102b já dizia que `?`
⊥ pede chave `.lang` (precedente do numeral de §V17), mas o coletor de strings visíveis pega
`text` de ∀ `<button>` ∴ os 28 pediram `wod.?=?` em [pt], [en] & no PT map. A exceção entrou
ESTREITA — `<button>` + texto exatamente `?` + nome `btnQ*` — porque wildcard aqui é §B7 entrando
pela porta da exceção, que é o que o comentário de §V15 já avisa 20 linhas acima.

### §T763 — §V333 (d)+(g), & por que 28 ⊥ se conta com `grep`

§V333 & §V334 **já ∃** no gate desde §T760/§T762 — ≡ o que aconteceu c/ §T776 & §V337 (status
`.`/`~` ⊥ quer dizer "falta fazer"). O que faltava eram as 2 pernas que o próprio comentário do
gate dizia esperar por §T761.

**O `grep` de `btnQ*` no XML acha 2, ⊥ 28** — os botões vivem DENTRO de template. A perna conta
**CALL SITE**: p/ cada template que declara um `btnQ`, quantas vezes ele é chamado no arquivo.
Roster FECHADO & nomeado (`@{ MeritPicked = 12; OpenAbility = 16 }`, ≡ o que §V109 faz c/
`cboGame`) ∴ um 3º template ganhando `?` acende, em vez de ser absorvido num total que ainda diz
28. Zero-guard ANTES das contagens.

Perna (d) tem 2 metades: **1** função p/ os 28 (`popOpen`), & cada `onClick` passando o valor da
PRÓPRIA linha — a régua é `sheet[` no atributo. Chave literal compila, parece certa & abre a
mesma descrição em ⊥ botão da ficha: falha sem sintoma até alguém LER.

### AS 9 MUTAÇÕES DA 141ª — todas VERMELHAS, arquivos restaurados byte a byte (SHA256)

| # | mutação | alvo | deu |
|---|---|---|---|
| 1 | `popScrim` autorado DEPOIS do `popDesc` | §V333b | VERMELHO |
| 2 | 2º `popDesc` noutra aba | §V333a | VERMELHO |
| 3 | 1 linha picker de antecedente virando DIGITADA (27) | §V333g | VERMELHO |
| 4 | 1 linha de antecedente desenhada 2× (29) | §V333g | VERMELHO |
| 5 | `?` passando chave LITERAL em vez do valor da linha | §V333d | VERMELHO |
| 6 | 2º abridor (`popShow`) em metade dos botões | §V333d | VERMELHO |
| 7 | **zero-guard:** nenhum `btnQ` autorado | §V333g | VERMELHO |
| 8 | teto escrito 2ª vez (`.fontSize = 40`) fora de `fontStep` | §V334a | VERMELHO |
| 9 | 1 pane sem o par de botão | §V334b | VERMELHO |

⚠ **a mutação 1 acendeu VERDE na 1ª rodada & a culpa era da BANCADA, ⊥ do check.** Ela tirava o
scrim & o re-inseria ANTES do `popDesc` — ⊥ movia nada que §V333b olhe (ele compara `IndexOf`).
**Mutação que ⊥ acende ! ser LIDA antes de acusar o check**: reescrita p/ jogar o scrim depois do
`</layout>` do `popDesc` (ancorado em `<layout name="mfSearch"`), acendeu na hora. A bancada
passou a AFIRMAR a pré-condição (`if (idx scrim < idx popDesc) { throw }`) em vez de supor.

### 2 ARMADILHAS DE FERRAMENTA DESTA RODADA

- **A saída do gate ⊥ vem pelo pipeline.** `& .\verify-hunters-hunted.ps1 2>&1 | Out-String`
  devolve VAZIO — ele escreve no HOST. Bancada que filtra `FAIL` assim lê 0 falha & declara
  toda mutação VERDE. Régua: `*> arquivo` & depois `[IO.File]::ReadAllLines`.
- **Backup de BANCADA ≠ backup de PATCH** (a armadilha que a 140ª já tinha achado, confirmada):
  os `.clean` da mutação vivem em `scratchpad\mut\` & são tirados **1×**, antes da 1ª mutação —
  `Copy-Item` no topo de cada volta sobrescreveria o limpo com um mutado no 1º erro no meio.
## 140ª RODADA (2026-08-29) — §T776, & os 2 defeitos que só a mutação achou

A rodada inteira coube em `verify-hunters-hunted.ps1`. **Nenhum arquivo de ficha mudou** — os
`.lfm` & os `.lua` saíram desta rodada byte a byte iguais ao que entraram (SHA256 conferido nas
3 levas de mutação). O `.rpk` foi regerado & instalado assim mesmo, porque build sem install é
tarefa incompleta: **2.463.587 B**, `rdk -i` exit 0, instalada 00:57:47 com o mesmo size.

⚠ **O size da `.rpk` oscila entre builds da MESMA fonte** — 3 builds seguidos desta rodada, sem
1 byte de mudança no plugin, deram **2.463.588** · **2.463.585** · **2.463.587**. É o zip, ⊥ a
ficha. ∴ a prova de §B1 é `.rpk` recém-gerada **vs INSTALADA** (têm de bater), ⊥ build vs build.

### A lição da rodada: `.` no §T ⊥ quer dizer "falta fazer"

§T776 pedia §V337 NOVA. §V337 estava PRONTA desde `§T782` — porque `§T781`/`§T782` foram escritas
DEPOIS, refazendo `§T775`/`§T776` com outro alvo, & ninguém voltou p/ virar o status das 2 velhas.
O `.` sobreviveu à tarefa. **Antes de escrever qualquer check, `grep` o número da §V no gate**:
custa 1 comando & evita escrever de novo o que já ∃ (ou, pior, escrever uma 2ª cópia — §V135).

### A bancada de mutação, & por que ela ⊥ pode usar `sed`

3 scripts no scratchpad (`mutate.ps1` `mutate2.ps1` `mutate3.ps1`), 1 mutação por chamada:
backup → aplica → roda o gate → **restaura no `finally`** → compara SHA256.

| armadilha | o que fazer |
|---|---|
| `.lfm` & `.ps1` são **CRLF**; o `sed` do Git Bash come o CR do arquivo inteiro (§B74) | a troca é PowerShell com **round-trip Latin1** (`[Text.Encoding]::GetEncoding(28591)`): preserva BOM, CRLF & UTF-8 multibyte, desde que o padrão de busca seja 100% ASCII |
| `Fail`/`Pass` do gate usam **`Write-Host`** ∴ ⊥ entram no pipeline — `$out = & $gate` volta VAZIO & toda mutação parece VERDE | rodar o gate em **processo filho**: `& powershell.exe -NoProfile -File $gate *> $log` |
| `$lines.InsertRange()` recusa `Object[]` | `[string[]]($raw -split "`r`n")` antes |

⚠ `HANDOFF.md` é **LF puro** (3690 LF, 0 CRLF) enquanto `SPEC.md` é **CRLF puro** (3389 CRLF, 0
LF avulso) & o gate é CRLF. São 3 réguas diferentes na mesma raiz — conferir ANTES de escrever.

### §V330c: como um check morre calado

O que estava lá contava `$writers330` num `foreach` e **nunca comparava com nada**. Passou por
verde em todas as rodadas desde que foi escrito. O comentário em cima afirmava a regra ("The
three controls have NO other writer anywhere on the sheet") ∴ quem lesse o gate leria a regra
como medida. É exatamente §B7, & é o motivo de §V20 existir.

**A forma nova mede MENÇÃO, ⊥ escrita**, & isso é decisão, ⊥ atalho: a escrita real é
`found["cboRoad"].enabled = open` mais 2 apelidos locais (`nm.visible`, `md.visible`), ∴ qualquer
regex de `<nome>.visible` acha **0** — inclusive dentro de `renderBearing`, o dono legítimo — &
passa no conjunto vazio. Menção serve porque **⊥ ∃ como tocar um destes 3 controles sem nomear**:
eles só chegam por `xpFind`, que exige a tabela `names`. Hoje: **7** menções, as 7 em
`renderBearing`. A sonda 13 prova que comentário ⊥ conta.

## 139ª RODADA (2026-08-29) — §T765 §T768 §T769 §T793 §T794, & 3 checks novos no gate

### §T765: os 47 antecedentes, do PDF ao `.lua`, em 4 peças

A bancada nova é `research/bg_body.ps1` → `research/bg_body_en.tsv` → tradução à mão em
`research/bg_body_pt.tsv` → `research/gen_bg_desc.ps1` → os 2 `.lua`. Nenhuma peça é opcional:

| peça | o que faz |
|---|---|
| `research/bg_body.ps1` | acha o cabeçalho de cada item nos 4 livros, corta na calha, para no cabeçalho SEGUINTE, junta linha em parágrafo & de-hifeniza |
| `research/bg_body_overrides.tsv` | **12** corpos consertados a mão (coluna embaralhada, tabela no meio, barra lateral cravada) |
| `research/bg_body_en.tsv` | a saída, **131 KB**, 47 linhas |
| `research/bg_body_pt.tsv` | a tradução, **147 KB**, escrita à mão nesta rodada — ⊥ ∃ gerador |
| `research/gen_bg_desc.ps1` | lê o bloco `BG_PICK` + os 2 TSV & escreve os 2 módulos, LF puro |

**A `Find-Gutter` erra em página de 1 coluna com escada de bolinha.** `core` p.113 (o corpo do
`Domain`) é 1 coluna só, mas a indentação da escada faz um pico de brancura no meio & o corte
mandou as últimas palavras de 8 linhas p/ uma "coluna B" — o corpo saiu com buracos
(`efforts by character to identify … in the A Domain`) & 7 fragmentos órfãos no fim (`your`
`domain.` `no` `hunt-` `See` `Six to` `"the`). **⊥ mexi na `Find-Gutter`**: ela é a mesma que o
`extract_merit_flaw.ps1` usa nos 641 nomes & mexer nela p/ 1 página é trocar um erro conhecido
por um desconhecido. O `Domain` foi p/ o override, que é o instrumento que ∃ p/ isso.

**A de-hifenização come hífen de verdade & ⊥ ∃ dicionário p/ evitar.** Ela junta `fami-`+`ly`
(certo) e `name-`+`recognition` (errado) pela mesma regra. A saída é o script **imprimir todas
as colagens** no fim & uma lista NOMEADA de **10** no próprio `bg_body.ps1` (`$HYPHEN_KEEP`):
`fire-ready` `here-and-now` `Low-level` `name-recognition` `non-Technocratic` `semi-permanent`
`single-purpose` `spirit-animal` `two-dot` `well-informed`. Colagem nova ! entra na lista.

**A escada de bolinha decide o que é NÍVEL.** Sem ela cada linha de continuação do nível virava
parágrafo próprio (`One ally of moderate influence and` / `power`). Regra: nível é a bolinha
SEGUINTE da escada (1, depois 2, …); dentro da escada, só outra bolinha ou uma linha que volte
à indentação do marcador abrem parágrafo. A mesma regra resolve o `Auspex` em §T768.

**`U+FFFD` no COMEÇO de linha é bolinha; no MEIO é acentuada.** O V20 core mapeia as 2 no mesmo
ponto de código. Trocar tudo por bolinha escrevia `prot•g•` no lugar de `protégé` (core p.115,
`Mentor`). Só a corrida INICIAL vira bolinha; o que sobra no meio sai no relatório & tem 1
conserto NOMEADO no script — hoje 1 palavra, o `protégé`.

**Tipografia:** `--` → `—` (o travessão que o livro imprime; a camada de texto do core devolve
2 hífens), apóstrofo reto → `’`, aspas duplas ficam como vêm. É a régua do `descMerit`, que é o
irmão de §I102e.

**Fontes, medidas:** `core` 13 itens · `hh` 7 · `w20` 6 · `m20` 21. As páginas saem do bloco
`BG_PICK` de `research/bg_essence.tsv`, que a 138ª já tinha resolvido.

### §T768: os 8 módulos de poder, & a forma INVERSA do númina

`research/gen_desc_system.ps1` ganhou **2** regras & perdeu **1** defeito:

1. **A forma inversa do `descNumina` (§I104e).** Lá `System` é cabeçalho de seção — linha
   sozinha, SEM dois-pontos — & os níveis moram DENTRO dela. O recorte é do cabeçalho até o fim
   da entrada. Sem isso o script rendia **0** recortes em 289 blocos & a trava de §B88 recusava
   o `-Apply`, que é exatamente o que ela existe p/ fazer.
2. **A escada de bolinha**, a mesma de §T765. `Auspex` põe `• Obfuscate:` `• Chimerstry:`
   `• Other Powers:` como LISTA dentro do `System` de um nível; `Sanguinus` & `Grave’s Decay`
   fazem igual. Contadas como nível, elas CORTAVAM o `System` do dono no meio. Isso derrubou as
   exceções de **970** p/ **556**.
3. **O defeito: o script emitia CRLF no bloco reescrito** (`-replace "\n", "\r\n"`), herdado de
   quando se achava que a casa era CRLF. Hoje §V345 cobra **LF** & a casa é LF (§B87). Se
   tivesse rodado assim, os 8 sairiam com 2 formas de quebra de linha no mesmo arquivo.

**Medido:** `descDisc` 36 entradas (129 recortes) · `descNumina` 50 (27) · `descPath` 64 (226) ·
`descRitual` 284 (202). Encolhimento: `descPath_en` 370→**219 KB** (59%) · `descDisc_en`
245→**154 KB** (63%) · `descNumina_en` 210→**138 KB** (66%) · `descRitual_en` 548→**424 KB**
(77%). Backup dos 8 antes de gravar (§B78), & a trava de §B88 segue armada.

**As 23 psíquicas do M20 Sorcerer ⊥ têm marcador NENHUM** — nem `System:` nem o cabeçalho. Elas
caem na regra normal de nível: perdem a prosa introdutória & mantêm cada nível INTEIRO. É
§I104c literal, & é a pergunta 3 da rodada.

### §T769: §V335, 5 pernas, & a lista de 131 nomes

`868` descrições, `1724` blocos de mecânica, `115` deles na forma inversa do númina. A lista
NOMEADA de exceção de §I104c tem **131** pares `<área>|<entrada>`, escrita no gate como
here-string — `descDisc` 7 · `descNumina` 23 · `descPath` 19 · `descRitual` 82. O apóstrofo
curvo entra como `~` & é trocado por `[char]0x2019` na leitura, porque o gate é 100% ASCII
(§B84).

**A perna (c) tem 2 sentidos, ⊥ 1:** nome que sai da lista enquanto a entrada segue sem
marcador ! VERMELHO (a lista protege de menos), **&** nome que fica na lista depois que a
entrada ganhou marcador ! VERMELHO (perdão que ⊥ dispara é perdão esperando a entrada errada
cair nele). Sem o 2º sentido a lista apodrece em silêncio.

**A perna (e) quase nasceu no-op.** A 1ª escrita comparava a contagem contra o que §V210a mede
— & §V210 lê os MESMOS arquivos na MESMA rodada ∴ apagar uma entrada das 2 metades derruba as 2
contagens juntas & nada acende. Virou **literal medido** (`descDisc 36 · descNumina 50 ·
descPath 64 · descRitual 284`), & a comparação contra §V210a ficou com outro papel: as 2
leituras têm de CONCORDAR. A mutação prova: apagar `Flight` das 2 metades deixa §V210a VERDE &
só §V335e vê.

**As 5 mutações rodaram** (§V20): `System:` fora de 1 nível ! (b) · bloco 3 esvaziado ! (d) ·
entrada apagada das 2 metades ! (e) · nome tirado da lista ! (b) · nome morto na lista ! (c).

### §T793/§T794: o `pickerItems`, & o `?` de §B91 que só a tela responde

**RAIZ, como o SPEC já dizia:** `field` nascia dentro do `if filter then` & `current` lê de
`field` ∴ p/ os **14** roots ⊥-filtrados `current` era `nil` & a regra de §V200 ⊥ tinha
executor. O conserto tem 3 partes & todas estão em `WoD20.6.lfm`:

1. `field` & `current` **saem** do `if filter then` — o bloco deixou de existir.
2. O campo se monta com `fieldRoot(nm) .. "_" .. num`, com o número casado por `_?(%d+)$`.
   `cboSpeciality1` ! `speciality_1` (§V346d): a grafia velha, `string.sub(nm, 4)`, respondia
   `Speciality1` & `sheet[field]` saía `nil`, calado.
3. **1** append do órfão, depois do laço & dentro do `if hit == nil` (§V135, §B38). O laço já
   segura `current` quando ele ∈ `vals` (os 2 testes deixam `raw == current` passar) ∴ o que
   chega no append é só o caso do item RENOMEADO.

**`odd` passou a significar 3 coisas, ⊥ 1** (§V346c): o filtro derrubaria · a época do `road`
derrubaria · **a lista autorada ⊥ carrega mais o valor**. A 3ª é a de §B91 & precisa de uma
varredura de `vals` — é ela que põe o órfão na chave do memo.

**2 checks velhos reagiram, & os 2 estavam certos em reagir:**
- **§V242** acendeu em `if not has then` — 4 palavras sem pontuação casam o padrão de "comentário
  que perdeu o `--`". Virou `if (not has) then`. O check ⊥ foi tocado.
- **§V272c** cobrava `string.match(nm, "_%d+$")` LITERAL, que é a grafia que §T793 substituiu.
  Emendada p/ `_?(%d+)$` — aceitar a velha seria deixar o buraco do `speciality` voltar. **⊥
  estava na linha do §T** ∴ é a pergunta 2 da rodada.

**§V346**, 5 pernas + zero-guard, & as **4** mutações de §T794 acenderam: `current` de volta p/
dentro do `if filter` ! (a) · append apagado ! (b) · chave do memo sem o `odd` ! (c) ·
`string.sub(nm, 4)` servindo o speciality ! (d).

⚠ **O `?` de §B91 segue ABERTO & só `§T795` o responde**: se o `comboBox` em branco DEVOLVEU o
vazio p/ o campo, ficha salva antes do conserto ⊥ volta sozinha. ⊥ escrever nenhum dos 2 lados
como fato antes do teste na tela.

### O `pcall` de `popOpen` saiu

`popOpen` fazia `pcall(require, "desc" .. kind .. "_" .. lang .. ".lua")` & o comentário dizia,
com todas as letras, que era andaime p/ a rodada em que `descMerit_*` & `descBackground_*` ⊥
existiam. Os 2 existem desde §T751 & §T765, §V210 mantém as **12** metades na raiz do plugin, &
o `require` ficou igual aos outros 5. Deixá-lo seria comentário mentindo sobre o código (§B73).

## 138ª RODADA (2026-08-28) — as 3 respostas do user, `/ck:spec` & o `Cannibal` consertado

### O que os livros novos mudaram

O user pôs `Books/Werewolf/` (**7** PDFs) & `Books/Mago/Mage - The Ascension`. Medido antes de
usar: `w20` core é **EN**, offset **2** (46 votos, rodapé `298  WEREWOLF…` na pdf 300);
`Mage - The Ascension` é **EN**, offset **1** (333 votos, `Chapter Six: Creating the Character
299` na pdf 300); `Lobisomem W20 - A idade das Trevas` é **PT** (0 "Merit", 26 "Antecedente").

Com isso o `research/bg_essence.tsv` foi **REFEITO**: os **5** nomes que a 137ª deixou com `?`
saíram medidos em `w20` **135-140** (`Ancestors` 136 · `Fetish` 137 · `Kinfolk` 138 ·
`Pure Breed` 138 · `Rites` 139), e as **27** linhas de Mage trocaram de fonte.

**§B90 — e ⊥ foi só o texto que mudou, a PÁGINA mudou.** A edição PT do M20 ordena a lista de
Antecedentes pelo nome **português** ∴ `Library`/`Biblioteca` é p.**309** no PT & p.**318** no
EN; `Status` é 326 no PT & **325** no EN. Seriam páginas erradas impressas na caixa que o
jogador lê, e ⊥ ∃ check que pegue isso — §I21 ⊥ tem como saber se o número está certo.

### `Totem` também parte em 2 — & foi o livro que decidiu

`m20` p.326: `shamans swore pacts with spirit helpers` — pacto PESSOAL. `w20` p.140:
`a Background that applies directly to the character's PACK, rather than the individual…
the pack spends all of the points`. Muda o que se compra & quem paga ∴ `Totem (Mage)` +
`Totem (Werewolf)`, & a lista de antecedente fechou em **47** itens.

O contraste que trava o critério (p/ ⊥ virar mania de dividir): `Resources` repete a MESMA
frase em `core` p.115 & `w20` p.138 (`actual cash, but as this Background increases…`) ∴ 1 item.
Os outros 10 homônimos entre jogos ficaram com 1 item pelo mesmo teste.

### `/ck:spec` rodado (resposta 3 do user)

Escrito: **§R130** (`Obertus` pelo 2º eixo, MEDIDA) · **§R131** (livros novos) · **§R132**
(`Totem`) · **§R133** (a forma do `System` nos 8 módulos) · **§I102g** (chave composta) ·
**§I104e** (a forma do `descNumina`) · **§I105b** emendada · **§V344** · **§V345** ·
**§B87-B90** · **§T791** & **§T792** (nascidas & já fechadas nesta rodada).

**§T786 fechada c/ veredito "⊥ muda nada":** as 2 fraquezas da `Obertus` foram lidas lado a
lado — `da` p.454 `Obsession Derangement` sobre uma área de conhecimento escolhida · `gr` p.102
`Obsessive-Compulsive` p/ a maioria & `Megalomania` p/ a linha Narov. As 2 param em
PERTURBAÇÃO, que esta ficha ⊥ modela ∴ ⊥ é o caso `Grimaldi` (lá o lado medieval trazia NÚMERO,
`only eight blood points`). §V342 já estava certa; o que faltava era a leitura.

### §T791/§T792: o `Cannibal` deixou de comer o irmão

`Cannibal` é Qualidade (`lotc` p.106) **&** Defeito (`gr` p.136) & o módulo de descrição é 1
tabela PLANA por nome ∴ ∃ 2 `["Cannibal"]` no arquivo & em Lua a 2ª sobrescrevia a 1ª, calado.
Consertado c/ chave COMPOSTA (`merit|Cannibal` / `flaw|Cannibal`) nos 2 idiomas, `popOpen`
ganhou o 4º argumento `sub` (opcional, composta primeiro & nua depois ∴ as outras 645 ⊥ mudam)
& **§V344** entrou no gate c/ 5 pernas. **⚠ o PT também estava errado**: os 2 corpos EN são
DIFERENTES & o TSV tinha 1 só ∴ os 2 mostravam o mesmo texto — o corpo PT da Qualidade foi
escrito nesta rodada (`merit|Cannibal`, `merit_flaw_body_pt.tsv` foi p/ 647 linhas).

### §B87 — a correção da 137ª estava para o LADO ERRADO, & foi o `grep` que enganou

A 137ª achou que `gen_merit_data.ps1` emitia LF onde a casa usava CRLF & "provou" o conserto
c/ igualdade byte a byte contra o `descMerit_en.lua` instalado. Isso só provava que ele batia
c/ **aquele arquivo**, ⊥ c/ a casa. §V345, ao nascer, acendeu em **8** módulos de uma vez, e a
contagem por BYTE fechou a questão:

| módulo | CR | LF |
|---|---|---|
| `descDisc` `descNumina` `descPath` `descRitual` (×2 idiomas) | **0** | 1284 / 1474 / 2076 / 3507 |
| `descMerit_en` `descMerit_pt` (antes) | = LF | 8447 / 6857 |

∴ **a casa é LF** & os 2 `descMerit_*` é que eram o desvio. Quem disse o contrário foi
`grep -c $'\r'`, que naquela invocação ⊥ interpretou o `\r` — o mesmo `grep` já tinha dito que
a `localization.lang` era CRLF quando ela ⊥ tem 1 CR. Gerador corrigido nos 2 pontos (literal
**&** junção das linhas), os 2 módulos regerados, & §V345 cobra LF dos 10 lendo BYTE.

### §V336 & §V210, o que elas dizem hoje

- §V336: `47 items with 'Artifacts' between 'Armory' and 'Avatar' … each of the 4 origin
  suffixes with a sibling, and leg (e) MEASURED NOTHING because descBackground_*.lua are not
  at the plugin root yet (SPEC T765)` — a perna (e) está ARMADA & anuncia que ⊥ mediu.
- §V210: `5 areas in 10 modules, 1081 entries keyed alike on both sides`.

### As 6 mutações da rodada (§V20), todas acenderam

§V344: chave nua duplicada · `merit|Cannibal` sem irmão · prefixo em nome de 1 lista só ·
`popOpen` c/ chave literal. §V345: 1 `desc*.lua` reescrito em CRLF. §V333 precisou de emenda
junto — ela fixava a assinatura `popOpen(from, kind, key)` literal & o 4º argumento a
reprovava; virou `key(, sub)?`, c/ os 3 primeiros ainda presos na ordem.


## 137ª RODADA (2026-08-28) — §T751 fechada, a lista de antecedente decidida & §T768 travada

### §T751: os 31 corpos PT que faltavam

`research/pt_body.ps1 -Append` levou `merit_flaw_body_pt.tsv` de **615** para **646/646**.
`gen_merit_data.ps1` então gravou `descMerit_pt.lua` (**566.159 B**, 647 entradas) e ela foi
instalada no plugin.

**O vocabulário seguiu a régua** (`descDisc_pt` é quem manda, ⊥ o `.lang`): `Celerity` =
**Celeridade** (16× em `descDisc_pt`; o `.lang` diz `Rapidez`, que é o item do dropdown, outra
superfície) · `Dementation` = **Demência** · `True Brujah` = **Verdadeiros Brujah** (do `.lang`)
· `Protean` = **Metamorfose** · `Beast Form` = **Forma da Besta**.

O lixo do corpo EN ⊥ foi para o PT, como o HANDOFF anterior mandava: `Twin Link` engolia a
entrada `Wild Talent` inteira (que ⊥ ∃ como chave nos 646) · `True Love` tinha `Mer- 493 it`
no meio · `Vitae Mutation` acabava em `60 KIASYD` · `Tracker's Mark` veio com as 2 colunas
intercaladas e o PT foi RECONSTRUÍDO dos pedaços.

### §B novo em potencial — o gerador emitia LF dentro do literal

`descMerit_en.lua` recém-gerado diferia do INSTALADO em **6486 linhas** sem **1 char de texto**
diferente: `gen_merit_data.ps1` montava o bloco com `` `n `` (LF) enquanto os 8 módulos de
descrição que a ficha já carrega — e o `descMerit_en.lua` instalado — usam **CRLF em toda
linha**. Corrigido na função `Blocks`, e a prova é dura: depois da correção o `descMerit_en.lua`
gerado ficou **byte a byte igual** ao instalado. Sem isso, `descMerit_pt.lua` entraria com uma
forma de fim-de-linha que nenhum outro módulo usa.

### §V210 cresceu de 4 áreas para 5

A lista de áreas de §V210 era literal de 4 (`descDisc` `descNumina` `descPath` `descRitual`) ∴
`descMerit` nasceria FORA dela. Virou `$v210Areas` com `descMerit`/`MERIT_DESC` junto & a
mensagem de Pass passou a derivar as contagens da lista, em vez de trazer "four areas in eight
modules" escrito à mão. Agora: **5 áreas em 10 módulos, 1081 entradas iguais dos 2 lados.**
Mutação rodada: apagar `Well-Rounded` da metade [pt] ! VERMELHO em §V210a.

### §T764: a medição que decidiu a lista de antecedente

`research/bg_essence.tsv` — 1 linha por (nome, livro), `<nome EN>\t<jogo>\t<livro>\t<pág>\t
<essência>`. Instrumentos: a calha de `extract_merit_flaw.ps1` reusada numa sonda de scratchpad.

**A bolinha de nível do V20 core sai como `U+FFFD`**, ⊥ `U+2022` — é glifo próprio que o
`pdftotext` ⊥ mapeia. A 1ª sonda deu **0 candidatos** por causa disso. Armadilha nova.

**O M20 PT decora o cabeçalho**: `Arcano/Camuflagem` · `Avatar/Gênio` · `Capela/Construto` ·
`Sanctum/Laboratório $` · `Armas Secretas*` · `Sonhos/Hiper Ecrã` · `Aprimoramento $`. Casar o
nome exato dava 0; foi preciso tirar `*`/`$` e aceitar a barra.

**A decisão de §I105b, tirada da tabela:** 13 dos 45 nomes existem em mais de 1 jogo. **11
ficam com 1 item** (`Allies` `Alternate Identity` `Contacts` `Fame` `Influence` `Library`
`Mentor` `Rank` `Requisitions` `Resources` `Retainers`) — são traços do mundo mortal que os 2
livros descrevem igual, e um `(Origem)` ali ⊥ separaria mecânica nenhuma. **`Status` vira 2**:
V20 p.118 é pé dentro da comunidade Kindred (vem do senhor/linhagem na Camarilla, da matilha no
Sabá); M20 p.326 é reputação entre pares Despertos e só em 4-5 alcança grupos aliados — duas
escadas sociais que ⊥ convertem uma na outra, e é o exemplo que o próprio user deu.
**`Totem` fica em aberto**: lado Mage medido, lado Werewolf sem livro.

### §V336, 6 pernas, & a perna que anuncia que ⊥ mediu nada

(a) `Artifacts` entre `Armory` & `Avatar` · (b) `wod.Node`=`Nodo` & `wod.Pure Breed`=`Raça Pura`
LITERAIS no [pt] e o inglês intacto no [en] · (c) ⊥ ∃ item 2× · (d) ∀ `Nome (Origem)` tem irmão
· (e) ∀ item tem chave em `descBackground_en` & `_pt` · (f) zero-guard.

`descBackground_*` ⊥ ∃ ainda (§T765) ∴ a perna (e) ⊥ tem o que medir — e o **Pass diz isso em
voz alta**: `…and leg (e) MEASURED NOTHING because descBackground_en.lua and _pt.lua are not at
the plugin root yet (SPEC T765)`. É o oposto de §B7: em vez de passar calado sobre nada, o
check soletra o que ⊥ mediu. As **6** mutações rodaram, inclusive a (e), com um par de módulos
de stub — e a (e) acendeu nos 2 modos (só uma metade ∃ · as 2 ∃ e faltam chaves).

`Raça Pura` entra no gate como `"Ra" + [char]0xE7 + "a Pura"`: o `.ps1` ⊥ tem BOM ∴ literal
acentuado chegaria mojibake e a comparação falharia CALADA (§B84). O gate ficou **100% ASCII** —
tinha 1 `Â§T681` sobrando num comentário de §V307, corrigido.

### §T680 & §T749 estavam prontas e marcadas errado

§V307a já usava **1** literal (`$clear307 = 1`) e a mensagem de Pass já o soletra. A mutação que
§T680 pedia (`ORN_MARK2` de volta a 7) foi rodada e **acende §V315** — a relação
`ORN_FIL_MARK + ORN_FIL_CROSS == ORN_MARK2` — que é o que prova que a constante é lida de
verdade; a sonda `ORN_SUB_MARK` ficou verde em §V307a e §V308. §T749 tem `merit_flaw.tsv`
inteiro e §V343 o mede (782 linhas, 641 nomes, 0 órfão). As 2 viraram `x`.


## 136ª RODADA (2026-08-28) — §T790 fechada & 615 dos 646 corpos PT

### §T790: a decisão de layout do user, buildada

O user pediu **3 partes de 1 decisão só**: `BACKGROUNDS` −6, as caixas à direita das tabelas
−15 cada, & **todo** o espaço liberado p/ o NOME da qualidade/defeito. Buildado & instalado:

| caixa | antes | agora |
|---|---|---|
| `BACKGROUNDS` | `0` `370` | `0` **364** — as 21 linhas seguem `300` & andaram `left 35`→**32** |
| `MERITS` & `FLAWS` | `375` `485` | **369** **536** |
| col 1 · 2 · 3 (11 caixas) | `865` `1110` `1355`, `240` | **910** · **1140** · **1370**, **225** |

Dentro das tabelas: linha `20/496` · `?` **0/20** · nome **20/246** · livro 266/80 · página
346/100 · custo 446/50, & os 4 cabeçalhos em 40/246 · 286/80 · 366/100 · 466/50.
Fecha em **1595** = 364+5+536+5+225+5+225+5+225 — o mesmo x de antes, vãos de 5 intactos.

**O ganho real:** o nome em 246 contra o pior nome em [pt] a 240 ∴ **0 de 646 cortam** (eram 2).

### §B86 — a régua de largura tem 2 DONOS, & medir pelo dono certo ⊥ basta

A 1ª escrita de §T790 mandava as linhas de antecedente p/ **294**, o que arrasta o picker p/
**164**. Medi por **§V196**, que escolhe a régua pelo `fontSize` do próprio controle (§V312a):
12pt ∴ 6,0 px/char, `Identidade Alternativa` pede 132 + 24 da seta = **156**, cabe. O gate saiu
VERMELHO em **§V312c**, que ⊥ usa a régua do controle: ela cobra de TODO
`comboBox[@fontSize='12']` fora dos 4 de §I86d que siga passando na régua VELHA de **6,5** ∴
143 + 24 = **167**. O picker tinha folga p/ 3, ⊥ p/ 6.

Consertado **sem gastar largura nenhuma**: os 6 saíram do AR (linhas `left 35`→32, `width`
segue 300), que é também a leitura mais literal do pedido do user ("3 da esquerda e 3 da
direita **do conteúdo**"). `OpenAbility` & `OpenAbilityFreeRow` ⊥ foram tocados.

### 2 COISAS QUE O HANDOFF ANTERIOR DIZIA & A LEITURA DO GATE DESMENTIU

- **"§V290 tem de ser emendada junto, os x mudam"** — FALSO. §V290 ⊥ carrega literal de x:
  lê o template, cobre encaixe sem costura (`L+W ≡ próximo L`) & 1 cabeçalho em `rowL + c.L`
  c/ a MESMA largura. A geometria nova passou nela **sem 1 char de emenda**.
- **"§V69 lê o mapa do topo do `WoD20.2.lfm`"** — §V69 lê o mapa do **`.1`**. Nada no gate lê o
  do `.2`. Ele foi reescrito assim mesmo (§B73 como PRÁTICA: comentário que mente sobre
  geometria), mas ⊥ ∃ check por trás dele.

### A METADE PT DE §T751: 615 de 646, & a bancada ficou no repositório

`research/pt_body.ps1` (novo, ASCII-only por §B84) substitui as 3 ferramentas de scratchpad da
rodada: `-Plan` diz quanto falta, `-Next` imprime o próximo lote de corpos EN tirados do
`descMerit_en.lua` JÁ INSTALADO, `-Append` valida & anexa. O corpo EN sai do `.lua` & ⊥ do PDF
porque o `.lua` já tem as 647 chaves finais & os 3 blocos de §I21.

**491.203 chars** de corpo EN no total, média 759. Em 34 lotes de ~13k chars saíram **615**.
Faltam **31**, do `The Company of Saints and Heroes` em diante.

O que a leitura de 615 corpos, um a um, revelou está na seção **⚠ O CORPO EN ESTÁ SUJO** lá em
cima — inclusive os **3** defeitos que existem no livro & ⊥ ∃ como entrada na ficha, & a
**chave duplicada `Cannibal`** em `descMerit_en.lua`, que é a coisa mais séria da rodada
porque o gate ⊥ a pega.

### O QUE ENTROU NO SPEC

`§T790` reescrita p/ dizer o que foi construído · `§B86` NOVA · `§V196` ganhou o ponteiro p/ o
2º dono da régua. ⊥ nasceu §V novo: §V312c pegou o caso na 1ª rodada do gate, que é p/ isso que
ela ∃.


## 135ª RODADA (2026-08-28) — LEIA ESTA PRIMEIRO

Gate **VERDE, 603 ok, 0 FAIL**, com `-Build`. `.rpk` **2.214.481 → 2.496.355 B**, instalada.
**§T750 e §T788 FECHADAS**, `§T751` metade. `§T749` segue `~` (o extrator fechou; falta o
`.tsv` por livro que o texto dela pede, e ele deixou de fazer falta).

### O PROBLEMA DA 134ª, RESOLVIDO NA RAIZ

O extrator de corpo lia página de 2 colunas como se fosse 1. O fim de um corpo só é confiável
quando se acha o **cabeçalho seguinte**, e numa página de 2 colunas ele está na OUTRA coluna, a
centenas de linhas na ordem de leitura — daí os **17 corpos inchados** e os 2 vazios.

**Cura: `pdftotext -layout -enc UTF-8` + corte na CALHA por página** (`Find-Gutter` /
`Split-Page` em `research/extract_merit_flaw.ps1`). O `-layout` põe as colunas lado a lado
separadas por uma calha de espaços; o extrator acha a calha **por página** e corta cada linha
nela, lendo esquerda inteira → direita. Aí o cabeçalho seguinte volta a ficar logo abaixo.

| medida | antes | depois |
|---|---|---|
| `Simply Waiting` (`lob` p.16) | **4425** chars | **488** (o real) |
| corpo vazio | 2 | **0** |
| corpo total | 759 KB | **573 KB** — a queda é junk, ⊥ texto bom (mediana 517 → 502) |
| linhas do `.tsv` com corpo | 782 de 783 | **782 de 782** |

### A LIÇÃO ⊥ É A CALHA — É QUE **COMPRIMENTO ⊥ ACUSA NADA**

O CSV ganhou a coluna **`Stop`**, que diz POR QUE o corpo parou, e é ela que separa confiável
de duvidoso: **`head` 711** (achou o cabeçalho seguinte — único fim confiável por construção) ·
`cut` 47 · `sect` 12 · `page` 4. Corpo de **6296** chars que fechou em `head` está CERTO
(`bos` e `gr` têm entradas longas de verdade); corpo de **921** que atravessou 2 páginas está
ERRADO. A 134ª caçava por tamanho e por isso conferia 58 entradas boas.

O corte por "linha com cara de título", **reprovado na 134ª** por comer 24% do texto bom, foi
reabilitado numa forma diferente: ele só toca os corpos que **⊥ acharam o cabeçalho seguinte**.
Nessa forma derrubou `Plague of Demons` de 4686 p/ **527** (fim exato) e `Unholy Stain` de 3826
p/ **518**, sem tocar 1 char dos 711 confiáveis.

### 5 DEFEITOS ACHADOS PELO CAMINHO, TODOS MEDIDOS

1. **As 81 linhas do `da` estavam SEM TIPO desde a §T749** e ninguém viu, porque nada as lia.
   A notação 4 (`Ambidextrous (1 point):`) ⊥ diz Merit nem Flaw — o tipo vem do cabeçalho de
   seção, e o extrator ⊥ o guardava. Corrigido: **27 Merit + 54 Flaw**. Virou **§B83** e
   **§V343a**. Dado que ninguém lê ⊥ tem gate ∴ apodrece calado.
2. **Caractere ⊥ ASCII em regex de `.ps1` sem BOM ⊥ dá erro — dá SILÊNCIO.** O extrator velho
   tinha o apóstrofo curvo LITERAL nos regex; o PowerShell 5.1 lê `.ps1` sem BOM como ANSI ∴
   com `-enc UTF-8` as **15** entradas com apóstrofo sumiam e **783 viravam 768, saindo 0**.
   O diagnóstico de 1ª hora culpou a FLAG e quase gravou "⊥ pôr `-enc`" na receita — o que
   deixaria o corpo inteiro em Latin-1, com travessão virando **U+FFFD**. A causa era o SCRIPT.
   Virou **§B84**. O de hoje é 100% ASCII e roda COM `-enc UTF-8`.
3. **`§I100d` prometeu "⊥ ∃ nome em comum entre qualidade & defeito — CONFERIDO antes de
   valer"** e a conferência só rodou 2 rodadas depois. Ela achou **1**: `Cannibal`, Merit 1pt
   (`lotc` p.106) e Flaw 3pt (`gr` p.136). ∴ o módulo nasce com **2** tabelas. Virou **§B82**.
4. **`§V340a` exigia `cost` ⊥ vazio** e 2 entradas ⊥ TÊM custo no livro (`Construct` e
   `Stormwarden`, m20va p.122, notação 7 imprime só a categoria). A perna obrigava a INVENTAR
   número. Emendada com os 2 NOMEADOS.
5. **A linha `Japheth lob 4` era ponto de SUMÁRIO**; o item real é `Disciple of Lazarus /
   Japheth` (`lob` p.48), que já estava na lista. 783 → **782** linhas.

### A ORIGEM EM [pt] FOI ALINHADA NA FICHA INTEIRA (user 2026-08-28)

`Bratovich (Trevas)` estava ERRADO — o user corrigiu p/ `Bratovich (Idade das Trevas)`, & a
mesma régua passou nas outras 4 de época: `(Moderna)` → `(Era Moderna)` em `Bratovitch`,
`Grimaldi` & `Gárgulas`. PAPEL ⊥ é origem: `Gárgulas (Batedoras)`/`(Sentinelas)`/`(Guerreiras)`
ficam. A tabela única está no `research/merit_flaw_dedupe.md` & o gerador a usa.

⚠ **O gate mordeu na hora**: §V196 acusou `cboClanFamily` de **192px** com o item novo pedindo
**206** — combo CORTA, ⊥ quebra linha. §I30 já tinha decidido quem cede ("a COLUNA, ⊥ a lista")
∴ o combo & o gêmeo digitado foram p/ **210**, & a coluna seguinte segue em 394 (§V224). Foi o
check achando um estrago de tradução ANTES da tela.
### O QUE ENTROU NO SPEC

`/ck:spec` rodou em modo BACKPROP: **§I100d** e **§V340** emendadas · **§V342** ESCRITA (a
dívida da `Obertus` — o gate já a implementava e reservava o número) · **§V343** NOVA ·
**§B82…§B85** · **§T750** e **§T775** emendadas · **§T788** NOVA, e já `x`.

### O QUE FOI CONSTRUÍDO

- **`meritData.lua`** (novo, 60 KB) — `MERIT_DATA` **310** + `FLAW_DATA` **336**,
  `return { merit = …, flaw = … }`. Módulo próprio, ⊥ `<script>` de `.lfm` (§I100g).
- **`PICKER_LIST["merit"]` / `["flaw"]`** no `WoD20th.lfm`, 311 e 337 itens com o vazio.
- **634** chaves `.lang` novas em [pt] e em [en] + **634** no mapa PT do `WoD20.6.lfm`
  (as outras 11 já existiam e as traduções BATERAM, 0 conflito).
- **`descMerit_en.lua`** (novo, 571 KB) — **646** entradas na forma de 3 blocos de §I21.
- **`research/gen_merit_data.ps1`** (novo) — o gerador único: lê `merit_flaw.tsv` +
  `merit_flaw_pt.tsv` + as 3 regras de `merit_flaw_dedupe.md` e escreve tudo acima.
- **§V340 + §V343 no gate**, com as 6 mutações rodadas antes de aceitar.

### A LISTA FINAL, MEDIDA

**646 itens** = **310 Merit + 336 Flaw**, de 641 nomes em 782 linhas, mais os 5 desdobramentos
da Regra 3 (`Bound` `Apostate` `Loyalty` `Oathbreaker` `Berserker`), mais `Cannibal` contado nas
2 listas. **645 chaves `.lang` distintas.** O `merit_flaw_dedupe.md` previa 642 — o número que
vale é **646**.

### PRÓXIMO

1. **Os 646 corpos em PT** → `research/merit_flaw_body_pt.tsv` → `descMerit_pt.lua` → §T751 `x`.
2. **A sonda de tela da Q23**, que destrava §T756/§T783/§T784.
3. **§T764** (antecedentes), que ⊥ depende de nenhuma das duas.


## 134ª RODADA (2026-08-28) — SUPERADA PELA 135ª (o extrator foi reescrito e o aceite bateu)

Gate **VERDE, 599 ok, 0 FAIL**. `.rpk` inalterada. Rodada de **pesquisa**.

### O PROBLEMA DE VERDADE: LAYOUT DE DUAS COLUNAS

O user mandou o texto real de 3 entradas, e a comparação expôs o que os números escondiam:
`Simply Waiting` real tem **488** chars e a extração dava **4425**. ⊥ era "ilegível" — era
**INCHADO**, seguindo adiante para dentro de uma tabela de ritual.

**Diagnóstico:** o fim de um corpo só é confiável quando se acha o **cabeçalho seguinte**. Em
página de 2 colunas o cabeçalho seguinte está **na outra coluna** ∴ a centenas de linhas de
distância na ordem de leitura, e o corpo corre até o teto.

⊥ ∃ modo do `pdftotext` que resolva: **`-raw` acerta a ordem & cola as palavras**; o **padrão
limpa as palavras & erra a ordem**. Os dois foram medidos.

### QUANTOS ESTÃO INCHADOS — medido, ⊥ estimado

Cruzei o modo padrão contra a extração `-raw` (que acerta a ordem): dos **58** corpos acima de
3000 chars, **17 são suspeitos** (padrão ≥ 1.8× o `-raw`). Conferi a cauda de 6 deles e **os 6
estão inchados**, cada um caindo em coisa diferente:

| entrada | livro/pág | tem | cauda cai em |
|---|---|---|---|
| `Simply Waiting` | lob 16 | 4425 (real **488**) | tabela do ritual de Re-Abraço |
| `Child` | bos 39 | 3195 | o texto do Defeito `Impediment` |
| `Dreadful Mara` | lob 60 | 4844 | custo em XP de um poder + rodapé |
| `Innocent` | hh 142 | 8849 | regra de alquimia de metais |
| `Paradise Lost` | hh 125 | 9234 | `Chapter Six: Organizations and Resources` |
| `Occult Library` | gr 139 | 7741 | `CHAPTER FIVE: CHARACTER CREATION` |
| `Sanctuary` | hh 44 | 5912 | regra de pontos de experiência + rodapé |

Os outros 11 suspeitos: `Unproven` lotc 123 · `Kashaph` rob 100 · `Well-Rounded` m20va 119 ·
`Rat in a Cage` lotc 87 · `Shadow Walker` lotc 107 · `Devil's Mark` bos 83 ·
`Banshee-in-Waiting` lob 26 · `Incoherent` lotc 163 · `Lost Svadharma` lotc 183 ·
`Ravnos Jati` dac 101 · `Nine Lives`/`Aging` (⊥ conferidos um a um).

⚠ Os **39** "confirmados pelo `-raw`" ⊥ são prova de que estão certos — os 2 podem estar
inchados juntos. O que a comparação prova é só que **⊥ divergem entre si**.

### ⛔ UMA CURA TENTADA E REPROVADA

Cortar o corpo em **"linha com cara de título"** (curta, capitalizada, sem pontuação no fim).
Consertava o `Simply Waiting` (4425 → 266) **e comia 24% do texto bom do corpus** — a mediana
caiu de 517 p/ 489 e o total de 759 KB p/ 578 KB. **REVERTIDO. ⊥ repetir.**

### ✅ O CAMINHO CERTO, JÁ TESTADO: `-layout` + corte na CALHA

`pdftotext -layout` preserva as colunas **lado a lado** na mesma linha, com uma **calha** de
espaços entre elas. Medido em 3 livros diferentes:

| livro | página | calha na coluna | em quantas linhas |
|---|---|---|---|
| `lob` | 17 | 61 | 43 de 50 (**86%**) |
| `hh` | 126 | 66 | 46 de 55 (**84%**) |
| `gr` | 140 | 59 | 38 de 56 (**68%**) |

∴ dá p/ **achar a calha por página** (a coluna onde a maioria das linhas tem branco), **cortar
cada linha nela** e ler as 2 colunas na ordem certa. Aí o cabeçalho seguinte volta a ficar
**logo abaixo** do corpo e o problema **desaparece na raiz** — junto com os 2 corpos vazios, que
são a mesma doença pelo outro lado.

**É uma reescrita do extrator, ⊥ um remendo.** Fazer numa sessão fresca.

### O QUE FICA VALENDO ATÉ LÁ

`research/merit_flaw.tsv` (783 linhas · 642 nomes) · `merit_flaw_pt.tsv` (642, 0 órfãs) ·
`merit_flaw_dedupe.md` · **`merit_flaw_overrides.tsv`** com os **3** textos que o user copiou do
livro (`Isolated Upbringing` gr 129 · `Discerning Palate` bh 177 · `Simply Waiting` lob 16).

⚠ **⊥ gerar `descMerit_en.lua` antes de refazer o extrator.** 17+ corpos entrariam com texto de
outra entrada colado no fim, e isso é o que o jogador leria na caixa do `?`.

### PRÓXIMO

1. **Reescrever o extrator de corpo com `-layout` + calha.** Aceite: `Simply Waiting` = 488
   chars, 0 corpos vazios, e nenhum corpo acima de 3000 sem conferência.
2. **`T751`** — `descMerit_en.lua` na forma de §I21, com o extrator novo.
3. **`T750`** — `meritData.lua`, listas e `.lang`, aplicando o dedupe já decidido.


## 133ª RODADA (2026-08-28) — corrige a 132ª

`.rpk` inalterada. Gate **VERDE, 599 ok, 0 FAIL**. Rodada de **pesquisa**.

### ⚠ TROQUEI O MODO DE EXTRAÇÃO — a 132ª está DESATUALIZADA nos números

47% dos corpos extraídos saíram com **palavras coladas**
(`sufferahigherdifficultyifyouu`) — texto que o jogador ⊥ conseguiria ler na caixa do `?`.
A causa é o `pdftotext -raw`: ele devolve ordem de leitura (por isso a armadilha 1 o escolheu)
mas **perde os espaços** que o PDF codifica como posicionamento.

O **modo PADRÃO** (sem flag nenhuma) resolve, e ⊥ funde as colunas como o `-layout` faria.
Medido nos 15 livros:

| | `-raw` | **padrão** |
|---|---|---|
| palavras coladas no texto inteiro | 16.745 | **1.181** (6 livros a ZERO) |
| corpos de qualidade/defeito sujos | 365 de 770 | **8 de 783** |
| entradas encontradas | 770 | **783** |

**Virou armadilha 8 do `research/README.md`**, com a regra: *nome e campo curto → `-raw`;
parágrafo que o jogador vai LER → modo padrão.*

### O QUE ISSO CONSERTOU SOZINHO

- **Os 5 nomes GRUDADOS acabaram.** `FleshoftheCorpse`, `TouchofFrost`, `SpiritMentor`,
  `LinguaFranca`, `HarbingeroftheAbyss` vieram com espaço e ⊥ ∃ mais nada a fundir à mão.
- **`Mark of Caine` saiu**: era **falso positivo** — só aparece em prosa (`"twisted by the mark
  of Caine"`), nunca como cabeçalho de Qualidade.
- **`Technobabbler` virou `Esoteric Discourse / Technobabbler`**, que é o nome inteiro que o
  `bos` p.4532 imprime. O `-raw` cortava o nome ao meio.
- **6 entradas novas** que o `-raw` perdia: `Japheth` (`lob` p.457), `Demonic Patron`,
  `Unholy Stain`, `Harbinger of the Abyss`, `Lingua Franca`, e o composto acima.

### UM GUARDA NOVO, E UM ERRO DELE QUE EU PEGUEI

`tos` p.900 é linha de **sumário** com 4 entradas coladas
(`Unholy Worship Blasphemous Pact (6 pt...) Demonic Patron (5 pt...) ...`) e virava um nome
inventado. Guarda: **linha com mais de um custo entre parênteses ⊥ é entrada**.

⚠ O guarda cru comeu junto a `Unclean` (`da` p.421), que é **legítima** — a forma do `da` traz
prosa na mesma linha, e a prosa dela tem um 2º parêntese com pontos
(`"...receive only 1 point for it and must take its full effects (3 points)"`). Afinado para
⊥ valer na forma com dois-pontos. **Um guarda de sumário ⊥ pode ser cego à notação do livro.**

### NÚMEROS FINAIS — ZERO ilegível, ZERO vazio

**642 nomes distintos** em **783 linhas** · **0 corpos ilegíveis** · **0 corpos vazios**.

Depois da troca de modo sobraram **10** corpos ruins, e os 10 foram consertados:

**8 embaralhados, todos do `lob`** (`Simply Waiting` p.16 · `Banshee-in-Waiting` p.26 ·
`Blood Weakness` p.37 · `Shadow Scarred` p.48 · `Dreadful Mara` p.60 · `Body Trail` p.70 ·
`The Eighth` p.80 · `Mortal Flashbacks` p.91). ⊥ era o modo de extração: o corpo estava
**passando do fim da entrada** e engolindo **página de abertura de capítulo**, que é epígrafe
e arte em fonte decorativa — e fonte decorativa a camada de texto devolve embaralhada.
2 guardas novos: **descrição ⊥ atravessa 2 viradas de página**, e **linha com 22+ letras
seguidas ⊥ é prosa** e sai fora.

**2 vazios** (`Isolated Upbringing` `gr` p.129 · `Discerning Palate` `bh` p.177). Causa:
página de **DUAS COLUNAS** em que o `pdftotext` devolve o cabeçalho da coluna A, depois o da
coluna B, e só então os dois corpos — fora de ordem. O parser dá o corpo de B para B e deixa A
vazio. **2 casos em 783**: ensinar o parser a ler coluna sairia mais caro que o problema, então
foram preenchidos à mão em **`research/merit_flaw_overrides.tsv`**, que o gerador de `T751` lê.
⚠ Se a contagem de vazios subir acima de 2, a extração mudou — conferir antes de só somar linha.

**+3 corpos** que estavam vazios por outro motivo (`Construct` · `Enemy` · `Language`, `m20va`
p.122): a notação 7 traz a prosa **na mesma linha**, depois do parêntese, e o parser só pegava
isso na forma do `da`. Corrigido.

### O DEDUPE ⊥ MUDOU

As 5 divisões da Regra 3 (`Bound` · `Apostate` · `Loyalty` · `Oathbreaker` · `Berserker`) e as
regras 0/1/2 seguem valendo — a extração limpa ⊥ mexeu em nenhum dos 61 conflitos julgados.

### PRÓXIMO

`T751` — gerar `descMerit_en.lua` a partir de `mf_bodies4.csv` na forma de §I21, tratando os
5 corpos vazios. Depois a tradução das 642 descrições, em lotes, ao longo de sessões.


## 132ª RODADA (2026-08-28) — NÚMEROS SUPERADOS PELA 133ª

`.rpk` inalterada (**2.214.481 B**, instalada 15:21:02) — rodada de **pesquisa**, ⊥ tocou código.
Gate **VERDE, 599 ok, 0 FAIL**.

Entregue: **`research/merit_flaw_dedupe.md`** — o dedupe DECIDIDO, com o texto dos livros lido
lado a lado. É o que destrava `T750` e `T751`.

### O QUE A LEITURA MOSTROU

Extraí o **corpo da descrição** de todas as 770 entradas (**669 KB**, mediana de 517 caracteres,
**nenhuma vazia**). Com o texto na mão, os **61 casos em conflito** se separaram em 4 grupos:

| regra | casos | o que acontece |
|---|---|---|
| **0** — tipo diferente | 1 | ⊥ é conflito: Merit e Flaw caem em **tabelas diferentes** da ficha |
| **1** — mesma mecânica, mesmo custo | 41 | 1 item, sem sufixo. Precedência do README dá Livro e Página |
| **2** — mesma mecânica, custo diferente | 14 | **ainda 1 item**: o 12.1 fala em MECÂNICA, ⊥ em preço |
| **3** — mecânica diferente | **5** | viram `Nome (Origem)` |

**Só 5 nomes** precisam de sufixo: `Bound`, `Apostate`, `Loyalty`, `Oathbreaker`, `Berserker`.
Todos os outros 91 fundem. O medo de "700 itens com parêntese em tudo" ⊥ se confirmou.

### A REGRA DO SUFIXO, estendida

§I105b dizia "Origem = o jogo". ⊥ basta: `Apostate` é de **dois livros de Vampiro**. A regra que
os 5 casos exigiram, e que a ficha **já pratica**:

- **jogo** quando os jogos diferem — `Bound (Vampire)` × `Bound (Mage)`
- **época** quando os 2 são de Vampiro mas de épocas distintas — `Apostate (Dark Ages)` ×
  `Apostate (Modern)`, do mesmo jeito que `Bratovich (Dark Ages)`
- **clã** quando é regra de um clã só — `Oathbreaker (Ravnos)`, do jeito de `Obertus (Narov)`

Isto ! virar emenda de §I105b.

### ⚠ DOIS ACHADOS QUE TERIAM ENTRADO SUJOS

1. **`Vengeful` ganhou uma 4ª entrada falsa.** O corpo dela em `gr` p.168 é
   `"Path of Enlightenment: The Path of Power and the Inner Voice 4 Willpower: 3 …"` — um
   **bloco de ficha de personagem**, ⊥ um Defeito. O cabeçalho casou por acidente. **Descartada.**
2. **`Cannibal` ⊥ é duplicata:** `lotc` p.106 é **Qualidade de 1pt** (consegue comer comida) e
   `gr` p.136 é **Defeito de 3pt** (compulsão por carne humana). Mecânicas **opostas**, e a ficha
   já as separa em duas tabelas. Um dedupe por nome cru teria fundido as duas.

⚠ `Unbondable` tem **4 custos diferentes em 4 livros** (core 5, bos 4, da 3, gr 6). Funde pela
precedência (5, do core), mas é o caso que mais vale conferir na tela.

### CONTAGEM FINAL PREVISTA

643 nomes − 5 grudados − 1 erro de parser + 5 desdobramentos = **642 itens**.

### ⚠ A FERRAMENTA WRITE EMITIU LF DE NOVO (§B81)

`merit_flaw_dedupe.md` saiu **0 CR / 91 LF**. Medi e consertei na mesma volta. **Medir
`CR == LF` depois de TODA escrita por ferramenta** — é a 2ª vez que morde.

### PRÓXIMO — a ordem importa

1. **`T751`** — `descMerit_en.lua`. Os corpos **já estão extraídos**; falta a forma de §I21
   (livro+pág · 2 linhas · nome · 2 linhas · texto) e o módulo. ⚠ **`descMerit_pt.lua` é o
   gigante**: 643 descrições para traduzir. Os 8 `.lua` que já ∃ somam 2,8 MB e foram feitos
   assim, em lotes. **Planejar como trabalho de várias sessões**, ⊥ tentar numa só.
2. **`T750`** — `meritData.lua` + `PICKER_LIST` + as chaves `.lang`, aplicando este dedupe.
   ⚠ 632 chaves novas × 3 lugares (`[pt]`, `[en]`, PT map) quase **dobram** o `.lang`.
3. **`T756`/`T757`/`T761`** · **`T783`–`T785`** · **`T764`–`T767`**.

### ARQUIVOS DE TRABALHO (morrem com a sessão)

`<scratchpad>/txt/*.txt` (texto dos 15 livros) · `mf_raw.csv` · `mf_bodies.csv` (os 669 KB de
descrição). Reextrair custa ~4 min com os scripts do `research/README.md`.

### PERGUNTA ACUMULADA (⊥ trava nada)

**Q22** — os 84 termos do V20 core marcados `R` em `research/merit_flaw_pt.tsv` valem uma
passada de olho do user. **Recomendação: ⊥ esperar** — a correção entra depois por substituição
no `.tsv` e regeneração.


## 131ª RODADA (2026-08-28)

`.rpk` inalterada (**2.214.481 B**, instalada 15:21:02) — rodada de **pesquisa**, ⊥ tocou código.
§T sem mudança (`T749` e `T750` seguem em aberto — ver abaixo).

Entregue: **`research/merit_flaw_pt.tsv`** — os **643** nomes traduzidos, **0 faltando**.

### A TRADUÇÃO — opção C, escolhida pelo user

Só **11** dos 643 já tinham chave `[pt]` na ficha. Faltavam **632**, mais da metade do que a
ficha inteira tem hoje (1077 chaves). Traduzi os 632 e **marquei os duvidosos**:

| marca | qtd | o que é |
|---|---|---|
| (sem marca) | 439 | tradução direta, sem jargão. Entram sem revisão. |
| **`R`** | **199** | termo consagrado de mesa — traduzido, mas ⊥ conferido contra edição BR |
| `ARTEFATO` | 5 | nome saiu **grudado** do `pdftotext` (`FleshoftheCorpse`) |

**Dos 199 marcados `R`, só 84 vêm do V20 core** — e esses são os que um jogador brasileiro
reconhece de cara (`Iron Will`, `Common Sense`, `Dark Fate`, `Nine Lives`…). **É essa a lista
curta que vale o olho do user.** Os outros 115 são de suplemento, onde ⊥ ∃ tradução consagrada
p/ conferir contra.

O estilo segue as **11 que a ficha já tinha** (`Child`=Criança, `Legerdemain`=Prestidigitação,
`True Faith`=Fé Verdadeira): termo de jogo **traduzido**, ⊥ transliterado.

### ⚠ OS 5 `ARTEFATO` — o `pdftotext` cola palavras

`FleshoftheCorpse` · `HarbingeroftheAbyss` · `SpiritMentor` · `TouchofFrost` · `LinguaFranca`.
⊥ são itens novos: são o MESMO item da linha vizinha, com o espaço comido pela camada de texto.
Somem no dedupe de `T751`. **⊥ criar chave `.lang` p/ eles.**

### ⚠ A CASE-INSENSITIVITY DO POWERSHELL MORDEU DE NOVO

`Sleeping with the Enemy` (`core`) e `Sleeping With the Enemy` (`bos`) são **2 entradas de
livros diferentes**, e uma `hashtable` comum **fundiu as duas** — o arquivo saiu com 642 de 643
e a validação foi quem pegou. Cura: `New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)`.
O aviso está no cabeçalho do próprio `.tsv`, p/ quem reler ⊥ repetir.

Esta é a **4ª vez** que a case-insensitivity do PowerShell custa tempo neste projeto
(`$T`/`$t`, `-match`, `wod.Artifacts` × `wod.ARTIFACTS`, e agora `with`/`With`). Merece §B própria.

### O QUE AINDA FALTA P/ `T750` FECHAR

O `.tsv` é **pesquisa**, ⊥ código. Falta:

1. **`meritData.lua`** — `MERIT_DATA[nome] = {book=, page=, cost=}` a partir de `merit_flaw.tsv`.
   Módulo PRÓPRIO, ⊥ `<script>` de `.lfm` (§I100g): CDATA é copiado por ficha aberta.
2. **`PICKER_LIST["merit"]` e `["flaw"]`** — 361 Merits e 409 Flaws, **depois do dedupe**.
3. **As chaves `.lang`** — 632 em `[pt]` **e** 632 em `[en]` (identidade), **e** as 632 no PT map
   de `WoD20.6` (§V22/§V28 exigem os 3 em sincronia). ⚠ **Isso quase DOBRA o `.lang`**, que hoje
   tem 1077 chaves por seção. Conferir o teto de locais de `WoD20.6` antes (§B77).
4. **O dedupe dos 96 repetidos** — 70 resolvem sozinhos (custo e tipo iguais); **28 precisam do
   texto** e saem em `T751`.

### PRÓXIMO

1. **`T751`** — `descMerit_en.lua`/`_pt.lua`. **Faça ANTES de `T750`**: é ela que resolve os 28
   casos de dedupe, e a lista final de `PICKER_LIST` depende do dedupe. Fazer `T750` primeiro
   obriga a refazer as chaves `.lang` dos itens que virarem `Nome (Origem)`.
2. **`T750`** — com o dedupe decidido.
3. **`T756`/`T757`/`T761`** — templates, auto-preenchimento e os 12 botões `?`.
4. **`T783`–`T785`** — a caixa de busca.
5. **`T764`–`T767`** — antecedentes, mesmo pipeline e muito menor.

### PERGUNTA ACUMULADA (⊥ trava nada)

**Q22** — os **84** termos do V20 core marcados `R` estão em `research/merit_flaw_pt.tsv`.
Vale o user passar o olho e corrigir os que a edição brasileira escreve diferente.
**Recomendação:** ⊥ esperar por isso — seguir com `T751`, e a correção entra depois por
substituição no `.tsv` + regeneração, que custa minutos. Segurar 643 itens por 84 palavras
seria trocar entrega por polimento.


## 130ª RODADA (2026-08-28)

Gate **VERDE, 599 ok, 0 FAIL**. `.rpk` inalterada desde a 129ª (**2.214.481 B**, instalada
15:21:02) — esta rodada é **medição e pesquisa**, ⊥ tocou código nenhum.
§T **678 `x` · 100 `.` · 9 `~`** (`T749` foi p/ `~`).

Entregue: **`research/merit_flaw.tsv`** — **770 linhas, 643 nomes distintos**, de **15 livros**.

### OS OFFSETS: os 8 `?` do README foram MEDIDOS

Método: para cada livro, amostrar 12 páginas com texto e achar o único `offset` tal que
`pagina_PDF − offset` apareça como número solto em TODAS elas. **Validou-se sozinho** em
`core`=8 e `da`=1, que já eram conhecidos — é o que dá crédito aos outros.

| livro | offset | | livro | offset |
|---|---|---|---|---|
| `core` | 8 ✓ | | `hh` `m20va` `bos` `trel` `anarch` | **1** |
| `da` + 9 outros | 1 | | **`sorcc`** | **0** ⚠ |
| | | | **`bcm`** | **2** ⚠ |

⚠ `sorcc` e `bcm` são os **únicos fora do padrão**. Chutar 1 neles poria página errada no
bloco 1 de §I21 — texto que o jogador lê.

### 3 LIVROS SAÍRAM POR MEDIÇÃO, ⊥ por escolha

- **`m20` (Mage 20th) está em PORTUGUÊS.** 3537 "Mago", 797 "Esfera", **0** "Sphere",
  **0** "Merit". ⊥ serve: a chave canônica é EN (§V24) e a fonte é EN (§V9); traduzir de volta
  inventaria grafia que livro nenhum imprimiu. **Se aparecer um PDF em inglês, ele entra.**
- **`bcm`** e **`trel`**: **0** qualidades/defeitos. Simplesmente ⊥ trazem.

Decisão do user 2026-08-28: **os 15 restantes entram TODOS**, e **sem filtro por tema** — a
caixa de busca da Q16 já resolve lista comprida (ninguém rola, digita).

### ⚠ SÃO SETE NOTAÇÕES, ⊥ TRÊS (o §R125 está incompleto)

A 1ª varredura deu **0** para `anarch`, `tos`, `sorc` e `m20va` — **61 itens sumindo calados**,
que é exatamente a doença que o §R125 existe para nomear. As 4 novas:

| # | livro | forma | o que quebra |
|---|---|---|---|
| 2 | `anarch` | `Peacemaker (2-pt. Merit)` | **hífen** entre número e `pt` |
| 3 | `tos` | nome numa linha, `(3 pt. Supernatural Merit)` na de baixo | nome ⊥ está na linha do custo |
| 5 | `sorc` | `Path Natural: (5 pt Merit)` | **dois-pontos ANTES** do parêntese |
| 6-7 | `m20va` | `• Well-Rounded (1 pt. Mental Merit)` e `• Construct (Social Flaw):` | marcador na frente; e a 7ª **⊥ tem custo** |

E o `da` (notação 4) **⊥ diz `Merit` nem `Flaw`** — o tipo sai do cabeçalho de seção
(`Physical Merits` / `Physical Flaws`). Sem isso, **81 itens ficariam sem tipo**.
Tudo isso está gravado na armadilha 7 do `research/README.md`.

### A COLHEITA, por livro

| livro | itens | | livro | itens |
|---|---|---|---|---|
| `bos` | 235 | | `bh` | 15 |
| `core` | 162 | | `sorc` | 14 |
| `lotc` | 120 | | `sorcc` | 7 |
| `da` | 81 | | `tos` | 6 |
| `lob` | 43 | | `anarch` | 6 |
| `hh` | 38 | | `m20va` | 5 |
| `gr` | 33 | | `dac` `rob` | 3 · 2 |

**361 Merits · 409 Flaws · 0 sem tipo.** Linhas de sumário descartadas (80 no total, 37 só no
`lob`) — elas terminam no número da página que apontam e entrariam em duplicata.

### O DEDUPE: o problema é MENOR do que parecia

**96 nomes** aparecem em 2+ livros. Mas:

- **70** têm **custo e tipo IDÊNTICOS** nos dois livros ∴ mesma mecânica, viram **1 item** pela
  regra do pedido 12.1 sem ninguém precisar ler nada.
- **26** têm **custo diferente** entre livros → precisam de leitura lado a lado.
- **2** aparecem como **Merit num livro e Flaw noutro** → esses são certeza de leitura.

∴ o julgamento humano/de leitura cai de 96 para **28 casos**. Isso é trabalho de `T751`, quando
as descrições forem extraídas — a decisão sai com o texto na mão, ⊥ de memória (§R8).

### POR QUE `T749` ESTÁ `~` E ⊥ `x`

Duas cláusulas do §T749 ⊥ foram cumpridas, **de propósito**:

1. **"saída = `research/mf_<livro>.tsv`"** — saiu **1 arquivo** (`merit_flaw.tsv`) com coluna
   `livro`, ⊥ 15 arquivos. 15 arquivos p/ um dado que só é útil junto contraria a regra de ⊥
   criar arquivo sem necessidade, e o dedupe precisa de tudo lado a lado.
2. **"Dedupar ENTRE livros na precedência do README (`core` > …)"** — **⊥ dedupei.** Precedência
   cega apagaria os 26 de custo divergente sem ninguém ver, que é a perda calada que a regra
   12.1 do próprio user existe p/ evitar. A evidência fica no arquivo até a decisão.

Ambas ! virar emenda de §T749 no `/ck:spec`.

### EMENDAS QUE O SPEC DEVE — agora 11

As 8 anteriores, mais:

- **§R125** — são **7** notações, ⊥ 3 (tabela acima).
- **§T749** — as 2 cláusulas acima (1 arquivo; dedupe adiado com evidência).
- **§R (novo)** — os 8 offsets medidos, e o `m20` em português.

### PRÓXIMO

1. **`T750`** — `meritData.lua` + `PICKER_LIST["merit"]`/`["flaw"]` + as chaves `.lang`.
   ⚠ **643 nomes ! ter tradução PT** (§V17) — é o maior custo do "todos os livros", e ⊥ é opcional.
2. **`T751`** — `descMerit_en.lua`/`_pt.lua`. É aqui que os **28** casos de dedupe se resolvem,
   com o texto na mão.
3. **`T756`/`T757`/`T761`** — templates, auto-preenchimento e os 12 botões `?` que faltam.
4. **`T783`–`T785`** — a caixa de busca.
5. **`T764`–`T767`** — antecedentes (mesmo pipeline, muito menor).

### ARQUIVOS DE TRABALHO (fora do repo, morrem com a sessão)

O texto dos 15 livros está extraído em `<scratchpad>/txt/*.txt` e o bruto em `mf_raw.csv`.
Reextrair custa ~3 min com o comando do `research/README.md`.


## 129ª RODADA (2026-08-28)

Gate **VERDE, 599 ok, 0 FAIL**. `.rpk` **2.214.481 B** gerado 15:21:01 e **INSTALADO 15:21:02**.
§T **678 `x` · 101 `.` · 8 `~`** (sem mudança — Q21 é emenda, não §T aberta).
**Nenhuma pergunta aberta.** As cinco (Q17…Q21) estão respondidas e implementadas.

### Q21 — a linhagem Narov, opção B (duas entradas)

`PICKER_LIST["family"]` **23 → 24**: entrou **`Obertus (Narov)`** ao lado de `Obertus`.

| entrada | trio |
|---|---|
| `Obertus` | Auspex · **Obfuscate** · Vicissitude |
| `Obertus (Narov)` | Auspex · **Dominate** · Vicissitude |

**Por que duas entradas e não um slot em aberto** (a pergunta que o user fez, e a resposta que
decidiu): `gr` p.102 diz *"Obertus revenants, **who display signs of the Narov line**, should
swap Obfuscate for Dominate."* Isso é **condição**, não escolha. Um slot `choice` daria Dominate
a **qualquer** Obertus — permissão que o livro não dá. A forma de duas entradas é a que os
`Gargoyles (Scout)/(Sentinel)/(Warrior)` já tinham fixado na ficha.

O livro trata Narov e Obertus como **uma família só hoje**: *"he selected the remaining Narov
revenants… **to be folded into the Obertus family**"* e *"a small percentage has displayed Narov
traits"*. Não há capítulo Narov no índice de famílias. Por isso o nome é `Obertus (Narov)` — o
parêntese diz o que é: linhagem dentro da família, ⊥ família nova.

Contagens no mesmo commit: §V212/§V236 **84 → 85**, §V294 **23 → 24** famílias, união **85 → 86**,
e as duas literais de §V341. `.lang` nas duas seções e PT map (`Obertus (Narov)` nos dois idiomas
— nome próprio, ⊥ traduz).

### §V342 NOVA — e o número está RESERVADO, ⊥ escrito no SPEC

Pernas: **(a)** as 2 entradas ∃ · **(b)** os trios diferem por **exatamente** Obfuscate↔Dominate
— um check que só contasse "2 entradas" passaria em duas idênticas, que é a divisão fechando
calada · **(c)** nenhuma das 2 tem `FAMILY_CAP` (nenhum dos livros põe NÚMERO na fraqueza da
Obertus) · **(d)** trio **fixo** nas duas, nunca `choice`/`open` — é a perna que guarda a
diferença entre condição e escolha livre · **(e)** zero-guard.

⚠ **`/ck:spec` deve escrever o texto de §V342.** Escrevi o check antes porque decisão sem check
regride calada; o número é o próximo livre e ⊥ colide.

**Mutação rodada (§V20/§V222):** `Narov fora da lista` · `os 2 trios idênticos` · `swap com a
Disciplina errada` · `slot aberto como choice` · `teto inventado p/ Obertus` → **todas
VERMELHAS**. Sonda (reescrever comentário) → **VERDE**.

⚠ **Erro meu que o gate pegou:** escrevi
`if (($diff | Sort-Object) -join '|' -ne (@(...) | Sort-Object) -join '|')` e a precedência do
PowerShell avaliou isso errado — o check reprovou código correto. Consertado com variável
intermediária. **Lição: `-join` dentro de comparação sempre em variável própria.**

### EMENDAS QUE O SPEC DEVE (rodar `/ck:spec`) — agora 8

As 6 da 126ª e as 5 da 128ª continuam devendo, mais:

- **§V342** — texto novo (o check já ∃ no gate).
- **§R129/§R93** — a Obertus fecha em **1 linha por época** (o 2º eixo ⊥ divergiu de forma que a
  ficha represente) **&** ganha a **2ª entrada por LINHAGEM**. São duas conclusões diferentes na
  mesma família e o §R tem que dizer as duas, senão a próxima leitura reabre a errada.
- **§I29b/§I108b** — a lista de famílias é **24**, e o motivo da 24ª é linhagem, ⊥ época.

### PRÓXIMO — só trabalho

1. **`T749`–`T751`** — extração das ~700 qualidades/defeitos. Destrava `T756`, `T757`, `T761`
   (12 dos 28 botões `?`), `T783`–`T785` e as pernas (d)/(g) de §V333.
2. **`T764`–`T767`** — antecedentes: extração, dedupe por essência, descrições, §V336.
3. **`T768`/`T769`** — regenerar os 8 `.lua` só com `System` (pedido 14).
4. **`T786`** — a leitura está FEITA (128ª) e já foi ATUADA (Q21); falta o `/ck:spec` escrever §R.
5. **`T770`–`T773`, `T787`** — testes de tela `[USER]`.


## 128ª RODADA (2026-08-28)

Gate **VERDE, 598 ok, 0 FAIL**. `.rpk` **2.213.748 B** gerado 14:00:30 e **INSTALADO 14:00:31**.
§T **678 `x` · 101 `.` · 8 `~`**. **As 4 perguntas abertas foram respondidas pelo user e as 4
estão fechadas** — não há nada pendente de decisão.

Entregue: **`T781`** (teto de família) e **`T782`** (§V337 + §V341 completas). Mais a leitura da
**`T786`**, cujo resultado está abaixo e ainda precisa do `/ck:spec` para virar §R.

### Q20 — o teto de sangue, feito como recomendei e você aprovou

As **20 bolinhas de `BLOOD POOL`** deixaram de se marcar sozinhas: `autoChange="false"` e
`onClick="bloodClick('bloodPool_N', self);"`. O `bloodClick` é **recusador próprio** e não
alcança `xpClick` nem `declareTrait` — as bolinhas continuam livres, sem preço e sem linha de
ledger, que é o que a §V219 realmente comprava. O que elas ganharam foi o **"antes da escrita"**
que a §V337d exige e que bolinha auto-marcante não tem.

A §V219 foi **emendada para mais apertada, não mais frouxa**: agora cada bolinha ! ter
`autoChange="false"` **e** nomear `bloodClick` **com o próprio campo**, e o `bloodClick` !
não alcançar nada que cobre. Descer nunca é recusado — teto limita o que a família **segura**,
e gastar sangue ninguém precisa de licença.

`FAMILY_CAP` nasceu com **2 linhas medidas** (`research/family_caps.tsv` tem as páginas):
`Enrathi` = `{humanity=3, conscience=2}` (`gr` p.95) e `Grimaldi (Dark Ages)` = `{bloodPool=8}`
(`da` p.454). A moderna **não** tem teto — o `gr` p.98 dá a ela fraqueza de comportamento, sem
número, e inventar um teto ali seria a ficha passar por cima do livro.

**Os pontos de entrada são DOIS de propósito** (bolinha de sangue não pode chegar em `xpClick`,
bolinha de rating não pode pular), **mas o número é lido em UM só**: `familyCap`. A §V337c mede
isso contando que `FAMILY_CAP[` apareça exatamente **1×** no chunk.

### Q18 — do jeito que recomendei

O teto impede **subir** e o já-marcado **fica**. Ficha antiga com 10 bolinhas e teto 8 abre com
as 10 e não ganha a 11ª. A §V337e é a perna que pega a "arrumação" que parece gentileza: ela
reprova qualquer `setField` que escreva `humanity_*`, `conscience` ou `bloodPool_*` para `false`.

### Q17 — MEDIDO. A Obertus **NÃO** quebra em duas

| | `da` p.454 (medieval) | `gr` p.101-102 (moderna) |
|---|---|---|
| trio | Auspex, Obfuscate, Vicissitude | Auspex, Obfuscate, Vicissitude |
| fraqueza | escolher uma área de conhecimento, tratada como **Obsession Derangement** | **Obsessive-Compulsive** (maioria) ou **Megalomania** (linhagem Narov) |

A fraqueza **diverge** — são Derangements diferentes e o `da` exige escolher a área. **Mas
nenhuma das duas tem NÚMERO**, e é isso que decide: o critério da `T774` é valor numérico de
traço. A Grimaldi quebrou porque a medieval tem teto de 8 e a moderna não — divergência que a
ficha **representa**. A da Obertus é *qual* Derangement, e Derangement na ficha é caixa de texto
livre que o jogador digita.

**Recomendação: uma linha só.** Quebrar criaria uma entrada com o mesmo trio, sem teto, e um
campo de texto que o jogador preenche igual — terceira entrada em que ninguém pode agir.

⚠ **ACHADO NOVO, fora do escopo da `T786` (vira Q21):** o `gr` diz que a Obertus da **linhagem
Narov troca Obfuscate por Dominate**. Isso é variação de **TRIO**, que a ficha *modela*
(`CLANS[...].fixed`). O jeito certo não seria quebrar por época — seria dar à Obertus um
`choice` no lugar do trio fixo, que é o mecanismo que a §I37/§V236d já têm para "liberado".
**Recomendação:** `["Obertus"] = { fixed = {"Auspex", "Vicissitude"}, choice = {"Obfuscate", "Dominate"}, choiceN = 1 }`.
Não implementei — é decisão sua e não estava na `T786`.

### MUTAÇÃO RODADA (§V20/§V222) — 12 vermelhas, 1 sonda verde

`1 bolinha volta a se marcar sozinha` · `1 bolinha entrega o campo errado` · `bloodClick alcança
xpClick` · `teto Enrathi 3→4` · `teto em família que não está na lista` · `xpClick para de
perguntar` · `bloodClick escreve antes de perguntar` · `algo apaga uma bolinha` · `2º leitor da
tabela` · `chave [pt] do aviso apagada` · `Grimaldi moderna ganha teto` · `teto medieval 8→7`
→ **todas VERMELHAS**. Sonda (reescrever um comentário) → **VERDE**.

⚠ A §V129 (censo de pop-ups do `xpClick`) acendeu sozinha quando a 8ª recusa entrou — **é ela
funcionando**: o comentário dela diz "a refusal added without coming here first turns this red".
Atualizada de 7 para 8 no mesmo commit.

### EMENDAS QUE O SPEC DEVE (rodar `/ck:spec`)

Além das 6 da 126ª rodada, que continuam devendo:

- **§V219**: a metade do `autoChange` foi emendada (Q20). O texto novo é o do gate.
- **§V337c**: "1 lugar recusa" virou **"1 lugar LÊ o número"** — os pontos de entrada são dois
  por construção, e fundi-los quebraria a §V219.
- **§I106a**: `FAMILY_CAP` tem **2** linhas, não 1 (`Enrathi` e `Grimaldi (Dark Ages)`).
- **§V129**: censo de 7 → **8** pop-ups.
- **§R129 / §R93**: a Obertus fecha em **uma linha** pelo 2º eixo (tabela acima), e nasce a
  **Q21** da linhagem Narov.
- **§V341c** deixou de ser comentário e virou perna de verdade.

### PRÓXIMO — só trabalho, nenhuma decisão trava

1. **`T749`–`T751`** — extração das ~700 qualidades/defeitos. O gargalo: destrava `T756`, `T757`,
   `T761` (12 dos 28 botões `?`), `T783`–`T785` e as pernas (d)/(g) de §V333.
2. **`T764`–`T767`** — antecedentes: extração, dedupe por essência, descrições, §V336.
3. **`T768`/`T769`** — regenerar os 8 `.lua` só com `System` (pedido 14).
4. **`T786`** — a leitura está FEITA (acima); falta só o `/ck:spec` escrever §R129.
5. **`T770`–`T773`, `T787`** — testes de tela `[USER]`.

### PEDIDO 9 — FECHADO pelo user

A largura das 8 caixas **não muda**. Decisão do user em 2026-08-28: "pode deixar cair, não
precisa alterar, estão bons por enquanto". A altura (186→153) fica como está.


## 127ª RODADA (2026-08-28) — LEIA ESTA E DEPOIS A 126ª

> ⚠ **O `.rpk` muda de 1-2 bytes a cada build** (carimbo de tempo dentro do zip). Se voce rodar
> `rdk -l` DEPOIS de `rdk -i`, o tamanho do instalado deixa de bater e a prova de §B1 acusa
> falso. Terminar sempre com `rdk -i`, nunca com `rdk -l`.

Gate **VERDE, 597 ok, 0 FAIL**. `.rpk` **2.210.367 B** gerado 13:15:56 e **INSTALADO 13:15:57**
(mesmo tamanho). §T **676 `x` · 102 `.` · 9 `~`**.

Entregue: **`T780`** (Grimaldi em 2 entradas) e **`T782` PARCIAL** (§V341 escrita e mutada;
§V337 não). **`T781` está BLOQUEADA** por um conflito do próprio SPEC — ver abaixo.

### `T780` — Grimaldi quebrada em duas, na íntegra

`PICKER_LIST["family"]` **22 → 23**: `Grimaldi` pelado saiu, entraram `Grimaldi (Dark Ages)` e
`Grimaldi (Modern)`. `CLANS` ganhou as duas com o **MESMO trio** (Celerity·Dominate·Fortitude),
porque o que divergiu foi a FRAQUEZA e não o trio. `.lang` nas duas seções e PT map de
`WoD20.6`, seguindo o precedente do `Bratovich`: `(Dark Ages)` → **`(Trevas)`**,
`(Modern)` → **`(Moderna)`**.

Contagens do gate no MESMO commit (senão vira §B70/§B73): §V212 e §V236 **83 → 84**,
§V294 **22 → 23** famílias e a união a **85**. O comentário do topo da lista, que dizia
"Grimaldi e Obertus ficam em uma linha cada", foi **reescrito** — comentário-mapa velho é §B73.

### ⛔ `T781` BLOQUEADA — conflito entre §V219 e §V337d (**Q20**)

O teto da `Grimaldi (Dark Ages)` é **8 pontos de sangue** (`da` p.454). Para recusar é preciso
interceptar o clique na bolinha de `BLOOD POOL`. **Não há onde.**

- **§V219** compra para a bolinha de sangue o direito de **se marcar sozinha**: `autoChange`
  ligado, **`onClick` vazio**, nada chegando em `xpClick`. É o que a separa de bolinha de rating.
- **§V337d** exige que o teto recuse **ANTES da escrita**.
- Com bolinha que se marca sozinha **não existe "antes"**: quando qualquer Lua roda, o host já
  escreveu. Sobraria gravar-e-desfazer, que é exatamente o que §V337d proíbe.

§I108c emendou **só a metade de §V219 sobre TRAIT** ("teto não faz da bolinha um traço") e
**deixou a metade do `autoChange` intacta**. Sem essa segunda emenda o ponto de recusa não existe.

**Não pus `FAMILY_CAP["Grimaldi (Dark Ages)"]` na tabela**: teto que nunca dispara é, pelas
palavras da própria §V337a, **pior que ausente**. A tabela fica vazia até a decisão.

⚠ Nota: a metade **`Enrathi`** de `T781` (`humanity` + `conscience`) **não** tem esse problema —
aquelas bolinhas são rating, têm `onClick` e passam por `xpClick`, onde a recusa de disciplina e
a de secondary path já moram (§I106b). Dá para entregar sozinha assim que a Q20 for respondida,
ou até antes, se você quiser separar as duas.

### §V341 escrita, com a perna (c) declarada ausente

Pernas **(a)** 23 entradas + as 2 presentes + o nome pelado AUSENTE · **(b)** as 2 com o mesmo
trio · **(d)** união = 85 · **(e)** zero-guard. A perna **(c)** (`FAMILY_CAP` da Grimaldi) está
**escrita como comentário explicando por que não existe**, no mesmo estilo das pernas (d)/(g) de
§V333. Por isso `T782` é `~`.

**Mutação rodada (§V20/§V222):** `Grimaldi` pelado de volta ! VERMELHO · entrada moderna apagada
! VERMELHO · trios discordando ! VERMELHO · 1 clã fora do roster (união 84) ! VERMELHO ·
sonda (reescrever uma palavra de comentário) ! VERDE.

⚠ **Uma mutação minha nasceu no-op e eu troquei:** mexer no limite do `for` da união NÃO
avermelha — o gate monta a união por conta própria a partir das duas listas, não lendo o laço
(quem lê a FORMA do laço é §V294c). Trocada por "tirar um clã do roster", que avermelha de verdade.

### PRÓXIMO, em ordem de valor

1. **`T749`–`T751`** — extração das ~700 qualidades/defeitos. É o gargalo real: destrava `T756`,
   `T757`, `T761` (12 dos 28 botões `?`), `T783`–`T785` e as pernas (d)/(g) de §V333.
2. **`T764`–`T767`** — antecedentes: extração, dedupe por essência, descrições, §V336.
   Destrava os outros 16 botões e o pedido 12.
3. **`T781`** — assim que a **Q20** for respondida (ou só a metade `Enrathi`, que não depende dela).
4. **`T768`/`T769`** — regenerar os 8 `.lua` só com `System` (pedido 14).
5. **`T786`** — reler a Obertus pelo 2º eixo (**Q17**). Leitura, não trava nada.
6. **`T770`–`T773`, `T787`** — testes de tela `[USER]`.

### PERGUNTAS ABERTAS — agora 4

- **Q20 (NOVA)** — como o teto de sangue da `Grimaldi (Dark Ages)` deve recusar?
  **Recomendação: emendar §V219 na metade do `autoChange`** para as 20 bolinhas de `BLOOD POOL`
  virarem `autoChange="false"` + `onClick` que passa por um recusador PRÓPRIO (não `xpClick`).
  Elas continuam sem preço, sem `declareTrait` e sem linha de ledger — que é o que §V219
  realmente comprava — e ganham o "antes da escrita" que §V337d exige. O custo é Lua nova para
  pintar 20 bolinhas que hoje o host pinta de graça.
  *Alternativa mais barata:* aceitar gravar-e-desfazer via `dataLink`, como §V187 já faz para o
  revert de picker. Não recomendo: o jogador veria a bolinha acender e apagar.
- **Q17** — `Obertus` julgada pelo mesmo critério incompleto da Grimaldi (só o trio). Falta
  comparar a FRAQUEZA lado a lado (`da` p.454 × `gr`). Recomendação: rodar `T786`; se divergir,
  ela quebra em duas igual à Grimaldi e a lista vai a 24.
- **Q18** — ficha nova semeia 10 bolinhas de sangue e o teto medieval é 8. Recomendação: manter
  §I106d (o teto impede SUBIR, o marcado FICA). Só vira código depois da Q20.
- **Q19** — pedido 9 pede encolher as 8 caixas na horizontal; §V298 exige 5px e o buraco é
  485 = 240+5+240. Recomendação: estreitar `DERANGEMENTS` de 240 para 220 e dar 10px a cada uma
  das quatro que subiram.


## 126ª RODADA (2026-08-28) — LEIA ESTA SEÇÃO PRIMEIRO

Gate **VERDE, 596 ok, 0 FAIL**. `.rpk` **2.209.805 B** gerado 12:50:05 e **INSTALADO 12:50:07**
(mesmo tamanho — as duas provas de §B1). §T **675 `x` · 104 `.` · 8 `~`**.

Entregue nesta rodada: **`T760`** (caixa do `?`), **`T762`** (zoom de fonte nas 8 panes),
**`T763` PARCIAL** (§V334 inteira + §V333 sem as pernas (d) e (g)) — por isso ela está `~` e
não `x`. Fecha o pedido **8** por inteiro e monta o mecanismo do **7** e do **13**.

### OS 16 PEDIDOS — 7 entregues, 9 faltam

| # | pedido | estado |
|---|---|---|
| 1 | Humanidade → Caminho, dropdown de trilhas | **PRONTO** |
| 2 | Campo Aura/Bearing colado nas bolinhas | **PRONTO** |
| 3 | Valor do bearing pelo nível | **PRONTO** |
| 5 | Defeitos abaixo de Qualidades | **PRONTO** |
| 6 | Aliados/Mentor/Recursos/Guias no lugar dos Defeitos | **PRONTO** |
| 8 | Fonte ± em TODAS as caixas de descrição | **PRONTO** (8 panes, 16 botões, salva) |
| 10 | "Status" → "Artefatos" | **PRONTO** |
| 11 | Antecedente "Artefatos" na lista | **PRONTO** |
| 15 | Node → **Nodo** | **PRONTO** |
| 16 | Pure Breed → **Raça Pura** | **PRONTO** |
| 13 | Fechar: botão X, clique fora, uma caixa por vez | **MECANISMO PRONTO** — falta o `?` que a abre |
| 7 | Botão `?` + caixa 500×500 | **CAIXA PRONTA** — faltam os botões (`T761`) e o texto (`T751`/`T765`) |
| 9 | 8 caixas: altura e largura | **METADE** — altura sim; largura NÃO, ver **Q19** |
| 4 | Qualidades/Defeitos com busca + auto-preenchimento | falta (`T749`–`T751`, `T783`–`T785`) |
| 12 | `?` nos antecedentes + dedupe com origem | falta (`T764`–`T766`) |
| 14 | Descrições só com a parte "Sistema" | falta (`T768`, `T769`) |

⚠ **`T766` está `.` mas PARCIALMENTE FEITA**: pedidos 11/15/16 já estão no código e instalados.
Resta só a lista final de antecedentes de `T764`. **Não refazer os três.**

### ⚠ A ARMADILHA QUE CUSTOU A RODADA — crase em string do PowerShell

**Escrevi `` `from` `` num comentário gerado por PowerShell e `` `f `` virou FORM FEED (0x0C).**
O `rdk` morreu do jeito de §B19/§B77/§B80: **exit 1, saída VAZIA, `.rpk` APAGADO, nenhum arquivo
nem linha nomeados.** O caractere estava dentro de um **COMENTÁRIO** Lua — código que não faz
nada — e mesmo assim derrubou a build.

O que funcionou (a lição de §B80 confirmada por um caso novo):

1. bissecção **por ARQUIVO** → `WoD20th.lfm`;
2. bissecção **por METADE do bloco** → o par `fontStep`/`applyDescFont`;
3. bissecção **por FUNÇÃO** → nenhuma delas: sobrou o **comentário** entre as duas.

**Regra nova, mais forte que "medir CR == LF" (§B81):** depois de gerar texto com PowerShell,
varrer o arquivo por **qualquer byte de controle** (`< 0x09`, `0x0B`, `0x0C`), não só o CR/LF.
Escapes que o PowerShell come em string de aspas duplas: `` `f `` `` `t `` `` `n `` `` `r ``
`` `b `` `` `a `` `` `v `` `` `0 `` `` `e ``. Em prosa, **não usar crase** — ou dobrar (`` `` ``).

Isto merece §B nova quando `/ck:spec` rodar.

### Outras 4 desta rodada

1. **`R` e `W` são ALIAS do PowerShell** (`R` = `Invoke-History`). Alias tem precedência
   **acima** de função ∴ `function R($p)` não é chamada — o alias é. Nomear helpers com ≥2 letras.
2. **`popScrim` não pode ser `align="client"`** (§V190): o `themePaper2` já toma o client rect do
   `<scrollBox>` da aba. Resolvido dando geometria explícita **1595×693**, sem afrouxar o §V190.
3. **`popDesc` é um `<layout>` com retângulo preto arredondado** ∴ o coletor de §V280/§V298 o
   varreu (74 caixas onde há 73) e o §V40 o acusou de sobrepor 6 vizinhos. Resolvido com
   `$OVERLAY_BOXES = @('popDesc')` — **exceção NOMEADA**, no estilo de §V328c, com **zero-guard
   nos dois sítios** (contagem ≠ tamanho da lista ! FAIL), então ela não pode virar no-op.
4. **`applyDescFont(self)` caiu no `onShow` e não no `onNodeReady`** porque `.IndexOf` achou a
   PRIMEIRA `applyTabVisibility(self);` do arquivo, que é a do `onShow`. O §V334e pegou.

### O que a §V10 NÃO precisou

§I102b e §I103b declaravam "exceção" para `?`, `+`, `−` não terem chave `.lang`. **Não foi
preciso**: a ficha já resolve isso com `wod.-=-` nas duas seções. Adicionei `wod.+=+` e
`wod.X=X` do mesmo jeito, mais as entradas no PT map de `WoD20.6`. **Nenhum check afrouxado.**
E o menos é ASCII `-`, não `−` (U+2212), que reprovaria em §V9.

### EMENDAS QUE O SPEC DEVE (rodar `/ck:spec`)

- **§I102c**: o rótulo é **`dynPopDescTitle`**, não `popDescTitle` — é a regra de §I108a (label
  escrita por Lua ! prefixo `dyn`, senão a travessia de idioma restaura o inglês envelhecido).
- **§I102c**: `edtPopDesc` ficou **460×435 em (20,45)**, não `470×420` — margem de 20 nos quatro
  lados, igual a toda caixa da ficha.
- **§I102a**: `popScrim` **não** é `align="client"` (ver armadilha 2 acima).
- **§I103a**: a assinatura real é `fontStep(from, delta)` e **`from` é o BOTÃO clicado**, âncora
  da travessia — não a pane. §I103c faz o tamanho ser **1 campo para as 8**, então argumento
  por-pane prometeria um tamanho por-pane que não existe.
- **§V334a**: "os literais 10/32/2 só dentro de `fontStep`" é medido como **"nenhum
  `.fontSize = <número>` fora de `fontStep`"** — o literal `2` não dá para policiar no chunk todo.
- **§V333**: pernas **(d)** (todo `btnQ*` chama o MESMO abridor) e **(g)** (contagem = 28) **não
  foram escritas**: 12 dos 28 botões dependem de `MeritPicked` (§T756/§T783). Escrevê-las contra
  zero botão seria o no-op de §B7. Por isso **`T763` está `~`**.
- **§I102e**: `popOpen` carrega o módulo com **`pcall(require, ...)`** porque `descMerit_*` e
  `descBackground_*` ainda não existem. **O `pcall` SAI quando `T751` e `T765` entrarem** —
  está comentado no código dizendo isso.

### MUTAÇÃO RODADA (§V20/§V222) — 11 vermelhas, 1 sonda verde

`scrim depois da caixa` · `caixa nasce visível` · `edtPopDesc sem wordWrap` · `scrim sem
popClose` · `pane sem o botão +` · `botão com passo 3` · `teto 32→40` · `fontSize = 14 fora de
fontStep` · `applyDescFont fora do onNodeReady` · `descFontSize fora da lista LUA-OWNED` ·
`OVERLAY_BOXES com nome que ninguém carrega` → **todas VERMELHAS**.
Sonda (mover um botão 2px) → **VERDE**.

### PRÓXIMO, em ordem de valor

1. **`T780`–`T782`** — Grimaldi em 2 entradas + `FAMILY_CAP` com alvo em `BLOOD POOL`. Não
   depende de livro (o §R129 já tem o dado). ⚠ `T780` mexe em §V212/§V236a/§V294 no MESMO
   commit. ⚠ `T781` emenda §V219.
2. **`T749`–`T751`** — extração das ~700 qualidades/defeitos. É o gargalo: destrava `T756`,
   `T757`, `T761` (12 dos 28 botões), `T783`–`T785` e as pernas (d)/(g) de §V333.
3. **`T764`–`T767`** — antecedentes: extração, dedupe por essência, descrições, §V336.
   Destrava os outros 16 botões de `T761` e o pedido 12.
4. **`T768`/`T769`** — regenerar os 8 `.lua` só com `System` (pedido 14).
5. **`T770`–`T773`, `T787`** — testes de tela `[USER]`.
6. **`T786`** — reler a Obertus pelo 2º eixo (**Q17**). É leitura, não trava nada.

### PERGUNTAS ABERTAS (nenhuma trava)

- **Q17** — a `Obertus` foi julgada pelo mesmo critério incompleto que deixou a Grimaldi passar
  (só o trio de Disciplinas). Falta comparar a FRAQUEZA lado a lado (`da` p.454 × `gr`).
  Recomendação: rodar `T786` antes de `T780` fechar, para as duas quebrarem juntas se for o caso.
- **Q18** — ficha nova semeia 10 bolinhas de sangue e o teto Grimaldi medieval é 8. Vale §I106d:
  o teto impede SUBIR, o já-marcado FICA. Recomendação: manter — apagar marcação do jogador é
  pior que 2 bolinhas acima do teto numa ficha antiga.
- **Q19** — o pedido 9 pede encolher as 8 caixas na horizontal. Impossível sem mexer em
  `DERANGEMENTS`: §V298 exige 5px e o buraco é 485 = 240+5+240. Recomendação: estreitar
  `DERANGEMENTS` de 240 para 220 e dar 10px a cada uma das quatro que subiram.

### NÃO COMMITADO (nada foi commitado — regra do projeto)

`M` HANDOFF.md · SPEC.md · verify-hunters-hunted.ps1 · localization.lang ·
WoD20.1.lfm · WoD20.2.lfm · WoD20.6.lfm · WoD20.7.lfm · WoD20.12.lfm · WoD20.13.lfm ·
WoD20.14.lfm · WoD20th.lfm · output/*.rpk · research/README.md
`??` .claude/ · research/family_caps.tsv · research/road_bearing.tsv


## 125ª RODADA (2026-08-28) — LEIA ESTA SEÇÃO PRIMEIRO

Gate **VERDE, 594 ok, 0 FAIL**. `.rpk` **2.201.464 B** gerado e **INSTALADO 12:14:15**.
§T **673 `x` · 107 `.` · 7 `~`**. Das 107 abertas, **~77** são teste de tela `[USER]`.

### OS 16 PEDIDOS DO USER — 6 entregues, 10 faltam

| # | pedido | estado |
|---|---|---|
| 1 | Humanidade → Caminho, dropdown de trilhas | **PRONTO** (55, filtradas por época) |
| 2 | Campo Aura/Bearing colado nas bolinhas | **PRONTO** |
| 3 | Valor do bearing pelo nível | **PRONTO** (−2/−1/0/+1/+2) |
| 5 | Defeitos abaixo de Qualidades | **PRONTO** |
| 6 | Aliados/Mentor/Recursos/Guias no lugar dos Defeitos | **PRONTO** |
| 10 | "Status" → "Artefatos" | **PRONTO** |
| 11 | Antecedente "Artefatos" na lista | **PRONTO** (destacado de `T766`) |
| 15 | Node → **Nodo** | **PRONTO** (destacado de `T766`) |
| 16 | Pure Breed → **Raça Pura** | **PRONTO** (destacado de `T766`) |
| 9 | 8 caixas: altura e largura | **METADE** — altura sim (186→153); largura NÃO, ver Q19 |
| 4 | Qualidades/Defeitos com busca + auto-preenchimento | falta (`T749`–`T751`, `T783`–`T785`) |
| 7 | Botão `?` + caixa 500×500 + fonte ± | falta (`T760`, `T761`, `T763`) |
| 8 | Fonte ± em todas as caixas de descrição | falta (`T762`) |
| 12 | `?` nos antecedentes + dedupe com origem | falta (`T764`–`T766`) |
| 13 | Fechar caixa: botão, clique fora, uma por vez | falta (`T760`) |
| 14 | Descrições só com a parte "Sistema" | falta (`T768`, `T769`) |

⚠ **`T766` está `.` mas PARCIALMENTE FEITA**: os pedidos 11/15/16 já estão no código e instalados.
O que resta nela é só a lista final de antecedentes de `T764`. **Não refazer os três.**

### ⚠ ARMADILHAS DESTA RODADA — todas custaram tempo

1. **`defaultValue` é de `<dataLink>`, nunca de `<comboBox>`** (§B80, agora coberto por §V338).
   Quando o `rdk` sai 1 calado: **bisseccionar por ARQUIVO antes de por trecho**.
2. **Edit e Write emitem LF** (§B81). Medir `CR == LF` depois de QUALQUER escrita por ferramenta.
3. **PowerShell é case-insensitive em VARIÁVEL e em `-match`.** Custou 4 vezes nesta sessão:
   `$T`/`$t` e `$S`/`$s` são a MESMA variável (2×, as duas morreram antes de gravar, por sorte);
   e `-match '^wod\.Artifacts='` casou com `wod.ARTIFACTS=` e pulou a inserção calado.
   Usar `-cmatch` / `-ceq` / `.Contains()` quando a caixa importa.
4. **`.Replace()` troca TODAS as ocorrências.** Numa sequência de trocas de coordenada, a posição
   NOVA de uma caixa virou a âncora ANTIGA de outra e as duas foram parar no mesmo x. O gate
   pegou (§V298); sem ele teriam ficado sobrepostas. Trocar por posição única, não por string.

### RÉGUAS DA ABA TRAITS que eu não conhecia e que fixam o desenho

- **§V298: exatamente 5px entre caixas vizinhas, nos DOIS eixos** (regra do user, 2026-08-25).
- **§V290b**: a tabela de cima e a caixa de baixo compartilham borda; re-apontada nesta rodada
  para `Merit/Flaw`, `MENTOR/FAME`, `DERANGEMENTS/ARTIFACTS`.
- **§V289**: `BACKGROUNDS` fecha onde a outra coluna fecha (**693**); re-apontada de `RESOURCES`
  (que subiu) para `OTHER`.
- Juntas elas travam a largura em **240**: o buraco que FLAWS deixou é 485 = 240+5+240.

### PRÓXIMO, em ordem de valor

1. **`T760` + `T762` + `T763`** — caixa do `?` e zoom de fonte. Fecham os pedidos **7, 8 e 13**
   e não dependem de livro nenhum. É o maior ganho por esforço que resta.
2. **`T780`–`T782`** — Grimaldi em 2 entradas + `FAMILY_CAP` com alvo em `BLOOD POOL`.
   ⚠ `T780` mexe em §V212/§V236a/§V294 no MESMO commit. ⚠ `T781` emenda §V219.
3. **`T783`–`T785`** — a caixa de busca. ⚠ o `require` DENTRO do `setTimeout` é o ponto da
   tarefa: fora dele o `loading` nunca pinta (§I107f, §R44, §R47).
4. **Extração pesada**: `T749`–`T751` (~700 qualidades/defeitos de TODOS os livros, 3 parsers),
   `T764`/`T765` (antecedentes), `T768` (regenerar 2,8 MB só com `System`). Sessão dedicada.
5. **`T770` teste de tela [USER]** — agrupar com `T733` `T736` `T739` `T746` `T787`.

### PERGUNTAS ACUMULADAS — nenhuma trava o build

- **Q17** — a `Obertus` foi julgada pelo mesmo critério incompleto da Grimaldi (só o trio de
  Disciplinas). Reler a fraqueza nos 2 livros (`T786`). Leitura, não código.
- **Q18** — ficha nova semeia 10 bolinhas de sangue; o teto da Grimaldi medieval é 8. Está
  valendo §I106d: o teto impede SUBIR e o já-marcado FICA.
- **Q19 (NOVA)** — o pedido 9 pedia "encolher horizontalmente apenas um pouco". **Não deu**:
  §V298 exige 5px entre vizinhas e `DERANGEMENTS` não se moveu, então o buraco é exatamente
  240+5+240 e as caixas TÊM de ser 240. A altura encolheu (186→153). Para encolher a largura
  também, `DERANGEMENTS` precisa estreitar ou mudar de lugar — decisão do user.

### Working tree — nada commitado (regra do `CLAUDE.md`)

`M` em `SPEC.md` `HANDOFF.md` `verify-hunters-hunted.ps1` `research/README.md` `WoD20.1.lfm`
`WoD20.2.lfm` `WoD20.6.lfm` `WoD20th.lfm` `localization.lang` `output/*.rpk` ·
`??` em `research/road_bearing.tsv` `research/family_caps.tsv` `.claude/`
## 123ª RODADA (2026-08-27) — LEIA ANTES DA SEÇÃO ABAIXO, ELA ESTÁ 1 RODADA ATRÁS

**O teto de locais do chunk de `WoD20.6.lfm` é 105, MEDIDO (§B77).** Passar dele faz `rdk -l`
sair **1 com saída VAZIA e APAGAR o `.rpk`** — não nomeia arquivo nem linha. Hoje o chunk está
em **99**; sobram **6**. Antes de declarar `local` nova nesse nível, conte
(`grep -c` das linhas com 3 tabs + `local `) ou ponha a família **dentro** da função que a lê,
que é o que a 123ª fez com `ORN_COL_*`/`ORN_GUT_*` e com a família mural inteira.

**§T734 = `x`** (barra clássica: coluna na aba, gotas na sub-aba, gota no separador).
Gate **VERDE, 0 FAIL**. `.rpk` **2.176.700 B** gerado e INSTALADO 22:08.

**Abertas desta rodada, em ordem:** `T735` (gate §V323) · `T737`+`T738` (chanfro clássico —
**par atômico**, `T737` sozinha deixa o gate vermelho porque §V322b ainda exige que o 4º ramo
não passe o raio) · `T740` (gate §V325) · `T736`/`T739` teste na tela `[USER]`, que agrupam
com `T733`.

⚠ **`git show HEAD:` NÃO é o estado de trabalho deste repo** (§B78): havia `T729`…`T732` sem
commit, e restaurar do HEAD as apagou junto com o CRLF do arquivo. Quem contou foi o gate
(§V318 + 4 pernas de §V320/§V322), não o `rdk`. **Backup antes, gate depois.**

## CHAT NOVO - LEIA ESTAS 20 LINHAS ANTES DE QUALQUER COMANDO

**Estado MEDIDO 2026-08-26 22:35**, nao estimado:

| coisa | valor |
|---|---|
| §T | **637 `x`** · **67 `.`** · **7 `~`** |
| §T de codigo | **ZERO** — as 74 abertas sao teste no Firecast [USER], probe, `T159` (arte) & `T619` (REVOGADA, virou §B61). A quebra fina por tipo é da 107ª & pode ter envelhecido |
| gate estatico | **VERDE** — 571 `ok`, 0 FAIL |
| gate `-Build` | **VERDE** — §V6 exit 0 · §V7 ok |
| `.rpk` | **2.149.105 B** gerado & INSTALADO 22:30 |
| commit | `64a10fa6` levou a 115ª & a 116ª INTEIRAS (codigo · gate · `.rpk` · `SPEC.md`) |

`/ck:build` pelado varre as 67 `.`, comeca em `T114` (probe de tela) & erra. **Nao existe id de
codigo p/ pedir.**

⚠ **3 sessoes Claude rodaram neste repo AO MESMO TEMPO em 2026-08-26** & uma buildou a 115ª
enquanto outra escrevia a spec da 116ª. Nada se perdeu, mas o §T que voce leu no inicio do chat
pode estar 1 flip atras do disco — **medir antes de planejar**, nunca confiar na 1ª leitura.

### O que PEDIR neste chat, em ordem de valor

1. **Teste no Firecast** — segue sendo o UNICO gargalo. Peca um ROTEIRO AGRUPADO por tela & por
   epoca; a ordem de id e a PIOR p/ executar (abre a mesma aba 8x).
2. **Spec nova** (`/ck:spec`) p/ o que a tela revelar.
3. **`T159`** se o user tiver a arte.

### Working tree — o que esta & o que nao esta commitado

Depois de `64a10fa6` sobrou no working tree so o `SPEC.md` (os flips de `T707` & `T711`) & este
`HANDOFF.md`. **Nao commitar sem o user pedir NAQUELA mensagem** (regra do `CLAUDE.md`, & ela
### ⚠ TUDO abaixo da 107ª rodada é HISTÓRICO & tem afirmação ENVELHECIDA

As seções antigas ainda dizem `T510` **bloqueada em §R93 esperando os livros** (linhas ~856
· ~872 · ~920 · ~959 · ~969 · ~1646). **⊥ é mais verdade**: o user entregou
`Ghouls_and_Revnants_(Final_Download).pdf` em 2026-08-25, §R93 FECHOU c/ as 22 famílias &
`T510` `T640` `T641` `T642` `T643` `T645` `T646` estão `x`. O histórico ⊥ foi reescrito de
propósito — ele registra o que se sabia NAQUELA rodada. **A 107ª (logo abaixo) manda.**

### O `?` mais valioso p/ a próxima rodada (§R102, & o §T644 responde)

A régua do gate é `$PX_PER_CHAR = 6.5`, calibrada 1× p/ o corpo PADRÃO. O picker de
`Affiliation` (& os de ritual/trilha) rodam `fontSize="12"` ∴ a régua é TETO, ⊥ medida. Se a
tela mostrar folga grande à direita de `Sociedade de Ideologias Altruístas Esclarecidas (SEAI)`,
a constante desce & abre ~50px A MAIS p/ `QUINTESSENCE`/`WILLPOWER`, em cima dos 32 que §T645
já cortou. Isso ⊥ se resolve daqui — só a tela responde.

## COMECE AQUI - 116ª rodada 2026-08-26: **ABAS EM FILETE E CRUZ, & so na Idade das Trevas**

`T708` `T709` `T710` `T711` FECHADAS. A 115ª (`T703`…`T707`) fechou junto — o codigo dela foi
escrito por OUTRA sessao as 22:04 & os §T viraram nesta.

### O que entrou

- **§I88** — 2ª familia de desenho de BARRA, escolhida pela MESMA `ornStyle` que ja escolhe a
  moldura de caixa (§I87). `markFilete` NOVA (`WoD20.6.lfm:2385`) & `markPath(w, h, kind, style)`
  DESPACHA. Aba = **1** filete em **24**, de 19,08 a `w-19,08`, + cruz de meio-braco **3** em cada
  pe (**21**->**27**) · sub-aba = filete em **23**, de **19,80** a `w-19,80`, sem cruz · separador
  = cruz de meio-braco **2,5**. Constantes proprias: `ORN_FIL_MARK`=6 · `ORN_FIL_CROSS`=3 ·
  `ORN_FIL_SEP`=2,5
- **a regra que segura o desenho fora do texto**: `ORN_FIL_MARK + ORN_FIL_CROSS == ORN_MARK2` ∴ o
  topo da TINTA fica em **21** nos 2 estilos, que e onde o user aprovou na 112ª. No default o topo
  e o filete; no `filete` e o BRACO DE CIMA DA CRUZ — copiar o 21 poria a cruz em 18, dentro do
  glifo. Quem solda e o GATE (§V315c); o codigo nao deriva um do outro (isso seria §B69)
- **§V315** no gate, 6 pernas + zero-guard · **§V307** EMENDADA (texto 3->1) · **§B73**

### 3 armadilhas que esta rodada pagou - NAO repetir

1. **Nao enfiar ramo novo dentro de `markPath`**: §V308 fatia a funcao por `if kind == "sep"`,
   `if kind == "sub"` & pelo 1º `return table.concat` ∴ ramo novo la dentro TROCA as fatias &
   deixa §V308 vermelha por construcao. A forma da casa ja existia: `ornPath` despacha p/
   `ornFiligree`/`ornFilete`, & foi isso que a 116ª copiou.
2. **`awk` do Git Bash COME os CR**: converteu `WoD20.6.lfm` (CRLF) p/ LF inteiro, calado, na 1ª
   tentativa. E o `cat -A` do Git Bash TAMBEM nao mostra `^M` ∴ as 2 ferramentas mentem juntas.
   Editar `.lfm` so por PowerShell, & medir `[regex]::Matches($t,[char]13)` ANTES & DEPOIS.
3. **o gate reporta por `Write-Host`** ∴ `& .\verify-hunters-hunted.ps1 2>&1 | Where-Object
   { $_ -match '^FAIL' }` devolve **VAZIO** mesmo com 9 FAIL na tela. Script que meca o gate tem
   de ler **`$LASTEXITCODE`**. Isso fez a 1ª rodada de mutacao reportar "9 de 9 nao morderam",
   que era falso nos 2 sentidos & quase virou um check aceito sem prova.

### 1 perna que nao sabia falhar, pega PELA MUTACAO (§V20 funcionando)

§V315(f) assertava `'s = ornStyleNow'` — & o ramo de restyle contem `e.s = ornStyleNow;` ∴ apagar
o carimbo de CRIACAO deixava o check VERDE. Reancorada em `s = ornStyleNow\s*\}` & partida em 2
asserçoes (criacao & regravacao). Placar final: **9 mutacoes, 9 vermelhas** · 2 sondas
(`ORN_SUB`, `ORN_SEP_RX`) VERDES. Sem a mutacao, §V315 teria entrado com 1/6 das pernas morta.

### Como retomar

Nao ha §T de codigo aberto. O gargalo e tela: `T644` `T698` `T702` & as outras ~64.

---
## ▶ COMECE AQUI — 107ª rodada: **§T510 DESBLOQUEADA & FECHADA · §T640 NASCEU E FECHOU**

**Estado MEDIDO 2026-08-25 19:50:**

| coisa | valor |
|---|---|
| gate estático | **VERDE** — **550** `ok`, **0** FAIL (era 545 na 106ª) |
| gate `-Build` | **VERDE** — §V6 exit 0 · §V7 `.rpk` 2.105.616 → 2.111.082, em 4 builds |
| `.rpk` gerado & INSTALADO | **2.111.082 B** nos 2, `19:50` — `rdk -i` rodado |
| commitado | `dcd7e9af` levou até §T643. FORA: `SPEC.md` `HANDOFF.md` `WoD20.7.lfm` o gate & o `.rpk` |
| §T510 §T640…§T643 §T645 §T646 | **`x`** |
| §V novas | §V294…§V297 · §I75 · §B65 |
| mutações RODADAS | **15**, todas mordem (6 §V294 · 3 §V295 · 3 §V296 · 3 §V297) |

### ➕ §T642 & §T643 (mesma sessão) — aba Numina, 2ª passada de LARGURA

Pedido user 2026-08-25: o dropdown de `Affiliation` sobe p/ a LINHA do rótulo & ⊥ encolhe
(§V196 pede 382 p/ `The Society of Enlightened Altruistic Ideologies (SEAI)`) ∴ quem cede é
a largura das vizinhas. `HEDGE MAGIC` 450→**618** · `QUINTESSENCE` 470/460→**638/376** ·
`WILLPOWER` 950/460→**1034/376** · as 2 listas 450→**618** · as 2 `DESCRIPTION`
470/940→**638/772** · as **34** linhas 386→**554** & os 168 que sobram foram P/ O COMBO DO
NOME (230→**398**, bolinhas →428·453·478·503·528) nos 4 templates de Hedge. §V296 NOVA trava
o alinhamento das 2 fileiras, que até aqui era COINCIDÊNCIA.

### ⚠ 2 armadilhas de ESCOPO desta rodada — ⊥ repetir

1. **`tabPsychic` compartilha as strings EXATAS de `tabHedge`** — `text="DESCRIPTION"`,
   `<layout ... width="386" height="25">` (24 linhas) & `width="450"`. Substituição global
   pega os 2 painéis: o 1º passe mexeu no Psychic sem querer (58 linhas em vez de 34) & foi
   REVERTIDO. Editar `WoD20.7` só por REGIÃO delimitada (`tabHedge` → `tabPsychic`) & os
   templates por nome.
2. **As 2 `DESCRIPTION` têm `textEditor` de nomes DIFERENTES** — `edtHedgeDesc` (paths) &
   `edtHedgeRitualDesc` (rituals). Trocar só o 1º deixa §V239/§V280 vermelhas c/ `R=-138`.

`?` VIVO p/ o teste (§T644): `tabPsychic` ficou FORA (o user nomeou só as 2 de Hedge & o
Psychic ⊥ tem a caixa que motivou a largura) ∴ trocar de painel SALTA de 618/638 p/ 450/470.
Se incomodar, alinhar o Psychic = 1 §T de 4 números + 2 templates.

### ✅ O que a 107ª entregou

**§R93 deixou de ser `?`.** O user pôs `Ghouls_and_Revnants_(Final_Download).pdf` na pasta dos
livros (já registrada em `research/README.md` como código `gr`, offset **1**) & a varredura dos
**10** PDF fechou o universo em **22** famílias de revenant. 18 trios saem do livro; **4**
(`Katayama` `Keskinen` `Krevcheski` `Marijava`) foram RESPONDIDAS PELO USER — são decisão dele,
⊥ do livro, & está escrito assim no §R93.

**§I29b virou outra coisa** (decisão user): `clan` & `family` são 2 listas AUTORADAS separadas
(o picker de clã vai ser mostrado em outro lugar SEM as famílias) & `PICKER_LIST["clanFamily"]`
deixou de ser ALIAS — agora é a UNIÃO das 2 (62 + 22 = **84**), montada 1× no construtor dentro
dos marcadores `CLANFAMILY_UNION_BEGIN`/`END`. §B50 proibia a CÓPIA de `clan`, ⊥ a união.

**`CLANS` foi de 61 p/ 83 chaves** & ganhou `choiceN` (ausente = 1). §V212 & §V236a passaram a
medir `clan` ∪ `family`; os pisos do gate foram 61 → **83**.

### ➕ §B65 & §V295 (mesma sessão, depois do build de §T510/§T640)

`choice` de §I17 NUNCA disse quantos slots abre ∴ `Ventrue Antitribu` · `Wu Zao` ·
`Angellis Ater` entregavam **4** disciplinas de clã onde o livro dá **3** — vive desde a 83ª
(§T547) & ⊥ ∃ relato de dano: caiu ao BUILDAR §T640, quando o `Keskinen` pediu "2 de 3".
`choiceN` (§T640) já consertou; **§T641 fechou o check** (§V295, 3 pernas + zero-guard).
Decisão do user 2026-08-25: o 4º slot dessas 3 é ESVAZIADO na abertura & §V237 zera as
bolinhas — 4 preenchidas era o estado ERRADO, ⊥ compra que envelheceu.

Estado final: gate **548 ok / 0 FAIL** · `-Build` verde (§V7 `.rpk` 2.110.911 → 2.110.913) ·
`.rpk` **2.110.913 B** gerado & INSTALADO `18:19` · **9** mutações rodadas na sessão (6 de
§V294 + 3 de §V295), todas mordem. `T641` = `x`. NADA commitado.

### ⚠ 3 armadilhas que esta rodada pagou — ⊥ repetir

1. **`\Q…\E` do Perl ⊥ impede interpolação de `$var`/`@var`.** Substituição literal em script
   PowerShell só é segura com `index`/`substr` + heredoc `<<'OLD'`, ⊥ com `s/\Q…\E/…/`.
2. **`WoD20.6.lfm` é CRLF** (MEDIDO: CR=LF=2516) & o `cat -A` do Git Bash daqui mostra `$` sem
   `^M` ∴ ele MENTE sobre quebra de linha. Medir só por PowerShell — é a armadilha 1 da 106ª
   em outra roupa, & ela morde de novo.
3. **§V294a nasceu NO-OP & foi pego ANTES de rodar** — o parser do gate DERIVA `clanFamily`
   como `clan + family`, ∴ comparar o derivado contra `clan + family` ⊥ podia falhar nunca
   (§B7 de novo). A cura foi medir o CÓDIGO da união (2 loops, 2 cópias, 1 local entregue),
   ⊥ o espelho. Espelho de parser ⊥ é evidência.

### As 6 mutações (§V20), todas MORDEM

| # | mutação | acende |
|---|---|---|
| M1 | união para de percorrer `family` | §V294a (2 FAIL) |
| M2 | `Grimaldi` autorado nas 2 listas | §V294b |
| M3 | união escreve em `PICKER_LIST["family"][n]` | §V294c (2 FAIL) |
| M4 | 1 família perde a chave `[pt]` | §V294d |
| M5 | marcador `CLANFAMILY_UNION_BEGIN` apagado | zero-guard |
| M6 | `Zantosa` perde a entrada em `CLANS` | §V212 & §V236 |

### ⛔ O que a 107ª ENCONTROU e ⊥ virou §B ainda — decisão do user

`choice` NUNCA limitou quantos slots saem dela: o loop de `renderClanDisc` tratava ∀ slot sem
`fixed` como slot de escolha ∴ `Ventrue Antitribu` (2 `fixed` + `choice`) abria **2** slots de
escolha p/ 1 disciplina que o livro dá. `choiceN` c/ default **1** CORRIGE isso de lado —
& a correção MUDA comportamento das 3 linhas c/ `choice` (o 4º slot delas passa a ser esvaziado,
& §V237 zera as bolinhas dele). ⚠ vale `/ck:spec bug:` p/ virar §B c/ invariante própria.

## ▶ COMECE AQUI — 106ª rodada: **§T629…§T637 & §T639 FECHADAS · §B64 NASCEU AO BUILDAR**

**Estado MEDIDO 2026-08-25 12:23:**

| coisa | valor |
|---|---|
| gate estático | **VERDE** — **545** `ok`, **0** FAIL (era 535 na 105ª) |
| gate `-Build` | **VERDE** — §V6 exit 0 · §V7 `.rpk` mudou |
| `.rpk` gerado & INSTALADO | **2.102.588 B** nos 2, `12:23` — `rdk -i` rodado (era 2.098.690) |
| commitado | **NADA** — `SPEC.md` `HANDOFF.md` + 15 `.lfm` + `localization.lang` + o gate no working tree |
| §T629…§T637 §T639 | **`x`** |
| §T638 | `.` — teste [USER], ver ⛔ abaixo |
| §V novas | §V286 §V287 §V288 §V289 §V290 §V291 §V292 §V293 |
| mutações RODADAS | **25** — 7 (§V286/§V287) + 15 (§V288…§V292) + 3 (§V293) |

### ✅ O que a 106ª entregou (os 8 itens do pedido de 2026-08-25)

| item | virou |
|---|---|
| (2) vão do topo | `CONTENT_GAP` **0** nos 11 forms top-level · **20** MANTIDO nos 3 de sub-aba. §V231a & §V231c REVOGADAS, §V231b sobrevive |
| (3) contorno da barra | chão de `tabStrip` c/ `strokeColor="#00000000"` + chave `["#00000000"]` nas 4 `stroke`. Fundo & canto quadrado INTACTOS |
| (4) atributos | `Physical` `Social` `Mental` `top` 76·161·246 → **68·153·238** |
| (5) antecedentes | **22** linhas, `height` **723**, fecha junto c/ `RESOURCES`. `BACKGROUND_ROWS`=22, livres seguem 5 (18…22) |
| (6) coluna Book | `book_$(num)` 80px antes de `Page`; `Merit` **390…890** · `Flaw` **910…1410** · `DERANGEMENTS` **1430…1670** |
| (7)(8) Background | `Prelude` `height` **628** · cabeçalho `width` **1180** c/ colunas **350** & vão **45** |
| (9) Settings | 1ª caixa **420**, os 3 `comboBox` **300** |

### ⛔ §B64 — a §C/§T629 da 106ª estavam ERRADAS, pegas no PLANO

§T629 mandava `hedgeStrip` 190→170 & as 2 sub-panes 262→242 "porque **2** dos 11 forms
carregam sub-barra ABSOLUTA". Premissa errada em METADE: em `WoD20.11` a `vampStrip` & as 3
panes SÃO irmãs do `scrollBox`; em `WoD20.7` **só** `numStrip` & as 3 panes de 1º nível são —
`hedgeStrip` & as 2 sub-panes são filhas de `tabHedge` (MEDIDO por profundidade) ∴ descem de
graça. A letra punha a `hedgeStrip` **8px DENTRO** da fileira que fecha em 178.

⚠ **§V268 guardava só o lado de BAIXO** ∴ isso sairia do gate VERDE. Cura = **§V293** (§T639),
que mede os 2 lados como RELAÇÃO (vão de cima = vão de baixo), ⊥ como o literal 12 de §I73.
A mutação `top=170` acende **só §V293** — §V268 fica calada, que é a prova de que o buraco
era real.

### ⚠ LIMITE CONHECIDO de §V286(a) — ⊥ é bug, é escopo

§V286(a) mede o **MENOR** `top` do form. Uma caixa sozinha derivando dentro de uma fileira que
ainda tem irmã em 0 **⊥ acende** (a 1ª mutação tentada saiu VERDE por isso; refeita em
`WoD20.6`/`WoD20.9`, que têm 2 filhos cada, ela morde). É herdado de §V231a & ⊥ é regressão.
Planura de fileira é de §V168/§V280b, ⊥ desta.

### ⚠ ARMADILHAS DE FERRAMENTA desta rodada — leia antes de escrever script

1. **`grep -c $'\r'` no Bash daqui expande VAZIO** & casa TODA linha ∴ "confirmei CRLF" é
   falso positivo. Medir quebra de linha **só** por PowerShell (`[regex]::Matches($t,'\r')`).
2. **O repo MISTURA quebras ENTRE arquivos**: `WoD20.1 .3 .4 .7 .9 .12 .13 WoD20th` &
   `localization.lang` = **LF**; `WoD20.2 .5 .6 .8 .10 .11 .14` = **CRLF**. Nenhum é misto por
   dentro & ⊥ pode virar. Idioma seguro: dividir por `\n`, editar, rejuntar com `\n` — arquivo
   CRLF mantém o `\r` no fim de cada elemento sozinho.
3. **PowerShell 5.1 lê `.ps1` sem BOM como ANSI** ∴ literal não-ASCII no script vira mojibake
   (`Página` → `PÃ¡gina`) & o `Replace` casa 0. Usar âncora ASCII ou gravar o script c/ BOM.
4. `$text.Split(@($sep), [StringSplitOptions]::None)` dá **sobrecarga ambígua** em 5.1 —
   usar `[regex]::Split($t, '\n')`.
5. `$rx.Replace($s, { … }, 1)` liga na sobrecarga `(string,string,int)` & injeta o TEXTO do
   ScriptBlock. Castar: `[System.Text.RegularExpressions.MatchEvaluator]{ … }`.
6. **§V223 lê comentário**: a palavra `rule` seguida de `(` num comentário do `.lfm` casou como
   chamada ao `local function rule` declarado depois. Evitar nome-de-local + `(` em prosa.

### 🔧 O QUE O `/ck:spec` PRECISA RECONCILIAR (⊥ escrevi — é build)

Além dos **8 itens herdados da 105ª** (§V240 · §I73 · §V234c · §V259 · §V247 · §V281c · §V276 ·
§T624 item 3 — todos ainda de pé), a 106ª achou **1 novo**:

9. **`WoD20.1`, parágrafo do `HEALTH`** — o comentário afirma "does not end on 760", "at seven
   rows it ends at 685" & "pushes 6px", mas `HEALTH_TEN_ROW_OVERHANG` no gate é **1** & os 3
   números já estavam errados ANTES desta rodada. Corrigi só as **8** coordenadas do mapa Y que
   a 106ª invalidou (§V69 lê o `y=` & ficaria vermelho); o parágrafo é de outra rodada.

### Como retomar

1. **§T638** [USER] na tela — & ele sai na MESMA sessão que **§T624** & **§T628** (decisão do
   user 2026-08-25, 1 ida só). ⚠ o relato de **§T628** vem **SEPARADO**: ele é o oráculo de
   §B62 & §T622 segue `~`; misturá-lo c/ as 8 mudanças novas ⊥ diz qual quebrou.
   ⚠ §T624 item (3) cita `PAD 57` & o código tem **79** (item 8 da lista acima).
2. **§T614** [código] — ornamento das 19 pílulas; §R111 pede decisão de TELA antes (3
   candidatos). Só depois §V282, & aí **§T617** fecha.
3. ⚠ `rdk -l` ANTES de marcar cada §T (§B54). E `rdk -i` DEPOIS do gate `-Build`: o `-Build`
   recompila & dessincroniza o instalado (aconteceu nesta rodada, 2102586 vs 2102588).
4. ⚠ mutação ! ASSERTAR que o texto mudou **&** que o padrão casou o nº esperado de vezes —
   as 25 desta rodada usaram esse guard & ele pegou 2 âncoras erradas.

---

## 105ª rodada: **§T615 §T618 §T621 §T623 FECHADAS · §T617 parcial**

**Estado MEDIDO 2026-08-25 00:43:**

| coisa | valor |
|---|---|
| gate estático | **VERDE** — **535** `ok`, **0** FAIL (era 517/32 na 104ª) |
| gate `-Build` | **VERDE** — **537** `ok` (§V6 exit 0 · §V7 `.rpk` mudou) |
| `.rpk` gerado & INSTALADO | **2.098.690 B** nos 2, `00:43` — `rdk -i` rodado |
| commitado | **NADA** — `SPEC.md` `HANDOFF.md` + 8 `.lfm` + o gate no working tree |
| §T615 §T618 §T621 §T623 | **`x`** |
| §T617 | segue **`~`** — §V280 & §V281 entraram, §V282 ⊥ (ver ⛔ abaixo) |

### ✅ §T618 — os 32 FAIL fechados, 8 mutações RODADAS

Literal → RELAÇÃO (é o que §T618 pedia), ∀ uma c/ mutação VERMELHA provada:

| check | o que virou | mutação |
|---|---|---|
| **V262c** | régua `$paneW-10` → **a fileira MAIS LARGA das 3 sub-abas**; gutter 10 → **20** | encolher `DESCRIPTION` 100 → VERMELHO · gutter 10 → VERMELHO |
| **V267a** | régua `1270` → **`$numRuler`, o mesmo que V262c acabou de medir** (+ zero-guard se V262c ⊥ setou nenhuma) | encolher `WILLPOWER` 100 → VERMELHO |
| **V240** | 10/10 → **PISO ≥20** (decisão do user, §B63) · achador de título `left=0 && width=box` → **idioma de §V27** (centrado & ≥80%) · corpo esticado `41` → **`title.bottom+1+20`** | encolher `VIRTUES` 5px → VERMELHO |
| **V146** | `31` literal → **`title.top + title.height + 1`** | 1ª linha p/ `top=45` → VERMELHO · sonda: mover o `top` da CAIXA → VERDE |
| **V234** | larguras `290/280` → **330/320** · título `left=0` → **SIMETRIA** | título de volta a 215 → VERMELHO |
| **V247** | `+16` medido contra a CAIXA → **contra o `xpLogScroll`**, + perna nova `logW == 2*scrL + scrW` | alargar `dynXpCost` 45→60 → VERMELHO |
| **V170** | `colW - 30` → **`colW - 40`** | as 36 linhas de volta a 260 → VERMELHO |
| **V259** · **V193** · **V274e** | 10 → 20 · `-10` → `-20` · `399`→**419** & 10/10→20/20 | (literais diretos) |
| **V224** | exclusão da legenda `width == boxW` → **idioma de §V27** | (o zero-guard de 8 células é a prova) |
| **V276** | a perna `setParent(c)` **SAIU** — §I72c REVOGADA, §V283a herda | — |

### ✅ CÓDIGO que §T615 tinha deixado para trás (achado pelos checks, ⊥ herdado)

- `WoD20.1` **EXPERIENCE** `200`→**330** de largura (fechava em 1260 c/ a grade em 1390, §V168)
  & altura `121`→**125** (a fileira do cabeçalho fecha numa base só).
- `WoD20.7` **QUINTESSENCE & WILLPOWER** `168`→**178** (§V267a: a banda fecha numa base só)
  & conteúdo re-centrado no corpo que abre em **61**.
- `WoD20.12`/`WoD20.13` `edtDiscDesc` **526→556** & `edtPathDesc` **551→581** (§V193, margem 20).
- `WoD20.1` **as 36 linhas de habilidade** `left=35 w=260` → **`left=20 w=290`**, `Ability`
  label `135`→**165** & `CustomAbility` edit `132`→**162**, bolinhas +30 (decisão do user:
  largura ganha vira NOME, ⊥ ar — §V170 vence a letra de §T615).
- `WoD20.3` **COMBAT** `700`→**750** & a coluna `Weapon/Attack` `170`→**220** (decisão do user).
- `WoD20.4` **Languages & Goals** `440`→**490** & os 2 `textEditor` `370`→**420**.
- 4 comentários reescritos que AFIRMAVAM o número velho (`WoD20.7` ×2, `WoD20.9`, `WoD20.1`).

### ✅ §T623 — §V283 NOVA, 4 pernas, 4 mutações + sonda

`(a)` argumento de `setParent` = `c.parent` · `(b)` **⊥ `getParent()`** (o no-op de §R112) ·
`(c)` `hitTest=false` como DEPENDÊNCIA declarada · `(d)` **`ORN_IN < 20`** — a perna de
pré-requisito virou MEDIÇÃO em vez de prosa. Mutações: `setParent(c)` (o código EXATO da
rodada passada) → VERMELHO · `setParent(p:getParent())` → VERMELHO · `hitTest=true` →
VERMELHO · `ORN_IN=25` → VERMELHO · sonda `ORN_OUT` 5→6 → **VERDE**.
§V284 já estava no gate desde §T627 & passa.

### ✅ §T617 PARCIAL — §V280 & §V281 entraram, c/ 8 mutações

**§V280** mede **73** caixas (filtro por CONSTRUÇÃO ≡ §V278), **48** vãos em X & **38** em Y,
& corta **3** filhos rotacionados. Mutações: margem 15 → VERMELHO · vão 10 no **X** → VERMELHO ·
vão 10 no **Y** → VERMELHO (§B52: os 2 eixos, separados) · tirar `rotationAngle` → VERMELHO
pelo zero-guard de (c) · sonda: vão de 2 BOTÕES 4→6 → **VERDE** (quem manda em botão é §V281).

**§V281** mede **19** pílulas em **4** barras. ⚠ **a perna (c) mudou de sentença por decisão do
user**: "o último fecha 30 antes do fim" era `?` DE LETRA (pílula é dimensionada pelo TEXTO,
§V228 ∴ a folga real é 450/949/1191) & virou **"a barra CABE nos botões"** —
`last.right + 30 <= bar.width`. A `tabStrip` ⊥ tem `width` autorado (é `align`) ∴ fica FORA de
(c) & o número de barras medidas é IMPRESSO (`3 of 4`), ⊥ pulado calado. Mutações: `top=10` →
VERMELHO · 1º botão em 20 → VERMELHO · barra 640 → VERMELHO · gap 6 → VERMELHO.

### ⛔ §V282 NÃO ENTROU — & ⊥ é orçamento

§V282 mede o ornamento das 19 pílulas. Esse ornamento **⊥ EXISTE**: §T614 está `.` & o motivo
dele é `?` em §R111 ("⊥ dá p/ escolher sem VER... Decide na tela"). Check p/ código que ⊥ foi
escrito ⊥ é check, é vermelho encomendado. **§T617 só fecha depois de §T614.**

### 🔧 O QUE O `/ck:spec` PRECISA RECONCILIAR (⊥ escrevi — §T618/§T617 são build)

O código & o gate estão coerentes; o TEXTO de 7 seções ficou atrás:

1. **§V240** — o texto diz "os 2 números são LITERAIS & iguais entre si" (10/10). Virou
   **PISO ≥20** por decisão do user, porque §B63 põe 22px DENTRO de `HEALTH`×2 & `SPECIALTIES`.
2. **§I73** — diz "caixa de seção = **20** nos 4 lados" (exato) enquanto §V280(a) é PISO
   ("⊥ ∃ filho fechando a menos de 20"). As 2 leituras ⊥ podem valer juntas.
3. **§V234c** — diz título `left=0` & `width` da caixa `290`/`280`. Hoje: SIMETRIA & 330/320.
4. **§V259** — diz vão **10**, "o vão da casa". Hoje 20 (§V280b).
5. **§V247** — diz `borda direita de Cost + 16` contra a CAIXA. Hoje: contra o `xpLogScroll`,
   & a caixa = scrollBox + 2×20.
6. **§V281c** — a sentença mudou (ver acima). O `?` de §T617 foi RESPONDIDO pelo user.
7. **§V276** — o texto nunca falou de parentesco, mas o gate tinha a perna. Ela saiu p/ §V283a.
8. **§T624 item (3)** — diz `HEALTH_BOX_PAD` **57**; o código é **79** (§B63 somou os 22).
   O teste de tela vai procurar o número errado.

**§B candidato (backprop de processo):** §T615 foi fechada c/ o gate VERDE na 104ª & ainda
tinha **4 fileiras sem reflow** (`COMBAT`, `Languages`, `Goals`, `EXPERIENCE`). O check que as
pegaria — §V280(b) — estava agendado p/ a §T SEGUINTE. Lição: §T cuja invariante mora numa §T
posterior ⊥ pode ser fechada pelo gate — o gate ainda ⊥ mede o que ela prometeu. É §B7 na
ORDEM das tarefas em vez de dentro do check.

### Como retomar

1. **`/ck:spec`** — os 8 itens acima. Nada de código depende disso, mas a próxima rodada que
   ler §V240/§I73/§V234/§V247 vai "consertar" código certo (é §B61 esperando).
2. **§T614** [código] — ornamento das pílulas; §R111 pede decisão de TELA antes (3 candidatos).
   Só depois §V282, & aí §T617 fecha.
3. **§T624** [USER] na tela — itens (1)–(4) = margem (§T615), (5)–(7) = z-order (§T621).
   ⚠ o item (3) cita `PAD 57` & o código tem **79**.
4. **§T625** & **§T628** [USER] — os outros 2 testes de tela acumulados.
5. ⚠ `rdk -l` ANTES de marcar cada §T (§B54: `--` faltando sai 1 SEM mensagem & APAGA o `.rpk`).
6. ⚠ **mutação ! ASSERTAR que o texto mudou** — 2 das 15 desta rodada abortaram por número de
   linha velho & teriam medido a própria falha como "verde" (§B54, ≡ o `\r\n` da 103ª).

---

## 104ª rodada: **§T615 CÓDIGO PRONTO, gate a reconciliar (32 FAIL)**

Rodada parada em **~56% de contexto por regra do user** (a 65% eu paro & preparo chat vazio).
⊥ é bloqueio: é orçamento. O código está INTEIRO & COERENTE; o que falta é §T618 (gate).

**Estado MEDIDO 2026-08-24 23:45:**

| coisa | valor |
|---|---|
| gate estático | **517 `ok` · 32 FAIL** (era 533/0 na 102ª; o pico foi 105 FAIL & já caiu p/ 32) |
| `rdk -l` | **exit 0** · `.rpk` **2.098.587 B** (era 2.096.951) — o Lua de §T621 compila |
| `.rpk` INSTALADO | **⊥** — falta, o gate ⊥ está verde |
| commitado | **NADA** — `SPEC.md` `HANDOFF.md` + 16 `.lfm` + o gate no working tree |
| §T615 §T618 §T621 §T623 | seguem **`~`** — `x` só com gate verde |

### ✅ O que a 103ª ENTREGOU (código, tudo verificado por medição própria)

- **as 73 caixas** c/ margem ≥20 nos 4 lados & vão 20 entre elas, nos 2 eixos. MEDIDO depois
  de aplicar: **73 caixas · 0 margem <20 · 0 vão <20**.
- **reflow nos 3 níveis** nos 14 `.lfm`. Larguras novas: `WoD20.2` **1670** · `WoD20.7` painéis
  **1410** (os 3 no mesmo rect, §V262a) · `WoD20.1` **1390** · `WoD20.11` **1070**.
- **§V69 restaurada**: `HUMANITY` `SPECIALTIES` & avatar fecham em **894**, `HEALTH` em 895.
  Mapa de `WoD20.1.lfm:36` reescrito p/ `x=1390 / y=894` (é de lá que §V69 LÊ).
- **avatar** `300→340`, altura **403** derivada da linha.
- **`HEALTH_BOX_PAD` 37 → 79** (`WoD20th.lfm:1168`) & as 2 caixas estáticas em **349**.
- **§T621 FEITO**: `p:setParent(c)` → **`p:setParent(c.parent)`** (`WoD20.6.lfm:2172`) & o
  comentário reescrito (ele AFIRMAVA o contrário — 2 verdades no mesmo arquivo).
- **§V27 reconciliada & MUTAÇÃO RODADA**: era `left=0 && width=boxW`, virou **simetria**
  (`left == boxW-left-width`). Sozinha derrubou **73** dos 105 FAIL. Probe: empurrar 1 título
  5px → 4→**7** VERMELHO, restaurado → 4. ⚠ a probe ASSERTA que o texto mudou (§B54/102ª).

### ⛔ §B63 NASCEU AO BUILDAR — leia antes de mexer em altura

§V69 (linha única) & crescimento uniforme ⊥ podem valer juntos: coluna c/ 3 caixas ganha
`+20` 3× & 2 vãos, contra 2× & 1 vão da vizinha ∴ **22px** de diferença. `HEALTH` é a única que
⊥ absorve crescendo (§V49 SOLDA a altura). **Decisão do user: os 22 entram DENTRO** (`PAD` 79),
⊥ num vão de 42 acima ∴ topo da fileira segue alinhado & §V280(b) segue IGUALDADE.

### 🔧 O QUE FALTA — os 32 FAIL, com o diagnóstico já feito

⚠ **`V224` & o título das caixas usam o MESMO idioma velho que §V27 usava** (`width == boxW`
p/ dizer "isto é o título"). Sob §I73 o título é `left=20 width=boxW-40` ∴ ⊥ é bug de código,
é literal a reconciliar — ≡ o que já fiz em §V27. Vale p/ `V224` & `V234`.

| check | n | o que é |
|---|---|---|
| **V262** | 11 | régua `1270` & gutter `10` → RELAÇÃO (§T618 já manda; `:6776` `$paneW - 10`) |
| **V234** | 4 | `dynHealth` 290/280 literais → 330/320 & título por SIMETRIA |
| **V193** | 3 | `WoD20.12/13/14`: o `<textEditor>` ⊥ acompanhou a caixa que cresceu |
| **V274** | 3 | altura 399→419 & "respira 10" → 20 |
| **V267** | 2 | banda em 2 bases (168/178) & régua 1270 → `:7037` (`-ne 1270`) |
| **V168·V170·V171** | 3 | `EXPERIENCE` fecha 1260 & `KNOWLEDGES` 1390 — o fecho da fileira do cabeçalho ! esticar |
| **V276** | 1 | afirma que o path é filho da CAIXA — §T621 inverteu ∴ vira §V283a |
| **V146·V224·V240·V247·V259** | 5 | literais: 31/41 · contagem 8 · centragem das 2 esticadas · última coluna do log · vão 10→20 |

### AINDA ⊥ ESCRITOS (são §T617/§T623, ⊥ estão nos 32)

**§V280** (3 pernas: margem · vão nos 2 EIXOS · corte de `rotationAngle`) & **§V283**
(4 pernas, z-order). Os 2 são checks NOVOS ∴ **mutação RODADA antes de aceitar** (§V20 §B7),
& §V280(b) ! ter mutação no eixo **Y** também — o Y é o único c/ vão de 5 (`WoD20.4`) & provar
só X é §B52 de novo.

### Como retomar (chat vazio)

1. `/ck:build T618` — é o gate, & é o que falta. A tabela acima é o mapa; ⊥ re-descobrir.
2. Depois `/ck:build T617` & `/ck:build T623` (§V280 & §V283 novas, c/ mutação).
3. Gate VERDE → `rdk -i` → aí sim marcar §T615 §T618 §T621 §T623 como `x`.
4. Então **§T624** [USER] na tela: itens (1)–(4) = margem, (5)–(7) = z-order.
5. ⚠ `rdk -l` ANTES de marcar cada §T (§B54: `--` faltando sai 1 SEM mensagem & APAGA o `.rpk`).
6. Backup do código pré-103ª: `%TEMP%\wod20th.bak` (17 arquivos) — serve p/ diffar, ⊥ p/ voltar.

---

`/ck:build` sem arg varreu as ~60 abertas: **0 §T de código construível** (≡ 99ª). Nenhum
arquivo tocado — `.lfm` `.lua` `.lang`, gate & `SPEC.md` intactos.

⚠ **working tree LIMPA** — o "commitado: NADA" das rodadas abaixo está VELHO: `c39d4445`
(2026-08-24 22:36) já carrega a 101ª & a 102ª.

### O que travava §T615 — MEDIDO nesta rodada, ⊥ herdado do HANDOFF

As 73 caixas ⊥ são 1 grupo só:

| n | margem hoje | sob "+40 uniforme" |
|---|---|---|
| **66** | `L=0 R=0 T=10 B=10` | 20/20/20/20 ✓ |
| **5** | `L=15 R=15 T=10 B=10` | **35/35**/20/20 ✗ |
| **2** | `L=0 R=0 T=10 B=36\|46` | `QUINTESSENCE` & `WILLPOWER` — §V267b já isenta |

Os 5: cabeçalho `WoD20.1 1030x105` · `Merit` & `Flaw` (`WoD20.2 410x291`) · cabeçalho
`WoD20.4 1040x105` · `Language` (`WoD20.6 380x125`). A decisão (A) da 99ª foi tomada ANTES de
alguém separar esses 5 ∴ ⊥ era falta de contexto, era **fork ⊥ medido**.

### As 5 decisões do user (2026-08-24, 103ª)

1. **REGRA = "margem vira EXATAMENTE 20"**, ⊥ "+40 fixo": **68** crescem **+40** de largura &
   as 5 de `L=R=15` crescem **+10**; **71** crescem **+20** de altura & **2** crescem +10. ∴
   §I73 fica verdadeira nas 73, sem exceção p/ ninguém decorar depois. `Merit`/`Flaw`
   `410→420` · cabeçalhos `1030→1040` & `1040→1050` · `Language` `380→390`.
2. **avatar da Main ACOMPANHA**: `300 → 340` de largura (`WoD20.1.lfm:330-331`, `rectangle`
   DimGray + `image field="avatar"`). ⊥ é caixa de seção (⊥ é preta ∴ §V278 ⊥ o pega & ⊥ entra
   nas 73) mas mora sob `ATTRIBUTES` ∴ ficar em 300 abre degrau de 40 na coluna esquerda.
   `style="autoFit"` ∴ o retrato ⊥ distorce. A ALTURA já era derivada (§V69 obriga a fechar
   na linha de `HUMANITY` & `SPECIALTIES`).
3. **as 3 sub-abas de `Numina` fecham no MESMO x** — a mais larga manda. MEDIDO: a fileira de
   cima da `tabHedge` fecha em **1410** ∴ `tabPsychic` chega lá pela caixa que FECHA a fileira
   (`DESCRIPTION` 850→**940**) & as 2 de `tabFaith` já são de largura cheia (1270→**1410**).
   Quem absorve é sempre a que fecha — esticar picker/combo violaria §V196/§V228.
4. **vão ENTRE caixas padroniza em 20**, nos 2 eixos (hoje é 10 na maioria, **20** no
   `WoD20.8`, **15** em pontos do `WoD20.1`, **5** no `WoD20.4`). Caixa↔caixa SÓ.
5. **§T615 + §T618 + §T621 + §T623 na MESMA rodada** — CONTRA a recomendação de separar
   (margem → tela → z-order). Registrado em §T621 c/ a razão, & §T624 ganhou as 2 metades
   numeradas separadas p/ o relato dizer QUAL quebrou.

### O que ⊥ é decisão — derivado & JÁ escrito no `SPEC.md` (103ª)

- **§V262c & §V267a**: o literal `1270` (`verify-hunters-hunted.ps1:6776` `:7037`) vira
  RELAÇÃO — "quem fecha a fileira fecha no MESMO x". ≡ o que §T618 já fez p/ §V221/§V225/§V232.
- **panes & barras**: `WoD20.7` (1280) & `WoD20.11` (990) crescem pro conteúdo novo; §V262b
  (`≤1280` & `≤660`) ganha os números novos.
- **regra de reflow, 3 níveis**: caixa cresce → vizinha da fileira anda o delta ACUMULADO
  (gaps preservados) → fileira de baixo desce +20 por fileira acima → container aninhado
  cresce pro conteúdo.
- **`HEALTH_BOX_PAD` 37 → 57** (`WoD20th.lfm:1168`): as 2 caixas de vitalidade são
  redimensionadas em runtime ∴ §V49 pede mutação NOVA, & isto encosta em §V284/§V285.
- **§V280 ! CORTAR `rotationAngle`** — §T617 já manda & §B61 é a razão.

### ✅ `/ck:spec` FEITO na 103ª — 8 linhas, gate re-rodado VERDE (533 ok, 0 FAIL)

`§I73` · `§V262` (b, c & a mutação) · `§V267` (a) · `§V280` (virou 3 pernas) · `§T615`
(re-escrita) · `§T618` · `§T621` · `§T624`. Nenhuma seção ⊥ nomeada foi tocada.

### Como retomar

1. **`/ck:build T615`** — & §T618 §T621 §T623 na MESMA rodada (decisão 5). Separar acende
   vermelho DE PROPÓSITO. ⚠ ORDEM DENTRO da rodada: a margem 20 aterrissa nas 73 ANTES de o
   filete subir, senão o filete de 5/9px risca os filhos de largura cheia de 68 das 73.
2. O que o build ainda tem de LIGAR no gate (§T618 nomeia): matar os 2 literais
   `verify-hunters-hunted.ps1:6776` (`$paneW - 10`) & `:7037` (`-ne 1270`), pôr §V240 em 20,
   §V247 em **541**, & escrever a perna (b) de §V280 (vão) c/ mutação nos 2 EIXOS — o Y é o
   que tem `WoD20.4` a 5 & o X ⊥ tem nada abaixo de 10 (§V222, ≡ §B52).
3. Depois: **§T624** [USER] na tela, itens (1)–(4) = margem & (5)–(7) = z-order.
4. ⚠ **5 testes de tela acumulados**, o urgente segue §T628.

---

## 102ª rodada: `/ck:spec` (§B62) + `/ck:build` → **§T626 & §T627 FECHADAS**

A 101ª entregou §T622 c/ gate VERDE, 7 mutações rodadas & `.rpk` instalado — **& ⊥ funcionava
na tela**. Esta rodada achou a raiz, curou & travou a lição.

**Estado MEDIDO 2026-08-24 22:33:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **533** `ok`, 0 FAIL (era 532; +1 = §V285) |
| gate `-Build` | **VERDE** (§V6 exit 0 · §V7) |
| `.rpk` gerado & instalado | **2.096.951 B** nos 2, 22:33:34 / 22:33:35 |
| commitado | **NADA** |

### A raiz de §B62 — 2 leituras de runtime SEM precedente

| leitura | precedente na ficha | veredito |
|---|---|---|
| `k:getClassName() == "rectangle"` | `THEME_SHAPES = { rectangle = true }` & o tema PINTA | provado |
| `k.align == "client"` | **0** — era a única leitura de `.align` em Lua da ficha | `?` inventado |
| `c.width`/`c.height` do filho `align="client"` | `getHeight` é `_gui_getHeight`, ≠ `getWidth` | `?` de reflow |

Se o host devolve índice de enum, o laço ⊥ acha nada & sai 0. Se o layout ⊥ reflowou no mesmo
tick, a comparação acha "igual" & ⊥ redesenha. **As 2 dão o MESMO sintoma** ∴ a cura mata as 2.

### §T626 `x` — a cura ⊥ escolhe entre os candidatos

`refreshOrnament(box, w, h)` recebe a medida por ARGUMENTO de `renderHealthTrack`, que acabou
de escrevê-la, & acha o controle pelo **MEMO** (`ornPainted[k.handle]`). `ornament(c, fill,
colour, w, h)` — os 2 opcionais; sem eles cai em `c.width`/`c.height` ≡ hoje ∴ §V276 intacta &
a CRIAÇÃO segue lendo (lá ⊥ ∃ escrita competindo c/ o reflow). `fill` entra `nil` de propósito:
o memo ∃ pelo teste recém-feito ∴ o ramo de criação ⊥ roda. De quebra some a dependência da
ORDEM de `getChildren()`, que é `pairs()` de hashtable (`rrpgObjs.lua:577`).

### §T627 `x` — §V285 no gate, 8 sondas RODADAS

| mut | o que | resultado |
|---|---|---|
| **A** | **o código EXATO da 101ª** | **VERMELHO — as 4 pernas** |
| B | `ornament` volta a 3 params | VERMELHO |
| C | medida lida de volta | VERMELHO (2) |
| D | chama sem entregar medida | VERMELHO |
| E | lê outra propriedade do filho | VERMELHO |
| **F** | **sonda**: renomear `k`→`kk` | **VERDE** |
| G · H | §V49 afrouxada: literal · escrita some | V49 VERMELHO |

⚠ **A e F quase passaram VACUOSAS**: usei `\r\n` no `.Replace()` & o arquivo é **LF** ∴ a
mutação ⊥ aplicou & o "verde" da 1ª rodada ⊥ media nada — ≡ o `python` que ⊥ ∃ nesta máquina
na 101ª. **Sonda ! ASSERTAR que o texto mudou**, senão ela mede a própria falha.

⚠ §V49 foi AFROUXADA de propósito: ela casava `height\s*=.*HEALTH_ROW_PITCH` numa linha só & a
cura calcula num local (1 fonte de verdade p/ 2 leitores). Re-ancorada na CONSTRUÇÃO — acha o
que é atribuído a `.height` & aceita literal COM a pitch ou local ATRIBUÍDO dela. G & H provam
que ainda sabe falhar.

### ⛔ §T622 SEGUE `~` — & isso é a lição, ⊥ pendência

A fiação está certa & o gate prova a FORMA. **O gate ⊥ RODA Lua** (§B30 §B34) ∴ ele ⊥ pode
dizer que a filigrana acompanha — só a TELA pode. §T622 fecha quando **§T628** passar, & ⊥
antes. Mutação prova que o CHECK sabe falhar, ⊥ que o CÓDIGO funciona.

### Como retomar

1. **§T628** [USER] — tema `Victorian Era`, `Health Levels` 7 → 10 → 4, nas 2 abas. Se AINDA
   ⊥ acompanhar, ⊥ ∃ 3º palpite: o próximo passo é `Log.i` no caminho (§R92i diz que ∃ & a API
   basta), ⊥ adivinhar uma 3ª leitura.
2. `/ck:spec` p/ §T615: falta a **regra de reflow** (quem anda, quanto, nos 3 níveis de
   aninhamento) & o que §V262c/§V267a VIRAM sob (A) — régua por fileira, ⊥ revogação.
3. Depois `/ck:build T615` + §T618, & então §T621 (depende de §T615) & §T623 (fecha c/ §V283).

⚠ **5 testes de tela acumulados**: §T628 (o urgente) · §T624 · §T625 · + os 3 da 97ª/98ª.

---

## 101ª rodada: `/ck:build --all` → **§T616 FECHADA**, §T622 REABERTA, §T618/§T623 parciais

**Estado MEDIDO 2026-08-24 21:55:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **532** `ok`, 0 FAIL (era 531; +1 = §V284) |
| gate `-Build` | **VERDE** (§V6 exit 0 · §V7 `.rpk` mudou) |
| `.rpk` gerado & instalado | **2.095.061 B** nos 2, 21:55:16 / 21:55:17 |
| commitado | **NADA** — working tree suja |

### §T622 FECHADA — filigrana da vitalidade acompanha a caixa

`ornPainted[handle]` passou de `path` p/ **`{p, w, h}`** & `ornament()` ganhou a 3ª porta
(memo ∃ **&** medida ≠ guardada → recalcula & reescreve `p.data`). `refreshOrnament(box)` NOVA
& global em `WoD20.6` (o padrão que `renderHedgePickers`/`renderManualEntry` já usam p/ falar
com outros arquivos), declarada ABAIXO de `ornament()` (§V223). `renderHealthTrack`
(`WoD20th.lfm`) chama **depois** de escrever `box.height`. `ornColour` guardado do último
`applyTheme`, do MESMO `t` que pinta as caixas.

**§V284 escrita no gate & 7 sondas RODADAS** — 6 mutações VERMELHAS + 1 vizinha VERDE:
memo sem medidas · sem comparação · `mode="stretch"` · `refreshOrnament` renomeada · **ORDEM
invertida** (refresh antes da altura) · nome LITERAL da caixa → todas VERMELHAS; renomear o
local `e` (decl + usos) → VERDE.

⚠ o 1º desenho de §V284 estava ERRADO & foi o check que mudou, ⊥ o código: ancorei em
`ornPainted[c.handle] = {` & o código atribui via local ∴ falso vermelho. Re-ancorado no par
que o box é medido (`local bw, bh = c.width, c.height`) & num construtor de tabela que carrega
os 2 — é a letra de §V222, & valeu a mutação ter rodado ANTES de aceitar.

### §T616 FECHADA — as 4 barras a h=60 & `CONTENT_GAP` 12→20

- **73 filhos de 1º nível** deslocados **+8** nos 14 forms (o mais alto de cada um estava em
  `top=12`) ∴ o espaçamento INTERNO ficou intacto.
- **4 barras** a `height=60`, `top=15` nos 22+6+4+6 retângulos, 1º botão em `left=30`, gap 4
  intacto. `tabStrip` desloca **+14** & as 3 sub-barras **+24**. Cadeia fecha em **1163**
  (⊥ 1153 — a 98ª supôs 1ºleft=20). `STRIP_X0` 16 → 30.
- **panes** liberam as barras: `WoD20.7` 66→**92** & `WoD20.11` 188→**214** (os gaps autorados,
  12 & 4, preservados). As 3 panes de `WoD20.7` foram a **714** & `tabHedgePaths`/`Rituals` a
  `top=242` — `tabHedge` fecha em 714/714, folga zero como previsto.
- gate: `$CONTENT_GAP` 12 → **20** (`:5342`). **Sonda RODADA**: 1 form de volta a `top=12` →
  §V231 VERMELHA no valor novo.

⚠ **§V69 acendeu & foi conserto REAL, ⊥ literal de gate**: ela lê a régua de um COMENTÁRIO-mapa
em `WoD20.1.lfm:36` (`Everything closes on x=1210 / y=784`), desenhado justamente p/ ⊥
apodrecer. Com o +8 as caixas passaram a fechar em **792** & o comentário foi junto.

⚠ Ferramenta nova em `$TMP/lfmedit.ps1`: mapeia elemento → offset no texto cru via `XmlReader`
+ `IXmlLineInfo`, correlacionado com o DOM por ordem de documento (conferido: 14/14 arquivos
batem). Foi necessária porque **`WoD20.4` & `WoD20.5` têm indentação MISTA** (tab + espaços)
∴ regex em texto cru erra 1 filho em cada — medido antes de editar.

### ⛔ §T615 PAROU — a regra de REFLOW ⊥ ∃ no spec

§T615 diz "a CAIXA cresce `+40×+20` & os filhos deslocam `+20/+10` — **nenhum conteúdo é
re-disposto**". As 2 metades ⊥ fecham: se ∀ caixa cresce 40 de largura, **a caixa VIZINHA à
direita ! andar 40** (& a de baixo, 20), senão §V40 (⊥ ∃ sobreposição) acende. O spec ⊥ diz
p/ ONDE o vizinho vai — & a conta ⊥ é uniforme: as 73 estão em níveis de aninhamento
DIFERENTES (umas são filhas do `scrollBox`, outras moram dentro de `tabHedge`/`tabDisc`).

Falta também o que SUBSTITUI §V262c & §V267a. §T618 diz que elas "CAEM" — mas **reconciliar
⊥ é apagar**: sob (A) a régua deixa de ser 1 número (1270) & vira "∀ fileira ladrilha de 0 até
a borda DELA, & as caixas da fileira concordam nisso". Apagar a perna perde cobertura em
silêncio, que é §B7 esperando.

**⊥ inventei nenhuma das 2.** É o 3º item desta sequência em que o §T descreve o QUE sem o
COMO (≡ §V281c & §B61) ∴ vale tratar como padrão, ⊥ como acaso.

### Como retomar

1. `/ck:spec` com 2 itens: **(a)** a regra de reflow de §T615 (quem anda, quanto, e como isso
   se comporta nos 3 níveis de aninhamento); **(b)** o que §V262c & §V267a VIRAM sob (A) —
   régua por fileira, ⊥ revogação. De quebra, §V281c (o "último botão fecha 30 antes do fim"
   ⊥ é implementável: os botões são dimensionados pelo TEXTO).
2. `/ck:build T615` + §T618, & só então §T621 (que depende de §T615) & §T623 (fecha c/ §V283).
3. §T614 segue esperando tela (§R111).

⚠ **4 testes de tela acumulados**: §T624 & §T625 (novos) + os 3 da 97ª/98ª (curvas cúbicas ·
`TRUE FAITH` ornamentada · 13 controles em zona de canto). **Vale abrir a ficha AGORA**: a
barra de abas mudou de altura em TODAS as abas & o conteúdo desceu 8px nas 14 — §T615 constrói
em cima dessa geometria, & se ela estiver torta na tela, §T615 compõe o erro.

---

## 100ª rodada: `/ck:spec` (3 itens do user + os 5 pendentes da 99ª) — **SPEC ESCRITO, 0 código**

`/ck:spec` fechou o buraco que travava a 99ª. **Escrito:** §C (17 bullets novos) · §I72c
**REVOGADA** & §I72d **NOVA** · **§R112 §R113** · **§V283 §V284** · **§T621…§T625** ·
**§B61** · & §T615 §T617 §T618 §T619 RE-ESCRITAS. Gate **VERDE, 531 `ok`** depois de escrever.
Numeração conferida: 0 duplicata em §R/§V/§T/§B, monotônica (R113 V284 T625 B61).

**O que a 100ª decidiu, & o que ela DESCOBRIU medindo:**

- **item 1 (filigrana POR CIMA)** — ⊥ ∃ z-order no SDK: `bringToFront`/`sendToBack`/`zorder`
  = **0 hit em `SDK3/` INTEIRO**. Só ordem de criação ∴ o `<path>` deixa de ser filho da
  `<rectangle>` & vira filho do `<layout>`. ⚠ **`setParent` tem early-return**
  (`rrpgObjs.lua:637`) ∴ `p:setParent(p:getParent())` — o idioma que o PRÓPRIO SDK usa em
  `initialize()` — é **NO-OP silencioso**. Virou §R112 & §V283b, & é a mutação que §T623 exige.
- **item 1 DEPENDE do item 3, & isso ⊥ é ordem preferida**: as réguas correm a `ORN_OUT=5` /
  `ORN_IN=9` da borda & 65 das 73 caixas têm filho em `left=0` de largura cheia ∴ POR CIMA,
  hoje, o filete RISCA o conteúdo. §V283d cobra §V280 como pré-requisito.
- **item 2 (vitalidade)** — `renderHealthTrack` escreve `box.height` (`WoD20th.lfm:1274`) mas
  `ornament()` calcula o dado **1× na criação** & o memo nunca recalcula. `gui.Path.data` TEM
  setter ∴ redesenhar é 1 atribuição; `mode="stretch"` ∃ & resolveria de graça, **mas achata
  o motivo ~26%** — rejeitado (§R113). São **2** caixas (`dynHealth_box` & `dynHealth3_box`).
- **§T619 era FALSA nas 3 partes** → virou **§B61** & a linha foi revogada. O gate JÁ sabia da
  rotação, por escrito, & §V27/§V239/§V240 já cortam `rotationAngle` — "⊥ ∃ check que o pegue"
  eram **3 checks que decidiram ⊥ pegar**. §T617 ganhou o aviso: §V280 ! cortar rotacionado.
- **§T617 ganhou um `?` novo**: §V281c ("o último botão fecha 30 antes do fim") ⊥ é
  implementável como está — os 19 botões são dimensionados pelo TEXTO ∴ o último fecha em 1163
  numa barra de 1280. Ou vira "≥30 de folga" ou sai. **Decidir antes de escrever o check.**

**Próximo comando: `/ck:build T616`** (ele & §T618 juntos — §T618 agora nomeia §V262/§V267).
Depois `/ck:build T615`, & só então §T621 (que depende de §T615). §T614 segue esperando tela.

---

## 99ª rodada: `/ck:build --all` → **0 §T fechada**, 3 decisões TOMADAS, 1 bloqueio MEDIDO

Rodada de DIAGNÓSTICO. `/ck:build` sem arg varreu as 60 linhas abertas & **⊥ ∃ §T de código
construível hoje** — ⊥ por falta de decisão (as 3 que faltavam foram tomadas nesta rodada),
& sim porque §T615 **&** §T616 colidem com a MESMA invariante, **§V262**, que §T618 ⊥ nomeia.

**Estado MEDIDO 2026-08-24 (99ª):**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **531** `ok`, 0 FAIL (≡ 98ª) |
| código tocado | **NENHUM** — 0 edição em `.lfm` `.lua` `.lang` & no gate |
| `SPEC.md` | **⊥ tocado** (write policy: `/ck:build` só vira status de §T; nenhum §T mudou de status) |
| commitado | **NADA** — working tree ≡ a da 98ª |

### As 3 decisões do user (2026-08-24, 99ª)

1. **§T615 = (A) as caixas CRESCEM** `+40×+20`, filhos deslocam `+20/+10`. Barras horizontais
   **ACEITAS** — reafirmado depois de eu medir que o custo real é MAIOR que o estimado.
2. **§T616 = `CONTENT_GAP` 12 → 20.** §I34 (a barra respira MENOS que o conteúdo) FICA:
   15 < 20 ∴ §V231(c) sobrevive. `$stripGap` o gate LÊ do XML ∴ vira 15 sozinho.
3. **§T619 = premissa errada** → vai p/ backprop, ⊥ p/ build (abaixo).

### ⛔ O BLOQUEIO: §V262 é a colisão de §T615 **e** §T616, & §T618 ⊥ a nomeia

§T618 lista §V240 §V231 §V221 §V225 §V232 §V247. **MEDIDO — 3 dessas ⊥ precisam de nada &
1 que falta precisa:**

- §V221 · §V225 · §V232 são **RELAÇÕES**, ⊥ literais: elas se reconciliam SOZINHAS se o
  deslocamento for feito certo. O ÚNICO literal de gate que §T616 derruba é
  `$CONTENT_GAP = 12` (`verify-hunters-hunted.ps1:5342`). `1153` & `1149` só ∃ em PROSA do
  `SPEC.md` (§C:704 · §I36:1008 · §T618) — o gate ⊥ guarda nenhum dos 2.
- **§V262 ⊥ está na lista & é quem acende nos 2 lados:**
  - **por §T616:** `tabHedge` (`WoD20.7`) tem **folga vertical ZERO** — `maxBottom` = **688**
    num pane de **688**. `hedgeStrip` 34 → 60 empurra `tabHedgePaths`/`tabHedgeRituals` de
    `top=216` p/ `242` ∴ fundo **714 > 688** → §V262(b) VERMELHA ("a vertical bar, which is
    the other half of §B52"). As outras 2 panes têm folga (47 & 28) & as 3 da Vampiro têm
    ≥88 sobrando ∴ **`tabHedge` é a única**.
  - **por §T615 sob (A):** §V262(c) mede "rows tile from 0 to 1270" & §V267 exige a banda
    fechando em **1270** (`verify-hunters-hunted.ps1:7019`). Sob (A), **6 das 14 abas**
    passam de 1280.

**Scanline MEDIDA (caixas que um traço horizontal atravessa × +40 cada):**

| arquivo | lado a lado | right hoje | right sob (A) |
|---|---|---|---|
| WoD20.2 | 6 | **1380** | **1620** |
| WoD20.7 | 3 | 1270 | **1390** |
| WoD20.1 | 4 | 1210 | **1370** |
| WoD20.10 | 3 | 1225 | **1345** |
| WoD20.5 | 3 | 1220 | **1340** |
| WoD20.8 | 3 | 1180 | **1300** |
| WoD20.4 · 3 · 11 · 12 · 13 · 14 · 6 · 9 | 1–3 | 380…1040 | 420…1160 ✓ |

⚠ a 98ª estimou *"a aba mais larga vai de 1280 p/ ~1320+"* — ela contou **1 caixa por faixa**.
O real é **1300…1620**. (WoD20.2 já está em 1380 HOJE — conferir se ela é uma das 3 panes que
§V262 isenta por rect.)

### §T619 — ⊥ construída. A premissa está errada nas 3 partes (é `/ck:spec bug:`, ⊥ build)

§T619 diz *"`WoD20.1.lfm:278` tem margem `-40` à esquerda … É defeito próprio & ⊥ subproduto
de §T615"*. MEDIDO:

1. **`:278` ⊥ tem `-40`** — é a própria caixa `ATTRIBUTES`, `left="0" top="127" width="300"
   height="286"`. Os `-40` estão em `:282` `:296` `:313` & são **3** (`Physical` `Social`
   `Mental`), ⊥ 1.
2. **⊥ vazam.** Os 3 têm `rotationAngle="270"` & `100×20` ∴ `-40` é a caixa PRÉ-rotação:
   centro `x = -40+50 = 10` & o render ocupa **x ∈ [0,20]**, DENTRO da caixa. Quem já sabe
   disso é o próprio gate, por escrito, em `verify-hunters-hunted.ps1:5819-5820`. §V27
   (`:1019`) §V239 (`:5860`) §V240 (`:5935` `:5973`) cortam rotacionado DE PROPÓSITO. ⊥ é
   "hoje ⊥ ∃ check que o pegue" — é **3 checks que decidiram ⊥ pegar**.
3. **"⊥ é subproduto de §T615" está invertido.** Com os 10 de hoje `[0,20]` passa; é o **20 de
   §I73** que faz o render encostar em `x=0`. E o conserto ⊥ é mexer no `-40` sozinho: as
   linhas de atributo vizinhas nascem em `left="35"` ∴ empurrar o rótulo p/ `[20,40]` obriga
   as 3 linhas a andar junto. Isso **É** §T615. `left="20"` cego põe o render em `[60,80]`,
   em cima das linhas — regressão garantida.

### Como retomar em chat novo — `/ck:spec` ANTES de qualquer build

1. `/ck:spec` com estes 5 itens:
   - **§T618 ganha §V262** (& §V267) na lista de reconciliação — é o item que falta & é o que
     bloqueia as 2 tarefas.
   - **§V262 sob (A):** revogar (c) & o 1270 de §V267 p/ as 6 abas medidas, OU declarar a
     régua nova. §B52 muda de escopo junto.
   - **§V262(b) p/ `tabHedge`:** decidir entre crescer as 3 panes de `WoD20.7` 688 → 714
     (§V262a exige as 3 no MESMO rect) ou encolher `tabHedgePaths`/`tabHedgeRituals` 472 → 446.
   - **§T615** re-escrita p/ (A): hoje a 2ª frase dela descreve (B) (*"Conteúdo encolhe 40px…"*).
   - **§T618** ganha `CONTENT_GAP` 12 → 20 (a decisão 2 acima); e §I36:1008 / §C:704 / §T618
     largam `1149`/`1153` — sob `left=30` a cadeia fecha em **1163**.
2. `/ck:spec bug:` p/ §T619 (os 3 pontos acima).
3. Só então `/ck:build T616` (menor) & depois `/ck:build T615`, cada uma com §T618 junto.

### Mapa de edição de §T616, já MEDIDO (p/ a rodada de build não re-descobrir)

- **4 barras** (19 botões: 11+3+2+3): `tabStrip` `WoD20th.lfm:3509` h46→60, 22 rects `top` 8→15,
  11 pares deslocam **+14** (1º `left` 16→30; fim 1149→**1163**) · `numStrip` `WoD20.7:414` &
  `hedgeStrip` `WoD20.7:585` & `vampStrip` `WoD20.11:163` h34→60, rects `top` 2→15, deslocam
  **+24** (1º `left` 6→30). O `<label>` de afinidade da `hedgeStrip` (`210/2/400/30`) anda junto.
- **Lua**: `STRIP_X0 = 16` → `30` (`WoD20th.lfm:372`, dentro de `TAB_W_BEGIN`/`_END`).
- **`CONTENT_GAP`**: os 14 forms têm o filho mais alto em `top=12` ∴ deslocar TODOS os filhos
  de 1º nível **+8** preserva o espaçamento interno exato; gate `:5342` 12 → 20.
- **Deslocamento sob barra**: `WoD20.7` panes `58` → `92` (numStrip acaba em 80, gap 12 mantido) ·
  `WoD20.11` panes `180` → `214` (vampStrip acaba em 210, gap 4 mantido).

---


## ▶ COMECE AQUI — 98ª rodada: **§T613 & §T620 FECHADAS**, §T617 PARCIAL, §T615 BLOQUEADA EM DECISÃO

`/ck:spec` (5 itens do user 2026-08-24) + `/ck:build --all`. A filigrana vitoriana da 97ª
estava **fora do spec**: código no `.lfm`, gate verde, & apagar a chave `ornament` ⊥ acendia
NADA. Esta rodada especificou (§I72 §I73 §V276…§V282 §T613…§T620 §B59 §B60 §R111) & travou
as 4 invariantes da filigrana no gate.

**Estado MEDIDO 2026-08-24 20:36:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **531** `ok`, 0 FAIL |
| gate `-Build` | **VERDE**, **533** `ok` (§V6 exit 0 · §V7 `2091801` → `2091802`) |
| `.rpk` gerado & instalado | **2.091.800 B** nos 2, 20:36:54 / 20:36:55 |
| commitado | **NADA** — working tree suja (`SPEC.md` `WoD20.6.lfm` `verify-hunters-hunted.ps1` `.rpk`) |

### O que a 98ª FECHOU

- **§T613** — braço ADAPTATIVO. `ornArm(w,h) = min(ORN_ARM, floor(min(w,h)/2) - 5)` & o guard
  fixo `min(w,h) < 2*ORN_ARM` SAIU do `ornament()`. `TRUE FAITH` (`WoD20.7.lfm:853`,
  `1270×76`) resolve braço **33** & ganha filigrana — era a ÚNICA das 73 que nascia lisa
  (§B59). Contas & filete que ⊥ cabem em braço curto são DROPADOS um a um; o filete nunca.
  MEDIDO: as 7 caixas de referência desenham dentro de `[0,w]×[0,h]`, 0 `NaN`.
- **§T620** — as 2 âncoras frouxas (§B60). O coletor de §V10/§V28 ganhou `(?<!\w)` ∴ o `t` de
  `format("…")` de 1 argumento ⊥ entra mais como string visível. §V205 passou a ler O QUE
  INDEXA `memo.lists` & O QUE A LEITURA ATRIBUI, ≡ a cura que §V275 já carrega.
  **6 sondas RODADAS**: `format("XYZZY")` → VERDE · `t("XYZZY")` → VERMELHO · renomear `key`
  (declaração + 2 usos) → VERDE · renomear `hit` → VERDE · apagar leitura → VERMELHO ·
  apagar escrita → VERMELHO.
- **§T617 PARCIAL (`~`)** — §V276 §V277 §V278 §V279 estão no gate, **11 sondas RODADAS**
  (9 mutações VERMELHAS + 2 vizinhas VERDES: renomear o local `p` dentro de `ornament()`,
  & `ORN_ARM` 40→30). §V279 lê `ORN_ARM`, o encolhimento & o piso DO LUA & mede contra a
  MENOR caixa do XML ∴ caixa curta nova acende vermelho. **FALTAM** os checks de §V280
  §V281 §V282 — ⊥ podem existir antes de §T615/§T616/§T614 aterrissarem.

### ⛔ §T615 PAROU EM DECISÃO SUA — ⊥ é falta de contexto, é bifurcação ⊥ especificada

MEDIDO: com margem **20** nos 4 lados, **0 das 73 caixas cabe**. TODAS precisam de **+40 de
largura & +20 de altura** — o conteúdo hoje encosta nas 4 bordas (65 das 73 em `0/10/0/10`).
∴ ⊥ ∃ caminho mecânico: ou

- **(A) as caixas CRESCEM** `+40×+20` & os filhos deslocam `+20/+10` — nada de conteúdo é
  re-desenhado, mas a aba mais larga vai de 1280 p/ ~1320+, §V225 (painéis 990×700) &
  §V239 §V240 §V247 recalculam, & as abas que já flertam c/ barra horizontal ganham uma; ou
- **(B) o conteúdo ENCOLHE** — as caixas ficam, & cada linha apertada é re-disposta à mão
  (o picker de 160px numa coluna de 290 vira 120 & corta texto; os 5 dots que fecham em
  `x=1255` na `TRUE FAITH` saem da caixa).

**⊥ escolher por você.** §T618 existe p/ reconciliar, mas ⊥ diz QUAL das duas.

### ⚠ §T616 tem uma colisão declarada, tb sem decisão

§V231 cobra, em LETRA, que **a barra respire MENOS que o conteúdo** (hoje 8 < `CONTENT_GAP`=12,
pedido do user em §I34). O valor novo é **15** ∴ §V231 quebra por construção. 2 saídas:
subir `CONTENT_GAP` 12 → **20** (preserva a relação de §I34 & casa c/ o 20 das caixas) **ou**
revogar §I34 nesse ponto. A 1ª desloca o 1º box das 14 abas de `top=12` p/ `top=20`.

### §T614 segue BLOQUEADA em §R111

Forma do ornamento de pílula (`99×30`) é `?` de TELA: `2*ORN_ARM`=80 ⊥ cabe em 30 de altura
∴ ⊥ é encolher a moldura, é desenhar outra. 3 candidatos em §R111.

### Como retomar em chat novo

1. Leia `SPEC.md` §I72 §I73 §V276…§V282 §T613…§T620 §B59 §B60 §R111.
2. Responda as 2 decisões acima (§T615 A|B · §T616 `CONTENT_GAP` 20 | revogar §I34).
3. `/ck:build T616` (menor) antes de `/ck:build T615`, & §T618 na MESMA rodada de cada uma.
4. §T617 fecha por último, quando §V280/§V281/§V282 já forem verdade.

⚠ Teste de TELA pendente da 97ª/98ª: abrir a ficha no tema `Victorian Era` & conferir
(a) as curvas cúbicas renderizam · (b) `TRUE FAITH` agora ornamentada · (c) os 13 controles
alinhados à esquerda em zona de canto — se a palmeta encostar no texto, encolher p/ ≤14px.

---

## ▶ COMECE AQUI — 97ª rodada: `/ck:spec` (rename de rótulo) + **§T612 FECHADA**

Pedido do user 2026-08-24: `Afiliação Manual` → **`Editar Afiliação`** & `Clã/Família Manual` →
**`Editar Clã/Família`**, os 2 `checkBox` de `STORYTELLER SETTINGS`. Como o EN é a fonte (§V9) & a
CHAVE `.lang` **É** o texto EN, o rename levou junto o par EN — `Edit Affiliation` &
`Edit Clan/Family`, derivados das 2 irmãs da mesma caixa (`Edit Clan Disciplines` /
`Edit Spent XP`), ⊥ inventados. **`chkManual*` & `stManual*` FICAM** (§V2, precedente
`retainers`→`GUIDES`) ∴ §V274 & os 3 sítios do gate (`:7473` `:7525` `:7529`) ⊥ foram tocados.

**Estado MEDIDO 2026-08-24 11:31:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **529** `ok`, 0 FAIL |
| gate `-Build` | **VERDE**, **531** `ok` (§V6 exit 0 · §V7 `2078889` → `2078866`) |
| `.rpk` gerado & instalado | **2.078.866 B** nos 2, 11:31:06 / 11:31:07 |
| commitado | **NADA** — working tree suja |

### O que a 97ª fez

- **`/ck:spec`** — §C ganhou os 6 bullets da 96ª rodada de PEDIDO (a numeração de rodada seguiu de
  95ª p/ 96ª no §C; esta seção do HANDOFF é a 97ª de SESSÃO) · §I66 & §I71 c/ os rótulos novos e
  `⚠ RÓTULO RENOMEADO` · §T610 item (7) passou a citar os nomes novos (ele é teste do user & mandaria
  procurar rótulo que ⊥ ∃ mais) · **§T612** NOVA. **⊥ nasceu §V**: §V10 (chave nos 2 blocos) & §V28
  (∈ mapa `PT`) & §V22 já cobram EXATAMENTE as 3 casas que mudam ∴ meia rodada já acende vermelho, &
  check novo ali ⊥ saberia falhar (§V20). §V16 ⊥ aperta: o [pt] tem o MESMO comprimento (16 & 18 char)
  & o EN ENCOLHE (18 → 16) ∴ `width="375"` intacto.
- **§T612** — 8 substituições, 6 linhas, 3 arquivos: `WoD20.10.lfm:151-152` (`text=`) ·
  `WoD20.6.lfm:169-170` (mapa `PT`, chave **e** valor) · `localization.lang:460-461` [pt] &
  `:1403-1404` [en]. Edição por **node** c/ asserção de contagem em 3 passes (antes / depois /
  ausência do velho) — o heredoc come `\` (§7) & aqui ∃ acento em 6 das 8 strings.
- **MEDIDO depois**: 0 ocorrência de `Manual Affiliation` `Manual Clan/Family` `Afiliação Manual`
  `Clã/Família Manual` no fonte (`.lfm` `.lua` `.lang`, fora de `output/`).

### ⊥ ∃ §T de código aberta (de novo)

As **53** que sobram: teste no Firecast do USER (51) + `T159` (arte) + `T510` (bloqueada em §R93).
**§T610 item (7)** é o teste desta rodada: a caixa do mestre ! mostrar `Editar Afiliação` &
`Editar Clã/Família` em PT & `Edit Affiliation` / `Edit Clan/Family` em EN, & o comportamento das 2
flags ⊥ pode ter mudado.

### ⚠ Os 2 achados da 96ª seguem ABERTOS — os 2 são `/ck:spec bug:`, ⊥ build

1. **§V205 acende sobre RENOME** (`verify-hunters-hunted.ps1:4620`, âncora no identificador `key`).
2. **Escada de version do `module.xml` apodrece calada** (`rdk -p` reescreve o arquivo).

---

## ▶ COMECE AQUI — 96ª rodada: `/ck:spec` (26 edições) + **§T522 & §T611 FECHADAS**

Sequência do dia: `/ck:build T495` (95ª) → `/ck:spec` → `/ck:build --all`. **⊥ ∃ §T de código
aberta.** As 53 que sobram são **teste no Firecast do USER** (51) + `T159` (arte, você) +
`T510` (bloqueada em §R93, seus livros). ⊥ peça `/ck:build --all` esperando trabalho: ⊥ ∃.

**Estado MEDIDO 2026-08-24 11:10:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, **529** `ok`, 0 FAIL |
| gate `-Build` | **VERDE**, **531** `ok` (§V6 exit 0 · §V7 `.rpk` mudou) |
| `.rpk` gerado & instalado | **2.078.889 B** nos 2, 11:10:27 nos 2 |
| commitado | **NADA** — working tree suja |

### O que a 96ª fez

- **`/ck:spec`** — §T: 9 linhas de contabilidade fechadas (`T26` `T29` `T49` `T50` `T289` `T326`
  superseded/cancelado · `T281` `T306` `T314` bumps de version MORTOS: `module.xml` diz
  `<version>1.0</version>` & `rdk -p` reescreve o arquivo). `T114` **⊥ foi fechada** — só tirei a
  cláusula falsa "BLOQUEIA T115"; ela segue teste do user. §I24 4 módulos → **8** halves + regra
  nova do `require` por idioma; §R91 c/ os 8 tamanhos medidos. §I70 aritmética 43→49 vira
  **44→50** (& **50** = entrada de `DESC`, **49** = item de picker — a diferença é `True Faith`).
  §I71 geometria real `12/68/386/24` & `onNodeReady` em `WoD20.11` (ela ⊥ tem `onShow`).
  **§V275** (chave do memo) · **§B58** · **§T611** · §R110 deixou de ser `?`.
- **§T522** — ⊥ teve código: as 6 cláusulas conferidas no artefato (`tabsHH`=0 · `selectTab(name,
  from)` global em `WoD20th.lfm:1609` · 11 botões · `activeTab` em Lua, 0 `field=` / 0 `setField`
  / 0 `sheet.activeTab` · `applyTabVisibility` · `sheetReveal`) & §V226/§V227/§V228/§V229/§V232
  medindo verde. Só a célula estava atrás.
- **§T611** — check de §V275 no gate, ancorado em **o que indexa `memo.lists`**, ⊥ no
  identificador `key`. 4 provas RODADAS: mutação chave-só-raiz → VERMELHO · mutação
  pergunta-mas-responde-com-raiz → VERMELHO · zero-guard `FILTER_NAME` vazia → VERMELHO ·
  sonda renomear o local `key` → §V275 **VERDE**.

### ⚠ 2 ACHADOS ABERTOS — os 2 são `/ck:spec bug:`, ⊥ build

1. **§V205 acende sobre RENOME e é §V222 em letra.** `verify-hunters-hunted.ps1:4620` faz
   `$pkm -notmatch 'hit\s*= memo\.lists\[key\];'` — âncora no IDENTIFICADOR. Renomear o local
   `key` dentro de `pickerItems` ⊥ muda comportamento nenhum & deixa §V205 VERMELHA. Foi a sonda
   de §T611 que pegou. §V222 diz, em letra: "padrão de check que casa identificador ! ter
   fronteira de palavra ou contexto". Cura ≡ a de §V275: ler O QUE INDEXA `memo.lists`.
2. **Escada de version do `module.xml` apodrece calada.** `T281`/`T306`/`T314` pediam
   `2.8`→`2.9`, `3.1`→`3.2`, `3.2`→`3.3` & o arquivo diz `1.0` porque `rdk -p` o REESCREVE.
   Qualquer §T futuro que diga "bump `module.xml`" morre igual. Sem §B ainda.

---

## ▶ COMECE AQUI — 95ª rodada: **§T495 FECHADA**. ⊥ ∃ §T de código aberta

`/ck:build T495` de 2026-08-23 executou o "PLANO PRONTO" que está mais abaixo neste arquivo.
**§T495 está `x` no `SPEC.md` — ⊥ refazer, e ⊥ releia o plano dela como se fosse trabalho.**
O que sobra do §T é teste no Firecast do USER (§T497 · §T565 · §T569 · §T576 · §T580 · §T586 ·
§T590 · §T595 · §T598 · §T603 · §T610) ou está bloqueado no user (`T114` `T159` `T496` `T510`).

**Estado MEDIDO 2026-08-23 23:22:**

| coisa | valor |
|---|---|
| gate estático | **VERDE**, `ALL CHECKS PASSED`, **528** `ok` (eram 527; o +1 é §V210) |
| gate c/ build (`-Build`) | **VERDE**, **530** `ok` (§V6 exit 0, §V7 `.rpk` mudou) |
| `.rpk` gerado & instalado | **2.078.887 B** nos 2, 23:22:44 / 23:22:45 |
| commitado | **NADA** — working tree suja |

**O que §T495 mudou:** os 4 `desc<X>.lua` viraram 8 `desc<X>_{en,pt}.lua` na raiz do plugin
(os 4 monolitos foram APAGADOS); os 5 `require` viram `require("desc<X>_" .. half .. ".lua")`
c/ `half = (lang == "pt") and "pt" or "en"`; §V210 NOVA no gate (mutação (a)/(b) + zero-guard
+ sonda §V222b RODADAS); §V32 §V177 §V178 §V192 §V273 leem os 2 lados por um helper único
(`DescEntries`/`DescMap`); §V198 §V214 §V215 §V266 corrigidos — §V266 e §V215 viravam no-op
calado / zero-guard falso c/ o `require` concatenado (a armadilha que o plano abaixo previu).
`research/rebuild_ritual_desc.sh` emite os 2 e provou round-trip byte a byte.
`daEn`/`daPt` seguem **0 ocorrências**: a cláusula de §V210 sobre eles está armada e quieta.

---

## ▶ COMECE AQUI — 94ª rodada: §T605 · §T606 · §T607 · §T608 · §T609 FECHADAS. **0 §T de código do PEDIDO aberta**

`/ck:build --all` de 2026-08-23 fechou as **5** §T de código que sobravam. **Todas estão `x` no
`SPEC.md`** — ⊥ refazer. O que resta do pedido de 7 itens é **§T610, teste no Firecast do USER**.

**Estado na largada, MEDIDO 2026-08-23 20:02:**

| coisa | valor |
|---|---|
| gate estático (`.\verify-hunters-hunted.ps1`) | **VERDE**, `ALL CHECKS PASSED`, **526** checks (eram 519) |
| gate c/ build (`-Build`) | **VERDE**, **528** checks (§V6 exit 0, §V7 `.rpk` mudou) |
| `.rpk` gerado & instalado | **2.122.016 B**, os 2 tamanhos batendo, 20:02:22 nos 2 |
| commitado | **NADA** — working tree suja em `SPEC.md`, `HANDOFF.md`, 13 `.lfm`, `descNumina.lua`, `localization.lang`, `verify-hunters-hunted.ps1`, `.rpk` |

### Ordem de build — ⊥ ∃ §T de código DO PEDIDO aberta

⚠ **⊥ peça `/ck:build` pelado nem `--all`.** As linhas `.` que sobram no §T são **teste no
Firecast do USER** ou estão bloqueadas há dezenas de rodadas (`T114` `T159` `T495` `T496` `T510`).
Um `--all` começa em `T114` e erra. Se ∃ pedido novo, ele passa por `/ck:spec` **antes**.

**Abertas de teste do user (⊥ são de código):**
**§T565 · §T569 · §T576 · §T580 · §T586 · §T590 · §T595 · §T598 · §T603 · §T610**

### A ÚNICA §T de código que sobra é §T495 — e ela tem 1 armadilha MEDIDA

Varredura do §T inteiro 2026-08-23 20:10: das linhas `.`/`~`, **§T495 é a única que é código e
⊥ depende de nada externo**. As outras são teste no Firecast do user (a esmagadora maioria),
dependem do user (`T114` `T159` `T496` probe · `T159` arte · `T510` bloqueada em §R93 esperando
os livros), ou são contabilidade velha (`T26` `T29` `T49` `T50` `T289` `T326` SUPERSEDED/CANCELADO ·
`T281` `T306` `T314` bumps de `module.xml` das rodadas 31-33 · `T153` `T239` `T421` `T252` probes
já respondidos).

⚠ **§T495 diz "`daEn` vai p/ o `_en`, `daPt` p/ o `_pt`" & `daEn`/`daPt` ⊥ ∃ EM DADO NENHUM.**
MEDIDO: **0** ocorrências nos 4 `desc*.lua`. O que ∃ são os LEITORES — `WoD20.12:51`,
`WoD20.13:50`, `WoD20.14` fazem `local da = (lang == "pt" and entry.daPt) or entry.daEn;` — e esse
ramo cai em nil p/ ∀ entrada hoje. Aqui o spec está À FRENTE do dado, ⊥ atrás: é o texto de Idade
das Trevas que nunca foi encodado. **§V210 (já escrita) ! ser lida ANTES de buildar §T495**, porque
o que ela mede depende de o `daEn`/`daPt` existir ou ⊥.

Tamanhos MEDIDOS, que são o ganho que §T495 persegue (§R92f — metade de ∀ módulo é idioma que a
sessão ⊥ lê): `descRitual.lua` **1.114.194 B** (284 `en` + 284 `pt`) · `descPath.lua` **755.611 B**
(64+64) · `descDisc.lua` **503.281 B** (36+36) · `descNumina.lua` **441.034 B** (50+50, cresceu na
94ª). §R92h segue `?` (se `package.loaded` é por APP ou por FICHA) e quem responde é **§T497**,
teste do user — mas §T495 declara que vale c/ ou sem ele.

## ▶▶ PLANO PRONTO DE §T495 — executar em chat LIMPO com `/ck:build T495`

Levantado 2026-08-23 20:15 numa sessão que ficou sem espaço p/ executar. **⊥ re-derivar nada
disto** — está tudo MEDIDO. Decisão do user: rodar em chat novo.

⚠ `/ck:build` **pelado resolve p/ §T495** — é a única §T de código que sobra (varredura acima).
O skill leria "every `.` row" e começaria em `T114`, que é teste do user. **Peça pelo id.**

### O `daEn`/`daPt` ⊥ BLOQUEIA — resolvido na leitura, ⊥ precisa perguntar ao user

§V210 tem 2 pernas: **(a)** o conjunto de chaves dos 2 arquivos bate 1:1 (nada some na divisão —
restrição do user) & **(b)** ⊥ ∃ `require` de módulo de descrição c/ nome CONSTANTE (o idioma entra
por concatenação). A cláusula "`daEn` no `_en` & `daPt` no `_pt`" diz ONDE essas chaves cairiam;
como são **0** ocorrências em dado nenhum, ela é satisfeita VACUAMENTE. ⊥ ∃ decisão pendente.

### FORMA escolhida — a que muda MENOS (§I24 intacta)

`desc<X>_en.lua` guarda `["Chave"] = { en = [==[…]==] },` e `_pt` guarda `["Chave"] = { pt = [==[…]==] },`.
O wrapper `{ }` FICA de propósito: `pick(tbl, lang)` = `tbl[lang] or tbl.en` e `pickEra(entry, lang)`
(`WoD20.12:40-56` e irmãs) continuam funcionando **sem 1 linha de mudança nos leitores** — muda só
a linha do `require`. Achatar p/ string crua obrigaria a reescrever os 4 renderers, que é trabalho
sem pedido.

### Arquivos — 8 criar · 4 apagar · 5 `require` · 1 script · ~8 sítios de gate

**CRIAR 8**, na RAIZ do plugin ao lado do `module.xml` (§R91: resolve por basename, e a raiz é o
caso PROVADO): `desc{Disc,Numina,Path,Ritual}_{en,pt}.lua`. Os marcadores de gerador MIGRAM
VERBATIM p/ os 2 lados — `DISC_DESC_BEGIN/_END` · `DESC_BEGIN/_END` (numina) · `PATH_DESC_*` ·
`RITUAL_DESC_*` (§I24).

**APAGAR 4** os monolitos. "NADA É REMOVIDO" de §T495/§R92f fala de CONTEÚDO (os 2 idiomas
seguem no `.rpk`), ⊥ dos arquivos velhos — deixá-los é dado morto que ninguém requer (§B55).
Tamanhos de hoje: `descRitual` 1.114.194 B (284+284) · `descPath` 755.611 (64+64) · `descDisc`
503.281 (36+36) · `descNumina` 441.034 (50+50).

**EDITAR 5 `require`** → `require("desc<X>_" .. lang .. ".lua")`, c/ guarda de idioma (`lang` que
⊥ for `"en"`/`"pt"` ! cair p/ `"en"`, senão o `require` estoura), e **DENTRO do corpo do renderer**
— subir p/ o topo do CDATA é §V198 vermelha:

| arquivo | linha | módulo |
|---|---|---|
| `WoD20.7.lfm` | `:82` **e** `:102` (são 2) | `descNumina` |
| `WoD20.12.lfm` | `:96` | `descDisc` |
| `WoD20.13.lfm` | `:91` | `descPath` |
| `WoD20.14.lfm` | `:96` | `descRitual` |

**EDITAR `research/rebuild_ritual_desc.sh`** — `MOD=` está CRAVADO em `descRitual.lua` (`:26`) e
o script lê/reescreve 1 arquivo (`:34-68`). Vira parametrizável e emite os 2 (§T495).

### ⚠ Os ~8 coletores do gate — e 2 armadilhas MEDIDAS

Hoje **todo** coletor casa o par `en = [==[…]==] , pt = [==[…]==]` na MESMA entrada. Com o split
esse par ⊥ ∃ mais num arquivo só ∴ cada um precisa de coletor POR IDIOMA:

| linha | §V | o que lê hoje |
|---|---|---|
| `:1578-1600` | §V32 §V189 | `descNumina.lua` + `$entryRx` pareado |
| `:2232` | §V34 | `$eraRx` = `(daEn\|daPt) = [==[…]==]` |
| `:2237-2239` | §V34 | loop `descDisc`/`descPath`/`descRitual` + marcadores |
| `:4149-4153` | §V177 §V178 §V184 §V192 | `$areaSpec` (File/Module/Marker/Templates) + `$entryRx2` pareado |
| `:4714` | §V214 | os 4 nomes, p/ garantir que ⊥ estão no plugin VELHO |
| `:6825` | §V266 | `require("descNumina.lua")` LITERAL |
| `:7274-7316` | §V273 | `descNumina.lua` + `$rx273` pareado + `-ne 50` |

⚠ **ARMADILHA 1 — §V266 vira no-op CALADO.** `:6825` faz
`$iReq266 = $numFn266.IndexOf('require("descNumina.lua")')` e a perna seguinte é
`elseif ($iReq266 -ge 0 -and …)`. Com o `require` concatenado o `IndexOf` devolve **-1**, a perna
inteira é PULADA e §V266 passa VERDE medindo NADA. É §B7 pela porta de sempre e é EXATAMENTE o que
§V210(b) proíbe no fonte — só que aqui quem crava o literal é o CHECK. ! ser corrigida na MESMA
rodada, e a mutação dela ! ser rodada (§V20).

⚠ **ARMADILHA 2 — §V214 (`:4714`) precisa dos 8 nomes novos**, ⊥ dos 4 velhos: ela mede que os
módulos ⊥ ficaram no plugin ANTIGO. Com os 4 apagados a lista velha passa a ser vacuamente
verdadeira e uma cópia perdida dos 8 novos lá dentro ⊥ acende nada.

### §V210 NOVA — as 2 pernas + as 2 provas de §V222

**(a)** p/ ∀ um dos 4 pares, o conjunto de chaves de `_en` == o de `_pt`, 1:1 · **(b)** ⊥ ∃
`require` de módulo de descrição c/ nome constante em `.lfm` NENHUM. Zero-guard próprio citando
§V209 (parsear 0 entradas = vermelho, ⊥ verde por omissão).
**Mutação (§V20):** tirar 1 chave de um dos lados ! VERMELHO por (a) · voltar 1 `require` p/ nome
literal ! VERMELHO por (b). **Sonda vizinha (§V222b):** mexer em algo que ela ⊥ mede — p.ex.
editar o CORPO de 1 entrada — ! ficar VERDE.

### Verificação, na ordem

```powershell
rdk -l                              # da raiz do plugin
.\verify-hunters-hunted.ps1         # estático
.\verify-hunters-hunted.ps1 -Build  # + §V6/§V7
rdk -i                              # INSTALA (build sem install = tarefa incompleta)
```
Provas de §B1: `.rpk` c/ mtime **e** size novos, e o instalado em
`%APPDATA%\Firecast\Plugins\andreoliveira.styllern.wod20th.rpk` c/ o MESMO size.

### O que §T495 ⊥ resolve

§R92h segue `?` — se `package.loaded` é por APP ou por FICHA ABERTA. Quem responde é **§T497**,
teste do USER. §T495 declara que vale c/ ou sem ele (o ganho é metade do parse de qualquer forma),
mas o TAMANHO do ganho depende dessa resposta.

---

### §T522 está `~` & o código JÁ ESTÁ CONSTRUÍDO — é célula de status, ⊥ build

MEDIDO 2026-08-23 20:10: `tabsHH` = **0** ocorrências nos 15 `.lfm` · `function selectTab` = **1** ·
`TAB_LIST` & `TAB_W` os 2 presentes · **11** controles `btnTab*`. E o gate mede isso VERDE hoje —
§V226 (`all 19 tab buttons are a rectangle over a label`), §V228, §V229, §V232 (`the strip
reflows`), §V227. **⊥ buildar §T522**: ela entra no `/ck:spec` junto c/ os 8 pontos acima, como
9º e 10º itens (o `~` obsoleto e o `daEn`/`daPt` fantasma).

---
---

## ⚠ O que a 94ª mudou e o `SPEC.md` AINDA ⊥ sabe

**Estes 8 pontos são DERIVA DECLARADA, ⊥ bug.** O código está certo e o spec está atrás. Quem
buildar sem ler isto vai "consertar" código correto (§B7 pela porta do spec).

1. **A conta de entradas de `descNumina.lua` é 44 → 50, ⊥ 43 → 49.** §I70 diz, em letra, que
   `True Faith` é entrada como as outras — e depois soma só as 21 hedge + 22 psíquicas. MEDIDO
   antes da rodada: **44** entradas. Depois das 6 de §T607: **50**. O literal **49** vale só p/
   §V78, que conta ITEM DE PICKER (e `True Faith` ⊥ tem picker, §I61). **§V273 foi escrita contra
   o medido: `-ne 50`.** §I70/§T608/§T609 pedem amend na aritmética, ⊥ na regra.
2. **§I71 põe `edtHedgeAffiliation` em `175/68/220/24` & esse retângulo ⊥ ∃ mais.** A 93ª tirou
   `Affiliation` da grade e o combo mora em **`12/68/386/24`** (§I66 amendada no handoff anterior,
   ainda ⊥ escrita). O espelho foi p/ o retângulo REAL, e §V274c mede a IDENTIDADE dos 4 atributos
   entre `cbo*` e `edt*` em vez de um literal — assim a próxima mudança de geometria arrasta os 2.
3. **§I71 manda chamar `renderManualEntry` no `onShow` das 2 abas & `WoD20.11` ⊥ tem `onShow`.**
   Ela tem `onNodeReady` (`:210`), que é o evento que existe e onde `renderMaxDisc`/`renderSubTabs`
   já moram. A chamada entrou ali. `WoD20.7` tem `onShow` e recebeu a chamada normalmente.
4. **§T605 ⊥ previu o memo KEY, só o memo STAMP — e a chave sozinha já quebrava os 2 filtros.**
   `fieldRoot("cbonumina_1")` = `numina`, a MESMA raiz de `cbonumina_2…17` ∴ a linha 1 (filtrada)
   e as 16 (⊥ filtradas) dividiam a chave `numina|` e **quem renderizasse primeiro decidia a lista
   das outras**: linha 1 antes → as 16 herdam a lista podada; as 16 antes → a linha 1 recebe a
   lista inteira e o filtro ⊥ faz nada. Nenhum dos 2 dá erro, os 2 passam em `rdk -l`. Entrou
   `FILTER_NAME[nm]` na chave, ao lado do `mainPath` que já estava lá pelo MESMO motivo. Pede
   perna nova em §V272 + **1 §B**: *"chave de memo por RAIZ ⊥ serve quando 1 linha da raiz filtra
   e as outras ⊥"*.
5. **3 literais de gate que nem §T606 nem §T607 previram** — os 3 são §B7 pela porta de sempre,
   e os 3 foram corrigidos na MESMA rodada:
   - **§V224** contava 8 controles no `DOMINATOR` e o espelho `edtClanFamily` virou o 9º. O check
     aprendeu a pular o gêmeo de espelho, e só enquanto **as 2** condições valem: autorado
     `visible="false"` **e** EXATAMENTE superposto a 1 outro controle. Um `edit` que sair de cima
     do combo volta a contar.
   - **§V111/§V244** tratava `enabled="false"` como só-leitura e cobrava `opacity=0.75` dos 2
     gêmeos. `enabled="false"` só é só-leitura quando o controle está **VISÍVEL**: um autorado
     invisível ⊥ é lido por ninguém, e dimá-lo ficaria errado no instante em que a Lua o revela
     (o revelador escreve `visible`+`enabled` e nunca `opacity`).
   - **§V78** tinha o roster `$hedgeCanon` com 21 nomes → **27**.
6. **`.lang` & mapa `PT` GANHAM as 6 núminas — §T607 ⊥ falava nisso.** O coletor de §V10 põe item
   de picker em `$visible` ∴ nome sem chave = FAIL: foram **24** FAILs até entrarem 6 chaves em
   CADA bloco do `localization.lang` **e** 6 no mapa `PT` de `WoD20.6`. É a MESMA lição do item 2
   do handoff da 93ª, **2ª vez seguida**. As 2 Vias entram como entrada de IDENTIDADE
   (`Via Geniorum` = `Via Geniorum`): latim que o livro ⊥ traduz nem dentro do inglês.
7. **§R110 está RESPONDIDA e a resposta é "⊥ é a mesma".** `Via Necromantiae` (HH2 p. 126) tem
   writeup e tabela próprios — Rituais de *Wakening · Warding · Communication · Expulsion ·
   Vivification* — e ⊥ têm relação com os aspectos de `Necromancy` (M20 Sorcerer p. 39). Ela
   ENTRA: §I69 fica em **6** núminas novas e o literal de §V78 é **49**. §R110 pode virar fato.
8. **§V270…§V274 nasceram com as 2 provas de §V222 RODADAS**, ⊥ só com a mutação:
   - **8 mutações** e as 8 acendem o check certo — `Lone Practitioner`→`Unaligned` (§V270c) ·
     `Healing`→`Herbalism` em `AFFINITY` (§V271b) · carimbo sem `hedgeAffiliation` (§V272b) ·
     `field = string.sub(nm, 4)` cru (§V272c) · página 18→918 (§V273c) · `pág. 20`→`pág. 21` só
     no `pt` (§V273d) · `edtClanFamily` sem `enabled="false"` (§V274c) · linha `c.enabled = show;`
     apagada (§V274d).
   - **5 sondas vizinhas** e as 5 ficam verdes — trocar a ordem de `PICKER_LIST["hedgeAttr"]`
     (§V270) · reordenar os valores de 1 entrada de `AFFINITY` (§V271) · renomear o local `vamp`
     dentro de `pickerItems` (§V272) · editar o CORPO (bloco 3) de 1 entrada (§V273) · trocar a
     ordem das 2 linhas de `checkBox` no XML sem mexer nos `top` (§V274).
   - ⚠ **§V272c nasceu no-op e foi pega pela mutação**: a 1ª versão media `fieldRoot(nm)`, que
     aparece 2× a mais dentro de `pickerItems` (`PICKER_LIST[fieldRoot(nm)]` e `local root =`)
     ∴ passava verde com a linha errada. Hoje ela mede a PERGUNTA (`string.match(nm, "_%d+$")`),
     que é a construção e ⊥ o nome — é §V222 em letra.

---

## O que a 94ª entregou, §T por §T

| §T | escopo | arquivos |
|---|---|---|
| **T605** | os 2 filtros por afiliação: `AFFINITY` (25) + `CASTING_ATTR` (20) na RAIZ · `hedgeAllows` + os 2 ramos de `pickAllowed` · `FILTER_NAME` + `isFilterRow` · `field` por `_<n>`/`fieldRoot` · carimbo `lang\|era\|afiliação` · chave de memo por nome · `renderHedgePickers` · `<dataLink>` | `WoD20th` `WoD20.6` `WoD20.7` |
| **T606** | as 2 flags de mestre: caixa 339→**399** & tudo abaixo −60 · `chkManualAffiliation`/`chkManualClanFamily` · `edtHedgeAffiliation`/`edtClanFamily` autorados escondidos · `renderManualEntry` · 2 `<dataLink>` + 2 eventos · 2 chaves × 2 blocos de `.lang` + mapa `PT` · 2 espelhos declarados · gate `-lt 5`→`-lt 7` (2×) + §V224 + §V111 | `WoD20.10` `WoD20.11` `WoD20.7` `WoD20.6` `localization.lang` gate |
| **T607** | as **6** núminas novas + o texto delas: `PICKER_LIST["numina"]` 21→**27** · 6 entradas `en`+`pt` em `descNumina.lua` JÁ c/ cabeçalho de 3 blocos · 6 chaves × 2 blocos de `.lang` + 6 no mapa `PT` · gate `-eq 43`→`-eq 49` + `$hedgeCanon` 21→27 | `WoD20th` `descNumina.lua` `WoD20.6` `localization.lang` gate |
| **T608** | cabeçalho de 3 blocos nas **44** entradas que já ∃, `en`+`pt`, corpo INTOCADO (só prefixo). Páginas da tabela MEDIDA de §I70 + `True Faith` = HH2 p. 83 | `descNumina.lua` |
| **T609** | gate: **§V270 §V271 §V272 §V273 §V274** novas, ∀ uma c/ zero-guard próprio citando §V209, + as 13 provas de §V222 RODADAS | `verify-hunters-hunted.ps1` |

### Onde as coisas moram agora (achar por NOME, ⊥ por número — §V18)

| o quê | arquivo | linha MEDIDA 2026-08-23 20:02 |
|---|---|---|
| `AFFINITY` / `CASTING_ATTR` | `WoD20th.lfm` | `:285` / `:323` |
| `PICKER_LIST["numina"]` (27) | `WoD20th.lfm` | `:81` |
| `hedgeAllows` / `pickAllowed` | `WoD20th.lfm` | `:3060` / `:3088` |
| `FILTER_NAME` / `isFilterRow` | `WoD20.6.lfm` | `:1045` / `:1059` |
| o `field` de `pickerItems` / o carimbo / a chave | `WoD20.6.lfm` | `:1127` / `:1146` / `:1172` |
| `renderHedgePickers` / `renderManualEntry` | `WoD20.6.lfm` | `:1261` / `:1296` |
| `cboHedgeAffiliation` / `edtHedgeAffiliation` | `WoD20.7.lfm` | `:473` / `:491` |
| `chkManualAffiliation` / `chkManualClanFamily` | `WoD20.10.lfm` | `:151` / `:152` |
| `edtClanFamily` | `WoD20.11.lfm` | `:111` |
| §V270…§V274 | `verify-hunters-hunted.ps1` | `:7046` `:7110` `:7184` `:7257` `:7323` |

### Piso de censo abaixo do real (⊥ é vermelho, é folga)

`$comboSeen -lt 17` e `$arcSeen -lt 328` seguem abaixo do medido. São pisos `-lt` ∴ passam. A
defasagem é ANTERIOR a esta rodada e apertar continua opcional.

### O que §T610 vai testar (leia antes de mexer em qualquer coisa da banda)

⚠ **§T610(1) fala em "caixa de 220px" e a caixa é de 386** desde a 93ª — o combo abre em linha
própria, ABAIXO do rótulo `Affiliation`. O que se testa é o mesmo (nome ⊥ corta); o número é outro.
Os itens **(2)…(4)** testam os filtros de §T605, **(5)…(6)** o cabeçalho de §T607/§T608, e
**(7)…(8)** as flags de §T606.

---

## 93ª rodada (2026-08-23) — §T604 FECHADA. 5 §T de código abertas

`/ck:build T604` de 2026-08-23 fechou: `Affiliation` virou picker de 26 nomes. **§T604 está `x`
no `SPEC.md`** — ⊥ refazer. Sobram **§T605 · §T606 · §T607 · §T608 · §T609** de código.

**Estado na largada, MEDIDO 2026-08-23 18:49:**

| coisa | valor |
|---|---|
| gate estático (`.\verify-hunters-hunted.ps1`) | **VERDE**, `ALL CHECKS PASSED`, **519** checks |
| gate c/ build (`-Build`) | **VERDE**, **521** checks (§V6 exit 0, §V7 `.rpk` mudou) |
| `.rpk` gerado & instalado | **2.087.902 B**, os 2 tamanhos batendo, 18:49:01 / 18:49:02 |
| commitado | **NADA** — working tree suja em `SPEC.md`, `HANDOFF.md`, 12 `.lfm`, `localization.lang`, `verify-hunters-hunted.ps1`, `.rpk` |

### Ordem de build — peça PELO ID, nunca `/ck:build` pelado

⚠ **⊥ peça `/ck:build` pelado nem `--all`.** O skill lê "vazio → every `.` row" e das linhas `.`
do §T a esmagadora maioria é teste no Firecast (do user) ou está bloqueada há dezenas de rodadas
(`T114` `T159` `T495` `T496` `T510`). Um `--all` começa em `T114` e erra.

```
/ck:build T605      # itens 2 & 3 — os 2 filtros por afiliação (ATÔMICA, 5 sítios)
/ck:build T606      # item 7 — as 2 flags de mestre + os 2 espelhos (ATÔMICA, + 2 literais de gate)
/ck:build T607      # itens 4 & 6 — as 6 núminas novas + o texto delas (ATÔMICA, + 1 literal de gate)
/ck:build T608      # item 5 — cabeçalho de 3 blocos nas 43 entradas que já existem
/ck:build T609      # gate — §V270…§V274 novas. RODA DEPOIS de T607 & T608
```

**T605 → T607 → T608 → T609** é ordem obrigatória (T608 põe cabeçalho nas 43 e §V273, que T609
escreve, mede as **49** que T607 cria). **T606 é independente** e pode entrar em qualquer ponto.
`T610` é **teste no Firecast do USER — Claude ⊥ executa**.

---

## ⚠ O que a 93ª mudou e o `SPEC.md` AINDA ⊥ sabe

**Estes 4 pontos são DERIVA DECLARADA, ⊥ bug.** O código está certo e o spec está atrás. Quem
buildar sem ler isto vai "consertar" código correto (§B7 pela porta do spec).

1. **§I66 fixa `220px` no MESMO retângulo do `<edit>` velho & é impossível.** MEDIDO: §V196
   pede **382px** p/ `The Society of Enlightened Altruistic Ideologies (SEAI)`, e a grade de 3
   linhas tem teto de 220 (`410 − 175 − 15`). ⊥ adianta encurtar nome — `Nebuu-Afef, The Order
   of The Golden Fly` (278) e `The Dozen Priests of the Pythian Order` (271) também estouram.
   **Construído** (decisão user 2026-08-23): `Affiliation` saiu da grade e ficou em **1ª** na
   caixa, rótulo em `15/40/150/24` + combo em **`12/68/386/24`**, `name="cboHedgeAffiliation"`.
2. **§T604 diz "`.lang` & mapa `PT` ⊥ ganham nada" & é FALSO.** O coletor de §V10 põe item de
   picker em `$visible` ∴ nome sem chave = FAIL. Foram **72** FAILs até entrarem **24** chaves
   nos 2 blocos do `localization.lang` **e** 24 entradas no mapa `PT` de `WoD20.6`
   (`Followers of Set` & `Giovanni` já existiam, dos clãs). A casa TRADUZ a parte descritiva —
   `O Culto de Ísis`, `Praticante Solitário` — ≡ `Filhos de Osíris` dos clãs (§I17 estava certa
   sobre "nome próprio", errada sobre "⊥ ganha chave").
3. **`ð` (U+00F0): §I66 dizia legal citando §V195, & §V195 diz o OPOSTO em letra.** Contradição
   dentro do próprio spec. **Resolvido no gate** (decisão user): `U+00F0` virou **2ª exceção
   DECLARADA** ao lado de `U+2019`, nos 2 sítios — §V9 (`:570`) e §V24 (`:1289`). O argumento é
   o mesmo que já bancou o `’`: grafia ⊥ é idioma, e `ð` ⊥ existe em português ∴ a porta segue
   fechada contra `á ç ã é`. `Forn Jafnaðr` é a grafia do livro.
4. **A largura custou ALTURA em 9 sítios, ⊥ 1.** §V267a exige as 3 caixas da banda na MESMA
   base ∴ `HEDGE MAGIC` **130 → 158** arrastou `QUINTESSENCE` e `WILLPOWER` junto, com a
   centragem de §V267b recalculada (dots `73 → 87`, bloco de willpower `63 → 77`), `hedgeStrip`
   `142 → 170`, `tabHedgePaths` & `tabHedgeRituals` `188 → 216`, e os 3 sub-painéis
   `tabHedge`/`tabPsychic`/`tabFaith` **660 → 688** (§V262a exige retângulo IDÊNTICO nos 3).
   Tudo dentro do `scrollBox` — a aba de vampiro já usa painéis de 700.

**Pede `/ck:spec amend`**: §I66 (geometria + as 24 chaves), §T604 (mesma coisa),
§V195/§V9/§V24 (a 2ª exceção), §V267/§V262 (os literais 158 e 688) — e **1 §B novo**:
*"§I que fixa lista longa sem passar a lista por §V196 & §V10 nasce impossível de cumprir"*,
que é o que custou esta rodada.

### Por que `Affiliation` ficou em PRIMEIRO (⊥ é gosto, é §V258)

§V258 reprova campo opaco que fica a **<14px** da lateral **e** <14px do fundo — é a mordida
`14x14` do `cornerType="innerRound"`. §V240 crava o vão de baixo em **10** ∴ a linha de baixo
NUNCA tem os 14 de folga vertical, e um combo de 386 a `x=12` ali é vermelho nos 2 cantos.
Na 1ª posição o vão de baixo é 66 e a regra nem morde. Bônus: é a ordem certa mesmo — é o campo
que §T605 vai usar p/ filtrar os outros dois.

---

## ⚠ Coordenadas de linha que MUDARAM na 93ª (o `SPEC.md` cita as VELHAS)

As inserções desta rodada empurraram tudo p/ baixo. **§T605 cita `WoD20.6.lfm:1072` e `:1082` e
`WoD20th.lfm:2943` — os 3 estão errados agora.** Achar por NOME, ⊥ por número (é a lição de §V18):

| o quê | §T605/SPEC diz | MEDIDO 2026-08-23 |
|---|---|---|
| `pickerItems` — a linha do `field` | `WoD20.6.lfm:1072` | **`WoD20.6.lfm:1096`** |
| o carimbo do memo (`local stamp = …`) | `WoD20.6.lfm:1082` | **`WoD20.6.lfm:1105`** |
| `pickAllowed` | `WoD20th.lfm:2943` | **`WoD20th.lfm:2965`** |
| `fieldRoot` | `WoD20.6.lfm:1028` | **`WoD20.6.lfm:1052`** |
| `FILTER_ROW` / `isFilterRow` | — | **`:1023`** / **`:1037`** |
| `PICKER_LIST_END` | `WoD20th.lfm:215` | **`WoD20th.lfm:237`** |
| §T606: `$stChecks.Count -lt 5` (2×) | `:5310` & `:5324` | **`:5313`** & **`:5327`** |
| §T607: `$total -eq 43` | `:1670` | **`:1673`** |

---

## Armadilhas das §T que sobraram — leia a §T antes de codar

1. **T605 é atômica de verdade.** Tabela sem ramo em `pickAllowed` é dado morto (§B55); ramo sem
   o carimbo do memo serve **lista velha** com `rdk -l` exit 0 e gate verde (§B48 é esse mesmo
   memo, uma lição atrás). São **5** sítios: `AFFINITY`+`CASTING_ATTR` na raiz, `pickAllowed`,
   `FILTER_NAME`+`isFilterRow`, o `field` de `pickerItems` e o carimbo, mais o `<dataLink>` em
   `WoD20.7`. ⚠ o `<dataLink field="hedgeAffiliation" onChange="renderHedgePickers(self);"/>`
   vai na caixa `HEDGE MAGIC`, que agora abre em `WoD20.7.lfm:447` e o combo mora em `:473`.
2. **O `field` de `pickerItems` MENTE para singleton.** Hoje é `string.sub(nm,4)`, que devolve
   `HedgeAttr` (H maiúsculo) para `cboHedgeAttr` ∴ `sheet[field]` = nil e §V200 solta o valor
   guardado **sem sintoma nenhum**. §I68 dá a conta certa. ⚠ vale p/ `cboHedgeAffiliation`
   também, que é singleton pelo mesmo motivo.
3. **3 literais de gate mudam em rodadas DIFERENTES** (§B7): `-lt 5` → `-lt 7` nos **2** sítios
   vai com **T606**; `-eq 43` → `-eq 49` vai com **T607**. **T609 ⊥ toca nesses três** — ela só
   acrescenta §V270…§V274.
4. **T607 é atômica com o texto.** §V32 cobra entrada `DESC` para ∀ item das listas `numina`/
   `psychic` ∴ crescer `PICKER_LIST["numina"]` sem escrever as 6 entradas em `descNumina.lua`
   reprova no mesmo passo.
5. **§R110 é um `?` vivo e é T607 quem o responde.** Se, ao transcrever, `Via Necromantiae` (HH2
   p. 126) for `Necromancy` (M20 Sorcerer p. 39) com verniz cristão, ela vira rótulo e ⊥ entrada:
   §I69 cai de 6 para 5 núminas novas e o literal de §V78 vira 48, não 49. **Ler antes de escrever.**
6. **§V223** vale em T605 e T606: função nova declarada ACIMA de quem ela chama compila
   `GETGLOBAL` e acha `nil` — é §B51.
7. **⊥ mexer em `PICKER_LIST["hedgeAffiliation"]`** — ela é da 93ª e está fechada. T605 lê a
   lista, ⊥ a reescreve.

### Piso de censo abaixo do real (⊥ é vermelho, é folga p/ T609 se quiser apertar)

`$comboSeen -lt 17` (`:1443`) com **20** pickers medidos hoje, e `$arcSeen -lt 328` (`:6346`) com
**369**. São pisos `-lt` ∴ passam. A defasagem é ANTERIOR a esta rodada (a 93ª só somou 1 a cada).
Apertar é opcional e cabe em §T609.

### 2 desvios do pedido literal, os dois com citação de livro (§R106)

O user pediu "as 8 númina faltantes"; **medido nos livros são 6**. Caem:

- **`Herbalism`** — o próprio `M20 Sorcerer` p. 18 tem o box `What Happened to Herbalism?` dizendo
  que ela foi **fundida na Path of Alchemy** e assim permanece ∴ ⊥ é path do cânone corrente. As 3
  afiliações que a listam como Favored Path mapeiam para `Alchemy` (§I67, normalização).
- **`Telekinesis`** (HH2 p. 82) — `M20 Sorcerer` p. 70 **abre** `Psychokinesis` dizendo que é
  telekinesis para alguns ∴ mesmo poder, e a entrada que já existe vence pela precedência de §I69.
  (Mesma coisa com `Animal Psi`/`Anti-Psi` de HH2 pp. 134-135 = `Animal Psychics`/`Anti-Psychic`.)

Os 3 livros ficam em `…\RPG\Storyteller V20\Hunted Hunters\` — `Sorcerer\M20 Sorcerer.pdf`,
`Sorcerer\Sorcerer_s_Companion.pdf` e `TheHuntersHunted_II_Revised_ (2).pdf`. Offsets de página
e o comando de extração estão em **§R109** (⚠ para cabeçalho de path o extrator útil é
`pdftotext` **SEM** `-layout` — o inverso da armadilha 1 de `research/README.md`).

### Abertas de teste do user (⊥ são de código)

**§T565 · §T569 · §T576 · §T580 · §T586 · §T590 · §T595 · §T598 · §T603 · §T610**

⚠ **§T610(1) mudou de forma com a 93ª**: o teste diz "nenhum nome corta na caixa de **220px**".
A caixa agora é de **386px** e o combo abre em linha própria, ABAIXO do rótulo `Affiliation`.
O que se testa é o mesmo (nome ⊥ corta); o número é outro.

---

## 92ª rodada (2026-08-23) — SPEC ESCRITO, código NÃO

`/ck:spec` do pedido user de 7 itens sobre os 3 livros de sorcerer/hunter fechou. **Nada de
código foi tocado nessa rodada** — só `SPEC.md`. O que entrou:

| seção | ids novos | assunto |
|---|---|---|
| §I | **§I66 · §I67 · §I68 · §I69 · §I70 · §I71** | os 7 itens do pedido (4 & 6 moram juntos em §I69) |
| §V | **§V270 · §V271 · §V272 · §V273 · §V274** | as invariantes que amarram os 7 |
| §R | **§R105 · §R106 · §R107 · §R108 · §R109 · §R110** | o que os 3 livros dizem, com página |
| §T | **§T604 · §T605 · §T606 · §T607 · §T608 · §T609 · §T610** | o trabalho, em 6 tarefas + 1 teste do user |

Estado no fim dela: gate verde com **517** checks, `.rpk` **2.082.777 B** instalado 13:22.

---

## 90ª rodada (2026-08-23) — §T591 · §T592 · §T593 · §T594 FECHADAS

A **90ª rodada** (as 3 sub-abas de `Numina`) fechou: **§T591 · §T592 · §T593 · §T594** marcadas `x`.
Sobra **§T595**, que é **teste no Firecast do USER — Claude ⊥ executa**.

Estado na largada: **gate VERDE** (`ALL CHECKS PASSED`, **510** checks — eram 486), `.rpk`
**2.048.766 B** gerado e instalado 2026-08-23 03:37 (tamanhos batendo), **nada commitado**.
Abertas de teste do user: **§T565 · §T569 · §T576 · §T580 · §T586 · §T590 · §T595**.

⚠ **⊥ peça `/ck:build` pelado nem `--all`.** O skill lê "vazio → every `.` row" e das linhas `.`
do §T a esmagadora maioria é teste no Firecast (do user) ou está bloqueada há dezenas de rodadas
(`T114` `T159` `T495` `T496` `T510`). Um `--all` começa em `T114` e erra. **Peça pelo id.**

### O que a 90ª entregou (pedido user 2026-08-23, 6 itens — §I58…§I61)

`WoD20.7` deixou de ser 1 página e virou **3 sub-abas** na forma que §I32 deu à Ghoul: barra
própria (`numStrip`, `0/12/1280/34`) sobre 3 painéis absolutos empilhados num retângulo só
(`tabHedge` · `tabPsychic` · `tabFaith`, os 3 em `0/58/1280/660`). **⊥ nasceram arquivos novos** —
os 4 de vampiro foram partidos porque a descrição era 397 KB de `.lfm` e desde §I24 o livro mora
em `descNumina.lua`.

| §T | escopo | arquivos |
|---|---|---|
| **T591** | casca + `Psychic Phenomena` inteiro (24 linhas, 19 picker + 5 digitadas) · `psychicSel` novo · 3 blocos de descrição · `renderSubTabs` genérico | `WoD20.7` `WoD20th` `WoD20.11` `WoD20.6` `localization.lang` gate |
| **T592** | `Hedge Magic`: caixas `HEDGE MAGIC` + `QUINTESSENCE` · lista 10→17 (12 picker + 5 digitadas) | `WoD20.7` `WoD20th` `WoD20.6` `localization.lang` gate |
| **T593** | `True Faith`: `cboFaith` → `<edit>` · `PICKER_LIST["faith"]` SAI | `WoD20.7` `WoD20th` gate |
| **T594** | gate: §V262 §V263 §V264 §V265 novas, as 8 provas de §V222 RODADAS | `verify-hunters-hunted.ps1` |

**Números que o user vai ver**: `NUMINA_ROWS`=**17** / `NUMINA_FREE_ROWS`=**5** ·
`PSYCHIC_ROWS`=**24** / `PSYCHIC_FREE_ROWS`=**5** · `quint_1`…`_10` bolinhas LIVRES ·
campos novos `hedgeEssence` `hedgeAffiliation` `hedgeAttr` `psychicSel`.

⚠ **CONSEQUÊNCIA DECLARADA que o user ! ver no teste**: `numina_9`/`_10` e `psychic_9`/`_10` eram
TEXTO LIVRE e viraram PICKER. Ficha salva com homebrew digitado nelas mantém o dado no NDB, mas o
combo abre VAZIO (valor ∉ `values`, §V12). ⊥ ∃ migração. `numina_11` VOLTA a existir — foi removido
a pedido do user em 2026-08-17.

### ⚠ Deriva SPEC ↔ código que esta rodada criou (pede `/ck:spec amend`, ⊥ é bug)

1. **§I59/§I60 dizem `<NuminaFree>` para as linhas digitadas das DUAS caixas & são 2 templates**:
   `NuminaFree` (hedge, `numinaSel`) e **`PsychicFree`** (psíquica, `psychicSel`). Motivo MEDIDO no
   coletor do gate (`:196-248`): `field`/`fieldValue` são EXPANDIDOS a partir da chamada do template
   e **`groupName` é lido CRU** ∴ um `field="$(sel)"` parametrizado chegaria a §V30 sem resolver e
   deixaria de ser mensurável. Os 4 templates dividem o mesmo x (§V26).
2. **§T591 listou 6 sítios de gate & foram 10**: entraram **§V111/§V244** (`$DESC_BRIGHT` era uma
   lista NOMEADA com `edtNuminaDesc`, que virou 3 painéis), **§V176** (o roster de seletores ganhou
   `psychicSel` & deixou de ser "1 grupo por bloco `DESCRIPTION`" — o de fé tem bloco e ⊥ tem
   grupo), **§V227** (`activeVampTab` virou `SUB_TABS`) e **§V32** (media "todo `cbo*` menos
   `cboFaith`", exclusão por NOME, & pediu entrada de livro para `Strength` quando o picker de
   atributo entrou — agora nomeia o que está DENTRO do escopo: as listas `numina` & `psychic`).
3. **§I61 põe a reescrita de §V50 em §T593 & ela caiu em §T591**: quem matou o mecanismo que §V50
   media (o ramo `selected == "faith"`) foi a casca, ⊥ a troca de widget. Sobrou de §V50 a única
   perna que sobrevive ao mecanismo — `DESC['True Faith']` ! existir — e §V265 cobre o resto.
4. **§I58 diz que o custo de §V206 é "parsear sempre ao MOSTRAR a aba"** e é o que foi construído:
   `faithText` ⊥ tem early-return porque ⊥ ∃ seleção. `onShow` segue sendo o gatilho ∴ abrir a
   FICHA ⊥ parseia nada (o que §B47 comprou de verdade).

---

## ⚠ 88ª rodada (2026-08-23) — §T577 · §T578 · §T579 FECHADAS

### O que a 88ª pede, em 3 §T

| §T | escopo | arquivos |
|---|---|---|
| **T577** | caixa Storyteller re-ordenada **&** antecedente vira PREÇO — XML + Lua + `.lang` + 3 literais de gate, **atômica** | `WoD20.10` `WoD20th` `WoD20.6` `localization.lang` `verify-hunters-hunted.ps1` |
| **T578** | `cmb*` traduz os próprios itens (conserto de §B57) | `WoD20.10` `WoD20th` `WoD20.6` |
| **T579** | gate: §V257 nova + §V254 reapontada | `verify-hunters-hunted.ps1` |

**Leia §I51 · §I52 · §V254 · §V257 · §B57 no `SPEC.md`** — eles carregam os números. O resumo
operacional abaixo é âncora, ⊥ substituto.

#### T577 — os números (§I51)

`WoD20.10.lfm`, caixa `STORYTELLER SETTINGS` (`left=820 width=405 height=339`, ⊥ muda de tamanho):

- ordem NOVA por `top`: `chkShowNumina` **46** · `chkShowDisciplines` **76** · `chkFreeBuy` **106**
  · `chkEditClanDisc` **136** · `chkEditSpentXP` **166** · `Health Levels` **204** (label; combo **201**)
  · `Specialty Cost` **234** (label; combo **231**) · `Background Cost` **264** (label; combo **261**)
  · `Save Initial Character` **306** (botão **303**, INTACTO);
- ⚠ o label fica 3px acima do combo — é o padrão que `Health Levels` já usa (`label top`/`combo top`
  = 264/261 hoje). Mantenha o par;
- `chkBackgroundsXP` (`:119`) **SAI**; entram `<label left="15" width="170" text="Background Cost">`
  + `<comboBox name="cmbBgCost" left="190" width="150" height="25" field="stBackgroundCost"` com
  `items`=`values`=`{'0','1','2','3','4','5'}` + `<dataLink field="stBackgroundCost" defaultValue="0"/>`;
- os **3** combos a `width="150"` na coluna `left="190"` ∴ `cmbHealthLevels` (`:161`) 58→**150**;
- RAIZ (`WoD20th.lfm`): `backgroundsXP = sheet.stBackgroundsXP == true,` (`:1934`) →
  `backgroundCost = tonumber(sheet.stBackgroundCost) or 0,` · no ramo `if kind == "Background" then`
  (`:1620`) a linha `if not ctx.backgroundsXP then return 0; end;` (`:1624`) **SAI** e o preço vira
  `from × v` com `from=0` → `v` (⊥ existe mais ramo especial: `v`=0 devolve 0 pela aritmética);
- `.lang` (os **2** blocos) **&** mapa `PT` de `WoD20.6`: ENTRA `Background Cost`=`Custo por Antecedente`,
  SAI `Can Buy Backgrounds With Experience`.

⚠ **3 sítios de gate na MESMA rodada, senão ele reprova código certo (§B7)**:
`$wantFlags` (`:2526`) troca `stBackgroundsXP`→`stBackgroundCost` · §V238 mede `$stChecks.Count -lt 6`
em **2** lugares (`:5217` e `:5231`) e a caixa passa a ter **5** `checkBox` → vira `-lt 5` ·
§V243 já mede x DISTINTO de toda entrada (3 combos + botão a 190), ⊥ precisa tocar.

#### T578 — a tradução (§I52, §B57)

- `cmbSpecCost`: `values` `forbidden` → **`Purchase Forbidden`** (o item já é esse texto) **&**
  `local SPEC_FORBIDDEN = "forbidden";` (`WoD20th.lfm:1598`) → `"Purchase Forbidden"`. **Os 2 no mesmo
  passo** ou a porta nunca lê como fechada (§V12);
- `["Purchase Forbidden"] = "Compra Proibida",` entra no mapa `PT` de `WoD20.6` (é ELE que o ramo lê);
- `applyLanguage` (`WoD20.6.lfm`, ramo `elseif cls == "comboBox" then` em `:1211`) ganha, ao lado de
  `pickerItems(...)`, uma chamada que trata `cmb*`: `items[i] = PT[values[i]] or values[i]`, **`values`
  ⊥ é escrito** (§V22). O ramo é **POR PREFIXO** (`string.sub(nm,1,3) == "cmb"`), nunca por nome — nome
  faria o 3º combo de valor nascer mudo, que é exatamente §B57 de novo;
- por que `pickerItems` ⊥ serve: ele abre com `if ... ~= "cbo" then return; end;` (`WoD20.6.lfm:1045`);
- ⚠ **§V223**: se escrever a função nova ACIMA de `PT`/de quem ela chama, o corpo compila `GETGLOBAL`
  e acha `nil` — é §B51. Declare abaixo, ou confira antes de rodar o gate.

⚠ **PONTA VIVA, decida antes de codar**: ficha que o user já salvou com `Compra Proibida` guarda o
literal **`forbidden`**. Depois de T578 esse valor ⊥ está mais na lista (combo renderiza VAZIO, §V200)
e `specForbidden()` responde **false** ∴ a porta que estava FECHADA abre sozinha a preço 3. Cura de 1
linha, e é JULGAMENTO a confirmar com o user: aceitar o literal velho como fechado também
(`v == SPEC_FORBIDDEN or v == "forbidden"`). ⊥ está no `SPEC.md` — se for adotada, é `/ck:spec`.

#### T579 — gate (§V257 nova, §V254 reapontada)

§V257 tem 4 pernas e **5 provas RODADAS** (4 mutações + 1 sonda) — a lista está na própria §V257.
Zero-guard próprio: 0 `cmb*` lido ! VERMELHO citando §V209. §V254 já mede o value sob o item de
prosa (⊥ o último da lista) ∴ ela acompanha o value novo sozinha; confira que segue verde e que a
perna (d) passa a cobrar **os 2 eixos** (`.lang` **&** mapa `PT`).

### Como rodar (idêntico para toda §T)

```bash
# gate: a saída são ~480 linhas 'ok' e afoga o contexto — mande p/ arquivo
powershell.exe -NoProfile -Command "& '.\verify-hunters-hunted.ps1' *>&1 | Out-File -FilePath '<tmp>/g.txt' -Encoding utf8; exit \$LASTEXITCODE"
grep -E "FAIL|ALL CHECKS" '<tmp>/g.txt'

# build + install (da raiz do plugin)
"$LOCALAPPDATA/FirecastSDK3/rdk.exe" -l     # compila + lint  -> output/*.rpk
"$LOCALAPPDATA/FirecastSDK3/rdk.exe" -i     # compila + INSTALA
```

- **`rdk -l` ANTES de marcar cada §T**: o gate ⊥ roda Lua, e um `end;` a menos passa por 480 checks
  e morre no rdk, que sai **1 SEM MENSAGEM e APAGA o `.rpk`** (§B19);
- terminar a rodada com `rdk -i` e provar: `%APPDATA%\Firecast\Plugins\andreoliveira.styllern.wod20th.rpk`
  com o **mesmo size** do `.rpk` recém-gerado e mtime da hora;
- **⊥ commitar** — regra do projeto vence o skill (`CLAUDE.md`). Terminar com §T marcada, gate verde,
  `.rpk` instalado e tudo no working tree.

### Armadilhas que custaram tempo REAL nesta sessão

1. **node: leu `latin1`, grave `latin1`.** `readFileSync(f,"latin1")` + `writeFileSync(f,s)` **sem** o
   encoding grava UTF-8 por cima de bytes que já eram UTF-8 → duplo-encoding silencioso (aconteceu em
   `WoD20.11.lfm`, 3 linhas de comentário). Cura exata: reler `"utf8"`, regravar `"latin1"`.
   Alternativa mais segura: ler **e** gravar `"utf8"` e escrever os padrões com os glifos de verdade.
2. **`node -e '...'` come `\\`**: `\\d` chega como `\d` e o JS o engole → regex vira `(d+)`. Para
   qualquer script com regex ou acento, **escreva o arquivo com a ferramenta `Write`** e rode
   `node arquivo.js`. Nunca conte com escape sobrevivendo ao heredoc/`-e`.
3. **⊥ ∃ Python** nesta máquina. ∃ `node` v24.
4. O gate é **ASCII puro + LF**: `if (/[^\x00-\x7f]/.test(s)) throw` antes de gravar salvou 3 vezes.
5. Comentário XML **DENTRO de `<template>`** mata o build sem mensagem (§B19, 5ª porta). Comentário
   ANTES do `<template>` é seguro.

### Deriva SPEC ↔ código herdada da 87ª (pede `/ck:spec amend`, ⊥ é bug)

1. **§V243** diz "as 2 ÚNICAS entradas ⊥-`checkBox`" e são **3** (o check já foi ampliado p/ contar x
   distintos de todas — depois de T577 são 4 widgets na coluna);
2. **§T570** diz "3 sítios de gate" e foram **5** (entraram §V238 e §V243);
3. **§V147**: os 3 laços de range cheio agora são `declareTrait` · ledger · `freeRowOf` (a mensagem
   velha citava o `grant`, que passou a parar antes).

---

## ⚠ 86ª & 87ª rodadas (2026-08-22) — §T566…§T575 FECHADAS, gate verde, `.rpk` instalado

`.rpk` **2.004.830 B**, instalado 23:25 com o mesmo tamanho (§B1: exit 0 sozinho ⊥ prova).
Gate **verde** (`ALL CHECKS PASSED`, ~480 checks) & `rdk -l` exit 0 antes de cada §T.
Abertas: **§T569** & **§T576** — teste no Firecast, do USER. **Nada commitado.**

### A 86ª: a régua da aba Ghoul DESCE (§T566 §T567 §T568)

Pedido user: blood pool −30% · coluna Rituals no mínimo · as 3 `DESCRIPTION` fechando junto.

- régua **1385 → 1235**: `BLOOD POOL` 500→**350** (`left` 885 intacto, as 20 bolinhas −75 em x,
  vão 36/36) · `WoD20.12` 1025→**875** · `WoD20.13` 850→**700** · `WoD20.14` 865→**745** c/ `left`
  520→**490**. Os 4 arquivos fecham em 1235 & §V225(b) mede isso numa passada;
- coluna `RITUALS` 510→**480** & o combo 460→**430** — é o PISO, ⊥ escolha: o item PT mais longo
  é `5. Círculos de Proteção contra Espíritos, Fantasmas e Demônios` (**62** char) & a régua da
  casa (`ceil(char×6,5)+24`) pede **427**. `?` em aberto (§R102): a régua ⊥ conhece TAMANHO de
  fonte & o picker roda `fontSize="12"` ∴ pode sobrar ~60px que só a tela mostra;
- `vampStrip` & os 3 painéis 1395→**1245** (régua + 10, §R94) ∴ a aba Ghoul deixa de exigir
  1395px de janela. O ponto mais largo da ficha volta a ser a **Traits (1370)**.

⚠ **§B56 — §V196 media 5 dos 17 combo & ZERO dos 5 de vampiro.** O XPath era
`//comboBox[@items][@width]` & §T493 (68ª) tinha tirado `items=` justo desses ∴ sumiram da conta
os itens mais longos da ficha (284 rituais, 64 trilhas). §V209(f) PREVIU isso na 68ª & mandou
trocar o count-guard por guard de CONTEÚDO; §T494 ⊥ construiu & 18 rodadas de verde passaram por
cima. `ListOf()` (`:97`) existia p/ isso desde a 68ª c/ **0 chamadas**. Agora §V196 lê por
`ListOf` & tem 2 zero-guards: `< 17` combo medidos **ou** `< 4` linhas de vampiro ! VERMELHO.

### A 87ª: 5 mudanças (§T570…§T575)

- **§T570 — preço de especialidade virou 1 VALOR (§I49, §V254).** Saíram `chkSpec3XP`/`chkSpec4XP`
  + os 2 `dataLink` de exclusão + as 2 chaves `.lang` + as 2 do mapa `PT`; entrou
  `Specialty Cost` + `cmbSpecCost` (`0`…`5` + `Purchase Forbidden`, `values` … `forbidden`,
  `defaultValue="3"`). Caixa **540→405** & tudo abaixo −30, `height` 369→**339**.
  ⚠ **`0` agora é PREÇO** (especialidade de graça) ∴ a recusa virou `specForbidden()` — a
  pergunta velha era `specCost() == 0` & mantê-la faria escolher `0` RECUSAR a compra. Os 2
  campos velhos são ÓRFÃOS (§V2) & `stSpecCost` é o único que a caixa escreve.
  ⚠ **MUDANÇA DE DEFAULT declarada**: antes ninguém comprava especialidade sem o mestre ligar
  flag; agora o default é `3` = compra LIBERADA. Ficha velha (campo `nil`) cai no 3 pelo fallback.
- **§T571/§T572 — texto livre em SPECIALTIES & BACKGROUNDS (§I50, §V255).** Templates
  `SpecialityFreeRow` (linhas 7-9) & `OpenAbilityFreeRow` (16-20), constantes
  `SPECIALITY_FREE_ROWS`=3 & `BACKGROUND_FREE_ROWS`=5, & as 2 chaves NOVAS em `TYPED_ROW_FROM`
  (`speciality` & `background`) ∴ `isTypedRow` responde por elas.
  ⚠ `renderSpecialities` **&** a busca de slot de `grantSpeciality` param em `total − livres`: o
  presente do traço é travado pelo `enabled` do COMBO & linha digitada ⊥ tem combo p/ travar.
  `freeRowOf` segue varrendo as 9 (o carimbo é que decide) ∴ sobraram **3** laços de range cheio,
  que é o piso de §V147.
- **§T573 — fundo escuro sob `edtTotalXP` & `edtSpentXP` (§V256, §R103).** `gui.Edit` **⊥ tem**
  prop de cor de fundo (MEDIDO no SDK) ∴ é `<rectangle>` ANTES do `edit` + `transparent="true"`
  NELE + chave `#0A0A0A` nas **4** paletas. `edtCurrentXP` ⊥ ganhou — é o campo que o jogador
  digita, & cue de trava em campo destravado é decoração. `<edit transparent>` ⊥ tem precedente
  no sheet ∴ **`?` de tela**: se a moldura sumir junto, a decisão é do user (§R103 b).
- **§T574 — `Caitiff`** entrou em `PICKER_LIST["clan"]`, em `CLANS` como `{ open = 3 }` (byte a
  byte a de `Panders`), no mapa `PT` & nos 2 blocos do `.lang`. Roster **60 → 61** & os **3**
  literais `60` do check de §V236 viraram 61.
- **§T575 — §V254 §V255 §V256 no gate**, cada uma c/ zero-guard próprio & as **2 provas de
  §V222 RODADAS** (3 mutações acenderam o check certo, 3 sondas ficaram verdes).

### ⚠ Deriva SPEC ↔ código que esta rodada criou (pede `/ck:spec amend`)

1. **§T570 diz "3 sítios de gate" & são 5**: `$wantFlags` de §V89 · o bloco de §V155 (removido) ·
   §V154 (reescrito) · **§V238** (o censo era `< 7` checkBox & a caixa tem 6 agora) · **§V243**.
2. **§V243 está desatualizada no texto**: ela diz "as 2 ÚNICAS entradas ⊥-`checkBox` da caixa" &
   agora são **3** (`cmbSpecCost` entrou). O CHECK foi ampliado p/ contar x DISTINTOS de ∀ entrada
   da caixa (+ zero-guard), ⊥ p/ nomear um par — mas o texto do §V ainda fala em 2.
3. **§V147 mudou de mensagem**: os 3 laços de range cheio agora são `declareTrait` · ledger ·
   `freeRowOf` (a mensagem velha citava "the grant looking for a free slot", que agora para antes).
4. §V204/§V248 ganharam a coluna **`Attr`** no `$rowSpec`: `SPECIALTIES` chama o template por
   `num=`, ⊥ por `field=` ∴ o censo pergunta a mesma coisa nos 2 formatos.

### ⚠ Armadilha de ferramenta NOVA (custou 1 arquivo corrompido)

`fs.readFileSync(f,"latin1")` + `fs.writeFileSync(f, s)` **sem o `"latin1"` na escrita** grava
UTF-8 por cima de bytes que já eram UTF-8 ∴ **duplo-encoding silencioso**. Aconteceu em
`WoD20.11.lfm` (3 linhas de comentário c/ `─┬─ → └─`) & o gate ⊥ pegou — XML segue válido.
A cura é exata & reversível: reler `"utf8"` & regravar `"latin1"`. **Escreva SEMPRE os 2 lados.**
Some a isso a armadilha que já estava no §7: `\\d` dentro de `node -e '...'` chega como `\d` &
o JS o come — use a ferramenta `Write` p/ scripts com regex, ⊥ `node -e`.

---

## ⚠ 85ª rodada (2026-08-22) — §T554…§T564 FECHADAS, gate verde, `.rpk` instalado

Pedido user de 9 itens → §I42…§I47 · §V243…§V253 · §T554…§T565. Só **§T565** ficou aberta
(teste no Firecast, do USER — responde §R100 & §R101). **Nada commitado.**

⚠ **ACHADO DE TOOLCHAIN — 5ª porta p/ a assinatura do §B19**: **comentário XML DENTRO de
`<template>` faz `rdk -l` sair 1 SEM MENSAGEM & APAGAR o `.rpk`.** MEDIDO nos 2 sentidos: o
MESMO texto compila fora do `<template>` & mata o build 11 linhas abaixo, dentro dele. O sheet
tem **26** templates & nenhum tinha comentário — por isso ninguém tinha batido nisso.
Custou um bisect de 7 arquivos × 6 variantes; o `.rpk` INSTALADO (`%APPDATA%\Firecast\Plugins\`)
serviu de baseline bom, porque o `git HEAD` está rodadas atrás. **⊥ ∃ check estático disso** —
o parser do gate (`System.Xml`) aceita o arquivo de boa. **PENDENTE de `/ck:spec bug:`** (o
`/ck:build` ⊥ escreve seção): §B novo + §V que conte `<!--` dentro de `<template>` nos 15 `.lfm`.

⚠ **`isFreeRow` JÁ EXISTIA** (carimbo de especialidade grátis, §V160) & o global novo de mesmo
nome o sobrescrevia em SILÊNCIO — o gate pegou na 1ª rodada. O helper das linhas digitadas
chama-se **`isTypedRow`** & o mapa **`TYPED_ROW_FROM`**. As CONSTANTES seguem `*_FREE_ROWS`
como §V248 as nomeia ∴ `DISC_FREE_ROWS` (digitada) convive c/ `isFreeRow` (grátis) no mesmo
arquivo. Candidato a `/ck:spec amend`: renomear p/ `*_TYPED_ROWS` & tirar a armadilha.

⚠ §I44 pedia `Level` **80** & margem direita 18; §V247 pede `width` = borda do `Cost` + **16**.
Ficou pela RELAÇÃO (§V247): `Level` **82** · `Cost` `left` **440** · as 2 caixas **501**. §I44
está 2px atrás do código nesse número.

Reescrito 2026-08-22, fim da **81ª rodada**. Para um Claude que abre a sessão sem contexto.

A 69ª fechou **§T498 · §T499 · §T500 · §T501 · §T502** (plugin próprio); a 70ª fechou **§T503** & a 71ª **§T504** — preços de XP de vampiro TROCADOS (§I9: disciplina 20 / clã n×15 / fora do clã n×25 · Secondary Path 20 / n×15) & ⚠ ficha que JÁ comprou disciplina é REPRECIFICADA na abertura, `Current` pode ir a negativo (§C); a 72ª fechou **§T505–§T509** — topo da aba Vampiro ganhou 2 caixas: `DOMINATOR` (dominador · geração 4ª-14ª · Max Discipline Level derivado · Clan/Family) & `BLOOD POOL` (20 bolinhas LIVRES, 10 por default). Teto de geração RECUSA compra de disciplina acima do máximo (§V220). **§T510 BLOQUEADA**: falta o user passar os livros p/ as famílias de revenant (§R93) — o combo `Clan/Family` vive c/ 60 clãs/linhagens até lá, & `clanFamily` é ALIAS de `clan` (§B50) ∴ §T510 TROCA o alias, ⊥ dá append. **§T511 é teste SEU no Firecast**; — esconder aba manejada ⊥ move mais ninguém: §V217 REVOGA §V93 (o pulo p/ `Main` arrancava o mestre da aba `Storyteller` a cada toggle). Gate verde, `.rpk` gerado e instalado.

A **73ª** fechou **§T512** — conserto do erro que o user viu ao trocar `Dominator Generation`:
`attempt to call a nil value (global 'tabRootOf')`. RAIZ = ORDEM DE DECLARAÇÃO em Lua, ⊥ lógica
(§B51): `tabRootOf` é `local function` & `renderMaxDisc` tinha sido escrita ~1050 linhas ACIMA
dela ∴ o corpo compilava GETGLOBAL & achava nil. `renderMaxDisc` DESCEU p/ debaixo de
`applyTabVisibility`, corpo intacto byte a byte; `GEN_MAX` & `maxDiscLevel` ficaram onde estavam.
O label `Max Discipline Level` estava MORTO nos 2 caminhos (`onNodeReady` & `onChange`) desde
a 72ª — §T507 (o teto que recusa a compra) ⊥ foi atingida, ela lê `maxDiscLevel()` direto.

⚠ **`rdk -l` sai 0 sobre global indefinido** — é Lua legal — & os 442 checks liam ESTRUTURA,
nunca ORDEM ∴ a 72ª fechou verde c/ o label morto. **§V223** fecha essa porta: nenhuma chamada
a `local function` acima da linha que a declara. Ela nasce c/ **0 dentes** de propósito (a única
violação do sheet era essa) — é guarda de REGRESSÃO, ⊥ auditoria. Conserto de um hit nela é
DESCER o chamador, ⊥ promover o helper a global (§V223 traz a convenção medida: global = chamada
de outro `.lfm`, local = helper interno).

A **74ª** fechou **§T513** & **§T514** (pedido user 2026-08-22, 2 mudanças de layout):

- a caixa `DOMINATOR` virou **grade 2×2** — linha 1 `Name` · `Generation`, linha 2 `Clan/Family`
  · `Max Discipline Level`. ⚠ **só o `text=` mudou**: os campos seguem `dominator` &
  `dominatorGen` (§V2 — o user grafou `dominatorName`/`dominatorGeneration` no pedido & esses
  ⊥ ∃; renomear perderia o dado da ficha que ele já está testando, §I30). As 2 caixas 150→**120**
  & `tabsVamp` 160→**130** ∴ as sub-abas ganharam 40px. `wod.Dominator` & `wod.Dominator
  Generation` perderam o último leitor & SAÍRAM dos 3 lugares; `wod.Name`/`wod.Generation` já ∃
  ∴ ⊥ entrou chave nova. **§V224** guarda a grade por COLUNA (§B12 §B13 são a mesma deriva).
- **esmaecimento**: as 4 caixas de descrição (`edtDiscDesc` `edtPathDesc` `edtRitualDesc`
  `edtNuminaDesc`) PERDERAM `opacity` — exceção NOMINAL de §V111, ≡ `bloodPool_*`/`willpower_c*`
  — & todo o resto foi `0.55`→**`0.40`**: 33 literais no XML + 3 sítios Lua. ⚠ o §T514 dizia
  "as 2 regex do gate" & são **3** (§V112 §V162 **§V175**) + o literal solto de §V179 + `$DIM`
  = **5** sítios no gate, & eles ⊥ leem a constante de propósito (casam fonte Lua, ⊥ atributo).
  O `$DIM` agora nomeia os outros 4 por ID DE CHECK, ⊥ por linha (§V209: linha apodrece).

A **75ª** fechou **§T516** & **§T517** — a aba Vampiro ganhou **régua direita em x=1385**.
O relato era "aparece scrollbar nas abas de disciplina/blood sorcery" & o número era grande:
`WoD20.13` fechava em **1385** dentro de um `tabsVamp` de **1210** — 175px de transbordo,
entregues na 65ª & VERDES desde então, porque ∀ caixa era medida SOZINHA & todas passavam.
⊥ ∃ quem comparasse o filho c/ o pai que ! segurá-lo. **§V225** fecha isso em 2 pernas:
(a) conteúdo de sub-aba ≤ largura de `tabsVamp` · (b) as 3 `DESCRIPTION` & a `BLOOD POOL`
fecham no MESMO x (4 arquivos concordando num número que nenhum declara).

- `DOMINATOR` 0..**875** (vão de coluna 13→68px) & `cboClanFamily` 200→**320** — que é o que
  §T510 vai querer quando as famílias de revenant chegarem. `BLOOD POOL` 885..1385 (600→500),
  20 bolinhas recentralizadas nos 2 eixos (x 111..388 · fileiras em 42 & 77).
- `WoD20.12` DESCRIPTION 850→**1025** & `WoD20.14` 850→**865**. **`WoD20.13` ⊥ foi tocado**:
  ele JÁ fechava em 1385 & é a FONTE da régua — mexer nele seria mover o alvo.
- `tabsVamp` 1210→**1395**, 10px além do conteúdo: o inset do `<tab>` ⊥ é legível no fonte
  (**§R94**) ∴ a folga é declarada. §T518 resolve nos 2 sentidos.

⚠ CUSTO declarado: a ficha já exigia **1370** pela aba Traits (46ª) ∴ o ponto mais largo vai
p/ 1395, **+25px** — mas a Vampiro TOMA da Traits o posto de 1ª aba a mostrar barra
horizontal quando a janela encolhe.

A **76ª** fechou **§T519** — barra de rolagem em `Blood Sorcery: Rituals` (relato user). Era o
eixo **Y**: `WoD20.14` fecha em **675** & `tabsVamp` tinha **650**. `tabsVamp` `height` 650→**730**
∴ fundo 780→860, & o CUSTO é **zero** — a aba Storyteller (`WoD20.10`) já obriga a ficha a **920**
de altura (MEDIDO nos 15 forms) ∴ o ponto mais alto ⊥ se move. ⊥ encolhi `WoD20.14`: os 675 são
25 linhas de ritual & cortar altura cortaria LINHA (§R8).

⚠ **§B52 é sobre MIM, ⊥ sobre o código**: §V225 nasceu na 75ª respondendo a um relato de barra
HORIZONTAL & mediu só o X; o relato seguinte foi a MESMA barra no Y, & o transbordo já estava
lá antes (as alturas ⊥ foram tocadas na 75ª). Pior: o Pass dizia "the three sub-tabs fit inside
tabsVamp (1395)" — "fit inside" LÊ como "cabem" & ele comparara LARGURA só. Verde afirmando
mais do que mediu = §V209, numa mensagem que CITAVA §V209. §V225(a) agora mede os 2 eixos & o
Pass nomeia os 2. Regra que sai daí: **eixo novo pede mutação PRÓPRIA** — a mutação de X ⊥
prova Y (§V222 em forma de eixo).

A **77ª** especou a **barra de abas própria** (§I32 §R95 §V226 §V227 §T521-§T525) & fechou o
probe **§T521**. Pedido user: trocar a estética das abas p/ combinar c/ o resto & seguir os
temas. Decisões user: **as 14 abas de uma vez** (11 de `tabsHH` + 3 de `tabsVamp`) & **ativa
preenchida / inativas só contorno**.

⚠ **A barra nativa ⊥ TEM estética p/ trocar** — ⊥ é "difícil", ⊥ ∃ propriedade. `gui.TabItem`
expõe `text`/`title`/`activate` + o que herda de `Control`; `gui.TabControl` só `tabIndex`.
E `color=` numa `<tab>` faz o rdk sair **1 SEM MENSAGEM** & apagar o `.rpk`. Único caminho =
substituir o `tabControl` por `rectangle`+`label`, que é o par que `applyTheme` alcança nas 2 pontas.

## ✅ §R95 RESPONDIDO no Firecast (user, 2026-08-22) — **os 3 sim**

**(a)** N irmãos `align="client"` c/ 1 visível: **FUNCIONA** — o visível preenche o container.
**(b)** absoluto + `anchors="left top right bottom"`: **FUNCIONA** — acompanha ao redimensionar.
**(c)** trocar de painel por `visible`: **FUNCIONA** nos 2 mecanismos.

∴ §T522 usa **(a)**, que é o caminho barato, & §V190 ganha **exceção ESCOPADA** ("1 visível de
N"), ⊥ revogação. §B41 segue válido & ⊥ contradiz isto: lá os 2 irmãos estavam VISÍVEIS (o
papel de tema aceso POR CIMA do `tabControl`) ∴ era sobreposição, ⊥ dimensionamento.

⚠ **PENDENTE de `/ck:spec`** (o `/ck:build` ⊥ escreve seção) — 3 coisas, & a 2ª MORDE:
1. §R95 registrar a resposta acima & sair de `?`;
2. **§T521 tem a sintaxe ERRADA no texto**: escrevi `anchors="{left,top,right,bottom}"` & a forma
   de chaves é de `bounds` (`margins`/`padding`). `set` é separado por ESPAÇO: `anchors="left top`
   `right bottom"` (MEDIDO: `corners="topLeft topRight"` · `sides="bottom"`). Sintaxe inválida em
   `.lfm` = rdk 1 SEM MENSAGEM ∴ o literal errado manda a rodada seguinte p/ um bisect;
3. §V190 escrever a exceção escopada que (a) autoriza.

⚠ **FATO NOVO do toolchain**: **a pasta `sdk/` é OBRIGATÓRIA num plugin**. Sem ela o rdk sai **1
SEM MENSAGEM** & ⊥ emite `.rpk` — 4ª porta p/ a mesma assinatura (§B19 §B49 §V216). Achado
construindo o probe: as 8 variantes do bisect foram recusadas, INCLUSIVE um form c/ 1 `<label>`
só — quando o mínimo absoluto falha, o problema ⊥ está no que você escreveu. Copiado o `sdk/`,
as 8 passaram. Merece §R próprio. (Bônus medido: o `.rpk` é nomeado pela PASTA do plugin, ⊥ por
`originalPluginFileName`.)

✅ **plugin PROBE REMOVIDO** (2026-08-22): `andreoliveira.styllern.probealign.rpk` (98.574 B)
apagado de `%APPDATA%\Firecast\Plugins` & a fonte (`scratchpad/probe/`, id
`AndreOliveira.Styllern.ProbeAlign`, form `frmProbeAlign`) apagada junto — ⊥ ∃ mais fonte p/
rebuildar. Firecast fechado ANTES (o `.rpk` fica TRAVADO c/ o app aberto — MEDIDO). `probealign`
tem **0** ocorrência em `syscache.tfh`/`temporary.tfh`/`state.xml`/`param.xml` (`grep -a`, app
fechado) ∴ ⊥ ∃ rastro LOCAL de ficha; se ∃ ficha do lado servidor, ela está órfã & sai pela UI.

## A 78ª: a barra de abas é NOSSA (§T522 §T523 §T524)

⊥ ∃ mais `<tabControl>` nem `<tab>` na ficha. As 14 abas (11 + 3 sub) são:

- **painel** = `<layout name="tab<X>">` c/ o `<import>` dentro. Na RAIZ eles são N irmãos
  `align="client"` c/ 1 visível (mecanismo (a), provado em §T521); em `WoD20.11` são ABSOLUTOS,
  porque lá o `scrollBox` já gasta o retângulo cliente c/ `themePaper11` & 2 `client` visíveis
  disputando é o §B41 em pessoa;
- **botão** = `<rectangle>` + `<label hitTest="false">` (idioma da trilha de saúde, `WoD20.1:162`);
- **ativa** = um 2º retângulo (`tabOn<X>`) que LIGA por `visible` — ⊥ por cor escrita em Lua.
  ⚠ Isto é decisão de projeto, ⊥ estilo: `applyTheme` repinta forma pela cor AUTORADA (§V57)
  ∴ escrever `color` em Lua seria sobrescrito no próximo repaint, ou teria de entrar no ledger.
  `visible` ⊥ disputa c/ ninguém & deixa a paleta mandando na paleta;
- **estado** = `activeTab` & `activeVampTab`, globais Lua. **NUNCA campo** (§V227).

§R33 ("⊥ ∃ evento de troca de aba") deixou de valer: a barra é nossa ∴ o clique é nosso. A
regra de ⊥ pular (§V217) segue, mas agora por ESCOLHA & ⊥ por limite.

⚠ **12 invariantes foram REAPONTADAS** (§V40 §V89 §V92 §V94 §V166 §V172 §V188 §V190 §V221
§V225 + §V226 §V227 novas). ⊥ mudaram de SENTIDO, mudaram de ALVO — & as 12 acenderam
VERMELHAS contra a estrutura nova antes de eu reapontá-las, o que é prova de mutação de
graça. Destaques: §V190 ganhou **exceção ESCOPADA** (N `client` irmãos, ∀ um c/ `<import>` &
nenhum autorado visível) & §V188 virou censo de **ZERO** `tabControl`.

⚠ **§V223 pegou um bug MEU na mesma sessão em que nasceu**: `renderVampTabs` chamava
`tabRootOf` de cima da declaração `local` — §B51 exato, 1 dia depois. Cura igual: DESCE o
chamador. Se você escrever função nova no topo do `<script>`, confira antes de rodar o gate.

⚠ **§B26 migrou de alvo**: os 2 botões gerenciados (`btnTabDisciplines` `btnTabStoryteller`)
nascem `visible="false"`, ≡ os `<tab>` nasciam. Eu tinha autorado os 11 abertos & foi o §V94
que me fez ver: se o Lua ⊥ rodar, a barra oferecia Vampiro & Narrador a qualquer um.

⚠ **§V68 mordeu**: usei raio 8 nos botões & a casa usa **14**. O preenchimento é
`color="black"` de propósito (p/ o tema mapeá-lo ≡ as caixas) ∴ entra no escopo de §V68.

**§T525 é teste SEU** & o passo (5) precisa de **2 clientes na mesma ficha** — é o único
jeito de ver §V227 funcionando.

## A 79ª: a barra ganhou PELE (§T526 §T527 §T528)

2 relatos do user sobre a barra que a 78ª entregou, & os 2 têm a mesma raiz estrutural:
a barra foi construída SEM fundo próprio.

- **o cinza** ⊥ era cor de ninguém: a faixa de `tabStrip` é a ÚNICA região da ficha SEM
  papel atrás. Os 13 `themePaper*` moram nos forms IMPORTADOS & o form RAIZ ⊥ tem nenhum
  ∴ ali aparecia o fundo do host (`theme="dark"`), que ⊥ é de época nenhuma. CURA = 1
  `<rectangle align="client" color="black" xradius="14" cornerType="innerRound"/>` como 1º
  filho — ≡ as 50+ caixas de seção (`WoD20.1:219`) ∴ `applyTheme` já repinta de graça.
  ⊥ Lua nova, ⊥ chave nova. **PAPEL foi rejeitado por medida**: `gui.Image` ⊥ tem `tile`,
  só `stretch` — textura em 34px vira borrão & a escala ⊥ casa c/ o painel de baixo;
- **a mordida do arco (§B53)**: `cornerType="innerRound"` curva a borda p/ DENTRO ∴ o
  interior é `width - 2*xradius` & a régua de §V16 mede `width` CRU. ⊥ CORTA nada —
  o texto ENCOSTA na curva — ∴ nenhum check de estouro veria. Fórmula nova (§V228) =
  `NeededPx + 2*xradius + 12`, nos **14** botões das 2 barras.

⚠ **a pílula da aba ativa mudou de COR** (`black` → `DimGray`, o acento da época): faixa
preta c/ pílula preta é falha CALADA & TOTAL — ⊥ quebra build, ⊥ acende check, & a ficha
abre sem NENHUMA aba parecendo aberta. §V229 guarda o par. Efeito colateral: os 14
`tabOn*` SAEM do alcance de §V68 (ela lê só `color='black'`) ∴ quem confere o canto
deles agora é §V228 — que por isso mede o `xradius` além da largura, senão a fórmula
afrouxa em silêncio junto c/ o que ela mede.

⚠ **⊥ mexer na altura de `vampStrip`**: a `tabStrip` cresceu 34→38 de graça (os painéis
dela são `align="client"`), mas em `WoD20.11` eles são ABSOLUTOS ∴ 4px ali reabrem
§B52. `vampStrip` ficou c/ `top`=130 & `height`=34 INTOCADOS, só largura & cor.

⚠ **§I33/§B53 dizem "folga ZERO" nas 3 sub-abas & está ERRADO** — o gate mediu 189px p/
`Feitiçaria de Sangue: Trilhas` (29 char, ⊥ 30) contra os 195 autorados ∴ a folga era **6px**,
⊥ zero. A CONCLUSÃO segue de pé (6px contra um pedágio de 28 é de longe o mais apertado da
ficha; os 11 de cima tinham 26) mas o NÚMERO ⊥. Pede `/ck:spec amend`. Pelo mesmo motivo
`btnTabPaths`/`btnTabRituals` ficaram em **235** & a regra só exige 229 — 6px acima do
piso, de propósito: são justo os 2 rótulos que §R96 aponta como de risco em fonte serifada.

## A 81ª: vão no topo (§T535 §T536 §T537)

MEDIDO: os **14** forms de conteúdo começavam a 1ª caixa em `top=0`, sem 1 exceção — ⊥ era
deriva de 1 arquivo, era como a ficha nasceu (herdado do Mage). Agora: conteúdo **12**,
barra **8**, & os **75** filhos de 1º nível desceram junto.

⚠ **o seletor ! ser ESTRUTURAL** (filho ELEMENTO direto de `<scrollBox>` c/ `top=`), ⊥ por
RECUO: no 1º ensaio um regex de 2 tabs pegou **73 de 75** porque `WoD20.5` indenta com 4
ESPAÇOS — & aplicação desigual ⊥ falha calada, ela vira SOBREPOSIÇÃO (§V40 acendeu em
`WoD20.4`). `gaplib.js` no scratchpad tem o tokenizador (comentário & CDATA antes das tags).

⚠ **§V231c guarda a RELAÇÃO, ⊥ os números**: o "espaçamento ainda menor" do pedido virou
contrato — vão da barra **<** vão do conteúdo. Sem essa perna, 2 rodadas futuras mexendo
em 1 número cada cruzam a hierarquia & ⊥ ∃ check que reclame. A faixa é conferida como
`2*vão + pílula` ∴ o vão de cima ⊥ desliza sem o de baixo acender.

⚠ a régua de **§V69 mora num COMENTÁRIO** de `WoD20.1` (`Everything closes on x=1210 / y=760`)
& o gate a LÊ de propósito, p/ o comentário ⊥ apodrecer. Foi a ÚNICA coisa que acendeu no
ensaio c/ o seletor certo ∴ ela vai a **772** na mesma rodada. Se você mexer em altura de
caixa da Main, é lá que o número mora.

⚠ `padding`/`margins` foram REJEITADOS como mecanismo: os 2 props ∃ (`rrpgGUI.lua:240-241`,
tipo `bounds`) mas têm **ZERO** uso nos 15 `.lfm` & se o inset alcança filho ABSOLUTO só o
Firecast responde ∴ custaria rodada de probe ≡ §T521. Empurrar é certo & estático.

⚠ CUSTO: ∀ form desce 12 ∴ `WoD20.10` (a mais alta) pede **932**, ⊥ 920 — é ela quem decide
quando nasce barra vertical. Sub-abas em 597 · 622 · **687** dentro dos 700 (13px de folga).

⚠ **`WoD20.8.lfm` apareceu inteiro em CRLF** (68 CR num arquivo que no HEAD tem 0) & ⊥ veio
de edição minha — fatiamento de string ⊥ converte quebra. Normalizei p/ LF depois de
conferir que o conteúdo batia (só as 6 mudanças de `top`). Se reaparecer, é editor
gravando CRLF: o repo inteiro é LF.

## A 80ª: o chão da barra é QUADRADO (§T530 §T531)

Pedido do user DEPOIS de ver a 79ª na tela: o fundo que a barra ganhou estava c/ canto
côncavo ≡ as caixas. Agora ele ⊥ autora `xradius` nem `yradius` nem `cornerType` — é o
**1º retângulo quadrado da ficha** (MEDIDO: os outros 99 autoram raio).

POR QUE ele é diferente: caixa de seção é objeto POUSADO no papel & o canto recortado é o
que a levanta do fundo; o chão da barra ⊥ é objeto, é o CHÃO — vai de ponta a ponta & ⊥ tem
nada atrás p/ se destacar. Canto côncavo ali só morde 4 quinas da tela.

⚠ **é a 1ª exceção PRETA de §V68**: as 2 velhas (moldura do avatar, marca de vitalidade)
saem DE GRAÇA porque o XPath só pega `color='black'` & esta ⊥ sai ∴ ela ! ser cortada
EXPLICITAMENTE. O corte é por CONSTRUÇÃO: retângulo `align="client"` cujo layout pai tem
irmão `rectangle[@onClick]` — MEDIDO, casa em **1** layout (`tabStrip`) & em nenhuma caixa.
⊥ cortar por NOME (âncora que apodrece) & sobretudo ⊥ pelo teste "⊥ autora canto": esse
seria BURACO — caixa que ESQUECESSE o raio escaparia calada, que é §B18 voltando pela porta
dos fundos. Prova RODADA: esquadrar 1 caixa de seção ! VERMELHO em §V68.

⚠ o canto **TROCOU DE DONO, ⊥ ficou sem**: §V68 abre mão & §V229 passa a exigir que o chão
⊥ autore raio nenhum. As 2 viram na MESMA rodada — §V68 sozinha deixa o canto órfão, §V229
sozinha deixa o gate vermelho de propósito.

⚠ o `left`=16 do 1º botão PERDEU a razão original (era fuga do arco da faixa, §R96) & FICA
assim mesmo, agora como margem esquerda da barra. ⊥ "consertar" p/ 6: a faixa vai de ponta
a ponta ∴ o 16 é a única margem visível que ela tem.

**§T529 é teste SEU** & o passo (3) é o que fecha o `?` de §R96: conferir `Configurações` &
`Feitiçaria de Sangue: Trilhas` em [pt] × `Victorian Era`/`Dark Ages` (as serifadas).

**Nada commitado.**

## ⚠ A FICHA MUDOU DE PLUGIN E DE NOME NA 69ª

| antes | agora |
|---|---|
| `Plugins/Sheets/World of Darkness 20th/` (6 fichas, do Ambesek) | `Plugins/Sheets/World of Darkness 20th Anniversary Edition/` (só a nossa) |
| pasta `HuntersHunted/` | pasta `WoD20th/` |
| `HuntersHunted.lfm` · `HH.<n>.lfm` | `WoD20th.lfm` · `WoD20.<n>.lfm` |
| forms `frmHuntersHunted` · `frmHH_<n>` | `frmWoD20th` · `frmWoD20_<n>` |
| dataType `Ambesek.HuntersHunted.20th` | `AndreOliveira.Styllern.WoD20th` (= `<id>` do plugin) |
| instalado `ambesek.wod.20th.rpk` | `andreoliveira.styllern.wod20th.rpk` |

O plugin velho **perdeu** `HuntersHunted/` e os 4 `desc*.lua` (§T499) e voltou a ser as 5
fichas do Ambesek. §V214 no gate reprova se alguém devolver uma cópia p/ lá.

⚠ **O `.rpk` velho INSTALADO no Firecast ainda tem a ficha dentro** — ele foi buildado
antes da remoção. Enquanto ele estiver instalado, o Firecast mostra a ficha DUAS vezes.
Rebuildar/desinstalar o plugin do Ambesek é do user, ⊥ nosso (§C).

⚠ **`rdk` reprova `-` no `<id>` e no `dataType` SEM MENSAGEM** (§B49, §V216) — mesmo sintoma
de erro de Lua (§B19). Só alfanumérico, `_` e `.`, 5..40 chars. O gate pega isso agora.

---

## 1. O COMANDO

```
/ck:build T491
```

**⊥ peça `/ck:build` pelado.** O skill lê *"vazio → every `.` row in §T order"*, e das **30**
linhas `.` do §T **27 são teste no Firecast — do USER, Claude ⊥ executa**. Um `/ck:build`
pelado começa em §T114 (um `?` fora de escopo há dezenas de rodadas) e erra. Peça a §T
pelo nome, sempre.

Tarefas de Claude que restam: **§T491** · **§T495** (⚠ ver §5) · **remover §T492** (⚠ §4).

---

## 2. ⚠ ANTES DE BUILDAR: abra o Firecast e olhe os dropdowns

A 68ª mudou **de onde vem a lista de TODO picker da ficha** (§I27/§T493 — detalhe no §3).
O gate prova que a fiação está certa; ele **⊥ roda Lua** ∴ ⊥ prova que a lista CHEGA no
widget. Isso só o Firecast responde, e é barato:

Abra uma ficha e confira que estes **abrem com itens**, ⊥ vazios:

| aba | picker | esperado |
|---|---|---|
| Main | Clan · Nature · Demeanor | 60 clãs · 68 arquétipos (×2) |
| Main | SPECIALTIES (9 linhas) | 50 traços |
| Traits | BACKGROUNDS (20 linhas) | 44 antecedentes |
| Powers | as 2 tabelas de númina · TRUE FAITH | 21 · 22 · 4 religiões |
| Vampire | Disciplines · Paths · Rituals | 36 · 64 · 284 |

**Se algum abrir VAZIO**, o bug é de §T493 e o gate ⊥ pegaria nunca — reporte qual e pare.
Causa mais provável: o combo ⊥ resolve chave em `PICKER_LIST` (§V211a mede isso no fonte,
mas só o runtime prova o resto).

⚠ **COBERTURA QUE ⊥ ∃:** §T487 cobre os pickers de VAMPIRO no Firecast. **⊥ ∃ §T de teste
p/ os outros 7** (clan · nature · speciality · background · numina · psychic · faith). Se
quiser isso registrado, é `/ck:spec` — `/ck:build` ⊥ escreve seção.

---

## 3. O que a 68ª FEZ

| §T | o que entrou |
|---|---|
| **T490** | `WoD20.14` perdeu o 2º `onNodeReady` que chamava `renderVampPickers`; sobrou o de `WoD20.13`. **§V207** novo no gate |
| **T492** | 17 chamadas de `wodTrace` + a função & `WOD_HITS` na raiz. **TEMPORÁRIO** (§4) |
| **T493** | as 10 listas de picker saíram do `items=`/`values=` do XML e viraram `PICKER_LIST` |
| **T494** | os 12 sítios do gate passaram a ler o mapa; **§V208 §V211 §V212** novas |

Antes, um `/ck:spec amend` de 27 edições emendou §I27 §V20 §V78 §V148 §V194 §V195 §V201
§V202 §V208 §V209 §T388 §T493 §T494 e criou §V211/§V212.

### A forma nova, em 6 linhas

- **`PICKER_LIST`** mora no `<script>` da **RAIZ** (`WoD20th.lfm`), entre
  `-- >>> PICKER_LIST_BEGIN` e `-- <<< PICKER_LIST_END`.
- Chave = **raiz de campo** (`cboritual_7`→`ritual`, `cboClan`→`clan`). **10 tabelas ↔ 13
  chaves**; 3 são ALIAS por IDENTIDADE (`demeanor`→`nature` · `clanDisc`→`disc` ·
  `secPath`→`mainPath`), escritas depois do construtor.
- `pickerItems` (`WoD20.6`) lê `PICKER_LIST[fieldRoot(nm)] or c.values`. A cauda `or c.values`
  serve os pickers que ⊥ migraram (`cboGame` `cboSheetTheme` de `WoD20.6`, e `WoD20.3`).
- **`AUTHORED_VALUES` & `authoredValues()` ⊥ ∃ MAIS.** A tabela é CONSTANTE ∴ ⊥ ∃ snapshot
  p/ tirar. Se você reintroduzir qualquer um dos 2, **§V201 fica VERMELHA de propósito**.
- `c.values` & `c.items` são escritos **INCONDICIONALMENTE**. O `if filter then` velho
  estava certo só enquanto o XML autorava `values=`.
- O gate lê tudo por **`ListOf $cb (TplOf $cb)`** — um acessor só, que cai no atributo
  inline p/ quem ⊥ migrou. ⊥ escreva um leitor novo de lista; use esse.

### GANHO MEDIDO

`WoD20th.lfm.lua` (o que a abertura parseia): **1.896.963 → 1.415.113 = −481.850 B**.
Chamadas `setItems`/`setValues` no compilado: **236 → 10**.
O `.rpk` caiu só 29 KB — é ZIP, e texto duplicado comprime quase de graça. O custo real
era PARSE, ⊥ download. **⊥ meça esta rodada pelo tamanho do `.rpk`.**

---

## 4. ⚠ §T492 é TEMPORÁRIO e ! SAIR antes de entregar

17 chamadas `wodTrace(...)` + `WOD_HITS` + a função, espalhadas em 8 arquivos:

```
WoD20th.lfm 2 · WoD20.12 3 · WoD20.13 3 · WoD20.14 3 · WoD20.7 3 · WoD20.1 1 · WoD20.6 1 · WoD20.9 1  (= 17)
```

Todas marcadas `SPEC T492` no comentário da raiz. Elas existem p/ o §T497 ser legível; assim
que ele rodar, saem. **⊥ podem ir no `.rpk` de entrega.**

Chaves do log: `root.onNodeReady` · `root.onShow` · `HH.<n>.onShow` · `renderVampPickers` ·
`numinaText`/`discText`/`pathText`/`ritualText` · `desc<X>.REQUIRE`.
Formato: `WOD  <chave> x<contador>`.
Confira `renderVampPickers x1` (⊥ `x2`) — é a prova em runtime de §T490.

---

## 5. ⚠ §T495 tem buraco de cobertura — ⊥ builde direto

§T495 (split de `desc*.lua` em `_en`/`_pt`) lista **§V210** como o check novo, mas **⊥ lista
os checks EXISTENTES que o split quebra**. Conferido: o gate lê `desc*.lua` em §V177 §V178
§V184 §V189 §V192 §V32 §V34, e pelo menos §V177/§V184 hoje passam dizendo *"all with **en+pt**
text on file"* — ou seja **pareiam os 2 idiomas DENTRO de um arquivo**. Depois do split ⊥ ∃
arquivo com os 2.

∴ antes de buildar: `/ck:spec amend §T495` p/ enumerar os sítios, ≡ o que a 68ª fez com
§V209. Buildar sem isso é **§B7** de novo.

Nota: `daEn`/`daPt` são referenciados nos renderers (`WoD20.12` `WoD20.13` `WoD20.14`, 2× cada) mas
**⊥ ∃ NENHUMA chave `daEn`/`daPt` nos 4 módulos** (grep = 0) ∴ `pickEra` sempre cai no corpo
do core hoje. A frase de §T495 sobre "daEn vai p/ o `_en`" descreve dado que ainda ⊥ existe.

---

## 6. Estado dos artefatos

```powershell
cd "c:\Users\awlol\OneDrive\Documents\firecast_fork"
.\verify-hunters-hunted.ps1          # ! dizer ALL CHECKS PASSED
```

| | |
|---|---|
| `.rpk` | **1.971.201** B, 2026-08-22 15:56:24 — instalado 15:56:24, sizes batendo |
| `WoD20th.lfm.lua` | **1.435.277** B (remedido na 73ª) |
| `module.xml` | `<id>AndreOliveira.Styllern.WoD20th</id>` · `<version>1.0</version>` (plugin novo) |
| gate | **6.013** linhas, ASCII puro, LF |
| §V/§B/§T/§R | §V máx **V256** · §B máx **B56** · §T máx **T576** · §I máx **I50** · §R máx **R103** · gate **6.013** linhas, ~480 checks (87ª rodada) |

⚠ **⊥ deixe a saída do gate cair no chat** — são ~400 linhas `ok` e afoga o contexto:

```bash
powershell.exe -NoProfile -Command "& '.\verify-hunters-hunted.ps1' *>&1 | Out-File -FilePath '<tmp>/g.txt' -Encoding utf8; exit \$LASTEXITCODE"
grep -E "FAIL|ALL CHECKS" '<tmp>/g.txt'
```

As linhas `FAIL` **⊥ aparecem** em `$o = .\verify...` — `Fail` escreve em outro stream. ! usar
`*>&1` p/ arquivo.

⚠ **`Out-File -Encoding utf8` põe BOM na 1ª linha** ∴ `grep -c '^ok  '` perde 1 check & a
contagem sai 1 A MENOS. Foi o que fez a 72ª ser relatada c/ "443 checks" quando eram **442**.
Se a contagem parecer ter caído sem motivo, confira o BOM ANTES de caçar check perdido.

---

## 7. Armadilhas de ferramenta — custaram tempo real nesta rodada

- **O adaptador XML do PowerShell SOMBREIA `.Name` com o atributo `name=`.** Num
  `<template name="RitualRow">`, `$p.Name` devolve **`RitualRow`**, ⊥ `template`. Um teste
  `-eq 'template'` **nunca casa & nada avisa** — foi assim que os coletores do gate passaram
  VERDES lendo 249 de 786 strings. Use **`.LocalName`** p/ nome de elemento.
- **`return , $array` em PowerShell embrulha array em array** ∴ o chamador lê a lista
  inteira como 1 item. Sintoma: `expected 'X', got 'System.Object[]'`.
- **`Get-Item` devolve `FileInfo` que se ATUALIZA.** `$b = Get-Item x` antes de mexer &
  `$b.Length` depois lê o valor NOVO ∴ a prova de §V6/§V7 vira mentira. Guarde
  `$b = (Get-Item x).Length` na hora.
- **O shell come `\\`.** Heredoc `<<'EOF'` com `\\|` chega como `\|`; `\b` num literal JS
  vira **caractere de backspace** dentro do `.ps1`. **Solução: escreva o arquivo com a
  ferramenta `Write` (preserva verbatim) ou monte a barra com `String.fromCharCode(92)`.**
  Nunca conte com `\\` sobrevivendo a um heredoc.
- **`String.replace` de JS interpreta `$&` `` $` `` `$'` `$1` na string de SUBSTITUIÇÃO.**
  Um `` `_%d+$` `` no texto novo injetou **175 KB do prefixo do próprio arquivo** no
  `SPEC.md` e duplicou §G/§C/§I. **Use replacer em FUNÇÃO:** `s.replace(o, () => n)`.
- **⊥ ∃ Python** nesta máquina (cai na Store). **∃ `node` v24.16.0** — use node p/ edição de
  texto precisa, sempre com asserção de contagem de ocorrências ANTES de gravar.
- O gate é **ASCII puro** e **LF**. node com `'latin1'` preserva; `Set-Content -Encoding utf8`
  grava BOM e quebra.

---

## 8. Regras do projeto que mordem

- **Gate verde ⊥ prova que COMPILA.** O gate faz XML + regex; ⊥ roda Lua. Um `end;` a menos
  passa por 300+ checks e morre no `rdk -l`, que sai **1 SEM MENSAGEM & APAGA o `.rpk`**
  (§B19). ∴ rodar `rdk -l` ANTES de marcar §T.
- **Nem o gate nem o `rdk` resolvem `require`, nem populam combo.** É runtime ∴ §2 ↑.
- **Check novo no gate ! poder falhar de verdade** (§V20): mutar e ver VERMELHO antes de
  aceitar. Os de §T494 foram mutados 9× (esvaziar cada lista, renomear o marcador, virar
  alias em cópia, `table.remove`, devolver o `if filter`, tirar um clã) — todos vermelharam
  o check certo e o restore voltou verde.
- **Só `/ck:spec` escreve seções do SPEC.** `/ck:build` só vira status de §T.
- **⊥ commitar sem o user pedir NAQUELA mensagem.** Vale mesmo quando o `/ck:build` manda
  commitar — a regra do projeto vence. Termine com §T marcado, gate verde, `.rpk` instalado,
  e as mudanças no working tree.

---

## 9. Working tree — **NADA COMMITADO**

User commitou até a 63ª em `3dc2f9fa`. O tree carrega 64ª…68ª:

| arquivo | 68ª rodada |
|---|---|
| `SPEC.md` | emenda de 27 edições + §V211/§V212 novas + status de T490/T492/T493/T494 → `x` |
| `WoD20th.lfm` | `PICKER_LIST` (189 linhas) · `wodTrace` + `WOD_HITS` |
| `WoD20.6.lfm` | `fieldRoot` · fonte = `PICKER_LIST` · `AUTHORED_VALUES` removido · writes incondicionais |
| `WoD20.1 WoD20.2 WoD20.7 WoD20.12 WoD20.13 WoD20.14` | `items=`/`values=` removidos das 11 declarações |
| `verify-hunters-hunted.ps1` | leitor de `PICKER_LIST` + 12 sítios + §V207 §V208 §V211 §V212 |
| `WoD20.9.lfm` | `wodTrace` |
| `output/*.rpk` | 3.775.337 → **3.763.377** |
| `HANDOFF.md` | este arquivo |

Não rastreados: `.claude/`, os 4 `desc*.lua` (2,7 MB, da 65ª).
