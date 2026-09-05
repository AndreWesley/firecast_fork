# research/ — listas extraídas dos livros

Dados DERIVADOS dos PDFs em (raiz dos livros, REORGANIZADA pelo user 2026-08-28 — §R126)
`C:\Users\awlol\OneDrive\Documents\RPG\Storyteller V20\Vampiro\Vampiro - A Máscara\Books`.

⚠ **Deixou de ser pasta única.** Agora são **3 subpastas + 2 soltos na raiz**, e a coluna
`arquivo .pdf` da tabela lá embaixo passa a levar o prefixo. Nenhum livro sumiu — só mudou de
lugar. Os 7 marcados **NOVO** entraram nesta reorganização e ainda não foram varridos.

| subpasta | livros |
|---|---|
| `Vampiro/` | os 8 de sempre + `Vampire V20 - Anarchs Unbound` (**NOVO**) |
| `Mago/` | `Mage - The Ascension` (**o M20 EM INGLES**, entrou 2026-08-28 no lugar do `M20.pdf` PT) · `M20_Victorian_Age_(Final_Download)` · `Mage - Book of Common Magicks` · `Mage - Book of Secrets` · `Mage - Technocracy Reloaded` |
| `Werewolf/` | **PASTA NOVA 2026-08-28**: `Werewolf W20` (core, EN) · `Werewolf W20 - Changing Breeds` · `Werewolf W20 - Changing Ways` · `Werewolf W20 - Kinfolk` · `Werewolf W20 - Rage Across the World` · `Werewolf W20 - Charactersheet` · `Lobisomem W20 - A idade das Trevas` (**PT**, unico do lote que nao esta em ingles) |
| `Sorcerer/` | `M20 Sorcerer` (saiu de `~\Downloads\`) · `Sorcerer_s_Companion` (**NOVO**) |
| (raiz) | `Ghouls_and_Revnants_(Final_Download)` · `TheHuntersHunted_II_Revised_ (2)` |
Só nome, nível, dona e página — **⊥ ∃ prosa de livro aqui**. O texto corrido de §T444–446
sai do PDF na hora, ⊥ deste diretório.

Tudo aqui JÁ está encodado no `HuntersHunted.lfm`. Estes arquivos existem para o caso de
o `.lfm` precisar ser regerado, e para §T444–446 saberem o que procurar em qual livro.

## Arquivos

| arquivo | forma | n |
|---|---|---|
| `paths.tsv` | `<disciplina>\t<trilha>` | 66 |
| `rd_core.tsv` | `<nível>\t<nome>\t<disciplina>` — V20 core | 70 |
| `rd_rob.tsv` | idem — Rites of Blood | 119 |
| `rd_misc.tsv` | idem — LotC · LoB · DA Companion · Black Hand | 18 |
| `rd_tos.tsv` | idem — Dark Ages Tome of Secrets | 35 |
| `rd_da.tsv` | idem — Dark Ages livro base | 42 |
| `rd_sorted.tsv` | a união, `<disciplina>\t<nível>\t<nome>` | 284 |
| `rd_extra_owner.tsv` | `<chave do ritual>\t<2ª disciplina dona>` | 13 |
| `adv_core.tsv` · `adv_da.tsv` | `<disciplina>\t<nível>\t<nome>\t<pág PDF>` | 109 · 119 |
| `adv_all.tsv` | a união dedupada, níveis 6–9 | 192 |
| `d36.list` | as 36 disciplinas canônicas de §I20 | 36 |
| `advext.awk` | extrator dos poderes 6–9 | — |
| `hedge_ritual_pages.tsv` | `<nível>\t<ritual hedge>\t<Caminho dono>\t<livro>\t<pág IMPRESSA>` — §T928 | 52 |
| `hedge_affiliation_pages.tsv` | `<afiliação>\t<livro>\t<pág IMPRESSA>` — §T929, 3 livros | 26 |
| `road_bearing.tsv` | `<nome>\t<aura|=mãe>\t<livro>\t<pág>\t<época>` — §T748 | 55 |
| `road_sins_raw.tsv` | `<tid>\t<livro>\t<pág>\t<título>\t<score>\t<wrongdoing>\t<rationale>` — MÁQUINA | 57 tabelas |
| `road_sins_map.tsv` · `road_sins_overrides.tsv` | nome do picker → `tid`, & o que o parser ⊥ acerta | 55 · 9 |
| `road_aura_raw.tsv` | `<bid>\t<rótulo>\t<nome>\t<prosa>` — MÁQUINA | 33 |
| `road_aura_map.tsv` · `road_aura_overrides.tsv` | nome do picker → `bid`, & os 9 que o parser ⊥ alcança | 55 · 9 |
| `road_sins_titles.tsv` | `<tid>\t<título EN>\t<título PT>` — o cabeçalho do bloco 4 | 56 |
| `road_sins_pt.tsv` | `<tid>\t<score>\t<wrongdoing PT>\t<rationale PT>` — À MÃO | 483 |
| `road_aura_pt.tsv` | `<bid>\t<prosa PT>` — À MÃO | 37 |
| `gen_road_desc.ps1` | escreve `descRoad_{en,pt}.lua` a partir dos 8 acima + os 2 `.lfm` | — |
| `clan_body_en.tsv` | `<nome do picker>\t<livro>\t<pág impressa>\t<corpo EN>` — §T848 metade EN | 61 |
| `clan_extract.ps1` | o extrator que escreve o de cima a partir do cache de texto dos livros | — |
| `clan_weakness.tsv` | `<nome do picker>\t<livro>\t<pág>\t<en>\t<pt>` — o parágrafo `Weakness:` de cada um dos 61 clãs, VERBATIM (§T970); pt à mão; `Caitiff` = core p.124 (custo ×6), `Panders`/`Children of Osiris` = a frase do livro | 61 |
| `clan_disc_open.tsv` | `<nome do picker>\t<en>\t<pt>` — a linha `Disciplines:` de trio ABERTO, em palavras (§I148d, §V432b); 1 família (§T850) + 7 clãs (§T970 — `Children of Osiris` também é trio aberto) | 1 |
| `gen_traits_desc.ps1` | escreve `descFamily_{en,pt}.lua` & `descClan_{en,pt}.lua` (§T850, §T971; `gen_clan_desc.ps1` SAIU em §T971) a partir de `CLANS` + `FAMILY_WEAKNESS` do `WoD20th.lfm`, do `.lang`, de `family_source.tsv` & de `clan_disc_open.tsv` — bloco 3 = `Disciplines:` ↵↵ `Weakness:`, mais nada | — |

Os 5 `rd_*.tsv` de livro já vêm **dedupados entre si**, na precedência
core > RoB > (LotC/LoB/DAC/BH) > TOS > DA. Somados dão 284 sem repetir nome.

## Código de livro → título para o bloco 1 de §I21

`path_pages.tsv` e `ritual_pages.tsv` gravam o livro como CÓDIGO CURTO; `disc_pages.tsv`
grava por extenso. O bloco 1 de §I21 quer o **título**, e o título **⊥ traduz** (só o
`p.`/`pág.` muda de idioma). Tabela abaixo = a tradução do código, o offset de página e o
arquivo PDF de onde o texto sai.

| código | título p/ o bloco 1 | offset | caminho a partir de `Books/` |
|---|---|---|---|
| `core` | `Vampire: The Masquerade 20th Anniversary Edition` | **8** | `Vampiro/vampire the masquerade - 20th anniversary edition` |
| `da` | `Vampire: The Dark Ages 20th Anniversary Edition` | 1 | `Vampiro/_Vampiro V20 - Dark Ages - Livro Base` |
| `rob` | `Rites of Blood` | 1 | `Vampiro/Vampire V20 - Rites of Blood` |
| `lotc` | `Lore of the Clans` | 1 | `Vampiro/Vampiro V20 - Lore of the Clans` |
| `lob` | `Lore of the Bloodlines` | 1 | `Vampiro/Vampiro V20 - Dark Ages - Lore of the Bloodlines` |
| `tos` | `Dark Ages Tome of Secrets` | 1 | `Vampiro/Vampiro V20 - Dark Ages - Tome of Secrets` |
| `dac` | `Dark Ages Companion` | 1 | `Vampiro/Vampiro V20 - Dark Ages - Companion` |
| `bh` | `The Black Hand: A Guide to the Tal’Mahe’Ra` | 1 | `Vampiro/Vampiro V20 - The Black Hand A Guide to the TalMaRahe` |
| `gr` | `Ghouls & Revenants` | 1 | `Ghouls_and_Revnants_(Final_Download)` |
| `anarch` | `Anarchs Unbound` | **1** | `Vampiro/Vampire V20 - Anarchs Unbound` — offset MEDIDO 2026-08-28. **12** qualidades/defeitos
| `hh` | `The Hunters Hunted II` | **1** | `TheHuntersHunted_II_Revised_ (2)` — offset MEDIDO 2026-08-28. **42** qualidades/defeitos
| `sorc` | `M20 Sorcerer` | 1 | `Sorcerer/M20 Sorcerer` — era `~\Downloads\M20 Sorcerer.pdf` até 2026-08-28 |
| `sorcc` | `Sorcerer's Companion` | **0** | `Sorcerer/Sorcerer_s_Companion` — offset MEDIDO 2026-08-28. **ÚNICO livro com offset 0.** 7 qualidades/defeitos
| `m20` | `Mage: The Ascension 20th Anniversary Edition` | **1** | `Mago/Mage - The Ascension` — offset MEDIDO 2026-08-28 (333 votos, rodapé `Chapter Six: Creating the Character 299` na pdf 300). **EM INGLÊS.** SUBSTITUI o `M20.pdf` PT, que o user trocou; a nota velha ("⊥ serve de fonte") CAIU
| `w20` | `Werewolf: The Apocalypse 20th Anniversary Edition` | **2** | `Werewolf/Werewolf W20` — offset MEDIDO 2026-08-28 (46 votos, rodapé `298  WEREWOLF...` na pdf 300). EN. Antecedentes em **135-140**
| `w20kin` | `W20 Kinfolk` | **1** | `Werewolf/Werewolf W20 - Kinfolk` — offset MEDIDO 2026-08-28. EN
| `w20da` | `Lobisomem W20: A Idade das Trevas` | `?` | `Werewolf/Lobisomem W20 - A idade das Trevas` — **EM PORTUGUÊS** (0 "Merit", 26 "Antecedente"), 81 págs. Único do lote que ⊥ está em inglês. Offset ⊥ medido — ninguém precisou dele ainda
| `m20va` | `M20 Victorian Age` | **1** | `Mago/M20_Victorian_Age_(Final_Download)` — offset MEDIDO 2026-08-28. **5** qualidades/defeitos
| `bcm` | `Book of Common Magicks` | **2** | `Mago/Mage - Book of Common Magicks` — offset MEDIDO 2026-08-28. **0** qualidades/defeitos
| `bos` | `Book of Secrets` | **1** | `Mago/Mage - Book of Secrets` — offset MEDIDO 2026-08-28. **245** qualidades/defeitos, o MAIOR de todos
| `trel` | `Technocracy Reloaded` | **1** | `Mago/Mage - Technocracy Reloaded` — offset MEDIDO 2026-08-28. **0** qualidades/defeitos

Os `?` de offset e de título dos 7 NOVOS são **honestos**: ninguém abriu esses PDFs ainda.
Medir o offset antes de usar a página — a regra de sempre é `impressa = PDF − offset`, e
chutar o offset põe página errada no bloco 1 de §I21, que é texto que o jogador lê.

`core` · `da` · `rob` · `lotc` são os 4 títulos que §T444 já gravou no `HH.12.lfm` — copie
a grafia de lá, ⊥ reinvente. `lob` & `bh` saem do rodapé corrido do próprio livro; `tos` &
`dac` põem o nome do CAPÍTULO no rodapé, ⊥ o do livro, ∴ o título vem desta tabela.

**Página impressa, ⊥ do PDF.** A coluna dos mapas já é a IMPRESSA. Para abrir o PDF na
página certa: `pdftotext -f <impressa + offset>`.

## Offset de página, por livro

Página IMPRESSA = página do PDF menos:

| livro | offset | época |
|---|---|---|
| V20 core | 8 | moderna |
| Dark Ages base · Tome of Secrets · DA Companion | 1 | medieval |
| Lore of the Clans · Lore of the Bloodlines · Rites of Blood · The Black Hand · Ghouls & Revenants | 1 | **moderna** |

`Vampiro V20 - Dark Ages - Lore of the Bloodlines.pdf` é livro MODERNO apesar do nome
(§R79): `Dark Medieval` 0 ocorrências, `Camarilla` 47, © 2017. Conferir época por
contagem de termo antes de atribuir, nunca pelo nome do arquivo.

## Armadilhas de extração (custaram tempo, ⊥ repetir)

1. **`pdftotext` sem `-layout`** funde as 2 colunas e joga o heading `Level Two Rituals`
   no meio do corpo (§R54) — 2 dos 5 níveis somem. Para conferir nível, usar `-layout`
   e ler por coluna.
2. **O awk desta máquina ⊥ casa classe de caractere multibyte.** A bolinha `•` (U+2022)
   tem de virar ASCII antes: `sed 's/\xe2\x80\xa2/*/g'`. É o que `advext.awk` espera.
3. **O Dark Ages escreve `Daimonion`**, o core escreve `Daimoinon`. Sem tratar isso, os 7
   poderes avançados de Daimonion caem em Chimerstry. O valor CANÔNICO é `Daimonion`
   (decisão do user, 57ª rodada).
4. **A escada de descritor de Força de Vontade** (`••••• • Confident` …
   `••••• ••••• Unshakable`) casa o mesmo padrão de bolinha de um poder avançado.
   Filtrar por página: no DA, qualquer coisa antes da p.190 é falso positivo.
5. **`Path of X` ⊥ é classificável por nome** (§R85). `The Path of Lilith` é moralidade,
   `The Nightshade Path` é Necromancy — mesmo prefixo. A dona vem da SEÇÃO onde o item
   mora, nunca do padrão do nome. Duas tentativas por nome falharam (§R75, §R82).
6. **O Git Bash desta máquina ⊥ abre o caminho dos livros.** O `á` de `Máscara` chega ao
   `pdftotext` como `M<e1>scara` e ele sai `I/O Error: Couldn't open file`. O caminho está
   certo, o `ls` lista, e mesmo assim ⊥ abre. Duas saídas: **glob** —
   `B=$(echo /c/Users/.../Vampiro\ -\ A\ M*scara/Books)` — ou **PowerShell**, onde o caminho
   literal funciona. Registrado 2026-08-28 (§R126), e ela custou a 1ª tentativa da 125ª.
7. **`Merit`/`Flaw` tem 7 notações, ⊥ 3** (§R125 dizia 3; as outras 4 foram MEDIDAS em
   2026-08-28, ao rodar §T749). Um parser que conheça menos perde o resto **CALADO**:
   1. `core` `lotc` `lob` `gr` `hh` `bh` `dac` `rob` `bos` `sorcc` — `Acute Sense (1pt. Merit)`
   2. `anarch` — `Peacemaker (2-pt. Merit)`, **hífen** entre o número e `pt`. A 1ª varredura
      deu **0** para este livro e as 12 sumiram sem aviso.
   3. `tos` — o nome fica **na linha de cima** e a linha do custo vem sozinha:
      `(3 pt. Supernatural Merit)`
   4. `da` — `Ambidextrous (1 point):` + prosa, **sem dizer `Merit` nem `Flaw`**. O tipo vem do
      cabeçalho de seção (`Physical Merits` / `Physical Flaws` / …), ⊥ da linha.
   5. `sorc` — `Path Natural: (5 pt Merit)`, **dois-pontos ANTES** do parêntese.
   6. `m20va` — `• Well-Rounded (1 pt. Mental Merit)`, com marcador antes do nome.
   7. `m20va` — `• Construct (Social Flaw):` — **sem custo**, só a categoria.

   Linha de SUMÁRIO termina no número da página que aponta (`(2 pt. Social Merit) 61`) e
   ! ser descartada, senão o item entra 2×. Só no `lob` são 37 dessas.

8. **LAYOUT DE 2 COLUNAS — RESOLVIDO na 135ª rodada.** O fim de um corpo só é confiável
   quando se acha o **cabeçalho seguinte**, e em página de 2 colunas esse cabeçalho está na
   OUTRA coluna, a centenas de linhas de distância na ordem de leitura. Era daí que vinham os
   **17 corpos inchados** (`Simply Waiting` `lob` p.16 saía com **4425** chars contra os
   **488** reais) e os **2 vazios** — a mesma doença pelos 2 lados.

   **A cura: `pdftotext -layout` + corte na CALHA**, implementada em
   `research/extract_merit_flaw.ps1` (`Find-Gutter` + `Split-Page`). O `-layout` põe as
   colunas lado a lado na mesma linha, separadas por uma calha de espaços; o extrator acha a
   calha **por página** (a coluna com o pico de brancura na faixa do meio), corta cada linha
   nela e lê coluna esquerda inteira → coluna direita. Aí o cabeçalho seguinte volta a ficar
   logo abaixo do corpo.

   ⚠ O corte de brancura é **RELATIVO ao pico da própria página**, ⊥ fixo em 90%: coluna
   justificada entra na calha de vez em quando, e um corte fixo perdia página boa (`dac`
   p.100 chega só a **78%**, `bos` p.35 a **81%**) — e página perdida = colunas FUNDIDAS, que
   é como `Tracker's Mark` e `Alcohol /Drug Tolerance` sumiam.

   ⚠ O `-layout` **⊥ cola palavras**: **1397** coladas contra **1399** do modo padrão, medido
   nos 15 livros. Nesse eixo os dois empatam.

   Medido depois da reescrita: **774 linhas · 641 nomes · 0 corpo vazio · `Simply Waiting` =
   488** · **714** corpos terminam no cabeçalho seguinte (o único fim confiável) e **46** no
   corte por título. Sobram **14** duvidosos, listados pelo próprio script.

9. **`-enc UTF-8` é OBRIGATÓRIO, & foi ele que quase saiu da receita por um defeito que era do
   SCRIPT, ⊥ da flag.** Sem `-enc`, o pdftotext cai em Latin-1 & o travessão, a reticência & as
   aspas duplas curvas viram **U+FFFD** dentro do corpo — losango preto no meio da frase que o
   jogador LÊ. Com `-enc UTF-8` o texto sai `–` `…` `“ ”` como no livro.

   ⚠ A versão ANTIGA do extrator PERDIA **15** entradas com `-enc UTF-8` — as que têm apóstrofo
   (`Lawman's Friend` · `Sire's Resentment` · `Can't Cross Running Water` · `Betrayer's Mark` ·
   `Dracon's Temperament` · `Methuselah's Thirst` · `Devil's Mark` · `Wolverine's Palate` ·
   `Warrior's Heart` · `Tracker's Mark` · `Judge's Wisdom` · `The Bard's Tongue`) — & **783
   linhas viravam 768 sem 1 aviso**. A causa ⊥ era a flag: era que o `.ps1` tinha os caracteres
   curvos **LITERAIS** dentro dos regex & o **PowerShell 5.1 lê `.ps1` sem BOM como ANSI** ∴ o
   `’` do regex chegava mojibake & ⊥ casava com o `’` do texto. O extrator de hoje monta os
   regex a partir de `[char]0x2019`, é **100% ASCII**, & normaliza SÓ a aspa simples curva
   (`U+2018`/`U+2019` → `'`) porque a chave canônica de `merit_flaw.tsv` usa a reta —
   trocá-la orfanaria as 640 traduções. Travessão, reticência & aspa dupla FICAM.

   **Regra: `.ps1` que casa texto de livro ! ser ASCII puro.** Caractere não-ASCII em regex de
   script sem BOM ⊥ dá erro — dá SILÊNCIO.

10. **O `tos` embaralha o dígito e o parêntese: `2( pt. Social Merit)`.** É a **8ª** notação,
   descoberta em 2026-08-28. Sem desembaralhar, `Heretical Sympathizer`,
   `Hunted by the Hierophants` e `Postulant of Echidna` somem do corpo do livro e só sobram os
   pontos de SUMÁRIO deles (que apontam p/ a p.4 e trazem texto de índice como corpo). O
   extrator normaliza `^(\d+)\(` → `($1 ` antes de casar.

11. **Cabeçalho que QUEBRA em 2 linhas.** A coluna do `-layout` é estreita e 3 formas
   aparecem: parêntese aberto que fecha na linha de baixo (`tos`: `Demonic Patron (5 pt.` /
   `Supernatural Merit)`), nome cortado na barra (`bos`: `Esoteric Discourse /` /
   `Technobabbler (...)`) e dois-pontos do `sorc` (`Isolated Upbringing:` / `(5 pt Merit)`).
   Sem juntar, o item **some E o item de cima engole o corpo dele** — `Blasphemous Pact` ia de
   963 p/ 1487 chars. O extrator junta o par quando o resultado casa o regex de cabeçalho, e
   recusa quando ∃ 3+ espaços seguidos (ponto de sumário).

12. **Cortar o corpo por "linha com cara de título" no corpus INTEIRO come 24% do texto bom.**
   Tentado e revertido em 2026-08-28. O que FUNCIONA é aplicá-lo **só aos corpos que já se
   sabem não confiáveis** — os que ⊥ acharam o cabeçalho seguinte. Nesses, o corte derrubou
   `Plague of Demons` de 4686 p/ **527** (fim exato) e `Unholy Stain` de 3826 p/ **518**, sem
   tocar em 1 char dos 714 corpos confiáveis.

## Comando de reextração

### Os 15 livros de qualidade/defeito (T749/T751, reescrito na 135ª rodada)

Passo 1 — despejar o texto. **`-layout -enc UTF-8`** (armadilhas 8 e 9). O Git Bash ⊥ abre
o caminho com acento; rodar por PowerShell, que abre:

```powershell
$PT = "$env:ProgramFiles\Git\mingw64\bin\pdftotext.exe"
$B  = (Get-ChildItem "$env:USERPROFILE\OneDrive\Documents\RPG\Storyteller V20\Vampiro" -Directory |
       Where-Object { $_.Name -like "*scara*" } | Select-Object -First 1).FullName + "\Books"
$out = "$env:TEMP\wod_books_layout"; New-Item -ItemType Directory -Force $out | Out-Null
$all = Get-ChildItem $B -Recurse -Filter *.pdf
# <codigo> = <nome do arquivo>, os 15 da tabela de offsets deste README
foreach ($k in $books.Keys) { & $PT -layout -enc UTF-8 ($all | Where-Object { $_.Name -eq $books[$k] })[0].FullName "$out\$k.txt" }
```

Passo 2 — o parser: **`research/extract_merit_flaw.ps1`**, que já está no repo.

```powershell
powershell -File research\extract_merit_flaw.ps1 -TxtDir $env:TEMP\wod_books_layout -OutCsv $env:TEMP\mf.csv
```

Deve reproduzir **641 nomes distintos em 774 linhas**, `Simply Waiting` = **488** chars e
**0** corpo vazio. Se ⊥ reproduzir, alguma coisa mudou — conferir antes de seguir.

A coluna **`Stop`** do CSV diz POR QUE cada corpo parou, e é ela — ⊥ o comprimento — que
separa o confiável do duvidoso:

| `Stop` | n | o que significa |
|---|---|---|
| `head` | 714 | achou o cabeçalho da entrada seguinte. **Único fim confiável por construção** |
| `cut` | 46 | parou por teto & o corte por título achou onde a seção acaba. Confiável na prática |
| `sect` | 10 | bateu num cabeçalho de categoria (`Physical Merits`). **Conferidos 1 a 1: os 10 estão certos** |
| `page` | 4 | atravessou 2 viradas de página. **2 inchados**, ver abaixo |

**Os 2 corpos INCHADOS que sobraram** (⊥ têm cura mecânica; vão p/ `merit_flaw_overrides.tsv`
com o texto do livro):

- `Clear Sighted` (`bos` p.75, 6334 chars) — a calha falha na página seguinte, que é um quadro
  de largura inteira, ∴ a cauda sai com as 2 colunas FUNDIDAS
- `Stubborn Magic` (`sorcc` p.54, 921 chars) — a cauda cai num ANÚNCIO do livro
  (`2 brand new Paths of Sorcery. 75+ new Rituals.`)

Os corpos acima de 3000 chars que terminam em `head` ⊥ são defeito: `bos` e `gr` têm entradas
longas de verdade (`Black and White` 6296, `Impediment` 6021, `Mayfly Curse` 5083). O
comprimento sozinho ⊥ acusa nada — a coluna `Stop` acusa.



```bash
export PATH="/mingw64/bin:$PATH"
pdftotext -enc UTF-8 "<livro>.pdf" saida.txt          # fluxo
pdftotext -layout -enc UTF-8 "<livro>.pdf" saida.txt  # 2 colunas preservadas

# índice por página: <pagina_pdf>\t<texto>
awk -v RS='\f' '{p=NR;n=split($0,L,"\n");for(i=1;i<=n;i++){t=L[i];gsub(/^[ \t]+|[ \t]+$/,"",t);if(t!="")print p"\t"t}}' saida.txt
```

`Vampire V20 - Anarchs Unbound.pdf` ⊥ rende nada (§R69): 0 marcador de nível. Já varrido.

## `disc_pages.tsv` — o mapa de página de §T444 (FECHADO 36/36 na 59ª rodada)

`<disciplina>\t<título do livro>\t<pág impressa>\t<pág pdf>\t<x|.>`

O bloco 1 de §I21 pede o título do livro & a página do ITEM. Achar isso custou uma
extração de 8 PDFs; o mapa existe para ⊥ repetir. A 5ª coluna é o progresso de §T444.

- offset core = 8 · Dark Ages = 1 · Rites of Blood = 1 · Lore of the Clans = 1
- 31 das 36 saem do core; `Abombwe` & `Daimonion` do Dark Ages (§I20: a grafia do DA
  vence), `Setite Sorcery` & `Dark Thaumaturgy` do Rites of Blood, `Abyss Mysticism`
  do Lore of the Clans — RoB p.37 só tem o cabeçalho, o write-up está no LotC
- **corpo = níveis 1–5 SÓ.** 6–9 moram em `ADVANCED_DISC` (§I23) & a ficha tem 5 bolinhas
- quadros de Narrador (`Storytelling Animals` etc.) ⊥ entram — é conselho, ⊥ o poder
- lixo de extração p/ limpar em CADA entrada: cabeçalho corrido do livro no meio do
  texto · nº de página solto · hifenização quebrada por quebra de página (`de-\npends`)
  · tabela de sucessos que sai embaralhada (`Successes 1 success ... Result A single`)
  — reescrever como `1 sucesso — <resultado>`, 1 por linha

## `path_pages.tsv` · `ritual_pages.tsv` — mapas de página de §T445/§T446 (58ª rodada)

`<trilha>\t<dona>\t<livro>\t<pág impressa>\t<x|.>` e
`<nível>\t<ritual>\t<dona>\t<livro>\t<pág impressa>\t<x|.>`. 64 e 284, 0 sem página.

Gerados por `findpage.sh` (busca de CABEÇALHO no índice de página, ⊥ de menção em prosa)
+ `mapritual.sh`. **Validação: as 70 páginas que o §I19 coletou à mão batem 70/70.**

**Os 2 mapas casam 1:1 com o `values=` do picker — conferido na 59ª rodada, 0 divergência:**

```bash
# HH.13: coluna 1 do mapa == value do picker
# HH.14: value do picker == "<coluna 1>. <coluna 2>" — o nível mora em coluna SEPARADA
#        no mapa, mas COLADO no value (§V184)
awk -F'\t' 'NR>1{print $1". "$2}' research/ritual_pages.tsv | sort -u
```

∴ dá p/ gerar a lista de chaves de `DESC` direto do mapa, sem reler o `.lfm` — e dá p/
FECHAR a tarefa provando que ⊥ ∃ item órfão nem chave sem item (foi assim que §T444 fechou).

3 correções que o gerador cru errou — repetir os mesmos filtros se reextrair:

1. **ÚLTIMA ocorrência, ⊥ a primeira.** O sumário do livro casa o cabeçalho antes do corpo:
   `Armor of Diamond Serenity` dava RoB p.5 (sumário) em vez de p.166. 44 falsos positivos.
2. **Faixa da dona.** `The Path of Blood` casou a Trilha de Iluminação do core p.316, ⊥ a de
   Taumaturgia na p.213 — é a armadilha 5 desta lista, agora com nome e número. Conferir:
   trilha de Necromancia ∈ 159..183, de Taumaturgia ∈ 212..240, Koldunic/Assamite ∈ cap. Dez.
3. **6 rituais do TOS/RoB** cujo cabeçalho real começa pelo dígito de nível (`1 Strength of
   Haqim`) ∴ ⊥ casam por prefixo. A página veio do número solto no fim da linha do sumário.

`?` RoB p.160 lista 8 trilhas Assamitas juntas & 3 delas são REMISSÃO (`• The Path of
Life's Waters (Path of Blood, V20, pp. 213-214)`), ⊥ write-up. Ao escrever essas entradas,
decidir se o bloco 1 cita RoB p.160 (onde o nome nasce) ou o V20 (onde a regra mora).
Vale para todo item onde 3+ compartilham página.

## Rodar de novo os mapas de página

`findpage.sh` & `mapritual.sh` moram AQUI desde a 58ª rodada. Eles leem `txt/<livro>.idx`,
que **⊥ está no repo de propósito** — é o texto corrido dos livros (§C: ⊥ ∃ prosa de livro
em `research/`). Regerar antes de usar:

```bash
export PATH="/mingw64/bin:$PATH"
B="C:/Users/awlol/OneDrive/Documents/RPG/Storyteller V20/Vampiro/Vampiro - A Máscara/Books"
mkdir -p research/txt
for p in "core:vampire the masquerade - 20th anniversary edition" \
         "da:_Vampiro V20 - Dark Ages - Livro Base" \
         "rob:Vampire V20 - Rites of Blood" \
         "lotc:Vampiro V20 - Lore of the Clans" \
         "lob:Vampiro V20 - Dark Ages - Lore of the Bloodlines" \
         "dac:Vampiro V20 - Dark Ages - Companion" \
         "tos:Vampiro V20 - Dark Ages - Tome of Secrets" \
         "bh:Vampiro V20 - The Black Hand A Guide to the TalMaRahe"; do
  k="${p%%:*}"; f="${p#*:}"
  pdftotext -enc UTF-8 "$B/$f.pdf" "research/txt/$k.txt"
  awk -v RS='\f' '{p=NR;n=split($0,L,"\n");for(i=1;i<=n;i++){t=L[i];gsub(/^[ \t]+|[ \t]+$/,"",t);if(t!="")print p"\t"t}}' \
      "research/txt/$k.txt" > "research/txt/$k.idx"
done
```

Uso: `bash research/findpage.sh research/txt/core.idx 8 "Bind the Accusing Tongue"` → `230`.
2º argumento = offset (core 8, resto 1). **Conferir contra as 70 páginas do §I19 antes de
confiar** — foi assim que os 3 filtros de cima foram achados.

## `rebuild_ritual_desc.sh` — escrever entradas de `DESC` no `HH.14.lfm` (§T446)

3º gerador daqui, da 62ª rodada. Existe porque a chave de ritual é `<nível>. <nome>` (§V184)
e o picker ordena por ela: um ritual novo quase nunca é o último ∴ **enxertar antes do
marcador de FIM — a receita que fechou §T444/§T445 — põe a entrada no lugar errado, calado.**
Este script faz SORT-MERGE da tabela inteira, com a ordem vindo de `ritual_pages.tsv`.

```bash
SP=<scratchpad>/r ; mkdir -p "$SP"
bash research/rebuild_ritual_desc.sh "$SP" --split   # dumpa o que o .lfm JÁ tem
#   ... escrever os blocos novos em "$SP"/<qualquer nome>.lua (1 arquivo pode levar N) ...
bash research/rebuild_ritual_desc.sh "$SP"           # reescreve a tabela inteira
```

`--split` é obrigatório na 1ª chamada da rodada, senão o rebuild apaga o que já estava lá.
O script aborta sem tocar o `.lfm` em chave fora do mapa ou duplicada, e confere
`[==[`/`]==]`, `]]>` == 1 e a ordem no fim. `--split` + rebuild devolve o arquivo byte a byte.


## Antecedentes — do PDF ao `descBackground_*.lua` (§T765, 139ª rodada)

**4 peças, em ordem. Nenhuma é opcional.**

```powershell
# 1. corpo EN, dos 4 livros. Aplica research/bg_body_overrides.tsv sozinho.
research\bg_body.ps1 -Tsv research\bg_body_en.tsv -Out $env:TEMP\bg_raw.txt
# 2. (a metade PT nao tem gerador: research/bg_body_pt.tsv e traducao escrita a mao)
# 3. os 2 modulos, direto na raiz do plugin
research\gen_bg_desc.ps1
```

| arquivo | papel |
|---|---|
| `bg_essence.tsv`, bloco `BG_PICK` | `<item do picker>\t<livro>\t<pág impressa>`, 47 linhas, 0 ambiguidade (§T764) |
| `bg_body.ps1` | acha o cabeçalho, corta na calha, para no cabeçalho SEGUINTE, junta linha em parágrafo |
| `bg_body_overrides.tsv` | **12** corpos consertados a mão — o script cai aqui só p/ o item listado |
| `bg_body_en.tsv` | a saída, 47 linhas, `\n` de 2 chars = quebra de parágrafo |
| `bg_body_pt.tsv` | a tradução, mesmas 47 chaves (§V210a cobra isso no `.lua`) |
| `gen_bg_desc.ps1` | os 2 `.lua`, forma de §I21, **LF puro** (§V345) |

**⚠ `bg_body_en.tsv` é REGENERÁVEL, `bg_body_pt.tsv` NÃO.** Reescrever o EN é rodar o script;
reescrever o PT é traduzir 131 KB de novo. Se o EN mudar, o PT muda à mão junto — as chaves
têm de bater 1:1 ou `gen_bg_desc.ps1` grava um módulo a menos & §V210a reprova.

### As 4 armadilhas que esta bancada custou

13. **`Find-Gutter` erra em página de 1 coluna com escada de bolinha.** `core` p.113 (o corpo
    do `Domain`) é 1 coluna, mas a indentação da escada faz pico de brancura no meio & o corte
    mandou as últimas palavras de 8 linhas p/ uma "coluna B" — buracos no meio da frase & 7
    fragmentos órfãos no fim. **⊥ mexer na `Find-Gutter`**: é a mesma que `extract_merit_flaw`
    usa nos 641 nomes. O caso vai p/ o override, que é o instrumento que ∃ p/ isso.
14. **A de-hifenização come hífen de verdade.** `fami-`+`ly` (certo) e `name-`+`recognition`
    (errado) são a mesma regra, & ⊥ ∃ dicionário aqui. O script IMPRIME todas as colagens no
    fim & `$HYPHEN_KEEP` (10 palavras) desfaz as erradas. Colagem nova ! entra na lista.
15. **`U+FFFD` no COMEÇO de linha é bolinha; no MEIO é acentuada.** O V20 core mapeia as 2 no
    mesmo ponto. Trocar tudo escrevia `prot•g•` no lugar de `protégé` (core p.115, `Mentor`).
    Só a corrida inicial vira bolinha; o resto sai no relatório & tem conserto NOMEADO.
16. **Cabeçalho do M20 vem decorado** (`Enhancement $` · `Secret Weapons*` · `Totem $` ·
    `Sanctum/ Laboratory $`) & o `Wonder` é `Wonder (Device/ Fetish/ Talisman, etc.)`. O `Bare`
    tira a decoração — mas veja a armadilha de PowerShell abaixo, que é como ele falhou calado.

### A armadilha de PowerShell que fez os 4 sumirem calados

**A vírgula liga mais forte que o `+` no operando direito de `-replace`.**

```powershell
$t -replace '[\*\$' + $x + ']+$', ''   # vira -replace @('[\*\$'+$x+']+$'+''): 1 argumento so
$pat = '[\*\$' + $x + ']+$'; $t -replace $pat, ''   # o jeito certo
```

O 1º **⊥ dá erro** — devolve a string intacta. Foi assim que 4 dos 47 antecedentes ⊥ acharam
cabeçalho. Padrão montado por concatenação vai p/ **variável** antes, sempre.

## `gen_desc_system.ps1` — o bloco `System` dos 8 módulos de poder (§T768)

```powershell
research\gen_desc_system.ps1 -OutDir $env:TEMP\descgen        # SO MEDE
research\gen_desc_system.ps1 -OutDir $env:TEMP\descgen -Apply # grava por cima dos 8
```

Fonte = os `.lua` INSTALADOS, ⊥ o PDF: os 3 blocos de §I21 já estão lá & o texto já foi
conferido rodada a rodada. Só o RECORTE do bloco 3 muda.

**2 formas, ⊥ 1** (§I104e, §R133): `descDisc`/`descPath`/`descRitual` escrevem `System:` com
dois-pontos DENTRO de cada nível ∴ o recorte é por nível, do marcador p/ baixo.
**`descNumina` é o INVERSO**: `System` é cabeçalho de seção, linha sozinha, sem dois-pontos, &
os níveis moram DENTRO dela ∴ o recorte é do cabeçalho até o fim da entrada.

**A escada de bolinha decide o que é NÍVEL**: nível é a bolinha SEGUINTE da escada (1, 2, 3…).
`Auspex` põe `• Obfuscate:` `• Chimerstry:` `• Other Powers:` como LISTA dentro do `System` de
um nível; contadas como nível, elas cortam o `System` do dono no meio.

**Escreve em LF** (§V345, §B87) — a versão velha devolvia CRLF só no bloco reescrito, que é o
arquivo quebrando linha de 2 jeitos & o `diff` mentindo sobre a rodada.

A trava de §B88 segue armada: área que render **0** recorte recusa o `-Apply` & ⊥ toca nenhum
dos 8. As exceções de §I104c saem em `-OutDir\excecoes.tsv` — são elas que §V335c pede.

## Arquétipos de nature/demeanor (§T838, 150ª rodada)

Pipeline REPRODUTÍVEL da lista `nature` (que É a de `demeanor` — uma tabela só, `WoD20th.lfm:549`).
Já gerou `descNature_en.lua` e `descNature_pt.lua` na raiz do plugin; isto fica para regerar.

| arquivo | o que é |
|---|---|
| `arch_names.txt` | os **68** nomes de `PICKER_LIST["nature"]`, um por linha |
| `arch_extract.pl` | extrai a descrição de cada um dos PDFs, com livro e página IMPRESSA |
| `arch_body_en.tsv` | a saída dele: `nome ⇥ livro ⇥ pág ⇥ texto ⇥ OK\|FB` — **46** linhas |
| `arch_body_pt.tsv` | as traduções PT-BR: `nome ⇥ texto` |
| `gen_nature.pl` | monta o `.lua` na forma de §I21 — `gen_nature.pl <tsv> <en\|pt> <saída>` |
| `arch_qa_words.pl` | varre a saída atrás de lixo de emenda de coluna |

**Como rodar.** Os `.txt` dos livros NÃO ficam versionados (são ~50 MB). Gere-os primeiro, num
diretório qualquer, e aponte `ARCH_DIR` para ele — o script espera `$ARCH_DIR/books/*.txt` e
`$ARCH_DIR/arch_names.txt`:

```powershell
# 1. despejar os PDFs (o acento do caminho derruba o Git Bash; use PowerShell)
$exe = "C:\Program Files\Git\mingw64\bin\pdftotext.exe"
Get-ChildItem "<Books>" -Recurse -Filter *.pdf | ForEach-Object {
  & $exe -layout -enc UTF-8 $_.FullName "<dir>\books\$($_.BaseName -replace '[^A-Za-z0-9]','_').txt" }
# 2. extrair e gerar
$env:ARCH_DIR = "<dir>/"; perl research/arch_extract.pl > research/arch_body_en.tsv
perl research/gen_nature.pl research/arch_body_en.tsv en "<plugin>/descNature_en.lua"
```

⚠ **`-enc UTF-8` não é opcional**: sem ele o `pdftotext` sai em Latin-1 e o Perl morre na 1ª linha.

### 5 armadilhas MEDIDAS aqui, e as 3 primeiras produziram texto errado que PARECIA certo

1. **`for my $b (...)` sombreia o `$b` do `sort`.** Foi assim que a extração virou NÃO
   determinística: 31, 34, 39, 42 aceitas do mesmo input, porque a calha de coluna era sorteada
   a cada processo. Todo número medido antes disso era amostra de moeda. ⊥ usar `$a`/`$b` como
   variável de laço em script que ordena.
2. **Calha de outra página fatia palavra no meio & o resultado LÊ como prosa** — `"apathetic
   cowards"` virou `"apathet cowards"`. A calha do livro só vale como candidata: ! passar o
   mesmo teste de coluna-em-branco NAQUELA página antes de ser usada.
3. **Varredura automática ⊥ pega truncamento dentro da palavra.** `effi cient`, `judgt es`,
   `littl esteem` passaram por 6 regras de QA e só cairam na LEITURA das 46 inteiras. O QA acha
   pontuação torta e letra solta; ⊥ acha isso. **Ler é parte do processo, ⊥ opcional.**
4. **Hífen no fim da linha só é quebra se a continuação for MINÚSCULA.** `Thrill-` + `Seeker`
   virou `ThrillSeeker` até essa regra entrar.
5. **`use utf8;` ou os literais do próprio script ⊥ casam** com o dado decodificado — mordeu
   duas vezes, no `—` do `%FIX` e no `pág.` do gerador.

**As 18 emendas de costura** ficam em `%FIX` dentro de `arch_extract.pl`, cada uma conferida
contra a página pelo user em 2026-08-30. São coisas que régua nenhuma acha: palavra partida pela
virada de página, letra carregada da coluna vizinha.

## `descRoad` — a tabela de pecados das 55 Estradas (§T849, §I141, §R139)

**Estado 2026-09-02: extração MECÂNICA pronta, mapeamento nome↔tabela PARCIAL.** `.lua` NENHUM
foi escrito ainda — & isso é de propósito: no minuto em que `descRoad_en.lua` tocar o disco,
**§V408 cobra as 55 sozinha** (a isenção "kind sem módulo em disco" cai sem ninguém editar régua)
∴ ⊥ ∃ entrega parcial que deixe o gate verde.

| arquivo | o que é |
|---|---|
| `road_table_cache.ps1` | roda `pdftotext -table` nos **5** livros & guarda em `%TEMP%\wod_books_table\`. Idempotente |
| `road_sins_parse.ps1` | lê esse cache & cospe `road_sins_raw.tsv`. **MÁQUINA — ⊥ editar à mão** |
| `road_sins_raw.tsv` | **53** tabelas · **44** com os 10 níveis · 138 KB. `livro⇥pág⇥título⇥score⇥wrongdoing⇥rationale` |
| `road_bearing.tsv` | (já existia, §T748) os **55** nomes + aura + livro + pág de SEÇÃO + época |

### ⚑ `-table` é a descoberta desta rodada, & ela vale p/ §T848/§T850 também

O `pdftotext` daqui é **Xpdf 4.00** (`C:\Program Files\Git\mingw64\bin\`), ⊥ Poppler: ⊥ tem
`-bbox-layout`, **mas tem `-table`**. Os 3 caches que já ∃ (`wod_books_txt` · `wod_books_layout` ·
`wod_books_noenc`, §I142a) **⊥ servem p/ TABELA**: o `_txt` derrete a tabela em parágrafo (a coluna
`Rationale` vira 1 bloco colado no fim) & o `_layout` desalinha a linha do score da linha do texto
em `bh`/`lotc`/`da` p.118. `-table -enc UTF-8` alinha as 3 formas de §I141h **de uma vez**.

**⊥ ler o `-table` sem expandir TAB antes.** As tabelas do `core` vêm com `\t` no meio ∴ a posição
VISUAL da coluna ⊥ é o índice na string, & fatiar por índice devolve célula vazia calada. Expandir
p/ paradas de 8 resolve — foi `10` de `10` tabelas do core recuperadas nessa 1 linha.

**A régua é a linha de CABEÇALHO DE COLUNA, ⊥ o título.** Formas MEDIDAS, **4** & ⊥ 1:
`Rating` · `Score` · `Path Rating` · `Dots`. E **⊥ ∃ título** em 4 tabelas (`Sins Against the
Blood` da p.432 · `The Road of the Abyss` da p.442 · as 2 variantes do `dac` p.84). Ancorar a
coluna do score em **x=0** (⊥ no índice da palavra `Rating`) é o que faz `Path Rating` funcionar.

### ⚠ 3 achados que a SPEC ⊥ tem, & os 3 são FUSÃO onde o tsv diz MÃE

`road_bearing.tsv` marca filho só com `=<mãe>` na coluna do bearing (§I141d). Estes **3** ⊥ têm `=`
& mesmo assim herdam tabela — o livro DIZ isso em prosa, ⊥ em estrutura:

- **`Road of Angra Mainyu`** (dac p.84): *"mechanically similar to the **Via Apophis** (V20 Dark
  Ages, p.449), but with these **replacements**"* ∴ mãe = `HIERARCHY OF SINS AGAINST APEP`, da
  p.449, & ela tem **3** níveis próprios (10·2·1)
- **`Road of Ahura Mazda`** (dac p.84): *"mechanically similar to the **Via Humanitas** (V20 Dark
  Ages, 123), but with these **additions**"* ∴ mãe = `AGAINST THE SOUL`, da p.123 (= `Road of
  Humanity`), **3** níveis próprios (10·8·1)
- **`Path of the Archangel`** (dac): a tabela ⊥ está na p.70 da seção, está na **p.71**, & é
  PRÓPRIA (`SINS AGAINST THE ARCHANGEL`, 10 níveis) ∴ esta é mãe DE VERDADE — o susto foi a página

⚠ **`Via Apophis` ≠ `Road of Set`.** As 2 estão na MESMA página (da p.449) & são tabelas
DIFERENTES: `AGAINST SET` & `AGAINST APEP`. Casar pela página dá a errada.

### ⚑ O MAPA está PRONTO — `road_sins_map.tsv`, **55**/55, conferido contra o livro

O título da tabela no livro é **TEMÁTICO**, ⊥ o nome da Estrada: `AGAINST WHO YOU ARE` é
`Road of the Beast` na p.116 **&** `Road of Lilith` na p.130 ∴ casar por string ⊥ funciona. Casar
por proximidade de página tb ⊥: a tabela **FLUTUA p/ o topo da página** & cai ANTES ou DEPOIS da
seção sem regra (`Road of the Beast` seção p.117 → tabela p.**116**; `Path of the Hunter` seção
p.117 → tabela p.**118**). O que resolveu foram **2** âncoras de CONTEÚDO: os blocos
`Additional Ethics of <nome>:` (25 deles, cada um nomeia o Path) & ler os níveis quando ainda
sobrava dúvida — foi assim que saíram `Path of Community` (p.124: propriedade pública · roubo ·
genocídio) contra `Path of Illumination` (p.125: luz · Luminaries), & `Path of the Devil`
(`AGAINST REBELLION`: rejeitar a lei de Deus & do Homem = o Adversário) contra `Path of Screams`
(`AGAINST DAMNATION`: servir o Inferno).

`tid` = `<livro>:<pág>:<ordinal na página>`, & é o que liga o mapa ao `road_sins_raw.tsv` — o
TÍTULO ⊥ serve de chave porque **8** tabelas saem c/ título de prosa colada. **Conferido:** os 55
nomes batem 1:1 c/ `PICKER_LIST["road"]` & ∀ `tid` do mapa ∃ no raw.

### ⚠ `Road of Heaven` ⊥ TEM TABELA em livro NENHUM — & é a única das 55

MEDIDO: `da` pp.119-120 dão `Aura: Holiness` & `Virtues: Conscience and Self-Control` & vão
DIRETO p/ os 3 Paths (`Christ` p.120 · `Derech Chaim` p.120 · `The Prophet` p.121), cada um c/ os
**10** níveis PRÓPRIOS. A Estrada mãe ⊥ ganha hierarquia. Isso BATE de frente c/ §I141c
("**10** níveis p/ Estrada, SEMPRE — palavra do user") ∴ é **decisão do dono**, ⊥ escolha minha,
& está marcada `!SEM-TABELA` no mapa. As 2 filhas dela ⊥ sofrem: têm os 10 próprios (`!SEM-MAE`).

⚠ o livro tb tem **2** Paths que o picker ⊥ oferece — `THE PATH OF THE PROPHET (ISLAM)` (da p.121,
a 3ª via abraâmica do `Road of Heaven`) & `AGAINST THE EIGHTFOLD WHEEL` (da p.137) — ∴ as 2
tabelas ficam no raw sem dono no mapa, & isso é CERTO.

### `road_sins_overrides.tsv` — **9** linhas que o parser ⊥ acerta por CONSTRUÇÃO

Aplicado DEPOIS do parser, casando por `(tid, score)`; score que ⊥ ∃ no raw é **INSERIR**.
⊥ é preguiça de régua, é limite de forma, & ∀ um dos 3 motivos é diferente:
- **`da` p.131 imprime DUAS tabelas LADO A LADO** (`Path of Veils` à esquerda, `Path of Making` à
  direita) ∴ corte por LINHA mistura as 2 colunas. As 4 de `Making` saíram de fatiar em `x=62`, &
  **3** delas o gerador ! INSERIR — o parser só achou 1 dos 4 níveis. (As 3 de `Veils` o parser
  passou a acertar sozinho & SAÍRAM daqui — override obsoleto é a mesma podridão de roster que
  §V408 nasceu p/ impedir)
- **`core` p.312** — o cabeçalho da tabela é PROSA ∴ a coluna do wrongdoing ⊥ tem `x` confiável &
  as 3 linhas cuja célula quebra colhem a coluna vizinha
- **`core` p.317 & p.319** — o rodapé da página cai na última linha (score 1)

### ⚑ O PARSER, 9 defeitos corridos & 1 tentativa REVERTIDA

`46` de `57` tabelas c/ os 10 níveis (as 11 restantes são as filhas ESPARSAS, & isso é o livro).
Sobra de rodapé/cabeçalho: **2** linhas, as 2 no override. Os 9 defeitos, ∀ um MEDIDO:
`Wrongdoing` sozinho é cabeçalho (`da` p.432 põe `Minimum` na linha de cima) · a coluna do score
começa no GRUPO do cabeçalho, ⊥ em `x=0` (senão `Path Rating` some & a prosa entra) · 2º
cabeçalho encerra a tabela (`da` p.120 & `dac` p.84 vinham GRUDADAS) · tabela de 2 colunas corta
na goteira de 5 espaços · de-hifenização `diabler- ize` (§I142d) · **continuação ! ter a célula
do score VAZIA** — sem isso a linha de score 1 engolia o resto da página em **31** de 57 tabelas,
& o arquivo tinha **137 KB** de prosa colada contra os **74 KB** de agora · & nas linhas c/ TAB
(as do `core`) a atribuição é por BLOCO, ⊥ por fatia de `x`, porque o tab faz a fronteira
derivar & CORTAR PALAVRA (`non-Assami` `pay` `emotio`).

⚠ **REVERTIDA — "só aceita o bloco se ele começar a ≤6 da coluna".** Parecia a generalização
certa das 2 últimas & DERRUBOU `core` p.312 de 7 linhas boas p/ **0**: naquela tabela o `x` da
coluna vem de um cabeçalho que é prosa ∴ a régua de distância mede contra a coluna ERRADA. Fica
registrado porque a ideia vai voltar: a cura ⊥ é medir melhor a distância, é ⊥ confiar no `x`
quando o cabeçalho ⊥ é cabeçalho.
### âš‘ A AURA â€” bloco 3 de Â§I141b, & ela Ã© o 2Âº pipeline, âŠ¥ uma coluna do 1Âº

**FECHADO 2026-09-03 (Â§T849).** A aura Ã© PROSA & mora na SEÃ‡ÃƒO; a tabela de pecados Ã© TABELA &
mora na pÃ¡gina vizinha. SÃ£o fontes diferentes âˆ´ sÃ£o 2 pipelines de 4 peÃ§as, & tentar tirar a
aura do cache `-table` custa o mesmo que tirar a tabela do cache de prosa: âŠ¥ dÃ¡.

| arquivo | o que Ã© |
|---|---|
| `road_aura_parse.ps1` | lÃª `%TEMP%\wod_books_txt\` (o cache de PROSA de Â§I142a) â†’ `road_aura_raw.tsv`. **MÃQUINA, âŠ¥ editar Ã  mÃ£o** |
| `road_aura_raw.tsv` | **33** blocos rotulados nos 5 livros |
| `road_aura_overrides.tsv` | **9** blocos que o parser âŠ¥ alcanÃ§a por CONSTRUÃ‡ÃƒO, Ã  mÃ£o |
| `road_aura_map.tsv` | **55**/55 nome do picker â†’ `bid`, Ã  mÃ£o. âˆ€ `bid` resolve, & as 16 filhas apontam p/ a mÃ£e (Â§I141g) |

`bid` = `<livro>:<pÃ¡g impressa>:<ordinal>` â€” o MESMO formato do `tid` do `road_sins_map.tsv`, de
propÃ³sito: quem escrever Â§T931 lÃª os 2 mapas do mesmo jeito.

**CONFERIDO por varredura, âŠ¥ por amostra:** os 55 nomes batem 1:1 c/ `PICKER_LIST["road"]`, âˆ€
`bid` do mapa âˆƒ no raw ou no overrides, **0** bloco extraÃ­do fica sem dono, & o `<Nome>` de âˆ€
bloco bate c/ `BEARING` da ficha nas 39 mÃ£es â€” que Ã© Â§I141g valendo em disco & âŠ¥ sÃ³ no papel.

#### As 5 armadilhas, & as 5 produziram texto ERRADO que passava por certo

1. **O rÃ³tulo tem 2 grafias & elas se dividem por LIVRO, âŠ¥ por trilha.** `da` & `dac` escrevem
   `Aura:`; core/bh/lotc escrevem `Bearing:`. Procurar sÃ³ um perde **21** dos 33.
2. **O terminador âŠ¥ pode ser `Road of ` nem `Path of `.** As 2 frases aparecem DENTRO da prosa
   (*"A follower of the Road of Blood takes his task seriously"*) & cortar nelas decepou **4**
   blocos, deixando `A follower of the` como texto final. O terminador Ã© o rÃ³tulo IRMÃƒO que vem
   depois: `Virtues:` no `da`, `Basic Beliefs:` no core/bh/lotc.
3. **`-match` Ã© case-INSENSITIVE & `[regex]::Match` Ã© case-SENSITIVE.** Usar os 2 no mesmo padrÃ£o
   faz o teste "o bloco fechou nesta pÃ¡gina?" discordar do corte: o rodapÃ© `the road of lilith`
   casava minÃºsculo no teste & âŠ¥ casava no corte âˆ´ o bloco saÃ­a c/ o rodapÃ© colado dentro & sem
   a cauda que estava na pÃ¡gina seguinte. **A pior das 5, porque o texto sai plausÃ­vel.**
4. **O sidebar entra ENTRE o sujeito & o predicado.** O `pdftotext` lÃª por ordem do content
   stream: `lotc` p.70 pÃµe 446 caracteres de *"Alternative Children of Damballah"* entre
   `rolls to excite extreme` & `and transformative emotional responses`. RÃ©gua de forma âŠ¥ acha â€”
   o sidebar Ã© prosa vÃ¡lida & âŠ¥ tem rÃ³tulo. Mesma coisa no `dac` p.70 (3,5 KB).
5. **A tabela de pecados entra no MEIO da frase que vira a pÃ¡gina.** `da` p.129 (Lilith) corta em
   `chunks and swirls may` & a cauda sÃ³ aparece na p.130 **depois** da `HIERARCHY OF SINS` inteira.
   No cache de prosa a cauda parece âŠ¥ existir (busca por `swirl` no livro todo: **1** ocorrÃªncia);
   ela estÃ¡ no cache `-layout`, que Ã© onde as 2 colunas ficam separadas. Idem `da` p.122.

âš  **`da` p.449 tem DOIS `Their Aura` & o 2Âº Ã© do `Path of Apep`,** que o picker âŠ¥ oferece. Casar
por pÃ¡gina sem ler pega o errado â€” Ã© Â§I142b outra vez, na mesma pÃ¡gina em que ele jÃ¡ mordeu a
tabela (`AGAINST SET` â‰  `AGAINST APEP`).

âš  **`String.StartsWith(string)` Ã© CULTURE-SENSITIVE & `U+FEFF` tem peso ZERO** âˆ´
`"#x".StartsWith([char]0xFEFF)` devolve **TRUE** & o `Substring(1)` come o `#` do cabeÃ§alho â€”
aconteceu nos 2 `.tsv` escritos Ã  mÃ£o, calado. Comparar o CHAR (`$s[0] -eq [char]0xFEFF`).

#### As 3 contas de mÃ£e/filha âŠ¥ sÃ£o a mesma, & as 3 sÃ£o MEDIDAS

| eixo | mÃ£es | filhas | onde |
|---|---|---|---|
| bearing / aura | **39** | **16** | `road_bearing.tsv`, `road_aura_map.tsv` |
| tabela de pecados | **37** | **18** | `road_sins_map.tsv` |

A diferenÃ§a sÃ£o `Road of Angra Mainyu` & `Road of Ahura Mazda`: as 2 herdam **tabela** por prosa
do `dac` p.84 (Â§I141d) & mesmo assim tÃªm **aura prÃ³pria**, no mesmo parÃ¡grafo. âŠ¥ âˆƒ 1 nÃºmero que
sirva p/ as duas â€” sondar o artefato, âŠ¥ deduzir (Â§B141).

âš  `Path of Christianity`, `Path of Life/Judaism` & `Path of the Prophet/Islam` sÃ£o **mÃ£es de
tabela** (10 nÃ­veis prÃ³prios cada) & dividem **1** bloco de aura, `da:120:1`: o livro imprime a
Aura no nÃ­vel do guarda-chuva que Â§Q58 tirou da lista. O IslÃ£ abre a seÃ§Ã£o na p.121 & a aura dele
mora na p.120.

### ⚑ A ENTREGA — `gen_road_desc.ps1` escreve os 2 `.lua`, & **⊥ editar `.lua` à mão**

**FECHADO 2026-09-03 (§T931).** `descRoad_en.lua` (**79.833** B) & `descRoad_pt.lua` (**83.814** B),
**55** chaves idênticas nos 2, **4** blocos por entrada. O gerador é DETERMINÍSTICO & lê 8 `.tsv`
+ os **2** `.lfm`: se o texto está errado, o errado está num `.tsv` — conserta lá & roda de novo.

```powershell
cd research
.\road_table_cache.ps1   # pdftotext -table nos 5 livros -> %TEMP%\wod_books_table\  (idempotente)
.\road_sins_parse.ps1    # o cache -table -> road_sins_raw.tsv                       (MÁQUINA)
.\road_aura_parse.ps1    # o cache de PROSA -> road_aura_raw.tsv                      (MÁQUINA)
.\gen_road_desc.ps1      # os 8 .tsv + os 2 .lfm -> descRoad_{en,pt}.lua
```

O gerador **conta os buracos & fala**: chave sem prosa PT sai como `((FALTA pt <tid>|<score>))`
& o rodapé lista os que faltam. Foi assim que as 483 linhas & as 37 auras fecharam sem metade
calada — `COMPLETO - nenhum buraco de dado` é a única saída que serve.

**Os 2 `.lfm` são AUTORIDADE & ⊥ cópia**, & isso é §I141b valendo em disco: a lista & a ORDEM das
chaves saem de `PICKER_LIST["road"]`, o nome da aura sai de `BEARING`, & o nome PT sai do mapa PT
do `WoD20.6.lfm` — o MESMO string que a linha de `ROAD` da Main mostra. §V409(c) mede exatamente
essa igualdade nos 2 idiomas.

#### 5 armadilhas, & 3 delas fizeram texto ERRADO passar por certo

1. **`$bearing` & `$BEARING` são a MESMA variável** (PowerShell ⊥ distingue caixa em nome de
   variável). O mapa do tsv comeu a tabela lida do `.lfm` & as **55** entradas saíram com
   `Aura: System.Collections.Hashtable.` — gerador exit 0, log limpo. É §I142k outra vez.
2. **`’` (U+2019) fecha string no PS 5.1** (§I142h) & morde no `.ps1` do GERADOR, ⊥ no dado:
   `'The Black Hand: A Guide to the Tal’Mahe’Ra'` derruba o parse. O título entra por `[char]`.
   & o `.ps1` **precisa de BOM** (§B84) porque tem `—` & `pág.` — são 2 defeitos DISTINTOS.
3. **`String.StartsWith(string)` é CULTURE-SENSITIVE & `U+FEFF` tem peso ZERO** ∴
   `"#x".StartsWith([char]0xFEFF)` devolve TRUE & o `Substring(1)` come o `#` do cabeçalho —
   virou linha de DADO em 2 `.tsv`, calada. Comparar o CHAR: `$s[0] -eq [char]0xFEFF`.
4. **Os `desc*.lua` são LF de ponta a ponta & o resto do repo é CRLF** (§V345, §B87). Juntar as
   linhas com CRLF deixa o arquivo MISTO (o corpo das entradas já é LF) & o gate conta os 2 —
   foram **192** CRLF entre 2.308 quebras na 1ª escrita.
5. **A metade PT ⊥ pode ser escrita sem acento.** O CABEÇALHO dos `.tsv` de `research/` é ASCII
   por convenção & o DADO ⊥ é: `bg_body_pt.tsv` já carrega acento. A 1ª escrita das 483 linhas
   saiu sem, & régua nenhuma pega — é texto que o jogador lê.

#### ⚠ 8 defeitos de EXTRAÇÃO achados na hora de entregar, & a busca que os achou

O `road_sins_raw.tsv` estava VERDE no gate & tinha **8** células com lixo dentro. **4** saíram de
varredura de FORMA & **4** só de LER as 483 linhas:

| como se acha | o que era |
|---|---|
| minúscula colada em MAIÚSCULA na célula | `treatedAct as your own master.` (`bh:59:1`) |
| sobra depois do ponto final | `...you have begun. expected to` (`da:125:1`) |
| rodapé da página na última linha | `the road of sin 135` · `The road of kings 127` · `the 123` |
| título da tabela VIZINHA na célula | `...Gospel of Christ DERECH CHAIM - THE PATH OF LIFE ( JUDAISM)` |
| as 2 variantes do `dac` p.84 GRUDADAS | `Fearing Frenzy THE ROAD OF AHUR The Road of Ahura Mazda is m (V20 Dark Ages,` |

Os 8 estão em `road_sins_overrides.tsv` com o motivo. **A lição: contar caractere acha bloco
poluído barato** — os limpos ficam entre 90 e 390, & `da:129:1` tinha **1.690** com a tabela de
pecados dentro.

⚠ **Tabela de FILHA no `da` é de 2 COLUNAS** (`Score` + `Minimum Wrongdoing`, sem `Rationale`) ∴
`rationale` vazia nas 6 filhas do `da` é o LIVRO, ⊥ buraco de tradução. Idem o `core` p.312, que
é a forma (a) de §I141h. Encher isso "por simetria" inventaria texto.

### O que FALTA p/ fechar

⊥ ∃ mais nada em §T849 nem em §T931 — as 2 estão `x`, o gate está VERDE com §V409 nova & as 3
pernas dela passaram por MUTAÇÃO (tirar 1 nível de filha avermelha (b); trocar 1 nome de aura
avermelha (c); colar os 4 blocos com 1 quebra avermelha (a)).

As **3** §Q que a lista `road` carrega seguem ABERTAS, & nenhuma delas bloqueou a entrega — as 3
foram construídas pela RECOMENDAÇÃO registrada na própria §Q, & trocar de decisão custa **1**
`gen_road_desc.ps1`, ⊥ 110 entradas à mão (é para isso que o gerador existe):

1. **§Q55** — qual das 3 páginas candidatas vai no bloco 1. Construído: a que **ABRE a seção**,
   que é a que `road_bearing.tsv` carrega. ⚠ as **16** páginas de filha do tsv saíram do SUMÁRIO
   & o próprio arquivo manda conferir antes de virar citação — o bloco 3 ⊥ herda esse problema
   (a filha aponta p/ o `bid` da MÃE, lido na página), mas o bloco **1** herda.
2. **§Q56** — o separador do par novo. Construído: o MESMO `\n\n\n`, & §V409(a) já o cobra.
3. **§Q57** — marcar ou ⊥ as linhas herdadas. Construído: **⊥ marcar**, & o cabeçalho é o que o
   LIVRO dá ao filho (`HIERARCHY OF SINS AGAINST THE HUNT`), ⊥ o da mãe. Os **2** do `dac` p.84
   são a exceção & saem com o cabeçalho da MÃE: o livro ⊥ dá título nenhum a eles.

⚠ **A decisão que ⊥ estava em §Q nenhuma & é minha: a FORMA do bloco 4.** `<cabeçalho>` + linha
em branco + `<score> — <wrongdoing>` + `      <rationale>` indentada, 1 nível em branco entre
níveis. O `textEditor` das panes ⊥ estiliza linha (§V29, §V31) ∴ tabela de verdade ⊥ ∃; isto é o
mais próximo que lê como tabela sem virar caractere de decoração. Trocar = 1 função no gerador.
