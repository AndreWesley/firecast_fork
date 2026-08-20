# HANDOFF — estado antes do próximo `/ck:build`

Escrito 2026-08-19, atualizado 2026-08-20 (fim da 58ª rodada). Para um Claude que abre
a sessão sem contexto.

## COMECE AQUI

Sobrou **~27 comandos `/ck:build`**, e **~24 deles são as 3 tabelas de `DESC`**. Tudo o
mais está fechado: ⊥ ∃ portão aberto, ⊥ ∃ drift de spec, gate verde, `.rpk` instalado.

```bash
cd "c:/Users/awlol/OneDrive/Documents/firecast_fork"
powershell -NoProfile -ExecutionPolicy Bypass -File ./verify-hunters-hunted.ps1 | tail -2
grep -c "	x$" research/disc_pages.tsv research/path_pages.tsv research/ritual_pages.tsv
```

O 1º ! dizer `ALL CHECKS PASSED`. O 2º é o PROGRESSO das 3 tarefas grandes — ele mora nos
mapas, **⊥ no `SPEC.md`** (o §T fica `~` do começo ao fim das 36/64/284 entradas).

| §T | arquivo | mapa (5ª\|6ª coluna = `x`\|`.`) | feito | retomar em |
|---|---|---|---|---|
| T444 | `HH.12.lfm` | `research/disc_pages.tsv` | 4 / 36 | `Auspex` |
| T445 | `HH.13.lfm` | `research/path_pages.tsv` | 1 / 64 | `Awakening of the Steel` |
| T446 | `HH.14.lfm` | `research/ritual_pages.tsv` | 2 / 284 | `1. Ambrus Kelemen’s Aegis` |

Ordem alfabética do picker em cada um. Os 3 mapas já dão **livro + página impressa dos
384** — essa extração foi paga e validada (as 70 páginas que o §I19 tinha à mão bateram
70/70). **⊥ reextrair.** A forma exata de cada entrada está em *Forma das 384 entradas*, ↓.

Depois das 3: **T470** (2º corpo de `DESC` por época) · **T448** (checks §V172…§V189) ·
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
    as páginas que o §I19 tinha à mão
  - `d36.list` · `paths.tsv` · `rd_*.tsv` · `adv_*.tsv` — as listas congeladas em §T430
  - `findpage.sh` · `mapritual.sh` — os geradores dos mapas. Precisam de `research/txt/*.idx`,
    que **⊥ está no repo** (é texto de livro); o `README.md` de lá tem o comando de regerar
  - **Leia `research/README.md` ANTES de reextrair qualquer coisa** — ele lista 6 armadilhas
    que já custaram tempo, incluindo as 3 que o gerador de página errou sozinho
- **`SPEC.md`** — fonte da verdade. §I19 §I20 §I21 §I22 §V184 §V192 §V196 §V197 §C §I10b
- **`verify-hunters-hunted.ps1`** — o gate, na raiz de propósito (fora da pasta que o
  `rdk` empacota). ASCII puro: PowerShell 5.1 lê `.ps1` sem BOM como ANSI

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

Último estado verde: `.rpk` gerado E instalado com **3.375.062** bytes, 2026-08-20 16:56.
Os dois batem — é essa igualdade que prova o install, ⊥ o exit 0.

## Próxima tarefa

A 58ª rodada fechou **T472 · T447 · T473 · T460 · T432 · T469 · T471** e deixou **T444 em `~`**. O que isso muda para você:

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
- **§B42/§V195 NOVOS**: §V9 & §V24 do gate testavam ASCII puro & reprovavam os 42 nomes
  canônicos com `’` (U+2019). Agora `’` é a ÚNICA exceção & ∃ check novo que recusa `'`
  ASCII em `items=`/`values=` — apóstrofo reto PARTE o item em 2 calado.

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

### §V196 & §V197 — o gate agora mede picker

`HH.7` & `HH.2` estavam estourados **desde que nasceram** e ninguém tinha visto: §V16 mede
`//label` desde a 1ª rodada & NUNCA olhou `comboBox` (§B43). §V196 mede, nos 2 eixos que o
`items` tem (idioma × época) — e foi ele que achou o §B44: `eraName` renomeava `Weather
Control` na númina de `HH.7` também, porque `value` ⊥ carrega SENTIDO. §V197 escopa.

**Estouro de picker aparece em CASCATA** (§B45): o check reporta 1 por combo, o pior item
∴ consertar o maior faz o 2º surgir. Rodar o gate ATÉ VERDE antes de anotar número.
### Ordem sugerida daqui

**T471 FEITO** na 58ª rodada (§V194 armado, 4 mutações). **T444 · T445 · T446 estão `~`** —
o corpo das 3 começou e o PROGRESSO MORA NOS MAPAS DE PÁGINA, ⊥ aqui:
| §T | arquivo | mapa de progresso (última coluna `x`\|`.`) | feitas |
|---|---|---|---|
| T444 | `HH.12.lfm` | `research/disc_pages.tsv` | 4 / 36 |
| T445 | `HH.13.lfm` | `research/path_pages.tsv` | 1 / 64 |
| T446 | `HH.14.lfm` | `research/ritual_pages.tsv` | 2 / 284 |

Retomar por ordem alfabética do picker em cada um. Os 3 mapas dão **livro + página
impressa de TODOS os 384 itens** — a extração dos 8 PDFs já foi paga e validada
(as 70 páginas que o §I19 tinha à mão batem 70/70). ⊥ reextrair; ler
`research/README.md` antes de mexer nos scripts.

| # | §T | por quê AQUI |
|---|---|---|
| 1 | T444 · T445 · T446 | o grosso. Podem correr em qualquer ordem: 3 arquivos disjuntos (§V189) |
| 2 | T470 | 2º corpo de `DESC` por época |
| 3 | T448 | checks de §V172…§V189, medem o que já ∃ |
| 4 | T449 | version 4.9→5.0 + build + install, fim |
| 5 | T450 | o teste de aceitação da ficha inteira |

**CORREÇÃO da 58ª rodada:** o `HANDOFF` velho dizia que o portão de layout travava
T444–T446. **⊥ trava.** O texto de `DESC` é indexado por `value` & renderizado com
`wordWrap` ∴ mudar a largura da combo reflui a caixa & ⊥ toca 1 linha do conteúdo.
O portão vale p/ o LAYOUT. As 3 tarefas de `DESC` podem correr antes dele.

### ⚠ O TAMANHO REAL de T444–T446 (medido, ⊥ estimado)

A tabela de "quantos builds" do `HANDOFF` velho dizia ~14 p/ as 3 juntas. **Está errada
por quase 2×.** Medição da 58ª rodada, com os PDFs na mão:

- 1 disciplina do core ≈ **9 KB [en] + 9 KB [pt]** · 1 trilha ≈ o mesmo · 1 ritual ≈ **1–2 KB**
- `HH.12` 12 KB → **61 KB** com 4 entradas · `.rpk` 3,18 MB → **3,37 MB**
- ∴ **T444 ≈ 9 comandos · T445 ≈ 6 · T446 ≈ 10. ~25 no total**, ⊥ 14

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

Nada commitado desde `77434067` (2026-08-19). 12 modificados, 6 novos.

Modificados: `HH.1.lfm` `HH.2.lfm` `HH.6.lfm` `HH.7.lfm` `HH.10.lfm` `HH.11.lfm`
`HuntersHunted.lfm` `localization.lang` `output/*.rpk` `SPEC.md` `verify-hunters-hunted.ps1`
`CLAUDE.md`.
Novos: `HH.12.lfm` `HH.13.lfm` `HH.14.lfm` `HANDOFF.md` `research/` `.claude/`.

`HH.10.lfm` & `HH.11.lfm` já estavam modificados ANTES da 58ª rodada — ⊥ foram tocados nela.
