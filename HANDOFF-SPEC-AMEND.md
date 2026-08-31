# EMENDA DE SPEC — os 5 §T que mentem sobre estar prontos (2026-08-31, 158ª)

Cole o bloco "O COMANDO" abaixo como argumento de `/ck:spec amend` num chat SEM contexto.

**Estado quando isto foi escrito:** gate **VERDE 634 ok / 0 FAIL** · §T **762 `x` · 104 `.` · 12 `~`**
· `.rpk` 2.630.249 B instalado 17:07 (Firecast fechado) · §T877 e §T878 construídos · **nada
commitado** (working tree suja desde `b675cc74`).

---

## O PROBLEMA, EM 1 FRASE

Cinco §T (`§T830` `§T832` `§T872` `§T874` `§T876`) têm **todos os bloqueadores que elas citam
em `x`**, mas nenhuma das cinco é construível. Quem ler a coluna de bloqueio entra direto na
tentativa que a 157ª já reverteu.

## OS FATOS, TODOS MEDIDOS EM 2026-08-31 CONTRA O CÓDIGO

1. **`0` `btnQ` em `WoD20.7.lfm` `WoD20.12.lfm` `WoD20.13.lfm` `WoD20.14.lfm`** — as famílias de
   disciplina, trilha, ritual, númina e hedge **⊥ têm `?`** hoje. (O gate conta 45 `btnQ` na
   ficha: 2 `HeaderPicker` + 22 `MeritPicked` + 21 `OpenAbility`, & mais nenhum.)
2. **`1` pane `<textEditor name="edt*Desc">` em cada** de `WoD20.12` `WoD20.13` `WoD20.14`.
3. **§T846 está `x` mas ⊥ faz o que §T830/§T832 dizem que ela faz.** Ela foi **REESCRITA na 148ª**
   (§B105) para ser "`?` no `HeaderPicker` (nature/demeanor), & SÓ nele". Ela **⊥ tira pane
   nenhuma**. §T830 a cita como "quem tira as 4 panes" & §T832 como quem tira as 3 — as duas
   descrevem uma §T que ⊥ ∃.
4. **§T811 proíbe as ondas** — texto dela: "ONDAS 2 a 5 de §I113e — **⊥ buildar antes de §T810
   passar**". §T810 é `[USER]`, teste de TELA, & está `.`.
5. **A corrente JÁ está escrita — em §B105**, & os §T é que nunca souberam: "cada pane sai na
   rodada em que a família DELA ganha `?` — porque as de Numina/Ghoul só ganham `?` nas ondas 3-5
   de §I113e, & tirar a pane antes deixa a linha **sem superfície de descrição NENHUMA**, nem
   pane nem `?`, que é o recurso apagado". §V365(d) diz o mesmo pelo lado da régua.
6. **§I131g** fecha o laço: "∀ família convertida entrega **3** coisas na MESMA rodada: a caixa
   de busca · o `?` · `-- Custom --`". ∴ o `?` dessas famílias chega COM a onda, ⊥ antes.

## A CORRENTE REAL — as 5 têm 1 raiz só

    §T810 [USER, tela, `.`]
      └─ §T811 (⊥ buildar onda antes de §T810 passar)
           ├─ §T872 onda 3  → dá `?` a disc/mainPath/secPath/ritual (§I131g)
           │     └─ §V365(d)+§B105: só ENTÃO as 3 panes de WoD20.12/13/14 podem sair
           │           └─ §T832 (aba Ghoul, 3 colunas — precisa das 3 panes fora)
           ├─ §T874 onda 4  → dá `?` às famílias de Numina/Hedge
           │     └─ §V365(d)+§B105: só ENTÃO as 4 panes de WoD20.7 podem sair
           │           └─ §T830 (aba Numina, 3 colunas — precisa das 4 panes fora)
           └─ §T876 onda 5  → `cboRoad` & `cboClanFamily`

∴ **⊥ ∃ §T construível sem o user rodar §T810.** As 5 citam bloqueadores satisfeitos porque
citam a §T ERRADA (§T846) ou porque a regra que as trava mora em OUTRA linha (§T811).

---

## O COMANDO

```
amend — 5 §T citam bloqueador satisfeito & nenhuma é construível. MEDIDO 2026-08-31 contra o código, gate verde 634/0. Numeração monotônica; idioma-fonte inglês. Só a coluna de bloqueio & a coluna cites mudam — o CONTEÚDO das 5 tarefas está certo e ⊥ deve ser reescrito.

O fato que as 5 compartilham, e que nenhuma diz: a pane de descrição só pode sair na rodada em que a família DELA ganha `?` (§V365(d), & §B105 escreve o porquê: tirar antes deixa a linha sem superfície de descrição NENHUMA, nem pane nem `?`). As famílias de Numina/Ghoul só ganham `?` nas ondas 3-5 (§I131g: caixa + `?` + `-- Custom --` na MESMA rodada), e §T811 proíbe qualquer onda antes de §T810 passar — que é `[USER]`, de tela, e está `.`. MEDIDO: 0 `btnQ` em WoD20.7/12/13/14 (o gate conta 45 na ficha, todos em HeaderPicker/MeritPicked/OpenAbility) e 1 pane `edt*Desc` em cada de WoD20.12/13/14.

1. §T830 — o bloqueador citado ⊥ ∃.
Hoje: "DESBLOQUEADA por §T829 `x` & §Q32 RESPONDIDA; **BLOQUEADA por §T846**, que é quem tira as 4 panes". §T846 está `x` mas foi REESCRITA na 148ª (§B105) p/ ser "`?` no HeaderPicker, & SÓ nele" — ela ⊥ tira pane nenhuma, ∴ a premissa nunca se cumpriu & a linha parece pronta. Emendar: BLOQUEADA por §T874 (onda 4), que é quem dá `?` às famílias de Numina — só então as 4 panes saem (§V365(d), §B105). Raiz: §T810. Manter "DESBLOQUEADA por §T829 & §Q32", que é verdade. cites: trocar `T846` por `T874,T810,V365`.

2. §T832 — mesma mentira, outra aba.
Hoje: "**BLOQUEADA por §T846** (as 3 panes saem antes: listas somam 1475 contra 1070, §I118d)". Emendar: BLOQUEADA por §T872 (onda 3), que é quem dá `?` a disc/mainPath/secPath/ritual — só então as 3 panes de WoD20.12/13/14 saem. Raiz: §T810. ⚠ acrescentar o que a 157ª mediu e que ⊥ está na linha: o CÓDIGO desta §T já saiu inteiro e CERTO uma vez e foi REVERTIDO; o custo dela é de GATE (~20 réguas), ⊥ de layout, e está em §I118e. cites: trocar `T846` por `T872,T810,V365`.

3. §T872 — a regra que a trava mora no §T811, ⊥ nela.
Hoje: "BLOQUEADA por §T868 (`x`) & §T877" — os 2 estão `x` ∴ a linha lê como PRONTA. Emendar: acrescentar "& por §T811 (⊥ buildar onda antes de §T810 passar) — §T810 é `[USER]`, de tela, & está `.`". Acrescentar também o bloqueio MEDIDO: §V365(d) reprova enquanto WoD20.12/13/14 tiverem pane, & elas têm 1 cada ∴ esta onda ! sair na MESMA rodada que §T832 tira as panes, ou depois. cites += `T811,T810,V365`.

4. §T874 — idem.
Hoje: "BLOQUEADA por §T868" (`x`). Emendar: acrescentar §T811/§T810, & que ela é quem dá `?` às famílias de Numina ∴ é ELA que destrava §T830. cites += `T811,T810,V365`.

5. §T876 — idem.
Hoje: "BLOQUEADA por §T868 & §T866" (os 2 `x`). Emendar: acrescentar §T811/§T810. cites += `T811,T810`.

E UM PEDIDO DE FORMA, ⊥ de conteúdo: §T811 ⊥ é tarefa, é REGRA — ela é o que proíbe as ondas, & hoje só quem abre §T811 descobre isso. Escrever a raiz (§T810) na coluna de bloqueio das 5 é o que faz `grep "^T[0-9]*|\.|" SPEC.md` parar de mentir, que é o dashboard que o /ck:build usa.
```

---

## DEPOIS DA EMENDA

1. **Commitar** o que está pronto (§T877, §T878, a emenda das 11 + esta) — a árvore está suja
   desde `b675cc74` & sem baseline ⊥ ∃ como reverter o §T832 se ele desandar de novo.
2. **§T810 é o gargalo real.** Rodar as de tela numa sessão só: `§T787` `§T804` `§T810` `§T816`
   `§T820` `§T823`. §T810 & §T827 são as que mais destravam.
3. Só então: §T872 (onda 3) + §T832 na mesma rodada, & §T834 (§V361/§V362 no gate) DEPOIS —
   régua de layout que ainda ⊥ ∃ nasce vermelha contra código certo (§B106).
