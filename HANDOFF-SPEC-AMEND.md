# EMENDA DE SPEC pedida pela 157ª rodada (2026-08-31)

Cole o conteúdo abaixo como argumento de `/ck:spec amend` num chat sem contexto.
São **11** pontos. Nenhum é opinião: cada um foi MEDIDO contra o código em `8cc288be`,
ou é uma decisão do user já tomada e que o `SPEC.md` ainda não registrou.

Regras que valem para a emenda: numeração de §V/§B/§T é monotônica (nunca reusar id);
o idioma-fonte de string visível é inglês; só `/ck:spec` escreve seções.

---

## 1. §I113c — o filtro NÃO é "o programa" (o ponto mais caro se ficar como está)

**Hoje diz:** que `pickAllowed`, a época e a afiliação moram dentro de `pickerItems` e que
"é ISTO, ⊥ o desenho da caixa, que faz a Q30 ser um programa".

**MEDIDO 2026-08-31** (implementado, verde, depois revertido junto com a onda): o filtro é
**8 linhas** dentro do laço que monta `MF.pool` em `mfOpen` —

    local levels = discLevels();
    local hedge  = hedgePathLevels();
    ...
    if vals[i] ~= "" and pickAllowed(MF.field, vals[i], levels, hedge) then
        MF.pool[#MF.pool + 1] = vals[i];
    end;

`levels` e `hedge` são lidos **1×** por abertura e não por nome — `hedgePathLevels` percorre a
ficha, e fazer isso 600× para uma lista de rituais é a carga que §I107 já pôs atrás de um timer.
A mesma função dos dois lados mantém §V199: a caixa não pode oferecer o que `guardPick` devolve.

**Emendar para:** o filtro é uma chamada no laço do pool; o que faz a onda 3 ser cara é §V365(d)
(ver ponto 3), não ele.

## 2. §I117c — §Q32 está RESPONDIDA

**Hoje diz:** "o N ⊥ está decidido — §Q32 ... ⊥ escrever nenhum dos 2 como fato antes da resposta".

**O user respondeu em 2026-08-30** (está no HANDOFF, seção "DECISÕES DO USER"): `psychic` vai a
**20** e os 4 excedentes são APAGADOS DE VEZ — saem `psychic_16`…`_19` (pickers), não `_21`…`_24`,
para que nenhum campo mude de sentido. `numina` vai a **20** com 3 pickers novos, `_18` `_19` `_20`.

**Emendar para:** §Q32 RESPONDIDA, com os números acima como fato. §T830 deixa de estar bloqueada.

## 3. §I118d — a contradição, e a saída que §T862 abriu

**Hoje diz** duas coisas incompatíveis: "o trabalho é tirar o `vampStrip`, tirar as panes & pôr
os 3 `<import>` lado a lado, **⊥ redesenhar caixa nenhuma**" e "as 3 saem & as colunas **encolhem
p/ ~350** cada".

**MEDIDO:** as listas somam **1475** (`WoD20.12` = 390 · `WoD20.13` = 565 · `WoD20.14` = 520 —
confirmado contra o XML: a pane de cada arquivo começa em 395 / 570 / 525). Encolher 565 → 350 é
redesenhar caixa, que a primeira metade proíbe.

A segunda metade só existia porque a aba Ghoul estava presa em **1070**. **§T862 levou a ficha a
1680**, então três colunas lado a lado pedem `1475 + 2 vãos` = **1485** e cabem. O user aprovou
alargar em 2026-08-31.

**Emendar para:** aba Ghoul `1070` → **1485**; os 3 `<import>` em `left` **0 / 395 / 965** com
larguras **390 / 565 / 520**, `top=150` (o strip saiu), todos visíveis. "⊥ redesenhar caixa
nenhuma" fica VERDADEIRO; a frase dos ~350 sai.

## 4. §I118d / §I117e — o CUSTO real, que nenhuma das duas diz

**Acrescentar (é o achado que evita a próxima rodada tropeçar):** tirar as panes e o strip é uma
rodada de **GATE**, não de layout. O código são ~30 minutos; as **~20 réguas** são o trabalho.

Contagens que mudam, todas medidas: botões de barra **19 → 16** · barras **4 → 3** · separadores
**5 → 3** · grupos de `SUB_TABS` **3 → 2** · nomes de sub-aba **8 → 5** · caixas de seção
**73 → 70** · panes nomeadas **9 → 6** · alvos do pintor **24 → 19**.

Réguas que pedem JULGAMENTO e não literal: **§V188 §V192 §V193 §V225 §V249/§V250 §V299(b) §V307
§V320**, mais §V221, que tem de passar de "painéis empilhados numa rect" para "colunas DISJUNTAS
em x" (a régua de §V40 aplicada às 3 colunas).

⚠ **Armadilha medida na tentativa:** apontar §V249/§V250 para `edtHedgeDesc` da Numina supondo
forma igual **não funciona** — `saveNuminaDesc` escreve `box.text`, não `form.<Edit>.text`.
Seguir o sujeito para a Numina é o caminho certo (é o que §V255 fez ao perder os dele), mas
medindo a forma DE LÁ.

## 5. §I129k e §V381(c) — a ordem de `descFor` condiciona em `key`, não em `sheet[slot]`

**Hoje diz:** "(1) slot casa o nome custom & ⊥ vazio → `customDescFieldOf` · (2) → `descFieldOf`".

**Está errado e o código faz outra coisa, de propósito.** Escrita contra `sheet[slot]`, a ordem
mostraria o texto DA LINHA sob todo candidato enquanto o jogador navega o picker. Os dois
primeiros passos hangam em **`key`**:

    1. `key` É o nome custom deste slot   -> o texto que o jogador escreveu
    2. `key` É o que o slot tem AGORA     -> o override do narrador
    3. senão                              -> o livro, descText
    4. nada em disco                      -> a frase de §V360c

É isso que deixa UMA ordem servir os dois leitores: o `?` pergunta pelo que a linha TEM (então
`key` é o valor do slot e 1 e 2 podem disparar); o picker pergunta por um CANDIDATO.

**Emendar §I129k e a perna (c) de §V381 para a ordem acima.**

## 6. §I129c — são 2 chaves novas, não 3

`wod.Name` **já existia** em `localization.lang` (linhas 155 e 2148). As novas são
`wod.-- Custom --` e `wod.custom description`. Escrever 3 fez nascer uma chave duplicada, que eu
tive de remover.

## 7. §I129d — `mfCustom` não escreve a pane; passa por `mfDesc`

**Emendar:** `mfDesc(found, name, own)` ganhou um terceiro parâmetro. `mfCustom` chama
`mfDesc(found, nil, tx)`. Motivo: §V372(a) exige **1** escritor de `edtMfDesc.text`, e
`mfCustom` escrevendo direto fazia 2. O reset de estado (`MF.custom = false` + `mfCustomPane
(found, false)`) só roda quando `own == nil` — com a prosa custom na mão, esse É o estado custom.

## 8. §I128e — o XML autora o PIOR caso, não o de [en]

**Hoje sugere** autorar a geometria de [en] (26px). **§V16/§V25 e §V351(c) leem o XML** e um
rótulo autorado na largura inglesa é um `CAMINHO` cortado esperando alguém abrir em pt.

**Emendar:** o XML autora **pt** (`left=37 width=46`, controle em `88`) e `renderRoadPair`
encolhe para [en]. É o que §V49 já faz com a altura de dez linhas do `HEALTH`: o arquivo declara
o maior que pode ser, o Lua reduz.

## 9. §V330c — `cboRoad` tem 2 donos NOMEADOS

**Hoje:** só `renderBearing` pode nomear `cboRoad`.

**Emendar:** dois, e a lista é fechada — `renderBearing` (o que ele MOSTRA) e `renderRoadPair`
(onde ele FICA). É a mesma divisão que §I128f já faz no rótulo: a travessia de `WoD20.6` é dona
do texto, o Lua é dono da geometria. A razão de §V330c sobrevive: dois tocadores só são duas
réguas quando decidem a MESMA coisa.

## 10. §V255 — trocou de sujeito

`SpecialityFreeRow` e `OpenAbilityFreeRow` morreram em §T870. A régua ("linha digitada mantém os
dots e o x da picker, e nunca ganha combo") passou a medir as **6** famílias que ainda têm linha
livre: `DiscFreeRow` `SecPathFreeRow` `RitualFreeRow` `NuminaFree` `PsychicFree` `HedgeRitualFree`.

⚠ E o seletor mudou: o dono do nome é o primeiro **`<edit>`**, não o primeiro nó com `field` —
essas 6 abrem com o `radioButton` que seleciona a linha, e lê-lo como dono reprovava 6 templates
corretos. As 2 antigas não tinham radio, então a distinção nunca apareceu.

Quando as ondas 3 e 4 rodarem, o último sujeito sai e §V255 sai com ele.

## 11. §V377 / §V378 — os zero-guards são POR TEMPLATE, não literais

**§V377** propunha "< 150 slots colhidos". Ficou: **cada** template que abre picker tem de render
≥1 slot, e o total > 0 — assim o número não precisa ser levantado à mão a cada onda. Os campos
são colhidos EXPANDINDO os templates pelas instâncias, e o padrão é lido do FONTE de
`descFieldOf` (hoje mede 39 slots em 4 templates).

**§V378(b)** propunha medir por prefixo de campo. Não serve: `OpenAbility` liga
`field="$(field)"` e um teste em `background_` passa direto por ele — a perna cobria 2 famílias
de 4 sem dizer. Ficou medindo **por template convertido** (`MeritPicked` `OpenAbility`
`SpecialityRow` `HeaderPicker`): botão visível + gêmeo escondido, que é o fato de §I107a1.
A exceção de §I130c no gate é `readOnly="true"` (as colunas book/page/cost), mais
`specialityName_` e os templates `CustomAbility` / `HeaderNarrow`.

---

## E UMA COISA QUE NÃO É EMENDA: uma decisão do user que ainda não virou §I/§V

O user decidiu em 2026-08-31, ao ser perguntado, que **o `-- Custom --` herda a isenção do filtro
que a linha digitada tinha**. Isso ainda NÃO está no `SPEC.md` nem no código (foi implementado e
revertido junto com a onda 3).

O problema que ela resolve: `pickRefusal` tem `if isTypedRow(field) then return nil; end;` — a
linha digitada era a válvula de escape do filtro. Quando §T873/§T875 tirarem as linhas livres,
`isTypedRow` fica falso para todas, e um nome `-- Custom --` numa linha de disciplina bate em
`guardPick`, que **reverte o campo e avisa**: o jogador digita, confirma e vê sumir.

A forma escolhida (a mais estreita das três oferecidas) é:

    local cf = customFieldOf(field);
    if sheet ~= nil and cf ~= nil and sheet[cf] == value then return nil; end;

Não é "qualquer linha que tenha custom" — é ESTE valor ser o nome custom deste slot. Qualquer
outra coisa numa linha filtrada segue enfrentando a regra inteira.

**Escrever como §I nova + §V nova, e como §T** dentro do bloco da onda 3 (as ondas dependem dela).
