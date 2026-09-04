# EMENDA DE SPEC — pronta p/ colar em `/ck:spec`. Escrita 2026-09-03 (fim da 174ª rodada)

**⊥ APLICADA AINDA.** São **4** operações & **1** id novo (**§B145**). Máximos MEDIDOS 2026-09-03:
**§B144 · §V414 · §T938 · §I143 · §R139 · §Q60** ∴ o único id a nascer é §B145; o resto EMENDA
linha que já ∃.

⚠ **A emenda da 173ª (o `se` de §Q59) JÁ FOI APLICADA** na 174ª — **⊥ recolar**. Tudo abaixo saiu
de MEDIÇÃO feita ao CONSTRUIR §T936, & **2 das 4 contrariam o que a linha diz hoje**.

---

## 1. EMENDAR §Q59 & §I143j — o aperto libera **385**, ⊥ 405, & `DOMINATOR` fecha em **578**

**O que a linha diz hoje:** `DOMINATOR` 660→**558** pela conta `20+72+5+225+20+156+10+`**30**`+20`,
& o box da fraqueza fica com **405**.

**O que foi MEDIDO ao construir:** o **30** é impossível. A 4ª coluna do grid de §V224 carrega
`cmbDominatorGen`, & §V196 preça um comboBox em `NeededPx(item mais longo) + ARROW`: `10th` são
4 chars × **6,5** (o combo ⊥ autora `fontSize` ∴ cai na régua do corpo, ⊥ na de 12) = 26, **+24**
de seta = **50**. Abaixo disso o picker CLIPA. ∴ a conta certa é
`20+72+5+225+20+156+10+`**50**`+20` = **578**, o aperto libera **82** em vez de 102, & o total é
102−20 = **385** p/ o box, ⊥ 405.

**Acrescentar ao fim de §Q59 & de §I143j:**

> ⚠ **CORRIGIDO 2026-09-03 ao CONSTRUIR §T936: `DOMINATOR` fecha em 578 & o box da fraqueza é de
> 385.** A conta velha dava **30** à 4ª coluna & o piso dela é **50** — `cmbDominatorGen` mora
> lá, & §V196 preça combo em `NeededPx + ARROW` = 26+24. As outras 3 pernas do aperto saíram
> como escritas: margens 35→**20** (§V280a), o vão de 49→**20**, os rótulos a **72**/**156** &
> as 20 bolinhas de passo 28→**26** (`BLOOD POOL` 405→**299**), & `EXPERIENCE` 333→**131**
> (`20+91+20`, o `edit` ⊥ se mexeu). A banda fica **578·299·385·131** + 3 vãos de 5 = **1408**,
> o mesmo das 3 colunas ∴ **a conclusão ⊥ muda: a aba ⊥ cresce**. O texto continua cabendo: 385
> − 40 de margem = **345**px ÷ 6,0 = **57** chars/linha × **4** = **228**, contra o pior caso pt
> de **221**. A folga caiu de 19 p/ 7 chars & o `textEditor` rola de qualquer jeito

---

## 2. EMENDAR §V412(f) — a completude é cobrada **2 vezes**, & a 2ª é a do IDIOMA

**Por que:** a linha diz que (f) é "∀ nome de `PICKER_LIST["family"]` tem linha na tabela". A régua
construída cobra **também** que ∀ FRASE da tabela tenha chave nas **2** metades de
`localization.lang` — sem isso a tabela é inglês autorado que `translateSheetText` ⊥ acha, & a
ficha em pt mostra as 23 fraquezas em INGLÊS com o gate verde. Mutação que a acende: reescrever
1 frase sem mover a chave (rodada, VERMELHA).

**Acrescentar ao fim de §V412:**

> ⚠ **EMENDADA 2026-09-03 (§T936): (f) tem 2 metades & a 2ª é o IDIOMA.** A tabela nasceu em
> `WoD20th.lfm` como irmã de `FAMILY_CAP` & **só em inglês** — o [pt] mora em
> `localization.lang` como o de toda frase que a ficha mostra, & `translateSheetText` é o único
> que o lê (§V9, §V10, §V24). ∴ (f) cobra as 2: ∀ nome da lista tem linha na tabela **&** ∀
> frase da tabela tem chave nas 2 metades do `.lang`. Sem a 2ª a ficha em pt mostraria as **23**
> fraquezas em inglês com o gate VERDE, que é §B57 pela porta do dado. ⚠ a frase de ausência é
> **1** só (`-- no weakness --` / `-- sem fraqueza --`) & o TÍTULO do box (`REVENANT WEAKNESS` /
> `FRAQUEZA DE REVENANTE`) passa por §V10/§V28 como todo rótulo — ele ! entrar TAMBÉM no mapa
> `PT` de `WoD20.6`, & foi o que §V28 cobrou no 1º disparo

---

## 3. EMENDAR §V414(a) — é a SOMA das larguras, ⊥ a borda onde a faixa FECHA

**⚠ isto é MEDIÇÃO contrária, & a régua chegou a ser escrita do jeito errado.** (a) diz
"`Σ(larguras) + 3×vão` ≡ `Σ(larguras) + 2×vão`". A 1ª implementação leu `max(left+width)` de cada
faixa — a mesma pergunta, "onde a faixa fecha", mais barata. **A mutação reprovou:** engordar
`DOMINATOR` de 578 p/ 598 sem pagar embaixo ⊥ move borda NENHUMA (a caixa cresce PARA DENTRO da
vizinha), as 2 faixas seguem fechando em 1408 & a régua passava VERDE sobre 20px de sobreposição.

**Acrescentar ao fim de §V414:**

> ⚠ **MEDIDO 2026-09-03 (§T936), & é o avesso do que parece: (a) ! ser a SOMA, ⊥ a borda.**
> `max(left+width)` responde "onde a faixa fecha" & é VERDE p/ a caixa que cresce PARA DENTRO da
> vizinha — 578→598 deixa as 2 faixas em 1408 & 20px de sobreposição (a sobreposição é de §V40 &
> §V298, ⊥ desta). A soma pergunta outra coisa: "as caixas, postas com o vão da casa, querem o
> mesmo espaço" — & essa acende. ⚠ **o vão é DERIVADO, ⊥ digitado**: sai do que as 3 colunas de
> fato deixam entre si (§V221 & §V298 é que o seguram em 5) ∴ esta linha ⊥ vira 3ª dona do
> número (§B70). MUTAÇÕES rodadas: banda cresce sem pagar → VERMELHA por (a) · coluna encolhe
> sem a banda → VERMELHA por (a) · tirar o fundo de 1 caixa do Ghoul → VERMELHA por (c) · SONDA:
> trocar a ORDEM de 2 caixas da banda mantendo o total → **VERDE**

---

## 4. §B145 NOVO — igualdade sobre BORDA passa pela caixa que cresce para DENTRO

`B145|2026-09-03|régua de igualdade entre 2 faixas escrita sobre a BORDA onde cada uma fecha
(`max(left+width)`) em vez da SOMA das larguras: caixa que engorda para DENTRO da vizinha ⊥ move
borda nenhuma ∴ a régua passa VERDE sobre a sobreposição que ela ∃ p/ pegar. Achado por MUTAÇÃO
antes de entrar (§V20, §V222), ⊥ em produção. **A lição é geral & ∃ mais régua assim no gate:
quando 2 conjuntos ! "dar no mesmo", medir a SOMA dos elementos & ⊥ o extremo do conjunto — o
extremo é insensível a tudo que acontece no meio dele.**|V414a`
