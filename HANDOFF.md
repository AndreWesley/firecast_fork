# HANDOFF — estado antes do próximo `/ck:build`

Escrito 2026-08-19, atualizado 2026-08-20 (fim da **63ª rodada**, que levou §T446 de 70/284 a
**123/284** — `core` inteiro + 53 do `rob`). A 61ª FECHOU §T445 (64/64).
Para um Claude que abre a sessão sem contexto.

## COMECE AQUI

### ⚠ `/ck:build` SEM ARGUMENTO RESOLVE ERRADO — exigir `T446`

O skill lê: *"`--all` ou vazio → every `.` row in §T order"*. Mas **§T446 está `~`, ⊥ `.`**
(fica `~` do começo ao fim das 284 entradas) ∴ um `/ck:build` pelado **PULA a tarefa real**
e começa em **§T114**. Contagem exata das 28 linhas `.` do §T hoje:

| quantas | quais | o que são |
|---|---|---|
| 23 | `T260` `T264` `T269` `T277` `T282` `T296` `T307` `T315` `T323` `T342` `T354` `T359` `T364` `T371` `T377` `T381` `T387` `T397` `T406` `T414` … | **`teste no Firecast`** — são do USER (família §T450). Claude ⊥ executa |
| 2 | `T114` `T159` | `?` antigos, fora de escopo há rodadas |
| 3 | `T470` `T448` `T449` | trabalho REAL, mas vêm DEPOIS de §T446 |

∴ o pedido certo é **`/ck:build T446`**. Se vier pelado, ⊥ obedecer a ordem
literal do skill: assumir §T446 & DIZER que assumiu. `--next` também erra — pega a linha
`~` de menor número, e ∃ `~` velho de bookkeeping (`T26` `T29` `T49` `T50` `T289`
SUPERSEDED · `T326` CANCELADO · `T281` `T306` `T314` bumps de versão · `T153` `T239`
`T252` `T421` provas no Firecast). **⊥ ∃ `~` real além de §T446.**

Sobrou **~7 comandos `/ck:build`**, e **~4 deles são §T446**. Tudo o mais está
fechado: ⊥ ∃ portão aberto, ⊥ ∃ drift de spec, gate verde, `.rpk` gerado E instalado.

```bash
cd "c:/Users/awlol/OneDrive/Documents/firecast_fork"
powershell -NoProfile -ExecutionPolicy Bypass -File ./verify-hunters-hunted.ps1 | tail -2
grep -c "	x$" research/path_pages.tsv research/ritual_pages.tsv
```

O 1º ! dizer `ALL CHECKS PASSED`. O 2º é o PROGRESSO da tarefa grande que sobrou — ele mora
no mapa, **⊥ no `SPEC.md`** (o §T fica `~` do começo ao fim das 284 entradas).

| §T | arquivo | mapa de progresso | feito | retomar em |
|---|---|---|---|---|
| ~~T444~~ | `HH.12.lfm` | `research/disc_pages.tsv` | **36 / 36 · `x` no SPEC** | — |
| ~~T445~~ | `HH.13.lfm` | `research/path_pages.tsv` | **64 / 64 · `x` no SPEC** | — |
| T446 | `HH.14.lfm` | `research/ritual_pages.tsv` | **123 / 284** | qualquer linha `.` — ver ↓ |

**§T446 ⊥ tem "retomar em".** As 161 que faltam ⊥ são um sufixo: o `core` inteiro (70) e
metade do `rob` (53) já foram, e estavam ESPALHADOS pelo mapa. ∴ o lote se escolhe por
LIVRO, ⊥ por posição — **e o desta rodada já está escolhido, ↓**. Sobram: **`rob` 66 ·
`da` 42 · `tos` 35 · `lotc` 11 · `dac` 4 · `lob` 2 · `bh` 1.**
O que sobrou do `rob` são as seções TEMÁTICAS espalhadas (pp. 23-30 Tremere moderno · 37-38
Assamita/Abismo · 62-69 as 4 escolas Anarquistas · 76-77 Assamita · 83-84 Setita · 89-94
Necromancia · 101-109 Tal'Mahe'Ra), ⊥ a lista genérica — essa foi inteira na 63ª.

### O PRÓXIMO LOTE JÁ ESTÁ ESCOLHIDO E CONFERIDO: `da`, 42 rituais

⊥ precisa decidir nada. A 63ª rodada abriu o `_Vampiro V20 - Dark Ages - Livro Base.pdf`
(offset 1) e conferiu os 3 blocos. São contíguos e cabem num comando, ≡ os 2 lotes anteriores:

| bloco | pág. impressa | quantos | dona |
|---|---|---|---|
| Mistérios do Abismo | 271-274 | 12 | `Abyss Mysticism` |
| Necromancia | 292-296 | 11 | `Necromancy` |
| Taumaturgia | 303-311 | 19 | `Thaumaturgy` |

```bash
awk -F'\t' 'NR>1 && $4=="da" && $6=="."' research/ritual_pages.tsv | sort -t$'\t' -k5n
```

**As 3 REGRAS DE CONJURAÇÃO deste lote já foram extraídas — ⊥ recaçar, e ⊥ reusar a de
Taumaturgia nas outras 2:**

- **`Thaumaturgy` (DA p.303)** — ⊥ é igual à do core p.228: o DA COBRA SANGUE.
  *"Unless otherwise noted, casting rituals requires the expenditure of one blood point,
  five minutes per level to cast, and a successful Intelligence + Occult roll, for which
  the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is
  required for a ritual to work…"*
- **`Necromancy` (DA p.292)** — *"To perform a ritual correctly, a player must succeed at
  an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual,
  maximum 9. Failure produces no effect, but a botch may produce disastrous results."*
- **⚠ `Abyss Mysticism` (DA p.271) ⊥ TEM ROLAGEM DE ESCOLA.** *"Abyss Mystic rituals are
  different from other forms of blood sorcery rituals, as they are based on use of a
  Discipline and not magic."* **Cada ritual declara a rolagem DELE** (`Pierce the Veil` =
  Percepção + Ocultismo dif. 8; `Eyes of the Abyss` = Inteligência + Ocultismo dif. 6 depois
  de um teste de Rötschreck…). O que entra na entrada é a regra de APRENDIZADO, ⊥ de rolagem:
  exige Ocultismo 3; ⊥ pode aprender ritual de nível acima do seu Obtenebração **ou**
  Ocultismo; sem especialização de Ocultismo em Abyss Mysticism, **+1 de dificuldade em cada
  ritual**; custa 3 XP por nível; muitos conferem Defeito como efeito colateral, e esse
  Defeito ⊥ dá XP nem pontos de bônus.
  **Colar a linha de Taumaturgia numa entrada de Abismo é INVENTAR REGRA.**

Detalhes de extração deste lote, já vistos: os títulos de ritual do Abismo vêm com bolinha
(`• Pierce the Veil`), ⊥ secos ≡ os outros; e o `Abyss Mysticism` tem ritual de nível **6·7·8**
(§V184 já prevê — ⊥ "conserte" o prefixo).

A última coluna do mapa é o `x`\|`.`. Ordem do value do picker em cada um (`sort` C).
Os mapas já dão **livro + página impressa dos 384 itens** — extração paga e validada
(as 70 páginas que o §I19 tinha à mão bateram 70/70; e as chaves casam 1:1 com o `values=`
do picker, conferido na 59ª). **⊥ reextrair.**

**Antes de escrever a 1ª entrada, leia 4 seções NESTA ORDEM** (a 1ª é a que impede o erro
que mais custa caro):

1. *§T446 QUEBRA o passo 4 da receita* (↓) — **o passo 4 de §T444/§T445 põe a entrada no
   lugar errado no `HH.14.lfm`, calado.** Ler ANTES da receita, ⊥ depois.
2. *O que a 63ª rodada ENSINOU* & *O que a 62ª rodada ENSINOU* (↓) — as armadilhas que as
   2 rodadas de §T446 pagaram: a regra de conjuração por escola, ritual sem descrição
   própria, coluna de jornal fundindo 2 rituais.
3. *A RECEITA que fechou §T444* (↓) — passos **1·2·3** valem intactos; **4·5·6 ⊥ valem**
   p/ §T446 (ver item 1).
4. *Forma das 384 entradas* (↓) — o literal exato que o §V192 mede.

§T444 fez 36 entradas, §T445 fez 46 + 18, §T446 fez 68 + 53 — sem 1 falha de gate.

O código de livro do mapa (`core` `rob` `tos` `da` `bh` `lotc` `dac` `lob`) vira TÍTULO
pela tabela em **`research/README.md` → "Código de livro → título para o bloco 1 de §I21"**,
que também dá o offset de página e o nome do `.pdf`. **⊥ inventar título de livro.**

Depois dela: **T470** (2º corpo de `DESC` por época) · **T448** (checks §V172…§V189) ·
**T449** (version `4.9`→`5.0` + build + install) · **T450** (teste de aceitação, do user).

**⊥ commite** sem o user pedir naquela mensagem. Ver *Regras do projeto que mordem*, ↓.

## LEIA ISTO ANTES DE BUILDAR

**O `SPEC.md` foi reconciliado com o código na 57ª rodada** (`/ck:spec` de 2026-08-20).
§I19 · §I20 · §V184 · §I23 · §C · §I10b batem com o `.lfm` — conferidos número a número.
**⊥ ∃ drift de spec aberto.** §T472 fechou o rename `Caminho`→`Trilha` na 58ª rodada.
1 drift NOVO, pequeno & já sabido: §I19/§I20 dizem **66** trilhas & o picker tem **64**
(2 têm 2 donas ∴ §V14 dedupa). Contagem de posse ≠ contagem de item; ⊥ "conserte" o XML.

O que a 57ª rodada gravou no spec, para você ⊥ reabrir a discussão:

| onde | o que ficou registrado |
|---|---|
| §I19 | valor de `RITUAL_DISC` é LISTA sempre; 13 dos 284 têm 2 donas; extração fechada em 284 |
| §V184 | prefixo casa `^[1-9]\. ` — `Abyss Mysticism` tem ritual 6·7·8·9 porque ⊥ tem trilha nenhuma |
| §I20 | `Daimonion` é o canônico — 1ª exceção declarada ao "core vence" de §C |
| §I23 | `ADVANCED_DISC`, 192 poderes de nível 6–9, DORMENTE, ⊥ muda a ficha |
| §C · §I10b | `Path` de blood sorcery = `Trilha`. **`path` é HOMÔNIMO** & §B15 vale por SENTIDO: `Trilha` p/ vampiro, `Caminho` p/ magia estática (númina), `Caminho` p/ `Road` do Dark Ages. Check que medir 1:1 por string EN nasce errado |

## Onde está o quê

- **`research/`** — o que foi extraído dos 8 livros, p/ ⊥ pagar de novo:
  - `disc_pages.tsv` · `path_pages.tsv` · `ritual_pages.tsv` — **livro + página impressa
    dos 384 itens**, + a coluna de progresso de §T444/§T445/§T446. Validado 70/70 contra
    as páginas que o §I19 tinha à mão, e 1:1 contra o `values=` dos pickers (59ª rodada)
  - **`README.md` → "Código de livro → título para o bloco 1 de §I21"** — a tabela que
    traduz `core` `rob` `tos` `da` `bh` `lotc` `dac` `lob` p/ o TÍTULO que o bloco 1 exige,
    + offset de página + nome do `.pdf`. `disc_pages.tsv` grava por extenso, os outros 2
    gravam CÓDIGO ∴ §T445/§T446 dependem desta tabela
  - `d36.list` · `paths.tsv` · `rd_*.tsv` · `adv_*.tsv` — as listas congeladas em §T430
  - `findpage.sh` · `mapritual.sh` — os geradores dos mapas. Precisam de `research/txt/*.idx`,
    que **⊥ está no repo** (é texto de livro); o `README.md` de lá tem o comando de regerar
  - **`rebuild_ritual_desc.sh`** (62ª rodada) — o sort-merge que ESCREVE a tabela `DESC` do
    `HH.14.lfm`. **§T446 ! usar ele**, ⊥ o append de §T444/§T445 (a chave de ritual ⊥ é
    sufixo alfabético ∴ append cai no lugar errado, calado). Receita ↓ e no `README.md` de lá
  - **Leia `research/README.md` ANTES de reextrair qualquer coisa** — ele lista 6 armadilhas
    que já custaram tempo, incluindo as 3 que o gerador de página errou sozinho
- **`SPEC.md`** — fonte da verdade. §I19 §I20 §I21 §I22 §V184 §V192 §V196 §V197 §C §I10b
- **`verify-hunters-hunted.ps1`** — o gate, na raiz de propósito (fora da pasta que o
  `rdk` empacota). ASCII puro: PowerShell 5.1 lê `.ps1` sem BOM como ANSI
- **`HH.12.lfm`** — as 36 entradas de §T444 são o MODELO vivo da forma de §I21. Ao escrever
  §T445/§T446, copiar a forma de lá (`Auspex` p/ entrada cheia c/ tabela, `Fortitude` p/
  entrada curta) em vez de reinterpretar o §I21

## O que roda

```powershell
cd "Plugins\Sheets\World of Darkness 20th"
& "$env:LOCALAPPDATA\FirecastSDK3\rdk.exe" -l    # compila + lint
& "$env:LOCALAPPDATA\FirecastSDK3\rdk.exe" -i    # compila + INSTALA no Firecast

cd ..\..\..\..
.\verify-hunters-hunted.ps1                      # o gate
```

Exit 0 sozinho ⊥ prova nada (§B1). As provas são:
- build: `output/World of Darkness 20th.rpk` mudou de **mtime E size**
- install: `%APPDATA%\Firecast\Plugins\ambesek.wod.20th.rpk` com o size do `.rpk` recém-gerado
- `rdk -p` é PREPARE, ⊥ build: sai 0 sem tocar no `.rpk` e ainda reescreve o `module.xml`

Último estado verde: `.rpk` gerado E instalado com **5.509.386** bytes, 2026-08-20 23:25.
Os dois batem — é essa igualdade que prova o install, ⊥ o exit 0.

## Próxima tarefa

**§T444 FECHOU na 59ª rodada** (36/36) & **§T445 FECHOU na 61ª** (64/64), os 2 `x` no
`SPEC.md`. **§T446 está em 123/284** (62ª + 63ª rodada). Sobram **161 rituais**:
mesma forma de entrada, mesmo mapa, mas passo 4 DIFERENTE (sort-merge, ↓).
O que já está de pé e ⊥ precisa ser refeito:

- os 4 pickers de vampiro têm ITEM: 36 disciplinas (`HH.12`) · 64 trilhas (`HH.13`) ·
  284 rituais (`HH.14`). **64, ⊥ 66** — `Hands of Destruction` & `Movement of the Mind`
  têm 2 donas & §V14 manda item único. §I19/§I20 ainda dizem 66; é contagem de LINHA de
  posse, ⊥ de item.
- `cboClan` ∃ em `HH.1`, 60 entradas, DORMENTE (`visible=false` `enabled=false`
  `opacity=0.55`), ⊥ ∃ Lua que escreva `clan`.
- `.lang` + mapa `PT` ganharam **462** chaves (384 itens + 60 clãs + 20 displays de
  `ERA_NAME`). Mapa `PT` = 904 entradas.
- `eraName(v, era)` no form RAIZ & `pickerItems(c, lang, era)` em `HH.6`: `items` = value
  → época → idioma. Chamada de `applyLanguage` **&** de `applyTheme`, ⊥ ∃ 3º gatilho.
- **§B42/§V195**: §V9 & §V24 do gate testavam ASCII puro & reprovavam os 42 nomes
  canônicos com `’` (U+2019). Agora `’` é a ÚNICA exceção & ∃ check novo que recusa `'`
  ASCII em `items=`/`values=` — apóstrofo reto PARTE o item em 2 calado.

### O que a 63ª rodada (§T446, 53 do `rob`) ENSINOU

- **A regra de conjuração do `rob` é UMA SÓ para todas as escolas.** *"The Blood and the
  Will"*, rob p.130: *"for the purposes of this book … Willpower rolls for path powers and
  Intelligence + Occult rolls for all rituals"* — vale p/ Necromancia, Akhu, Koldúnica, tudo.
  ∴ ⊥ procurar um quadro por escola: `Dur-An-Ki` & `Setite Sorcery` do `rob` levam a linha de
  p.130; a Koldúnica tem quadro PRÓPRIO (p.156) que dá a dificuldade explícita; a Taumaturgia
  do `rob` ⊥ muda nada e segue com a linha do core p.228.
- **Título de ritual do `rob` às vezes carrega nível + escola entre parênteses**
  (`Armor of Diamond Serenity (Level One Sadhana Ritual)`). A chave & o bloco 2 levam SÓ o
  nome do picker; o parêntese vira a 1ª frase do corpo (≡ o nome latino de §T445).
- **Coluna de jornal embaralha 2 rituais DIFERENTES na mesma linha.** Em rob p.157-158 o
  `System:` de `Cowing the Servant` e o de `Flatline` saíram intercalados palavra a palavra
  (*"For one week per success, the difficulty of mortal or embarrass some Camarilla Lick…"*).
  Casar na mão lendo as 2 frases separadamente — ⊥ é hifenização, é DUAS colunas fundidas.
  Também aconteceu em `Court of Hallowed Truth` × `Severed Hand` (p.155).
- Custo real: **53 entradas em 1 comando**, `HH.14.lfm` 245 KB → **437 KB** · `.rpk` 5,28 →
  **5,51 MB**. Entrada de `rob` é ~2× a do `core` (tem parágrafo de história antes da regra).

### O que a 62ª rodada (§T446, as 68 do `core`) ENSINOU

- **A REGRA DE CONJURAÇÃO DA ESCOLA ENTRA EM ∀ ENTRADA DE RITUAL.** O texto do ritual quase
  nunca diz o que rolar — ele diz *"the player rolls to activate this ritual as normal"* e
  a regra mora no topo da seção, longe. A caixa da ficha mostra 1 ritual por vez ∴ a entrada
  ! ser autossuficiente. Fica na ÚLTIMA linha do bloco 3, rotulada com a página:
  - Taumaturgia (core p.228): *"Thaumaturgical ritual casting (p. 228): Unless stated
    otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a
    successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of
    the ritual (maximum 9)…"*
  - Necromancia (core p.177): *"Necromantic ritual casting (p. 177): Casting times … vary
    widely … The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual,
    maximum 9)…"*
  - as outras 4 escolas (`Assamite`/`Setite`/`Koldunic`/`Abyss`/`Dark Thaumaturgy`) têm a
    REGRA DELAS — copiar do topo da seção do livro de cada uma, ⊥ reusar a de Taumaturgia.
  Custa ~370 bytes × 2 idiomas por entrada. É duplicação de propósito: ⊥ ∃ como o leitor
  chegar na regra a partir da caixa.
- **Ritual SEM descrição própria ∃.** `Warding Circle versus Lupines`/`versus Kindred`/
  `versus Spirits, Ghosts, and Demons` (core p.234) só existem num QUADRO de 4 linhas que
  diz "iguais ao Círculo contra Carniçais, com o componente da proteção correspondente".
  A entrada leva o quadro VERBATIM + um `System:` que resolve a remissão (componente, raio,
  duração), senão o leitor fica sem nada. Mesma coisa vale p/ `Ward versus Lupines`/`Kindred`/
  `Spirits`, que são 2 linhas cada.
- **Tabela de 2 colunas embaralhada de novo** (§B do §T445 vale igual): `Insight` (sucesso →
  nitidez da visão) e `Dead Man's Hand` (nível de vitalidade → tempo até a próxima perda).
  Vira 1 linha por resultado.
- **O corpo pode sair ANTES do cabeçalho.** Em `Insight` o `pdftotext` imprimiu o fim do
  System ANTES do título, no topo da página. Conferir de qual ritual o parágrafo fala.
- Custo real: **68 entradas em 1 comando**, `HH.14.lfm` 26 KB → **245 KB** · `.rpk` 5,05 →
  **5,28 MB**. Ritual é entrada CURTA mesmo (~1,5 KB × 2) ∴ o lote pode ser grande.

### O que a 60ª & a 61ª rodada (§T445, 46 + 18 entradas) ENSINARAM

- **6 das 64 trilhas são entrada CURTA de 8 linhas.** O `Rites of Blood` p.160 tem um quadro
  *"Other Paths of Dur-An-Ki"* dizendo que 6 trilhas Assamitas são **funcionalmente idênticas** a
  trilhas de Taumaturgia — ⊥ ∃ poder por nível p/ extrair. As 6 estão escritas: `The Covenant of
  Enki` (Neptune’s Might) · `The Hand of the Magi` (Lure of Flames) · `The Laws of Suleiman`
  (Spirit Manipulation) · `The Path of Jinn’s Gift` (Path of Conjuring) · `The Path of Life’s
  Waters` (Path of Blood) · `The Path of the Ailing Jackal` (Path of the Father’s Vengeance).
- **Trilha SEM poder por nível ∃ e ⊥ é a mesma coisa que entrada curta.** `Weather Control` ·
  `The Revelations of Eden` · `The Taking of the Spirit` · `The Way of the Spirit` · `Ushabti` ·
  `The Path of Praapti` trazem 1 linha POR NÍVEL em vez de poder nomeado (o livro diz
  literalmente *"Individual power descriptions are not provided for this path"*). A entrada é
  CHEIA — leva a prosa & o `System:` de topo — mas o corpo dos 5 níveis é 1 linha `• <efeito>`.
- **Regra de SEÇÃO que muda dado rolado entra na trilha** (precedente `Die Herrschaft des Wyrm`,
  aplicado 5× na 61ª): as 3 trilhas Setitas de `tos` levam *"no lugar de Ocultismo, usa-se
  Teologia"* (tos p.61) & as 2 Koldúnicas de `rob` levam a *"Koldunic Sorcery Dice Mechanics"*
  (rob p.156, rolagem de Força de Vontade dif. 3+nível). Sem isso ⊥ ∃ como saber o que rolar,
  porque o `System:` de cada poder ⊥ repete.
- **⊥ ENTRARAM, por serem regra da DISCIPLINA & ⊥ da trilha:** o quadro *"THE CURSE OF
  NECROMANCY"* (tos p.58, Defeito por ritual falhado — é de RITUAL ∴ §T446/§T470) & a versão
  `rob` da mecânica Koldúnica onde ela ⊥ toca trilha nenhuma de §T445.
- **`pdftotext` em modo FLUXO embaralha TABELA de 2 colunas em BLOCO** (todos os `Successes`
  juntos, depois todos os `Result`). Casar na mão e virar `1 sucesso — <resultado>` (§I21).
  Aconteceu em `Awakening of the Steel` · `Cenotaph Path` · `Elemental Mastery` · `Neptune’s Might`
  · `Path of Corruption` · `Path of Technomancy` · `Path of Spirit Manipulation` · `Sepulchre Path`.
- **A tabela pode cair no poder ERRADO.** Em `Path of Technomancy` a tabela de alcance de
  `Telecommute` saiu impressa sob `Encrypt/Decrypt`. Conferir de qual `System:` a tabela fala.
- **Quadro de REGRA entra, quadro de CONSELHO ⊥ entra** (critério de §T444, aplicado 5x aqui):
  ENTROU `Creating Spirits` (RoB p.142, dá nível & parada de espírito) c/ a página no rótulo.
  ⊥ ENTROU `Zombie Statistics` · `Whither Mortis?` · `Interactions between the Spirit Realm…` ·
  `Necromancy’s Tangled Paths` · `Vampires in the Underworld`.
- **Epígrafe de livro ⊥ entra.** `tos` & `bh` abrem trilha com citação + atribuição `— Fulano`;
  o `HH.12.lfm` ⊥ tem 1 linha começando com `—` em 36 entradas ∴ a convenção é CORTAR.
- **`tos` & `da` põem o nome LATINO entre parênteses no cabeçalho** (`Iter Pernix (The Swift
  Journey)` · `Rego Calatio (Rule of Summoning)`). A chave & o bloco 2 levam SÓ o nome do picker;
  a tradução entre parênteses entra na 1ª frase do corpo.
- **`Die Herrschaft des Wyrm` & `Rego Calatio` compartilham 1 regra de topo de seção** ("All
  targeted Dark Thaumaturgy Path effects may be resisted with a Willpower roll…", tos p.109).
  Ela ⊥ é da trilha, é da DISCIPLINA — mas muda dado rolado ∴ entrou nas 2.
- Custo real: **46 entradas em 1 comando** (60ª) + **18 em 1 comando** (61ª), `HH.13.lfm`
  28 KB → 567 KB → **772 KB** · `.rpk` 4,01 → 4,76 → **5,05 MB**.

### A RECEITA que fechou §T444 & §T445 — passos 1·2·3 valem p/ §T446, **4·5·6 ⊥ VALEM**

> ⚠ **Se você está em §T446, os passos 4, 5 e 6 abaixo estão ERRADOS p/ você.** Eles falam
> de `HH.12`/`HH.13`, onde as entradas que faltavam eram sempre o SUFIXO alfabético. No
> `HH.14.lfm` ⊥ são ∴ o append cai no lugar errado **sem o gate reclamar**. Pule para
> *§T446 QUEBRA o passo 4 da receita* (↓) — lá os 3 passos estão substituídos por 1 script.

**1. Achar livro & página.** O mapa dá as duas colunas. O código de livro vira TÍTULO pela
tabela em `research/README.md` (`core`→`Vampire: The Masquerade 20th…`, offset 8; resto
offset 1). Página do PDF = **impressa + offset**.

**2. Extrair em modo FLUXO, ⊥ `-layout`:**

```bash
export PATH="/mingw64/bin:$PATH"
pdftotext -enc UTF-8 -f <impressa+offset> -l <+3> "$B/<arquivo>.pdf" saida.txt
```

Fluxo dá ordem de leitura & desfaz hifenização. `-layout` só serve p/ ler TABELA por coluna.

**3. Escrever o bloco com a ferramenta `Write`, ⊥ com heredoc.** São dezenas de KB de prosa
UTF-8 com `’ … ö ×`; heredoc de bash a esse tamanho é risco desnecessário. 1 arquivo de
scratchpad por lote de entradas.

**4. Enxertar antes do marcador de FIM** — **⊥ vale p/ §T446, ver ↓** (⊥ ∃ outro lugar; a
ordem é ALFABÉTICA pelo value):

```bash
cd "Plugins/Sheets/World of Darkness 20th/HuntersHunted"
END=$(grep -n -- '-- <<< PATH_DESC_END' HH.13.lfm | cut -d: -f1)   # RITUAL_DESC_END em HH.14
head -n $((END-1)) HH.13.lfm > "$SP/novo"
cat "$SP/blk_a.lua" "$SP/blk_b.lua" >> "$SP/novo"
tail -n +$END HH.13.lfm >> "$SP/novo"
cp "$SP/novo" HH.13.lfm
```

**5. Provar o enxerto ANTES de rodar qualquer coisa:**

```bash
echo "open=$(grep -c '\[==\[' HH.13.lfm) close=$(grep -c '\]==\]' HH.13.lfm)"  # ! iguais
grep -c ']]>' HH.13.lfm                                                        # ! 1 (o CDATA)
grep -o $'^\t\t\t\t\\["[^"]*"' HH.13.lfm | sed 's/.*\["//;s/"//'                # ! alfabética
```

**6. Virar a coluna do mapa & fechar:** `sed -i -E 's/^(<nome>)(\t.*)\t\.$/\1\2\tx/'`,
gate, `rdk -l`, `rdk -i`. Ao terminar TODAS, provar que ⊥ ∃ órfão: `diff` das chaves de
`DESC` contra o mapa **e** contra o `values=` do picker (receita no `research/README.md`).

**⚠ Splice por número de linha erra fácil.** Se o `grep` ⊥ casar, a variável fica VAZIA e
`$((L+2))` vira `2` — o bloco cai no TOPO do arquivo calado. Aconteceu na 59ª rodada, no
`research/README.md`. Preferir âncora de texto (`sed '/padrão/r arquivo'`) e conferir o
resultado DEPOIS de cada enxerto.

### §T446 QUEBRA o passo 4 da receita — usar `research/rebuild_ritual_desc.sh`

**Enxertar antes do marcador de FIM ⊥ funciona no `HH.14.lfm`.** Em §T444/§T445 as entradas
que faltavam eram o SUFIXO alfabético ∴ append dava certo. Aqui a chave é
`<nível>. <nome>` (§V184) & o picker ordena por ela ∴ um ritual novo quase nunca é o último:
`5. Blood Contract` entra DEPOIS de `1. Widow's Spite`, mas `1. Insight` entra no MEIO.
Append põe a entrada no lugar errado — calado, porque o gate ⊥ mede ordem de `DESC`.

∴ a 62ª rodada trocou o passo 4 por um SORT-MERGE, e ele mora em
`research/rebuild_ritual_desc.sh` (3º gerador de `research/`, ≡ `findpage.sh`/`mapritual.sh`):

```bash
cd "c:/Users/awlol/OneDrive/Documents/firecast_fork"
SP=<scratchpad>/r ; mkdir -p "$SP"
bash research/rebuild_ritual_desc.sh "$SP" --split   # 1º: dumpa o que o .lfm JÁ tem
#   ... escrever os blocos novos com a ferramenta Write em "$SP"/<qualquer nome>.lua ...
bash research/rebuild_ritual_desc.sh "$SP"           # 2º: reescreve a tabela inteira
```

- `--split` é OBRIGATÓRIO na 1ª chamada da rodada — sem ele o rebuild escreve só os blocos
  novos e APAGA os 70 que já estão lá.
- ordem vem do `ritual_pages.tsv`, ⊥ do nome do arquivo ∴ 1 arquivo pode levar 6 entradas em
  qualquer ordem. Foi assim que a 62ª escreveu 68 entradas em 9 arquivos.
- ele ABORTA (e ⊥ toca o `.lfm`) em chave fora do mapa ou chave duplicada, e no fim confere
  `[==[`/`]==]`, `]]>` == 1 e a ordem. As 2 pernas foram MUTADAS na 62ª & falharam de
  verdade (§V20). Round-trip testado: `--split` + rebuild devolve o arquivo BYTE A BYTE.

### ⚠ O PORTÃO §T459 FOI FECHADO PELO USER (2026-08-20)

Veredito textual: *"aumente os campos para caber, empurre o que precisar para a direita de
forma cascateada (aumenta o campo e empurra o próximo, se tiver outro, empurra ele também.
Sempre empurra o início e o fim)"*. Virou §T474 (vampiro) & §T477 (`HH.2`/`HH.7`), os 2 `x`.
**⊥ ∃ portão de layout aberto.** As larguras finais:

| arquivo | entrada | bolinhas | linha | caixa | `DESCRIPTION` `left` |
|---|---|---|---|---|---|
| `HH.12` | 160→**170** | →200·225·250·275·300 | →325 | →350 | →360 |
| `HH.13` | 160→**345** | →375·400·425·450·475 | →500 | →525 | →535 |
| `HH.14` | 290→**460** | — | →485 | →510 | →520 |
| `HH.7` | 160→**230** | →260·285·310·335·360 | →385 | →410 | →420 |
| `HH.2` | 160→**170** | →175·200·225·250·275 | →300 | →330 | tudo ≥330 anda +10 |

A aba Vampire fica MAIS LARGA que a grade de 1210 da Main (1210\|1385\|1370) & rola na
horizontal. Consequência ACEITA da regra de empurrar, ⊥ é bug.

**O layout ⊥ trava §T445/§T446.** `DESC` é indexado por `value` & renderizado com
`wordWrap` ∴ largura de combo reflui a caixa & ⊥ toca 1 linha do conteúdo.

### §V196 & §V197 — o gate mede picker

`HH.7` & `HH.2` estavam estourados **desde que nasceram** e ninguém tinha visto: §V16 mede
`//label` desde a 1ª rodada & NUNCA olhou `comboBox` (§B43). §V196 mede, nos 2 eixos que o
`items` tem (idioma × época) — e foi ele que achou o §B44: `eraName` renomeava `Weather
Control` na númina de `HH.7` também, porque `value` ⊥ carrega SENTIDO. §V197 escopa.

**Estouro de picker aparece em CASCATA** (§B45): o check reporta 1 por combo, o pior item
∴ consertar o maior faz o 2º surgir. Rodar o gate ATÉ VERDE antes de anotar número.

### Ordem sugerida daqui

| # | §T | por quê AQUI |
|---|---|---|
| 1 | T446 | o grosso que sobrou — **161 dos 284** rituais em `HH.14.lfm` |
| 2 | T470 | 2º corpo de `DESC` por época |
| 3 | T448 | checks de §V172…§V189, medem o que já ∃ |
| 4 | T449 | version 4.9→5.0 + build + install, fim |
| 5 | T450 | o teste de aceitação da ficha inteira, é do USER |

### ⚠ O TAMANHO REAL, agora MEDIDO em 36 entradas reais

§T444 gastou **5 comandos** p/ 36 entradas (4 · 4 · 6 · 4 · 14). O que ela ensinou:

- entrada CHEIA (5 poderes + Sistema) ≈ **9 KB [en] + 9 KB [pt]**; entrada CURTA (magia de
  sangue = só a regra de conjuração; ou valor plano tipo `Potence`) ≈ **1 KB × 2**
- **8 das 36 eram curtas** ∴ o último comando levou 14 de uma vez. Em §T445 as 64 trilhas
  são quase todas cheias (6 curtas); em §T446 o ritual é 1–2 KB, mas são 282
- `HH.12.lfm` 12 KB → **220 KB** · `.rpk` 3,18 MB → **4,01 MB**
- ∴ **T445 gastou 2 comandos (46 + 18) · T446 gastou 2 (68 + 53 de 284).** Sobram ~4 de T446 + T470/T448/T449

O custo por entrada ⊥ é o texto: é a LIMPEZA do lixo de extração + a TRADUÇÃO à mão.
O mapa de página era a 3ª parte cara & essa **já foi paga** (58ª rodada, automatizada).
`T114` e `T159` são `?` antigos de rodadas anteriores, fora desta.

## Forma das 384 entradas de `DESC` (§I21)

**A forma LITERAL é `[==[ ]==]` com quebra de linha DE VERDADE, ⊥ `"..."` com `\n`.**
O §I21 descreve o VALOR da string; o gate (§V192, `T463`) casa o literal, e o que ele
espera é o colchete longo — que é também o que `HH.7` já usa e o único que aguenta aspas
e parágrafo de livro sem escapar nada:

```lua
["<chave>"] = {
    en = [==[<livro>, p. <pág>


<nome>


<descrição verbatim>]==],
    pt = [==[<livro>, pág. <pág>


<nome>


<tradução>]==],
},
```

- bloco 1 = livro + página **do item**, ⊥ da seção. `p.` em [en], `pág.` em [pt].
  Título de livro ⊥ traduz. Os 3 mapas de `research/` já dão livro & página dos 384.
- bloco 2 = o nome, IDÊNTICO ao valor do picker (§V24) — ritual entra com o prefixo de
  nível (`3. Ritual of The Unearthed Fetter`, §V184). É o mesmo nos 2 idiomas.
- bloco 3 = prosa + bloco de sistema, VERBATIM do livro em [en]; [pt] é tradução one-way.
- §V192 mede a forma & desde a 58ª rodada tem **14 strings reais** p/ medir, ⊥ passa mais
  vazio. As 2 pernas foram mutadas: nome fora da chave & linha de fonte sem `, p. <n>`.

Decidido na 58ª rodada, ⊥ reabrir sem motivo:
- corpo = **níveis 1–5 SÓ**. 6–9 moram em `ADVANCED_DISC` (§I23) & a ficha tem 5 bolinhas
- **quadro de Narrador ⊥ entra** (`Storytelling Animals`, `Zombie Statistics`) — é
  conselho de mesa, ⊥ descrição do poder
- **quadro de REGRA entra, quadro de CONSELHO ⊥ entra.** `Seeing the Unseen` (core p.142)
  entrou em `Auspex` c/ a página no rótulo: é regra de Auspícios × Ofuscação/Quimerismo, ⊥
  conselho de mesa. `Storytelling Animals` ⊥ entrou. Critério = muda dado rolado?
- **tabela de livro vira 1 linha por resultado** (`1 sucesso — <resultado>`), ⊥ ∃ colunas: o
  `pdftotext` embaralha tabela de 2 colunas & a caixa da ficha ⊥ tem tab stop
- **disciplina de MAGIA DE SANGUE = entrada CURTA**, só a regra de conjuração: as trilhas
  dela moram no `path_pages.tsv` ∴ são §T445, ⊥ §T444. Já valeu p/ `Assamite Sorcery` ·
  `Abyss Mysticism` · `Dark Thaumaturgy` · `Koldunic Sorcery` · `Necromancy`. **Ainda vale
  p/ `Thaumaturgy` & `Setite Sorcery`** — ⊥ se assuste com as 43 trilhas de Taumaturgia
- **`Fortitude` & `Celerity` ⊥ têm poder por nível** — valor plano, entrada = intro +
  Sistema. O bloco `<Disciplina> 6+` que vem depois é de nível 6–9 ∴ ⊥ entra
- **§T444 FECHOU c/ 36/36** (59ª rodada). O que ela ENSINOU p/ §T445 & §T446:
  - entrada CHEIA (5 poderes) ≈ 9 KB × 2 idiomas · entrada CURTA (magia de sangue, valor
    plano) ≈ 1 KB × 2 ∴ **8 das 36 eram curtas**. Em §T445 as 64 trilhas são TODAS cheias
  - o `pdftotext` em modo FLUXO (⊥ `-layout`) dá ordem de leitura e desfaz hifenização,
    MAS: (a) corta o parágrafo no rodapé & injeta `<nº da pág>` + cabeçalho do capítulo no
    meio — remendar à mão; (b) quando o poder vira de coluna, o CORPO sai ANTES do próprio
    cabeçalho `•••` (aconteceu em `Obfuscate` `Obtenebration` `Valeren`) ∴ conferir se o
    1º parágrafo de cada nível fala do nível certo
  - erro de impressão do livro FICA no [en] (é verbatim): `Damionion` · `Steath` ·
    `Horrid Realty` · `Flescrafting`. No [pt] sai corrigido — tradução ⊥ é transcrição
- `’` (U+2019) fica, é §V195. `'` reto ⊥ entra em `items=`, mas em `DESC` é indiferente —
  ainda assim manter `’` p/ bater com o livro

Divisão: `HH.12` = 36 disciplinas · `HH.13` = **64** trilhas · `HH.14` = 284 rituais.

## Regras do projeto que mordem
- **Gate verde ⊥ prova que COMPILA.** O gate faz XML + regex; ⊥ roda Lua. Um `end;` a menos
  passa por 200+ checks e só morre no `rdk -l`, que sai **1 SEM MENSAGEM & APAGA o `.rpk`**
  (§B19). Aconteceu na 58ª rodada: splice de `awk` comeu o `end;` de `pickerItems`. §V6/§V7
  existem por isso — rodar o build ANTES de marcar §T, ⊥ só o gate.
- **Splice por número de linha (`awk NR==n`) erra fácil.** Conferir o bloco DEPOIS de cada
  splice, ⊥ confiar na contagem de `skip=`.

- **⊥ commitar sem o user pedir NAQUELA mensagem.** Vale mesmo quando o `/ck:build` manda
  commitar — a regra do projeto vence. Termine com o §T marcado, gate verde, `.rpk`
  instalado, e as mudanças no working tree.
- **Só `/ck:spec` escreve seções do SPEC.** O `/ck:build` só vira o status do §T.
- **Check novo no gate ! poder falhar de verdade** (§V20): mutar o código e ver vermelho
  ANTES de aceitar. §V20 existe porque um check já virou no-op (§B7).
- **⊥ escrever `.lfm` com `Set-Content -Encoding utf8`** — grava BOM e o XML quebra. Usar
  redirecionamento do bash ou `-Encoding utf8NoBOM`.

## Estado do working tree

A 58ª rodada foi commitada pelo user em `bfccbe9d`. Da **59ª à 63ª** sobrou no tree, ⊥ commitado
(bate 1:1 com `git status --short`; `research/rebuild_ritual_desc.sh` & `.claude/` = `??`):

| arquivo | o que mudou |
|---|---|
| `SPEC.md` | §T444 & §T445 viraram `x` (§T446 segue `~` — só fecha em 284/284) |
| `HH.12.lfm` | 36 entradas de `DESC` · 12 KB → 220 KB (59ª rodada) |
| `HH.13.lfm` | 64 entradas de `DESC` · 28 KB → 772 KB (60ª + 61ª rodada) |
| `HH.14.lfm` | **123 entradas de `DESC` · 26 KB → 437 KB** (62ª + 63ª rodada) |
| `output/*.rpk` | 3,37 MB → **5.509.386** bytes |
| `research/disc_pages.tsv` | coluna de progresso 4→36 `x` |
| `research/path_pages.tsv` | coluna de progresso 1→64 `x` (FECHADO) |
| `research/ritual_pages.tsv` | **coluna de progresso 2→123 `x`** |
| `research/rebuild_ritual_desc.sh` | **NOVO** — o sort-merge que §T446 exige (↑) |
| `research/README.md` | legenda de código de livro → título (§I21) |
| `HANDOFF.md` | este arquivo |
| `.claude/` | NOVO, ⊥ rastreado |

**⊥ commitar sem o user pedir NAQUELA mensagem** — ver *Regras do projeto que mordem*, ↑.
Ao fechar tarefa, DIZER o que ficou pendente em vez de commitar.
