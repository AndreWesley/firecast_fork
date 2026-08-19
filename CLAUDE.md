# firecast_fork — instruções do projeto

Plugins de ficha para o Firecast (SDK3). Spec do trabalho corrente = `SPEC.md` na raiz
(formato caveman, §G/§C/§I/§R/§V/§T/§B). Gate = `verify-hunters-hunted.ps1` na raiz.

Plugin ativo: `Plugins/Sheets/World of Darkness 20th/` (ficha `HuntersHunted/`).

## Build ! terminar em .rpk INSTALADO

Toda vez que terminar de buildar: gerar o `.rpk` **e instalar**. Build sem install =
tarefa incompleta — o Firecast continua rodando a versão velha.

Da raiz do plugin (`Plugins/Sheets/World of Darkness 20th/`):

```powershell
rdk -l    # compila + lint do código-fonte -> output/World of Darkness 20th.rpk
rdk -i    # compila + INSTALA no Firecast
```

`rdk.exe` fica em `%LOCALAPPDATA%\FirecastSDK3\rdk.exe`.

Provas de que funcionou (exit 0 sozinho não prova nada — §B1 do SPEC):

- build: `output/World of Darkness 20th.rpk` mudou de mtime **e** size;
- install: `%APPDATA%\Firecast\Plugins\ambesek.wod.20th.rpk` com o mesmo size do `.rpk`
  recém-gerado e mtime da hora do install.

`rdk -p` é PREPARE, não build: sai 0 sem tocar no `.rpk` e ainda reescreve o `module.xml`.

## Gate antes de fechar tarefa

```powershell
.\verify-hunters-hunted.ps1          # checks estáticos (§V1..§V40)
.\verify-hunters-hunted.ps1 -Build   # + rdk -l e assert de §V6/§V7
```

Verde é condição para marcar §T como `x`. Check novo no gate ! poder falhar de verdade
(teste de mutação antes de aceitar) — §V20 existe porque um check já virou no-op (§B7).

## Escrita no SPEC.md

Só `/ck:spec` (ou `/cavepony:spec`) escreve seções; `/ck:build` só vira o status do §T.
Numeração de §V/§B/§T é monotônica — nunca reusar id.

## Git ! commit só sob pedido direto

Neste projeto o Claude **não commita** por conta própria. Nada de `git commit`, `git add`
seguido de commit, amend, push, tag ou branch de entrega sem o user pedir **naquela mensagem**.

- Vale mesmo quando um skill manda commitar: `/ck:build` diz "commit after each §T" —
  esta regra **vence**. O build termina com o §T marcado, o gate verde e o `.rpk` instalado,
  e as mudanças ficam no working tree.
- Autorização não é permanente nem retroativa: "pode commitar" vale para aquele commit,
  não para os próximos.
- O que continua normal sem pedido: editar arquivos, rodar o gate, `rdk -l` / `rdk -i`,
  e comandos git de **leitura** (`status`, `diff`, `log`, `show`).
- Ao fechar tarefa, dizer o que ficou pendente de commit em vez de commitar.
