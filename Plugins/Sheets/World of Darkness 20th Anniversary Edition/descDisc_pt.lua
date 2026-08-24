-- Discipline descriptions, the [pt] half (SPEC T495, V210).
--
-- descDisc.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [pt] only, descDisc_en.lua holds the other, the two carry the SAME
-- keys, and the renderer requires the half the sheet is set to - require("descDisc_" .. lang ..
-- ".lua"), never a constant name (SPEC V210b). Nothing was removed: both files ship in the
-- .rpk and no entry is dropped (SPEC V210a). The generator markers migrated verbatim to
-- both sides, so every region parser still aims at the same shape (SPEC I24).
--
-- Discipline descriptions for the Vampire tab (SPEC I21). One entry per canonical picker
-- value, keyed in ENGLISH because that is what the sheet saves (SPEC V24); `pt` is a
-- translation of the same three blocks, source line for source line.
--
-- SPEC I24 / T479-T481: this table used to be an upvalue inside the <script> of HH.12.lfm.
-- The <script> CDATA is copied raw into constructNew_*(), so every open sheet parsed and
-- kept its own copy. As a module it is parsed once and cached in package.loaded, and the
-- require that pulls it lives INSIDE discText (SPEC V198).
--
-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24). The generator
-- markers migrated verbatim, so research/rebuild_ritual_desc.sh and the .tsv maps still aim
-- at the same region - only the path of the target changed.

return {
				-- >>> DISC_DESC_BEGIN (generated - SPEC T444)
				["Abombwe"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 189


Abombwe


Os Bonsam alegam descender de um caçador possuído por uma escuridão de um tempo anterior à luz. É impossível verificar a veracidade dessa afirmação, mas a Disciplina de Abombwe certamente bebe tanto da escuridão primordial quanto da destreza predatória.

• Comunhão do Predador
O Laibon é o maior predador do seu território e percebe sempre que um possível aliado ou rival está por perto.
Sistema: Gaste um ponto de sangue. Pelo resto da cena, o Laibon consegue sentir predadores na área, incluindo vampiros, metamorfos, fantasmas, animais predatórios, mortais e carniçais com Caminho 4 ou menos. Para localizar com precisão ou encontrar uma criatura escondida, o jogador rola Percepção + Sobrevivência (dificuldade 6, modificada pela força do predador conforme o Narrador determinar; predadores mais fortes costumam ser mais fáceis de detectar).

•• Invocando o Predador
Esculpindo a escuridão maleável dentro de si e empurrando-a para fora, o Laibon consegue copiar aspectos de animais predatórios.
Sistema: Essa transformação leva um turno e exige um ponto de sangue. O personagem pode fazer crescer garras que causam Força +1 de dano letal ou uma cauda para equilíbrio. A maioria das transformações é automática, mas as particularmente exóticas, como glândulas de veneno, exigem uma rolagem de Inteligência + Sobrevivência (dificuldade 7). Uma falha crítica resulta numa transformação bem-sucedida, mas acrescenta mudanças cosméticas como escamas ou listras. Esse poder não suspende as leis da física; o Laibon não pode criar asas nem teia de aranha forte o bastante para sustentar seu peso.

••• Hibernação Invisível
O Laibon faz seu covil dentro de formações naturais, plantas ou terra, derretendo-se na escuridão escondida sob a superfície delas. Um objeto natural significativamente alterado ou esculpido pelo homem não serve para esse poder; uma cabana de madeira não pode ser usada, mas uma árvore com entalhes talvez sirva.
Sistema: O jogador gasta um ponto de sangue. Hibernação Invisível é automática e leva um turno para se completar. O personagem cai numa consciência um passo acima do torpor durante esse tempo, e seu jogador precisa fazer uma rolagem de Caminho (dificuldade 6) para que o personagem desperte antes da hora.
A dificuldade das rolagens para localizar o personagem aumenta em dois. Indivíduos astrais não conseguem afetá-lo diretamente, encontrando em vez disso uma escuridão contorcida enquanto suas mãos o atravessam.
Violência contra o vampiro submerso o expele do objeto num jato ofuscante (todos perto do vampiro, e o próprio vampiro, ficam com +2 de dificuldade em Percepção naquele turno). O vampiro subtrai dois da sua Iniciativa no primeiro turno após a expulsão, mas pode agir normalmente depois disso.

•••• Poder da Escuridão
O Laibon deixa a escuridão escorrer para fora e sobre si como sangue negro e coagulado que gruda no seu corpo. Isso lhe concede poder e habilidades especiais, ainda que a luz a repila.
Sistema: Esse poder custa dois pontos de sangue e é automático. Uma transformação pode estar ativa por vez, durando uma cena, durante a qual resistir a Rötschreck é +1 de dificuldade.
Exemplos de uso estão listados abaixo, mas jogadores e Narradores são encorajados a criar suas próprias mudanças:
Mãos – Socos causam Força +1 de dano agravado.
Cabeça – Ganhe a capacidade de enxergar perfeitamente na escuridão normal e -2 de dificuldade para enxergar em escuridão sobrenatural. Cuspa uma toxina rolando Destreza + Esportes (dificuldade 7) que paralisa qualquer membro inimigo que toque, a menos que o alvo obtenha sucesso numa rolagem de Vigor (dificuldade 7).
Torso – Faça brotar quatro pernas de aranha, que permitem um ataque adicional como parte de uma ação múltipla no turno. Ações de escalada têm sucesso automático, e tentativas de escapar correndo ficam com -2 de dificuldade.
Pernas – Chutes causam dano agravado. Salte até 10 vezes a distância normal e receba -1 de dificuldade para aterrissar em segurança depois de uma queda ou salto.
Garganta – Emita um rugido primordial. Mortais e carniçais precisam ter sucesso numa rolagem de Coragem (dificuldade 9) ou fogem, enquanto seres sobrenaturais precisam ter sucesso numa rolagem de Coragem (dificuldade 8) ou ficam fracos de terror (todas as paradas de dados reduzidas à metade, arredondando para cima).

••••• Transformação do Predador
O Laibon mata um predador e consome uma parte dele, seja coração, fígado, carne ou sangue. Ele então se torna aquela criatura, à medida que sua vitae absorve por completo a essência dela.
Sistema: O jogador gasta um ponto de sangue e rola Vigor + Sobrevivência (dificuldade 7). Se tiver sucesso, o Laibon se transforma fisicamente na criatura. A criatura precisa ser predatória por natureza e ter ao menos o tamanho de um gato. Humanos e seres sobrenaturais podem ser duplicados, mas isso não inclui poderes. Transformação do Predador dura até o nascer do sol ou até o Laibon encerrar o poder.
Um Laibon pode duplicar uma transformação anterior sem consumir outra criatura. Isso exige uma rolagem de Vigor + Sobrevivência (dificuldade 10), com a dificuldade reduzida em um para cada vez que ele matou e se transformou numa criatura daquele tipo, até uma dificuldade mínima de 6. Com mortais, vampiros e outros humanoides, o Laibon assume uma aparência média para o grupo étnico da vítima.]==],
				},
				["Abyss Mysticism"] = {
					pt = [==[Lore of the Clans, pág. 125


Abyss Mysticism


À medida que os Lasombra se aprofundavam nos segredos da Tenebrosidade, descobriram que ela extraía poder de um reino sombrio de sombras chamado Abismo. Místicos do Clã passaram a estudar esse reino secreto para destrancar seus segredos e, por meio disso, desenvolveram a arte do Misticismo do Abismo. Os Lasombra mantêm esse poder em segredo do resto da Sabbat, pois as criaturas que invocam e controlam com ele são tão sombrias quanto misteriosas.

O Misticismo do Abismo é difícil e demorado de aprender, e cobra seu preço. Seus rituais muitas vezes têm efeitos colaterais que criam Defeitos que o personagem não pode remover e que não dão pontos de bônus. Para aprender o poder, um vampiro precisa ter ao menos um ponto tanto em Tenebrosidade quanto em Ocultismo. Ela não pode aprender nenhum ritual do Abismo de nível superior ao menor entre seus valores de Tenebrosidade e Ocultismo, e cada ritual custa um número de pontos de experiência igual a três vezes o nível do ritual.

Rituais do Abismo são conjurados com uma rolagem de Raciocínio + Ocultismo. A dificuldade é 3 + o nível do ritual sendo conjurado. Apenas um sucesso é necessário para conjurar o ritual, mas o Narrador é encorajado a tornar as penalidades do fracasso especialmente horripilantes.

(Mais detalhes sobre o Misticismo do Abismo podem ser encontrados em Rites of Blood, pp. 37-39.)]==],
				},
				["Animalism"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 128


Animalism


A Besta reside dentro de todas as criaturas, das baratas que se arrastam aos ratos sarnentos, passando por lobos indomados e até por poderosos anciões Membros. Animalismo permite ao vampiro amplificar sua natureza intensamente primordial. Ele não apenas se comunica com animais, como também impõe sua vontade sobre eles, dirigindo tais bestas a fazer o que ordena. Conforme o vampiro cresce em poder, ele consegue até controlar a Besta dentro de mortais e de outros seres sobrenaturais.
Bestas ficam nitidamente agitadas na presença de um vampiro que não tenha esta Disciplina ou a Perícia Empatia com Animais, muitas vezes a ponto de atacar o vampiro ou fugir dele. Em contraste, vampiros que possuem Animalismo exalam uma aura dominante para criaturas inferiores, o que as atrai.
Animalismo é comumente encontrado em vampiros dos Clãs Gangrel e Nosferatu. Manipulação e Carisma são importantes para o uso dos poderes de Animalismo; quanto mais forte a personalidade do vampiro, mais influência ele tem sobre os animais.

• Sussurros Selvagens
Este poder é a base a partir da qual todas as outras habilidades de Animalismo crescem. O vampiro cria uma conexão empática com uma besta, permitindo-lhe assim comunicar-se ou dar ordens simples. O Membro trava os olhos com o animal, transmitindo seus desejos por pura força de vontade. Embora não seja necessário de fato "falar" em pios, sibilos ou latidos, alguns vampiros descobrem que fazê-lo ajuda a fortalecer a conexão com o animal. O contato visual precisa ser mantido o tempo todo; se for rompido, o Membro precisa restabelecer o contato para continuar a comunicação.
Quanto mais simples a criatura, mais difícil se torna conectar-se com a Besta do animal. Mamíferos, aves de rapina e répteis maiores são relativamente fáceis de comunicar-se. Insetos, invertebrados e a maioria dos peixes são simples demais para conectar-se.
Sussurros Selvagens não garante que um animal vá querer lidar com o vampiro, nem assegura que o animal vá atender a qualquer pedido que o vampiro lhe faça. Ainda assim, ao menos deixa a criatura mais bem disposta em relação ao Membro. A maneira como o vampiro apresenta seus desejos ao animal muitas vezes depende do tipo de criatura. Um Membro pode com frequência intimidar bestas menores a obedecer ordens, mas faz melhor em formular ordens para grandes predadores como pedidos.
Se o vampiro usar o poder com sucesso, o animal executa a ordem da melhor forma que sua capacidade e intelecto permitem. Só as criaturas mais brilhantes entendem diretrizes verdadeiramente complexas (ordens que lidem com situações condicionais ou exijam lógica abstrata). Ordens que o animal de fato entende, porém, ficam profundamente implantadas e guiam seu comportamento por algum tempo.
Sistema: Nenhuma rolagem é necessária para conversar com um animal, mas o personagem precisa primeiro estabelecer contato visual (ver p. 152). Dar ordens exige uma rolagem de Manipulação + Empatia com Animais. A dificuldade depende da criatura: mamíferos predadores (lobos, gatos, morcegos-vampiros) são dificuldade 6, outros mamíferos e aves de rapina (ratos, corujas) são dificuldade 7, e outras aves e répteis (pombos, cobras) são dificuldade 8. Essa dificuldade é reduzida em um se o personagem falar com o animal na "língua nativa" dele, e pode ser ajustada ainda mais pelas circunstâncias e pela habilidade de interpretação (recomendamos fortemente que toda comunicação entre personagens e animais seja interpretada).
O número de sucessos que o jogador obtém determina o quão fortemente a ordem do personagem afeta o animal. Um sucesso basta para fazer um gato seguir um indivíduo e levar o personagem ao mesmo lugar, três sucessos bastam para fazer um corvo espionar um alvo por semanas, e cinco sucessos garantem que um urso-pardo guarde ferozmente a entrada do refúgio silvestre do personagem por alguns meses.
A Natureza do personagem tem grande papel em como ele aborda essas conversas. O personagem pode tentar intimidar, provocar, bajular ou racionalizar. O jogador deve entender que, nessas situações, ele não interpreta apenas seu personagem, mas a Besta Interior também.
Usar este poder não pode forçar um animal a fazer algo contra sua natureza, nem forçar uma criatura a arriscar a vida. Embora o urso-pardo mencionado acima montasse guarda ao refúgio do vampiro e até lutasse por ele, não o faria contra um número obviamente superior nem contra algo esmagadoramente sobrenatural. Uma ave de rapina poderia ser convencida a fustigar um alvo, mas definitivamente não manteria posição. Um cão dócil ou um gato arisco não teria problema em relatar algo que tivesse visto, mas não entraria em combate a menos que não lhe restasse outra opção — embora provavelmente concordasse em ficar e lutar e então fugisse na primeira oportunidade, se um Membro severo o exigisse.

•• Chamado
A conexão do vampiro com a Besta fica forte o bastante para que ele possa clamar na voz de um tipo específico de animal — uivando como um lobo, guinchando como um corvo etc. Esse chamado convoca misticamente criaturas do tipo escolhido. Como cada tipo de animal tem um chamado diferente, Chamado funciona para uma única espécie por vez.
Todos esses animais ao alcance da audição são convocados, e alguma porcentagem deles atenderá ao Chamado se ele for bem-sucedido. Embora o vampiro não tenha nenhum controle adicional sobre as bestas que respondem, os animais que o fazem ficam favoravelmente dispostos em relação a ele e estão ao menos dispostos a ouvir as preocupações do Membro. (O vampiro pode então usar Sussurros Selvagens em animais individuais para comandá-los, possivelmente com dificuldade reduzida, a critério do Narrador.)
Sistema: O jogador rola Carisma + Sobrevivência (dificuldade 6) para determinar a resposta ao chamado do personagem; consulte a tabela abaixo. Só animais que possam ouvir o grito responderão. Se o Narrador decidir que não há animais daquele tipo ao alcance da audição, a convocação fica sem resposta.
O chamado pode ser tão específico quanto o jogador desejar. Um personagem poderia chamar todos os morcegos da área, apenas os morcegos machos por perto, ou apenas o morcego albino de orelha entalhada que ele viu na outra noite.
1 sucesso — Um único animal responde.
2 sucessos — Um quarto dos animais ao alcance da audição responde.
3 sucessos — Metade dos animais responde.
4 sucessos — A maioria dos animais responde.
5 sucessos — Todos os animais respondem.

••• Aplacar a Besta
Como predadores supremos do mundo natural, os Membros são altamente sintonizados com a natureza bestial que habita todo coração mortal. Um vampiro que desenvolve este poder pode impor sua vontade sobre um sujeito mortal (animal ou humano), subjugando a Besta dentro dela. Isso extingue todas as emoções fortes e poderosas — esperança, fúria, amor, medo — dentro do alvo. O Membro precisa tocar seu sujeito ou fitar seus olhos para canalizar sua vontade de forma eficaz.
Mortais que carecem do fogo de suas Bestas interiores ficam bastante dóceis, reagindo com indiferença até a situações estressantes. Mesmo o mortal mais corajoso ou enlouquecido torna-se apático e desanimado, enquanto um indivíduo especialmente sensível pode sofrer de um distúrbio fóbico enquanto estiver sob a influência do poder.
Clãs diferentes evocam este poder de maneiras diferentes, embora o efeito em si seja idêntico. Os Tzimisce o chamam de Intimidar a Besta, pois forçam o espírito mais fraco do mortal a encolher de medo diante da própria Besta interior do Membro. Os Nosferatu se referem a ele como Canção da Serenidade, pois acalmam a Besta do sujeito até um estado de completa complacência, permitindo assim que se alimentem livremente. Os Gangrel conhecem o poder como Aplacar a Besta, e forçam o espírito mortal a um estado de medo ou apatia conforme convier à natureza de cada vampiro.
Sistema: O jogador rola Manipulação + Intimidação se estiver subjugando a Besta pelo medo, ou Manipulação + Empatia se estiver acalmando-a até a complacência. A dificuldade da rolagem é 7 em qualquer dos casos. Esta é uma ação estendida que exige tantos sucessos totais quanto o alvo tiver de Força de Vontade. Um fracasso indica que o jogador precisa recomeçar do início, enquanto uma falha crítica indica que o vampiro não pode afetar a Besta daquele sujeito pelo resto da cena.
Quando a Besta de um mortal é intimidada ou acalmada, ela não pode mais usar nem recuperar Força de Vontade. Ela cessa toda resistência, seja mental ou física. Ela nem sequer se defende se for agredida, embora o Narrador possa permitir uma rolagem de Força de Vontade se a mortal acreditar que sua vida está realmente ameaçada. Para se recuperar deste poder, a jogadora da mortal rola Força de Vontade (dificuldade 6) uma vez por dia até acumular sucessos suficientes para igualar a Força de Vontade do vampiro. Membros não podem ser afetados por este poder.
Embora a Besta de um vampiro não possa ser intimidada com esta habilidade, o Narrador pode permitir que personagens usem a variação "acalmante" deste poder para tirar um vampiro do frenesi. Com três ou mais sucessos, o vampiro em frenesi pode rolar novamente para sair do frenesi, usando a mesma dificuldade do estímulo que causou o frenesi originalmente.

•••• Subsumir o Espírito
Ao travar seu olhar com o de um animal, o vampiro pode possuir mentalmente a criatura. Alguns anciões acreditam que, como animais não têm almas e sim espíritos, o vampiro consegue mover a própria alma para dentro do corpo do animal. Muitos vampiros mais jovens acham que é questão de transferir a própria consciência para a mente do animal. Em qualquer dos casos, concorda-se que o espírito (ou mente) mais fraco da besta é empurrado para o lado pela consciência do Membro. O corpo do vampiro cai num estado imóvel semelhante ao torpor enquanto sua mente assume o controle das ações do animal, permanecendo assim até que a consciência do Membro retorne.
Alguns Tzimisce arrogantes evitam este poder, considerando aviltante entrar no corpo de uma criatura inferior. Quando se rebaixam a usá-lo, possuem apenas predadores. Inversamente, os Gangrel se deleitam em conectar-se ao mundo natural desta forma. Eles adoram experimentar a natureza de diferentes animais.
Sistema: O jogador rola Manipulação + Empatia com Animais (dificuldade 8) enquanto o personagem olha nos olhos do animal (ver o quadro na p. 152). O número de sucessos permite ao personagem empregar algumas Disciplinas mentais enquanto possui o animal, conforme indicado abaixo.
1 sucesso — Não pode usar Disciplinas.
2 sucessos — Pode usar Auspícios e outros poderes sensoriais.
3 sucessos — Pode usar também Presença e outros poderes de manipulação emocional.
4 sucessos — Pode usar também Demência, Dominação e outros poderes de manipulação mental.
5 sucessos — Pode usar também Quimerismo, Necromancia, Taumaturgia e outros poderes místicos.
Este poder entrelaça a consciência do personagem intimamente com o espírito do animal, a tal ponto que o personagem pode continuar a pensar e sentir como aquele animal mesmo depois de romper a conexão. Esse efeito continua até que o personagem gaste um total de sete noites ou três pontos de Força de Vontade para resistir e finalmente superar a natureza animal. Isso deve ser interpretado, embora o personagem seja afetado em menor grau se o jogador optar por gastar Força de Vontade.
Ao fim de qualquer incidente particularmente empolgante durante a possessão, o jogador rola Raciocínio + Empatia (dificuldade 8) para que o personagem retenha a própria mente. Um fracasso indica que a mente do personagem retorna ao próprio corpo, mas ainda pensa em termos puramente animalescos. Uma falha crítica devolve o personagem ao corpo e também o lança em frenesi.
O personagem pode viajar tão longe do próprio corpo físico quanto quiser enquanto possui o animal. Nesse período, porém, o personagem não retém nenhuma conexão consciente com seu corpo vampírico. O vampiro também pode se aventurar durante o dia, ainda que no corpo do animal. Contudo, o próprio corpo do personagem precisa estar desperto para isso, exigindo uma rolagem bem-sucedida para permanecer acordado (ver p. 262). Se o personagem deixar o corpo do animal (por escolha, se seu corpo adormecer, ou após sofrer ferimento significativo), a consciência do vampiro retorna instantaneamente à sua forma física.
Embora o vampiro não tenha ligação consciente com seu corpo enquanto possui o animal, ele forma um vínculo simpático. Tudo o que o animal sente, o vampiro também experimenta, do prazer à dor. De fato, qualquer dano que o corpo do animal sofra também é aplicado ao corpo do personagem, embora o corpo do Membro possa absorver normalmente. Se o animal morrer antes que a alma do vampiro possa fugir do corpo, o corpo do personagem cai em torpor. Presume-se que isso seja uma resposta simpática ao trauma massivo da morte, mas alguns Membros acreditam que a alma do vampiro fica à deriva durante esse tempo e precisa encontrar o caminho de volta ao corpo.

••••• Extrair a Besta
Neste nível de Animalismo, o Membro tem um entendimento aguçado da Besta Interior e é capaz de liberar seus impulsos ferais sobre outro mortal ou vampiro. Quem recebe a Besta do vampiro é instantaneamente tomado pelo frenesi. Trata-se, porém, de um frenesi antinatural, pois a vítima está canalizando a fúria do próprio Membro. Assim, o comportamento, as expressões e até os padrões de fala do vampiro ficam evidentes nas ações selvagens do sujeito.
Gangrel e Tzimisce apreciam especialmente desencadear suas Bestas sobre os outros. Os Gangrel o fazem para incitar seus carniçais a alturas inspiradas de selvageria durante o combate. Os Tzimisce se importam menos com quem recebe sua Besta do que em manter a própria compostura.
Sistema: O jogador precisa anunciar o alvo pretendido (já que precisa ser alguém à vista, Extrair a Besta não pode ser usado se o vampiro estiver sozinho) e então rolar Manipulação + Autocontrole/Instinto (dificuldade 8). Consulte a tabela abaixo para os resultados:
1 sucesso — O personagem transfere a Besta, mas a desencadeia sobre um indivíduo aleatório.
2 sucessos — O personagem fica atordoado pelo esforço e não pode agir no turno seguinte, mas transfere a Besta com sucesso. Alternativamente, o personagem pode agir normalmente durante o turno, mas precisa gastar um ponto de Força de Vontade ou sofrer um único nível de dano letal.
3+ sucessos — O personagem transfere a Besta com sucesso.
Se a tentativa fracassar, o próprio personagem entra imediatamente em frenesi. Enquanto o personagem relaxa na expectativa de aliviar seus impulsos selvagens, a Besta aproveita a oportunidade para se enterrar mais fundo. Nesse caso, o frenesi dura o dobro do normal e é duas vezes mais difícil de sacudir; sua severidade também aumenta exponencialmente. Obter uma falha crítica nessa rolagem é ainda mais catastrófico; o frenesi intensificado cresce a tal extremo que nem mesmo gastar Força de Vontade contém sua duração ou seus efeitos. O personagem é vítima indefesa da fúria terrível de sua Besta, e pode muito bem lançar-se numa carnificina selvagem e dilacerante que deixa a Máscara (e os infelizes espectadores por perto) em farrapos.
Se o personagem deixar a presença do alvo antes que o frenesi se esgote, o vampiro perde sua Besta, talvez permanentemente. Embora não esteja mais vulnerável ao frenesi, o personagem não pode usar nem recuperar Força de Vontade e fica cada vez mais letárgico. Para recuperar a Besta, ele precisa encontrar a pessoa que agora a possui (e que provavelmente não está se divertindo nada) e persuadir a Besta a voltar ao seu receptáculo apropriado. A maneira mais eficaz de fazê-lo é comportar-se de modo que faça a Besta querer voltar — no entanto, isso não garante que ela vá desejar fazê-lo. Alternativamente, o personagem pode simplesmente matar o hospedeiro (fazendo assim com que a Besta retorne imediatamente ao vampiro).]==],
				},
				["Assamite Sorcery"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 440


Assamite Sorcery


De um ponto de vista puramente funcional, a magia de sangue que a casta de feiticeiros Assamita pratica difere pouco daquela empunhada pelos Tremere. De uma perspectiva filosófica, porém, mundos de diferença separam as duas. Os Tremere forçam cada fragmento de conhecimento que incorporam para dentro da estrutura rígida e sistemática da alta invocação Hermética. Em contraste, as práticas da casta de feiticeiros são fruto de milênios de adaptação e fusão, e são díspares demais para serem consideradas "estruturadas" em qualquer sentido real. O corpo moderno de conhecimento que é a Feitiçaria Assamita extrai seu conteúdo de um amplo leque de tradições mágicas, dos ritos extáticos dos seguidores de Kali e Shiva à precisão sutil do feng shui, até as elegantes transformações simbólicas e matemáticas dos alquimistas e astrônomos islâmicos.
A Feitiçaria Assamita é mecanicamente idêntica à Taumaturgia mais comum que aparece nas pp. 212-240. Contudo, embora funcionem por princípios semelhantes (o uso de vitae vampírica para alimentar exercícios de vontade consciente a fim de efetuar mudança no mundo físico ou espiritual), as duas não são compatíveis entre si. Um Tremere se esforça para realizar sua magia da mesma maneira, o tempo todo, sempre. Um Assamita pode nunca executar o mesmo ritual exatamente da mesma forma duas vezes num milênio.
Como se pode esperar, estudantes de Feitiçaria Assamita têm grande dificuldade em aprender as práticas de outras tradições de magia de sangue. Todos os custos em pontos de experiência para aprender outras trilhas e rituais de magia de sangue são aumentados pela metade (arredondando para cima) para feiticeiros Assamitas. Além disso, mesmo depois que a feiticeira incorpora essas lições ao seu repertório, elas continuam alheias a ela. Todas as invocações de uma trilha "estrangeira" exigem um ponto de sangue extra, e todos os rituais levam o triplo do tempo normal e exigem um sucesso extra para qualquer resultado desejado.

Os feiticeiros têm ensinamentos equivalentes para muitas técnicas comuns de magia de sangue, além de suas próprias lições exclusivas. A lista a seguir não é uma cobertura exaustiva de tudo o que há na Grande Biblioteca, mas é um ponto de partida para jogadores e Narradores que queiram determinar as capacidades dos feiticeiros Assamitas. Nomes entre parênteses são os nomes que a casta de feiticeiros prefere usar para cada item, quando o nome Assamita difere do comumente aceito. Trilhas marcadas com asterisco costumam ser opções para um feiticeiro Assamita aprender como sua trilha principal, desde que seu instrutor aprove.
Trilhas: The Path of Blood, The Lure of Flames*, Movement of the Mind*, The Path of Conjuring, Hands of Destruction
Rituais: Defense of the Sacred Haven (Curtain of Will), Wake with Evening’s Freshness (Black Sunrise), Communicate with Kindred Sire (Speak with Sire), Deflection of Wooden Doom (Turn the Impaling Shaft), Ward versus Ghouls, Principal Focus of Vitae Infusion (Draught of the Pebble), Incorporeal Passage (Passage of the Ghul), Bone of Lies (Stain of Guilt)]==],
				},
				["Auspex"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 134


Auspex


Auspícios dá ao vampiro capacidades sensoriais sobrenaturais. Ela começa com a capacidade de aguçar significativamente seus sentidos naturais, mas, conforme cresce em poder, passa a perceber auras psíquicas e a ler os pensamentos de outro ser. Auspícios também pode atravessar ilusões mentais como as criadas por Ofuscação — veja o quadro "Vendo o Invisível" na p. 142 para mais detalhes.
Contudo, um vampiro com Auspícios precisa tomar cuidado. Sua sensibilidade sensorial aumentada pode fazê-la se deixar levar por coisas belas ou ficar atordoada por ruídos altos ou cheiros penetrantes. Eventos súbitos ou dinâmicos podem desorientar um personagem usando Auspícios, a menos que sua jogadora faça uma rolagem de Força de Vontade para bloqueá-los (dificuldade de pelo menos 4, embora quanto mais potente a fonte de distração, maior a dificuldade). Uma falha sobrecarrega os sentidos do personagem, deixando-a alheia ao que a cerca por um turno ou dois. Embora os Malkavianos e os Toreador sejam mais propensos a esse tipo de distração, os Tremere e os Tzimisce não estão imunes.
Pontos em Percepção são muito úteis para usar poderes de Auspícios, pois mais sucessos ajudam o personagem a obter mais informação sensorial.

• Sentidos Aguçados
Este poder aumenta a acuidade de todos os sentidos do vampiro, efetivamente dobrando a clareza e o alcance da visão, da audição e do olfato. Embora seus sentidos de paladar e tato não se estendam mais longe que o normal, eles também se tornam muito mais distintos; o vampiro conseguiria sentir o gosto de um traço de bebida no sangue de uma vítima ou perceber a cedência da tábua que esconde um vão no assoalho. O Membro pode ampliar seus sentidos à vontade, sustentando esse foco aguçado pelo tempo que desejar. A critério do Narrador, isso pode facilitar a caçada.
Ocasionalmente, esse talento fornece percepções extrassensoriais ou até precognitivas. Esses vislumbres breves e desfocados podem ser premonições estranhas, lampejos de empatia ou sensações inquietantes de mau presságio. O vampiro não tem controle sobre essas percepções, mas com prática pode aprender a interpretá-las com razoável precisão.
Sentidos ampliados têm um preço, porém. Luzes fortes, ruídos altos e cheiros intensos representam um perigo enquanto o vampiro usa esse poder. Além da possibilidade de distração, um estímulo especialmente súbito ou potente (como o brilho de um holofote ou um estrondo de trovão) pode cegar ou ensurdecer o Membro por uma hora ou mais.
Sistema: Ativar essa habilidade exige uma ação reflexiva, mas nenhuma rolagem ou outro custo é necessário. Em certas circunstâncias, rolagens de dados associadas ao uso dos sentidos do personagem (como Percepção + Prontidão) têm sua dificuldade reduzida em um número igual ao valor de Auspícios do personagem enquanto o poder estiver ativo.
O Narrador também pode usar esse poder para verificar se o personagem percebe uma ameaça. Nesse caso, o Narrador rola em segredo o valor de Auspícios não modificado do personagem, aplicando a dificuldade que julgar mais adequada às circunstâncias. Por exemplo, sentir que uma pistola está apontada para a nuca do personagem pode exigir uma rolagem de dificuldade 5, enquanto a súbita compreensão de que um rival ao Primogênito planeja seu assassinato pode exigir um 9. Note que mesmo essa "precognição" vem apenas como resultado da interpretação de detalhes que o Membro é capaz de notar. Não é uma percepção universal nem uma revelação milagrosa.
A critério da personagem, ela pode aguçar seletivamente um sentido específico, em vez de deixar todos ligados. Nesses casos, a dificuldade para perceber estímulos com aquele sentido cai em um, mas a dificuldade para evitar distração ou ofuscamento temporário aumenta em um.
Este poder não permite que personagens enxerguem na escuridão total, como faz Olhos da Besta (p. 199), mas reduz as penalidades de dificuldade para agir nessa escuridão de +2 para +1, e o personagem pode fazer ataques à distância na escuridão total se conseguir ouvir, cheirar ou de outro modo detectar seu adversário.

•• Percepção da Aura
Usando esse poder, o vampiro consegue perceber as "auras" psíquicas que irradiam de mortais e de seres sobrenaturais igualmente. Esses halos são compostos por uma série cambiante de cores que exige prática para ser discernida com clareza. Mesmo o indivíduo mais simples tem muitos matizes mutáveis em sua aura; emoções fortes predominam, enquanto impressões momentâneas ou segredos profundos passam em riscos e redemoinhos.
As cores mudam em sintonia com o estado emocional do sujeito, misturando-se em novos tons num padrão que dança constantemente. Quanto mais fortes as emoções envolvidas, mais intensos os matizes se tornam. Um vampiro habilidoso pode aprender muito sobre seu sujeito lendo as nuances de cor e brilho no fluxo da aura.
Além de perceber estados emocionais, vampiros usam Percepção da Aura para detectar seres sobrenaturais. As cores nas auras dos Membros, embora intensas, são bastante pálidas; halos de magos frequentemente faíscam e crepitam com poder arcano; a raça dos metamorfos tem auras marcantemente vivas, quase frenéticas; fantasmas têm auras fracas que tremulam de modo intermitente como uma chama que se apaga; e o brilho das criaturas feéricas é atravessado por matizes caprichosos de arco-íris.
Sistema: Depois que o personagem encara o sujeito por ao menos alguns segundos, o jogador rola Percepção + Empatia (dificuldade 8); cada sucesso indica quanto da aura do sujeito o personagem vê e compreende (veja a tabela abaixo). Uma falha indica que o jogo de cores e padrões não produz nenhuma impressão dominante. Uma falha crítica indica uma interpretação falsa ou errônea. O Narrador pode preferir fazer essa rolagem, mantendo assim o jogador no escuro quanto à veracidade da interpretação do personagem.
1 sucesso — Consegue distinguir apenas o tom (pálido ou brilhante).
2 sucessos — Consegue distinguir a cor principal.
3 sucessos — Consegue reconhecer os padrões de cor.
4 sucessos — Consegue detectar mudanças sutis.
5 sucessos — Consegue identificar misturas de cor e padrão.
A tabela de Cores da Aura oferece algumas ideias de cores comuns e das emoções que elas refletem, que os Narradores podem usar. Note que é quase impossível determinar com certeza se um personagem em particular está mentindo ou não com esse poder – vampiros são inerentemente enganadores por natureza, mas até mortais podem reagir com ansiedade a perguntas sendo sinceros. É útil, porém, para determinar o estado emocional do alvo, o que pode levar o vampiro a decidir que determinado alvo é suspeito.
Um personagem pode escolher fazer uma varredura de aura bem superficial numa área grande, como a pista de dança de uma casa noturna ou o público de uma galeria. Nesse caso, o jogador decide qual característica das auras ela está procurando, e essa é a única informação que consegue obter se a rolagem for bem-sucedida. (A critério do Narrador, nessa rolagem de varredura geral, mais sucessos podem render mais rapidamente o que o personagem procura.) Por exemplo, o jogador pode especificar: "Quem é a pessoa mais nervosa presente?" ou "Há alguma aura vampiricamente pálida na comitiva do presidente da empresa?" Depois disso, o jogador pode estreitar seu exame para um único indivíduo, com uma rolagem adicional normal.
O personagem só pode focar na aura de um sujeito em particular uma vez por cena com algum grau de clareza. Quaisquer tentativas subsequentes que resultem em falha devem ser consideradas falhas críticas. É muito fácil para o personagem imaginar que vê o que quer ver ao julgar as intenções de alguém. Depois de 24 horas, o personagem pode tentar de novo sem penalidade.
É possível, embora difícil, sentir a aura de um ser que de outro modo é invisível à visão normal. Consulte "Vendo o Invisível", p. 142, para mais informações.
Cores da Aura
Com medo — Laranja
Agressivo — Roxo
Furioso — Vermelho
Amargurado — Marrom
Calmo — Azul-claro
Compassivo — Rosa
Conservador — Lilás
Deprimido — Cinza
Desejoso ou Luxurioso — Vermelho-escuro
Desconfiado — Verde-claro
Invejoso — Verde-escuro
Empolgado — Violeta
Generoso — Rosa-chá
Feliz — Vermelhão
Odioso — Preto
Idealista — Amarelo
Inocente — Branco
Apaixonado — Azul
Obcecado — Verde
Triste — Prateado
Espiritual — Dourado
Suspeitoso — Azul-escuro
Ansioso — A aura aparece embaralhada como estática ou ruído branco
Confuso — Cores manchadas e cambiantes
Diaborista — Veios pretos na aura
Sonhando acordado — Cores em lampejos agudos
Em frenesi — Cores ondulando rapidamente
Psicótico — Cores hipnóticas e rodopiantes
Vampiro — As cores da aura são pálidas
Carniçal — Manchas pálidas na aura
Uso de Magia — Miríade de faíscas na aura
Metamorfo — Aura viva e vibrante
Fantasma — Aura fraca e intermitente
Feérico — Reflexos de arco-íris na aura

••• O Toque do Espírito
Quando alguém manuseia um objeto por qualquer período de tempo, deixa uma impressão psíquica no item. Um vampiro com esse nível de Auspícios consegue "ler" essas sensações, descobrindo quem manuseou o objeto, quando o segurou pela última vez e o que foi feito com ele recentemente. (Para esses fins, um cadáver conta como um "objeto" e pode ser lido do mesmo modo.) Essas visões raramente são claras e detalhadas, registrando-se mais como uma espécie de "instantâneo psíquico". Ainda assim, o Membro pode aprender muito mesmo com um vislumbre desses. Embora a maioria das visões diga respeito à última pessoa a manusear o item, um dono de longa data deixa uma impressão mais forte do que alguém que segurou o objeto brevemente.
Extrair informação do resíduo espiritual exige que o vampiro segure o objeto e entre num transe superficial. Ela fica apenas marginalmente ciente do que a cerca enquanto usa O Toque do Espírito, mas um ruído alto ou uma sensação física brusca quebra o transe instantaneamente.
Sistema: O jogador rola Percepção + Empatia. A dificuldade é determinada pela idade das impressões e pela força mental e espiritual da pessoa ou do evento que as deixou. Sentir informação de uma pistola usada num assassinato horas atrás pode exigir um 4, enquanto descobrir quem foi o dono de um boneco manchado de sangue confeccionado há um século pode ser um 9.
Quanto maior a conexão emocional do indivíduo com o objeto, mais forte a impressão que ele deixa nele — e mais informação o Membro consegue extrair. Eventos envolvendo emoções fortes (uma doação de presente, uma tortura, uma longa história de família) também deixam impressões mais fortes do que contatos curtos ou casuais. Assuma que cada sucesso oferece uma informação, conforme a tabela abaixo.
Falha crítica — O personagem é sobrecarregado por impressões psíquicas pelos próximos 30 minutos e fica incapaz de agir.
Falha — Nenhuma informação de valor.
1 sucesso — Informação bem básica: o gênero ou a cor de cabelo do último dono, por exemplo.
2 sucessos — Uma segunda informação básica.
3 sucessos — Informação mais útil sobre o último dono, como a idade e o estado de espírito na última vez que usou o item.
4 sucessos — O nome da pessoa.
5+ sucessos — Uma riqueza de informação: praticamente qualquer coisa que você queira saber sobre a relação da pessoa com aquele objeto está disponível.
A critério do Narrador, algumas impressões em objetos podem ser tão fortes — uma faca cravada no peito de César, a ponta da Lança do Destino, uma presa arrancada das fauces de Drácula — que qualquer uso desse poder pode ser considerado um sucesso.

•••• Telepatia
O vampiro projeta uma porção de sua consciência na mente de um mortal próximo, criando um elo mental pelo qual pode se comunicar sem palavras ou até ler os pensamentos mais profundos do alvo. O Membro "ouve" na própria mente os pensamentos colhidos de um sujeito como se lhe tivessem sido falados.
Esta é uma das habilidades vampíricas mais potentes, pois, com tempo, um Membro pode aprender virtualmente qualquer coisa de um sujeito sem que ele jamais saiba. Os Tremere e os Tzimisce em particular acham esse poder especialmente útil para arrancar segredos de outros ou para dirigir seus seguidores mortais com precisão silenciosa.
Sistema: O jogador rola Inteligência + Subterfúgio (dificuldade igual aos pontos atuais de Força de Vontade do sujeito). Projetar pensamentos na mente do alvo exige um sucesso. O sujeito reconhece que os pensamentos vêm de algum lugar que não sua própria consciência, embora não consiga discernir a origem real deles sem uma rolagem bem-sucedida de Percepção + Consciência (dificuldade igual à Manipulação + Subterfúgio do vampiro).
Para ler mentes, é preciso rolar um sucesso para cada informação colhida ou cada camada de pensamento perfurada. Segredos profundos ou memórias enterradas são mais difíceis de obter do que emoções superficiais ou comentários não ditos, exigindo cinco ou mais sucessos para serem acessados.
Ler pensamentos com Telepatia normalmente não funciona sobre a mente morta-viva. Um personagem pode gastar um ponto de Força de Vontade para fazer a tentativa, fazendo a rolagem normalmente em seguida. Do mesmo modo, é igualmente difícil ler os pensamentos de outras criaturas sobrenaturais. Contudo, o personagem pode projetar seus pensamentos sem gastar um ponto de Força de Vontade. Esses pensamentos, porém, ainda são obviamente intrusões na mente do alvo, mas o personagem pode tentar disfarçar sua "voz" mental com uma rolagem de Manipulação + Subterfúgio (dificuldade igual à Percepção + Consciência do alvo), de modo que o alvo não a reconheça como a "falante".
Narradores são encorajados a descrever pensamentos como correntes fluidas de impressões e imagens, em vez de como uma sequência de prosa (poderes como Comunicação Telepática são mais úteis para isso). Em vez de fazer afirmações secas como "Ele está planejando matar o novo namorado da ex-amante", diga: "Você vê uma série fugaz de visões: um casal se beijando com paixão numa entrada de porta, depois o homem caminhando sozinho à noite; de repente você vê suas próprias mãos, os nós dos dedos brancos, agarradas a um volante, com uma figura atravessando a rua à frente; seu coração, mortal agora e martelando de pânico enquanto você ouve o motor acelerar descontrolado; e acima de tudo, uma raiva ardente somada a uma agonia emocional e a um medo apavorado de perda". Descrições assim não só acrescentam à história, como também forçam o jogador a interpretar por si mesmo o que sua personagem apreende. Afinal, compreender mentes — especialmente mentes muito emotivas ou perturbadas — é uma tarefa difícil e frequentemente desconcertante.

••••• Projeção Psíquica
O Membro com essa habilidade formidável projeta seus sentidos para fora do invólucro físico, saindo do próprio corpo como uma entidade de puro pensamento. A forma astral do vampiro é imune a dano físico ou fadiga, e pode "voar" com velocidade ofuscante por qualquer lugar da Terra — ou até sob o solo —, desde que permaneça abaixo da órbita da lua.
A forma material do Membro fica num estado torporoso enquanto seu eu astral está ativo, e o vampiro não tem consciência de nada que aconteça ao seu corpo até retornar a ele. Um cordão de prata efêmero conecta a psique do Membro ao seu corpo. Se esse cordão for cortado, sua consciência fica encalhada no plano astral (o reino dos fantasmas, espíritos e sombras). Tentar retornar ao invólucro físico do vampiro é uma provação longa e apavorante, ainda mais porque não há garantia de que ela completará a jornada com sucesso. Esse perigo considerável impede muitos Membros de deixarem seus corpos por muito tempo, mas quem ousa pode aprender muito.
Sistema: Viajar em forma astral exige que o jogador gaste um ponto de Força de Vontade e faça uma rolagem de Percepção + Consciência. A dificuldade varia conforme a distância e a complexidade da viagem pretendida; 5 é dentro do campo de visão, 7 é perto ou para um local familiar, e 9 reflete uma viagem para longe de território conhecido (uma primeira jornada da América do Norte para o Extremo Oriente; tentar cortar caminho através da terra). Quanto maior o número de sucessos rolados, mais focada é a presença astral do personagem, e mais fácil é para ela alcançar o destino desejado.
Uma falha significa que o personagem não consegue separar sua consciência do corpo, enquanto uma falha crítica pode ter consequências desagradáveis — lançar sua forma astral para um destino aleatório na Terra ou no reino espiritual, chegar a um lugar onde o sol está ativo (exigindo uma rolagem de frenesi, embora a luz solar não cause dano algum) ou arremessá-la em direção ao destino desejado com tanta força que o cordão de prata se rompe.
O jogador pode gastar um ponto de Força de Vontade para ativar esse poder, e um ponto adicional de Força de Vontade para obter o sucesso necessário para realizar a excursão. Esta é uma exceção à regra normal, segundo a qual um jogador não pode gastar mais de um único ponto de Força de Vontade por turno.
Cada cena em Projeção Psíquica exige outro ponto de Força de Vontade e uma nova rolagem. Uma falha indica que o vampiro se perdeu e precisa refazer o trajeto do seu cordão de prata. Uma falha crítica nesse estágio significa que o cordão se rompe, encalhando a forma psíquica do personagem no misterioso plano astral.
Uma forma astral pode viajar a grandes velocidades (o Narrador pode usar aproximadamente 1.600 quilômetros por hora como guia geral) e não carrega roupas nem objetos materiais de espécie alguma. Diz-se que alguns artefatos existem no mundo espiritual, e o personagem pode tentar usar uma dessas ferramentas se encontrar alguma. O personagem não pode trazer tais relíquias para o mundo físico ao retornar ao corpo, porém.
Interagir com o mundo físico é impossível enquanto se usa Projeção Psíquica. Na melhor das hipóteses, o personagem pode gastar um ponto de Força de Vontade para se manifestar como uma forma fantasmagórica. Essa aparição dura um turno antes de se desvanecer; embora não possa afetar nada fisicamente nesse tempo, o personagem pode falar. Apesar de não ter substância física, um personagem astral pode usar Auspícios normalmente. A critério do Narrador, tal personagem pode empregar alguns ou todos os poderes de Animalismo, Demência, Dominação, Necromancia, Tenebrosidade, Presença, Taumaturgia e poderes não corpóreos semelhantes que possua, embora isso normalmente exija no mínimo três sucessos na rolagem inicial de Projeção Psíquica.
Se duas formas astrais se encontram, elas interagem como se fossem sólidas. Podem conversar, tocar e até lutar como se ambas estivessem no mundo material. Como não têm corpos físicos, personagens astrais que buscam interagir "fisicamente" substituem os Atributos Físicos por Mentais e Sociais (Raciocínio substitui Destreza, Manipulação substitui Força e Inteligência substitui Vigor). Por causa da ausência de forma material, a única maneira real de danificar outra entidade psíquica é cortar seu cordão de prata. Ao lutar dessa forma, considere pontos de Força de Vontade como níveis de vitalidade; quando um combatente perde toda a sua Força de Vontade, o cordão é rompido.
Embora um personagem projetado astralmente permaneça no reflexo do mundo mortal, ela pode se aventurar mais fundo nos reinos espirituais, especialmente se ficar perdida. Outros seres com sensibilidade particular à atividade psíquica, como fantasmas, lobisomens e até alguns magos, também percorrem o plano astral e podem interagir normalmente com a presença psíquica de um vampiro (embora o personagem projetado astralmente não seja considerado um "fantasma" para poderes como Necromancia). O personagem observador nota o vampiro em projeção astral com uma rolagem de Percepção + Consciência (dificuldade 8), exigindo mais sucessos do que a rolagem de ativação da Projeção Psíquica. Mesmo quem nota você não conseguirá identificá-la; você é apenas uma sombra imaterial pairando pela área. Narradores são encorajados a tornar as viagens ao mundo espiritual tão bizarras, misteriosas e oníricas quanto possível. O mundo além é um lugar vívido e fantástico, onde a verdadeira natureza das coisas é mais forte e muitas vezes marcadamente diferente de sua aparência terrena.

Vendo o Invisível (p. 142)
Auspícios permite aos Membros perceber muitas coisas além dos limites de sentidos menores. Entre seus muitos usos, Auspícios pode detectar a presença de um ser sobrenatural escondido da visão normal (um vampiro usando Ofuscação, por exemplo, ou um fantasma) ou atravessar ilusões criadas pela Disciplina de Quimerismo. Nota: "Visão normal" inclui o uso regular, sem Auspícios, da perícia Consciência.
• Ofuscação: Quando um vampiro tenta usar suas percepções aguçadas para notar um Membro escondido com Ofuscação, ela detecta a presença do sujeito se seu valor de Auspícios for maior que a Ofuscação dele, e se obtiver sucesso numa rolagem de Percepção + Consciência (dificuldade igual a 7 menos o número de pontos pelos quais seu Auspícios excede a Ofuscação dele). Inversamente, se a Ofuscação do alvo superar o Auspícios dela, ele permanece por descobrir. Se os dois valores forem iguais, ambos os personagens fazem uma rolagem resistida de Percepção + Consciência (usuário de Auspícios) contra Manipulação + Subterfúgio (usuário de Ofuscação). A dificuldade para ambas as rolagens é 7, e vence o personagem com mais sucessos.
• Quimerismo: Do mesmo modo, vampiros com Auspícios podem buscar penetrar ilusões criadas com Quimerismo. Quem empunha Auspícios precisa buscar ativamente atravessar a ilusão (isto é, o jogador precisa dizer ao Narrador que seu personagem está tentando detectar uma ilusão). O usuário de Auspícios e o usuário de Quimerismo então comparam valores relativos, como em Ofuscação, acima. O processo é em tudo o mais idêntico ao de atravessar Ofuscação.
• Outros Poderes: Como os poderes de seres como magos e wraiths funcionam de modo diferente das Disciplinas vampíricas, uma comparação simples de valores relativos não se aplica. Para manter as coisas simples, ambos os personagens fazem uma rolagem resistida. O vampiro rola Percepção + Consciência, enquanto o sujeito rola Manipulação + Subterfúgio. Novamente, a dificuldade é 7, e vence o personagem com mais sucessos.]==],
				},
				["Bardo"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 442


Bardo


Esta Disciplina vem sendo transmitida desde que o próprio Osíris descobriu esse caminho. Ela envolve alcançar um estado constante de consciência mística, obtido apenas pela não-vida rígida e ascética dos Filhos. Esta Disciplina não é o mesmo estado que Golconda. Golconda é uma compreensão e aceitação de como as coisas são, enquanto as Disciplinas dos Filhos se baseiam na negação. Eles negam a Besta dentro de si concentrando-se intensamente na sua Humanidade e no seu estado de morte. Se um Filho abandonasse suas meditações e sua disciplina, seria assaltado por sua Besta.
O Filho precisa manter Humanidade igual ao seu nível mais alto de habilidade, ou perde aquela habilidade. Por exemplo, um Filho precisa ter Humanidade 9 para obter o nono nível de atingimento. Se a Humanidade do Filho alguma vez cair abaixo do nível exigido, a habilidade daquele nível é perdida e precisa ser comprada de novo com pontos de experiência. O Filho pode contrabalançar isso com Restaurar Humanitas (abaixo).
Um Filho de Osíris não pode seguir nenhum tipo de código moral que não seja a Humanidade.

• Restaurar Humanitas
A primeira coisa que os Filhos de Osíris aprendem é que a Humanidade não precisa ser um deslize inexorável rumo à depravação. Em vez disso, ela é mais parecida com uma escalada por uma encosta extremamente íngreme. O vampiro vai perder algum terreno, mas com perseverança e força pode reconquistá-lo.
Sistema: Quando o vampiro perde um ponto de Humanidade, ele pode tentar recuperá-lo sem gastar pontos de experiência usando esse poder. O Filho precisa usar esse poder dentro de uma semana da perda da Humanidade e não pode ter perdido mais Humanidade desde a perda inicial (isto é, se o personagem cai de Humanidade 8 para Humanidade 7 e depois cai para Humanidade 6 antes de usar esse poder, Restaurar Humanitas só pode ser usado para recuperar a Humanidade 7). O personagem medita por várias horas e gasta todos os pontos de sangue atualmente em seu corpo. O jogador então rola Consciência (dificuldade igual ao nível de Humanidade sendo recuperado). Se a rolagem for bem-sucedida, o personagem recupera o ponto de Humanidade e (se aplicável) o ponto de Consciência perdido numa rolagem de degeneração com falha crítica. Se o personagem ganhou um distúrbio, ele desaparece dentro de uma semana do uso de Restaurar Humanitas.

•• Sinal de Banimento de Thoth
O personagem gesticula, desviando qualquer efeito sobrenatural dirigido a ela. A fonte do efeito não importa. Ela pode frustrar, ou ao menos atenuar, a força de qualquer ataque místico. Esse sinal teria sido ensinado a Osíris por Thoth, o deus egípcio da sabedoria e da magia. O que Thoth realmente era — vampiro, mortal ou conjurador — se perdeu no tempo.
Sistema: O jogador gasta um ponto de sangue e rola Destreza + Ocultismo (dificuldade 7). Esse poder pode ser usado para "esquivar" de qualquer ataque de natureza mística que chegue, incluindo quaisquer Disciplinas que tenham o personagem como alvo (causem dano ou não). Quaisquer sucessos que o jogador role são subtraídos dos sucessos na rolagem do atacante. O sinal não serve para desviar ataques físicos magicamente potencializados; um soco de um vampiro com a Disciplina Potência ainda tem efeito pleno.

••• Dádiva de Ápis
Todos os vampiros precisam consumir sangue, por melhores que sejam suas intenções. Embora esse fato básico da não-vida não possa ser contornado, os Filhos de Osíris podem ao menos evitar beber sangue humano.
Sistema: Sangue animal é tão nutritivo para o personagem quanto sangue humano. Um animal é considerado como tendo uma reserva de sangue igual ao número de níveis de vitalidade que possui, em vez do valor menor normalmente atribuído para representar os fluidos pouco saciantes da criatura (veja a p. 270 para mais sobre beber de animais). Essa habilidade está sempre ativa.

•••• Pilar de Osíris
No centro de todo templo há um Pilar de Osíris, um lugar de meditação e poder no qual a magia dos Filhos é grandemente ampliada. Nesse nível de Bardo, o personagem aprende a criar um Pilar desses, o que significa que ele pode criar seu próprio templo.
Sistema: Criar o Pilar de Osíris exige um ritual que dura a noite inteira, com a dificuldade determinada pelo local. Quanto mais remoto e livre de violência o local, menor a dificuldade. Uma caverna longe de populações humanas que nunca viu violência pode ser dificuldade 5, enquanto o local de um homicídio-suicídio macabro numa área central seria dificuldade 9. O jogador gasta um ponto de Força de Vontade e rola Força de Vontade. O sucesso cria o Pilar, que não exige um pilar físico — o Pilar de Osíris é conceitual, não literal.
Uma vez criado o Pilar, qualquer vampiro com ao menos um ponto de Bardo recebe -3 nas dificuldades de qualquer Disciplina ou outra atividade mística (incluindo magia de sangue) realizada no Pilar. Contudo, isso exige idas regulares ao Pilar. Depois que o vampiro cria um Pilar, ele precisa visitá-lo ao menos uma vez por mês, ou o Pilar deixa de funcionar. Além disso, para cada semana que ele passa longe de um Pilar (não necessariamente o que criou), as dificuldades de todas as rolagens para evitar frenesi aumentam em um. A Besta, longamente negada pelas práticas ascéticas do Filho, cresce em força enquanto ele está longe do Pilar, e por fim empurra o vampiro ao frenesi e (provavelmente) à perda de Humanidade. Os Filhos de Osíris, por essa e outras razões, não deixam seus templos por muito tempo.

••••• Paradoxo
O Filho profere uma frase ou um enigma que expõe a verdade do universo a um ouvinte. Essa verdade — a perspectiva da importância daquele único ouvinte pesada contra a totalidade da criação — basta para imobilizar o alvo por um curto período. Embora essa experiência pareça desanimadora, depois do fato os alvos ficam relutantes em fazer mal ao Filho. Se isso se dá por uma nova apreciação do próprio lugar no mundo, ou por medo de que o vampiro revele o paradoxo outra vez, ninguém sabe ao certo.
Sistema: O vampiro fala a frase, e o jogador gasta um ponto de Força de Vontade e rola Manipulação + Ocultismo (dificuldade igual à Força de Vontade atual do ouvinte). Se houver múltiplos ouvintes, o jogador rola contra a maior dificuldade. Se a rolagem for bem-sucedida, o(s) ouvinte(s) fica(m) imobilizado(s) pela cena enquanto contempla(m) o que ouviu(ram). Golpear a vítima a tira desse estado. No fim da cena, o paradoxo se vai, e o alvo nunca consegue explicá-lo direito. Ele sofre, porém, um +1 permanente de dificuldade para ferir ou agir contra o Filho de Osíris.]==],
				},
				["Celerity"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 142


Celerity


Nem todos os vampiros são criaturas lentas e meticulosas. Quando necessário, alguns vampiros conseguem se mover rápido — muito rápido. Celeridade permite que Assamitas, Brujah e Toreador se movam com uma rapidez espantosa, tornando-se praticamente um borrão. Os Assamitas usam sua velocidade em conjunto com a furtividade para golpear rápida e cruelmente das sombras antes de serem notados. Os Brujah, por outro lado, simplesmente gostam da vantagem que o poder lhes dá contra chances esmagadoras. Os Toreador são mais inclinados a usar Celeridade para dar um ar de graça sobrenatural a apresentações ao vivo ou para um empurrão extra ao terminar uma obra-prima no prazo, mas podem ser tão rápidos em derramar sangue quanto qualquer assassino ou arruaceiro quando enfurecidos.
Sistema: Cada ponto de Celeridade acrescenta um dado a toda rolagem relacionada a Destreza. Além disso, o jogador pode gastar um ponto de sangue para realizar uma ação extra, até o número de pontos que tiver em Celeridade no início do turno em questão; esse gasto pode ultrapassar o máximo normal da sua Geração. Quaisquer pontos usados para ações extras, porém, deixam de estar disponíveis para rolagens relacionadas a Destreza durante aquele turno. Essas ações adicionais precisam ser físicas (por exemplo, o vampiro não pode usar uma Disciplina mental como Dominação várias vezes num turno), e as ações extras ocorrem no fim do turno (a ação regular do vampiro continua acontecendo conforme sua rolagem de iniciativa).
Normalmente, um personagem sem Celeridade precisa dividir seus dados se quiser realizar múltiplas ações num único turno, conforme a p. 248. Um personagem usando Celeridade realiza suas ações extras (incluindo movimento completo) sem penalidade, obtendo uma parada de dados cheia para cada ação separada. Ações extras obtidas por Celeridade não podem, por sua vez, ser divididas em múltiplas ações, porém.]==],
				},
				["Chimerstry"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 144


Chimerstry


Os Ravnos são conhecidos como mestres da ilusão, embora a razão disso esteja perdida na história. Abundam rumores de ghûls, rakshasas e metamorfos Ravnos, mas quaisquer que sejam suas origens, o Quimerismo continua sendo uma arma potente e poderosa para os Enganadores. A Disciplina é, fundamentalmente, uma arte de conjuração que converte a vontade do vampiro em fantasmas que confundem tanto os sentidos quanto a tecnologia. Até vampiros caem sob o domínio do mundo ilusório dos Ravnos, a menos que tenham um domínio suficientemente forte de Auspícios (veja a p. 142). Os Ravnos frequentemente usam esse poder para trapacear e seduzir suas vítimas a atos que acabam mal para a vítima (mas ótimos para o Ravnos).
Ilusões criadas com Quimerismo podem ser vistas pelo que são por uma vítima que "prove" a falsidade da ilusão (por exemplo, uma pessoa que caminha até uma parede ilusória, expressa sua descrença nela e atravessa a mão por ela efetivamente bane a ilusão), e ilusões explicitamente inacreditáveis são vistas como falsas de imediato (por exemplo, dragões cuspindo fogo ou a gravidade funcionando ao contrário). Às vezes, alvos frequentes de Quimerismo acabam tentando descrer de tudo à sua volta, o que leva a distúrbios (e, muito frequentemente, à diversão dos Ravnos).

• Ignis Fatuus
O vampiro pode conjurar uma miragem menor e estática que confunde um sentido. Por exemplo, ele pode evocar um fedor sulfuroso, a aparência de estigmas ou o estilhaçar de vidro quebrado. Note que, embora ilusões táteis possam ser sentidas, elas não têm substância real; uma parede invisível mas tátil não consegue confinar ninguém, e arame farpado invisível não causa dano real. Do mesmo modo, o vampiro precisa conhecer as características do que está criando. Embora seja fácil o bastante estimar a aparência de um ferimento de faca, falsificar a voz de uma pessoa ou uma fotografia da casa da infância exige conhecimento dos detalhes.
Sistema: O jogador gasta um ponto de Força de Vontade para que o vampiro crie essa ilusão. O volume de cheiros, iluminação ambiente, nuvens de fumaça e afins é limitado a aproximadamente meio metro cúbico por ponto que o vampiro tenha em Quimerismo. A ilusão dura até que o vampiro deixe as imediações dela (como sair da sala) ou até que outra pessoa a desmascare de algum modo. O Cainita também pode encerrar a ilusão a qualquer momento sem esforço.

•• Fata Morgana
O Cainita agora consegue criar ilusões que apelam a todos os sentidos, embora permaneçam estáticas. Por exemplo, o vampiro poderia fazer um porão imundo parecer um salão de baile opulento, embora não pudesse criar um lustre reluzente nem uma dezena de dançarinos graciosos. De novo, a ilusão não tem presença sólida, embora seja fácil o bastante enganar uma visitante extasiada com sugestões do que ela pode esperar. Um balde de água salobra é tão gelado quanto champanhe gelado, afinal.
Sistema: O jogador gasta um ponto de Força de Vontade e um ponto de sangue para criar a ilusão. Essas imagens estáticas permanecem até serem dissipadas, muito da mesma forma que uma ilusão de Ignis Fatuus.

••• Aparição
Não é realmente um poder por si só; Aparição permite ao vampiro dar movimento a uma ilusão criada com Ignis Fatuus ou Fata Morgana. Assim, o Cainita poderia criar a ilusão de um ser vivo, de água corrente, de cortinas ondulando ou de um fogo crepitante.
Sistema: O criador gasta um ponto de sangue para fazer a ilusão se mover de uma maneira significativa, ou de qualquer número de maneiras sutis. Por exemplo, o vampiro poderia criar a ilusão de um assaltante à espreita avançando sobre sua vítima, ou poderia criar a ilusão de uma rua desolada, pela qual um vento gelado sopra lixo enquanto um poste de luz pisca e zumbe. Realizar ações complicadas além de manter a ilusão — isto é, qualquer coisa que exigiria uma rolagem de dados — exige primeiro sucesso numa rolagem de Força de Vontade, resultando na dissolução do falso constructo se a rolagem falhar.
Uma vez que o criador para de se concentrar na ilusão, ela pode continuar em movimentos simples e repetitivos – grosso modo, qualquer coisa que possa ser descrita numa frase simples, como um guarda andando de um lado para outro diante de uma porta de aço. Depois disso, o vampiro não pode retomar o controle sobre a ilusão – ela pode ou permitir que continue se movendo como ordenado, ou deixá-la se desvanecer conforme descrito em Ignis Fatuus.

•••• Permanência
Este poder, também usado em conjunto com Ignis Fatuus ou Fata Morgana, permite que uma miragem persista mesmo quando o vampiro não consegue vê-la. Dessa forma, os Ravnos frequentemente encobrem seus refúgios temporários com falsos ornamentos de luxo, ou afastam invasores com cães de guarda ilusórios.
Sistema: O vampiro só precisa gastar um ponto de sangue, e a ilusão se torna permanente até ser dissolvida (incluindo ilusões "programadas" como as criadas por Aparição).

••••• Realidade Horrenda
Em vez de criar ilusões simples, o vampiro agora consegue projetar alucinações diretamente na mente de uma vítima. O alvo dessas ilusões acredita completamente que as imagens são reais; um fogo alucinatório pode queimá-lo, um laço imaginário pode estrangulá-lo e uma parede ilusória pode bloqueá-lo. Esse poder afeta apenas uma pessoa por vez; embora outros possam ver a ilusão, ela não os atinge da mesma forma. Outras pessoas podem tentar convencer a vítima de que seus terrores não são reais, mas ele não acreditará nelas. Note que alvos com pontos suficientes em Auspícios ainda podem tentar rolar para Vendo o Invisível (p. 142).
Sistema: Uma ilusão de Realidade Horrenda custa dois pontos de Força de Vontade para ser posta em movimento e dura uma cena inteira (embora seus efeitos possam durar mais; veja abaixo). Se o vampiro estiver tentando ferir sua vítima, seu jogador precisa rolar Manipulação + Subterfúgio (dificuldade igual à Percepção + Autocontrole/Instinto da vítima). Cada sucesso inflige um nível de vitalidade de dano letal na vítima, que não pode ser absorvido — o Cainita ataca a mente e as percepções da vítima, não seu corpo. Se o jogador quiser infligir menos dano ou mudá-lo para dano por contusão, pode anunciar uma quantidade máxima de dano antes de rolar os dados. Efeitos secundários (como rolagens de frenesi por causa de fogo ilusório) também podem ocorrer.
A vítima cura todo o seu dano instantaneamente se puder ser convencida de que o dano que sofreu era ilusório, mas convencê-la pode dar trabalho, como com ao menos dois sucessos numa rolagem de Carisma + Empatia (dificuldade igual à Manipulação + Subterfúgio do Cainita usando Realidade Horrenda). O alvo precisa ser convencido da natureza ilusória do ataque dentro de 24 horas de sua ocorrência, ou ele se estabelece bem demais na memória dele, e ele terá de curar o dano usando sangue (se for vampiro) ou com o tempo (se for mortal).
Este poder não pode de fato matar suas vítimas (embora um alvo com problema cardíaco possa muito bem morrer de susto). Uma vítima "morta" por um ataque ilusório perde a consciência ou entra em torpor.]==],
				},
				["Daimonion"] = {
					pt = [==[Vampire: The Dark Ages 20th Anniversary Edition, pág. 208


Daimonion


Arrancada dos sussurros daqueles presos à terra, uma voz rasgada da garganta dos primeiros feiticeiros que chamaram pelo Abismo canta através do sangue Baali. Daimonion é um grito através da Criação, estendendo-se deste mundo até um lugar abandonado, e o poder vem junto com o eco que retorna. Um dia a linhagem Baali gritará, e esse brado despedaçará o mundo. Por ora, eles usam Daimonion para embalar suavemente os outros no sono e mandá-los sonhar com fogo e escuridão.
Personagens com Fé Verdadeira são mais resistentes à escuridão dos Baali. Subtraia o valor de Fé Verdadeira da vítima de todas as rolagens para ativar poderes de Daimonion contra ela. Isso inclui rolagens secundárias de mira, como a rolagem para acertar com Essência Atormentada.

• Sentir o Pecado
Toda joia tem uma falha, e todo homem tem um vício. O melhor jeito de despedaçar uma joia é golpear aquela falha, e o melhor jeito de despedaçar um homem é martelar seu vício. Esse poder permite ao Baali encontrar o vício particular de um alvo e colher seus segredos com um olhar.
Sistema: Role Percepção + Empatia contra seres vivos ou mortos-vivos; a dificuldade é igual ao Autocontrole ou Instinto do sujeito +4. O sucesso indica que o Baali obteve uma percepção da fraqueza do sujeito. Com um sucesso, isso é informação como uma Virtude baixa, Força de Vontade fraca ou ações recentes que violaram o Caminho do sujeito. Dois sucessos podem render um vício estimado ou um segredo casual. Três ou mais rendem um Distúrbio central ou um trauma formativo do passado do sujeito.

•• Medo do Vazio
Uma vez que você conhece os vícios de um sujeito, manipulá-los é fácil. Converter vícios de prazer em ondas de terror existencial é um truque maior. Falando em tons suaves de horror primevo, o Baali inflama os traumas da sua vítima.
Sistema: O Baali precisa primeiro usar com sucesso Sentir o Pecado ou outro método para descobrir os segredos ou medos do alvo. Ela precisa então falar com o alvo, zombando das inseguranças dele com o tom de voz. Uma rolagem bem-sucedida de Raciocínio + Intimidação (dificuldade da Coragem do sujeito +4) leva a vítima a acessos furiosos de terror. Dois sucessos causam fuga em pânico semelhante ao Rötschreck, enquanto três causam um Distúrbio inflamado (escolha do Narrador) e quatro ou mais causam catatonia. Todos os efeitos duram o resto da cena. Mortais e criaturas sobrenaturais ligadas a emoções fortes (como feéricos ou fantasmas) não podem contestar essa rolagem; outras criaturas sobrenaturais podem fazer uma rolagem resistida de Coragem (dificuldade da Força de Vontade do Baali).

••• Essência Atormentada
Os Baali conhecem seu lugar no universo e dentro da hierarquia de seus mestres. O sofrimento escorre para baixo, e os Baali estão dentro dessa torrente. Invocando o tormento em seu sangue, o Baali pode arremessar um dardo flamejante de dor infernal contra seus inimigos. Nervos gritam, madeira vira cinza, pedra derrete e a carne se desintegra por completo.
Sistema: Gaste um ponto de sangue. O personagem reúne dor infernal nas mãos; mais comumente isso se manifesta como um dardo de chama negra, mas relâmpagos de tonalidade nauseante ou tentáculos negros e viscosos são igualmente comuns. Seja como for, o poder cria um projétil que inflige um dado de dano agravado. Mais pontos de sangue podem ser gastos para aumentar o tamanho e o dano do projétil, a um dado por ponto. O jogador rola Destreza + Ocultismo (dificuldade 6) para acertar o alvo, que pode se esquivar normalmente. Como em qualquer ataque normal, os sucessos somam-se à parada de dados de dano. Vampiros confrontados com esse poder fazem testes de Rötschreck (dificuldade 8), independentemente da forma do poder. Curiosamente, esse poder é duplamente eficaz contra demônios e outros espíritos, cujas formas corpóreas reagem mal à matéria do tormento. Contra tais criaturas, cada ponto de sangue vira dois dados de dano em vez de um.

•••• Psicomaquia
Prudêncio foi um poeta romano que escreveu a Psychomachia – "a Batalha das Almas", descrevendo a luta da fé contra a idolatria e o vício. Os Baali conhecem esse jogo, e jogam para vencer. Com esse poder, o vampiro combina a capacidade de ler a psique de uma vítima com a capacidade de dilacerar matéria espiritual. Psicomaquia sopra vida infernal no vício do alvo, forçando a vítima a bancar a heroína e literalmente lutar contra seus demônios interiores.
Sistema: Depois de usar Sentir o Pecado com sucesso, o vampiro força o alvo a rolar sua Virtude mais baixa (dificuldade da Força de Vontade do Baali). Falhar nessa rolagem traz à tona quaisquer Distúrbios que o alvo possua, opondo-os a uma aparição personificada do vício da vítima invocada do seu eu mais sombrio. Uma falha crítica indica que o alvo foi sobrepujado e entra em frenesi — ou é possuído pelo seu passageiro sombrio. Uma falha resulta numa luta literal entre os dois, embora isso possa tomar a forma de qualquer conflito, como uma discussão abusiva em vez de uma batalha física.
O agressor é um personagem do Narrador com traços equivalentes ou ligeiramente inferiores aos da vítima. Alvos com pontuação baixa de Caminho enfrentam uma oposição significativamente mais poderosa (+1 em todos os traços para cada nível de Caminho abaixo de 5). Os ferimentos infligidos pela mente são ilusórios, embora possam forçar um mortal à catatonia ou um vampiro ao torpor com uma "morte" fantasma. O fantasma desaparece com a derrota deles ou com a perda de concentração do Baali.

••••• Condenação
Os Filhos de Baal saboreiam a oportunidade de importunar energias sombrias para dentro do mundo desperto. Com esse poder, o Baali impõe uma maldição à sua vítima, valendo-se da força atormentada do seu sangue para impor sua vontade ao destino.
Sistema: Uma rolagem de Inteligência + Ocultismo (dificuldade igual à Força de Vontade do sujeito) determina a duração e a severidade da maldição. Os sucessos precisam ser divididos entre esses dois efeitos, conforme o quadro abaixo.
Maldições com zero sucessos alocados à duração duram uma noite. O Baali pode escolher encerrar a maldição a qualquer momento, mas raramente o faz. Narradores devem se sentir à vontade para inventar maldições criativas ou apropriadas à história. Com cinco sucessos, um Baali pode arrancar um demônio de um hospedeiro mortal ou de uma relíquia e atirá-lo de volta ao Inferno, mas só o fazem contra os mais recalcitrantes.
Condenação
1 sucesso — Até uma semana — "Suas pisadas mais leves são como pisões infantis." — Todas as rolagens de Furtividade ficam com +3 de dificuldade.
2 sucessos — Um mês — "Adoeça e definhe, e sinta a fraqueza do seu sangue." — A dificuldade de todas as rolagens de Vigor aumenta em dois, ou o vampiro perde quatro dados de absorção.
3 sucessos — Um ano — "Viva para sempre com medo: aqueles que você respeita buscam sua traição." — O vampiro sofre dificuldades aumentadas em rolagens Sociais, ou o personagem não pode se beneficiar de Aliados ou Contatos.
4 sucessos — Dez anos — "Sinta esmagado o deuszinho nas suas veias, e desaparecida sua futura prole." — O personagem não pode Abraçar cria nem criar carniçais.
5 sucessos — Permanente — "A perdição estará sobre você, e seus passos em falso se tornarão fatais e definitivos." — Falhas simples são consideradas falhas críticas.]==],
				},
				["Dark Thaumaturgy"] = {
					pt = [==[Rites of Blood, pág. 112


Dark Thaumaturgy


A Taumaturgia Negra é expressamente definida como "feitiçaria ensinada por demônios". Como tal, a Taumaturgia Negra é absoluta, descaradamente e cruelmente maligna. Outros itens também caem nesse domínio. A Disciplina Baali de Daimoinon, que exige que o usuário invoque nomes demoníacos e profira bênçãos infernais, é infernal e corrompe a alma do usuário a cada uso. Todos esses poderes exigem a perda de um ponto de moralidade no primeiro uso, e testes continuados contra a Consciência do personagem a cada vez que forem usados depois da primeira — a menos que o usuário de tais poderes tenha trocado sua moralidade pelo Caminho das Revelações Malignas. Alguns exemplos começam na p. 167.]==],
				},
				["Dementation"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 147


Dementation


Demência é a Disciplina que permite a um vampiro focar e canalizar loucura para dentro das mentes daqueles à sua volta. Embora seja o legado natural dos Malkavianos, praticantes de Demência não precisam de fato ser loucos para usar a Disciplina… mas ajuda.
De modo perturbador, Demência não deixa suas vítimas loucas de verdade; em vez disso, ela parece derrubar as portas da escuridão escondida na mente do alvo, soltando ao ar livre o que quer que se encontre lá. Os Malkavianos afirmam que isso se dá porque a insanidade é o próximo passo lógico na evolução mental, um avanço trans-humanista daquilo que as pessoas modernas consideram consciência. Outros Membros zombam de que esse raciocínio é uma justificativa escancarada para o caos que a Demência traz. Não zombam alto demais, porém, para que o Malkaviano não resolva avançar a consciência deles em seguida.

• Paixão
O vampiro agita as emoções da sua vítima, ou intensificando-as até um ponto febril, ou embotando-as até que o alvo esteja completamente dessensibilizado. O Cainita não pode escolher qual emoção é afetada; ela só pode amplificar ou embotar emoções já presentes no alvo. Dessa forma, um vampiro pode inflamar uma irritação leve até uma raiva trêmula, ou atrofiar o amor verdadeiro até um interesse casual.
Sistema: O personagem conversa com sua vítima, e o jogador do vampiro rola Carisma + Empatia (dificuldade igual ao valor de Humanidade ou Caminho da vítima). O número de sucessos determina a duração do estado alterado de sentimento. Efeitos desse poder podem incluir acréscimos ou reduções de um ou dois pontos nas dificuldades de rolagens de frenesi, rolagens de Virtude, rolagens para resistir a poderes de Presença, etc.
1 sucesso — Um turno
2 sucessos — Uma hora
3 sucessos — Uma noite
4 sucessos — Uma semana
5 sucessos — Um mês
6+ sucessos — Três meses

•• A Assombração
O vampiro manipula os centros sensoriais do cérebro da sua vítima, inundando os sentidos dela com visões, sons, cheiros ou sensações que não estão realmente ali. As imagens, independentemente do sentido a que apelam, são apenas "vislumbres" fugazes, mal perceptíveis para a vítima. O vampiro que usa Demência não pode controlar o que a vítima percebe, mas pode escolher qual sentido é afetado.
Os efeitos da "assombração" ocorrem principalmente quando a vítima está sozinha, e sobretudo à noite. Podem tomar a forma dos medos reprimidos do sujeito, de memórias culposas ou de qualquer outra coisa que o Narrador considere dramaticamente apropriada. Os efeitos nunca são agradáveis nem discretos, porém. O Narrador deve deixar sua imaginação correr solta ao descrever essas impressões sensoriais; a vítima pode muito bem sentir que está enlouquecendo, ou que o mundo está.
Sistema: Depois que o vampiro fala com a vítima, o jogador gasta um ponto de sangue e rola Manipulação + Subterfúgio (dificuldade da Percepção + Autocontrole/Instinto da vítima). O número de sucessos determina a duração das "visitações" sensoriais. Os efeitos precisos ficam a cargo do Narrador, embora aparições especialmente sinistras ou dilacerantes possam certamente reduzir paradas de dados por um turno ou dois após a manifestação.
1 sucesso — Uma noite
2 sucessos — Duas noites
3 sucessos — Uma semana
4 sucessos — Um mês
5 sucessos — Três meses
6+ sucessos — Um ano

••• Olhos do Caos
Este poder peculiar permite ao vampiro tirar proveito da clareza fugaz escondida na insanidade. Ela pode escrutinar os "padrões" da alma de uma pessoa, as circunvoluções da natureza interior de um vampiro, ou até eventos aleatórios na própria natureza. O Membro com esse poder pode discernir as psicoses mais bem escondidas ou obter uma percepção do verdadeiro eu de uma pessoa. Malkavianos com esse poder frequentemente têm (ou afirmam ter) conhecimento dos lances e contra-lances da grande Jyhad, ou dos padrões do destino.
Sistema: Este poder permite a um vampiro determinar a verdadeira Natureza de uma pessoa, entre outras coisas. O vampiro se concentra por um turno, e então sua jogadora rola Percepção + Ocultismo. A dificuldade depende da complexidade do padrão. Discernir a Natureza de um estranho seria dificuldade 9, de um conhecido casual seria 8, e de um aliado estabelecido, 6. O vampiro também poderia ler a mensagem trancada numa missiva cifrada (dificuldade 7), ou até ver a atuação de uma mão invisível em eventos como o padrão das folhas caindo (dificuldade 6). Quase qualquer coisa pode conter alguma percepção escondida, por mais trivial ou sem sentido que seja. Os padrões estão presentes na maioria das coisas, mas são muitas vezes tão intrincados que podem manter um vampiro enfeitiçado por horas enquanto tenta compreender sua mensagem.
Este é um poder potente, sujeito a arbitragem. Narradores, este poder é uma forma eficaz de introduzir fios de trama para uma crônica, revelar uma pista negligenciada, prenunciar eventos importantes ou comunicar informação crítica que um jogador procura. Importante no seu uso, porém, é entregar a informação da maneira certa. Segredos revelados por Olhos do Caos nunca são fatos simples; são símbolos instigantes à deriva num mar de loucura. Descreva os resultados desse poder em termos de alegoria: "O homem diante de você aparece como uma marionete tosca, com feições berrantes pintadas em maquiagem de palco vistosa, e cordões sumindo noite acima". Evite afirmar secamente: "Você descobre que este carniçal é lacaio de um Matusalém poderoso".

•••• Voz da Loucura
Meramente dirigindo-se em voz alta às suas vítimas, o Membro pode levar alvos a acessos de raiva ou medo cego, forçando-os a abandonar a razão e o pensamento superior. As vítimas são atormentadas por alucinações de seus demônios subconscientes e tentam fugir ou destruir suas vergonhas ocultas. A tragédia quase sempre segue no rastro do uso desse poder, embora os Malkavianos ofensores frequentemente aleguem que estavam apenas encorajando as pessoas a agir "de acordo com suas naturezas". Infelizmente para o vampiro em questão, ele corre um risco bem real de cair vítima do poder da própria voz.
Sistema: O jogador gasta um ponto de sangue e faz uma rolagem de Manipulação + Empatia (dificuldade 7). Um alvo é afetado por sucesso, embora todas as vítimas potenciais precisem estar ouvindo a voz do vampiro.
As vítimas afetadas entram imediatamente em frenesi ou num medo cego como o Rötschreck. Membros ou outras criaturas capazes de frenesi, como Lupinos, podem fazer um teste de frenesi ou de Rötschreck (escolha do Narrador quanto ao modo como são afetados) com +2 de dificuldade para resistir ao poder. Mortais são afetados automaticamente e não se lembram de suas ações enquanto enlouquecidos. O frenesi ou o medo dura uma cena, embora vampiros e Lupinos possam testar normalmente para sair dele.
O vampiro que usa Voz da Loucura também precisa testar frenesi ou Rötschreck ao invocar esse poder, embora sua dificuldade para resistir seja um ponto menor que o normal. Se a rolagem inicial para invocar o poder for uma falha, porém, a rolagem para resistir ao frenesi é um ponto maior que o normal. Se a rolagem para invocar o poder for uma falha crítica, a resposta de frenesi ou Rötschreck é automática.

••••• Insanidade Total
O vampiro atrai a loucura dos recessos mais profundos da mente do seu alvo, focando-a numa onda avassaladora de insanidade. Este poder levou incontáveis vítimas, vampiros e mortais igualmente, a fins infelizes.
Sistema: O Membro precisa obter a atenção indivisa do seu alvo por ao menos um turno inteiro para executar esse poder. O jogador gasta um ponto de sangue e rola Manipulação + Intimidação (dificuldade dos pontos atuais de Força de Vontade da vítima). Se a rolagem for bem-sucedida, a vítima é afligida com cinco distúrbios à escolha do Narrador (veja a p. 290). O número de sucessos determina a duração.
1 sucesso — Um turno
2 sucessos — Uma noite
3 sucessos — Uma semana
4 sucessos — Um mês
5+ sucessos — Um ano
Numa falha crítica… bem, o Narrador pode decidir o que um vampiro inflige a si mesmo ao tentar incitar os infernos primais que espreitam nos recessos mais escuros da mente de uma vítima.
A vítima (ou o alvo de uma falha crítica) pode gastar um número de pontos de Força de Vontade igual aos sucessos rolados para encerrar a duração prematuramente. O Narrador decide quando esses pontos de Força de Vontade podem ser gastos (como depois de uma sessão de terapia ou depois que um amigo conseguiu provar que determinado delírio é falso).]==],
				},
				["Dominate"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 151


Dominate


Dominação é uma das Disciplinas mais temidas. É a capacidade de um vampiro influenciar os pensamentos e as ações de outra pessoa pela sua própria força de vontade. Dominação exige que o vampiro capture o olhar da vítima (veja a p. 152); assim sendo, só pode ser usada contra um sujeito por vez. Além disso, as ordens precisam ser dadas verbalmente, embora ordens simples possam ser feitas por sinais — por exemplo, um dedo apontado e uma expressão enérgica para indicar "Vá!". Contudo, o sujeito não obedecerá se não conseguir entender o vampiro, por mais poderosa que seja a vontade do Membro.
Talvez sem surpresa, vampiros para quem Dominação vem naturalmente tendem a ser de Clãs obstinados e mandões. Os Giovanni, Lasombra, Tremere e Ventrue todos consideram uma vontade de ferro uma bênção, e são ávidos por impor essa vontade de ferro a quem quer que se mova contra eles.

• Comando
O vampiro trava os olhos nos do sujeito e fala uma ordem de uma palavra, que o sujeito precisa obedecer instantaneamente. A ordem precisa ser clara e direta: corra, concorde, caia, boceje, pule, ria, renda-se, pare, grite, siga. Se a ordem for de algum modo confusa ou ambígua, o sujeito pode responder lentamente ou executar a tarefa mal. O sujeito não pode receber ordem de fazer algo diretamente prejudicial a si mesmo, de modo que uma ordem como "morra" é ineficaz.
A ordem pode ser incluída numa frase, ocultando assim dos outros o uso do poder. Esse esforço de sutileza ainda exige que o Membro faça contato visual no momento certo e enfatize ligeiramente a palavra-chave. Um espectador atento — ou até a vítima — pode notar a ênfase. Ainda assim, a menos que ela seja versada em poderes sobrenaturais, o indivíduo provavelmente atribuirá a fala e a ação subsequente a uma coincidência bizarra.
Sistema: O jogador rola Manipulação + Intimidação (dificuldade igual aos pontos atuais de Força de Vontade do alvo). Mais sucessos forçam o sujeito a agir com maior vigor ou por uma duração mais longa (continuar correndo por um número de turnos, cair num ataque de riso, gritar incontrolavelmente).
Lembre também que ser mandado a agir contra a própria Natureza atrapalha o uso desse poder. Ouvir "durma!" numa situação perigosa ou "ataque!" sob custódia policial pode não ter o efeito desejado, ou de fato efeito algum.

•• Mesmerizar
Com esse poder, um vampiro pode implantar verbalmente um pensamento falso ou uma sugestão hipnótica na mente subconsciente do sujeito. Tanto o Membro quanto o alvo precisam estar livres de distração, pois Mesmerizar exige concentração intensa e formulação precisa para ser eficaz. O vampiro pode ativar o pensamento imposto imediatamente ou estabelecer um estímulo que o dispare depois. A vítima precisa conseguir entender o vampiro, embora os dois só precisem manter contato visual pelo tempo necessário para implantar a ideia.
Mesmerizar permite qualquer coisa, de diretrizes simples e precisas (entregar um item) a outras complexas e muito elaboradas (anotar os hábitos de alguém e transmitir essa informação num horário marcado). Não serve para plantar ilusões ou memórias falsas (como ver um coelho ou acreditar estar em chamas). Um sujeito só pode ter uma sugestão implantada por vez.
Sistema: O jogador rola Manipulação + Liderança (dificuldade igual aos pontos atuais de Força de Vontade do alvo). O número de sucessos determina o quão bem a sugestão se fixa no subconsciente da vítima. Se o vampiro obtiver um ou dois sucessos, o sujeito não pode ser forçado a fazer nada que lhe pareça estranho (ela pode sair andando, mas dificilmente roubaria um carro). Com três ou quatro sucessos, a ordem é eficaz a menos que segui-la coloque o sujeito em perigo. Com cinco sucessos ou mais, o vampiro pode implantar praticamente qualquer tipo de ordem.
Por mais forte que seja a vontade do Membro, sua ordem não pode forçar o sujeito a ferir a si mesma diretamente nem a desafiar sua Natureza inata. Assim, embora um vampiro que obtivesse cinco sucessos pudesse fazer um fracote de 45 quilos atacar um leão de chácara de 135 quilos, ele não conseguiria fazer a mortal atirar na própria cabeça.
Se um vampiro tentar Mesmerizar um sujeito antes que o alvo cumpra uma diretriz implantada anteriormente, compare os sucessos rolados com os obtidos ao implantar a primeira sugestão. A rolagem com o maior número de sucessos é a ordem que passa a governar o comportamento do alvo; a outra sugestão é apagada. Se os sucessos rolados forem iguais, a ordem mais nova suplanta a antiga.

••• A Mente Esquecida
Depois de capturar o olhar do sujeito, o vampiro mergulha nas memórias dele, roubando-as ou recriando-as a seu bel-prazer. A Mente Esquecida não permite contato telepático; o Membro opera muito como um hipnotizador, fazendo perguntas dirigidas e extraindo respostas do sujeito. O grau de alteração da memória depende do que o vampiro deseja. Ele pode alterar a mente do sujeito apenas ligeiramente (bastante eficaz para eliminar memórias de a vítima ter encontrado o vampiro ou até ter sido alimento dele) ou desfazer por completo as memórias que ela tem do próprio passado.
O grau de detalhe empregado tem influência direta sobre o quão fortemente as novas memórias se fixam, pois a mente subconsciente da vítima resiste à alteração. Uma memória falsa simplista ou incompleta ("Você foi ao cinema ontem à noite") desmorona muito mais rápido do que uma com mais atenção ao detalhe ("Você pensou em mandar mensagem para sua namorada enquanto estava na fila do cinema novo, mas sabia que teria de desligar o celular ao entrar. Você gostou razoavelmente do filme, mas o enredo pareceu fraco. Você estava cansado quando acabou, então foi para casa, assistiu um pouco de televisão de madrugada e foi dormir.").
Mesmo nas suas aplicações mais simples, A Mente Esquecida exige tremenda habilidade e finesse. É relativamente simples vasculhar a psique de uma vítima e arrancar as memórias da noite anterior sem saber o que o sujeito fez naquela noite. Fazer isso deixa uma lacuna na mente da vítima, porém — um buraco que pode dar origem a mais problemas adiante. O Membro pode descrever memórias novas, mas essas lembranças raramente têm o mesmo grau de realismo que os pensamentos originais do sujeito tinham.
Assim sendo, esse poder nem sempre é completamente eficaz. A vítima pode se lembrar de ter sido mordida, mas acreditar que foi um ataque animal. Memórias maiores podem voltar em pedaços na forma de sonhos, ou por gatilhos sensoriais como um odor familiar ou uma frase falada. Mesmo assim, meses ou anos podem passar antes que o sujeito recupere memórias perdidas suficientes para dar sentido aos fragmentos.
Um vampiro também pode sentir quando as memórias de um sujeito foram alteradas pelo uso desse poder, e até restaurá-las, como um hipnotizador extrai pensamentos reprimidos.
Sistema: O jogador declara que tipos de alteração quer realizar e então rola Raciocínio + Subterfúgio (dificuldade igual aos pontos atuais de Força de Vontade do alvo). Qualquer sucesso pacifica a vítima pelo tempo que o vampiro levar para realizar a alteração verbal, contanto que o vampiro não aja agressivamente com ela. A tabela abaixo indica o grau de modificação possível na memória do sujeito. Se os sucessos rolados não permitirem a extensão de mudança que o personagem desejava, o Narrador reduz o impacto resultante na mente da vítima.
1 sucesso — Pode remover uma única memória; dura um dia.
2 sucessos — Pode remover permanentemente, mas não alterar, uma memória.
3 sucessos — Pode fazer pequenas mudanças na memória.
4 sucessos — Pode alterar ou remover uma cena inteira da memória do sujeito.
5 sucessos — Pode reconstruir períodos inteiros da vida do sujeito.
Para restaurar memórias removidas ou detectar memórias falsas num sujeito, o valor de Dominação do personagem precisa ser igual ou maior que o do vampiro que fez a alteração. Nessa situação, o jogador precisa fazer uma rolagem de Raciocínio + Empatia (dificuldade igual à Força de Vontade permanente do vampiro original) e obter mais sucessos do que seu predecessor obteve. Contudo, o Membro não pode usar A Mente Esquecida para restaurar as próprias memórias se elas foram roubadas dessa maneira.

•••• Condicionamento
Por meio de manipulação sustentada, o vampiro pode tornar um sujeito mais maleável à vontade do Membro. Com o tempo, a vítima se torna cada vez mais suscetível à influência do vampiro, ao mesmo tempo em que fica mais resistente aos esforços corruptores de outros Membros. Obter controle completo sobre a mente de um sujeito não é tarefa pequena, levando semanas ou até meses para ser realizada.
Membros frequentemente enchem a cabeça de seus lacaios com sussurros sutis e impulsos velados, garantindo assim a lealdade desses mortais. Ainda assim, vampiros precisam pagar um preço alto pelas mentes que enredam. Servos Dominados dessa forma perdem muito de sua paixão e individualidade. Seguem as ordens do vampiro bem ao pé da letra, raramente tomando iniciativa ou mostrando qualquer imaginação. No fim, esses lacaios se tornam como autômatos ou mortos-vivos ambulantes.
Sistema: O jogador rola Carisma + Liderança (dificuldade igual aos pontos atuais de Força de Vontade do alvo) uma vez por cena. Condicionamento é uma ação estendida, para a qual o Narrador determina em segredo o número de sucessos necessários. Costuma exigir entre cinco e 10 vezes o valor de Autocontrole/Instinto do sujeito. Alvos com Naturezas mais empáticas podem exigir um número menor de sucessos, enquanto os de Naturezas obstinadas exigem um total maior. Só pela interpretação um personagem pode discernir se seu sujeito foi condicionado com sucesso.
Um alvo pode se tornar mais tratável mesmo antes de estar plenamente condicionado. Uma vez que o vampiro acumule metade do número de sucessos necessários, o Narrador pode aplicar uma dificuldade menor aos usos subsequentes de Dominação pelo vampiro. Depois de condicionado, o alvo cai tão profundamente sob a influência do vampiro que o Membro não precisa fazer contato visual nem sequer estar presente para manter controle absoluto. O sujeito faz exatamente o que lhe é dito (incluindo tomar ações que a machucariam), contanto que seu mestre consiga se comunicar com ela verbalmente. Nenhuma rolagem de comando é necessária a menos que o sujeito esteja totalmente isolado da presença do vampiro (em outro cômodo, ao telefone). Mesmo que uma rolagem de comando falhe, o alvo ainda provavelmente cumprirá parte das ordens dadas, simplesmente porque seu mestre assim deseja.
Depois que o sujeito está plenamente condicionado, outros Membros a acham mais difícil de Dominar. Tal condicionamento aumenta as dificuldades dos outros em dois (até um máximo de 10).
É possível, embora difícil, se livrar do Condicionamento. O sujeito precisa ser separado inteiramente do vampiro a quem estava subjugada. Esse período de separação varia conforme o indivíduo, mas o Narrador pode fixá-lo em seis meses, menos um número de semanas igual à Força de Vontade permanente do sujeito (de modo que uma pessoa com Força de Vontade 5 precisa ficar longe do vampiro por pouco menos de cinco meses). O sujeito recupera sua personalidade lentamente durante esse tempo, embora ainda possa recair em breves acessos de apatia, desespero ou até raiva. Se o vampiro encontrar o alvo antes que esse tempo passe, uma única rolagem bem-sucedida de Carisma + Liderança (dificuldade dos pontos atuais de Força de Vontade do alvo) por parte do vampiro reafirma completamente o domínio.
Se o sujeito atravessar o período sem intervenção do seu mestre, o alvo recupera sua antiga individualidade. Mesmo assim, o vampiro pode restabelecer o condicionamento mais facilmente do que na primeira vez, pois o sujeito agora está predisposto a cair sob o controle mental do Membro. Novas tentativas exigem metade do número total de sucessos que a última rodada de condicionamento exigiu (o que significa que o sujeito também alcança mais cedo o limiar para dificuldades reduzidas).

••••• Possessão
Nesse nível de Dominação, a força da psique do Membro é tal que pode suplantar por completo a mente de um sujeito mortal. Falar não é necessário, mas o vampiro precisa capturar o olhar da vítima. Durante a luta psíquica, os olhos dos contendores ficam travados um no outro.
Uma vez que o Membro sobrepuja a mente do sujeito, o vampiro move sua consciência para dentro do corpo da vítima e o controla tão facilmente quanto usa o próprio. A mortal cai numa fuga mental enquanto está possuída. Ela tem consciência dos eventos apenas de forma distorcida e onírica. Em contrapartida, a mente do vampiro se concentra inteiramente em controlar seu sujeito mortal. O próprio corpo dele jaz num estado torporoso, indefeso contra quaisquer ações dirigidas a ele.
Vampiros não podem possuir uns aos outros dessa forma, pois até a mente do Membro mais fraco é forte o bastante para resistir a esse domínio mental direto. Só por meio de um laço de sangue um vampiro pode controlar outro nesse grau. Criaturas sobrenaturais também não podem ser possuídas dessa maneira, embora carniçais que tenham bebido do vampiro que usa Possessão possam.
Sistema: O vampiro precisa despojar completamente a Força de Vontade do alvo antes de possuí-la. O jogador gasta um ponto de Força de Vontade e então rola Carisma + Intimidação, enquanto o sujeito rola sua Força de Vontade numa ação resistida (dificuldade 7 para cada). Para cada sucesso que o vampiro obtiver acima do total da vítima, o alvo perde um ponto temporário de Força de Vontade. Só se o atacante obtiver falha crítica é que o sujeito pode escapar do seu destino, pois isso torna o alvo imune a quaisquer outras tentativas de Dominação daquele vampiro pelo resto da história.
Uma vez que o alvo perde toda a sua Força de Vontade temporária, sua mente está aberta. O vampiro rola Manipulação + Intimidação (dificuldade 7) para determinar quão plenamente ele assume o controle da casca mortal. Semelhante ao poder de Animalismo Absorver o Espírito, múltiplos sucessos permitem ao personagem utilizar algumas Disciplinas mentais, indicadas na tabela abaixo. (Vampiros possuindo carniçais podem usar as Disciplinas físicas que o carniçal possui, mas não as mentais.)
1 sucesso — Não pode usar Disciplinas
2 sucessos — Pode usar Auspícios e outros poderes sensoriais
3 sucessos — Pode também usar Presença e outros poderes de manipulação emocional
4 sucessos — Pode também usar Demência, Dominação e outros poderes de manipulação mental
5 sucessos — Pode também usar Quimerismo, Necromancia, Taumaturgia e outros poderes místicos
O personagem pode viajar tão longe do próprio corpo quanto for fisicamente capaz enquanto possui o mortal. O vampiro também pode se aventurar durante o dia na forma mortal. Contudo, o próprio corpo do vampiro precisa estar acordado para isso, exigindo uma rolagem bem-sucedida para permanecer acordado (veja a p. 262). Se o vampiro deixar a casca mortal (por escolha, se seu corpo adormecer, por expulsão sobrenatural, após sofrer ferimento significativo, etc.), sua consciência retorna à forma física num instante.
Uma vez libertada da possessão, a mortal recupera o controle mental de si mesma. Isso pode acontecer num instante, ou a vítima pode ficar comatosa por dias enquanto sua psique lida com a violação.
O vampiro experimenta tudo o que o corpo mortal sente durante a possessão, do prazer à dor. De fato, qualquer dano que o corpo da vítima sofra também é aplicado ao corpo do personagem (embora o Membro possa absorver normalmente). Se a mortal morrer antes que a alma do vampiro consiga fugir do corpo, o corpo do personagem cai em torpor. Presumivelmente isso é uma resposta simpática ao trauma massivo da morte, embora alguns Membros acreditem que a alma do vampiro fica à deriva durante esse tempo e precisa achar o caminho de volta ao corpo.
O Membro pode permanecer no corpo da mortal mesmo que sua própria forma torporosa seja destruída, embora uma criatura tão patética dificilmente exista por muito tempo. A cada nascer do sol, o vampiro precisa rolar Coragem (dificuldade 8) ou ser expelido do corpo. Se for forçado a sair do corpo mortal, o vampiro despenca no plano astral, sua alma permanentemente perdida no mundo espiritual. Um vampiro preso num corpo mortal não pode ser "re-Abraçado". Se o Abraço ocorrer a uma criatura dessas, ele simplesmente encontra a Morte Final.

Contato Visual (p. 152)
Existem muitos mitos e histórias sobre a capacidade mística de um vampiro de enfeitiçar pessoas olhando fundo nos olhos da vítima. A persistência dessas histórias ao longo das eras não surpreende, já que vários poderes de Disciplinas dos Membros (mais notavelmente Dominação) exigem contato visual para funcionar. Outros vampiros, ao saberem desse requisito, já tentaram de tudo, de usar óculos escuros espelhados a arrancar os próprios olhos, para impedir que um ancião imponha sua vontade sobre eles.
Mas os Membros não são frustrados tão facilmente.
A necessidade de contato visual nasce da necessidade que o Membro agressor tem de ver a alma da vítima, e os olhos são tradicionalmente conhecidos como as janelas da alma. Embora o vampiro precise capturar a atenção do alvo, os olhos do alvo não precisam estar presentes para que tal poder funcione (embora as artes dos Tzimisce tornem isso um tanto desafiador às vezes) — eles só precisam encontrar a alma da vítima exposta.
Um alvo tentando evitar o contato visual pode fazer uma rolagem de Força de Vontade contra uma dificuldade igual à Manipulação + Intimidação do usuário de Dominação (ou outra combinação apropriada para outras Disciplinas ou situações específicas, a critério do Narrador). A dificuldade pode ser reduzida por fatores atenuantes: -1 no caso de o alvo obscurecer levemente os olhos (como fechar os olhos ou usar óculos escuros), até -3 para os olhos estarem completamente invisíveis (como com uma venda grossa ou com os olhos arrancados). Em última análise, porém, cabe ao Narrador decidir se o contato visual é estabelecido num caso específico.]==],
				},
				["Flight"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 447


Flight


Os Gárgulas possuem uma quarta Disciplina de clã, chamada Voo. Todos os Gárgulas começam com um ponto gratuito, e ela pode ser aumentada como qualquer outra Disciplina. Conforme o Gárgula ganha pontos de Voo, ele se torna capaz de voar mais rápido, assim:

• O personagem não consegue de fato voar, mas pode planar como uma asa-delta. Ele também não pode carregar nada (precisa das mãos para ajudar a se dirigir). A velocidade máxima é igual à dos ventos predominantes, ou 25 quilômetros por hora em ar calmo.

•• O personagem pode fazer uma decolagem em corrida e carregar 10 quilos enquanto voa. A velocidade máxima é de 50 quilômetros por hora.

••• O personagem pode fazer uma decolagem vertical direta se estiver desimpedido, ou uma decolagem em corrida carregando até 25 kg. A velocidade máxima no ar é de 70 quilômetros por hora.

•••• O personagem agora pode fazer uma decolagem vertical com até 25 kg de bagagem, mas pode carregar até 45 kg enquanto voa. A velocidade máxima é de 95 quilômetros por hora.

••••• O personagem agora pode carregar até 90 kg, o bastante para levar embora uma pessoa adulta (ou um vampiro). A velocidade máxima é de 120 quilômetros por hora.

Pontos adicionais na Disciplina somam 45 kg de peso e 30 quilômetros por hora à velocidade. Os Gárgulas não pensam em Voo como uma Disciplina. Para eles é só voar, parte inseparável de ser um Gárgula, e podem ficar perplexos com noções como a de ensiná-lo a outros vampiros.]==],
				},
				["Fortitude"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 158


Fortitude


Embora todos os vampiros tenham uma constituição sobrenatural que os torna muito mais resistentes que os mortais, Fortitude confere uma resiliência que deixaria um herói de filme de ação com inveja. Vampiros com essa Disciplina conseguem ignorar traumas agonizantes e fazer o impacto mais estilhaçador de ossos parecer um arranhão. O poder oferece até proteção contra as pragas tradicionais dos vampiros, como a luz do sol e o fogo, e os Gangrel, Ravnos e Ventrue todos acham essa vantagem incrivelmente útil.
Sistema: O valor de Fortitude de um personagem soma-se ao seu Vigor para fins de absorver dano normal (contusão e letal). Um personagem com essa Disciplina também pode usar seus pontos de Fortitude para absorver dano agravado, embora os Membros normalmente não possam absorver coisas como mordidas de vampiro, garras de lobisomem, efeitos mágicos, fogo, luz do sol ou trauma físico massivo. Veja a p. 272 para mais detalhes sobre absorção e dano.]==],
				},
				["Koldunic Sorcery"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 448


Koldunic Sorcery


A conjuração propriamente dita da feitiçaria Koldúnica exige mais que um exercício desajeitado de vontade. Essa magia demanda perfeição de forma e domínio do saber apropriado. O jogador do conjurador gasta um ponto de sangue e rola (Atributo) + Ocultismo contra uma dificuldade igual ao nível do poder + 3, com o Atributo específico listado para cada trilha ou "via". Vampiros sempre usam o Atributo base, ignorando quaisquer bônus obtidos por gasto de sangue ou outras Disciplinas. Todos os kolduns precisam escolher uma das vias listadas abaixo como sua trilha principal.]==],
				},
				["Melpominee"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 453


Melpominee


Batizada em homenagem a Melpômene, a Musa grega da tragédia, a Disciplina exclusiva das Filhas da Cacofonia é uma Disciplina de fala e canto. Os poderes dessa Disciplina exploram os vários usos da voz tanto para o bem quanto para o mal. Como acontece com a arte mortal, nem sempre fica claro qual dessas direções esses poderes tomam. Nenhum personagem pode ter um valor em Melpominee maior que seu valor em Performance. Melpominee afeta a alma do sujeito além dos ouvidos; assim, funciona perfeitamente bem em sujeitos surdos, e já causou ao menos uma quebra conhecida da Máscara por causa desse efeito. Além disso, os poderes de Melpominee funcionam apenas sobre quem está presente quando ela é usada — as Filhas da Cacofonia não podem gravar efeitos de Melpominee, enviá-los por ondas de rádio nem transmiti-los pela internet.
As Filhas da Cacofonia podem usar alguns dos poderes da Disciplina Melpominee em conjunto, por assim dizer. Se mais de uma Sereia usar o mesmo nível dessa Disciplina simultaneamente, a dificuldade da rolagem cai em um para cada Filha envolvida além da primeira. A dificuldade não pode cair abaixo de 3, porém. Os níveis da Disciplina que podem se beneficiar dessa regra estão indicados abaixo.

• A Voz Ausente
O personagem pode "lançar" sua voz para qualquer lugar dentro do seu campo de visão. Isso permite à Filha manter conversas dissimuladas, cantar duetos consigo mesma ou causar toda sorte de distrações. Esse poder também pode ser combinado com outros poderes de Melpominee para disfarçar sua origem (e algumas Filhas o usam para esconder o fato de que os poderes de Melpominee não funcionam através de mídia gravada).
Sistema: Esse poder funciona automaticamente enquanto o personagem o quiser. Contudo, usar A Voz Ausente enquanto realiza qualquer ação que não seja falar ou cantar acarreta uma penalidade de dois dados naquela ação, devido à quebra de concentração do personagem.

•• Orador Fantasma
A Filha pode projetar sua voz para qualquer indivíduo que tenha encontrado pessoalmente. A distância não é obstáculo, mas precisa ser noite onde o alvo estiver naquele momento. O vampiro pode cantar, falar ou de outro modo projetar sua voz da maneira que achar melhor (incluindo outros usos de Melpominee), mas não consegue ouvir o que está dizendo, e portanto sofre +1 de dificuldade em quaisquer rolagens que acompanhem sua fala. Por exemplo, o vampiro poderia projetar sua voz até um inimigo numa tentativa de intimidá-lo, mas sofreria +1 na dificuldade da rolagem de Carisma + Intimidação.
Sistema: O jogador rola Raciocínio + Performance (dificuldade 7) e gasta um ponto de sangue. Cada sucesso permite um turno de fala; três ou mais sucessos permitem falar por uma cena inteira.

••• Madrigal
A música tem o poder de comover o ouvinte, engendrando emoções específicas por meio de letras habilidosas, de um crescendo martelante ou de uma melodia assombrosa. As Filhas da Cacofonia conseguem se valer do poder da música, forçando os ouvintes a sentir o que quiserem. A emoção se torna tão poderosa que o ouvinte precisa agir, embora o que ele faça não seja algo que a Sereia possa controlar diretamente.
Sistema: O jogador rola Carisma + Performance (dificuldade 7). Cada sucesso instila a emoção escolhida em um quinto da plateia do Membro (mais de cinco sucessos não têm efeito adicional). O Narrador decide precisamente quais membros da plateia são afetados. Personagens podem resistir a esse poder pela duração da cena com o gasto de um ponto de Força de Vontade, mas apenas se tiverem motivo para acreditar que estão sendo controlados por indivíduos externos. A canção que o vampiro canta também precisa refletir a emoção que ela deseja engendrar — ninguém vai partir para cima da segurança do show por melhor que ela cante "High Hopes", mas talvez o façam se ela tocar "I Predict a Riot".
Indivíduos afetados devem agir de acordo com suas Naturezas — Conformistas enfurecidos entrariam num tumulto, mas não o iniciariam; Valentões excitados podem forçar suas atenções sobre o objeto do seu desejo; e Diretores enciumados podem mandar capangas atrás de seus rivais.
Múltiplas Filhas podem usar essa Disciplina em conjunto.

•••• O Chamado da Sereia
As Filhas da Cacofonia não espalham loucura de modo tão certeiro (ou tão visível) quanto os Malkavianos, mas suas canções são definitivamente prejudiciais à sanidade. Com esse poder, a Filha pode levar qualquer ouvinte à loucura. Na maior parte do tempo, a vítima está fascinada demais para perceber que deveria sair da área e bloquear a música da sua mente.
Sistema: O Chamado da Sereia exige uma rolagem estendida e resistida. O jogador rola Manipulação + Performance (dificuldade igual à Força de Vontade atual do alvo); a vítima resiste com uma rolagem de Força de Vontade (dificuldade igual à Aparência + Performance da cantora). Se a cantora acumular cinco sucessos a mais que a vítima em qualquer ponto, a pobre alma adquire um novo distúrbio ou Defeito Psicológico à escolha do Narrador. Esse distúrbio normalmente dura uma noite, com uma noite adicional por sucesso acima de cinco. Com um total de 20 sucessos líquidos, a Filha pode torná-lo permanente.
Múltiplas Filhas podem usar essa Disciplina em conjunto.

••••• Virtuosa
A maior parte dos poderes de nível baixo de Melpominee só pode ser usada em um alvo por vez. Quando a Filha atinge esse nível de maestria na sua Disciplina, ela consegue "entreter" uma plateia mais ampla. Cada membro da plateia ouve a mesma mensagem.
Sistema: A Filha pode usar Orador Fantasma ou O Chamado da Sereia num número de alvos igual ao seu Vigor + Performance. O jogador precisa gastar um ponto de sangue para cada cinco alvos além do primeiro.]==],
				},
				["Mytherceria"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 455


Mytherceria


Seja qual for a estranha mistura de sangue que produziu os Kiasyd, ela levou a uma série de efeitos esquisitos, e não menos importante entre eles está a Disciplina Mytherceria. Esse conjunto de poderes imita as capacidades dos feéricos — ou pelo menos é esse o melhor palpite dos Membros que a conhecem. Os Kiasyd usam esse poder para alterar e ludibriar as mentes de seus adversários, bem como para forçar outros a dizer a verdade. Os Kiasyd não costumam, em geral, ensinar essa Disciplina a quem está fora da linhagem, e supostamente aprendê-la exigiria juramentos prestados sobre o sangue vital do estudante.

• Folderol
O Kiasyd consegue separar a verdade da mentira. O efeito exato varia de vampiro para vampiro. Alguns Kiasyd sangram pelos olhos ou pelos ouvidos quando ouvem uma mentira, enquanto os olhos de alguns Esquisitos brilham diante de uma falsidade. Qualquer que seja o efeito, esse poder detecta mentiras, não erros, o que significa que o alvo precisa saber que está mentindo para que o poder funcione.
Sistema: O personagem sabe quando um alvo está mentindo deliberadamente. Nenhuma rolagem ou gasto é necessário para esse poder funcionar, mas o personagem precisa ativá-lo deliberadamente. Note que esse poder não fornece nenhuma percepção do que a verdade poderia ser, nem permite ao vampiro dizer se um alvo está simplesmente afirmando algo falso que ele acredita ser verdadeiro.

•• Visão Feérica
O conhecimento de magia dos Kiasyd não é apenas teórico. Seus olhos de cor estranha são capazes de detectar as energias arcanas dos feéricos, assim como magia de outras fontes mais esotéricas. Não são capazes, porém, de usar esse poder para detectar o resíduo de fantasmas ou de magia vampírica.
Sistema: O Kiasyd vê feéricos e outros mortais tocados pelos feéricos pelo que realmente são, sem rolagem necessária. Além disso, o jogador pode detectar qualquer forma de magia que não venha de fantasmas ou dos mortos-vivos, incluindo magia de magos, lobisomens e outras fontes estranhas do gênero. O personagem consegue reconhecê-las pelo que verdadeiramente são, desde que já tenha visto efeitos semelhantes antes.

••• Absorção de Aura
O Kiasyd é capaz de ver imagens de eventos e emoções passados tocando um objeto ou uma área. Contudo, ao contrário do poder de Auspícios O Toque do Espírito, esse poder absorve as imagens, tornando-as mais difíceis de acessar por outros seres com poderes semelhantes. Qualquer um que tente usar esse poder, O Toque do Espírito ou capacidade parecida para ver o que o Kiasyd viu descobre que as imagens são difíceis de segurar, escapando pelos olhos da mente como peixinhos por um riacho.
Sistema: O jogador precisa fazer uma rolagem de Percepção + Empatia. A dificuldade é determinada pelo Narrador com base na idade das impressões e na força mental e espiritual da pessoa que as deixou. O número de sucessos determina a quantidade de informação obtida, tanto em termos de imagens da cena em que o objeto estava sendo segurado ou tocado quanto da natureza da pessoa que segurava o objeto. Uma imagem do tipo cena e um aspecto da identidade da pessoa (Natureza, Comportamento, aura, nome, sexo ou idade) ficam claros para cada sucesso que o jogador obtiver na rolagem. Qualquer um que tente usar esse poder ou O Toque do Espírito no mesmo objeto posteriormente precisa acumular mais sucessos do que o Kiasyd obteve para ter qualquer impressão. Os sucessos do primeiro Kiasyd subtraem-se do número de sucessos obtidos por quem tentar ler o objeto depois.

•••• Selo Chanjelin
O vampiro inscreve um selo num objeto, num local ou numa pessoa. Esse selo desorienta e confunde quem quer que o veja, o que significa que, mesmo que um intruso consiga penetrar a segurança de um Esquisito e roubar um objeto de valor, dificilmente conseguirá achar o caminho da saída. Kiasyd rancorosos usam esses selos como punição — uma história conta de um Esquisito que desenhou um selo na camisa de um inimigo quando o amanhecer se aproximava, e então assistiu (em segurança) enquanto o infeliz vampiro queimava ao sol, incapaz de lembrar para que lado correr.
Sistema: O vampiro que cria o selo inscreve o símbolo num local visível — numa porta de biblioteca, numa estante ou na roupa de um indivíduo — e o jogador rola Inteligência + Furto (dificuldade 7 para objetos inanimados, ou a Força de Vontade atual do sujeito +2). Qualquer um que entre na área selada ou toque o objeto selado perde dois dados das suas paradas de Inteligência enquanto mantiver contato ou proximidade com o selo. Além disso, qualquer um que veja o selo fica aturdido e perdido, a menos que obtenha sucesso numa rolagem de Raciocínio + Investigação (dificuldade 8). O Kiasyd é imune aos próprios selos. Os glifos duram por um tempo indicado pelo número de sucessos na rolagem de Inteligência + Furto:
1 sucesso — Uma hora
2 sucessos — Uma noite
3 sucessos — Uma semana
4 sucessos — Um mês
5 sucessos — Um ano

••••• O Enigma Fantástico
O Kiasyd sussurra um enigma a um oponente, e o enigma consome a mente dele. O alvo não consegue fazer nada até resolver o enigma, e ninguém pode ajudá-lo — respostas dadas por outros, mesmo as corretas, não anulam essa aflição.
Sistema: O jogador rola Manipulação + Ocultismo (dificuldade da Força de Vontade atual da vítima). Depois de uma rolagem bem-sucedida, a vítima não consegue fazer nada além de sentar e ponderar o Enigma até acumular três vezes os sucessos do enigmista. O sujeito rola Raciocínio + Ocultismo (dificuldade 8, mais ou menos o número de distúrbios que a vítima tem, a critério do Narrador). Ela faz essa rolagem assim que ouve o Enigma, e depois uma vez por hora até ter reunido sucessos suficientes. Se a vítima obtiver falha crítica numa rolagem para resolver o Enigma, ela sofre um nível de dano letal enquanto o enigma místico tortura seu corpo, e perde todos os sucessos do total acumulado. Esse dano não pode ser curado até que o Enigma seja resolvido. O enigmista pode encerrar esse transe dizendo a resposta à vítima, mas ninguém mais pode.]==],
				},
				["Necromancy"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 159


Necromancy


Necromancia é ao mesmo tempo uma Disciplina e uma escola de magia de sangue dedicada ao comando das almas dos mortos. É semelhante à Taumaturgia por ter várias "trilhas" e "rituais" que as acompanham, em vez de uma progressão linear rígida de poderes. O estudo da Necromancia não é difundido entre os Membros, e seus praticantes — principalmente os Giovanni — são evitados e desprezados por suas práticas repugnantes (até que essas práticas se tornem úteis, é claro).
Ao longo dos séculos, as várias escolas de Necromancia vampírica evoluíram e se diversificaram a partir de uma forma mais antiga de magia da morte, deixando várias trilhas distintas de magia necromântica disponíveis aos Cainitas. Quase todos os necromantes modernos aprendem primeiro a Trilha do Sepulcro antes de estender seus estudos a outras trilhas. A trilha principal de Necromancia aumenta automaticamente conforme o personagem aumenta seu valor geral de Necromancia. Outras trilhas precisam ser compradas separadamente, usando os custos de experiência de trilhas secundárias.
Como a Taumaturgia, a Necromancia também gerou uma série de rituais. Embora não sejam nem de longe tão imediatos em efeito quanto os poderes básicos de Necromancia, os rituais necrománticos podem ter efeitos impressionantes a longo prazo. Sem surpresa, os elementos do ritual necromântico são coisas como cadáveres há muito enterrados e mãos de corpos de enforcados, de modo que obter materiais adequados pode ser bastante difícil.
Sistema: Um necromante Cainita precisa aprender ao menos três níveis na sua trilha principal antes de aprender seu primeiro nível numa trilha secundária de Necromancia. Ele precisa então dominar a trilha principal (todos os cinco níveis) antes de adquirir qualquer conhecimento de uma terceira trilha.
Como na Taumaturgia, o avanço na trilha principal custa a quantidade normal de experiência, enquanto o estudo de trilhas necrománticas adicionais acarreta um custo adicional em pontos de experiência (veja a p. 124). Como a Necromancia não é um estudo tão rígido quanto a Taumaturgia, as rolagens exigidas para usar poderes necrománticos podem variar de trilha para trilha e até dentro de trilhas individuais. A Trilha do Sepulcro, comumente aprendida, é apresentada primeiro, e as trilhas restantes são apresentadas em ordem alfabética.
As estatísticas de fantasmas podem ser encontradas no Capítulo Nove, p. 385.]==],
				},
				["Obeah"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 457


Obeah


A linhagem conhecida nas noites modernas simplesmente como Salubri é na verdade descendente de uma das metades do antigo Clã. Em noites idas, poder-se-ia falar de Salubri "curandeiros" e "guerreiros". Nas noites modernas, os últimos vestígios dos Salubri guerreiros são os antitribu do Clã, e praticam sua Disciplina de Valeren (veja a p. 474). O resto da linhagem conhece a Disciplina de Obeah. Essa Disciplina permite aos Salubri avaliar e até melhorar a saúde de um sujeito. Conforme o vampiro cresce em poder, Obeah lhe permite curar diretamente a alma de um alvo. É esse poder que forma a base da acusação de "suga-almas" que persegue a linhagem nestas noites.
Essa Disciplina dá aos seus praticantes um terceiro olho no centro da testa do vampiro quando o Membro domina o segundo nível de Obeah.

• Sentir a Vitalidade
Com um toque, o Salubri consegue ler instantaneamente os ferimentos de um alvo. Ela pode descobrir quanto dano um alvo sofreu e, com isso, arriscar um palpite sobre o que precisa ser feito para salvá-lo. Esse poder também pode ser usado para fins diagnósticos — útil para uma vítima que não consegue mais falar.
Sistema: O Salubri precisa tocar o alvo para ver quão perto da morte ela está. Ele precisa então fazer uma rolagem de Percepção + Empatia (dificuldade 7). Um sucesso nessa rolagem identifica um sujeito como mortal, vampiro, carniçal ou outra criatura. Dois sucessos revelam quantos níveis de vitalidade de dano o sujeito sofreu. Três sucessos dizem o quão cheia está a reserva de sangue do sujeito (se for vampiro) ou quantos pontos de sangue ela ainda tem no organismo (se for mortal ou outra forma de vida portadora de sangue). Quatro sucessos revelam quaisquer doenças na corrente sanguínea do sujeito. Um jogador pode optar por saber a informação obtida por um grau menor de sucesso — por exemplo, um jogador que acumule três sucessos pode saber se um sujeito é ou não vampiro, além do conteúdo da sua reserva de sangue.
Alternativamente, cada sucesso nessa rolagem permite ao jogador fazer ao Narrador uma pergunta sobre a saúde ou os níveis de vitalidade do sujeito. "Ele foi drogado?" ou "Os ferimentos dele são agravados?" são perguntas válidas, mas "A Sabbat fez isso?" ou "Como era o Lupino que o atacou?" não são. O Salubri pode usar esse poder em si mesma se estiver ferida mas de algum modo tiver perdido a memória de como recebeu os ferimentos.
Além disso, ao custo de um ponto de sangue, o Salubri pode usar Empatia numa rolagem em vez de Medicina.

•• Toque Anestésico
O vampiro pode aliviar a dor de um alvo ou colocá-lo num sono profundo e reconfortante apenas com um toque. Esse poder tem por finalidade curar a dor ou confortar a mente de alvos voluntários, mas o personagem pode, com algum esforço, empregar o poder contra alguém que não o deseje.
Sistema: Se o sujeito estiver disposto a passar por esse processo, o jogador gasta um ponto de sangue e faz uma rolagem de Força de Vontade (dificuldade 6) para bloquear a dor do sujeito. Isso permite ao sujeito ignorar todas as penalidades de ferimento por um turno por sucesso. Uma segunda aplicação desse poder pode ser feita depois que a primeira expirar, ao custo de outro ponto de sangue e outra rolagem de Força de Vontade. Se o sujeito estiver relutante por algum motivo, o jogador precisa fazer uma rolagem resistida de Força de Vontade contra o sujeito (dificuldade 8).
Para adormecer um mortal, aplica-se o mesmo sistema. O mortal dorme de cinco a 10 horas — o que for seu ciclo normal de sono — e recupera um ponto temporário de Força de Vontade ao acordar. Ele dorme em paz e não sofre pesadelos nem os efeitos de quaisquer distúrbios enquanto dorme. Pode ser acordado normalmente (ou violentamente).
Membros, incluindo a própria Salubri, não são afetados por esse poder — seus corpos cadavéricos estão ligados demais à morte.

••• Corpore Sano
O Salubri consegue curar ferimentos com a imposição das mãos. O sujeito sente uma sensação quente e formigante sobre as áreas afetadas enquanto a dor deixa o corpo e a carne se fecha. O terceiro olho do vampiro se abre durante esse processo.
Sistema: Esse poder funciona em qualquer criatura viva ou morta-viva, mas o personagem precisa tocar o ferimento propriamente dito (ou a parte mais próxima do corpo da vítima, no caso de ferimentos internos). Cada nível de vitalidade a ser curado exige o gasto de um ponto de sangue e um turno de contato. Ferimentos agravados também podem ser curados dessa maneira, mas o vampiro precisa gastar dois pontos de sangue em vez de um para cada nível de vitalidade agravado.

•••• Vigília do Pastor
O Salubri com esse nível de maestria em Obeah consegue criar uma barreira invisível entre aqueles sob seus cuidados e aqueles que lhes fariam mal. O próprio Salubri precisa estar entre seus protegidos ao gerar essa barreira; ele não pode defendê-los de longe. Inimigos armados com armas de fogo ou outras armas à distância ainda podem atacar, mas ninguém pode se aproximar além de alguns passos.
Sistema: O jogador gasta dois pontos de Força de Vontade. Erguer essa barreira é uma ação padrão, mas mantê-la de turno em turno ou baixá-la é uma ação reflexiva. A barreira invisível se estende por um raio de cerca de 3 metros a partir do personagem, e ninguém fora dela pode atravessá-la enquanto ela mantiver o poder. Quem estiver dentro dela na sua criação pode sair e voltar, porém. A barreira se move com o Salubri. Não pode ser mantida à distância.
Aqueles que desejarem atravessar a barreira de fora, sejam amistosos ou hostis, precisam superar o personagem numa rolagem estendida e resistida de Força de Vontade (a dificuldade é a Força de Vontade atual do oponente para o Salubri, e a Força de Vontade atual do Salubri para o oponente). O oponente pode atravessar a barreira assim que acumular três sucessos líquidos a mais que o Salubri.

••••• Mens Sana
Com esse poder, o Salubri consegue curar a loucura, aquietando demônios interiores e trazendo paz a uma alma. De fato, histórias antigas dos Salubri afirmam que Saulot usou esse poder para trazer alívio doce, ainda que temporário, ao seu "irmão" Malkav. Outras histórias, mais recentes, afirmam que foi Saulot quem causou a loucura de Malkav em primeiro lugar.
Sistema: O jogador gasta dois pontos de sangue e rola Inteligência + Empatia (dificuldade 8). O uso de Mens Sana leva ao menos 10 minutos de conversa relativamente ininterrupta. O sucesso cura o sujeito de um distúrbio à escolha do jogador do Salubri. Esse poder não pode curar um Malkaviano do seu distúrbio central, embora alivie seus efeitos pelo resto da cena. Uma falha crítica inflige o mesmo distúrbio ao Salubri pelo resto da cena. Esse poder não pode ser usado pelo Salubri para curar seus próprios distúrbios.]==],
				},
				["Obfuscate"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 184


Obfuscate


Ofuscação é a capacidade sobrenatural que os Membros têm de se esconder da vista, às vezes até diante de uma multidão. Um vampiro Ofuscado não se torna de fato invisível, porém — em vez disso, ele consegue iludir os observadores para que acreditem que ele sumiu. Ofuscação também permite aos Membros mudar suas feições e ocultar outras pessoas ou objetos. Normalmente, vampiros usando Ofuscação precisam estar a curta distância de suas testemunhas (aproximadamente cinco metros por ponto de Raciocínio + Furtividade) para que o poder seja eficaz.
A menos que o Membro escolha se fazer ver, ela pode permanecer oculta pelo tempo que quiser. Em níveis mais altos, o vampiro consegue de fato sumir da vista de modo tão sutil que quem está por perto não consegue lembrar o momento em que ela saiu.
Normalmente, poucos mortais ou sobrenaturais (mesmo os treinados em Consciência) conseguem atravessar a névoa da Ofuscação. Animais, que confiam mais nos seus instintos que nos sentidos normais, às vezes conseguem perceber (e se assustar com) a presença do vampiro. Crianças e aqueles a quem o engano é estranho também podem conseguir atravessar a ilusão, a critério do Narrador. Por fim, a Disciplina Auspícios permite aos Membros enxergar através da Ofuscação. Nem isso é garantido, porém; consulte "Vendo o Invisível", p. 142, para mais detalhes. (Narradores que precisem de uma rolagem para animais ou crianças podem usar esta diretriz rápida e tosca: trate-os como se tivessem Auspícios 1 para fins de disputa contra Ofuscação. Eles não têm o poder de Auspícios 1, mas são considerados como tendo-o ao se determinar se um vampiro é notado.)
Como a Ofuscação turva a mente de quem vê, os vampiros não podem usá-la para esconder sua presença de dispositivos eletrônicos ou mecânicos. Câmeras de vídeo e fotográficas, por exemplo, capturam a imagem do vampiro com precisão. Mesmo assim, a pessoa que usa, digamos, o celular para gravar um vampiro Ofuscado ainda terá sua mente afetada pelo poder, e não verá a imagem do Membro até assistir ao vídeo numa data posterior (se é que verá).
Vários Clãs cultivam esse poder — os Assamitas, os Seguidores de Set e os Malkavianos, por exemplo —, mas os Nosferatu são particularmente conhecidos por essa Disciplina. Alguns Membros anciões acreditam que Caim, ou talvez Lilith, concedeu essa Disciplina ao Clã para compensar as horrendas deformidades físicas que seus membros sofrem.
A maioria dos poderes de Ofuscação dura uma cena, ou até que o vampiro pare de mantê-los. Uma vez evocados, exigem muito pouco esforço mental para se manterem no lugar.

• Manto de Sombras
Nesse nível, o vampiro precisa contar com sombras e abrigo próximos para ajudar a esconder sua presença. Ele entra num lugar afastado e sombreado e se retira suavemente da vista normal. O vampiro permanece despercebido enquanto ficar em silêncio, imóvel, sob algum grau de cobertura (como uma cortina, um arbusto, um batente de porta, um poste ou um beco) e fora da iluminação direta. A ocultação do imortal desaparece se ele se mover, atacar ou cair sob luz direta. Além disso, o engodo do vampiro não resiste à observação concentrada sem se desfazer.
Sistema: Nenhuma rolagem é exigida enquanto o personagem cumprir os critérios descritos acima. Enquanto permanecer quieto e imóvel, praticamente ninguém além de outro Membro com um valor de Auspícios alto o bastante o verá.

•• Presença Invisível
Com a experiência, o vampiro consegue se mover por aí sem ser visto. As sombras parecem se deslocar para cobri-lo, e as pessoas automaticamente desviam o olhar quando ele passa. Outros se movem inconscientemente para evitar contato com a criatura encoberta; os de vontade fraca podem até se afastar depressa da área num medo que não admitem. O vampiro continua ignorado indefinidamente, a menos que alguém deliberadamente o procure ou ele inadvertidamente se revele.
Como o vampiro mantém plenamente sua substância física, ele precisa tomar cuidado para evitar contato com qualquer coisa que possa denunciar sua presença (derrubar um vaso, esbarrar em alguém). Até uma palavra sussurrada ou o arrastar de um sapato no chão pode bastar para romper o poder.
Sistema: Nenhuma rolagem é necessária para usar esse poder, a menos que o personagem fale, ataque ou de outro modo chame atenção para si. O Narrador deve pedir uma rolagem de Raciocínio + Furtividade em qualquer circunstância que possa fazer o personagem se revelar. A dificuldade da rolagem depende da situação; pisar numa tábua rangente pode ser 5, enquanto caminhar por uma poça d’água pode exigir 9. Outros atos podem exigir um certo número de sucessos; falar baixo sem entregar a própria posição, por exemplo, exige ao menos três sucessos. Com o sucesso, o vampiro, toda a sua roupa e objetos que caibam num bolso ficam ocultos.
Algumas coisas estão além do poder de ocultação da Presença Invisível. Embora o personagem esteja encoberto da vista enquanto atravessa uma janela, grita ou atira alguém do outro lado da sala, o vampiro se torna visível a todos logo depois. Os presentes despertam da fuga sutil em que a Ofuscação os pôs. Pior ainda, cada observador pode fazer uma rolagem de Raciocínio + Consciência (dificuldade 7); se tiver sucesso, a névoa mental se dissipa completamente, e esses indivíduos lembram cada movimento que o personagem fez até então como se ele estivesse visível o tempo todo.

••• Máscara de Mil Faces
O vampiro consegue influenciar a percepção dos outros, fazendo com que vejam um rosto diferente do seu. Embora a forma física do Membro não mude, qualquer observador que não consiga sentir a verdade vê quem quer que o vampiro deseje que ela veja.
O vampiro precisa ter uma ideia firme do semblante que deseja projetar. A decisão principal é se vai criar um rosto imaginário ou sobrepor as feições de outra pessoa. Feições fabricadas são muitas vezes mais difíceis de compor em proporções críveis, mas esse disfarce é mais fácil de manter do que ter de personificar outra pessoa. Claro, as coisas ficam mais simples se o Membro pega emprestado o rosto mas não se incomoda com a personalidade.
Sistema: O jogador rola Manipulação + Performance (dificuldade 7) para determinar o quão bem o disfarce funciona. Se o personagem tentar personificar alguém, ele precisa dar uma boa olhada no sujeito antes de vestir a máscara. O Narrador pode aumentar a dificuldade se o personagem tiver visto apenas um relance. A tabela abaixo lista os graus de sucesso na fabricação de outra aparência. Vampiros que desejem se mascarar como alguém mais atraente do que são precisam pagar pontos de sangue adicionais iguais à diferença entre o valor de Aparência do vampiro e a Aparência da máscara (o que significa que vampiros mais jovens podem precisar de mais tempo para gastar o sangue necessário).
1 sucesso — O vampiro mantém a mesma altura e compleição, com algumas alterações leves nas suas feições básicas. Nosferatu podem parecer mortais normais, ainda que feios.
2 sucessos — Ele parece diferente de si mesmo; as pessoas não o reconhecem facilmente nem concordam sobre a aparência dele.
3 sucessos — Ele parece do jeito que quer parecer.
4 sucessos — Transformação completa, incluindo gestos, maneirismos, aparência e voz.
5 sucessos — Alteração profunda (parecer do sexo oposto, de idade muito diferente ou com mudança extrema de tamanho).
Fazer-se passar por outra pessoa de fato traz seus próprios problemas. O personagem deve saber ao menos informações básicas sobre o indivíduo; enganos especialmente difíceis (enganar um amante ou amigo próximo) exigem ao menos alguma familiaridade com o alvo para dar certo.

•••• Desvanecer da Mente
Esta expressão potente de Ofuscação permite ao vampiro desaparecer da vista aberta. Tão profundo é esse desaparecimento que o imortal consegue sumir mesmo estando bem na frente de alguém.
Embora o desaparecimento em si seja discretamente sutil, seu impacto sobre quem o vê é tudo menos isso. A maioria dos rebanhos entra em pânico e foge logo depois. Indivíduos especialmente fracos de vontade apagam a memória do Membro de suas mentes. Embora vampiros não se abalem tão facilmente, até Membros podem se surpreender momentaneamente com um sumiço repentino.
Sistema: O jogador rola Carisma + Furtividade; a dificuldade é igual ao Raciocínio + Prontidão do alvo (use o maior total do grupo se o personagem desaparecer diante de uma multidão). Com três sucessos ou menos, o personagem se esmaece mas não some, tornando-se uma figura indistinta e fantasmagórica. Com mais de três, ele desaparece completamente. Se o jogador obtiver mais sucessos que o valor de Força de Vontade de um observador, essa pessoa esquece que o vampiro esteve ali.
Acompanhar o personagem com precisão enquanto ele aparece fantasmagórico exige uma rolagem de Percepção + Prontidão (dificuldade 8). Uma rolagem bem-sucedida significa que o indivíduo pode interagir normalmente com o vampiro (embora o Membro pareça uma forma fantasmagórica profundamente perturbadora). Uma rolagem falha resulta num modificador de +2 de dificuldade (máximo 10) ao tentar agir sobre o vampiro ou interagir com ele. O Narrador pode pedir novas checagens de observação se o vampiro se mover para um ambiente em que seja difícil de ver (entra nas sombras, passa atrás de um obstáculo, atravessa uma multidão). Quando totalmente invisível, o vampiro é tratado como descrito em Presença Invisível, acima.
Uma pessoa sujeita ao sumiço faz uma rolagem de Raciocínio + Coragem (mortais com dificuldade 9, vampiros com dificuldade 5). Uma rolagem bem-sucedida significa que o indivíduo reage imediatamente (embora depois de o vampiro realizar sua ação naquele turno); a falha significa que a pessoa fica parada sem compreender por dois turnos enquanto sua mente tenta dar sentido ao que acabou de experimentar.

••••• Encobrir a Reunião
Nesse grau de poder, o vampiro pode estender suas capacidades de ocultação para cobrir uma área. O imortal pode usar qualquer poder de Ofuscação sobre os que estão por perto além de sobre si mesmo, se quiser.
Qualquer pessoa protegida que comprometa o manto se expõe à vista. Além disso, se aquele que invoca o poder se entregar, o manto cai de todos. Esse poder é particularmente útil se o vampiro precisa levar sua comitiva por um local seguro sem atrair a atenção dos outros.
Sistema: O personagem pode ocultar um indivíduo extra para cada ponto de Furtividade que possua. Ele pode conceder ao grupo qualquer poder único de Ofuscação por vez. Embora o poder se aplique a todos sob o manto do personagem, seu jogador só precisa fazer uma rolagem. Cada indivíduo precisa seguir os requisitos descritos no poder de Ofuscação em questão para permanecer sob seu efeito; qualquer pessoa que deixe de fazê-lo perde a proteção do manto, mas não expõe os outros. Só se o próprio vampiro errar é que o poder cai para todos.]==],
				},
				["Obtenebration"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 188


Obtenebration


O poder característico dos Lasombra, Tenebrosidade concede ao vampiro poder sobre a própria escuridão. A natureza da escuridão invocada pela Tenebrosidade é assunto de intenso debate entre os Membros. Alguns acreditam que sejam meras sombras, enquanto outros sentem que o poder dá controle sobre a matéria da alma do vampiro, atraindo-a tangivelmente para fora.
Seja como for, os efeitos da Tenebrosidade são aterrorizantes, com ondas de escuridão revolvendo-se para fora do Cainita, envolvendo os que estão em seu caminho como uma maré infernal. Como a Tenebrosidade é conhecida sobretudo como uma Disciplina Sabbat, qualquer vampiro da Camarilla flagrado usando o poder é bom que tenha uma explicação muito boa.
Nota: Vampiros usando Tenebrosidade conseguem enxergar através da escuridão que controlam, embora outros vampiros (mesmo os que também têm Tenebrosidade) não consigam. Histórias medonhas de Lasombra rivais lutando para cegar e sufocar um ao outro com os mesmos fiapos de escuridão circulam entre os jovens membros do Clã, embora nenhum ancião tenha se apresentado para confirmar essas alegações.

• Jogo de Sombras
Este poder concede ao vampiro controle limitado sobre sombras e outras formas de escuridão ambiente. Embora o vampiro não consiga verdadeiramente "criar" escuridão, ela pode sobrepor e esticar sombras existentes, criando manchas de penumbra. Esse poder também permite aos Membros separar sombras dos corpos que as projetam e até moldar a escuridão nas sombras de coisas que não estão ali.
Uma vez que um Membro assume o controle da escuridão ou da sombra, ela ganha uma tangibilidade mística. Descrita ora como fria, ora como infernalmente quente e grudenta, a escuridão pode ser usada para irritar ou até sufocar vítimas. Certos Lasombra insensíveis afirmam ter estrangulado mortais até a morte com as próprias sombras deles.
Sistema: Este poder não exige rolagem, mas um ponto de sangue precisa ser gasto para ativá-lo. Jogo de Sombras dura uma cena e não exige concentração ativa. Membros que se cobrem de sombra ganham um dado extra nas suas paradas de Furtividade e somam um às dificuldades de ataques com armas à distância contra eles. Vampiros que usam a escuridão para se tornar mais aterrorizantes somam um dado às paradas de Intimidação. Oponentes assolados por sombras esvoaçantes e escuridão estranguladora subtraem um dado de todas as paradas de Vigor (incluindo absorção). Mortais, carniçais e outros que respiram ar reduzidos a Vigor zero por sombras estranguladoras começam a asfixiar; vampiros perdem todos os dados cabíveis, mas não são afetados de outro modo. Apenas um alvo ou sujeito pode ser afetado por esse poder por vez, embora algum grau de ocultação seja oferecido a um grupo relativamente imóvel.
A aparência antinatural desse poder se mostra extremamente perturbadora para mortais e animais (e, a critério do Narrador, Membros que nunca o viram antes). Sempre que esse poder é invocado nas imediações de um mortal, esse indivíduo precisa fazer uma rolagem de Coragem (dificuldade 8) ou sofrer uma penalidade de um dado em todas as paradas pelo resto da cena, por medo das sombras monstruosas.

•• Manto da Noite
O vampiro consegue criar uma nuvem de negrume denso. A nuvem obscurece completamente a luz e até o som, em certa medida. Aqueles que ficaram presos nela (e sobreviveram) descrevem a nuvem como viscosa e perturbadora. Essa manifestação física dá crédito aos Lasombra que afirmam que sua escuridão é algo além de mera sombra.
A nuvem tenebrosa pode até se mover, se o Membro que a criou desejar, embora isso exija concentração total.
Sistema: O jogador rola Manipulação + Ocultismo (dificuldade 7). O sucesso na rolagem gera escuridão de aproximadamente três metros de diâmetro, embora a nuvem amorfa se desloque e ondule constantemente, às vezes até estendendo tentáculos sombrios. Cada sucesso adicional dobra o diâmetro da nuvem (embora o vampiro possa voluntariamente reduzir a área que deseja cobrir). A nuvem pode ser invocada a uma distância de até 50 metros, embora criar escuridão fora do campo de visão do vampiro some dois à dificuldade da rolagem e exija o gasto de um ponto de sangue.
A massa alcatroada de fato extingue as fontes de luz que engolfa (com exceção do fogo) e abafa os sons até que fiquem indistinguíveis. Quem está dentro da nuvem perde todo o sentido da visão e sente como se estivesse imerso em piche. O som também se deforma e distorce dentro da nuvem, tornando quase impossível realizar qualquer coisa (+2 de dificuldade, conforme Combate às Cegas na p. 274). Mesmo os que possuem Sentidos Aguçados, Olhos da Besta, Língua da Áspide e poderes semelhantes sofrem a penalidade por cegueira, devido à escuridão antinatural. Além disso, estar cercado pelo Manto da Noite reduz em dois dados as paradas baseadas em Vigor, pois a treva sufoca e agita as vítimas. Esse efeito não é cumulativo com Jogo de Sombras, embora os alvos asfixiem conforme Jogo de Sombras se chegarem a Vigor 0; mais de um mortal infeliz já se "afogou" na escuridão.
Mortais e animais cercados pelo Manto da Noite precisam fazer rolagens de Coragem conforme Jogo de Sombras, acima, ou entrar em pânico e fugir.

••• Braços do Abismo
Refinando seu controle sobre a escuridão, o Membro consegue criar tentáculos preênseis que emergem de manchas de iluminação fraca. Esses tentáculos podem agarrar, imobilizar e constringir adversários.
Sistema: O jogador gasta um ponto de sangue e faz uma rolagem simples (nunca estendida) de Manipulação + Ocultismo (dificuldade 7); cada sucesso permite a criação de um único tentáculo. Cada tentáculo tem dois metros de comprimento e possui valores de Força e Destreza iguais ao Traço de Tenebrosidade do vampiro que o invoca — pontos de Potência e Celeridade são somados a esses valores de Força e Destreza, respectivamente. Se o vampiro quiser, ela pode gastar um ponto de sangue para aumentar em um a Força ou a Destreza de um único tentáculo, ou para estender seu comprimento em mais dois metros. Cada tentáculo tem quatro níveis de vitalidade, é afetado por fogo e luz do sol como se fosse um vampiro, e absorve dano por contusão e letal usando o Vigor + Fortitude do vampiro. Dano agravado não pode ser absorvido.
Tentáculos podem constringir adversários, infligindo (Força +1) de dano letal por turno. Romper o agarrão de um tentáculo exige que a vítima vença uma rolagem resistida de Força contra o tentáculo (dificuldade 6 para cada). Contudo, tentáculos não podem ser usados para nenhum tipo de manipulação, como digitar ou dirigir.
Nem todos os tentáculos precisam emanar da mesma fonte — desde que haja múltiplas manchas de escuridão adequadas, há fontes para os Braços do Abismo. Controlar os tentáculos não exige concentração total; se o Membro não estiver incapacitado nem em torpor, ela pode controlar tentáculos enquanto realiza outras ações.

•••• Metamorfose Negra
O Cainita invoca sua escuridão interior e se infunde com ela, tornando-se um híbrido monstruoso de matéria e sombra. Seu corpo fica salpicado de manchas de sombra tenebrosa, e tentáculos esguios se projetam do seu torso e abdômen. Embora ainda humanoide, o vampiro assume uma aparência quase demoníaca, à medida que a escuridão dentro dele borbulha até a superfície.
Sistema: O jogador gasta dois pontos de sangue e faz uma rolagem de Manipulação + Coragem (dificuldade 7) — vampiros de Geração mais baixa podem precisar de dois turnos para fazer a transição. A falha indica que o vampiro não consegue realizar a Metamorfose Negra (embora gaste os pontos de sangue mesmo assim). Uma falha crítica inflige dois níveis de vitalidade de dano letal não absorvível ao vampiro, enquanto a escuridão devasta seu corpo morto-vivo.
Sob os efeitos da Metamorfose Negra, o vampiro possui quatro tentáculos semelhantes aos evocados por Braços do Abismo (embora seus valores de Força e Destreza sejam iguais aos Atributos do próprio vampiro, incluindo dados de Celeridade e Potência). Esses tentáculos, combinados às faixas de escuridão por todo o corpo do Membro, subtraem dois dados das paradas de Vigor e absorção de oponentes tocados fisicamente em combate, enquanto o vampiro mantiver contato com a vítima. Isso não é cumulativo com outros poderes de Tenebrosidade, embora os alvos possam asfixiar com Vigor 0, conforme Jogo de Sombras. O vampiro pode fazer um ataque adicional sem penalidade usando os tentáculos (para um total de dois ataques, não um ataque adicional por tentáculo). Além disso, o vampiro consegue sentir plenamente o ambiente mesmo na escuridão total.
A cabeça e as extremidades do vampiro às vezes parecem se desvanecer no nada, enquanto em outros momentos parecem envoltas numa escuridão de outro mundo. Isso, combinado aos tentáculos que se contorcem saindo do seu corpo, cria uma visão inquietante. Mortais, animais e outras criaturas não acostumadas a esse tipo de exibição precisam fazer rolagens de Coragem (dificuldade 8) ou sucumbir a um pânico equivalente ao Rötschreck (embora inspirado pela escuridão, e não pelo fogo). Muitos Membros cultivam esse aspecto diabólico, e a Metamorfose Negra soma três dados às paradas de Intimidação do Membro que a invoca.

••••• Forma Tenebrosa
Neste nível, o domínio da escuridão pelo Membro é tão extenso que ela pode fisicamente se tornar escuridão. Ao ativar esse poder, o vampiro se torna uma mancha de sombra densa e amebóide. Vampiros nessa forma são praticamente invulneráveis e podem se esgueirar por fendas e frestas. Além disso, o vampiro-sombra ganha a capacidade de enxergar na escuridão natural.
Sistema: A transformação custa três pontos de sangue (que podem precisar ser gastos ao longo de três turnos, dependendo da Geração do vampiro). O vampiro é imune a ataques físicos enquanto está na forma tenebrosa (embora ainda sofra dano agravado de fogo e luz do sol), mas ela mesma não pode atacar fisicamente. Ela pode, contudo, envolver e escorrer sobre os outros, afetando-os da mesma maneira que um Manto da Noite, além de usar Disciplinas mentais. Vampiros em Forma Tenebrosa podem até se esgueirar por paredes e tetos ou "pingar" escuridão para cima — eles não têm massa e portanto não são afetados pela gravidade. As dificuldades de Rötschreck causadas por fogo e luz do sol aumentam em um para vampiros nessa forma, pois a luz é ainda mais dolorosa para seus corpos sombrios.
Mortais (e outros não acostumados a tais exibições) que testemunham o vampiro se transformar em sombra profana precisam de rolagens de Coragem (dificuldade 8) para evitar o terror debilitante descrito em Metamorfose Negra.]==],
				},
				["Ogham"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 461


Ogham


A Disciplina Ogham só é encontrada entre a linhagem Lhiannan; eles não (alguns dizem que não podem) compartilham seus segredos com quem não sofre da maldição da sua linhagem. Todos os Lhiannan compartilham um estilhaço de um espírito de floresta sombrio, outrora vasto e poderoso. Ogham lhes permite se valer do poder desse espírito e da comunhão dele com espíritos livres da mesma laia.
Ogham é uma forma limitada de magia de sangue; não é tão flexível nem tão poderosa quanto a Taumaturgia Tremere, nem quanto a feitiçaria de sangue de outros Clãs, mas dentro dos limites postos pela natureza territorial dos Lhiannan é bastante poderosa. Ogham é mais forte dentro do território natal de uma Lhiannan. A mais de 80 km do seu território natal, a dificuldade de usar Ogham aumenta em um em todos os casos, pois o próprio estilhaço espiritual da Lhiannan entra em conflito com a vida espiritual local desconhecida.

• Consagrar o Bosque
A Lhiannan com essa habilidade pode usar o poder do seu sangue para despertar os espíritos da vida vegetal no seu território; eles agirão em sua defesa contra qualquer intruso indesejado. Raízes enredam pés, o capim agarra botas, árvores se inclinam antinaturalmente no caminho dos adversários, e assim por diante. Tipicamente a Lhiannan corta um pulso e roda no lugar, ou perfura a palma da mão e caminha em espiral pela folhagem que deseja despertar.
Sistema: O jogador gasta de um a três pontos de sangue, e o personagem precisa realizar o processo descrito acima. Um ponto de sangue desperta a vida vegetal num diâmetro de 3 metros; dois pontos de sangue dobram isso para 6 metros; três levam a 12 metros. Percorrer a área desejada leva um turno por ponto de sangue gasto.
Quando o sangue foi semeado, o jogador rola Carisma + Sobrevivência (dificuldade 6). Se a rolagem obtiver ao menos um sucesso, a vida vegetal se anima enquanto o mundo espiritual local é despertado para a ação. Inimigos na área sofrem -2 em todas as paradas de dados por distração e interferência física. Além disso, intrusos precisam fazer uma rolagem de Vigor + Esportes para evitar três dados de dano por contusão vindos da flora local (desde que a vida vegetal local seja capaz de tal dano; árvores e sarças provavelmente são, mas um prado de capim não contém o tipo de flora necessário para tal ataque). Uma falha crítica nessa rolagem faz as plantas se voltarem contra a própria Lhiannan.
Este poder dura uma cena.

•• Glasto Carmesim
A Lhiannan traça runas ou escrita mística no próprio corpo com vitae, convidando espíritos da guerra a infundi-la e prepará-la para a batalha. Enquanto assim imbuída, ela ignora muitos ferimentos e mantém maior controle da própria mente enquanto os espíritos dirigem sua Besta. A Lhiannan também pode desferir contra seus inimigos um ataque feroz nascido do sangue.
Sistema: O personagem gasta uma cena traçando o glasto no corpo; isso custa um ponto de sangue. O jogador então rola Inteligência + Ocultismo (dificuldade 7). Cada sucesso permite ao personagem ignorar um dado de penalidade por ferimento. Também subtrai um da dificuldade para evitar frenesi ou Rötschreck. Essa habilidade dura uma cena. Além disso, se o personagem receber mais de quatro níveis de vitalidade de dano, as inscrições místicas são arruinadas e os espíritos fogem do seu corpo.
A Lhiannan também pode desferir um golpe contra seus inimigos, somando a fúria do glasto ao seu ataque. O jogador pode somar o número de sucessos obtidos na rolagem acima ao número de dados rolados para dano num único ataque corpo a corpo (essa habilidade só pode ser usada uma vez por aplicação de Glasto Carmesim).

••• Inscrever a Maldição
A Lhiannan inscreve o nome de um inimigo no próprio corpo com vitae, em qualquer língua ou conjunto de símbolos que preferir. Quando o nome está assim inscrito e o inimigo da Lhiannan consegue vê-lo, espíritos malignos se prendem ao nome e lançam uma maldição sobre esse inimigo. A maldição entra em vigor no momento em que a vítima vê seu nome rabiscado em sangue.
Sistema: O jogador gasta três pontos de sangue. A Lhiannan precisa escrever o nome do adversário em sangue, e ele precisa estar exposto numa parte do seu corpo visível ao alvo pretendido para que Inscrever a Maldição faça efeito. O jogador escolhe qual maldição lançar sobre o alvo a partir da lista abaixo; a maldição entra em vigor assim que o alvo vê seu nome. Ele não precisa entender a língua usada, mas se conseguir compreendê-la pode resistir à maldição com uma rolagem de Raciocínio + Ocultismo (dificuldade 8).
As maldições descritas abaixo expiram quando o glifo é apagado, se desgasta ou é desfigurado pela Lhiannan sofrer quatro ou mais níveis de vitalidade de dano. A maldição funciona de modo diferente conforme o lugar em que a Lhiannan inscreve o nome do alvo.
Corpo: Inscreva o nome nos braços, nas pernas ou no ventre. O corpo da vítima adoece e enfraquece (+2 em todas as dificuldades de rolagens Físicas, e todas as penalidades de ferimento aumentam em um dado) ou, no caso de Cainitas, a vítima não pode usar sangue além do ponto por dia necessário para permanecer ativa.
Mente: Inscreva o nome atravessando a testa. O adversário fica confuso enquanto partes da sua mente se desconectam umas das outras; ele precisa gastar um ponto de Força de Vontade para tentar qualquer rolagem de Conhecimento ou usar qualquer habilidade mágica ou Disciplina (que não seja Celeridade, Fortitude ou Potência). Essa Força de Vontade não lhe compra um sucesso naquela rolagem; simplesmente permite que ele a faça.
Voz: Inscreva o nome na garganta. A vítima perde o poder da fala; pode grunhir ou gemer, mas não consegue dizer palavra alguma.
Alma: Inscreva o nome descendo pelo esterno e sobre o coração. O sujeito perde a vontade de resistir à Besta: as dificuldades para evitar frenesi aumentam em dois. Não-vampiros são tomados pelo medo. O alvo precisa fugir do território da Lhiannan a menos que obtenha sucesso numa rolagem de Coragem (dificuldade 8).

•••• Lua e Sol
A vida de um Cainita é dominada por dois corpos celestes: o sol, que ela precisa temer e odiar; e a lua, sua única fonte segura de luz. Uma Lhiannan pode traçar sinetes antigos desses dois orbes no próprio corpo para obter dádivas – o espírito da lua, sempre amigo do vampiro, a abençoa conforme sua fase atual, enquanto o espírito do sol afasta parte da maldição ígnea daquele orbe.
Sistema: O jogador gasta três pontos de sangue. A Lhiannan inscreve o sinete desejado no corpo ao longo de 15 minutos. O sinete pode ser inscrito em qualquer lugar, mas precisa estar exposto. O personagem pode escolher inscrever tanto a lua quanto o sol, mas cada símbolo exige o gasto de sangue e 15 minutos para ser traçado. Ela também pode inscrever esses sinetes em qualquer sujeito voluntário.
O emblema do sol protege um vampiro dos piores efeitos do fogo e da luz do sol. Enquanto o símbolo permanecer no corpo do personagem, o jogador faz uma rolagem de Vigor (dificuldade 8) quando afligido por fogo ou luz do sol. Se a rolagem for bem-sucedida, o dano é considerado letal e o jogador pode rolar para absorvê-lo normalmente. Essa rolagem precisa ser feita toda vez que o personagem enfrentar tal dano.
O emblema da lua soma um às dificuldades das rolagens de Autocontrole/Instinto para evitar frenesi (mas não às rolagens de Coragem para evitar Rötschreck). Outros efeitos do emblema da lua dependem da fase atual da lua:
Lua Nova: Some um dado às paradas de Destreza e Furtividade.
Lua Crescente: Some um dado às paradas de Raciocínio e Ocultismo.
Quarto de Lua: Some um dado às paradas de Percepção e Subterfúgio.
Lua Gibosa: Some um dado às paradas de Carisma e Expressão.
Lua Cheia: Some um dado às paradas de Força e Briga.

••••• Beber a Terra até Secar
O espírito dentro de toda Lhiannan é atraído por sítios de energia mística, sejam círculos de pedra antigos, anéis feéricos ou trilhas de dragão. Esse estilhaço espiritual pode arrancar energia espiritual desses lugares de poder e usá-la para auxiliar a Lhiannan. Uma palavra de cautela, porém: roubar poder demais de qualquer sítio místico o torna estéril e sem vida, quase como se o Cainita tivesse consumido o próprio sangue da Terra. Além disso, magos e lobisomens frequentam esses mesmos sítios, e destruir esses lugares pode despertar sua ira.
Sistema: O jogador rola Percepção + Ocultismo (dificuldade 8). Um sucesso determina se um dado local é um sítio adequado (decisão geralmente deixada nas mãos do Narrador, embora uma Lhiannan com um Antecedente Domínio alto possa ter um sítio desses dentro dos seus domínios). Dois ou mais sucessos nessa rolagem concedem uma ideia aproximada do poder do sítio numa escala de 1 a 5. Se o personagem quiser explorar o poder daquele local, ela precisa gastar uma cena e um ponto de sangue marcando várias partes do sítio com sinetes de poder, chaves para que seu estilhaço espiritual destranque as energias do lugar.
Uma vez preparado o sítio, o jogador faz uma segunda rolagem reflexiva de Percepção + Ocultismo (dificuldade 7). Quaisquer sucessos acima do valor de poder do sítio são ignorados. Para cada sucesso, o jogador ganha dois dados, que ela pode somar a quaisquer paradas de dados (exceto as para evitar frenesi ou Rötschreck) pelo resto da cena. Esses dados somem quando usados, mas o personagem pode explorar o mesmo local de novo, de turno em turno. O jogador precisa fazer a rolagem de Percepção + Ocultismo a cada vez. Cada "gole" das energias do sítio o esgota, porém, como descrito abaixo.
O estilhaço espiritual da Lhiannan é uma coisa gananciosa, vestindo como veste a roupagem da Besta de um Cainita, e bebe as energias do sítio de modo imprudente. Uma Lhiannan só pode obter um número de sucessos igual a 10 vezes o valor de poder do sítio, ponto a partir do qual a área se transforma num ermo estéril, incapaz de sustentar vida. Esse tipo de atividade em particular certamente atrairá a atenção de Lupinos ou magos. Um sítio pode se reabastecer ao longo de anos. Contudo, um sítio explorado com Beber a Terra até Secar em qualquer momento do ano é incapaz de repor os dados perdidos naquele ano, e se o sítio for completamente drenado, está irrevogavelmente morto.]==],
				},
				["Potence"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 192


Potence


Membros dotados de Potência possuem força sobrenatural. Essa Disciplina permite ao vampiro saltar distâncias enormes, erguer pesos tremendos e golpear oponentes com força brutal. Mesmo níveis baixos desse poder podem dar aos Membros força física além dos limites mortais. Membros mais poderosos conseguem saltar tão longe que parecem voar, arremessar carros como latas de refrigerante e socar através de paredes como se fossem papelão. Embora as Disciplinas mentais mais sutis possam ser impressionantes, a eficácia brutal da Potência é formidável por si só.
Os Brujah, Giovanni, Lasombra e Nosferatu são naturalmente dotados dessa Disciplina, mas membros de outros Clãs muitas vezes fazem questão de encontrar alguém que possa lhes ensinar o poder assombroso da Potência.
Sistema: Cada ponto que o vampiro tem em Potência acrescenta um dado a todas as rolagens relacionadas a Força. Além disso, o jogador pode gastar um ponto de sangue e transformar seus dados de Potência num número igual de sucessos automáticos em todas as rolagens relacionadas a Força naquele turno. Em combate com armas brancas e briga, os sucessos vindos de Potência (rolados ou automáticos) são aplicados aos resultados da rolagem de dano.]==],
				},
				["Presence"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 193


Presence


Presença é a Disciplina da manipulação emocional. Vampiros com esse poder conseguem inspirar fervor apaixonado ou terror irracional em mortais e Membros igualmente. Além disso, ao contrário da maioria das Disciplinas, alguns dos poderes de Presença podem ser usados em multidões inteiras de uma vez. Presença consegue transcender raça, religião, gênero, classe e (o mais importante) natureza sobrenatural. Assim sendo, esse poder sutil é uma das Disciplinas mais úteis que um vampiro pode possuir.
Qualquer um pode resistir a Presença por uma cena gastando um ponto de Força de Vontade e obtendo sucesso numa rolagem de Força de Vontade (dificuldade 8), mas o indivíduo afetado precisa continuar gastando pontos até não estar mais na presença do vampiro (ou, no caso de Convocação, até o efeito passar). Vampiros de Geração três ou mais níveis abaixo da do usuário só precisam gastar um único ponto de Força de Vontade para ignorar a Presença por uma noite inteira, e não precisam rolar Força de Vontade para isso.
A grande desvantagem da Presença é que ela controla apenas as emoções. Faz com que outros sintam de determinada forma em relação ao vampiro, mas não lhe dá controle direto sobre eles. Embora as pessoas deem muito peso às ordens que o vampiro declara, suas mentes continuam sendo delas. Diretrizes suicidas ou ridículas não soam mais sensatas só porque quem as dá é excepcionalmente fascinante. Ainda assim, eloquência inspirada ou riqueza significativa usadas em combinação com essa Disciplina podem permitir ao vampiro conduzir outros ao rumo desejado.
Os Clãs Brujah, Seguidores de Set, Toreador e Ventrue são todos adeptos dessa Disciplina. Os Ventrue são possivelmente os mais habilidosos na sua aplicação, porém, graças à sua capacidade de usar Presença e Dominação em combinação eficiente.

• Assombro
Aqueles próximos ao vampiro subitamente desejam estar mais perto dela e ficam receptivos ao seu ponto de vista. Assombro é extremamente útil para comunicação em massa. Pouco importa o que se diz — os corações dos afetados pendem para a opinião do vampiro. Os fracos querem concordar com ela; mesmo que os de vontade forte resistam, logo se veem em minoria. Assombro pode transformar uma deliberação incerta numa resolução certa em favor do vampiro quase antes que seus oponentes percebam que a maré virou.
Apesar da intensidade dessa atração, os assim arrebatados não perdem o senso de autopreservação. O perigo quebra o encanto do fascínio, assim como sair da área. Aqueles sujeitos ao Assombro se lembrarão de como se sentiram na presença do vampiro, porém. Isso influenciará suas reações caso a encontrem de novo.
Sistema: O jogador gasta um ponto de sangue e rola Carisma + Performance (dificuldade 7). O número de sucessos rolados determina quantas pessoas são afetadas, conforme a tabela abaixo. Se houver mais pessoas presentes do que o personagem pode influenciar, Assombro afeta primeiro as de menor valor de Força de Vontade. O poder permanece em vigor pelo resto da cena ou até que o personagem escolha encerrá-lo.
1 sucesso — Uma pessoa
2 sucessos — Duas pessoas
3 sucessos — Seis pessoas
4 sucessos — 20 pessoas
5 sucessos — Todos nas imediações do vampiro (um auditório inteiro, uma multidão)
Os afetados podem usar pontos de Força de Vontade para superar o efeito, mas precisam continuar gastando Força de Vontade a cada cena enquanto permanecerem na mesma área que o vampiro. Assim que um indivíduo gastar um número de pontos de Força de Vontade igual aos sucessos rolados, ele se livra completamente do Assombro e permanece imune pelo resto da noite.

•• Olhar Aterrador
Embora todos os Membros consigam assustar os outros revelando fisicamente sua verdadeira natureza vampírica — expondo garras e presas, encarando com malevolência, sibilando alto com maldade —, esse poder concentra esses elementos em níveis insanamente aterrorizantes. Olhar Aterrador engendra terror insuportável na vítima, estupidificando-a até a loucura, a imobilidade ou a fuga desabalada. Até o indivíduo mais firme recuará diante do semblante horrendo do vampiro.
Sistema: O jogador rola Carisma + Intimidação (dificuldade igual ao Raciocínio + Coragem da vítima). O sucesso indica que a vítima é acovardada, enquanto a falha significa que o alvo fica assustado, mas não aterrorizado com a visão. Três ou mais sucessos significam que ele foge em medo absoluto; vítimas que não têm para onde correr arranham as paredes, na esperança de cavar uma saída em vez de encarar o vampiro. Além disso, cada sucesso subtrai um das paradas de dados de ação do alvo no turno seguinte.
O personagem pode tentar Olhar Aterrador uma vez por turno contra um único alvo, embora também possa executá-lo como ação estendida, somando seus sucessos para subjugar o alvo completamente. Uma vez que o alvo perde dados suficientes para não conseguir realizar nenhuma ação, ele fica tão abalado e aterrorizado que se encolhe no chão e chora. A falha durante a ação estendida significa que a tentativa fracassa. O personagem perde todos os sucessos acumulados e pode recomeçar no turno seguinte, enquanto a vítima pode agir normalmente de novo.
Uma falha crítica a qualquer momento indica que o alvo não fica nem um pouco impressionado — talvez até ache as palhaçadas do vampiro cômicas — e permanece imune a quaisquer outros usos de Presença por parte do personagem pelo resto da história.

••• Enlevo
Este poder dobra as emoções alheias, tornando-as servos voluntários do vampiro. Por causa do que esses indivíduos veem como devoção verdadeira e duradoura, eles atendem a todo desejo do vampiro. Como isso é feito voluntariamente, em vez de terem a vontade drenada, esses servos mantêm sua criatividade e individualidade.
Embora esses lacaios obedientes sejam mais agradáveis e animados que os escravos mentais criados por Dominação, também são um tanto imprevisíveis. Além disso, como Enlevo tem duração temporária, lidar com um servo cujo efeito expirou pode dar trabalho. Um Membro sábio ou se desfaz daqueles que Enleva depois que cumprem sua utilidade, ou os prende de forma mais segura por um laço de sangue (o que fica muito mais fácil com a boa vontade do lacaio em servir).
Sistema: O jogador gasta um ponto de sangue e rola Aparência + Empatia (dificuldade igual aos pontos atuais de Força de Vontade do alvo); o número de sucessos determina por quanto tempo o sujeito fica Enlevado, conforme a tabela abaixo. (Sujeitos ainda podem gastar Força de Vontade para resistir temporariamente, como em qualquer outro poder de Presença.) O Narrador pode preferir fazer a rolagem, já que o personagem nunca tem certeza da força do seu domínio sobre a vítima. O vampiro pode tentar manter o sujeito sob seu jugo, mas só depois que o Enlevo inicial passar. Tentar esse poder enquanto o Enlevo já está em operação não tem efeito.
Falha crítica — O sujeito não pode ser enlevado pelo resto da história.
Falha — O sujeito não pode ser enlevado pelo resto da noite.
1 sucesso — Uma hora
2 sucessos — Um dia
3 sucessos — Uma semana
4 sucessos — Um mês
5 sucessos — Um ano

•••• Convocação
Este poder impressionante permite ao vampiro chamar até si qualquer pessoa que já tenha encontrado. Esse chamado pode ir a qualquer um, mortal ou sobrenatural, através de qualquer distância dentro do mundo físico. O sujeito da Convocação vem tão rápido quanto consegue, possivelmente sem sequer saber por quê. Ele sabe intuitivamente como encontrar quem o Convocou — mesmo que o vampiro se mude para outro lugar, o sujeito redireciona seu próprio caminho assim que pode. Afinal, ele está indo até o próprio vampiro, não até algum local predeterminado.
Embora esse poder permita ao vampiro chamar alguém através de uma distância impressionante, é mais útil quando usado localmente. Mesmo que a pessoa desejada reserve o próximo voo disponível, chegar a Quioto partindo de Milwaukee ainda pode levar muito mais tempo do que o vampiro precisa. Obviamente, os recursos financeiros do indivíduo são um fator; se ele não tiver dinheiro para viajar rápido, levará muito mais tempo para chegar.
O sujeito pensa principalmente em alcançar o vampiro, mas não negligencia o próprio bem-estar. Isso conta menos se ele só precisa atravessar uma sala, a menos que tenha de passar por uma gangue de arruaceiros armados para isso. O indivíduo mantém seus instintos de sobrevivência, e embora não se furte à violência física para chegar ao lado do vampiro, não se submeterá a situações suicidas.
A Convocação se dissipa ao amanhecer. A menos que o sujeito seja treinado a continuar rumo ao vampiro depois do primeiro chamado, o imortal precisa Convocar a cada noite até o alvo chegar. Ainda assim, enquanto o vampiro estiver disposto e capaz, tem a certeza de que receberá o sujeito desejado alguma noite — desde que nada aconteça a ele pelo caminho, claro.
Sistema: O jogador gasta um ponto de sangue e rola Carisma + Subterfúgio. A dificuldade base é 5; ela sobe para 7 se o sujeito foi encontrado apenas brevemente. Se o personagem usou Presença com sucesso no alvo no passado, essa dificuldade cai para 4, mas se a tentativa foi malsucedida, a dificuldade sobe para 8.
O número de sucessos indica a velocidade e a atitude do sujeito ao responder:
Falha crítica — O sujeito não pode ser Convocado por aquele vampiro pelo resto da história.
Falha — O sujeito não pode ser Convocado por aquele vampiro pelo resto da noite.
1 sucesso — O sujeito se aproxima devagar e hesitante.
2 sucessos — O sujeito se aproxima com relutância e é facilmente barrado por obstáculos.
3 sucessos — O sujeito se aproxima com velocidade razoável.
4 sucessos — O sujeito vem com pressa, superando quaisquer obstáculos no seu caminho.
5 sucessos — O sujeito corre até o vampiro, fazendo qualquer coisa para chegar até ela.

••••• Majestade
Nesse estágio, o vampiro consegue ampliar mil vezes seu semblante sobrenatural. Os atraentes se tornam paralisantemente belos; os sem graça se tornam horrendamente distorcidos. Majestade inspira respeito, devoção e medo universais — ou todas essas emoções ao mesmo tempo — naqueles ao redor do vampiro. Os fracos se atropelam para obedecer a cada capricho dela, e mesmo os mais intrépidos acham quase impossível negar-lhe algo.
As pessoas afetadas acham o vampiro tão formidável que não ousam arriscar seu desagrado. Erguer a voz para ela é difícil; erguer a mão contra ela é impensável. Os poucos que se livram do potente mistério do vampiro o bastante para se opor a ela são silenciados aos gritos pelos muitos sob seu jugo, antes mesmo que a imortal precise responder.
Sob a influência da Majestade, corações se partem, o poder treme e os ousados se abalam. Membros sábios usam esse poder com cautela, tanto contra mortais quanto contra imortais. Embora a Majestade possa acovardar políticos influentes e Primogênitos veneráveis, o vampiro precisa tomar cuidado para que isso não volte a assombrá-la. Afinal, um dignitário rebaixado diante dos outros perde sua utilidade rapidamente, enquanto um Membro humilhado tem séculos para planejar vingança.
Sistema: Nenhuma rolagem é exigida da parte do vampiro, mas ela precisa gastar um ponto de Força de Vontade. Um sujeito precisa fazer uma rolagem de Coragem (dificuldade igual ao Carisma + Intimidação do vampiro, até um máximo de 10) se quiser ser grosseiro ou simplesmente contrário ao vampiro. O sucesso permite ao indivíduo agir normalmente naquele momento, embora ele sinta o peso do desagrado do vampiro esmagando-o. Um sujeito que falhe na rolagem aborta a ação pretendida e chega a ir a extremos absurdos para se humilhar diante do vampiro, não importa quem mais esteja assistindo. Os efeitos da Majestade duram uma cena.]==],
				},
				["Protean"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 199


Protean


Metamorfose concede ao Membro a capacidade mística de manipular sua forma física. Alguns vampiros acreditam que o poder venha de uma conexão intensificada com o mundo natural, enquanto outros o consideram uma ampliação da marca de Caim. Seja qual for sua base, aqueles que desenvolvem essa Disciplina conseguem fazer crescer garras bestiais, assumir as formas de morcegos e lobos, transformar-se em névoa e até se fundir com a própria terra.
Membros transformados geralmente conseguem usar outras Disciplinas — vampiros em forma de lobo ainda podem ler auras e se comunicar com outros animais, por exemplo. Contudo, o Narrador pode decidir que certas Disciplinas não podem ser usadas em situações específicas. As roupas e os pertences pessoais do Membro também mudam quando ele se transforma (presumivelmente absorvidos na sua própria substância), embora armaduras e afins não ofereçam benefício algum enquanto transformado.
Vampiros não conseguem mudar ou transformar objetos grandes nem outros seres; Metamorfose é uma expressão pessoal de poder. Um Membro que tenha sido empalado (aprisionando assim sua alma dentro do corpo) não consegue se transformar. Alguns vampiros acreditam que aqueles que dominaram os níveis mais altos de Metamorfose podem negar essa limitação, porém.
O Clã Gangrel é bem conhecido pelo seu domínio da Metamorfose, embora outros Membros tenham aprendido alguns dos segredos dessa Disciplina com esses Cainitas bestiais.

• Olhos da Besta
O vampiro enxerga perfeitamente na escuridão total, não precisando de fonte de luz para notar detalhes mesmo no porão ou na caverna mais escura. A Besta do vampiro fica evidente nos seus olhos vermelhos e brilhantes, uma visão certa de perturbar a maioria dos mortais.
Sistema: O personagem precisa declarar seu desejo de invocar os Olhos. Nenhuma rolagem é necessária, mas a mudança exige um turno inteiro para se completar. Enquanto manifesta os Olhos, o personagem sofre +1 de dificuldade em todas as rolagens Sociais com mortais, a menos que tome medidas para proteger os olhos (óculos escuros são a solução mais simples). (Um vampiro sem esse poder que esteja imerso em escuridão total sofre as penalidades de combate às cegas conforme a p. 274.)

•• Garras Ferinas
As unhas do vampiro se transformam em garras longas e bestiais. Essas garras são cruelmente afiadas, capazes de rasgar carne com facilidade e até de talhar pedra e metal sem muito esforço. A Besta também é proeminente nas garras, tornando-as armas temíveis contra outros imortais. Rumores dizem que alguns Gangrel modificaram esse poder para transformar suas presas vampíricas em presas viciosas de javali.
Sistema: As garras crescem automaticamente em resposta ao desejo do personagem, e podem crescer tanto das mãos quanto dos pés. A transformação exige o gasto de um ponto de sangue, leva um único turno para se completar e dura uma cena.
O personagem ataca normalmente em combate, mas as garras infligem Força + 1 de dano agravado. Outros sobrenaturais normalmente não conseguem absorver esse dano, embora um poder como Fortitude possa ser usado. Além disso, as dificuldades de todas as rolagens de escalada são reduzidas em dois.

••• Fusão com a Terra
Um dos poderes mais valorizados dentro da Metamorfose, Fusão com a Terra permite ao vampiro se tornar um com a terra. O imortal literalmente afunda no solo nu, transmutando sua substância para se ligar à terra.
Embora o vampiro possa se imergir completamente no solo, ele não consegue se mover dentro dele. Além disso, é impossível se fundir à terra através de outra substância. Ripas de madeira, asfalto, até grama artificial bloqueiam a eficácia da Fusão com a Terra — por outro lado, é relativamente simples para um vampiro nesse nível de poder fazer crescer garras e rasgar o piso o bastante para expor o solo cru embaixo.
Ao se enterrar no chão, o vampiro ganha proteção completa contra a luz do dia quando ao ar livre. É também o método preferido dos Membros que desejam dormir por séculos; esses vampiros se trancam no abraço da terra, ganhando força e poder enquanto descansam. Membros supersticiosos e paranoicos sussurram que milhares de Anciões dormem dentro do solo e despertarão quando a Gehenna chegar.
Enquanto assim enterrado, o vampiro está num estado de transição entre carne e terra. Sua presença física existe entre o mundo físico e o plano astral. Assim sendo, o vampiro é difícil de sentir, mesmo por meios sobrenaturais. Contudo, uma perturbação no solo que o imortal ocupa, ou na sua presença no reino astral, o devolve imediatamente ao mundo físico (e à vigília plena), espalhando terra para fora enquanto seu corpo desloca o solo.
Sistema: Nenhuma rolagem é necessária, embora o personagem precise gastar um ponto de sangue. Afundar na terra é automático e leva um turno para se completar. O personagem cai num estado um passo acima do torpor durante esse tempo, sentindo o ambiente apenas distantemente. O jogador precisa fazer uma rolagem de Humanidade ou Caminho (dificuldade 6) para que o personagem desperte em resposta a um perigo antes do momento desejado de emergir.
Como o personagem está num estado intermediário, quaisquer tentativas de localizá-lo (captar seu cheiro, escanear sua aura, viajar astralmente e assim por diante) são feitas com +2 de dificuldade. Indivíduos astrais não conseguem afetar o vampiro diretamente, encontrando em vez disso uma espécie de resistência esponjosa enquanto suas mãos o atravessam. Do mesmo modo, cavar no mundo material encontra terra incrivelmente compactada, praticamente tão densa quanto pedra.
Tentativas de violência contra o vampiro submerso, de qualquer um dos lados, o devolvem à sua natureza física, expelindo o solo ao qual se ligou num jato ofuscante (todas as rolagens baseadas em Percepção ficam com +2 de dificuldade naquele turno). O próprio personagem subtrai dois da sua iniciativa no primeiro turno após sua restauração, devido à desorientação momentânea. Uma vez expelido da terra, o vampiro pode agir normalmente.

•••• Forma da Besta
Isso dota o vampiro da lendária capacidade de se transformar em lobo ou morcego. Um Membro assim transformado é um representante particularmente imponente do reino animal. De fato, ele é muito superior a animais normais, mesmo aos possuídos por Absorver o Espírito. Ele mantém sua própria psique e temperamento, mas ainda pode recorrer às capacidades da forma bestial — sentidos aumentados para o lobo e voo para o morcego. Diz-se que os Gangrel se transformam em outras formas animais mais adequadas ao seu ambiente — chacais na África, cuões na Ásia e até ratos enormes em ambientes urbanos —, um feito que outros Clãs que aprendem Metamorfose parecem não conseguir duplicar.
Sistema: O personagem gasta um ponto de sangue para assumir a forma desejada. A transformação exige três turnos para se completar (gastar pontos de sangue adicionais reduz o tempo de transformação em um turno por ponto gasto, até um mínimo de um). O vampiro permanece na sua forma bestial até o amanhecer seguinte, a menos que deseje voltar antes.
Enquanto na forma do animal, o vampiro pode usar qualquer Disciplina que possua, exceto Necromancia, Serpentis, Taumaturgia ou Vicissitude (bem como quaisquer outras que o Narrador julgue indisponíveis). Além disso, cada forma dá ao personagem as capacidades daquela criatura. Em forma de lobo, os dentes e garras do vampiro infligem Força + 1 de dano agravado, ele pode correr no dobro da velocidade e as dificuldades de todas as rolagens de Percepção são reduzidas em dois. Em forma de morcego, a Força do vampiro é reduzida a 1, mas ele pode voar a até 30 quilômetros por hora, as dificuldades de todas as rolagens de Percepção baseadas em audição são reduzidas em três, e ataques feitos contra ele ficam com +2 de dificuldade devido ao seu tamanho pequeno.
O Narrador pode permitir que os Gangrel assumam uma forma animal diferente, mas deve estabelecer as capacidades naturais que ela concede ao personagem.

••••• Forma de Névoa
Este poder verdadeiramente perturbador permite ao vampiro se transformar em névoa. Sua forma física se dispersa numa nuvem enevoada, mas ainda inteiramente sujeita à vontade do imortal. Ele flutua num ritmo ágil e pode passar por baixo de portas, através de telas, por dentro de canos e por outras aberturas minúsculas. Embora ventos fortes possam desviar o vampiro do seu curso escolhido, nem ventos de força de furacão conseguem dispersar sua forma de névoa.
Alguns Membros sentem que esse poder é uma expressão do controle definitivo do vampiro sobre o mundo material, enquanto outros acreditam que seja a alma do imortal tornada manifesta (por mais condenada que seja).
Sistema: Nenhuma rolagem é exigida, embora um ponto de sangue precise ser gasto. A transformação leva três turnos para se completar, embora o personagem possa reduzir esse tempo em um turno para cada ponto de sangue adicional gasto (até um mínimo de um turno). Ventos fortes podem sacudir o personagem, embora Disciplinas como Potência possam ser usadas para resistir a eles. Vampiros em Forma de Névoa conseguem perceber o ambiente normalmente, embora não possam usar poderes que exijam contato visual.
O vampiro é imune a todos os ataques físicos mundanos enquanto está em forma de névoa, embora ataques sobrenaturais o afetem normalmente. Além disso, o vampiro sofre um dado a menos de dano de fogo e luz do sol. O personagem não pode atacar outros fisicamente nesse estado — isso inclui encontrar outro vampiro em forma de névoa. Ele pode usar Disciplinas que não exijam substância física, porém.]==],
				},
				["Quietus"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 203


Quietus


A Disciplina da morte silenciosa, Quietus é praticada pelos do Clã Assamita. Baseada em elementos de sangue, veneno, controle de vitae e peste, Quietus se concentra na destruição de um alvo por uma variedade de meios. Essa Disciplina nem sempre causa uma morte rápida, mas os Assamitas contam com sua letalidade para esconder seu envolvimento com as vítimas.

• Silêncio da Morte
Muitos Assamitas afirmam nunca ter ouvido os gritos de morte dos seus alvos. Silêncio da Morte imbui o vampiro de um silêncio místico que irradia do seu corpo, abafando todo ruído dentro de certas imediações. Nenhum som ocorre dentro dessa zona, embora sons originados fora da área de efeito possam ser ouvidos por quem estiver dentro dela. Abundam rumores de certos vizires Assamitas habilidosos que teriam a capacidade de silenciar um local em vez de uma circunferência que os acompanha, mas nenhuma prova disso apareceu.
Sistema: Este poder (que custa um ponto de sangue para ativar) mantém um raio de 6 metros de quietude absoluta ao redor do Membro por uma hora.

•• Toque do Escorpião
Mudando as propriedades do seu sangue, um vampiro pode criar um veneno poderoso que despoja sua presa de resiliência. Esse poder é muito temido por outros Membros, e toda sorte de histórias medonhas sobre métodos de aplicação circula entre coteries trêmulas. Sabe-se que Membros com Quietus aplicam o veneno untando suas armas com ele, atingindo seus oponentes com um toque ou cuspindo-o como uma naja. Um relato apócrifo fala de uma Príncipe orgulhosa que descobriu um Assamita tramando sua exsanguinação e começou a diaborizar seu quase-assassino. Na metade do ato, ela percebeu que havia ingerido uma quantidade terrível de sangue contaminado e ficou então incapaz de resistir ao ataque renovado do enfraquecido hashashiyyin.
Sistema: Para converter um pouco do seu sangue em veneno, o jogador do Membro gasta ao menos um ponto de sangue e rola Força de Vontade (dificuldade 6). Se essa rolagem for bem-sucedida, e o vampiro acertar (mas não necessariamente danificar) seu oponente, o alvo perde um número de pontos de Vigor igual ao número de pontos de sangue convertidos em veneno — vampiros que tentem beber o sangue do Membro com Toque do Escorpião são automaticamente considerados como "acertados com sucesso".
A vítima pode resistir ao veneno com uma rolagem de Vigor + Fortitude (dificuldade 6); os sucessos obtidos na rolagem de resistência subtraem-se dos sucessos do vampiro. O número máximo de pontos de sangue que um Membro pode converter de uma vez é igual ao seu Vigor. O número de sucessos obtidos indica a duração da perda de Vigor.
1 sucesso — Um turno
2 sucessos — Uma hora
3 sucessos — Um dia
4 sucessos — Um mês
5 sucessos — Permanentemente (embora o Vigor possa ser recomprado com experiência)
Se o Vigor de um mortal cair a zero pelo uso do Toque do Escorpião, ela fica terminalmente doente e perde qualquer imunidade a doenças, seu corpo sucumbindo a enfermidades dentro de um ano, a menos que de algum modo consiga aumentar o Vigor de novo. Se o Vigor de um Membro cair a zero, o vampiro entra em torpor e assim permanece até que um dos seus pontos de Vigor retorne. Se um Membro for permanentemente reduzido a Vigor zero, ela só pode se recuperar do torpor por meios místicos.
Para afligir alguém com o veneno, o Cainita precisa tocar a carne do alvo ou acertá-lo com algo que carregue a peçonha. Muitos Assamitas untam suas armas com a secreção, enquanto outros acumulam a toxina nas mãos (ou salpicam os lábios com o veneno, para um "beijo da morte") e a pressionam contra os oponentes. Armas assim envenenadas precisam ser do tipo corpo a corpo — flechas, pedras de funda, balas, armas de arremesso e afins não conseguem carregar material suficiente para causar dano, ou ele escorre em voo. Jogadores cujos vampiros queiram cuspir nos alvos precisam fazer uma rolagem de Vigor + Esportes (dificuldade 6). Não mais que dois pontos de sangue de veneno podem ser expectorados, e um Membro pode cuspir a uma distância de 3 metros para cada ponto de Força (e Potência) que o personagem possua. Vampiros com Quietus são imunes ao próprio veneno, mas não ao sangue-peçonha de outros Membros com esse poder.

••• Chamado de Dagon
Este poder terrível permite a um vampiro afogar seu alvo no próprio sangue dele. Concentrando-se, o Membro rompe os vasos sanguíneos do alvo e enche seus pulmões de vitae, que o estrangula por dentro. O sangue de fato constringe o corpo do alvo de dentro para fora enquanto inunda seu organismo; assim, funciona até em Membros que não respiram. Até que o alvo desabe em agonia ou em estertores de morte, esse poder não tem efeito visível, e muitos Membros gostam dele porque não deixa traço da sua presença.
Sistema: O vampiro precisa tocar seu alvo antes de usar o Chamado de Dagon. Dentro de uma hora depois disso, o vampiro pode emitir o chamado, embora não precise estar na presença nem sequer no campo de visão do alvo.
Invocar o poder custa um ponto de Força de Vontade. O jogador do Membro faz uma rolagem resistida de Vigor contra o Vigor do alvo; a dificuldade de cada rolagem é igual ao valor de Força de Vontade permanente do oponente. O número de sucessos que o vampiro usando o Chamado de Dagon obtiver é a quantidade de dano letal, em níveis de vitalidade, que a vítima sofre. Por um ponto adicional de Força de Vontade gasto no turno seguinte, o vampiro pode continuar usando o Chamado de Dagon fazendo outra rolagem resistida de Vigor. Enquanto o jogador do Membro continuar gastando Força de Vontade, o personagem pode continuar dilacerando seu oponente por dentro.

•••• Carícia de Baal
O penúltimo uso do sangue como arma (aquém da própria diaborização), Carícia de Baal permite ao Membro transmutar seu sangue num icor virulento que destrói qualquer carne viva ou morta-viva que toque. Em noites de outrora, quando os Assamitas lideravam as investidas das legiões sarracenas, era comum ver os Assassinos lambendo suas lâminas, cortando a própria língua e untando as armas com essa secreção imunda.
Carícia de Baal pode ser usada para potencializar qualquer arma de lâmina; já se relatou de tudo, de facas e espadas envenenadas a unhas e garras contaminadas.
Sistema: Carícia de Baal não aumenta o dano causado por uma dada arma, mas essa arma inflige dano agravado em vez de normal. Nenhuma rolagem é necessária para ativar esse poder, mas um ponto de sangue é consumido por acerto. Por exemplo, se um Cainita envenena sua faca e golpeia o oponente (mesmo sem infligir dano), um ponto de sangue de lubrificação desaparece. Por essa razão, muitos vampiros escolhem cobrir suas armas com uma quantidade significativa de sangue. Se o vampiro errar, nenhum sangue contaminado é consumido.

••••• Sabor da Morte
Um refinamento da Carícia de Baal, Sabor da Morte permite ao Cainita cuspir sangue cáustico no alvo. O sangue expelido com esse poder queima a carne e corrói os ossos; já se relatou de vampiros que vomitam jorros volumosos de vitae capazes de reduzir seus alvos a montes de lodo.
Sistema: O vampiro pode cuspir até 3 metros para cada ponto de Força e Potência que possua. Acertar o alvo exige uma rolagem de Vigor + Esportes (dificuldade 6). Cada ponto de sangue jorrado no alvo inflige dois dados de dano agravado, e não há limite (além da capacidade do vampiro e do máximo de gasto por turno) para a quantidade de sangue com que um alvo pode ser inundado.]==],
				},
				["Sanguinus"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 463


Sanguinus


Sanguinus é a Disciplina insalubre concedida aos Irmãos de Sangue pelos Tzimisce que os criaram. Uma parente curiosa de Vicissitude, Sanguinus permite aos vampiros que a praticam combinar partes dos seus corpos, emprestá-las a outros e coordenar suas mentes e apêndices. Mesmo os níveis baixos dela são perturbadores de assistir. O uso dos níveis mais altos é francamente repugnante, com carne aberta e órgãos expostos, atrofiados pelo estado de não-vida dos Irmãos de Sangue, fundindo-se e pulsando. Mortais que observam o espetáculo dos poderes mais evidentes dessa Disciplina precisam fazer rolagens de Coragem (dificuldade 4), gastar um ponto de Força de Vontade ou fugir da área enojados.

• Sangue do Irmão
Um círculo de Irmãos de Sangue é mais próximo que qualquer matilha Sabbat, que qualquer par de amantes vampíricos ligados pelo sangue, que qualquer família de carniçais. O círculo compartilha carne, mente e, claro, sangue. Os membros do círculo podem gastar sangue para curar os corpos uns dos outros, não importa a distância entre eles.
Sistema: O jogador gasta um ponto de sangue, que pode ser usado para curar qualquer membro do círculo, independentemente da distância em relação ao personagem. O Irmão de Sangue também pode "poupar" sangue, gastando cinco pontos para curar um ferimento agravado de outro ao longo de vários turnos. Esse poder tem efeito automático; nenhuma rolagem é necessária. Sangue gasto por outro Frankenstein não conta contra a quantidade máxima de vitae que o personagem alvo pode gastar por turno.

•• Octópode
O círculo de Irmãos de Sangue pode doar membros e órgãos uns aos outros. Isso não serve para curar depois da batalha, mas para uso durante a batalha. Um oponente enfrentando os Irmãos de Sangue pode ver um dos seus adversários fazer crescer um segundo par de pernas (tornando-o quase impossível de derrubar), outro par de braços (significando que ele pode bloquear ou aparar quase qualquer ataque), olhos extras para visão de 360 graus, ou uma boca extra para maior consumo de sangue. Claro, o Frankenstein que abre mão do órgão pode ficar como um caroço de carne sem membros, sem olhos e sem boca à beira do campo de batalha, mas os Irmãos de Sangue nunca parecem se importar com isso.
Sistema: O jogador "doador" gasta um ponto de sangue para cada membro ou órgão que queira emprestar ao outro membro do círculo. (Só o doador precisa ter esse nível de maestria em Sanguinus; o receptor pode ser qualquer outro membro do círculo do doador.) Os órgãos emprestados aparecem no fim daquele turno, no local que o receptor quiser — já se viram olhos na nuca ou nas pontas das mãos, assim como cabeças inteiras localizadas entre as pernas de um Irmão de Sangue. O uso desse poder não confere ataques extras, mas pode permitir entrada sensorial adicional, mais sangue consumido num único turno, ou mãos extras para segurar armas ou imobilizar adversários. Apenas órgãos externos podem ser emprestados dessa maneira — corações, estômagos e cérebros não.

••• Gestalt
Os Irmãos de Sangue compartilham uma mente-colmeia; essa capacidade foi um dos princípios norteadores por trás da sua criação. O poder Gestalt é essa mente-colmeia, a capacidade dos Frankensteins de se coordenar silenciosa e perfeitamente em batalha, de evitar poderes de controle mental e de agir em uníssono.
Sistema: Este poder confere vários benefícios aos Irmãos de Sangue. Para que funcione, porém, todo Irmão de Sangue do círculo precisa gastar um ponto de sangue. Se sequer um membro não puder ou não quiser gastar um ponto de sangue, esse poder falha. Uma vez que um Irmão de Sangue encontra a Morte Final, ele deixa de fazer parte do círculo, de modo que o poder continua funcionando entre os membros ainda mortos-vivos do grupo. Gestalt dura uma cena. Enquanto esse poder está ativo:
• Dominação, Presença e afins fazem efeito contra o maior valor de Força de Vontade do círculo. Por exemplo, se um vampiro tentar Dominar um Irmão de Sangue sob a influência do Gestalt, ela precisa rolar contra o maior valor de Força de Vontade que qualquer um dos vampiros do círculo possua, mesmo que seu sujeito tenha o menor valor de Força de Vontade do círculo. Além disso, um Irmão de Sangue afetado por poderes dessa maneira sai do Gestalt, embora o Gestalt permaneça ativo para os outros. Esse "fusível" mental teria sido criado para impedir que o círculo inteiro fosse Dominado por um vampiro olhando nos olhos de um único Irmão de Sangue.
• As dificuldades de Percepção de todos os Irmãos de Sangue do círculo diminuem em três, pois eles compartilham a entrada sensorial dos outros vampiros do círculo.
• Não realizando nenhuma ação além de se concentrar, um Irmão de Sangue pode "emprestar" uma Habilidade a outro irmão. Por exemplo, um vampiro ferido com Armas Brancas 4 pode sair do combate e emprestar a um companheiro de círculo com Armas Brancas 2 seu domínio daquela Perícia. O vampiro que "toma emprestado" faz testes de Habilidade contra o Traço emprestado como se fosse seu.
• Os Irmãos de Sangue no Gestalt podem se comunicar por telepatia, o que lhes permite coordenar ações. Em termos de jogo, apenas uma rolagem de iniciativa é feita para o círculo, baseada no personagem com o maior valor de iniciativa (veja a p. 271).
Nem todos os Irmãos de Sangue do círculo precisam ter esse nível de Sanguinus para se beneficiar do Gestalt. Se um dado personagem não conhece esse poder, porém, o jogador rola Raciocínio + Ocultismo (dificuldade 7) quando o poder é ativado. Se essa rolagem falhar, o personagem ainda pode receber Habilidades emprestadas, mas não ganha nenhum outro benefício do Gestalt.

•••• Caminhada de Caim
A teoria feiticeira por trás dos Irmãos de Sangue se lê como um tratado filosófico sobre a natureza da individualidade, do livre-arbítrio e da hematologia. Os Frankensteins não são um grupo de vampiros, mas um vampiro em vários corpos, ou assim diz a teoria. Assim sendo, qualquer das suas características precisa ser vista como um contínuo — eles não são individualmente de Décima Segunda, Décima Primeira e Décima Terceira Gerações, por exemplo, mas coletivamente de Nona Geração em qualquer momento. Embora a metafísica desse tipo de raciocínio faça doer a cabeça da maioria dos vampiros, parece haver algo nisso. Um Irmão de Sangue pode extrair força do seu círculo, baixando sua Geração para permitir maiores feitos de gasto de vitae.
Sistema: Cada membro do círculo pode "doar" um degrau de Geração. No exemplo acima, o vampiro de Décima Primeira Geração poderia tomar um degrau de cada um dos seus dois companheiros de círculo e cair para a Nona, mas o vampiro de Décima Terceira Geração não poderia cair abaixo da Décima Primeira. Não importa o tamanho do círculo, nenhum Irmão de Sangue pode cair a uma Geração efetiva inferior à Quarta. Do mesmo modo, um Irmão de Sangue de Décima Terceira Geração pode cair a uma Geração efetiva de Décima Quarta, o que traz consigo as penalidades listadas no Defeito Décima Quarta Geração (p. 481). (Ele não pode ir para a Décima Quinta Geração, porém.)
Como no Gestalt, apenas um Irmão de Sangue precisa conhecer esse poder para iniciar o processo. Os que não tiverem Caminhada de Caim precisam fazer uma rolagem de Vigor + Consciência (dificuldade 7). Se essa rolagem falhar, eles não podem participar da ação.

••••• Entidade Coagulada
Os Irmãos de Sangue se fundem num monte carnudo e sangrento de horror. Esse colosso avança, esmagando e consumindo tudo em seu caminho. A Sabbat aprendeu, para seu desgosto, que se os Irmãos de Sangue não forem explicitamente mandados se separar depois de usar esse poder, eles não se separam. Essa fusão é, aparentemente, o que os Irmãos de Sangue verdadeiramente querem.
Sistema: Todo vampiro do círculo que deseje se tornar parte da Entidade Coagulada gasta três pontos de sangue. Três turnos depois de o processo começar, o monstro está completo e apto a agir. O vampiro de Geração mais baixa que faz parte do constructo guia as ações da criatura. A Geração real da própria criatura, contudo, é a Geração mais alta de qualquer vampiro presente no constructo, menos um para cada vampiro adicional presente no constructo. (Usando o exemplo anterior, o vampiro de Décima Primeira Geração seria o guia, mas a Geração mais alta é 13, então a Entidade geral seria 13 menos 2, ou Décima Primeira Geração.)
A Força, o Vigor e a Percepção da criatura são iguais aos do guia, com +1 para cada vampiro adicional contido nela. (Limites de Geração não se aplicam a essa criatura — por puro tamanho, uma Entidade Coagulada pode ter Força 7 ou mais.) Todas as ações físicas empreendidas pela monstruosidade ganham um dado extra na parada para cada vampiro além do primeiro presente no constructo (antes de dividir as paradas de dados).
Apenas um vampiro do círculo precisa possuir Sanguinus em Nível Cinco para que esse poder funcione. Partes do corpo tendem a se deslocar durante a criação de uma Entidade Coagulada — fauces cheias de presas nas pontas das mãos e olhos no alto de hastes carnudas já foram relatados por sobreviventes aterrorizados. Narradores devem se sentir à vontade para dar quaisquer bônus (ou penalidades) ao constructo como acharem melhor.
Uma Entidade Coagulada não pode ser empalada, pois tem corações demais em lugares nada convencionais para que qualquer coisa além da sorte mais cega os transpasse. Ela tem os sete níveis de vitalidade normais de um vampiro, mais dois para cada vampiro adicional que se torne parte da entidade (trate esses níveis de vitalidade extras como Escoriado). A entidade permanece coagulada por uma cena, a menos que o Narrador queira decidir que ninguém mandou os Irmãos de Sangue se separarem.]==],
				},
				["Serpentis"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 209


Serpentis


Acredita-se que Serpentis seja o legado do próprio Set, um presente aos seus filhos. Os Seguidores de Set são muito cuidadosos em guardar os segredos dessa Disciplina, ensinando a arte apenas àqueles que julgam dignos. A maioria dos vampiros teme os Setitas por causa dos poderes de Serpentis e da sua conexão com cobras e répteis; essa Disciplina consegue evocar um medo primordial nos outros, particularmente naqueles que se lembram da história do Éden.

• Os Olhos da Serpente
Este poder concede ao vampiro o lendário olhar hipnótico da serpente. Os olhos do Membro ficam dourados com grandes íris negras, e mortais nas imediações do personagem se veem estranhamente atraídos por ele. Um mortal que encontra o olhar sedutor do vampiro fica imobilizado. Até que o personagem tire os olhos da vítima, a pessoa fica paralisada no lugar.
Sistema: Nenhuma rolagem é exigida, mas esse poder pode ser evitado se o mortal tomar cuidado para não olhar nos olhos do vampiro. Vampiros e outras criaturas sobrenaturais também podem ser afetados por esse poder se o jogador do Cainita obtiver sucesso numa rolagem de Força de Vontade (dificuldade 9). Se atacadas ou de outro modo feridas, criaturas sobrenaturais podem gastar um ponto de Força de Vontade para quebrar o encanto.
Nota: Isto é diferente do contato visual normal detalhado na p. 152. O alvo precisa conseguir ver os olhos do vampiro para que Os Olhos da Serpente funcionem.

•• A Língua da Áspide
O vampiro pode alongar a língua à vontade, dividindo-a numa bifurcação como a de uma serpente. A língua pode alcançar meio metro, e é uma arma aterrorizantemente eficaz em combate corpo a corpo.
Sistema: O açoite da bifurcação afiada da língua causa ferimentos agravados (dificuldade 6, dano de Força). Se o Membro ferir seu inimigo, ela pode beber sangue do alvo no turno seguinte como se tivesse cravado as presas no pescoço da vítima. Por mais horrendo que seja, o afago da língua é muito parecido com o Beijo, e deixa vítimas mortais indefesas de medo e êxtase. Além disso, a língua é altamente sensível a vibrações, permitindo ao vampiro funcionar com eficácia na escuridão que o Clã prefere. Estalando a língua para dentro e para fora da boca, o vampiro pode reduzir pela metade quaisquer penalidades relativas à escuridão (p. 274).

••• A Pele da Víbora
Recorrendo ao seu Sangue, o vampiro pode transformar sua pele num couro escamoso e mosqueado. Um vampiro nessa forma se torna mais flexível e maleável.
Sistema: O vampiro gasta um ponto de sangue e um ponto de Força de Vontade. Sua pele fica escamosa e mosqueada; isso, combinado à flexibilidade aumentada do personagem, reduz as dificuldades de absorção para 5. O vampiro pode usar seu Vigor para absorver dano agravado de garras e presas, mas não de fogo, luz do sol ou outras energias sobrenaturais. A boca do vampiro se alarga e as presas se alongam, permitindo que sua mordida inflija um dado extra de dano. Por fim, o vampiro pode passar por qualquer abertura larga o bastante para caber sua cabeça.
A Aparência do vampiro cai para 1, e ela é obviamente inumana se observada com algum grau de atenção, embora transeuntes casuais possam não notar, se o vampiro estiver na escuridão ou usando roupas pesadas.

•••• A Forma da Cobra
O Cainita pode mudar sua forma para a de uma enorme naja negra. A serpente pesa tanto quanto a forma humana do vampiro, estende-se por mais de três metros de comprimento e tem cerca de 50 cm de circunferência. A Forma da Cobra concede várias vantagens, incluindo uma mordida venenosa, a capacidade de rastejar por espaços pequenos e um olfato grandemente aguçado. O personagem pode usar quaisquer Disciplinas nessa forma, exceto as que exigem mãos (como Garras Ferinas).
Sistema: O vampiro gasta um ponto de sangue; a mudança é automática, mas leva três turnos. Roupas e pequenos pertences pessoais se transformam junto com o vampiro. O vampiro permanece em forma de serpente até o amanhecer seguinte, a menos que deseje voltar antes. O Narrador pode conceder ao Setita dados de bônus em todas as rolagens de Percepção relacionadas ao olfato, mas as dificuldades de todas as rolagens de audição aumentam em dois. A mordida da naja inflige dano igual ao do vampiro, mas o vampiro não precisa agarrar sua vítima; além disso, o veneno aplicado é fatal para mortais.

••••• O Coração das Trevas
Um Membro com maestria em Serpentis pode arrancar o próprio coração do corpo. Ela pode até usar essa capacidade em outros Cainitas, embora isso exija várias horas de cirurgia macabra. Este poder só pode ser invocado durante a lua nova. Se realizado sob qualquer outra lua, o rito falha. Ao remover o coração, o vampiro o coloca numa pequena urna de barro e então esconde ou enterra a urna com cuidado. Enquanto seu coração estiver escondido, ela não pode ser empalada por nenhuma madeira que atravesse seu peito. Além disso, como o coração é a sede da emoção, as dificuldades de todas as suas rolagens para resistir ao frenesi são dois pontos menores enquanto esse poder estiver em vigor.
Os Cainitas tomam cuidado para manter seus corações longe de perigo. Se alguém se apoderar do seu coração, o vampiro fica completamente à mercê dessa pessoa. O coração só pode ser destruído sendo lançado ao fogo ou exposto à luz do sol. Se isso acontecer, o Membro morre onde está, fervendo até virar um monte escaldante de cinzas e ossos enegrecidos. Cravar uma estaca de madeira num coração exposto lança o vampiro em torpor instantâneo.
Um vampiro pode carregar seu coração consigo, ou ter vários corações falsos enterrados em lugares diferentes. Um Membro esperto muitas vezes evita o esconderijo do próprio coração, para desencorajar a descoberta. Os versados no saber Setita sussurram que os anciões corruptos do Clã muitas vezes guardam os corações dos seus subordinados como mais um método de controle.
Sistema: Este poder não exige rolagem. Aqueles que testemunham um vampiro arrancar o coração do peito (ou cortar o coração de outro vampiro) precisam fazer rolagens de Coragem. A falha indica desde forte desconforto até repulsa completa, possivelmente até Rötschreck.]==],
				},
				["Setite Sorcery"] = {
					pt = [==[Rites of Blood, pág. 36


Setite Sorcery


Existem muitos tipos diferentes de feitiçaria Setita, do wanga semelhante ao vodu ao akhu de base egípcia. As Serpentes da Luz, e seu Clã de origem, os Seguidores de Set, dedicaram grande energia à prática da magia, criando uma série de teosofias radicalmente diferentes a respeito de conjuração e encantamento.
As Serpentes da Luz rejeitam a doutrina Teofidiana (baseada em Set) em todas as suas formas. Aceitam o lugar de Caim como o primeiro vampiro, em vez de aderir às crenças do seu Clã de origem de que Set não descenderia do Pai Sombrio. As Serpentes da Luz acreditam que, através da morte, é possível se tornar um deus. Se ficarem poderosas o bastante, acreditam, poderão se erguer para tomar o domínio da terra, e o controle do mundo espiritual também. Quando um grupo de Setitas egípcios militantes (mais da metade deles Setitas Guerreiros) tentou forçar as serpentes do Novo Mundo a aceitar sua Ortodoxia, empurrou um grande número de Setitas afro-caribenhos para a Espada de Caim. Por causa desse cisma de doutrina (tanto mágica quanto teosófica), as Serpentes da Luz nutrem grande amargura contra os Seguidores de Set, e frequentemente buscam a destruição do seu Clã de origem.
A feitiçaria das Serpentes da Luz exige muitos níveis de iniciação. Um buscador atravessa círculos de mistério e aprende mais a cada passo ao longo da trilha. As quatro Serpentes da Luz que detêm a iniciação mais alta são chamadas de empereurs, e esses vampiros são receptáculos da maioria da sabedoria e do conhecimento Cobra. Por causa da natureza da sua tutela iniciática, os Cobras são ainda mais ciosos dos seus segredos mágicos que a maioria dos outros taumaturgos da Seita, recusando-se a compartilhar o conhecimento das suas práticas rituais mesmo com outros Cobras – a menos que esses adeptos tenham passado pelos ritos de iniciação apropriados.]==],
				},
				["Spiritus"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 465


Spiritus


A Disciplina Spiritus abre ao vampiro mundos e panoramas — e métodos de alimentação — que a maioria dos Membros jamais poderá tocar. Vampiros estão espiritualmente mortos, incapazes de criar vida. O ritual xamânico que criou as Ahrimanes, porém, permitiu uma conexão espiritual entre os mortos-vivos e o vasto mundo vivo ao seu redor. Embora o vampiro mal consiga arranhar a superfície do que xamãs vivos conseguem realizar, a Disciplina Spiritus ainda é formidável.

• Auxílio dos Espíritos
Espíritos estão em toda parte, mas são invisíveis para a maioria dos seres vivos (e não-vivos). Este poder permite ao vampiro despertar brevemente o espírito de um objeto, fazendo com que esse objeto cumpra sua função pretendida melhor e com mais eficiência. Isso de modo algum torna o espírito bem-disposto em relação ao vampiro — não que isso costume importar para a Ahrimane.
Sistema: O personagem toca o objeto, e o jogador gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade 6). Se a rolagem for bem-sucedida, o jogador recebe um bônus na sua parada de dados ao usar aquele item, igual ao número de sucessos rolados. Por exemplo, se o personagem usar esse poder numa arma de fogo e o jogador rolar três sucessos, ela recebe +3 na sua próxima rolagem de Armas de Fogo feita com aquela arma. Bônus não usados desaparecem no fim da cena, e múltiplos usos desse poder não se combinam (o uso mais recente prevalece sobre os anteriores). O personagem pode, contudo, usar o poder em vários objetos que utilize na mesma cena, contanto que tenha sangue para isso.

•• Invocar Feras Espirituais
O vampiro pode não compreender plenamente o elo entre "animal" e "espírito-animal", mas espíritos de animais agressivos costumam estar mais que dispostos a assumir um corpo físico e lutar pelo vampiro. Espíritos de animais curiosos, por sua vez, parecem gostar de destrancar portas ou seguir pessoas. Com esse poder, a Ahrimane pode invocar o espírito de um animal nativo da área e mandá-lo fazer o que lhe é natural.
O espírito assume a forma corpórea do animal apropriado e é capaz de tudo o que o animal normalmente conseguiria fazer. O animal pode seguir ordens telepáticas simples e é ligeiramente mais inteligente do que um animal normal seria (mas ainda não tão inteligente quanto uma pessoa).
Sistema: O animal invocado precisa ser nativo da área — só porque o zoológico local abriga um tigre não significa que haja espíritos-tigre por aí. O jogador precisa gastar um ponto de sangue e rolar Carisma + Empatia com Animais (dificuldade 7). O número de sucessos indica por quanto tempo o espírito permanece material. Os espíritos têm o mesmo número de níveis de vitalidade que suas contrapartes físicas normalmente teriam (veja a p. 388 para alguns traços de animais de exemplo). Se forem reduzidos a Incapacitado, eles se descorporificam.
1 sucesso — Um turno
2 sucessos — Cinco turnos
3 sucessos — Uma hora
4 sucessos — Uma noite
5 sucessos — Uma semana

••• Aspecto da Besta
Em vez de invocar espíritos animais, o vampiro aprende a emular aspectos desses espíritos ela mesma. Dessa forma, ela pode ficar mais rápida, mais forte, mais resistente, ou ganhar os poderes especiais de quase qualquer animal, desde que o espírito seja local da área.
Sistema: O jogador gasta um ponto de sangue e rola Manipulação + Ocultismo (dificuldade 7). O poder dura um turno por sucesso, salvo indicação em contrário. Alguns exemplos de aspectos são dados abaixo, embora o jogador e o Narrador estejam livres para inventar outros:
Mordida do Castor — Torna a mordida da Ahrimane forte e afiada o bastante para cortar quase qualquer substância (embora não cause dano adicional a alvos vivos ou não-vivos).
Cores do Camaleão — A Ahrimane se torna capaz de mudar de cor para se adequar ao ambiente (-2 de dificuldade em todas as rolagens de Furtividade que envolvam se esconder).
Orelhas da Lebre — A Ahrimane consegue ouvir tão bem quanto um coelho, reduzindo em dois a dificuldade das rolagens de Percepção que envolvam audição.
Olho do Falcão — A Ahrimane consegue enxergar a grandes distâncias como se tivesse os olhos de um falcão (-3 em todas as rolagens de Percepção que envolvam visão).
Ferocidade do Puma — Todas as rolagens de Coragem são feitas com -2 de dificuldade.
Salto da Rã — Concede à Ahrimane a capacidade de saltar três vezes a altura e a distância normais. (Veja a p. 260 para as regras de salto.)
Focinho do Cão — O olfato da Ahrimane é muito superior ao de um mortal. Ela pode até rastrear por cheiro com uma rolagem de Percepção + Sobrevivência (dificuldade definida pelo Narrador).
Peçonha da Serpente — A mordida da Ahrimane transmite uma toxina venenosa que causa dois níveis de vitalidade de dano em vítimas vivas por turno (veja "Venenos e Drogas", p. 301). O dano continua até que a toxina seja removida ou neutralizada, ou até que o poder espiritual da Ahrimane termine.
Som do Grilo — Concede o poder de produzir um som irritante e estridente, alto o bastante para ensurdecer quem estiver por perto. O alvo sofre +4 em todas as rolagens de Percepção relacionadas à audição pela próxima cena, a menos que obtenha sucesso numa rolagem de Força de Vontade (dificuldade 7).
Equilíbrio do Esquilo — A Ahrimane consegue se mover pelos galhos e ramos das árvores ou por cordas bambas com pouco medo de cair. Todas essas rolagens de Esportes têm suas dificuldades reduzidas em dois.
Força do Urso — Dá à Ahrimane dois pontos extras de Força.
Rapidez do Cervo — A Ahrimane pode se mover no dobro da sua velocidade normal de corrida.

•••• Fúria Engling
Espíritos abundam — supostamente tudo, da própria camisa ao próprio ar, tem um. A Ahrimane pode absorver esses espíritos, decompô-los e renovar suas próprias reservas mentais. Isso destrói o espírito, mas nenhuma repercussão foi relatada.
Sistema: O jogador rola Manipulação + Intimidação (dificuldade 8). Cada sucesso permite a ela recuperar um ponto de Força de Vontade, mas cada uso desse poder destrói mais um espírito.

••••• A Fera Selvagem
A Ahrimane fica mais magra, mais ágil e mais forte. Ela se curva ligeiramente, seus olhos ficam fendidos e felinos, e garras viciosas crescem nas suas mãos. Suas feições ficam levemente felinas, e nessa forma ela é uma predadora ainda mais formidável que o normal. Animais reagem com medo à Fera Selvagem, e mortais a veem como um monstro — se é que a veem.
Sistema: A mudança não exige rolagem, mas o jogador precisa gastar dois pontos de sangue. A mudança eleva a Força do vampiro em três, e a Destreza e o Vigor em dois cada. A Aparência cai para 0 e a Manipulação é reduzida em três. As presas do vampiro infligem um dado extra de dano, e ela ganha garras que infligem dano agravado. O personagem consegue enxergar no escuro, e todas as dificuldades envolvendo olfato, audição e visão caem em dois. O personagem pode manter a forma de Fera Selvagem por um número de horas por noite igual ao seu valor de Força de Vontade.]==],
				},
				["Temporis"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 467


Temporis


A linhagem dos Verdadeiros Brujah reivindica uma Disciplina peculiar que lhes permite algum controle sobre o fluxo do tempo. Mestres de Temporis muitas vezes se tornam cada vez mais desligados da passagem das eras. Isso, combinado à tendência natural dos Sábios de se distanciarem emocional e espiritualmente, torna os anciões Verdadeiros Brujah excepcionalmente perigosos. Eles sabem que toda vida é finita, e por isso não sentem escrúpulo algum em encerrá-la.

• Ampulheta da Mente
Mestres de Temporis valorizam a paciência e a clareza. O tempo é complexo e perigoso demais para ser manipulado sem cautela ou por capricho. Assim, o primeiro poder de Temporis se concentra inteiramente na percepção e funciona como uma alteração permanente dos sentidos do vampiro.
Sistema: Uma vez comprada, essa Disciplina dá ao vampiro um senso perfeito de tempo. O vampiro conhece os eventos com precisão de segundos ou melhor. Além disso, o Cainita sabe sempre que o fluxo do tempo é misticamente perturbado pelo uso de Celeridade, por níveis maiores de Temporis, por magia mortal ou por coisas mais estranhas. Sentir perturbações é instintivo e reflexivo, embora exija uma rolagem bem-sucedida de Percepção + Consciência (dificuldade 6 para a maioria dos fenômenos, modificada pelo Narrador conforme distância e intensidade).

•• Contemplação Recorrente
Um vampiro com esse poder pode prender a mente de um alvo revisando um conjunto de eventos repetidamente até ser interrompido. Este poder é extremamente sutil e mal adaptado a combate ou a outras situações ricas em estímulos sensoriais. Contudo, um vampiro astuto pode enganar uma sentinela para que reviva o tédio da sua vigília sem incidentes justamente enquanto o Cainita se aproxima o bastante para golpear ou passar despercebido. Outros usos incluem a imposição enlouquecedora de déjà vu para induzir paranoia ou fazer uma vítima questionar seus sentidos e sua sanidade.
Sistema: O vampiro se concentra numa única vítima dentro do seu campo de visão. O jogador rola Manipulação + Ocultismo (dificuldade igual à Força de Vontade atual da vítima). Com qualquer sucesso, a vítima cai num transe leve e revive as experiências mais recentes que precederam sua fuga. Alternativamente, o vampiro pode evocar outro conjunto de memórias e circunstâncias específicas do passado da vítima, desde que tenha algum meio de extraí-las telepaticamente. Os eventos recorrentes precisam ser relativamente benignos, no sentido de que nada digno de nota acontece ou nada acontece que exija ação imediata da vítima. Assim, no exemplo da sentinela, o vampiro poderia entranhá-la e passar sem ser observado, mas não se a sentinela o tivesse avistado antes de invocar o poder. Normalmente, a fuga dura um minuto por sucesso. Se o jogador do vampiro gastar um ponto de sangue para alimentar esse poder, determine a duração do transe conforme a tabela a seguir:
1 sucesso — um minuto
2 sucessos — 10 minutos
3 sucessos — uma hora
4 sucessos — seis horas
5+ sucessos — um dia
Vítimas em transe ficam alheias ao ambiente e ao fluxo real do tempo ao seu redor. Contudo, a fuga termina imediatamente se a vítima sofrer qualquer dano ou experimentar um choque súbito nos sentidos, como um trovão ou mesmo um empurrãozinho leve. Conversa normal não quebra o transe, mas gritar quebra.

••• Momento de Chumbo
Com esse poder, um vampiro pode começar a alterar o próprio fluxo do tempo, e não apenas a percepção dos eventos. O vampiro gesticula e desacelera o objeto desejado quase até a parada total. Este poder pode desacelerar balas que se aproximam ao ritmo de nuvens à deriva, ou fazer um guerreiro inimigo ver o campo de batalha acelerar até virar um borrão de carnificina vertiginosa enquanto cada movimento dele se arrasta.
Sistema: O jogador gasta um ponto de sangue e rola Inteligência + Ocultismo. A dificuldade depende do tamanho e da natureza do alvo: um único tijolo arremessado é apenas dificuldade 4, enquanto um carniçal enlouquecido tem dificuldade 9. Alvos maiores que um humano adulto não podem ser afetados por Momento de Chumbo. É possível afetar objetos inanimados pequenos e agrupados de mesma natureza como se fossem um único objeto, embora isso aumente a dificuldade em dois ou mais a critério do Narrador (uma saraivada de balas pode ser dificuldade 9). Este poder pode ser ativado reflexivamente como ação defensiva contra projéteis, mas de outro modo exige uma ação completa na iniciativa do vampiro. Embora a falha não acarrete penalidade especial além do desperdício de sangue, uma falha crítica significa que o vampiro por engano desacelera a si mesmo em vez do alvo, contando cada 1 como sucesso para esse fim.
Se o vampiro tiver sucesso, o objeto desacelera para metade da sua velocidade real. A cada dois sucessos além do primeiro, essa velocidade é reduzida por mais um fator, de modo que três sucessos desaceleram o alvo para um terço da sua velocidade, cinco sucessos rendem um quarto, etc. A mecânica real dessa desaceleração depende da situação. Para projéteis, multiplique quaisquer sucessos de acerto e o dano final pelo fator de velocidade, arredondando para baixo. Aplique de modo semelhante o modificador de velocidade aos sucessos de outras ações envolvendo Destreza, Raciocínio ou Força para personagens desacelerados. Personagens com Celeridade podem gastar um ponto de sangue para anular um fator de redução de velocidade, ao custo da ação extra normalmente concedida – por exemplo, um ponto de sangue cancela uma redução para metade da velocidade, dois pontos de sangue cancelam um terço, etc. Momento de Chumbo dura um turno para cada dois sucessos rolados, arredondando para cima.

•••• Paciência das Nornas
O vampiro agora pode suspender um objeto inanimado no tempo, mantendo-o congelado em estase perfeita enquanto o tempo passa em velocidade normal ao seu redor. Como nos poderes menores de Temporis, essa estase tem aplicações tanto em combate quanto fora dele. Guerreiros Verdadeiros Brujah podem parar balas de vez em vez de meramente desacelerar sua aproximação, ou desviar casualmente de um prédio desabando. Variações de nível mais alto desse poder preservam pergaminhos e artefatos preciosos sem risco de mofo ou decomposição. Se qualquer objeto sólido ou volume não trivial de líquido tocar um objeto congelado sem que o tocasse no momento da suspensão, o item volta a entrar no tempo com as mesmas propriedades e velocidade de quando parou. Assim, tocar um objeto suspenso com qualquer coisa mais substancial que uma gota de chuva o libera exatamente como estava antes de parar.
Sistema: O jogador gasta dois pontos de sangue e rola Inteligência + Ocultismo (dificuldade 6). O vampiro precisa conseguir perceber o objeto que está suspendendo, de modo que o jogador pode precisar fazer uma rolagem de Percepção + Prontidão com dificuldade determinada pelo Narrador para congelar objetos em movimento rápido. Se um objeto exceder a velocidade da percepção mortal, é necessária percepção sobre-humana como Auspícios para vê-lo e pará-lo (assim sendo, balas podem ser paradas com esse poder, mas só se o vampiro tiver ao menos um ponto de Auspícios). Objetos congelados por esse poder permanecem parados conforme o número de sucessos rolados:
1 sucesso — um turno
2 sucessos — um minuto
3 sucessos — 10 minutos
4 sucessos — uma hora
5 sucessos — um dia
6+ sucessos — uma semana por sucesso acima de 5
Objetos suspensos retêm toda a energia na sua suspensão, sem liberar nada para o universo exterior. Uma faca suspensa não tem energia cinética no que diz respeito ao resto do mundo, e fica pendurada no ar até que o poder seja interrompido ou a duração expire. Processos alquímicos ou químicos suspensos também param, incluindo o fogo. Contudo, qualquer contato físico mais substancial que uma gota de chuva quebra a suspensão.

••••• Dádiva de Cloto
Com esse poder, um vampiro acelera momentaneamente o tempo através de si mesmo. Nesse breve instante, ele se move com a velocidade sobrenatural da Celeridade. Ao contrário daquela Disciplina, porém, a dilatação temporal da Dádiva de Cloto permite qualquer tipo de ação. Um vampiro ainda pode se mover ou golpear mais rápido do que o olho consegue ver, mas também pensar, planejar e até invocar outras Disciplinas que exijam concentração total. Só a última apresenta perigo, pois sobrecarrega a estase não-viva do vampiro.
Sistema: O jogador gasta três pontos de sangue e rola Inteligência + Ocultismo (dificuldade 7). Por um número de turnos igual à metade do valor de Temporis do vampiro, arredondando para cima, o personagem pode realizar um número de ações extras com sua parada de dados cheia igual ao número de sucessos rolados. Essas ações seguem as regras de contagem associadas à Celeridade, mas podem ser usadas para realizar qualquer ação. Um vampiro pode usar as ações concedidas pela Dádiva de Cloto para ativar Disciplinas várias vezes, mesmo Disciplinas que não podem ser usadas mais de uma vez por turno (como Dominação ou Taumaturgia). Contudo, para cada ação gasta ativando uma Disciplina, o vampiro sofre um nível de dano letal não absorvível. Existe apenas uma exceção importante: qualquer tentativa de acumular ações extras por meio de Celeridade, de aplicações subsequentes da Dádiva de Cloto ou de outros poderes resulta em Morte Final imediata, com o vampiro desmoronando em cinzas como se queimado pelo sol.]==],
				},
				["Thanatosis"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 471


Thanatosis


Esta Disciplina é um desenvolvimento exclusivo da linhagem Samedi, e está intrinsecamente ligada à identidade e à história dos Defuntos. Embora Thanatosis pareça lidar de perto com a morte e as energias da decomposição, nenhum Giovanni jamais reivindicou domínio sobre esse poder. Os de fora presumem que os Giovanni devem ter interesse em aprender essa Disciplina. Contudo, os Giovanni veem os Samedi com desconfiança e repulsa, enquanto a opinião dos Samedi sobre os Giovanni costuma ser expressa resmungando uma maldição contra o Clã e cuspindo sangue. Assim, a possibilidade de uma troca de informações se aproxima de zero.

• Rugas da Bruxa
O apodrecimento perpétuo torna a carne do personagem maleável. A Samedi pode abrir grandes dobras na própria carne, guardando objetos nelas como a bolsa de um canguru. Ela também pode massagear as abas viscosas de tecido adiposo para alterar levemente sua aparência (embora isso não faça nada pelo cheiro). Outros Membros podem aprender essa Disciplina, claro, mas se não possuírem a "vantagem" de ter uma pele que já cai em pregas e dobras, rugas e protuberâncias grandes podem ficar visíveis.
Sistema: Este poder exige um turno para moldar as rugas e o gasto de um ponto de sangue. Se o poder for usado para distorcer as feições de um personagem, o jogador da Samedi precisa rolar Vigor + Subterfúgio (dificuldade 8). O sucesso aumenta em um a dificuldade de identificar visualmente o personagem e dura uma hora por sucesso rolado. Se o personagem estiver tentando esconder um objeto pequeno (uma carteira, uma carta, uma pistola pequena), a rolagem e a duração são as mesmas, mas todas as rolagens feitas para verificar se o objeto é detectado (por exemplo, uma revista corporal ou a inspeção visual de um segurança) ficam com +2 de dificuldade.

•• Putrefação
O personagem pode, com um toque, infligir decomposição a um alvo. O cabelo cai, os dentes se soltam, a carne apodrece e fungos crescem na pele. Este poder funciona em alvos vivos e mortos-vivos, e é obviamente bastante perturbador tanto física quanto psicologicamente.
Sistema: Este poder exige primeiro que o personagem toque o alvo pretendido. O jogador então rola Destreza + Medicina (dificuldade do Vigor + Fortitude do alvo) e gasta um ponto de sangue. O sucesso inflige um nível de vitalidade de dano letal ao alvo e remove um ponto de Aparência da vítima. Essa perda de Aparência retorna aos vampiros à razão de um ponto por noite, mas é permanente para mortais (embora a cirurgia plástica possa corrigir a desfiguração física dos mortais). Se um mortal sofrer três ou mais níveis de vitalidade de dano por usos repetidos desse poder numa cena, gangrena ou outras enfermidades podem ocorrer.
Putrefação também pode ser usada em plantas, caso em que o alvo fica crestado e murcho. Não pode, porém, ser usada em objetos inanimados como carros ou estacas de madeira.

••• Cinzas às Cinzas
O personagem desmorona num pó branco, espesso e pegajoso. Nessa forma, o personagem não consegue se mover e tem apenas uma consciência vaga do ambiente, mas é imune a fogo e luz do sol (o que faz desse poder uma fuga eficaz em algumas situações). O personagem precisa tomar cuidado, porém — se as cinzas forem espalhadas, ela pode nunca mais conseguir se reconstituir.
Sistema: A transformação em cinzas exige um turno e o gasto de dois pontos de sangue. Enquanto o personagem está em forma de cinzas, o jogador precisa fazer uma rolagem de Percepção + Prontidão (dificuldade 9) para qualquer cena em que deseje que sua personagem esteja ciente do ambiente. Reconstituir-se do monte de cinzas leva um turno. Se o personagem estiver num espaço confinado (como uma urna), ela explode para fora dele de maneira adequadamente dramática enquanto retoma o tamanho normal. Se uma Samedi for espalhada nessa forma, um nível de vitalidade e um ponto de sangue são perdidos para cada décimo (aproximadamente) da personagem que tenha sido dissipado. Cinco pontos de sangue são necessários para curar cada nível de vitalidade perdido dessa maneira. A critério do Narrador, a Samedi pode ficar sem membros ou órgãos vitais (embora nunca a cabeça ou o coração) até que os níveis de vitalidade faltantes sejam curados.

•••• Definhamento
O Defunto pode encolher e inutilizar o membro de um oponente. Este poder funciona tanto em Membros quanto em mortais. Os Membros, claro, ficam horrorizados com o poder, pois tendem a pensar nos seus corpos como imortais e invulneráveis a tais estragos.
Sistema: O Samedi precisa tocar o membro que pretende encolher. O jogador gasta um ponto de Força de Vontade e rola Manipulação + Medicina (dificuldade igual ao Vigor + Fortitude da vítima). Três sucessos são necessários para que esse poder encolha um membro. Com um ou dois sucessos, a vítima sofre um nível de vitalidade de dano por contusão, que pode ser absorvido normalmente, mas de resto não é afetada. (Se a tentativa de Definhamento for bem-sucedida, o sujeito não sofre nenhum nível de vitalidade de dano, mas sim o definhamento do próprio membro.)
Os efeitos do Definhamento desaparecem depois de uma noite se a vítima for um vampiro ou outra criatura sobrenatural, mas mortais (incluindo magos) ficam permanentemente afligidos, a menos que algum tipo de cura sobrenatural seja usado. Se este poder for usado num braço ou numa perna, o membro fica instantaneamente inutilizado. Se este poder for usado na cabeça de um oponente, vítimas mortais morrem instantaneamente. Membros perdem dois pontos de todos os Atributos Mentais enquanto suas cabeças estão encolhidas e ficam incapazes de usar qualquer Disciplina exceto Celeridade, Fortitude e Potência. Múltiplos usos desse poder no mesmo apêndice não têm efeito adicional.

••••• Necrose
Uma forma mais horrenda e potente da Putrefação, este poder faz a carne se decompor e se desprender, expondo o osso embaixo. O uso desse poder pode deixar um oponente incapaz de se mover por falta de tecido muscular.
Sistema: O Samedi precisa fazer contato com a vítima. O jogador gasta dois pontos de sangue e rola Destreza + Medicina (dificuldade do Vigor + Fortitude do alvo). A vítima sofre um número de níveis de vitalidade de dano letal igual ao número de sucessos rolados e sofre efeitos adicionais conforme listado abaixo.
1 sucesso — Nenhum efeito adicional
2 sucessos — Perde um ponto de Aparência
3 sucessos — Perde um ponto de Aparência e um de Destreza
4 sucessos — Perde um ponto de Aparência, um de Destreza e um de Força
5+ sucessos — Perde dois pontos de Aparência e um de Destreza e um de Força
Atributos perdidos dessa maneira são recuperados quando todo o dano do ataque de Necrose é curado. Se uma vítima for reduzida a Força ou Destreza zero, ela fica incapaz de se mover a não ser por debater-se fracamente e rastejar, mas ainda pode usar Disciplinas e gastar pontos de sangue normalmente.]==],
				},
				["Thaumaturgy"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 212


Thaumaturgy


Taumaturgia abrange a magia de sangue e outras artes feiticeiras disponíveis aos Membros. O Clã Tremere é mais conhecido por possuir (e acumular ciosamente) essa Disciplina. Os Tremere criaram a Taumaturgia combinando a magia mortal com o poder da vitae vampírica e, como resultado, ela é uma Disciplina versátil e poderosa. Embora haja sussurros sobre a existência de Tremere antitribu na Sabbat, outros Clãs da Espada de Caim também pesquisaram e desenvolveram acesso a esse poderio místico. Ainda assim, os Tremere da Camarilla continuam sendo os mestres dessa Disciplina.
Como a Necromancia, a prática da Taumaturgia se divide em trilhas e rituais. Trilhas taumatúrgicas são aplicações do conhecimento de magia de sangue do vampiro, permitindo que ela crie efeitos a seu bel-prazer. Rituais são mais formulaicos por natureza, mais parecidos com "feitiços" mágicos antigos. Como tantas trilhas e rituais diferentes estão disponíveis aos arcanos Tremere, nunca se sabe o que esperar ao se deparar com um praticante dessa Disciplina.
Quando um personagem aprende Taumaturgia pela primeira vez, o jogador escolhe uma trilha para o personagem. Essa trilha é considerada a trilha principal do personagem, e ela recebe automaticamente um ponto nela, além de um ritual de Nível Um. Daí em diante, sempre que o personagem aumenta seu nível em Taumaturgia, seu valor na trilha principal também aumenta em um. Rituais adicionais são aprendidos separadamente, como parte de uma história; os jogadores não precisam pagar pontos de experiência para que seus personagens aprendam rituais até o nível igual ao seu valor geral em Taumaturgia, embora precisem encontrar alguém para ensinar os rituais em questão. Valores de trilha nunca excedem 5, embora a pontuação geral de Taumaturgia possa. Se um personagem atinge valor 5 na sua trilha principal e aumenta sua pontuação de Taumaturgia depois disso, ela pode alocar seu ponto "gratuito" de trilha a uma trilha diferente. (Os custos de experiência estão na p. 124.)
Muitos Membros temem se indispor com os praticantes da Taumaturgia. É uma Disciplina muito potente e mutável, e quase tudo o que o Membro desejar pode ser realizado por sua magia.

Trilhas Taumatúrgicas
As trilhas definem os tipos de magia que um vampiro pode realizar. Um vampiro tipicamente aprende sua trilha principal com seu senhor, embora não seja desconhecido que alguns vampiros estudem sob muitos tutores diferentes.
Como mencionado antes, a primeira trilha que um personagem aprende é considerada sua trilha principal e aumenta automaticamente conforme o personagem avança na própria Disciplina. Trilhas secundárias podem ser aprendidas quando o personagem tiver adquirido dois ou mais pontos na sua trilha principal, e precisam ser aumentadas separadamente com pontos de experiência. Além disso, o valor do personagem na sua trilha principal precisa sempre ser ao menos um ponto maior que qualquer uma das suas trilhas secundárias, até que ela tenha dominado a trilha principal. Uma vez que o personagem tenha alcançado o quinto nível da sua trilha principal, as trilhas secundárias podem ser aumentadas até esse nível.
Cada vez que o personagem invoca um dos poderes de uma trilha taumatúrgica, o jogador do taumaturgo precisa gastar um ponto de sangue e fazer uma rolagem de Força de Vontade contra uma dificuldade igual ao nível do poder +3. Apenas um sucesso é necessário para invocar o efeito de uma trilha — os níveis de trilha, e não os sucessos, governam o poder da magia de sangue. A falha nessa rolagem indica que a magia falha. Uma falha crítica causa algum tipo de perda ou contragolpe catastrófico, como perder um ponto (ou um ponto permanente!) de Força de Vontade, combustão espontânea, ou deixar acidentalmente uma estátua viva correr solta. A Taumaturgia é uma arte implacável.
Diferentes Seitas e Clãs têm acesso diferente a cada trilha, mas a menos que o Narrador decida o contrário, presume-se que os Tremere tenham algum acesso a todas elas. ("Ter acesso" não significa o mesmo que "obter facilmente", especialmente dentro da estrutura de poder Tremere.) As trilhas começam por uma das mais comuns (A Trilha do Sangue) e, daí em diante, são apresentadas em ordem alfabética. (A incomum "trilha" da Contramágica Taumatúrgica também é apresentada, embora seja considerada uma Disciplina separada – veja a p. 228 para detalhes.)]==],
				},
				["Valeren"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 474


Valeren


Valeren é uma Disciplina de guerreiro, um resquício das noites em que os Salubri guerreiros atuavam como lutadores nobres e cavaleiros Membros. A Disciplina ainda se aplica às noites modernas, mas os Salubri antitribu a empregam para fins decididamente mais cruéis.
Como Obeah, Valeren confere aos seus praticantes o fabuloso terceiro olho de Saulot. O terceiro olho aparece no momento em que o vampiro domina o segundo nível de Valeren. A natureza e o propósito precisos do olho são praticamente desconhecidos dos vampiros fora dos Salubri antitribu. Alguns suspeitam que o olho lhes concede visão além da visão, enquanto outros arriscam que o olho lhes permite ver a mácula infernal nos próprios Salubri não-Sabbat.

• Sentir a Vitalidade
Um curandeiro aprende as doenças de um sujeito para curá-las. Os Salubri antitribu, porém, descobrem o quão perto da morte um alvo está para que possam acelerar o processo.
Sistema: Este poder funciona de modo idêntico ao poder de Obeah de mesmo nome (p. 457).

•• Toque Anestésico
O Salubri antitribu pode amenizar a dor de um sujeito, o que lhe permite reforçar a eficácia de um carniçal em combate. Este poder também pode adormecer um mortal, o que tem aplicações óbvias para escapar do escrutínio humano (embora a Fúria provavelmente seja tão propensa a matar o mortal em questão).
Sistema: Este poder funciona de modo idêntico ao poder de Obeah de mesmo nome (p. 458).

••• Toque Ardente
As mãos do personagem trazem dor lancinante, como se o alvo estivesse sendo queimado com metal em brasa. Embora o poder não inflija dano de fato, exposição prolongada ou repetida pode bastar para traumatizar uma vítima. Este poder funciona extremamente bem como método de tortura.
Sistema: O vampiro precisa tocar seu sujeito para que esse poder faça efeito, e os efeitos diminuem rapidamente depois que ele retira a mão. O jogador gasta ao menos um ponto de sangue para ativar esse poder, e cada ponto de sangue gasto reduz em dois as paradas de dados da vítima enquanto a Fúria estiver em contato com ela. Este poder é frequentemente usado para interrogatório ou tortura, desgastando a resistência do sujeito e tornando-o muito mais tratável.

•••• Armadura da Fúria de Caim
O Salubri antitribu é envolvido por um halo carmesim reluzente. Essa armadura fantasma protege o vampiro contra a maior parte dos ferimentos físicos, bem como contra o Rötschreck.
Sistema: O jogador gasta um ponto de sangue e rola Vigor + Armas Brancas (dificuldade 7). Para cada sucesso, o personagem ganha um ponto de proteção de armadura contra dano por contusão e letal, até um máximo de cinco pontos de proteção. Além disso, a cada dois sucessos rolados, ela ganha um dado adicional para resistir ao Rötschreck causado pelos efeitos da batalha (mas não por fogo ou luz do sol). Este poder funciona por uma cena.

••••• Vingança de Samiel
O Salubri antitribu golpeia seu adversário com precisão e força sobre-humanas, enquanto seu terceiro olho se abre e muda para um azul furioso e gélido. Algumas Fúrias invocam os nomes de antigos guerreiros Salubri, enquanto outras simplesmente fecham os olhos normais e deixam Samiel guiar suas mãos.
Sistema: Este poder custa três pontos de sangue. Qualquer ataque único feito pelo vampiro acerta o alvo automaticamente, pois forças místicas guiam o golpe. Ataques feitos dessa maneira não podem ser esquivados, embora possam ser bloqueados, aparados e absorvidos normalmente. O golpe acerta como se o Salubri antitribu tivesse obtido sucesso com toda a sua parada de dados de Destreza + Armas Brancas ou Briga (o que resulta em dano significativo). Este poder só pode ser usado uma vez por turno, e nesse caso a única ação do Salubri antitribu é o ataque. Além disso, este poder não funciona para armas à distância; apenas mãos nuas ou armas brancas.]==],
				},
				["Vicissitude"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 241


Vicissitude


Vicissitude é o poder característico dos Tzimisce, e raramente é compartilhado fora do Clã (embora seja conhecido de alguns outros Cainitas da Sabbat). Semelhante à Metamorfose em alguns aspectos, Vicissitude permite aos vampiros moldar e esculpir carne e osso. Quando um Membro usa Vicissitude para alterar mortais, carniçais e vampiros de Geração mais alta, os efeitos do poder são permanentes; vampiros de Geração igual ou mais baixa podem escolher curar os efeitos de Vicissitude como se fossem ferimentos agravados. Quem empunha Vicissitude sempre pode remodelar a própria carne.
Quem a empunha precisa estabelecer contato pele a pele e muitas vezes precisa esculpir manualmente o resultado desejado para que esses poderes façam efeito. Isso também se aplica ao uso do poder em si mesmo. Tzimisce habilidosos em Vicissitude são muitas vezes inumanamente belos; os menos habilidosos são simplesmente inumanos.
Há rumores de que Vicissitude seja uma doença em vez de uma Disciplina "normal", mas só os Demônios sabem ao certo, e eles não estão falando.
Nota: Os Nosferatu sempre "curam" alterações de Vicissitude, ao menos as que os deixam com melhor aparência. A antiga maldição do Clã não pode ser contornada por Vicissitude. O mesmo se aplica a deformidades físicas vindas da fraqueza do Clã Gangrel.
Artes do Corpo: Vampiros que desejam usar bem Vicissitude muitas vezes especializam seu conhecimento de Medicina numa arte conhecida como Artes do Corpo. Essa especialização permite ao seu possuidor fazer toda sorte de alterações em carne e osso vivos e mortos. Também dá acesso a técnicas mais mundanas; muitos Tzimisce são habilidosos em esfolamento, entalhe de ossos, embalsamamento, taxidermia, tatuagem e perfuração.

• Semblante Maleável
Um vampiro com esse poder pode alterar seus próprios parâmetros corporais: altura, compleição, voz, feições faciais e tom de pele, entre outras coisas. Tais mudanças são cosméticas e de escopo pequeno — não mais que 30 cm de altura ganhos ou perdidos, por exemplo. Ela precisa moldar fisicamente a alteração, literalmente esculpindo sua carne até o resultado desejado.
Sistema: O jogador precisa gastar um ponto de sangue para cada parte do corpo a ser mudada, e então rolar Inteligência + Medicina (dificuldade 6). Duplicar outra pessoa ou outra voz exige uma rolagem de Percepção + Medicina (dificuldade 8), e cinco sucessos são necessários para uma cópia impecável; menos sucessos deixam falhas minúsculas (ou nem tanto). Aumentar o próprio Traço de Aparência tem dificuldade 9, e o vampiro precisa gastar um ponto de sangue adicional para cada ponto de Aparência aumentado além do seu total natural. Uma falha crítica reduz permanentemente o Atributo em um.

•• Modelagem da Carne
Este poder é semelhante ao Semblante Maleável, acima, mas permite ao vampiro realizar alterações drásticas e grotescas em outras criaturas. Os Tzimisce muitas vezes usam esse poder para transformar seus servos em guardas monstruosos, melhorando o efeito de amedrontar adversários. Apenas carne (pele, músculo, gordura e cartilagem, mas não osso) pode ser transformada.
Sistema: Depois de gastar um ponto de sangue, o vampiro precisa agarrar a vítima pretendida. O jogador do vampiro que faz a Modelagem faz uma rolagem bem-sucedida de Destreza + Medicina (dificuldade variável: 5 para um puxa-e-dobra tosco, até 9 para transformações precisas). Um vampiro que deseje aumentar o Traço de Aparência de outro o faz conforme descrito em Semblante Maleável; reduzir o Atributo é consideravelmente mais fácil (dificuldade 5), embora uma desfiguração verdadeiramente inspirada possa exigir dificuldade maior. Em ambos os casos, cada sucesso aumenta ou reduz o Atributo em um.
Um vampiro pode usar esse poder para deslocar aglomerados de pele, gordura e tecido muscular, provendo assim acolchoamento adicional onde for necessário. Para cada sucesso obtido numa rolagem de Destreza + Medicina (dificuldade 8), o vampiro pode aumentar em um a parada de absorção do sujeito, à custa de um ponto de Força ou de um nível de vitalidade (escolha do vampiro).

••• Modelagem dos Ossos
Este poder terrível permite a um vampiro manipular osso da mesma maneira que a carne é moldada. Em conjunto com a Modelagem da Carne, acima, esse poder permite a um praticante de Vicissitude deformar uma vítima (ou a si mesma) além do reconhecimento. Este poder deve ser usado em conjunto com as artes de modelar carne, a menos que o vampiro queira infligir ferimentos à vítima (veja abaixo).
Sistema: O jogador do vampiro precisa gastar um ponto de sangue e fazer uma rolagem de Força + Medicina (dificuldades como acima). Modelagem dos Ossos pode ser usada sem as artes de modelar carne, como arma ofensiva. Cada sucesso obtido na rolagem de Força + Medicina (dificuldade 7) inflige um nível de vitalidade de dano letal à vítima, enquanto seus ossos rasgam, perfuram e cortam caminho para fora da pele.
O vampiro pode utilizar esse poder (em si mesmo ou em outros) para formar espigões ou garras de osso, seja nos nós dos dedos como arma ofensiva, seja por todo o corpo como "espinhos" defensivos. Se espigões de osso forem usados, o vampiro ou a vítima sofre um nível de vitalidade de dano letal (o do vampiro vem de ter o osso muito afiado atravessando sua pele — esse armamento não sai barato). No caso dos espinhos, o sujeito sofre um número de níveis de vitalidade igual a cinco menos o número de sucessos (uma falha crítica mata o sujeito ou lança o vampiro em torpor). Esses níveis de vitalidade podem ser curados normalmente. Espigões nos nós dos dedos infligem Força +1 de dano letal. Espinhos defensivos infligem a Força de um atacante corpo a corpo em dano letal, a menos que o atacante obtenha três ou mais sucessos na rolagem de ataque (caso em que o atacante não sofre dano); o defensor ainda sofre dano normalmente. Espinhos também permitem ao vampiro ou ao sujeito alterado somar dois a todo dano infligido por agarrões, imobilizações ou investidas.
Um vampiro que obtenha cinco ou mais sucessos na rolagem de Força + Medicina pode fazer a caixa torácica de um vampiro rival se curvar para dentro e perfurar o coração. Embora isso não lance o vampiro em torpor, faz o vampiro afetado perder metade dos seus pontos de sangue, enquanto a sede da sua vitae se rompe num jorro de sangue.

•••• Forma Horrenda
Os Membros usam esse poder para se tornar monstros horrendos e letais. A estatura do vampiro aumenta para dois metros e meio completos, a pele se torna uma quitina cinza-esverdeada ou cinza-escura doentia, os braços ficam simiescos e fibrosos com unhas negras irregulares, e o rosto se distorce em algo saído de um pesadelo. Uma fileira de espinhos brota das vértebras, e a carapaça externa exsuda uma graxa de cheiro repugnante.
Sistema: A Forma Horrenda custa dois pontos de sangue para despertar. Todos os Atributos Físicos aumentam em três, mas todos os Atributos Sociais caem a zero, exceto ao lidar com outros também em Forma Horrenda. Contudo, um vampiro em Forma Horrenda que esteja tentando intimidar alguém pode substituir um Atributo Social por Força. O dano infligido em combate de briga aumenta em um, devido às cristas irregulares e às protuberâncias ósseas que vincam as mãos da criatura.

••••• Forma de Sangue
Um vampiro com esse poder pode transformar fisicamente todo ou parte do seu corpo em vitae senciente. Esse sangue é em todos os aspectos idêntico à vitae normal do vampiro; ela pode usá-lo para se nutrir ou nutrir outros, criar carniçais ou estabelecer laços de sangue. Se todo esse sangue for bebido ou de outro modo destruído, o vampiro encontra a Morte Final.
Sistema: O vampiro pode transformar toda ou parte de si como achar melhor. Cada perna pode virar dois pontos de sangue de vitae, assim como o torso; cada braço, a cabeça e o abdômen convertem-se em um ponto de sangue cada. O sangue pode ser reconvertido na parte do corpo, desde que esteja em contato com o vampiro. Se o sangue tiver sido utilizado ou destruído, o vampiro precisa gastar um número de pontos de sangue igual ao que foi originalmente criado para regenerar a parte do corpo faltante.
Um vampiro inteiramente nessa forma não pode ser empalado, cortado, golpeado nem perfurado, mas pode ser queimado ou exposto ao sol. O vampiro pode escorrer, pingar parede acima e fluir pelas frestas mais estreitas, como se estivesse em Forma Tenebrosa (p. 190).
Disciplinas mentais podem ser usadas, desde que não seja necessário contato visual nem emissão vocal, embora o vampiro consiga perceber o ambiente perfeitamente bem (mas as percepções são sempre centradas na maior poça de sangue). Se um vampiro nessa forma "lavar" um mortal ou animal, esse mortal precisa fazer uma rolagem de Coragem (dificuldade 8) ou entrar em pânico.]==],
				},
				["Visceratika"] = {
					pt = [==[Vampire: The Masquerade 20th Anniversary Edition, pág. 475


Visceratika


Visceratika é uma extensão da afinidade natural dos Gárgulas por pedra e terra. Certos poderes de Visceratika se assemelham bastante a alguns aspectos da Metamorfose e, em menor grau, de Vicissitude. Tremere em posição de saber insistem que isso é pura coincidência, mas os poucos entre os Gárgulas que mantêm aspirações eruditas insistem que o sangue Gangrel e Tzimisce usado para criar a linhagem ainda mantém certo domínio sobre seus membros.
Por muitos anos, Visceratika foi considerada endêmica à condição de Gárgula, assim como o semblante repulsivo e as asas que outros Membros associam à linhagem. Isto é, os vampiros — incluindo os Tremere — acreditavam que não podiam ter uma coisa sem as outras. Supostamente isso não é verdade e, desde que se encontre um tutor Gárgula, qualquer vampiro pode aprender a Disciplina. Claro, isso pressupõe que se consiga encontrar um tutor disposto — os Gárgulas não são ávidos por revelar esses segredos. Além disso, poucos Membros querem apostar que os Tremere estão errados e arriscar acordar com asas e chifres.

• Pele do Camaleão
Este poder básico salvou incontáveis Gárgulas de quebrar a Máscara — e permitiu que outros tantos emboscassem intrusos desprevenidos. Quando a Pele do Camaleão está em vigor, a pele do Gárgula assume a cor e a textura do ambiente ao redor. Essa coloração muda reflexivamente enquanto o Gárgula mantiver um ritmo de caminhada ou mais lento. Movimento mais rápido faz a aparência do Gárgula borrar, anulando o efeito de camuflagem. Se esse poder for usado enquanto o Gárgula estiver em voo, sua pele se torna um fac-símile razoável do céu noturno (embora não se altere para imitar arranha-céus próximos ou padrões de estrelas, e uma silhueta negra contra um horizonte bem iluminado provavelmente será notada).
Sistema: O jogador gasta um ponto de sangue. Pelo resto da cena, a parada de dados de Furtividade do Gárgula é aumentada em cinco. Este poder está sujeito às limitações descritas acima. Qualquer movimento em solo mais rápido que uma caminhada anula o efeito desse poder, assim como o voo (a critério do Narrador).

•• Vigiar a Pedra do Lar
A primeira função dos Gárgulas para os Tremere foi a de guardião e cão de guarda. Este poder lhes permite saber instintivamente onde qualquer pessoa está dentro de uma dada estrutura. Permite até que o Gárgula detecte personagens ocultos por meios mágicos, se o Escravo for perceptivo o bastante.
Sistema: O jogador gasta um ponto de Força de Vontade para ativar esse poder, que permanece em vigor enquanto o Gárgula estiver dentro da estrutura alvo ou em contato com ela, ou até o pôr do sol seguinte. Vigiar a Pedra do Lar pode ser usado em qualquer coisa até o tamanho de um complexo de cavernas, um teatro grande, um estacionamento coberto ou uma mansão. O personagem ganha um senso inato da localização e do tamanho e condição física aproximados de todos os seres vivos (ou não-vivos) dentro da estrutura. Para localizar com precisão a posição de um indivíduo específico com esse poder, o jogador precisa obter sucesso numa rolagem de Percepção + Consciência (dificuldade 6). Se o sujeito estiver tentando se esconder, ele pode opor essa rolagem com uma rolagem de Raciocínio + Furtividade (dificuldade 6).
Vigiar a Pedra do Lar pode ser usado para detectar a presença de personagens sob efeito de Ofuscação ou poderes semelhantes. Nesse caso, o Gárgula sabe apenas que há alguém presente — ela não consegue de fato ver o indivíduo em questão. Para determinar a capacidade do Gárgula de detectar personagens Ofuscados, compare os níveis relativos do Visceratika do Gárgula menos um e da Ofuscação do intruso, conforme o quadro "Vendo o Invisível" na p. 142.

••• Vínculo com a Montanha
O Gárgula afunda numa superfície de pedra, desaparecendo dentro da rocha até que deseje reaparecer. Este poder permitiu aos Gárgulas invadir as fortalezas dos inimigos dos seus mestres, lutar até o nascer do sol e então se fundir com as rochas ou paredes de pedra e reaparecer na noite seguinte. Nas noites modernas, pode fazer as vezes de refúgio para Fugitivos itinerantes. Ao contrário do poder Fusão com a Terra (p. 199), com o qual se parece, Vínculo com a Montanha não oculta o Gárgula completamente. Um contorno tênue do seu corpo pode ser visto na rocha onde ele se esconde.
Sistema: O jogador gasta dois pontos de sangue, e a fusão leva quatro turnos para se completar. Este poder funciona de maneira semelhante ao poder Metamorfose 3, Fusão com a Terra, e só pode ser realizado sobre rocha nua ou substância semelhante. Contudo, o Gárgula não afunda completamente na substância com a qual se funde, e seu contorno pode ser detectado dentro da pedra com uma rolagem bem-sucedida de Percepção + Prontidão (dificuldade 9). Um Gárgula atacado enquanto está Vinculado à Montanha tem o triplo da sua parada normal de absorção contra todas as formas de ataque. Contudo, se ele sofrer três ou mais níveis de vitalidade de dano letal de um único ataque, é forçado para fora do seu vínculo e sofre desorientação semelhante à experimentada por um personagem em Fusão com a Terra cujo sono é interrompido.

•••• Armadura de Terra
Neste nível de Visceratika, a pele do Gárgula endurece e se torna verdadeiramente pétrea ao toque. O Escravo fica mais difícil de ferir, mesmo com fogo, e se torna insensível a ferimentos. Uma não-Gárgula que aprenda esse nível de Visceratika veria sua pele ficar cinzenta e pétrea, desmentindo a alegação de que a Disciplina não traz o risco da maldição do Gárgula.
Sistema: Este poder é automático e não exige rolagem; está sempre em vigor. Um vampiro com Armadura de Terra tem um dado extra de absorção contra todos os ataques agravados e letais e dois contra todos os ataques por contusão, reduz todas as penalidades de ferimento em um e reduz pela metade a parada de dados de dano de qualquer fonte de ferimento baseada em fogo (esta Disciplina não muda as regras de Rötschreck, porém). A dificuldade de todas as rolagens de Percepção baseadas em tato é aumentada em dois, devido à dessensibilização da pele do personagem.

••••• Fluir Dentro da Montanha
O Gárgula não está mais restrito a se esconder dentro da pedra. Agora ele pode fluir através da pedra como lava descendo pela encosta de uma montanha, emergindo do esconderijo em qualquer ponto que deseje. Como esse poder funciona tanto em cimento ou concreto quanto em rocha, as ruas de uma metrópole moderna oferecem ao Gárgula algumas ferramentas de assassinato bastante interessantes.
Sistema: Uma vez que o personagem tenha usado Vínculo com a Montanha, o jogador gasta mais dois pontos de sangue para ativar Fluir Dentro da Montanha pela duração da cena. O Gárgula pode se mover dentro de pedra e cimento (de resto usando as mesmas regras do poder de Metamorfose Controle da Terra, p. 200). O personagem também pode usar esse poder para atravessar uma parede de pedra e emergir do outro lado sem antes usar Vínculo com a Montanha. Nesse caso, o jogador gasta um ponto de sangue e rola Força (dificuldade 8; Potência acrescenta dados ou sucessos normalmente). O Gárgula pode fluir através de uma espessura máxima em centímetros igual a 30 vezes o número de sucessos rolados. Se a parede ou barreira for mais espessa que isso, o personagem fica preso dentro dela até ser cinzelado para fora ou usar Fluir Dentro da Montanha para escapar.]==],
				},
				-- <<< DISC_DESC_END
};
