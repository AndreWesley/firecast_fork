-- Path descriptions, the [pt] half (SPEC T495, V210).
--
-- descPath.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [pt] only, descPath_en.lua holds the other, the two carry the SAME
-- keys, and the renderer requires the half the sheet is set to - require("descPath_" .. lang ..
-- ".lua"), never a constant name (SPEC V210b). Nothing was removed: both files ship in the
-- .rpk and no entry is dropped (SPEC V210a). The generator markers migrated verbatim to
-- both sides, so every region parser still aims at the same shape (SPEC I24).
--
-- Path descriptions for the Vampire tab (SPEC I21). One entry per canonical picker
-- value, keyed in ENGLISH because that is what the sheet saves (SPEC V24); `pt` is a
-- translation of the same three blocks, source line for source line.
--
-- SPEC I24 / T479-T481: this table used to be an upvalue inside the <script> of HH.13.lfm.
-- The <script> CDATA is copied raw into constructNew_*(), so every open sheet parsed and
-- kept its own copy. As a module it is parsed once and cached in package.loaded, and the
-- require that pulls it lives INSIDE pathText (SPEC V198).
--
-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24). The generator
-- markers migrated verbatim, so research/rebuild_ritual_desc.sh and the .tsv maps still aim
-- at the same region - only the path of the target changed.

return {
				-- >>> PATH_DESC_BEGIN (generated - SPEC T445)
				["Ash Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 163


Ash Path


A Trilha das Cinzas permite aos necromantes espiar as terras dos mortos e até afetar coisas de lá. Entre as trilhas de Necromancia, a Trilha das Cinzas é a mais perigosa de aprender, porque muitos dos usos da trilha aumentam a vulnerabilidade do necromante a espectros.

• Visão do Sudário
Visão do Sudário permite ao necromante enxergar através do Sudário, a barreira mística que separa o mundo dos vivos do Submundo. Usando este poder, o vampiro consegue avistar construções e objetos espectrais, a paisagem das chamadas Terras das Sombras e até os próprios espectros. Contudo, um espectro observador pode notar quando um vampiro subitamente começa a encará-lo, o que pode levar a consequências desagradáveis.
Sistema: Uma simples rolagem de Percepção + Prontidão (dificuldade 7) permite ao necromante utilizar Visão do Sudário. Os efeitos duram uma cena.

•• Línguas sem Vida
Onde Visão do Sudário permite ao necromante ver fantasmas, Línguas sem Vida permite a ela conversar com eles sem esforço. Uma vez empregado Línguas sem Vida, o vampiro consegue manter uma conversa com os habitantes do Submundo espectral sem gastar sangue nem fazer os espectros despenderem qualquer esforço.
Sistema: Usar Línguas sem Vida exige uma rolagem de Percepção + Ocultismo (dificuldade 6) e o gasto de um ponto de Força de Vontade.

••• Mão Morta
Semelhante ao poder Tormento da Trilha do Sepulcro, Mão Morta permite ao necromante alcançar através do Sudário e afetar um objeto espectral como se ele estivesse no mundo real. Fantasmas são sólidos para necromantes que usam este poder, e podem ser atacados. Além disso, o necromante consegue pegar objetos espectrais, escalar arquitetura espectral (dando aos espectadores do mundo real a impressão de que ele está escalando o ar!) e, de modo geral, existir em dois mundos. Por outro lado, um necromante usando Mão Morta é bastante sólido para os residentes do Submundo — e para quaisquer hostilidades que eles possam ter.
Sistema: O jogador gasta um ponto de Força de Vontade e faz uma rolagem bem-sucedida de Raciocínio + Ocultismo (dificuldade 7) para ativar Mão Morta por uma cena. Para cada cena adicional em que o vampiro queira permanecer em contato com o Submundo, ele precisa gastar um ponto de sangue.

•••• Ex Nihilo
Ex Nihilo permite ao necromante entrar fisicamente no Submundo. Enquanto está nas terras dos mortos, o vampiro é essencialmente um fantasma particularmente sólido. Ele mantém seu número normal de níveis de vitalidade, mas só pode ser ferido por coisas que causem dano agravado a fantasmas (armas forjadas de almas, certos poderes espectrais etc.). Um vampiro fisicamente no Submundo pode atravessar objetos sólidos no mundo real (ao custo de um nível de vitalidade) e permanecer "incorpóreo" por um número de turnos igual ao seu Vigor. Por outro lado, vampiros presentes no Submundo estão sujeitos a todos os perigos do Submundo, incluindo a destruição definitiva. Um vampiro morto no reino dos mortos se foi para sempre, além até do alcance de outros necromantes.
Sistema: Usar Ex Nihilo cobra um preço tremendo do necromante. Para ativar este poder, o vampiro precisa primeiro desenhar uma porta com giz ou sangue em qualquer superfície disponível. (O vampiro pode desenhar portas com antecedência exatamente para esse fim.) O jogador precisa então gastar dois pontos de Força de Vontade e dois pontos de sangue antes de fazer uma rolagem de Vigor + Ocultismo (dificuldade 8) enquanto o vampiro tenta abrir fisicamente a porta de giz. Se a rolagem tiver sucesso, a porta se abre e o vampiro atravessa para o Submundo.
Quando o vampiro deseja retornar ao mundo real, basta que se concentre (e o jogador gasta outro ponto de Força de Vontade e rola Vigor + Ocultismo, dificuldade 6). A critério do Narrador, um vampiro imerso fundo demais no Submundo pode precisar viajar até um lugar próximo das terras dos vivos para conseguir atravessar. Vampiros que vagam longe demais pelas terras dos mortos podem ficar presos lá para sempre.
Vampiros no Submundo não podem se alimentar de fantasmas sem o uso de outro poder; seu único sustento é o sangue que trazem consigo.

••••• Domínio do Sudário
Domínio do Sudário oferece ao Membro a capacidade de manipular o véu entre os mundos dos vivos e dos mortos. Ao fazê-lo, um necromante pode tornar mais fácil aos espectros vinculados a seu serviço funcionarem, ou tornar quase impossível que fantasmas contatem o mundo material.
Sistema: Para exercer Domínio do Sudário, o necromante gasta dois pontos de Força de Vontade e então declara se está tentando erguer ou baixar o Sudário. O jogador então faz uma rolagem de Força de Vontade (dificuldade 9). Cada sucesso na rolagem aumenta ou reduz em um as dificuldades de todas as tentativas de espectros próximos de atravessar o Sudário de qualquer forma, até um máximo de 10 ou um mínimo de 3. O Sudário volta à sua força normal a uma taxa de um ponto por hora daí em diante.]==],
				},
				["Awakening of the Steel"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 440


Awakening of the Steel


Embora o domínio do combate dificilmente seja o objetivo principal da casta feiticeira, ela tem uma longa tradição de estar pronta para se defender e, se preciso, auxiliar a casta guerreira no campo de batalha. O Despertar do Aço é um legado dessa prontidão, uma trilha que alguns dizem ter começado com os alquimistas que estudaram nas forjas de Toledo e Damasco. Esse conjunto de técnicas se concentra no simbolismo da espada como extensão definitiva do corpo de um guerreiro treinado, apoiando-se nos mitos que várias tradições guerreiras atribuíram a suas espadas e adagas: os cruzados europeus e suas lâminas abençoadas, o kris dos praticantes indonésios de Pentjak-Silat e os gurcas indianos com suas facas kukri, entre outros. O praticante do Despertar do Aço concentra-se nesse simbolismo enquanto usa o poder de seu sangue para aprimorar sua arma e sua perícia.
Um estudante do Despertar do Aço descobre que um entendimento apurado tanto da forma quanto da função de uma lâmina é necessário para o domínio pleno desta trilha. O personagem precisa ter um nível de Armas Brancas ou de Ofícios igual a seu nível em Despertar do Aço. Quem pratica esta trilha também percebe que suas lições são estreitamente focadas, talvez a ponto da superespecialização. A trilha é mais eficaz com espadas e facas, e o portador só consegue estender seus efeitos a outras armas cortantes. Qualquer tentativa de usar uma técnica desta trilha em outra arma cortante é com +1 de dificuldade.

• Conferenciar com a Lâmina
Embora poucos Assamitas afirmem ter de fato conversado com a alma de uma arma, ferreiros e guerreiros atribuem qualidades espirituais a lâminas forjadas à mão há séculos. Praticantes de Auspícios conhecem bem a maneira como objetos inanimados podem guardar impressões da própria história. Conferenciar com a Lâmina permite ao portador de uma arma mergulhar nos eventos ocorridos ao redor dela. Alguns praticantes deste poder afirmam que ele deixa a arma mais "confortável" nas mãos, enquanto outros falam do senso de história que uma lâmina antiga carrega. As impressões em si levam apenas um instante para serem obtidas, embora muitos prefiram passar bem mais tempo em contemplação se o tempo permitir.
Sistema: O número de sucessos determina a quantidade de informação que o feiticeiro obtém sobre a história da lâmina e seu estado atual, além de tudo o que um número menor de sucessos revelaria. Com três ou mais sucessos, o feiticeiro pode reduzir em um a dificuldade de sua próxima tentativa de aplicar um ritual de magia de sangue à arma.
1 sucesso — Apenas informação física: comprimento e peso precisos (ao micrômetro e ao miligrama), composição química (supondo que o personagem entenda de metalurgia), número de dados de dano e tipo de dano (letal ou agravado).
2 sucessos — Panorama histórico: quando e onde a lâmina foi forjada, o nome e o rosto de seu ferreiro, vislumbres breves de eventos significativos de sua existência.
3 sucessos — Compreensão feiticeira: o tipo e o nível relativo de poder de quaisquer encantamentos ou aprimoramentos sobrenaturais que a lâmina possua, bem como o nome e o rosto de quem os lançou.
4 sucessos — Síntese subliminar: conhecimento abrangente da história da espada. Pelas sete noites seguintes, o personagem reconhece o gosto de qualquer sangue que já tenha manchado a lâmina, caso o prove.
5 sucessos — Comunhão total: a espada e o portador se ligam num nível mais profundo que o físico e mais duradouro que o imediato. O Narrador determina que informação a espada guarda para o personagem, mas ela pode incluir qualquer evento da história da lâmina ou qualquer aspecto de sua existência e condição presentes.

•• Agarrar da Montanha
A melhor cimitarra de toda a criação não serve de nada ao dono se estiver caída a cinco metros dele. Agarrar da Montanha fortalece o vínculo espiritual entre a espada e o espadachim para reforçar o domínio físico do portador sobre sua arma. Uma lâmina sob o efeito desta arte nunca deixa a mão de seu mestre a menos que ele assim queira.
Sistema: Pelo resto da cena, o personagem tem um número de sucessos automáticos para resistir a todas as tentativas de desarmá-lo igual ao número de sucessos rolados. Ele não pode derrubar a lâmina acidentalmente (o que significa que suas falhas críticas provavelmente resultam em automutilação em vez de uma mão vazia). Se o personagem for de algum modo desarmado apesar de Agarrar da Montanha, ele pode chamar a lâmina de volta à mão invocando este poder com sucesso outra vez, desde que tenha linha de visão livre para a arma.

••• Perfurar a Pele do Aço
Neste nível de compreensão, o feiticeiro pode comandar sua lâmina com tal precisão que consegue golpear a proteção física de um oponente em vez do corpo dele. A espada transfere toda a sua fúria ao alvo pretendido, retalhando até a mais resistente cota ou placa. Isso arranca as defesas da vítima, deixando-a vulnerável ao próximo ataque. Embora este poder seja de utilidade limitada nas noites modernas, já que a armadura tradicional caiu em desuso, ele permanece na progressão de lições da trilha por sua utilidade em destruir outros obstáculos.
Sistema: Enquanto Perfurar a Pele do Aço estiver em efeito, um ataque contra um alvo sem armadura causa metade do dano (arredondado para baixo). Contudo, por um número de turnos igual ao número de sucessos rolados, cada ataque bem-sucedido que o personagem faz contra um inimigo blindado causa dano à armadura corporal do alvo em vez de feri-lo diretamente. Só armadura de metal pode ser danificada por este poder. Quando o personagem faz um ataque bem-sucedido contra um alvo blindado, o jogador não rola dano. Em vez disso, ele rola um número de dados igual ao bônus de dano da espada (o número de dados que ela soma à Força dele) contra dificuldade 7. Cada sucesso reduz em um dado o bônus de absorção da armadura. Armadura reduzida a zero dados de absorção desse modo é completamente destruída e irrecuperável. Sucessos adicionais além dos necessários para destruir uma peça de armadura não têm efeito.
A critério do Narrador, Perfurar a Pele do Aço pode destruir outros objetos inanimados (paredes, portas, carros, obstáculos dramaticamente apropriados) sem dano significativo à espada. Para os fins deste poder, Fortitude conta como parte do Vigor do alvo, não como armadura externa.

•••• Escudo da Navalha
Muitos espadachins sustentam que o duelo é o teste definitivo do guerreiro porque coloca todos os oponentes em pé de igualdade: a morte está a apenas um metro de aço de distância, e só a perícia dos combatentes determina quem sai andando. Contudo, observadores mais pragmáticos que românticos notam que um inimigo com uma arma de longo alcance (seja arco, funda ou arma de fogo) tem a vantagem de golpear de muito mais longe que o comprimento do braço. Embora o Despertar do Aço não consiga neutralizar completamente essa vantagem, este poder concede ao feiticeiro habilidoso alguma medida de defesa, enquanto a espada se interpõe entre seu mestre e os ataques vindos de longe.
Sistema: Por um número de turnos igual ao número de sucessos rolados, o personagem pode tentar aparar projéteis. Isso exige uma ação para cada projétil que o jogador queira bloquear, e o personagem precisa conseguir ver o disparo vindo (Sentidos Aguçados permite acompanhar balas visualmente). Cada tentativa de aparar exige uma rolagem de Destreza + Armas Brancas, com dificuldade determinada pela velocidade do projétil. Objetos arremessados têm dificuldade 6; flechas e virotes de besta, dificuldade 7; e balas, dificuldade 9. Cada sucesso subtrai um sucesso da rolagem de ataque do atacante.
Escudo da Navalha não permite ao personagem aparar ataques à distância que não envolvam projéteis sólidos, como fogo, relâmpago ou sangue cuspido.

••••• Golpear a Carne Verdadeira
Embora pacifistas possam encontrar outros usos para lâminas, um guerreiro sabe que espadas foram criadas para um propósito: talhar a carne do inimigo em ruína sangrenta. Golpear a Carne Verdadeira invoca a própria essência da arma do feiticeiro, reduzindo-a à encarnação de sua definição mais estrita (ou, como diriam os de mente mais clássica, invocando a forma platônica) enquanto simplifica seu alvo a um nível igualmente básico. Os resultados de tal invocação costumam ser devastadores tanto no plano filosófico quanto no prático, enquanto arma e vítima perdem momentaneamente todos os atributos sobrenaturais.
Sistema: Os efeitos de Golpear a Carne Verdadeira duram um número de turnos igual ao número de sucessos rolados, e terminam com o primeiro ataque bem-sucedido que o personagem fizer nesse período. A espada causa apenas a quantidade básica de dano letal que uma arma de seu tamanho e tipo normalmente causaria, desconsiderando todos os aprimoramentos que ela possa ter recebido (ainda que aumentos na força ou na velocidade do portador, como Potência e Celeridade, mantenham seus efeitos normais, assim como sucessos extras na rolagem de ataque).
Contudo, todas as defesas sobrenaturais do alvo (inclusive Fortitude) são igualmente anuladas — ele absorve o ataque apenas com seu Vigor básico. Se a anulação de seus poderes e defesas deixar o alvo incapaz de absorver dano letal, ele não pode absorver o ataque de forma alguma. Armadura corporal protege contra este ataque, por ser uma forma mundana de defesa.]==],
				},
				["Bone Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 164


Bone Path


A Trilha dos Ossos ocupa-se principalmente de cadáveres e dos métodos pelos quais almas mortas podem ser restauradas ao mundo dos vivos — temporariamente ou não.

• Tremens
Tremens permite ao necromante fazer a carne de um cadáver se mover uma vez. Um braço pode subitamente tombar para a frente, um cadáver pode se sentar, ou olhos mortos podem se abrir de repente. Esse tipo de coisa costuma causar um impacto impressionante em quem não espera que um parente falecido se revire no caixão.
Sistema: Para usar Tremens, o necromante gasta um único ponto de sangue, e o jogador precisa ter sucesso numa rolagem de Destreza + Ocultismo (dificuldade 6). Quanto mais sucessos obtidos, mais complicada pode ser a ação efetuada no cadáver. Um sucesso permite um movimento instantâneo, como um espasmo, enquanto cinco permitem ao vampiro estabelecer condições específicas sob as quais o corpo se anima ("Na próxima vez que alguém entrar na sala, quero que o cadáver se sente e abra os olhos."). Em nenhuma circunstância Tremens pode fazer um corpo morto atacar ou causar dano.

•• Vassouras do Aprendiz
Com Vassouras do Aprendiz, o necromante pode fazer um corpo morto se erguer e desempenhar uma função simples. Por exemplo, o cadáver pode ser posto a carregar objetos pesados, cavar ou apenas se arrastar de um lugar a outro. Os cadáveres assim animados não atacam nem se defendem se forem incomodados; em vez disso, tentam cumprir as instruções dadas até serem tornados inanimados. Em geral é preciso desmembramento, fogo ou algo semelhante para destruir um cadáver animado dessa forma.
Sistema: Uma rolagem de Raciocínio + Ocultismo (dificuldade 7) e o gasto de um ponto de sangue e um de Força de Vontade é tudo o que se precisa para animar cadáveres com Vassouras do Aprendiz. O número de cadáveres animados é igual ao número de sucessos obtidos. O necromante precisa então declarar a tarefa à qual está incumbindo seus zumbis. Os cadáveres se dedicam ao trabalho até terminarem o serviço (quando então desabam) ou até que algo (inclusive o tempo) os destrua.
Cadáveres animados dessa forma não têm iniciativa própria e são incapazes de fazer julgamentos de valor. Eles respondem a instruções bem literais. Assim, um zumbi pode ser mandado "varrer esta sala todo dia até que toda a poeira e teias de aranha sumam" ou "transcrever este manuscrito" com expectativa de resultados razoáveis, enquanto uma ordem mais aberta como "conserte esta motocicleta" ou "pesquise este ritual necromântico e anote os resultados" estaria fadada ao fracasso.
Corpos energizados por este poder continuam a se decompor, ainda que a uma taxa muito mais lenta que o normal.

••• Hordas Cambaleantes
Hordas Cambaleantes gera resultados óbvios: cadáveres reanimados com a capacidade de atacar, ainda que nem muito bem nem muito depressa. Uma vez preparados por este poder, os cadáveres esperam — por anos, se necessário — para cumprir a ordem que lhes foi dada. As ordens podem ser proteger determinado local ou simplesmente atacar de imediato, mas serão cumpridas até que o último dos monstros em decomposição seja destruído.
Sistema: O jogador gasta um ponto de Força de Vontade. O jogador precisa então ter sucesso numa rolagem de Raciocínio + Ocultismo (dificuldade 8). Cada sucesso permite ao vampiro erguer mais um cadáver da sepultura, e custa um ponto de sangue. Se o jogador não puder ou escolher não pagar o custo em sangue de zumbis adicionais além de certo número, os sucessos extras simplesmente se perdem. Cada zumbi pode seguir uma instrução simples, como "Fique aqui e guarde este cemitério contra quaisquer intrusos" ou "Mate-os!".
Nota: Zumbis criados por Hordas Cambaleantes esperarão para sempre, se preciso, para cumprir suas funções. Muito depois de a carne ter apodrecido e caído de seus ossos misticamente animados, os zumbis esperarão, esperarão e esperarão, ainda capazes de desempenhar seus deveres.

•••• Roubo de Alma
Este poder afeta os vivos, não os mortos. Ele, contudo, transforma temporariamente uma alma viva numa espécie de espectro, pois permite ao necromante arrancar uma alma de um corpo vivo. Um mortal exilado de seu corpo por este poder torna-se um espectro com um único laço com o mundo real: seu corpo agora vazio.
Sistema: O jogador gasta um ponto de Força de Vontade e então faz uma rolagem disputada de Força de Vontade contra a vítima pretendida (dificuldade 6). Os sucessos indicam o número de horas durante as quais a alma original fica forçada para fora de sua morada. O corpo em si permanece autonomicamente vivo, porém catatônico.
Este poder pode ser usado para criar hospedeiros adequados para Possessão Demoníaca. Não tem efeito sobre Membros ou outras criaturas sobrenaturais (exceto carniçais) enquanto tais criaturas não estiverem mortas — no caso de vampiros, isso significa a Morte Final.

••••• Possessão Demoníaca
Possessão Demoníaca permite ao vampiro inserir uma alma num corpo recém-morto. Isso não transforma o cadáver reanimado em nada além de um cadáver reanimado, que irrevogavelmente se decomporá depois de uma semana, mas dá a um espectro ou a uma alma solta (digamos, a de um vampiro usando Projeção Psíquica) um lar temporário no mundo físico.
Sistema: O corpo em questão não pode estar morto há mais de 30 minutos, e o novo inquilino precisa concordar em habitá-lo — um fantasma ou forma astral não pode ser forçado a entrar numa nova casca. Contudo, a maioria dos fantasmas agarraria a oportunidade de bom grado. Caso o vampiro, por qualquer razão, deseje inserir uma alma no cadáver de outro vampiro (antes que ele se desfaça em cinzas), o necromante precisa obter cinco sucessos numa rolagem resistida de Força de Vontade contra o dono original do corpo. Do contrário, o intruso tem a entrada negada.
Nota: A alma pode usar quaisquer habilidades físicas (Esportes, Briga, Potência) que seu novo lar de carne possua, e quaisquer habilidades mentais (Informática, Direito, Presença) que ela já possuísse. Ela não pode usar as habilidades físicas de sua forma antiga, nem as habilidades mentais da nova.]==],
				},
				["Cenotaph Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 166


Cenotaph Path


Praticantes da Trilha do Cenotáfio ocupam-se principalmente de descobrir ou forjar elos entre o mundo dos vivos e as Terras das Sombras. Ela funciona sobre o princípio de que um Membro, já um cadáver, é uma ponte antinatural entre os vivos e os mortos, e o necromante pode usar isso para encontrar outras ligações semelhantes. Os rudimentos básicos da Trilha do Cenotáfio funcionam com facilidade assim que o Membro aprende a se sintonizar com essas conexões. O domínio avançado da trilha em geral envolve algum ritual breve para forjar conexões artificiais, seja focalizando paixões desagradáveis, seja comandando este mundo e as Terras das Sombras em conjunto.

• Um Toque da Morte
Assim como um necromante pode exercer domínio sobre as Terras das Sombras, alguns fantasmas também podem se impor no mundo mortal. Enquanto manifestações óbvias de poder espectral, como paredes sangrando ou gemidos incorpóreos, certamente não passam despercebidas, algumas capacidades espectrais produzem efeitos sutis que não são facilmente reconhecidos. Um necromante sensibilizado ao resíduo dos mortos, porém, consegue sentir se um objeto foi tocado por um fantasma ou perceber a passagem recente de um espectro.
Sistema: O necromante simplesmente toca uma pessoa ou objeto que suspeita ser vítima de influência espectral. O jogador rola Percepção + Prontidão (dificuldade 6). Se tiver sucesso, o necromante consegue determinar se um fantasma exerceu algum tipo de poder sobre o sujeito, ou mesmo passou por perto, conforme a duração detalhada abaixo.
1 sucesso — Último turno; detecta uso de poderes espectrais.
2 sucessos — Últimos três turnos; detecta uso de poderes espectrais.
3 sucessos — Última hora; detecta o toque do fantasma e o uso de poderes espectrais.
4 sucessos — Último dia; detecta o toque do fantasma e o uso de poderes espectrais.
5 sucessos — Última semana; detecta a passagem próxima do fantasma, o toque dele e o uso de poderes espectrais.
Numa falha, o necromante não recebe impressão alguma. Uma falha crítica revela uma resposta enganosa (um objeto pode parecer tingido de poder espectral sem estar, ou vice-versa). Caso o necromante tenha sucesso na detecção enquanto toca um objeto ou pessoa que um fantasma esteja possuindo, ele imediatamente percebe que o fantasma ainda está lá dentro. A impressão obtida nesse caso basta para contar como uma imagem do espírito para os fins dos poderes da Trilha do Sepulcro, de modo que o Membro pode ser capaz de (por exemplo) ordenar imediatamente que um fantasma saia da pessoa que ele possui.

•• Revelar os Catene
Compulsões necrománticas funcionam muito melhor quando o conjurador usa um objeto significativo para o fantasma em questão. Tais grilhões prendem os mortos às terras dos vivos por sua importância lembrada — uma poltrona preferida para relaxar, uma peça de arte detestada empurrada por parentes odiados, ou algum objeto de emoção igualmente intensa. Muitos necromantes conseguem detectar tais catene pelo uso de rituais (ver Ritual do Grilhão Desenterrado, p. 181). Com este poder, porém, o necromante consegue determinar um grilhão com apenas alguns momentos de manuseio. O Membro simplesmente passa as mãos sobre o objeto e se concentra nele. Rapidamente recebe uma impressão da importância do item (ou da pessoa) para espectros, se houver; caso o espectro seja um que o necromante conheça, ele imediatamente reconhece o objeto como grilhão daquele (ou daqueles) fantasma(s). A identificação bem-sucedida de um fantasma ligado não é exclusiva; isto é, se o vampiro determina que o objeto é importante para determinado espectro, ele também pode determinar se há outros fantasmas ligados ao item, embora precise usar o poder de novo para obter as identidades deles.
Muitos necromantes usam este poder em objetos já identificados com Um Toque da Morte, a fim de determinar se o fantasma está tentando sintonizar determinado grilhão ou apenas brincando com o mundo dos vivos.
Sistema: O necromante segura e examina o objeto por pelo menos três turnos — se for um item, isso significa virá-lo nas mãos, correr os dedos por ele ou de outro modo lhe dar um olhar crítico; com uma pessoa, isso pode exigir um exame mais… invasivo… O jogador então gasta um ponto de sangue e rola Percepção + Ocultismo (dificuldade 7). Se tiver sucesso, o Membro determina se o objeto guarda algum significado para algum fantasma e, com três ou mais sucessos, a identidade de pelo menos um desses fantasmas (o que permite ao Membro usar a Trilha do Sepulcro naquele espectro, se quiser). Se o necromante já conhece algum dos fantasmas envolvidos, os laços deles são revelados junto com a identidade — assim, se o necromante já conhece um espectro bem o bastante para invocá-lo e compeli-lo com outros poderes, a identificação bem-sucedida de um grilhão diz se o objeto está ligado àquele fantasma, além de quaisquer outras impressões obtidas.
Se ocorrer uma falha crítica, o necromante nunca mais conseguirá usar este poder com sucesso no item examinado.

••• Pisar Sobre a Sepultura
A consciência ampliada concedida pela Trilha do Cenotáfio permite ao necromante encontrar locais onde as Terras das Sombras e o mundo dos vivos se aproximam. Muitas vezes o necromante sente um calafrio ou arrepio ao entrar numa área onde o Submundo está perto do mundo vivo. Com prática, o vampiro consegue dizer exatamente onde tais locais estão.
Necromantes experientes aprendem que certos locais são suscetíveis à influência espectral; essas áreas assombradas muitas vezes se tornam uma espécie de lar para fantasmas. Um vampiro instruído pode assim descobrir lugares onde os mortos provavelmente se reúnem, para melhor capturá-los com outros poderes de Necromancia.
Sistema: O jogador simplesmente declara a intenção de sentir o Sudário numa área e faz uma rolagem de Força de Vontade (dificuldade 8). O sucesso revela se o local é altamente sintonizado com as Terras das Sombras, se é mediano (não particularmente próximo do mundo dos mortos) ou se está bem distante do reino da morte. Uma tentativa fracassada de usar o poder não tem efeito adverso, embora só possa ser tentada uma vez por cena (de modo que o necromante precisa esperar um tempo ou se mover para outra área antes de tentar Pisar Sobre a Sepultura novamente).
Uma falha crítica atordoa o necromante à inação por um turno inteiro e lhe custa um ponto temporário de Força de Vontade, enquanto ele é dominado por arrepios e uma sensação de desespero avassalador.
Com três ou mais sucessos, o necromante consegue determinar se a força do Sudário foi artificialmente alterada na área.

•••• Dobre de Finados
Nem todos os que morrem se tornam fantasmas — muitos não têm o ímpeto de se agarrar depois da morte ou simplesmente não têm necessidades avassaladoras que os obriguem a ficar. Normalmente, nem mesmo necromantes têm como separar os que podem virar fantasmas da massa dos que seguem para quaisquer recompensas que os aguardem. Com o tempo, porém, um necromante pode se sensibilizar ao puxão que ocorre quando uma alma escapa de um corpo apenas para pairar à espera, escravizada por seus desejos. O peso do desespero torna-se como um puxão tangível, e alguns necromantes saboreiam essa emoção enquanto seguem a sensação para achar o novo fantasma.
Claro, de fato descobrir o novo fantasma pode ser problemático. O Membro pode precisar de algum meio de enxergar através do Sudário, ou ter de enviar outros espectros para procurar o novo infeliz, especialmente se um grande acidente ou massacre deixar cadáveres demais para o necromante distinguir e testar nomes com facilidade.
Sistema: Sempre que alguém morre e se torna fantasma a menos de um quilômetro do necromante, ela percebe automaticamente o falecimento (embora muitos escolham ignorar este poder "sempre ligado" a menos que estejam procurando alguém ativamente). Este poder não localiza nem identifica automaticamente o novo fantasma, mas o jogador pode gastar um ponto de Força de Vontade e rolar Percepção + Ocultismo (dificuldade 7) para que o necromante obtenha uma noção vaga da distância e da direção do novo espectro. Com um sucesso, o Membro pode sentir um puxão vago numa direção geral; com três sucessos, o necromante consegue sentir a direção e estimar a distância dentro de meio quilômetro. Com cinco sucessos, o necromante percebe imediatamente a localização do novo fantasma com precisão de 30 cm. Uma falha não acarreta penalidade, mas uma tentativa com falha crítica manda o necromante correr na direção errada.
O Narrador pode determinar que distúrbios no Submundo, magia interveniente ou outros fenômenos semelhantes turvem essa sensação, simplesmente para evitar sobrecarregar uma crônica com caça a fantasmas e rolagens constantes.

••••• Vínculo Efêmero
Os necromantes mais poderosos aprendem não só a sentir os laços entre vivos e mortos, mas a forjá-los eles mesmos. O mestre do Vínculo Efêmero transforma um objeto ou pessoa de resto mundanos num depósito de sua própria energia necromântica. A Maldição que não morre transforma o sujeito numa espécie de ligação entre vivos e mortos. O necromante lambuza seu sangue no item em questão, que misticamente absorve a vitae e, ao fazê-lo, torna-se um receptáculo para ancorar um espírito.
Sistema: O necromante precisa cobrir um objeto com seu sangue (o equivalente a um ponto de sangue inteiro); se o sujeito for uma pessoa, então esse indivíduo precisa ingerir a vitae. O jogador marca o ponto de sangue, gasta um ponto de Força de Vontade e rola Manipulação + Ocultismo (dificuldade 8). Se tiver sucesso, o item temporariamente se torna grilhão de um espectro. Se o Membro já sabe o nome do espectro ou tem uma impressão psíquica forte, então o objeto pode se tornar grilhão a qualquer distância, mesmo de um fantasma que normalmente não se aproxima do mundo dos vivos (desde que o fantasma ainda exista). Do contrário, o necromante precisa conseguir ver ou sentir o fantasma (com Testemunha da Morte, Visão do Sudário ou outros meios do tipo).
Um grilhão criado artificialmente dessa forma funciona, para todos os fins necrománticos e espectrais, como um grilhão normal: pode ser detectado com outros poderes de Necromancia, o vampiro ganha bônus em Necromancia contra o espectro sintonizado a ele, e o fantasma igualmente acha mais fácil exercer seus poderes sobre o sujeito (de modo que o vampiro pode transformar um carniçal desavisado em consorte de um espectro versado em possessão…). O fantasma pode mergulhar no grilhão para se curar; inversamente, se o grilhão for destruído, o espectro é banido para alguma região inacessível do Submundo, talvez para nunca mais voltar.
Um grilhão criado com Vínculo Efêmero dura uma noite por sucesso obtido. O gasto de um ponto adicional de Força de Vontade aumenta essa duração para uma semana por sucesso, ao passo que gastar um ponto permanente de Força de Vontade estende a duração para um ano e um dia.
Uma falha crítica com este poder não só causa o fracasso como também deixa o fantasma imediatamente ciente do que o necromante estava tentando fazer. A maioria dos fantasmas não recebe bem Membros intrometidos tentando fabricar correntes artificiais para eles.]==],
				},
				["Corpse in the Monster"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 168


Corpse in the Monster


Esta trilha aprofunda a compreensão necromântica da forma não-viva e permite ao usuário experimentar plenamente o cadáver como portal entre a vida e a morte. A trilha deixa o vampiro aplicar alguns traços de um cadáver a um vampiro, e ela pode aumentar ou reduzir esses traços em vários níveis do poder.

• Máscara da Morte
O personagem com esta capacidade pode assumir um semblante de morte ou infligir essa forma a outro vampiro. A carne da vítima fica pálida e fina (se já não estiver), e a pele se retesa contra o osso. Esta capacidade pode ser bem útil, pois permite a alguém se esconder à vista de todos numa tumba ou cripta a qualquer momento (embora o personagem continue tão vulnerável à luz do sol e ao fogo quanto sempre). Quando um necromante usa este poder em outro Membro, a vítima adquire o mesmo comportamento cadavérico. Nesse sentido, a capacidade funciona como uma espécie de maldição menor.
Sistema: O jogador gasta um ponto de sangue para o personagem adquirir a forma descrita. Os afligidos pela Máscara da Morte perdem dois pontos de Destreza e de Aparência (mínimo de 1 em Destreza e 0 em Aparência) pela duração do poder. O jogador também ganha dois dados extras em sua parada de Intimidação, caso queira aterrorizar espectadores. Além disso, se o personagem permanecer perfeitamente imóvel, observadores precisam de cinco sucessos numa rolagem de Percepção + Medicina (dificuldade 7) para distinguir o personagem de um cadáver comum. O jogador não precisa rolar nada para o personagem parar de se mover — vampiros não têm funções autonômicas.
Se o usuário infligir Máscara da Morte a outro vampiro, ele precisa gastar um ponto de sangue, tocar o alvo e então fazer uma rolagem de Vigor + Medicina (dificuldade igual ao Vigor do alvo + 3). A Máscara da Morte dura até o próximo pôr do sol, a menos que o personagem que criou a máscara queira extinguir seus efeitos antes.

•• Frio da Sepultura
Os mortos não sentem dor, embora a maioria dos não-mortos sinta. Com esta capacidade, o personagem pode assumir temporariamente a insensibilidade dos mortos, a fim de se proteger de danos físicos e emocionais. Ao assumir o Frio da Sepultura, a pele do vampiro fica anormalmente fria. Quando ela fala, seu hálito embaça mesmo no ar quente — quem tem sentidos excepcionais pode até ver um leve tom avermelhado no hálito.
O poder traz uma sensação de letargia sobre o personagem, como um mortal poderia sentir sob influência de uma doença levemente desagradável. Torna-se difícil se animar à ação, e muito pouco parece importante o bastante para realmente preocupar. Um cadáver não tem preocupações, afinal.
Sistema: O jogador gasta um ponto de Força de Vontade. Pelo resto da cena, o personagem não sofre penalidades por ferimento, e o jogador ganha um dado adicional em todas as paradas que envolvam resistir a manipulação emocional, como Intimidação ou Empatia. Contudo, o jogador também perde um dado das paradas para manipular emocionalmente os outros. O personagem é frio como um peixe para quem interage com ela, e as pessoas não respondem prontamente a ela. O Frio da Sepultura não protege o personagem contra as depredações da Besta. Ela pode estar emocionalmente fria na superfície, mas se outros a provocarem e enfurecerem o bastante, ela ainda está sujeita a frenesi normalmente.

••• Maldição da Vida
A Maldição da Vida inflige alguns dos traços indesejáveis dos vivos aos não-mortos, removendo sua natureza cadavérica e criando uma vida falsa para lembrá-los das piores coisas de estar vivo. Alvos deste poder recuperam apenas os aspectos desagradáveis da vida, colhidos da memória do usuário da Disciplina. Isso pode incluir fome e sede mundanas, suor e outras excreções, a necessidade de urinar e defecar, uma diminuição da acuidade sensorial e uma vulnerabilidade particular a ataques que o personagem normalmente desprezaria.
Sistema: O jogador gasta um ponto de Força de Vontade e rola Inteligência + Medicina (dificuldade 8) para afetar um alvo na linha de visão e a não mais que 20 metros do personagem. Se a rolagem tiver sucesso, o alvo sofre as fraquezas dos vivos sem ganhar nenhum benefício desse estado. Ele não se torna imune à luz do sol ou a artefatos sagrados, por exemplo. Contudo, fica seriamente distraído por necessidades mundanas, com o resultado líquido de que seu jogador sofre penalidade de +2 de dificuldade em todas as rolagens. Ele pode ignorar essas distrações ao custo de um ponto de Força de Vontade por cena. Além disso, a vítima não pode usar sangue para aumentar seus Atributos Físicos enquanto este poder estiver em efeito, e Força de Vontade não pode eliminar essa penalidade. O poder permanece em efeito até o próximo pôr do sol.

•••• Dádiva do Cadáver
Este poder, um dos mais potentes da trilha O Cadáver no Monstro, permite ao necromante ignorar a maioria das fraquezas inerentes à sua raça por um curto período. Um corpo morto não é particularmente vulnerável à luz do sol, a artefatos sagrados, ao frenesi ou a ser estacado no coração, afinal, e assim é com um vampiro usando a Dádiva do Cadáver. Como com o Frio da Sepultura, acima, o personagem que usa este poder assume um aspecto ainda mais mortiço. Dura menos de um minuto, tipicamente, mas esse tempo pode bastar para permitir a um personagem atravessar correndo um prédio em chamas sem temer frenesi ou morte instantânea.
Sistema: O jogador gasta um ponto de Força de Vontade e rola Vigor + Ocultismo (dificuldade 8). Para cada sucesso, o personagem pode passar um turno num estado em que é mais parecido com um cadáver animado do que com um vampiro. Artefatos sagrados e solo sagrado não têm efeito, e o personagem fica imune a frenesi e a Rötschreck. A luz do sol causa apenas dano contundente, e ainda assim só se houver pele nua exposta num dia claro. Ser estacado no coração é apenas tão perigoso quanto ser apunhalado no baço morto dele. O fogo o fere apenas como feriria um mortal — causando dano letal em vez de agravado.
Caso o personagem chegue ao fim da duração do poder enquanto exposto a qualquer das coisas nocivas mencionadas, ele imediatamente sofre o efeito pleno delas. Se estiver estacado, fica imobilizado; se estiver em ou perto do fogo, começa a sofrer o dano que um Cainita deveria sofrer, e precisa rolar imediatamente contra Rötschreck.

••••• Dádiva da Vida
Com a Dádiva da Vida, o personagem pode experimentar as melhores e mais positivas coisas de estar vivo. A fome avassaladora por sangue abranda temporariamente, permitindo ao personagem consumir e apreciar comida e bebida. Ela também pode desfrutar de sexo como quiser, e o sol não a queima. A Dádiva da Vida vem com um custo sombrio e terrível, porém. Seu uso quase certamente resulta na morte de um mortal, pois o vampiro precisa gastar uma quantidade enorme de vitae para iniciá-la. Os efeitos da Disciplina duram até a meia-noite seguinte ao uso do poder, de modo que é do interesse dela usá-lo logo depois da meia-noite.
Sistema: O jogador gasta 12 pontos de sangue, queimando o máximo de sangue possível a cada turno até atingir esse patamar. Ela então rola Vigor + Ocultismo (dificuldade 6) e precisa de apenas um sucesso para o poder funcionar. Uma falha crítica tem efeitos catastróficos. O personagem pode ser morto instantaneamente ou pode inadvertidamente Abraçar sua vítima, por exemplo. Se levar mais de um turno para gastar o sangue necessário para efetivar esta capacidade, ela não entra em efeito até que todos os 12 pontos tenham sido gastos. Contudo, o sangue precisa ser gasto continuamente — o vampiro não pode queimar cinco, sair para se alimentar e queimar mais sete uma hora depois. Por outro lado, ela pode se alimentar enquanto ativa o poder — num turno pode queimar um ponto de sangue enquanto bebe três. Como poucos Membros acima da Sétima Geração conseguem gastar tal quantidade de sangue com facilidade, a forma mais eficiente de ativar este poder é ter um humano por perto que possa ser sacrificado para alimentar a transformação.
Depois da transformação, o personagem ganha muitos traços de um humano comum. Ela fica em grande parte imune aos efeitos escaldantes do sol (dificuldades de Fortitude para absorver dano de luz solar direta são reduzidas à metade, e ela não sofre dano se estiver suficientemente coberta), e pode experimentar e apreciar muitas das coisas boas da vida humana. Ela mantém alguns de seus benefícios vampíricos, contudo. Fortitude e Auspícios continuam funcionando se ela tiver qualquer uma dessas Disciplinas, e o Narrador pode permitir que ela mantenha outras Disciplinas também, se julgar dramaticamente apropriado. Ela também mantém os benefícios de um vampiro no que toca a lidar com dano contundente. Contudo, ela ainda é vulnerável a artefatos sagrados, à fé humana e a ser estacada. Seu sangue continua sendo vitae, não sangue humano. O uso desta capacidade — que cria um arremedo da vida humana — pode interferir no avanço de Caminho do personagem, a critério do Narrador.
O vampiro não é mais vulnerável ao fogo que qualquer outro mortal enquanto está nesse estado semivivo, mas ainda sofre um pouco com a Besta. As dificuldades de frenesi e Rötschreck são reduzidas à metade (arredondando para cima). Ela pode permanecer ativa durante o dia sem os limites de parada de dados por Humanidade ou Caminho, embora esteja certamente cansada durante o dia, já que esse não é seu horário habitual de atividade.
Sua Besta cobra uma retribuição perigosa quando seu dia de "vida" termina. Embora a influência dela seja bastante suprimida durante a duração deste poder, a Besta faz o que quer com o vampiro pelas seis noites seguintes, pois todas as dificuldades para resistir a frenesi aumentam em três. O necromante sábio se esconde em algum lugar durante esse período, mas, dependendo de moral e temperamento, o isolamento forçado pode levá-la ao frenesi por si só.]==],
				},
				["Die Herrschaft des Wyrm"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 109


Die Herrschaft des Wyrm


Die Herrschaft des Wyrm (Tirania do Wyrm) é uma Trilha recente, praticada primeiro por uma linhagem de taumaturgos Malkavianos na região de Hesse, dentro dos Feudos da Cruz Negra. Diz-se que foram tutelados por demônios balbuciantes a serviço de um dragão de três cabeças; os magos de sangue neófitos logo abraçaram o infernalismo com o objetivo de suplantar os embrionários Tremere e auxiliar aliados Salubri em sua retribuição contra os Usurpadores. Tragicamente, o preço de lidar com o profano logo arrastou os Malkavianos para longe do rumo pretendido.
Um gravador Malkaviano, ou "zettler", como o chamava o povo nativo de Hesse, traiu toda a sua linhagem em sacrifício ao dragão. Em troca, obteve conhecimento pleno da Tirania do Wyrm e dádivas que lhe permitiram poderes além de seus anos de neonato. O desaparecimento recente do zettler, e a subsequente descoberta por outros Cainitas de seus pergaminhos perfeitamente preservados detalhando a Trilha, levou ao surgimento de uma leva de infernalistas intrépidos na região.
Todos os efeitos de Trilha de Taumaturgia Negra que tenham alvo podem ser resistidos com uma rolagem de Força de Vontade (dificuldade 6, mais o nível de Taumaturgia Negra do infernalista, até o máximo de 9).
Preço: Como o clã responsável por sua criação, Die Herrschaft des Wyrm é instável. Caso a vítima perceba que está sendo afetada, por aviso prévio ou por evidência da intenção do infernalista, ela pode fazer uma rolagem de Raciocínio + Ocultismo (dificuldade igual à Força de Vontade permanente do infernalista, exigindo tantos sucessos quantos forem os pontos de Taumaturgia Negra do infernalista). Seu sucesso faz os efeitos do poder ricochetearem sobre o infernalista. Uma falha crítica em qualquer rolagem de Die Herrschaft des Wyrm também faz os efeitos afligirem o infernalista.
Uma bênção de alguém com Fé Verdadeira remove quaisquer efeitos nocivos causados por esta Disciplina. A morte do infernalista não remove esses efeitos, pois em seu lugar os demônios perpetuarão as várias maldições e dores.

• Infecção Malfeana
Pelo uso da Infecção Malfeana, o infernalista profana um indivíduo sagrado, corroendo sua Fé Verdadeira sem que a vítima sequer saiba que o poder está agindo.
Sistema: O infernalista precisa saber o nome de seu alvo e pintar um olho na própria palma com vitae. Para cada sucesso no uso da Trilha, a vítima perde quaisquer poderes associados à sua Fé Verdadeira por um número de noites:
1 sucesso — Uma noite
2 sucessos — Três noites
3 sucessos — Uma semana
4 sucessos — Um mês
5 sucessos — Um ano
6 ou mais sucessos — Permanente (ou até ser removido por uma bênção)
Se refletido de volta sobre o infernalista por causa de uma falha crítica ou de a vítima combater o efeito com sucesso numa rolagem de Raciocínio + Ocultismo, a Infecção Malfeana impede o uso de Taumaturgia Negra por um número de noites correspondente ao número de sucessos, conforme indicado acima. Essa limitação pode ser removida por um novo acordo de subserviência com um demônio.

•• Ruína para a Alma
Os Malkavianos que forjaram Die Herrschaft des Wyrm comungaram com demônios espirituais chamados "Ruínas" (Banes), que eles descobriram poder ser invocados e presos às almas de seus inimigos. Ao enxertar uma Ruína num inimigo, descobriram que a vítima ficaria inclinada a agir segundo todos os seus piores impulsos.
Sistema: O infernalista precisa segurar um item ou artigo outrora tocado por seu alvo e pingar vitae sobre ele. Uma Ruína demoníaca se prenderá à alma do alvo com um sucesso, aumentando em +2 a dificuldade dos testes de Virtude (até o máximo de 9). Cada sucesso determina quanto tempo a Ruína permanece:
1 sucesso — Uma noite
2 sucessos — Três noites
3 sucessos — Uma semana
4 sucessos — Um mês
5 sucessos — Um ano
6 ou mais sucessos — Permanente (ou até ser removido por uma bênção)

••• Miserere Dissonante
Por meio de cânticos, encantamentos e um matraquear inspirado, o infernalista penetra a mente da vítima com o ruído incessante de seus delírios. A cacofonia de um Miserere Dissonante persiste noite após noite, plantando na mente da vítima a semente de que só se encontra refúgio invocando um demônio da loucura, que talvez remova o balbucio. O poder age como porta para tal demônio, à espera de golpear quando a vítima estiver mais fraca. A vítima precisa implorar para que o demônio atravesse para que isso aconteça.
Sistema: O infernalista precisa possuir um pedaço de pele, cabelo ou unha da vítima e embebê-lo em vitae. As bocas gritantes do Wyrm entram na mente da vítima, aumentando a dificuldade de todos os testes de Força de Vontade e de qualquer teste que exija concentração em um ponto por sucesso rolado (até o máximo de dificuldade 9), e retiram um ponto temporário de Força de Vontade da vítima a cada noite em que permanecem.
O efeito é permanente, até a vítima receber uma bênção ou invocar um demônio da loucura para aliviá-la dessa dor. Se ocorrer o segundo caso, o demônio — uma criatura guinchante sem forma tangível — oferecerá à vítima uma trégua em troca de um serviço. A natureza desse serviço depende de quão fraca de vontade o demônio julga estar a vítima nesse momento (e é determinada pelo Narrador), mas pedidos típicos incluem o assassinato de um inocente, o despojamento de todos os bens materiais ou um sacrifício de vitae ao infernalista.

•••• Alimentar o Wyrm
Ao beber o sangue de sua vítima, o infernalista cria um elo simpático entre seus mestres demoníacos e o vampiro alvejado. Esse elo causa agonia, e às vezes até a morte, enquanto a magia do infernalista torce e mutila o corpo da vítima. Só há trégua se o sofredor concordar em servir ao Wyrm com atos vis futuros.
Sistema: O infernalista precisa possuir uma porção (um ponto de sangue) do sangue da vítima, misturar sua vitae a ele e beber a mistura. Isso pode formar um laço de sangue, se o sangue for de outro vampiro. Uma vez engolido o sangue, uma rolagem bem-sucedida inflige um nível de dano agravado por sucesso. Esse dano pode ser absorvido com Fortitude. O corpo da vítima se contorce de dor e manifesta excrescências desumanas, reduzindo sua Aparência em dois pontos. A perda de Aparência é cumulativa se este poder for usado mais de uma vez.
A vítima só pode recuperar sua Aparência concordando em servir ao Wyrm. Se o fizer, um demônio de desejo ligado à vaidade aparece numa superfície reflexiva e exige um sacrifício, cuja severidade é determinada pelo tamanho da perda de beleza ocorrida. Sacrifícios podem envolver arrancar o sorriso do rosto de um recém-nascido, matar uma dúzia de virgens ou a vítima permitir que um Maeljin habite sua alma permanentemente.

••••• Hospedar o Maeljin
Segundo os taumaturgos Malkavianos que fundaram esta Trilha, os Maeljin estão entre os mais poderosos e sábios dos demônios. Essas encarnações de vício, imundície e imoralidade são mestres das Ruínas e semideuses extradimensionais. Hospedar o Maeljin permite ao infernalista servir de hospedeiro a um dos Maeljin, à custa de um sacrifício terrível. Os benefícios de poder por hospedar um Maeljin são numerosos. O custo moral é imenso.
Sistema: O infernalista precisa assassinar um mortal ou vampiro com quem mantenha relação próxima. Se a vítima for um vampiro, o infernalista precisa cometer diablerie em sua presa. Uma rolagem bem-sucedida manifesta um dos Maeljin no corpo do infernalista. Cada sucesso determina quanto tempo o Maeljin permanece:
1 sucesso — Uma cena
2 sucessos — Uma noite
3 sucessos — Duas noites
4 sucessos — Quatro noites
5 sucessos — Uma semana
6 ou mais sucessos — Permanente (ou até ser removido por uma bênção)
Se o Maeljin permanecer permanentemente, o vampiro corre o risco de perder todo o controle para o demônio dentro dele. Torna-se então uma corrida para alcançar a purificação antes que o Maeljin possa exercer domínio absoluto.
As naturezas dos vários Maeljin diferem. Como seres de profanidade elemental, eles representam pecados abstratos, como vergonha, perda, raiva e uma multidão de outros conceitos intangíveis. Todos os Maeljin fortalecem seu hospedeiro com seis pontos para distribuir entre Atributos (nenhum Atributo pode ganhar mais de dois), seis pontos para distribuir entre Habilidades e seis pontos para distribuir entre Disciplinas (nenhuma Disciplina pode ganhar mais de dois). O Narrador decide onde esses pontos são alocados na ficha.
Como exemplos de como um Maeljin possuidor pode fortalecer seu hospedeiro: um Maeljin da Luxúria pode alocar seis pontos entre Atributos Sociais, colocar três pontos em Performance e outros três em Expressão, com dois pontos indo para Presença, mais dois para Dominação e os dois finais em Daimoinon. Um Maeljin das Mentiras pode alocar dois pontos em Manipulação, dois em Inteligência e dois em Destreza, com seis pontos espalhados entre Habilidades coercitivas. Os seis finais podem ir para Ofuscação, Presença e Quimerismo.
Um Maeljin habitante permite ao hospedeiro praticar livremente os poderes que concedeu. Ele quer o hospedeiro fortalecido e terrível. Contudo, ocasionalmente tentará influenciar ou controlar abertamente seu hospedeiro para agir de modos favoráveis à sua agenda alienígena. Nesses casos, o vampiro precisa fazer uma rolagem de Instinto/Autocontrole (dificuldade 8) para não agir do modo que o Maeljin deseja. O Narrador determina os desejos do Maeljin. Ele pode tentar exercer controle uma vez por noite.
Conforme o Maeljin se aproxima do fim de sua habitação, ele busca consumir o hospedeiro levando-o a um ato de autodestruição. O Maeljin só pode tentar isso uma vez, mas, para resistir a se lançar numa pira, saudar o sol ou entrar num edifício santificado, o vampiro precisa ter sucesso numa rolagem de Coragem (dificuldade 9). Se sua coterie tentar contê-lo, ele imediatamente cai em frenesi. O Maeljin partirá em paz se não tiver êxito em sua tentativa de reclamar a alma inteira de seu hospedeiro.]==],
				},
				["Elemental Mastery"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 214


Elemental Mastery


Esta trilha concede ao vampiro controle limitado sobre objetos inanimados e comunhão com eles. Domínio Elemental só pode ser usado para afetar o não-vivo — um vampiro não poderia fazer uma árvore andar usando Animar o Imóvel, por exemplo. Taumaturgos que buscam domínio sobre coisas vivas geralmente estudam trilhas como a Trilha Verde (p. 215).

• Força Elemental
O vampiro pode extrair a força e a resistência da terra, ou dos objetos ao seu redor, para aumentar sua proeza física sem precisar de grandes quantidades de sangue.
Sistema: O jogador distribui um total de três pontos temporários de bônus entre a Força e o Vigor do personagem. O número de sucessos na rolagem para ativar o poder é o número de turnos que esses pontos permanecem. O jogador pode gastar um ponto de Força de Vontade para aumentar essa duração em um turno. Este poder não pode ser "acumulado" — uma aplicação precisa expirar antes que a seguinte possa ser feita.

•• Línguas de Madeira
O vampiro pode falar, ainda que de forma limitada, com o espírito de qualquer objeto inanimado. A conversa pode não ser incrivelmente interessante, já que a maioria das pedras e cadeiras tem pouca preocupação com o que ocorre à volta delas, mas o vampiro consegue ao menos uma impressão geral do que o sujeito "vivenciou". Note que eventos significativos para um vampiro podem não ser os mesmos que interessam a um gnomo de jardim.
Sistema: O número de sucessos dita a quantidade e a relevância da informação que o personagem recebe. Um sucesso pode render a lembrança que um pedregulho tem de um incêndio florestal, enquanto três podem indicar que ele se recorda de uma figura sombria passando correndo, e cinco farão a pedra relatar uma descrição precisa de um Gangrel local.

••• Animar o Imóvel
Objetos afetados por este poder se movem conforme o vampiro que o usa determina. Um objeto não pode realizar uma ação completamente inconcebível para algo com sua forma — por exemplo, uma porta não poderia saltar das dobradiças e carregar alguém pela rua. Contudo, objetos aparentemente sólidos podem se tornar flexíveis dentro do razoável: banquetas podem correr com as pernas, armas podem se torcer para fora das mãos dos donos ou disparar dentro do coldre, e estátuas humanoides podem se mover como humanos normais.
Sistema: Este poder exige o gasto de um ponto de Força de Vontade com menos de quatro sucessos na rolagem. Cada uso deste poder anima um objeto não maior que o tamanho humano; o conjurador pode controlar simultaneamente um número de objetos animados igual à sua Inteligência. Objetos animados por este poder permanecem animados enquanto estiverem na linha de visão do conjurador ou por até uma hora, embora o taumaturgo possa realizar outras ações nesse período.

•••• Forma Elemental
O vampiro pode assumir a forma de qualquer objeto inanimado de massa aproximadamente igual à sua. Uma escrivaninha, uma estátua ou uma bicicleta seriam viáveis, mas uma casa ou uma caneta estariam além da capacidade deste poder.
Sistema: O número de sucessos determina quão completamente o personagem assume a forma que deseja imitar. São necessários ao menos três sucessos para o personagem usar seus sentidos ou Disciplinas enquanto estiver na forma alterada. Este poder dura o resto da noite, embora o personagem possa voltar à sua forma normal à vontade.

••••• Invocar Elemental
O vampiro pode invocar um dos espíritos tradicionais dos elementos: uma salamandra (fogo), uma sílfide (ar), um gnomo (terra) ou uma ondina (água). Alguns taumaturgos afirmam ter contatado espíritos elementais de vidro, eletricidade, sangue e até energia atômica, mas tais relatos seguem não confirmados (mesmo enquanto seus autores são convocados a Viena para interrogatório). O conjurador pode escolher que tipo de elemental deseja invocar e comandar.
Sistema: O personagem precisa estar perto de alguma quantidade do elemento clássico correspondente ao espírito que deseja invocar. O espírito invocado pode ou não seguir de fato as instruções do conjurador depois de invocado, mas em geral ao menos dará atenção aproximada ao que lhe for mandado fazer. O número de sucessos obtidos na rolagem de Força de Vontade determina o nível de poder do elemental.
O elemental tem três pontos em todos os Atributos Físicos e Mentais. Um ponto pode ser somado a um dos Atributos Físicos do elemental para cada sucesso obtido pelo conjurador na rolagem inicial. O Narrador deve determinar as Habilidades, os ataques e o dano do elemental, e quaisquer poderes especiais que ele tenha relacionados a seu elemento.
Uma vez invocado o elemental, o taumaturgo precisa exercer controle sobre ele. Quanto mais poderoso o elemental, mais difícil é essa tarefa. O jogador rola Manipulação + Ocultismo (dificuldade igual ao número de sucessos obtidos na rolagem de conjuração + 4), e o número de sucessos determina o grau de controle:
Falha crítica — O elemental ataca imediatamente o taumaturgo.
Falha — O elemental fica livre e pode atacar qualquer um ou deixar a cena, a critério do Narrador.
1 sucesso — O elemental não ataca quem o invocou.
2 sucessos — O elemental se comporta favoravelmente com quem o invocou e pode prestar um serviço em troca de pagamento (determinado pelo Narrador).
3 sucessos — O elemental presta um serviço, dentro do razoável.
4 sucessos — O elemental realiza qualquer tarefa para o conjurador que não ponha em risco a própria existência.
5 sucessos — O elemental realiza qualquer tarefa que o conjurador lhe determinar, mesmo uma que leve várias noites para ser concluída ou que coloque sua existência em risco.]==],
				},
				["Grave’s Decay"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 171


Grave’s Decay


Esta trilha deriva da observação da ação do tempo sobre todas as coisas mortais. A pedra se esfarela e o cadáver apodrece até virar nada, um processo de fascínio infindável para os Cainitas perdidos conhecidos como Cappadocius. De fato, para os que não morrem, o processo de decomposição é uma doença fascinante que aflige todos e tudo, menos eles. Sob esta trilha, um praticante de Necromancia canaliza essa força.

• Destruir a Casca
Cainitas que matam suas vítimas, em vez de apenas se alimentarem delas, frequentemente se veem precisando de um jeito rápido de se livrar de um cadáver. Embora haja muitas maneiras de garantir que um cadáver não seja encontrado — dá-lo a uma matilha de cães ou colocar-lhe peso e jogá-lo num rio —, muitos desses métodos envolvem risco para o vampiro e não têm sucesso garantido. Destruir a Casca, em contraste, é infalível. O uso deste poder simplesmente transforma um cadáver humano num monte de cerca de 13 quilogramas de pó nada notável, com aproximadamente o tamanho e a forma daquele corpo.
Sistema: O jogador gasta um ponto de sangue enquanto o vampiro pinga sua vitae sobre o cadáver. O jogador então rola Inteligência + Medicina (dificuldade 6). Um sucesso é tudo o que se precisa para reduzir o cadáver a pó, embora o processo leve um número de turnos igual a cinco menos os sucessos.

•• Rigor Mortis
Uma das primeiras mudanças que sobrevêm a um corpo morto é a rigidez; o cadáver fica duro como tábua, congelado numa única pose. O Cainita que empunha Rigor Mortis é capaz de levar um corpo vivo ou não-morto a esse ponto de rigidez usando apenas sua vontade e sua compreensão das forças da decomposição. Ela força seu alvo a ficar rígido e incapaz de se mover sem enorme esforço de vontade, enquanto os próprios músculos o traem.
Sistema: O jogador gasta um ponto de Força de Vontade e rola Inteligência + Medicina (dificuldade 7). Cada sucesso congela o alvo no lugar por um turno. Uma falha indica simplesmente a perda do ponto de Força de Vontade, enquanto uma falha crítica torna o alvo imune aos poderes da trilha Decomposição da Sepultura pelas próximas 24 horas. O alvo precisa estar visível e a cerca de 25 metros para que esta capacidade tenha efeito. Um alvo congelado é tratado como se tivesse sido estacado (ver p. 280). Com uma rolagem de Força de Vontade (dificuldade 7) e dois sucessos, o alvo pode se libertar da rigidez em seu turno. A falha lhe causa um nível de dano contundente e significa mais um turno desperdiçado e congelado.

••• Mirrar
Lembrando alguns dos poderes de Vicissitude, Mirrar permite ao vampiro aleijar o membro de um oponente. Seja o inimigo vivo ou não-morto, o músculo definha, a pele descasca e o osso se torna quebradiço. O alvo fica incapaz de exercer qualquer força digna de nota no membro aleijado. Este ferimento dura muito mais do que a maioria dos ferimentos incomoda vampiros e, em mortais, simplesmente não se cura.
Mirrar não precisa ser usado num membro, embora esse seja seu propósito habitual. Também pode ser usado simplesmente para afetar o rosto e o cabelo do alvo, fazendo-o parecer muito mais velho do que é. Também pode ser aplicado ao olho ou ouvido de um alvo, matando o sentido naquele órgão (e exigindo, assim, dois usos para cegar ou ensurdecer permanentemente). Mirrar não pode ser usado como poder de "morte instantânea" — necromantes não podem mirrar órgãos internos —, mas pode infligir uma ampla variedade de ferimentos a um inimigo.
Sistema: O jogador gasta um ponto de Força de Vontade. O personagem escolhe um membro do alvo e então toca esse membro. Se o alvo estiver tentando evitar contato, o jogador do invocador rola Destreza + Briga para acertar normalmente. Se o personagem tiver sucesso em tocar o membro pretendido, o alvo sofre dois ferimentos agravados. A menos que o alvo absorva ambos os ferimentos (com Fortitude, por exemplo), o membro atingido fica aleijado e inutilizável até que ambos os ferimentos tenham sarado. Membros curam os ferimentos como fariam com qualquer outro ferimento agravado (ver p. 285). Mortais são incapazes de curar ferimentos agravados, então sofrem pelo resto da vida a menos que sejam curados por meios sobrenaturais. Um membro mirrado não se degenera mais, nem mesmo num mortal. O personagem pode ficar aleijado para a vida, mas o membro não infecciona nem gangrena.
Os efeitos do mirramento dependem do membro afetado. Um braço aleijado tem Força 0, não pode se beneficiar de Potência e não pode carregar nada mais pesado que cerca de 200 gramas. Uma perna aleijada impede o personagem de se mover mais rápido que um pulo trôpego ou um manquejar arrastado. O personagem sofre os efeitos do Defeito Manco (ver p. 482). Um único olho ou ouvido mirrado impõe +1 de dificuldade às rolagens de Percepção pertinentes. Perder ambos os olhos ou ambos os ouvidos impõe os efeitos dos Defeitos Cego ou Surdo (ver pp. 484 e 483). Uma língua mirrada impõe os efeitos do Defeito Mudo (p. 483), enquanto um rosto mirrado reduz a Aparência do alvo em um para cada ferimento agravado sofrido.

•••• Corromper a Carne Não-Morta
Corromper a Carne Não-Morta borra a linha entre vida e não-vida, transformando uma criatura não-morta em algo vivo o bastante para carregar e sofrer de doença. A doença aflige o alvo, causando letargia, tontura, perda de força, falta de coordenação e a incapacidade de manter o sangue no organismo. Essa influência perniciosa é extremamente virulenta entre mortais. Eles contraem a doença simplesmente passando algumas horas perto da vítima. Outros vampiros têm mais dificuldade em contrair a doença. Precisam consumir o sangue da vítima para tanto, mas depois disso sofrem tanto quanto o alvo original — inclusive transmitindo a aflição a outros.
A doença some depois de cerca de uma semana.
Sistema: A jogadora escolhe um alvo na linha de visão de sua personagem e a não mais que 20 metros. Ela rola Inteligência + Medicina (dificuldade 6) e gasta um ponto de Força de Vontade. O jogador da vítima precisa rolar Vigor (+ Fortitude, se apropriado) contra dificuldade igual à Força de Vontade da atacante. Se a jogadora obtiver mais sucessos que a vítima, esta contrai imediatamente uma doença virulenta. A doença tem os seguintes efeitos:
• A Força e o Raciocínio da vítima são reduzidos à metade (arredondando para baixo).
• A vítima perde um ponto de Destreza.
• O jogador da vítima precisa gastar um ponto adicional de sangue toda noite para o vampiro despertar à consciência. Mortais perdem um nível de vitalidade por dia em vez disso.
• O jogador da vítima precisa rolar Autocontrole ou Instinto cada vez que o personagem se alimentar (dificuldade 8). Numa falha, o vampiro não consegue manter dentro do corpo o sangue que acabou de ingerir, e o vomita em grandes jorros horrendos de sangue, perdendo qualquer benefício que o sangue pudesse ter dado. Humanos vomitam comida.
Toda noite ao pôr do sol, a vítima tem uma chance de se livrar da praga. O jogador da vítima rola Vigor, com dificuldade igual a 10 menos o número de poentes desde que contraiu a praga. Numa rolagem bem-sucedida, o personagem contém a doença e começa a se recuperar. Ele recupera instantaneamente sua capacidade de reter sangue, e recupera um ponto de Atributo perdido por hora até que todos tenham voltado.

••••• Dissolver a Carne
Esta capacidade fecha o círculo da trilha Decomposição da Sepultura, pois faz Destruir a Casca se aplicar a vampiros. Dissolver a Carne permite ao necromante tentar transformar carne vampírica em pó ou cinza, como se o alvo tivesse sido queimado ou deixado ao sol.
Sistema: O jogador gasta dois pontos de sangue e um ponto de Força de Vontade enquanto o vampiro extrai uma quantidade de sua vitae carregada com o poder da sepultura. Se ela a pingar sobre um único Membro vítima em algum dos poucos turnos seguintes (a maior parte do sangue precisa alcançar a vítima, de modo que atirar algumas gotas é ineficaz), isso faz pedaços inteiros do corpo da vítima se desfazerem em cinzas. O jogador rola Força de Vontade contra dificuldade igual ao Vigor da vítima + 3. Para cada sucesso, o alvo sofre um ferimento agravado.
A carne não-morta danificada por este poder vira pó (perdido por ora), e precisa ser regenerada penosamente pela vítima, caso ela sobreviva. Esse pó sem dúvida tem propriedades místicas que vários feiticeiros poderiam aproveitar. Cada ferimento infligido por esta capacidade representa a perda de cerca de um oitavo do peso do alvo; o Narrador escolhe de onde vem a perda. (Ela também pode se distribuir por todo o corpo, deixando a vítima um pouco mais esquelética ou faltando pedaços de carne.)
A regeneração de partes do corpo ocorre naturalmente enquanto se curam ferimentos agravados na taxa normal (ver p. 285).]==],
				},
				["Hands of Destruction"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 217


Hands of Destruction


Esta Trilha é praticada mais comumente pelos vários taumaturgos do Sabbat. Embora não seja muito vista fora dessa Seita, alguns Tremere da Camarilla conseguiram aprender os segredos desta trilha ao longo dos séculos. As Mãos da Destruição têm uma história infame, e alguns Tremere se recusam a praticá-la por causa de rumores de que seria de origem demoníaca.

• Decomposição
Este poder acelera a decrepitude de seu alvo, fazendo-o murchar, apodrecer ou de outro modo se desfazer. O alvo precisa ser inanimado, embora matéria orgânica morta possa ser afetada.
Sistema: Se a rolagem tiver sucesso, o objeto inanimado tocado pelo taumaturgo envelhece 10 anos a cada minuto em que o Membro o toca. Se o vampiro romper o contato físico e desejar envelhecer o objeto de novo, outro ponto de sangue precisa ser gasto e outra rolagem precisa ser feita. Este poder não afeta vampiros.

•• Retorcer a Madeira
Este poder deforma e entorta objetos de madeira. Embora a madeira não seja de resto danificada, este poder muitas vezes deixa os objetos completamente inúteis. Este poder também pode ser usado para inchar ou contrair a madeira, além de dobrá-la em formas insalubres. Diferentemente dos outros poderes desta trilha, Retorcer a Madeira exige apenas um olhar, em vez de contato físico.
Sistema: Vinte e cinco quilos de madeira visível podem ser retorcidos para cada ponto de sangue gasto neste poder (o taumaturgo pode gastar quanto sangue quiser neste poder, até seu máximo geracional por turno). Também é possível deformar múltiplos objetos visíveis — como todas as estacas que uma equipe de caçadores de vampiros empunha.

••• Toque Ácido
O vampiro secreta um fluido biliar e ácido de qualquer parte de seu corpo. O ácido viscoso corrói metal, destrói madeira e causa queimaduras químicas horrendas em tecido vivo.
Sistema: O jogador gasta um ponto de sangue para criar o ácido — o sangue literalmente se transmuta na secreção volátil. Um ponto de sangue cria ácido suficiente para queimar através de meio centímetro de chapa de aço ou sete centímetros de madeira. O dano de um ataque corpo a corpo aumentado por ácido é agravado e custa um ponto de sangue por turno de uso. O taumaturgo é imune ao próprio toque ácido.

•••• Atrofia
Este poder mirra o membro de uma vítima, deixando apenas uma casca ressecada, quase mumificada, de osso e pele. Os efeitos são instantâneos; em mortais, também são irreversíveis.
Sistema: A vítima pode resistir aos efeitos de Atrofia obtendo três ou mais sucessos numa rolagem de Vigor + Esportes (dificuldade 8). A falha significa que o membro fica permanente e completamente aleijado. Resistência parcial é possível: um sucesso indica que a dificuldade de qualquer rolagem que envolva o uso do braço aumenta em dois, embora esses efeitos ainda sejam permanentes no caso de mortais. Dois sucessos significam que as dificuldades aumentam em um. Vampiros afligidos por este poder podem gastar cinco pontos de sangue para rejuvenescer membros atrofiados. Mortais ficam permanentemente aleijados. Este poder afeta apenas membros ou partes de membros (braços, pernas, mãos); não funciona na cabeça, no tronco etc. das vítimas.

••••• Reduzir a Pó
Este poder assustador acelera a decrepitude em suas vítimas. Mortais literalmente envelhecem ao mero toque de um taumaturgo habilidoso, ganhando décadas em instantes.
Sistema: Cada sucesso na rolagem envelhece a vítima em 10 anos. Uma vítima em potencial pode resistir com uma rolagem de Vigor + Coragem (dificuldade 8), mas precisa acumular mais sucessos que a rolagem de ativação do conjurador — é tudo ou nada. Se a vítima tiver sucesso, não envelhece nada. Se não obtiver mais sucessos que o taumaturgo, envelhece o total. Obviamente, este poder, embora afete vampiros, não tem efeito prejudicial sobre eles (são imortais). No máximo, uma vítima Membro fica mais pálida e mirra ligeiramente (-1 em Aparência) por uma noite.]==],
				},
				["Iter Pernix"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 297


Iter Pernix


Iter Pernix (A Jornada Veloz) fortalece sutilmente o vigor de mortais, vampiros ou animais para que possam cruzar grandes distâncias mais depressa do que conseguiriam normalmente. Não acelera o movimento deles do mesmo modo que Celeridade faz. Em vez disso, incute neles a determinação de seguir em frente e um alívio da fadiga de uma marcha constante.
Sistema: Escolha um número de alvos e role por sucessos. Cada sucesso permite aos alvos se moverem por estradas a uma velocidade de quarenta e cinco km por hora durante uma hora, sem necessidade de descanso nem quaisquer efeitos posteriores negativos. Não tem efeito sobre velocidades de movimento em combate, apenas em viagens de longa distância.
Falhas críticas: Em vez de acelerar a viagem, uma falha crítica ao invocar Iter Pernix faz as montarias ficarem difíceis de conduzir, reduzindo o movimento à metade da velocidade pela hora seguinte se estiverem atreladas a carroças, ou possivelmente as faz sair do rumo se não estiverem.
• Um ser (uma montaria ou humano a pé)
•• Até seis montarias ou uma carroça carregada
••• Até doze montarias ou quatro carroças de suprimentos
•••• Até 24 montarias ou oito carroças de suprimentos ou uma máquina de cerco
••••• Até 48 montarias ou dezesseis carroças de suprimentos ou quatro máquinas de cerco]==],
				},
				["Lure of Flames"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 218


Lure of Flames


Esta trilha concede ao taumaturgo a capacidade de conjurar chamas místicas — fogos pequenos a princípio, mas magos habilidosos podem criar grandes conflagrações. O fogo criado por esta trilha não é "natural". De fato, muitos vampiros acreditam que as chamas sejam conjuradas do próprio Inferno. O Chamado das Chamas é muito temido, pois o fogo é uma das maneiras mais certeiras de trazer a Morte Final a um vampiro. Ver "Fogo" (p. 297) para mais informações sobre como vampiros sofrem com as chamas.
O fogo conjurado pelo Chamado das Chamas precisa ser liberado para ter qualquer efeito. Assim, uma "palma de chamas" não queima a mão do vampiro nem causa ferimento agravado (nem faz o conjurador entrar em frenesi) — ela apenas produz luz. Uma vez liberada a chama, porém, ela queima normalmente e o personagem não tem controle sobre ela.
Sistema: O número de sucessos determina com que precisão o vampiro coloca a chama no local desejado (declarado antes de a rolagem ser feita). Um sucesso é tudo o que se precisa para conjurar uma chama na própria mão, enquanto cinco sucessos colocam uma chama em qualquer ponto da linha de visão do Membro. Menos sucessos significam que a chama aparece em algum lugar a critério do Narrador — como regra grosseira, o taumaturgo consegue posicionar a chama com precisão até 10 metros de si por sucesso.
Não são fornecidas descrições individuais para cada nível desta trilha — fogo é fogo, afinal (inclusive na possibilidade de causar frenesi em outros vampiros que o testemunhem). A tabela abaixo descreve o nível de trilha necessário para gerar determinada quantidade de chama. Para absorver o dano de alguma forma, o vampiro precisa ter a Disciplina Fortitude. O fogo sob controle do conjurador não fere o vampiro nem o faz entrar em frenesi, mas incêndios iniciados como resultado da chama antinatural afetam o taumaturgo normalmente.
• Vela (dificuldade 3 para absorver, um nível de vitalidade de dano agravado por turno)
•• Palma de chamas (dificuldade 4 para absorver, um nível de vitalidade de dano agravado por turno)
••• Fogueira de acampamento (dificuldade 5 para absorver, dois níveis de vitalidade de dano agravado por turno)
•••• Fogueira grande (dificuldade 7 para absorver, dois níveis de vitalidade de dano agravado por turno)
••••• Inferno (dificuldade 9 para absorver, três níveis de vitalidade de dano agravado por turno)]==],
				},
				["Mastery of the Mortal Shell"] = {
					pt = [==[Rites of Blood, pág. 138


Mastery of the Mortal Shell


O folclore adverte sobre os perigos da maldição das bruxas e sobre a capacidade dos feiticeiros de possuir os fracos e forçá-los a cumprir suas ordens. Durante as primeiras noites do Clã Tremere, o Domínio da Casca Mortal foi desenvolvido para combater os saqueadores Tzimisce e Gangrel que atacavam suas capelas. O uso desta Trilha foi mais tarde ampliado para impor subserviência entre as Gárgulas após sua primeira revolta. Um taumaturgo que pratica o Domínio da Casca Mortal explora o funcionamento fundamental do corpo, obtendo controle sobre os mecanismos físicos de sua vítima. Os alvos podem incluir humanos ou quaisquer criaturas sobrenaturais de carne, como vampiros, lobisomens ou magos, mas não fantasmas nem demônios, que são feitos primordialmente de espírito.
Os poderes menores desta Trilha são desajeitados em seu controle do corpo, mas tornam-se cada vez mais precisos e completos.
Vários dos poderes desta Trilha são ativados pelo toque. Dependendo das circunstâncias, o Narrador pode exigir uma rolagem bem-sucedida de Destreza + Briga para o taumaturgo fazer contato com a vítima pretendida. As regras de mira (ver V20, p. 274) se aplicam ao atacar uma extremidade específica se o contato não estiver garantido.
Salvo indicação em contrário, os poderes do Domínio da Casca Mortal duram um número de turnos igual ao número de sucessos que o taumaturgo obtiver em sua rolagem de ativação. Uma vítima só pode sofrer os efeitos de um poder desta Trilha por vez. Assim, um taumaturgo não pode aplicar Vertigem e Contorção ao mesmo tempo sobre a mesma vítima. O poder ativado mais recentemente substitui os efeitos de poderes anteriores usados na vítima.

• Vertigem
O taumaturgo induz desorientação e tontura leves por meio de manipulações sutis no corpo do sujeito. O desconforto físico é temporário e menor, mas um taumaturgo esperto pode usá-lo em rivais nos momentos mais inoportunos, fazendo-os perder a compostura.
Sistema: Um toque do taumaturgo provoca desorientação em sua vítima. Se tiver sucesso, todas as ações físicas da vítima ficam com +1 de dificuldade pela duração do poder. Usos subsequentes desta Trilha podem estender a duração, embora a dificuldade não aumente mais.

•• Contorção
Com um toque, o taumaturgo faz um grupo dos músculos de seu oponente se contrair involuntariamente, reduzindo-o a espasmos trêmulos. Esse efeito é extremamente desconcertante para o sujeito, tornando o membro ou grupo muscular inutilizável.
Sistema: Ao fazer contato físico com um dos membros do alvo, o taumaturgo o torna inútil pela duração de Contorção. Uma perna inutilizada torna difícil ficar de pé, e a vítima sofre dificuldade aumentada (+1 a +3, dependendo das circunstâncias) em desafios de Destreza pertinentes relacionados à perna, como dançar ou se equilibrar em beiradas. Um braço contorcido pende sem vida ao lado do sujeito. Uma cabeça inutilizada causa perda da fala e aumenta em +2 a dificuldade de todas as rolagens Sociais, enquanto os músculos faciais espasmam fora de controle.

••• Convulsão
Convulsão faz o corpo irromper num acesso de espasmos. Todos os músculos do corpo se contraem incontrolavelmente, enquanto a vítima espuma pela boca e os espasmos a torturam de agonia. Um mortal pode até morrer sufocado quando a língua lhe corta o suprimento de ar.
Sistema: Um toque leve do taumaturgo impõe os efeitos bastante desagradáveis deste poder ao alvo. Pela duração da convulsão, o corpo do alvo se contorce, atormentando-a a ponto da incapacitação. As vítimas sofrem penalidade de +2 de dificuldade em todas as ações físicas. A vítima também sofre um nível de dano contundente a cada turno, enquanto seu corpo se retorce impotente. A critério do Narrador, os efeitos deste poder podem até causar a morte em mortais extremamente doentes ou feridos.
O dano pode ser reduzido normalmente (embora níveis vindos de armadura não se apliquem).

•••• Falência Corporal
Taumaturgos que empunham este poder assustador ganham percepções devastadoras sobre o funcionamento do corpo, permitindo um colapso completo de seus sistemas. Essa sobrecarga biológica súbita muitas vezes se mostra fatal para mortais e danosa para outros seres sobrenaturais. Falência Corporal tem sido usada ao longo das eras para infligir males horríveis de modos discretos que sugerem um derrame ou ataque cardíaco.
Sistema: O taumaturgo não precisa mais tocar sua vítima para golpear com este nível de domínio da Trilha. Ela pode afetar qualquer alvo em sua linha de visão, mas precisa manter contato visual com a vítima o tempo todo para manter este efeito. Uma ativação bem-sucedida deste poder concede efeitos semelhantes aos de Convulsão, exceto que o dano é letal (e portanto não absorvível por mortais) devido à falência maciça e completa de tecidos e órgãos. Além disso, a vítima sofre penalidade de +2 de dificuldade em todas as ações.
O sujeito pode resistir aos efeitos de Falência Corporal por meio de uma rolagem de Vigor + Fortitude quando o taumaturgo tenta golpear o alvo (dificuldade igual à Força de Vontade atual do taumaturgo). Cada sucesso que a vítima obtiver nessa rolagem reduz a duração de Falência Corporal em um turno.

••••• Marionete
O taumaturgo que invoca Marionete obtém tal domínio sobre o corpo alheio que consegue magicamente assumir o controle de outro ser e forçar sua vítima a agir conforme seus próprios caprichos. Esse controle não é tão fino quanto o comando direto e pessoal do poder Possessão, de Dominação, mas o corpo verdadeiro do taumaturgo não fica tão vulnerável durante a manipulação. Uma vez estabelecida, a vítima de Marionete fica sob o domínio completo do taumaturgo, forçada a atuar como peão macabro dele.
Sistema: O taumaturgo pode afetar qualquer alvo em sua linha de visão, mas precisa manter contato visual com a vítima o tempo todo para manter este efeito. O sujeito pode resistir aos efeitos de Marionete numa rolagem de Vigor + Fortitude (dificuldade igual à Força de Vontade atual do taumaturgo) quando o taumaturgo tenta assumir o controle. Cada sucesso que a vítima obtiver nessa rolagem reduz a duração de Marionete em um turno. Vítimas sem Fortitude não têm a resistência física para desafiar este efeito.
Pela duração deste poder, o taumaturgo pode fazer a vítima realizar qualquer ação física, usando as paradas do alvo com penalidade de +2 de dificuldade em todas as rolagens. A concentração que este poder exige também aumenta em dois as dificuldades do próprio taumaturgo para todas as demais ações pessoais realizadas enquanto manipula a vítima. Para estender a duração desse controle, o taumaturgo precisa fazer uma segunda rolagem de ativação. Marionete não priva a vítima de sua consciência, apenas do controle físico sobre o próprio corpo. Durante esse tempo de domínio do taumaturgo, o alvo permanece ciente de que alguma força externa está manipulando suas ações físicas, consciente de que não são suas. A vítima pode gastar um ponto de Força de Vontade para tentar realizar uma ação mental ou social, como ativar uma Disciplina ou falar.]==],
				},
				["Movement of the Mind"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 220


Movement of the Mind


Esta trilha dá ao taumaturgo a capacidade de mover objetos telecineticamente pelo poder místico do sangue. Em níveis mais altos, até o voo é possível (mas cuidado com quem vê…). Objetos sob controle do personagem podem ser manipulados como se ela os segurasse — podem ser erguidos, girados, malabareados ou até "arremessados", embora gerar força suficiente para infligir dano real exija domínio de ao menos o quarto nível desta trilha. Alguns conjuradores habilidosos nesta trilha até a usam para guardar seus refúgios, animando espadas, machados e armas de fogo para repelir intrusos. Esta trilha pode assustar e desconcertar espectadores.
Sistema: O número de sucessos indica a duração do controle do conjurador sobre o objeto (ou sujeito). Cada sucesso permite um turno de manipulação, embora o Membro possa tentar manter o controle depois desse tempo fazendo uma nova rolagem (ela não precisa gastar sangue adicional para manter o controle). Se a rolagem tiver sucesso, o controle é mantido. Se um taumaturgo perder ou afrouxar o controle sobre um objeto e depois o manipular de novo, sua jogadora precisa gastar outro ponto de sangue, pois uma nova tentativa está sendo feita. Cinco ou mais sucessos na rolagem inicial significam que o vampiro pode controlar o objeto pela duração da cena.
Se este poder for usado para manipular um ser vivo, o sujeito pode tentar resistir. Nesse caso, o conjurador e o sujeito fazem rolagens opostas de Força de Vontade a cada turno em que o controle é exercido.
Como no Chamado das Chamas, não são fornecidos níveis individuais de poder para esta trilha — consulte a tabela abaixo para ver quanto peso um taumaturgo pode controlar.
Quando um Membro alcança nível 3, ela pode levitar a si mesma e "voar" a aproximadamente a velocidade de corrida, não importa quanto pese, embora as restrições de peso se apliquem se ela manipular outros objetos ou sujeitos. Quando um Membro alcança 4, ela pode "arremessar" objetos com Força igual a seu nível de domínio desta trilha.
• Meio quilograma
•• 10 quilogramas
••• 100 quilogramas
•••• 250 quilogramas
••••• 500 quilogramas]==],
				},
				["Neptune’s Might"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 218


Neptune’s Might


Vampiros raramente são associados ao oceano na maioria das mitologias, e a maior parte dos Membros não tem nada a ver com água em grandes quantidades simplesmente por não ter razão para isso. Ainda assim, o Poder de Netuno goza de um séquito pequeno, porém devotado, há séculos entre os taumaturgos da Camarilla. Esta trilha se baseia principalmente na manipulação de água parada, embora alguns de seus efeitos mais perturbadores se afastem desse princípio.
Quando o personagem alcança o terceiro nível do Poder de Netuno, o jogador pode escolher se especializar em água doce ou água salgada. Tal especialização reduz em um todas as dificuldades do Poder de Netuno ao lidar com o meio escolhido, mas as aumenta em um ao lidar com o oposto. O sangue não é considerado nem doce nem salgado para esse fim, e as dificuldades de manipulá-lo não são afetadas.

• Olhos do Mar
O taumaturgo pode observar um corpo d'água e ver eventos que ocorreram sobre, dentro ou ao redor dele a partir da perspectiva da água. Alguns praticantes mais velhos desta arte afirmam que o vampiro comunga com os espíritos das águas ao usar este poder; Membros mais jovens zombam de tais afirmações.
Sistema: O número de sucessos rolados determina quão longe no passado o personagem consegue enxergar.
1 sucesso — Um dia
2 sucessos — Uma semana
3 sucessos — Um mês
4 sucessos — Um ano
5 sucessos — 10 anos
O Narrador pode exigir uma rolagem de Percepção + Ocultismo para o personagem discernir detalhes muito pequenos nas imagens transmitidas. Este poder só pode ser usado em água parada; lagos e poças servem, mas oceanos, rios, esgotos e taças de vinho não.

•• Prisão de Água
O taumaturgo pode comandar uma quantidade de água suficientemente grande para que ela se anime e aprisione um sujeito. Este poder exige uma quantidade significativa de fluido para ser plenamente eficaz, embora mesmo alguns litros possam ser usados para moldar correntes de água animada.
Sistema: O número de sucessos obtidos na rolagem é o número de sucessos que a vítima precisa obter numa rolagem de Força (dificuldade 8; Potência pode somar a essa rolagem) para se libertar. Um sujeito só pode ser mantido em uma prisão por vez, embora o conjurador seja livre para invocar múltiplos usos deste poder sobre vítimas distintas e possa dissolver essas prisões à vontade. Se uma quantidade suficiente de água (ao menos o equivalente a uma banheira) não estiver presente, a dificuldade da rolagem de Força de Vontade para ativar este poder aumenta em um.

••• Sangue em Água
O taumaturgo agora alcançou poder suficiente sobre a água para transmutar outros líquidos neste elemento básico. O uso mais comum deste poder é como agressão; com apenas um toque, o sangue da vítima se transforma em água, enfraquecendo vampiros e matando mortais em instantes.
Sistema: O personagem precisa tocar a vítima pretendida. O jogador rola Força de Vontade normalmente. Cada sucesso converte um ponto de sangue da vítima em água. Um sucesso mata um mortal em minutos. Vampiros que perdem pontos de sangue para este poder também sofrem penalidades de parada de dados como se tivessem recebido um número equivalente de níveis de vitalidade em ferimentos. A água deixada no organismo do alvo por este ataque evapora à taxa do equivalente a um ponto de sangue por hora, mas o sangue perdido não retorna.
A critério do Narrador, outros líquidos podem ser transformados em água com este poder (a dificuldade para tal ação é reduzida em um a menos que a substância seja particularmente perigosa ou de natureza mágica). O personagem ainda precisa tocar a substância ou seu recipiente para usar este poder.

•••• Muralha Fluida
Histórias sobre a incapacidade de vampiros de cruzar água corrente podem ter derivado em parte de relatos truncados deste poder em ação. O taumaturgo pode animar a água a um grau ainda maior do que é possível com o uso de Prisão de Água, comandando-a a se erguer e formar uma barreira intransponível para quase qualquer ser.
Sistema: O personagem toca a superfície de um corpo de água parada; o jogador gasta três pontos de Força de Vontade e o ponto de sangue normalmente exigido e rola normalmente. Os sucessos são aplicados tanto à largura quanto à altura da muralha; cada sucesso "compra" três metros em uma das dimensões. A muralha pode ser posicionada em qualquer ponto da linha de visão do personagem e precisa ser formada em linha reta. A muralha dura até o próximo nascer do sol. Não pode ser escalada, embora se possa voar sobre ela. Para atravessar a barreira, qualquer ser sobrenatural (inclusive seres que tentem passar pela muralha em outros níveis de existência, como fantasmas) precisa obter ao menos três sucessos numa única rolagem de Força de Vontade (dificuldade 9).

••••• Desidratar
Neste nível de domínio, o taumaturgo pode atacar diretamente alvos vivos e não-vivos removendo a água de seus corpos. Vítimas mortas por este poder deixam para trás cadáveres mumificados horrendos. Este poder também pode ser usado para fins menos agressivos, como secar roupas molhadas — ou evaporar poças para impedir que outros praticantes desta trilha as usem.
Sistema: Este poder pode ser usado em qualquer alvo na linha de visão do personagem. O jogador rola normalmente; a vítima resiste com uma rolagem de Vigor + Fortitude (dificuldade 9). Cada sucesso obtido pelo conjurador se traduz em um nível de vitalidade de dano letal infligido à vítima. Este ferimento não pode ser absorvido (a rolagem de resistência substitui a absorção neste ataque), mas pode ser curado normalmente. Vampiros perdem pontos de sangue em vez de níveis de vitalidade, embora, se um vampiro não tiver pontos de sangue, este ataque inflija perda de níveis de vitalidade como faria contra um mortal. A vítima deste ataque também precisa rolar Coragem (dificuldade igual ao número de sucessos obtidos pelo conjurador + 3) para conseguir agir no turno seguinte ao ataque; a falha significa que ela é dominada pela agonia e não consegue fazer nada.]==],
				},
				["Path of Conjuring"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 220


Path of Conjuring


Invocar objetos "do nada" é um pilar da lenda oculta e sobrenatural desde muito antes da ascensão dos Tremere. Esta trilha taumatúrgica permite conjurações poderosas, limitadas apenas pela mente do praticante.
Objetos invocados por esta trilha têm duas características distintas. São uniformemente "genéricos", no sentido de que cada objeto invocado, se invocado de novo, teria exatamente a mesma aparência de antes. Por exemplo, uma faca seria precisamente a mesma faca se criada duas vezes; as duas seriam indistinguíveis. Mesmo uma faca específica — aquela que o pai de uma personagem usou para ameaçá-la — apareceria idêntica toda vez que fosse conjurada. Um rato teria padrões "ladrilhados" repetidos pelo pelo, e uma lata de lixo teria uma textura estriada completamente uniforme por toda a superfície. Além disso, objetos conjurados não têm defeitos: armas não têm amassados nem arranhões, ferramentas não têm marcas distintivas, e celulares todos parecem ter acabado de sair da embalagem.
O limite de tamanho dos objetos conjurados parece ser o do próprio conjurador: nada maior que o taumaturgo pode ser criado. O conjurador também precisa ter algum grau de familiaridade com o objeto que deseja invocar. Trabalhar apenas a partir de uma imagem ou da imaginação exige dificuldade mais alta, enquanto objetos com os quais o personagem tem familiaridade íntima (como a faca descrita acima) podem de fato reduzir a dificuldade, a critério do Narrador.
Quando o jogador rola para conjurar algo, os sucessos obtidos na rolagem indicam a qualidade do objeto invocado. Um sucesso rende uma criação vagabunda e imperfeita, enquanto cinco sucessos rendem ao conjurador uma réplica quase perfeita.

• Invocar a Forma Simples
Neste nível de domínio, o conjurador pode criar objetos simples e inanimados. O objeto não pode ter partes móveis nem ser feito de múltiplos materiais. Por exemplo, o conjurador pode invocar um bastão de aço, um cano de chumbo, uma estaca de madeira ou um bloco de granito.
Sistema: A cada turno em que o conjurador desejar manter o objeto em existência, outro ponto de Força de Vontade precisa ser gasto, ou o objeto desaparece.

•• Permanência
Neste nível, o conjurador não precisa mais pagar custos em Força de Vontade para manter um objeto em existência. O objeto é permanente, embora objetos simples ainda sejam tudo o que se pode criar.
Sistema: O jogador precisa investir três pontos de sangue num objeto para torná-lo real.

••• Magia do Ferreiro
O Membro pode agora conjurar objetos complexos, de múltiplos componentes e com partes móveis. Por exemplo, o taumaturgo pode criar armas de fogo, bicicletas, motosserras ou celulares.
Sistema: Objetos criados por Magia do Ferreiro são automaticamente permanentes e custam cinco pontos de sangue para conjurar. Itens particularmente complexos muitas vezes exigem uma rolagem de Conhecimento (Ofícios, Ciências, Tecnologia etc.) além da rolagem básica.

•••• Conjuração Reversa
Este poder permite ao conjurador "banir" para a inexistência qualquer objeto anteriormente invocado por esta trilha.
Sistema: Esta é uma rolagem de sucessos prolongada. O conjurador precisa acumular tantos sucessos quantos o conjurador original obteve ao criar o objeto em questão. Isso também pode ser usado pelo taumaturgo para banir objetos que ela mesma criou com esta Trilha.

••••• Poder Sobre a Vida
Este poder não pode criar vida verdadeira, embora possa invocar simulacros impressionantes. Criaturas (e pessoas) invocadas com este poder carecem de livre-arbítrio para agir por conta própria, seguindo em vez disso, sem pensar, as instruções simples de seu conjurador. Pessoas criadas dessa forma podem ser submetidas ao uso do poder Possessão, de Dominação (p. 155), se desejado.
Sistema: O jogador gasta 10 pontos de sangue. Imperfeitas e impermanentes, criaturas invocadas por esta trilha são complexas demais para existir por muito tempo. Dentro de uma semana após a conjuração, os simulacros se desvanecem na insubstancialidade.]==],
				},
				["Path of Corruption"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 221


Path of Corruption


As origens desta trilha são acaloradamente debatidas entre os que conhecem suas minúcias. Uma teoria sustenta que seus segredos foram ensinados aos Tremere por demônios e que usá-la aproxima perigosamente o praticante dos poderes infernais. Uma segunda opinião propõe que a Trilha da Corrupção é um resquício dos dias em que o Clã Tremere ainda era mortal. A terceira teoria, e a mais perturbadora para os Tremere, é que a trilha se originou com os Seguidores de Set, e que o conhecimento de seu funcionamento foi vendido aos Tremere por um preço não especificado. Este último boato é veementemente negado pelos Tremere, o que automaticamente o torna tópico predileto de discussão quando o assunto surge.
A Trilha da Corrupção é uma trilha primordialmente de orientação mental e espiritual, centrada em influenciar as psiques de outros indivíduos. Não pode ser usada nem para emitir ordens como Dominação, nem para mudar emoções no momento como Presença. Em vez disso, produz uma torção gradual e sutil das ações, da moral e dos processos de pensamento do sujeito. Esta trilha lida intimamente com engano e desejos sombrios, e quem trabalha com ela precisa compreender os lugares ocultos do coração. Por isso, nenhum personagem pode ter um nível de Trilha da Corrupção maior que seu nível de Lábia.

• Contradizer
O vampiro pode interromper os processos de pensamento de um sujeito, forçando a vítima a inverter seu curso de ação atual. Uma Arconte pode ser levada a executar um prisioneiro que estava prestes a inocentar e soltar; um amante mortal pode passar de gentil e carinhoso a sádico e exigente no meio de um encontro. Os resultados de Contradizer nunca são conhecidos com precisão pelo taumaturgo de antemão, mas sempre tomam a forma de uma ação mais negativa que a que o sujeito originalmente pretendia realizar.
Sistema: Este poder pode ser usado em qualquer sujeito na linha de visão do personagem. O jogador rola normalmente. O alvo rola Percepção + Lábia (dificuldade igual ao número de sucessos obtidos pelo conjurador + 2). Dois sucessos permitem ao sujeito perceber que está sendo influenciado por alguma fonte externa. Três sucessos permitem a ela identificar a fonte do efeito. Quatro sucessos lhe dão um momento de hesitação, não realizando nem sua ação original nem o inverso dela, enquanto cinco permitem que ela leve a cabo a ação original.
O Narrador dita qual é a reação precisa do sujeito a este poder. Contradizer não pode ser usado em combate nem para afetar outras ações (a critério do Narrador) que sejam principalmente físicas e reflexas.

•• Subverter
Este poder segue o mesmo princípio de Contradizer, a liberação do lado sombrio e autodestrutivo de um sujeito. Contudo, os efeitos de Subverter duram mais que o lampejo momentâneo de Contradizer. Sob a influência deste poder, as vítimas agem segundo suas próprias tentações reprimidas, perseguindo agendas que sua moral ou autocontrole lhes proibiriam seguir em circunstâncias normais.
Sistema: Este poder exige que o personagem faça contato visual (ver p. 152) com a vítima pretendida. O jogador rola normalmente. O alvo resiste com uma rolagem de Percepção + Lábia (dificuldade igual à Manipulação + Lábia do alvo). Se o taumaturgo obtiver mais sucessos, a vítima fica inclinada a seguir um desejo reprimido e vergonhoso pelo período de tempo descrito abaixo.
1 sucesso — Cinco minutos
2 sucessos — Uma hora
3 sucessos — Uma noite
4 sucessos — Três noites
5 sucessos — Uma semana
O Narrador determina o desejo ou a agenda precisa que a vítima segue. Deve estar de acordo com os Defeitos Psicológicos que ela possui ou com os aspectos negativos de sua Natureza (por exemplo, uma Solitária desejando isolamento a tal ponto que se torna violenta se for forçada a comparecer a um evento social). O sujeito não deve ficar fixado em seguir essa nova agenda o tempo todo, mas ocasionalmente deve ser forçado a gastar um ponto de Força de Vontade se surgir a oportunidade de sucumbir e ele quiser resistir ao impulso.

••• Dissociar
"Dividir para conquistar" é uma máxima bem compreendida pelos Tremere, e Dissociar é uma ferramenta poderosa para dividir os inimigos do Clã. Este poder é usado para romper os laços sociais de relações interpessoais. Mesmo o caso mais apaixonado ou a amizade mais antiga podem ser esfriados pelo uso de Dissociar, e laços pessoais mais fracos podem ser destruídos por completo.
Sistema: O personagem precisa tocar o alvo. O jogador rola normalmente. O alvo resiste com uma rolagem de Força de Vontade (dificuldade igual à Manipulação + Empatia do taumaturgo). A vítima perde três dados de todas as rolagens Sociais por um período determinado pelo número de sucessos obtidos pelo conjurador:
1 sucesso — Cinco minutos
2 sucessos — Uma hora
3 sucessos — Uma noite
4 sucessos — Três noites
5 sucessos — Uma semana
Esta penalidade se aplica a todas as rolagens que dependam de Atributos Sociais, mesmo as exigidas para o uso de Disciplinas. Se este poder for usado num personagem que tenha participado da Vaulderie ou ritual semelhante, os níveis de Vinculum desse personagem são reduzidos em três pela duração do efeito de Dissociar.
O efeito primário de Dissociar recai mais sobre a interpretação que sobre a mecânica de jogo. Vítimas deste poder devem ser interpretadas como retraídas, desconfiadas e emocionalmente distantes. O Narrador deve se sentir à vontade para exigir o gasto de um ponto de Força de Vontade de um jogador que não siga essas diretrizes.

•••• Vício
Este poder é uma forma muito mais forte e potencialmente mais danosa de Subverter. Vício cria exatamente isso na vítima. Ao simplesmente expor o alvo a determinada sensação, substância ou ação, o conjurador cria uma dependência psicológica poderosa. Muitos taumaturgos garantem que suas vítimas se tornem viciadas em substâncias ou emoções que só o místico pode fornecer, criando assim tanto uma fonte de renda quanto material de chantagem em potencial.
Sistema: O sujeito precisa encontrar ou ser exposto à sensação, substância ou ação à qual o personagem quer viciá-lo. O taumaturgo então toca seu alvo. O jogador rola normalmente; a vítima resiste com uma rolagem de Autocontrole/Instinto (dificuldade igual ao número de sucessos obtidos pelo conjurador + 3). A falha dá ao sujeito um vício instantâneo naquele objeto.
Um personagem viciado precisa satisfazer seu vício ao menos uma vez por noite. Cada noite em que ele fica sem satisfazer seu desejo impõe uma penalidade cumulativa de um dado em todas as suas paradas (até um mínimo de um dado). A vítima precisa rolar Autocontrole/Instinto (dificuldade 8) toda vez que for confrontada com o objeto de seu vício e desejar evitar ceder. Vício dura um número de semanas igual à Manipulação do taumaturgo.
Um indivíduo pode tentar romper os efeitos de Vício. Isso exige uma rolagem prolongada de Autocontrole/Instinto (dificuldade igual à Manipulação + Lábia do conjurador), com uma rolagem por noite. O viciado precisa acumular um número de sucessos igual a três vezes o número de sucessos obtidos pelo conjurador. A vítima não pode ceder ao vício ao longo do tempo necessário para acumular esses sucessos. Se ceder, todos os sucessos acumulados são perdidos e ele precisa recomeçar na noite seguinte. Note que a parada de Autocontrole/Instinto é reduzida a cada noite em que a vítima passa sem alimentar seu vício.

••••• Dependência
Muitos ex-peões do Clã Tremere afirmam ter sentido uma sensação estranha, semelhante à depressão, quando não estavam na presença de seus mestres. Isso costuma ser atribuído ao laço de sangue, mas às vezes é resultado do domínio de Dependência pelo vampiro. O poder final da Trilha da Corrupção permite ao vampiro atar a alma de sua vítima à sua própria, engendrando sensações de letargia e desamparo quando a vítima não está em sua presença nem agindo para promover seus desejos.
Sistema: O personagem envolve o alvo numa conversa. O jogador rola normalmente. A vítima rola Autocontrole/Instinto (dificuldade igual ao número de sucessos obtidos pelo conjurador + 3). A falha significa que a psique da vítima foi sutilmente atada à do taumaturgo por uma noite por sucesso rolado pelo conjurador.
Uma vítima atada não é menos propensa a atacar quem a controla, e não sente emoções positivas particulares por ela. Contudo, fica psicologicamente viciada na presença dela, e sofre penalidade de um dado em todas as rolagens quando não está perto dela nem realizando tarefas para ela.
Além disso, ele é muito menos resistente às ordens dela, e suas paradas são reduzidas à metade quando tenta resistir à Dominação, à Presença (ou a outros poderes de controle mental ou emocional) ou a rolagens Sociais mundanas dela. Por fim, ele é incapaz de recuperar Força de Vontade quando não está na presença do taumaturgo.]==],
				},
				["Path of Haunting"] = {
					pt = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, pág. 174


Path of Haunting


Conforme os Maeghar se afastaram cada vez mais do mundo e mergulharam nas trevas, seus poderes de ilusão e ardil foram deformados pelas sombras do Esquecimento. Lentamente eles acenderam dentro de si a centelha sombria que cresceria até se tornar a Trilha da Assombração. Outros necromantes também podem aprender a Trilha da Assombração e, de fato, o Clã Giovanni a criou por conta própria.

• Canção dos Mortos
A necromante tece morte e silêncio numa canção assombrosa que instila no ouvinte uma obsessão pela morte. A vítima passa a ter certeza de que a morte a espreita e vê maus presságios por toda parte. Essa ameaça constante pode acabar levando um mortal ao suicídio ou lançar um vampiro à torpor.
Sistema: A vampira entoa o canto para a vítima enquanto sua jogadora gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade igual à Força de Vontade atual do alvo). Uma falha crítica indica que a vampira afeta a si mesma como se tivesse obtido sucessos iguais ao número de 1 rolados.
Por um número de noites igual aos sucessos rolados, o alvo sofre de depressão e ansiedade mórbida. Essa fixação soma +2 à dificuldade de rolagens Sociais (exceto as que envolvam Intimidação) e +1 à dificuldade de todas as demais rolagens não reflexas. Se um alvo sofrer os efeitos deste poder por mais noites contínuas que sua Força de Vontade permanente, ele perde um ponto de Força de Vontade permanente. Esse ciclo continua após um intervalo igual ao novo valor em dias, com a vítima perdendo um ponto de Força de Vontade permanente após cada iteração dessas. Quando um personagem chega a zero de Força de Vontade permanente, ele comete suicídio (se vivo) ou cai em torpor (se vampiro). Se o poder for interrompido por ao menos uma noite, a vítima recupera sua Força de Vontade permanente à taxa de um ponto por semana. Um vampiro que cai em torpor por chegar a zero de Força de Vontade desperta com seu valor original.

•• Invocar Fogo-Fátuo
Cavalgando entre dois mundos, a necromante não existe de verdade. Ela está aqui, e ao mesmo tempo não está. Buscando dentro de si, ela infunde uma centelha de sua própria natureza efêmera com energia necromântica sombria. O resultado é uma luz dançante, tão hipnótica quanto traiçoeira.
Sistema: A jogadora gasta um ponto de sangue e rola Carisma + Ocultismo (dificuldade 5) para conjurar um orbe de luz pálida que dura uma cena. O fogo-fátuo pode assumir qualquer cor que a vampira escolher e não tem substância nem peso. Pode voar tão rápido quanto a vampira consegue correr, lançando uma iluminação fria tão brilhante quanto uma vela. Mortais que contemplem o fogo-fátuo precisam rolar Força de Vontade (dificuldade 4) e obter mais sucessos que a conjuradora, ou caem num transe leve, que soma +1 à dificuldade de todas as ações por distração. Se os sucessos da vampira forem o dobro dos do mortal, ele segue a luz sem se importar com nada além dos obstáculos mais óbvios. Contorna árvores e pedras, mas cai em areia movediça ou de um parapeito alto. Qualquer ruído alto ou outra distração rompe o devaneio imediatamente.
Se a jogadora da vampira tiver falha crítica na rolagem de conjuração, o fogo-fátuo aparece e age com sua própria agenda malévola. Tal criatura é apenas um estorvo, mas pode demonstrar astúcia notável ao atrair inimigos ao refúgio da vampira ou ao denunciar a posição dela.

••• Tormenta Onírica
Nem os sonhos oferecem descanso aos inimigos da necromante. O sono repousante vira puro terror enquanto a Canção dos Mortos continua a assombrar quem dorme por meio de pesadelos.
Sistema: A vampira faz contato visual com a vítima, enquanto sua jogadora gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade igual à Força de Vontade permanente do alvo). Se tiver sucesso, a vítima sente uma leve sensação de inquietação. Da próxima vez em que dormir, sofre pesadelos horríveis sobre a própria morte. Ainda que não consiga lembrar plenamente o conteúdo de suas visões ao acordar, o trauma emocional o impede de recuperar Força de Vontade. Além disso, seu déjà vu distorcido e sua paranoia antinatural lhe dão os Defeitos Pesadelos e Presença Sinistra (V20, p. 495) pelo dia. Uma falha crítica ao conjurar este poder inflige os mesmos sonhos terríveis à vampira quando ela dormir.

•••• Fantasmas
A necromante reconhece a paixão dos mortos como uma ilusão. Valendo-se dessa compreensão, ela pode voltar essas ilusões para assombrar os vivos.
Sistema: A vampira visualiza a aparição desejada, enquanto a jogadora gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade 7). Essas criações não têm substância e não podem falar nem realizar ações complicadas, embora emitam um frio surreal. Cada sucesso permite à vampira criar um fenômeno, ou acrescentar uma característica ou condição a outro fantasma. Por exemplo, três sucessos poderiam animar sombras para se arrastarem e contorcerem (um sucesso) e criar uma ilusão de sangue escorrendo que irrompe numa nuvem de moscas quando alguém se aproxima (um sucesso para o sangue e um sucesso para a condição). Este poder pode criar aparições em qualquer ponto da linha de visão da conjuradora. O Narrador continua sendo o árbitro final do que é ou não possível com este poder.
Uma falha crítica chama a atenção de um fantasma maléfico, dando à vampira o Defeito Assombrado (V20, p. 495) por um número de noites igual aos 1 rolados.

••••• Tormento
A distinção entre vida e morte nada significa para a necromante — é outra ilusão, criada para o conforto dos vivos. Ela pode rasgar esse véu e chamar aparições maliciosas para assombrar sua vítima.
Sistema: A jogadora gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade 8). Numa falha crítica, a vampira ganha permanentemente o Defeito Assombrado (V20, p. 495), atraindo os fantasmas mais vis e odiosos. Se tiver sucesso, a vítima sente um calafrio súbito. A dificuldade para fantasmas afetarem o alvo com qualquer poder diminui em um para cada sucesso rolado, até um mínimo de dificuldade 4. Fantasmas maliciosos se aglomeram em torno do alvo, infligindo avidamente todo horror à sua disposição. A redução de dificuldade diminui em um a cada dia ao amanhecer, até a vítima voltar ao normal e os espectros perderem o interesse. Múltiplas aplicações deste poder não podem ser acumuladas para aumentar a duração ou a intensidade do efeito. As estatísticas e os poderes dos espectros ficam a cargo do Narrador, mas a experiência deve aterrorizar completamente o personagem e bem pode resultar em perturbações, no mínimo.]==],
				},
				["Path of Mars"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 224


Path of Mars


Aqueles raros Sabbat que mantiveram talentos taumatúrgicos voltaram seu foco para auxiliar a Seita em tempos de guerra. Esta trilha se mostrou útil, virando o rumo de vários confrontos com vampiros anciões. A trilha adota uma postura bastante marcial, enquanto outras magias de sangue tendem a ter efeitos mais sutis e menos violentos. Diz-se que alguns Tremere da Camarilla aprenderam esta trilha, mas pouquíssimos deles têm o temperamento certo para empunhá-la com eficácia.

• Grito de Guerra
Um vampiro na ofensiva pode concentrar sua vontade, tornando-se menos suscetível ao medo de batalha ou aos poderes dos não-mortos. O vampiro solta um grito primal para iniciar o efeito, embora se saiba que alguns taumaturgos pintam o rosto ou se cortam em vez disso.
Sistema: Pela duração de uma cena, o vampiro soma um a seu Traço de Coragem. Além disso, para fins de efeitos hostis, sua Força de Vontade é considerada um ponto mais alta (embora este bônus se aplique apenas ao Traço em si, não à reserva de Força de Vontade). Um personagem só pode obter os benefícios de Grito de Guerra uma vez por cena.

•• Golpe Certeiro
O vampiro faz um único ataque, guiado pelo poder profano de seu Sangue. Esse ataque atinge o inimigo infalivelmente.
Sistema: Ao invocar este poder, o jogador não precisa rolar para ver se o ataque do vampiro acerta — ele acerta, automaticamente. Só ataques de Armas Brancas ou Briga podem ser feitos dessa maneira. Esses ataques são considerados ataques de um sucesso; não oferecem dados de dano adicionais. Além disso, podem ser esquivados, bloqueados ou aparados normalmente, e o defensor precisa de apenas um sucesso (já que o número de sucessos dos ataques é assumido como um). Golpe Certeiro não tem efeito se tentado em múltiplos ataques (divisões de parada de dados) num único turno pelo mesmo personagem.

••• Dança do Vento
O taumaturgo invoca o poder dos ventos, movendo-se num borrão. Ela ganha uma vantagem sobrenatural em evitar os golpes de seus inimigos, saindo do caminho antes que o inimigo tenha chance de desferi-los.
Sistema: A jogadora pode esquivar de qualquer número de ataques com sua parada de dados completa num único turno. Esta vantagem se aplica apenas a esquivas — se a personagem quiser atacar e esquivar, a jogadora ainda precisa dividir sua parada. Este poder dura uma cena.

•••• Coração Destemido
O vampiro aumenta temporariamente suas capacidades como guerreiro. Pelos poderes místicos da magia de sangue, o personagem se torna uma força de combate potente.
Sistema: Coração Destemido concede ao vampiro um ponto extra em cada um dos Atributos Físicos (Força, Destreza e Vigor). Esses Traços não podem exceder seus máximos geracionais, embora o jogador possa usar pontos de sangue para elevar os Traços do personagem ainda mais. Os efeitos duram uma cena, e um personagem só pode obter seus benefícios uma vez por cena. O vampiro precisa passar duas horas em estado calmo e de repouso após o uso de Coração Destemido, ou perde um ponto de sangue a cada 15 minutos até descansar.

••••• Camaradas de Armas
Esta capacidade estende o poder das capacidades anteriores da trilha. Ela permite que qualquer dos efeitos anteriores seja aplicado a um grupo, como uma matilha ou Bando de Guerra.
Sistema: O jogador escolhe um dos poderes de nível inferior da trilha, invocando-o normalmente. Depois, ele toca outro personagem e (se a rolagem de Camaradas de Armas tiver sucesso) concede o benefício a ela também. O mesmo poder pode ser entregue a qualquer número de companheiros de matilha, desde que as rolagens de Camaradas de Armas tenham sucesso e o taumaturgo pague os custos de sangue apropriados.]==],
				},
				["Path of Spirit Manipulation"] = {
					pt = [==[Rites of Blood, pág. 142


Path of Spirit Manipulation


Criada para substituir os rituais praticados pelo Clã Tremere nos dias em que era um bando de magos mortais, a Manipulação de Espíritos é a arte de forçar espíritos a ações e situações que normalmente seriam contrárias à sua natureza. Esses espíritos não são os espectros controlados pela Necromancia, mas uma manifestação dos grandes poderes do universo que o cérebro humanoide limitado percebe como espíritos. Alguns acreditam que espíritos são tulpas — construtos da vontade humana criados pela fé para explicar como o universo consegue funcionar. A Manipulação de Espíritos força esses espíritos a um arremedo grotesco de seus comportamentos normais para obter resultados mágicos no mundo material.

Criando Espíritos (p. 142)
Espíritos são construtos nascidos dos reinos espirituais e são conhecidos pelos de formação Hermética como os Umbrood. Esses construtos espirituais não são sencientes como tradicionalmente se entende entre os que vivem no mundo físico, mas são reflexos do mundo espiritual e aspectos percebidos do universo interpretados de um modo que a percepção mortal limitada consiga compreender. Assim, espíritos vêm numa ampla gama de tipos e potências. As regras a seguir são um guia limitado para criar espíritos para V20.
Primeiro, defina o conceito do espírito. Tradicionalmente ele é limitado por uma única categoria que se possa descrever com uma frase. Alguns exemplos podem incluir: espírito da natureza (terra, mar, mata ou deserto), espírito conceitual (matemática, guerra ou mecânica) ou um objeto inanimado (um computador, uma faca ou uma joia).
Em seguida, determine a potência do espírito definindo seu nível (de 1 a 5). O nível do espírito determina sua Força de Vontade. Se o espírito precisar participar de algum teste, sua parada de dados é o dobro de seu nível.
Para cada ponto de nível do espírito, atribua um poder de Disciplina baseado no conceito. Por exemplo, um Espírito do Fogo de nível 3 pode possuir três pontos de Taumaturgia: O Chamado das Chamas (V20, p. 218). A Força de Vontade alimenta qualquer capacidade especial que um espírito possua, e pontos de Força de Vontade são recuperados a cada 24 horas.
Por fim, atribua uma Habilidade por nível do espírito. Um espírito da guerra pode ter Briga, Armas Brancas, Armas de Fogo, Sobrevivência ou qualquer número de habilidades relacionadas à guerra ou ao combate. Cada Habilidade soma dois dados à sua parada básica de Força de Vontade x 2.

• Visão Hermética
O vampiro consegue perceber o mundo espiritual, seja fitando-o profundamente, seja vendo a presença de espíritos próximos como uma camada turva sobreposta ao mundo material.
Sistema: Visão Hermética permite ao taumaturgo perceber o reino espiritual entremeado ao mundo material por uma hora. Cada nível adicional de sucesso na rolagem de ativação aumenta a duração deste poder em mais trinta minutos.

•• Cântico Astral
As línguas do mundo espiritual são infinitamente variadas e em geral incompreensíveis para mentes mortais (e imortais). Cântico Astral não ensina ao taumaturgo as línguas dos espíritos, mas lhe permite compreendê-los quando falam com ele e responder nas línguas deles. O uso deste poder nem sempre é necessário; muitos espíritos falam línguas humanas, mas optam por fingir ignorância ao lidar com vampiros. Espíritos não são afetados por Dominação, mas podem ser manipulados por Presença. Alguns taumaturgos teorizam que isso ocorre porque espíritos não são de fato sencientes como um vampiro entenderia o conceito, mas manifestações baseadas na percepção dos que têm autoconsciência.
Sistema: Cântico Astral permite ao taumaturgo falar com qualquer espírito visível por Visão Hermética durante quinze minutos. Cada nível adicional de sucesso na rolagem de ativação aumenta a duração deste poder em mais quinze minutos.

••• Voz de Comando
Este é talvez o poder mais perigoso do arsenal da Manipulação de Espíritos, pois as consequências do fracasso podem ser particularmente desagradáveis. Voz de Comando permite ao taumaturgo dar ordens a um espírito, compelindo-o a atender seus desejos queira ele ou não.
Espíritos compelidos por este poder estão plenamente cientes de que estão sendo forçados a essas ações, e bem podem buscar vingança contra seus antigos mestres mais tarde. Taumaturgos que emitem ordens além do que seus servos espirituais são compelidos a cumprir podem se ver ignorados ou ridicularizados. Um espírito trapaceiro pode concordar em seguir ordens apenas para trair seu mestre, deixando o taumaturgo numa situação de constrangimento potencialmente fatal.
Sistema: O taumaturgo faz a rolagem oposta normal de Força de Vontade contra o espírito. O espírito alvo resiste com Força de Vontade (dificuldade igual à Manipulação + Ocultismo do taumaturgo). O grau de sucesso que o taumaturgo alcança determina a complexidade e a severidade da ordem que pode dar.
Falha crítica — O espírito fica imune às ordens do personagem pelo resto da noite. Ele reage como o Narrador julgar apropriado. Tipicamente, o espírito fica irado o bastante para buscar vingança na primeira oportunidade. Pode ignorar, zombar ou até atacar o personagem, a critério do Narrador.
Falha — O espírito não é afetado, e novas tentativas de comandá-lo são feitas com +1 de dificuldade (cumulativo).
1 sucesso — O espírito obedece a uma ordem bem simples que não lhe cause grande incômodo.
2 sucessos — O espírito atende a uma ordem relativamente direta à qual não se oponha inatamente.
3 sucessos — O espírito concorda em realizar uma tarefa moderadamente complexa que não viole sua ética.
4 sucessos — O espírito consente com uma tarefa prolongada ou intrincada que não o coloque em perigo imediato.
5 sucessos — O espírito aceita uma tarefa longa ou quase impossível, ou uma que signifique sua destruição.

•••• Aprisionar o Efêmero
Este poder permite ao taumaturgo prender um espírito num objeto físico. Isso pode ser feito para aprisionar o alvo, mas é mais frequentemente realizado para criar um fetiche — um artefato que concede benefícios místicos alimentados pelo espírito. Fetiches criados por este poder são muitas vezes pouco confiáveis e falham em momentos inoportunos, pois os espíritos dentro deles estão compreensivelmente descontentes com sua situação e aproveitarão qualquer oportunidade para escapar ou frustrar seus captores. Lupinos consideram ofensivo que vampiros possuam um fetiche, e muitas vezes entram em frenesi só de ver um vampiro empunhando um.
Sistema: O taumaturgo precisa primeiro localizar um receptáculo simbolicamente alinhado ao espírito alvo, que eventualmente se tornará o fetiche. Então precisa ordenar ao espírito alvo que entre no receptáculo por meio de uma rolagem oposta de Força de Vontade. O espírito alvo resiste com Força de Vontade (dificuldade igual à Manipulação + Ocultismo do taumaturgo).
Se o taumaturgo tiver sucesso, pode criar um fetiche de nível de poder baseado no número de sucessos obtidos sobre o espírito, até um fetiche de nível cinco. Por exemplo, se o taumaturgo vencer a rolagem oposta de Força de Vontade contra o espírito por três sucessos, cria um fetiche de nível três.
Criar e manter um fetiche é difícil; por isso, o número de fetiches que um taumaturgo pode criar é limitado por sua Força de Vontade. Se o taumaturgo doar tal fetiche, ele ainda conta contra seu total de espaços disponíveis. Ela só pode criar um fetiche adicional quando um de seus fetiches anteriores tiver sido destruído.
Um fetiche concede um número de dados de bônus a uma perícia específica correspondente ao nível do fetiche. Por exemplo, um espírito de cura preso dentro de um bisturi concederia dados extras (o nível do fetiche) para qualquer rolagem de Medicina. O Narrador sempre tem a palavra final sobre que tipo de fetiche pode ser feito.
Um fetiche é ativado rolando-se a Força de Vontade do usuário (dificuldade igual ao nível de poder do fetiche + 3). Uma falha crítica nessa rolagem destrói o componente físico do fetiche e liberta o espírito que estava preso dentro dele.

••••• Dualidade
O taumaturgo agora consegue interagir plenamente com o mundo espiritual — um lugar estranho que só às vezes se assemelha ao mundo real. Ao usar este poder, ela existe nos dois planos de existência ao mesmo tempo. É capaz de pegar objetos no mundo físico e colocá-los no mundo espiritual e vice-versa. Seres e elementos da paisagem em ambos os reinos são sólidos para ela, e ela pode se engajar em qualquer tipo de interação. Pode até usar Taumaturgia e outras Disciplinas em qualquer dos mundos. Isso não vem sem seus perigos. Com um único passo em falso, o vampiro pode se ver preso no reino espiritual sem meio de voltar para casa. Vários taumaturgos incautos definharam até a torpor presos do outro lado da barreira que separa os reinos físico e espiritual.
Sistema: O taumaturgo pode interagir com o mundo espiritual por quinze minutos. Cada nível adicional de sucesso na rolagem de ativação aumenta a duração deste poder em mais quinze minutos. Dualidade só pode ser acionada enquanto o personagem começa o processo no mundo físico. Nesse estado, o taumaturgo fica suscetível a ataques de ambos os reinos e sofre +1 de dificuldade em todas as rolagens de Percepção. O personagem ainda é considerado como estando no mundo físico para fins de física básica (e bom senso).
Espíritos previamente irritados buscarão vingança física contra taumaturgos desatentos que usem este poder.
Uma falha crítica na rolagem para ativar este poder arranca o vampiro do mundo físico e o prende no reino espiritual. O caminho de volta ao reino físico, se houver, fica a critério do Narrador, e pode dar início a uma história inteiramente nova.]==],
				},
				["Path of Technomancy"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 224


Path of Technomancy


A trilha mais recente a ser aceita pela hierarquia Tremere como parte do corpo oficial de conhecimento do Clã, a Trilha da Tecnomancia é uma inovação relativamente recente, desenvolvida na segunda metade do século XX. A trilha se concentra no controle de dispositivos eletrônicos, de celulares a laptops, e seus defensores sustentam que ela é um exemplo primoroso da versatilidade da Taumaturgia diante de um mundo em mudança. Tremere mais conservadores, contudo, afirmam que misturar a magia Tremere com a ciência mortal beira a traição ou mesmo a blasfêmia, e alguns Regentes europeus chegaram a declarar o conhecimento de Tecnomancia motivo de expulsão de suas capelas. O Conselho Interno de fato aprovou a introdução da trilha nos grimórios do Clã, mas ainda não se manifestou sobre a oposição conservadora à Tecnomancia.

• Analisar
Mortais estão constantemente desenvolvendo novas invenções, e qualquer vampiro que queira operar a Tecnomancia precisa ser capaz de compreender aquilo sobre o que pratica sua magia. O poder mais básico desta trilha permite ao taumaturgo projetar suas percepções para dentro de um dispositivo, concedendo-lhe uma compreensão temporária de sua finalidade, dos princípios de seu funcionamento e de seu modo de operação. Isso não concede conhecimento permanente, apenas um lampejo momentâneo de compreensão que se dissipa em minutos.
Sistema: O personagem precisa tocar o dispositivo para aplicar este poder. O número de sucessos rolados determina quão bem o personagem compreende aquele equipamento em particular. Um sucesso permite um conhecimento básico (ligar/desligar e funções simples), enquanto três sucessos concedem competência em operar o dispositivo, e cinco sucessos mostram ao personagem toda a gama de potencial do dispositivo. O conhecimento dura um número de minutos igual à Inteligência do personagem.
Este poder também pode ser usado para compreender uma inovação tecnológica não física — geralmente um software — com +2 de dificuldade. O personagem precisa tocar o computador em que o software está instalado — apenas segurar o pen drive ou CD-ROM não basta. Software aplicado remotamente a um dispositivo (como por uma loja de aplicativos) também não pode ser analisado até estar instalado.

•• Queima
Geralmente é mais fácil destruir do que criar, e a eletrônica sensível não é exceção a essa regra. Queima é usado para provocar um surto na alimentação de um dispositivo (interna ou externa), danificando ou destruindo o alvo. Queima não pode ser usado para ferir diretamente outro indivíduo, embora a destruição súbita de um marca-passo ou do chip de controle de injeção de um carro certamente possa criar um risco à saúde.
Sistema: O personagem pode usar este poder a uma distância de até 10 vezes sua Força de Vontade em metros, embora +1 de dificuldade seja aplicado se ela não estiver tocando o item alvo. O número de sucessos determina a extensão do dano:
1 sucesso — Interrupção momentânea do funcionamento (um turno), mas sem dano permanente.
2 sucessos — Perda significativa de função; +1 de dificuldade para usar o dispositivo pelo resto da cena.
3 sucessos — O dispositivo quebra e fica inoperante até ser consertado.
4 sucessos — Mesmo depois de consertado, as capacidades do dispositivo ficam diminuídas (+1 de dificuldade permanente para usar).
5 sucessos — O equipamento é perda total; completamente irrecuperável.
Sistemas grandes o bastante, como um cluster de servidores ou uma aeronave de passageiros, impõem +2 a +4 de dificuldade (a critério do Narrador) para serem afetados por este poder. Além disso, alguns sistemas, como redes militares e bancárias, podem estar protegidos contra surtos e picos de energia e, portanto, possuir de um a cinco dados (novamente a critério do Narrador) para rolar e resistir a este poder. Cada sucesso nessa rolagem (dificuldade 6) retira um sucesso da rolagem de Taumaturgia.
Queima pode ser usado para destruir armazenamento eletrônico de dados; nesse caso, três sucessos destroem toda a informação no item alvo, e cinco a apagam além de qualquer esperança de recuperação não mágica.

••• Encriptar/Decriptar
A segurança eletrônica é preocupação primordial tanto de governos quanto de corporações. Os taumaturgos versados em tecnologia o bastante para entender o que está em jogo se encantaram bastante com este poder, que lhes permite embaralhar misticamente os controles de um dispositivo, tornando-o inacessível a qualquer outra pessoa. Encriptar/Decriptar também funciona em mídia eletrônica; um DVD sob a influência deste poder exibe apenas chuvisco e estática se for reproduzido sem a aprovação do dono. Alguns neonatos passaram a chamar este poder de "DRM".
Sistema: O personagem toca o dispositivo ou recipiente de dados que deseja encriptar. O jogador rola normalmente. O número de sucessos obtidos é aplicado como modificador de dificuldade para quem tentar usar o equipamento protegido ou acessar a informação embaralhada sem a ajuda do personagem. O conjurador pode dissipar o efeito a qualquer momento tocando o item alvo e gastando um ponto de Força de Vontade.
Este poder também pode ser usado para contrariar o uso de Encriptar/Decriptar por outro taumaturgo. O jogador rola com +1 de dificuldade; cada sucesso anula um do "dono".
Os efeitos de Encriptar/Decriptar duram um número de semanas igual à Força de Vontade permanente do personagem.

•••• Acesso Remoto
Com este poder, um taumaturgo habilidoso pode dispensar a necessidade de contato físico para operar um dispositivo. Não é uma forma de telecinese; o vampiro não manipula os controles do item, mas o toca diretamente com o poder de sua mente.
Sistema: Este poder pode ser usado em qualquer dispositivo eletrônico na linha de visão do personagem. O número de sucessos rolados é o número máximo de dados de qualquer Habilidade pertinente que o personagem pode usar enquanto controla o dispositivo remotamente. (Por exemplo, se Fritz tem Tecnologia 5 e obtém três sucessos ao usar Acesso Remoto numa fechadura de teclado, ele só pode aplicar três pontos de seu nível de Tecnologia a quaisquer rolagens que fizer por meio de qualquer uso do poder.) Acesso Remoto dura um número de turnos igual ao número de sucessos rolados, e só pode ser usado num item por vez.
Se um item for destruído enquanto estiver sob os efeitos de Acesso Remoto, o personagem sofre cinco dados de dano contundente devido ao choque de ter suas percepções bruscamente arremessadas de volta ao próprio corpo.

••••• Teletrabalho
Uma derivação progressiva de Acesso Remoto, Teletrabalho permite ao taumaturgo projetar sua consciência para dentro da Internet, enviando sua mente pelas conexões de rede tão rápido quanto elas conseguirem transferi-la. Enquanto imersa na rede, ela pode usar qualquer outro poder de Tecnomancia nos dispositivos com que fizer contato.
Sistema: O personagem toca qualquer forma de dispositivo de comunicação: um celular, um netbook com 3G, um tablet com Wi-Fi ou qualquer outra coisa conectada direta ou indiretamente à Internet. O jogador rola normalmente e gasta um ponto de Força de Vontade. Teletrabalho dura cinco minutos por sucesso rolado, e pode ser estendido em 10 minutos com o gasto de outro ponto de Força de Vontade. O número de sucessos indica o alcance máximo a que o personagem pode projetar sua consciência para longe do corpo:
1 sucesso — 40 quilômetros
2 sucessos — 400 quilômetros
3 sucessos — 1500 quilômetros
4 sucessos — 8000 quilômetros
5 sucessos — Qualquer lugar do mundo
Enquanto estiver na rede, o personagem pode aplicar qualquer outro poder da Trilha da Tecnomancia a qualquer dispositivo ou dado com que entrar em contato. Uma perda de conexão, seja pela destruição de uma parte da rede, seja simplesmente por perda de sinal de celular, arremessa sua consciência de volta ao corpo e inflige oito dados de dano contundente.
Um personagem viajando pela Internet por meio deste poder pode usar seus poderes da Trilha da Tecnomancia com dificuldade normal. Usar quaisquer outras habilidades ou poderes enquanto assim engajado é feito com +2 de dificuldade.]==],
				},
				["Path of the Father’s Vengeance"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 226


Path of the Father’s Vengeance


Esta trilha, baseada livremente nas interpretações que um taumaturgo poderoso fez do Livro de Nod, dedica-se a entregar justiça à raça dos Cainitas. Cada poder supostamente tem algum precedente nas parábolas do livro antigo, e se concentra em ensinar as lições de Caim pelo poder da magia de sangue. O uso desta trilha é acaloradamente debatido no Sabbat, pois alguns o consideram equivalente a reivindicar para si o direito de Caim sobre todos os vampiros. Vampiros da Camarilla não têm o mesmo conhecimento do Livro de Nod que o Sabbat tem, mas a trilha não é de todo desconhecida nas capelas Tremere.
O poder desta trilha vem não apenas da magia do sangue, mas também da entoação de versos do Livro de Nod. Para que qualquer destes poderes tenha efeito, o conjurador precisa pronunciar a condenação em si. Por exemplo, para invocar o poder de terceiro nível, o conjurador precisa declarar claramente a seu alvo que ela só pode comer cinzas. Em geral, o sujeito precisa conseguir ouvir o conjurador para que estes poderes tenham efeito, embora escrevê-los e mostrá-los ao sujeito também sirva.
Estes poderes se aplicam apenas a vampiros. Não afetam mortais, carniçais nem quaisquer outras criaturas sobrenaturais.

• Litania de Zillah
Zillah, a esposa de Caim, bebeu sem saber de seu marido e senhor três vezes, ficando assim atada a ele. Este poder revela ao taumaturgo laços de sangue e Vinculi existentes.
Sistema: Se o sujeito tiver quaisquer laços de sangue ou Vinculi com outros vampiros, este poder os revela ao conjurador. Embora o conjurador possa não conhecer os vampiros em questão, este poder de fato revela os nomes e dá impressões psíquicas aproximadas dos indivíduos em questão.

•• O Orgulho da Anciã
Este poder inflige a maldição da anciã, que atou Caim a si enquanto ele fugia da rejeição da esposa. Horrivelmente feia, a anciã precisava recorrer a artimanhas para conseguir que outros a ajudassem ou servissem.
Sistema: Este poder reduz a Aparência do alvo a zero. Todas as rolagens Sociais durante esse período geralmente falham, a menos que o personagem tente intimidar ou coagir o sujeito. Este poder dura uma noite.

••• Banquete de Cinzas
Usado primordialmente contra vampiros devassos ou excessivos, este poder remove temporariamente a dependência de sangue de um vampiro. Embora alguns dissessem que isso anula a Maldição de Caim, ele reduz o vampiro a pouco mais que um necrófago miserável, pois precisa consumir cinzas literais, ainda que delas obtenha pouco sustento.
Sistema: A vítima deste poder não consegue mais consumir sangue, vomitando-o como faria com comida ou bebida mortal. Em vez disso, a vítima só pode comer cinzas, e os "pontos de sangue" que obtém disso só podem ser usados para se erguer a cada noite. "Pontos de sangue" de cinza não podem ser usados para alimentar Disciplinas, aumentar Atributos ou alimentar carniçais (embora pontos de sangue reais no corpo do personagem no momento em que este poder é invocado ainda possam ser usados para tanto). O equivalente a um ponto de sangue em cinza é cerca de meio litro, e qualquer cinza serve — cinza de cigarro, restos de fogueira ou cadáveres de vampiros destruídos pelo fogo ou pelo sol. Este poder dura uma semana.

•••• Desfavor de Uriel
Este poder invoca a escuridão do Anjo da Morte. Toda luz que não seja a mais tênue causa dor excruciante ao sujeito, e algumas formas artificiais de luz forte podem até danificar o vampiro. Uriel entregou a maldição de Deus sobre Caim, cobrindo-o com a negrura de suas asas.
Sistema: A presença de qualquer luz deixa o sujeito desconfortável, e luz forte de qualquer tipo — lanternas, faróis etc. — inflige um nível de vitalidade de dano agravado ao personagem a cada turno em que ele permanecer sob seu foco direto. A maioria dos vampiros que sofre esta maldição opta por dormir pela duração dela, escondendo-se na escuridão de seus refúgios até poder caminhar novamente entre os vivos sem dor. Este poder dura uma semana.

••••• Valedição
Muitos Sabbat temem este poder com razão, embora pouquíssimos já o tenham visto ser usado. Ele cobra punição por quebrar um dos maiores mandamentos de Caim — a proibição da diablerie. Como a maioria dos Sabbat alcança seu poder e sua posição por alguma medida de diablerie, eles precisam reconciliar suas crenças com as admoestações de Caim, e este poder engendra um grande senso de humildade.
Sistema: Quando este poder faz efeito, o sujeito reverte imediatamente à sua Geração original. Essa mudança pode implicar a perda de pontos em certos Traços devido aos máximos geracionais. Este poder dura uma semana, após a qual quaisquer Traços reduzidos aos máximos de Geração mais alta voltam ao normal. Leva três turnos para pronunciar o verso completo que efetiva os efeitos deste poder.]==],
				},
				["Path of the Focused Mind"] = {
					pt = [==[Rites of Blood, pág. 139


Path of the Focused Mind


Um aspirante a taumaturgo precisa possuir vontade forte e intelecto bem desenvolvido para dominar a arte sutil da Taumaturgia. Praticantes da Mente Focada aumentam grandemente sua presteza e prontidão mentais, permitindo melhor compreensão de problemas e situações. Taumaturgos, já mentalmente disciplinados, tornam-se assustadoramente poderosos no domínio cerebral ao dominar esta Trilha.
Desenvolvida por Melvin Liebknecht, um erudito Tremere da Cabala, esta Trilha de Taumaturgia definhou na obscuridade até ser descoberta numa capela perdida em Berlim depois do fim da Segunda Guerra Mundial. O interesse por esta Trilha se espalhou rapidamente pela Pirâmide conforme os adaptáveis Tremere perceberam seu grande potencial e seus benefícios. Diferentemente da maior parte da Taumaturgia, os poderes desta Trilha não exigem uma ação para serem invocados, embora ainda exijam o gasto normal de sangue e a rolagem de ativação de Força de Vontade. Taumaturgos com esta Trilha podem usar um único poder dela durante um único turno.

• Prontidão
Usar Prontidão torna o conjurador capaz de obter uma compreensão mais rápida de uma situação difícil. A lucidez aumentada ilumina o conjurador, permitindo maior esperteza e melhores reações a situações em mudança.
Sistema: Este poder só é utilizável na própria taumaturga. Cada sucesso na rolagem de ativação soma um dado a uma parada especial pelo resto do turno. Esses dados podem ser usados em quaisquer rolagens ou ações relacionadas a Raciocínio que a taumaturga realizar durante este turno. Alternativamente, cada dado retirado da parada soma um à iniciativa do conjurador.

•• Centramento
Ao invocar este poder, a taumaturga provoca uma calma súbita e intensa no sujeito, sussurrando-lhe palavras tranquilizadoras. Sob essa serenidade, o alvo consegue se concentrar melhor nas tarefas em curso, ignorando distrações e incômodos, inclusive danos corporais graves. Taumaturgos com medo de frenesi muitas vezes usam este poder em si mesmos para sufocar as próprias emoções e alcançar um estado de tranquilidade.
Sistema: Este poder é utilizável em qualquer sujeito ao alcance da voz da taumaturga e dura um turno por sucesso na rolagem de ativação. Durante esse período, o alvo não é afetado por nenhum poder ou efeito (com a notável exceção de disciplinas de Anciões) que reduza suas paradas de dados. Isso inclui penalidades por ferimento, modificadores situacionais e Disciplinas. Modificações em números de dificuldade ainda se aplicam nesse período, contudo. Além disso, devido à serenidade antinatural que este poder concede, o alvo recebe dois dados adicionais em todas as tentativas de evitar ou romper o frenesi.

••• Mente de Trilho Único
Ao estender seus poderes a outros indivíduos, a taumaturga é capaz de fixar o sujeito numa única ação. Essa unicidade de propósito do alvo é tão completa que ele ignora tudo o mais que ocorre à sua volta. Guardas são facilmente distraídos com este poder, pois sua atenção fica fixada em outro ponto, e a pesquisa se torna uma tarefa dedicada e focada. O uso deste poder é às vezes chamado coloquialmente de "colocar alguém nos trilhos".
Sistema: Este poder pode afetar qualquer um que consiga ouvir a taumaturga. A invocação bem-sucedida torna o alvo incapaz de dividir qualquer parada de dados para múltiplas ações e incapaz de mudar de tática depois de declaradas as ações. Como benefício colateral, o alvo reduz em um a dificuldade da ação declarada. Ações adicionais que a vítima realize (por Celeridade, por exemplo) durante a duração deste poder precisam dar seguimento à ação inicial, pois ela se concentra inteiramente nessa única ideia. Se o alvo quiser tentar um curso de ação diferente, precisa gastar um ponto de Força de Vontade por cena (ou por turno, em combate). A duração de Mente de Trilho Único é uma cena, ou um turno por sucesso na rolagem de ativação.

•••• Pensamento Duplo
Os rigores de aprender Taumaturgia fortalecem a mente e a vontade de um taumaturgo. Como resultado, os versados em Taumaturgia muitas vezes têm a capacidade de avaliar rapidamente uma situação e calcular as opções disponíveis. Neste nível de domínio da Mente Focada, a taumaturga é capaz de dividir sua atenção entre duas tarefas completamente distintas sem penalidade nem distração. Assim como Mente de Trilho Único força a atenção do sujeito a um único objetivo, Pensamento Duplo expande a concentração da taumaturga a ponto de tornar possível o foco em dois objetivos.
Sistema: O uso bem-sucedido de Pensamento Duplo permite ao conjurador realizar duas ações sem penalidade durante seu turno. (Note que este poder especificamente suspende as restrições de múltiplas ações detalhadas em V20, p. 248.) A ação extra concedida por este poder precisa ser uma ação mental, seja o uso de Disciplinas como Auspícios ou Taumaturgia, seja a contemplação de algum problema. Se a personagem estiver usando as duas ações para resolver um problema, ela tem duas paradas de dados separadas para usar. Essas duas ações acontecem ao mesmo tempo, conforme determinado pela iniciativa da personagem. Não se pode usar a ação extra para reconjurar Pensamento Duplo.

••••• Clareza Perfeita
Clareza Perfeita traz à taumaturga um momento zen de compreensão focada, enquanto ela obtém um entendimento breve e perfeito de si mesma, do universo e de seu lugar nele. Essa lucidez protege a taumaturga de influências tanto internas quanto externas; nem mesmo a Besta interior consegue se enfurecer. Pensamento e ação se tornam um enquanto uma serenidade completa da mente desce sobre a taumaturga.
Sistema: Clareza Perfeita dura uma cena (ou um turno mais um turno adicional para cada sucesso na rolagem de ativação, se usada em combate). Nesse período, a taumaturga tem as dificuldades de todas as ações reduzidas em dois. O Membro fica imune a frenesi e Rötschreck de todas as fontes, mesmo gatilhos sobrenaturais. Por fim, quaisquer meios de controlar ou influenciar a taumaturga sofrem +2 de dificuldade, incluindo poderes como Presença, Dominação e Dementação.]==],
				},
				["Path of the Levinbolt"] = {
					pt = [==[Rites of Blood, pág. 140


Path of the Levinbolt


O relâmpago há muito é considerado domínio dos deuses, mas tradicionalmente esteve fora do alcance dos taumaturgos por falta de compreensão dos princípios da eletricidade. Como resultado, esta Trilha permaneceu relativamente obscura até o nascimento da ciência moderna e os esforços de John Blackwood. O suprimento abundante de eletricidade no fim do século XIX significou que taumaturgos não precisavam mais esperar por uma tempestade conveniente para carregar seus poderes, podendo reunir a eletricidade necessária em meros segundos para dirigi-la como quisessem.
Praticantes da Trilha do Raio tendem a causar bastante eletricidade estática ao seu redor, mesmo quando não estão empregando seus poderes. Às vezes isso atrapalha o sinal de celular, faz luzes piscarem sem razão e computadores sofrerem surtos de energia em sua presença.
Vários dos poderes desta Trilha são ativados pelo toque. Dependendo das circunstâncias, o Narrador pode exigir uma rolagem bem-sucedida de Destreza + Briga para o taumaturgo fazer contato com a vítima pretendida. As regras de mira (ver V20, p. 274) se aplicam ao atacar uma extremidade específica se o contato estiver garantido.

• Apagão
Taumaturgos novatos aprendem a absorver livremente a energia ao seu redor por tomadas, circuitos ou baterias. Quem usa este poder consegue sentir a corrente que alimenta determinado sistema elétrico e então puxá-la para si, efetivamente desligando-o.
Sistema: A taumaturga simplesmente lança o olhar sobre um alvo alimentado por eletricidade. Com uma rolagem de ativação bem-sucedida, ela pode desligar um dispositivo elétrico por dez minutos por sucesso na rolagem de ativação. A faísca de eletricidade arqueia do dispositivo diretamente para a taumaturga numa exibição assustadora de poder místico. A fonte deste poder é imediatamente conhecida.

•• Faísca
Taumaturgos novatos conseguem acumular uma carga estática minúscula, suficiente para produzir um estalo perceptível ao toque. Tal descarga representa pouca ameaça a alvos saudáveis, embora a energia possa arruinar eletrônicos delicados ou atordoar uma vítima azarada.
Sistema: A taumaturga simplesmente toca um alvo (após o gasto de sangue exigido e a rolagem de ativação pelo jogador) e libera a faísca. A eletricidade pode estalar de qualquer parte do corpo do conjurador, de modo que uma taumaturga pode dar uma surpresa desagradável a quem a tocar. A descarga elétrica resultante inflige quatro dados de dano letal aos alvos (dificuldade 7 para absorver) e causa curto-circuito em equipamentos e dispositivos eletrônicos não especificamente aterrados contra descargas atmosféricas.

••• Iluminar
Neonatos às vezes se referem depreciativamente a este efeito como o "Tremere de 40 watts", até sentirem sua picada. A taumaturga convoca eletricidade suficiente para cobrir sua mão ou braço com arcos elétricos. Este poder pode carregar uma bateria, fazer funcionar brevemente um pequeno dispositivo ou até deixar uma queimadura feia num sujeito tocado.
Sistema: Cada sucesso obtido na rolagem de ativação do jogador se traduz em aproximadamente um turno de energia suficiente para alimentar um punhado de luzes ou um pequeno dispositivo elétrico. Alternativamente, a taumaturga pode chocar alguém pelo toque, como no poder Faísca, mas causando oito dados de dano elétrico letal (dificuldade 8 para absorver).
A corrente criada com este poder não é forte o bastante para forçar caminho por condutores menos que ideais, e assim simplesmente inflige dano elétrico a metais brutos, madeiras ou outra matéria na forma de queimadura e descoloração. A taumaturga pode alternativamente deixar a eletricidade faiscar ao redor da mão, dos olhos ou da cabeça; isso cria iluminação equivalente a uma lâmpada fraca e reduz em 2 a dificuldade de quaisquer rolagens de Intimidação.

•••• Fúria de Thor
A taumaturga pode golpear seus inimigos de longe como se fosse uma deusa. Ela pode dirigir um arco de relâmpago de seu corpo a alvos próximos.
Sistema: A taumaturga concentra sua atenção no alvo e então dirige os raios arremessados por meio de uma rolagem de Percepção + Ciências (dificuldade 6 mais o alcance em metros, máximo de 4 metros). Cada sucesso inflige um nível de dano letal (dificuldade 8 para absorver). A fonte deste poder é imediatamente conhecida.

••••• Olho da Tempestade
A taumaturga torna-se um pilar mutável e faiscante de poder elétrico. A energia canalizada no Olho da Tempestade protege seu corpo de virtualmente qualquer dano direto.
Sistema: Quando a taumaturga gasta um ponto de Força de Vontade para invocar este poder, ela solidifica a eletricidade armazenada dentro de si numa barreira mística que a cerca completamente. O conjurador se torna imune a quaisquer ataques à distância. Armas de metal, como espadas, causam ferimento normalmente no primeiro golpe, mas então derretem com o contato com a barreira, e quem as empunha sofre um nível de dano letal. Inimigos que ousem tocar o conjurador sofrem dois pontos de dano agravado (dificuldade 8 para absorver). Armas não metálicas, como estacas de madeira, não são afetadas pelo Olho da Tempestade. Este poder dura um único turno, e cada sucesso adicional na rolagem de ativação estende essa duração em um turno. Ataques mentais e sociais podem atravessar esta barreira.]==],
				},
				["Potestas Exsecrabilis"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 300


Potestas Exsecrabilis


Quando os Tremere eram magos mortais, consideravam a bruxaria comum de maldições e imprecações indigna de sua atenção erudita. Agora, contudo, reconheceram que precisam de todo instrumento à sua disposição, e por isso a adaptaram rapidamente às suas necessidades.
O Poder Maldito tem exigências que outras trilhas não têm. Primeiro, o taumaturgo precisa não apenas estar na presença da vítima da maldição, mas declará-la claramente. Não precisa ser numa língua que a vítima entenda, mas ainda assim precisa ser dita com força. Segundo, o taumaturgo precisa de alguma parte do ser da vítima: cabelo, sangue, um pedaço de unha ou algo semelhante. Por fim, a vítima pode se livrar do efeito da maldição fazendo uma rolagem de Força de Vontade (dificuldade 7, salvo indicação em contrário), representando sua capacidade de se manter firme contra o impacto psicológico do poder.

• Estigma
Numa época em que os Tremere lutam por status político, o poder de enfraquecer a capacidade de seus oponentes de influenciar situações sociais pode ser tão importante quanto qualquer demonstração de força bruta. Esta maldição lança uma aura de erro sobre a vítima, fazendo os que estão à sua volta se afastarem instintivamente, encará-la com desconfiança ou simplesmente achar sua presença intolerável.
Sistema: O taumaturgo gasta um ponto de sangue e rola Força de Vontade normalmente. Se tiver sucesso, o alvo sofre penalidade de +2 em todas as ações Sociais (rolagens que envolvam Carisma, Manipulação ou Aparência), até uma dificuldade máxima aumentada de 9. O efeito dura até o próximo pôr do sol ou até que o conjurador decida levantar a maldição.

•• Enfermidade
Embora os Cainitas sejam poupados da maioria das doenças que permeiam o Mundo Medieval Sombrio, esta maldição permite ao conjurador simular seus efeitos. O resultado pode ser tanto fisicamente incapacitante quanto psicologicamente danoso, pois a vítima vampira é súbita e poderosamente lembrada da mortalidade que deixou para trás.
Sistema: Para cada sucesso que o taumaturgo rolar, as paradas de Força, Destreza e Vigor do alvo são reduzidas em um (até o máximo de penalidade de três dados com três sucessos) por um número de noites igual à Força de Vontade do conjurador. A cada noite, a vítima pode fazer uma rolagem de Força de Vontade (dificuldade 7) para se livrar do efeito; cada sucesso reduz a penalidade aos Atributos Físicos em um dado até a noite seguinte. Se ela remover todas as penalidades numa única noite, a maldição é quebrada.

••• Bode Expiatório
Um refinamento da maldição Estigma, Bode Expiatório faz com que aqueles que veem o alvo ou de outro modo interagem com ele o percebam como um rival amargo ou inimigo odiado. As percepções de cada pessoa são afetadas de modo diferente; a vítima se torna quem quer que aquela pessoa mais despreze. Diferentemente de Máscara de Mil Faces, a ilusão lançada pela maldição não pode ser perfurada com Auspícios; seu método é novo demais, incomum demais, para que os traços comuns sejam discerníveis.
Sistema: Para cada sucesso que o taumaturgo rolar, a maldição dura uma noite. Durante esse tempo, a vítima aparece a todos que encontra como alguma forma de inimigo. Embora isso não resulte necessariamente em violência imediata, tende a impedir o alvo de interagir de qualquer modo normal com os que estão à sua volta.

•••• Corromper o Corpo
Com uma imprecação contra alguma característica do alvo, o taumaturgo invoca este poder para causar uma transformação dolorosa e especificamente dirigida. Pode fazer músculos atrofiarem, membros tremerem, rostos se deformarem ou a estrutura inteira do corpo ficar frágil e emaciada. O que a torna mais temível aos olhos de outros Cainitas que testemunharam seus efeitos é que ela pode durar muito mais que outras maldições Tremere. Algumas noites de sofrimento sob uma Enfermidade não são nada comparadas às semanas ou meses de dor que Corromper o Corpo pode causar.
Sistema: Uma vez que o taumaturgo lance a maldição e role por sucessos, o alvo pode tentar resistir rolando Força de Vontade (dificuldade 7), com cada sucesso reduzindo a força efetiva da maldição em um. Depois disso, contudo, não há chance de desfazê-la a menos que o conjurador a levante voluntariamente ou a duração se esgote.
A maldição exige apenas um turno para ser conjurada, mas a transformação leva três turnos para se completar. Nesses três turnos, a dor da mudança reduz em três a parada de dados de qualquer ação que o alvo realize. Depois, pela duração da maldição, as paradas de dados da vítima para todas as ações ficam reduzidas em um (cumulativo com penalidades por ferimento). Além disso, o alvo tem um atributo à escolha do conjurador — Força, Destreza, Vigor ou Aparência — reduzido a 1. A duração depende do número de sucessos rolados:
1 sucesso — Uma noite
2 sucessos — Uma semana
3 sucessos — Um mês
4 sucessos — Uma estação
5 sucessos — Um ano

••••• Acídia
Esta maldição poderosa não apenas lança um manto de infortúnio sobre a vítima, como também instila um senso tão forte de autorrepulsa e derrota que ela pode se retirar inteiramente do mundo até que os efeitos passem. Cada pensamento e ação se torna uma provação, carregada de dúvida e da tristeza esmagadora da crença de que ela fracassará.
Sistema: Os efeitos desta maldição exigem uma rolagem de Força de Vontade (dificuldade 8) para resistir. Se o alvo tiver falha crítica na rolagem e o conjurador tiver obtido ao menos três sucessos ao lançá-la, a maldição é permanente. Do contrário, a duração é a mesma de Corromper o Corpo.
Sob a influência de Acídia, a vítima não pode ter sucesso automático em nenhuma tarefa, e é tratada como tendo rolado uma falha crítica em cada ação. (Em outras palavras, anule um sucesso em cada rolagem; nenhum sucesso significa resultado de falha crítica.) Mesmo se tiver sucesso, o resultado efetivo máximo que ela consegue alcançar é dois sucessos, incluindo sucesso adicional de Força de Vontade ou de outras fontes.]==],
				},
				["Rego Calatio"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 111


Rego Calatio


A formação do Rego Calatio (Regra da Invocação) remonta a uma era anterior aos registros escritos em tinta. Os criadores desta Trilha são desconhecidos e sem nome, suas pesquisas gravadas em pedra ou pintadas com sangue em couros e ossos. A Trilha é dedicada à invocação e ao aprisionamento de demônios. Nos últimos séculos, esses demônios começaram a aparecer em formas esperadas e temidas pelos mortais, manifestando-se como caricaturas da ganância, da luxúria, da preguiça e da ira. Em tempos passados, tinham igual probabilidade de aparecer como pilares de fumaça revolta, o choro de crianças ou o fedor da podridão. Os demônios contatados pelo Rego Calatio não estão presos a nenhuma forma fixa e podem aparecer como bem quiserem.
Invocadores de demônios são ousados. Os demônios sabem que, ao aparecerem fisicamente, ficam enfraquecidos, mas podem facilmente dominar e destruir invocadores sem os meios suficientes para controlá-los. Muitos demônios se agradam de servir sob aprisionamento mágico, já que provavelmente lhes será pedido que perpetrem algo que fariam de qualquer modo se estivessem livres; mas a maioria dos demônios resistirá a tentativas de controle por princípio. Um demônio invocado pelo Rego Calatio permanece na Terra até o sol nascer ou até ouvir sinos de igreja.
Todos os efeitos de Trilha de Taumaturgia Negra que tenham alvo podem ser resistidos com uma rolagem de Força de Vontade (dificuldade 6, mais o nível de Taumaturgia Negra do infernalista, até o máximo de 9).
Preço: A natureza profana do Rego Calatio é tal que qualquer área em que ele é praticado se corrompe; as pessoas adoecem e o gado nasce malformado. O uso do Rego Calatio produz uma sequela necromântica (ver p. 52) baseada em seu nível.
O praticante sofre pesadelos horríveis por um número de noites igual aos sucessos rolados na invocação. Esses pesadelos forçam o infernalista a perder dois pontos de sangue ao despertar, em vez do normal de um, e uma rolagem de Força de Vontade é exigida (dificuldade 7); do contrário, dois pontos temporários de Força de Vontade também são perdidos. Uma falha crítica nessa rolagem faz uma Perturbação apropriada atormentar o infernalista pelo dobro da duração de seus pesadelos induzidos pela invocação.
Sistema: Cada nível desta Disciplina exige o sacrifício da vida de outro ser, com a maioria dos demônios exigindo a morte de um inocente num círculo de ossos ensanguentados. Se um demônio nomeado estiver sendo invocado, o nome dele precisa ser pintado com a vitae do invocador numa pedra no centro do círculo. O infernalista precisa gastar pontos de Força de Vontade iguais ao nível de Rego Calatio ativado; do contrário, o demônio invocado fica livre e ou ignorará ou atacará quem o invocou. Demônios podem absorver todos os tipos de dano com seu Vigor, a menos que esse dano seja causado por alguém com Fé Verdadeira.
• Demônio Menor (Atributos 4/3/2, Habilidades 3/2/1, Força de Vontade 3, Vitalidade 4)
•• Demônio da Loucura (Atributos 5/4/3, Habilidades 4/3/2, Força de Vontade 4, Vitalidade 6, Pontos de Sangue 5, dois pontos de Disciplinas, um dos quais precisa ser Dementação)
••• Demônio da Paixão (Atributos 6/5/4, Habilidades 5/4/3, Força de Vontade 6, Vitalidade 7, Pontos de Sangue 6, quatro pontos de Disciplinas, dois dos quais precisam ser Presença)
•••• Demônio Assassino (Atributos 7/6/5, Habilidades 6/5/4, Força de Vontade 7, Vitalidade 8, Pontos de Sangue 7, seis pontos de Disciplinas, três dos quais precisam ser Potência)
••••• Demônio Nomeado (Atributos 8/7/6, Habilidades 7/6/5, Força de Vontade 9, Vitalidade 10, Pontos de Sangue 10, oito pontos de Disciplinas, alocados onde o infernalista escolher, com máximo de seis pontos numa única Disciplina)
O número de sucessos rolados determina quanto controle o infernalista tem sobre o demônio invocado:
Falha — A invocação não ocorre. Pode ser tentada de novo com um novo sacrifício.
1 sucesso — O demônio fica preso ao círculo por uma noite e só dará ouvidos ao infernalista.
2 sucessos — O demônio fica preso ao círculo por uma noite e dará ouvidos a qualquer um em suas proximidades, respondendo a perguntas simples.
3 sucessos — O demônio fica obrigado a permanecer ao alcance da vista do infernalista por uma noite. Está bem-disposto e responderá com precisão a perguntas complicadas.
4 sucessos — O demônio fica obrigado a permanecer ao alcance da vista do infernalista por uma noite. É forçado a servir ao infernalista em tarefas simples.
5 sucessos — O demônio pode sair do campo de visão do infernalista e cumprir suas ordens sombrias. Submete-se de bom grado aos decretos do infernalista pela duração da noite.
6 ou mais sucessos — Um demônio de um grau acima do pretendido é invocado, e tratado como se tivesse sido invocado com 4 sucessos. O grau máximo é o Demônio Nomeado.]==],
				},
				["Sepulchre Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 160


Sepulchre Path


Pela Trilha do Sepulcro, o vampiro pode testemunhar, invocar e comandar os espíritos dos mortos. Em níveis mais altos, o necromante pode forçar o fantasma a permanecer num lugar ou objeto específico, ou até causar dano direto a espectros. Como muitas outras áreas da Necromancia envolvem lidar com fantasmas, esta é a trilha mais comum para necromantes começarem.
Nota: Se um Membro usar um poder da Trilha do Sepulcro na presença de algo de grande importância para o fantasma que o poder afeta, as chances de sucesso na invocação aumentam drasticamente (reduza a dificuldade em 2). Pode ser a banheira em que o corpo mortal do fantasma foi afogado, a carcaça enferrujada do carro em que o corpo físico do fantasma ficou preso vivo, ou algo não relacionado à morte do fantasma, como um livro predileto ou o quarto de brinquedos amado por um fantasma-criança.

• Testemunha da Morte
Antes de ser possível controlar os mortos, é preciso percebê-los. Este poder permite exatamente isso, sintonizando os sentidos não-vivos do vampiro à presença do incorpóreo. Sob seus efeitos, o necromante vê fantasmas como fantasmagorias translúcidas deslizando entre os vivos e ouve seus sussurros e gemidos. Ela sente o frio espectral do toque deles e cheira seu leve travo mofado de decomposição. Ainda assim, não se pode confundir os mortos com os vivos, pois lhes falta substância verdadeira, e eles parecem mais opacos e menos reais que criaturas de carne e sangue. Quando um vampiro usa este poder, seus olhos tremeluzem com um fogo azul-pálido que só os mortos conseguem ver.
Fantasmas se ressentem de ser espionados, e sombras mais poderosas podem usar seus próprios poderes para infligir seu desagrado aos incautos.
Sistema: O jogador rola Percepção + Prontidão (dificuldade 5). O sucesso permite ao vampiro perceber fantasmas como descrito pelo resto da cena (no mundo mortal — ver fantasmas na terra dos mortos exige Visão do Sudário, na p. 163). A falha não tem efeito especial, mas uma falha crítica significa que o vampiro só consegue ver os mortos pela cena; todo o resto aparece como sombras disformes e opacas. Embora os demais sentidos do vampiro permaneçam sintonizados com os vivos, ele fica praticamente cego nesse estado e sofre +3 de dificuldade na maioria das rolagens de Percepção baseadas em visão e nos ataques. Fantasmas notam os olhos brilhantes de um vampiro usando este poder apenas com uma rolagem bem-sucedida de Percepção + Prontidão (dificuldade 7).

•• Invocar a Alma
O poder de Invocar a Alma permite ao necromante chamar um fantasma de volta do Submundo, apenas para fins de conversa. Para realizar esse feito (e, de fato, a maioria dos feitos desta trilha), o vampiro precisa cumprir certas condições:
• O necromante precisa saber o nome do espectro em questão, embora uma imagem do espectro obtida por Testemunha da Morte (ver acima), Visão do Sudário (ver p. 163), Auspícios ou outra percepção sobrenatural sirva.
• Um objeto com o qual o espectro teve algum contato em vida precisa estar nas proximidades, embora não precise ser algo de importância significativa para a consciência viva do fantasma. Um pedaço do cadáver do fantasma funciona bem para esse fim (e ainda dá um modificador de -1 de dificuldade).
Certos tipos de fantasma não podem ser invocados com este poder. Vampiros que alcançaram Golconda antes de suas Mortes Finais, ou que foram diablerizados, estão fora do alcance desta invocação. Da mesma forma, muitos fantasmas dos mortos não podem ser chamados — foram destruídos, são incapazes de retornar ao plano mortal ou estão perdidos na tempestade eterna do Submundo.
Sistema: O jogador gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade igual a 7 ou à Força de Vontade do fantasma, o que for maior). O vampiro precisa saber o nome do fantasma e ter à mão um objeto com que o fantasma teve contato em vida. Desde que o alvo tenha morrido e se tornado fantasma, o sucesso significa que a sombra aparece diante do necromante como descrito acima. Nem todos viram fantasma — é preciso vontade forte para perseverar diante da morte, e almas que encontraram a paz seguem para suas recompensas eternas. Além disso, é possível que os mortos sofram dissolução e destruição espiritual depois de se tornarem fantasmas. O Narrador deve considerar todos esses fatores ao decidir se determinado fantasma existe para um vampiro invocar.
Vampiros sabem se sua invocação deveria ter tido sucesso por uma sensação de queda súbita e aterrorizante, ao alcançarem longe demais no grande Além, de modo que este poder pode ser usado para determinar se uma alma perdurou além da morte. Enquanto a falha significa que o vampiro desperdiça sangue, a falha crítica chama um espírito diferente do procurado — geralmente um fantasma malevolente conhecido como Espectro (ver p. 385). Tal demônio atormenta quem o invocou com todo poder perverso à sua disposição.
Uma vez invocado, o fantasma não pode deliberadamente sair do campo de visão do vampiro, embora possa realizar quaisquer outras ações, inclusive ataque direto. O jogador do vampiro pode gastar um ponto de Força de Vontade para dispensar o fantasma a qualquer momento (a menos que tenha rolado falha crítica). Do contrário, ao fim da cena, as sombras envolvem o espírito mais uma vez e o devolvem à sua localização original.

••• Compelir a Alma
Com este poder, o vampiro pode ordenar a um fantasma que cumpra suas vontades por um tempo. Compelir a alma é um empreendimento perigoso e, quando usado de modo impróprio, pode pôr em risco tanto vampiro quanto espectro.
Sistema: O vampiro localiza e se aproxima do fantasma pretendido ou o chama à sua presença com Invocar a Alma. Como no poder anterior, ele precisa ter o nome do fantasma e um objeto que ele manuseou em vida. Seu jogador então gasta um ponto de sangue e rola Manipulação + Ocultismo numa rolagem resistida contra a Força de Vontade do fantasma (dificuldade 6 para ambas as rolagens).
Se o vampiro vencer, o número de sucessos líquidos determina o grau de controle que ele tem sobre o fantasma (como descrito abaixo). Além disso, o controle do vampiro impede que fantasmas chamados com Invocar a Alma retornem às suas localizações originais ao fim da cena. Se o fantasma vencer, o vampiro perde um número de pontos de Força de Vontade igual aos sucessos líquidos do fantasma. Num empate, a rolagem se torna uma disputa prolongada que continua a cada turno até um dos lados vencer. Se o vampiro tiver falha crítica em qualquer ponto, o fantasma fica imune a qualquer uso da Necromancia do vampiro pelo resto da cena. Se o fantasma tiver falha crítica, ele precisa obedecer como se o jogador do vampiro tivesse rolado cinco sucessos líquidos.
1 sucesso — O fantasma precisa realizar uma tarefa simples para o vampiro que não o coloque em perigo certo. Precisa cuidar dessa tarefa imediatamente, embora possa adiar a compulsão e seguir seus próprios assuntos ao custo de um ponto de Força de Vontade por cena. O fantasma não pode atacar o vampiro até que essa tarefa esteja concluída. É possível dar como tarefa responder a uma pergunta, caso em que o fantasma precisa responder com verdade e da melhor forma que souber.
2 sucessos — O vampiro pode dar duas ordens ou fazer duas perguntas, conforme descrito para um sucesso. Alternativamente, o vampiro pode exigir uma tarefa simples com possibilidade real de perigo, desde que o perigo não seja certo. O fantasma pode adiar essa compulsão com Força de Vontade.
3 sucessos — O vampiro pode dar três ordens, conforme descrito para um sucesso. Alternativamente, pode exigir que o fantasma cumpra uma tarefa difícil e perigosa ou uma incumbência simples com duração prolongada de até um mês. O fantasma pode adiar tais ordens com Força de Vontade.
4 sucessos — O vampiro pode dar quatro ordens, conforme descrito para um sucesso, ou atribuir duas tarefas, como para dois sucessos. Alternativamente, o vampiro pode ordenar ao fantasma que realize uma incumbência complexa que o coloque em risco extremo, ou que realize qualquer número de tarefas não ameaçadoras como escravo do vampiro por até um mês (ou, se o necromante gastar um ponto permanente de Força de Vontade, por um ano e um dia). É possível que fantasmas adiem tarefas individuais, mas não que adiem a escravização.
5 ou mais sucessos — O vampiro pode dar múltiplas ordens cuja complexidade ou perigo somados equivalham a cinco sucessos. Em vez disso, o vampiro pode ordenar ao fantasma que realize qualquer ação que ele seja capaz de executar dentro de um mês. Tal tarefa pode colocar o fantasma em perigo imediato de destruição, ou até forçá-lo a trair e agredir entes queridos. Não é possível que fantasmas adiem uma tarefa dessa magnitude com Força de Vontade — precisam obedecer.

•••• Assombração
Assombração prende um fantasma invocado a um local específico ou, em casos extremos, a um objeto. O espectro não pode deixar a área à qual o necromante o prende sem arriscar a destruição.
Sistema: A jogadora gasta um ponto de sangue enquanto está no local da assombração ou tocando a prisão pretendida. Ela então faz com que o fantasma seja trazido até si por quaisquer meios que deseje, embora Invocar a Alma seja o mais rápido e confiável. Sua jogadora então rola Manipulação + Ocultismo (a dificuldade é igual aos pontos atuais de Força de Vontade do alvo, se houver resistência, com mínimo de 4; do contrário, é 4). A dificuldade sobe em um se a vampira quiser colocar o fantasma num objeto. Como de costume, a dificuldade diminui em um se a necromante tiver uma parte do cadáver do espírito além de saber seu nome (dificuldade mínima 3).
Cada sucesso prende o fantasma dentro do local ou objeto por uma noite. Essa duração se estende para uma semana se a jogadora gastar um ponto de Força de Vontade, ou para um ano e um dia por um ponto permanente de Força de Vontade. Um espectro que tente deixar a área de uma assombração precisa fazer uma rolagem prolongada de Força de Vontade (dificuldade 9, quatro sucessos cumulativos necessários numa única cena) ou sofrer um nível de dano agravado por rolagem. Se o espectro ficar sem níveis de vitalidade, é arremessado às profundezas do Submundo para enfrentar a destruição.

••••• Tormento
É pelo uso deste poder que necromantes poderosos convencem fantasmas presos a se comportarem — ou então. Tormento permite ao vampiro golpear um espectro como se ele mesmo estivesse nas terras dos mortos, infligindo dano à forma ectoplásmica do espectro. O vampiro permanece no mundo real, contudo, de modo que não pode ser golpeado de volta.
Sistema: O jogador rola Vigor + Empatia (dificuldade igual aos pontos atuais de Força de Vontade do espectro), e o vampiro estende a mão para golpear o espectro. Cada sucesso inflige um nível de dano letal ao espectro. Se o espectro perder todos os níveis de vitalidade, ele desaparece imediatamente pelo que parece ser uma porta para algum reino de pesadelo horrendo. Fantasmas "destruídos" assim não podem reaparecer no mundo real ou perto dele por um mês.]==],
				},
				["The Bialowieza Kraina"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 46


The Bialowieza Kraina


Os koldun da Floresta de Białowieza são compostos de Tzimisce poloneses e russos, mas todos nominalmente pertencem ao Voivodato. É uma floresta primordial de tamanho imenso, intransponível para todos exceto os viajantes mais determinados; o koldun de Sexta Geração Djabelek mantinha ali um domínio solitário, alojado numa fabulosa torre branca. Seu desaparecimento recente levou à soltura de vários cria pela mata, incluindo a menos abertamente antagonista Grondrska. Ela convida rivais a enfrentá-la, junto com estudantes que queiram aprender a seus pés.

• Brecha no Domínio
O koldun está tão em sintonia com seu domínio que consegue detectar quando um intruso adentra suas fronteiras. Esta Disciplina não é focada o bastante para identificar e apontar a localização do intruso, mas fornece aviso prévio adequado antes de uma surpresa. Uma tática comum ao sentir um visitante é dar seguimento enviando espiões animais.
Sistema: O koldun gasta ao menos um ponto de sangue dentro da área que deseja afetar com esta Disciplina, e o jogador rola para ativar este poder (Atributo: Percepção). Um quilômetro quadrado ao redor do koldun é afetado para cada ponto de sangue gasto. Pelo resto da noite, o koldun sente se quaisquer visitantes entram ou saem da área determinada.
Se este poder for ativado dentro da Floresta de Białowieza, nenhum gasto inicial de sangue é exigido. Este poder não pode ser usado num ambiente predominantemente urbano.

•• Dedos de Bialowieza
O koldun com este poder ordena a plantas e árvores próximas que enlacem, e potencialmente imobilizem, suas vítimas. Esta Disciplina afeta plantas de todo tamanho, compelindo desde raízes finas até galhos velhos e retorcidos. Koldun muitas vezes usam Dedos de Białowieza em plantas que cercam trilhas que levam a seus refúgios.
Sistema: O koldun gasta sangue, garantindo que ele toque a planta que deseja afetar, e rola para ativar este poder (Atributo: Destreza). A planta tentará enlaçar qualquer um que passe a até dois metros de seu alcance, permanecendo pronta para agarrar dessa forma por uma noite por ponto de sangue gasto. Para fins de agarrão, a planta rola seis dados. Ela inflige um nível de dano contundente a cada turno após um agarrão bem-sucedido. A planta ganha um dado adicional para agarrar a cada turno subsequente, até o máximo de dez dados. Plantas pequenas possuem dois níveis de vitalidade para fins de destruição, com galhos de árvore chegando a seis, dependendo do tamanho. Elas têm um ponto de Vigor para cada nível de vitalidade e podem absorver dano contundente.
Se este poder for ativado dentro da Floresta de Białowieza, o dano contundente das plantas e seus níveis de vitalidade são dobrados em relação aos números iniciais, com o Vigor aumentando como subproduto do aumento de vitalidade.

••• O Impasse de Grondrska
Conta-se a história de um caçador furtivo que invadiu terras Tzimisce. Não demorou e ele fugia em pânico apavorado. Ele achava que conhecia a floresta, mas as árvores se moviam ao seu redor, cortando sua saída, tocando-o diretamente para o Cainita faminto que esperava lá dentro. O Impasse de Grondrska torna essa lenda terrível uma realidade.
Sistema: A koldun gasta ao menos um ponto de sangue dentro da área que deseja afetar, e a jogadora rola para ativar este poder (Atributo: Percepção). Um quilômetro quadrado ao redor da koldun é afetado para cada ponto de sangue gasto. Pelo resto da noite, quaisquer visitantes detectados com Brecha no Domínio sofrem dificuldade aumentada em três nas tentativas de rastrear, escapar e se orientar dentro da área, enquanto a vegetação rasteira se desloca e se ergue ao redor do intruso. Se o visitante falhar em sua rolagem, a koldun pode escolher se o move para mais perto, para mais longe ou na direção de uma armadilha bem posicionada.
Se este poder for ativado dentro da Floresta de Białowieza, a vegetação rasteira suga dois pontos da Percepção do visitante, devolvidos se ele deixar a área. A koldun pode escolher que isso não afete certos visitantes que dispararam o poder de Brecha no Domínio.

•••• A Boca de Djabelek
Djabelek é um Tzimisce aterrorizante enterrado em algum ponto da Floresta de Białowieza. Diz-se que de algum modo ele continua a se alimentar apesar de seu estado torpor, abrindo a boca enquanto sonha, consumindo o que quer que caia dentro. Este poder muitas vezes resulta em morte rápida para mortais invasores, quando a terra se abre ao redor deles. Sabe-se que koldun usam A Boca de Djabelek perto de seus refúgios como medida de segurança, e no calor da batalha para pegar um oponente desprevenido. Uma língua de lama fria arrasta o intruso para dentro da terra, com pedras que trituram e terra que esmaga pulverizando a vítima.
Sistema: A koldun derrama ao menos um ponto de sangue na área de terra que deseja afetar, e gasta um ponto de Força de Vontade além de fazer a rolagem para ativar este poder (Atributo: Força). Caso qualquer ser pise a até dez metros de onde o poder foi ativado, abre-se um fosso de dois metros de diâmetro e três metros de profundidade. Cada ponto de sangue gasto deixa a vítima presa e imóvel por um turno. Para se libertar, é preciso uma rolagem bem-sucedida baseada em Força por parte da vítima (dificuldade 8), e são exigidos cinco sucessos num teste prolongado. Seres presos no fosso sofrem dois níveis de dano letal a cada turno, que podem ser absorvidos (dificuldade 7).
Se este poder for ativado dentro da Floresta de Białowieza, a duração dele é dobrada. A koldun pode escolher que isso não afete certos visitantes.

••••• A Torre Branca
A Białowieza toma seu nome da notória torre de Djabelek, construída com os ossos alvejados de suas vítimas, empilhados alto para formar um refúgio particularmente sinistro. A torre há muito está ausente da floresta, mas relatos ocasionais de sua reconstrução emergem do ermo — e nem sempre na Floresta de Białowieza.
A Torre Branca é a dádiva concedida pelos demônios da terra com quem Djabelek certa vez fez seu pacto. Os ossos de todas as vítimas da kraina de Białowieza forçam caminho para fora da terra e envolvem em casulo o koldun que os invoca, numa torre de terra e osso de ao menos cinco metros de altura. A koldun pode permanecer dentro do refúgio enquanto seu sangue aguentar, ou dobrar-se de volta à terra com a torre e reemergir em outro lugar, longe do perigo.
Sistema: A koldun espalha um ponto de sangue no solo; a jogadora gasta um ponto de Força de Vontade e faz a rolagem para ativar este poder (Atributo: Vigor). A Torre Branca faz efeito imediatamente, com a terra se movendo e ossos irregulares e blocos de terra formando uma parede circular aparentemente orgânica ao redor da koldun, com cinco metros de altura. Para cada sucesso na ativação, mais um andar de cinco metros de altura é construído acima do inicial, um andar por turno. A Torre Branca se estende sob a terra tanto quanto se estende acima dela, e não tem entrada nem saída, a menos que a koldun assim queira. Quaisquer bens deixados dentro na última vez em que a Disciplina foi ativada permanecem na torre. A Torre Branca é altamente resistente a forças externas, possuindo 20 níveis de vitalidade e invulnerabilidade a tudo exceto dano agravado.
A Torre Branca pode se dobrar de volta à terra levando a koldun junto, ao custo de mais um ponto de sangue e um único ponto de Força de Vontade. Nesse ponto, a vampira fica efetivamente sepultada cinco metros abaixo da terra no local onde a Torre Branca estava.
Ao custo de um ponto de sangue e um ponto de Força de Vontade adicionais, junto com a rolagem para ativar o poder (Atributo: Vigor), a Torre Branca emerge em qualquer ponto num raio de 20 quilômetros da localização anterior, desde que a área seja florestada. O tamanho dessa nova Torre Branca é estabelecido da mesma maneira que na rolagem inicial.
A Torre Branca não se desmonta se a koldun quiser que uma saída apareça e deixar a construção. Se qualquer Cainita cair em torpor dentro da Torre Branca, ou um mortal adormecer lá dentro, ela os consome e acrescenta os ossos do vampiro aos outros que revestem as paredes e os pisos.
Se este poder for ativado dentro da Floresta de Białowieza, ele possui o dobro dos níveis de vitalidade.]==],
				},
				["The Black Sea Kraina"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 277


The Black Sea Kraina


Os koldun da região do Mar Negro praticam estes ritos.

• Vozes Danubianas
Nascendo na Floresta Negra e atravessando uma dúzia de nações a caminho de desaguar no Mar Negro, o poderoso Danúbio tem sido a artéria que sustenta incontáveis impérios desde que há gente vivendo em suas margens. E ao longo de todos eles, os Tzimisce vigiaram. Os koldun conhecem seu verdadeiro valor, pois os espíritos do rio falam com eles, transmitindo o que sabem ou carregando mensagens para eles em troca de um gole da vitae dos feiticeiros vampíricos.
Sistema: O koldun pinga o sangue exigido num rio, riacho ou outro curso d'água corrente. Até a água do degelo da neve ou de uma chuva forte basta para usar este poder. Se for o próprio Danúbio, ou um de seus afluentes, nenhum gasto inicial de sangue é necessário. Eles então fazem a rolagem de ativação (Atributo: Carisma); se tiverem sucesso, um espírito da água lhes aparece e os servirá (na medida do possível) por um número de dias igual aos sucessos rolados. Essa duração pode ser estendida a qualquer momento antes de expirar borrifando mais sangue na água; um ponto de sangue estende a servidão do espírito por mais um dia.
O que o espírito pode fazer é bastante limitado; ele pode conversar com o koldun, compartilhando o que sabe, ou pode receber uma mensagem para levar a alguém ou a outro lugar. O espírito ficará mais que feliz em falar do que sabe; espíritos de rio podem ser bem tagarelas, e aconselha-se ao Tzimisce ajudar a conduzir o espírito aos tópicos que mais lhe interessam, sob pena de ser entretido por horas com descrições prosaicas do campo ao redor. O espírito só é capaz de se mover para cima e para baixo em seu curso d'água (e rio acima é bem mais lento que rio abaixo), de modo que o destinatário da mensagem precisa ser alguém que ele possa encontrar em sua jornada. Outro método envolve instruir o espírito a ir a um lugar ao longo de seu caminho e entregar a mensagem à primeira pessoa que encontrar, embora isso obviamente tenha seus inconvenientes também. Um koldun também pode suplicar a um espírito da água que permaneça num lugar e vigie contra invasores ou outras ameaças, e então se mova rapidamente pelo leito do rio para adverti-la do perigo, caso algum se apresente.

•• Sepultura do Marea Neagra
Os antigos citas tinham seu próprio nome para o grande mar em torno do qual habitavam: axšaina, que se traduz aos nossos ouvidos como "sem luz". A descrição deles é apropriada; a luz do sol não penetra muito além da superfície e, nas porções mais profundas, até o ar deixa de existir. É, de muitas maneiras, o santuário perfeito para um cadáver, como atestam os muitos navios e suas tripulações preservados por toda a eternidade em seu fundo, muitos deles colocados ali por koldun que habitam sob as ondas.
Sistema: A koldun pode sempre descer em segurança às profundezas mais baixas do Mar Negro, onde pode repousar confortavelmente, protegida do sol e do mundo exterior. Ao borrifar seu sangue num corpo d'água grande o bastante para conter sua massa e fazer sua rolagem de ativação (Atributo: Raciocínio), ela imbui aquela água com todas as propriedades protetoras do Mar Negro. Ela não pode ser ferida pela luz do sol, seu corpo fica perfeitamente preservado enquanto ela permanecer ali sepultada, e ela se torna extremamente difícil de detectar. Para avistar a koldun, um personagem precisa rolar Percepção + Prontidão (dificuldade 8) e obter mais sucessos que a koldun rolou em sua ativação. Quem enfrentar a Tzimisce submersa sofre dois níveis de dano letal a cada turno em que permanecer na água gelada.

••• Pontos Euxeinos
Os gregos certa vez chamaram o Mar Negro de Pontos Euxeinos, o Mar Hospitaleiro. Para os koldun da kraina do Mar Negro, ele realmente pode sê-lo, acolhendo-os em seu abraço e curando-os até de seus piores ferimentos.
Sistema: A koldun precisa ter acesso a um corpo d'água grande o bastante para se submergir. Uma vez submersa na água acolhedora, ela libera nela o sangue exigido (embora, se for de fato o Mar Negro, nenhum gasto de ponto de sangue seja necessário), e então faz sua rolagem de ativação (Atributo: Vigor). Cada sucesso pode ser alocado à cura exatamente como se fosse um ponto de sangue (um sucesso cura um nível de dano contundente ou letal, enquanto cinco sucessos curam um nível de dano agravado). Isso não reduz a limitação de tempo sobre a cura; para curar dano agravado, a koldun precisa permanecer submersa e em repouso por um dia por nível curado.

•••• Servos da Marmara Profunda
Conta a lenda que o koldun Cízico, que reinou abertamente como rei dos dolíones nos dias da antiguidade, descobriu que, se derramasse seu sangue no Mar de Marmara, bestas estranhas de suas profundezas emergiriam para cumprir suas ordens. Outros koldun descobriram que qualquer corpo d'água serve igualmente, embora as criaturas que habitam as profundezas de Marmara sejam as mais fortes.
Sistema: O koldun borrifa seu sangue sobre a superfície da água — ao menos um ponto de sangue, mas quantos ele escolher gastar — e então faz a rolagem de ativação (Atributo: Manipulação). Para cada sucesso, até o total de pontos de sangue gastos, um servo emerge da água. Os Servos da Marmara Profunda são criaturas humanoides estranhas, combinando traços de rã e peixe. Eles realizarão uma tarefa para o koldun, após a qual estão livres para retornar a suas moradas aquáticas. A cada servo pode ser dada uma tarefa diferente. Servos usam os seguintes valores (os valores entre parênteses são para os servos invocados do próprio Mar Negro):
Atributos: Força 4 (5), Destreza 3, Vigor 4 (5), Carisma 1, Manipulação 1, Aparência 0, Percepção 3, Inteligência 1 (2), Raciocínio 2 (3)
Força de Vontade: 3
Níveis de Vitalidade: Ok, Ok, -1, -1, (-1), -2, -2, -2, -5, (-5), Incapacitado
Habilidades: Esportes 2, Briga 4, Intimidação 3, Sobrevivência 3
Ataque: Garras (Força + 2, letal), Agarrão (Força + 4, contundente); escamas e carne gordurosa dão +2 dados nas rolagens de absorção.
Capacidades: Servos de Marmara podem respirar ar ou água igualmente bem. São nadadores exímios, movendo-se com a mesma facilidade dentro e fora d'água.

••••• Pontos Axeinos
Antes de os gregos colonizarem seu litoral sul, chamavam o Mar Negro de Pontos Axeinos, o Mar Inóspito. Para os inimigos do koldun, ele pode ser bem inóspito, parindo tempestades, redemoinhos, névoa e barreiras rochosas onde não havia nenhuma momentos antes.
Sistema: O koldun pinga seu sangue num corpo d'água (a menos que seja o Mar Negro, caso em que nenhum sangue precisa ser gasto) e faz a rolagem de ativação (Atributo: Inteligência). Ela pode alocar seus sucessos para manifestar qualquer número de perigos aquáticos para seus oponentes enfrentarem; alguns exemplos do que cada sucesso pode realizar: um redemoinho ou correnteza de fundo com Força igual à Força da koldun, que pode agarrar ou arrastar os outros; aumentar em um o multiplicador de Força da correnteza; revelar rochas pontiagudas que causam Força + 3 de dano letal quando alguém se choca contra elas; névoa que aumenta em 2 todas as dificuldades de Percepção baseadas na visão; ventos e chuva fortes com rajadas de até 75 km por hora; uma queda abrupta da temperatura da água a níveis quase de congelamento, e assim por diante. Este poder dura uma cena e então se dissipa.]==],
				},
				["The Blessings of the Great Dark Mother"] = {
					pt = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, pág. 86


The Blessings of the Great Dark Mother


Uma trilha taumatúrgica de desenvolvimento relativamente recente, as Bênçãos da Grande Mãe Sombria valem-se diretamente da natureza de seus servos espírito-besta — Gato, Coruja, Serpente e Dragão entre eles — para auxiliar os ashipu em suas lutas contra o infernal. Apesar do epíteto "Mãe dos Demônios", os filhos de Lilith quase nunca são habitantes do Inferno nem restos rejeitados do Vazio Exterior, mas a prole de suas muitas uniões com seres estranhos e maravilhosos. Partilhando da essência de Lilith e da de seus parceiros, essas uniões produzem entidades que são misturas únicas de espiritual e físico, cuja mutabilidade de substância as torna vulneráveis a abusos por parte dos ignorantes e dos inescrupulosos. As técnicas usadas pelos feiticeiros da Primeira Tribo para alterar sutilmente os Nomes verdadeiros dos Filhos do Vazio Exterior, as expectativas ritualmente impostas pelos demonólogos mortais e a potente magia verdadeira dos Desperto podem todas forçar os Lilin à forma demoníaca. As artes desta trilha podem libertá-los desse cativeiro e distorcer, perturbar e profanar os pactos e laços profanos entre um infernalista e seus mestres e servos genuinamente diabólicos.

• Canção de Ninar
A ashipu profere uma encantação que lhe revela a natureza de quaisquer pactos, laços ou vínculos espirituais com outros seres ao alcance audível de sua voz. Esses laços aparecem de modo diferente para cada ashipu que emprega a canção de ninar, dependendo fortemente de seu estímulo sensorial preferido. Algumas veem os laços como fios de luz enrolados nos outros, pulsando com cores que definem sua natureza; outras os ouvem como uma canção rica e complexa cujas melodias internas, harmonias, andamento e ritmo contêm a informação de que precisam. Cantada da forma mais apropriada, a encantação também pode ser simplesmente falada, assobiada nas notas apropriadas ou tocada sem palavras num instrumento musical como poema sinfônico; a amplificação eletrônica pode aumentar, e aumenta, seu alcance efetivo.
Sistema: A ashipu canta sua canção de ninar, gasta um ponto de sangue e rola Percepção + Ocultismo (dificuldade igual à maior Força de Vontade atual entre os indivíduos do grupo, ou à Força de Vontade atual do indivíduo se estiver tentando afetar um alvo único). Se tiver sucesso, a canção faz com que todo e qualquer pacto infernal, pacto espiritual e laço voluntário ou involuntário de qualquer tipo (inclusive o laço de sangue) se torne "visível" de alguma forma para a conjuradora.

•• Kessep
O primogênito de Lilith e Lúcifer foi chamado "Prata" pela luz da Lua, tom refletido nas escamas prateadas e brilhantes da serpente que serve à Grande Mãe Sombria. A serpente às vezes funciona como uma de suas muitas formas, simbólica de pureza e purificação. A ashipu que invoca a serpente argêntea canta, fala ou toca uma invocação que lhe permite selecionar um laço infernal ou espiritual e purificar o dono dele — rompendo os vínculos de espíritos ou demônios presos. Esta invocação não pode romper o laço de sangue (não importa quão involuntariamente ele tenha sido firmado), nem pode desfazer um pacto infernal.
Sistema: A ashipu invoca a dádiva da serpente argêntea, gastando um ponto de sangue e rolando Manipulação + Ocultismo, com dificuldade igual à Força de Vontade atual do alvo. Se tiver sucesso, a invocação faz com que um único laço selecionado entre o alvo e um espírito escravizado ou demônio preso seja rompido. Isso, é claro, libera o espírito ou demônio antes preso para fugir, se vingar ou impor quaisquer consequências do cativeiro que prefira sobre seu antigo dono.

••• Sotheq
O segundo filho de Lilith e Lúcifer foi chamado "Silêncio", pela paz e quietude de D'hainu, o jardim de renovação da Grande Mãe Sombria, e é também um atributo da coruja vigilante e caçadora noturna que ao mesmo tempo a serve e a encarna. A ashipu que invoca a coruja de asas crepusculares canta, fala ou toca uma invocação que lhe permite silenciar todos os vínculos infernais ou espirituais de seu alvo, tanto pactos quanto laços.
Sistema: A ashipu invoca a dádiva da coruja crepuscular, gastando um ponto de sangue e rolando Manipulação + Ocultismo, com dificuldade igual à Força de Vontade atual do alvo. Se tiver sucesso, a invocação faz cair um silêncio psíquico ou espiritual sobre todos os laços e pactos em que o alvo esteja envolvido — ele não pode mais dar ordens a seus espíritos presos ou demônios servos, nem pode receber comunicação ou ordens de qualquer espírito ou demônio que o tenha em servidão. Sucesso excepcional (quatro sucessos ou mais) estende este efeito ao Cainita do outro lado de qualquer laço de sangue em que o alvo esteja envolvido.

•••• Allah
A filha mais nova de Lilith e Lúcifer foi chamada "Noite", pelo reino que teria sido dela se tivesse vivido até a maturidade. Tal escuridão também é um atributo do gato de patas macias e garras afiadas que guardava as fronteiras de D'hainu e protegia os que habitavam o Jardim da Renovação. A ashipu que invoca o gato de pelagem de sombra canta, fala ou toca uma invocação que lhe permite atacar diretamente todos os vínculos infernais ou espirituais menores de seu alvo, partindo os laços como com um golpe de garras mortíferas e desarmando o alvo de suas armas espirituais.
Sistema: A ashipu invoca a dádiva do gato de sombra noturna, gastando um ponto de sangue e rolando Manipulação + Ocultismo, com dificuldade igual à Força de Vontade atual do alvo, para cada espírito ou demônio que o alvo mantenha escravizado como servo. O sucesso liberta o espírito ou demônio preso para fazer o que quiser. A falha não apenas deixa de libertar o espírito ou demônio, como também permite que essas entidades saibam precisamente quem tentou romper aqueles vínculos.

••••• Memo
A primogênita e filha mais velha de Lilith e Lúcifer foi sua filha, chamada "Água" em homenagem à lembrança carinhosa que a mãe tinha tanto dos riachos cristalinos do Éden perdido quanto das vastas profundezas oceânicas em que se abrigou após sua expulsão. Nos oceanos, ela pariu a primeira de suas muitas ninhadas e emergiu de seu exílio mais poderosa que antes. Poderosos e profundos são os poderes daquele grande reino primordial, e poderosa era a forma que a Grande Mãe Sombria ali assumiu. Ela emprestou os segredos e as dádivas daquela forma à sua primeira filha e filha mais velha, a dragoa cujas asas encobriam a lua, o sol e as estrelas, e cujas escamas brilhavam com todos os tons do mar, a maior de todas as purificadoras. A ashipu que invoca a dragoa que chora lágrimas de sal canta, fala ou toca uma invocação que lhe permite atacar diretamente o pacto infernal ou espiritual principal de seu alvo.
Sistema: A ashipu invoca a dádiva da grande serpente do oceano, gastando um ponto de sangue e rolando Percepção + Ocultismo, com dificuldade igual à Força de Vontade atual do alvo. Ao fazê-lo, ela obtém o conhecimento do que levou o alvo a firmar uma barganha em que sua alma seria perdida. Cada sucesso rolado rende conhecimento mais detalhado sobre seu alvo, sobre a natureza e as forças do pacto e sobre quaisquer investiduras ou dádivas infernais que o alvo possua. Sucesso espetacular rende o Nome Verdadeiro do patrono demoníaco do alvo e a oportunidade de enfrentá-lo diretamente numa rolagem disputada de Manipulação + Ocultismo (dificuldade igual à Força de Vontade permanente dele). O sucesso por parte da ashipu rompe o laço entre o infernalista e seu patrono; o sucesso por parte do patrono permite que o laço permaneça intacto. A falha de qualquer rolagem nesta sequência permite ao patrono do infernalista perceber a ashipu e obter informação substancial sobre ela por meio do contato.]==],
				},
				["The Covenant of Enki"] = {
					pt = [==[Rites of Blood, pág. 160


The Covenant of Enki


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
O Pacto de Enki é uma dessas trilhas: é funcionalmente idêntica ao Poder de Netuno (V20, pp. 218-220).]==],
				},
				["The Fires of the Inferno"] = {
					pt = [==[Rites of Blood, pág. 167


The Fires of the Inferno


Praticantes dos Fogos do Inferno podem convocar fogo maligno que brota de suas mãos em jatos ou globos. Muitos acreditam que esta chama verde maligna seja conjurada das próprias profundezas do Hades. Ser queimado por esses fogos é provar as agonias que os aguardam no Inferno. Testemunhar a conjuração dos Fogos do Inferno permite a qualquer um com sentidos místicos saber que a fonte é infernal. O fogo maligno é muito temido, pois o fogo é uma das maneiras mais certeiras de trazer a Morte Final a um vampiro.
Sistema: O número de sucessos determina com que precisão o vampiro coloca a chama no local desejado (declarado antes de a rolagem ser feita). Não são fornecidas descrições individuais para cada nível desta trilha — fogo é fogo, afinal (e pode potencialmente causar frenesi em outros vampiros que o testemunhem). A tabela abaixo descreve o nível de trilha necessário para gerar determinada quantidade de chama. Para absorver o dano de alguma forma, o vampiro precisa ter a Disciplina Fortitude.
O fogo sob controle do conjurador não fere o vampiro nem o faz entrar em frenesi, mas incêndios iniciados como resultado da chama antinatural afetam o taumaturgo normalmente.
• Isqueiro (dificuldade 3 para absorver, um nível de vitalidade de dano por turno)
•• Boca de fogão (dificuldade 4 para absorver, dois níveis de vitalidade de dano por turno)
••• Maçarico (dificuldade 5 para absorver, três níveis de vitalidade de dano por turno)
•••• Lança-chamas (dificuldade 7 para absorver, quatro níveis de vitalidade de dano por turno)
••••• Conflagração (dificuldade 9 para absorver, cinco níveis de vitalidade de dano por turno)]==],
				},
				["The Flow of Ashe"] = {
					pt = [==[Rites of Blood, pág. 165


The Flow of Ashe


O Fluxo do Ashe (Trilha de Wanga) é incomum mesmo entre as Trilhas de feitiçaria por não custar sangue para ser usado. Na verdade, sua finalidade é evitar que o wangateur precise usar vitae em outros contextos. Derivado do herbalismo iorubá, o Fluxo do Ashe pode ser descrito com mais exatidão como uma série de rituais que precisam ser aprendidos sequencialmente. Cada ritual produz uma mistura de ervas que, se usada corretamente, pode tomar o lugar do sangue em diferentes circunstâncias. A rolagem de Força de Vontade é feita quando o ponto de sangue normalmente seria gasto. Se falhar, o vampiro perde dois pontos de sangue em vez do um que teria gasto se tivesse pulado o ritual por completo. Normalmente, os ingredientes precisam ser misturados e a mistura usada no turno seguinte, mas a Dádiva do Ashe supera essa limitação. Mais importante, se as circunstâncias permitirem, muitas dessas misturas podem até ser usadas em outros além do wangateur.

• Toque da Vida
O wangateur pode ingerir uma mistura especial de ervas e pós em vez de gastar sangue ao tentar imitar as características dos vivos. O efeito dura uma cena. O wangateur pode ingerir esta mistura para si mesmo ou fornecê-la a outro Membro (mas não a um mortal), que precisa engolir a mistura durante aquela cena. Neste último caso, o wangateur decide que aspecto dos vivos o outro Membro imitará.

•• Força da Raiz e da Pedra
O wangateur pode inalar pelo nariz uma mistura de ervas e pós em vez de gastar sangue ao tentar aumentar um Atributo Físico. O efeito é o mesmo que se o vampiro tivesse gasto um ponto de sangue para melhorar um Atributo Físico. O efeito dura uma cena. O wangateur pode usar esta mistura ele mesmo ou fornecê-la a outro (inclusive a um mortal). Se for para ser usada por outro, o wangateur decide qual Atributo será aumentado quando a mistura é preparada.

••• Sopro da Vida
A wangateur pode usar uma mistura de ervas e pós no lugar do sangue ao tentar se curar. A mistura específica produz uma pasta que a wangateur precisa esfregar fisicamente na área a ser curada. O efeito é o mesmo que se o vampiro tivesse gasto um ponto de sangue para reparar dano físico. Este poder não pode ser usado para curar dano agravado, apenas contundente ou letal. A wangateur pode usar esta mistura para si mesma ou para outro (inclusive um mortal).

•••• Favor dos Orixás
A wangateur pode usar uma mistura de ervas e pós para alimentar qualquer Disciplina (inclusive magia de sangue) que exija exatamente um ponto de sangue para funcionar. Esta fórmula também exige uma pequena quantidade de sangue para funcionar, mas ele não precisa vir da wangateur e, de fato, pode vir de um inimigo (humano ou Membro) que tenha derramado sangue por perto. A wangateur só pode usar esta mistura em si mesma e precisa fazer um corte superficial no braço e então esfregar a mistura na ferida aberta.

••••• Dádiva do Ashe
O wangateur pode agora criar misturas usando os três primeiros níveis desta trilha que manterão sua eficácia por uma noite inteira, em vez de apenas um turno ou uma cena. Além disso, o wangateur pode manter simultaneamente um número de misturas até sua Inteligência. Assim, ele pode fornecer as misturas a aliados e não precisa mais estar por perto para conceder os benefícios apropriados — pode simplesmente dar a mistura a uma aliada e mandá-la seguir seu caminho.]==],
				},
				["The Green Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 215


The Green Path


A Trilha Verde trata da manipulação de matéria vegetal de todo tipo. Qualquer coisa mais complexa que uma floração de algas pode teoricamente ser controlada pela aplicação apropriada desta trilha. Samambaias, rosas, dentes-de-leão e até sequoias ancestrais são alvos válidos para os poderes desta trilha, e matéria vegetal viva e morta são igualmente afetadas. Embora não seja tão imediatamente impressionante quanto algumas outras trilhas mais praticadas, a Trilha Verde (às vezes chamada depreciativamente de "Domínio Botânico") é tão sutil e poderosa quanto o mundo natural que ela afeta.

• Sabedoria das Ervas
Com um toque, o vampiro pode comungar com o espírito de uma planta. Conversas travadas dessa maneira são muitas vezes crípticas, porém proveitosas — a sabedoria e a experiência dos espíritos de algumas árvores superam as dos oráculos da lenda. O capim, por outro lado, raramente tem muito discernimento a oferecer, mas pode revelar a aparência da última pessoa que o pisou.
Sistema: O número de sucessos rolados determina a quantidade de informação que se pode obter do contato. Dependendo da informação precisa que o vampiro busca, o Narrador pode exigir que o jogador role Inteligência + Ocultismo para interpretar os resultados da comunicação.
1 sucesso — Impressões crípticas fugazes
2 sucessos — Uma ou duas imagens claras
3 sucessos — Uma resposta concisa a uma pergunta simples
4 sucessos — Uma resposta detalhada a uma ou mais perguntas complexas
5 sucessos — A totalidade do conhecimento do espírito-planta sobre determinado assunto

•• Acelerar a Passagem das Estações
Este poder permite ao taumaturgo acelerar o crescimento de uma planta, fazendo rosas florescerem em questão de minutos ou árvores dispararem de mudas da noite para o dia. Alternativamente, ela pode acelerar a morte e a decomposição de uma planta, murchando grama e desfazendo estacas de madeira com um mero toque.
Sistema: O personagem toca a planta alvo. O jogador rola normalmente, e o número de sucessos determina a quantidade de crescimento ou decomposição. Um sucesso dá à planta um breve surto de crescimento ou simula os efeitos de tempo severo, enquanto três a aumentam ou murcham perceptivelmente. Com cinco sucessos, uma planta adulta brota de uma semente ou se desfaz em pó em poucos minutos, e uma árvore dá frutos ou começa a apodrecer quase instantaneamente. Se este poder for usado em combate, três sucessos são necessários para tornar uma arma de madeira completamente inútil. Dois sucessos bastam para enfraquecê-la, enquanto cinco fazem com que ela se desintegre na mão de quem a empunha.

••• Dança das Trepadeiras
O taumaturgo pode animar uma massa de vegetação de até seu próprio tamanho, usando-a para fins utilitários ou de combate com igual facilidade. Folhas podem caminhar sobre uma escrivaninha, hera pode atuar como escriba, e cipós de selva podem estrangular oponentes. Intrusos devem se acautelar com oficinas Tremere que abriguem mudas de sorveira em vasos.
Sistema: Qualquer quantidade total de vegetação com massa menor ou igual à do personagem pode ser animada por este poder. As plantas permanecem ativas por um turno por sucesso obtido na rolagem, e ficam sob controle completo do personagem. Se usadas para fins de combate, as plantas têm Força e Destreza iguais, cada uma, à metade da Força de Vontade do personagem (arredondada para baixo) e Briga um ponto abaixo da do personagem.
Dança das Trepadeiras não pode fazer plantas se desenraizarem e sair pisoteando por aí. Mesmo a vegetação mais enérgica é incapaz de se arrancar do solo e caminhar sob o efeito deste poder. Contudo, 100 quilogramas de kudzu conseguem cobrir uma área considerável sozinhos….

•••• Refúgio Verdejante
Este poder tece um abrigo temporário a partir de uma quantidade suficiente de matéria vegetal. Além de prover proteção física contra os elementos (e até contra a luz do sol), o Refúgio Verdejante também estabelece uma barreira mística quase intransponível para qualquer um que o conjurador deseje excluir. Um Refúgio Verdejante aparece como um hemisfério de dois metros de altura, de galhos, folhas e cipós entrelaçados, sem abertura discernível, e mesmo para o observador casual parece uma construção antinatural. Corre o boato de que Refúgios Verdejantes têm propriedades curativas sobrenaturais, mas nenhum Membro relatou ter experimentado tais benefícios numa estadia em um deles.
Sistema: O personagem precisa estar de pé numa área densamente vegetada para usar este poder. O Refúgio Verdejante brota ao redor do personagem ao longo de três turnos. Uma vez estabelecido o refúgio, quem quiser entrar nele sem a permissão do conjurador precisa obter mais que o número original de sucessos do conjurador numa única rolagem de Raciocínio + Sobrevivência (dificuldade igual à Força de Vontade do conjurador). O refúgio dura até o próximo pôr do sol, ou até que o conjurador o dissipe ou o deixe. Se o conjurador obtiver quatro ou mais sucessos, o refúgio é impenetrável à luz do sol, a menos que seja rompido fisicamente.

••••• Despertar os Gigantes da Floresta
Árvores inteiras podem ser animadas por um mestre da Trilha Verde. Carvalhos ancestrais podem receber temporariamente o dom do movimento, arrancando as raízes do solo e sacudindo o chão com seus passos. Embora não sejam tão versáteis quanto elementais ou outros espíritos invocados, árvores trazidas à vida pesada por este poder demonstram força e resistência formidáveis.
Sistema: O personagem toca a árvore a ser animada. O jogador gasta um ponto de sangue e rola normalmente. Se a rolagem tiver sucesso, o jogador precisa gastar um ponto de sangue para cada sucesso. A árvore permanece animada por um turno por sucesso rolado; quando esse tempo se esgota, a árvore lança raízes onde quer que esteja e não pode ser animada de novo até a noite seguinte. Enquanto animada, a árvore segue as ordens verbais do personagem da melhor forma que consegue. Uma árvore animada tem Força e Vigor iguais ao nível de Taumaturgia do conjurador, Destreza 2 e Briga igual à do próprio conjurador. Ela é imune a dano contundente, e todas as paradas de dano letal são reduzidas à metade devido ao seu tamanho.
Uma vez que a energia animadora deixa a árvore, ela lança raízes imediatamente, independentemente do que esteja sob ela no momento. Uma árvore se restabelecendo no solo pode furar concreto e asfalto para achar terra e água nutritivas embaixo, o que significa que é inteiramente possível um plátano se enraizar no meio de uma estrada sem aviso algum.]==],
				},
				["The Hand of the Magi"] = {
					pt = [==[Rites of Blood, pág. 160


The Hand of the Magi


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
The Hand of the Magi é uma dessas trilhas: é funcionalmente idêntica ao Chamado das Chamas (V20, p. 218).]==],
				},
				["The Hunter’s Winds"] = {
					pt = [==[Rites of Blood, pág. 159


The Hunter’s Winds


Esta trilha foi originalmente desenvolvida por feiticeiros Assamitas e raramente é encontrada fora daquele Clã, mas seu conhecimento passou ao acervo maior do saber Dur-An-Ki. A Trilha é feita para aumentar a furtividade natural do vampiro e sua perícia com Ofuscação. Embora muitos aspectos desta Trilha pareçam redundantes dada a existência de Ofuscação, a Trilha oferece uma vantagem poderosa sobre aquela Disciplina — por exemplo, Auspícios não perfura automaticamente o véu proporcionado pelos Ventos do Caçador. Embora Auspícios possa somar às rolagens de Percepção do observador conforme o Narrador julgar adequado, o observador não enxerga automaticamente através dos enganos só porque seu Auspícios excede o nível de Trilha do ashipu, como é o caso com Ofuscação ou Quimerismo.

• Odor do Engano
O alvo deste poder ganha a capacidade de alterar seu odor ou eliminá-lo completamente.
Sistema: Uma rolagem bem-sucedida significa que o alvo ou não deixa odor algum que possa ser detectado ou rastreado, ou deixa o odor de outra pessoa que ela conheça. A falha significa que nada acontece. Uma falha crítica significa que o odor dela fica mais facilmente identificável para os outros (além das outras penalidades por falha crítica numa rolagem de magia de sangue).

•• Pele de Camaleão
A pele e as roupas do alvo automaticamente assumem a coloração e a textura daquilo perto do que ele estiver.
Sistema: Pela duração da cena seguinte à cena de ativação, a dificuldade de todas as rolagens de Percepção para detectar o alvo aumenta em +4 enquanto ele permanecer parado. Enquanto estiver em movimento, o efeito é anulado, mas assim que ele voltar a parar junto a uma superfície diferente, pode reafirmar a camuflagem com uma rolagem bem-sucedida de Percepção + Furtividade (dificuldade 6, ou 9 se alguém estiver ativamente procurando por ele no momento). Quaisquer mudanças de textura são ilusórias; o alvo não ganha a resistência de um muro de tijolos só por ficar perto dele.

••• Pose Discreta
O alvo se mistura sem esforço a qualquer multidão. Todos os presentes assumirão que o alvo pertence àquele lugar, inclusive quaisquer perseguidores.
Sistema: Se a rolagem tiver sucesso, qualquer observador assumirá automaticamente que o alvo pertence ao local em que for encontrado. Os que o procuram são incapazes de perceber que ele é um intruso. Contudo, este efeito não engana a tecnologia, e qualquer um que observe por circuito interno de TV, por exemplo, pode identificá-lo como intruso.

•••• Sopro de Kalif
O alvo deste efeito gera uma aura fisicamente inebriante para qualquer um que a observe diretamente. Os afetados podem experimentar um devaneio agradável, ou podem simplesmente ficar parados de boca aberta enquanto o alvo segue seu caminho.
Sistema: Se o efeito for ativado com sucesso, qualquer um que observe o alvo durante o resto da cena precisa rolar reflexivamente Raciocínio + Prontidão (dificuldade 7) ou ficar inebriado por um número de horas igual aos sucessos do ashipu ao disparar o efeito. Indivíduos afetados são incapazes de realizar qualquer ação além de encarar com o olhar perdido visões que só eles veem, ou talvez rir baixinho de vez em quando. Contudo, qualquer ameaça direta a um indivíduo afetado faz a embriaguez se dissipar imediatamente.

••••• Corpo Fantasma
Como efeito particularmente poderoso, Corpo Fantasma exige que o ashipu gaste três pontos de sangue em vez do normal de um. Quando o efeito é ativado, o alvo se torna completamente invisível, inaudível e intangível, e pode se mover livremente através de quaisquer barreiras que não sejam proteções contra vampiros.
Sistema: Se ativado com sucesso, o alvo se torna imaterial em quase todos os sentidos. O efeito não a transforma num fantasma de verdade, e ela é incapaz de interagir com espectros ou espíritos nessa forma. Ela também é incapaz de usar quaisquer Disciplinas nessa forma. O efeito termina assim que o alvo tomar a decisão consciente de afetar o mundo físico de qualquer maneira.]==],
				},
				["The Keeper’s Way"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 42


The Keeper’s Way


Os Guardiões praticam uma trilha epônima de Feitiçaria Assamita conhecida apenas por eles.
Guardiões não conseguem passar sem beber ao menos um ponto de sangue do Grande Poço a cada noite. Quando deixam de fazê-lo, sofrem um nível de dano agravado inabsorvível a cada noite sem beber. Quando Guardiões precisam deixar Alamut para assuntos especialmente importantes, levam odres cheios de sangue do Grande Poço para consumo pessoal. Em viagem, Guardiões podem precisar de suas artes; qualquer dos rituais listados abaixo, salvo o quinto, pode ser usado igualmente bem com o Guardião despejando o sangue num recipiente de boca aberta.

• Sentir as Ondulações
Assamitas que aprendem esta trilha aprendem primeiro a escutar e ler as maiores ondulações do Grande Poço, que indicam eventos dramáticos: a morte ou torpor de um Ancião ou do Ancião-Mor, uma traição planejada, ou coisa pior. Embora eventos dramáticos possam ser vistos conforme ocorrem, é só com conhecimento superior que um praticante consegue saber em detalhe o que aconteceu. A cada sucesso, ela pode fazer uma pergunta esclarecedora relacionada ao assunto que possa ser respondida com sim ou não. Perguntas paradoxais não podem ser respondidas.

•• A Dádiva de Haqim
Com estudo maior, o praticante consegue esticar o sangue tirado do Grande Poço. Ele precisa beber ao menos um ponto de sangue do poço. Seu corpo é preenchido pelo poço, independentemente de quão longe esteja do poço de fato. Ele ganha pontos de sangue iguais ao número de sucessos, que chegam a uma taxa de um por hora até serem plenamente concedidos.

••• O Carmesim Distante
Com este feitiço, a praticante pode observar os arredores físicos de quaisquer Assamitas num raio de cem quilômetros. Ela pode ver pelos olhos dos Assamitas presentes no local, e consegue dizer seus estados emocionais gerais, se têm sangue suficiente para atravessar a semana e se estiveram em combate na última noite. Com sucessos adicionais, ela pode filtrar suas percepções com base num traço adicional formalmente reconhecido, como casta ou idade.

•••• Conhecer o Destino de Um
Ao examinar com mais clareza as agitações mínimas do poço, a praticante consegue sentir uma mudança dramática no destino de um vampiro. Ela pode fazer perguntas que possam ser respondidas com sim ou não, em número igual aos sucessos de sua rolagem. Este feitiço é frequentemente realizado para discernir a verdadeira depravação de vampiros especialmente poderosos. Quando os guerreiros acreditam que precisam infligir a Morte Final a um Príncipe, eles primeiro perguntam aos Guardiões.

••••• Lançar-se ao Poço de Sangue
Este feitiço precisa sempre ser conjurado por quatro feiticeiros. Ao se esvaziarem de pontos de sangue com as mãos no poço, os praticantes conseguem sentir o sangue de todos os membros do clã fluindo por eles, e podem impactar o destino imediato do Clã Assamita. A Geração de todos os participantes aumenta em um, pois eles sacrificam a potência de seu sangue para influenciar o destino do clã. Embora não possam controlar o tempo nem impactar as coisas diretamente, pelo poder deste ritual podem impactar dramaticamente o resultado de uma série de eventos. Na prática, eles escolhem um objetivo a alcançar, que precisa ser acordado por todos os membros conjuradores. Para cada sucesso, escolha um dos seguintes:
• Indivíduos ganham –1 de dificuldade em ações pertinentes (até a dificuldade mínima 3).
• Indivíduos ganham +1 dado em ações pertinentes (até o máximo de +5 dados).
• Os que obstruem o objetivo ganham +1 de dificuldade (até a dificuldade máxima 9).
• Os que obstruem o objetivo perdem 1 dado (até a parada mínima de 1 dado).
Por exemplo: se o objetivo é impedir que um exército invada Alamut, todos os guerreiros receberiam bônus em suas rolagens feitas para defender a cidade, e todos os feiticeiros ganhariam bônus em rituais em defesa do coletivo, enquanto os inimigos sofreriam penalidades para atacar os Assamitas ali dentro.]==],
				},
				["The Kraina of Enoch"] = {
					pt = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, pág. 169


The Kraina of Enoch


Tzimisce do Clã Antigo Abraçados dentro do Submundo, que reivindicaram Enoque como seu território, foram os pioneiros desta kraina. A Kraina de Enoque é tão única em metodologia quanto a terra que a pariu. Koldun e sua terra são um só; toda kraina desperta a natureza daquela terra. Enquanto a maioria das kraina exige que o koldun conceda uma oferenda de sangue à terra, a Kraina de Enoque reflete o próprio coração do Submundo. O koldun que busca despertá-la precisa primeiro se tornar um com as terras dos mortos sacrificando uma porção de seu corpo.
No Submundo, koldun com esta kraina sempre têm um senso intuitivo da localização exata de Enoque dentro da Tempestade.
A Kraina de Enoque é acessível a qualquer koldun do Clã Antigo iniciado na Tal'Mahe'Ra.

• Sudário do Esquecimento
A existência no Submundo concede aos Cainitas certas vantagens indisponíveis na Terra; o koldun arranca um pedaço do tecido do Submundo para saturar a área ao seu redor com os atributos dele.
Sistema: O koldun gasta um ponto de Força de Vontade e então faz a rolagem de ativação (Atributo: Vigor). Com um sucesso, a pele do koldun vira cinza e se esfarela até sumir, expondo sua carne aos elementos. Ele mergulha as mãos na terra, afastando qualquer impedimento como se fosse solo recém-arado, e arranca dali uma lâmina insubstancial de noite tinta, puxando um pedaço do Submundo com o qual se envolver. Uma vez vestido, a aparência de tudo o que o sudário cobre fica visivelmente esmaecida; no mundo físico, tudo sob seu escudo se assemelha a imagens de televisão em preto e branco num mundo colorido, enquanto no Submundo as coisas assumem um tom mais medonho de escuridão e decomposição mais profundas.
O Sudário do Esquecimento se centra no koldun e o acompanha. O poder tem raio de dois metros por sucesso obtido na rolagem de ativação, e duração (em turnos) igual aos sucessos. Todos dentro do raio se beneficiam dos efeitos do sudário. Os efeitos deste poder diferem conforme a terra em que o koldun se encontra no momento (ver o quadro "Vampiros no Submundo" na p. 119): enquanto no mundo mortal, o dano da luz do sol se reduz a contundente. Se em qualquer parte do Submundo, o sol tênue não causa dano algum.
Quando a duração do poder expira, o koldun sangra, perdendo um ponto de sangue a cada turno até gastar um ponto de sangue para rejuvenescer sua pele (a menos que esteja no Submundo, caso em que nenhum sangue é perdido). Penalidades sofridas para ativar este poder são contabilizadas depois que a duração termina. Curar-se antes desse momento suspende os efeitos do poder.

•• Manto Espectral
Ao dominar a visão dos mortos, a koldun aflige os que estão nas proximidades com um vislumbre do mundo além do dos vivos. O Manto Espectral esconde a koldun de olhos hostis e afasta observadores indesejados em terror.
Sistema: A koldun arranca os próprios olhos, esmaga-os nas mãos e estende as palmas ao céu, então faz a rolagem de ativação (Atributo: Percepção). Com um sucesso, a polpa vira pó e alça voo num uivo sinistro de vento que jorra de uma escuridão insondável dentro de suas órbitas vazias. Sombras extraídas dos arredores envolvem a koldun, que desaparece, tornando-se invisível à visão comum (para os que têm Auspícios, ver o quadro "Seeing the Unseen" na p. 142 de V20, usando o nível da koldun nesta kraina). Embora a koldun enxergue normalmente dentro do raio de efeito do poder, ela fica cega para tudo fora dessa área. Os demais dentro do raio precisam ter sucesso numa rolagem de Força de Vontade (dificuldade igual ao nível da koldun na kraina mais os sucessos obtidos na rolagem de ativação, máximo 9), ou são afligidos pelo Defeito Visão da Morte (V20, p. 494) e tentam fugir apavorados por um número de turnos igual aos sucessos obtidos na rolagem de ativação.
O raio do poder se centra na koldun e a acompanha, permitindo que ela se mova e aja sobre os outros, mesmo violentamente, sem ser revelada. O Manto Espectral tem raio de três metros por sucesso obtido na rolagem de ativação e duração (em turnos) igual aos sucessos. Quando a duração do poder expira, a koldun fica abandonada à cegueira até gastar um ponto de sangue para se curar (a menos que esteja no Submundo, onde a koldun pode continuar a enxergar indefinidamente, apesar da perda dos olhos). Penalidades sofridas para ativar este poder são contabilizadas depois que a duração termina. Curar-se antes desse momento suspende os efeitos do poder.

••• Lago do Pavor Malévolo
Aninhado logo acima do abismo no Submundo, nenhum lugar é mais gélido, desprovido de luz, tenebroso ou desolado que o Mar das Sombras, um oceano de almas à beira da aniquilação total. O koldun forma um poço para sorver da desgraça deste mar e liberar seu fluxo.
Sistema: O koldun passa um turno se estripando, enfiando as mãos fundo no abdome para expelir as entranhas no chão, então faz a rolagem de ativação (Atributo: Vigor). Com um sucesso, suas vísceras perfuram a terra atravessando qualquer obstrução em seu caminho, e então cruzam o limiar que separa as terras vibrantes dos vivos das terras ressecadas dos mortos. Suas entranhas tocam as próprias profundezas da camada mais funda do Submundo, criando raízes no Mar das Sombras. O vampiro drena a essência dele para dentro de si e a descarrega para fora em ondas pulsantes de desespero que borbulham pela terra e o cercam num lago líquido de espectros fervilhantes e contorcidos. Braços fantasmagóricos se estendem para agarrar e devorar os que caminham pelo raio do círculo. O lago ondulante se centra sob o koldun, que permanece travado no lugar da cintura para baixo até o poder terminar.
O poder tem raio de cinco metros por sucesso obtido na rolagem de ativação e duração (em turnos) igual aos sucessos. Todos dentro do raio têm sua velocidade reduzida a ¼ e precisam ter sucesso numa rolagem de Força de Vontade a cada turno (dificuldade igual ao nível do koldun na kraina mais os sucessos obtidos na rolagem de ativação, máximo 9) ou perdem 1 ponto de Força de Vontade permanente.
Quando a duração do poder expira, o koldun secciona as vísceras enterradas na terra e sofre dois níveis de dano letal inabsorvível. Este dano não pode ser curado por nenhum outro meio que não gastar sangue. Além disso, o koldun perde uma quantidade de pontos de sangue igual à metade dos sucessos obtidos na rolagem de ativação, arredondada para cima (a menos que esteja no Submundo, caso em que nenhum sangue é perdido). Ferimentos sofridos para ativar este poder são contabilizados depois que a duração termina. Curar-se antes desse momento suspende os efeitos do poder.

•••• Ira da Tempestade
Permeando a maior parte do Submundo está a Tempestade: um tufão revolto e ilimitado feito de memórias fraturadas, sonhos partidos, pesadelos, medo e miséria. A koldun invoca os estertores de morte de todos os que venceu, furando um buraco na barreira entre os mundos para deixar sangrar a tormenta metafísica.
Sistema: A koldun gasta um ponto de Força de Vontade e ergue a cabeça ao céu, então faz a rolagem de ativação (Atributo: Força). Com um sucesso, ela abre a boca e um coro de vozes que não são suas emite um grito ensurdecedor que se funde em trovão, enquanto nuvens de tempestade se juntam acima dela pelo resto do turno. Segue-se um silêncio imóvel enquanto a koldun permanece congelada, a expressão transfixada, ecoando o chamado. Momentos depois, um furacão rugidor explode ao seu redor, irrompendo da terra dos mortos com toda a fúria do Submundo. Seu olho, um funil focado, desce pela boca da koldun, fazendo-a convulsionar e se contorcer enquanto se ergue nove metros no ar.
A tempestade tem raio de sete metros por sucesso obtido na rolagem de ativação e duração (em turnos) igual aos sucessos. Todos dentro do raio precisam ter sucesso numa rolagem de Força de Vontade (dificuldade 8) a cada turno ou ganham uma perturbação e entram num estranho estado de fuga (descrito na p. 291 de V20) chamado "Harrowing", enquanto a tempestade deforma memórias, aprisionando os que estão dentro num labirinto interno de arrependimento, depressão e desesperança pelo resto da cena. Enquanto a tempestade ruge, a koldun fica sem mente e completamente alheia aos arredores; ela sofre um nível de dano contundente inabsorvível a cada turno enquanto a tempestade a golpeia por dentro (a menos que esteja no Submundo, caso em que o dano contundente pode ser absorvido normalmente). Penalidades sofridas para ativar este poder são contabilizadas depois que a duração termina. Curar-se antes desse momento suspende os efeitos do poder.

••••• Fome do Vazio
O koldun encarna as distorções da Tempestade, torturando sua própria alma para abrir um poço de destruição perfeita na realidade.
Sistema: O koldun gasta um ponto de Força de Vontade, enfia a mão pela própria garganta e arranca sua própria alma. Ele passa um turno atormentando e esticando a boca do espírito cada vez mais, enquanto ela protesta mudamente, arranhando impotente seu violador em descrença chocada. Ele lança a alma contorcida à terra a seus pés, então faz a rolagem de ativação (Atributo: Força) antes de mergulhar nela. Com um sucesso, as fauces gigantes se transformam numa cavidade de um metro e meio de circunferência que começa a sugar tudo o que pode para saciar seu apetite insaciável.
O poder tem raio de oito metros por sucesso obtido na rolagem de ativação e duração (em turnos) igual aos sucessos. Todos dentro do raio são arrastados três metros por turno em direção ao Nihil, e têm sua velocidade reduzida à metade a cada dois metros mais próximos que estejam dele. Se consumidos pelas fauces, eles desaparecem e precisam fazer uma rolagem de Força de Vontade (dificuldade 9). Depois que o poder termina, o Nihil implode, deixando uma cratera enorme em seu rastro. Na base da cratera jaz o koldun, com tudo o que as fauces consumiram repousando sobre ele. Personagens que falharam na rolagem são transformados em criaturas sem mente, com suas virtudes e moralidade completamente arrancadas e reduzidas a zero. Vampiros que tiverem sucesso na rolagem entram num Harrowing (ver Ira da Tempestade) pelo resto da cena e ganham uma perturbação. Independentemente de sucesso ou falha, qualquer mortal consumido pelo poço tem a alma obliterada e entra em coma permanente.
A estase não-morta de um vampiro não consegue encarnar esta energia de outro mundo. Ao término do poder, fissuras de nada não filtrado despedaçam a alma do koldun por dentro, enquanto queimaduras abrasadoras irrompem e rasgam a carne por toda a sua estrutura (infligindo dois níveis de dano agravado).]==],
				},
				["The Kraina of the Well"] = {
					pt = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, pág. 172


The Kraina of the Well


A lenda sustenta que esta kraina é a primeiríssima kraina, desenvolvida pelo Ancião-Mor ao descobrir o Poço do Sacrifício original. Diferentemente de outras de sua espécie, a Kraina do Poço não é guardada com exclusividade apenas pelo Clã Antigo. O Clã Antigo também instrui aqueles Baali na Via Hyron dedicados à missão da Ordem de Moloch de conquistar ou matar o demoníaco, com tolerância zero para todos os que caíram em suas fauces infernais. Estudantes Baali não cultivam uma kraina primária e não podem aprender outras kraina além da do Poço.
Para efetivar o poder desta kraina, a koldun é obrigada a estabelecer um vínculo simpático ao Poço do Sacrifício original construindo uma duplicata para seu próprio uso e ungindo-a com seu sangue. Poços do Sacrifício são muitas vezes construídos em áreas isoladas, escondidas de perturbações em potencial (ver Poços do Sacrifício na p. 102), e seu padrão espiralado lembra (e presta homenagem ao) símbolo do Clã Tzimisce. No ermo, as "raízes" de uma montanha, uma caverna ou a base de uma árvore são locais tradicionalmente preferidos. Uma koldun que habite a extensão de uma cidade moderna pode escolher um reservatório de água abandonado num telhado, os restos de um sistema de metrô desativado ou nunca concluído, ou um prédio abandonado ou poço de elevador aberto ao céu.
A construção de um Poço exige seis horas de trabalho ininterrupto toda noite por uma semana inteira, seguidas de encantamento e um sacrifício mortal a cada mês daí em diante para mantê-lo. Durante a construção, a koldun dá seis pontos de sangue por noite ao Poço e faz uma rolagem prolongada de Manipulação + Ocultismo (dificuldade 7). Se uma noite de trabalho for perdida ou se as sete rolagens não acumularem ao menos 25 sucessos líquidos, o Poço permanece dormente e a koldun precisa recomeçar do zero. Para manter um Poço, a koldun prepara seu sacrifício e novamente faz um presente de seis pontos de sangue, então rola Manipulação + Ocultismo (dificuldade 7, precisando de um mínimo de três sucessos). Um Poço simpático construído dessa maneira dura indefinidamente, a menos que sua estrutura seja arruinada. Caso o Poço de uma koldun seja destruído, ela perde acesso a todos os poderes desta kraina até que um novo Poço seja erguido.

• Chamar os Filhos
Para comandar algo, é preciso se aventurar a conhecê-lo. Demônios, muito como cães, sempre se esforçam por vir quando chamados por seus mestres. A técnica de conjurar os habitantes do Inferno sempre foi um pilar à mesa da prática infernal.
Sistema: Exigindo uma cena inteira de foco ininterrupto e o gasto de um ponto de sangue para efetivar, o koldun realiza uma longa série de encantações enquanto traça glifos ao redor de um círculo feito com seu próprio sangue em torno da entrada de seu Poço do Sacrifício. O poder e a força do demônio que o koldun é capaz de invocar sobem proporcionalmente a seu nível de avanço na kraina.
Conforme a perícia do koldun na kraina sobe, sobe também sua capacidade de invocar demônios de poder crescente. Ao longo da cena, ele faz uma rolagem prolongada de invocação (Atributo: Raciocínio), exigindo uma quantidade de sucessos igual ao nível de dificuldade do demônio invocado.
Kraina nível 1 — Dificuldade de 5 sucessos; Tentador Caído
Kraina nível 2 — Dificuldade de 6 sucessos; Tentador Caído: +30
Kraina nível 3 — Dificuldade de 7 sucessos; Tentador Caído: +55
Kraina nível 4 — Dificuldade de 8 sucessos; Profanador Terreno nas Trevas
Kraina nível 5 — Dificuldade de 9 sucessos; Profanador Terreno nas Trevas: +30
Demônios usam as estatísticas apresentadas nas pp. 386-387 de V20. Narradores devem trocar livremente Habilidades e Disciplinas específicas por outras e variar os valores de Atributo para atender às necessidades de seu jogo. Demônios invocados por Chamar os Filhos não estão de posse de um hospedeiro mortal, mantendo o semblante de sua Forma Apocalíptica descrita em Poderes e Fraquezas. Sem estar preso, um demônio não pode sair dos limites do círculo de invocação em que está e será arrancado de volta ao Inferno depois que expirar um número de turnos igual ao nível de dificuldade de sua conjuração. O demônio pode se comunicar, mas em geral exige uma troca de bens ou serviços (às vezes até um contrato) por qualquer informação que lhe seja pedida e, mesmo assim, não há garantia de que precise responder com verdade. O jogador pode escolher invocar o mesmo demônio de novo mais tarde se uma barganha foi firmada, mas não cumprida antes do fim da duração do poder. Dois ou mais koldun com este poder podem eleger um invocador principal e trabalhar em conjunto para invocar uma entidade. O nível de dificuldade é reduzido em um (mínimo 4) para cada koldun que auxilie na invocação.

•• Escutar o Coração Fadado ao Inferno
Seja por bênção, seja por familiaridade, uma koldun que bebe de seu Poço ganha um sentido sobrenatural que a alerta quando há influência demoníaca por perto, empunhando a capacidade de examinar lugares, objetos ou seres corrompidos pela marca da companhia infernal.
Sistema: Ao sorver um ponto de sangue diretamente de seu Poço, a koldun soma seus níveis alcançados na Kraina do Poço à sua Habilidade Prontidão para detectar influência demoníaca em áreas maculadas por sua presença ou almas manchadas por seu toque. Este efeito dura enquanto o ponto de sangue permanecer em seu organismo. O sangue é sempre consumido na ordem em que foi ingerido.

••• Égide Alighieri
Nomeada nas noites modernas em homenagem ao famoso poeta veneziano, a Égide Alighieri protege a koldun de investidas violadoras, predações e profanações por forças demoníacas.
Sistema: A koldun lacera uma veia, gastando um turno e um ponto de sangue para cobrir um amuleto com seu sangue, então faz a rolagem de ativação (Atributo: Carisma). Pelo resto da cena, a koldun soma os sucessos obtidos na rolagem de ativação à dificuldade de ataques e influências sobrenaturais de origem infernal usados contra ela (como objetos abençoados infernalmente, Investiduras e Dádivas, ou quaisquer Disciplinas e poderes de feitiçaria de sangue empunhados por infernalistas e demônios). Ela também ganha uma quantidade de dados extras nas rolagens para resistir a esses mesmos efeitos igual à quantidade de sucessos obtidos. Qualquer objeto mundano ou místico pode ser consagrado como amuleto; escolhas populares incluem adagas cerimoniais, crucifixos aviltados ou cabeças decepadas que se animam para gritar infindavelmente em silêncio. Contudo, apenas a koldun se beneficia da proteção concedida pela Égide Alighieri, e ela precisa estar com o amuleto consigo para este poder funcionar. Antes de ativar este poder, exige-se que a koldun tenha mergulhado o amuleto em seu Poço, deixando-o de molho ali por uma noite inteira. Dois ou mais koldun trabalhando juntos em estreita proximidade (a até 15 metros) concedem uns aos outros um sucesso extra em rolagens de resistência e aumentam em um (máximo 9) a dificuldade para atacá-los, para todos os koldun presentes com este poder ativado.

•••• Expulsar a Hoste do Inferno
Depois de aprender a chamar, a sentir e então a se defender da mácula infernal, o koldun pode agora apagar suas cicatrizes por completo.
Sistema: O koldun cria um elo com seu Poço moldando ou cavando uma depressão em forma de tigela (mínimo de 30 cm de diâmetro) na terra e batizando-a com um ponto de sangue. Ele entoa uma litania de admoestações e maldições enquanto asperge o sangue sobre a área ou batiza o sujeito que pretende exorcizar, então faz a rolagem de ativação (Atributo: Manipulação).
Para limpar uma área, ser ou coisa de marca infernal, ou expulsar uma entidade demoníaca, exige-se uma quantidade de sucessos relativa ao grau de corrupção infundida (1 a 2 para máculas menores, 3 para infecções sutis de maldade perceptível, 4 ou mais para objetos e espaços que irradiem uma malevolência palpavelmente potente). Infernalistas imbuídos do diabólico e espíritos demoníacos que aviltam uma área com sua presença (ou que estejam diretamente de posse de seres, lugares ou coisas) podem resistir gastando um ponto de Força de Vontade e então rolando Força de Vontade (dificuldade igual à Força de Vontade permanente do koldun). Demônios que falharem na rolagem são dispensados e banidos de volta ao Inferno. Infernalistas purificados não recuperam suas almas condenadas, mas qualquer marca infernal que outrora permeasse seu ser é permanentemente expelida.
Um ou mais koldun com Expulsar a Hoste do Inferno podem auxiliar um exorcista principal a anular uma praga infernal. O nível de dificuldade para limpar ou expulsar é reduzido em um (mínimo 4) para cada koldun que auxilie no exorcismo.

••••• Ceifar o Poço
Koldun que alcançam o domínio pleno da Kraina do Poço recebem de seus pares o epíteto de "Ceifador do Inferno", e por boa razão.
Sistema: Ao invocar um demônio ou descobrir um fugitivo solto e livre fora da prisão do Inferno, a koldun pode tentar prender e escravizar a criatura à sua vontade. A koldun corta os pulsos, levando um turno para juntar um ponto de sangue nas mãos em concha a fim de fabricar uma conexão com seu Poço. Quando pronta, ela gasta um ponto de Força de Vontade e faz a rolagem de ativação (Atributo: Força). O sangue salta de suas mãos na forma de seis correntes de ganchos entrelaçadas, ancoradas sob seus pulsos cortados, que se lançam ao alvo com precisão infalível (máximo de 30 metros). Se a rolagem for um sucesso, os ganchos de sangue se fincam dolorosamente na entidade, criando ferimentos sangrentos (sem dano), independentemente de a criatura possuir ou não forma física. Uma criatura enlaçada pode se debater para romper uma corrente por turno gastando um ponto de Força de Vontade e então rolando Força de Vontade (dificuldade igual à Força de Vontade permanente da koldun).
Enquanto os ganchos penetrarem o corpo da entidade, uma vez por turno a koldun pode exigir seu Nome Verdadeiro, atormentando o demônio ao rolar Inteligência + Intimidação contra os pontos atuais de Força de Vontade do alvo para dilacerar sua alma com dor excruciante. Com um sucesso, a vítima brada a resposta em súplica. A koldun tem duas escolhas: pode desacorrentar e dispensar o demônio por Expulsar a Hoste do Inferno, ou absorvê-lo para dentro de si.
Uma koldun que tenha obtido o Nome Verdadeiro de um demônio reduz o nível de dificuldade em dois ao evocá-lo mais tarde por Chamar os Filhos. Demônios presos por seu Nome Verdadeiro podem sair dos limites do círculo em que foram invocados, e podem ser comandados por uma koldun a cumprir um número de tarefas por um número de dias igual aos sucessos obtidos na rolagem de invocação. O demônio responderá a qualquer pergunta da koldun, e a koldun não precisa oferecer troca de serviços por perguntas ou tarefas.
Se escolher absorver um demônio acorrentado, a koldun pode gastar um ponto de sangue para chamá-lo de volta instantaneamente. Demônios acorrentados são inteiramente obedientes e servem à vontade da koldun na capacidade que ela exigir, mas precisam permanecer atados (máximo de 30 metros) à koldun. Uma koldun pode controlar até seis servos demoníacos acorrentados; cada corrente dividida diminui a quantidade de correntes disponíveis para futuros aprisionamentos e aumenta em um a dificuldade para atormentar demônios não domados.
Um demônio que desobedeça ou minta para uma invocadora que conheça seu Nome Verdadeiro ao conjurá-lo sofre agonia paralisante. Caso Ceifar o Poço seja usado para realizar um exorcismo violento num hospedeiro vivo possuído por um demônio, o hospedeiro rola Vigor contra dificuldade igual à quantidade de turnos levados para domar o demônio a revelar seu Nome Verdadeiro. A falha resulta na morte do hospedeiro por choque. Múltiplos koldun podem Ceifar o Poço juntos, diminuindo coletivamente em um por corrente a dificuldade para atormentar um demônio (mínimo 4). A Ceifadora do Inferno que extrair com sucesso o Nome Verdadeiro do demônio em seu turno pode escolher prendê-lo ou dispensá-lo. Todos os koldun presentes ouvem o demônio uivar seu Nome Verdadeiro e, se dispensado, podem conjurá-lo individualmente. Um demônio a serviço de uma Ceifadora do Inferno não pode ser evocado até ser liberado do serviço.]==],
				},
				["The Laws of Suleiman"] = {
					pt = [==[Rites of Blood, pág. 160


The Laws of Suleiman


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
The Laws of Suleiman é uma dessas trilhas: é funcionalmente idêntica a à Trilha da Manipulação de Espíritos (Rites of Blood, pp. 142-145).]==],
				},
				["The Nightshade Path"] = {
					pt = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, pág. 70


The Nightshade Path


Desenvolvida pelas Drakaina, esta Trilha de Necromancia estuda os ciclos naturais, incluindo o interjogo selvagem entre vida e morte. Toda vida é uma manifestação da entropia, um milagre caótico pontuando o fluxo da Criação rumo à destruição. Quando a putrefação reclama um corpo, ela impregna a carne com insetos e plantas viçosas, e seu fedor chama os necrófagos que se sustentam com a fartura da morte. Vampiros demonstram como esse processo pode ser detido e manipulado, pois os Membros ficam suspensos no momento da morte, antes que a natureza os abençoe com o poder de se decompor e alimentar coisas vivas. A semente negra jaz dormente dentro deles, mas eles podem encorajar seu crescimento em outros, manipulando a putrefação e manchando a vida com a essência espectral.
Embora as Drakaina tenham desenvolvido a Trilha, elas não a guardam para si — é a dádiva da Mãe Sombria, para partilhar com todos que a adoram. Qualquer necromante Bahari pode aprendê-la com uma professora Drakaina. Lilin Nagaraja praticam esta Trilha em números crescentes porque ela unifica os princípios de vida e morte de modos antecipados (mas nunca realizados) por seus antepassados Idran.

• Cuidar do Jardim de Corpos
A perícia forense moderna torna possível determinar a hora da morte com precisão notável — perspectiva assustadora para Membros com corpos a esconder. Por outro lado, às vezes é melhor que as pessoas achem os cadáveres antes que a putrefação os tome. Apresentar prova de que Membros anciões sofreram a Morte Final às vezes é difícil, pois seus corpos rapidamente se desfazem em cinzas indistintas. Uma necromante com este poder supera essas dificuldades. Ela pode acelerar ou retardar o processo de decomposição, transformando um mortal morto num hospedeiro inchado de moscas em segundos, ou anulando a decomposição da Morte Final.
Sistema: A jogadora gasta um ponto de sangue enquanto a vampira deixa parte de seu sangue pingar sobre um cadáver, e rola Raciocínio + Ocultismo (dificuldade 6). Os sucessos permitem à vampira acelerar ou deter a decomposição da seguinte forma:
1 sucesso — Retardar ou acelerar a putrefação em até um dia
2 sucessos — Até uma semana
3 sucessos — Até um mês
4 sucessos — Até um ano
5 ou mais sucessos — A critério do Narrador
A vampira pode usar este poder em mortais e animais desde que os restos não tenham sido substancialmente espalhados. Pode ser usado em Membros por no máximo um turno depois de terem encontrado a Morte Final. Cadáveres que recentemente pertenceram aos vivos mudam conforme as condições locais, de modo que um guardado em lugar seco pode mumificar, enquanto outro que repousa sobre solo rapidamente brota plantas e larvas. Coisas vivas que se alimentam dos mortos são aceleradas ou mantidas em estase junto com o cadáver, desde que sejam plantas, fungos ou não maiores que um escaravelho. Membros sob a Morte Final mirram e se desfazem em pó sem atrair tais organismos.

•• Fruto da Bruxa
Toda planta depende da morte para crescer. Coisas em putrefação enriquecem o solo, e as árvores, trepadeiras e gramíneas sorvem ecos necróticos junto com nutrientes vitais. Uma necromante pode despertar essa aura de morte expondo os frutos delas a seu sangue. Ela desperta e concentra suas energias necróticas residuais de modo que qualquer um que os consuma possa sentir e tocar as Terras das Sombras.
Sistema: A jogadora gasta um ponto de sangue enquanto a vampira toca matéria vegetal comestível. Nenhuma rolagem é exigida. A primeira criatura viva a comer essa refeição contaminada cai num transe desperto e ambulante por uma cena, durante a qual pode enxergar as Terras das Sombras, ouvir seus habitantes e até tocar e ser tocada por fantasmas. O alvo não pode fazer contato físico com prédios e outros objetos que nunca estiveram vivos, e não pode ser arrastado para a Tempestade ou qualquer outro lugar que não tenha localização correspondente no mundo dos vivos. A matéria vegetal contaminada apodrece até o próximo nascer do sol e perde a capacidade de conferir esse estado.
Frutos de bruxa são alucinógenos leves. Visões distorcidas de fantasmas e prédios há muito derrubados desorientam mortais sob sua influência. Isso normalmente impõe +2 às dificuldades para realizar quaisquer ações, exceto rolagens de Força de Vontade, enquanto durar o efeito. Criaturas familiarizadas com fenômenos sobrenaturais não sofrem essa penalidade.

••• Erguer o Verdejante
Histórias de Kid, Osíris e do Homem Verde descrevem todas seres que foram trazidos de volta da morte e vestidos de cor verdejante. Ísis ergueu Osíris para que se tornasse símbolo de renascimento e crescimento, e neopagãos dizem que a iconografia do Homem Verde recorda o deus que é morto pelo Inverno e renascido no ventre da Deusa. Necromantes da Erva-Moura canalizam essas lendas no ato de erguer um cadáver amarrado e fortalecido por matéria vegetal. Folhas cobrem sua pele e trepadeiras fortes complementam seus tendões apodrecidos. A casca viva concede velocidade e instintos de autopreservação não vistos em outros mortos animados.
Sistema: O jogador rola Raciocínio + Ocultismo (dificuldade 8). Ele gasta um ponto de Força de Vontade e um ponto de sangue enquanto se concentra num cadáver que jaz sobre ou dentro de solo fértil. Se a rolagem tiver sucesso, trepadeiras, galhos e folhas de tom avermelhado envolvem o cadáver, e ele se ergue para cumprir as ordens do necromante. O necromante só pode erguer os Verdejantes um de cada vez, e nunca pode ter múltiplos Verdejantes ativos ao mesmo tempo.
Verdejantes são mais fortes, mais rápidos e possuem instintos melhores que a maioria dos zumbis. Seus traços são Força 4, Destreza 4, Vigor 4, Esportes 2, Briga 3 e o equivalente a 2 pontos de Fortitude, pois seus corpos úmidos resistem a ferimentos. O dano contundente causa metade do dano a um Verdejante. Como vampiros, eles sofrem dano contundente de armas de fogo. Diferentemente dos zumbis comuns, agem na ordem normal de iniciativa.

•••• Lamentos e Sussurros
Conforme a compreensão da necromante se aprofunda, ela explora a barreira oscilante entre vida e morte. Quando grita como uma banshee, consegue atrair uma alma para sua ruína, aumentando a chance de um ferimento fatal. Quando sussurra como uma mãe para seu filho, consegue fixar uma alma nas terras dos vivos, mesmo quando ela ocupa um corpo que deveria estar morto.
Sistema: A vampira se concentra num alvo, gritando ou sussurrando conforme suas intenções ditarem. (O alvo não precisa conseguir ouvir a vampira.) A jogadora gasta um ponto de Força de Vontade e rola Raciocínio + Ocultismo (dificuldade 8). Se ela desejar atrair seu alvo para mais perto da morte, cada sucesso soma um nível de dano letal ao total infligido pelo próximo ferimento que ele sofrer naquela cena. Se ela desejar impedir que o alvo morra, cada sucesso reserva um nível de dano (de qualquer tipo) do próximo ferimento que o alvo sofrer durante a cena, mas este benefício só dura até o fim da cena, após o que o dano reservado retorna. O alvo sofre o ferimento, mas não sente seus efeitos, até e inclusive a morte, até a cena terminar e o dano retornar. Note que o Narrador pode determinar que quantidades muito grandes de dano possam causar a morte por destruição total ou quase total do corpo, independentemente dos efeitos deste poder.

••••• Ventre Ctônico
No ápice desta Trilha, a necromante combina assassinato e fertilidade para dar à luz o fantasma de um mortal que ela matou. Ela bebe o sangue da vítima para agarrar sua alma e, depois de despachá-lo, aprisiona-a dentro de si. Mais tarde, ela pode invocá-la como fantasma para cumprir suas ordens.
Sistema: A vampira precisa beber ao menos um ponto do sangue de uma vítima mortal, mas pode matá-lo por outro método. Outra pessoa ou incidente pode causar a morte do mortal, mas a necromante precisa fazer contato físico com ele no momento da morte. Nesse ponto, a jogadora gasta um ponto de Força de Vontade e rola Raciocínio + Ocultismo (dificuldade 8). Se a jogadora tiver sucesso, a alma ocupa o corpo da vampira em estado dormente por até um mês por sucesso. (Percepção de Aura ou poderes semelhantes revelam a presença da alma dormente, que pode ser confundida com uma forma de possessão.) A necromante pode armazenar múltiplas almas dessa forma, mas "gêmeos", "trigêmeos" e mais oneram a energia da "mãe". Cada alma armazenada além da primeira drena um ponto de sangue adicional quando a vampira desperta a cada noite.
A qualquer momento antes de a alma deixar seu corpo, a vampira pode invocá-la para se manifestar com os traços de um fantasma recém-falecido (ver V20, p. 385) ou com os que possuía em vida, junto com as capacidades sobrenaturais de um fantasma recém-falecido. Ela precisa prestar três serviços à sua "mãe". Depois disso, a alma está livre para seguir rumo a seu destino final. Se o fantasma for ordenado a realizar qualquer tarefa que traumatizaria um mortal (tipicamente, aquelas que arriscariam um teste de Humanidade num vampiro com esse traço em 7), ele pode, a critério do Narrador, tratar a necromante como um "grilhão", um objeto no qual o fantasma se fixa e que usa como laço com o mundo dos vivos. Isso dá ao fantasma a capacidade de assombrar a necromante até ser banido. A necromante pode sempre simplesmente dispensar a alma quando ela aparecer, ou até ordenar que ela deixe seu corpo enquanto a alma ainda dorme.]==],
				},
				["The Path of Blood"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 213


The Path of Blood


Quase todo Tremere estuda a Trilha do Sangue como sua trilha primária. Ela abrange alguns dos princípios mais fundamentais da Taumaturgia, baseada como é na manipulação da vitae dos Membros. Se uma jogadora quiser escolher outra trilha como a trilha primária de sua personagem, o Narrador pode exigir justificativa adicional (embora escolher uma trilha diferente não seja de forma alguma inédito).

• Gosto pelo Sangue
Este poder foi desenvolvido como meio de testar o poderio de um inimigo — capacidade extremamente importante nas primeiras noites tumultuadas do Clã Tremere. Ao meramente tocar o sangue de seu sujeito, o conjurador pode determinar quanta vitae resta no sujeito e, se o sujeito for vampiro, há quanto tempo ele se alimentou, sua Geração aproximada e, com três ou mais sucessos, se ele já cometeu diablerie.
Sistema: O número de sucessos obtidos na rolagem determina quanta informação o taumaturgo colhe e quão precisa ela é.

•• Fúria de Sangue
Este poder permite ao vampiro forçar outro Membro a gastar sangue contra a vontade. A conjuradora precisa tocar seu sujeito para este poder funcionar, embora apenas o contato mais leve seja necessário. Um vampiro afetado por este poder pode sentir uma onda física enquanto o taumaturgo eleva seus Atributos Físicos, pode se ver subitamente com aparência mais humana, ou pode até se ver à beira do frenesi enquanto suas reservas de vitae são misticamente esgotadas.
Sistema: Cada sucesso força o sujeito a gastar um ponto de sangue imediatamente do modo que a conjuradora desejar (o que precisa se dirigir a algum gasto lógico que o vampiro alvo poderia fazer, como aumentar Atributos Físicos ou alimentar Disciplinas). Note que pontos de sangue gastos à força dessa maneira podem exceder o máximo normal "por turno" indicado pela Geração da vítima. Cada sucesso obtido também aumenta em um a dificuldade do sujeito para resistir ao frenesi. A taumaturga não pode usar Fúria de Sangue em si mesma para burlar os limites geracionais.

••• Sangue de Potência
O taumaturgo ganha tal controle sobre o próprio sangue que pode efetivamente "concentrá-lo", tornando-o mais poderoso por um curto período. Na prática, ele pode temporariamente reduzir sua própria Geração com este poder. Este poder só pode ser usado uma vez por noite.
Sistema: Um sucesso na rolagem de Força de Vontade permite ao personagem reduzir sua Geração em um passo por uma hora. Cada sucesso adicional concede ao Membro ou um passo a menos na Geração ou uma hora de efeito. Os sucessos obtidos precisam ser gastos tanto para diminuir a Geração do vampiro quanto para manter a mudança (este poder não pode ser ativado de novo até que a aplicação original se esgote). Se o vampiro for diablerizado enquanto este poder estiver em efeito, ele se esgota imediatamente e o diablerista ganha poder apropriado à Geração real do conjurador. Além disso, quaisquer mortais Abraçados pelo taumaturgo nascem na Geração apropriada à Geração original de seu senhor (por exemplo, um Tremere de Décima Geração que reduziu sua Geração efetiva para Oitava ainda produz cria de Décima Primeira Geração).
Uma vez esgotado o efeito, qualquer sangue acima do máximo da reserva do personagem se dilui, deixando o personagem em sua reserva máxima normal. Assim, se um Tremere de Décima Segunda Geração (reserva máxima de 11) reduziu sua Geração para Nona (reserva máxima 14), ingeriu 14 pontos de sangue e tinha toda essa vitae no organismo quando o poder se esgotou, sua reserva de sangue cairia imediatamente para 11.

•••• Roubo de Vitae
A taumaturga que usa este poder suga vitae de seu sujeito. Ela nunca precisa entrar em contato com o sujeito — o sangue literalmente jorra numa torrente física do sujeito para a Membro (embora muitas vezes seja misticamente absorvido e não precise entrar pela boca).
Sistema: O número de sucessos determina quantos pontos de sangue a conjuradora transfere do sujeito. O sujeito precisa estar visível para a taumaturga e a até 15 metros. Usar este poder impede que a conjuradora fique presa por laço de sangue, mas de resto conta como se a vampira tivesse ingerido o sangue ela mesma. Este poder é espetacularmente óbvio, e os príncipes da Camarilla, com razão, consideram seu uso público uma quebra da Máscara.

••••• Caldeirão de Sangue
A taumaturga que usa este poder ferve o sangue de seu sujeito nas veias dele como água num fogão. A Membro precisa tocar seu sujeito, e é esse contato que faz o sangue do sujeito ferver. Este poder é sempre fatal para mortais e causa grande dano até aos vampiros mais poderosos.
Sistema: O número de sucessos obtidos determina quantos pontos de sangue entram em ebulição. O sujeito sofre um nível de vitalidade de dano agravado para cada ponto fervido (indivíduos com Fortitude podem absorver este dano usando apenas seus dados de Fortitude). Um único sucesso mata qualquer mortal, embora se diga que alguns carniçais com acesso a Fortitude sobreviveram após absorver todo o dano agravado.]==],
				},
				["The Path of Jinn’s Gift"] = {
					pt = [==[Rites of Blood, pág. 160


The Path of Jinn’s Gift


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
The Path of Jinn’s Gift é uma dessas trilhas: é funcionalmente idêntica a à Trilha da Conjuração (V20, pp. 220-221).]==],
				},
				["The Path of Life’s Waters"] = {
					pt = [==[Rites of Blood, pág. 160


The Path of Life’s Waters


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
The Path of Life’s Waters é uma dessas trilhas: é funcionalmente idêntica a à Trilha do Sangue (V20, pp. 213-214).]==],
				},
				["The Path of Phobos"] = {
					pt = [==[Rites of Blood, pág. 168


The Path of Phobos


Infernalistas conhecem o poder do medo e a alavanca do desespero. Praticantes desta trilha mergulham misticamente nas profundezas das psiques de suas vítimas, arrancando os terrores de suas mentes e fazendo-os parecer reais. Infernalistas Sabbat sofisticados preferem esta trilha, pois apreciam os efeitos sublimes de usar os próprios medos dos sujeitos contra eles, em vez de demonstrações vulgares e brutais de fogo e servos demoníacos.
Infernalistas que infligem pesadelos a outros arriscam consumir as memórias horríveis que vazaram de suas vítimas, apenas para revivê-las mais tarde. Narradores devem impor uma rolagem de Manipulação + Empatia (dificuldade 7) a qualquer personagem que utilize a Trilha de Fobos mais de uma vez numa mesma história. A cada noite em que revive os pesadelos de suas vítimas, ela acordará encharcada de sangue; custando efetivamente um ponto extra de sangue para despertar, devido à falta de sono profundo. Tal é o preço da percepção infernal. O número de sucessos indica por quanto tempo a personagem precisa lidar com o mar de terrores roubados que se alvoroçam em sua mente.
1 sucesso — Uma semana
2 sucessos — Cinco dias
3 sucessos — Quatro dias
4 sucessos — Dois dias
5 sucessos — Um dia

• Induzir Medo
A infernalista aproveita o poder do Inferno para torcer a mente de sua vítima, deixando-a paranoica. Formas e sombras sutis tremeluzem na borda da visão da vítima, atormentando-a ao espreitar logo além de seu campo de visão.
Sistema: A infernalista pode escolher como alvo qualquer sujeito em sua linha de visão. Ela precisa se concentrar, gesticular em direção à vítima e entoar a invocação apropriada ao Inferno. Se tiver sucesso, a vítima fica visivelmente perturbada e preocupada, o que deve ser interpretado. Para resistir, a vítima precisa fazer uma rolagem de Coragem (dificuldade 4 + o número de sucessos obtidos na rolagem de ativação, até o máximo de 9) para realizar qualquer ação que não seja procurar o perseguidor imaginado.
Todas as paradas de dados da vítima pela duração deste poder são automaticamente reduzidas em um. A duração deste poder é limitada pelo número de sucessos obtidos na rolagem de ativação:
1 sucesso — Um turno
2 sucessos — Cinco turnos
3 sucessos — Uma hora
4 sucessos — Uma noite
5 sucessos — Duas noites

•• Assombrar
Este poder transforma suspeita em pavor, enquanto as sombras fugidias se tornam ameaças assustadoras. A vítima sente que algo terrível está prestes a lhe acontecer a menos que fuja imediatamente da área. Ela pode imaginar que vê o brilho do cano de uma arma ou ouve o estalar de sapatos de sola dura na calçada logo atrás. Pode até acreditar que sente o cheiro do suor de seu perseguidor ou o hálito úmido dele na nuca.
Sistema: A infernalista precisa ver sua vítima e sussurrar uma prece ao Inferno para este poder funcionar. A sensação incômoda no fundo da mente do personagem se torna mais tangível. Mortais precisam de uma rolagem bem-sucedida de Coragem (dificuldade 7) para não fugirem da área em terror. Vampiros precisam fazer a mesma rolagem, mas se falharem entram em Rötschreck.

••• Aterrorizar
O infernalista pode extrair o medo de sua vítima e apresentá-lo a ela. A vítima vê aquilo que mais a aterroriza. Se ela teme aranhas, pode imaginar teias roçando seu rosto e suas mãos enquanto milhares de aracnídeos ilusórios correm por sua carne. Pode ouvi-los se arrastando pelo chão ou estalando suas horrendas quelíceras. Para a vítima, os efeitos parecem bem reais, embora sejam simplesmente ilusões e invisíveis para os espectadores.
Sistema: A infernalista precisa se concentrar por um momento e então gesticular em direção à vítima. Se tiver sucesso, o sujeito aterrorizado precisa ter sucesso numa rolagem de Coragem (dificuldade 7) para sacudir seu medo e conseguir agir. Do contrário, ela simplesmente se encolhe, escondendo-se debilmente de seu objeto imaginário de terror. Uma falha crítica nessa rolagem de Coragem resulta numa perturbação, de preferência adequada ao medo que visita a vítima.
A duração deste poder é limitada pelo número de sucessos obtidos na rolagem de ativação:
1 sucesso — Um turno
2 sucessos — Cinco turnos
3 sucessos — 30 minutos
4 sucessos — Uma hora
5 sucessos — Uma noite

•••• Praga do Medo
A infernalista pode agora provar o medo mais enraizado de sua vítima. Ela pode forçar seu sujeito a mergulhar fundo nessa fobia a cada momento de vigília. Uma pessoa com medo de se afogar sentiria o ar engrossar e coagular na garganta e nos pulmões até não conseguir respirar, enquanto uma pessoa com medo de vampiros pode ver nêmeses presados em seus colegas de trabalho ou espreitando atrás de cada esquina. Por fim, a vítima fica tão exausta que se torna incapaz de se levantar e enfrentar mais uma noite de horrores em enxame.
Sistema: A infernalista precisa ver e então amaldiçoar em voz alta sua vítima para este poder terrível fazer efeito. Uma vez amaldiçoada, este poder dura uma semana. A vítima é constantemente assediada por seu medo a cada instante. Pela duração deste poder, todas as rolagens de Força de Vontade são feitas como se o valor permanente do personagem fosse três pontos menor que o normal (até um mínimo de 1).

••••• Sanguessuga do Medo
Este poder permite à infernalista se alimentar temporariamente do medo como se fosse sangue. Essa experiência dá uma euforia mais forte que a alimentação convencional, mas é uma prática perigosa se usada com frequência demais. A infernalista converte a carga emocional pura extraída do terror da vítima num substituto místico da vitae.
Sistema: Enquanto tiver seu sujeito à vista, a infernalista pode tentar obter sustento de qualquer medo que a vítima esteja sofrendo no momento. Naturalmente, a vítima precisa ter motivo para ter medo de algo ou alguém enquanto a infernalista pratica este poder. Esses medos não podem ser causados por outras aplicações desta trilha.
O número de sucessos obtidos na rolagem de ativação determina o número de pontos transmutados na "reserva de medo" da infernalista. Cada ponto nessa "reserva de medo" pode ser gasto exatamente como um ponto de sangue, além dos limites normais de Geração. Contudo, essa fonte extra de poder precisa ser utilizada antes do nascer do sol, ou desaparecerá.
Além do ponto de Força de Vontade perdido, uma falha crítica significa que a infernalista não obtém "reserva de medo" alguma da vítima, e não pode usar o poder naquela vítima de novo por 24 horas.]==],
				},
				["The Path of Praapti"] = {
					pt = [==[Rites of Blood, pág. 165


The Path of Praapti


Praapti (Trilha de Sadhana) é o poder da viagem instantânea. Os praticantes indianos de Sadhana desenvolveram esta Trilha para igualar seus misteriosos rivais asiáticos, que têm o poder de viajar instantaneamente por linhas de força mística. Mais tarde, sadhus renegados venderam o segredo desta Trilha aos Tremere, que fizeram engenharia reversa dele no que chamam de Trilha de Mercúrio. Um punhado de Anarquistas da Nova Era também tropeçou no segredo desta trilha, que eles simplesmente chamam de Teletransporte.
Os níveis individuais desta Trilha não têm efeitos distintos. Em vez disso, um domínio maior simplesmente indica uma distância maior que pode ser percorrida. Idealmente, o feiticeiro precisa conseguir ver o local de destino ou conhecê-lo intimamente. A falha numa rolagem para ativar esta trilha significa que nada acontece, mas falhas críticas são mais problemáticas. Se o local de destino estiver à vista ou for bem próximo (do outro lado de uma parede, por exemplo), uma falha crítica causa ao personagem os problemas catastróficos usuais da magia de sangue. Se o feiticeiro tentar um teletransporte às cegas, contudo, falhas críticas são bem mais perigosas. Tipicamente, o feiticeiro se vê fundido a um objeto sólido, sofrendo um nível de dano agravado por "1" rolado. Três ou mais níveis de dano também significam que o feiticeiro fica preso dentro de um objeto grande, como uma parede ou o chão, e pode não conseguir se libertar. Fortitude absorve este dano normalmente, mas não ajudará um personagem que se materializar a dois metros de profundidade. A familiaridade com o local de destino de um teletransporte às cegas afeta a dificuldade da rolagem da seguinte forma.
Íntimo (o próprio refúgio) — modificador de dificuldade -1
Visitado regularmente — +0
Não visto, mas compreendido (como o outro lado desta parede) — +0
Pouco familiar (visitado algumas vezes) — +1
Muito pouco familiar (um local conhecido) — +2
• Teletransporta até 10 metros.
•• … até 50 metros.
••• … até 500 metros.
•••• … até 8 quilômetros.
••••• … até 800 quilômetros.
O teletransporte raramente é exato. Cada "1" rolado numa rolagem bem-sucedida desvia o feiticeiro em 10% do total do destino. O número de sucessos rolados determina o que pode ser transportado. Um único sucesso permite o teletransporte do corpo nu do feiticeiro. Cada sucesso adicional permite o transporte de mais nove quilos. Se os sucessos rolados não bastarem para abranger o que o feiticeiro pretende levar, o Narrador decide o que fica para trás.]==],
				},
				["The Path of Skulls"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 54


The Path of Skulls


Cappadocius são muitas vezes descartados como apolíticos, aptos apenas para trabalho em masmorras e valas de peste. Não possuem nenhum dos talentos de sangue que permitem manipulação e controle de mortais. A expectativa de que um Saqueador de Túmulos se sentiria mais em casa com os braços enfiados num cadáver não é fantasiosa, mas existe um estrato do clã que gosta de permanecer oculto, deixando seus cria vadearem entre cadáveres enquanto eles fazem reis. Esses Cappadocius se chamam de Arautos. Sua ordem existe há milênios. Ela formaria a espinha dorsal do clã, não fossem seus números reduzidos nos últimos séculos. Corre o boato de que o fundador do clã confinou um grande número de Arautos ao próprio Inferno.
Os Arautos usam a Necromancia de modo atípico. Antes de a Longa Noite degenerar na Guerra dos Príncipes, eles criaram a Trilha dos Crânios — uma Trilha necromântica dedicada ao roubo de identidade e conhecimento dos mortos. De salas do trono a caravanas de mercadores, necromantes que canalizam a Trilha dos Crânios exercem domínio sobre o cenário diplomático e a Jyhad. Cappadocius guardam a Trilha dos Crânios com invejosa reserva, em grande parte pelo sigilo da agenda dos Arautos. Cappadocius que conhecem a Trilha ocasionalmente tutelam os que demonstram sagacidade política sutil. Saber se deve assassinar um monarca, sua rainha ou o herdeiro deles; perceber se deve entregar, alterar ou destruir uma mensagem de uma corte a outra — tais comportamentos são observados pelos Cappadocius que se chamam de Arautos, e recompensados com tutela na Trilha dos Crânios.

• Calvaria Emissicius
Um dos segredos mais valiosos do Clã Cappadocius é a capacidade de espionar pelas órbitas oculares dos mortos. Poucos indagam por que Saqueadores de Túmulos enfeitam seus refúgios com os crânios de suas vítimas. Um Cainita simples pode tomar um aglomerado de restos esqueléticos por decoração mórbida, sem perceber que das órbitas vazias de um crânio espia o olhar de um necromante.
Sistema: O necromante precisa possuir o crânio de qualquer criatura que ele mesmo tenha matado. O jogador gasta um ponto de sangue e rola Percepção + Ocultismo (dificuldade 5). A falha não tem efeito; uma falha crítica significa que o crânio se desfaz em pó imediatamente. O sucesso significa que o necromante pode entrar instantaneamente num estado meditativo em que consegue ver pelas órbitas do crânio, cancelado apenas quando o transe é rompido ou o sol nasce. Esse estado de espionagem pode ser reiniciado um número de vezes igual ao número de sucessos.

•• Consilium Mortuus
O mito sustenta que os mortos não mentem. Na verdade, espectros e cadáveres animados são tão capazes de falsidade quanto qualquer outro ser, mas os Arautos acreditam que há um grão de verdade na fábula. Os Cappadocius buscam um jeito de garantir respostas verdadeiras dos falecidos, e a posse do crânio é a chave. Ao conversar com a cabeça decepada do alvo falecido, revela-se que arrancar uma verdade garantida de lábios apodrecidos é bem possível.
Sistema: O necromante precisa possuir a cabeça decepada de um ser cuja língua ele compreenda. O jogador precisa gastar ao menos um ponto de sangue e rolar Manipulação + Empatia (dificuldade 6). A falha não tem efeito; uma falha crítica significa que a cabeça responderá apenas com mentiras ao interrogatório do necromante. O sucesso força a cabeça a responder com verdade a uma pergunta feita pelo necromante, mas precisa ser uma pergunta cuja resposta o antigo dono da cabeça saberia. Para cada ponto de sangue gasto além do inicial, uma pergunta adicional pode ser feita.
Nenhum espírito é invocado com Consilium Mortuus — o ser morto com quem o necromante se comunica nem sequer está ciente de estar sendo canalizado. A resposta vem por memória vestigial, traços deixados no cérebro apodrecido da cabeça, impressos em sua língua em putrefação.

••• Ammorsus Vicarius
Quem pratica a Trilha dos Crânios sabe que ser destinatário de informação sensível é um negócio mortal. O fetiche da Trilha — o crânio epônimo — tem mais utilidade que um simples meio de comunicação. Pode agir como ferramenta brutal nas mãos de um necromante experiente, e muitas vezes precisa fazê-lo, pois necromantes fazem muitos inimigos.
Usando este poder, o necromante pode segurar a mandíbula e a maxila do crânio para usá-lo como arma bizarra de curto alcance, fixar o crânio na ponta de uma lança para atacar à distância, ou até deixar o crânio sozinho, para agir como armadilha. Se não estiver sob controle manual de quem o empunha, o crânio tem alcance limitado. Tal restrição muitas vezes leva necromantes a colocar esses crânios em camas, sobre escrivaninhas ou dentro de baús. Quando os dentes se cravam numa vítima, o sangue flui. Cada gota rejuvenesce o necromante.
Sistema: O necromante precisa possuir um crânio ou cabeça em decomposição com todos os dentes removidos. O jogador precisa gastar um ponto de Força de Vontade e ao menos um ponto de sangue para este poder fazer efeito. No lugar dos dentes, uma fileira cruel de presas emerge no crânio, permanecendo até que ele consuma tantos pontos de sangue quantos foram gastos pelo necromante em sua ativação. Nesse ponto, o crânio fica inerte e suas presas caem.
O crânio morde instintivamente quando está a meio metro de carne viva e sangue quente. Com o gasto de um segundo ponto de Força de Vontade pelo vampiro, ele também investirá contra Cainitas. O crânio é capaz de se impulsionar meio metro com as mandíbulas abertas numa única ocasião, com parada de combate total de 6 e dificuldade padrão. Uma mordida bem-sucedida de um crânio independente é um agarrão imediato do qual o crânio não se soltará até ser destruído.
O crânio pode ser empunhado como arma pelo necromante, caso em que mantém a mesma parada de combate e dificuldade da arma em que está fixado (ver V20 Dark Ages p. 349). Nesse caso, o crânio retrairá voluntariamente sua mordida se o necromante o afastar da vítima.
A mordida do crânio causa três níveis de dano agravado a cada turno em que suas presas estiverem cravadas num alvo. Ela também consome um ponto de sangue por turno, que é necromanticamente canalizado ao Cainita que lhe deu poder. Vitae canalizada dessa forma pode contar para um laço de sangue.
O crânio é destrutível, mas leva ao menos um turno de ataque concentrado para ser destruído. Para fins de defesa, o crânio não pode esquivar nem manobrar. Tem Força 3 para determinar resistência a ser arrancado e Vigor 2; tem apenas três níveis de vitalidade e só pode absorver dano contundente.
Um necromante pode animar múltiplos crânios fazendo o gasto de Força de Vontade e sangue para cada um.

•••• Exedo Animus
Os de fora jamais devem conhecer os benefícios deste poder, pois presumirão que o praticante é culpado do Amaranto. Os necromantes que realizam Exedo Animus não estão consumindo a alma de um dos mortos, mas permitindo que as memórias do falecido habitem seus corpos por um tempo. Tal presença não dá ao espírito poder algum sobre o hospedeiro, mas dá ao hospedeiro acesso completo à identidade, à personalidade e à memória do falecido.
Ao portar um crânio — seja de mortal, seja de Cainita —, o necromante forma um vínculo simpático com o antigo dono do crânio. Necromantes usaram este poder para enganar os entes queridos do falecido, indicando que falam pelas últimas vontades do morto. Outros matam rivais, ganhando acesso a seus segredos ao beber memórias do crânio do falecido.
Sistema: O necromante precisa possuir um crânio e conhecer a identidade da pessoa da qual o crânio outrora fez parte. O jogador precisa gastar dois pontos de Força de Vontade e dois pontos de sangue, e rolar Inteligência + Ocultismo (dificuldade 7). A falha não tem efeito; uma falha crítica significa que as memórias do falecido serão confusas e enganosas. O sucesso permite ao necromante virar o crânio e beber a personalidade dele. Para cada sucesso, o necromante ganha uma hora como hospedeiro das memórias e da identidade do crânio.
Os efeitos de Exedo Animus permitem ao necromante realizar rolagens baseadas em Inteligência que envolvam a recordação e as memórias do falecido com dificuldade reduzida em 3. Essas memórias param no ponto da morte — o espírito em comunhão é uma sombra da vida, e não um espectro independente e pensante.
Exedo Animus também concede ao necromante o poder de se passar pela identidade do falecido, ganhando três dados em rolagens baseadas em Performance ao fazê-lo. Tal imitação sofre penalidades quando o necromante não se assemelha fisicamente à fonte morta de sua imitação, mas ao utilizar Ofuscação ou ao explicar que está canalizando o morto em vez de ser o morto, esses atos são mais bem-sucedidos.

••••• Degulo
Quando Degulo foi praticado pela primeira vez, seus criadores necromantes celebraram num devaneio longo e sombrio. Nestas noites, a eficácia de Degulo é pesada contra os perigos que apresenta. Enquanto Possessão Demoníaca (ver V20 Dark Ages p. 280) se concentra na arte de transpor um espírito falecido para a casca vazia de um cadáver, Degulo é o método pelo qual um necromante consome um fragmento de alma e o retém para sempre como parte de si.
O processo pelo qual um necromante come um espírito exige grande sacrifício por parte do praticante, que precisa abrir mão de uma parte de si para permitir que o morto se mude para dentro. Sabe-se de necromantes que despojam seus corpos de fragilidade para acolher as almas de guerreiros poderosos, enquanto outros perdem o conhecimento de suas próprias línguas para abrir espaço a dialetos antigos e arcanos. No extremo, alguns Arautos se despojam dos poderes dados por seu clã em troca de Disciplinas possuídas por Cainitas falecidos. Contam-se histórias de Cappadocius que tentam perder sua maldição, substituída pela de outro clã. Até hoje, essas tentativas fracassaram, mas necromantes são conhecidos por seu compromisso com a experimentação incessante.
Sistema: O necromante precisa possuir o crânio do ser cujos poderes deseja ingerir e absorver. O jogador precisa gastar dois pontos de Força de Vontade e fazer uma rolagem de Força de Vontade (dificuldade 9). Força de Vontade não pode ser gasta para criar um sucesso automático nessa rolagem. A falha não tem efeito; uma falha crítica significa que o necromante perde aquilo que estava preparado para sacrificar pela Disciplina, mas não ganha nenhum dos benefícios. O sucesso permite ao necromante desencaixar a mandíbula e consumir o crânio inteiro, absorvendo em seguida elementos do espírito devorado.
Degulo força o vampiro a perder um traço qualquer de sua ficha. O Narrador então substitui o valor desse traço pelo valor detido pela pessoa morta cujo crânio foi consumido.
O vampiro que usa Degulo está restrito a trocar apenas um valor de traço e, como o crânio é consumido no ato, este ato não pode ser repetido com outros traços do mesmo espírito. Diferentemente dos outros níveis da Trilha dos Crânios, se houver um espectro do falecido, ele é afetado por este poder, ganhando o traço legado pelo necromante em troca do seu próprio.
A única restrição de Degulo se aplica a Disciplinas, permitindo apenas uma troca de valor igual de poderes Cainitas. Um necromante não pode trocar seu único ponto em Auspícios pelos quatro pontos de Dominação de outro Cainita, mas pode trocar seu único ponto em Auspícios pelo primeiro ponto da Disciplina Dominação do Cainita falecido. O praticante de Degulo então perde sua Disciplina escolhida como Disciplina de Clã, ganhando a Disciplina consumida como sua nova Disciplina de Clã.]==],
				},
				["The Path of Woe"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 57


The Path of Woe


A proficiência dos Giovani no trato com espíritos é amplamente respeitada por outros necromantes, com a exceção de uma estirpe rara — um sindicato de mortais e vampiros romanos que leva o nome Rosselini, ou variações dele. Os necromantes que seguem a suposta matriarca Rosalina são tão hábeis em enredar espectros quanto qualquer Giovani, mas, onde os Jovens sondam, interrogam e barganham com fantasmas, os necromantes Rosselini torturam e drenam os mortos, aviltando as terras dos vivos no processo. Ironicamente, a maioria vê os Giovani como amadores rudes na melhor das hipóteses, desdenhando em especial da Trilha do Sepulcro. Para seus fundadores Rosselini, a Trilha da Aflição equivale a uma forma de arte sagrada, com o apoio virtuoso de caçadores mortais que operam sob o papado. Esses inquisidores querem ver as almas dos hereges sofrerem ainda mais, implorando absolvição mesmo além da morte. Os necromantes que conhecem a Trilha da Aflição têm todo o prazer em cumprir o édito papal.
Os Rosselini mortais — que levam o nome simplesmente como tributo ao epíteto de sua líder de cabeleira escarlate — foram Abraçados em clãs e linhagens diversos. Embora os Cappadocius e os Giovani estejam entre seus principais senhores, praticantes da Trilha da Aflição são encontrados entre os Seguidores de Set, os Toreador e os Lasombra em número menor. A Trilha é nova nestas noites, mas, com Luís IX da França preparando outra cruzada para retomar Jerusalém e o fervor cristão em brasa, a Necromancia estilizada como forma sagrada entra na moda nas cortes Cainitas.

• Encontrar o Lócus
Espectros costumam estar presos a objetos, locais e indivíduos conhecidos como Grilhões. Necromantes Rosselini sabem que expor um deles em geral exige detectar e ameaçar seus Grilhões. Dali, o interrogatório ou a destruição pode começar.
Sistema: A jogadora gasta um ponto de sangue enquanto sua vampira esfrega vitae nos olhos e rola Percepção + Sensitividade (dificuldade 5). A falha não tem efeito; uma falha crítica significa que a necromante confunde o objeto errado com um Grilhão. O sucesso permite à necromante ver um brilho ectoplásmico ao redor de algo importante para um espectro, como a espada usada para matá-lo, o vestido em que ela morreu, a casa em que ele cresceu ou a filha que ela entregou à Igreja. Cada sucesso adicional permite à necromante ver trilhas até outros Grilhões do mesmo espectro. Os efeitos da Disciplina duram uma cena. Este poder só permite ao vampiro ver um Grilhão. Embora o espectro muitas vezes se manifeste se seu Grilhão for ameaçado, a necromante não conseguirá vê-lo até que ele torne sua presença evidente.

•• Expurgar os Condenados
Necromantes Rosselini não se interessam por invocar espíritos nem barganhar com eles. Eles ameaçam os mortos e lhes arrancam as defesas. Se um necromante tem certeza de que um espírito está no cômodo, no círculo de ossos ou na fronteira pintada com vitae, Expurgar os Condenados força o espectro a se dar a conhecer. Não prende o espírito nem o compele a falar, mas põe o espectro exatamente onde o Rosselini o quer.
Sistema: O necromante precisa estar num espaço fechado, formar um círculo de ossos humanos ou pintar um usando a própria vitae. O jogador precisa gastar um ponto de sangue (mais, se estiver pintando um círculo, com o volume a critério do Narrador) e rolar Raciocínio + Teologia (dificuldade 7, reduzida em um se um Grilhão dentro da área for identificado, em dois se o Grilhão for danificado e em três se o Grilhão for destruído). Se o espectro estava dentro da área afetada por Expurgar os Condenados antes da rolagem, o sucesso o expele das Terras das Sombras para o mundo dos vivos numa forma física e vulnerável. A falha resulta no Poder não funcionar; uma falha crítica puxa a vampira através das Terras das Sombras, onde ela se vê sujeita ao que quer que o espectro tenha planejado.
Espectros expurgados para a área do necromante usam as estatísticas de V20 Dark Ages (p. 403) e podem absorver dano tanto contusivo quanto letal. Espectros trazidos assim podem voltar livremente às Terras das Sombras, mas poucos o fazem quando seus Grilhões estão sob ameaça.

••• Flagelo de Sangue
O Flagelo de Sangue permite ao necromante infligir dor torturante a um espectro, para grande deleite da Inquisição e dos necromantes Rosselini. O poder exige sacrifício por parte da necromante, pois ela precisa dar da própria vitae. Assim como um portador de Fé Verdadeira pode possuir sangue de glória ardente, a vitae santificada da necromante inflige dor purgativa aos condenados. A maioria dos necromantes usa este poder com calma, como meio de prolongar o sofrimento e extrair segredos da vítima espiritual. O corpus do espectro se descola em pedaços apodrecidos conforme a vitae o alcança. O Flagelo de Sangue é uma arma necromântica verdadeiramente infame.
Sistema: A jogadora gasta no mínimo um ponto de sangue. A vitae flui livremente das palmas e das solas da necromante, que pode lançar as mãos como se empunhasse um chicote contra o espírito diante dela. A jogadora precisa rolar Armas Brancas + Destreza para sua Cainita acertar o espectro, com o espectro tendo direito a esquivar se estiver em posição de fazê-lo. Para cada ponto de sangue gasto, a necromante inflige esse número em dano agravado ao espectro. Essa vitae ardente causa tamanha agonia que aumenta em dois a dificuldade de qualquer tentativa do espectro de usar seus poderes.
O Flagelo de Sangue não pode ferir espectros nas Terras das Sombras, a menos que o necromante esteja presente lá.

•••• Eucaristia Maldita
A Necromancia é um empreendimento custoso, muitas vezes deixando seus mestres drenados e amaldiçoados por seguir trilhas que ninguém deveria trilhar. A Trilha da Aflição permite uma ressurreição à necromante, no ponto em que sua determinação fraqueja. Para os necromantes desta Trilha, a Eucaristia Maldita é uma dádiva de Deus e prova de que Ele quer que continuem sua obra sagrada. Só cravando as presas num espectro é que Deus mostra essa bênção.
Sistema: A jogadora rola Vigor + Teologia (dificuldade 6) enquanto a necromante tenta se alimentar de um espectro. Na falha, nada acontece; uma falha crítica resulta em icor ardente drenado do espírito, causando um nível de dano agravado à Cainita. O sucesso converte a Paixão drenada do espectro em Força de Vontade temporária, à razão de um ponto de Força de Vontade para cada dois pontos de Paixão consumidos.

••••• Purgar a Alma do Apóstata
Os Rosselini levam seu mandato papal a sério. Ele lhes permite praticar sua Necromancia livremente num mundo cada vez mais hostil à magia. Ferver almas de hereges e beber o escorrido é uma honra e um bônus para os membros verdadeiramente malignos da fé, que reconhecem a cálida benevolência de Deus na permissão de seus atos terríveis. Purgar a Alma do Apóstata é um método infalível de enviar espíritos ao Olvido.
Magos do sangue estreitam os olhos diante dos praticantes deste poder, reconhecendo semelhanças com seu próprio Caldeirão de Sangue (ver V20 Dark Ages p. 302) e se perguntando se algum necromante roubou e reformulou o poder deles. Os necromantes, é claro, insistem que é bem o contrário, sendo seu poder eminentemente superior e abençoado pela Inquisição.
Sistema: O jogador gasta três pontos de Força de Vontade e rola Inteligência + Teologia (dificuldade 8), enquanto o necromante está na presença de ao menos um espectro. A falha resulta em nada acontecer; uma falha crítica reverte o efeito sobre o vampiro. Cada sucesso inflige um nível de dano agravado à alma do espectro e a qualquer outro dentro de um raio de 10 metros do necromante, mortal ou morto-vivo. Para cada nível de vitalidade perdido pelo espectro, uma poça desprendida de ectoplasma é produzida. O necromante pode bebê-la, recuperando um ponto de Força de Vontade para cada poça lambida do chão.
O uso deste poder contamina irreversivelmente o raio de 10 metros ao redor do necromante, tornando-o uma esfera onde a vida é incapaz de crescer e na qual espectros jamais podem voltar a entrar.]==],
				},
				["The Path of the Ailing Jackal"] = {
					pt = [==[Rites of Blood, pág. 160


The Path of the Ailing Jackal


Muitas das trilhas associadas ao Dur-An-Ki são funcionalmente idênticas a várias trilhas de Taumaturgia. Em muitos casos, a versão Dur-An-Ki veio primeiro e foi adaptada à Taumaturgia pelos Tremere.
The Path of the Ailing Jackal é uma dessas trilhas: é funcionalmente idêntica à Trilha da Vingança do Pai (V20, pp. 226-228).]==],
				},
				["The Path of the Evil Eye"] = {
					pt = [==[Rites of Blood, pág. 160


The Path of the Evil Eye


Ao longo da história, os ignorantes e supersticiosos temeram o Mau-Olhado — a crença de que algumas pessoas têm o poder de amaldiçoar seus inimigos, seja pela invocação de poderes sombrios, seja simplesmente pela vontade maliciosa. Em alguns lugares, tais crenças persistem, talvez em parte por causa da existência desta Trilha, que permite ao ashipu invocar djinn irados para constranger, ferir ou até matar seus inimigos. Mas esta Trilha não é domínio exclusivo do Dur-An-Ki. Sua linhagem antiga significa que ela é conhecida de muitos Anarquistas da Velha Escola que preservaram o poder de amaldiçoar ao longo das eras, enquanto sua pura rancorosidade garantiu que Feiticeiros Punk modernos aprendessem a duplicar seus efeitos.
Para usar o Mau-Olhado contra um alvo, o feiticeiro precisa ou conseguir fazer contato visual com ele e dizer algo que indique seu desdém, seja uma maldição árabe tradicional ou simplesmente um “Vai se foder!” gritado. Como alternativa, o feiticeiro pode usar uma efígie para lançar a maldição a maior distância (como descrito nos Princípios de Contágio e Simpatia, pp. 133-135). O alvo não necessariamente perceberá que foi amaldiçoado. Uma rolagem de Inteligência + Ocultismo (dificuldade 6) é exigida do alvo se o feiticeiro lançar a maldição na cara dele, enquanto uma rolagem de dificuldade 9 é exigida para perceber que a má sorte recente é resultado de uma maldição lançada de longe. Um personagem com Percepção da Aura ou que tenha ao menos um ponto nesta Trilha pode notar sinais reveladores de uma maldição pairando na aura do alvo e pode reconhecê-los como resíduo de maldição com uma rolagem de Raciocínio + Ocultismo (dificuldade 7). Um personagem que identifique uma maldição desse modo pode tratar a própria maldição como uma conexão mística equivalente a um bem estimado enquanto estiver na presença do indivíduo amaldiçoado.
O feiticeiro que lançou a maldição pode anulá-la à vontade. Qualquer outro personagem capaz de reconhecer a maldição (inclusive o próprio alvo, se tiver o conhecimento apropriado de magia de sangue) pode tentar anulá-la com Contramagia Taumatúrgica (V20 p. 228) ou qualquer efeito comparável de magia de sangue. Quem lança a maldição nunca sabe exatamente como ela se manifestará. Cada nível desta Trilha define os parâmetros do tipo de dano que pode ocorrer, mas o Narrador determina a natureza precisa da manifestação.

• Humilhação
A aplicação mais simples do Mau-Olhado faz o alvo se envergonhar de algum modo público. Resultados possíveis incluem dizer algo constrangedor diante dos pares, fracassar desastrosamente numa tentativa de alimentação ou simplesmente rasgar o fundilho da calça num bar lotado.
Sistema: Cada sucesso representa uma noite durante a qual o alvo é afetado pela maldição. A maldição dispara uma vez por noite num momento à escolha do Narrador, em geral a cena em que o personagem está diante do maior número de indivíduos ou diante do maior número de pessoas socialmente importantes. Ou seja, ela pode disparar enquanto o personagem está num restaurante lotado ou quando está a sós com o Príncipe, o que tiver o maior potencial de constrangimento pessoal. O Narrador determina quando a maldição dispara, mas ela deve fazê-lo ao menos uma vez por noite.
Durante a cena de disparo, em cada rolagem Social feita para o personagem, o jogador precisa acrescentar um número de 1s automáticos igual ao valor do feiticeiro na Trilha do Mau-Olhado, aumentando assim a probabilidade de falha crítica numa rolagem Social. Além disso, durante a cena de disparo, o Narrador deve rolar um número de dados igual ao valor do feiticeiro nesta trilha (dificuldade 5). Sucessos significam que algum evento externo acontece e causa constrangimento ao personagem, como um garçom derramando bebidas nele ou um carro respingando lama.

•• Perda
Esta maldição afeta o patrimônio material do alvo. O mais comum é fazer o alvo ser despojado de dinheiro, mas ela também pode fazer o Rebanho dele diminuir ou destruir um Refúgio. A maldição pode ter como alvo qualquer bem tangível representado como Antecedente. Se o personagem não tem Antecedentes adequados, ela mira itens pessoais de significado emocional.
Sistema: Dentro de uma semana, o alvo perde um ponto de um Antecedente apropriado. Em geral, a maldição ataca preferencialmente Recursos em vez de outros Antecedentes, mas teoricamente qualquer forma de Antecedente tangível que represente um bem pessoal pode ser alvo válido. O feiticeiro não tem controle sobre como o ponto de Antecedente é perdido, nem sobre qual ponto de Antecedente é perdido. O Narrador pode até optar por decidir aleatoriamente.

••• Perigo
Neste nível de maestria, a ashipu pode finalmente pôr o inimigo em perigo, em vez de meramente incomodá-lo. A maldição não pode ferir o alvo diretamente, mas pode criar uma situação em que seja possível que ele seja ferido, seja pelas mãos de um brutamontes bêbado que se ofende com os modos do alvo num bar, seja por uma alcateia de lobisomens que, por acaso, decide embarcar no mesmo vagão de metrô solitário que a vítima.
Sistema: O número de sucessos determina por quantas noites o personagem fica em risco. No início de cada noite, o Narrador precisa rolar um dado e, conforme o resultado, montar um encontro para o personagem alvejado.
1-3 — Nenhum. A maldição não dispara durante esta noite.
4-6 — Leve: Um encontro que provavelmente não fere o personagem, mas que tem chance de fazê-lo. Um mortal tenta assaltar o personagem enquanto ela está diante de mortais, ou simplesmente tenta assaltar uma loja de conveniência enquanto a personagem está na fila pagando gasolina. Um frequentador de bar se ofende com algo que a personagem faz ou diz e tenta arrumar briga.
7-8 — Moderado: Um encontro com probabilidade significativa de ao menos algum dano ao personagem. O personagem se envolve num acidente de carro ou é atropelado por um motorista que foge. Uma escada cede enquanto o personagem a sobe.
9 — Grave: Um encontro em que o personagem quase certamente sofrerá algum dano letal. O personagem diz sem querer algo ofensivo que provoca rolagens de frenesi em vampiros próximos. O prédio desaba enquanto o personagem está dentro dele, ou irrompe um incêndio.
10 — Catastrófico: Um encontro potencialmente mortal. O personagem fica trancado do lado de fora de seu refúgio durante o dia. O personagem diz sem querer algo que ofende uma alcateia de Lupinos próxima.
Noites em que não há perigo não contam contra os sucessos da ashipu; a maldição continua até que o alvo tenha sofrido um número de encontros perigosos igual aos sucessos ou até que a maldição seja levantada. Durante qualquer encontro perigoso, o personagem alvejado tem chance de perceber que está sob uma maldição (se já não soubesse). A rolagem é Inteligência + Ocultismo. A dificuldade padrão é 9, mas cai para 8 se o personagem tiver Auspícios ou para 6 se o personagem tiver algum conhecimento desta Trilha.

•••• Inimigo
Esta maldição potente faz os amigos e aliados do alvo se voltarem contra ele, ao mesmo tempo em que faz crescer o número de seus inimigos.
Sistema: Para cada sucesso na rolagem de Força de Vontade, o alvo perde um ponto de Aliados, Contatos, Influência ou Lacaios. Isso pode refletir amigos e aliados que ficaram irritados com o personagem e lhe dão as costas, pode refletir contatos e aliados que simplesmente ficam indisponíveis por um tempo, ou pode de fato resultar em tais personagens sendo feridos ou até morrendo por má sorte. Como alternativa, o jogador pode optar por gastar parte ou todos os sucessos para dar ao alvo um novo Inimigo (conforme o Defeito Inimigo), que aparece para perseguir uma vendeta contra o personagem. De todo modo, os efeitos se manifestam dentro de uma semana, e o jogador do personagem alvejado não pode nem recuperar Antecedentes perdidos nem remover o Defeito Inimigo sem descobrir e neutralizar a maldição.

••••• O Olho Que Fere
A expressão máxima desta trilha maléfica, o Olho Que Fere não precisa de tempo para estabelecer uma cadeia de má sorte. Ele golpeia de imediato. A ashipu precisa fazer contato visual com seu alvo e proferir alguma exclamação relativa a uma característica dele. Pode ser elogio ou insulto, sarcasmo ou fúria, mas seja qual for a forma, o alvo é imediatamente atingido por um ferimento agonizante que danifica aquela característica.
Sistema: Embora a maldição permita flexibilidade, o pressuposto padrão é que, a cada dois sucessos (arredondados para cima), o alvo (ou objeto, se a maldição for dirigida a um bem do alvo) sofre um nível de dano agravado. Em geral, mesmo um único nível de dano basta para matar um animal ou destruir a maioria dos objetos. Se usado contra um mortal, este poder o mutila permanentemente. Se usado contra um Membro, a maldição inflige dano moldado pelas palavras da ashipu. Se ela elogia os belos olhos dele, eles serão queimados e ele pode ficar cego até conseguir se curar. Se ela zomba de suas palavras melífluas, a maldição pode queimar-lhe a língua e deixá-lo incapaz de falar. Esta maldição pode ser transmitida por uma efígie, mas a penalidade normal de dificuldade imposta pelo uso de efígie aumenta em +2 (ver Princípios de Contágio e Simpatia, pp. 133-135).]==],
				},
				["The Path of the Twilight Garden"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 289


The Path of the Twilight Garden


Conhecida pelos de fora como “A Trilha dos Quatro Humores”, a Trilha do Jardim Crepuscular está entre os segredos mais bem guardados das Lâmias. A Disciplina surgiu das práticas rituais do Culto de Lâmia embora, como as próprias Lilin, a Trilha do Jardim Crepuscular tenha uma inclinação marcial.

• Sussurros à Alma
Apenas ouvir o sussurro do verdadeiro nome da Mãe Negra basta para enlouquecer mortais e encher de terror o coração dos Cainitas.
Sistema: A Lilin sussurra um dos nomes secretos de Lilith. Qualquer alvo único a até 100 passos e na linha de visão da personagem ouve o sussurro como se a invocadora falasse diretamente em seu ouvido. O alvo precisa fazer imediatamente uma rolagem de Força de Vontade (dificuldade 8) ou será atormentado por pesadelos e alucinações por um número de dias e noites igual ao valor de Manipulação da invocadora. Isso faz o alvo perder dois dados de todas as paradas de dados enquanto durar o poder.

•• Beijo da Mãe Negra
A Lilin morde a própria língua e enche a boca com uma mistura fétida e acre de bile negra e vitae. Sua mordida se torna ainda mais terrível, e ela consegue devorar a vida de suas vítimas com facilidade.
Sistema: A jogadora gasta um ponto de sangue enquanto a vampira enche a boca com a substância cáustica. O próximo ataque de mordida que ela fizer causa dano dobrado antes da absorção. Isso não torna a alimentação mais eficiente, nem agrava o dano causado por perda de sangue. Se a vampira não usar um ataque de mordida contra um alvo, sua mordida permanece potente pelo resto da noite.

••• Humores Negros
As Lâmias são conhecidas por seu atletismo e pelo domínio do próprio corpo. Não só conseguem realizar feitos de destreza física incrível, como também conseguem manipular o equilíbrio dos humores em seu corpo por pura força de vontade. Com o uso deste poder, uma Lâmia pode transubstanciar sua própria vitae num de quatro humores corporais corrompidos, cada um com seu efeito.
Sistema: A jogadora gasta dois pontos de sangue enquanto a Lâmia corta a própria pele (ela pode usar uma faca, morder a língua ou simplesmente rasgar a pele com as garras). Ela transubstancia uma pequena quantidade de sangue num dos humores descritos abaixo. Ela também pode usar isso como defesa contra outro vampiro que esteja se alimentando dela. O alvo não precisa ingerir o humor para sofrer seus efeitos; o contato com a pele basta.
Os quatro humores são:
Fleumático: A exposição a humores fleumáticos deixa o alvo letárgico. Todas as paradas de dados são reduzidas em dois pelo restante da cena.
Melancólico: Humores melancólicos mergulham o alvo em profundo desespero. Pelo resto da cena, ele não pode gastar nenhum ponto de Força de Vontade e a dificuldade de todas as suas rolagens de Força de Vontade aumenta em dois.
Sanguíneo: Ao ser exposto a humores sanguíneos, o alvo se torna propenso a sangramento excessivo. Quaisquer ferimentos letais ou agravados causam um nível extra de dano do tipo correspondente no turno seguinte.
Bilioso: Humores biliosos envenenam o alvo, infligindo um número de níveis de dano letal igual ao Vigor do necromante.

•••• Manto do Nunca-Nascido
Com o uso deste poder, a Lâmia fortalece sua conexão com o coração negro da Mãe Negra. Ao completar um breve ritual em que bebe ao menos cinco pontos de sangue de um cadáver frio, ela ganha um pouco da força e da sabedoria duramente conquistadas da longamente sofrida Lilith.
Sistema: A vampira bebe ao menos cinco pontos de sangue de um cadáver frio, depois gasta cinco pontos para invocar o poder. Ela então se transforma em nível espiritual e fisiológico; seus olhos ficam inteiramente negros, seus modos ficam distantes e frios. Ela ganha dois dados adicionais de absorção e imunidade a todas as penalidades por ferimento pelo restante da cena. Com uma rolagem bem-sucedida de Percepção + Ocultismo (dificuldade 7), ela pode enxergar as Terras das Sombras e falar com quaisquer fantasmas de lá. Por fim, ela consegue determinar de imediato a saúde relativa de qualquer ser que veja, pois ferimentos e doenças se manifestam vividamente na aura da criatura.

••••• Lamento de D’hainu
A Lâmia uiva em agonia, e a própria terra treme. Um miasma de escuridão contorcida se ergue do solo e enlaça seus inimigos. Os apanhados pela escuridão não são fisicamente presos, mas são de imediato acometidos por uma angústia emocional tão rica e crua que buscam pôr fim à própria vida do modo mais expedito possível.
Sistema: A jogadora gasta dois pontos de Força de Vontade e rola Vigor + Esportes, dificuldade 7. Para cada sucesso rolado, o raio do Lamento de D’hainu aumenta em cinco metros. Qualquer um dentro do raio do Lamento (exceto a necromante) precisa fazer uma rolagem de Força de Vontade, dificuldade 7. Se a rolagem de Força de Vontade falhar, as vítimas do Lamento são tomadas pelo desespero e buscam pôr fim à própria vida imediatamente. Homens se lançam sobre suas espadas, lupinos rasgam a própria garganta e magos voltam suas magias contra si mesmos. A menos que seja detida, a vítima do Lamento não cessa sua busca pela morte até conseguir se matar. Cainitas afetados pelo Lamento não são levados ao suicídio, mas caem em torpor imediatamente. Mesmo que o alvo tenha êxito na rolagem de Força de Vontade, ele se livra dos impulsos suicidas, mas sua parada de dados para todas as ações é reduzida em dois pelo restante da cena. Se uma vítima que falhou na rolagem de Força de Vontade não tiver conseguido se matar até o fim da cena, os efeitos do Lamento se dissipam, mas sua parada de dados para todas as ações fica reduzida em dois até o nascer do sol seguinte.]==],
				},
				["The Revelations of Duat"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 61


The Revelations of Duat


O Feitiço da Vida é domínio dos dedicados ao antigo inimigo de Set, Osíris. Embora as Bruxas de Equidna sejam incapazes de replicar os poderes do Feitiço, elas há muito forjaram os primeiros passos de uma Trilha de Akhu, chamada As Revelações de Duat. Depois de ensinar os preceitos a Setitas Ortodoxos de Saqqara a Luxor, as Górgonas abandonaram o Egito de repente e se retiraram para a Grécia. As razões da partida delas caíram no apócrifo, se é que um dia foram conhecidas.
Pouco depois de as Górgonas deixarem o Egito, Cappadocius do culto de Lázaro chegaram em busca de santuário junto a Setitas simpáticos. Os Setitas — noviços nas promissoras Revelações de Duat — recorreram à prole de Lázaro para mais tutela. O resultado é uma Trilha de Feitiçaria Setita maculada pelos dons da Necromancia, muitas vezes compartilhada entre Setitas e Cappadocius dispostos a se dedicar ao estudo da morte e — no mínimo — a prestar reverência de fachada a Anúbis ou Hades.
Iniciar os poderes da Feitiçaria Setita é idêntico ao da Taumaturgia (ver V20 Dark Ages p. 297), exceto que, no lugar de Ocultismo, usa-se Teologia.

• Vista do Chacal
Feiticeiros com a Vista do Chacal identificam de imediato fantasmas que resistem ao chamado de Duat, espionando os mortos livres enquanto cavalgam recipientes vivos ou se escondem em objetos e estruturas. Os olhos do feiticeiro ganham uma película cinzenta translúcida até que a duração do poder termine.
Sistema: Sucessos adicionais permitem maior percepção da força, da forma e da história do fantasma. O poder dura o restante da cena. Fantasmas percebem o feiticeiro numa falha crítica e, conforme seu temperamento, podem atacar o vampiro. A Vista do Chacal não permite ao feiticeiro se comunicar com os mortos.

•• Pesar as Virtudes
Para julgar os mortos, Anúbis precisa pesar virtudes e pecados. O Setita que pratica Pesar as Virtudes consegue identificar quaisquer feitos moralmente relevantes realizados por um ser outrora vivo, quer use este poder sobre um fantasma, um cadáver ou um vampiro. O conhecimento desses feitos é a chave para praticar os poderes seguintes desta Trilha, já que Imbuir com a Graça de Anúbis se apoia na compreensão dos crimes do falecido.
Sistema: Para cada sucesso, um feito diferente — de salvar uma criança das mandíbulas de um crocodilo a assassinar um rival por causa de um amante — surge ao feiticeiro em vívidos detalhes. Numa falha crítica, este poder revela um dos pecados do feiticeiro aos seus companheiros mais confiáveis.

••• Sentinela do Faraó
Sentinelas irracionais, sem emoção e inflexíveis são os melhores guardas que um Príncipe poderia desejar, mas, para criá-las, o feiticeiro precisa de um corpo morto e de um espírito desapossado. A Sentinela do Faraó cria um autômato sem emoções que serve para sempre ao édito do feiticeiro, agindo como guerreiro e guarda vigilante, sem escrúpulos morais quanto a matar nem medo de morrer em serviço.
Sistema: Quando o feiticeiro pratica a Sentinela do Faraó sobre um cadáver morto há uma única noite num lugar que um fantasma assombra, um fragmento da alma do fantasma migra para o cadáver e causa sua reanimação. O feiticeiro precisa ter usado Pesar as Virtudes antes, para identificar um gancho espiritual com que enredar o espírito. Cada sucesso permite usar o poder sobre um cadáver morto há uma noite a mais.
O édito do feiticeiro precisa ser uma única frase, p. ex. “Você deve guardar esta tumba de todos os intrusos, menos eu”, ou “Você deve seguir este homem até a casa dele e matá-lo lá dentro”. A ambiguidade leva a erros graves. Nos exemplos anteriores, “Você deve guardar esta tumba de todos os intrusos” levaria até o próprio feiticeiro a ser atacado caso tentasse entrar na tumba; e “Você deve seguir este homem até a casa dele e matá-lo” pode levar ao assassinato da vítima num ponto prematuro, em vez de dentro do prédio pretendido.
O cadáver animado permanece ativo permanentemente, sem sucumbir à decomposição.
Uma falha crítica na tentativa da Sentinela do Faraó faz o cadáver se erguer e atacar irracionalmente seu invocador até ser destruído.
Atributos: Força 4, Destreza 3, Vigor 5, Carisma 0, Manipulação 0, Aparência 0, Percepção 1, Inteligência 0, Raciocínio 1
Habilidades: Prontidão 2, Esportes 2, Briga 3, Intimidação 2, Armas Brancas 2, Furtividade 2
Disciplinas: Fortitude 1
Força de Vontade: 5
Vitalidade: 7
Notas: Essas sentinelas costumam ter uma reserva de sete pontos de sangue e se desfazem em pó depois de usá-los. Esse sangue está morto para fins de alimentação, então não pode ser consumido por vampiros.

•••• Imbuir com a Graça de Anúbis
Um guardião irracional é um defensor potente para refúgios e templos, mas às vezes o feiticeiro precisa que Anúbis devolva mais do que um lampejo de vida. Pela graça do deus chacal, o feiticeiro se vale do bom feito ou do pecado identificado por Pesar as Virtudes e imbui o cadáver animado pela Sentinela do Faraó com uma compulsão baseada nesse feito. O cadáver animado ainda é vítima do édito de uma linha, mas agora abriga emoções e inclinações baseadas nos feitos anteriores do espírito colhido e age conforme elas quando não for especificamente instruído a fazer o contrário. Essas inclinações sempre se manifestam de modo violento.
A utilidade deste poder vem do caos que ele causa. O feiticeiro que envia uma horda de cadáveres possuídos por emoção violenta a uma cidade sabe que o domínio se desfará pelas costuras.
Sistema: Uma sentinela com memória básica dos feitos que a definem age impulsivamente de modos semelhantes aos de sua vida anterior; p. ex. um antigo assassino que cortava a garganta de mercadores sempre matará quaisquer comerciantes que encontrar com ataques ao pescoço, enquanto um padre que auxiliava os pobres terá como alvo as casas dos ricos, incendiando-as e massacrando os moradores. Um único sucesso planta a memória de um feito na mente da sentinela, e cada sucesso adicional dá ao feiticeiro a opção de plantar outro.
O espírito de que o feito é extraído para a criação desta sentinela dotada tem consciência de que suas virtudes ou pecados estão sendo drenados, mas, sem o auxílio do feiticeiro, não pode recuperar a parte que perde para este poder. O feiticeiro precisa gastar um ponto de sangue para devolver o feito ao espírito de que ele se originou, ponto em que a sentinela se torna irracional, mantendo as mesmas estatísticas, mas nenhuma liberdade de pensamento.
A sentinela ataca seu senhor numa rolagem com falha crítica.
Atributos: Força 5, Destreza 4, Vigor 5, Carisma 0, Manipulação 0, Aparência 0, Percepção 2, Inteligência 0, Raciocínio 2
Habilidades: Prontidão 2, Esportes 3, Briga 3, Intimidação 3, Armas Brancas 3, Furtividade 3
Disciplinas: Fortitude 2, Potência 1
Força de Vontade: 7
Vitalidade: 8
Notas: Essas sentinelas costumam ter uma reserva de oito pontos de sangue e se desfazem em pó depois de usá-los. Narradores podem ampliar as estatísticas conforme o feito imbuído no cadáver.

••••• A Feitiçaria da Vida
Nos apócrifos Setitas, diz-se que os servos favoritos de Set eram as entidades imortais conhecidas como Múmias Malignas. Set e seus cria tentaram uma versão do Feitiço da Vida de Osíris na tentativa de criar seus próprios servos eternos, mas o Feitiço deu horrivelmente errado. Onde os filhos de Osíris receberam vida eterna, pureza e sabedoria, os servos imortais de Set foram dotados apenas de impurezas, regurgitados pelo demônio Ammut e renascidos como Múmias Malignas. A frustração de Set foi destrutiva. Ele culpou seus cria e destruiu todo Setita de Quarta Geração azarado o bastante para estar em sua presença.
Com o tempo, Set devotou adoração às Múmias Malignas, mas sempre ressentiu os fracassos de seus cria na criação delas. Múmias Malignas ainda existem, mas o segredo de sua concepção é algo guardado dentro dos santuários dos templos dos Hierofantes. Poucos desejam irritar Set de modo tão flagrante a ponto de criar novas Múmias Malignas.
As Bruxas de Equidna — certas de uma ruína iminente — não são tão apreensivas. Seus estudos revelam uma rota diferente para dotar seus servos de poder e, em concordância com os Cappadocius de Lázaro, elas legam essa pesquisa aos Setitas egípcios. Com a Feitiçaria da Vida, uma forma de Proto-Múmia Maligna é torcida à vida. Os praticantes arriscam o desagrado de seu fundador ao criar esses servos, mas avaliam a aposta como digna de ser feita.
Sistema: O feiticeiro precisa ter dado os passos necessários de Imbuir com a Graça de Anúbis e manter sob seu jugo um cadáver animado que carregue o fogo de feitos movidos por emoção. Cada sucesso se converte em pontos que o feiticeiro pode atribuir aos Atributos ou Disciplinas da sentinela. Quaisquer Disciplinas concedidas à sentinela precisam estar entre as que o feiticeiro possui. A Proto-Múmia Maligna ainda está sujeita aos caprichos do feiticeiro, mas tentará tarefas intrincadas se sua Inteligência for elevada o bastante para permitir a compreensão de ordens complicadas.
Como em Imbuir com a Graça de Anúbis, o espírito colhido para a criação desta Proto-Múmia Maligna tem consciência de que suas virtudes ou pecados estão sendo roubados. O feiticeiro precisa gastar um ponto de sangue para devolver o feito, ponto em que o cadáver se torna uma sentinela irracional, mantendo as mesmas estatísticas, mas nenhuma liberdade de pensamento nem capacidade de usar Disciplinas.
Atributos: Força 6, Destreza 4, Vigor 6, Carisma 1, Manipulação 1, Aparência 0, Percepção 3, Inteligência 1, Raciocínio 2
Habilidades: Prontidão 3, Esportes 3, Briga 3, Intimidação 4, Liderança 1, Armas Brancas 3, Furtividade 3, Sobrevivência 2, Ocultismo 2, Teologia 1
Disciplinas: Fortitude 2, Potência 2
Força de Vontade: 9
Vitalidade: 12
Notas: Estas são as estatísticas padrão da Proto-Múmia Maligna, antes de os sucessos adicionais serem traduzidos em pontos adicionais. Esses monstros costumam ter uma reserva de dez pontos de sangue e se desfazem em pó depois de usá-los. Eles podem obter mais sangue comendo a carne de um vampiro ou de um mortal. Narradores podem ampliar as estatísticas conforme o feito imbuído no cadáver. Proto-Múmias Malignas podem absorver todo dano, exceto o agravado.]==],
				},
				["The Revelations of Eden"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 64


The Revelations of Eden


Cainitas conhecem os Seguidores de Set por sua duplicidade e destreza em manipulação. Poucos merecem essa reputação mais que os Decadentes de Constantinopla, também conhecidos como os Filhos de Judas. Chamados de hereges pelos Hierofantes, suspeita-se que os Filhos de Judas sejam os próximos alvos de eliminação assim que a queda das Bruxas Teofídias estiver completa.
Apesar de ideologias opostas, talvez seja o desespero compartilhado que force as Bruxas de Equidna a oferecer tutela passageira aos Decadentes. A facção de Khay’tall nunca pediu a ajuda delas, mas a acolheu antes da destruição dele; seus seguidores Setitas assumiram as rédeas das Revelações do Éden na esteira da partida das Bruxas.
Uma Trilha simples em seu cerne, as Revelações do Éden despedaçam a vontade e a fé da vítima, abrindo espaço para que a Serpente do Éden, Sutekh, ou qualquer deus que o feiticeiro escolher, tome o lugar delas. A corrupção máxima encontrada na Trilha vem da submissão voluntária da maioria das vítimas aos seus poderes. Como a Presença, esta Disciplina gera nos seus sujeitos uma sensação de contentamento e desejo.
Iniciar os poderes da Feitiçaria Setita é idêntico ao da Taumaturgia (ver V20 Dark Ages p. 297), exceto que, no lugar de Ocultismo, usa-se Teologia.
Sistema: Um sucesso basta para corroer a Força de Vontade temporária da vítima. Cada sucesso adicional remove mais um ponto de Força de Vontade temporária, e valores mais altos na Trilha conferem efeitos adicionais à vítima. Esses efeitos não são cumulativos. A vítima pode tentar resistir aos efeitos da Disciplina com uma rolagem de Força de Vontade (dificuldade 6). Uma falha crítica do feiticeiro concede à vítima a recuperação de toda a Força de Vontade temporária. Uma falha crítica da vítima força a perda de um ponto de Consciência/Convicção. Este poder não pode ser resistido com o gasto de Força de Vontade temporária. Perdas anotadas como permanentes só podem ser recuperadas pelo torpor ou pela Morte Final do feiticeiro Setita responsável.

• Remova um ponto de Força de Vontade temporária da vítima e um ponto do valor de Força de Vontade dela.

•• Remova da vítima um ponto de Força de Vontade temporária e um ponto do valor do Caminho dela.

••• Remova da vítima um ponto de Força de Vontade temporária e um ponto do Autocontrole/Instinto dela.

•••• Remova da vítima um ponto de Força de Vontade temporária e escolha o novo Comportamento dela.

••••• Remova da vítima um ponto de Força de Vontade temporária e escolha a nova Natureza dela.]==],
				},
				["The Revelations of Midgard"] = {
					pt = [==[Dark Ages Tome of Secrets, pág. 65


The Revelations of Midgard


A história de Arnulf “Jörmungandrsson” é infame entre os Setitas. Um mercador nórdico que virou cultista, carniçal e por fim vampiro, Jörmungandrsson foi Abraçado no Egito com grande pompa e cerimônia. As Bruxas de Equidna previram que seu retorno ao Reino da Noruega geraria uma nova frente na batalha de Tífon contra os Éons. Em vez disso, Jörmungandrsson formou um novo culto dedicado à Serpente de Midgard como um aspecto de Apep; antitético à maioria dos Setitas, mas longe o bastante para não ser destruído de imediato pelos Teofídios. O imbróglio de Jörmungandrsson é um ponto sensível entre os Setitas Ortodoxos, que apagaram depressa o registro do Abraço de Arnulf, mas pouco puderam fazer para suprimir a notícia difundida do filho pródigo que abandonou seu clã.
Por séculos o Salão operou seus cultos em prazerosa isolação em relação aos demais membros do clã, com seus filósofos seguindo uma versão da Trilha de Apep (ver V20 Dark Ages p. 449) que chamam de Trilha de Jörmungandr. Nos últimos anos, membros do culto viajaram para além da Escandinávia e encontraram as Bruxas de Equidna nas Cortes do Amor e nos Feudos da Cruz Negra, sofrendo perseguição da Ortodoxia do clã. Em solidariedade, o Salão concedeu esmolas às Bruxas e, em troca, aprendeu os princípios de uma feitiçaria que chamam de As Revelações de Midgard. As Górgonas ficaram impressionadas com a devoção do Salão aos seus cultistas, vendo nos vampiros nórdicos uma devoção à família outrora compartilhada pelos Setitas do Nilo.
As Revelações de Midgard permitem aos membros do Salão de Jörmungandr recorrer à sua fé interior e, com ela, fortalecer seus carniçais, feras e servos mortais. Embora sua fé seja indiscutivelmente aviltada, os poderes dados a eles pelas Górgonas reforçam a devoção dos seguidores ao culto.
Iniciar os poderes da Feitiçaria Setita é idêntico ao da Taumaturgia (ver V20 Dark Ages p. 297), exceto que, no lugar de Ocultismo, usa-se Teologia.

• Concessão de Escamas
Talvez mais que qualquer clã, os Seguidores de Set valorizam seus cultistas. Muitos veem pouca diferença entre o status de um mortal, um carniçal ou um vampiro a serviço de seu deus. Essa é uma crença que permeia o clã em todas as suas formas variadas. Pelo amor aos seus cultistas, praticantes da Concessão de Escamas podem absorver o dano causado aos seus servos favoritos, que ganham manchas de escamas de serpente sobre a carne que de outro modo teria sido ferida. Essas escamas nunca somem, evidenciando a graça de Set e da Serpente de Midgard.
Sistema: A Concessão de Escamas afeta qualquer criatura viva ou carniçal de quem o Cainita tenha se alimentado, não importa a distância. Quando tal cultista sofre dano, a feiticeira pode reflexivamente aplicar sua resistência morta-viva ao corpo do cultista, transferindo o dano para a vampira. A Cainita pode absorver esse dano do modo normal, embora qualquer dano não absorvido pela vampira seja sofrido pelo cultista. O cultista desenvolve escamas no lugar em que teria sofrido o dano. Conforme a localização, isso pode reduzir o valor de Aparência do cultista, embora os Setitas reconheçam a deformidade como uma bênção. Uma falha crítica neste poder permite à vampira absorver o dano, mas a impede de absorvê-lo com dados.

•• Sofrer por Jormungandr
Acima de tudo, os Seguidores de Set são um clã de fé. A crença inspira em seus portadores a capacidade de realizar grandes feitos, tanto nobres quanto destrutivos. O Salão de Jörmungandr ensina todos os seus cultistas a sofrer por suas crenças; com o sacrifício vem a recompensa. Os que dão de si pela fé certamente receberão recompensa espiritual. Vampiros que usam Sofrer por Jörmungandr põem essa crença à prova, pois, pela própria sobrevivência, infligem ferimentos hediondos aos seus cultistas. Os cultistas que sofrem desse modo ganham traços serpentinos — olhos afilados, nariz achatado, dedos membranosos e perda de cabelo.
Sistema: Quando uma Cainita instruída em Sofrer por Jörmungandr recebe dano físico, ela pode aplicar esse dano a um servo mortal de quem tenha tomado sangue e a quem tenha dado vitae. O cultista precisa estar ao alcance da vista da feiticeira. Sofrer por Jörmungandr é ativado reflexivamente, a menos que a vampira opte por não usá-lo. Para cada sucesso acumulado além do primeiro, a vampira pode infligir um nível adicional do dano que sofreu ao cultista escolhido. O dano adquirido num único turno não pode ser distribuído entre múltiplos cultistas, e qualquer dano que exceda a trilha de vitalidade do cultista volta à vampira para ser absorvido ou sofrido. A manifestação deste poder reduz o valor de Aparência do cultista gradualmente, a critério do Narrador. Uma falha crítica na rolagem deste poder ainda transfere todo o dano a um cultista, mas cada ponto é convertido em agravado, se já não o for.

••• Engolir a Cauda
O Salão de Jörmungandr crê na preeminência da Serpente de Midgard, fadada a ingerir a própria cauda até se erguer e devorar o mundo. Este poder estranho é simbolicamente semelhante ao mito, permitindo ao vampiro repor qualquer sangue derramado em batalha. Seja jorrando de uma lesão, manchando roupas ou empoçado no chão, os feiticeiros conseguem atrair o sangue até si em riachos dançantes. Sabe-se de Setitas que sofrem ferimentos graves, com sua vitae espalhada ao redor, antes de prender os inimigos num olhar hipnótico enquanto o sangue sobre a terra rasteja de volta às suas bocas como cobrinhas. Quaisquer cultistas na presença do Setita que pratica este poder sentem o sangue em suas veias saltar para escapar. Ele não escapa, mas dali em diante os cultistas carregam vasos sanguíneos serpentinos marcando de modo proeminente sua pele.
Sistema: Este poder é sempre ativado como a última ação de um turno, depois das ações de Celeridade. O sangue ao alcance da vista da vampira desliza até ela, levando um turno para chegar à sua boca e repor pontos de sangue perdidos. Fica a critério do Narrador quantos pontos de sangue há na área ao redor, mas cada sucesso rolado permite a um ponto de sangue rastejar até a feiticeira. Numa falha crítica, o poder força a vampira a regurgitar dez pontos de sangue menos o valor de seu Caminho. Este poder não pode ser usado para drenar sangue de um recipiente vivo ou morto-vivo.

•••• Ciclo da Serpente de Midgard
O Salão de Jörmungandr põe a família num pedestal alto. Feiticeiros conhecem a importância de mortais e carniçais; os cultistas sustentam seus esforços. Enquanto drenam sangue do rebanho, os feiticeiros devolvem dons terríveis e pungentes ao culto como prova do agrado de seu deus. Setitas que aprendem o Ciclo da Serpente de Midgard impõem aos seus cultistas um dos maiores dons de magia de sangue possíveis — a capacidade de recorrer às Disciplinas de seus senhores. O Ciclo da Serpente de Midgard permite aos feiticeiros agir vicariamente por meio de seus seguidores, embora não tenham controle sobre como os cultistas usam os poderes concedidos.
Sistema: Um Setita que use este poder pode conceder pontos em Disciplinas a um carniçal que tenha consumido ao menos um ponto de seu sangue. O número de pontos de Disciplina concedidos é igual ao número de sucessos rolados. O poder dura até o próximo pôr do sol. Alguns poderes são perigosos ou mesmo autodestrutivos se um mortal os usar. O Narrador tem a palavra final sobre se um carniçal pode usar uma dada Disciplina.
Para efeito de Disciplinas que exigem o gasto de pontos de sangue para ativar, o carniçal possui um número de pontos de sangue igual aos consumidos do senhor na noite em que o poder é ativado. Uma falha crítica nesta rolagem resulta no carniçal ganhando os pontos em Disciplinas até o próximo pôr do sol, mas o laço de sangue com seu domitor se rompe. O rompimento desse laço não é percebido pelo vampiro.

••••• Transformação de Apep
Para alguns que carregam o sangue de Set, seu epíteto de Seguidores de Set é impreciso. As Bruxas de Equidna chegaram, nos últimos anos, à suspeita de que, embora seu fundador possa ser um semideus monstruoso de poder caprichoso e devastador, o nome Set está incorreto. Fosse o que fosse seu fundador, ele se fez passar por Set, Tífon, Apep e até pela Serpente de Midgard em esforços para obter adoração e adeptos servis. Algo no sangue dessa Mãe dos Monstros se manifesta em Setitas que usam níveis altos de Serpentis para mudar de forma. A Transfiguração de Apep permite a um Setita infligir essa mudança — que as Górgonas alegam ser a verdadeira forma de Set — a um seguidor leal. A mudança é dilacerante e dolorosa, mas o físico glorioso alcançado converte ou consome depressa os descrentes.
Sistema: Este poder só afeta um cultista mortal ou carniçal que tenha bebido o sangue do vampiro feiticeiro. Numa rolagem bem-sucedida, o corpo do cultista passa dez turnos — menos o número de sucessos rolados — se contorcendo e se transformando numa serpente sem membros, com braços e pernas se desprendendo como um amálgama de pele morta, tecido e osso. O cultista de Apep incha até uma forma de serpente com o tamanho aproximado de um cavalo de guerra. Ele não pode falar, mas compreende a língua de seu criador. A mudança em cultista de Apep é permanente. A serpente permanece leal ao vampiro como carniçal bestial, ainda exigindo doses regulares de vitae. Quaisquer poderes das Revelações de Midgard usáveis em seguidores continuam usáveis no cultista de Apep. Uma falha crítica na rolagem para executar este poder mata o cultista e provoca um teste de frenesi na feiticeira, já que ela se depara com um fracasso humilhante de fé.
O cultista de Apep tem as seguintes estatísticas:
Atributos: Força 5, Destreza 5, Vigor 4, Carisma 3, Manipulação 1, Aparência 1, Percepção 3, Inteligência 2, Raciocínio 3
Habilidades: Prontidão 4, Esportes 4, Briga 5, Intimidação 5, Performance 3, Furtividade 4, Sobrevivência 3, Teologia 3
Disciplinas: Fortitude 1, Potência 2, Presença 2
Força de Vontade: 9
Vitalidade: 15, sem penalidades por ferimento
Notas: O cultista de Apep costuma ter uma reserva de dez pontos de sangue e mergulha num estado torpente sem sangue. Eles podem obter mais sangue bebendo de uma vítima. Cultistas de Apep podem absorver todo dano, exceto o agravado. Seu ataque de mordida usa oito dados (Força + 3).]==],
				},
				["The Taking of the Spirit"] = {
					pt = [==[Rites of Blood, pág. 170


The Taking of the Spirit


Ao invocar o poder do Inferno, esta trilha permite ao infernalista despojar a vítima de sua Força de Vontade temporária, deixando um autômato quase sem alma, pronto para servir ao infernalista sem questionar. Alguns vampiros diabólicos construíram legiões inteiras de servos para si com este poder. Esta trilha temível funciona igualmente em vampiros e no rebanho.
Sistema: A infernalista clama em voz alta pelas legiões do Inferno para roubar o espírito de seu alvo e então toca o alvo. Conforme as circunstâncias, o Narrador pode exigir uma rolagem bem-sucedida de Destreza + Briga para que a taumaturga faça contato com a vítima pretendida. Feito o contato, a infernalista precisa travar uma rolagem resistida de Força de Vontade contra o sujeito (dificuldade 8). O sucesso significa que a vítima perde um número de pontos de Força de Vontade igual aos sucessos da infernalista.
Se a vítima acumular mais sucessos nessa rolagem resistida de Força de Vontade antes de ser reduzida a zero de Força de Vontade, ela resiste aos poderes do Inferno. Além disso, o sofrimento suportado endurece sua mente, e esta trilha infernal não pode ser usada contra ela de novo por um ano inteiro.
Se a vítima for reduzida a zero de Força de Vontade, ela precisa cumprir as ordens do vampiro, sem falar, com o olhar vazio à frente, num estado muito parecido com o de um zumbi, até ter recuperado um ponto de Força de Vontade, conforme a tabela abaixo.
Se o infernalista for morto, a vítima recupera toda a Força de Vontade perdida imediatamente.
Uma falha crítica por parte do infernalista tem resultados únicos: Ele perde um número de pontos temporários de Força de Vontade correspondente à sua maestria na dita trilha. Esses pontos de Força de Vontade voltam à razão de um por noite. Se todos os pontos forem perdidos, ele pode cair sob o controle de forças de outro mundo.
A Força de Vontade sugada por este poder retorna a uma taxa determinada pelo nível do infernalista na trilha:

• Retorno de 3 pontos de Força de Vontade por dia de descanso

•• Retorno de 2 pontos de Força de Vontade por dia de descanso

••• Retorno de 1 ponto de Força de Vontade por dia de descanso

•••• Retorno de 1 ponto de Força de Vontade por semana de descanso

••••• Retorno de 1 ponto de Força de Vontade a cada duas semanas de descanso]==],
				},
				["The Transylvanian Kraina"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 275


The Transylvanian Kraina


Koldun da região da Transilvânia praticam as magias a seguir.

• Trono de Burebista
Reza a lenda que o rei Burebista, que aterrorizou os gregos por séculos — primeiro como rei mortal da Dácia, depois como poderoso koldun —, ergueu um grande trono no alto de um pico de montanha de onde podia contemplar todas as suas terras e acompanhar os movimentos de todos os seus inimigos. A lenda é verdadeira, embora com o tempo Burebista já não precisasse do trono para observar seu reino. Ele passou esse segredo aos seus cria, e hoje quase todo koldun da kraina da Transilvânia consegue sentar-se em seu trono.
Sistema: O koldun gasta um ponto de sangue e faz a rolagem de ativação (Atributo: Percepção). Se estiver no alto de qualquer montanha dos Cárpatos, não há necessidade de gastar sangue. Com sucesso, o koldun pode lançar seus sentidos ao alto pelos ares, ou estendê-los para além do corpo; quão longe depende de quantos sucessos forem rolados (ver abaixo). Este efeito dura até o koldun recolher seus sentidos ou até o fim da cena, o que vier primeiro.
1 sucesso — Raio de 50 metros
2 sucessos — Raio de 100 metros
3 sucessos — Raio de 500 metros
4 sucessos — Raio de 1,5 quilômetro
5 sucessos — Raio de dez quilômetros

•• Hospitalidade de Pietrosu
O Monte Pietrosu é o pico mais alto, e mais perigoso, dos Cárpatos, onde os ventos cortantes e as temperaturas gélidas matam um homem desprotegido em meros instantes. Um cenário perfeito para destruir os próprios inimigos. Levar um adversário despreparado até o alto do Pietrosu, porém, é bem difícil; bem mais fácil, raciocinam os koldun, é levar a montanha consigo.
Sistema: O koldun precisa lançar o sangue exigido ao ar (a menos que esteja à vista dos Cárpatos, caso em que nenhum gasto de sangue é necessário) e fazer a rolagem de ativação (Atributo: Destreza). Se obtiver sucesso, um vento poderoso e gélido se ergue ao redor do koldun por um número de turnos igual aos sucessos rolados. Esse vento causa um nível de dano contusivo por turno e entorpece o corpo de qualquer um, exceto o koldun, apanhado dentro dele, reduzindo o deslocamento à metade e as paradas de Destreza em dois. No turno seguinte ao término deste poder, a penalidade de Destreza cai para um e o deslocamento fica em três quartos, e no turno depois desse a vítima recupera Destreza e mobilidade plenas. Um efeito colateral útil deste poder é que o koldun fica imune ao frio e à força do vento enquanto ele estiver ativo; ao cruzar montanhas ou outros ambientes onde o vento seja um risco, basta ativar a Hospitalidade de Pietrosu para se proteger do perigo.

••• As Margens do Bâsca
Quando as chuvas chegam aos Cárpatos, o Bâsca salta suas margens e vilarejos inteiros são levados, junto de qualquer pessoa, viva ou morta, insensata a ponto de não buscar terreno mais alto. O koldun que empunha este poder carrega consigo a força torrencial do Bâsca aonde quer que vá.
Sistema: O koldun libera seu sangue em água corrente — um rio ou riacho é o mais comum, embora um córrego ou mesmo apenas o degelo da neve seja o bastante — e rola para ativar este poder (Atributo: Força). Com sucesso, o sangue reforça o fluxo, fazendo-o inchar e avançar, uma enxurrada dotada de vida mágica. Qualquer pessoa, bem como quase qualquer coisa não fixada ao chão, apanhada em seu caminho será arrastada rumo ao ponto de menor elevação a uma taxa de cem metros por turno, e precisa absorver cinco dados de dano contusivo por turno. Qualquer sujeito de algum modo impedido de ser levado correnteza abaixo — preso contra uma parede ou outro objeto imóvel, por exemplo — sofre o dobro do dano normal. Além disso, mortais precisam fazer uma rolagem de natação (dificuldade 8) a cada turno para evitar engolir grandes goles de água; a falha inflige um nível adicional de dano letal que não pode ser absorvido. Essas águas revoltas duram um número de turnos igual aos sucessos rolados para ativar o poder, ou o dobro desse número se a fonte da enchente for qualquer rio dos Cárpatos.

•••• Exalação de Kupala
Na bacia de Berca, perto do mosteiro ortodoxo oriental de Ratesti, a vegetação deixa de crescer e os gases estranhos do submundo borbulham até o nosso mundo, formando pequenos cones de lama que endurecem rápido enquanto exalam seus bafos gélidos. Alguns koldun aprenderam a invocar esses gases mortíferos para si; alegam ser o próprio bafo de Kupala. Podem estar certos.
Sistema: O koldun gasta sangue, ao menos um ponto mas quanto quiser, e rola para ativar este poder (Atributo: Vigor). Uma vez por turno, por um número de turnos igual aos sucessos rolados, até o limite de quanto sangue foi gasto, ela pode fazer os gases sob o solo irromperem para cima, formando uma cratera vulcânica minúscula. Esses gases são de um frio cortante; qualquer um apanhado num raio de três metros do cone está sujeito ao mesmo dano e às mesmas penalidades da Hospitalidade de Pietrosu. Pior ainda, o gás borbulhante é altamente inflamável; qualquer chama próxima acende o gás numa explosão terrível, infligindo cinco dados de dano letal (agravado para vampiros) a todos ao alcance do cone. Se este poder for ativado dentro da bacia de Berca, cada ponto de sangue gasto conta em dobro.

••••• Medias Inquieta
De tempos em tempos, o solo sob o vilarejo de Medias treme e se revolve, arrancando construções de seus alicerces e às vezes até matando os descuidados. Os locais culpam os deuses, mas os koldun sabem que é Kupala, remexendo-se inquieto em seu túmulo de terra. Os de maior perícia sabem como despertar suas agitações.
Sistema: O koldun gasta um ponto de Força de Vontade além do ponto de sangue e da rolagem de ativação de sempre (Atributo: Força). Se usado à vista dos Cárpatos, nenhum gasto de ponto de sangue é necessário. Cada sucesso permite ao koldun ou afetar uma área maior (ver abaixo) ou prolongar a duração do terremoto. Qualquer um e qualquer coisa apanhados no alcance do abalo estão sujeitos a dez dados de dano letal a cada turno em que permaneçam em sua área de efeito, e precisam fazer uma rolagem de Destreza + Esportes (dificuldade 8) ou serão derrubados. A maioria das casas e estruturas simples desaba depois de um ou dois turnos; estruturas de construção mais robusta, como castelos, permanecem de pé quatro ou cinco turnos antes de serem totalmente destruídas.
1 sucesso — Uma casa ou uma construção pequena
2 sucessos — Várias construções, até cinco
3 sucessos — Uma rua inteira de um povoado ou vilarejo
4 sucessos — Uma estrutura grande, como um castelo
5 sucessos — Um vilarejo inteiro, ou uma parte de uma cidade]==],
				},
				["The Way of Earth"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 448


The Way of Earth


Capaz de grande destruição e de grande cura, a terra é o ventre da vida e o sepulcro da morte. Ela bebe todo sangue derramado com violência sobre seu solo, e assim espelha o vampiro. É pela associação com a terra como fonte de força que um koldun impõe sua vontade.
Atributo: Vigor

• Solo Agarrador
Um koldun que invoca este poder pode ordenar que a terra se erga num jato de barro e suba pelas pernas da vítima. Este poder só comanda solo, não pedra, e só alcança vítimas que estejam pisando a terra.
Sistema: O koldun pode dirigir qualquer trecho de terra num raio de 30 metros para prender um alvo por dois turnos por sucesso rolado. O barro animado sobe e comprime na metade entre os joelhos e os quadris da vítima, mantendo-a presa a menos que o jogador dela obtenha cinco sucessos numa rolagem de Força + Sobrevivência (dificuldade 6). Também é possível usar este poder como ataque, caso em que a terra agarra, esmaga uma vez e solta. Usado assim, cada sucesso na conjuração inflige um nível de dano letal. Tal dano se manifesta como pernas quebradas e pés esmagados.

•• Resistência da Pedra
Puxando a essência da terra para dentro de si, um koldun ganha uma medida da resiliência sobrenatural dela. Sob os efeitos deste poder, a pele do vampiro lembra uma fusão horrível de carne e pedra, que racha e flui de modo impossível a cada movimento.
Sistema: Uma rolagem de ativação bem-sucedida concede ao koldun dois pontos extras de Vigor pelo resto da cena. Esses pontos são considerados parte do Vigor natural do personagem e podem auxiliar em qualquer uso daquele Atributo, inclusive absorção.

••• Terra Faminta
Ampliando o poder de Solo Agarrador, um koldun pode usar este poder para arrastar a vítima para dentro da terra. Basta um gesto e o solo sob a vítima se abre como as fauces de uma grande besta. Este poder pode prender qualquer vítima que pise a terra a até 30 metros do koldun.
Sistema: Como em Solo Agarrador, cada sucesso na rolagem de ativação deixa a vítima imóvel por um turno. Porém, a dificuldade da rolagem de Força + Sobrevivência para se libertar sobe para 8 e ainda exige cinco sucessos. Como a terra continua a se mover e agarrar enquanto o poder durar, essa rolagem precisa ser feita como uma tentativa única (embora repetível), não como um teste prolongado. Além disso, seres presos no fosso esmagador sofrem um nível de dano letal por turno. Seres capazes de absorver esse dano podem fazê-lo, mas com dificuldade 7. Ao fim da duração do poder, a terra se escancara mais uma vez para soltar a vítima.

•••• Raiz da Vitalidade
Como em Terra Faminta, o koldun pode ordenar à terra que soterre qualquer alvo que esteja pisando o solo num raio de 30 metros. Ainda assim, este poder é bem mais benevolente na intenção, ainda que não menos perturbador na manifestação. O solo ondula, abrindo-se e fechando-se como um ventre obsceno enquanto puxa o alvo quase um metro abaixo da superfície. Seres vivos sepultados desse jeito não sufocam, pois o solo encantado bombeia ar de cima em respirações ondulantes. Melhor ainda, a essência fértil da terra pressiona a carne dele e a restaura à saúde. Mesmo assim, o processo é altamente perturbador e antinatural, ainda mais porque os alvos permanecem plenamente conscientes numa imobilidade silenciosa e impotente durante toda a duração. É possível a um koldun curar a si mesmo com este poder.
Sistema: O jogador gasta quantos pontos de sangue quiser (o que pode exigir múltiplos turnos, conforme a Geração) e faz a rolagem de ativação. Cada sucesso permite à terra curar dois níveis de dano contusivo ou um nível de dano letal. Curar dano agravado exige dois sucessos por nível. O total de níveis de vitalidade que podem ser restaurados a cada uso deste poder é o número de pontos de sangue investidos ou o número de sucessos na rolagem de ativação, o que for menor. Qualquer ponto de sangue gasto além do número de sucessos escoa sem efeito. O processo de cura em si leva um turno por nível contusivo, um minuto por nível letal e uma hora por nível agravado. Assim que a cura termina ou o poder é interrompido por escavação determinada, a terra expele o alvo de volta à superfície.

••••• Fúria de Kupala
Mortais rezam com medo quando as montanhas tremem. Eles temem a ira dos Velhos Deuses, e com razão. Este não é um poder usado com leviandade ou capricho, porque representa uma das maiores armas disponíveis à Feitiçaria Koldúnica.
Sistema: Este poder exige um ponto de Força de Vontade além do custo e da rolagem de ativação de sempre. O koldun golpeia a terra com o punho, e sua ira flui pelo solo até qualquer alvo em sua linha de visão. O terremoto irrompe para fora daquele ponto, infligindo 10 dados de dano letal a tudo e a todos na área de efeito. A maioria das estruturas de madeira desaba por inteiro, e mesmo prédios de concreto e aço podem ficar rachados e marcados com dano superficial pelo tremor. O abalo dura um turno e afeta uma área determinada pelo número de sucessos rolados. Não é possível aplicar menos sucessos do que os rolados.
1 sucesso — Uma casa ou uma loja isolada
2 sucessos — Cinco estruturas menores ou um pequeno quarteirão
3 sucessos — Uma rua lateral inteira ou um quarteirão grande
4 sucessos — Vários quarteirões ou uma estrutura grande (como um estádio)
5 sucessos — Um bairro inteiro ou um complexo industrial imenso]==],
				},
				["The Way of Fire"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 452


The Way of Fire


O antigo anátema dos vampiros, o elemento fogo oferece a ferramenta mais poderosa e mais perigosa disponível aos koldun. A Via do Fogo compartilha aspectos com a Via da Terra, no sentido de que se concentra mais em magma e rocha ígnea do que na chama pura e nua.
Atributo: Manipulação

• Coragem Ígnea
Nenhum vampiro domina um elemento que teme, então este poder reduz esse medo a uma mera brasa de sua intensidade anterior.
Sistema: Uma vez aprendido, este poder é permanente e não exige rolagem de ativação nem sangue. O koldun subtrai seu nível na Via do Fogo da dificuldade das rolagens de Coragem para resistir ao Rötschreck causado por exposição ou proximidade a chamas. Este poder não ajuda a resistir ao pânico que acompanha a luz do sol nem a qualquer outra causa além do fogo propriamente dito. Se isso reduzir a dificuldade de uma rolagem de Coragem abaixo de dois, o koldun simplesmente não sucumbe ao Medo Vermelho. Koldun nunca correm risco de Rötschreck por fogo e magma que eles mesmos conjuram.

•• Combustão
Os olhos do Cainita fulguram num laranja vívido de poder feiticeiro enquanto o ar superaquecido se enrola no alvo. Em instantes, o alvo irrompe em chamas espontâneas.
Sistema: Para cada sucesso na rolagem de ativação, o alvo sofre um nível de dano agravado. Este ataque pode ser esquivado, mas não bloqueado, e pode afetar seres vivos (ou mortos-vivos) com +2 de dificuldade. Só é possível fazer um ataque ígneo por turno.

••• Muralha de Magma
O koldun ergue a mão e a terra se parte, jorrando uma muralha de magma incandescente de 3 metros de altura. Normalmente essa muralha forma um círculo de 3 metros de raio ao redor do vampiro, embora o feiticeiro possa erguer outras formas com prática e perícia.
Sistema: A muralha de magma invocada com este poder tem duração de dois turnos por sucesso rolado. Se o koldun quiser liberar o magma numa forma diferente do círculo protetor, aumente a dificuldade base em um. Personagens não conseguem se aproximar de uma muralha de rocha derretida sem uma rolagem de Coragem (dificuldade 8), e mesmo assim o calor escaldante de perto inflige um nível de dano agravado. O contato efetivo com a lava eleva o dano a três níveis e sobe a dificuldade de absorção para 9, supondo que algum tipo de absorção seja possível. O koldun não sofre dano pela proximidade do magma invocado (embora o contato com ele ainda o fira normalmente).

•••• Onda de Calor
O koldun age como conduto de gêiseres de vapor e canaliza uma rajada de ar dessecante contra uma vítima em sua linha de visão. Esse vento ígneo aparece como uma onda de calor ondulante envolvendo a vítima. Indivíduos mortos por este poder medonho ficam com aparência de cascas ressecadas e mumificadas.
Sistema: Numa rolagem de ativação bem-sucedida, a vítima sofre cinco níveis de dano letal, que podem ser absorvidos por seres capazes disso. Alvos vampiros também perdem cinco pontos de sangue, independentemente do dano infligido.

••••• Explosão Vulcânica
No domínio final da Via do Fogo, um koldun ordena que a lava exploda do chão num gêiser imenso. A rocha derretida se espalha por uma faixa ampla antes de despencar na terra e fluir em todas as direções. Tudo no caminho da rocha derretida queima, derrete ou vaporiza em instantes. O conjurador pode dirigir a erupção de lava a qualquer ponto de sua linha de visão.
Sistema: Este poder custa um ponto de Força de Vontade além de um ponto de sangue. Para cada sucesso na rolagem de ativação, a explosão inicial de lava dura um turno. Os rios de rocha líquida ardente então fluem lentamente pelo dobro dessa duração antes de esfriar e endurecer de repente. Mesmo que um objeto sobreviva ao calor, ele agora fica preso sob a rocha. Qualquer coisa que entre em contato com a lava (inclusive o koldun) sofre no mínimo três níveis de dano agravado. Para objetos que não têm níveis de vitalidade, o Narrador precisa decidir quantos turnos eles duram antes de derreter ou irromper em seu próprio inferno. Uma falha crítica neste poder abre o gêiser de lava sob um alvo não pretendido, possivelmente o próprio koldun.]==],
				},
				["The Way of Sorrows"] = {
					pt = [==[Rites of Blood, pág. 157


The Way of Sorrows


Embora faça parte da escola Koldúnica mais ampla, esta Trilha não depende abertamente de uma conexão direta com Kupala. Em vez disso, ela invoca uma série de maldições em nome de várias divindades eslavas pré-cristãs. Por outro lado, alguns estudiosos Tzimisce especulam que ao menos algumas dessas divindades sejam elas próprias meros aspectos do ser que se autodenomina Kupala. Todos esses efeitos exigem que o koldun consiga perceber o alvo diretamente. Em geral não podem ser usados à distância por magia simpática, mas podem ser usados contra um alvo distante que o koldun consiga perceber por poderes como A Via do Espírito ou Vidência (p. 153).
Mecânica de dados da Feitiçaria Koldúnica (Rites of Blood p. 156): a rolagem para ativar uma Trilha de Feitiçaria Koldúnica é uma rolagem de Força de Vontade com dificuldade igual a (3 + nível da Trilha), e cada rolagem dessas também exige o gasto de um ponto de sangue. A rolagem para ativar um ritual de Feitiçaria Koldúnica é Inteligência + Ocultismo com dificuldade igual a 3 + o nível do ritual. Estas regras substituem as de V20. As conexões metafísicas da escola com Kupala e com as terras permeadas por esse espírito aumentam a dificuldade em +1 em todas as rolagens de Feitiçaria Koldúnica feitas em favor de koldun que operam sua magia fora dos territórios da Europa Oriental.

• As Frustrações de Nestrecha
O koldun pode destruir a determinação de seu inimigo, instilando sentimentos de pessimismo e desesperança.
Sistema: Por um turno por sucesso, o alvo não pode gastar Força de Vontade para nenhuma finalidade.

•• Os Insultos de Krivda
O koldun desfere um insulto odioso contra seu adversário, provocando nele uma ira irracional.
Sistema: Em resposta ao insulto, o alvo precisa rolar imediatamente Autocontrole para resistir ao frenesi contra uma dificuldade de 5 + o número de sucessos na rolagem de ativação, dificuldade máxima 9.

••• O Pranto de Kruchina
O koldun pode instilar em seu inimigo um desespero esmagador ou uma depressão quase suicida.
Sistema: Por um turno por sucesso, o alvo é dominado por uma tristeza intensa e chora incontrolavelmente. Ele não pode se envolver em nenhuma ação que exija concentração, e um Membro perde um ponto de sangue a cada turno enquanto a vitae escorre de seus olhos.

•••• O Infortúnio de Chernogolov
O koldun escarnece de seu inimigo com uma previsão de ruína certa, que então se cumpre.
Sistema: O alvo perde automaticamente dois sucessos em toda rolagem que tentar. O efeito dura por um número de rolagens consecutivas igual aos sucessos rolados.

••••• A Inanição de Marena
O koldun pode agora infligir dano direto ao seu inimigo na forma de frio cortante e fome faminta.
Sistema: Para cada sucesso, o alvo sofre dois níveis de dano contusivo que podem ser absorvidos normalmente. Além disso, um vampiro alvejado por este poder perde um ponto de sangue por sucesso.]==],
				},
				["The Way of Water"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 450


The Way of Water


Praticada em grande parte por koldun com refúgios perto de uma grande fonte de água, esta via pode erguer escravos espirituais aquáticos e reduzir um navio a lascas. De modo mais sutil, o vampiro pode espreitar nas profundezas ou conjurar ilusões para confundir e deslumbrar seus inimigos.
Atributo: Raciocínio

• Poça de Mentiras
Este poder versátil cria ilusões tridimensionais sobre a superfície de uma fonte de água. Como o koldun usa tais ilusões depende do temperamento e da vontade dele. É tão fácil forjar uma visitação divina quanto uma sedução astuta.
Sistema: Com uma rolagem de ativação bem-sucedida, o koldun pode projetar uma ilusão sobre qualquer superfície de água em sua linha de visão. A ilusão pode falar e se mover como o vampiro quiser, embora não tenha substância e não possa sair dos limites da água. O fantasma dura um turno por sucesso rolado, após o que se dissipa lentamente numa névoa fina. É possível estender essa duração com ativações subsequentes do poder, que se acumulam na determinação da duração final. Rolagens para estender a duração de uma ilusão somam um à dificuldade base, mas não exigem sangue. Uma vez que a ilusão se desfaz, ela precisa ser conjurada de novo.

•• Refúgio Aquático
Assim como os Gangrel se fundem à terra, também o koldun com este poder pode afundar sob a água para escapar do sol. O vampiro não tanto submerge quanto se funde com a água. Embora sua forma adormecida possa ficar visível de ângulos estranhos vista de cima, só o esparramar mais determinado consegue perturbar seu descanso.
Sistema: Este poder não exige sangue. Se o jogador obtiver dois ou mais sucessos na rolagem de ativação, o vampiro afunda na água conforme o poder de Metamorfose Fusão com a Terra. Um corpo d’água precisa ter ao menos sessenta centímetros de profundidade e ser tão grande nas outras dimensões quanto o corpo do vampiro para contê-lo. Vislumbrar um koldun oculto na água exige uma rolagem bem-sucedida de Percepção + Prontidão (dificuldade 8).

••• Névoa Sobre o Mar
Movendo-se com a graça antinatural de um fantasma, um koldun que empregue este poder pode caminhar sobre a água tão prontamente quanto sobre a terra, sem deixar sequer uma ondulação a marcar sua passagem. Alguns vampiros se deleitam em usar este poder em conjunto com Poça de Mentiras para conjurar fantasmas que os acompanhem.
Sistema: Para cada sucesso na rolagem de ativação, o koldun pode andar sobre a água por uma cena ou uma hora, o que for mais longo. O koldun pode optar por abandonar os efeitos deste poder para submergir ou nadar; porém, o vampiro não pode voltar a andar sobre a água a menos que reative o poder.

•••• Lacaios das Profundezas
Pingando seu sangue num corpo d’água, o koldun pode invocar ou despertar elementais de água encarnados para servi-lo por uma noite. Tais lacaios são infalivelmente leais, ainda que não especialmente espertos. Apesar da forma líquida, são sólidos o bastante para agarrar um homem e arrastá-lo a um túmulo aquático ou espancá-lo como a arrebentação.
Sistema: O jogador gasta um ponto de Força de Vontade e faz a rolagem de ativação padrão. Com sucesso, o jogador pode gastar sangue para invocar lacaios elementais. Esse sangue precisa ser pingado ou lançado num corpo d’água, o que pode exigir múltiplos turnos conforme os limites de gasto de sangue por Geração.
Assim que a última gota de sangue cai, a água se ergue na forma que o koldun desejar. O conjurador pode criar tantos lacaios quantos forem os pontos de sangue gastos, mas nunca mais do que o total de sucessos rolados. Independentemente da forma, os espíritos têm valor igual ao Raciocínio do vampiro em todos os Traços. Esses seres não têm Conhecimentos e nenhuma Perícia além de Furtividade. Além disso, seus Atributos Mentais e Sociais são considerados como valor 1, exceto em situações passivas ou defensivas (como resistir a persuasão ou controle mental).
Elementais de água absorvem e sofrem dano como vampiros, inclusive de luz solar. O fogo os fere menos, infligindo apenas dano contusivo. Ademais, as criaturas aquosas podem extinguir chamas com seus corpos líquidos, embora não sem sofrer ferimento. Um elemental que deixa o corpo d’água que o gerou sofre um nível de dano agravado por hora. Lacaios regeneram um nível de dano de qualquer tipo (inclusive agravado) a cada turno em que permaneçam em contato com um grande corpo d’água, mas fora isso não se curam. A menos que sejam destruídos, lacaios invocados duram até o amanhecer seguinte, quando desabam em poças inanimadas.

••••• Maré da Perdição
Muitos navios jazem no fundo do Mar Negro, despedaçados pelos redemoinhos dos koldun. Vítimas deste poder precisam lutar com cada grama de sua força ou cair nas profundezas rodopiantes e sem ar lá embaixo.
Sistema: O jogador gasta um ponto de Força de Vontade além do sangue de sempre. Para cada sucesso na rolagem de ativação, o redemoinho resultante tem raio de 1,5 metro, centrado em qualquer ponto da linha de visão do vampiro. Redemoinhos têm Força base 15, aumentando em 5 pontos por sucesso após o primeiro. Vítimas precisam se opor com êxito a essa Força usando a própria Força + Sobrevivência (dificuldade 8) para se libertar. As que falham são sugadas às profundezas e golpeadas por correntes esmagadoras. Seres vivos se afogam normalmente, enquanto vampiros e outras criaturas que não respiram simplesmente ficam presos, impotentes, no vórtice. Este poder dura uma cena.]==],
				},
				["The Way of Wind"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 449


The Way of Wind


Mais sutil que o domínio sobre a terra, esta via evoca o ar no fôlego dos vivos e no último estertor de um moribundo. Em quietude ou em movimento, os koldun voltam todos os aspectos do ar ao seu desígnio morto-vivo.
Atributo: Percepção

• Sopro de Sussurros
Mesmo ausentes, os koldun instilam medo profundo em seus servos. Este poder leva as palavras do vampiro numa brisa leve e retorna com a resposta do alvo. Basta ao vampiro dirigir-se ao alvo pelo nome e imitar com força uma exalação profunda enquanto profere a mensagem.
Sistema: Toda vez que o koldun quiser enviar uma nova mensagem por este poder, seu jogador faz a rolagem de ativação de sempre. Porém, o jogador só precisa gastar sangue na primeira vez em que o poder é usado numa dada cena. Cada sucesso permite um turno de fala. Depois que o vampiro conclui a mensagem, ventos velozes a levam ao destino. Em até um minuto, o alvo ouve o koldun como se o vampiro sussurrasse em seu ouvido. Ele pode responder ou permanecer calado, mas tudo o que disser dentro de um número de turnos igual aos sucessos do koldun voa de volta ao koldun. Este poder pode levar palavras a qualquer um a até um quilômetro e meio que não esteja num cômodo vedado. Ao usar este poder, o koldun precisa se concentrar plenamente. Qualquer perturbação rompe a comunicação.

•• Vendaval Cortante
Koldun vingativos buscaram invocar um vento tão gélido quanto o ar no alto dos Montes Cárpatos. Este poder alcança esse fim, desencadeando um vento cortante capaz de congelar o sangue de um homem nas veias enquanto redemoinha por uma área à escolha do conjurador. Além das aplicações óbvias em combate, este poder também facilita uma entrada dramática para os que apreciam tal coisa.
Sistema: Com uma rolagem de ativação bem-sucedida, o koldun invoca um vento congelante num raio máximo de 100 metros. Qualquer um apanhado nessa rajada gélida sofre um dado de dano contusivo por turno (que pode ser absorvido normalmente), perde dois dados de todas as paradas de Destreza e se move à metade da velocidade normal. Os ventos duram enquanto o koldun quiser, desde que ele mantenha a concentração. Qualquer ação não reflexiva por parte do vampiro faz os ventos cessarem e se dissiparem. Isso inclui qualquer movimento.

••• Brisa da Letargia
Embora não induzam sono imediato, os ventos evocados por este poder trazem exaustão crescente e um cansaço entorpecente por cada músculo. Vítimas deste poder muitas vezes sentem um traço de fumaça agridoce antes de cair em transe.
Sistema: Por dois turnos por sucesso, o koldun cria um vento que inflige letargia extrema num raio de 60 metros. Jogadores de personagens apanhados nesse vento precisam rolar Vigor + Sobrevivência (dificuldade 8). Essa rolagem é feita uma vez a cada dez minutos de exposição. A falha significa que o personagem reduz à metade todas as paradas de dados que envolvam ações físicas pelo restante da duração do vento e reduz à metade todos os deslocamentos pela cena. Uma falha crítica faz o personagem adormecer (ou entrar em torpor leve, no caso de vampiros) pela cena. Personagens adormecidos acordam se cutucados, sacudidos ou de outro modo manuseados, embora se movam devagar e possam sofrer paradas de dados reduzidas à metade se o vento persistir.

•••• Cavalgar a Tempestade
Um koldun que empregue este poder se move a velocidades incríveis enquanto cavalga os ventos. Ao viajar com este poder, o vampiro assume uma forma borrada que se recompõe quando ele alcança o destino.
Sistema: Com uma rolagem de ativação bem-sucedida, o koldun se dissolve no vento e voa a 400 km/h até seu destino. Este poder não funciona de modo eficaz em cavernas, prédios ou outras áreas fechadas. Ao ar livre, o voo do vampiro contorna todos os obstáculos. Assim que o koldun chega ao destino ou a cena termina, o vampiro desce à terra e se solidifica.

••••• Tempestade
Aplicando uma fúria ampliada por sangue e vontade, o koldun pode projetar toda a medida de sua ira ao céu noturno. Nuvens cinzentas revoltas apagam estrelas e lua, desencadeando rajadas espiraladas e um aguaceiro de chuva gelada. Relâmpagos riscam o alto, e cada clarão trovejante lança sombras recortadas.
Sistema: Com uma rolagem de ativação bem-sucedida e um ponto de Força de Vontade (além do sangue de sempre), o koldun pode conjurar uma tempestade terrível. Levam-se seis horas para as nuvens se juntarem e adensarem no alto, menos uma hora para cada sucesso rolado. Se isso resultar numa duração inferior a uma hora, as nuvens desabrocham para fora direto de cima como um dossel negro, enchendo o céu em meros minutos. Assim que as nuvens se formam, a chuva começa a cair em torrentes e os relâmpagos começam. A tempestade persiste em plena força por uma hora por sucesso rolado. Ela se dissipa gradualmente ao longo da hora seguinte. No auge de sua fúria, a tempestade pode causar enchentes e certamente gela até os ossos qualquer mortal exposto (1 dado de dano contusivo inabsorvível a cada cinco minutos de exposição plena). Raios caem com regularidade, muito mais do que numa tempestade comum. De fato, ao custo de um ponto de Força de Vontade, o koldun pode dirigir um raio contra um inimigo usando Percepção + Ocultismo (dificuldade 6). Um golpe bem-sucedido inflige 10 dados de dano letal (que podem ser absorvidos normalmente). Só um ataque desses pode ser feito por turno.]==],
				},
				["The Way of the Spirit"] = {
					pt = [==[Rites of Blood, pág. 156


The Way of the Spirit


Esta Trilha raramente é encontrada fora dos Tzimisce do Clã Antigo, cujos membros ainda espreitam as mesmas terras ancestrais de seus senhores e dos senhores de seus senhores. Mas ela tem utilidade até para os Tzimisce do Sabá, e assim seu conhecimento se espalha inclusive entre companheiros de clã mais cosmopolitas. A trilha permite ao koldun difundir suas percepções por uma área cada vez maior. Se a magia for realizada corretamente, o koldun consegue perceber potencialmente tudo o que ocorre na área afetada (que pode ter muitos quilômetros quadrados), embora abrir-se plenamente a tal consciência seja perigoso para todos, menos para os koldun de vontade mais forte. Em vez disso, a maioria limita reflexivamente suas percepções a “todos os intrusos” ou “todos os recipientes potenciais de alimentação”, conforme desejar, e mesmo o koldun mais perceptivo pode deixar escapar algo importante se o tiver excluído sem querer de seu olhar. Enquanto o poder estiver ativo, o koldun também pode ter como alvo qualquer local ou pessoa que perceba, usando qualquer outro poder ou ritual de Trilha Koldúnica, desde que o nível do poder ou ritual da Trilha não exceda o nível do koldun em A Via do Espírito. Este poder também derrota o uso de Ofuscação por qualquer Membro dentro da área de efeito.
Mecânica de dados da Feitiçaria Koldúnica (Rites of Blood p. 156): a rolagem para ativar uma Trilha de Feitiçaria Koldúnica é uma rolagem de Força de Vontade com dificuldade igual a (3 + nível da Trilha), e cada rolagem dessas também exige o gasto de um ponto de sangue. A rolagem para ativar um ritual de Feitiçaria Koldúnica é Inteligência + Ocultismo com dificuldade igual a 3 + o nível do ritual. Estas regras substituem as de V20. As conexões metafísicas da escola com Kupala e com as terras permeadas por esse espírito aumentam a dificuldade em +1 em todas as rolagens de Feitiçaria Koldúnica feitas em favor de koldun que operam sua magia fora dos territórios da Europa Oriental.

• O koldun consegue perceber tudo num raio de 20 metros.

•• ... num raio de 100 metros.

••• ... num raio de meio quilômetro.

•••• ... num raio de 1,5 quilômetro.

••••• ... num raio de oito quilômetros.

Sistema: O número de sucessos na rolagem de ativação determina por quantas cenas sucessivas o efeito dura. Se ativado antes de o sol nascer, a consciência do koldun pode se estender pelas horas de luz, e o koldun não sofre efeitos negativos por monitorar suas terras durante o dia. Ele ainda sofre as penalidades usuais de dados por realizar quaisquer outras ações durante o dia.]==],
				},
				["Ushabti"] = {
					pt = [==[Rites of Blood, pág. 163


Ushabti


Ushabti deriva seu nome das estatuetas confeccionadas para os túmulos dos ricos e poderosos no antigo Egito. Acreditava-se que tais estatuetas ganhariam vida no Mundo Inferior para servir a seus senhores como trabalhadores ou brinquedos. Cada aplicação desta Trilha cria um ushabti diferente, e cada ushabti só pode ser ativado uma vez. O feiticeiro precisa forjar a estatueta em cera ou argila misturada a um ponto de sangue. Depois, precisa entalhar palavras de poder egípcias na estatueta antes de banhá-la em mel e cerveja. Ativar uma estatueta exige que o feiticeiro gaste um ponto de sangue e recite uma encantação, e o jogador rola Força de Vontade para determinar se o ushabti ativa. Se ativar, a estatueta se expande numa figura animada em tamanho natural que obedece à vontade do feiticeiro. No caso de uma falha crítica, além dos efeitos normais, o ushabti ativa, mas fica hostil ao feiticeiro.
Ushabti ativados têm Atributos e Habilidades determinados pelo nível da trilha usado para criá-los. O feiticeiro não pode conceder a um ushabti Habilidades que ele mesmo não tenha, nem valores de Habilidade maiores que os seus. Os sucessos na rolagem de Força de Vontade determinam quão realista é o ushabti ativado. Porém, os sucessos aplicados ao “realismo” nunca podem exceder o nível de trilha usado. Assim, só um ushabti criado com o Dom de Khnum (Ushabti •••••) pode ser indistinguível de uma criatura viva.
1 sucesso — Uma coisa tosca, obviamente feita de cera.
2 sucessos — Tão realista quanto uma figura de cera bem-feita ou uma boneca de porcelana.
3 sucessos — Verossímil o bastante para enganar um observador casual (dificuldade 6 para detectar como falso)
4 sucessos — Extremamente verossímil (dificuldade 8 para detectar como irreal)
5 sucessos — Indistinguível de uma criatura viva
Uma vez ativado, o ushabti perdura por um mês lunar, mas isso pode ser estendido indefinidamente ao custo de um ponto de sangue por mês adicional. Porém, isso pressupõe que o ushabti permaneça dentro do refúgio de seu senhor e não interaja com mortais. Se essas condições forem rompidas, o ushabti se degrada em nada dentro de uma hora. Um feiticeiro pode confeccionar um ushabti para uso de outro, mas fazê-lo lhe custa um ponto de Força de Vontade.

• Trabalhador
O ushabti pode ser um humano ou um animal. É irracional e obedece a todas as ordens de seu senhor. Tem dois pontos em cada Atributo Físico, um ponto em cada Atributo Mental e nenhum ponto em Atributo Social. Não tem Habilidades.

•• Servidor
Ao Trabalhador, some três pontos adicionais de Atributo. Nenhum pode ser aplicado a Atributo Social, e nenhum Atributo Mental pode subir acima de 2. Some dois pontos de Habilidades não combativas.

••• Guarda
Ao Trabalhador, some seis pontos de Atributos e quatro pontos de Habilidades. Guardas podem ter Atributos Sociais, mas nenhum Atributo Social ou Mental pode exceder 2, nem qualquer Habilidade.

•••• Supervisor
Ao Trabalhador, some nove pontos de Atributos e seis pontos de Habilidades; nenhum Atributo Social ou Mental pode exceder 3, nem qualquer Habilidade.

••••• Dom de Khnum
A expressão máxima desta arte, o Dom de Khnum (o lendário criador da humanidade segundo a tradição egípcia) permite ao feiticeiro criar o que é, na prática, um corpo vivo, seja como escravo obediente, seja como recipiente pronto para um espectro ou espírito. A personagem que ativa o ushabti decide qual, embora a segunda opção exija que ela tenha à mão um espectro ou espírito complacente.
Ao Trabalhador básico, some 12 pontos de Atributos e oito pontos de Habilidades. O ushabti ganha as Virtudes, a Humanidade e a Força de Vontade de um vampiro iniciante. Ele é senciente, mas emocionalmente ligado a quem o ativa como se por laço de sangue. Isso vale mesmo se um espírito ou espectro o possuir. Cada uso do Dom de Khnum custa dois pontos de Força de Vontade no momento da ativação, e o jogador pode gastar pontos adicionais de Força de Vontade para obter sucessos automáticos na rolagem de ativação. Um ushabti criado com esta Trilha não se degrada, a menos que alguém conteste ativamente sua identidade e o convença de que ele não é real. Na ausência de prova de sua própria irrealidade, o ushabti é efetivamente imortal.]==],
				},
				["Vitreous Path"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 174


Vitreous Path


A Trilha Vítrea permite ao necromante controlar e influenciar as energias relativas à morte. Esta trilha extremamente rara manipula a entropia, uma força que mesmo a maioria dos necromantes sente desconforto em manejar. Um desenvolvimento da linhagem Nagaraja (p. 406, embora eles às vezes chamem a trilha de “Niilística”), a Trilha Vítrea é um complemento formidável ao ofício necromântico, e os obcecados pelo domínio sobre a morte e as almas — como os Arautos dos Crânios — certamente arriscariam muito para desvendar os segredos desta trilha.
Como a maioria dos necromantes, os Nagaraja em geral aprendem a Trilha do Sepulcro antes de qualquer outra. A Trilha Vítrea costuma ser seu segundo foco de estudo.

• Olhos dos Mortos
O necromante que emprega os Olhos dos Mortos consegue ver com as percepções dos Mortos Inquietos (chamada Visão da Morte). Para tal manipulador de energias fantasmagóricas, as auras dos seres ao redor emitem indícios reveladores de sua saúde e até de seu destino final; o necromante enxerga as energias da morte fluindo por todos, assim como os fantasmas enxergam. Ao observar as marcas entrópicas no corpo de uma pessoa, o necromante obtém um conhecimento aproximado de quão longe da morte ela está, quão cedo é provável que morra e até qual será provavelmente a causa de sua morte. A informação assim obtida não é nem de longe exata, mas dá ao necromante uma vantagem sobre quem ele examina.
Sistema: O jogador rola Percepção + Ocultismo, dificuldade 6. Um sucesso permite ao necromante determinar se alguém está ferido, doente ou morrendo, bem como se o indivíduo padece sob algum tipo de maldição ou magia maligna.
Além disso, o vampiro pode adivinhar o falecimento futuro do alvo, conforme os sucessos obtidos. Um sucesso significa que o personagem consegue estimar quanto tempo de vida o alvo tem, com margem de algumas semanas. Três sucessos significam que o personagem consegue estimar quanto tempo de vida o alvo tem e qual será a provável origem da morte, pois as marcas entrópicas mostram os ferimentos que um dia existirão naquela pessoa. Cinco sucessos significam que o personagem consegue de fato ver onde e quando o evento ocorrerá, interpretando as marcas negras na alma do alvo.
Esta capacidade dura uma cena, embora o necromante possa optar por encerrar o poder antes. Ela só pode ser usada para ler o destino de um alvo por vez. Narradores devem exercer bom senso com este poder, já que as marcas da morte costumam ser inevitáveis. Ele pode decidir rolar os dados por conta própria, de modo que a jogadora não tenha como saber se sua intuição está correta.

•• Aura de Decadência
O necromante pode intensificar a sensação de entropia ao seu redor a ponto de ela decompor objetos não vivos e máquinas. Ela pode retorcer madeira, enferrujar metal, trincar chips de silício e corroer plástico, vidro e matéria orgânica morta. Este poder tem alcance de um metro a partir do corpo do necromante, mas todos na presença do vampiro sentem sua corrupção como um vento gelado.
Sistema: Nenhuma rolagem é exigida, mas este poder custa ao menos um ponto de sangue. Objetos submetidos a esta Aura de Decadência se decompõem e se tornam inúteis depois de alvejados. Como o objeto cede, bem como o mecanismo exato da falha, cabe ao Narrador. Corrosão, fadiga de metal ou pura fragilidade são todas igualmente plausíveis para a ruína de um dado item, mas o efeito em jogo de usar um item condenado é como se o personagem dono dele tivesse rolado uma falha crítica. A velocidade com que o item se decompõe depende de quantos pontos de sangue são gastos.
Um ponto de sangue — Uma semana
Dois pontos de sangue — Um dia
Três pontos de sangue — Fim da cena
Quatro pontos de sangue — Cinco turnos
Cinco pontos de sangue — Um turno
Note que, como este poder exige o gasto de pontos de sangue, o personagem não pode causar uma Aura de Decadência enquanto estiver estacado.

••• Banquete de Almas
Assim como o necromante pode liberar energias entrópicas de dentro de si, ele também pode puxá-las para si como fonte de poder. O Banquete de Almas permite ao conjurador ou extrair as energias da morte ambientes ao redor, ou se alimentar ativamente de um fantasma, roubando a substância do espectro e transformando misticamente essa energia em sustento.
Sistema: O jogador gasta um ponto de Força de Vontade para permitir ao vampiro se alimentar das energias negativas dos mortos. Se a personagem estiver extraindo as energias da atmosfera, ela precisa estar num lugar onde tenha ocorrido uma morte na última hora ou num lugar onde a morte seja comum, como um cemitério, um necrotério ou a cena de um assassinato recente. Em geral, o necromante consegue extrair de um a quatro pontos de entropia de tal local, embora a dificuldade para usar toda Necromancia e poderes mortíferos semelhantes dentro daquela área aumente em valor igual por um número de noites igual aos pontos tomados. As energias de tal área só podem ser drenadas uma vez, até que a entropia do lugar se reponha.
Nos casos em que o necromante se alimenta de um fantasma, o vampiro precisa de fato atacar o espectro como se estivesse se alimentando normalmente. Espectros têm até 10 “pontos de sangue” que podem lhes ser tomados, e eles ficam cada vez menos substanciais à medida que sua essência espiritual escoa. A personagem fica vulnerável a qualquer ataque que o fantasma possa fazer, mesmo aqueles que normalmente não afetam o mundo físico; enquanto se alimenta, o vampiro está essencialmente num meio-estado, existindo ao mesmo tempo nas terras dos vivos e no Mundo Inferior. O espectro assim atacado é considerado imobilizado e não pode correr nem escapar, a menos que consiga derrotar o vampiro numa rolagem resistida de Força de Vontade (dificuldade 6 para ambos os lados). Este poder também pode ser usado em conjunto com a Necromancia da Trilha das Cinzas, permitindo ao vampiro drenar poder (embora não sustento) de fantasmas enquanto viaja pelas terras dos mortos.
Essa energia de alma pode ser usada exatamente como sangue em todos os aspectos, exceto quando o vampiro se ergue para a noite. Ela pode ativar Disciplinas, curar ferimentos, elevar Atributos etc. Uma falha crítica neste poder deixa o vampiro incapaz de se alimentar através da Mortalha pelo resto da noite. Porém, ele permanece suscetível aos assaltos de fantasmas e espíritos por vários turnos (em geral, um número de turnos igual à quantidade de energia que poderia ter sido extraída da área, ou um turno se estivesse atacando um fantasma) enquanto paira entre os mundos, incapaz de funcionar de modo eficaz em qualquer um deles.

•••• Sopro de Thanatos
O Sopro de Thanatos permite ao necromante extrair energia entrópica e concentrá-la sobre uma área ou pessoa, tomando fôlego fundo e então exalando com força uma névoa de energia necromântica. Essa nuvem de virulência é completamente invisível a qualquer um sem a capacidade de ver a passagem da entropia. A energia dessa nuvem é como um farol para Espectros, e eles são atraídos à força entrópica como mariposas à chama.
Uma vez extraída a energia do corpo do necromante, ele pode dispersá-la por uma área grande como isca para Espectros, ou usar a névoa para fins mais sinistros. Canalizada num objeto ou pessoa, a névoa da morte inflige ao sujeito uma doença debilitante e consumptiva. Além disso, as energias concentradas são maculadas e sinistras e, embora em geral invisíveis (exceto a poderes como Percepção da Aura), tendem a fazer pessoas e animais se sentirem desconfortáveis perto da vítima.
Sistema: O jogador gasta um ponto de sangue e rola Força de Vontade (dificuldade 8). Só um sucesso é necessário para extrair o Sopro de Thanatos. Se dispersadas para invocar Espectros, as energias cobrem cerca de 400 metros de raio, centradas no necromante. O alcance aumenta em mais 400 metros para cada ponto de sangue adicional gasto.
Espectros invocados por este poder ignoram o necromante invocador pela duração do poder, a menos que sejam provocados, mas podem muito bem fazer questão de causar estrago em qualquer outra pessoa nas redondezas. O necromante pode então usar outros poderes de Necromancia (como os da Trilha do Sepulcro) para manipular e afetar esses Espectros. Fantasmas assim alvejados podem então interagir com o necromante normalmente, embora os demais Espectros da área continuem a ignorar tanto o vampiro quanto o fantasma alvejado. Essa energia se dispersa depois de uma cena, após a qual os Espectros partem em busca de nova presa. As regras de Espectros estão na p. 385.
Se a nuvem for dirigida a um alvo específico, o necromante precisa ou tocar o alvo ou dirigir o jato de entropia usando Destreza + Ocultismo (dificuldade 7). Um alvo carregado de entropia sofre um (e apenas um) nível de dano agravado; isso em geral se manifesta como doença ou decomposição súbita. As dificuldades sociais do alvo ao interagir com quem não está familiarizado com o toque da morte — a maioria dos humanos normais, bem como algumas criaturas sobrenaturais — aumentam em 2. Além disso, percepções sobrenaturais indicam que o alvo está maculado de decadência, o que pode ser perigoso. Essa forma de mácula dura até o nascer do sol; uma vítima já assolada por este poder não pode ser afetada de novo até que a névoa de entropia anterior tenha se dispersado.
Uma falha crítica na rolagem para controlar este poder indica que o vampiro voltou a energia contra si mesmo e sofre todos os efeitos do sopro vitriólico. Isso inflige o ferimento de sempre e pode sujeitar o necromante à atenção possivelmente perigosa de Espectros provocados e outras criaturas de além-túmulo.

••••• Grito Noturno
O sopro de energia entrópica se torna um grito de puro caos. O necromante pode emitir um brado sobrenatural (ouvido tanto no mundo dos vivos quanto nas Terras das Sombras). O uivo derrama olvido gélido num alvo ou grupo de alvos — ou varrendo a entropia inerente, ou recolhendo essa destruição e desencadeando-a.
Sistema: O vampiro escolhe um número de alvos dentro de um metro por ponto de Necromancia e invoca o Grito Noturno com um berro terrível. O jogador gasta um ponto de Força de Vontade e um ponto de sangue para cada alvo além do primeiro. (Ou seja, ele não gasta sangue se for atrás de um único alvo, ou um de sangue para dois alvos. Os limites de sangue por Geração se aplicam, e o vampiro não pode “pré-gastar” sangue antes de usar o Grito Noturno.)
O jogador então escolhe se o vampiro vai auxiliar ou ferir os alvos, e rola Manipulação + Ocultismo (dificuldade 6). Se escolher auxiliar o alvo ou alvos, cada sucesso dá a cada alvo afetado um modificador de -2 de dificuldade a todas as suas ações por um turno por sucesso. Se em vez disso escolher ferir, cada sucesso causa um ferimento agravado a cada alvo. Os alvos podem ser qualquer tipo de criatura viva, inclusive as sobrenaturais.
Não importa o resultado, o Grito Noturno é ouvido dos dois lados da Mortalha, atraindo a atenção de qualquer um por perto. Numa falha crítica, a necromancia pode invocar fantasmas ou Espectros indóceis, semelhante ao Sopro de Thanatos.]==],
				},
				["Weather Control"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 228


Weather Control


O comando sobre o clima é há muito um poder básico de magos tanto mortais quanto imortais, e diz-se que esta trilha antecede os Tremere em milênios. A proliferação do uso desta trilha fora do Clã tende a confirmar essa teoria; o Controle do Clima é bastante comum fora dos Tremere, e até fora da Camarilla. Os níveis mais baixos desta trilha permitem manipulações sutis, enquanto os estágios mais altos de maestria permitem ao vampiro convocar tempestades furiosas. A área afetada por este poder costuma ser bem pequena, não mais que cinco ou seis quilômetros de diâmetro, e as mudanças que o poder provoca nem sempre são imediatas.
Sistema: O número de sucessos rolados indica quanto tempo a magia climática leva para fazer efeito. Um sucesso indica que um dia inteiro pode se passar antes de o clima mudar ao gosto do taumaturgo, enquanto uma rolagem com cinco sucessos traz um efeito quase instantâneo.
A dificuldade da rolagem de Força de Vontade necessária para invocar este poder pode mudar conforme as condições climáticas locais atuais e o clima que o personagem tenta criar. O Narrador deve impor um bônus (-1 ou -2 de dificuldade) para mudanças relativamente pequenas, como dissipar uma garoa leve ou chamar raios quando uma tempestade severa já está em curso. Por outro lado, uma penalidade (+1 ou +2 de dificuldade) deve ser aplicada quando a mudança desejada estiver em desacordo com as condições atuais, como invocar essa mesma garoa leve no meio do Deserto do Saara ou fazer descer um raio de um céu sem nuvens.
Se o personagem tentar atingir um alvo específico com um raio, o jogador precisa rolar Percepção + Ocultismo (dificuldade 6 se o alvo estiver em terreno aberto, 8 se estiver sob abrigo, ou 10 se estiver dentro de um recinto mas perto de uma janela), além da rolagem base para usar Taumaturgia. Do contrário o relâmpago se desvia, e o grau relativo de fracasso da rolagem determina onde exatamente o raio cai.
Os efeitos do poder assumem por padrão a área máxima disponível, a menos que o conjurador declare que está tentando afetar uma área menor. A critério do Narrador, uma rolagem adicional de Força de Vontade (dificuldade 6) pode ser exigida para manter a mudança climática sob controle.
O Controle do Clima não é o tipo de poder que se preste bem à aplicação em ambientes fechados. Embora certos usos da trilha (mudanças de temperatura, ventos fortes e possivelmente até névoa) façam algum sentido em cenários internos, outros (precipitação de qualquer tipo, raios) não fazem. A dificuldade de todas as rolagens para usar o Controle do Clima em ambiente fechado recebe +2, e o Narrador deve se sentir à vontade para proibir qualquer uso proposto que não faça sentido.
Descrições individuais de poder não são fornecidas para esta trilha, já que o princípio geral é bastante consistente. Em vez disso, lista-se o fenômeno climático mais forte possível em cada nível.

• Névoa: A visão fica levemente prejudicada e os sons ficam abafados; um +1 de dificuldade é imposto a todas as rolagens de Percepção que envolvam visão e audição, e o alcance efetivo de todos os ataques à distância cai pela metade.
• Brisa leve: Um +1 de dificuldade é imposto a todas as rolagens de Percepção que envolvam olfato.
• Mudança pequena de temperatura: É possível elevar ou reduzir a temperatura local em até 5 graus Celsius.

•• Chuva ou neve: Como a Névoa, mas as rolagens de Percepção são prejudicadas em grau bem maior; o modificador de dificuldade de todas essas rolagens sobe para +2. Além disso, a dificuldade de todas as rolagens de Condução aumenta em dois.

••• Ventos Fortes: A velocidade do vento sobe a cerca de 50 quilômetros por hora, com rajadas de até o dobro disso. Ataques à distância ficam muito mais difíceis: +1 para ataques com armas de fogo e +2 para armas de arremesso e arco e flecha. Além disso, durante rajadas ferozes, rolagens de Destreza (dificuldade 6) podem ser exigidas para impedir que os personagens sejam derrubados pelos ventos. Quando ventos de força de vendaval estão em ação, papéis saem voando, objetos são apanhados pelo vento e arremessados sem cerimônia, e outros efeitos devidamente cinematográficos são prováveis.
••• Mudança moderada de temperatura: A temperatura local pode ser elevada ou reduzida em até 10 graus Celsius.

•••• Tempestade: Tem os efeitos tanto da Chuva quanto dos Ventos Fortes.

••••• Golpe de Raio: Este ataque inflige 10 dados de dano letal. Armadura corporal não soma à parada de dados do alvo para absorver este ataque.]==],
				},
				-- <<< PATH_DESC_END
};
