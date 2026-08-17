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
- Merits & Flaws ⊥ no PDF ?
- Abas Background & Notes ⊥ no PDF, herdadas da base Mage ?
- Numina = 11 linhas abertas ?

## §I INTERFACES

- I1 dataType: `Ambesek.HuntersHunted.20th`, `formType="sheetTemplate"`, title `Hunters Hunted - Mortal`, `theme="dark"`
- I2 arquivos: `Plugins/Sheets/World of Darkness 20th/HuntersHunted/` → `HuntersHunted.lfm` (raiz) + `HH.1.lfm`…`HH.6.lfm` + `images/`
- I3 campos NDB (contrato de dados — ⊥ renomear pós-release):
  - header: `name` `player` `chronicle` `nature` `demeanor` `concept` `motivation` `occupation` `residence`
  - attrs (dot1 fixo, campos `_2`…`_5`): `strength` `dexterity` `stamina` `charisma` `manipulation` `appearance` `perception` `inteligence` `wits`
  - abilities (`_1`…`_5`) talents: `alertness` `athletics` `awareness` `brawl` `empathy` `expression` `intimidation` `leadership` `streetwise` `subterfuge`
  - skills: `animalKen` `crafts` `etiquette` `firearms` `larceny` `melee` `performance` `ride` `stealth` `survival`
  - knowledges: `academics` `enigmas` `finance` `investigation` `law` `medicine` `occult` `politics` `science` `technology`
  - virtues (dot1 fixo, `_2`…`_5`): `conscience` `selfControl` `courage`
  - `humanity_1`…`_10` · `willpower_1`…`_10` + `willpower_c1`…`_c10` · `faith_1`…`_5`
  - health: `bruised` `hurt` `injured` `wounded` `mauled` `crippled` `incapacitated`
  - numina: `numina_1`…`_11` (+ `_1`…`_5` cada) + `numinaNotes`
  - backgrounds: `background_1`…`_5` (+ `_1`…`_5` cada)
  - combat: `attack_N` `damage_N` `difficulty_N`, N=1…4
  - `experience` · `avatar`
- I4 build: `rdk -l` @ raiz do plugin → compile + lint fonte → `output/World of Darkness 20th.rpk`. `rdk -c` = só compile. `rdk p` = PREPARE, ⊥ build.

## §R RESEARCH

id|topic|finding|src
R1|Locale fallback|`Locale.tryLang` → `_system_locale_tryLang`, nativo do host, ⊥ visível no SDK ∴ fallback [pt]↔[en] = `?`. Mitigado por [en] identidade → pergunta vira irrelevante|`sdk/localeCore.dlua:8`
R2|alcance da tradução|rotina do sheet traduz só `findClass("label")` & `radioButton`. `checkBox` `button` `tab.title` `form.title` ⊥ alcançados. Ficha ⊥ tem radioButton|`HuntersHunted/HH.6.lfm`
R3|combo tema|`items` do combo `theme` = valor, ⊥ rótulo — Lua compara `theme == "Claro"` ∴ traduzir item quebra troca de tema|`HuntersHunted/HH.6.lfm`

## §V INVARIANTS

V1: ∀ `field=` de widget de entrada único na árvore do sheetTemplate ∴ ⊥ 2 inputs no mesmo dado. `<dataLink>` ∉ contagem — observa, ⊥ possui (§B.3)
V2: nome de campo ∈ §I.3 ⊥ renomeado após release ∴ ficha salva perde dado
V3: ∀ png em `src=` `checkedImage=` `uncheckedImage=` ! ∃ em `HuntersHunted/images/` (path relativo à pasta do sheet)
V4: dataType `Ambesek.HuntersHunted.20th` ∉ demais plugins do repo
V5: qtd de dots ! = PDF — attrs 5, abilities 5, virtues 5, numina 5, backgrounds 5, humanity 10, willpower 10 dots + 10 box, faith 5, health 7 níveis
V6: build = `rdk -l` @ raiz do plugin, exit 0 antes de commit. `rdk p` ⊥ build (§B.1)
V7: build ok ! = exit 0 & mtime|size do `.rpk` mudou — exit 0 sozinho ⊥ prova (§B.1)
V8: ∀ `<dataLink field=X>` → ∃ widget de entrada com `field=X` no mesmo sheet ∴ ⊥ link morto
V9: ∀ string visível ! autorada em inglês ∴ tradução one-way EN→[pt] (§B.4)
V10: ∀ string visível ∈ {`label`, `checkBox`, `button`} → ∃ `wod.<txt>` em [pt] & [en]
V11: ⊥ label com padding p/ alinhar coluna — 1 label por coluna ∴ cada um traduzível (§B.5)
V12: `items` de combo = valor ⊥ rótulo ∴ mudar item ! mudar comparação Lua & `defaultValue` no mesmo commit (§R.3)

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
T20|.|`?` testar em Firecast: `findClass("tab")` alcança & `tab.title` gravável → sim: traduzir 6 abas; ⊥: registrar limite em §C|R2

## §B BUGS

id|date|cause|fix
B1|2026-08-15|`rdk p` = PREPARE ⊥ pack — exit 0 mas `.rpk` ⊥ mudou & `module.xml` reescrito|V6,V7
B2|2026-08-15|§C travou `sdkVersion` que o rdk possui & reescreve (`3.6c`→`3.7b`)|§C
B3|2026-08-15|§V1 contou `<dataLink field>` como dono de campo; base `M20.6.lfm` usa por design|V1,V8
B4|2026-08-16|tradução cobre só `label` ∴ 7 níveis Health (`checkBox`) c/ chave [pt] ⊥ aplicada; Credits autorado em PT ⊥ traduzível p/ EN|V9,V10
B5|2026-08-16|header COMBAT = 1 label c/ padding p/ alinhar colunas ∴ ⊥ utilizável como chave|V11
