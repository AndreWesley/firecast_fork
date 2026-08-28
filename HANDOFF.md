# HANDOFF — estado antes do próximo `/ck:build`

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
