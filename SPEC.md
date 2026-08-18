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
- 7ª rodada 2026-08-17 ↓
- LIMPAR marca = CURA ∴ ⊥ zera a linha clicada: zera a ÚLTIMA linha marcada (maior índice). Ex. do user: 3 marcadas (1 2 3), clique p/ limpar a 1 → quem zera é a 3 & a 1 SEGUE marcada. Dano entra por qualquer linha, cura sai sempre de baixo
- clique esquerdo em `*` (wrap p/ `" "`) & clique DIREITO caem os 2 na mesma rotina de cura ∴ 1 regra só, ⊥ 2 caminhos p/ divergir. Direito vira "cura 1 nível" de qualquer linha. JULGAMENTO meu — user disse "se um ponto de vida for limpo", ⊥ separou os 2 botões ?
- alvo da cura ∈ linhas 1…`healthLevels` (as VISÍVEIS) ∴ marca presa em linha escondida (track encolheu depois de marcar) ⊥ vira alvo — senão o clique some sem efeito visível (§V45)
- normalização do render (valor ∉ lista → `" "`, §V42) ⊥ é cura: limpeza de dado velho, ⊥ clique ∴ ⊥ passa pela rotina de cura
- ⊥ downgrade de gravidade na cura (`*`→`X`→`/`): user pediu LIMPAR o nível. Regra de livro (agravado cura diferente) ⊥ entra — ficha = papel (§C ↑)
- 8ª rodada 2026-08-17 ↓
- track SEMPRE AGRUPADO: marcas ordenadas por gravidade decrescente `*` > `X` > `/` > vazio nas linhas 1…`healthLevels`, ⊥ buraco entre elas ∴ dano mais forte sobe sozinho & empurra o mais fraco p/ baixo. Pedido user 2026-08-17 c/ 2 exemplos
- ordem de gravidade = a própria ordem de `HEALTH_MARKS` (índice ↑ = mais grave) ∴ ⊥ 2ª lista p/ divergir de §V41
- entrada de dano segue sendo o CICLO na caixa (" "→`/`→`X`→`*`) ∴ registrar 1 agravado = clicar a ferida & seguir ela subindo. Exemplos do user fecham: `X X /` + clique em vazio → `X X / /`; clique na nova `/` → `X X X /`; clique nessa `X` (que subiu p/ linha 3) → `* X X /`. Depois +2 cliques numa vazia → `* X X X /`
- reagrupar roda DEPOIS de ∀ mutação que pode quebrar a ordem: upgrade no meio da pilha (`* X X /` + clique na 2ª `X` → `* X * /`) & marca criada em caixa vazia longe do bloco (buraco). Cura ⊥ precisa — tirar a última de lista ordenada mantém ordem
- render também reagrupa: ficha marcada nas rodadas 6/7 tem ordem arbitrária ∴ 1ª abertura já mostra agrupado. Contagem preservada ∴ ⊥ é perda de dado, ≠ cura (§V45)
- ⊥ estouro: marca NOVA só nasce clicando caixa vazia ∴ total ≤ `healthLevels` sempre; upgrade troca tipo, ⊥ cria marca
- 9ª rodada 2026-08-17 ↓
- caixa `ABILITIES` (Main) herdou fill `#FFFFFF00` (transparente) do `M20.1` ∴ fundo da aba passa através & ela lê CINZA ao lado das irmãs pretas. Fix = `color="black"` ≡ demais caixas de seção (§B18)
- fills ⊥ pretos que FICAM: moldura do avatar (`DimGray` — ⊥ é caixa de seção, ⊥ tem título) & caixinha de marca de vitalidade (`#00000000` — mora DENTRO de caixa preta, o vazado é o efeito) ∴ §V48 mede só caixa de SEÇÃO
- aba História: caixas `Concept` (campo `personalidade`) & `Nature` (campo `natureza`) SAEM; `Moral Flaws` & `Fears` ocupam as posições delas — (0,315) & (205,315). Pedido user 2026-08-17
- `personalidade` & `natureza` viram ÓRFÃOS declarados (∃ dado em ficha salva, ⊥ widget) ∴ remoção PEDIDA ≠ rename acidental, §V2 ⊥ se aplica ≡ precedente `transportation`/`other`
- chaves `.lang` `Concept` & `Nature` FICAM: header da Main renderiza `Concept` & os pickers renderizam `Nature` ∴ ⊥ sair do `.lang` nem do mapa `PT`
- slot de baixo (0,675)+(205,675) fica VAZIO & `Prelude` segue 715 alto ∴ coluna esquerda fecha em 670 & sobra vão de 180px. Reflow ⊥ pedido ≡ precedente das 5 fichas base ?
- 10ª rodada 2026-08-17 ↓
- fundo preto da caixa HEALTH acompanha `healthLevels`: altura = `n`·PITCH + PAD. Geometria real das 2 abas: 1ª linha @ top 28, pitch 27, linha 20 alta ∴ PITCH=27 & PAD=30 → n=10 dá 300 (= altura de hoje) & n=7 dá 219. Pedido user 2026-08-17
- XML declara o MÁXIMO (n=10 → 300) & o Lua só ENCOLHE ∴ §V40 (caixa × caixa) mede o PIOR caso no arquivo estático & runtime ⊥ pode estourar vizinho. Crescer ⊥ existe: 10 é o teto do combo
- PITCH & PAD = constantes nomeadas no form raiz, ⊥ número solto no meio do render ∴ gate compara PITCH c/ o pitch REAL medido nas linhas do XML (§V49) — mesmo tipo de deriva que causou §B12 & §B16
- caixa ganha nome (`<prefix>box`) p/ o render achá-la ≡ `<prefix>row<N>` & `<prefix><N>` ∴ ⊥ 3ª convenção
- encolher deixa vão embaixo da caixa nas 2 abas. Reflow do que está em volta ⊥ pedido ∴ ⊥ mexe (≡ precedente da 9ª rodada)
- 11ª rodada 2026-08-17 ↓ (8 pedidos do user, 1 por item)
- (1) Main: preview do avatar 375→405 alto ∴ fecha em y=810 ≡ `BACKGROUNDS` & `HUMANITY`. Caixa `HUMANITY & WILLPOWER` ⊥ MUDA — user confirmou 2026-08-17 que só o avatar estava fora (ela já fechava em 810)
- (2) `HEALTH_BOX_PAD` 30→36 ∴ +6px embaixo da última linha & altura declarada da caixa HEALTH 300→306 nas 2 abas (§V49 = caso n=10). Canto ACEITO: só em n=10 a caixa passa 6px abaixo de `BACKGROUNDS` na Main
- (3) Traits, alvos de alinhamento do user: `Merit` fecha ≡ `MENTOR` (x=410) · `Flaw` fecha ≡ `FAME` (x=830) · `DERANGEMENTS` abre ≡ `BASE OF OPERATIONS` (x=840) ∴ Merit 0..410 & Flaw 420..830 & DERANGEMENTS 840..1040, todos c/ gutter 10
- (3) largura extra vai p/ a coluna do NOME no template `Merit` (200→230; `Page` & `Cost` ⊥ mudam) ∴ template 350→380 & labels de cabeçalho acompanham
- (4) `cboFaith` items = `{'', 'Christianity', 'Judaism', 'Islam', 'Other'}` — user escreveu em PT, mas §V9 manda autorar em EN & traduzir no `.lang` (`Cristianismo` `Judaísmo` `Islamismo` `Outro`). 1º item vazio MANTIDO (§V15)
- (4) descrição da linha `faith` = SEMPRE `DESC['True Faith']`, ∀ item escolhido ∴ os 4 itens ⊥ pedem entrada própria em `DESC` (§V50) & §V32 ⊥ se aplica a eles
- (5) Combat: `ARMOR` encolhe p/ fechar ≡ HEALTH em n=7 → altura 225 (= 7·27+36) & `armorDescription` 180→110; HEALTH sobe de top 330 p/ 350 ∴ as 3 caixas (`ARMOR` `VIRTUES` HEALTH) ABREM na mesma linha y=350
- (5) caixa `WILLPOWER` NOVA na Combat, abaixo de `VIRTUES` @ (390,470,270,105) ∴ fecha em 575 ≡ ARMOR & HEALTH(n=7)
- (5) bolinhas `willpower_1`…`_10` na Combat = SÓ-LEITURA (⊥ `field`, pintadas por Lua ≡ mecanismo de T101); `willpower_c1`…`_c10` = ESPELHO EDITÁVEL ∴ marcar na Combat muda a Main (§V36, §V51)
- (6) História: `Prelude` fecha ≡ `Goals`; caixa do grid de descritores 125→100 (conteúdo fecha em 90) & tudo abaixo sobe 25 ∴ `Languages` 110 · `Moral Flaws`/`Fears` 290 · `Goals` 470..645 · `Prelude` (410,110,630,535) fecha 645
- (7) Progress: os 3 campos de XP viram 3 colunas na horizontal, caixa `EXPERIENCE` (0,0,1040,90); `EXPERIENCE LOG` (0,100,1040,540) ∴ mesma borda direita 1040 & mesmo fim 640
- (8) Settings: caixa de opções sobe p/ o TOPO & créditos vão p/ o FIM (hoje é o contrário)
- (8) créditos separam autoria: `Andre (Styllern)` = Developer desta ficha; demais nomes & papéis VERBATIM sob "Based on the RPGmeister sheet plugin, by:". ⊥ inventar papel — crédito de pessoa real (§C ↑ RPGmeister)
- (8) combo `Theme` NOVO logo abaixo de `Game`: items `{'Modern', 'Victorian Era'}`, default `Modern`, ⊥ 1º item vazio. Campo = `sheetTheme`, ⊥ `theme`: nome velho carrega `Dark`/`Escuro` de ficha salva do Mage & o check §V12 casa em `field="theme"` ∴ reusar mentiria
- (8) combo do tema = `cboSheetTheme` (nome `cbo*` DE PROPÓSITO): a troca de idioma só reconstrói items de `cbo*` ∴ sem o prefixo o user veria `Modern`/`Victorian Era` num sheet [pt], contra o pedido. `values` seguem EN canônico (§V24) & items mostram [pt]. CORREÇÃO 2026-08-17 do §C que mandava ficar fora dos checks — achada @ build
- (8) ∴ `cboSheetTheme` ∈ §V14 & §V17, mas EXCEÇÃO declarada em §V15: 1º item ⊥ vazio, pois é combo de ESTADO c/ default real (`Modern`), ⊥ picker de prosa que precisa ser limpável
- (8) `sheetTheme` só estado, ⊥ dispara lógica ≡ `game` ?
- 12ª rodada 2026-08-17 ↓
- (1+3) as 2 bordas pedidas fecham 1 retângulo só: `COMBAT` (0,0,650,330) → (0,0,660,320) — direita ≡ `VIRTUES` (x=660), baixo ≡ `COMBAT TRAITS` (y=320). 10 linhas de ataque fecham em 300 ∴ cabe c/ 20 de folga
- (1) coluna `Damage` 50→90. Os +40 saem de: +10 da caixa que alargou & −30 de `Weapon/Attack` (200→170, segue a coluna mais larga). Demais colunas ⊥ mudam. JULGAMENTO meu — user pediu ampliar dano & ⊥ disse de onde tirar
- (1) grade nova do template `Attack`: 0..170 attack · 170..270 roll · 270..320 diff · 320..410 damage · 410..460 range · 460..510 rate · 510..560 clip · 560..630 conceal (630 = 660 − 15 de margem ×2)
- (1) os 8 labels do cabeçalho ganham `horzTextAlign="center"` & `width` = largura da coluna ∴ centralizados SOBRE a coluna, ⊥ encostados à esquerda. §V11 intacto (1 label por coluna, ⊥ padding)
- (2) `VIRTUES` da Combat vira SÓ-LEITURA: bolinhas perdem `field`, viram `roVirtue_*` c/ `autoChange="false"` & Lua pinta ≡ traços/willpower. `conscience` `selfControl` `courage` (+`_2`…`_5`) SAEM de ESPELHOS & entram em SÓ-LEITURA no §I3
- (2) ∴ na Combat sobram editáveis só `health_*` (marca) & `willpower_c*` (caixas) — o resto da aba é vitrine. §V51 ampliado p/ cobrir os 3 grupos
- (4) `EXPERIENCE` da aba Progress 90→75 alto (conteúdo fecha em 65) & `EXPERIENCE LOG` (0,100,1040,540)→(0,85,1040,555) ∴ fim da aba segue 640
- 13ª rodada 2026-08-17 ↓
- (1) Combat: a fileira `ARMOR` · `VIRTUES` · HEALTH abre em 350 & `COMBAT` fecha em 320 ∴ vão de 30, contra os 10 que a ficha usa em ∀ outro lugar. Fileira inteira sobe 20 → top 330; `WILLPOWER` acompanha (470→450) ∴ tudo que estava na linha da armadura ou abaixo dela sobe junto
- (1) ⊥ mexe em altura nenhuma: `ARMOR` 225 & HEALTH n=7 225 seguem fechando juntos (330+225 = 555) & `WILLPOWER` fecha em 555 igual
- (2) `EXPERIENCE` (Progress): título colado no topo (top=0) → top=10 ∴ margem interna em cima; dados sobem de 45 p/ 38 ∴ distância título↔dados cai de 25 p/ 8
- (3) os 3 pares viram COLUNA: rótulo em cima (`horzTextAlign="center"`), valor ABAIXO & centrado sob ele — era rótulo à esquerda + valor ao lado. 3 colunas de 336 @ left 15 · 352 · 689; `edit` 90 largo centrado em cada (+123)
- (3) empilhar CRESCE a caixa: 75→95 alto (título 10..30 · rótulos 38..58 · valores 60..85 · 10 de folga). REVOGA em parte a 12ª rodada (que encolheu p/ 75) — pedido novo do user manda. `EXPERIENCE LOG` (0,85,1040,555)→(0,105,1040,535) ∴ fim da aba segue 640
- 14ª rodada 2026-08-17 ↓ (tema visual — o combo `sheetTheme` deixa de ser só estado & passa a PINTAR)
- combo `cboSheetTheme` 2→3 itens: `Modern` · `Victorian Era (Light)` · `Victorian Era (Dark)`. Pedido user 2026-08-17 — as 2 direções que ofereci como alternativa viraram as 2 opções
- `Modern` = a ficha de HOJE & ⊥ tem paleta escrita à mão: snapshot dos props ANTES da 1ª pintura & voltar = RESTAURAR o snapshot ∴ ⊥ 2ª descrição do visual atual p/ divergir do XML (≡ §V22 p/ tradução)
- valor velho `Victorian Era` (gravado na 11ª rodada, quando o combo era só estado) ∉ lista nova → cai no fallback `Modern`. ⊥ perda: aquele valor nunca pintou nada
- §V12 aplica: a tabela `THEMES` (chaveada pelos `values`) É a comparação Lua ∴ mudar `items` & mudar `THEMES` & mudar `defaultValue` = 1 commit
- tema ⊥ escreve geometria (`left` `top` `width` `height`) de NADA ∴ §V37 §V40 §V49 seguem medindo o XML estático & runtime ⊥ inventa sobreposição
- pintura ⊥ usa `findClass`: o rdk gera essa função partindo de `self` ∴ ela alcança só a aba onde roda — é o §B9 por outro caminho (§R21). Reusa `rootOf`+`collect` do `applyLanguage` (`HH.6`)
- mapa de cor chaveado no valor AUTORADO (`black` `white` `#FFFFFF` `#00000000` `DimGray`) ∴ ⊥ preciso nomear ~50 `<rectangle>`; cor nova sem entrada no mapa = gate vermelho (§V53), ⊥ caixa preta calada no meio do pergaminho
- `#00000000` (caixa de marca de vitalidade) segue transparente nas 3 opções — o vazado é o efeito (≡ exceção declarada em §V48)
- PALETA Claro: form `light` · fundo `#E8DCC0` · filete `#6B4F2A` · texto `#2E2015` · moldura do avatar `#8A6A3B`. PALETA Escuro: form `dark` · fundo `#1C1310` · filete `#C2A14D` · texto `#E8DCC0` · moldura do avatar `#6B4F2A`
- ⊥ cor própria p/ título de seção (ouro): separar título de label comum pediria nome por widget | detecção por `left=0`+`horzTextAlign` ∴ hierarquia segue vindo do `fontSize` que já ∃. CORTE declarado, ⊥ esquecimento
- moldura: `xradius`/`yradius` 10→0 & `strokeSize`→2 nas 2 vitorianas ∴ canto reto + filete grosso ≡ documento impresso. Tamanho de caixa ⊥ muda
- fonte serifada por `fontFamily`. Família vem do host — ⊥ dá p/ embarcar arquivo de fonte no `.rpk` ∴ candidatas + fallback = §R24
- bolinha: `prime_on.png` de hoje é BRANCA ∴ sumiria no pergaminho. Claro ganha par tinta, Escuro ganha par dourado ∴ as 3 opções ⊥ ficam iguais
- ornamento = geometria PROCEDURAL (círculo, filete, canto, grão de papel) que eu gero por comando. Filigrana/arabesco vitoriano de verdade = ARTE, ⊥ sei desenhar ∴ `?` — user fornece PNG se quiser trocar
- `gui.Image` ⊥ tem `tile` (§R23) ∴ textura = 1 PNG grande em `style="stretch"` por aba, `hitTest="false"` & sem `field` (≡ §V29: ∉ contrato de dados)
- textura ATRÁS do conteúdo depende de ordem de declaração — ⊥ ∃ `bringToFront`/`sendToBack` no SDK (§R23) ∴ T153 testa ANTES; ⊥ resolvido → tema segue SEM textura (§V56), ⊥ para
- 6 PNGs novos gerados 1× por comando inline ∴ ⊥ script de geração no repo (regerar = raro; arquivo a mais só p/ isso ⊥ se paga)
- backdrop tem nome POR ABA (`themePaper1`…`themePaper9`, ⊥ em `HH.6`) & o Lua casa por PREFIXO ≡ `dyn`/`cbo` — `name=` de controle é global entre os `.lfm` da ficha (§V59, §B19). Achado @ build
- correção 2026-08-17 ↓ (teste do user: as 3 opções renderizaram erradas, `Modern` incluído — que ⊥ mudou no XML)
- caminho de imagem gravado em RUNTIME ! absoluto do plugin (`/HuntersHunted/images/x.png`). Relativo vale só no XML, que o rdk resolve @ COMPILE ∴ paleta c/ relativo = arte que ⊥ carrega (§B20, §R26)
- gravar prop ⊥ é no-op: ∀ setter de fonte chama `_gui_prepareForFont*Change` ANTES de gravar ∴ desacopla o controle da fonte herdada do tema mesmo gravando o valor que acabou de ler (§B21, §R27)
- ∴ snapshot-e-restaura em ∀ controle morreu. Fix = LEDGER: `applyTheme` só grava prop c/ destino MAPEADO & registra o valor autorado; `Modern` restaura só o registrado ∴ ficha recém-aberta em Modern grava ZERO prop (§V61, §V62)
- ledger guarda o valor AUTORADO ∴ Claro→Escuro direto mapeia da cor ORIGINAL, ⊥ da que o tema anterior deixou. Valor autorado = nil (prop que o XML nunca setou) → ⊥ pinta, pois ⊥ teria como desfazer
- backdrop fica FORA do ledger: é controle que só existe p/ o tema, estado autorado = sem `src` & escondido ∴ `Modern` só re-esconde (e só se já ⊥ estiver escondido, p/ ⊥ furar §V61)
- `fontFamily` só onde o snapshot devolve família REAL (string ⊥ vazia) ∴ restauro sempre grava família válida. Controle que HERDA fonte fica sem serifa & isso ! ser observado no teste (§R27)
- 15ª rodada 2026-08-17 ↓ (4 épocas; pedido user)
- combo 3→5: `Modern` · `Present Day` · `Victorian Era` · `Dark Ages` · `Classical Era`. Ordem = base primeiro, depois voltando no tempo
- `Victorian Era (Light)` SAI inteiro (paleta + arte). User ⊥ gostou ∴ ⊥ ∃ mais variante clara
- sufixo `(Dark)`/`(Light)` CAI de todos: c/ 1 variante por época ele ⊥ distingue nada. `Victorian Era (Dark)` → `Victorian Era`
- ∴ o valor `Victorian Era` da 11ª rodada VOLTA a ser válido (era fallback desde a 14ª) ∴ ficha salva daquela época passa a pintar Vitoriano em vez de cair no base — o que ela queria dizer. Benigno, ⊥ é reuso de órfão (§I3 fala de nome de CAMPO, isto é VALOR)
- `Modern` fica c/ o nome de hoje (decisão user): segue sendo a ficha CRUA, ⊥ tem paleta & é o único caminho de volta + a garantia de zero escrita (§V54, §V61). Custo aceito: "Moderno" & "Atual" convivem na lista
- PALETA `Present Day` (vampiro 2025/26, noturno urbano): form `dark` · fundo `#12141A` · filete `#3A4150` · texto `#E6E8EC` · avatar `#2A2F3A` · `Segoe UI` · canto **10** (ÚNICO tema que ⊥ zera — UI atual é arredondada) · filete **1** · bolinha carmim
- PALETA `Dark Ages` (Europa ~1300, pedra & carvalho à luz de vela): form `dark` · fundo `#1A1512` · filete `#8A7A5C` (ferro/latão fosco) · texto `#E3D8BE` · avatar `#5A4A32` · `Book Antiqua` · canto 0 · filete **3** (banda de ferro) · bolinha sangue
- PALETA `Classical Era` (Roma ~200 a.C., República): form `dark` · fundo `#171218` (basalto) · filete `#BFA05A` (ouro de louro) · texto `#F0EAD9` (marfim) · avatar `#6B2A4A` (púrpura tíria) · `Times New Roman` · canto 0 · filete 2 · bolinha OURO reusada do Vitoriano ∴ ⊥ 2 PNGs a mais
- `paper_dark.png` → `paper_victorian.png`: c/ 4 papéis por época, `paper_dark` ao lado de `paper_dark_ages` mente. Renome de arquivo, ⊥ de campo
- arte: +7 PNG (`prime_on_crimson` `prime_off_slate` `prime_on_blood` `prime_off_iron` `paper_present` `paper_dark_ages` `paper_classical`) · −3 (`prime_on_ink` `prime_off_ink` `paper_light`) ∴ tema removido leva a arte junto (§V64)
- ⊥ resolvido segue ⊥ resolvido: T153(a)(b) (papel atrás do conteúdo & `hitTest`) & §R27 (família herdada) agora carregam 4 papéis & 3 famílias ∴ o teste no Firecast pesa MAIS, ⊥ menos
- correção 2026-08-17 (2ª) ↓ (teste do user: bolinha fixa BRANCA em ∀ tema)
- dot1 fixo de `Attribute` (`HH.1`, 8 attrs + 3 virtudes) & `VirtueMirror` (`HH.3`) = `<image src="images/prime_on.png">`, ⊥ `imageCheckBox` ∴ ficava fora da troca de arte — o ramo `image` do `applyTheme` só olhava `themePaper*`. Corte declarado por MIM na 14ª rodada ("arte fixa ⊥ é assunto do tema"), ERRADO: é a MESMA arte da caixa marcada ∴ ! seguir `dotOn` (§B22)
- casamento por LEAF do caminho (`prime_on.png`) c/ `normPath` ≡ `normColor`: XML autora relativo & runtime devolve absoluto (§R26) ∴ comparar o nome do arquivo resolve os 2
- ⊥ chave nova de paleta: a bolinha fixa mostra o mesmo que a caixa marcada ∴ reusa `dotOn`/`dotOff` que já ∃ & §V63 segue em 10 chaves
- avatar (`<image>` SEM `src`, `field="avatar"`) segue FORA: é a foto do jogador, ⊥ arte de tema
- 16ª rodada 2026-08-17 ↓ (4 pedidos do user)
- (1) tema base `Modern` (sem paleta) SAI ∴ 4 valores, ∀ um c/ paleta & a ficha SEMPRE é pintada. Perde-se a volta p/ a ficha crua & a garantia de "zero escrita" — custo que EU declarei na 15ª rodada e o user aceita agora
- (2) `Present Day` → `Modern` (PT `Atual` → `Moderno`). `wod.Modern`=`Moderno` já ∃ ∴ ⊥ chave nova; `wod.Present Day` sai
- ficha salva c/ o `Modern` VELHO (= ficha crua) cai no `Modern` NOVO (contemporâneo estilizado): mesma string, outro sentido. ⊥ ∃ mais opção crua p/ onde mandar ∴ benigno. `Present Day` salvo → desconhecido → default = o MESMO tema c/ outro nome ∴ sem perda
- (1) ⊥ ∃ arte usada SÓ pelo `Modern` velho: ele ⊥ tem paleta ∴ ⊥ referencia arte nenhuma. `prime_on.png` & `prime_off.png` são autorados no XML em ∀ template & são as CHAVES que ∀ paleta remapeia (§V65) ∴ FICAM. Nada a apagar — §V64 prova
- (3) "borda diferenciada nas pontas" = `cornerType="innerLine"` + raio 10, autorado no XML em 53 caixas ∴ JÁ vale em ∀ época. As outras 3 paletas estavam DESTRUINDO o detalhe c/ `corner = 0` ∴ fix = parar de escrever raio, ⊥ adicionar nada
- (3) ∴ `corner` SAI das paletas & `applyTheme` ⊥ escreve `xradius`/`yradius` (§V66). Melhor que forçar 10: 3 `rectangle` autoram raio PRÓPRIO (2 & 5 — caixa de marca de vitalidade & moldura do avatar) & seriam deformados
- (4) outline hoje: 1 (`Present Day`) · 2 (`Victorian Era`) · 3 (`Dark Ages`) · 2 (`Classical Era`) → mais largo = **3** ∴ ∀ um 3
- (4) ∴ `strokeSize` SAI das paletas → constante ÚNICA `THEME_STROKE = 3` (§V67): "todos iguais" vira ESTRUTURAL, ⊥ 4 cópias que podem divergir. §V63 10→8 chaves
- `restore()` & o ramo `t == nil` viram código MORTO (⊥ ∃ mais opção sem paleta) ∴ SAEM. Ledger FICA — é ele que faz época→época mapear da cor ORIGINAL (§V62)
- canto arredondado numa ficha medieval | vitoriana lê menos "de época" — pedido EXPLÍCITO do user, custo aceito
- 17ª rodada 2026-08-17 ↓ (1 pedido: canto mais arredondado)
- `cornerType` `innerLine` → `innerRound` nas 54 ocorrências & raio 10 → 14 nas 53 caixas de seção ∴ o corte RETO do canto vira CURVA, um pouco maior. Decisão do user entre 4 opções (`round` RECUSADO: perderia o recorte & a moldura viraria caixa comum)
- moldura do avatar acompanha o `cornerType` mas MANTÉM raio 5; caixa de marca de vitalidade INTACTA (raio 2, sem `cornerType`) — as 2 são deliberadamente diferentes & uniformizar deformaria (≡ lógica de §V66)
- canto mora no XML (§V66) ∴ muda 1× & vale nas 4 épocas ao mesmo tempo
- 18ª rodada 2026-08-17 ↓ (4 pedidos do user)
- (1) Main, caixa `VIRTUES`: título desce de `top` 0 → 8 ∴ respiro entre a borda de cima & a palavra. Demais títulos de seção ⊥ mudam — pedido é só desta caixa
- (2) pitch das 3 virtudes 25 → 29 (linhas @ 33 · 62 · 91) ∴ +4px entre `Conscience` `Self-Control` `Courage`. Caixa 110 → 126 alto (fecha 636, gap 10 p/ a de baixo ≡ resto do arquivo)
- (3) `HUMANITY & WILLPOWER` absorve os 16px: top 630→646 & height 180→164 ∴ fim segue em 810 ≡ `BACKGROUNDS` (§V69). Internos ⊥ mudam — conteúdo fecha em 155, folga de baixo 25→9
- (3) folga de baixo (9) < folga de cima (15) na caixa apertada. Reflow interno ⊥ pedido ∴ ⊥ mexe (≡ precedente da 9ª & 10ª rodada)
- `VIRTUES` da aba Combat (`HH.3`, 390,330,270,110) ⊥ acompanha: user pediu "aba main" & lá a caixa fecha em 440 c/ `WILLPOWER` @ 450 ∴ +16 colidiria & pediria reflow da coluna inteira. As 2 abas ficam c/ pitch DIFERENTE — custo declarado, ⊥ esquecimento
- (4) paleta `Dark Ages`: `stroke` `#8A7A5C` (ferro fosco) → `#C0C6CC` (prata) nas 3 entradas & `fill["black"]` `#1A1512` → `#0E0B09` ∴ filete claro sobre interior mais escuro. Hex = JULGAMENTO meu — user disse "prateada" & "mais escura", ⊥ deu valor
- (4) `fill["DimGray"]` (moldura do avatar, `#5A4A32`) & `#00000000` & `font` & arte de bolinha (`prime_on_blood` `prime_off_iron`) ⊥ mudam: pedido fala de outline & interior de CAIXA. Moldura marrom ao lado de filete prateado = escolha, ⊥ deriva ?
- (4) ⊥ chave nova em paleta nenhuma — só VALOR ∴ §V53 & §V63 seguem verdes sem tocar no gate
- 19ª rodada 2026-08-17 ↓ (6 pedidos do user — tema deixa de ser só pintura & passa a RENOMEAR perícia)
- (1)(4)(6) cada época traz sua LISTA de perícias: o RÓTULO da linha passa a depender do tema & o CAMPO ⊥ muda (§V2 intacto). Mapa por época, chaveado no campo:
  - `Dark Ages`: `streetwise`→`Legerdemain` · `crafts`→`Archery` · `etiquette`→`Commerce` · `firearms`→`Crafts` · `larceny`→`Etiquette` · `finance`→`Hearth Wisdom` · `science`→`Seneschal` · `technology`→`Theology`
  - `Modern Nights`: `etiquette`→`Drive` · `firearms`→`Etiquette` · `larceny`→`Firearms` · `melee`→`Larceny` · `performance`→`Melee` · `ride`→`Performance` · `enigmas`→`Computer`
  - `Classical Age`: `etiquette`→`Archery` · `firearms`→`Commerce` · `larceny`→`Etiquette` · `melee`→`Performance` · `performance`→`Melee` · `enigmas`→`Hearth Wisdom` · `finance`→`Investigation` · `investigation`→`Law` · `law`→`Medicine` · `medicine`→`Occult` · `occult`→`Politics` · `politics`→`Philosophy` · `science`→`Ritual` · `technology`→`Religion`
  - `Victorian Era` ⊥ tem mapa ∴ segue c/ o rótulo autorado no XML — user ⊥ pediu lista vitoriana ?
- user escreveu 4 rótulos em PT (`Computador` `Etiqueta` `Filosofia` `Religião`) ∴ autoro EN (`Computer` `Etiquette` `Philosophy` `Religion`) & traduzo no `.lang` (§V9 §V24)
- trocar de época RE-INTERPRETA as bolinhas: dado ⊥ move, mas a linha que dizia `Firearms` passa a dizer `Etiquette` ∴ ficha montada numa época & lida em outra mostra OUTRA perícia no mesmo ponto. Custo INERENTE ao pedido, ⊥ contornável sem migrar dado
- rótulo de perícia vira Lua-owned: label do template ganha `name="dynAbil$(field)"` & o renderer escreve `tryTranslate(MAPA[campo] | autorado)` ∴ FORA da travessia de idioma (≡ `dyn` da vitalidade, §V31) & roda no load & na troca de tema & na troca de idioma (§V72)
- EN autorado no XML segue sendo a fonte do caso SEM mapa ∴ snapshot 1× no 1º render (≡ §V22), ⊥ 2ª lista de rótulos-base p/ divergir
- (2) `Dark Ages`: bolinha ligada & desligada na MESMA prata do outline (`#C0C6CC`) ∴ arte nova `prime_on_silver.png` (cheia) + `prime_off_silver.png` (anel), 100×100 ≡ geometria do par base; `prime_on_blood.png` & `prime_off_iron.png` SAEM (§V64). Bolinha só-leitura & dot1 fixo já seguem `dotOn`/`dotOff` (§V65) ∴ "incluindo as que o user ⊥ muda" ⊥ pede código novo
- (3) `Modern` → `Modern Nights` ([pt] `Noites Modernas`) & (5) `Classical Era` → `Classical Age` ([pt] `Idade Clássica`). `values` = EN canônico (§V24) ∴ "Noites Modernas" é display, ⊥ valor
- `Modern Nights` segue default & fallback (§V52) ∴ ficha salva c/ `Modern` cai no MESMO tema, só o nome mudou. Ficha salva c/ `Classical Era` cai no default ∴ PERDE a época — alias ⊥ criado (≡ precedente `Present Day`), custo declarado ?
- DECISÃO user 2026-08-17: espelho de combate segue o PAR rótulo↔bolinha — se a época ⊥ tem `Firearms`, a linha mostra a perícia de ataque à distância DAQUELA época & espelha o CAMPO dela ∴ `Dark Ages` = `Archery` (campo `crafts`) · `Modern Nights` = `Firearms` (campo `larceny`) · `Classical Age` = `Archery` (campo `etiquette`) · `Victorian Era` = `Firearms` (campo `firearms`)
- idem corpo-a-corpo: `Melee` mora em `melee` (Trevas · Vitoriano) | `performance` (Moderno · Clássico) ∴ 2 das 7 linhas de perícia da caixa `COMBAT TRAITS` viram SLOTS
- os 2 slots perdem o nome por campo & viram POSICIONAIS (`ro_ranged_*` `ro_close_*`) ≡ precedente da vitalidade (4ª rodada): nome por campo mentiria em 2 das 4 épocas. As outras 5 linhas ⊥ trocam de campo, mas o RÓTULO delas passa pelo MESMO renderer ∴ 1 caminho só, ⊥ 2 p/ divergir
- as 4 linhas de ATRIBUTO de `HH.3` compartilham o template `ReadOnlyTrait` ∴ entram no renderer de graça (sem mapa = rótulo autorado traduzido). Separar o template p/ poupar 4 labels = complexidade sem ganho — JULGAMENTO meu
- rótulo de perícia ⊥ é dado: §I3 ⊥ ganha campo novo & os slots seguem sem `field=` ∴ §V1 §V36 §V51 intactos
- 20ª rodada 2026-08-17 ↓ (1 pedido do user: valor ! ser consistente entre épocas — §B23)
- identidade do traço = o NOME, ⊥ a linha: `Melee` ! ler o MESMO campo em ∀ época ∴ mapa de época passa a ser ATRIBUIÇÃO CANÔNICA nome→campo, ⊥ renome de linha (era o que a 19ª rodada escreveu ∴ `Melee` morava em `melee` na Idade das Trevas & em `performance` no Clássico)
- CONJUNTO de nomes por época ⊥ muda — as 4 listas seguem as que o user pediu na 19ª rodada. Muda só QUAL LINHA carrega cada nome ∴ ⊥ é pedido novo, é a mesma lista escrita de outro jeito
- mapas NOVOS (só o que difere do rótulo autorado): `Victorian Era` = {} · `Modern Nights` = `ride`→`Drive` · `enigmas`→`Computer` · `Dark Ages` = `streetwise`→`Legerdemain` · `firearms`→`Archery` · `larceny`→`Commerce` · `finance`→`Hearth Wisdom` · `science`→`Seneschal` · `technology`→`Theology` · `Classical Age` = `firearms`→`Archery` · `larceny`→`Commerce` · `finance`→`Hearth Wisdom` · `enigmas`→`Philosophy` · `science`→`Ritual` · `technology`→`Religion`
- ∀ nome que ∃ em 2+ épocas cai sempre no mesmo campo: `Melee`=`melee` · `Performance`=`performance` · `Etiquette`=`etiquette` · `Crafts`=`crafts` · `Archery`=`firearms` · `Commerce`=`larceny` · `Hearth Wisdom`=`finance` ∴ o sintoma do user morre p/ ∀ perícia que atravessa época
- linha compartilhada por nomes EXCLUSIVOS de época (⊥ coexistem): `streetwise` = Streetwise \| Legerdemain · `firearms` = Firearms \| Archery · `larceny` = Larceny \| Commerce · `ride` = Ride \| Drive · `finance` = Finance \| Hearth Wisdom · `enigmas` = Enigmas \| Computer \| Philosophy · `science` = Science \| Seneschal \| Ritual · `technology` = Technology \| Theology \| Religion. Valor ⊥ some & voltar p/ a época mostra ele de novo — mas aparece sob o nome QUE AQUELA ÉPOCA dá à linha
- ∴ o dado NUNCA muda de campo: nem na troca, nem na volta. `applyTheme` & o renderer seguem ⊥ escrevendo campo nenhum (⊥ migração, ⊥ Lua tocando NDB) — a correção é de MAPA, ⊥ de mecanismo
- alternativa RECUSADA (custo ⊥ se paga agora): campo próprio por NOME (`archery` `commerce` `hearthWisdom` `legerdemain` `seneschal` `theology` `philosophy` `ritual` `religion` `computer` `drive` = 11 campos novos, 41 no total) ∴ Seneschal ≠ Ritual seriam traços separados. Pede bolinha Lua-owned | religar `field` em runtime (⊥ documentado) + §V1 c/ exceção nova ?
- ordem da coluna deixa de ser alfabética em Trevas & Clássico (`Archery` & `Commerce` ficam nas linhas de `firearms` & `larceny`) ∴ lista certa, ordem de leitura ⊥. Reordenar linha por época = Lua escrevendo `top` (permutação, ⊥ cria sobreposição) — ⊥ pedido ∴ ⊥ feito ?
- c/ nome→campo canônico, `Firearms`\|`Archery` mora SEMPRE em `firearms` & `Melee` SEMPRE em `melee` ∴ os 2 SLOTS da aba Combat (19ª rodada) viram flexibilidade MORTA: `THEME_COMBAT` sai & as 2 linhas voltam a ligar estático. §V71 RETIRADO, coberto por §V74
- 21ª rodada 2026-08-17 ↓ (1 pedido do user: ponto de 1 nome ⊥ pode aparecer em OUTRO nome — §B24)
- user recusa o resíduo declarado na 20ª rodada: `Enigmas 2` virando `Computer 2` na troca p/ `Modern Nights` ∴ nome exclusivo de época ! ser TRAÇO PRÓPRIO, ⊥ inquilino da linha de outro. Vale p/ ∀ coisa que o user edita — hoje só perícia é renomeada por época ∴ escopo = as 3 colunas de perícia
- modelo NOVO: bijeção nome↔campo. 11 campos NOVOS (`legerdemain` `archery` `commerce` `drive` `computer` `hearthWisdom` `philosophy` `religion` `ritual` `seneschal` `theology`) ∴ 41 nomes / 41 campos & 2 nomes ⊥ dividem bolinha nunca mais (§V74 reescrito)
- ∴ o mapa por época deixa de ser campo→rótulo & vira LISTA DE NOMES por coluna: `ERA_ABILITIES[época][coluna]` = 10 nomes na ordem de leitura; `ABILITY_FIELD[nome]` = campo. Linha = SLOT, ⊥ dono de campo
- bolinha RE-LIGA em runtime: `imageCheckBox.field` tem setter no SDK (`gui.ImageCheckBox:setField` → `_obj_setProp(handle,"FieldName",v)`, §R28) ∴ ⊥ precisa de bolinha Lua-owned, ⊥ precisa de linha por nome escondida & ⊥ mexe em geometria. `checked` recarregado do NDB depois de re-ligar (§V76)
- XML segue autorando a lista VITORIANA (nome + `field`) ∴ renderer que ⊥ roda deixa a ficha coerente na época base, ⊥ meio pintada (§V19). §V1 segue medindo o estático: 1 dono por campo
- os 11 campos novos ⊥ têm dono no XML — nascem ligados em runtime ∴ §I3 declara categoria nova & §V5 (conta bolinha no XML) ⊥ os vê
- ⊥ migração: ficha salva segue c/ o valor no campo BASE ∴ quem "pôs pontos em Computer" antes desta rodada pôs em `enigmas` & agora lê `Enigmas` c/ os pontos & `Computer` zerado — que é EXATAMENTE o pedido do user
- ordem das colunas volta a ser ALFABÉTICA em ∀ época (a lista é dado agora, ⊥ consequência da linha) ∴ some o resíduo declarado na 20ª rodada. `Classical Age` = `Politics` antes de `Philosophy` & `Ritual` antes de `Religion` na escrita do user (artefato do modelo velho de renome) → ordeno alfabético. JULGAMENTO meu, fácil de inverter
- listas por época (10 por coluna, alfabéticas): TALENTS = base nas 4, c/ `Legerdemain` no lugar de `Streetwise` só em `Dark Ages` · SKILLS `Modern Nights` = Animal Ken · Crafts · Drive · Etiquette · Firearms · Larceny · Melee · Performance · Stealth · Survival · SKILLS `Dark Ages` = `Classical Age` = Animal Ken · Archery · Commerce · Crafts · Etiquette · Melee · Performance · Ride · Stealth · Survival · KNOWLEDGES `Modern Nights` = base c/ `Computer` no lugar de `Enigmas` · KNOWLEDGES `Dark Ages` = Academics · Enigmas · Hearth Wisdom · Investigation · Law · Medicine · Occult · Politics · Seneschal · Theology · KNOWLEDGES `Classical Age` = Academics · Hearth Wisdom · Investigation · Law · Medicine · Occult · Philosophy · Politics · Religion · Ritual
- aba Combat: `Archery` vira campo PRÓPRIO ∴ a linha de ataque à distância volta a ser SLOT (`ro_ranged_*`), resolvida da lista da época (o único nome ∈ {`Firearms`,`Archery`}) — ⊥ 2ª tabela p/ divergir (≡ §V41). `Melee` ∈ lista de ∀ época & mora sempre em `melee` ∴ aquela linha segue estática
- `THEME_LABELS` SAI (substituída por `ERA_ABILITIES` + `ABILITY_FIELD`). `THEME_COMBAT`, apagada na 20ª rodada, ⊥ volta: o slot resolve da lista
- 22ª rodada 2026-08-17 ↓ (1 pedido do user: nome da aba & títulos das 2 tabelas)
- aba `Powers` → `Numina` ([pt] `Númina`) ∴ chave `wod.Powers` SAI (⊥ ∃ outra string visível `Powers` — o resto é comentário & prosa de `DESC`, fora de §V28)
- títulos das 2 tabelas perdem o prefixo: `NUMINA: HEDGE MAGIC PATHS` → `HEDGE MAGIC PATHS` & `NUMINA: PSYCHIC PHENOMENA` → `PSYCHIC PHENOMENA` ∴ o nome da aba ⊥ se repete 3× na mesma tela. [pt] segue o glossário de §V34 (`CAMINHOS DE MAGIA ESTÁTICA`)
- chaves velhas SAEM de `.lang` & do mapa `PT` (⊥ ∃ mais widget que as mostre). `["NUMINA"]` & `["NUMINA & OTHER TRAITS"]` FICAM órfãs no mapa — §V22 mede mapa ⊆ `.lang`, ⊥ o inverso ∴ ⊥ vermelho; limpeza ⊥ pedida
- 23ª rodada 2026-08-17 ↓ (1 pedido do user: caixa do header encolhe & `EXPERIENCE` alarga)
- header (0,0,1100,100) → 1040 largo & caixa `EXPERIENCE` (1110,0,100,100) → (1050,0,160,100) ∴ os 2 seguem fechando em 1210 & gap de 10 (§V40). Título 100→160 acompanha a caixa (§V27) & o `edit` de 60 recentraliza em `left` 50
- os 60px saem do `edit`/`comboBox` dos templates `Header` & `HeaderPicker`: 235→215 (`left` 112 INTACTO ∴ coluna de entrada segue alinhada, §V26) ∴ template 347→327 & as 3 colunas passam a 335 largo @ `left` 5 · 350 · 695 (pitch 365→345)
- rótulo do header FICA em 105: o mais longo é `Demeanor` = `Comportamento` (~85px) ∴ encolher o label cortaria o [pt] (§V16). "espaço livre antes de Name/Player/Chronicle" que o user vê = folga do label `horzTextAlign="trailing"`, ⊥ largura sobrando
- caixa `EXPERIENCE` da aba Progress (`HH.9`) ⊥ muda — pedido fala da Main ?
- 24ª rodada 2026-08-17 ↓ (1 pedido do user: header encolhe de novo & conteúdo anda p/ a esquerda)
- header 1040→1010 & gap p/ `EXPERIENCE` 10→40 ∴ as 2 caixas seguem fechando em 1210 (`EXPERIENCE` ⊥ muda). Gap de 40 = EXCEÇÃO declarada ao gutter de 10 do resto da ficha, pedida pelo user
- conteúdo inteiro anda 30px p/ a ESQUERDA: colunas @ `left` 5 (297 largo) · 320 (327) · 665 (327), gutter 18 & folga direita 18 ≡ hoje
- os 30px da coluna 1 saem de um template NOVO `HeaderNarrow` (label 75 + entrada @ 82, 215 largo) p/ `name` `player` `chronicle`: o label de 105 é ditado por `Demeanor` = `Comportamento` (~86px) que mora na coluna 2 ∴ era ele que empurrava `Nome`/`Jogador`/`Crônica` p/ a direita. Rótulo da coluna 1 em [pt] = `Nome` `Jogador` `Crônica` (≤7 chars, ~46px) ∴ 75 sobra
- §V26 mede colunas de entrada entre irmãos de MESMO `left` ∴ largura de rótulo diferente ENTRE colunas ⊥ viola nada; dentro de cada coluna todas as linhas seguem no mesmo template
- rótulo das colunas 2 & 3 FICA em 105 & entrada FICA em 215: apertar o que já estava justo cortaria [pt] (§V16, ≡ lição da 23ª rodada) ∴ o ganho veio de encurtar rótulo ONDE ele pode ser curto
- arquivo ganha 1 template (5º do `HH.1`) — justificado: a alternativa é `width="$(lw)"` no template ∃, & substituição `$(` em atributo NUMÉRICO ⊥ é uso comprovado no repo (só nome/campo/texto) ∴ template novo = caminho conhecido ?
- 25ª rodada 2026-08-17 ↓ (1 pedido do user: header um pouco mais largo, itens internos PARADOS)
- header 1010→1030 ∴ gap p/ `EXPERIENCE` 40→20 & folga interna à direita 18→38. Colunas, templates & `EXPERIENCE` ⊥ mudam
- user pediu p/ esticar "p/ o lado esquerdo" — impossível: a caixa já abre em `left` 0, encostada na borda da aba & alinhada c/ `ATTRIBUTES` (0,110) & a moldura do avatar (0,405) ∴ largura extra só pode sair pela DIREITA. Escolha de 20 (das 3 que ofereci) = user 2026-08-17
- 26ª rodada 2026-08-17 ↓ (1 pedido do user: título de caixa colado no topo)
- ∀ título de seção `top` 0 (1 no `ABILITIES`) → 4 em 8 arquivos: 45 títulos + os vizinhos da MESMA faixa (combo `cmbHealthLevels` das 2 caixas HEALTH & os cabeçalhos `Page`/`Cost` de `Merit`/`Flaw`) ∴ a faixa inteira desce junto, ⊥ título desalinhado do que está ao lado
- 4px = o que cabe SEM mexer no conteúdo: título ocupa 0..20 & 1ª linha abre em 25 ∴ 4 deixa 1px de sobra. Mais que isso pediria empurrar linha por linha & crescer 51 caixas — trabalho de outra ordem, ⊥ "espaçamento bem pequeno"
- aba Progress (`HH.9`) ⊥ tocada — pedido explícito do user. `EXPERIENCE LOG` de lá segue em `top` 0 ∴ é a exceção declarada de §V77
- caixas c/ folga própria ⊥ mudam: `VIRTUES` 8 (18ª rodada) · `HUMANITY` 15 · Settings & créditos 10 — já passam de 4, ⊥ estavam coladas
- 27ª rodada 2026-08-18 ↓ (1 pedido do user: 1 lista por caixa de númina)
- as 2 tabelas dividiam 1 lista ÚNICA de 43 itens (§T55) ∴ `HEDGE MAGIC PATHS` oferecia `Telepathy` & `PSYCHIC PHENOMENA` oferecia `Alchemy`. User pede lista PRÓPRIA por caixa ∴ a parte "1 lista ÚNICA" de §T55 REVOGADA (1 lista → 2)
- corte = §R.14 já pronto, ⊥ pede leitura nova do PDF: caixa de CIMA (`HEDGE MAGIC PATHS` = `CAMINHOS DE MAGIA ESTÁTICA`) = os 21 Paths do cap.1 · caixa de BAIXO (`PSYCHIC PHENOMENA` = `FENÔMENOS PSÍQUICOS`) = os 22 Phenomena do cap.2. União = 43 ≡ hoje ∴ ⊥ item novo, ⊥ item perdido & `.lang` + mapa `PT` + `DESC` ⊥ mudam
- ordem pedida (magia estática em cima, psíquicos embaixo) JÁ é a ordem @ tela desde §T57 ∴ ⊥ move caixa nenhuma; a rodada só troca o `items`/`values` de cada picker
- `Shadows` (cap.1, magia estática) ≠ `Shadow` (cap.2, psíquico) — 2 núminas distintas, 1 em cada caixa. Trocar as 2 = item sem `DESC` ∴ o gate pega (§V32)
- 1 lista por caixa ! 1 template por caixa: `NuminaPicker` → `HedgePicker` (21) + `PsychicPicker` (22), mesmos x de radio/entrada/bolinha ∴ coluna segue alinhada (§V26) & `items` segue inline no XML (§V18), ⊥ Lua populando @ runtime. `NuminaFree` (linhas 9 & 10) ⊥ muda — texto livre ⊥ tem lista
- ficha salva c/ númina na caixa ERRADA (ex: `numina_3` = `Telepathy`) segue no NDB, mas o combo abre VAZIO — valor ∉ `values` (§V12). ⊥ migração & ⊥ Lua limpando campo: o bloco `DESCRIPTION` lê `DESC[valor]` ∴ o dado segue visível & o user reescolhe na caixa certa. ≡ precedente `transportation`/`other` (user: ⊥ ∃ ficha salva que importe)

- 27ª rodada (2026-08-18) — aba `Storyteller` + ledger de XP derivado. ↓ ∀ decisão desta rodada
- aba `Storyteller` = 12ª aba, SÓ p/ mestre da mesa. Gate = `Firecast.getMesaDe(sheet).meuJogador.isMestre` (§R29). ⊥ mesa (biblioteca local, ficha aberta fora de mesa) → aba ESCONDIDA. DECIDIDA pelo user 2026-08-18 ∴ baseline só é salvável c/ a ficha aberta DENTRO da mesa
- "salvo de forma ⊥ visível ao jogador" = ⊥ renderiza widget no cliente dele. O NDB segue chegando ao cliente ∴ ⊥ é segredo criptográfico — blindar contra jogador que lê o dado por fora ∉ escopo
- `Salvar Personagem Inicial` = 1 SHOT. `Dialogs.confirmOkCancel` antes (§R30, "ação sem volta"); gravado ⊥ regravável & ⊥ ∃ caminho na ficha que apague
- log de XP = DERIVADO (baseline × ficha atual, recalculado a ∀ mudança), ⊥ diário append-only. DECIDIDA pelo user 2026-08-18 ∴ desmarcar bolinha some c/ a linha & clique errado ⊥ fica no log p/ sempre. Preço aceito: log ⊥ tem ordem cronológica (ordena por categoria & slot)
- custo de Habilidade = nível atual ×2 (1º ponto fixo 3). Pedido escrito dizia ×3 mas o exemplo do próprio user (`Firearms 1→2 = 2`) & o canon V20 dizem ×2 — user CONFIRMOU ×2 2026-08-18
- Affinity Path = SEMPRE `numina_1` (slot FIXO), ⊥ "primeira linha preenchida". DECIDIDA pelo user 2026-08-18. Destaque = `*` + negrito na linha 1 mesmo vazia + nota curta depois de `TRUE FAITH`
- `Mostrar Númina` `Mostrar Disciplinas` `Mostrar Magika` escondem a aba p/ TODOS (mestre incluso), ⊥ só p/ jogador — 1 flag, 0 ramo por papel; mestre que quer ver liga o flag. JULGAMENTO meu, reversível
- default dos flags: `stShowNumina` LIGADO · `stShowDisciplines` & `stShowMagika` DESLIGADOS ∴ ficha salva antes desta rodada (campo nil) ⊥ perde a aba Numina que já via
- abas `Disciplines` & `Magika` nascem VAZIAS (moldura + título) a pedido do user ∴ custo de Disciplina & Trilha & Esfera & Arete fica DECLARADO & DORMENTE (§I9) — ⊥ ∃ campo p/ diffar. SUPERSEDE em parte o §C "Mage-only ⊥ portar": a JANELA de Magika entra, o conteúdo (Spheres, Rotes, Focus, Arete) ⊥
- antecedente c/ `stBackgroundsXP` desligado → linha ENTRA no log c/ custo 0 (o aumento existiu, XP ⊥ foi gasto) ∴ mestre vê o que mudou. JULGAMENTO meu
- `xpLog` (textEditor livre da aba Progress) SAI — o bloco vira tabela DERIVADA de 4 colunas. Campo vira ÓRFÃO declarado (§I3) ∴ texto que o jogador já digitou ⊥ ressuscita em caixa errada
- soma automática de `spentXP` a partir do ledger ⊥ pedida ∴ campo segue manual & c/ 1 dono (§V1). Fora de escopo desta rodada

- 28ª rodada (2026-08-18) — `*` da linha 1 sai & visibilidade de aba passa a ser fail-CLOSED. ↓ ∀ decisão desta rodada
- destaque do Affinity Path = só NEGRITO. Label `*` da linha 1 SAI a pedido do user; o `*` do TEXTO da nota fica (é nota de rodapé, ⊥ marca de linha) ∴ `["*"]` do mapa PT & `wod.*` do `.lang` saem junto (chave morta)
- estado AUTORADO de aba = default do flag/gate, ⊥ "visível até o Lua esconder". REVOGA a decisão da 27ª rodada ("ficha cujo Lua ⊥ rodou mostra demais, ⊥ de menos") — user viu ficha nova c/ os 3 checkbox desligados & as abas à vista (§B26). Fail-OPEN ⊥ vale p/ aba: `Disciplines` `Magika` `Storyteller` nascem `visible="false"` no XML & `Numina` nasce visível (default ON, §V89)
- gatilho de visibilidade mora no form RAIZ, ⊥ em `HH.10` — aba escondida ⊥ pode ser dona do gatilho que a esconde (dependência circular de ciclo de vida) ∴ `onNodeReady` + `dataLink` dos 3 flags migram p/ `HuntersHunted.lfm`
- esconder aba = esconder ABA **&** CONTEÚDO dela ∴ mesmo que o host ⊥ tire o botão da aba (§R31 segue `?`), o jogador ⊥ vê o que está dentro
- aba ativa proibida → ficha PULA p/ `Main` a ∀ recálculo (load, troca de flag, gate). Pedido do user 2026-08-18. ⊥ ∃ evento de troca de aba no SDK (`gui.TabControl` só tem `tabIndex`, §R33) ∴ ⊥ dá p/ barrar o clique no botão — o pulo cobre load & mudança de flag, ⊥ o clique em botão que sobreviva

- 29ª rodada (2026-08-18) — visibilidade de aba vira DERIVADA, ⊥ decisão tomada 1 vez. ↓ ∀ decisão desta rodada
- papel na mesa muda SEM avisar a ficha: `jogador`/`mesa` ⊥ têm evento nenhum no SDK, só getters (§R34) ∴ a ficha ⊥ pode esperar ser avisada — ! reperguntar a ∀ exibição (`onShow`, §V96)
- §V93 reescrito p/ o que o SDK deixa fazer (§R33): "aba ATIVA ∈ proibidas" ⊥ é legível ∴ o gatilho vira a TRANSIÇÃO visível→escondida. Custo DECLARADO por mim, ⊥ pedido pelo user: mestre desligando 1 flag manda p/ `Main` também quem estava em aba permitida

- 30ª rodada (2026-08-18) — XP vira REGRA, ⊥ papel. Pedido do user. ↓ ∀ decisão desta rodada
- ficha BARRA compra sem saldo & só devolve XP de ponto que está no log. REVOGA "⊥ derivados calculados / ficha = papel" p/ os 3 números de XP (a 27ª já tinha revogado p/ o Total)
- jogador digita SÓ o Current. Único número GRAVADO = `xpTotal` (novo, só-Lua): Spent = Σ log, Current = `xpTotal` − Spent ∴ subir ponto desconta & tirar ponto devolve, sem 1 linha de desconto — é subtração, ⊥ evento
- `experience` & `spentXP` viram ÓRFÃOS: lidos 1× p/ semear `xpTotal` (= `experience` + Σ log no 1º render) & nunca mais ∴ o saldo que o jogador via ⊥ muda na virada
- guarda DORME enquanto ⊥ ∃ baseline ∴ criação de personagem ⊥ é barrada por saldo — a regra só vale depois que o mestre congela a ficha
- ponto do personagem INICIAL ⊥ pode ser vendido (§V103): o dot volta sozinho. Só ponto comprado (∈ log) sai & devolve
- 2 clientes editando a MESMA ficha ao mesmo tempo ⊥ tratado — mas ⊥ ∃ cache p/ divergir: tudo deriva do NDB a ∀ render ∴ o pior caso é 1 render velho, ⊥ 1 número errado gravado

## §I INTERFACES

- I1 dataType: `Ambesek.HuntersHunted.20th`, `formType="sheetTemplate"`, title `Hunters Hunted - Mortal`, `theme="dark"`
- I2 arquivos: `Plugins/Sheets/World of Darkness 20th/HuntersHunted/` → `HuntersHunted.lfm` (raiz) + `HH.1.lfm`…`HH.12.lfm` (`HH.8` = aba Inventory, `HH.9` = aba Progress, `HH.10` = aba Storyteller, `HH.11` = aba Disciplines, `HH.12` = aba Magika — os 3 últimos NOVOS na 27ª rodada) + `images/` = `prime_on.png` `prime_off.png` (XML, tema base) + arte de paleta (15ª rodada): `prime_on_gold.png` `prime_off_gold.png` (Vitoriano & Clássico) · `prime_on_crimson.png` `prime_off_slate.png` (Atual) · `prime_on_silver.png` `prime_off_silver.png` (Idade das Trevas — prata do outline, 19ª rodada; par `blood`/`iron` saiu) · `paper_present.png` `paper_victorian.png` `paper_dark_ages.png` `paper_classical.png`
- I1b ordem das abas (12, 27ª rodada; eram 9): Main · Traits · Numina (era `Powers` até a 22ª rodada) · Disciplines · Magika · Combat · Inventory · Background · Progress · Notes · Settings · Storyteller. As 3 NOVAS entram assim: `Disciplines` & `Magika` colam em `Numina` (as 3 são poder ∴ ficam juntas) & `Storyteller` fecha a fileira depois de `Settings`. `Numina`/`Disciplines`/`Magika` escondem por flag (§I8, §V89) & `Storyteller` por papel (§V79) ∴ jogador comum abre 8 abas
- I3 campos NDB (contrato de dados — ⊥ renomear pós-release):
  - header: `name` `player` `chronicle` `nature` `demeanor` `concept` `motivation` `occupation` `residence`
  - attrs (dot1 fixo, campos `_2`…`_5`): `strength` `dexterity` `stamina` `charisma` `manipulation` `perception` `inteligence` `wits`
  - attr EXCEÇÃO: `appearance` = `appearance_1`…`_5`, dot1 é `imageCheckBox` (⊥ `<image>` fixa) ∴ desligável. `appearance_1` = campo NOVO 2026-08-17 (§C)
  - abilities (`_1`…`_5`) talents: `alertness` `athletics` `awareness` `brawl` `empathy` `expression` `intimidation` `leadership` `streetwise` `subterfuge`
  - skills: `animalKen` `crafts` `etiquette` `firearms` `larceny` `melee` `performance` `ride` `stealth` `survival`
  - knowledges: `academics` `enigmas` `finance` `investigation` `law` `medicine` `occult` `politics` `science` `technology`
  - perícias de ÉPOCA (campos NOVOS 21ª rodada, §V74): `legerdemain` `archery` `commerce` `drive` `computer` `hearthWisdom` `philosophy` `religion` `ritual` `seneschal` `theology` (+`_1`…`_5` cada). ⊥ têm dono no XML — a bolinha do slot RE-LIGA neles em runtime (§V76, §R28) ∴ §V5 (conta bolinha no XML) ⊥ os vê & §V1 segue medindo o estático
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
  - história (aba Background, `HH.4`): `desc_sexo` `desc_altura` `desc_olhos` `desc_idade` `desc_peso` `desc_cabelo` `desc_idadeAparente` `desc_etinicidade` + `desc_nacionalidade` (novo) · `aparencia` (RÓTULO = `Languages`) · `idiomas` (RÓTULO = `Goals`) · `moralFlaws` `fears` (novos) · `background`. `personalidade` & `natureza` SAÍRAM na 9ª rodada ∴ órfãos ↓
  - progress (aba Progress, `HH.9`): `spentXP`. `experience` = ESPELHO do da Main (§V36). `totalXP` ⊥ tem `field` ∴ ∉ contrato, ⊥ salvo (§C, ≡ §V29). `xpLog` SAIU na 27ª rodada (bloco virou ledger derivado, §I10) ∴ ÓRFÃO declarado ↓; as 4 colunas do ledger ⊥ têm `field` (≡ `totalXP`, §V84)
  - ESPELHOS declarados (>1 widget de entrada no MESMO `field`, §V36 — ⊥ é violação de §V1): `health_1`…`_10` em `HH.1`+`HH.3` · `willpower_c1`…`_c10` em `HH.1`+`HH.3` (11ª rodada) · `experience` em `HH.1`+`HH.9`. Virtudes SAÍRAM daqui na 12ª rodada — viraram só-leitura ↓
  - SÓ-LEITURA em `HH.3` (espelho ⊥ editável, ⊥ conta como dono): `alertness` `athletics` `awareness` `brawl` `melee` `stealth` (+`_1`…`_5`) + 1 SLOT `ro_ranged_*` = `Firearms` (`firearms`) | `Archery` (`archery`) conforme a lista da época (21ª rodada — `Archery` virou campo próprio ∴ o slot voltou; `Melee` ∈ ∀ época SÓ-LEITURA em `HH.3` (espelho ⊥ editável, ⊥ conta como dono): `alertness` `athletics` `awareness` `brawl` `firearms` `melee` `stealth` (+`_1`…`_5`) — os 2 SLOTS da 19ª rodada SAÍRAM na 20ª: `Firearms` mora sempre em `melee`)|`Archery` mora sempre em `firearms` & `Melee` sempre em `melee` (§V74) ∴ ligação estática de volta · `strength` `dexterity` `stamina` `perception` (+`_2`…`_5`) · `willpower_1`…`_10` (bolinhas da caixa WILLPOWER nova — 11ª rodada; os `_c1`…`_c10` do MESMO bloco são espelho editável ↑) · `conscience` `selfControl` `courage` (+`_2`…`_5`) — 12ª rodada, virtudes deixaram de ser editáveis aqui
  - ÓRFÃOS declarados (∈ NDB de ficha salva, ⊥ widget em nenhum `.lfm`): `transportation` `other` (3ª rodada) · `bruised` `hurt` `injured` `wounded` `mauled` `crippled` `incapacitated` (4ª rodada — vitalidade virou posicional, §C) · `personalidade` `natureza` (9ª rodada — caixas Concept & Nature removidas a pedido) · `xpLog` (27ª rodada — bloco de texto livre virou ledger derivado, §I10 §V91). ⊥ reusar estes nomes p/ campo novo ∴ ficha velha ⊥ ressuscita dado em caixa errada
  - settings (aba Settings, `HH.6`): `language` · `game` (novo 2026-08-17, 5 jogos + vazio) · `sheetTheme` (11ª rodada; 16ª rodada = 4 valores `Modern`\|`Victorian Era`\|`Dark Ages`\|`Classical Era`, ∀ um c/ paleta, default `Modern`, PINTA — §I5 §I6)
  - LUA-OWNED declarados (∈ NDB, ⊥ widget POR DESIGN — escritos só por Lua ∴ ⊥ órfãos: dado VIVO): `baseline` (§I8c). `<dataLink>` pode observar (exceção de §V8, §B25)
  - storyteller (aba Storyteller, `HH.10`, 27ª rodada): `baseline` = XML do snapshot do personagem inicial (§R32), string, vazio ⟺ ⊥ salvo · `stBackgroundsXP` `stShowNumina` `stShowDisciplines` `stShowMagika` = bool (§I8, defaults OFF\|ON\|OFF\|OFF por §V89). ∀ um ⊥ tem widget em aba de jogador ∴ só o mestre edita (§V79)
  - `experience` · `avatar`
- I4 build: `rdk -l` @ raiz do plugin → compile + lint fonte → `output/World of Darkness 20th.rpk`. `rdk -c` = só compile. `rdk p` = PREPARE, ⊥ build.
- I5 `THEMES` — tabela Lua @ `HH.6.lfm`, chave = `values` do `cboSheetTheme` (16ª rodada: ∀ valor tem paleta, ⊥ ∃ mais entrada ausente). ∀ época: `{ form, fill = {<cor autorada> → <cor nova>}, stroke = {…}, font = {…}, fontFamily, dotOn, dotOff, paper }` — 8 chaves, todas obrigatórias (§V63). `corner` REMOVIDO (§V66) & `strokeSize` virou constante `THEME_STROKE` (§V67)
- I6 `applyTheme(v, from)` — @ `HH.6.lfm`, MESMA forma de `applyLanguage`: `rootOf(from)` + `collect` da raiz, snapshot 1× por handle antes da 1ª pintura, depois pinta `THEMES[v]` | restaura snapshot. Chamado pelo `<dataLink field="sheetTheme">` ∴ roda no load & em ∀ troca
- I7 `ABILITY_FIELD` & `ERA_ABILITIES` — tabelas Lua @ `HuntersHunted.lfm` (form RAIZ, ≡ `HEALTH_MARKS`/§V41). `ABILITY_FIELD[nome]` = campo do traço (41 nomes, bijeção §V74). `ERA_ABILITIES[t][coluna]` = os 10 nomes daquela coluna naquela época, na ordem de leitura; `coluna` ∈ `talents` `skills` `knowledges`; chave `t` = `values` do `cboSheetTheme`. `THEME_LABELS` (19ª/20ª rodada) & `THEME_COMBAT` (19ª) ⊥ ∃ mais

- I8 aba `Storyteller` (`HH.10.lfm`, 27ª rodada) — caixa `STORYTELLER SETTINGS`: linha `Save Initial Character` + `<button>` `Save` & 4 `checkBox` — `Can Buy Backgrounds With Experience` (`stBackgroundsXP`, default OFF) · `Show Numina` (`stShowNumina`, default ON) · `Show Disciplines` (`stShowDisciplines`, default OFF) · `Show Magika` (`stShowMagika`, default OFF)
  - I8a `isStoryteller()` @ form RAIZ = `Firecast.getMesaDe(sheet)` ⊥ nil & `.meuJogador` ⊥ nil & `.isMestre == true`; ∀ outro caminho → false (fail-closed, §V80). ⊥ mesa → false ∴ ficha fora de mesa ⊥ mostra a aba (§C)
  - I8b `applyTabVisibility(from)` @ form RAIZ (≡ `HEALTH_LEVELS`/§V41): `Storyteller`.visible = `isStoryteller()`; `Numina`/`Disciplines`/`Magika`.visible = flag de §I8. REESCRITO na 28ª rodada (§B26): gatilho mora no form RAIZ (`onNodeReady` + `dataLink` dos 3 flags) ⊥ em `HH.10` ∴ ⊥ depende do ciclo de vida de aba nenhuma; esconde ABA **&** CONTEÚDO da aba (§V92); depois de recalcular, aba ativa proibida → volta p/ `Main` (§V93)
  - I8c `Save` → `Dialogs.confirmOkCancel` (aviso de ação SEM VOLTA, §R30) → OK → `sheet.baseline = ndb.exportXML(sheet)` (§R32). `baseline` ⊥ vazio ⟺ personagem inicial salvo ∴ ⊥ precisa de 2º campo de estado
- I9 tabela de custo de XP (custo p/ ir do nível `n` → `n+1`; `n` = nível ATUAL, §V85). ∀ custo em pontos de Experiência
  - Atributo `n×4` · Habilidade `n×2` (`n=0` → 3) · Virtude `n×2` · Humanidade `n×2` · Força de Vontade `n×2` (`n` = bolinhas `willpower_1`…`_10`, ⊥ `willpower_c*`)
  - Antecedente `n×3` (`n=0` → 3) SÓ c/ `stBackgroundsXP` ligado; flag desligada → linha entra c/ custo `0` (§C)
  - Númina `n×7` (`n=0` → 7); 1º ponto de TIPO ∉ baseline → 21 (§V87). Númina de afinidade (`numina_1`) `n×6`, `n=0` segue 7 (| 21 se tipo novo)
  - tipos de númina (3): `hedge` = `numina_1`…`_10` (Magia Estática) · `psychic` = `psychic_1`…`_10` (Fenômenos Psíquicos) · `faith` = `faith` (Fé Verdadeira)
  - DORMENTES — regra declarada, ⊥ ∃ campo p/ diffar enquanto `Disciplines`/`Magika` estiverem vazias (§C): Disciplina de clã `n×5` (`n=0` → 10) · Disciplina fora do clã `n×7` (`n=0` → 10) · Trilha (Necromancy Path \| Thaumaturgy Path) `n×4` (`n=0` → 7) · Esfera de afinidade `n×7` (`n=0` → 10) · Esfera sem afinidade `n×8` (`n=0` → 10) · Arete `n×8`
- I10 ledger de XP (aba Progress, `HH.9`, 27ª rodada) — bloco `EXPERIENCE LOG` vira 4 colunas SÓ-LEITURA: `Type` \| `Trait` \| `Level` \| `Cost`
  - fonte = diff(`baseline`, ficha atual), recalculado a ∀ render (§V83). ⊥ tem `field` ∴ ∉ contrato de dados & ⊥ salvo (≡ §V29, ≡ `totalXP`)
  - 1 linha por PONTO: baseline 2 → atual 4 = 2 linhas (nível 3 & nível 4), custo de CADA passo por §I9. `Level` = nível ALCANÇADO
  - ordem = categoria na ordem de §I9, depois índice do campo/slot (⊥ ∃ ordem cronológica, §C)
  - `Type` & `Trait` renderizados por Lua ∴ passam por `tryTranslate` (≡ §V70): `Attribute`=`Atributo` · `Ability`=`Habilidade` · `Virtue`=`Virtude` · `Humanity`=`Humanidade` · `Willpower`=`Força de Vontade` · `Background`=`Antecedente` · `Numina`=`Númina` (+ dormentes `Discipline` `Sphere` `Arete`)
  - `baseline` vazio → bloco mostra texto de estado EXPLÍCITO (`initial character not saved yet`), ⊥ tabela em branco (§V33)

- I11 os 3 números de XP (30ª rodada) — 1 GRAVADO, 2 derivados. Valem na aba Progress (`HH.9`) & no espelho da Main (`HH.1`)
  - `xpTotal` = campo só-Lua (≡ `baseline`, §I3): XP total ganho. Único número salvo
  - `Total` = `xpTotal`, só-leitura · `Spent` = Σ `cost` do log, só-leitura · `Current` = `xpTotal` − `Spent`, EDITÁVEL
  - digitar X no `Current` → `xpTotal = X + Spent` (`onUserChange` do `edit`, ⊥ `field`) ∴ o jogador mexe no saldo & o total se ajusta
  - migração 1×: `xpTotal` nil → `xpTotal = (`experience` \| 0) + Σ log ∴ o `Current` renderizado = o que o jogador via antes
- I12 `xpGuard(field)` @ form RAIZ — `onChange` de ∀ dot que custa XP chama. ⊥ escreve XP nenhum (Current é derivado ∴ ⊥ ∃ o que descontar \| devolver)
  - `baseline` vazio → sai (§V101). `base` = `field` sem `_N`; `XP_TRAIT[base]` nil → sai
  - dot LIGOU & `xpTotal` − Σ log < 0 → DESFAZ (dot volta a `false`) ∴ ⊥ compra sem saldo
  - dot DESLIGOU & nível resultante < nível no `baseline` → DESFAZ (dot volta a `true`) ∴ ponto do personagem inicial ⊥ é vendido (§V103)
  - desfazer re-dispara o `onChange` — o 2º passe acha estado legal & para ∴ ⊥ ∃ laço

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
R20|altura em runtime|`gui.Control.props["height"]` tem setter (`setHeight` → `_gui_setHeight`) ∴ Lua muda altura de `layout` em runtime. Precedente em ficha: `self.height = h` no item de equipamento de 5+ fichas do repo|`SDK3/API/rrpgGUI.lua:99,236` · `Plugins/Sheets/Ficha D&D Next/equipamentoItem.lfm:33`
R21|escopo de `findClass`|rdk gera `findClass` como função LOCAL por `.lfm`: `findAllControls()` = `{self}` + `recursiveFindControls(self,…)` ∴ alcança só a aba onde roda. ∴ o tema Escuro/Claro & os color pickers das 5 fichas base pintam SÓ a aba Credits desde 2017 (≡ §B9, outro caminho). Tema novo ! usar `rootOf` (§R10)|`output/rdkObjs/Mage20th/M20.6.lfm.lua:40-98` · `Mage20th/M20.6.lfm:101-135`
R22|props pintáveis em runtime|têm setter: `Shape.color` `strokeColor` `strokeSize` · `TextControl.fontColor` `fontFamily` `fontSize` `fontStyle` · `ImageCheckBox.checkedImage` `uncheckedImage` · `Image.src` `style` · `Form.theme` (enum `default\|light\|dark\|firecast`) ∴ tema inteiro = setter, ⊥ `.lfm` duplicado por variante|`sdk/rrpgGUI.lua:471,631-634,781-783,835-841,1057-1059`
R23|imagem de fundo|`gui.Image.style` ∈ `proportional\|autoFit\|originalSize\|stretch` — ⊥ `tile` ∴ textura = 1 PNG grande esticado por aba. `bringToFront`/`sendToBack`/`zorder` ⊥ ∃ no SDK ∴ ficar ATRÁS do conteúdo = ordem de declaração `?`, ! testar (T153)|`sdk/rrpgGUI.lua:837-841` · grep `bringToFront\|sendToBack` = 0 hits
R24|`?` fontFamily|serifada vem do host (⊥ dá p/ embarcar fonte no `.rpk`). Candidatas Windows: `Georgia` `Book Antiqua` `Palatino Linotype` `Times New Roman`. Comportamento c/ família ausente = `?` ∴ ! testar & fixar a 1ª que ∃|`sdk/rrpgGUI.lua:632`
R25|`?` getter de cor|`Shape:getColor` = `_obj_getProp(handle,"Color")`, nativo ∴ ⊥ sei se devolve o literal autorado (`black`) ou normalizado (`#FF000000`). Decide se o mapa de §I5 casa direto | precisa de `normColor()` ∴ ! testar antes de T155|`sdk/rrpgGUI.lua:1050-1059`
R26|caminho de imagem @ runtime|rdk resolve `src=`/`checkedImage=`/`uncheckedImage=` relativo p/ ABSOLUTO do plugin @ compile: `images/prime_on.png` → `setImageChecked("/HuntersHunted/images/prime_on.png")` ∴ gravação em runtime ! usar a forma absoluta, a relativa ⊥ resolve|`output/rdkObjs/HuntersHunted/HH.1.lfm.lua:410,420-421`
R27|`?` fonte herdada|`getFontFamily` = `_obj_getProp(handle,"Font.Family")` — ⊥ sei o que devolve p/ controle que nunca autorou fonte (`""` \| nil \| família efetiva) nem se gravar de volta RE-acopla ao tema. CERTO: ∀ setter de fonte passa por `_gui_prepareForFont*Change` ∴ 1ª gravação DESACOPLA p/ sempre, mesmo gravando o valor lido (§B21)|`sdk/rrpgGUI.lua:617-621`
R28|`field` @ runtime|`gui.ImageCheckBox.props["field"]` tem SETTER: `setField(v)` = `_obj_setProp(self.handle, "FieldName", v)` (`SDK3/API/rrpgGUI.lua:765`) ∴ re-ligar bolinha a outro campo em runtime é API suportada, ⊥ gambiarra. `?` se o controle recarrega `checked` sozinho ao trocar de `FieldName` — assumo que ⊥ & recarrego à mão (§V76)

R29|mestre da mesa|`Firecast.getMesaDe(sheet)` → mesa (global dentro de `.lfm` de ficha, precedente `Sheets/Anime e5 Sheet/FichaAnimeE5/primeiraPagina.lfm:45`); `mesa.meuJogador.isMestre` = bool, precedente de uso `ChatMods/AfkBot/afkbot.lua:182`. Fora de mesa devolve nil. `?` `meuJogador` já populado no `onNodeReady` — ! testar no Firecast|`SDK3/API/rrpg.lua:185` `SDK3/API/rrpgWrappers.lua:398` `:214`
R30|confirmação modal|`Dialogs.confirmOkCancel(msg, callback)` — callback recebe o OK; precedente em ficha DO REPO (`Tem certeza que quer apagar?`)|`Sheets/Ao cair da noite/Ficha ACN/ACN.1.Other.lfm:48`
R31|`?` esconder aba|`gui.TabItem` herda `gui.Control` ∴ tem prop `visible`. ⊥ confirmado que o host TIRA o botão da aba (vs só esvaziar o conteúdo) ∴ `?` até teste no Firecast — §T.239. Precedente ESTÁTICO: `Plugins/Sheets/Avatar Legends/Avatar Legends.lfm` publica ~30 `<tab visible="false">`. 28ª rodada: user relatou aba à vista c/ flag desligada — sintoma cabe em 2 causas (renderer ⊥ rodou \| `visible` ⊥ esconde) ∴ segue `?`, §T.260 separa as duas|`SDK3/API/rrpgGUI.lua:1017` `:225`
R32|snapshot do NDB|`ndb.exportXML(nodeObj)` → string XML do nó inteiro; volta por `ndb.newMemNodeDatabase` + `ndb.importXML` ∴ baseline = 1 campo string lido em nó de MEMÓRIA, ⊥ 1 campo por traço & ⊥ toca a ficha. `baseline` vazio na hora do export ∴ ⊥ aninha snapshot dentro de snapshot (§V81 mantém isso verdade)|`SDK3/API/ndb.lua:552` `:390` `:568`

R33|`?` troca de aba|`gui.TabControl` expõe SÓ `tabIndex` (get/set) & `gui.TabItem:activate()`; `eves` ⊥ tem `onChange`/`onTabIndexChange` — `Control.eves` só oferece mouse/teclado/foco ∴ ⊥ dá p/ interceptar o clique no botão de aba. Sobra recalcular & PULAR p/ `Main` (§V93) + esconder o conteúdo (§V92)|`SDK3/API/rrpgGUI.lua:1010` `:1025` `:268`

R34|exibição de form|`gui.Form.eves["onShow"]` existe (par de `onHide`) ∴ dá p/ recalcular a ∀ vez que a ficha aparece, ⊥ só no `onNodeReady` (1×/nó). Precedente: 15 `.lfm` do repo, incl. ficha (`Sheets/Ficha de Reinos d20/FichaReinosD20/DockNPCs.lfm:73`). `jogador` & `mesa` ⊥ expõem evento nenhum em `rrpgWrappers` — só getters ∴ `onShow` é o gancho que ∃|`SDK3/API/rrpgGUI.lua:480` `SDK3/API/rrpgWrappers.lua:370` `:444`

R35|`?` `onShow` em aba|`gui.Form.eves["onShow"]` ∃ (§R34) mas ⊥ ∃ precedente no repo de form IMPORTADO em `<tab>` usando `onShow` — os 15 usos são popup, dock & form raiz ∴ ⊥ confirmado que TROCAR DE ABA dispara o `onShow` do form de dentro. `?` até §T269. Se ⊥ disparar, sobra: (a) `onChange` nos dots dos templates chamando o render por referência global \| (b) campo-contador escrito pelo dot & `dataLink` em `HH.9` (custa 1 nome de campo p/ sempre, §V2)|`SDK3/API/rrpgGUI.lua:480`

## §V INVARIANTS

V1: ∀ `field=` de widget de entrada único na árvore do sheetTemplate ∴ ⊥ 2 inputs no mesmo dado. `<dataLink>` ∉ contagem — observa, ⊥ possui (§B.3). `radioButton` do MESMO grupo compartilha `field` POR DESIGN (exclusão mútua) ∴ exceção declarada, ⊥ conta como 2 donos — distinção fica em `fieldValue` (§V.30)
V2: nome de campo ∈ §I.3 ⊥ renomeado após release ∴ ficha salva perde dado
V3: ∀ png em `src=` `checkedImage=` `uncheckedImage=` ! ∃ em `HuntersHunted/images/` (path relativo à pasta do sheet)
V4: dataType `Ambesek.HuntersHunted.20th` ∉ demais plugins do repo
V5: qtd de dots ! = PDF — attrs 5, abilities 5, virtues 5, numina 5 (20 linhas: 10 hedge + 10 psíquicas), backgrounds 5, humanity 10, willpower 10 dots + 10 box, faith 5, health 7 níveis
V6: build = `rdk -l` @ raiz do plugin, exit 0 antes de commit. `rdk p` ⊥ build (§B.1)
V7: build ok ! = exit 0 & mtime|size do `.rpk` mudou — exit 0 sozinho ⊥ prova (§B.1)
V8: ∀ `<dataLink field=X>` → ∃ widget de entrada com `field=X` no mesmo sheet ∴ ⊥ link morto. EXCEÇÃO declarada (27ª rodada): X ∈ LUA-OWNED de §I3 — campo sem widget POR DESIGN (dado escondido do jogador, escrito só por Lua) ∴ link vivo sem dono de widget. Lista FECHADA em §I3, ⊥ escapatória genérica (§B25)
V9: ∀ string visível ! autorada em inglês ∴ tradução one-way EN→[pt] (§B.4)
V10: ∀ string visível ∈ {`label`, `checkBox`, `button`} → ∃ `wod.<txt>` em [pt] & [en]
V11: ⊥ label com padding p/ alinhar coluna — 1 label por coluna ∴ cada um traduzível (§B.5)
V12: `items` de combo = valor ⊥ rótulo ∴ mudar item ! mudar comparação Lua & `defaultValue` no mesmo commit (§R.3)
V13: campo c/ picker = `comboBox` dono do `field`, ⊥ `edit` ao lado ∴ só escolha da lista. Combo sem `field` renderiza mas ⊥ salva (decisão user 2026-08-17)
V14: ∀ lista de picker ⊥ item duplicado
V15: 1º item de ∀ picker = vazio. EXCEÇÃO declarada: `cboSheetTheme` — combo de ESTADO c/ default real (`Modern`), ⊥ existe "tema vazio" ∴ ⊥ precisa ser limpável (11ª rodada)
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
V43: ∀ caixa de marca de vitalidade declara `onClick` (avança 1) & `onMenu` (cura, §V44) ∴ ⊥ caixa que só avança & ⊥ estado alcançável só dando 3 voltas
V44: limpar ⊥ acontece na linha clicada: ∀ operação que zeraria `health_N` → zera a MAIOR linha marcada ∈ 1…`healthLevels` & `health_N` fica como está. ∃ ≥1 marcada sempre que a cura roda (a própria clicada) ∴ ⊥ no-op silencioso
V45: alvo da cura ∈ 1…`healthLevels` ∴ marca em linha escondida (track encolheu) ⊥ é curada & ⊥ engole o clique. Render ⊥ chama cura — normalização de valor velho (§V42) ≠ cura
V46: pós-mutação, linhas 1…`healthLevels` = marcas em gravidade DECRESCENTE (`*` antes de `X` antes de `/`) & ⊥ vazio entre 2 marcas ∴ ⊥ estado exibido fora de ordem
V47: reagrupar preserva a CONTAGEM por tipo (só reposiciona) ∴ ⊥ vira cura nem dano escondido; ordem de gravidade lida de `HEALTH_MARKS` (§V41), ⊥ de lista própria
V48: ∀ caixa de SEÇÃO (`<layout>` c/ `<rectangle>` + `<label>` de título `horzTextAlign="center"`) tem fill `black` ∴ ⊥ caixa translúcida lendo cinza ao lado das irmãs (§B18). ∉ regra: moldura sem título (avatar `DimGray`) & `rectangle` ∈ template (marca de vitalidade `#00000000`, vazado é o efeito)
V49: altura da caixa HEALTH em runtime = `healthLevels`·`HEALTH_ROW_PITCH` + `HEALTH_BOX_PAD` & ≤ altura declarada no XML ∴ Lua só ENCOLHE & §V40 (estático) segue medindo o pior caso. `HEALTH_ROW_PITCH` ! = pitch REAL das linhas no XML (`top` da linha 2 − da linha 1) nas 2 abas ∴ ⊥ deriva Lua × XML (§B12, §B16)
V50: linha `faith` da aba Powers → bloco mostra `DESC['True Faith']` ∀ item do `cboFaith` ∴ trocar de religião ⊥ muda o texto & os 4 itens ∉ §V32 (⊥ têm entrada própria em `DESC`)
V51: ∀ grupo SÓ-LEITURA de `HH.3` — traços de combate · `willpower_1`…`_10` · virtudes `conscience` `selfControl` `courage` (+`_2`…`_5`, 12ª rodada) — ⊥ tem `field` & tem `autoChange="false"`, valor pintado por Lua ∴ ⊥ 2º dono (§V1). Editáveis na aba = SÓ `health_1`…`_10` & `willpower_c1`…`_c10`, os 2 espelhos declarados (§V36)
V52: `sheetTheme` ∈ os 4 `values` do `cboSheetTheme` (16ª rodada; era 5). Valor ∉ os 4 (nil, lixo, `Present Day` de ficha velha) → paleta DEFAULT (`Modern`) ∴ `THEMES[v]` NUNCA resolve nil & ⊥ ficha sem tema | meio-pintada (§V19, §V33)
V53: ∀ literal de `color=` `strokeColor=` `fontColor=` nos 9 `.lfm` → ∃ chave correspondente em CADA paleta de §I5 (15ª rodada: 4 paletas, ⊥ 2 — o check conta 1 mapa POR paleta declarada, ⊥ número fixo) ∴ caixa nova c/ cor nova ⊥ fica preta no meio da época — falha VISÍVEL vira gate vermelho antes de virar bug
V54: ledger grava o valor AUTORADO 1× por prop, ANTES da 1ª pintura daquela prop ∴ ⊥ é reescrito por pintura posterior. RETIRADA na 16ª rodada a outra metade ("`Modern` ⊥ tem paleta, voltar = restaurar"): ⊥ ∃ mais opção sem paleta ∴ `restore()` saiu. O que sobra é o que faz §V62 funcionar
V55: pintura parte da RAIZ (`rootOf`+`collect`), ⊥ de `findClass` ∴ alcança as 9 abas (§R21, §B9)
V56: ornamento ausente (PNG ⊥ ∃ | textura ⊥ pôde ir atrás do conteúdo) → cor & fonte & filete seguem aplicados & a `<image>` fica `visible=false` ∴ ⊥ ficha meio-vitoriana & ⊥ textura por cima do conteúdo
V57: `applyTheme` ⊥ escreve `left` `top` `width` `height` de NADA ∴ §V37 §V40 §V49 seguem medindo o XML estático & tema ⊥ cria sobreposição em runtime
V58: ∀ PNG citado por paleta de §I5 ! ∃ em `HuntersHunted/images/`. §V3 lê `src=` do XML & a paleta aponta em RUNTIME ∴ escapava do check
V59: `name=` de controle é GLOBAL entre os `.lfm` da ficha ∴ ∀ `name` único nos 10 arquivos (⊥ conta `<template name=>` — já checado à parte — nem `<event name=>` nem nome c/ `$(`, que expande por chamada). 2 arquivos c/ o mesmo `name` → `rdk` sai 1 SEM mensagem & APAGA o `.rpk` (§B19)
V60: ∀ caminho de imagem gravado em RUNTIME (`dotOn` `dotOff` `paper` de §I5) = absoluto do plugin `/HuntersHunted/images/…` ∴ ⊥ arte muda. Forma relativa vale só no XML (§B20, §R26). §V58 mede TAMBÉM a forma, ⊥ só a existência do arquivo
V61: `applyTheme` só grava prop c/ destino MAPEADO & c/ valor autorado ⊥ nil (prop que o XML nunca setou ⊥ é pintada — ⊥ teria como voltar). Gravar ⊥ é no-op: setter de fonte desacopla do tema mesmo gravando o valor lido (§B21, §R27). RETIRADA na 16ª rodada a cláusula "`Modern` grava ZERO prop" — ⊥ ∃ mais opção sem paleta
V62: ∀ repintura mapeia do valor AUTORADO (ledger antes do controle), ⊥ do que a época anterior deixou ∴ Vitoriano→Clássico lê a cor ORIGINAL & ⊥ acumula. `restore()` saiu na 16ª rodada; o ledger FICA — é o que garante isto
V63: ∀ paleta de §I5 declara as 8 chaves (`form` `fill` `stroke` `font` `fontFamily` `dotOn` `dotOff` `paper`) ∴ época nova incompleta = gate vermelho, ⊥ ficha meio pintada. 16ª rodada: eram 10 — `corner` saiu (§V66) & `strokeSize` virou constante (§V67)
V64: ∀ PNG em `HuntersHunted/images/` ! referenciado pelo XML (§V3) | por paleta (§I5) ∴ tema removido leva a arte junto & `images/` ⊥ vira depósito de arte morta
V65: ∀ `<image>` c/ `src=` autorado no XML (⊥ `themePaper*`) → leaf ∈ {`prime_on.png`, `prime_off.png`} & `applyTheme` remapeia p/ `dotOn`/`dotOff` da paleta ∴ arte FIXA acompanha a época. §V53 dá essa garantia p/ COR autorada; ARTE autorada ⊥ tinha equivalente (§B22)
V66: `applyTheme` ⊥ escreve `xradius`/`yradius` de NADA ∴ o detalhe de canto (`cornerType="innerLine"` + raio) é do XML & vale igual em ∀ época; as 3 caixas c/ raio próprio (2 & 5) ⊥ são achatadas p/ um raio único. Era `corner = 0` em 3 paletas que MATAVA o detalhe (§C 16ª rodada)
V67: `strokeSize` declarado 1× (`THEME_STROKE`), ⊥ por paleta ∴ "∀ outline igual" é estrutural & ⊥ 4 cópias p/ divergir (≡ §V41 p/ `HEALTH_MARKS`). Valor = o mais largo entre as paletas na hora da mudança (3)
V68: ∀ caixa de SEÇÃO (`<rectangle color="black">`, §V48) compartilha `cornerType` & `xradius` & `yradius` c/ as irmãs ∴ caixa nova c/ canto copiado de arquivo velho = gate vermelho, ⊥ um canto fora de sintonia no meio dos 52. EXCEÇÕES declaradas: moldura do avatar (`DimGray`, raio 5) & caixa de marca (`#00000000`, raio 2). ≡ deriva do §B18, outra propriedade
V69: fim da coluna do meio da Main (`HUMANITY & WILLPOWER`, `top`+`height`) = fim de `BACKGROUNDS` (810) ∴ crescer `VIRTUES` ⊥ desalinha a fileira de baixo. EXCEÇÃO declarada: HEALTH n=10 fecha em 816 (canto aceito na 11ª rodada). §V40 mede SOBREPOSIÇÃO, ⊥ alinhamento ∴ caixa apertada de menos passava verde
V70: ∀ nome ∈ `ERA_ABILITIES` → ∃ `wod.<txt>` em [pt] & [en] & ∈ mapa `PT` de `HH.6` & largura ≤ label do template `Ability` (125px, ~6.5px/char ∴ ≤19 chars) ∴ nome que só existe no Lua ⊥ escapa dos checks que leem o XML (≡ ponto cego de §B11 §B17). Lia `THEME_LABELS` até a 20ª rodada
V71: RETIRADO na 20ª rodada — dizia que os 2 slots da Combat espelham o campo cujo rótulo NA ÉPOCA é a perícia de ataque. C/ nome→campo canônico (§V74) `Firearms`|`Archery` mora sempre em `firearms` & `Melee` sempre em `melee` ∴ o slot virou flexibilidade morta & a Combat volta a ligar estático. O par rótulo↔bolinha que este invariante protegia passa a ser consequência de §V74, ⊥ regra própria
V72: renderer de rótulo roda no load & no `dataLink sheetTheme` & no `dataLink language` ∴ ⊥ ficha aberta c/ rótulo da época errada & ⊥ rótulo que volta ao EN na troca de idioma (§V19, ≡ `renderHealthTrack`)
V73: ABSORVIDO por §V75 na 21ª rodada — dizia que ∀ época mostra rótulos distintos por coluna. C/ lista de NOMES por coluna (§I7) a distinção virou propriedade da própria lista ∴ 1 check só, ⊥ 2 lugares p/ divergir
V74: bijeção nome↔campo: ∀ nome de perícia → EXATAMENTE 1 campo & ∀ campo → EXATAMENTE 1 nome ∴ ponto de 1 traço ⊥ aparece sob outro nome em época nenhuma (§B24). REESCRITO na 21ª rodada — a 20ª pedia só nome→1 campo & deixava 3 nomes dividirem `science`
V75: ∀ época & ∀ coluna: `ERA_ABILITIES` = EXATAMENTE 10 nomes, ∀ um ∈ `ABILITY_FIELD` & distintos ∴ lista ⊥ deixa slot vazio, ⊥ pede campo inexistente & ⊥ repete nome (absorve §V73 p/ o modelo novo)
V76: trocar época ! RE-LIGAR o `field` das 5 bolinhas de ∀ slot & recarregar `checked` do NDB no mesmo passo ∴ ⊥ bolinha marcada c/ estado do campo anterior. Ligação autorada no XML = lista `Victorian Era` ∴ renderer que ⊥ roda deixa a época base coerente, ⊥ ficha meio ligada (§V19)
V77: ∀ título de seção (label `horzTextAlign="center"` em caixa `<rectangle color="black">`) tem `top` ≥ 4 ∴ ⊥ texto encostado no filete de 3px (`THEME_STROKE`). EXCEÇÃO declarada: aba Progress (`HH.9`) — user pediu p/ ⊥ mexer nela na 26ª rodada. ≡ §V68: 45 títulos alinhados de uma vez pedem check, senão a próxima caixa copiada de arquivo velho nasce colada
V78: picker de númina = 1 lista por CAIXA — `HedgePicker` `items`/`values` ≡ os 21 Paths de §R.14 cap.1 & `PsychicPicker` ≡ os 22 Phenomena de §R.14 cap.2 (+ 1º item vazio, §V15) ∴ ∩ = ∅ & ∪ = 43 (∴ §V32 & §V17 seguem cobrindo os mesmos 43). Check ! ler os 2 `<template>` POR NOME: os 2 combos se chamam `cbo$(field)` ∴ coletor por nome de combo ⊥ distingue caixa (§V20)

V79: aba `Storyteller` visível ⟺ `isStoryteller()` (§I8a) ∴ jogador & espectador ⊥ a veem & ficha fora de mesa ⊥ a abre (decisão user 2026-08-18)
V80: gate de §V79 FAIL-CLOSED — mesa nil | `meuJogador` nil | prop nil | erro → aba ESCONDIDA ∴ falha ⊥ vaza a aba (§V19, §V33). Roda no load & em ∀ gatilho que possa mudar o papel (≡ §V72)
V81: `baseline` = 1 SHOT — gravado só se `baseline` vazio & só depois do OK de `Dialogs.confirmOkCancel` ∴ 2º clique ⊥ sobrescreve, ⊥ ∃ caminho na ficha que apague & snapshot ⊥ contém outro snapshot (§R32)
V82: `baseline` ⊥ vazio → botão `Save` DESABILITADO & estado explícito ao lado ∴ ⊥ botão que parece funcionar e ⊥ faz nada (§V33)
V83: ledger = f(`baseline`, ficha) PURO — recalculado do zero a ∀ render, ⊥ acumula & ⊥ guarda estado próprio ∴ 2 renders seguidos = mesmo texto (idempotente, ≡ §V22) & desmarcar bolinha REMOVE a linha
V84: as 4 colunas do ledger ⊥ têm `field` ∴ ∉ contrato de dados & ⊥ salvas (≡ §V29, ≡ `totalXP`). Fonte única = `baseline` + campos de traço ∴ ⊥ 3º número p/ divergir dos 2 que o produzem
V85: nível de traço lido pela MESMA função no baseline & na ficha: nº de bolinhas marcadas (+1 onde dot1 é fixo — 8 atributos & 3 virtudes), Força de Vontade conta `willpower_1`…`_10` (⊥ `willpower_c*`) ∴ ⊥ 2 leituras p/ divergir (≡ §V41 p/ `HEALTH_MARKS`)
V86: ∀ linha do ledger tira custo de §I9 & ∀ regra ATIVA de §I9 tem exatamente 1 implementação ∴ tabela do spec = tabela do código. Regra DORMENTE ⊥ tem código (⊥ ∃ campo) & ⊥ conta como implementada
V87: 1º ponto de tipo de númina ∉ `baseline` = 21 ∴ 21 é por TIPO NOVO, ⊥ por númina nova — demais núminas daquele tipo seguem §I9 (7 no 1º ponto). "1º" = menor índice de slot daquele tipo entre as compras ∴ determinístico mesmo sem cronologia (§C)
V88: `numina_1` = Affinity Path, slot FIXO ∴ custo ×6 & destaque = NEGRITO na linha 1 SEMPRE, mesmo vazia; nota explicativa FORA da caixa, embaixo de `TRUE FAITH`. 28ª rodada: label `*` na linha SAIU a pedido do user (o `*` do texto da nota FICA) ∴ destaque = só negrito. Trocar a númina da linha ⊥ move a afinidade
V89: `stShowNumina` `stShowDisciplines` `stShowMagika` escondem a aba p/ TODO cliente (mestre incluso, §C) & default = ON | OFF | OFF ∴ ficha velha (campo nil) ⊥ perde a aba Numina que já via
V90: `Disciplines` & `Magika` ⊥ declaram `field` nenhum enquanto vazias ∴ ⊥ queima nome de campo antes do conteúdo existir (§V2 ⊥ perdoa rename depois)
V91: `xpLog` ∈ ÓRFÃOS de §I3 ∴ ⊥ reusado por widget novo — texto livre de ficha velha ⊥ ressuscita numa coluna do ledger (≡ `transportation` `personalidade`)

V92: esconder aba manejada = `tab.visible = false` **&** conteúdo da aba invisível ∴ host que ⊥ tire o botão (§R31 `?`) ainda ⊥ mostra o que está dentro. Vale p/ as 4 (`Numina` `Disciplines` `Magika` `Storyteller`)
V93: aba manejada que passa de VISÍVEL→ESCONDIDA num recálculo → ficha ativa `Main` ∴ ⊥ ∃ jogador preso olhando aba que acabou de ser negada. REESCRITO na 29ª rodada: "aba ATIVA ∈ proibidas" ⊥ é implementável — §R33, `tabIndex` é int sem nome & ⊥ se sabe se conta aba escondida ∴ resolver a ativa erraria & chutaria o jogador da `Numina` a ∀ load. Custo declarado: quem estava em aba permitida também vai p/ `Main` quando o mestre desliga 1 flag
V94: estado autorado no XML de aba manejada = default do flag/gate — `Disciplines` `Magika` `Storyteller` `visible="false"`, `Numina` visível ∴ ficha cujo Lua ⊥ rodou mostra de MENOS, ⊥ de mais (§B26 revoga a decisão contrária da 27ª rodada). ≡ §V80 fail-closed, mas p/ o ESTÁTICO
V95: gatilho de §I8b mora no form RAIZ ∴ aba nenhuma é dona do gatilho que a esconde — `HH.10` está escondida p/ o jogador & ⊥ pode ser quem decide isso (§B26)

V96: visibilidade de aba = DERIVADA, recalculada a ∀ EXIBIÇÃO do form raiz (`onShow`, §R34) & ⊥ só 1× no `onNodeReady` ∴ papel que muda na mesa (jogador↔mestre) se conserta saindo & voltando p/ a ficha. ⊥ ∃ estado de visibilidade que sobreviva a uma re-exibição (§B27)
V97: relatório da aba Progress recalculado a ∀ EXIBIÇÃO da aba (`onShow`) & ⊥ depende de observer de NDB p/ ficar correto ∴ voltar p/ a aba mostra o estado de AGORA. Observer, se disparar, é só atalho p/ atualizar com a aba já aberta — ⊥ é o gatilho de que a corretude depende (§B28)
V98: `rows` VAZIO ⊥ = 4 colunas em branco — o log DIZ que nada foi comprado ainda (≡ §V33, que só cobria baseline ausente) ∴ ficha certa ⊥ parece quebrada
V99: ∀ `imageCheckBox` cujo `field` = dot de traço que custa XP (§I9) chama `xpGuard` no `onChange` ∴ ⊥ ∃ caminho de compra que escape da regra. Dot de ESPELHO só-leitura (§V51) & `willpower_c*` (pontos gastos, ⊥ nível) ⊥ contam
V100: XP ⊥ é jornalizado — `Spent` & `Current` DERIVAM de `xpTotal` & do log a ∀ render ∴ ⊥ ∃ número gravado que possa divergir do log (≡ §V83 §V84). `xpTotal` é o ÚNICO gravado & só muda quando o jogador digita o saldo
V101: `xpGuard` DORME enquanto `baseline` vazio ∴ montar personagem ⊥ é barrado por saldo — a regra nasce quando o mestre congela a ficha (§I8c)
V102: `experience` & `spentXP` ∈ ÓRFÃOS de §I3 depois da migração — lidos 1× p/ semear `xpTotal`, ⊥ reusados por widget nenhum (≡ §V91)
V103: desfazer ponto só vale p/ ponto QUE ESTÁ NO LOG ∴ nível ⊥ desce abaixo do `baseline`; devolução = a própria subtração (§V100), ⊥ ∃ crédito escrito

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
T120|x|`HuntersHunted.lfm` — `healHealthMark()`: acha a maior linha marcada ∈ 1…`healthLevels` & zera SÓ ela. `cycleHealthMark(n)` chama quando o próximo símbolo seria `" "` (⊥ escreve em `n`); `resetHealthMark(n)` vira chamada direta da cura ∴ 1 rotina só|V41,V44,V45
T121|x|`verify-hunters-hunted.ps1` — checks NOVOS §V44 (`cycleHealthMark` ⊥ escreve `HEALTH_MARKS[1]` em `n`; wrap → `healHealthMark`) & §V45 (busca limitada por `healthLevels`; render ⊥ chama cura)|V44,V45,V20
T122|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T123|x|`HuntersHunted.lfm` — `regroupHealthMarks()`: conta marcas por tipo ∈ 1…`healthLevels` & reescreve as linhas do mais grave p/ o menos, vazias no fim. Ordem vem de `HEALTH_MARKS` (⊥ lista nova). Chamada no fim de `cycleHealthMark` & dentro de `renderHealthTrack` (após normalização §V42)|V41,V42,V46,V47
T124|x|`verify-hunters-hunted.ps1` — checks NOVOS §V46 (`regroupHealthMarks` ∃, varre gravidade do topo, chamada por `cycleHealthMark` & `renderHealthTrack`) & §V47 (limitada por `healthLevels`, lê `HEALTH_MARKS`, ⊥ escreve `HEALTH_MARKS[1]` fora do bloco de vazias)|V46,V47,V20
T125|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T126|x|`HH.1.lfm` — caixa `ABILITIES`: `color="#FFFFFF00"` → `color="black"` ∴ para de ler cinza (§B18). `strokeColor`/`strokeSize` ficam|V48
T127|x|`HH.4.lfm` — remover caixas `Concept` (`personalidade`) & `Nature` (`natureza`); `Moral Flaws` & `Fears` descem p/ (0,315) & (205,315). Slot (0,675)+(205,675) vaga; `Prelude` ⊥ muda|I3,V1,V2,V27
T128|x|`verify-hunters-hunted.ps1` — check NOVO §V48 (fill de caixa de seção = black, c/ as 2 exceções); órfãos += `personalidade` `natureza`|V48,I3
T129|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T130|x|`HH.1.lfm` + `HH.3.lfm` — caixa HEALTH ganha `name="dynHealth_box"` \| `name="dynHealth3_box"`; `height` XML segue 300 = MÁXIMO (n=10) ∴ §V40 mede pior caso|V40,V49
T131|x|`HuntersHunted.lfm` — `HEALTH_ROW_PITCH = 27` & `HEALTH_BOX_PAD = 30` + `renderHealthTrack` faz `box.height = n * HEALTH_ROW_PITCH + HEALTH_BOX_PAD` (`box = form[prefix .. "box"]`), guardado p/ box nil|V19,V49,R20
T132|x|`verify-hunters-hunted.ps1` — check NOVO §V49: pitch do XML (linha2.top − linha1.top) = `HEALTH_ROW_PITCH` nas 2 abas; `height` XML = 10·pitch + PAD; render ajusta `height` a partir de `healthLevels`|V49,V20
T133|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T134|x|(1) `HH.1.lfm` — avatar `<rectangle>` + `<image>` 375→405 alto ∴ fecham em y=810 ≡ `BACKGROUNDS`. Caixa `HUMANITY & WILLPOWER` ⊥ tocada|V48
T135|x|(2) `HuntersHunted.lfm` `HEALTH_BOX_PAD` 30→36 + altura declarada da caixa HEALTH 300→306 em `HH.1` & `HH.3` (§V49 = caso n=10)|V49
T136|x|(3) `HH.2.lfm` — `Merit` box 380→410 (0..410) · `Flaw` box (390,380)→(420,410) ∴ 420..830 · `DERANGEMENTS` (810,230)→(840,200); template `Merit` 350→380 c/ coluna do nome 200→230 & 3 labels de cabeçalho acompanham|V16,V25,V26,V37,V40
T137|x|(4) `HH.7.lfm` — `cboFaith` items & values `{'', 'Christianity', 'Judaism', 'Islam', 'Other'}`; renderer da linha `faith` usa chave FIXA `True Faith` ∴ ∀ item abre o mesmo texto|V13,V15,V24,V32,V50
T138|x|(5) `HH.3.lfm` — `ARMOR` altura 300→225 & `armorDescription` 180→110; HEALTH box top 330→350; caixa `WILLPOWER` NOVA (390,470,270,105): bolinhas SÓ-LEITURA `willpower_1`…`_10` + `checkBox` espelho `willpower_c1`…`_c10`; Lua de pintura junto de `renderCombatTraits`|I3,V1,V27,V36,V40,V51
T139|x|(6) `HH.4.lfm` — grid de descritores 125→100; `Languages` 135→110 · `Moral Flaws`/`Fears` 315→290 · `Goals` 495→470 · `Prelude` (410,135,630,715)→(410,110,630,535) ∴ fecha 645 ≡ `Goals`|V27,V37,V40
T140|x|(7) `HH.9.lfm` — `EXPERIENCE` (0,0,420,150)→(0,0,1040,90) c/ os 3 pares label+edit em 3 colunas; `EXPERIENCE LOG` (0,160,1040,480)→(0,100,1040,540)|V16,V25,V27,V37,V40
T141|x|(8) `HH.6.lfm` — caixa de opções p/ o topo & créditos p/ o fim; `Andre (Styllern)` = Developer separado, demais nomes/papéis VERBATIM sob "Based on the RPGmeister sheet plugin, by:"; combo `Theme` (`sheetTheme`, `{'Modern','Victorian Era'}`, default `Modern`) abaixo de `Game`|I3,V9,V10,V16,V27
T142|x|(8+4) `localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — `Theme`=Tema · `Modern`=Moderno · `Victorian Era`=Era Vitoriana · `Developer`=Desenvolvedor · `Based on the RPGmeister sheet plugin, by:` · `Christianity`=Cristianismo · `Judaism`=Judaísmo · `Islam`=Islamismo · `Other`=Outro|V10,V17,V22,V24,V28
T143|x|`verify-hunters-hunted.ps1` — checks NOVOS §V50 (itens do `cboFaith` ∉ §V32 & chave fixa no renderer) & §V51 (bolinhas de willpower ⊥ `field` em `HH.3` & `_c*` = espelho); §I3 espelhos += `willpower_c*`; §V49 altura 306|V49,V50,V51,I3,V20
T144|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T145|x|(1+3) `HH.3.lfm` — `COMBAT` (0,0,650,330)→(0,0,660,320); template `Attack` c/ grade nova (weapon 170, damage 90, resto igual); linhas de ataque 620→630 largas; 8 labels do cabeçalho c/ `horzTextAlign="center"` & `width` da coluna|V11,V16,V25,V26,V37,V40
T146|x|(2) `HH.3.lfm` — `VirtueMirror` só-leitura: bolinhas `roVirtue_$(field)_N` SEM `field` + `autoChange="false"`, pintadas em `renderCombatTraits` (dot1 segue `<image>` fixa); `dataLink` += `conscience_2`…`courage_5`|I3,V1,V36,V51
T147|x|(4) `HH.9.lfm` — `EXPERIENCE` 90→75 & `EXPERIENCE LOG` (0,100,1040,540)→(0,85,1040,555) ∴ fim 640 mantido|V27,V37,V40
T148|x|`verify-hunters-hunted.ps1` — §V51 estendido às virtudes (⊥ `field` em `VirtueMirror`, `autoChange="false"`, Lua pinta); `$mirrors` −`conscience`/`selfControl`/`courage`|V1,V36,V51,V20
T149|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T150|x|(1) `HH.3.lfm` — `ARMOR` `VIRTUES` `dynHealth3_box` top 350→330 & `WILLPOWER` 470→450 ∴ vão p/ `COMBAT` cai de 30 p/ 10; alturas intactas|V37,V40
T151|x|(2+3) `HH.9.lfm` — `EXPERIENCE` 75→95: título top 10, rótulos top 38 centrados, `edit` top 60 centrado SOB o rótulo, 3 colunas @ 15\|352\|689 (336 cada, edit +123); `EXPERIENCE LOG` → (0,105,1040,535)|V16,V25,V26,V27,V37,V40
T152|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T153|~|`?` testar em Firecast: (a) `<image>` declarado 1º no `scrollBox` fica ATRÁS do conteúdo (b) `hitTest="false"` na textura ⊥ come clique (c) getter de `color` devolve `black` ou `#FF000000` (d) qual serifada ∃ no host. (c) BLOQUEIA T155 · (a)(b) BLOQUEIAM T158 · (d) BLOQUEIA T157|R23,R24,R25
T154|x|`HH.6.lfm` — `cboSheetTheme` `items`=`values`=`{'Modern','Victorian Era (Light)','Victorian Era (Dark)'}` & `dataLink defaultValue="Modern"`; corrigir o comentário XML que ainda diz "Not named cbo*" (mentira desde a 11ª rodada). MESMO commit que T155 (§V12)|I3,V12,V52
T155|x|`HH.6.lfm` — `THEMES` (§I5) + `applyTheme` (§I6): snapshot 1× por handle antes da 1ª pintura, `rootOf`+`collect` da raiz, `Modern` = restaurar, valor ∉ lista → `Modern`; `<dataLink field="sheetTheme" onChange>` chama ∴ roda no load & na troca|I5,I6,V52,V54,V55,V57,R21,R22,T153
T156|x|`images/` — 4 bolinhas novas 100×100 ≡ geometria de `prime_on/off.png`: `prime_on_ink.png` `prime_off_ink.png` (Claro) & `prime_on_gold.png` `prime_off_gold.png` (Escuro); paletas de §I5 apontam p/ elas|V3,V58
T157|x|paletas ganham `fontFamily` serifada & `xradius`/`yradius`=0 & `strokeSize`=2 ∴ serifa + canto reto + filete grosso nas 2 vitorianas. Tamanho de caixa ⊥ muda|V57,R24,T153
T158|x|textura — `paper_light.png` `paper_dark.png` + `<image name="themePaper" style="stretch" hitTest="false" visible="false">` como 1º filho do `scrollBox` das 9 abas; paleta liga & troca `src`, `Modern` desliga. T153(a)(b) negativo → PULAR & tema segue sem textura (§V56), ⊥ trava a rodada|V56,V58,R23,T153
T159|.|`?` moldura ornamental do avatar (`HH.1`) — 1 PNG por variante sobre o `<rectangle>` `DimGray`. Só entra se o traço procedural ficar apresentável; senão o avatar segue só com o filete da paleta (§V56)|V56,V58
T160|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — `Victorian Era (Light)`=`Era Vitoriana (Claro)` · `Victorian Era (Dark)`=`Era Vitoriana (Escuro)`; chave `Victorian Era` velha SAI (⊥ mais ∈ `values`)|V10,V17,V22,V24,V28
T161|x|`verify-hunters-hunted.ps1` — checks NOVOS §V52 (3 valores & fallback) §V53 (∀ literal de cor dos 9 `.lfm` ∈ mapa das 2 paletas) §V54 (`Modern` ⊥ tem paleta & restaura snapshot) §V55 (⊥ `findClass` no tema) §V56 (ornamento ausente ⊥ aborta a pintura) §V57 (tema ⊥ escreve geometria) §V58 (PNG de paleta ∈ `images/`)|V52,V53,V54,V55,V56,V57,V58,V20
T162|x|`module.xml` version `1.0` → `1.1`|-
T163|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T164|x|`verify-hunters-hunted.ps1` — check §V59: ∀ `name=` de controle único entre os 10 `.lfm` (⊥ `<template>`, ⊥ `<event>`, ⊥ nome c/ `$(`). Mesmo tipo de morte muda que o check de template já cobre|V59,V20
T165|x|`HH.6.lfm` — `dotOn`/`dotOff`/`paper` das 2 paletas p/ `/HuntersHunted/images/…` (absoluto)|I5,V60,R26
T166|x|`HH.6.lfm` — LEDGER: `paint(c,prop,valor,autorado)` grava só c/ destino mapeado & registra o autorado; `authored(c,prop)` lê do ledger antes do controle; `Modern` = `restore(c)` do registrado. `themeSnap`/`put` SAEM|I6,V61,V62,R27
T167|x|`HH.6.lfm` — `fontFamily` só onde o autorado é string ⊥ vazia; backdrop fora do ledger (re-esconde só se visível) ∴ Modern segue gravando 0|V61,R27
T168|x|`verify-hunters-hunted.ps1` — checks NOVOS §V60 (forma do caminho) §V61 (⊥ gravação direta fora de `paint`, exceto o backdrop; `paint` recusa nil) §V62 (`restore` lê o ledger & `Modern` chama). §V58 resolve o prefixo antes de procurar em disco|V58,V60,V61,V62,V20
T169|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T170|x|`HH.6.lfm` — `cboSheetTheme` `items`=`values` 3→5: `Modern` `Present Day` `Victorian Era` `Dark Ages` `Classical Era`. MESMO commit que T171 (§V12)|I3,V12,V52
T171|x|`HH.6.lfm` `THEMES` — apagar paleta `Victorian Era (Light)`; `(Dark)` → `Victorian Era` (paleta intacta, só a chave); +3 paletas `Present Day` `Dark Ages` `Classical Era` c/ os valores de §C. Caminhos absolutos (§V60) & 10 chaves cada (§V63)|I5,V53,V60,V63
T172|x|`images/` — +7 PNG (`prime_on_crimson` `prime_off_slate` `prime_on_blood` `prime_off_iron` `paper_present` `paper_dark_ages` `paper_classical`), −3 (`prime_on_ink` `prime_off_ink` `paper_light`), renomear `paper_dark.png`→`paper_victorian.png`. Bolinha 100×100 ≡ geometria das ∃|I2,V3,V58,V64
T173|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — +`Present Day`=Atual · `Dark Ages`=Idade das Trevas · `Classical Era`=Era Clássica · `Victorian Era`=Era Vitoriana (volta); −`Victorian Era (Light)` −`Victorian Era (Dark)`|V10,V17,V22,V24,V28
T174|x|`verify-hunters-hunted.ps1` — §V52 3→5 valores; §V53 conta 1 mapa POR paleta declarada (⊥ número fixo) ∴ 5ª época futura ⊥ escapa; checks NOVOS §V63 (10 chaves por paleta) §V64 (⊥ PNG órfão em `images/`)|V52,V53,V63,V64,V20
T175|x|`module.xml` version `1.1` → `1.2`|-
T176|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T177|x|`HH.6.lfm` — `normPath` (leaf, minúsculas) + ramo `image` do `applyTheme`: leaf `prime_on.png`→`t.dotOn` & `prime_off.png`→`t.dotOff`, via `paint` ∴ entra no ledger & `Modern` restaura|I6,V61,V62,V65,R26
T178|x|`verify-hunters-hunted.ps1` — check NOVO §V65: ∀ `//image[@src]` (⊥ `themePaper*`) tem leaf remapeável & `applyTheme` contém o remapeamento|V65,V20
T179|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T180|x|`HH.6.lfm` — `cboSheetTheme` `items`=`values` 5→4 (`Modern` `Victorian Era` `Dark Ages` `Classical Era`) & paleta `Present Day` renomeada p/ `Modern`. MESMO commit (§V12)|I3,V12,V52
T181|x|`HH.6.lfm` — `restore()` & o ramo `t == nil` SAEM (código morto); `local t = THEMES[v] or THEMES["Modern"]` ∴ nunca nil. Ledger FICA (§V62)|I6,V52,V54,V61,V62
T182|x|`HH.6.lfm` — `corner` sai das 4 paletas & `applyTheme` ⊥ escreve `xradius`/`yradius` ∴ detalhe de canto do XML vale em ∀ época|I5,V63,V66
T183|x|`HH.6.lfm` — `strokeSize` sai das paletas → constante `THEME_STROKE = 3` (o mais largo dos 4)|I5,V63,V67
T184|x|`localization.lang` [pt]+[en] & mapa `PT` — `Present Day`/`Atual` SAI. `Modern`=`Moderno` já ∃ ∴ ⊥ chave nova|V10,V17,V22,V24,V28
T185|x|`verify-hunters-hunted.ps1` — §V52 5→4 & fallback = paleta default; §V63 10→8 chaves; §V54/§V61/§V62 conforme texto novo (⊥ mais `restore`); checks NOVOS §V66 (⊥ escreve raio) §V67 (`THEME_STROKE` 1×, ⊥ `strokeSize` em paleta)|V52,V54,V61,V62,V63,V66,V67,V20
T186|x|`module.xml` version `1.2` → `1.3`|-
T187|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T188|x|9 `.lfm` — `cornerType="innerLine"`→`innerRound` (54×) & `xradius`/`yradius` `10`→`14` (53 caixas de seção). Avatar mantém raio 5; marca de vitalidade INTACTA|V66,V68
T189|x|`verify-hunters-hunted.ps1` — check NOVO §V68: caixas de seção compartilham `cornerType` & raio; as 2 exceções ficam de fora|V48,V68,V20
T190|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T191|x|`HH.1.lfm` caixa `VIRTUES` — título `top` 0→8; linhas 25/50/75 → 33/62/91 (pitch 29); caixa 110→126 alto ∴ 510..636|V27,V40,V68
T192|x|`HH.1.lfm` caixa `HUMANITY & WILLPOWER` — top 630→646 & height 180→164 ∴ fecha em 810 ≡ `BACKGROUNDS`. Internos INTACTOS|V40,V69
T193|x|`verify-hunters-hunted.ps1` — check NOVO §V69: fim da caixa `HUMANITY`/`WILLPOWER` = fim de `BACKGROUNDS`; HEALTH fora (exceção n=10). Mutação: mexer 1px no height ! ficar vermelho|V69,V20
T194|x|`HH.6.lfm` paleta `Dark Ages` — `stroke` 3 entradas `#8A7A5C`→`#C0C6CC` & `fill["black"]` `#1A1512`→`#0E0B09`. `DimGray` `#00000000` `font` `dot*` `paper` ⊥ mudam|I5,V53,V63
T195|x|`module.xml` version `1.3` → `1.4`|-
T196|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T197|x|`images/` — `prime_on_silver.png` (cheia) + `prime_off_silver.png` (anel) em `#C0C6CC`, 100×100 ≡ par base; `prime_on_blood.png` & `prime_off_iron.png` SAEM|I2,V3,V58,V64
T198|x|`HH.6.lfm` paleta `Dark Ages` — `dotOn`/`dotOff` p/ os PNG prata, caminho absoluto do plugin|I5,V58,V60,V63
T199|x|`HH.6.lfm` — `cboSheetTheme` items=values `Modern`→`Modern Nights` & `Classical Era`→`Classical Age`; chaves de `THEMES` & `dataLink defaultValue` & fallback no MESMO commit|I3,V12,V52
T200|x|`localization.lang` [pt]+[en] & mapa `PT` — +`Modern Nights`=`Noites Modernas` · `Classical Age`=`Idade Clássica`; −`Modern` −`Classical Era`|V10,V17,V22,V24,V28
T201|x|`localization.lang` [pt]+[en] & mapa `PT` — 9 rótulos NOVOS: `Legerdemain`=`Prestidigitação` · `Archery`=`Arquearia` · `Commerce`=`Comércio` · `Hearth Wisdom`=`Sabedoria Popular` · `Seneschal`=`Senescal` · `Theology`=`Teologia` · `Philosophy`=`Filosofia` · `Ritual`=`Ritual` · `Religion`=`Religião`. `Computer`=`Computador` & `Drive`=`Condução` já ∃|V9,V10,V17,V28,V70
T202|x|`HuntersHunted.lfm` (raiz) — `THEME_LABELS` (§I7) c/ as 3 listas de §C & `Victorian Era` vazio|I7,V70,V73
T203|x|`HH.1.lfm` — label do template `Ability` ganha `name="dynAbil$(field)"`|I7,V59,V72
T204|x|`HH.6.lfm` — `renderAbilityLabels(from)`: `rootOf`+`collect` da raiz, snapshot 1× do EN autorado por label, escreve `tryTranslate(THEME_LABELS[t][campo] \| autorado)`; chamado no load & pelos 2 `dataLink` (`sheetTheme` & `language`)|I6,I7,V21,V22,V31,V70,V72
T205|x|`HH.3.lfm` — 2 linhas de perícia viram slots (`ReadOnlyTrait field="ranged"` & `field="close"` ∴ `ro_ranged_*` `ro_close_*`) & label do `ReadOnlyTrait` ganha `name="dynRo$(field)"` ∴ as 11 linhas da aba entram no renderer|I3,V51,V59,V71
T206|x|`HuntersHunted.lfm` + `HH.3.lfm` — `THEME_COMBAT` (§I7) & `renderCombatTraits` pinta os 2 slots do campo DA ÉPOCA; rótulo dos slots sai do renderer de T204|I7,V51,V71,V72
T207|x|`verify-hunters-hunted.ps1` — checks NOVOS §V70 (tradução & largura das strings de tema) §V71 (par rótulo↔campo nas 2 abas) §V72 (renderer nos 3 gatilhos) §V73 (rótulo único por coluna por época); §V52 c/ `Modern Nights` & `Classical Age`. Mutação antes de aceitar|V52,V70,V71,V72,V73,V20
T208|x|`module.xml` version `1.4` → `1.5`|-
T209|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T210|x|`HuntersHunted.lfm` — `THEME_LABELS` reescrito p/ atribuição canônica (mapas de §C, 20ª rodada): `Modern Nights` 7→2 entradas · `Dark Ages` 8→6 · `Classical Age` 14→6 · `Victorian Era` segue vazio. Conjunto de nomes por época INTACTO|I7,V70,V73,V74
T211|x|`HuntersHunted.lfm` + `HH.3.lfm` — `THEME_COMBAT` SAI (flexibilidade morta); `ReadOnlyTrait field="ranged"`/`"close"` voltam a `field="firearms"`/`"melee"`, `paintAs` volta a `paint` & o `dataLink` de `HH.3` perde `crafts_*` `etiquette_*` `performance_*` `sheetTheme`. Rótulo segue vindo do renderer (`dynRo*`)|I3,I7,V51,V71,V74
T212|x|`verify-hunters-hunted.ps1` — check NOVO §V74 (nome→1 campo, rótulo autorado incluído); checks de slot de §V71 SAEM (invariante retirado). Mutação: pôr 1 nome em 2 campos ! ficar vermelho|V74,V71,V20
T213|x|`module.xml` version `1.5` → `1.6`|-
T214|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T215|x|`HuntersHunted.lfm` — `ABILITY_FIELD` (41 nomes, 11 campos novos) & `ERA_ABILITIES` (4 épocas × 3 colunas × 10 nomes, §C); `THEME_LABELS` SAI|I3,I7,V74,V75
T216|x|`HH.1.lfm` — template `Ability` vira SLOT: label `name="dynAbil$(col)$(num)"` & bolinhas `name="abil$(col)$(num)_<n>"`; `field=` & `nome=` autorados seguem = lista `Victorian Era`|I7,V59,V76
T217|x|`HH.6.lfm` — renderer por slot: nome = `ERA_ABILITIES[era][col][num]`, label = `tryTranslate(nome)`, bolinha `field = ABILITY_FIELD[nome].."_"..n` & `checked = sheet[...] == true`|I6,I7,V72,V74,V76,R28
T218|x|`HH.3.lfm` + renderer — linha de ataque à distância volta a SLOT (`ro_ranged_*`), campo = o nome ∈ {`Firearms`,`Archery`} da lista da época; linha `Melee` segue estática. Rótulo pelo mesmo renderer|I3,V51,V74,V76
T219|x|`verify-hunters-hunted.ps1` — §V74 vira bijeção; checks NOVOS §V75 (10 nomes distintos c/ campo por coluna/época) §V76 (re-ligação + reload de `checked`); §V70 & §V73 passam a ler `ERA_ABILITIES`. Mutação antes de aceitar|V70,V73,V74,V75,V76,V20
T220|x|`module.xml` version `1.6` → `1.7`|-
T221|x|`rdk -l` + `rdk -i` + teste no Firecast: 2 pontos em `Enigmas`, trocar p/ `Modern Nights` → `Computer` ! ficar 0 & voltar ! mostrar `Enigmas 2`|V6,V7,V76
T222|x|`HuntersHunted.lfm` aba `Powers`→`Numina`; `HH.7.lfm` títulos `NUMINA: HEDGE MAGIC PATHS`→`HEDGE MAGIC PATHS` & `NUMINA: PSYCHIC PHENOMENA`→`PSYCHIC PHENOMENA`; `localization.lang` [pt]+[en] & mapa `PT` acompanham (3 chaves novas, 3 velhas fora)|I1b,V9,V10,V17,V22,V28,V34
T223|x|`module.xml` version `1.7` → `1.8`|-
T224|x|`rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T225|x|`HH.1.lfm` — templates `Header` & `HeaderPicker`: `edit`/`comboBox` 235→215 (`left` 112 intacto); caixa do header 1100→1040 & as 9 linhas passam a `left` 5 \| 350 \| 695, `width` 335|V16,V26,V37
T226|x|`HH.1.lfm` — caixa `EXPERIENCE` (1110,0,100,100)→(1050,0,160,100), título `width` 100→160 & `edit` `left` 20→50 ∴ fecha em 1210 c/ gap 10|V27,V40
T227|x|`module.xml` version `1.8` → `1.9` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T228|x|`HH.1.lfm` — template NOVO `HeaderNarrow` (label 75 `trailing` + `edit` @ `left` 82, 215 largo); coluna 1 (`name` `player` `chronicle`) passa a usá-lo|V16,V25,V26
T229|x|`HH.1.lfm` — caixa do header 1040→1010 & colunas @ `left` 5 (w 297) \| 320 (w 327) \| 665 (w 327) ∴ conteúdo anda 30 p/ a esquerda & gap p/ `EXPERIENCE` vira 40|V37,V40
T230|x|`module.xml` version `1.9` → `2.0` (⊥ `1.10`: ordenação de string) + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T231|x|`HH.1.lfm` — caixa do header 1010→1030 (cresce só pela direita, `left` 0 é a borda da aba) ∴ gap p/ `EXPERIENCE` 40→20|V37,V40
T232|x|`module.xml` version `2.0` → `2.1` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T233|x|8 `.lfm` (⊥ `HH.9`) — 45 títulos de seção `top` 0\|1 → 4 & os vizinhos de faixa (`cmbHealthLevels` ×2, `Page`/`Cost` de `Merit`/`Flaw`) acompanham|V27,V37,V77
T234|x|`verify-hunters-hunted.ps1` — check NOVO §V77 (título ≥ 4, `HH.9` fora). Mutação: 1 título de volta p/ 0 ! ficar vermelho|V77,V20
T235|x|`module.xml` version `2.1` → `2.2` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T236|x|`HH.7.lfm` — `NuminaPicker` → `HedgePicker` c/ `items`/`values` = 21 Paths de §R.14 cap.1 + template NOVO `PsychicPicker` = 22 Phenomena do cap.2; chamadas `numina_1`…`_8` → `HedgePicker` & `psychic_1`…`_8` → `PsychicPicker`. `NuminaFree`, x dos widgets, `DESC`, `.lang` & mapa `PT` ⊥ tocados|V12,V14,V15,V18,V24,V26,V78,R14
T237|x|`verify-hunters-hunted.ps1` — check NOVO §V78 (2 templates lidos por NOME, listas literais 21 + 22, ∩ = ∅, ∪ = 43). Mutação: `Telepathy` movida p/ `HedgePicker` ! ficar vermelho|V78,V20
T238|x|`module.xml` version `2.2` → `2.3` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7

T239|~|TESTE de viabilidade no Firecast: `<tab visible="false">` TIRA o botão da aba? ⊥ tirar → §R.31 vira BLOQUEIO & a rodada para p/ replanejar antes de T240|R31,V79
T240|x|`HH.10.lfm` NOVO — aba Storyteller: caixa `STORYTELLER SETTINGS` c/ linha `Save Initial Character` + `<button>` `Save` & os 4 `checkBox` de §I8|I2,I3,I8,V1,V38,V48,V68,V77
T241|x|`HH.11.lfm` & `HH.12.lfm` NOVOS — abas `Disciplines` & `Magika` VAZIAS (scrollBox + backdrop de tema + caixa de título só, ⊥ `field`)|I2,V48,V57,V68,V90
T242|x|`HuntersHunted.lfm` — 3 `<tab>` novas na ordem de §I.1b + `name=` único em ∀ tab|I1b,I2,V59
T243|x|`HuntersHunted.lfm` — `isStoryteller()` & `applyTabVisibility(from)` no form RAIZ; chamados no `onNodeReady` & pelo `dataLink` dos 3 flags|I8,V19,V33,V79,V80,V89,R29
T244|x|`HH.10.lfm` — `Save` → `Dialogs.confirmOkCancel` → `sheet.baseline = ndb.exportXML(sheet)`; 1 shot, botão desabilita & mostra estado|I8,V33,V81,V82,R30,R32
T245|x|`HuntersHunted.lfm` — `traitLevel(node, campo)` (§V85) & `XP_COST` (§I9) no form RAIZ ∴ ledger & futuros leitores usam a MESMA leitura|I9,V85,V86
T246|x|`HH.9.lfm` — bloco `EXPERIENCE LOG` vira 4 colunas só-leitura sem `field`; `xpLog` SAI do XML & entra em ÓRFÃOS de §I.3|I3,I10,V29,V84,V91
T247|x|`HH.9.lfm` — `renderXPLedger`: diff `baseline`×ficha por nó de memória, 1 linha por ponto, custo por §I9, 21 por tipo novo de númina, afinidade ×6; baseline vazio → texto de estado|I10,V33,V70,V83,V85,V86,V87
T248|x|`HH.7.lfm` — linha `numina_1` c/ `*` + negrito & nota de Affinity Path depois de `TRUE FAITH`|V9,V10,V16,V88
T249|x|`localization.lang` [pt]+[en] & mapa `PT` de `HH.6` — strings novas das 3 abas + 4 títulos de coluna + 7 nomes de `Type` + nota de afinidade|V9,V10,V17,V22,V28,V34,V70
T250|x|`verify-hunters-hunted.ps1` — checks NOVOS §V79…§V91. Mutação antes de aceitar ∀ check|V20,V79,V80,V81,V83,V84,V85,V86,V87,V88,V89,V90,V91
T251|x|`module.xml` version `2.3` → `2.4` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size) — CLAUDE.md|V6,V7
T252|~|teste no Firecast: mestre vê `Storyteller` & jogador ⊥; salvar baseline → +1 em `dexterity` → linha `Attribute\|Dexterity\|3\|8` & desmarcar REMOVE a linha|V79,V81,V83

T253|x|`HH.7.lfm` — label `*` da linha `numina_1` SAI (negrito fica); `["*"]` do mapa `PT` de `HH.6` & `wod.*` [pt]+[en] saem junto|V10,V22,V28,V88
T254|x|`HuntersHunted.lfm` — `<tab>` `Disciplines` `Magika` `Storyteller` autoradas `visible="false"`; `Numina` segue visível|V89,V94
T255|x|`HuntersHunted.lfm` — `onNodeReady` + `dataLink` dos 3 flags MIGRAM de `HH.10` p/ o form RAIZ; `HH.10` fica só c/ `renderBaselineState`|I8,V95
T256|x|`HuntersHunted.lfm` — `applyTabVisibility` esconde ABA & CONTEÚDO (filhos da `<tab>`)|I8,V92
T257|x|`HuntersHunted.lfm` — pós-recálculo, aba ativa proibida → `Main` (`tabIndex = 0` \| `tabMain:activate()`)|I8,V93,R33
T258|x|`verify-hunters-hunted.ps1` — checks NOVOS §V92 §V93 §V94 §V95; §V88 passa a exigir negrito SEM `*`. Mutação antes de aceitar|V20,V88,V92,V93,V94,V95
T259|x|`module.xml` version `2.4` → `2.5` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T260|.|teste no Firecast (RESOLVE §R31 & §T239): ficha nova como JOGADOR → `Disciplines` `Magika` `Storyteller` ⊥ aparecem; ST liga `Show Numina` → aparece p/ o jogador; jogador na aba & ST desliga → pula p/ `Main`. Se o botão da aba SOBREVIVER ao `visible=false`, §R31 vira `⊥` & §V92 é o que segura|R31,V92,V93,V94

T261|x|`HuntersHunted.lfm` — `<event name="onShow">` no form RAIZ → `applyTabVisibility(self)`|V96,R34
T262|x|`verify-hunters-hunted.ps1` — check NOVO §V96 (form raiz tem `onShow` chamando `applyTabVisibility`). Mutação antes de aceitar|V20,V96
T263|x|`module.xml` version `2.5` → `2.6` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T264|.|teste no Firecast: mestre → jogador → mestre, sair da ficha & voltar → aba `Storyteller` REAPARECE. Se ⊥ reaparecer, a causa ⊥ é o gatilho & sim §R29 (`meuJogador` ⊥ populado) ∴ backprop de novo|R29,V96
T265|.|`HH.9.lfm` — `<event name="onShow">` → `renderTotalXP(self)` + `renderXPLedger(self)` ∴ voltar p/ a aba redesenha|V97,R34,R35
T266|.|`HH.9.lfm` — `#rows == 0` escreve estado "Nothing bought yet" na 1ª coluna (≡ §V33) + chave [pt] & [en]|V98,V33,V10
T267|.|`verify-hunters-hunted.ps1` — checks NOVOS §V97 §V98. Mutação antes de aceitar|V20,V97,V98
T268|.|`module.xml` version `2.6` → `2.7` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T269|.|teste no Firecast (RESOLVE §R35 & §T252): baseline salvo → +1 em `dexterity` → ir p/ Progress → linha `Attribute\|Dexterity\|3\|8`; desmarcar REMOVE a linha. Se ⊥ aparecer ao trocar de aba, `onShow` ⊥ dispara em form de aba & o gatilho vira (a) \| (b) de §R35|R35,V97,V83
T270|.|`HuntersHunted.lfm` — `XP_TRAIT[base] = {kind, first, fixed}` p/ ∀ traço de §I9, montado das MESMAS listas que `xpLedgerRows` usa (⊥ 2ª lista, §V86) + `xpSpent()` = Σ `cost` do log|I12,V86
T271|.|`HuntersHunted.lfm` — `xpGuard(field)` conforme §I12 (dorme sem baseline · barra compra sem saldo · barra venda de ponto do baseline · desfaz escrevendo o campo de volta)|I12,V99,V101,V103
T272|.|`HH.1.lfm` `HH.7.lfm` — `onChange="xpGuard('$(field)_N'); renderXPBoxes(self);"` em ∀ dot de traço que custa XP (templates)|V99
T273|.|`HuntersHunted.lfm` — `renderXPBoxes(form)` (≡ `renderHealthTrack`, §R9): escreve `Total` `Spent` `Current` + migração de `xpTotal` (§I11). `HH.9` & `HH.1` chamam|I11,V100,V102
T274|.|`HH.9.lfm` & `HH.1.lfm` — 3 caixas de XP perdem `field`; `Current` ganha `onUserChange` → `xpTotal = digitado + Spent`. `spentXP` & `experience` saem de §I3 ESPELHOS p/ ÓRFÃOS|I11,V1,V36,V102
T275|.|`verify-hunters-hunted.ps1` — checks NOVOS §V99 §V100 §V101 §V102 §V103. Mutação antes de aceitar|V20,V99,V100,V101,V102,V103
T276|.|`module.xml` version `2.7` → `2.8` + `rdk -l` (exit 0 & `.rpk` mudou) + `rdk -i` (instalado c/ mesmo size)|V6,V7
T277|.|teste no Firecast: baseline salvo & `Current` = 10 → subir `dexterity` 3→4 (custa 12) BARRA & o dot volta · `Current` = 20 → mesma compra passa & `Current` cai p/ 8 · desmarcar o dot devolve os 12 · desmarcar dot do baseline ⊥ funciona|I11,I12,V99,V101,V103

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
B18|2026-08-17|caixa `ABILITIES` (`HH.1`) ficou c/ `color="#FFFFFF00"` copiado do `M20.1` ∴ fundo da aba passa através & ela lê CINZA ao lado das caixas pretas. Gate media posição, largura & texto — nunca COR ∴ ia ficar assim p/ sempre|V48
B19|2026-08-17|backdrop do tema declarado c/ o MESMO `name="themePaper"` nas 8 abas → `rdk -l` exit 1 SEM mensagem & `.rpk` APAGADO. Bisect: ∀ atributo isolado compila; 2 arquivos c/ `name` igual ⊥ compila. Gate cobria `<template name=>` mas ⊥ `name=` de controle ∴ mesma morte muda, outra família (≡ §B4/§B17)|V59
B20|2026-08-17|paleta apontava `images/prime_on_ink.png` (relativo). rdk resolve relativo @ COMPILE (`/HuntersHunted/images/…`) ∴ gravar em runtime ⊥ resolve & bolinhas + papel dos 2 temas vitorianos ⊥ carregam. §V58 checava o arquivo EM DISCO, ⊥ a FORMA do caminho ∴ gate verde|V60
B21|2026-08-17|snapshot-e-restaura gravava `fontColor`+`fontFamily` em ∀ controle de texto no load, `Modern` incluído. Setter de fonte chama `_gui_prepareForFont*Change` ANTES ∴ 1ª gravação desacopla o controle da fonte do tema & fixa o valor CRU do getter — a ficha inteira renderizou errada nas 3 opções, inclusive a que ⊥ mudou no XML. "Gravar o mesmo valor = no-op" era premissa MINHA, ⊥ do SDK|V61,V62
B22|2026-08-17|dot1 fixo de atributo & virtude = `<image src=>`, ⊥ `imageCheckBox` ∴ ⊥ passava pelo ramo de troca de arte & ficava BRANCO ao lado das bolinhas douradas/carmim/sangue em ∀ tema. Ramo `image` do `applyTheme` só olhava `themePaper*` — corte declarado por mim na 14ª rodada. §V53 cobria COR autorada; ⊥ ∃ equivalente p/ ARTE autorada|V65
B23|2026-08-17|mapa de época da 19ª rodada escrito como RENOME DE LINHA ∴ o mesmo nome mudava de campo entre épocas: `Melee` = `melee` na Idade das Trevas & `performance` no Clássico, `Etiquette` = `etiquette` \| `firearms` \| `larceny` conforme a época. Trocar de época mostrava `Melee 3` virando `Performance 3` & `Melee 0`. Custo declarado por MIM em §C da 19ª rodada ("re-interpreta as bolinhas") — o user recusa: valor ! seguir o NOME. §V71 media o par rótulo↔bolinha DENTRO de 1 época ∴ ⊥ via a troca|V74
B24|2026-08-17|20ª rodada deu campo canônico por NOME mas deixou 1 campo carregar vários nomes de épocas diferentes (`enigmas` = Enigmas \| Computer \| Philosophy, `science` = Science \| Seneschal \| Ritual …) ∴ 2 pontos em `Enigmas` apareciam como `Computer 2` em `Modern Nights`, num traço que o user nunca tocou. Eu declarei isso como custo aceito em §C — ⊥ era: o user quer identidade por nome. §V74 media só nome→1 campo ∴ o sentido inverso passava verde|V74,V75,V76
B25|2026-08-18|`baseline` = campo só-Lua (⊥ widget — é o dado escondido do jogador) ∴ `<dataLink field="baseline">` de `HH.10` caiu em §V8 como link morto. Invariante ⊥ previa dono-Lua; gate ⊥ lê `fields=` de link múltiplo ∴ o mesmo campo em `HH.9` passou despercebido (gap ANTERIOR, ⊥ regressão desta rodada)|V8
B26|2026-08-18|12 abas autoradas VISÍVEIS + gatilho de `applyTabVisibility` morando em `HH.10` (a própria aba escondida) ∴ ficha nova c/ os 3 flags desligados abria com `Disciplines` `Magika` & `Storyteller` à vista p/ o JOGADOR. §V80 fez o gate fail-closed na LÓGICA, mas o estado ESTÁTICO seguia fail-open & §R31 (`visible` tira o botão?) segue `?` ∴ 2 causas possíveis, 1 sintoma|V92,V93,V94,V95
B27|2026-08-18|`applyTabVisibility` só disparava no `onNodeReady` do form RAIZ & no `dataLink` dos 3 flags ∴ trocar de papel na mesa ⊥ re-avaliava: a decisão tomada como JOGADOR congelava & o mestre voltava p/ a ficha sem a aba `Storyteller`. Até a 27ª rodada a aba nascia `visible="true"` ∴ o estado estático mascarava a falta de re-avaliação; §V94 fechou o default & EXPÔS. Agravante: os 3 checkbox que disparam o `dataLink` moram DENTRO da aba escondida ∴ ⊥ ∃ caminho de volta pelo próprio cliente|V96
B28|2026-08-18|corretude do log de XP dependia de `ndb.newObserver` p/ os ~458 dots — API do SDK sem precedente em FICHA (só ChatMod) & nunca testada (§T252 ficou `~`). Os únicos gatilhos PROVADOS eram `onNodeReady` (1×/carga) & `dataLink` de 3 campos ∴ log congela no estado do load. Somado: `rows` vazio escrevia 4 colunas EM BRANCO (§V33 só cobria baseline ausente) ∴ baseline recém-salvo + ponto novo = tela vazia que ⊥ diz nada|V97,V98
