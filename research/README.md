# research/ — listas extraídas dos livros

Dados DERIVADOS dos PDFs em
`C:\Users\awlol\OneDrive\Documents\RPG\Storyteller V20\Vampiro\Vampiro - A Máscara\Books`.
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

Os 5 `rd_*.tsv` de livro já vêm **dedupados entre si**, na precedência
core > RoB > (LotC/LoB/DAC/BH) > TOS > DA. Somados dão 284 sem repetir nome.

## Offset de página, por livro

Página IMPRESSA = página do PDF menos:

| livro | offset | época |
|---|---|---|
| V20 core | 8 | moderna |
| Dark Ages base · Tome of Secrets · DA Companion | 1 | medieval |
| Lore of the Clans · Lore of the Bloodlines · Rites of Blood · The Black Hand | 1 | **moderna** |

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

## Comando de reextração

```bash
export PATH="/mingw64/bin:$PATH"
pdftotext -enc UTF-8 "<livro>.pdf" saida.txt          # fluxo
pdftotext -layout -enc UTF-8 "<livro>.pdf" saida.txt  # 2 colunas preservadas

# índice por página: <pagina_pdf>\t<texto>
awk -v RS='\f' '{p=NR;n=split($0,L,"\n");for(i=1;i<=n;i++){t=L[i];gsub(/^[ \t]+|[ \t]+$/,"",t);if(t!="")print p"\t"t}}' saida.txt
```

`Vampire V20 - Anarchs Unbound.pdf` ⊥ rende nada (§R69): 0 marcador de nível. Já varrido.

## `disc_pages.tsv` — o mapa de página de §T444 (58ª rodada)

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
