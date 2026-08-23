# HANDOFF — estado antes do próximo `/ck:build`

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

⚠ **o plugin PROBE segue INSTALADO** (`andreoliveira.styllern.probealign.rpk`, 98.574 B). Fonte no
scratchpad, fora do repo. P/ limpar: apagar a ficha de probe no Firecast ANTES de desinstalar,
senão fica ficha órfã apontando p/ um dataType que ⊥ existe mais.

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
