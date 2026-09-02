# firecast_fork — instruções do projeto

Plugins de ficha para o Firecast (SDK3). Spec do trabalho corrente = `SPEC.md` na raiz
(formato caveman, §G/§C/§I/§R/§V/§T/§B). Gate = `verify-hunters-hunted.ps1` na raiz.

Plugin ativo: `Plugins/Sheets/World of Darkness 20th Anniversary Edition/` (ficha `WoD20th/`).

**Antes do primeiro `/ck:build` da sessão, leia `HANDOFF.md` na raiz.** Ele lista onde o
`SPEC.md` está atrás do código (buildar sem saber disso faz "consertar" código correto),
qual §T pegar em seguida e quais parecem prontas mas arrastam trabalho junto.
Dados de pesquisa extraídos dos livros: `research/` (leia o `README.md` de lá antes de
reextrair qualquer coisa dos PDFs).

## Leitura — as 4 regras que seguram o custo (§I133g, §V387)

O gargalo medido não é disco nem rede: é token. Contexto médio de 323k por request e 650k
tokens de saída por rodada. Estas 4 regras valem em toda sessão:

1. **Nunca `grep -C` no `SPEC.md`.** Use `.\spec-slice.ps1 <id>` — devolve a linha do id e
   as que ela cita. Medido em §T826: 10.717 tokens contra 750.
2. **Gate sempre com `-Quiet`**: `.\verify-hunters-hunted.ps1 -Quiet` imprime só os FAIL e a
   contagem. Todos os checks rodam igual — 14.093 tokens por rodada contra ~1k.
3. **`Edit` em vez de `Write`** em arquivo que já existe. Write regrava tudo em tokens de
   saída, a parte serial e lenta: foram 57 Writes contra 5 Edits, 20% de toda a saída.
4. **Nunca abrir inteiros** `desc*.lua` (975 KB cada, dado e não lógica),
   `verify-hunters-hunted.ps1` (1,25 MB) e `SPEC.md` (1,62 MB) — sempre `grep` ou `sed -n`.

⚠ Todo arquivo do repo é **CRLF** e as ferramentas do Git Bash comem o CR do arquivo
inteiro, sem sintoma (§B74, §V318). Depois de gerar arquivo com `awk`/`>`, converta:
`awk '{printf "%s\r\n", $0}'`.

## Build ! terminar em .rpk INSTALADO

Toda vez que terminar de buildar: gerar o `.rpk` **e instalar**. Build sem install =
tarefa incompleta — o Firecast continua rodando a versão velha.

**Mas 1 install por RODADA, no fim — não por §T (§B103 do SPEC).** `rdk -l` roda quantas
vezes precisar; `rdk -i` roda uma vez, ao fechar a rodada. Instalar com o Firecast aberto e
a ficha carregada deixa o form velho na tela com o código novo atrás: o controle some e
nenhum handler o traz de volta — só fechar e reabrir a ficha cura, e o sintoma se disfarça
de bug de código. Se a ficha puder estar aberta, **avise antes de instalar**.

Da raiz do plugin (`Plugins/Sheets/World of Darkness 20th Anniversary Edition/`):

```powershell
rdk -l    # compila + lint do código-fonte -> output/World of Darkness 20th Anniversary Edition.rpk
rdk -i    # compila + INSTALA no Firecast
```

`rdk.exe` fica em `%LOCALAPPDATA%\FirecastSDK3\rdk.exe`.

Provas de que funcionou (exit 0 sozinho não prova nada — §B1 do SPEC):

- build: `output/World of Darkness 20th Anniversary Edition.rpk` mudou de mtime **e** size;
- install: `%APPDATA%\Firecast\Plugins\andreoliveira.styllern.wod20th.rpk` com o mesmo size do `.rpk`
  recém-gerado e mtime da hora do install.
- diferença de size entre `output/` e o instalado que não muda nada para o user **não** é
  motivo para reinstalar: foram 2 dos 3 installs desperdiçados na 147ª rodada (§B103).

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
