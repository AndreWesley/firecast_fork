# HANDOFF — estado antes do próximo `/ck:build`

## COMECE AQUI - CHAT NOVO, SEM CONTEXTO (2026-09-26, 220ª rodada — 42º + 43º lotes ESPECIFICADOS, CONSTRUÍDOS & INSTALADOS: §I186, §T1157 §T1158 §T1159 §T1161 §T1162 `x`, §T1160 §T1163 (tela [USER]) `.`, §Q105 RESPONDIDA)

**43º lote (15:50) — §Q105 RESPONDIDA:** *"1. apagar. 2. não."* → os 9 campos das caixas de nota saíram de ÓRFÃO p/ **APAGADO POR DECISÃO** (contra a rec., decisão INFORMADA — ⊥ "consertar"). `WoD20th.lfm`: `DELETED_FIELDS` (9) + `purgeDeleted()` depois de `mcNodes` (anda `MC.root` SEMPRE + filhos de `MC.chars`, `local n`/`local f`, escreve `nil` só sob `~= nil`), chamada como ÚLTIMA linha do `onNodeReady` do root, DEPOIS do `setTimeout` do reveal. Gate: `$I3_ORPHANS` volta a 30, `$I3_DELETED` 13, §V362(d) 4→13, §V362(f) NOVA. §B187: o 1º desenho de §I186g lia `mcRootGone` (§V499d) & endereçava `nodes[i][…]` (§V492b) — o gate pegou antes do install. Bateria **5/5** (`scratchpad\b43.ps1`/`battery43.log`). Gate `-Build -Quiet` VERDE. **INSTALADO 15:50:07** (3155270 B). ⚠ os 4 `psychic_16`…`_19` (APAGADOS pela §Q32) NUNCA foram zerados no NDB — MEDIDO; FORA (§I186h). **PRÓXIMO:** §T1160 + §T1163 (tela: ficha velha c/ texto nas 9 abre normal).

### 42º lote (mesma rodada)

**Pedido do user:** aba Traits — `BOOK`/`PAGE` ×2, `COST` ×1,5; as 9 caixas de nota (Aliados, Mentor, Recursos, Guias, Contatos, Fama, Artefatos, Influência, Base de Operações) SAEM; `OUTROS` cresce até o topo de onde era `ARTEFATOS`; `PERTURBAÇÕES`/`OUTROS` coladas às tabelas.

**Construído (14:39):** `WoD20.2`: colunas `304/234 · 538/90 · 628/75` (linha 703, `MERITS`/`FLAWS` 743), 9 `<layout>` fora, `DERANGEMENTS` & `OTHER` em x=1137 nas fileiras de `MERITS`/`FLAWS` (225×337 as 2, editor 155×284 as 2) ∴ 5 caixas, aba fecha em 1362. `.lang` −18 linhas & mapa `PT` de `WoD20.6` −9 (chaves dos 9 títulos). Os 9 campos viraram ÓRFÃOS (`$I3_ORPHANS` +9, rec. de §Q105.1). Gate: §V332 (a)(c)(e)(f), §V349(a), §V290(b), §V392 REESCRITA, censo §V280/§V298 71→62 & — ⚠ ⊥ listados na spec, pegos pelo "∀ outro check que acender" de §T1159 — pisos de §V239 70→61, §V240 70→61, §V400 69→60 (−9, mesma folga; o SPEC ⊥ carrega esses números). Bateria **9/9** (`5cc4c8e5…\scratchpad\battery42.ps1`/`.log`: M1…M7 VERMELHAS nos checks previstos, P1/P2 sondas VERDES onde deviam; hashes = `pre-battery42.hashes.txt`). Gate `-Build -Quiet` VERDE. **INSTALADO 14:39:18** (3154333 B = `output/`). **Nada commitado.** ⚠ `sed -i` no SPEC.md comeu o CRLF do arquivo inteiro no meio da rodada — restaurado por `awk` (0 dano), & o flip de status foi refeito c/ Edit.

**PRÓXIMO:** pedir ao user §T1160 (tela) + §Q105 (2 perguntas, construídas PELA recomendação) + as pendências de tela abaixo (§T1156 …).

## ANTERIOR (2026-09-26, 219ª rodada — 41º lote ESPECIFICADO, CONSTRUÍDO & INSTALADO: §I185, §V526, §T1153 §T1154 §T1155 `x`, §T1156 (tela [USER]) `.`, §Q104 ABERTA)

**Construído (13:02):** `WoD20.10` desembrulhado (filhos −1 tab, `stSharedScope` 0/321/445×25 só c/ `chkMultipleChars` + gatilho `{language, multipleCharacters}`); `WoD20th.lfm`: `MC_PRESET_FIELDS` (12), `MC.preset`, `function mcPreset()` antes de `mcAdd`, `mcInit` acha `mcPreset` & pina `mcRootScope`, janela 470 sem `chkMultipleCharsMc`, `mcRootScope` 0×0 c/ o link de `mcOrder`, `<dataLink field="healthLevels" onChange="mcRender(self);"/>` depois do gatilho das barras. Gate: §V526 NOVA (depois de §V525), §V489(c) & §V492(a)(c)(d) fora, §V36 sem `multipleCharacters`, §V499c/§V509b emendadas. Bateria **10/10** (`b9fe6a2f…\scratchpad\battery41.ps1`/`.log`: M1…M7 → V526 a…g, M8 → V499c, M9 → V509b, P1 VERDE; hashes = `pre-battery41.hashes.txt`). ⚠ na bateria, `param($t)` & `$T` (tab) eram a MESMA variável (PS ignora caixa) — tab virou `$TB`. Gate `-Build -Quiet` VERDE (78 s). **INSTALADO 13:01:59** (3158390 B = `output/`). **Nada commitado.**

**Pedido do user:** as Storyteller Settings viram POR PERSONAGEM (≠ jogo/era/níveis por personagem); a janela `Settings` da coluna só faz o setup INICIAL dos novos & ⊥ altera quem já ∃. REVERTE §Q88.8 (o "altera todos" de 2026-09-23) — ⊥ "consertar" o espelho de volta. Desenho (§I185): o box de `WoD20.10` sai do `stSharedScope` (liga no ativo); `stSharedScope` encolhe p/ `chkMultipleChars` + gatilho `{language, multipleCharacters}`; a janela pina em nó NOVO `mcPreset` (criado + semeado da raiz 1× por `mcPreset()`, nunca em `mcInit`); `mcAdd` copia do preset + `language`; `mcShared` só `language`; `mcOrder` vai p/ `mcRootScope`; `<dataLink healthLevels → mcRender>` no root. 0 migração (∀ `mcChar` já tem cópia dos 12).

**PRÓXIMO:** pedir ao user §T1156 (tela) + §Q104 (5 perguntas, construídas PELA recomendação) + as pendências de tela abaixo. Se §T1156(b) negar a troca de tema/abas/caixinhas → lote novo c/ re-render em `mcShow` (§I185f).

## ANTERIOR (2026-09-26, 218ª rodada — 40º lote ESPECIFICADO, CONSTRUÍDO & INSTALADO: §I184f, §B186 REABERTO, §V525(a) EMENDADA, §T1150 §T1151 `x`, §T1152 (tela [USER]) `.`; §T1149 `x` c/ FALHA)

**§T1149 FALHOU na tela** (user: *"o problema de quando abre pela primeira vez a janela e o obscurecimento não pega na área toda ainda está acontecendo"*) → reescrever `align` ⊥ realinha o scrim na 1ª subida. Plano B (§I184f) construído: `scrimFit(s)` agora lê `local p = s.parent` (= `sheetMain`) & escreve `s.align = "none"; s.left = 0; s.top = 0; s.width = p.width; s.height = p.height; p:needRepaint();` — o rect vem do pai (já na tela c/ tamanho final) & o `needRepaint` invalida o pai inteiro; cobre as 2 causas que sobraram. As 5 chamadas ⊥ mudaram. XML segue `align="contents"`. Gate: §V525(a) lê o local do pai, `none` 1× & 0 `contents`, 4 escritas de geometria 1× cada, `needRepaint` DEPOIS da última. Bateria **5/5** (`e770a319…\scratchpad\battery40.ps1`/`.log`): M1 `height` tirada · M2 `needRepaint` tirado · M3 `needRepaint` antes do `width` → V525a · M4 `scrimFit` fora de `specOpen` → V525b · P1 VERDE; hash restaurado. Gate `-Build -Quiet` VERDE. **INSTALADO 11:53:29** (3156848 B). **Nada commitado** (39º + 40º no working tree; 38º no stage; user commitou `d0d2663a` 10:56).

**PRÓXIMO:** §T1152 (tela): fechar & reabrir a ficha, 1ª janela → escuro inteiro. Se AINDA falhar: pedir PRINT da 1ª abertura (quais partes ficam claras) — é o dado que separa as hipóteses; próximo conserto seria `setTimeout` de 1 tick re-chamando `scrimFit` (lote novo, §I184f). Pendências antigas: §T1146/§T1143/§T1140/§T1137 (tela), §Q102, backprop do `mcShow` (abaixo).

## ANTERIOR (2026-09-26, 218ª rodada — 39º lote ESPECIFICADO, CONSTRUÍDO & INSTALADO: §I184, §B186, §V525, §T1147 §T1148 `x`, §T1149 (tela [USER]) `.`)

**Pedido + bug do user:** escuro a **80%** & *"na primeira vez que o escurecimento aparece ele não preenche todo o espaço"*. Feito: 2 scrims `opacity="0.80"`; `function scrimFit(s)` GLOBAL antes de `popClose` (`s.align = "none"; s.align = "contents";`) chamada depois do `visible = true` do scrim nas 5 subidas (`popOpen` `mcSettingsOpen` `noteOpen` `specOpen` `mfOpen`). ⚠ a causa (§B186) é HIPÓTESE `?` — o scrim nasce oculto & ninguém o realinhava; só §T1149 (tela: fechar/reabrir a ficha, 1ª janela → escuro inteiro) prova. Se falhar: geometria explícita em Lua, lote novo (§I184d). Gate: §V503(a) `0.80`, §V525 NOVA (depois de §V524, roster derivado). Bateria **5/5** (`e770a319…\scratchpad\battery39.ps1`/`.log`): M1 `0.85` → V503a/b · M2 sem `scrimFit` em `specOpen` → V525b · M3 escritas trocadas → V525a · M4 `scrimFit` antes do `visible` em `popOpen` → V525b · P1 VERDE; hash restaurado. Gate `-Build -Quiet` VERDE. **INSTALADO 11:35:54** (3156473 B). User commitou `d0d2663a` (10:56) & deixou o 38º no stage; o 39º está só no working tree. ⚠ nesta rodada um `sed -i` tirou o CR do `WoD20th.lfm` — reconvertido c/ `awk`, diff contra o índice = só as linhas do 39º.

## ANTERIOR (2026-09-26, 217ª rodada — 38º lote ESPECIFICADO, CONSTRUÍDO & INSTALADO: §I183, §T1144 §T1145 `x`, §T1146 (tela [USER]) `.`; §Q103 RESPONDIDA)

**Pedido do user:** *"a cor do escurecimento, altere para 85%"* → `popScrim` & `popScrimB` `opacity="0.70"` → `"0.85"` (`WoD20th.lfm`, + comentário do bloco); `color="black"` (tom de caixa da época) FICA. §Q103 marcada RESPONDIDA por LEITURA: ele mudou a intensidade & ⊥ escolheu preto puro ∴ cor da época — se ele disser o contrário, reabrir. Gate: §V503(a) cobra `0.85`; §V502(c) cobra `0.70` c/ 0 dono (`$o70Scrim502` saiu). Bateria **3/3** (`e770a319…\scratchpad\battery38.ps1`/`.log`): M1 `0.70` de volta no `popScrim` → V502c + V503a/b · M2 só `popScrimB` `0.80` → V503a/b · P1 `popDesc` top 150→160 VERDE; hash restaurado. Gate `-Build -Quiet` VERDE. **INSTALADO 11:06:08** (3155889 B = `output/`). **Nada commitado.**

**PRÓXIMO:** pedir ao user §T1146 + §T1143 + §T1140 + §T1137 (tela) + adicionar personagem c/ MC ON (o `mcShow`, abaixo). Depois `/ck:spec`: fechar as telas, §Q102, backprop do `mcShow`.

## ANTERIOR (2026-09-26, 217ª rodada, 1ª metade — 37º lote CONSTRUÍDO & INSTALADO: §T1141 §T1142 `x`; §T1143 & §T1140 & §T1137 (tela [USER]) `.`; §Q102 & §Q103 ABERTAS; 1 conserto FORA do spec: `mcShow`)

**Estado:** gate `-Build -Quiet` **ALL CHECKS PASSED** (79 s, 10:41). Bateria **5/5** (`battery37.ps1` da sessão `44249432…`, rodada na `e770a319…\scratchpad\`, child ~50 s/caso): M1 `["#000000"]` de volta na 1ª paleta → V524a · M2 `#000000` no `popScrim` → V503a/b (+V53, V493a, V68) · M3 `["dimgray"]` ao lado de `["DimGray"]` → V524a · M4 `["#FFFFFF"]` de volta no 1º `stroke` → V524a · P1 `popDesc` top 150→160 VERDE. Hashes de `WoD20.6`/`WoD20th` = os de antes (`pre-battery37.hashes.txt`). **INSTALADO 10:42:44** (3155881 B = `output/`). Se a ficha estava aberta, FECHAR & REABRIR. **Nada commitado** (35º + 36º + 37º + `mcShow` no working tree; árvore limpa era `570a5678`). ⚠ `git stash list` tem `stash@{0}` "AAAAAAAAAAA" (09:55, NÃO é desta sessão) c/ os mesmos 8 arquivos — ⊥ mexer sem o user.

**O que achei:** o build do 37º (sessão `44249432…`, 09:41) já tinha feito TODO o §T1141/§T1142 no código & no gate, mas a bateria morreu no meio de M1 (0 `battery37.log`) & o `finally` ⊥ restaurou ∴ a MUTAÇÃO `["#000000"]   = "#000000",` ficou na 1ª paleta (`WoD20.6.lfm:3254`, byte a byte o `to` de M1, sem comentário) → os boxes do Modern Nights seguiam em preto puro & V524a VERMELHA. Conserto desta rodada = tirar essa 1 linha. `t.stroke[normColor("#FFFFFF")]` (`WoD20.6:5179`) segue certo sem a chave `#FFFFFF`: `applyTheme` troca `t.stroke` pelo mapa canonizado na carga (`:3515-3519`).

**Conserto FORA do spec (bug do user, 2026-09-26): `mcShow` quebrava ∀ `mcAdd`** — *"attempt to index a nil value (global 'MF')"*, `WoD20th.lfm.lua:5035`. O 36º (§T1138, §I181c) pôs `if MF.depth == 2 then mfClose(from); end;` em `mcShow` (`WoD20th.lfm:~4991`), mas `local MF` é declarado ~1200 linhas ABAIXO (`:6189`) ∴ ali `MF` é a GLOBAL nil. Agora: `mfClose(from); mfClose(from);` sem teste (desce 1 nível por chamada; a 2ª é inofensiva). Varredura dos 12 `.lfm`: era o ÚNICO local de chunk lido acima da declaração. §V493e segue VERDE (mede só a ORDEM `mfClose(` < `setNodeObject(`) — o gate ⊥ pegou & ⊥ pega. **Pendente p/ `/ck:spec` (backprop):** §B novo + régua "0 local de chunk referenciado acima da declaração" (mutação: o `MF.depth` de volta ! VERMELHO); o texto de §I181c ainda descreve o `if MF.depth == 2`.

**PRÓXIMO:** pedir ao user §T1143 (tela: nas 4 épocas os boxes na cor de caixa de cada uma — Modern `#12141A` chumbo-azulado, Victorian `#1C1310` mogno, Dark Ages `#0E0B09` fuligem, Classical `#171218` basalto; abrir `?` → escuro a 70% no tom da época) + §T1140 + §T1137 + adicionar personagem c/ MC ON (o `mcShow`). Depois `/ck:spec`: fechar as telas, responder §Q102/§Q103, backprop do `mcShow`. **0 §T de código aberta.**

## ANTERIOR (2026-09-26, fim da 215ª rodada — 36º lote ESPECIFICADO, CONSTRUÍDO & INSTALADO: §B184, §V523, §I181, §T1138 §T1139 `x`; §T1140 (tela [USER]) `.`; §Q102 ABERTA; §T1137 (tela do 35º) ainda `.`)

**Estado:** gate `-Quiet` **ALL CHECKS PASSED** (39 s); `-Build -Quiet` compilou o XML movido. Bateria **8/8** (`battery36.ps1`, child ~42 s/caso): M1 geometria fixa de volta no `popScrim` → V503a (+V496d) · M2 `opacity` 0.70→0.50 → V503a (+V503b, V502c, V476b) · M3 `#B3000000` de volta → V523a/b (+V503a, V53, V493a) · M4 guarda de `mcShow` tirada → V493e · M5 `["#00000000"]` → `["#40000000"]` → V523a/b (+V53) · P1 `popDesc` top 150→160 VERDE · P2 `mcSettings` top 150→160 VERDE · P3 `normColor` prefixando `FF` de novo VERDE (registro: §V523 mede LITERAL, ⊥ a função). Hashes restaurados nos 8. **INSTALADO 00:06:52** (3155957 B = `output/`). Se a ficha estava aberta, FECHAR & REABRIR. **Nada commitado**: `SPEC.md` `HANDOFF.md` `localization.lang` `WoD20.6.lfm` `WoD20th.lfm` `verify-hunters-hunted.ps1` & o `.rpk` de `output/` modificados (35º + 36º lotes; árvore limpa era `570a5678`). Scratchpad `44249432…\scratchpad\`: `SPEC.before35.md` `SPEC.before36.md` `HANDOFF.before35.md` `HANDOFF.before36.md`, `spec35\*` & `spec36\*` (blocos exatos das 2 emendas), `battery35.ps1`/`.log`, `battery36.ps1`/`.log`.

**PRÓXIMO:** pedir ao user §T1140 (tela, pt, como narrador): (a) MC OFF: abrir `?`, `!` nota, `!` especialização, picker, picker sobre picker, Settings — TODO o resto (faixa de abas inclusa) preto a 70%, só a janela nítida; clicar no escuro fecha; (b) MC ON c/ 2 personagens: a lista NÃO escurece; c/ `?`/picker aberto clicar OUTRO personagem → a janela FECHA & a ficha troca (0 escrita no personagem novo); (c) picker sobre picker: o 1º picker escurece; (d) o que ficar nítido por cima do escuro; (e) o `!*` piscando: vermelho ou verde-amarelo? (§Q102.1). Depois: `/ck:spec` p/ fechar §T1140/§T1137 & responder §Q102 (rec.: (1) `#99D32F2F` → `#D32F2F99` nos 4 templates de `WoD20.1` + 4 paletas; (2) manter a guarda de `mcShow`). **0 §T de código aberta.**

**O bug & a raiz (§B184):** *"quando abre as janelas, o resto ainda não fica obscurecido"* — 3ª vez. O Firecast lê cor de 8 dígitos como **`#RRGGBBAA`** (plugins do próprio host: `#FFCC66`+`70`, `#FFFFFF`+`A0`, `#707070`+`80`, §R181a); o scrim autorava `#AARRGGBB` desde o 24º ∴ alfa 00 = invisível em 40/50/70%. O tip já tinha sofrido o mesmo (§Q98.1) & foi p/ `opacity` sem ninguém perguntar por quê.

**O QUE VIROU CÓDIGO (§T1138)**
- `WoD20th.lfm` — o `</layout>` de `sheetMain` desceu p/ depois de `mfSearchB` ∴ os 8 overlays (`popScrim` `popDesc` `mcSettings` `popNote` `popSpec` `mfSearch` `popScrimB` `mfSearchB`) são filhos de `sheetMain` (indentação ficou a de antes, cosmético); `popScrim` & `popScrimB` = `align="contents" color="#000000" opacity="0.70" strokeColor="#00000000" visible="false"` + `onClick`; comentário do bloco reescrito (0 hex de 8 dígitos); `mcShow`: `if MF.depth == 2 then mfClose(from); end; mfClose(from); popClose(from);` antes de `setNodeObject`.
- `WoD20.6.lfm` — 4 paletas `["#000000"] = "#000000"` (saiu `#B3000000`); `normColor` `hex .. "FF"`; `NAMED_COLORS` `#000000FF`/`#FFFFFFFF`/`#696969FF`; `sectionBox` compara `"#000000FF"`.
- `verify-hunters-hunted.ps1` (§T1139) — §V389/§V396 blocos SAÍRAM (nota); §V367 (a)(b) sobre `sheetMain`; §V493 título/(a) + **(e)** `mcShow`; §V496(d) `align="contents"` & 0 geometria; §V502(c) `0.70` c/ 2 donos (`popScrimB?`); §V503(a)(b) `#000000`/`0.70`/`contents`; §V316(d) literal `"#000000FF"`; §V523 NOVA (depois de §V522).

**3 gates até o verde nesta rodada (cada um ensinou):** 1º — §V190 (2 `align="client"` irmãos: o 1º desenho, "client em sheetBody", era o que §B41 já proibia → `contents` dentro de `sheetMain`), §V523 (`#FF000000` de `normColor`), §V502c (`0.70` sem dono); 2º — §V316(d) (pinava `#FF000000`); 3º — VERDE. Tudo registrado em §I181a/d/g, §R181 (c corrigido, g), notas em §V190/§V316/§V367/§V502.

**Armadilhas p/ a próxima:** (1) `align="client"` NUNCA como 2º filho do mesmo pai (§V190) — `contents` é o preenchimento total; (2) cor c/ alfa = `opacity=`, & literal de 8 dígitos c/ alfa no FIM (§V523 acende `…00`); (3) `sheetMain` some c/ MC ON & 0 personagem (§V496e) & leva os overlays junto — estado degenerado, anotado em §I181a; (4) as janelas agora são posicionadas em relação a `sheetMain` (c/ a coluna visível andam 370 px p/ a direita); (5) commit só sob pedido.

## ANTERIOR (2026-09-25, fim da 214ª rodada — 35º lote CONSTRUÍDO & INSTALADO: §T1133 §T1134 §T1135 §T1136 `x`; §T1137 (tela [USER]) `.`; §Q101 RESPONDIDA)

**Estado:** gate `-Build -Quiet` **ALL CHECKS PASSED** (146 s, 23:14). Bateria **10/10** (`battery35.ps1`, child process ~88 s/caso): M1 `#80000000` de volta no `popScrim` → V503a (+V53/V493/V503b) · M2 `#80000000` sobrando em 1 paleta → V503a (+V53/V493) · M3 `PÁGINA` no `.lang` → V521a (+V22) · M4 `PÁGINA` no mapa `PT` → V521b (+V22) · M5 `readOnly = not isStoryteller()` de volta em `popOpen` → V522b · M6 `onChange` de volta no `edtPopDesc` → V522a · M7 `savePopDesc` vazia de volta → V522c · M8 passo `descFieldOf` fora de `descFor` → V522d (+V381c) · P1 `popDesc` top 150→160 VERDE · P2 `fontSize` 12→13 VERDE. Hashes restaurados nos 10. **INSTALADO 23:14:45** (3155799 B = `output/`). Se a ficha estava aberta, FECHAR & REABRIR. **Nada commitado**: `SPEC.md` `HANDOFF.md` `localization.lang` `WoD20.6.lfm` `WoD20th.lfm` `verify-hunters-hunted.ps1` & o `.rpk` de `output/` modificados (árvore limpa era `570a5678`). Scratchpad `44249432…\scratchpad\`: `SPEC.before35.md`, `HANDOFF.before35.md`, `spec35\*.txt` (blocos exatos da emenda), `battery35.ps1` + `battery35.log`.

**PRÓXIMO:** pedir ao user §T1137 (tela, pt, como narrador): (a) MERITS & FLAWS lêem `PÁG.`; (b) `?` numa qualidade c/ texto: digitar ⊥ muda nada, fechar/reabrir → igual; (c) `?`, `!` de nota, `!` de especialização, picker, picker sobre picker, `Settings` da coluna — o resto MAIS escuro (70%), só a janela aberta nítida; (d) anotar o que fica NÍTIDO por cima do escuro (botão, campo, combo, abas, coluna) → responde §Q101.2 (se vazar, é o host pintando controle nativo por cima do retângulo: `<popup>` nativo c/ `backOpacity`, lote NOVO, §I169j). **0 §T de código aberta.** Depois da tela: `/ck:spec` só p/ fechar §T1137 (`x`) & registrar §Q101.2.

**O QUE VIROU CÓDIGO**
- `localization.lang:360-361` — `wod.Page=Pág.` & `wod.PAGE=PÁG.` ([en] `:2661-2662` intactos). `WoD20.6.lfm:404-405` — mapa `PT` `["Page"] = "Pág."` & `["PAGE"] = "PÁG."`.
- `WoD20th.lfm` — `popOpen`: 1 escrita só (`found["edtPopDesc"].text = txt`), sem `descQuiet`, sem `readOnly`; SAÍRAM `savePopDesc` (função + comentário), `popRow` (3 sítios + o comentário órfão que o descrevia antes do bloco `Esc fecha os 2 overlays`), `onChange="savePopDesc(self);"` do `edtPopDesc`; comentários de `escClose`, `descFieldOf`, `savePopNote` & do XML de `popNote` reescritos (1 menção a `savePopDesc` FICA, no comentário de `descFieldOf`, dizendo que saiu). `popScrim` & `popScrimB` `color="#B3000000"`; comentário do scrim SEM o hex.
- `WoD20.6.lfm:3257 :3329 :3361 :3406` — `["#B3000000"] = "#B3000000"` nas 4 paletas; `#80000000` c/ 0 ocorrência nos 12 `.lfm`. ⚠ a prova `B3000000 == 6` de §T1135 contou LINHAS: são **10** ocorrências (chave+valor × 4 paletas + 2 scrims) em 6 linhas.
- `verify-hunters-hunted.ps1` — §V503(a) `#B3000000` + perna "0 `#80000000`" (cabeçalho & Pass dizem 70%); bloco (f) de §V365 SAIU (nota de aposentadoria no lugar; `$sav365` fora; (g) cita só (c); Pass ajustado); §V249/§V250 (`:9926`) & §V266 (`:11050`) sem a perna `LuaFn 'savePopDesc'` (Pass & comentários ajustados); §V521 & §V522 NOVAS logo depois de §V520 (`Á`/`á` por code point, `-cne`); comentários de §V265/§V377 que citavam `savePopDesc` como dono ganharam "gone since the 35th batch".

**0 desvio do spec.** Achado da bateria (⊥ pendência, só registro): §V22 compara o mapa `PT` c/ o `.lang` por VALOR — M3/M4 acenderam V22 além de V521 ∴ §V521 ⊥ é redundante c/ ela: V22 mede "iguais entre si", V521 mede "o que o user pediu".

## ANTERIOR (2026-09-25, 214ª rodada — 35º lote ESPECIFICADO: §I180, §R180, §V521, §V522, §T1133…§T1137, §Q101 ABERTA; NADA construído)

**PRÓXIMO COMANDO:** `/ck:build §T1133 §T1134 §T1135 §T1136` — ⚠ ⊥ `--all` (§T1137 é TELA [USER]). Ordem: §T1133 (`.lang` + mapa `PT`) · §T1134 (`WoD20th.lfm`, Lua + 1 atributo XML do `?`) · §T1135 (`WoD20th.lfm` XML dos 2 scrims + 4 paletas de `WoD20.6`) · §T1136 (gate) por ÚLTIMO, sobre a árvore pronta — §T1134 & §T1135 deixam o gate VERMELHO (§V365f, §V249/§V266 em `:9926`/`:11050`, §V503a) até §T1136 ∴ os 4 na MESMA rodada. Depois: 1 `rdk -i` & pedir ao user §T1137 (tela) + as 3 perguntas de §Q101. Ler ANTES: `.\spec-slice.ps1 I180` (a…e), `.\spec-slice.ps1 V521`, `.\spec-slice.ps1 V522`, `grep -n "^R180|" SPEC.md` (spec-slice ⊥ lê R).

**Pedido do user (2026-09-25, 3 itens, 0 bug):** (1) MERITS/FLAWS: `Page` → `Pág.` em pt; (2) as janelas do `?` ⊥ editáveis (*"apenas para consultas"*) — REVOGA §I102i (o `?` destravado p/ o narrador, 2026-08-30); (3) toda janela (`?`, `!`, pickers) escurece o resto a 70% (hoje 50%, `#80000000`, §I172a). MEDIDO (§R180): as 5 janelas + gêmeo do picker JÁ sobem `popScrim`/`popScrimB` ∴ (3) é `#B3000000` em 2 retângulos + 4 paletas; (2) é DELETAR (`:4742`, `savePopDesc`, `popRow`, `onChange`), ⊥ acrescentar; (1) é 2 valores no `.lang` + 2 no mapa `PT`. Backup do spec de antes: scratchpad `44249432…\scratchpad\SPEC.before35.md` (& `HANDOFF.before35.md`); os blocos exatos da emenda em `44249432…\scratchpad\spec35\`.

**Armadilhas p/ o build:** (1) `descFor` ⊥ muda (§Q101.1; §V522d cobra os 3 passos) — só a ESCRITA sai; (2) a global `descQuiet` FICA (`noteOpen`/`specPaint`/4 panes a usam, §V500c/§V505d) — sai só o par em volta de `edtPopDesc.text` em `popOpen`; (3) `escClose :4660` (`from.readOnly ~= true`) FICA — serve `edtMfDesc`; (4) `#80000000` ! sumir dos 4 mapas `fill` (perna nova de §V503a) & `#B3000000` ! entrar nos 4 (§V53); (5) o gate é ASCII — `Á`/`á` de §V521 por code point (`[char]0x00C1`/`0x00E1`, §V384) & `-ceq` (PowerShell ignora caixa por padrão); (6) `.lang`/`.lfm` CRLF UTF-8 sem BOM: `Edit`, nunca `sed -i` (§B74); (7) §V365(f) SAI inteiro (`:18194-18220` + `$sav365 :18123`) — ⊥ inverter perna a perna dentro de §V365; (8) mutações M1…M8 + 2 sondas RODADAS (§V222), ≤3 por chamada, `*>&1`; (9) commit só sob pedido — a árvore estava LIMPA (`570a5678`, 22:16) & esta rodada só tocou `SPEC.md` & `HANDOFF.md`.

**Gate `-Quiet` c/ o spec novo:** **ALL CHECKS PASSED** (59 s, 22:34, checado ao fim desta escrita; §V425 & §V318 leram o spec novo). **0 §T de CÓDIGO construída nesta rodada.** **Nada commitado.**

## ANTERIOR (2026-09-25, fim da 213ª rodada — 34º lote CONSTRUÍDO, INSTALADO & TELA OK: §T1128 §T1129 §T1131 §T1132 `x`; §T1130 CANCELADA; **§T tem 0 linha aberta**)

**Estado:** gate `-Build -Quiet` **ALL CHECKS PASSED** (147 s, 21:30). Bateria **4/4** (`battery34.ps1`, child process ~90 s/rodada): M1 (twin fora de `PICKER_NOSORT`) VERMELHA em §V350e + §V520a + §V520b · M2 (`cboHedgeAttr` → `cboHedgeattr`) VERMELHA em §V520a — & TAMBÉM em §V297/§V312 (checks por nome; ⊥ §V421/§V211 como §V520 previa → emenda abaixo) · P1 (`cboGame` fora do roster) VERMELHA em §V350e + §V520b c/ §V520a VERDE (a perna mede a REDE, ⊥ o roster) · P2 (`cboGameMc = "leading"` em `PICKER_ANCHOR`) só §V419, §V520 INTEIRA VERDE. Hashes de `WoD20.6`/`WoD20.7` = os de antes da bateria. **INSTALADO 21:39:02** (3157291 B = `output/`). Se a ficha estava aberta, FECHAR & REABRIR. **Nada commitado**: `SPEC.md` `HANDOFF.md` `WoD20.6.lfm` `verify-hunters-hunted.ps1` & o `.rpk` de `output/` modificados. Scratchpad `9d217500…\scratchpad\`: `SPEC.before34.md`, `HANDOFF.before34.md`, `battery34.ps1` + `battery34.log`, `battery-backups\*.pre-battery34.lfm` + `pre-battery34.hashes.txt`, `edit-file.ps1` + `lua-edit-T1128.txt` + `gate-edit-T1129.txt` (as edições exatas).

**PRÓXIMO:** nada de código pendente — **§T tem 0 linha aberta** (user 2026-09-25: *"tudo aprovado, faça o que precisa fazer para concluir tudo, incluindo os specs restantes"* → §T1131/§T1132 `x`; §Q100 ENCERRADA sem reparo: 0 ficha em `Mage` relatada). A emenda do build foi APLICADA no SPEC na mesma rodada (§V520 M2 → §V297/§V312; §R179g; §B183 fechado; §I179e nota). Gate `-Quiet` VERDE c/ o spec final. **Pendente só de COMMIT (⊥ pedido explicitamente):** `SPEC.md` `HANDOFF.md` `WoD20.6.lfm` `verify-hunters-hunted.ps1` & o `.rpk` de `output/` — árvore limpa era `e9652f89`.

**O QUE VIROU CÓDIGO**
- `WoD20.6.lfm:2504` — `PICKER_NOSORT = { cboGame = true, cboSheetTheme = true, cboGameMc = true, cboSheetThemeMc = true };` (1 linha) + comentário `:2492-2503` (4 nomes, §B183, por que o twin herda ∀ roster & por que fica em 1 linha).
- `verify-hunters-hunted.ps1` — §V350e (`:16489` `$want350` c/ os 4; FAIL text `:16491`; comentário `:16481-16484`); **§V520 NOVA** `:16517-16574` (depois de §V350, antes de §V351): `(?s)` no literal, ARRAY + `-ccontains`/`-cmatch`/`-cne`, censo `//comboBox[@name]` SEM filtro de `visible`, `$(` pulado & contado; hoje examina 2 (`cboClan` `cboHedgeAttr`) & 2 pares.

**EMENDA do build APLICADA (2026-09-25, mesma rodada, a pedido do user):** §V520 em M2 acende §V297 & §V312 (⊥ §V421/§V211) — está na linha de §V520; §R179g (tela) & o fecho de §B183 idem. 0 emenda pendente.

**⚠ SESSÃO CONCORRENTE (medido nesta rodada):** outra sessão (`scratchpad ba7ad769…`) especificou & construiu um §B183/§V520 DIFERENTE p/ o mesmo bug (teoria MC ON: `current = MC.root[field]` em `pickerItems` + `mcShared` no `mcInit`) entre 19:49 & 20:06, INSTALOU às 20:08 (3157389 B) & o repo foi REVERTIDO às 20:25 (código, gate & SPEC voltaram ao HEAD `e9652f89`) — mas o `.rpk` INSTALADO continuou sendo o dela até este install (21:39). Se o user relatou sintoma entre 20:08 & 21:39, era essa versão na tela. Os ids §B183/§V520 no SPEC de HOJE são os desta rodada (1 de cada, conferido). Antes de nascer id novo: `grep -c "^B<n>|"` & `grep -c "^V<n>:"` no SPEC & olhar `ls Temp\claude\*\scratchpad\battery*.ps1` das outras sessões.

## ANTERIOR (2026-09-25, 213ª rodada — 34º lote ESPECIFICADO: §B183, §I179, §R179, §V520, §T1128…§T1132, §Q100 RESPONDIDA)

**PRÓXIMO COMANDO:** `/ck:build §T1128 §T1129` — ⚠ ⊥ `--all` (os `.` restantes são TELA [USER]). **§T1128 ANTES de §T1129** (o gate de hoje, §V350e, cobra `PICKER_NOSORT` == exatamente `cboGame` & `cboSheetTheme` ∴ o Lua novo fica VERMELHO até o gate ser emendado — os 2 na MESMA rodada); §T1130 CANCELADA (§Q100 respondida: 0 semente, 0 escrita automática em `game`). Depois: 1 `rdk -i` & pedir ao user §T1131/§T1132 (tela). Ler ANTES: `.\spec-slice.ps1 I179` (a…f), `.\spec-slice.ps1 V520`, `.\spec-slice.ps1 B183`, `grep -n "^R179|" SPEC.md` (spec-slice.ps1 so le T/B/V/I, nao R).

**Bug do user (2026-09-25):** ficha abre num tema & o box da aba Storyteller mostra OUTRO; reabrir → tela = o que estava no box, box = outro; c/ `multipleCharacters` OFF. Causa MEDIDA no fonte (§B183): os twins `cboGameMc`/`cboSheetThemeMc` da janela de settings da coluna (24º lote) ⊥ estão em `PICKER_NOSORT` ∴ `pickerItems` grava neles a lista ORDENADA 1× por abertura, & a rede de §V424 ⊥ os alcança (`fieldRoot` → `sheetThemeMc`, `current` nil). O host (`?`, §R179e) grava o valor do índice antigo ∴ `sheetTheme` anda 1 posição por abertura (pt: MN→VA→CA→MN, Dark Ages fixa) & `game` alterna `Vampire ⇄ Mage` (combo travado, sem conserto na tela → §Q100 RESPONDIDA: *"não é para elas mudarem sozinhas"* ∴ 0 semente; ficha em `Mage` só por reparo MANUAL, a decidir se §T1131 achar alguma). Verificado por 5 leitores independentes (0 refutação). Backup do spec de antes: scratchpad `9d217500…\SPEC.before34.md` (& `HANDOFF.before34.md`).

**Armadilhas p/ o build:** (1) o literal `PICKER_NOSORT` FICA em **1** linha (§V350e o lê c/ `(?m)…(.*?)\};`); (2) §V520 lê o literal c/ `(?s)`, usa `-cmatch`/`-ccontains`/`-cne` (PowerShell ignora caixa por padrão) & um ARRAY, ⊥ `@{}`; censo XML SEM filtro de `visible` (o twin mora em `mcSettings` `visible="false"` — §V421 filtra, ⊥ copiar); 0 `$` de fim de linha sobre texto de arquivo (CRLF); (3) mutações M1 M2 P1 P2 de §V520 RODADAS, ≤3 por chamada, `*>&1`, reverso único; (4) ⊥ mexer em `fieldRoot`/`pickerItems` (§I179b explica por quê); (5) o comentário `WoD20.6:2492-2495` diz "two combos" — vira 4; (6) §T1130 CANCELADA — 0 mudança em §V110 nem no bloco `WoD20th:10152-10160`; (7) commit só sob pedido — a árvore estava LIMPA (`e9652f89`, 19:08) & esta rodada só tocou `SPEC.md` & `HANDOFF.md`.

**Gate `-Quiet` VERDE c/ o spec novo** (checado ao fim desta escrita). **0 §T de CÓDIGO construída nesta rodada.** **Nada commitado.**

## ANTERIOR (2026-09-25, fim da 212ª rodada — 33º lote CONSTRUÍDO: §T1122…§T1126 `x`)

**TELA OK (user 2026-09-25, "todos os testes estão ok, pode fechar todos"):** as **102** linhas abertas do §T (72 `[USER]` + 30
testes/sondas de tela sem a marca, §T114…§T1127) → `x`. **§T tem 0 linha aberta.** Backup de antes: scratchpad
`b25e575f…\SPEC.before-close-tests.md`. **§V508d EMENDADA** (desvio abaixo, a pedido do user) + nota em §I178b. **§B182** (NOVA): fechar as 102 acendeu §V410 — o
zero-guard contava linhas ABERTAS como prova de que o parser lê o §T; agora conta ∀ linha (`.` `~` `x`), §V410 EMENDADA, gate
consertado & provado (M0 VERDE, M1 parser-quebrado VERMELHA, hash restaurado). **Spec em dia com o código; 0 pendência.** **0 §T de CÓDIGO em aberto.** **Nada commitado.** §Q99 RESPONDIDA
(*"siga suas recomendações"*, registrada no §C).

### 33º LOTE CONSTRUÍDO (212ª) — `/ck:build §T1122 §T1123 §T1124 §T1125 §T1126`
Gate `-Build -Quiet` **ALL CHECKS PASSED** (74 s, 18:02). Bateria **23/23**: M0 VERDE, 18 mutações VERMELHAS no check certo, 4
sondas VERDES, 0 erro de setup, hashes dos 4 `.lfm` = os de antes. **INSTALADO 18:03:18** (3156533 B = `output/`). Se a ficha
estava aberta, FECHAR & REABRIR. Scratchpad `b25e575f…\scratchpad\`: `*.before33.lfm` (4),
`gate.before33.ps1`, `SPEC.before33build.md`, `battery33.ps1` (+ `battery33.log`, `pre-battery33.hashes.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20.6.lfm` — `bang` depois de `ornament` nas 4 paletas; `["#99D32F2F"]` nas 4 `fill`; `bangAccent` pinta `t.bang`.
- `WoD20.1.lfm` — nos 4 templates de spec: `hit…` 1º filho & `blinkSp…` logo depois do `btnSp…`; fundo do `specTip` `0.80`; 1
  comentário FORA dos templates explicando os 2. `WoD20.2.lfm` — `hit…` 1º filho de `OpenAbility`/`MeritPicked`; `noteTip` `0.80`.
- `WoD20th.lfm` — `BANG_BLINK_MS`/`BANG_BLINK` & `bangBlink` antes de `specBangPaint`; os 3 laços de `specBangPaint` chamam 1
  pintor local `bang(sfx, key)` (texto, destaque & piscar de 1 `!`) & o timer arma no fim; `renderBearing` escreve `nm.visible`
  (Ghoul|Vampire, estrito); `'game', 'stShowDisciplines'` no `<dataLink>` da Road.
- `verify-hunters-hunted.ps1` — §V517 (faz a conta HSL da complementar) §V518 §V519 NOVAS; §V516 REESCRITA (+ perna d);
  §V501a/§V513f `0.80`; §V476b de volta a 2 donos (saiu o corte por pai); §V515a `t.bang`; §V287 admite `hit*`/`blinkSp*` só
  como filho direto de `<template>`; §V508d (desvio abaixo).

**DESVIO DO SPEC NO BUILD → EMENDA PENDENTE p/ `/ck:spec`:**
1. **§V508d cobrava `setInterval` 1× na FICHA** (o animador das linhas) & o timer do piscar é o 2º → o gate passou a contar
   ∀ `setInterval(` MENOS `setInterval(bangBlink, BANG_BLINK_MS)` (que §V518c pina em 1, dentro de `specBangPaint`). O spec do
   33º ⊥ previu a colisão (§I178b cita o precedente `rowTween` & ⊥ a perna que o pina). Mutação M18 da bateria cobre.

## ANTERIOR (2026-09-25, 211ª rodada — 33º lote ESPECIFICADO)

`/ck:spec` + §Q99 respondida. Backup do spec de antes: scratchpad `b25e575f…\SPEC.before33.md`.

### 33º LOTE ESPECIFICADO (211ª) — `!` na complementar, `!*` piscando, tip a 80%, Road só Ghoul|Vampire, tip na linha inteira (§I178)
`/ck:spec` 1×: §C (33º lote), §Q99 ABERTA, §I178a…f, §R178a…g, §V517/§V518/§V519 NOVAS, §V516 REESCRITA, §B181, §T1122…§T1127,
emendas em §I177a/b/c/d §V68 §V287 §V476 §V501 §V510 §V512 §V513 §V514 §V515. **As 5 emendas pendentes do build do 32º (abaixo)
foram APLICADAS nesta escrita.** Gate `-Quiet` VERDE c/ o spec novo.
- **Armadilhas p/ o build:** (1) `bang` é VALOR de paleta (≡ `ornament`), ⊥ chave de `font`; `bangAccent` lê `t.bang`; (2) o `button`
  do SDK ⊥ tem cor de fundo — o vermelho é um `<rectangle blinkSp…>` POR CIMA do `!` c/ `hitTest="false"` (`?` na tela); a cor
  `#99D32F2F` ! entrar nas 4 `fill` (§V53) & o retângulo ! autorar `strokeColor="#00000000"` (senão `applyTheme` desenha o
  contorno da época) → §V287 ganha os prefixos `hit…`/`blinkSp…`; (3) `bangBlink` para SOZINHO (`r.handle == nil` & `return false`)
  — 0 handler de fechar (§V475f); `BANG_BLINK` global (§V347, raiz a 3 do teto); (4) `hit…` é o 1º filho (ATRÁS) de cada template,
  `align="contents"`, c/ o `<cat>`/`<campo>` do `!` do MESMO template (§V510b compara); 0 comentário em `<template>` (§B19);
  (5) `0.50` volta a 2 donos — o corte por pai que o build do 32º pôs em §V476 SAI junto c/ o `0.80`; (6) Road: `'game'` &
  `'stShowDisciplines'` no `<dataLink>` de `road`/`humanity_*`, predicado ESTRITO `== true` (§B103); (7) regex .NET
  `(?m)…[^\r\n]*$` ⊥ casa em CRLF (32º); (8) sonda de §V ! ser RODADA (§B178).

## ANTERIOR (2026-09-25, 210ª rodada — 32º lote CONSTRUÍDO: §T1117 §T1118 §T1119 §T1120 `x`)

**Estado:** INSTALADO 16:09:57; §T1121 (tela) segue `.`. **0 §T de CÓDIGO em aberto** até o 33º lote. Os 5 desvios abaixo foram
APLICADOS ao spec na 211ª.

### 32º LOTE CONSTRUÍDO (210ª) — `/ck:build §T1117 §T1118 §T1119 §T1120`
Gate `-Build -Quiet` **ALL CHECKS PASSED** (72 s, 16:08). Bateria **25/25**: M0 VERDE, 20 mutações VERMELHAS no check certo, 4 sondas
VERDES, 0 erro de setup, hashes dos 4 `.lfm` = os de antes. **INSTALADO 16:09:57** (3136312 B = `output/`). Scratchpad
`b25e575f…\scratchpad\`: `*.before32.lfm` (4), `gate.before32.ps1`, `SPEC.before32build.md`, `before32.hashes.txt`,
`battery32.ps1` (+ `battery32.log`, `pre-battery32.hashes.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20th.lfm` — `TIP_CHAR_W` `TIP_TEXT_MAX` `TIP_PAD` `TIP_BAR` (globais, logo depois de `NOTE`); `noteTipMove` mede pelo maior
  parágrafo (`lens`/`longest`), `tip.width = TIP_PAD + tw + TIP_PAD + TIP_BAR`, `lbl.width = tw`; `edtMcSettingsKey` último filho
  de `mcSettings` (fora do scope); `mcSettingsOpen` arma & foca; `kbRefocus` (roster + ramo por último) & `escClose` (roster +
  laço do `popClose`) c/ `mcSettings`; `onClick`/`onChange` = `kbRefocus(self);` nos 8 checkBox & 4 comboBox vivos;
  `noteBangPaint` NOVA (depois de `noteButton`) + chamada no fim de `renderBgButtons`/`renderMeritButtons` & em `savePopNote`;
  `specBangPaint` monta `named` & chama `bangAccent` nos 3 laços; `renderBearing` sem `fam`/`open`/`cboRoad`/`visible`.
- `WoD20.1.lfm`/`WoD20.2.lfm` — `fontSize="12"` nos 2 rótulos de tip; fundo `color="black" opacity="0.50"`; `fontColor="white"`
  nos 6 `!`. `WoD20.6.lfm` — `bangAccent` NOVA logo depois de `paint`; `specBangPaint(from); noteBangPaint(from);` no fim de
  `applyTheme`; comentário da chave `#80000000` sem o tip.
- `verify-hunters-hunted.ps1` — §V513…§V516 NOVAS no fim; §V330(b) APOSENTADA c/ nota; §V512c 4 chamadas; §V510a c/ `opacity` &
  `fontSize`; §V501a `black` + `0.50`; §V476b 4 donos; §V68 corta os 2 fundos pelo nome do pai (== 2).

**DESVIOS DO SPEC NO BUILD → EMENDAS PENDENTES p/ `/ck:spec`** (o build só vira status de §T):
1. **§I177b/§V514: o receptor é `top="481" height="4" opacity="0.75"`, ⊥ `482`/`16`.** O XML do spec acendeu 2 §V vigentes no 1º
   gate: §V240/§V280 (482 + 16 = 498 deixa **2** px de pé na janela de 500; o piso é 15) & §V111/§V244 (texto só-leitura lê a
   0.75). 481…485 fecha o pé em 15. A sonda de §V514 vira `top 481 → 480` (VERDE, RODADA — a do spec, 482 → 484, ⊥ vale mais).
2. **§V515(b) do gate cobra TAMBÉM o corpo dos 2 pintores** (0 `.fontStyle =`/`.fontColor =` em `specBangPaint`/`noteBangPaint`):
   a mutação do próprio spec (`btn.fontColor = "#C2A14D"` em `noteBangPaint`) ⊥ nomeia `btnSp`/`btnN` na linha ∴ a perna
   escrita como está ⊥ a pegaria.
3. **Só §V68 contava os fundos pretos como caixa** — corte `$tipFloorCut68` pelo nome do pai, contado == 2. §V40/§V287/§V375 ⊥
   acenderam. (Na M6, `xradius` no fundo acende TAMBÉM §V280/§V298/§V314: vira caixa de seção — esperado.)
4. **§V476b no gate**: o passe XML amarra cada `opacity="0.50"` de `<rectangle>` ao pai `noteTip`/`specTip` (conta == 2) & o passe
   de linha deixa passar SÓ a linha XML exata do fundo — o retângulo ⊥ tem nome p/ o passe de linha ver.
5. **MEDIDO (candidato a §R):** no Lua gerado (`WoD20th.lfm.lua` dentro do `.rpk`), ∀ `<script>` das abas roda no construtor
   ANTES do 1º `addEventListener` (raiz :7727, `WoD20.6` :51860, 1º listener :54678) & sob o MESMO `_ENV` ∴ global de `WoD20.6`
   chamada de handler do raiz ⊥ precisa de guarda `~= nil` — `bangAccent` é chamada sem. (As guardas velhas de
   `translateSheetText`/`repaintXpDots` sobram, mas ⊥ foram tocadas.) Também: `longest` começa em 1 — nota só de linhas vazias
   daria `tw = 0` & divisão por 0 (§I177a ⊥ disse).

**Armadilha medida:** regex .NET `(?m)^…[^\r\n]*$` ⊥ casa em arquivo CRLF (o `$` multiline para antes de `\n`, ⊥ de `\r`) — o
1º gate de §V515c deu VERMELHO falso por isso; tirar o `$` final.

## ANTERIOR (2026-09-25, 209ª rodada — 32º lote ESPECIFICADO & §Q98 RESPONDIDA; NADA construído)

**PRÓXIMO COMANDO:** `/ck:build §T1117 §T1118 §T1119 §T1120` — ⚠ ⊥ `--all`: os outros `.` do §T são TELA [USER] (§T1121 & os
velhos) & o `--all` varre ~90 linhas p/ achar 0 construível. §T1117 (`WoD20th.lfm`), §T1118 (`WoD20.1` + `WoD20.2`), §T1119
(`WoD20.6`) são arquivos DISJUNTOS; §T1120 (o gate) por ÚLTIMO, sobre a árvore pronta. Depois: 1 `rdk -i` & pedir ao user §T1121
(+ §T1114/§T1108/§T1109, tela, ainda `.`). **Git:** o 31º lote & §T1116 estão no commit `522eaf06` (14:56, "no message" — ⊥ feito
por esta sessão); o 32º (só `SPEC.md` & `HANDOFF.md`) está SEM commit. Ler ANTES: `.\spec-slice.ps1 I177` (a/b/c/d/e + as emendas no fim
da linha a), `.\spec-slice.ps1 V513` … `V516`, `.\spec-slice.ps1 B180`.

### 32º LOTE ESPECIFICADO (209ª) — tip na largura do texto, Esc no Settings, `!` em destaque, texto da Road (§I177)
`/ck:spec` 2×: (1) §C (32º lote), §Q98 ABERTA, §I177a…e, §R177, §V513…§V516, §B180, notas em §V330 (b APOSENTADA) §V405 §V510
§V512 §I170h §I99d, §T1117…§T1121; (2) §Q98 RESPONDIDA — (2)(3)(4) como recomendado; **(1) c/ acréscimo**: tetos 400/160 FICAM,
o texto ⊥ invade a barra, & o FUNDO dos 2 tips vira a cor das caixas da época a 50% (`color="black" opacity="0.50"`) → §I177a,
§V513 (e)(f), §V501a, §V476b (4 donos de `0.50`), §V510a EMENDADAS & §T1118/§T1119/§T1120/§T1121 REESCRITAS. Backups scratchpad
`fa7d14ae…\SPEC.before32.md` & `SPEC.before32b.md`.
- **Causas MEDIDAS (§R177):** (1) o tip mede `chars * 6` sobre o texto INTEIRO & um rótulo sem `fontSize` → estreito p/ letra larga;
  (2) `mcSettings` tem 0 controle de texto & o Esc só chega em texto focado (§V405); (3) `applyTheme` repinta a cor de ∀ texto do
  original gravado & `THEMES` é local de `WoD20.6` → o destaque passa por `bangAccent` lá, pela porta `paint`; (4) **§B180**: a §T876
  deixou a trava da Road escrevendo em `found["cboRoad"]` (nil) & o texto c/ `visible = open` → sem clã, picker aberto & texto sumido.
- **Armadilhas p/ o build:** (1) `bangAccent` ! morar em `WoD20.6` (os locais da paleta) & ser GLOBAL; `specBangPaint`/`noteBangPaint`
  ! rodar DEPOIS da varredura de `applyTheme` (§B179 p/ cor); (2) os 6 `!` autoram `fontColor="white"` — sem cor autorada a guarda
  de §B21 em `paint` recusa a escrita & o destaque ⊥ aparece, calado; (3) §V330(b) do gate cobra `fam ~= nil and fam ~= ""` em
  `renderBearing` — sai JUNTO c/ o Lua (§T1120), senão vermelho; (4) `TIP_*` globais (§V347); (5) 0 comentário em `<template>`
  (§B19); (6) o receptor de Esc é `textEditor` `readOnly` (≡ `edtPopDesc`, o precedente MEDIDO); (7) `onChange` nos combos de
  `mcSettings` dispara por troca de nó — `kbRefocus` sem overlay visível ⊥ foca nada; (8) o fundo PRETO do tip (`color="black"`)
  pode acender check que conta retângulo preto como caixa — isentar pelo nome do pai (≡ §V40 linha ~1211, §V375 ~5765, §V287
  ~8083, que JÁ isentam `noteTip`/`specTip`); o `0.50` acende §V476 até o gate ganhar os 2 donos novos; (9) PowerShell: `$T`/`$t`
  & `$P`/`$p` são a MESMA variável (2 scripts pararam por isso no 31º); `IndexOf` c/ `[StringComparison]::Ordinal`; (10) sonda de
  §V ! ser RODADA contra o gate atual (§B178: 2 sondas mortas pegas no 31º — `top` de `btnXpApply` & o local `filled`); (11) o gate
  leva ~66 s/rodada (~110 s c/ `-Build`) ∴ bateria de ~20 mutações ≈ 25 min em background (`battery31.ps1` do scratchpad é o molde:
  aplica/reverte em `finally`, 1 par por linha, `*>&1`, hashes antes/depois).

## ANTERIOR (2026-09-25, 208ª rodada — 31º lote CONSTRUÍDO: §T1110 §T1111 §T1112 §T1113 §T1115 `x` + §T1116 `x` (209ª), gate VERDE, `.rpk` INSTALADO 14:32:40)

**PRÓXIMO COMANDO:** pedir ao user os testes de TELA **§T1114** (tooltip na linha inteira, `!*`, `?` apagado) + **§T1108/§T1109**
(do 30º, ainda `.`) — FECHAR & REABRIR a ficha antes. **§T1116 FEITA na 209ª** (rodada própria, `/ck:build --all`): as 4 chaves `["#55FFFFFF"]` + as 3 linhas de comentário
delas SAÍRAM de `WoD20.6.lfm` (0 leitor antes, `grep`), gate `-Build -Quiet` VERDE (112 s), INSTALADO 14:32:40 (3131764 B =
`output/`). **0 §T de CÓDIGO em aberto** — o resto do §T `.` é tela [USER]. (Linha velha, p/ histórico: as 4 chaves
órfãs de paleta em `WoD20.6.lfm`). §T1096/§T1101 seguem `.` (tela). **Nada commitado** — o working tree tem o 31º inteiro.

### 31º LOTE CONSTRUÍDO (208ª) — §T1110 §T1111 §T1112 §T1113 §T1115 `x` (`/ck:build`)
Gate `-Build -Quiet` **ALL CHECKS PASSED** (103 s, 14:10). Bateria §V510/§V511/§V512/§V500e/§V501c: **18/18 mutaÃ§Ãµes VERMELHAS no check certo & 3/3 sondas VERDES, 0 erro de setup**, backups
restaurados (hashes = `after31.hashes.txt`). **INSTALADO 14:12:18** (3132098 B = `output/`). Se a ficha estava aberta, FECHAR &
REABRIR. Scratchpad `fa7d14ae…\scratchpad\`: `*.before31.lfm` (7), `gate.before31.ps1`, `SPEC.before31*.md`; scripts `t1110.ps1`,
`t1111-15.ps1` (+ `t1111.lua.txt`), `t1113.ps1` (+ `v510-512.ps1.txt`), `battery31.ps1` (+ `battery31.log`).

**O QUE VIROU CÓDIGO**
- `WoD20.1.lfm` — `specTip`/`specTipScroll`/`dynSpecTip` (último filho do `<scrollBox>` raiz; ≡ `noteTip` c/ nomes PRÓPRIOS, §R176);
  `Attribute`/`AttributeZeroable`/`Ability`/`CustomAbility`: nomes `lbl$(field)`, `dot$(field)_k`, `edt$(field)` + `onMouseMove`/
  `onMouseLeave` em ∀ controle visível (28; `Ability` passa a expressão VIVA `self.abil$(col)$(num)_1.field`).
- `WoD20.2.lfm` — `OpenAbility`/`MeritPicked`: `dot$(field)_k`, `edtBook_`/`edtType_`/`edtCost_$(num)` + eventos (12); pickers c/ a
  guarda `rowDragMove` intacta.
- `WoD20th.lfm` — `NOTE` sem `found`/`NOTE_NAMES` (+ `tipText`); `noteTipMove` acha tip & controle por `from[nome]` (0 `xpFind`),
  tip do `cat` (`specTip`|`noteTip`), texto 1× por linha, `NOTE.hold = true` a cada mexida; `noteTipHide` esconde os 2 num laço;
  `specTipText` & `specBangPaint` NOVAS (globais); `noteTipHide(from)` em `specOpen`/`noteOpen`; `specBangPaint(from)` no topo de
  `renderSpecialities`; `noteButton(found["btnQ…"], v)` + roster em `renderBearing` `renderHeaderButtons` `renderBgButtons`
  `renderMeritButtons` `renderClanFamilyButton` (7 pares).
- `WoD20.3.lfm` (3 pares) · `WoD20.7.lfm` (4) · `WoD20.11.lfm` (5) — `noteButton` do `?` ao lado de cada `mfLabel`, `btnQ…` no roster.
- `WoD20.6.lfm` — `specBangPaint(from)` como última instrução de `applyLanguage` (§B179) & de `renderAbilityLabels`.
- `verify-hunters-hunted.ps1` — §V510, §V511, §V512 NOVAS; §V500e (definição + 3 `!` + 1 por `?`), §V501c (0 `xpFind`) EMENDADAS;
  §V40, §V375 & §V287 isentam `specTip` por nome exato (≡ `noteTip`).

**SPEC nesta rodada** (`/ck:spec` 3× + backprop do build): §Q97 RESPONDIDA (+ pedido `!*`), §I176 (a/c/d reescritas, h nova), §R176,
§V143/§V510/§V512 (+§V476 §V509 §I175h §I174c §I175b §I175e §T1104 — as 6 emendas do 30º), §B178, **§B179** (a tradução de
`WoD20.6` regrava o texto de ∀ `button` fora de `dyn*` ∴ o `!*` precisa de repintura depois dela), §T1115/§T1116 novas, & notas
de build em §V511 (par `dynMerit_m` ⇄ `btnQmerit_m`; a sonda "renomear `filled`" era MORTA — §V500e pina — trocada), §I176a
(isenções do gate), §I176c (`NOTE.hold` & o laço de `noteTipHide`), §I176h (chamada no topo de `renderSpecialities`).

**Armadilhas medidas nesta rodada**
- As abas são `<import>` INLINE: ∀ controle nomeado de ∀ aba é campo do MESMO `obj` raiz (`WoD20th.lfm.lua:12`, `:14700`) ∴ nome
  NOVO ! ser único na FICHA (o 2º `obj.<nome> =` sobrescreve) & `from[nome]` acha qualquer controle a partir do `self` de handler
  (§R176, §V143 EMENDADA).
- `applyLanguage` regrava texto de botão ⊥ `dyn*` c/ o texto da 1ª passada (§B179) — todo texto de botão pintado por Lua precisa
  de nome `dyn*` OU de repintura depois dela.
- PowerShell: `$T`/`$t` & `$P`/`$p` são a MESMA variável — 2 scripts pararam por isso (0 dano, `throw` antes de gravar). O
  sintoma pareceu `IndexOf` culture-sensitive & ⊥ era (testado: os 2 modos acham).
- O gate subiu p/ ~66 s por rodada (era ~40) ∴ bateria de 21 rodadas ≈ 25 min em background.
- §V59 JÁ cobra nome único ENTRE os `.lfm` (o `rdk` morre calado, §B19) — acendeu na M3 da bateria; nome novo repetido é pego
  pelo gate antes do `rdk`.

### 31º LOTE ESPECIFICADO (208ª) — tooltip da `!` na linha inteira, `!*` & `?` apagado no vazio (§I176)
`/ck:spec` 2×: (1) §C (31º lote), §Q97 ABERTA, §I176a…g, §V510/§V511, §T1110…§T1114, notas em §V500/§V501/§I170g/§I170h;
(2) §Q97 RESPONDIDA (*"faça exatamente o que você recomendou"* + pedido NOVO `!*`), §I176 (cabeçalho) & §I176a/c/d REESCRITAS,
§I176h NOVA, §R176 NOVA, §V143 EMENDADA, §V510 REESCRITA, §V512 NOVA, §T1110/§T1111/§T1113/§T1114 REESCRITAS, §T1115/§T1116
NOVAS, §B178 NOVA, emendas em §V476 §V509 §I175h §I174c §I175b §I175e §T1104. **Nada commitado.** Backups: scratchpad
`fa7d14ae…\scratchpad\SPEC.before31.md` (antes da 1ª escrita) & `SPEC.before31b.md` (antes da 2ª).
- **O pedido (user 2026-09-25):** (1) hover em QUALQUER ponto da linha de um traço c/ `!` (rótulo, `!`, `?`, bolinhas) mostra o conteúdo
  da janela do `!`; especialização só c/ a bolinha MARCADA & c/ nome; (2) `?` de valor vazio apagado ≡ o `!` de nota; (3) especialização
  comprada|ganha SEM nome → o `!` do traço vira `!*` até ganhar nome.
- **Medida que mudou o desenho (§R176):** as abas são `<import>` INLINE — ∀ controle nomeado de ∀ aba é campo do MESMO `obj` raiz &
  o `self` de ∀ handler é esse `obj` ∴ `from[nome]` acha qualquer controle (precedente `self.abil…_1.field`) & nome ! ser ÚNICO na
  FICHA: o tip de `WoD20.1` chama `specTip`/`specTipScroll`/`dynSpecTip`, ⊥ `noteTip`. §V143 EMENDADA (2ª forma aceita & fechada).
- **Armadilhas p/ o build:** (1) 0 comentário dentro de `<template>` (§B19); (2) §V347: `specTipText` & `specBangPaint` GLOBAIS;
  (3) os pickers `dyn…` de `WoD20.2` MANTÊM `if not rowDragMove(self, event) then noteTipMove(…) end;` (§V508b); (4) o 4º argumento
  de `Ability` é a expressão VIVA `self.abil$(col)$(num)_1.field` (§I172d); (5) §V501c hoje cobra `NOTE.found = NOTE.found or xpFind(`
  & §V500e cobra 3 chamadas de `noteButton` — o gate (§T1113) muda JUNTO c/ o Lua; (6) `specTipText` varre 325 linhas ∴ SÓ na troca
  de chave, ⊥ por pixel (§V510c); (7) nomes novos (`lbl…`, `dot…`, `edt…`, `edtBook_…`) — conferir unicidade no gerado ANTES.

### 30º LOTE CONSTRUÍDO (207ª) — §T1102…§T1107 `x` (`/ck:build --all`)
Gate `-Build -Quiet` **ALL CHECKS PASSED** (123 s, 2026-09-25 11:06). Bateria §V508/§V509/§V502c/§V476b/§V489c/§V499c:
**18/18 mutações VERMELHAS no check certo & 3/4 sondas VERDES** (P4 = sonda MORTA do SPEC, ver emenda 1), backups restaurados
(`battery-backups\` vazio, 0 resíduo por grep). **INSTALADO 2026-09-25 11:08:01** (3097777 B = `output/`). Se a ficha estava
aberta, FECHAR & REABRIR. **Nada commitado.** Backups de antes do build no scratchpad `63daf4d3…\scratchpad\`:
`WoD20th.before30.lfm`, `WoD20.2.before30.lfm`, `WoD20.7.before30.lfm`, `WoD20.11.before30.lfm`, `WoD20.3.before30.lfm`,
`gate.before30.ps1`, `SPEC.before30build.md`; hashes `before30.hashes.txt`/`after30.hashes.txt`; bateria `battery30.ps1`
(+ `mutfn30.ps1`, log `battery30.log`); scripts de edição `t1102.ps1`, `t1103-5.ps1`, `t1106.ps1`, `t1107.ps1` (+ blocos
`dragblock.lua`, `mcblock.lua`, `v508v509.ps1.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20th.lfm` — §T1102: sonda FORA (0 `PROBE`/`ROW_PROBE`/`rowDragAte`/`rowDragDown`/`rowDragUp`/`ROW_DRAG_MIN`; `:9118`
  "PROBE SLICE" é prosa alheia & ficou), `d.hoverId` (memo por linha), vigia em `rowTween` (`ROW_WATCH_TICKS = 20`,
  `ROW_WATCH_MAX = 4`; lê `ROW_DRAG.live` LITERAL — §V508d cobra o literal, `d.live` acendeu o gate na 1ª M0),
  `rowDragMove` = `return ROW_DRAG.live == true;`, `rowDragStart` chama `rowTweenStart()`, re-arme em `rowDropEnter` quando
  a vigia desistiu. §T1106: `ROW_LISTS` c/ 11 entradas MOVIDA p/ depois de `RITUAL_FREE_ROWS` (`:2870` — os laços leem
  `DISC_ROWS`…`RITUAL_VACANT`, declaradas DEPOIS do lugar velho; o chunk roda de cima p/ baixo), `rowOrderRepair(saved, ids)`
  extraída, `MC_ROW_TOP0 = 4`/`MC_ROW_PITCH = 114` ao lado de `MC_POOL`, `MC_KEEP` + `mcOrder`, `mcIdOf` `mcOrderOf`
  `mcAnimTo` `mcRowOrderApply(from, instant, found)` `mcDragInstall` `mcDragStart` `mcDropEnter` `mcDropCommit`
  (+ `MC_DRAG_INSTALLED`) logo depois do bloco das listas; `mcRender` carimba `mcId` (`if mcIdOf(n) == nil then`), `0.50`
  no `mcOn_` & termina em `mcRowOrderApply(from, MC_DRAG_INSTALLED ~= true, found)`; `<dataLink field="mcOrder"
  onChange="mcRowOrderApply(self, false);"/>` dentro de `mcSettingsScope`; o `<dataLink fields>` das ordens c/ os 11.
- `WoD20.2.lfm` — `onMouseDown`/`onMouseUp` FORA dos 2 pickers, `onClick` = `mfOpen(…)` puro, comentário reescrito.
- `WoD20.7.lfm` (59 `dragRow_`, `numina_1` anônima) · `WoD20.11.lfm` (56, `clanDisc_*` anônimas; `sortRituals`/`sortQuiet`/
  `flashRitual`/`ritualRank` & o `<rectangle name="hl$(field)">` FORA; `<dataLink>` dos rituais só `guardPick`) ·
  `WoD20.3.lfm` (11 `dragRow_attack_<num>`) — `onStartDrag` nos 8 templates, nota FORA de cada template (§B19).
- `verify-hunters-hunted.ps1` — §V508 REESCRITA (11 listas nos 4 `.lfm`, ids derivados c/ VACANT & `numina` de 2, 10
  templates de alça, 0 nome aposentado no texto CRU dos `.lfm`, `rowDragMove` literal, `<dataLink>` derivado de
  `ROW_LISTS`), §V509 NOVA (5 pernas + zero-guard), §V502c → 0.50 & `0.70` proibido, §V476b → 2 donos (`btnXpApply`,
  `mcOn_`; conta só `.opacity =`), §V489c `[not(self::dataLink)]`, §V499c + `mcOrder`, §V252/§V253 → 1 nota de
  aposentadoria (0 check), `$luaOwned` + 10, `$LUA_OPACITY` − `0.70`, comentário de §V204 sem `sortRituals`.

**DESVIOS DO SPEC NO BUILD (APLICADOS 2026-09-25 na 208a pelo `/ck:spec`)** (o build só vira status de §T):
1. §V476 sonda `top="47"` → `48` em `btnXpApply` ! **⊥ é VERDE**: acende §V479d (pina o `top` em 47). Sonda MORTA no
   texto de §V476 — rec.: tirar a sonda de §V476 & apontar p/ a de §V479 (§B novo: sonda herdada sem reconferir).
2. §V509b/c: `mcRowOrderApply` ⊥ chama `rowOrderRepair(` direto — chama `mcOrderOf()` (que faz `rowOrderRepair(MC.root.mcOrder,
   ids)`); & o `.top` de `mcRow_` é escrito em `mcAnimTo` (≡ `rowAnimTo`), ⊥ em `mcRowOrderApply`. O gate cobra ASSIM.
3. §I175h(3): `mcRowOrderApply(from, instant, found)` — 3º parâmetro OPCIONAL (o `found` do `mcRender`, p/ ⊥ andar a árvore
   2× por pintura); o `<dataLink>` & a vigia chamam c/ 2, `mcDropCommit` c/ 3.
4. §I174c/§I175b: `ROW_LISTS` mora depois de `RITUAL_FREE_ROWS` (`:2870`), ⊥ "junto de `MERIT_ROWS`" (motivo acima).
5. §I175e/§T1104: `ritualRank` (`local function`, só o sort lia) saiu junto; as 4 chaves `["#55FFFFFF"]` das paletas de
   `WoD20.6.lfm` ficaram ÓRFÃS (§V53 só cobra autorado → paleta) — rec.: apagar em rodada própria.
6. §I175h(4): o dado da coluna é `drag:addData("wodChar", <mcId>)` (chave `wodChar`, valor = o id), ⊥ a string `"wodChar|<mcId>"`;
   `rowDropEnter` lê `wodRow` & `mcDropEnter` lê `wodChar` — as chaves diferentes SÃO a recusa cruzada (§V509d).

**Armadilhas medidas nesta rodada**
- `.ps1` do scratchpad SEM BOM: um `⚠` dentro de here-string ⊥ casa (PowerShell 5.1 lê o arquivo como ANSI) — `t1103-5.ps1`
  parou ANTES de escrever (o `throw` vem antes do `WriteAllText`, 0 dano). Âncoras só ASCII; texto não-ASCII vai num arquivo
  à parte lido c/ UTF-8 (`dragblock.lua`, `mcblock.lua`, `handoff30.md`).
- `grep -c $'\r$'` dentro de `$( )` no Bash tool devolve 0 à toa — contar CR c/ `tr -cd '\r' | wc -c`.
- Bateria: ~38 s por rodada do gate em processo filho ⇒ 5 por chamada cabem no teto de 10 min; 22 rodadas em 5 chamadas.

### 30º LOTE ESPECIFICADO (206ª) — arrasto do host em 9 listas + coluna a 50% (§I175) & §I174/§V508 REESCRITAS (§B176/§B177)
`/ck:spec` só: §C (30º lote, §Q95 em parte, §Q96 ABERTA c/ 5 perguntas & rec.), §I3 (+10 LUA-OWNED), §I174 REESCRITA (b/d/e/i),
§I175a…k, §R174 (host drag MEDIDO), §R175 (as 9 listas HOJE), §V508 REESCRITA, §V509 NOVA, §V252 REVOGADA, §V476b & §V502c
EMENDADAS, §B176, §B177, §T1102…§T1109 (+ §T1101 SUBSTITUÍDA). **Nada commitado por mim** (outra sessão commitou `1d29ca9b`
01:02 c/ a árvore do momento). Backup de antes: scratchpad `d30d1769…\scratchpad\SPEC.before30.md`.
- **⚠ O `.rpk` INSTALADO (00:59:48, 3097312 B) é a SONDA do 29º:** arrasto por `onStartDrag` FUNCIONA (9 arrastos medidos), mas
  carrega 19 `wodTrace("PROBE …")` & a guarda `rowDragAte()` que COME o clique seguinte a cada arrasto (§B177). O gate está
  VERMELHO nesta árvore (§V508 antiga cobra `onMouseDown`/`rowDragUp`; o gate ainda é o do 29º). **PRÓXIMO:** `/ck:build`
  §T1102…§T1107 numa rodada (§T1102 & §T1106 os 2 em `WoD20th.lfm` — ⊥ paralelizar; §T1103/§T1104/§T1105 são 1 arquivo cada;
  §T1107 o gate) → 1 install → pedir ao user §T1108 & §T1109 (tela) + a resposta de §Q96.
- **O que MUDOU de mecanismo (ler §R174 antes de tocar no Lua):** com o botão apertado o host ⊥ entrega `onMouseMove` (o
  `TRExtInputHelper` do Firecast é dono do aperto) — arrasto = `onStartDrag` no picker (`drag:addData("wodRow", "<lista>|<id>")`)
  + `onStartDrop` em ∀ controle de ∀ linha (instalado por atribuição `ctrl.onStartDrop = fn`, recursivo, 1× por ficha) que chega
  POR PIXEL & por polling (memo `d.hoverId` obrigatório) + `drop:addAction("wodRow", cb)`; o `cb` roda 1× no soltar; 0 gancho de
  cancelamento (vigia por silêncio em `rowTween`: 20 tiques × 4); 0 `onClick` depois de arrasto (a guarda SAI); 1 `onMouseMove`
  avulso c/ `y` fora do botão logo após o `onStartDrag` (o portão da dica `rowDragMove` devolve `ROW_DRAG.live`).
- **Armadilhas p/ o build:** (1) `rowDropInstall` é 1× por ficha (flag) & roda do `onNodeReady` do raiz — ∀ lista nova tem de
  estar em `ROW_LISTS` ANTES (registro por aba nunca ganha drop site); (2) ids DERIVADOS pulando `PSYCHIC_VACANT` {16…19} &
  `RITUAL_VACANT` {21…25}, & `numina` começa em 2 c/ `top0 = 61` (`numina_1` pinada); `attack` `top0 = 61` (cabeçalho em 36);
  (3) `DiscRow` & `HedgePicker` são templates PARTILHADOS c/ linhas que ⊥ arrastam (`clanDisc_*`, `numina_1`) — `rowDragStart`
  RECUSA por `rowPosOf = nil` ANTES de `addData` (§V508e); ⊥ criar template irmão; (4) §V347: o chunk do raiz está a 3 do teto
  de locais — tudo global (≡ `ROW_DRAG`); (5) §V242: prosa sem `--` — `if not x then` de 4 palavras acende o check (usar
  `~= true`); (6) `mcOrder` é escrito em `MC.root` (⊥ `setField`: `sheet` pode ser um filho) & o `<dataLink field="mcOrder">`
  vai DENTRO de `mcSettingsScope` (pinado à raiz em `mcInit`), ⊥ em `stSharedScope` (§V489c compara o conjunto de `field=`);
  (7) `0.50` colide c/ §V476b — o gate emenda p/ 2 donos nomeados JUNTO c/ o código (§T1107), senão vermelho; (8) §V252 (auto-
  ordem dos rituais) SAI c/ `sortRituals`/`sortQuiet`/`flashRitual`/`hl$(field)` — o check do gate vira aposentado c/ nota;
  (9) comentário DENTRO de `<template>` = `rdk -l` exit 1 mudo (§B19) — 10 templates recebem atributo, 0 comentário;
  (10) `mcOrder = true` em `MC_KEEP` (senão `mcWipe` apaga ao remover a raiz, §V499c) & `mcId` escrito SÓ em `mcRender` (lazy;
  `mcAdd` intacto — §V492a proíbe `n.x =` lá) & `rowOrderRepair(saved, ids)` EXTRAÍDA de `rowOrderOf` (soldada a `sheet`);
  (11) `<rectangle>`/`<image>`/`label`/`dataScopeBox` como fontes de `onStartDrag` ⊥ têm precedente (só `<button>`/`<form>`) —
  §T1109(g) anota de quais a linha arrastou; se só o `X` arrastar → `<button>` transparente sobre a linha (rodada própria); (12) §V252 & §V253 saem JUNTAS do gate (§V253 lê `flashRitual`/`hl`); §V489c
  passa a ler só widgets (`[not(self::dataLink)]`); (13) o gate HOJE está 4× VERMELHO em §V508 (esperado: §V508 velha) —
  reescrever o gate sobre a árvore pronta, M0 VERDE, só então a bateria; sondas = edições estáticas (⊥ cenário de runtime);
  (14) `ROW_LISTS` c/ chaves NOMEADAS (`order = …, prefix = …`) — forma posicional deixa `L.order` nil.
- **§Q96 RESPONDIDA pelo user 2026-09-25:** (1) rituais: auto-ordem SAI; (2) CLAN DISCIPLINES ⊥ arrasta; (3) `numina_1` pinada;
  (5) contorno 0.50 c/ 2 donos do literal — as 4 como recomendadas; **(4) MUDOU:** a alça é QUALQUER ponto da área do personagem
  (foto inclusive) → `mcDragInstall` põe `onStartDrag` por atribuição em TODO controle da linha (menos o `<edit>` do nome:
  seleção de texto, ≡ o combat tracker) & `onStartDrop` em todos; **0** `onStartDrag=` no XML de `McRow` (§I175h(4), §V509d).

### 29º LOTE CONSTRUÍDO (206ª) — §T1097…§T1100 `x` (`/ck:build --all`)
Gate `-Build -Quiet` **ALL CHECKS PASSED** (61 s, 2026-09-25 00:00). Bateria §V508/§V502e: **11/11 mutações VERMELHAS no check certo & 2/2 sondas VERDES**, hashes dos 4 arquivos mutados = os de antes.
**INSTALADO 2026-09-25 00:00:53** (3093572 B = `output/`). Se a ficha estava aberta, FECHAR & REABRIR. **PRÓXIMO:** pedir ao user **§T1101** (tela) junto de
§T1096/§T1090/§T1083/§T1080/§T1074, que seguem `.`; & a resposta de §Q95 (4 perguntas). **Nada commitado.** Backups de antes
do build no scratchpad `d30d1769…\scratchpad\`: `WoD20.2.before29.lfm`, `WoD20th.before29.lfm`, `WoD20.6.before29.lfm`,
`localization.before29.lang`, `gate.before29.ps1`; bateria: `battery29.ps1` (+ `mutfn29.ps1`, log `battery29.log`, hashes
`battery29.hashes.txt`).

**O QUE VIROU CÓDIGO**
- `WoD20.2.lfm` — os 43 `<layout>` de linha com `name="dragRow_<field>"`; `dyn$(field)` (OpenAbility) & `dynMerit_$(num)`
  (MeritPicked) com `onMouseDown`→`rowDragDown`, `onMouseUp`→`rowDragUp`, `onMouseMove` = `if not rowDragMove(…) then
  noteTipMove(…); end;`, `onClick` = `if not rowDragAte() then mfOpen(…); end;`; comentários FORA dos templates.
- `WoD20th.lfm` — `ROW_LISTS` (+ `prefix`) & `ROW_DRAG_MIN`/`ROW_TWEEN_MS`/`ROW_TWEEN_K` logo depois de `MERIT_ROWS`;
  `rowOrderOf` `rowOrderApply` `rowDragDown` `rowDragMove` `rowDragUp` `rowDragAte` `rowTweenStart` `rowTween` depois de
  `noteTipHide`; `rowOrderApply(self, true)` no `onNodeReady` junto de `renderBgButtons`; `<dataLink fields="{'orderBackground',
  'orderMerit', 'orderFlaw'}">` → `rowOrderApply(self, false)`. Coluna: `Blood Pool`, rótulos 117, barras 205/133;
  `MC_BARS.blood.label = "Blood Pool"`.
- `WoD20.6.lfm:87` & `localization.lang:2307/4603` — chave `Blood` RENOMEADA p/ `Blood Pool` (pt `Reserva de Sangue`).
- `verify-hunters-hunted.ps1` — §V508 nova (5 pernas + zero-guard); §V502(e) lê `Blood Pool` + (e2) folga +6 + (e3) dica =
  rótulo + valor pt pinado nos 2 lados; §V501(b) aceita o `onMouseMove` guardado; `$luaOwned` + os 3 campos de ordem.

**DESVIOS DO SPEC NO BUILD → EMENDAS PENDENTES p/ `/ck:spec`** (o build só vira status de §T):
1. §I174d/§I174h dizem "tabela Lua LOCAL `ROW_DRAG`": saiu GLOBAL (`ROW_DRAG`, `ROW_ANIM`, `ROW_TICKING`). §V347 — o chunk
   do raiz estava a 3 do teto REAL de 53 locais & os 3 `local` acenderam o check; global aqui é POR FICHA (o `_ENV` é
   religado no topo do script, §V487a) ∴ o que "local" queria dizer (⊥ NDB, ⊥ compartilhado) segue valendo.
2. §I174c: as entradas de `ROW_LISTS` ganharam `prefix` (`background_` · `merit_` · `merit_`) — os flaws moram em
   `merit_f*`, & o nome da linha é `dragRow_` .. prefix .. id. §V508(a) lê o `prefix`.
3. §V501(b) EMENDADA no gate (previsto em §T1097): o regex aceita `^(if not rowDragMove\(self, event\) then )?noteTipMove(`;
   a guarda em si é cobrada por §V508(b). A linha de §V501 no SPEC ainda diz `^noteTipMove(`.
4. §V145 conta SÓ os laços `for i = 1, BACKGROUND_ROWS, 1 do` (os 2 do XP): o laço dos ids usa `rowI`, o mesmo expediente
   do `for noteI = 1, BACKGROUND_ROWS` que já existia.
5. §V242 (prosa sem `--`): `if not d.dragging then` casa com a heurística (4 palavras, 0 pontuação Lua) → saiu
   `if d.dragging ~= true then`. Armadilha p/ quem escrever Lua aqui.
6. `rowOrderApply(…, true)` também zera o alvo pendente da linha em `ROW_ANIM` (senão um tween velho a arrastaria de volta).
7. Bateria: + M11 (onMouseMove do MeritPicked sem a guarda ! VERMELHO por §V508b), além das 7 + sonda de §V508 & das 3 +
   sonda de §V502.

### 29º LOTE ESPECIFICADO (206ª) — arrastar Backgrounds/Merits/Flaws + `Blood Pool` na coluna (§I174)
`/ck:spec` só: §C (29º lote + §Q95 ABERTA, 4 perguntas c/ rec.), §I3 (+3 LUA-OWNED), §I173b ⚠, §I174a…i, §R173, §V502
EMENDADA, §V508 NOVA, §T1097…§T1101 (+ nota ⚠ em §T1096). **0 código tocado, nada commitado.** Backup de antes: scratchpad
`d30d1769…\scratchpad\SPEC.before29.md` & `HANDOFF.before29.md`.
- **PRÓXIMO:** `/ck:build` §T1097…§T1100 (§T1097 em `WoD20.2`; §T1098 & §T1099 os 2 em `WoD20th.lfm` — ⊥ paralelizar;
  §T1100 no gate) → 1 install no fim → pedir ao user §T1101 (tela) junto de §T1096/§T1090/§T1083/§T1080/§T1074.
- **Pedido (3) do user (janelas escurecem a 50%) JÁ ESTÁ construído** (27º lote, §R173g: os 5 que abrem janela sobem
  `popScrim`, `mfSearchB` tem `popScrimB`, §V503d deriva) → 0 §T; quem responde é §T1090(a)(b)(c); §Q95.1 pergunta.
- **Desenho:** a ordem é VISUAL — o dado FICA no slot & só o `top` do `<layout name="dragRow_<field>">` muda; a ordem mora
  em `orderBackground`/`orderMerit`/`orderFlaw` (LUA-OWNED, escrita 1× ao soltar). Tween = `setInterval` 15 ms × 0,35.
- **Armadilhas p/ o build:** (1) ⊥ mover VALOR de campo entre slots — o log de XP é derivado POR SLOT (`baseline` + chaves
  `background_k#nível`, §R173b) & o gasto mudaria calado; (2) `self` nos handlers é o FORM da aba (§R134) & `xpFind` devolve
  SÓ os nomes pedidos (§B167) — os `dragRow_` saem de 1 `xpFind` no `rowDragDown` & ficam em `ROW_DRAG`, ⊥ por pixel;
  (3) o host dispara `onClick` DEPOIS do arrasto (o botão veio junto c/ o cursor) — sem `rowDragAte()` o soltar abre a busca;
  (4) o `onMouseMove` do picker já é da dica (`noteTipMove`) — `rowDragMove` vem ANTES & guarda, & §V501 lê esse atributo;
  (5) comentário DENTRO de `<template>` = `rdk -l` exit 1 mudo & `.rpk` apagado (§B19); (6) `Blood` → `Blood Pool` é
  RENOMEAR a chave nos 5 lugares (§I174g), ⊥ criar 2ª; (7) 110/198/140 & `'Blood'` moram também no gate (§V502e) — mudam
  junto em §T1100.

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
