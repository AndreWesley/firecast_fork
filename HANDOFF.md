# HANDOFF — estado antes do próximo `/ck:build`

Reescrito 2026-08-21, fim da **72ª rodada**. Para um Claude que abre a sessão sem contexto.

A 69ª fechou **§T498 · §T499 · §T500 · §T501 · §T502** (plugin próprio); a 70ª fechou **§T503** & a 71ª **§T504** — preços de XP de vampiro TROCADOS (§I9: disciplina 20 / clã n×15 / fora do clã n×25 · Secondary Path 20 / n×15) & ⚠ ficha que JÁ comprou disciplina é REPRECIFICADA na abertura, `Current` pode ir a negativo (§C); a 72ª fechou **§T505–§T509** — topo da aba Vampiro ganhou 2 caixas: `DOMINATOR` (dominador · geração 4ª-14ª · Max Discipline Level derivado · Clan/Family) & `BLOOD POOL` (20 bolinhas LIVRES, 10 por default). Teto de geração RECUSA compra de disciplina acima do máximo (§V220). **§T510 BLOQUEADA**: falta o user passar os livros p/ as famílias de revenant (§R93) — o combo `Clan/Family` vive c/ 60 clãs/linhagens até lá, & `clanFamily` é ALIAS de `clan` (§B50) ∴ §T510 TROCA o alias, ⊥ dá append. **§T511 é teste SEU no Firecast**; — esconder aba manejada ⊥ move mais ninguém: §V217 REVOGA §V93 (o pulo p/ `Main` arrancava o mestre da aba `Storyteller` a cada toggle). Gate verde, `.rpk` gerado e instalado.
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
| `.rpk` | **1.952.695** B, 2026-08-21 22:37:01 — instalado 22:37:01, sizes batendo |
| `WoD20th.lfm.lua` | **1.415.113** B (⊥ remedido na 69ª — o rename ⊥ muda tamanho) |
| `module.xml` | `<id>AndreOliveira.Styllern.WoD20th</id>` · `<version>1.0</version>` (plugin novo) |
| gate | **4.439** linhas, ASCII puro, LF · 436 checks |
| §V máx | **V222** · §B máx **B50** · §T máx **T511** · gate **443** checks |

⚠ **⊥ deixe a saída do gate cair no chat** — são ~400 linhas `ok` e afoga o contexto:

```bash
powershell.exe -NoProfile -Command "& '.\verify-hunters-hunted.ps1' *>&1 | Out-File -FilePath '<tmp>/g.txt' -Encoding utf8; exit \$LASTEXITCODE"
grep -E "FAIL|ALL CHECKS" '<tmp>/g.txt'
```

As linhas `FAIL` **⊥ aparecem** em `$o = .\verify...` — `Fail` escreve em outro stream. ! usar
`*>&1` p/ arquivo.

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
