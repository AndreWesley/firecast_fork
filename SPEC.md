# SPEC

## §G GOAL

Ficha Firecast p/ Hunters Hunted (mortal WoD 20th), estrutura clonada do `Mage20th`, conteúdo = PDF `VaV20_1-Page_Mortal_Interactive`.

## §C CONSTRAINTS

- Firecast SDK3. `sdkVersion` ∈ `module.xml` pertence ao rdk — toolchain instalado = `3.7b`, rdk reescreve @ prepare/compile. ⊥ fixar à mão (§B.2).
- `.lfm` XML declarativo. Lua só onde Mage já usa: autoupdater + delete de `recordList`. ⊥ lógica nova.
- ⊥ rolagem de dados automática. Base Mage ⊥ tem, PDF ⊥ pede.
- ⊥ derivados calculados (dice pool, penalidade de Health). Ficha = papel, jogador soma.
- Mage-only ⊥ portar: Spheres, Rotes, Focus, Arete, Quintessence, Paradox, Wonders.
- Sheet novo ∈ plugin `World of Darkness 20th` existente ∴ reusa build, autoupdater, tema, `.lang`. Plugin separado = 1 `module.xml` novo + `.rpk` novo ?
- idioma-fonte de ∀ string visível = inglês; `.lang` [pt] traduz. ⊥ autorar string em PT (§B.4).
- listas de conteúdo (arquétipo/antecedente/númina) ⊥ no repo ∴ ⊥ escrever como fato sem validação do user (§R.8).
- HERD & HAVEN & FEEDING GROUNDS = vampiro-only ∴ ⊥ portar p/ ficha mortal.
- forma do picker = `comboBox` sozinho, na posição onde ficava o `edit`. DECIDIDA pelo user 2026-08-17. ⊥ texto livre ∴ valor fora da lista ! virar item da lista (§V.14 §V.17).
- Merits & Flaws ⊥ no PDF ?
- Abas Background & Notes ⊥ no PDF, herdadas da base Mage ?
- Numina = 8 picker + 2 linha livre (era 11 abertas). `numina_11` & `numinaNotes` REMOVIDOS a pedido do user 2026-08-17 ∴ remoção pedida ≠ rename acidental, §V2 ⊥ se aplica
- ordem das abas = Main · Traits · Powers · Combat & Items · Background · Notes · Credits. Powers entra logo após Traits ∴ ⊥ desloca as demais (decisão 2026-08-17). SUPERSEDED ↓ (2ª rodada 2026-08-17)
- ordem das abas ATUAL = Main · Traits · Powers · Combat · Inventory · Background · Notes · Settings (8). `Credits`→`Settings` & `Combat & Items`→`Combat` (o item saiu p/ Inventory ∴ título velho mentiria — JULGAMENTO meu). Pedido user 2026-08-17
- aba `Settings` = ex-Credits: caixa de créditos FICA, `<image>` `RPGmeister.jpg` SAI (arquivo apagado) & coluna vaga é reocupada. Pedido user 2026-08-17
- combo `Game` (`Vampire: The Masquerade` · `Vampire: Dark Ages` · `Werewolf: The Apocalypse` · `Mage: The Ascension` · `Hunters Hunted` — 5º add 2026-08-17, [pt] `Caçadores Caçados`) grava `game` & ⊥ dispara lógica nenhuma — só estado. ? filtrar conteúdo por jogo depois = escopo NOVO, ⊥ este
- aba Inventory = as 6 caixas ⊥-combate que moram em `HH.3` (ITEMS · ARMOR · GEAR (CARRIED) · EQUIPMENT (OWNED) · TRANSPORTATION · OTHER), MESMOS campos, grade 3×2. `HH.3` fica só com COMBAT. SUPERSEDED ↓ (3ª rodada 2026-08-17)
- Main: caixa VIRTUES parte em 2 — `VIRTUES` (conscience · selfControl · courage) em cima, caixa NOVA abaixo c/ `HUMANITY` + `WILLPOWER`. Linha `Faith` SAI da Main
- `faith_1`…`_5` MIGRAM p/ a linha `TRUE FAITH` da aba Powers ∴ remoção da Main ≠ perda de dado (§V35). ⊥ é rename (§V2 intacto), ⊥ é campo novo
- BACKGROUNDS 5→6 linhas (pedido user: "pra ver como fica o layout") ∴ caixa cresce, pitch de 45 mantido
- `TRUE FAITH` = Path ÚNICO no livro ("Unlike the other Numina Paths, True Faith only has a single Path") ∴ lista PRÓPRIA `{'', 'True Faith'}`, FORA dos 43 itens das 2 tabelas — JULGAMENTO meu; alternativa (entrar na lista única) ⊥ escolhida p/ ⊥ oferecer True Faith em linha de númina. REVOGA "1 lista ÚNICA" só p/ esta 3ª tabela
- PT de perícia: `Melee` = `Armas Brancas` (⊥ hífen) · `Firearms` = `Armas de Fogo` (⊥ `Arm. Fogo`, abreviação herdada do Mage). Pedido user 2026-08-17
- rótulo ≠ nome de campo: `retainers` renderiza `GUIDES`, `type_N` renderiza `Page`. Campo preservado (§V2), só o rótulo muda ∴ ficha salva ⊥ perde dado
- user escreveu "Base of Operation" (caixa @ Traits) & "Base of Operations" (item do picker) → unifico em `Base of Operations` ∴ 1 chave `.lang` serve os 2. JULGAMENTO meu, ⊥ pedido
- aba Powers = só Numina. "& OTHER TRAITS" sai do título (pedido 4)
- aba Powers = 2 tabelas: `NUMINA: HEDGE MAGIC PATHS` (era `NUMINA`) + `NUMINA: PSYCHIC PHENOMENA` logo abaixo, mesma forma; bloco `DESCRIPTION` à direita das 2 (pedido user 2026-08-17)
- 1 lista de picker ÚNICA serve as 2 tabelas (21 Paths + 22 Phenomena juntos) ∴ tabela ⊥ restringe o que a linha aceita. Decisão user 2026-08-17
- radio antes de cada linha, 1 grupo p/ as 2 tabelas ∴ ≤1 númina selecionada na aba inteira (§V.30)
- bloco reativo (radio → texto) ! Lua nova: `dataLink onChange` + tabela `DESC`. REVOGA "⊥ lógica nova" p/ este caso ∴ risco de falha calada = §B.6, coberto por §V.33
- descrição = prosa introdutória + bloco `System` INTEIRO (Modifiers · Aspects/níveis de ponto · Price of Failure), VERBATIM. ⊥ `Sample Rituals` / `Sample Recipes` / `Sample Creations` — conteúdo por-ritual, ⊥ descrição da númina (JULGAMENTO meu 2026-08-17, volume ×3). User 2026-08-17: "o livro tem toda a descrição inclusive como elas funcionam mecanicamente" ∴ mecânica ENTRA, escopo anterior (só prosa) revogado
- fonte da descrição = `C:\Users\awlol\Downloads\M20 Sorcerer.pdf` em disco. cap.1 = pág. PDF 19-52, cap.2 = 55-78 (pág. PDF = pág. impressa +1) ∴ T62 ⊥ mais bloqueado, ⊥ `?`
- `.rpk` distribuído carrega ~43 trechos verbatim do `M20 Sorcerer` (prosa + mecânica) — redistribuição = escolha declarada do user, ⊥ meu julgamento. Mitigação ? = atribuição na aba Credits
- descrição EN + PT. §V9 §V10 mantidos, ⊥ exceção. Decisão user 2026-08-17
- conteúdo das descrições ⊥ no repo ∴ vem das imagens/PDF do user (≡ §R.8) ∴ ⊥ escrever de memória
- GLOSSÁRIO PT travado (user 2026-08-17): `hedge magic` → `magia estática` · `hedge magician` → `mago estático` · `hedge wizard` → `mago estático` · `sorcerer` → `feiticeiro`. ⊥ `magia menor` | `mago menor` | `bruxo menor` (§V34, §B15). Parentético EN — `magia estática (hedge magic)` — MANTIDO, padrão já usado no arquivo p/ termo de livro
- RPGmeister SAI do plugin INTEIRO, ⊥ só da ficha mortal: `<image>` + `<button>` das 5 fichas base (`M20.6` `M20.7` `V20.7`×2 `W20.6`) + 5 `RPGmeister.jpg` + 2 chaves `wod.RPGmeister` + tag `<contact>` do `module.xml`. Pedido user 2026-08-17 ∴ alarga §G p/ além do HuntersHunted
- 5 fichas base ficam c/ vão de layout em (550,0) & (555,425) — reflow ⊥ pedido, DECIDIDO pelo user ∴ ⊥ bug. As 5 ⊥ têm cobertura de gate (gate só lê `HuntersHunted/`) ∴ edição nelas = às cegas
- `module.xml` version `0.8` → `1.0` (user 2026-08-17). `<contact>` removido ∴ plugin ⊥ declara via de contato
- 3ª rodada 2026-08-17 — caixa `ARMOR` VOLTA de `HH.8` p/ `HH.3` (armadura = combate) ∴ REVOGA "`HH.3` fica só com COMBAT" (§C ↑). Campos `armorClass` `armorRating` `armorPenalty` `armorDescription` migram de volta, ⊥ rename (§V35)
- aba Inventory ATUAL = grade 3×2 na ordem: `GEAR (CARRIED)` · `EQUIPMENT (OWNED)` · `TRANSPORTATION` em cima; `BASE OF OPERATIONS (DEFENSES)` · `(ARMAMENTS)` · `(OTHER)` embaixo (3 caixas NOVAS, forma ≡ as de cima). Pedido user 2026-08-17
- a caixa `TRANSPORTATION` de cima é o campo `items` c/ RÓTULO novo — user pediu "renomeie Itens p/ Transporte" & escolheu manter o campo `items` (2026-08-17) ∴ ≡ precedente `retainers`→`GUIDES` (§C ↑), §V2 intacto
- caixas `TRANSPORTATION` (campo `transportation`) & `OTHER` (campo `other`) SAEM da aba a pedido do user 2026-08-17 ∴ os 2 campos ficam ÓRFÃOS no NDB (∃ dado, ⊥ widget). Remoção PEDIDA ≠ rename acidental ∴ §V2 ⊥ se aplica (≡ precedente `numina_11`). User confirmou ⊥ ∃ ficha salva que importe
- COLISÃO de rótulo: `items`→`TRANSPORTATION` bateria c/ a caixa `TRANSPORTATION` já ∃ ∴ resolvida removendo a segunda (↑). §V novo "⊥ 2 títulos por aba" ⊥ criado — `HH.5` tem 3 caixas `Notes` desde a base Mage ∴ invariante nasceria vermelho. JULGAMENTO meu 2026-08-17
- user escreveu "Base de Operação"×2 & "Base de Operações"×1 → unifico em `BASE OF OPERATIONS (...)`, plural, UPPERCASE ≡ demais títulos de caixa. JULGAMENTO meu, ≡ precedente `Base of Operations` (§C ↑)
- 3 caixas Base of Operations da aba Inventory ≠ caixa `BASE OF OPERATIONS` da aba Traits (campo `baseOfOperation`, antecedente c/ descrição) ∴ 4 caixas de nome parecido em 2 abas, INTENCIONAL
- 4ª rodada 2026-08-17 ↓
- HEALTH ganha `comboBox` CURTO ao lado do título: `healthLevels`, `items`=`values`=`1`…`10`, default `7`. Muda a TABELA de rótulos, ⊥ o dado marcado
- tabela de níveis = LITERAL do user, ⊥ regra derivável: 6 = 7 menos `Bruised`; 5 = menos `Hurt` tb; mas 4 = `Injured`·`Wounded`·`Mauled`·`Incapacitated` ∴ PULA `Crippled` ∴ ⊥ é "corta de cima". Encodar as 10 listas verbatim (§V39)
- vitalidade vira POSICIONAL: `health_1`…`health_10`, linha N = N-ésima caixa de dano, rótulo vem do Lua. Os 7 nomes semânticos (`bruised` `hurt` `injured` `wounded` `mauled` `crippled` `incapacitated`) SAEM ∴ órfãos declarados & ficha salva PERDE as marcações de vitalidade — perda ACEITA pelo user 2026-08-17 (alternativas "reusar os 7" & "migrar por Lua" recusadas)
- caixa HEALTH = exceção a §V27: título ⊥ pode ser `left=0 width=<box>` c/ o combo ao lado ∴ título encurta & centraliza no espaço que sobra. Exceção DECLARADA, ⊥ regressão de §B13
- `healthLevels` = combo de VALOR (≡ `language`), ⊥ picker de prosa ∴ nome ⊥ `cbo*` & fica FORA de §V15 (1º item vazio ⊥ faz sentido p/ contagem de níveis) & de §V17 (numeral ⊥ traduz, `wod.1`…`wod.10` = lixo). §V12 SE aplica: item = valor ∴ mudar a lista ! mudar a comparação Lua & o `defaultValue` no mesmo commit
- rótulo de vitalidade ⊥ vem mais do XML — Lua injeta `text` ∴ os 7 rótulos ! ∈ mapa `PT` de `HH.6` p/ traduzir (§V28) & §V38 mede o `checkBox` contra o [pt] mais longo (`Ferido Gravemente (-2)`)
- lógica Lua nova: renderer de rótulo de vitalidade (`dataLink healthLevels` → texto dos 10 `checkBox`). REVOGA "⊥ lógica nova" 2ª vez (1ª = bloco `DESC`, §C ↑) ∴ risco de falha calada coberto por §V39 & §V19
- BACKGROUNDS 7→9 linhas, caixa FICA em 300px & pitch 40→30 (5px de folga). Pedido user 2026-08-17 — 3ª vez que a caixa aperta ∴ 10ª linha ⊥ cabe sem crescer a faixa
- ESPELHO entre abas = 2+ widgets de entrada no MESMO `field`. NDB = fonte única ∴ sincronia é automática, ⊥ pede Lua. REVOGA §V1 p/ espelho DECLARADO (≡ exceção do `radioButton`), coberto por §V36
- aba Combat ganha espelho EDITÁVEL de HEALTH & VIRTUES + espelho SÓ-LEITURA de 7 abilities (`alertness` `athletics` `awareness` `brawl` `firearms` `melee` `stealth`) & 4 attrs (`strength` `dexterity` `stamina` `perception`). Pedido user 2026-08-17
- bolinha SÓ-LEITURA = mecanismo `?`: `imageCheckBox` ⊥ tem `readOnly` documentado (§R.4 lista props de `ComboBox`, ⊥ de `imageCheckBox`) ∴ ! §R antes de implementar. Candidatos: `enabled="false"` | `<image>` pintada por Lua
- caixa externa `MERITS AND FLAWS` REMOVIDA; as 2 tabelas internas (`Merit`/`Flaw`) FICAM & sobem p/ o topo. Cada uma 8→10 linhas (`merit_m9` `_m10` `merit_f9` `_f10` + `type_` `costy_` cada) ∴ caixa interna 240→290 & DERANGEMENTS acompanha
- aba `Progress` NOVA entre Background & Notes → `HH.9.lfm` ∴ 9 abas
- `totalXP` = `spentXP` + `experience`, ⊥ editável. REVOGA "⊥ derivados calculados" SÓ p/ este campo ∴ resto da ficha segue papel (jogador soma)
- `totalXP` ⊥ tem `field` (≡ §V29) ∴ ∉ contrato de dados, ⊥ salvo, sempre recalculado do par. JULGAMENTO meu — evita 3º valor que pode divergir dos 2 que o geram
- `experience` da aba Progress = ESPELHO do da Main (mesmo `field`) ∴ editar num lado muda o outro (§V36)
- aba Progress ganha área de texto livre p/ o jogador descrever onde gastou XP → campo `xpLog`
- `appearance` = ÚNICA exceção ao "dot1 fixo" dos attrs: dot1 vira `imageCheckBox` `appearance_1` ∴ desligável como as outras 4. Pedido user 2026-08-17. Demais 8 attrs seguem c/ `<image>` fixa
- aba História, renomes de RÓTULO (campo preservado, §V2 intacto, ≡ precedente `retainers`→`GUIDES`): `aparencia` renderiza `Languages` (era `Appearance`) · `idiomas` renderiza `Goals` (era `Languages`). User escolheu manter os campos ∴ 2 nomes passam a MENTIR sobre o conteúdo — custo aceito 2026-08-17
- `Moral Flaws` (`moralFlaws`) & `Fears` (`fears`) = caixas NOVAS, ⊥ renome. "o que hoje é goals" ⊥ existia — a aba ⊥ tem caixa Goals (só `Appearance` `Concept` `Nature` `Languages` `Prelude`). Confirmado c/ user 2026-08-17
- aba História, campo novo `Nationality` (`desc_nacionalidade`) abaixo de Weight
- aba História, grid de descritores: colunas em `left=5`\|`320`\|`585` mas template `Descricao` = 310 largo ∴ 320+310=630 > 585, a 3ª coluna entra 45px dentro do `edit` da 2ª. Atinge 2 linhas (Height×Eyes & Weight×Hair), ⊥ só a de Eyes que o user viu. Fix = 3ª coluna → `635` (5\|320\|635 fecha em 945 < 960). §B16, coberto por §V37
- 5ª rodada 2026-08-17 ↓
- aba Combat, troca de posição: `COMBAT TRAITS` ↔ `HEALTH` na coluna direita (traços sobem p/ o topo, vitalidade desce). `VIRTUES` SAI da coluna direita → à DIREITA de `ARMOR` & à ESQUERDA de `HEALTH` novo. Pedido user 2026-08-17
- 5ª rodada = geometria PURA: ⊥ campo novo, ⊥ rename, ⊥ Lua. `renderHealthTrack(self,'dynHealth3_')` & `renderCombatTraits` acham widget por NOME (`dynHealth3_N`, `ro_<field>_N`), ⊥ por posição ∴ mover caixa ⊥ toca script & espelhos de §I3 seguem iguais (§V36)
- coluna direita FECHA o vão que `VIRTUES` deixou: `COMBAT TRAITS` @ top 0 & `HEALTH` @ top 330 (gap 10 ≡ resto do arquivo) ∴ ⊥ buraco de 110px no meio. JULGAMENTO meu — user pediu troca, ⊥ pediu vão
- `VIRTUES` ! caber entre borda de `ARMOR` (x=380) & coluna direita (x=670) ∴ caixa 280→270 larga @ left 390 (gap 10 dos 2 lados) & layouts internos left 15→10. Conteúdo = label 125 + 5 dots = 250 ∴ cabe c/ folga; título acompanha `width` da caixa (§V27)
- 6ª rodada 2026-08-17 ↓
- marca de vitalidade deixa de ser bool: 4 ESTADOS `" "` `"/"` `"X"` `"*"` (1º = espaço), clique avança 1, depois do 4º volta ao 1º, botão DIREITO volta ao 1º de qualquer estado. Símbolos LITERAIS do user
- caixa da marca vai p/ a DIREITA do texto do nível & encostada na borda direita da caixa HEALTH (era `checkBox` = box à esquerda + texto embutido) ∴ o nome do nível vira `label` próprio & o Lua passa a pintar esse label, ⊥ mais o `text` do `checkBox`
- forma = `rectangle` `hitTest="true"` (a moldura da caixinha) + `label field="health_N"` dentro ∴ o valor GRAVADO é o próprio símbolo & aparece sem render de Lua; clique = `onClick`, botão direito = `onMenu` (§R17 §R18 §R19). JULGAMENTO meu: user chamou de "caixa de marcação" ∴ mantém box visível, ⊥ `button` do precedente
- `health_1`…`_10` mudam de DOMÍNIO (bool → 1 dos 4 símbolos), ⊥ de nome ∴ §V2 intacto. Ficha salva c/ `true` normaliza p/ `" "` no 1º render (1 linha em `renderHealthTrack`, ⊥ migração) ∴ marcas velhas caem — ≡ perda já aceita na 4ª rodada, ⊥ pedida de novo ?
- símbolos ⊥ traduzem (`/` `X` `*` = grafia, ⊥ idioma) ∴ FORA de §V9 §V10 §V17 ≡ exceção já aberta p/ o combo `healthLevels`
- lista dos 4 símbolos + funções de ciclo/reset declaradas 1× no form RAIZ (≡ `HEALTH_LEVELS`) & as 2 abas chamam a mesma ∴ ⊥ drift Main × Combat (§V41)
- espelho Main↔Combat segue de graça: a marca mora num `label field="health_N"` ∴ NDB sincroniza as 2 abas sem Lua (§V36). `dataLink` p/ `health_*` ⊥ criado — observador sem efeito. CORREÇÃO 2026-08-17 do §C que pedia o contrário (contradizia §V36), achada @ build

## §I INTERFACES

- I1 dataType: `Ambesek.HuntersHunted.20th`, `formType="sheetTemplate"`, title `Hunters Hunted - Mortal`, `theme="dark"`
- I2 arquivos: `Plugins/Sheets/World of Darkness 20th/HuntersHunted/` → `HuntersHunted.lfm` (raiz) + `HH.1.lfm`…`HH.9.lfm` (`HH.8` = aba Inventory, `HH.9` = aba Progress) + `images/`
- I1b ordem das abas (9): Main · Traits · Powers · Combat · Inventory · Background · Progress · Notes · Settings
- I3 campos NDB (contrato de dados — ⊥ renomear pós-release):
  - header: `name` `player` `chronicle` `nature` `demeanor` `concept` `motivation` `occupation` `residence`
  - attrs (dot1 fixo, campos `_2`…`_5`): `strength` `dexterity` `stamina` `charisma` `manipulation` `perception` `inteligence` `wits`
  - attr EXCEÇÃO: `appearance` = `appearance_1`…`_5`, dot1 é `imageCheckBox` (⊥ `<image>` fixa) ∴ desligável. `appearance_1` = campo NOVO 2026-08-17 (§C)
  - abilities (`_1`…`_5`) talents: `alertness` `athletics` `awareness` `brawl` `empathy` `expression` `intimidation` `leadership` `streetwise` `subterfuge`
  - skills: `animalKen` `crafts` `etiquette` `firearms` `larceny` `melee` `performance` `ride` `stealth` `survival`
  - knowledges: `academics` `enigmas` `finance` `investigation` `law` `medicine` `occult` `politics` `science` `technology`
  - abilities custom (`_1`…`_5` cada): `customTalent_1` `_2` · `customSkill_1` `_2` · `customKnowledge_1` `_2`
  - virtues (dot1 fixo, `_2`…`_5`): `conscience` `selfControl` `courage`
  - `humanity_1`…`_10` · `willpower_1`…`_10` + `willpower_c1`…`_c10` (aba Main, caixa nova HUMANITY & WILLPOWER) · `faith_1`…`_5` (MIGROU p/ aba Powers, dots da linha `TRUE FAITH` — §V35)
  - health POSICIONAL (aba Main, `HH.1`): `health_1`…`health_10` + `healthLevels` (combo `1`…`10`, default `7`). Linha N = N-ésima caixa de dano; o RÓTULO vem do Lua conforme `healthLevels` (§V39), ⊥ do nome do campo
  - numina hedge (aba Powers, tabela 1): `numina_1`…`_8` picker + `numina_9` `_10` texto livre (+ `_1`…`_5` cada). `numina_11` & `numinaNotes` ⊥ — removidos 2026-08-17
  - numina psíquica (aba Powers, tabela 2): `psychic_1`…`_8` picker + `psychic_9` `_10` texto livre (+ `_1`…`_5` cada)
  - numina True Faith (aba Powers, tabela 3): `faith` picker (lista própria) + dots `faith_1`…`_5` migrados da Main
  - `numinaSel` = campo do grupo de radio. Valor = nome do campo da linha (`numina_3`, `psychic_1`, …), ⊥ o nome da númina ∴ trocar item da linha ⊥ quebra a seleção
  - bloco `DESCRIPTION` ⊥ tem `field` ∴ ∉ contrato de dados, ⊥ salvo (§V.29)
  - backgrounds: `background_1`…`_9` (+ `_1`…`_5` cada) — `_6` 2026-08-17, `_7`…`_9` 4ª rodada
  - traits (aba Traits): `merit_m1`…`_m10` & `merit_f1`…`_f10` (+ `type_` `costy_` cada; `_m9` `_m10` `_f9` `_f10` novos 4ª rodada) · `derangements` · caixas `allies` `mentor` `contacts` `resources` `fame` `retainers` `status` `influence` `bgOther` + `baseOfOperation` (novo)
  - combat (aba Combat, `HH.3`): `attack_N` `roll_N` `difficulty_N` `damage_N` `range_N` `rate_N` `clip_N` `conceal_N`, N=1…10 (era `attack`\|`damage`\|`difficulty` N=1…4 antes de T30) + `armorClass` `armorRating` `armorPenalty` `armorDescription` (VOLTARAM de `HH.8` na 3ª rodada — §V35)
  - inventory (aba Inventory, `HH.8`): `gear` · `equipment` · `items` (RÓTULO = `TRANSPORTATION`, ⊥ `ITEMS` — §C) · `baseDefenses` `baseArmaments` `baseOther` (novos 2026-08-17)
  - história (aba Background, `HH.4`): `desc_sexo` `desc_altura` `desc_olhos` `desc_idade` `desc_peso` `desc_cabelo` `desc_idadeAparente` `desc_etinicidade` + `desc_nacionalidade` (novo) · `aparencia` (RÓTULO = `Languages`) · `idiomas` (RÓTULO = `Goals`) · `moralFlaws` `fears` (novos) · `personalidade` `natureza` `background`
  - progress (aba Progress, `HH.9`): `spentXP` · `xpLog`. `experience` = ESPELHO do da Main (§V36). `totalXP` ⊥ tem `field` ∴ ∉ contrato, ⊥ salvo (§C, ≡ §V29)
  - ESPELHOS declarados (>1 widget de entrada no MESMO `field`, §V36 — ⊥ é violação de §V1): `health_1`…`_10` & `conscience` `selfControl` `courage` (+`_2`…`_5`) em `HH.1`+`HH.3` · `experience` em `HH.1`+`HH.9`
  - SÓ-LEITURA em `HH.3` (espelho ⊥ editável, ⊥ conta como dono): `alertness` `athletics` `awareness` `brawl` `firearms` `melee` `stealth` (+`_1`…`_5`) · `strength` `dexterity` `stamina` `perception` (+`_2`…`_5`)
  - ÓRFÃOS declarados (∈ NDB de ficha salva, ⊥ widget em nenhum `.lfm`): `transportation` `other` (3ª rodada) · `bruised` `hurt` `injured` `wounded` `mauled` `crippled` `incapacitated` (4ª rodada — vitalidade virou posicional, §C). ⊥ reusar estes nomes p/ campo novo ∴ ficha velha ⊥ ressuscita dado em caixa errada
  - settings (aba Settings, `HH.6`): `language` · `game` (novo 2026-08-17, 5 jogos + vazio)
  - `experience` · `avatar`
- I4 build: `rdk -l` @ raiz do plugin → compile + lint fonte → `output/World of Darkness 20th.rpk`. `rdk -c` = só compile. `rdk p` = PREPARE, ⊥ build.

## §R RESEARCH

id|topic|finding|src
R1|Locale fallback|`Locale.tryLang` → `_system_locale_tryLang`, nativo do host, ⊥ visível no SDK ∴ fallback [pt]↔[en] = `?`. Mitigado por [en] identidade → pergunta vira irrelevante|`sdk/localeCore.dlua:8`
R2|alcance da tradução|rotina do sheet traduz só `findClass("label")` & `radioButton`. `checkBox` `button` `tab.title` `form.title` ⊥ alcançados. Ficha ⊥ tem radioButton|`HuntersHunted/HH.6.lfm`
R3|combo tema|`items` do combo `theme` = valor, ⊥ rótulo — Lua compara `theme == "Claro"` ∴ traduzir item quebra troca de tema|`HuntersHunted/HH.6.lfm`
R4|ComboBox ⊥ editável|`gui.ComboBox.props` = `transparent` `field` `frameRegion` `items` `values` `text` `value` + fonte/estilo. ⊥ `editable`, ⊥ freeText ∴ "digitar por cima" ! `edit` (dono do field) + `comboBox` picker sem field|`sdk/rrpgGUI.lua:952-958`
R5|items i18n|`ComboBox:getItems` → prop nativa `ItemsI18N` ∴ items `?` já passam pelo locale — ⊥ confirmado, ! testar|`sdk/rrpgGUI.lua:944`
R6|VTM combate+inventário|`V20.3.lfm`: COMBAT = 8 col (`attack` `roll` `difficulty` `damage` `range` `rate` `clip` `conceal`) × 10 linhas; inventário = ARMOR (`armorClass` `armorRating` `armorPenalty` + desc) + GEAR + EQUIPMENT + TRANSPORTATION + HAVEN + FEEDING GROUNDS|`VampireMasquerade20th/V20.3.lfm`
R7|VTM traits|`V20.4.lfm`: template `Merit` (`merit_N`\|`type_N`\|`costy_N`) × 8 merits + 8 flaws; DERANGEMENTS = 1 textEditor; XP (`totalXP` `spentXP` `xpList`); 10 caixas de antecedente c/ descrição (ALLIES MENTOR CONTACTS RESOURCES FAME RETAINERS HERD STATUS INFLUENCE OTHER)|`VampireMasquerade20th/V20.4.lfm`
R8|listas de conteúdo|arquétipos, antecedentes & núminas ⊥ existem em nenhum plugin do repo (grep 0 hits) ∴ ! vir de fora, `?` até user validar|grep `Plugins/Sheets`
R9|escopo de getChildren|`objs.HierarchyObject.getChildren` = `instance._children` ∴ só filhos declarados no form. `recursiveFindControls(self)` @ form de aba ⊥ alcança abas irmãs|`sdk/rrpgObjs.lua:577`
R10|escopo de findControlByName|sobe via `getParent()` até parentmost, depois busca recursiva ∴ alcança ficha inteira. Contraste c/ §R.9 — este é o padrão certo p/ travessia global|`sdk/rrpgGUI.lua:1697-1737`
R11|`radioButton` existe|props `checked` `field` `fieldValue` `groupName` + eve `onChange` ∴ grupo = mesmo `field`, opção = `fieldValue`. Precedente de radio em template de ficha (`field="turma_inicial_$(field)"` + `groupName`) já no repo ∴ §R.2 "ficha ⊥ tem radioButton" era sobre as 5 fichas WoD, ⊥ sobre o SDK|`sdk/rrpgGUI.lua:732-754` · `Plugins/Sheets/Arc Metal Zhuls/Ficha Arc Metal Zhuls/FichaAMZ.1.2.lfm:24`
R12|texto ⊥ digitável|`textEditor` recebe `readOnly` via `_addEditablePropsToObject` ∴ `readOnly="true"` + `text=` + SEM `field` = bloco rolável, ⊥ editável, ⊥ salvo. `wordWrap` & `textTrimming` vêm de TextControl. Precedente real de bloco de texto explicativo|`sdk/rrpgGUI.lua:667-676,988-999,640-663` · `Plugins/Sheets/Fira/fira.lfm:12505`
R13|reatividade sem botão|`dataLink.eves["onChange"] = "field, oldValue, newValue"` & prop `fields` aceita lista ∴ 1 `dataLink` observa `numinaSel` + os 20 campos de linha e re-renderiza. Precedente: `<dataLink field="fof" onChange="self:atualizarInterfaceFriendOrFoe();"/>`|`sdk/rrpgGUI.lua:1152-1178` · `Plugins/Sheets/Ficha The Maze/turnos/AtorCombatTracker.lfm:304`
R14|listas canônicas de númina|cap.1 Hedge Magic Paths (21): Alchemy · Conjuration · Conveyance · Divination · Ephemera · Enchantment · Fascination · Fortune · Healing · Hellfire · Illusion · Maelstroms · Necromancy · Necronics · Oneiromancy · Quintessence Manipulation · Shadows · Shapeshifting · Starlight · Summoning, Binding, and Warding · Weather Control. cap.2 Psychic Phenomena (22): Animal Psychics · Anti-Psychic · Astral Projection · Biocontrol · Channeling · Clairvoyance · Cyberkinesis · Cyberpathy · Ectoplasmic Generation · Mind Shields · Precognition · Psychic Healing · Psychic Hypnosis · Psychic Invisibility · Psychic Vampirism · Psychokinesis · Psychometry · Psychoportation · Pyrokinesis · Shadow · Synergy · Telepathy. Total 43 ∴ §R.8 resolvido p/ núminas (arquétipos & antecedentes seguem `?`)|`M20 Sorcerer` TOC p.4 · cap.1 p.18-51 · cap.2 p.54-77 (PDF anexado pelo user 2026-08-17)
R15|canvas da aba|fichas HH usam até x≈1210 (`HH.1`: layout `left=890 width=320`) ∴ 2 tabelas ~350 à esquerda + bloco de descrição ~800 à direita cabem sem estourar|`HuntersHunted/HH.1.lfm`
R16|conteúdo True Faith|3 seções nos 2 prints do user: `Systems for True Faith` (Path ÚNICO ≠ demais Numina · cada nível = +1 Willpower · cada ponto = dado de proteção divina vs Numina & Disciplinas, dif. 7, subtrai sucessos da ativação, só poder que afeta direto & exige rolagem, ⊥ vs Aura Perception/Fortitude · rating 1-5) · `True Faith Levels` (• repelir criatura c/ símbolo/oração: gasta Willpower & rola Faith vs Willpower permanente, sucessos = turnos de fuga, botch = avança livre, símbolo no corpo = 1 agravado por sucesso · •• sentir presença de vampiro em ambiente calmo · ••• imune a Chimerstry/Dementation/Dominate/Obfuscate · •••• ⊥ pode virar ghoul, imune a Presence · ••••• presença causa auto-ódio/nojo/terror/dor, Rötschreck dif. 9) · `Miracles of True Faith` (≤1 por história, sempre dramático, ⊥ sistema mecânico, motivação examinada pelo ST) + exemplos. Fim da lista de exemplos ⊥ cabe no print ∴ `?` — sessão de build sem os prints ! pedir reenvio, ⊥ escrever de memória (≡ §R.8)|prints do user 2026-08-17
R17|widget de texto clicável|`gui.Button` & `gui.Label` herdam `gui.TextControl` ∴ os 2 têm `text`; só `Label` tem prop `field` ∴ label ligado a campo renderiza o valor cru sem Lua. `Button` ⊥ tem `field` — precedente grava por Lua (`sheet.<campo> = …`)|`SDK3/API/rrpgGUI.lua:681-712`
R18|botão direito|`gui.Control.eves["onMenu"] = 'x, y, event'` ∴ ∀ controle tem hook de clique-direito, ⊥ só `button`. Precedente real em ficha: `<rectangle hitTest="true" onMenu="self:exibirMenuDoAtor();">` ∴ `rectangle` c/ `hitTest` recebe evento de mouse|`SDK3/API/rrpgGUI.lua:280` · `Plugins/Core/rrpginlua/turnos/AtorCombatTracker.lfm:237` · `Plugins/Sheets/Ficha 4D&T/Ficha4D&T/Examples.lfm:16`
R19|ciclo por clique|precedente de N estados em ficha: `<button onClick>` faz `sheet.imageCounter = (sheet.imageCounter + 1) % #pics` & escreve o valor no campo ∴ ciclo = contador + módulo, estado mora no NDB, ⊥ em variável de form|`Plugins/Sheets/Ficha Exalted 3rd/Ficha Exalted 3rd/MultImageCheckbox.lfm:27-36`

## §V INVARIANTS

V1: ∀ `field=` de widget de entrada único na árvore do sheetTemplate ∴ ⊥ 2 inputs no mesmo dado. `<dataLink>` ∉ contagem — observa, ⊥ possui (§B.3). `radioButton` do MESMO grupo compartilha `field` POR DESIGN (exclusão mútua) ∴ exceção declarada, ⊥ conta como 2 donos — distinção fica em `fieldValue` (§V.30)
V2: nome de campo ∈ §I.3 ⊥ renomeado após release ∴ ficha salva perde dado
V3: ∀ png em `src=` `checkedImage=` `uncheckedImage=` ! ∃ em `HuntersHunted/images/` (path relativo à pasta do sheet)
V4: dataType `Ambesek.HuntersHunted.20th` ∉ demais plugins do repo
V5: qtd de dots ! = PDF — attrs 5, abilities 5, virtues 5, numina 5 (20 linhas: 10 hedge + 10 psíquicas), backgrounds 5, humanity 10, willpower 10 dots + 10 box, faith 5, health 7 níveis
V6: build = `rdk -l` @ raiz do plugin, exit 0 antes de commit. `rdk p` ⊥ build (§B.1)
V7: build ok ! = exit 0 & mtime|size do `.rpk` mudou — exit 0 sozinho ⊥ prova (§B.1)
V8: ∀ `<dataLink field=X>` → ∃ widget de entrada com `field=X` no mesmo sheet ∴ ⊥ link morto
V9: ∀ string visível ! autorada em inglês ∴ tradução one-way EN→[pt] (§B.4)
V10: ∀ string visível ∈ {`label`, `checkBox`, `button`} → ∃ `wod.<txt>` em [pt] & [en]
V11: ⊥ label com padding p/ alinhar coluna — 1 label por coluna ∴ cada um traduzível (§B.5)
V12: `items` de combo = valor ⊥ rótulo ∴ mudar item ! mudar comparação Lua & `defaultValue` no mesmo commit (§R.3)
V13: campo c/ picker = `comboBox` dono do `field`, ⊥ `edit` ao lado ∴ só escolha da lista. Combo sem `field` renderiza mas ⊥ salva (decisão user 2026-08-17)
V14: ∀ lista de picker ⊥ item duplicado
V15: 1º item de ∀ picker = vazio
V16: ∀ `label` & `edit` & picker: `width` ! ≥ largura do texto mais longo entre [en] & [pt] ∴ ⊥ corta em nenhum idioma
V17: ∀ item de picker → ∃ chave `wod.<item>` em [pt] & [en] (§V.10 estendido a `items`)
V18: `items` de picker ! declarado inline no XML do template (padrão `colorSelection`) ⊥ populado por Lua @ runtime (§B.6)
V19: ⊥ `if x ~= nil then <efeito> end` como único caminho de inicialização — falha silenciosa. Precedente ⊥ vale sem ∃ o alvo (§B.6)
V20: check do gate ! ler do artefato real (XML `items=`), ⊥ de forma intermediária ∴ refactor ⊥ transforma check em no-op (§B.7)
V21: travessia p/ aplicar tradução ! partir da RAIZ (subir `getParent()` até topo), ⊥ de `self` ∴ alcança 6 abas (§B.9 §R.9 §R.10)
V22: tradução ⊥ destrutiva — texto EN original ! guardado @ load; troca = original | `tryTranslate(original)` ∴ reversível & idempotente (§B.8)
V23: idioma = `comboBox` `language`, `values` = `en`|`pt`, ⊥ bool ∴ ⊥ estado "meio traduzido"
V24: picker: `values` ! canônico EN (dado salvo), `items` = display no idioma corrente ∴ trocar idioma ⊥ altera dado salvo
V25: §V16 estendido — label c/ `text="$(nome)"` ! medido com o valor de `nome=` da CHAMADA contra a `width` do label no template ∴ label de template ⊥ escapa da checagem de largura (§B.11)
V26: chamadas de template irmãs c/ mesmo `left` ! usam templates c/ mesmo x do 1º widget de entrada ∴ coluna de entrada/bolinha alinhada (§B.12)
V27: label de título de seção: `left`=0 & `width` = `width` do `<layout>` pai ∴ `horzTextAlign="center"` centraliza de fato (§B.13)
V28: ∀ string visível ∈ mapa `PT` de `HH.6.lfm`. §V22 checa mapa ⊆ `.lang`; isto checa visível ⊆ mapa ∴ ⊥ string c/ chave [pt] que nunca traduz (§B.14). Texto de descrição ∉ este check — vive em `DESC`, ⊥ em `PT` (§V.31)
V29: bloco `DESCRIPTION` = `textEditor` `readOnly="true"` SEM `field` ∴ ⊥ digitável & ⊥ grava no NDB (§R.12)
V30: ∀ radio de númina: `field="numinaSel"` & mesmo `groupName` & `fieldValue` = nome do campo da linha, único nas 2 tabelas ∴ ≤1 selecionado na aba (§R.11)
V31: texto do bloco = `DESC[<valor da linha selecionada>][lang]` renderizado por Lua ∴ ⊥ traduzido in-place pela travessia (§V22 ⊥ toca `textEditor`); troca de idioma → re-render, ⊥ perda do EN
V32: ∀ item de picker de númina → ∃ `DESC[item].en` & `DESC[item].pt`, ⊥ vazio ∴ ⊥ radio que abre bloco em branco
V33: caminho ⊥ resolvido (linha vazia | linha de texto livre | `DESC[v]` = nil) → bloco mostra texto de estado EXPLÍCITO ∴ falha visível, ⊥ silêncio (§B.6, §V19)
V34: ∀ texto [pt] do sheet (`DESC` de `HH.7` · `.lang` · mapa `PT` de `HH.6`) segue o glossário de §C: `hedge magic`=`magia estática`, `hedge magician`=`hedge wizard`=`mago estático`, `sorcerer`=`feiticeiro` ∴ ⊥ `mag(o|a|os|as|ia|ias) menor(es)` & ⊥ `brux(o|a|os|as) menor(es)` em NENHUM `.lfm` nem no `.lang`. 1 termo EN → 1 termo PT (§B15)
V35: campo que MUDA de aba ! segue existindo exatamente 1× & no arquivo novo — `faith_1`…`_5` ∈ `HH.7` (linha `TRUE FAITH`) & ∉ `HH.1`; `items` `armorClass` `armorRating` `armorPenalty` `armorDescription` `gear` `equipment` `transportation` `other` ∈ `HH.8` & ∉ `HH.3` ∴ mover ⊥ duplica (§V1) & ⊥ some calado (§V2). Remover + adicionar = 1 commit
V36: ∀ `field` c/ >1 widget de entrada ! listado em ESPELHOS de §I.3 ∴ espelho = intenção declarada, duplicata acidental segue caindo em §V1. NDB = fonte única, sincronia ⊥ pede Lua
V37: ∀ `<layout>` irmãos na MESMA caixa & mesmo `top` ! ⊥ sobrepõem em x — `left`+largura-do-template ≤ `left` do próximo ∴ campo ⊥ desenha por cima do vizinho (§B16)
V38: §V16 estendido a `checkBox` c/ `text=` — `width` ! ≥ largura do texto mais longo entre [en] & [pt]. §V16 media só `//label` ∴ família inteira escapava (§B17)
V39: tabela de vitalidade: ∀ n ∈ 1…10 → ∃ lista `LEVELS[n]`, `#LEVELS[n]` = n, último item = `Incapacitated`, ∀ item ∈ os 7 rótulos canônicos ∴ combo ⊥ abre linha sem rótulo (§V33, §V19)
V40: caixas irmãs (`<layout>` c/ `left top width height` filhas do mesmo `scrollBox`) ! retângulos DISJUNTOS ∴ caixa ⊥ desenha por cima de caixa. §V37 mede linha vs linha DENTRO da caixa; isto mede CAIXA vs caixa — ponto cego aberto desde que ∃ coluna lado a lado (`COMBAT` 0..650 vs coluna 670). JULGAMENTO meu, ⊥ pedido: 5ª rodada aperta `VIRTUES` num vão de 280px ∴ erro de 10px passaria verde
V41: lista de marcas = `{" ", "/", "X", "*"}` NESSA ordem, 1º = `" "`, declarada 1× no form raiz (`HuntersHunted.lfm`) ∴ Main & Combat ciclam igual & ⊥ 2ª lista p/ divergir
V42: ∀ valor gravado em `health_1`…`_10` ∈ os 4 símbolos. Valor ∉ lista (bool de ficha velha, nil, lixo) → render normaliza p/ `" "` & clique recomeça do 1º ∴ ciclo ⊥ trava (§V19, §V33)
V43: ∀ caixa de marca de vitalidade declara `onClick` (avança 1) & `onMenu` (volta ao 1º) ∴ ⊥ caixa que só avança & ⊥ estado alcançável só dando 3 voltas

## §T TASKS

id|status|task|cites
T1|x|criar `HuntersHunted/` + copiar `prime_on.png` `prime_off.png` `RPGmeister.jpg` ← `Mage20th/images/`|V3
T2|x|`HuntersHunted.lfm` — raiz sheetTemplate + tabControl 6 abas + evento autoupdater ← `Mage20th.lfm`|I1,V4
T3|x|`HH.1.lfm` Main — templates Header/Attribute/Ability/OpenAbility/Dots10/Willpower; header 9, ATTRIBUTES 9, ABILITIES 30, VIRTUES 3, HUMANITY, WILLPOWER, FAITH, HEALTH, BACKGROUNDS 5, EXPERIENCE, avatar|V1,V2,V5
T4|x|`HH.2.lfm` Traits — NUMINA & OTHER TRAITS 11 linhas abertas 5 dots + textEditor livre|V1,V5
T5|x|`HH.3.lfm` Combat & Items — COMBAT 4 linhas (weapon\|damage\|diff) + ITEMS/GEAR/EQUIPMENT/OTHER ← `M20.3.lfm`|V1
T6|x|`HH.4.lfm` Background — desc fields + Appearance/Concept/Nature/Languages/Prelude ← `M20.4.lfm`|V1
T7|x|`HH.5.lfm` Notes — 3 textEditors ← `M20.5.lfm`|V1
T8|x|`HH.6.lfm` Credits — ← `M20.6.lfm`, trocar textos p/ Hunters Hunted|-
T9|x|`module.xml` version `0.6` → `0.7`|-
T10|x|`localization.lang` — chaves pt/en faltantes: Awareness, Animal Ken, Ride, Performance, Larceny, Finance, Motivation, Occupation, Residence, Demeanor, Conscience, Self-Control, Courage, Humanity, Faith, Virtues, Numina, Difficulty|-
T11|x|`rdk -l` → compile + lint → regerar `output/World of Darkness 20th.rpk`|V6,V7
T12|x|`verify-hunters-hunted.ps1` @ raiz do repo — gate runnable p/ invariantes ⊥ checáveis a olho|V1,V3,V4,V5,V7,V8
T13|x|`module.xml` `<description>` lista 5 fichas, agora ! 6 — citar Hunters Hunted|-
T14|x|`HH.6.lfm` rotina de tradução — cobrir `checkBox` & `button` além de `label` ∴ 7 níveis Health passam a traduzir|V10,R2
T15|x|`HH.3.lfm` header COMBAT — 1 label c/ padding → 3 labels (`Weapon/Attack`, `Damage`, `Diff.`)|V11
T16|x|`HH.6.lfm` strings PT→EN: `Tema:`→`Theme:`, `Versão Atual:`→`Current Version:`, `Sua Versão:`→`Available Version:`, `Não pedir para atualizar.`→`Don't ask to update.`, `Conheça a Mesa:`→`Visit the Table:`, `Atualizar`→`Update`. Créditos do Mage mantidos, só traduzidos|V9
T17|x|`HH.6.lfm` combo tema — `items` `{'Escuro','Claro'}`→`{'Dark','Light'}` + `defaultValue="Dark"` + comparação Lua `== "Light"`, tudo no mesmo commit|V12,R3
T18|x|`localization.lang` — [pt] p/ ∀ string visível nova; [en] identidade p/ ∀ string que a ficha renderiza ∴ §R.1 vira irrelevante|V10,R1
T19|x|`verify-hunters-hunted.ps1` — check §V.10 (chave [pt] & [en] p/ todo label/checkBox/button) & §V.11 (⊥ padding em label)|V10,V11
T20|x|`?` testar em Firecast: `findClass("tab")` alcança & `tab.title` gravável → sim: traduzir 6 abas; ⊥: registrar limite em §C|R2
T21|x|`HH.2.lfm` MERITS AND FLAWS — template `Merit` (nome\|tipo\|custo) × 8 merits + 8 flaws ← `V20.4.lfm`|R7,V1
T22|x|`HH.2.lfm` DERANGEMENTS — 1 textEditor ← `V20.4.lfm`|R7
T23|x|`HH.2.lfm` (Traits) 9 caixas de descrição nome-fixo ← `V20.4.lfm`: ALLIES MENTOR CONTACTS RESOURCES FAME RETAINERS STATUS INFLUENCE OTHER. HERD ⊥ (vampiro-only). ≠ T28 — aquilo é picker na aba Main|R7
T24|x|`?` LISTA arquétipos Nature/Demeanor — M20 primeiro, depois VTM, depois resto, ⊥ duplicata. ! user validar antes de T27|V14,R8
T25|x|`?` LISTA antecedentes — VTM + M20 + W20, ⊥ duplicata. ! user validar antes de T28|V14,R8
T26|~|SUPERSEDED por T49 — "⊥ inventar" virou "rascunhar & mostrar p/ validação", que ⊥ afirma nada como fato|V14,R8
T27|x|`HH.1.lfm` (Main) Nature & Demeanor → `edit` + picker, mesma lista, valores independentes, 1ª opção vazia|V13,V15,T24
T28|x|`HH.1.lfm` (Main) BACKGROUNDS 5 linhas → `edit` + picker por linha, mesma lista, valores independentes. ≠ T23|V13,V15,T25
T29|~|SUPERSEDED por T50 — o bloco migra p/ `HH.7.lfm` & vira 8 picker + 2 livre, ⊥ 11 linhas|V13,V15,T26
T30|x|`HH.3.lfm` COMBAT → 8 col × 10 linhas ← `V20.3.lfm`|R6,V1
T31|x|`HH.3.lfm` inventário → ARMOR (class\|rating\|penalty\|desc) + GEAR + EQUIPMENT + TRANSPORTATION ← `V20.3.lfm`; HAVEN & FEEDING ⊥|R6,V1
T32|x|`localization.lang` — [pt] & [en] p/ ∀ string & ∀ item de picker novo|V10,V17
T33|x|`verify-hunters-hunted.ps1` — checks §V.13 §V.14 §V.15 §V.16 §V.17|V13,V14,V15,V16,V17
T34|x|`HH.6.lfm` remover botões (Change Log, Update, RPGmeister) + combo tema + pickers de cor + checkBox `noUpdate`. Manter créditos & controle de idioma|-
T35|x|`HH.6.lfm` `localization` checkBox → `comboBox` `language`, items `{English, Português BR}` values `{en, pt}`, default `en`|V23,B10
T36|x|`HH.6.lfm` travessia da RAIZ (subir `getParent()`) + snapshot do texto EN @ load ∴ 6 abas & reversível|V21,V22,R9,R10
T37|x|`HH.6.lfm` troca de idioma reconstrói `items` dos pickers no idioma; `values` EN intactos|V24,V17
T38|x|`verify-hunters-hunted.ps1` — checks §V.21 §V.22 §V.23 §V.24|V21,V22,V23,V24
T39|x|`HuntersHunted.lfm` remover autoupdater: `Internet.download` + `Dialogs.choose` + `isNewVersion` + helper `t()`. Campos `versionInstalled` `versionDownloaded` `noUpdate` saem junto (decisão user 2026-08-17)|V1
T40|x|`HH.1.lfm` template `CustomAbility` (edit + 5 dots, x do 1º dot = 80 ≡ `Ability`) + 2 linhas ao fim de TALENTS & SKILLS & KNOWLEDGES; caixa 300→350 alt, ABILITIES 340→390|V1,V5,V26
T41|x|`HH.1.lfm` realinhar Main — pitch de coluna 290 uniforme no header (era 5\|290\|580) & 1 `width` de label + 1 `left` de entrada por coluna (Concept ≡ Nature/Demeanor); títulos de seção `left=0` & width da caixa; HUMANITY & WILLPOWER viram título acima das bolinhas, dots @80 ≡ Virtues; borda direita & inferior das caixas alinhadas|V16,V25,V26,V27
T42|x|`HH.7.lfm` NOVO — aba Powers, recebe o bloco de núminas + template `Trait` migrado de `HH.2`. Título = `NUMINA`, ⊥ "& OTHER TRAITS"|I2,V9,V27
T43|x|`HuntersHunted.lfm` — `<tab title="Powers">` logo após Traits|I1
T44|x|`HH.2.lfm` — remover bloco NUMINA (11 linhas) + `textEditor` `numinaNotes` + template `Trait`|I3
T45|x|`HH.2.lfm` relayout — MERITS AND FLAWS & DERANGEMENTS sobem p/ o topo (buraco deixado pelas núminas), 10 caixas de antecedente em grade regular|V27
T46|x|`HH.2.lfm` — `RETAINERS` → `GUIDES` (campo `retainers` INTACTO + comentário XML dizendo por quê) & caixa nova `BASE OF OPERATIONS` no slot vazio (750,830), campo `baseOfOperation`|V2,V10,V16,V25
T47|x|`HH.2.lfm` — label `Type` → `Page` ×2 (Merit & Flaw). Campo `type_$(num)` INTACTO|V2,V10
T48|x|`HH.1.lfm` picker de antecedentes += `Armory` `Base of Operations` `Guide`, ordem alfabética, ⊥ duplicata|V14,V15,V17
T49|~|SUPERSEDED por T55 — rascunho de memória substituído por lista SOURCED do `M20 Sorcerer` (§R.14) ∴ `?` cai|V14,R14
T50|~|SUPERSEDED por T56 & T57 — 1 tabela de 10 linhas virou 2 tabelas de 10 c/ radio|V13,V15,V26
T51|x|`localization.lang` — pt+en p/ strings novas: `NUMINA` `Powers` `GUIDES` `BASE OF OPERATIONS` `Page` `Armory` `Base of Operations` `Guide` + ∀ item de númina|V10,V17
T52|x|`HH.6.lfm` regerar `local PT` a partir do `.lang` ∴ aba Powers & rótulos novos traduzem|V22,V28
T53|x|`verify-hunters-hunted.ps1` — §V5 numina 11→10 & + `customTalent`/`customSkill`/`customKnowledge` 5 dots; checks novos §V.25 §V.26 §V.27 §V.28|V5,V25,V26,V27,V28
T54|x|`rdk -l` + instalar; conferir que mtime\|size do `.rpk` mudou|V6,V7
T55|x|LISTA de núminas = §R.14 na ordem do livro (21 Paths + 22 Phenomena = 43 itens), 1 lista ÚNICA p/ os pickers das 2 tabelas, 1º item vazio, ⊥ duplicata|V14,V15,R14
T56|x|`HH.7.lfm` tabela 1 — título `NUMINA` → `NUMINA: HEDGE MAGIC PATHS`; template `NuminaPicker` (radio + `comboBox` + 5 dots) × 8 (`numina_1`…`_8`) + `NuminaFree` (radio + `edit` + 5 dots) × 2 (`numina_9` `_10`)|V13,V15,V26,V30,T55
T57|x|`HH.7.lfm` tabela 2 NOVA `NUMINA: PSYCHIC PHENOMENA` logo abaixo da 1, mesmos templates, campos `psychic_1`…`_10`|I3,V13,V15,V26,V30,T55
T58|x|`HH.7.lfm` bloco `DESCRIPTION` à direita das 2 tabelas — `textEditor readOnly="true"` sem `field`, `wordWrap="true"`, altura ≈ das 2 tabelas somadas|V29,R12,R15
T59|x|`HH.7.lfm` tabela Lua `DESC` = canonEN → `{en=…, pt=…}` + render: lê `numinaSel` → campo da linha → valor → `DESC` → `text` do bloco; sem match → texto de estado explícito|V31,V32,V33,R13
T60|x|`HH.7.lfm` `<dataLink fields="{'numinaSel','numina_1'…'psychic_10'}" onChange="render()"/>` ∴ trocar radio OU trocar item da linha atualiza o bloco|V33,R13
T61|x|`HH.6.lfm` troca de idioma ! chamar o render de T59 (bloco ⊥ passa pela travessia de tradução) ∴ descrição acompanha `en`/`pt`|V21,V22,V31
T62|x|CONTEÚDO — transcrição VERBATIM (prosa + `System`, ⊥ samples) das 43 núminas ← `M20 Sorcerer.pdf` pág. 19-52 & 55-78 + tradução [pt] minha (user autorizou 2026-08-17, ⊥ tenho termo oficial PT) ∴ ⊥ de memória, ! ler do PDF|V32,R8,R14
T68|x|`localization.lang` + `HH.6` mapa `PT` — 43 nomes de númina em [pt] (tradução minha, ! user validar); `values` seguem EN canônico (§V24)|V10,V17,V24
T63|x|`localization.lang` — [pt] & [en] p/ `NUMINA: HEDGE MAGIC PATHS` `NUMINA: PSYCHIC PHENOMENA` `DESCRIPTION` + os 43 itens de picker|V10,V17,V24
T64|x|`HH.6.lfm` regerar `local PT` a partir do `.lang` ∴ títulos novos & 43 itens traduzem; descrições ⊥ entram no mapa|V22,V28,V31
T65|x|`verify-hunters-hunted.ps1` — exceção de `radioButton` no check §V1; checks novos §V.29 §V.30 §V.31 §V.32 §V.33; §V5 numina 10→20 linhas; §V.17 sobre os 43 itens|V1,V5,V17,V29,V30,V31,V32,V33
T66|x|`module.xml` version `0.7` → `0.8`|-
T67|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T69|x|`HH.7.lfm` `DESC` [pt] — 21 trechos: `magos menores`×8 & `mago menor`×9 & `magia menor`×3 & `bruxo menor`×1 → `magos estáticos` \| `mago estático` \| `magia estática`. Colateral (`Milagres menores` `ferimentos menores` `chama menor` `for menor que` `magias comuns`←`regular spells`) ⊥ tocado. EN intacto (§V9)|V34
T70|x|`localization.lang` [pt] & mapa `PT` de `HH.6.lfm` — `NÚMINAS: CAMINHOS DE MAGIA MENOR` → `NÚMINAS: CAMINHOS DE MAGIA ESTÁTICA`. Chave & label EN intactos ∴ `values` canônicos ⊥ mexidos|V10,V24,V34
T71|x|`verify-hunters-hunted.ps1` — check §V34: regex ASCII da renderização PROIBIDA sobre ∀ `.lfm` + `.lang` ∴ recorrência = gate vermelho, ⊥ precisa grafar acento no `.ps1`|V34
T72|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T73|x|`HuntersHunted.lfm` — `<tab title="Credits">`→`Settings`, `<tab title="Combat &amp; Items">`→`Combat`, `<tab title="Inventory">` c/ `<import file="HH.8.lfm"/>` logo após Combat ∴ 8 abas na ordem de §C|I1,I2
T74|x|`HH.6.lfm` — remover `<image src="images/RPGmeister.jpg">` & apagar o arquivo `images/RPGmeister.jpg`; caixas de créditos & settings reflow p/ `left=0` (coluna da imagem vagou)|V3,V27
T75|x|`HH.6.lfm` — combo `Game` logo ABAIXO de `Language` na mesma caixa: `name="cboGame"` `field="game"`, `items`=`values`=`{'', 'Vampire: The Masquerade', 'Vampire: Dark Ages', 'Werewolf: The Apocalypse', 'Mage: The Ascension'}`; caixa cresce p/ 2 linhas|I3,V13,V14,V15,V17,V24
T76|x|`HH.8.lfm` NOVO — aba Inventory: ITEMS · ARMOR (`armorClass`\|`armorRating`\|`armorPenalty`\|`armorDescription`) · GEAR (CARRIED) · EQUIPMENT (OWNED) · TRANSPORTATION · OTHER em grade 3×2, campos IDÊNTICOS aos de `HH.3`|I2,I3,V1,V2,V27,V35
T77|x|`HH.3.lfm` — remover as 6 caixas movidas, sobra só COMBAT (8 col × 10 linhas) & largura da aba encolhe. MESMO commit que T76 ∴ ⊥ 2 donos de `items`/`gear`/…|V1,V35,T76
T78|x|`HH.1.lfm` — BACKGROUNDS 5→6 linhas (`background_6` + dots `_1`…`_5`), pitch 45 mantido ∴ caixa cresce & as 3 caixas de baixo terminam na mesma borda inferior|I3,V1,V5,V26,V27
T79|x|`HH.1.lfm` — caixa VIRTUES parte em 2: `VIRTUES` (conscience·selfControl·courage) em cima, caixa NOVA `HUMANITY` + `WILLPOWER` abaixo; linha `Faith` SAI da Main. MESMO commit que T81 ∴ `faith_1`…`_5` ⊥ ficam órfãos|V26,V27,V35,T81
T80|x|`localization.lang` — `wod.Melee` `Armas-Brancas`→`Armas Brancas` & `wod.Firearms` `Arm. Fogo`→`Armas de Fogo` (label do template `Ability` = 125px, dimensionado p/ `Empatia com Animais` ∴ cabe)|V10,V16
T81|x|`HH.7.lfm` — 3ª caixa `TRUE FAITH` abaixo de `NUMINA: PSYCHIC PHENOMENA`: 1 linha `NuminaPicker field="faith"` (radio `numinaSel` fieldValue `faith` + `cboFaith` + 5 dots `faith_1`…`_5`) c/ lista PRÓPRIA `{'', 'True Faith'}` ∴ template ganha `items` por-chamada \| template novo de 1 item; bloco `DESCRIPTION` cresce p/ acompanhar as 3 caixas|I3,V1,V13,V14,V15,V26,V30,V35
T82|x|`HH.7.lfm` — `DESC['True Faith']` = transcrição VERBATIM dos 2 prints (§R.16: Systems · Levels • a ••••• · Miracles) + [pt] minha; `dataLink fields` += `'faith'`. Print ⊥ em mão na sessão de build → PARAR & pedir reenvio|V31,V32,V33,R13,R16
T83|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` regerado — chaves novas: `Settings`=Configurações · `Inventory`=Inventário · `Combat`=Combate · `Game`=Jogo · `TRUE FAITH`=FÉ VERDADEIRA · `True Faith`=Fé Verdadeira · `Vampiro: A Máscara` · `Vampiro: Idade das Trevas` · `Lobisomem: O Apocalipse` · `Mago: A Ascensão`. `Credits` & `Combat & Items` FICAM (outras 5 fichas do plugin usam)|V10,V16,V17,V22,V24,V28
T84|x|`verify-hunters-hunted.ps1` — §V5 background 5→6 linhas & numina 20→21 (+ linha `faith`); check §V35 (dono único & arquivo certo p/ os 14 campos migrados); §V14/§V15/§V17 alcançam `cboGame` & `cboFaith`|V5,V14,V15,V17,V35
T85|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T86|x|RPGmeister fora do plugin INTEIRO — `<image>`+`<button>` das 5 fichas base + 5 `RPGmeister.jpg` + 2 chaves `wod.RPGmeister` + entrada morta do mapa `PT` + tag `<contact>`; `module.xml` `0.8`→`1.0`|V3,V10,V22,V28
T87|x|mover caixa `ARMOR` `HH.8`→`HH.3` (`armorClass`\|`armorRating`\|`armorPenalty`\|`armorDescription` + desc), abaixo de COMBAT. Remover + adicionar = 1 commit (§V35) ∴ ⊥ 2 donos|V1,V2,V16,V27,V35
T88|x|`HH.8.lfm` — caixa do campo `items` passa a renderizar `TRANSPORTATION` (era `ITEMS`); caixas `TRANSPORTATION` (`transportation`) & `OTHER` (`other`) REMOVIDAS a pedido ∴ 2 campos órfãos, ⊥ rename (§V2 intacto)|V2,V10,V16
T89|x|`HH.8.lfm` — 3 caixas NOVAS `BASE OF OPERATIONS (DEFENSES)` `(ARMAMENTS)` `(OTHER)`, campos `baseDefenses` `baseArmaments` `baseOther`, forma ≡ caixas de cima (título + 1 `textEditor`); grade final 3×2 = `gear`\|`equipment`\|`items` em cima, as 3 novas embaixo|I3,V1,V16,V27
T90|x|`HH.6.lfm` — `cboGame` `items` & `values` += `Hunters Hunted` ∴ 5 jogos + vazio. Segue só estado, ⊥ dispara lógica|I3,V13,V14,V15,V17,V24
T91|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — `BASE OF OPERATIONS (DEFENSES\|ARMAMENTS\|OTHER)` + `Hunters Hunted`=`Caçadores Caçados`. `TRANSPORTATION` & `ARMOR` já ∃|V10,V16,V17,V22,V24,V28
T92|x|`verify-hunters-hunted.ps1` — §V35 `$movedTo`: os 4 campos de armor `HH.8`→`HH.3`; assert `cboGame` = 5 itens; §V1 alcança `baseDefenses` `baseArmaments` `baseOther`|V1,V14,V17,V35
T93|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T94|x|`?` §R — como tornar bolinha SÓ-LEITURA: `imageCheckBox` tem `enabled`\|`readOnly`? senão `<image>` pintada por Lua. Ler `sdk/rrpgGUI.lua`. BLOQUEIA T101|R4,R12
T95|x|`HH.1.lfm` — attr `appearance` exceção: dot1 `<image>` → `imageCheckBox field="appearance_1"` @ x=125 ∴ desligável & coluna de dot intacta. Template próprio \| `Attribute` ganha variante|I3,V1,V5,V26
T96|x|`HH.1.lfm` — HEALTH posicional: 7 `checkBox` de nome semântico → 10 `checkBox` `health_1`…`_10`; os 7 nomes velhos SAEM (órfãos §I3). `width` ! caber [pt] mais longo (§V38)|I3,V1,V2,V38
T97|x|`HH.1.lfm` — combo `healthLevels` (`1`…`10`, default `7`) ao lado do título HEALTH; nome ⊥ `cbo*` ∴ combo de VALOR, fora dos checks de picker (§C); título encurta & recentra no espaço restante (exceção §V27 declarada em §C)|I3,V12,V13,V27
T98|x|`HH.1.lfm` — tabela Lua `LEVELS[1..10]` verbatim de §C + `dataLink field="healthLevels"` → escreve `text` dos 10 `checkBox` & esconde as linhas > n; sem match → estado explícito|V19,V33,V39,R13
T99|x|`HH.1.lfm` — BACKGROUNDS 7→9 linhas (`background_7`…`_9` + dots), caixa FICA 300px, pitch 40→30|I3,V1,V5,V26,V27
T100|x|`HH.3.lfm` — espelho EDITÁVEL de HEALTH (`health_1`…`_10`) & VIRTUES (`conscience` `selfControl` `courage`) ∴ 2 donos por field, DECLARADO em §I3|I3,V1,V36
T101|x|`HH.3.lfm` — espelho SÓ-LEITURA de 7 abilities & 4 attrs pelo mecanismo que T94 achar ∴ ⊥ editável & ⊥ 2º dono|I3,V1,V36,T94
T102|x|`HH.2.lfm` — remover caixa externa `MERITS AND FLAWS`; as 2 tabelas sobem p/ topo (`left=0`\|`390`, `top=0`); 8→10 linhas cada (`_m9` `_m10` `_f9` `_f10`); caixa 240→290 & DERANGEMENTS + faixa de antecedentes acompanham|I3,V1,V16,V27
T103|x|`HH.4.lfm` — fix §B16: 3ª coluna do grid `left=585`→`635` ∴ ⊥ sobrepõe o `edit` da 2ª. Corrige as 2 linhas (Height×Eyes & Weight×Hair)|V37
T104|x|`HH.4.lfm` — rótulos: caixa `aparencia` → `Languages`, caixa `idiomas` → `Goals` (campos INTACTOS, §V2) + caixas NOVAS `Moral Flaws` (`moralFlaws`) & `Fears` (`fears`) abaixo|I3,V1,V2,V10,V16,V27
T105|x|`HH.4.lfm` — campo novo `Nationality` (`desc_nacionalidade`) abaixo de Weight, template `Descricao`|I3,V1,V10,V16,V25
T106|x|`HH.9.lfm` NOVO — aba Progress: `Total Experience` (⊥ `field`, = `spentXP`+`experience`, Lua) · `Spent Experience` (`spentXP`) · `Current Experience` (`experience`, ESPELHO da Main) · área livre `xpLog`|I2,I3,V1,V16,V27,V29,V36
T107|x|`HuntersHunted.lfm` — `<tab title="Progress">` c/ `<import file="HH.9.lfm"/>` entre Background & Notes ∴ 9 abas|I1,I1b,I2
T108|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — chaves novas: `Goals` `Moral Flaws` `Fears` `Nationality` `Total Experience` `Spent Experience` `Current Experience` `Progress` + os 7 rótulos de vitalidade que o Lua injeta (`Bruised`…`Incapacitated`, já ∃ mas agora ! ∈ mapa `PT`, §V28). `1`…`10` do combo ⊥ levam chave (combo de valor, §C). `Languages` `Appearance` já ∃|V10,V16,V17,V22,V24,V28
T109|x|`verify-hunters-hunted.ps1` — §V5 background 7→9 & health 7 níveis → 10 posicionais & appearance 4→5 dots; merit 8→10; checks NOVOS §V36 (espelhos ⊆ §I3) §V37 (sobreposição) §V38 (`checkBox` vs [pt]) §V39 (`LEVELS`); órfãos += os 7 nomes de vitalidade|V1,V5,V36,V37,V38,V39
T110|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T111|x|`HH.3.lfm` relayout — `COMBAT TRAITS` (670,430)→(670,0), 280×320; `HEALTH` (670,0)→(670,330), 280×300; `VIRTUES` (670,310,280,110)→(390,350,270,110) c/ layouts internos left 15→10 & título `width` 280→270. Só `left top width`: ⊥ campo, ⊥ nome de widget, ⊥ Lua, ⊥ `.lang`|V27,V36,V37,V40
T112|x|`verify-hunters-hunted.ps1` — check §V40: caixas irmãs do `scrollBox` c/ `left top width height` ⊥ se cruzam ∴ o lado-a-lado novo (`ARMOR`\|`VIRTUES`\|coluna direita) tem gate|V40
T113|x|`rdk -l` @ raiz do plugin → exit 0 & mtime\|size do `.rpk` mudou|V6,V7
T114|.|`?` testar em Firecast: `onMenu` dispara em `rectangle hitTest="true"` dentro da ficha & ⊥ abre menu nativo por cima. ⊥ → cair p/ `button` (§R19) \| `onDblClick` como reset. BLOQUEIA T115|R18,V43
T115|x|`HuntersHunted.lfm` (form raiz) — `HEALTH_MARKS = {" ", "/", "X", "*"}` + `cycleHealthMark(sheet, n)` (avança, volta ao 1º após o 4º) & `resetHealthMark(sheet, n)`; `renderHealthTrack` normaliza valor ∉ lista → `" "`|V41,V42,V19,R19
T116|x|`HH.1.lfm` HEALTH — cada linha vira `label` do nível (esquerda, pintado pelo Lua ≡ hoje) + caixa de marca `rectangle hitTest="true"` c/ `label field="health_N"` dentro, encostada na borda direita da caixa; `onClick`→`cycleHealthMark`, `onMenu`→`resetHealthMark`. `checkBox` `dynHealth1_N` some|V1,V16,V25,V41,V43,T115
T117|x|`HH.3.lfm` — mesma troca no espelho (`dynHealth3_`). Sincronia entre abas = NDB via `label field=` ∴ ⊥ mexe em `dataLink` (§V36). MESMO commit que T116 ∴ ⊥ 2 formas de vitalidade convivendo|V1,V36,V41,V43,T116
T118|x|`verify-hunters-hunted.ps1` — §V5 conta as 10 linhas de vitalidade pela forma nova (⊥ mais `checkBox field="health_N"`); checks NOVOS §V41 (lista 1× no raiz, 4 símbolos, ordem) §V42 (normalização no render) §V43 (`onClick` & `onMenu` em ∀ caixa de marca); §V38 ⊥ mede mais os níveis (viraram `label` ∴ §V16/§V25 assumem)|V5,V16,V38,V41,V42,V43
T119|x|`rdk -l` → exit 0 & `.rpk` mudou; depois `rdk -i` → `.rpk` instalado em `%APPDATA%\Firecast\Plugins\ambesek.wod.20th.rpk` c/ mesmo size (CLAUDE.md)|V6,V7

## §B BUGS

id|date|cause|fix
B1|2026-08-15|`rdk p` = PREPARE ⊥ pack — exit 0 mas `.rpk` ⊥ mudou & `module.xml` reescrito|V6,V7
B2|2026-08-15|§C travou `sdkVersion` que o rdk possui & reescreve (`3.6c`→`3.7b`)|§C
B3|2026-08-15|§V1 contou `<dataLink field>` como dono de campo; base `M20.6.lfm` usa por design|V1,V8
B4|2026-08-16|tradução cobre só `label` ∴ 7 níveis Health (`checkBox`) c/ chave [pt] ⊥ aplicada; Credits autorado em PT ⊥ traduzível p/ EN|V9,V10
B5|2026-08-16|header COMBAT = 1 label c/ padding p/ alinhar colunas ∴ ⊥ utilizável como chave|V11
B6|2026-08-17|picker populado via `<script>` local + `onNodeReady` + `findControlByName`, tudo guardado por `if ~= nil` ∴ dropdown vazio & ⊥ erro. Precedente citado (`M20.2.1.lfm` busca `"rclName"`, real = `"rclWonders"`) = código morto que nunca rodou|V18,V19
B7|2026-08-17|gate lia listas de picker de `local X = {}` no Lua; ao mover p/ `items=` inline os checks §V14/§V15/§V17 passariam sem verificar nada|V20
B8|2026-08-17|tradução muta `label.text` in-place & ⊥ guarda original ∴ ⊥ volta p/ EN, 2ª execução = no-op|V22
B9|2026-08-17|`recursiveFindControls` parte de `self` (form da aba Credits) ⊥ da raiz ∴ só Credits traduz. Vale p/ as 5 fichas base desde 2017; §T.14 ⊥ alcançou os 7 Health de `HH.1`|V21
B10|2026-08-17|`dataLink field="localization" defaultValue="#FFFFFF"` — defaultValue de cor em campo booleano, copiado do `colorFont`|V23
B11|2026-08-17|check §V16 pula `//label[@text]` c/ `$(` ∴ ∀ label de template escapa. `WILLPOWER` `width=60` vs [pt] `FORÇA DE VONTADE` (~104px) nunca flagrado; `Humanity`→`Humanidade` (~65px) idem|V25
B12|2026-08-17|templates irmãos c/ x de entrada divergente na mesma coluna: `Header` edit@90 vs `HeaderPicker` combo@112 (Concept ≠ Nature/Demeanor); `Attribute`/`Ability` dot@80 vs `Advantages`/`Willpower` dot@60 (Humanity/Willpower ≠ Virtues)|V26
B13|2026-08-17|título de seção c/ `left="5"` & `width` = largura da caixa ∴ `horzTextAlign="center"` centraliza 5px à direita. ATTRIBUTES ABILITIES TALENTS SKILLS KNOWLEDGES VIRTUES BACKGROUNDS|V27
B14|2026-08-17|§V22 checa mapa `PT` ⊆ `.lang` mas ⊥ o inverso ∴ string visível nova c/ chave [pt] fora do mapa ⊥ traduz em runtime & gate passa verde|V28
B15|2026-08-17|T62/T68 traduziram `hedge magic`/`magician`/`wizard` ad-hoc por entrada: `magia menor`×3 `mago menor`×9 `magos menores`×8 `bruxo menor`×1 (Enchantment) ∴ 4 renderizações p/ 1 termo & 0 uso do canônico `magia estática`; `.lang` + mapa `PT` levavam `CAMINHOS DE MAGIA MENOR`. Glossário ⊥ existia no spec ∴ nada p/ o gate checar|V34
B16|2026-08-17|`HH.4` grid de descritores: template `Descricao` = 310 largo mas colunas em `left=5`\|`320`\|`585` ∴ 320+310=630 > 585, 3ª coluna desenha 45px DENTRO do `edit` da 2ª. 2 linhas afetadas (Height×Eyes, Weight×Hair). Gate media texto-vs-largura (§V16) mas nunca posição-vs-irmão ∴ passava verde|V37
B17|2026-08-17|§V16 mede só `//label[@text][@width]` ∴ `checkBox` c/ `text=` nunca checado: `Wounded (-2)` = `Ferido Gravemente (-2)` (~143px) num `checkBox` de 125px, cortando em [pt] desde T3. Achado à mão ao alargar HEALTH, ⊥ pelo gate ≡ §B4 (mesmo ponto cego, outra família)|V38
