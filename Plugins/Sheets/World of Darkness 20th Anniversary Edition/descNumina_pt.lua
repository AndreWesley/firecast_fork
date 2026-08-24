-- Numina descriptions, the [pt] half (SPEC T495, V210).
--
-- descNumina.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [pt] only, descNumina_en.lua holds the other, the two carry the SAME
-- keys, and the renderer requires the half the sheet is set to - require("descNumina_" .. lang ..
-- ".lua"), never a constant name (SPEC V210b). Nothing was removed: both files ship in the
-- .rpk and no entry is dropped (SPEC V210a). The generator markers migrated verbatim to
-- both sides, so every region parser still aims at the same shape (SPEC I24).
--
-- Numina descriptions, transcribed from M20 Sorcerer (chapter 1 pp. 18-51, chapter 2
-- pp. 54-77): intro prose + the System block / dot levels. Sample rituals, recipes,
-- creations and sidebars are deliberately out (SPEC C, T62).
--
-- Keyed by the canonical ENGLISH picker value, because that is what the sheet saves
-- (SPEC V24). `pt` is a translation of the same text, paragraph for paragraph.
-- This table is NOT part of the HH.6 `PT` map on purpose (SPEC V28 / V31): the block
-- is re-rendered from here on every language change instead of being translated
-- in place, so the English original can never be lost.
--
-- SPEC I24 / T478: this table used to be an upvalue inside the <script> of HH.7.lfm.
-- The <script> CDATA is copied raw into constructNew_frmHH_7(), so every open sheet
-- parsed and kept its own 380 KB copy. As a module it is parsed once and cached in
-- package.loaded, and the require that pulls it lives INSIDE numinaText (SPEC V198).
-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).

return {
				-- >>> DESC_BEGIN (generated - SPEC T62)
				["Alchemy"] = { pt = [==[M20 Sorcerer, pág. 18


Alchemy


O estudo da transformação e da purificação, a Alquimia é uma arte e uma ciência antigas. Seus praticantes recorrem a práticas díspares, tanto mágicas quanto científicas, para compreender as propriedades ocultas da matéria e da alma. O objetivo mais tradicional da alquimia não é a mais famosa transformação da matéria base em contrapartes mais “nobres” — como chumbo em ouro — mas sim a perfeição do próprio alquimista.

Como Caminho, a Alquimia cria itens mágicos de uso único e transformações. Muitas das coisas que ela produz são destinadas à ingestão, embora poucas sejam feitas pensando no sabor ou mesmo na saúde e no bem-estar do consumidor. A Alquimia também produz revestimentos que podem ser aplicados sobre a pele ou sobre objetos, e reagentes que catalisam transmutações de elementos base em outra matéria.

Embora muitas vezes estudada como um meio de aperfeiçoar a alma, essa busca está profundamente ligada à prática Alquímica propriamente dita. Outras práticas dão a ela seu próprio toque: os praticantes de Bruxaria (Witchcraft) chamam o Caminho de Herbalismo (Herbalism) e concentram-se em ingredientes naturais e nos efeitos relacionados a eles, enquanto os engenheiros e inventores da Hipertecnologia (Hypertech) que utilizam a Ciência Estranha (Weird Science) o chamam de Química Avançada (Advanced Chemistry), e descartam completamente as implicações metafísicas que a prática da Alquimia impõe ao Caminho.

Em todos os casos, o Caminho da Alquimia é caro. Na maioria das versões do Caminho, ele exige um laboratório bem equipado e ingredientes estranhos. As aplicações mais poderosas requerem componentes cada vez mais exóticos e Tass extremamente especializado. Embora a variante do Herbalismo tenda a ser mais barata em termos de dinheiro, ela exige mais tempo e esforço, com plantas e fungos coletados sob condições estritas.

Muitas aplicações deste Caminho passaram para a lenda. Sabe-se que poucos alquimistas realmente completaram a chamada “Grande Obra”, a criação de uma Pedra Filosofal, ou qualquer outro produto que conduza à imortalidade, mas a maioria dos mestres do Caminho faz a tentativa.

Este Caminho não tem magias. Ele faz tudo por meio de rituais chamados receitas.

Sistema

Modificadores: Uma vez que o mago siga uma receita com sucesso três vezes, a dificuldade é reduzida em um.

Tempo: A Alquimia leva mais tempo para obter resultados do que a maioria dos Caminhos. As receitas exigem um dia por nível para serem preparadas, mas isso pode ser encurtado se a Habilidade do Caminho exceder o nível da receita. Cada ponto da Habilidade acima do nível do ritual reduz o tempo total gasto em um dia. Se isso reduzisse o tempo de preparação a menos de um dia, presuma em vez disso várias horas de trabalho.

Duração: Os efeitos duram uma única cena, a menos que indicado de outra forma.

Efeitos: A Alquimia não possui Aspectos; em vez disso, cada ponto aumenta o poder e o controle do praticante. Exceto pelas receitas mais potentes, elas exigem apenas um único sucesso para serem feitas. Os sucessos adicionais são divididos entre fornecer doses adicionais e manter essas doses potentes por um dia por sucesso gasto.

• As destilações neste nível não parecem mágicas de forma alguma. Essas receitas são simplesmente versões mais avançadas de substâncias químicas e concocções existentes, produzindo analgésicos, venenos, colas, solventes etc. mais potentes, e aumentando em um o Índice de Toxina (Toxin Rating) da substância química (conforme Mage 20 p. 442). Níveis mais altos do Caminho podem alterar ainda mais o Índice de Toxina, aumentando ou diminuindo o índice em um por ponto.
•• Agora as substâncias criadas permitem que quem as ingere exceda seus limites físicos habituais. Qualquer um dos Atributos pode ser aumentado em um ponto, até um máximo de cinco, pela duração da cena. Preparações especiais podem expandir a consciência mística de alguém, principalmente por meio de sonhos ou alucinações induzidos. Essas visões ficam a critério do Narrador e devem permanecer enigmáticas e incertas. As visões obtidas neste nível carecem da força de um benefício de sistema e estão incluídas como um recurso narrativo.
••• Não apenas o alquimista pode agora aprimorar seus alvos além das capacidades normais dos humanos, como também pode conceder habilidades psíquicas de baixo nível (veja o Capítulo Dois) por uma hora de cada vez. Essas habilidades psíquicas começam com um único ponto, mas cada dois sucessos adicionais fornecem um ponto adicional, até um máximo do nível de Caminho do alquimista.
•••• Os alquimistas podem provocar melhorias verdadeiramente potentes em seres vivos. Eles podem aumentar um único Atributo ou Habilidade em dois, ou dois Atributos ou Habilidades em um cada, e o limite humano normal de cinco não se aplica mais.
••••• O alquimista agora pode elaborar receitas que reproduzem até três pontos de poderes sobrenaturais. Cada ponto reproduzido dessa maneira imita um único efeito — escolhido quando a receita é elaborada — mesmo que o poder replicado ofereça múltiplos efeitos. Estas são algumas das poções mais difíceis de produzir e exigem componentes exóticos, tais como pedaços do ser sobrenatural em questão.

Preço do Fracasso: Trabalhar com compostos voláteis é perigoso por si só. Mesmo um simples fracasso resulta em equipamento quebrado e reagentes arruinados, exigindo substituições caras. No melhor cenário possível com um desastre de verdade, o produto alquímico explode, potencialmente ferindo o mago (bem como seus vizinhos). Mais comumente, porém, a receita desastrada parece se concretizar perfeitamente, mas produz efeitos indesejáveis e possivelmente danosos. Até mesmo um efeito inesperado, mas benigno, pode ser catastrófico no momento errado.]==] },
				["Chronomancy"] = { pt = [==[Sorcerer’s Companion, pág. 29


Chronomancy


É bem sabido que os magos são supostamente mestres do tempo e do espaço, e os Feiticeiros (Sorcerers) trabalharam para acompanhar esse tipo de crença também. Enquanto a Adivinhação (Divination) permite que um Feiticeiro veja aspectos do futuro, e a Fortuna (Fortune) permite puxar os fios do destino, alguns usuários de magia preferem concentrar-se em manipulações do tempo dentro do presente. Viajar anos através do tempo está além da capacidade da Feitiçaria, mas um usuário deste Caminho pode obter uma percepção mais aguçada do fluxo do tempo, fazer alterações sutis, ou mesmo acelerá-lo e desacelerá-lo. Alguns podem considerar esses efeitos comparativamente menores quando medidos contra algumas das coisas que um “verdadeiro” Mago pode fazer, mas a maioria dos Feiticeiros rapidamente descobrirá o quão útil este Caminho pode ser.

Sistema

Teste: Raciocínio + Ocultismo

Custo: Um ponto de Força de Vontade

Modificadores: –1 se o personagem tiver Meditado com sucesso naquele dia.

Duração: Varia.

Efeitos

A Chronomancy não tem Aspectos, propriamente, e em vez disso seus efeitos baseiam-se no nível puro.

• Ver o Fluxo (See the Flow): Neste nível, o Feiticeiro torna-se ciente do fluxo do tempo, capaz de acompanhá-lo perfeitamente e de reagir de acordo. Ele pode ser capaz de sentir que uma área está distorcida por magias de tempo ou por manipulações feéricas do chronos, e sua própria capacidade de reagir rapidamente às coisas melhora por causa disso. Em combate, o Feiticeiro ganha um bônus na Iniciativa igual aos sucessos obtidos, mas limitado pelo nível do Caminho. De todo modo, isso dura uma cena.
•• Sincronia Perfeita (Perfect Timing): Depois de conseguir sentir o fluxo do Tempo, o feiticeiro aprende a sincronizar-se com ele, o que lhe dá a capacidade de realizar ações que exigem boa sincronia ou o encadeamento de eventos com mais facilidade. Qualquer ação que exija sincronia precisa, incluindo a maioria das manobras de combate, pode ganhar um bônus de dados equivalente ao menor valor entre os sucessos obtidos e o nível do Caminho do conjurador. Isso dura até ser usado, mas não mais que uma cena, após a qual o bônus não usado desaparece.
••• Acelerar (Accelerate): Os discípulos deste Caminho são capazes de alterar mais deliberadamente o próprio fluxo do tempo, acelerando a si mesmos ao desacelerar as coisas para a sua percepção. Depois de conjurar esta magia, o Feiticeiro tem um número de ações extras que pode tomar em combate ou situação similar, distribuídas como desejar, igual aos sucessos obtidos, ainda que limitado pelo nível do Caminho. Isso não é cumulativo; apenas uma instância pode estar ativa por vez. Isso segue regras de ações extras similares às de Celeridade ou Fúria; essas extras não podem ser divididas ainda mais, ocorrem no fim do turno, e devem ser declaradas como em uso no início de um turno.
•••• Desacelerar (Decelerate): Com este uso do poder, o Feiticeiro torna-se capaz de desacelerar outros como antes acelerou a si mesmo. Cada sucesso obtido, limitado pelo nível do Caminho, causa a perda de uma ação de outro personagem a partir do turno seguinte. Por exemplo, se 3 sucessos forem obtidos, o alvo perderia 3 turnos de ações, ou precisaria ‘dividir’ sua parada de dados como se estivesse realizando a quarta ação de um turno (ou seja, uma penalidade de –7), ou alguma combinação dos dois. Isso pode ser anulado por qualquer coisa que conceda ações extras, na proporção de 1 para 1.
••••• Congelar (Freeze): O feiticeiro, neste nível de poder, pode parar o tempo em uma área pequena (1 metro de diâmetro), impedindo quaisquer ações ou movimento por um número de turnos ou minutos (em combate ou fora dele, respectivamente) igual aos sucessos obtidos, limitado pelo nível do Caminho. Qualquer coisa movida para dentro também fica congelada, mas algo que esteja apenas parcialmente dentro pode ser manipulado de fora; empurrar um colchão para baixo de alguém que você congelou pouco antes de atingir o chão, por exemplo.
•••••• Salto no Tempo (Time-Hop): Embora a verdadeira viagem no tempo esteja além do que qualquer Feiticeiro é capaz, esta magia permite que um Feiticeiro se ‘segure’ no tempo, desaparecendo e então reaparecendo um número de turnos ou minutos depois (dependendo de estar em combate ou não, respectivamente) igual ao número de sucessos obtidos (sem limite). Alternativamente, o conjurador pode saltar para trás um número de turnos igual aos sucessos obtidos (limitado pelo nível do Caminho), caso em que o feiticeiro permanece como está (dano sofrido e tudo) mas pode refazer esses turnos ao reaparecer e substituir seu eu anterior, com conhecimento do que acontece (as ações geralmente não podem ser mudadas até que o Feiticeiro faça algo diferente). Esta é uma magia para a qual se pode abortar, mas ainda custa uma ação para conjurar normalmente (assim, funciona como uma Esquiva perfeita, por assim dizer). Se algo estiver ocupando o espaço em que o Feiticeiro reapareceria após a duração, ele é movido para a área disponível mais próxima, e sofre 1 nível de dano letal.]==] },
				["Conjuration"] = { pt = [==[M20 Sorcerer, pág. 20


Conjuration


A Conjuração é o Caminho por excelência dos mágicos de palco: tirar coelhos de cartolas e cartas do bolso de alguém da plateia são exemplos comuns de suas aplicações mais básicas. Os feiticeiros que desejam ganhar a vida com seus estudos frequentemente aprendem Conjuração. Por causa dessa associação inextricável com a mágica de palco, os Adormecidos (Sleepers) tendem a racionalizar a Conjuração como simples prestidigitação especializada.

O caminho da Conjuração é a capacidade de mover ou convocar um objeto ou ser. Enquanto um novato talvez só consiga realizar truques de salão, como fazer moedas girarem, um feiticeiro avançado de Conjuração pode pendurar uma magia em seu companheiro antes de entrar em uma situação perigosa, permitindo-lhe arrancar o amigo das (talvez literais) garras da morte, se for preciso.

Quase tão importante quanto o que a Conjuração é, é o que a Conjuração não é. A Conjuração é muito semelhante ao caminho do Transporte (Conveyance) em termos de mecânica, a ponto de haver muitas vezes confusão entre os dois caminhos — especialmente entre os Magos Despertos, que podem alcançar resultados comuns a ambos os Caminhos com a Esfera de Correspondência. A Conjuração não pode mover o feiticeiro que a empunha, enquanto o Transporte pode. Um feiticeiro também não pode usar este caminho para “convocar” ataques elementais — esse é o domínio do Fogo Infernal (Hellfire). A Conjuração pode convocar um balde de areia, mas não pode criar uma tempestade de areia.

Sistema

Modificadores: Para qualquer aplicação que possa ser passada como — ou descrita de modo suficientemente semelhante a — mágica de palco, mantenha um sucesso que de outra forma teria sido removido pelas testemunhas. Até o consenso racional está predisposto pela cultura pop a acreditar que conjurar um elefante do nada é possível com truques visuais inteligentes. Observe que ações que causem dano físico óbvio não podem ser explicadas dessa maneira.

Usar Conjuração em um objeto nas mãos de alguém que resista ativamente acarreta +1 de dificuldade. Tentar usar Conjuração para mover um alvo que resista acarreta +2 de dificuldade. Aplique –1 de dificuldade para um objeto bem conhecido pelo feiticeiro (veja também Permanência de Objeto (Object Permanence) abaixo).

Aspectos: A Conjuração usa os Aspectos de Distância, Número de Alvos e Peso. A Conjuração notavelmente não usa Velocidade. O alvo convocado aparece instantaneamente com a conclusão bem-sucedida de uma magia ou ritual. O feiticeiro também pode escolher comprar os seguintes efeitos com sucessos adicionais:

• 1 sucesso para poder usar Conjuração para atacar desajeitadamente sem tocar a arma (penalidade de –1 dado no ataque).
• 2 sucessos para atacar como acima, mas sem penalidade, ou para conceder controle motor fino a qualquer objeto conjurado, como usar um conjunto de gazuas a distância.
• 1 sucesso para cada rodada adicional que o feiticeiro deseje manter o efeito. O Feiticeiro não pode mudar drasticamente o efeito, como arremessar um fantoche para golpear alguém depois de fazer o fantoche dançar, sem rolar Conjuração novamente.

Preço do Fracasso: Enquanto um simples fracasso significa que nenhum item é transportado, um desastre de Conjuração vai do altamente inconveniente ao grotesco. Um feiticeiro pode enviar um objeto para o lugar errado, como mandar um item ainda mais longe do alcance ou conjurar uma arma preparada diretamente na própria mão. Às vezes o feiticeiro convoca o objeto completamente errado. Alternativamente, um feiticeiro pode conjurar apenas parte do item pretendido, e basta imaginar o horror de um desastre na Conjuração de um ser vivo.]==] },
				["Conveyance"] = { pt = [==[M20 Sorcerer, pág. 22


Conveyance


Sonhando com teletransporte ou com vassouras voadoras, as pessoas sempre quiseram viajar rapidamente de um lugar a outro. Não importa quão rápido consigam fazê-lo, nunca é rápido o bastante, e muitos recorrem à magia e a ciências estranhas para chegar aonde vão bem mais cedo. Para os magos estáticos (hedge magicians), esses feitos podem não ser rotina, mas poucos deles se preocupam em ser alocados numa poltrona do meio de um avião.

Até alcançar os ápices do domínio do Caminho, um mago estático que use o Caminho do Transporte (Conveyance) precisa de algum tipo de veículo, que é preparado pelo mago para uma única viagem. Os místicos tendem a preferir botas de sete léguas, tapetes e vassouras voadoras, e coisas mais estranhas como carruagens puxadas por gatos divinos, enquanto os magos mais científicos usam mochilas a jato, carros transformáveis e afins.

Praticantes poderosos deste Caminho, porém, podem cobrir distância sem atravessar o espaço intermediário. O teletransporte não precisa ser instantâneo, mas costuma não precisar de veículo; normalmente um ritual ou dispositivo no ponto de origem basta para enviar o mago para onde ele quiser ir.

Sistema

Modificadores: +2 de dificuldade para cada alvo relutante, –1 de dificuldade para locais bem conhecidos

Aspectos: Além dos Aspectos de Distância, Velocidade de Viagem e Passageiros, cada um dos seguintes aumenta o número de sucessos necessários:

• 1 sucesso para viajar até um local onde o mago nunca esteve.
• 2 sucessos para teletransportar-se, mesmo que não seja instantâneo Isso é necessário para tentar usar o Transporte ofensivamente.
• Cada barreira atravessada custa um sucesso. As barreiras devem ser possíveis de contornar. Este Caminho não pode penetrar câmaras hermeticamente seladas.

Preço do Fracasso: Os acidentes com o Caminho do Transporte podem ser extremamente perigosos. Os fracassos são bastante inócuos, já que simplesmente nada acontece. Os desastres, porém, tendem a ser específicos ao método de transporte utilizado e tendem a atingir o conjurador (o trocadilho é intencional) no meio da viagem. Vassouras voadoras caem do céu, botas de sete léguas deixam você preso a léguas do seu destino, e corpos inteiros de ficção científica discutem o que acontece quando o teletransporte dá errado.]==] },
				["Curses"] = { pt = [==[The Hunters Hunted II, pág. 72


Curses


A maldição é uma das formas mais antigas e potentes de Magia Estática (Hedge Magic). Ela pode tomar muitas formas, do “mau-olhado” do Mediterrâneo e do Oriente Médio ao “jinx” do hoodoo e ao “hex” do folclore do Leste Europeu. Sabe-se que maldições causam graves infortúnios em uma variedade de formas: acidentes, doenças e até a morte.

No cerne de qualquer maldição está a intenção maléfica dirigida a um inimigo. A Maga Estática concentra sua vontade, seu ódio dirigido, sobre o alvo e libera essa intenção na forma de energia nociva. A maldição aflige rapidamente a vida da vítima e desvanece lentamente à medida que a energia odiosa se dissipa.

A mecânica básica do amaldiçoar é simples. A Maga Estática determina que nível de maldição deseja infligir (dentro de sua capacidade), e então gasta um turno por nível de severidade reunindo e afiando seu ódio místico. Uma vez preparada, ela descarrega a maldição de forma catártica diretamente sobre o alvo (que deve estar visível para ela). Exemplos de uma descarga apropriada incluem um grito, uma dança, rasgar um boneco que representa a vítima, ou gestos ofensivos.

O jogador da Maga Estática faz um teste de ativação de Manipulação + Intimidação (dificuldade 7) para determinar se a maldição é bem-sucedida e qual a sua duração, conforme listado em Efeitos.

Cada nível do Caminho das Maldições permite que uma gama maior de infortúnios ocorra. Mecanicamente, uma maldição toma a forma de penalidades às dificuldades e, eventualmente, às paradas de dados. O Narrador deve aplicar os efeitos de uma maldição com cuidado para garantir que este Caminho de Numina não domine a crônica inteira.

Ao mexer com os fios do destino, contudo, a Maga Estática corre o risco de enredar-se a si mesma. Uma falha crítica em uma maldição traz os efeitos de volta sobre ela em triplo, caso em que a maldição destinada ao inimigo aplica-se imediatamente à Maga Estática.

Uma Maga Estática pode tentar banir qualquer maldição, mesmo uma sua, mas não é fácil. Seu jogador deve gastar um ponto de Força de Vontade e testar Raciocínio + Manha (dificuldade 9). Cada nível de sucesso reduz o nível da maldição infligida em um ponto. Se o teste falhar criticamente, a Maga Estática sofre a própria maldição que tentou banir pelo restante da duração original da maldição, sem nova chance de rompê-la.

O Caminho das Maldições acaba cobrando seu preço da alma humana. Seus praticantes raramente vivem vidas felizes, pois o ódio e a raiva necessários para alimentar este Caminho tendem a retorcer-lhes as entranhas. Mecanicamente, isso muitas vezes se traduz em uma Humanidade baixa para os personagens que praticam este Caminho. Os Narradores são encorajados a exigir testes de Humanidade de Magos Estáticos que tenham Humanidade alta ou que invoquem maldições mais de uma vez por mês.

Sistema

Teste: Manipulação + Intimidação (dificuldade 7)

Modificadores: N/A

Custo: 1 ponto de Força de Vontade

Duração: Varia (veja abaixo)

Níveis do Caminho das Maldições

• A vítima sofre inconveniências breves, como deixar cair um objeto, dizer algo tolo, ou ter o pé atropelado por uma motocicleta. Mecanicamente, isso é representado pelo Narrador somando +1 de dificuldade às paradas de dados apropriadas à situação especificada pela duração da maldição. Por exemplo, o pé machucado pode aumentar em 1 as dificuldades de Esportes, enquanto dizer algo tolo pode fazer as dificuldades de Etiqueta aumentarem do mesmo modo.
•• A vítima sofre uma sequência de erros e má sorte que resultam em ferimento duradouro ou constrangimento, como pisar em um prego, quebrar uma herança de família, ou pegar uma doença leve. Mecanicamente, isso é representado pelo Narrador aumentando em 2 a dificuldade dos testes apropriados à maldição pela duração da maldição.
••• A vítima sofre acidentes e infortúnios severos. Efeitos típicos podem ser ossos quebrados, perda de renda, ou doença grave. Mecanicamente, isso é representado pelo Narrador aumentando em 3 a dificuldade dos testes apropriados à maldição pela duração da maldição.
•••• A vítima sofre grandes catástrofes e doenças crônicas. Mecanicamente, isso é representado pelo Narrador aumentando em 3 a dificuldade dos testes apropriados à maldição pela duração da maldição. Além disso, a vítima subtrai um das paradas de dados associadas nos momentos apropriados da história.
••••• As maldições infligidas neste nível são quase de escopo Bíblico. Nada dá certo para a vítima pela duração da maldição. Sua vida é um exercício de miséria, e pode muito bem ser acompanhada de pragas de gafanhotos, de tornar-se estéril, ou de causar desespero naqueles que encontra. Mecanicamente, isso é representado pelo Narrador aumentando em 4 a dificuldade dos testes apropriados à maldição pela duração da maldição. Além disso, a vítima subtrai dois das paradas de dados associadas nos momentos apropriados da história. Invocar uma maldição desta magnitude exige um teste de Humanidade para os Magos Estáticos de Humanidade 4 ou mais.

Duração da Maldição

A duração de uma maldição específica é determinada pelo número de sucessos obtidos no teste de ativação.

Um sucesso — A próxima ação
Dois sucessos — Uma cena
Três sucessos — Um dia
Quatro sucessos — Uma semana
Cinco sucessos — Um mês
Seis+ sucessos — Até um ano, decidido na ativação da maldição]==] },
				["Divination"] = { pt = [==[M20 Sorcerer, pág. 23


Divination


Ler folhas de chá, lançar pedras rúnicas ou ossos, estudar o céu noturno — todos esses são exemplos de práticas tradicionais de Divinação (Divination), cujas variações abrangem uma infinidade de culturas. Desde que existe o conceito de futuro, existem pessoas querendo saber o que ele lhes reservava. Algumas das práticas mais recentes, embora mais difíceis, envolvem o uso de programação avançada de computadores baseada em ciências extraordinárias e hipermatemática (hypermath).

Um mago estático (hedge magician) que realiza atos de Divinação tenta prever o futuro. No entanto, o futuro é uma confusão turva e em constante mudança. Um feiticeiro pode usar a Divinação para encontrar pistas dos resultados mais prováveis, mas o vidente sábio conhece o valor de interpretar com precisão o simbolismo impreciso e onírico para julgar as prováveis mudanças de probabilidade.

Raramente algo a respeito do futuro está gravado em pedra. Mortais morrem, mas o onde, o quando e o como são determinados por variáveis infinitas: escolhas de ação e de inação igualmente. A mera decisão de vislumbrar o futuro e contar a alguém sobre isso pode alterar drasticamente os resultados.

Como a Divinação se apoia em práticas ritualísticas, não há distinção entre magias e rituais neste Caminho, exceto pelo tempo e pelo esforço de conjuração. A Divinação raramente se qualifica como magia vulgar, e muitos magos estáticos habilidosos nessa arte acham lucrativo praticá-la abertamente. No entanto, algumas práticas, como a Haruspicina (Haruspicy) (prever o futuro estudando as entranhas de um sacrifício), correm o risco de consequências legais se descobertas. A maioria dos Adivinhos (Diviners) escolhe uma prática, mas não é inédito que feiticeiros tenham algumas práticas que usam dependendo da situação ou do cliente, especialmente se uma prática favorita for ilegal ou estiver sujeita a ser frustrada pelo clima, como no caso da astrologia.

Sistema

Modificadores: +1 de dificuldade ao usar Ciência Extraordinária (Extraordinary Science), mas essa Prática fornece probabilidades mais precisas.

–1 de dificuldade quando sob a influência de substâncias que alteram a mente. Visões e sinais podem vir com mais facilidade e mais vívidos em estados alterados, mas continuam sujeitos a interpretação.

Aspectos: a Divinação usa os seguintes:

Período de Tempo (Time Period)

• um dia

•• uma semana

••• um mês

•••• um ano

••••• 10 anos

Precisão (Accuracy)

• Visões e sinais são incrivelmente vagos e difíceis de interpretar com qualquer certeza

•• Tipicamente precisos, mas profundamente enterrados em simbolismo

••• Precisos, mas vagos e abertos a más interpretações

•••• A verdade está lá sob camadas de simbolismo, mas não é terrivelmente difícil de interpretar

••••• Precisos e muitas vezes fáceis de entender, embora ainda sujeitos a erro humano

Consulta (Query)

• Uma pergunta simples que poderia ser respondida com sim ou não se você estivesse falando com uma pessoa em vez de com as estrelas ou as entranhas

•• Uma pergunta específica que pode ser respondida com uma explicação curta e simples. Por exemplo, “Qual estrada à frente é mais segura?”, mas não “Qual é o plano do nosso inimigo?”

••• A pergunta poderia ser pesquisada e respondida com conhecimento de fontes públicas, se apenas você tivesse as horas para dedicar.

•••• A pergunta pode ser detalhada e exigir informações ocultas, mas as informações poderiam ser descobertas com tempo e conhecimento suficientes.

••••• Uma consulta muito detalhada que normalmente exigiria informações perdidas, destruídas ou deliberadamente ocultadas para ser respondida.

Preço do Fracasso (Price of Failure): No melhor cenário, o feiticeiro simplesmente não recebe visões nem intuição alguma devido ao fracasso. Um desastre, no entanto, pode dar leituras patentemente falsas ou perigosamente enganosas. O mago estático pode divinar que não há segurança no local em que seu coven planeja invadir, quando o lugar usa segurança suficiente para rivalizar com Fort Knox. Alternativamente, o feiticeiro pode divinar corretamente que a fechadura de uma porta está quebrada, mas não compreender que o proprietário sabe disso e colocou guardas armados para vigiá-la. O Narrador deve variar as abordagens para os desastres de Divinação, para que não se tornem previsíveis dentro e fora do personagem.]==] },
				["Dowsing"] = { pt = [==[Sorcerer’s Companion, pág. 21


Dowsing


Com este Caminho, um mago usa itens ritualmente preparados mas em última análise mundanos para responder perguntas simples, localizar fontes elementais e encontrar itens específicos. Este Caminho é aparentado à Adivinhação (Divination) no sentido de que ambos permitem ao mago usar focos externos e interpretação para ler fatos do mundo ao seu redor. A Radiestesia (Dowsing) é muito mais orientada a resultados que a Adivinhação, pois é dedicada a assuntos específicos, limitados e práticos, em vez de possibilidades e circunstâncias abrangentes. Poder-se-ia dizer que, enquanto a Adivinhação foca no universal, a Radiestesia atende ao específico.

Ao praticar a radiestesia, o mago usa um item específico, ou itens, feitos de materiais normais do dia a dia, para encontrar algum tipo de objeto, pessoa, substância ou local, ou para determinar um fato imediato. O estereótipo do radiestesista é o do caipira com uma vara bifurcada procurando água, e de fato esse é um uso comum da habilidade. Os verdadeiros radiestesistas sabem, porém, que há muito mais nesta magia. Fatos podem ser aprendidos por meio de perguntas feitas com critério. Itens específicos podem ser encontrados e, em níveis mais altos, até emoções ocultas (como malícia, ódio ou mesmo amor) podem ser detectadas naqueles ao seu redor.

Os radiestesistas dependem mais que a maioria de seus Focos, que muitas vezes atuam como sua ferramenta de adivinhação. Se o Radiestesista não tiver o ritual “Prepare Implement”, ele precisa ter um foco Personalizado ou Único dedicado a este Caminho para poder usá-lo. Por isso, a maioria aprende esse ritual básico cedo, para dispor de opções adicionais sobre como conduzir suas magias.

Quaisquer perguntas feitas com a Radiestesia devem relacionar-se ao presente ou ao passado imediato, e apenas à área/situação imediata; prever o futuro ou obter informações relativas a circunstâncias de longo alcance é da alçada da Adivinhação. O Aspecto de distância deve cobrir tudo o que estiver sendo questionado, bem como a distância até qualquer coisa que esteja sendo buscada mais diretamente.

Sistema

Teste: Percepção + Prontidão

Modificadores: –1 para objeto/local/etc. bem conhecido. +1 a +3 para alvos vagamente definidos.

Custo: Nenhum para ferramenta ritualmente preparada, um ponto de Força de Vontade para usar focos diretamente.

Duração: Aproximadamente uma cena de busca

Aspectos

Potência

• O radiestesista é capaz de encontrar itens pequenos (até o tamanho de um livro pequeno) que já lhe pertencem, ou obter uma noção vaga da resposta a uma pergunta de sim/não sobre circunstâncias imediatas relativas a si mesmo.
•• O radiestesista pode encontrar itens pessoais de qualquer tamanho, e objetos pequenos e especificamente definidos pertencentes a outros (“a aliança de casamento do Joe” é aplicável, mas não “qualquer livro que tenha o ritual de que preciso”). Ele também pode obter uma noção geral da resposta a uma pergunta de sim/não relativa às circunstâncias imediatas de outro indivíduo.
••• O radiestesista pode encontrar itens especificamente definidos de qualquer tamanho pertencentes a qualquer um, buscar objetos pequenos e vagamente definidos, ou encontrar acúmulos de substâncias mundanas (uma nascente subterrânea, ou uma inesperada “bolsa de ar” nas paredes de um edifício representando um quarto secreto). Qualquer tipo de pergunta de sim/não relativa às circunstâncias imediatas pode ser feita em vez disso (“Existe um deus?” está além do seu alcance, mas “Esta sopa está envenenada?” é válido).
•••• O radiestesista pode buscar fenômenos menos materiais ou óbvios, como buscar magia, Mana, doença ou emoções, embora as especificidades devam ser definidas (“Proteções”, não “qualquer magia que eu queira ver”).
••••• O radiestesista pode buscar fenômenos imateriais menos bem definidos, como buscar qualquer tipo de magia Desperta, ou Mana de qualquer ressonância.
•••••• O radiestesista pode buscar objetos, pessoas, locais, substâncias ou fenômenos incrivelmente vagos de qualquer tamanho, por exemplo buscar “a fraqueza do Demônio que está me perseguindo” ou “o melhor recurso para melhorar meus estudos”.

Distância

• As imediações (6 metros, ou um quarto pequeno)
•• O mesmo edifício ou área (cerca de 15 metros).
••• Cerca de 1,5 km.
•••• Cerca de 16 km.
••••• Em torno de 160 km.
•••••• Sem limite, embora o poder possa precisar ser reativado para localizar algo muito distante.

Preço do Fracasso

A falha mais óbvia é simplesmente a incapacidade de discernir o que o Feiticeiro deseja, mas falhas críticas podem causar-lhe problemas mais profundos. Podem levá-lo a uma situação perigosa, fornecer respostas deliberadamente enganosas e perigosas, ou enganá-lo a ponto de fazê-lo pensar que aquilo que busca sequer existe.]==] },
				["Ephemera"] = { pt = [==[M20 Sorcerer, pág. 25


Ephemera


Alguns magos — aqueles que se concentram no Caminho da Convocação, Vinculação e Proteção (Path of Summoning, Binding, and Warding) — comandam espíritos. Aqueles que seguem o Caminho da Efêmera (Path of Ephemera) buscam uma relação de maior familiaridade com eles. Para os magos que usam o Caminho da Efêmera, sua relação com os espíritos é mais como família e amigos do que senhor e servo. Quando chamam por um espírito, é um convite, não uma intimação judicial.

Em vez de vincular e comandar espíritos, o Caminho da Efêmera permite que o mago negocie com eles. Esse processo, chamado chiminage, é um dar e receber. Cada espírito quer algo diferente, relacionado à sua natureza. O pedido do espírito depende do poder do espírito e do tamanho da tarefa envolvida. Pedir a um Incarna que empreenda uma tarefa difícil e de longo prazo exige muito do mago, talvez algo só possível com uma difícil missão própria. Pedir a um Gaffling que faça algo simples e diretamente ligado à sua natureza (por exemplo, pedir a um espírito do fogo que acenda uma vela) exigiria, ao contrário, quase nada do mago, talvez apenas a oportunidade de fazê-lo. Esse processo, naturalmente, tem uma curva de aprendizado acentuada. A maioria dos magos se vê no lado pior de um ou dois acordos antes de pegar o jeito.

Este Caminho quase sempre se concentra na Umbra Intermediária (Middle Umbra) e, mais raramente, na Umbra Inferior (Low Umbra). Rumores de versões que funcionam com a Umbra Superior (High Umbra) são persistentes, mas não passam de boatos.

Sistema

Modificadores: –2 a +2 de dificuldade dependendo da opinião do espírito sobre o mago.

Aspectos: Peso Metafísico (Metaphysical Weight) e Alcance Espiritual (Spiritual Reach).

Alcance Espiritual

• O mago pode sentir espíritos e obter sua atenção, mas pouco mais pode fazer.

•• O mago está restrito a invocar um tipo geral de espírito

••• Agora espíritos específicos podem ser chamados por meio de rituais feitos sob medida, e quase sempre aparecem, a menos que o mago os tenha ofendido de alguma forma.

•••• Espíritos começam a se aproximar do mago sem serem solicitados. O mago consegue ver a Penumbra, o que aumenta o número e os tipos de espírito com os quais pode interagir. O mago também pode revidar contra espíritos, se precisar, embora a maioria tente evitar isso.

••••• O mago agora pode ir até os espíritos em vez de precisar que eles venham ao mundo físico. Embora a viagem física até a Umbra ainda seja impossível, o mago pode se projetar astralmente até lá, usando Raciocínio no lugar de Destreza, Manipulação no lugar de Força, Inteligência como Vigor e Força-de-Vontade como níveis de Vitalidade. Eles estão conectados ao seu corpo por um fio de prata e, se ficarem sem Força-de-Vontade, ele se rompe, cortando sua conexão e deixando-os presos.

Preço do Fracasso: Lidar com espíritos pode ser perigoso, especialmente nos estágios iniciais, quando tudo o que um mago consegue fazer é chamar a atenção do que estiver por perto. Mesmo nos níveis mais altos, a coisa mais perigosa possível em um desastre é chamar o espírito errado, sendo as pragas (banes) particularmente comuns.]==] },
				["Enchantment"] = { pt = [==[M20 Sorcerer, pág. 26


Enchantment


O Caminho do Encantamento (Path of Enchantment) recompensa a paciência e a premeditação mais do que qualquer outro Caminho. Não há magias neste Caminho, apenas rituais, o que faz com que o mago estático (hedge wizard) precise aprender — ou inventar — um novo ritual cada vez que quiser fazer um Artefato (Artifact) que ainda não tenha feito antes. Cada um desses Artefatos deve ser cuidadosamente confeccionado pelo Encantador. O primeiro passo é criar o item mundano de base. Normalmente, esses são feitos à mão pelo próprio Encantador, levando suas habilidades mundanas ao limite para fazer exatamente o receptáculo certo para sua magia. Às vezes, no entanto, o receptáculo certo pode ser encontrado na forma de um objeto raro ou antigo. Uma vez que o receptáculo tenha sido feito ou encontrado, o Encantador pode partir para o processo de infundir o objeto com energia mágica para ser usada depois. O primeiro estágio geralmente é realizado por meio de testes de Ofícios (Crafts) (ou, para tecnofeiticeiros (technosorcerers), testes de Tecnologia ou Hipertecnologia (Hypertech)), enquanto o último é um teste de Caminho.

Os Artefatos criados por meio do Encantamento diferem em vários aspectos essenciais das receitas da Alquimia (Alchemy). Artefatos geralmente são persistentes ou, ao menos, podem ser usados muitas vezes. Alguns podem ser permanentes, ou quase isso, enquanto outros podem ser usados um número fixo de vezes antes que sua magia se dissipe. Além disso, eles tendem a ser mais fracos que os Prodígios (Wonders) criados por magos, e mais focados. Um Artefato só pode ter um único poder, uma restrição que os Prodígios não têm.

Encantadores tendem a gastar muito tempo e esforço em suas oficinas. Qualquer tipo de artesanato que façam para criar seus Artefatos os define. Eles frequentemente se veem primeiro como ferreiros, joalheiros, engenheiros eletrônicos ou marceneiros, e a magia que podem fazer vem depois. Isso leva os Encantadores a buscar altos níveis do Antecedente (Background) Recursos, assim como de outros que representem um espaço seguro e protegido para realizar seu trabalho e a capacidade de adquirir matérias-primas de alta qualidade e muitas vezes exóticas.

Sistema

Modificadores: Uma vez que um mago crie um Talismã (Talisman) três vezes, a dificuldade é reduzida em 1.

Tempo: Tempo de confecção do objeto, mais 1-3 dias por nível do encantamento

Efeitos: O Encantamento não tem Aspectos; em vez disso, tem os seguintes Efeitos:

• O Encantador pode criar itens menores que raramente são perceptivelmente mágicos para aqueles que ainda não estejam cientes de seus poderes. Isso pode adicionar um (ou, em circunstâncias restritas, dois) dados a um teste de Atributo ou Habilidade, ou diminuir a dificuldade em 1 para um ataque ou uma perícia. Outras pequenas dádivas também são possíveis.

•• Versões mais poderosas de Artefatos já possíveis oferecem dois dados adicionais ou –2 de dificuldade em uma tarefa. Alguns dos objetos criados neste nível podem mudar a realidade de maneira sutil, sendo mais mágicos do que era possível anteriormente.

••• Itens obviamente mágicos agora são possíveis, embora ainda pareçam apenas “muito estranhos” para os leigos em magia. Estes incluem itens que oferecem dois dados adicionais em até três testes diferentes de Atributo ou Habilidade, e aqueles que conferem percepções sobrenaturais ao usuário replicando poderes sobrenaturais de não mais de um único ponto.

•••• Objetos de poder verdadeiramente sobre-humano. Estes podem elevar Atributos acima de 5, duplicar poderes (até o segundo ponto) de outros seres sobrenaturais e, de outras formas, distorcer a realidade de maneiras significativas.

••••• Itens extremamente poderosos, muitas vezes beirando o mítico. Milagres menores são possíveis, e frequentemente esses poderes são bastante evidentes. Itens criados neste nível podem reproduzir até três pontos de poderes sobrenaturais. Cada ponto reproduzido dessa forma imita um único efeito — escolhido quando o item é confeccionado — mesmo que o poder replicado ofereça múltiplos efeitos.

Preço do Fracasso: O fracasso geralmente significa que o mago desperdiçou dias ou semanas de seu tempo, possivelmente arruinando o item que tentava encantar, mas nada pior. Desastres tendem a ser mais variados. Podem resultar em explosões que destroem a oficina. Pior, porém, podem resultar em objetos que parecem funcionar, mas têm algum tipo de efeito colateral imprevisto. Esses itens malditos tendem a ser difíceis de destruir ou de descartar, muitas vezes permanecendo muito tempo depois de o Encantador ter partido e até chegando às mãos de Adormecidos (Sleepers).]==] },
				["Fascination"] = { pt = [==[M20 Sorcerer, pág. 29


Fascination


Histórias do feiticeiro cativante ou do mágico enfeitiçador são encontradas em contos populares por todo o mundo. Encantadores traiçoeiros trazem os inocentes para sob seu domínio, e pactos firmados em troca de poder aprisionam os corações e as mentes daqueles tolos o bastante para assinar a entrega de suas almas em tais barganhas. O grão de verdade nesse velho clichê é sólido como diamante. Mágicos inescrupulosos que dobram as mentes dos outros à sua vontade praticam este Caminho desde que alguém desejou que outra pessoa simplesmente agisse ou pensasse de maneira agradável.

Os métodos variam, mas o resultado é o mesmo: Quebrar a vontade do sujeito e cativá-lo. Um feiticeiro que empregue uma prática mística pode aplicar maquiagem que faça seus olhos brilharem com um resplendor arrebatador. Ele pode se borrifar com uma fragrância sedutora, atraindo a atenção de qualquer um ao alcance do aroma. Outros podem simplesmente afiar sua confiança como o fio de uma navalha, impossível de resistir. Cidadãos Extraordinários (Extraordinary Citizens) carregam ressonadores harmônicos testados e aprovados que emitem uma frequência subsônica que reequilibra neurotransmissores para facilitar a submissão.

Aqueles que já possuem poderes de alteração mental podem resistir com seus próprios poderes se forem o alvo específico de um poder. Isso funciona nas duas direções, já que um estudante deste Caminho pode reconhecer outros usos de efeitos de alteração mental e se preparar para resistir a eles ou superá-los.

Sistema

Modificadores: +1 de dificuldade por ser antipatizado pelo alvo, +2 de dificuldade por ser odiado pelo alvo

Aspectos: Além dos Aspectos de Número de Alvos (Number of Targets), Alcance (Range) e Conexão Simpática (Sympathetic Connection), Fascinação (Fascination) usa os Aspectos Atração (Allure) e Dobra de Vontade (Willbending):

Atração

• Adicione 1 dado às paradas de dados sociais
•• Adicione 2 dados às paradas de dados sociais
••• Adicione 3 dados às paradas de dados sociais
•••• Adicione 4 dados às paradas de dados sociais
••••• Adicione 5 dados às paradas de dados sociais

Dobra de Vontade

• Intrigante (Intriguing): Você atrai atenção mesmo em uma multidão, e os indivíduos o acham interessante em uma conversa a dois. Você pode fazer sugestões brandas que se alinhem com a personalidade e a situação do alvo, como deixar outra pessoa bêbada se estiverem em um bar.
•• Atraente (Alluring): Quase todos na reunião sabem que você estava lá, e os indivíduos tentarão encontrar uma maneira de vê-lo novamente. Você pode fazer sugestões fortes que se alinhem com a personalidade e a situação do alvo, como ir para casa com o mago estático (hedge wizard) após uma noite divertida.
••• Ludibriante (Beguiling): Todos presumem que você teve participação na organização da festa, e os indivíduos ao seu redor disputarão sua atenção. Você pode fazer sugestões que não se alinhem necessariamente com a personalidade e a situação do alvo, como sugerir que terminem com seu parceiro de longa data para dar ao conjurador da magia uma chance de uma única vez.
•••• Arrebatador (Entrancing): Com convite ou não, a festa é realizada em sua homenagem, na estimativa de todos. Os indivíduos não querem mais apenas sua atenção, eles anseiam por sua aprovação, possivelmente fazendo papel de bobos no processo. Você pode fazer sugestões fortes que não se alinhem com a personalidade ou os interesses do alvo, como sugerir que o alvo lute contra outra pessoa para defender a honra do mágico.
••••• Escravizador (Enthralling): Se você começasse a atirar coisas, este lugar se tornaria um tumulto em escala total; os presentes se veem em dificuldade para resistir aos seus pedidos, fazendo quase qualquer coisa que você venha a pedir. Inferno, eles podem até matar por você ou colocar a vida em risco por você se você pedir do jeito certo. Você pode fazer sugestões fortes que desafiem descaradamente o caráter e as circunstâncias do alvo, como sugerir que a vítima da magia incendeie um bar por ousar anunciar a última rodada.

Preço do Fracasso: As consequências do fracasso ao manipular corações e mentes tendem a se basear no contexto da situação. Um simples fracasso em uma festa pode passar em grande parte despercebido após um momento de leve vergonha, como uma bebida derramada durante a tentativa de um floreio grandioso ou pisar nos pés dos outros ao atravessar a pista de dança. Um desastre, porém, inevitavelmente leva à humilhação, ou pior. Isso pode ser representado invertendo qualquer bônus em uma penalidade pelo tempo da duração. O alvo do encantamento se torna um inimigo jurado em vez de um amante, ou pode perder a capacidade de sentir emoções por completo. O sujeito deste último efeito fica insensível a todas as formas de empatia e simpatia e exige grandes esforços ou a passagem do tempo para voltar ao normal. O inverso pode ver a vítima se tornar desequilibrada, transformando-se em um abusador violentamente ciumento que fará mal a qualquer um que perceba como invasor de seu domínio.]==] },
				["Fortune"] = { pt = [==[M20 Sorcerer, pág. 30


Fortune


O destino é volúvel, mesmo antes de considerar as manipulações dos mágicos. O Caminho da Fortuna permite que eles empunhem a sorte como uma arma, abatendo seus inimigos com maldições ou fortalecendo seus aliados com bênçãos. Embora os métodos e as explicações possam variar, do Mau-Olhado (Evil Eye), à Mão de Deus, à manipulação de probabilidade, o Caminho da Fortuna nunca faz o verdadeiramente impossível acontecer, apenas o extremamente improvável. Ele também é um dos Caminhos menos precisos: enquanto o mago estático (hedge magician) põe a Fortuna em movimento e controla a magnitude e a faixa geral de resultados potenciais, os efeitos deste Caminho frequentemente o surpreendem ou desaparecem no ruído da vida cotidiana.

O Povo da Noite (Night-Folk) é mais difícil de maldizer com este Caminho do que os Adormecidos. Eles fazem um teste de Força-de-Vontade contra 4 + o índice de Caminho do mágico, e efeitos sem um Aspecto em 5 exigem apenas um único sucesso para serem anulados. Aquelas maldições extremamente poderosas podem ser ignoradas com apenas dois sucessos, embora a dificuldade seja 9, o que torna isso bastante desafiador. Para resistir, a vítima deve estar ciente da maldição do mágico e tentar ativamente resistir a ela. Descobrir uma maldição não anunciada pode ser difícil, mas é possível por meio de percepções sobrenaturais, como a leitura de aura. Magos com Primórdio (Prime) ou Entropia (Entropy) podem notá-la, e mágicos com o Caminho da Fortuna geralmente conseguem reconhecer o trabalho de um dos seus.

O Antecedente Arcano/Camuflagem (Arcane/Cloaking) fornece uma camada adicional de proteção contra maldições. Ter como alvo qualquer pessoa com esse Antecedente sem sua permissão explícita subtrai um sucesso do teste por cada ponto de Arcano que ela tiver.

Sistema

Modificadores: –1 de dificuldade com uma conexão simpática fraca (objeto pertencente ao alvo), –2 de dificuldade para uma conexão simpática forte (posse valiosa do alvo, parte do alvo como cabelo ou aparas de unha)

Aspectos: A Fortuna usa o Aspecto Duração (Duration), mas trata todas as durações como um nível acima, com Duração 5 consistindo em magias que duram vários anos. Além disso, usa o Aspecto Número de Alvos (Number of Targets), mas todos os alvos devem ser relacionados (membros de uma família, a população de uma cidade pequena, etc.). O Caminho da Fortuna também usa um Aspecto chamado Severidade (Severity), como segue:

Severidade

• Uma bênção ou maldição menor, geralmente algo simples, como um ato falho ou conseguir pegar por muito pouco um ônibus de que o alvo precisa.
•• Um inconveniente, ferimento ou pequeno benefício duradouro, mas não permanente. Torções, doenças que não ameaçam a vida e objetos quebrados são o padrão da má sorte, enquanto a boa sorte pode ser tão simples quanto evitar a gripe por uma estação, uma pequena vantagem em combate ou a resolução de um obstáculo menor.
••• Um grande reverso ou bônus. Doenças temporárias, mas graves, e sérias gafes sociais são as maldições mais comuns, enquanto encontrar burocratas prestativos, sucesso com jogos de azar ou relacionamentos, ou um dado adicional em paradas de combate são as bênçãos mais comuns.
•••• Agora as bênçãos e as maldições podem ter efeitos sérios e permanentes. Ferimentos debilitantes, falência, uma tragédia social que deixa o alvo um pária, ganhar na loteria, sobreviver a uma morte quase certa, ou apenas um encontro casual que muda a posição social do alvo são todos possíveis.
••••• Maldições neste nível quase sempre resultam em uma morte dolorosa e incomum. Alvos são decapitados, sofrem doenças degenerativas incuráveis, sofrem acidentes de carro horríveis e mais. As bênçãos são igualmente dramáticas, como ser resgatado de uma execução estatal por uma ligação do governador. Outras salvações de última hora de uma morte certa são possíveis, mas também vitórias muito mais raras que uma em um milhão: um inimigo em combate pode tropeçar e quebrar o pescoço, o beneficiário pode encontrar um tomo perdido na cesta de promoções de uma livraria de usados, ou pode ganhar um cargo político sem nenhum reconhecimento de nome.

Preço do Fracasso: Algumas magias de Fortuna fracassadas são indetectáveis. O alvo é naturalmente sortudo ou azarado, resultando na aparência de um sucesso. Desastres são um assunto mais sério. Uma bênção ou maldição distorcida ainda resulta. Bênçãos parecem benéficas no início, mas cada vez que ajudam o alvo há consequências horríveis. Maldições, do mesmo modo, parecem prejudiciais, mas acabam beneficiando o alvo da ira do mágico. Isso é especialmente perigoso para um mágico que tenta usar o Caminho da Fortuna em si mesmo. Em vez de bênçãos distorcidas, a força total de uma maldição mais poderosa, muitas vezes a mais poderosa que o mágico consegue causar, o toma como alvo. E o pior de tudo, o mágico não pode desfazer (unweave) a magia em que obteve um desastre sobre si mesmo, embora possa fazê-lo em outros.]==] },
				["Healing"] = { pt = [==[M20 Sorcerer, pág. 32


Healing


Onde a humanidade prospera, há necessidade de cura. Desde o amanhecer da civilização, curandeiros surgiram da empatia e da necessidade da comunidade. Muito antes de a ciência saber o que era a teoria dos germes, curandeiros aprenderam a servir seu povo pela tradição, comungando com espíritos, por tentativa e erro e por uma série de outros meios. Agora, mesmo quando a ciência pode prevenir e curar doenças horríveis, muitos permanecem sem acesso a tais técnicas. Em desertos médicos e em comunidades que foram historicamente injustiçadas pelo establishment médico, ainda há necessidade. As pessoas ainda buscam desesperadamente curandeiros. Elas podem não acreditar plenamente em magia ou milagres, mas entre a escolha de uma agonia garantida e um fio de esperança, muitos arriscam.

A magia estática (hedge magic) pode alcançar resultados miraculosos. Um curandeiro mestre pode curar cânceres e acelerar a cura de ferimentos graves além do que deveria ser possível, mas eles não anunciam isso. Mesmo quando tantos são ignorados e abandonados pelo establishment médico, é ilegal praticar medicina sem licença. Além disso, a fama pode ser um fardo pesado de carregar. Muitos magos estáticos (hedge magicians) ávidos e empáticos começam a aprender o caminho da Cura, mas poucos o dominam — eles frequentemente se esgotam cedo por causa do mundo frio e ingrato, mudando para outras Artes se continuarem a praticar magia de alguma forma.

Embora não seja sempre exigido por sua Prática, muitos Curandeiros magos estáticos aprendem alguma forma de medicina. Aqueles que não confiam na ciência extraordinária muitas vezes aprendem formas de cura não baseadas na medicina moderna. No mínimo, nos casos em que aprendem os fundamentos da ciência médica moderna, sua abordagem ao tratamento pode ser radicalmente diferente em filosofia e técnica.

Um curandeiro pode curar doenças ou deformidades congênitas leves a moderadas, mas exemplos mais extremos, como regenerar membros ou ressuscitar os recém-mortos, são o campo da lenda.

Sistema

Modificadores: A conjuração rápida (fast casting) só pode ser usada para estabilizar dano letal ou agravado ou para reduzir penalidades de ferimento. Todos os outros usos devem empregar magias comuns, magias de rolagem estendida ou rituais.

• 1 sucesso adicional para corrigir um ferimento mal curado
• +1 de dificuldade para curar um paciente não cooperativo

Aspectos: Este caminho usa o Aspecto Dano/Cura (Damage/Healing). Dano contundente pode ser curado com um sucesso por nível de dano. Além disso, cada sucesso pode reduzir uma toxina, doença ou penalidade de ferimento (causada por dor, em vez de um membro faltante, por exemplo) em um nível. Veja Mage 20 p. 406 para informações sobre penalidades de ferimento e p. 442 para a tabela de toxinas e doenças.

Preço do Fracasso: Um fracasso simplesmente significa que a magia não funcionou; o dano estava além da capacidade de cura do feiticeiro. Um desastre pode se tornar horrível rapidamente. Um Curandeiro pode tornar a pessoa mais suscetível à toxina que está tentando combater, aumentando o Índice de Toxina (Toxin Rating) efetivo. Ele pode causar dano diretamente ou curar algo incorretamente, como fundir as pálpebras ou consertar um osso torto, de modo que ele precise ser quebrado de novo mais tarde. O curandeiro também pode infectar a si mesmo com a doença que estava tentando curar.]==] },
				["Hellfire"] = { pt = [==[M20 Sorcerer, pág. 33


Hellfire


O Caminho do Fogo do Inferno (Hellfire) continua sendo um dos Caminhos mais populares da magia estática (hedge magic), apesar de existir uma certa má reputação associada a ele. Para a maioria das pessoas, o fascínio de lançar poder elemental por aí e destruir seus inimigos supera a crença de que ele possa de alguma forma estar contaminado pelo mal, se não for francamente infernal. Apesar desses sentimentos, muitos magos estáticos (hedge magicians) se especializam nos efeitos pirotécnicos que este Caminho torna disponíveis para eles, sendo um dos Caminhos mais dramáticos da magia estática.

Mesmo os estudantes iniciantes de Fogo do Inferno muitas vezes recebem respeito, e não pouco medo, de seus companheiros. Eles aprendem cedo que podem invocar relâmpagos e fogo, causar terremotos e afogar seus inimigos, se assim escolherem, mesmo que não saibam pessoalmente como. Aos aprendizes também é dado um aviso essencial: eles não são imunes aos seus próprios poderes. Essa vulnerabilidade não se limita às tentativas de magia que resultam em desastre (veja o Preço do Fracasso abaixo). Os praticantes devem ter cuidado para não estarem dentro das áreas que visam, e o fogo, uma vez desencadeado, pode ser difícil de controlar.

Sistema

Aspectos: Dano, Alcance, Área, e os seguintes Efeitos Especiais podem ser adicionados:

• Decadência (Decay): Em vez de causar dano a alvos vivos, a magia decompõe qualquer coisa que eles estejam vestindo ou carregando. Para cada ponto de dano que ela causaria, pode transformar três libras de material em lixo.
• Tempestade de Poeira (Dust Storm): A magia invoca uma tempestade de poeira, varrendo a área (que deve ter pelo menos três pontos) e, além do dano, causando cegueira na área por um turno por nível de Vitalidade infligido.
• Água-Neve (Sleet): Um jato de gelo e água congelante causa cegueira breve e deixa o chão escorregadio. Isto não pode ser tornado agravado.
• Fumaça (Smoke): O conjurador emite uma nuvem de fumaça venenosa que envolve a área (que deve ter pelo menos três pontos no Aspecto Área). Todos dentro da nuvem sofrem um nível de dano por turno, a menos que estejam protegidos. Uma máscara de gás normal fornece dois turnos de proteção antes de se tornar inútil. Seres que não precisam respirar são imunes a esse dano. A visão, mesmo que aprimorada, fica completamente obscurecida enquanto se está dentro da nuvem.
•• Terremoto (Earthquake): a magia faz o chão se abrir e engolir, e então esmagar, o alvo. Ele pode rolar Força com dificuldade 6 para tentar cavar e se libertar. Precisa de tantos sucessos quantos os níveis de Vitalidade de dano que sofreu. Isto não pode ser tornado agravado.
•• Relâmpago (Lightning): Em vez de fogo, a magia dispara um raio de eletricidade. Qualquer um em contato com o alvo através de um material condutor sofre o mesmo dano que o alvo.
•• Emaranhado de Madeira (Tanglewood): As plantas se agitam e atacam o alvo, lançando espinhos, lascas e outros pedaços de madeira contra ele. Com sorte extrema (pelo menos três sucessos além do exigido pela magia), isto pode empalar um vampiro, mas um mago que conte com isso provavelmente ficará muito decepcionado. Se o alvo estiver em vegetação densa, ele é capturado pelas plantas. Uma criatura contida dessa forma não pode se mover até acumular tantos sucessos em um teste de Força (dificuldade 7) quanto o dano causado pela magia. Isto não pode ser tornado agravado.
•••• Maré Afogadora (Drowning Tide): Isto requer uma piscina de tamanho olímpico ou um corpo de água maior. O alvo é puxado para debaixo da água por uma onda súbita ou por uma correnteza, fazendo com que comece a se afogar (veja M20 página 440-441). Escapar da água requer um teste estendido de Força, dificuldade 8, com pelo menos dois sucessos necessários, muitas vezes mais. Isto causa apenas dano por afogamento.

Os Efeitos Especiais acima devem ser comprados com Pontos de Bônus (Freebie) ou Pontos de Experiência, a um custo igual ao valor em pontos + 1.

Preço do Fracasso: Quando você brinca com fogo, às vezes se queima. Obter um desastre ao usar o Caminho do Fogo do Inferno normalmente resulta na magia ricocheteando no conjurador. Ele sofre qualquer dano que estivesse tentando infligir ao seu alvo.]==] },
				["Illusion"] = { pt = [==[M20 Sorcerer, pág. 35


Illusion


Uma das magias mais fundamentais é o poder de enganar os outros para que acreditem no que o mago quer. O Caminho da Ilusão confunde os sentidos, fazendo com que seus alvos percebam coisas que não estão lá ou alterando a percepção deles do que está lá. A maioria das pessoas confia em seus sentidos. “Ver é crer”, mas quando um ilusionista está por perto, esse velho ditado pode matar você.

O Caminho da Ilusão é muito menos direto na maioria de suas aplicações do que alguns dos outros Caminhos. Os ilusionistas tendem a ser manipuladores astutos, ao menos para escolher exatamente a visão falsa certa para qualquer tarefa que deva ser cumprida. Isso muitas vezes exige padrões estranhos de pensamento e raciocínio lateral, levando os ilusionistas a se tornarem excêntricos com o tempo.

Quando alguém é alvo do Caminho da Ilusão, evitar o engano é sempre uma possibilidade. Um teste de Percepção + Prontidão com dificuldade (4 + Aspecto Realismo) para magias, e dificuldade (4 + Nível) para rituais revela as leves imperfeições na ilusão. Isto requer um sucesso para cada sentido coberto pela ilusão, embora nos casos em que um sentido essencial, conforme determinado pelo Narrador, seja deixado de fora, o número de sucessos exigido possa diminuir. Qualquer um que consiga esse teste pode perceber que o que está percebendo não é real, embora perceba tanto isso quanto a verdade. Se alertar os outros sobre esse fato, eles podem rolar novamente uma vez.

Sistema

Modificadores: –1 a –3 de dificuldade se usar uma base semelhante ao objetivo (fazer uma mesa parecer diferente é mais fácil do que fazer uma mesa aparecer do nada)

Aspectos: Duração, Número de Alvos, e o seguinte:

Sentidos

• Afeta um sentido
•• Afeta dois sentidos
••• Afeta três sentidos
•••• Afeta quatro sentidos
••••• Amplitude sensorial completa

Realismo

• Completamente imóvel e fixa; se visual, plana
•• Muda com a perspectiva, de modo que o movimento do observador não a desfaz imediatamente
••• As ilusões podem ter partes móveis, mas somente grandes
•••• Movimentos e variações menores são possíveis, mas ainda há indícios sutis
••••• Totalmente imersiva, este nível engana completamente todos os sentidos visados

Preço do Fracasso: Magos ingênuos pensam que obter um desastre em uma ilusão não deve ser grande coisa. A magia não fez nada real, então nada real deveria acontecer quando ela dá errado. Ao contrário, as percepções do conjurador são alteradas. Pior, a maioria das alterações é sutil e facilmente ignorada. Para magias maiores, porém, eventualmente haverá uma mudança substancial, provavelmente no momento mais perigoso para o conjurador ser pego de surpresa.]==] },
				["Maelstroms"] = { pt = [==[M20 Sorcerer, pág. 37


Maelstroms


Descoberto por acidente, o Caminho dos Maelstroms foi originalmente uma tentativa de redescobrir o Controle do Clima (Weather Control). Tradicionalmente chamado de “Assobio” (Whistle) (como em “assobiar para chamar uma tempestade”), os magos que o usavam buscavam conjurar intensas rajadas de vento e chuva no mundo dos vivos. Foi só no século XIX que se descobriu que essas tempestades eram roubadas das Terras das Sombras (Shadowlands).

O Maelstrom extrai a energia para criar suas tempestades de duas fontes. A primeira é a força de vontade do conjurador. Magias e rituais deste Caminho custam um ponto de Força-de-Vontade por nível, em vez do usual ponto único fixo da maioria dos Caminhos. A outra fonte de poder são as próprias Terras das Sombras, extraindo sua energia e deixando os fantasmas da área calmos ou expulsando à força os mortos da área, dependendo do tamanho da tempestade.

O instrumento mais comum para este Caminho é, de longe, a música. A maioria dos usuários diz que, a partir do momento em que o aprenderam, podiam ouvir música dentro da cabeça, e alguns acreditam que ela fica mais alta quando as tempestades das quais podem extrair são mais fortes. Para essas pessoas, sua Prontidão é limitada a 3, devido à distração da música. Outros, porém, não experimentam esse efeito e não sofrem penalidade.

Sistema

Aspectos: Área, Duração e Intensidade

Intensidade

• Trazer uma brisa e neblina do submundo para o mundo dos vivos pacifica as Terras das Sombras locais. Os fantasmas na área são acalmados. Eles se defenderão, mas fora isso não atacarão ninguém na área durante a duração, a menos que obtenham sucesso em um teste de Força-de-Vontade (dificuldade 6).
•• Uma tempestade de chuva é invocada, e ela drena tanta energia do submundo que os fantasmas ficam congelados no lugar, a menos que façam um teste de Força-de-Vontade (dificuldade 7). Eles são tornados corpóreos apenas o suficiente para que o mago possa movê-los fisicamente. Normalmente, eles removem os fantasmas de uma área onde não são bem-vindos.
••• Convocar uma tempestade de trovões em escala total faz ainda mais para silenciar as Terras das Sombras. Isso drena o poder do Esquecimento (Oblivion) da área. Os fantasmas são sedados como no primeiro nível, mas aqueles sob controle de suas Sombras têm a razão restaurada. Os resultados variam com os espectros, mas existem lendas de magos estáticos (hedge magicians) com este Caminho arrancando um espectro do Esquecimento.
•••• Tempestades poderosas no mundo dos vivos, com ventos de força de vendaval, granizo e muitos danos à propriedade, podem realmente esgotar o poder do Esquecimento nas Terras das Sombras. Espectros e outros fantasmas profundamente maliciosos que falhem em um teste de Força-de-Vontade (dificuldade 8) desaparecem dentro da barragem de vento e granizo. Nenhum mago estático sabe com certeza o que acontece com esses espíritos, mas eles nunca são vistos no local onde o poder foi evocado por um ano e um dia.
••••• Uma tempestade massiva que drena toda a energia da região correspondente das Terras das Sombras. Tanto a área quanto seu reflexo nas Terras das Sombras tornam-se completamente inabitáveis para fantasmas. Os Mortos Inquietos (Restless Dead) devem fugir da área, ou então sofrer cinco dados de dano por rodada até que o façam.

Preço do Fracasso: O controle do mago sobre essas tempestades é tênue, na melhor das hipóteses. Em uma falha, a Força-de-Vontade ainda é gasta, mas nada acontece. Desastres, porém, resultam em tempestades que saem de controle, tanto no mundo dos vivos quanto nas Terras das Sombras. Quando um mago estático perde o controle das energias deste Caminho, ele invoca um pedaço da Tempestade (Tempest). Isso faz com que os fantasmas normais fiquem desorientados e tenham dificuldade em se mover. Os espectros, por outro lado, prosperam nesse ambiente. Esses espíritos, os mais maliciosos de todos, cavalgam a Tempestade diretamente até as Terras das Sombras e têm mais facilidade para se manifestar na área pela duração que a magia teria tido.]==] },
				["Necromancy"] = { pt = [==[M20 Sorcerer, pág. 39


Necromancy


Algumas coisas deveriam permanecer enterradas. A principal delas: os mortos. Mas aqueles que seguem o Caminho da Necromancia (Necromancy) veem as coisas de um modo um pouco diferente. Assim como o Fogo do Inferno (Hellfire), a Necromancia tem a reputação de ser algo vil, praticado apenas pelos piores dos piores. Diferentemente do Fogo do Inferno, essa reputação é, ao menos em parte, merecida. Até os mais simples feitiços de Necromancia envolvem dobrar os mortos à força à vontade do mágico (magician), e os mais poderosos deles podem manipular os poderes das Terras das Sombras (Shadowlands) para afetar também os vivos.

Embora os métodos variem enormemente conforme a prática, a Necromancia sempre exige que os primeiros instrumentos do mágico incluam o pedaço preservado do cadáver de alguém de quem ele gostava, quase sempre um membro da família. Isso cria o vínculo entre o mágico e o submundo (underworld), permitindo que ele se torne um conduto para as energias da própria morte. Enquanto para mágicos místicos a criação de um instrumento desses muitas vezes parece natural, os tecnomágicos tendem a se ver com objetos únicos e macabros, como teclados com teclas feitas de osso ou chips de computador com neurônios cerebrais embutidos na circuitaria.

Usar este Caminho é difícil. Não no sentido da técnica — não é mais complexo de usar do que qualquer outro Caminho. Em vez disso, ele cobra um preço emocional do mágico. Os vivos não foram feitos para canalizar as energias da morte tão diretamente. Eles sentem o luto de seus ancestrais, de séculos atrás, talvez milênios. Esse desespero avassalador pela perda de incontáveis gerações leva a complicações, particularmente para mágicos que estão com pouca Força-de-Vontade. Por fim, essas energias causam dano ao usuário, e cada feitiço ou ritual faz o conjurador sofrer um nível de dano contundente por nível do poder sendo invocado, a menos que a descrição mencione o contrário.

Sistema

Aspectos: Duração juntamente com Vínculo com Fantasmas (Ghost Binding):

Vínculo com Fantasmas

• O conjurador pode ver, ouvir e falar com fantasmas em suas proximidades, esteja ele em qualquer um dos lados da Mortalha (Shroud).
•• O mágico agora pode aterrorizar os mortos inquietos. Enchendo-se com a energia necrótica das Terras das Sombras, os mortos podem vê-lo como vivo, mas imbuído do poder da morte. Isso resulta em –2 de dificuldade em todos os testes de Intimidação e Lábia contra os mortos.
••• O conjurador força um fantasma a assumir uma forma corpórea, quer ele pudesse fazê-lo por conta própria ou não. Pela duração, o fantasma é, para todos os efeitos, uma pessoa viva novamente, incluindo os sete níveis de Vitalidade habituais. Se morto, porém, ele não simplesmente retorna a ser um fantasma. Em vez disso, a experiência transforma o fantasma em um espectro, um fantasma consumido pelos poderes do Oblívio (Oblivion) e subserviente a eles. E esse espectro guarda rancor contra o conjurador.
•••• Qualquer fantasma pode ser convocado até o conjurador neste nível. Tudo de que o mágico precisa é o Nome Verdadeiro (True Name) do fantasma e ganhar um teste resistido de Força-de-Vontade. Se o necromante for bem-sucedido, o fantasma deve então chegar imediatamente. Tenha em mente que a maioria dos mortos não se torna fantasma, e a maioria dos fantasmas não aprecia ser convocada.
••••• Os mestres da Necromancia podem impor obediência aos mortos. Além do teste do Caminho, eles devem ganhar um teste resistido de Força-de-Vontade. Se conseguirem, podem exigir que o fantasma realize uma tarefa simples ou responda a uma pergunta simples da melhor forma que puder. Para tarefas, o Aspecto Duração cobre por quanto tempo o fantasma deve tentar realizá-la.

Preço do Fracasso: O fracasso, para a maioria dos Caminhos, simplesmente resulta em nada acontecer. Para a Necromancia, o desespero de gerações os domina, resultando em uma perturbação (derangement), geralmente depressão severa, por uma hora. Se tiverem menos de três pontos temporários de Força-de-Vontade, então a perturbação dura, em vez disso, uma semana. Desastres são verdadeiramente perigosos, com não apenas as perturbações durando mais (um mês inteiro) e a quase certeza de fantasmas muito irritados, mas o mágico corre o risco de ser arrancado de seu corpo, deixando-o aparentemente em coma enquanto sua mente passa o mês “vivendo” como um dos mortos inquietos.]==], },
				["Necronics"] = { pt = [==[M20 Sorcerer, pág. 40


Necronics


Um dos Caminhos mais novos, descoberto apenas por caçadores de fantasmas no final da década de 1990, o Caminho da Necrônica (Necronics) foi estudado primeiramente por hackers “Black Hat” que tentavam combinar seu conhecimento de eletrônica com o mundo dos mortos. Eles usam várias técnicas para manipular sua própria bioeletricidade, ou energia vital, a fim de afetar o mundo dos mortos de alguma forma. Como a energia viva é antitética às Terras das Sombras (Shadowlands), isso tende a resultar no impedimento dos esforços dos fantasmas para conduzir suas assombrações.

Sendo um Caminho novo, há muita coisa ainda não compreendida sobre a Necrônica. Quase todos os praticantes atuais usam dispositivos eletrônicos — normalmente computadores, telefones e tablets — para conjurar feitiços de Necrônica. Embora existam análogos em culturas tradicionais, esses Caminhos podem ou não ser os mesmos que a Necrônica, usando métodos de tecnologia mais baixa e mais tradicionais. Caçadores de fantasmas que investigam a Necrônica tendem a ser fascinados por essas práticas. Eles acham que estudá-las fornecerá novas técnicas que poderão aplicar para lidar com assombrações.

Além das consequências do desastre indicadas abaixo, a Necrônica guarda um outro grande perigo para o mágico (magician). Como os usuários estão manipulando sua bioeletricidade tão intensamente, tocá-los enquanto trabalham é perigoso. Até o mais leve toque de outro ser vivo desfaz o foco e o controle da bioeletricidade do mágico, fazendo com que se forme um ciclo de retroalimentação. Essa retroalimentação faz com que ele sofra um nível de dano agravado e falhe no feitiço ou ritual. O mágico precisa de atenção médica imediata para ser estabilizado e fica enfraquecido (–1 dado em todas as ações) por uma semana por nível do feitiço ou ritual interrompido.

Sistema

Aspectos: Área, Duração e Impedância (Impedance):

Impedância

• O mágico inunda o submundo local com energia elétrica, desligando todos os poderes fantasmagóricos ativos. Os fantasmas podem ignorar isso, continuando como estavam, se obtiverem sucesso em um teste de Força-de-Vontade (dificuldade 8).
•• Neste nível, em vez de apenas interromper uma assombração, o mágico pode aumentar o índice da Mortalha (Shroud). Isso custa um sucesso por grau aumentado, com o primeiro grau incluído no custo básico do feitiço (assim, além dos requisitos normais, são necessários 2 sucessos para aumentar a Mortalha de 6 para 9).
••• Lugares podem ser defendidos de assombrações pela simples técnica de enganar o fantasma para que ele assombre outro lugar. Neste grau, o mágico pode criar uma armadilha, um reino falso que o fantasma pode assombrar em vez do local real. Um fantasma pode perceber que foi enganado com um teste de Raciocínio + Enigmas (dificuldade 8) e pode escapar com outro.
•••• Neste nível, o mágico pode usar diretamente sua bioeletricidade como um ataque contra um fantasma. Ao usar este grau da Necrônica, os Aspectos Área e Duração são substituídos por Dano e Alcance.
••••• Os mestres deste Caminho são capazes de devastar uma região das Terras das Sombras e seus habitantes. Eles chamam isso de “criar um zero”, e “formatam” o espaço para um padrão predefinido. Quando bem-sucedidos, não sobra nada. Pela duração do feitiço, a região se torna inabitável para fantasmas, fazendo com que os Mortos Inquietos (Restless Dead) perdam Corpus a uma taxa de 3 por turno até que consigam escapar da área. Se não conseguirem escapar antes de esgotar seus níveis de Corpus, eles desaparecem. Os mágicos geralmente acreditam que esses fantasmas foram completamente destruídos, em vez das consequências usuais de esgotar o Corpus. Como nenhum especialista em Necrônica jamais viu um que tenha sobrevivido a ser “zerado”, este parece ser o melhor palpite.

Preço do Fracasso: Como o mágico da Necrônica usa sua própria bioeletricidade para interagir com os mortos, os desastres são particularmente arriscados. Eles não estão apenas estendendo sentidos místicos, mas sim uma parte muito real e física de si mesmos. Em um desastre, o efeito pretendido não acontece. Em vez disso, todos os fantasmas na área ganham Pathos e Angst iguais ao nível do feitiço ou ritual sendo realizado. Eles também se tornam intensamente cientes de que o mágico está tentando controlá-los ou bani-los e podem afetar o mágico diretamente com seus poderes como se ele fosse um fantasma, em vez de terem que atravessar a Mortalha ou de precisarem de poderes específicos que lhes permitam tocar os vivos.]==], },
				["Oneiromancy"] = { pt = [==[M20 Sorcerer, pág. 42


Oneiromancy


O Reino dos Sonhos é um lugar fluido que responde ao humor e à imaginação do sonhador. Algumas pessoas, particularmente aquelas com o Talento Sonho Lúcido (Lucid Dreaming) (Mage 20 p. 294), podem assumir o controle de seus próprios sonhos, tornando os pesadelos comuns controláveis, os bons sonhos experiências divertidas e outros sonhos possíveis fontes de percepção sobre si mesmas. Sem magia, porém, o maior Reino dos Sonhos permanece trancado, com cada sonhador confinado à sua própria psique.

Mágicos (magicians) que aprendem o Caminho da Oniromancia (Oneiromancy) aprendem a entrar nos sonhos dos outros. Uma vez lá, eles tentam assumir o controle, e podem colher informações ou alterar os sonhos para o benefício ou o prejuízo do sonhador. No ápice de seu poder, os oniromantes podem até reunir várias pessoas em um sonho compartilhado. Segundo a lenda, alguns podem até tornar os sonhos reais ou se tornar capazes de entrar fisicamente nos sonhos.

Sistema

Aspectos: O Caminho da Oniromancia tem dois Aspectos: Conexão Simpática (Sympathetic Connection) e Caminhada nos Sonhos (Dreamwalking)

Caminhada nos Sonhos

• A Oniromancia básica permite que o mágico toque os sonhos dos outros, vendo lampejos de imagens que poderiam ser interpretados para obter percepções sobre a natureza e a história de seu alvo.
•• O oniromante agora pode entrar nos sonhos dos outros, não apenas vê-los. Ele se torna parte do sonho, forçado a assumir um papel apropriado ao próprio sonho. Uma vez no sonho, mudanças podem ser feitas. A magnitude das mudanças determina a dificuldade de um teste adicional de Oniromancia, sendo a criação de pequenos itens dificuldade 6, mas violar o tema do sonho dificuldade 8, talvez com um Limiar (Threshold).
••• Os Caminhantes de Sonhos agora podem observar os sonhos de fora, vendo-os claramente sem serem puxados para dentro deles. Agora eles podem verdadeiramente transformar os sonhos que encontram. Com este grau, podem criar terrores que imitam o Defeito Pesadelos (Nightmares) ou acalmar um sonho até o ponto de ajudar o sonhador a recuperar um ponto adicional de Força-de-Vontade temporária.
•••• Os Envios de Sonho (Dream Sendings) se tornam disponíveis para o conjurador neste nível. Ele pode elaborar sequências oníricas específicas e detalhadas para seu alvo, que se repetem uma vez por sucesso. Se elas se repetirem mais de uma ou duas vezes por noite, o alvo pode começar a suspeitar que seus sonhos estão sendo manipulados.
••••• Os mestres da Oniromancia podem criar sonhos compartilhados, trazendo uma pessoa para o sonho por cada sucesso no teste de conjuração. O ambiente começa como uma mistura de suas influências subconscientes, mas o oniromante pode manipulá-lo ainda mais usando níveis inferiores do Caminho.

Preço do Fracasso: Obter um desastre na Oniromancia tende a ser psicologicamente prejudicial. Muitos oniromantes são lançados em um Reino de Pesadelo (Nightmare Realm), que os atormenta de forma semelhante aos Reinos de Paradoxo (Paradox Realms) (Mage 20 p. 102-103) temidos pelos magos. Na melhor das hipóteses, eles perdem o controle de qualquer sonho com o qual estejam interagindo. Claro, mesmo se tiverem sucesso, interagir com os sonhos de alguém com o Defeito Pesadelos pode ser um tipo próprio de inferno.]==], },
				["Quintessence Manipulation"] = { pt = [==[M20 Sorcerer, pág. 43


Quintessence Manipulation


Quase todos os feiticeiros concordam com um fato. Existe um fluxo de poder que alimenta suas obras. O nome desse poder assumiu uma multidão de faces e filosofias: mana, qi, gnosis, shakti, sekhem e muitos outros. Todo mago consegue descrever o fluxo de energia enquanto impõe sua vontade sobre a realidade. Correndo por eles como carga por uma linha de energia, ele pode ser sentido e, para alguns, pode ser diretamente aproveitado. Por meio de Práticas como as da geomancia e do feng shui, os magos estáticos (hedge wizards) conseguem sentir e redirecionar a energia não refinada do universo.

Em contraste, muito poucos feiticeiros consideram isto um Caminho por direito próprio. A maioria vê a Manipulação de Quintessência (Quintessence Manipulation) como um exercício padrão e um refinamento de seu ofício já definido. O estilo pessoal de cada mago já lhe informa como realizar manipulações para executar todas as suas outras magias. Varinhas direcionam a energia, padrões desenhados em caixas criam armadilhas para retê-la, enquanto facas cortam e perturbam conforme realizam todas as suas outras obras. Ainda assim, aqueles que se concentram em dominar essa habilidade fundamental por si só descobrem que seu trabalho nunca fica sem uma fonte da qual extrair, e que seus arredores místicos raramente são um mistério.

Sistema

Modificadores: –1 a –3 de dificuldade com base em distrações na área ao redor, com –1 representando um sistema de som alto tocando na mesma sala e –3 representando a Time Square à meia-noite no Ano Novo.

Aspectos: Área e Duração, bem como o Fluxo (Flow) listado abaixo:

Fluxo (Flow)

• Sentir os Arredores (Sense Surroundings): Sentir as energias da área torna-se uma tarefa rotineira. Com um momento de meditação ou invocação, um feiticeiro determina se uma área ou item está carregado de poder (seja Quintessência, sangue de vampiro, Gnosis ou outra fonte mística). Com três sucessos, o feiticeiro identifica a Ressonância dessa energia.

•• Percepção Focada (Focused Awareness): A capacidade de sentir o fluxo e o refluxo da energia transcende os arredores locais e o inanimado e cruza para o domínio dos indivíduos. Agora o feiticeiro pode perceber outro indivíduo usando magias sutis e isso lhe permite ver meridianos obstruídos ou fluxos de energia ocluídos. Isso revela maldições deixadas sobre indivíduos ou fluxo de Quintessência bloqueado através do corpo, imposto por perturbações maliciosas. A capacidade de avaliar o potencial mágico em um sujeito também se torna disponível. Embora especialmente útil para identificar ameaças em potencial, a quantidade de informação obtida dessa maneira carece de nuance detalhada para definir plenamente se o sujeito é uma criatura sobrenatural ou um humano normal com certa aptidão.

••• Perturbar (Disrupt): Não mais restrito a observar, agora o feiticeiro habilidoso pode começar a afetar a Quintessência ao seu redor. Ainda incapaz de dobrar e manipular a energia com graça, o praticante deste caminho é ao menos versado o suficiente para causar perturbações no fluxo ao seu redor. Com sua invocação ou foco, o feiticeiro pode aquietar o fluxo na área local, fazendo com que uma fonte de Quintessência se torne dormente por um tempo. Perturbar também pode significar desviar. Um fluxo de Quintessência pode ser desviado e enviado por um novo caminho de maneira muito semelhante. Alternativamente, com algum esforço um praticante pode aprisionar uma partícula de Quintessência em um objeto simples por um tempo limitado.

•••• Controlar (Control): A mera força bruta dá lugar ao controle nuançado do fluxo de Quintessência dentro de si mesmos, do mundo ao seu redor e dentro do padrão dos outros. Os fluxos de energia através de si mesmos são agora rios correntes com canais dosados e comportas que permitem ao praticante aproveitar a Quintessência em um lugar de poder. Cada sucesso em um esforço deste tipo permite ao feiticeiro canalizar um ponto de Quintessência por sucesso, até o limite do poder daquela área. A Quintessência extraída dessa forma se dissipa a menos que seja usada no próximo turno.

O fluxo de energia de um inimigo agora é um alvo viável para perturbação neste nível de compreensão. Retirar a energia da reserva de outra pessoa destrói uma Quintessência por cada sucesso rolado. Energias mais alienígenas de outras criaturas sobrenaturais ainda são acessíveis, mas fazê-lo é mais desgastante. A energia de outras criaturas sobrenaturais é perturbada em um ponto por cada dois sucessos.

O fluxo de energia através do padrão de um indivíduo é essencial para sua saúde. Um feiticeiro com esse conhecimento pode causar grande dano ou proporcionar grande ajuda, ainda que ao longo de um período prolongado, por meio de algo semelhante a uma maldição ou a uma bênção. Alterar o fluxo da energia vital de outra pessoa pode promover ou deteriorar sua saúde, mas leva muito tempo para se tornar evidente. Ela adoece com mais frequência, achando difícil combater um simples resfriado, e leva mais tempo para se recuperar de um ferimento simples. Se não for controlado, ela inevitavelmente será vítima de um carcinógeno ambiental ou de uma enfermidade que corre em seu histórico familiar. Por outro lado, beneficiar o fluxo de Quintessência em um indivíduo fará com que o receptor quase nunca fique doente por mais de um dia, recuperando-se de qualquer ferimento como se fosse um mero inconveniente e vivendo até uma idade avançada. Por meio desta função, o mago estático pode conceder Qualidades (Merits) físicas ou infligir Defeitos (Flaws) físicos, gastando 2 sucessos por ponto da Qualidade ou do Defeito.

••••• Governar (Rule): Os mestres da Manipulação de Quintessência alcançaram um nível de compreensão que põe o fluxo de energia à sua disposição, impressionando até os Despertos. Agora, a Quintessência armazenada pode ser diretamente infundida em contramagia, adicionando dados às paradas de dados (dice pools) de contramagia. Sentindo a Quintessência sendo direcionada, o feiticeiro pode interromper o fluxo de energia, impedindo que outro feiticeiro use a Quintessência que possui. Cada sucesso bloqueia um ponto de Quintessência ou Tass de potencializar um efeito.]==] },
				["Shadows"] = { pt = [==[M20 Sorcerer, pág. 45


Shadows


O poder sobre a escuridão é um clichê ao qual alguns feiticeiros não têm problema em se apegar, por deleite irônico ou por crença genuína. Não se estaria errado em supor que o Caminho das Sombras seja a origem da ideia de que forças sombrias fortalecem as artes místicas, dada a frequência com que charlatões fazem tal alegação. Independentemente de sua reputação, o Caminho carrega de fato um ar agourento e intimidador, pois molda e transforma a substância do medo instintivo — sombras e escuridão.

Os praticantes descobriram que a aplicação do Caminho das Sombras é muito mais maleável do que a de outros Caminhos. As sombras são onipresentes e, mesmo nos dias mais luminosos, destacam-se e proporcionam contraste. A disponibilidade das sombras e o potencial de ajustar a profundidade dos matizes concedem possibilidades maiores do que Caminhos menos versáteis.

Pode-se pensar que o Caminho manipula a qualidade da luz ambiente, afastando-a das áreas mais escuras para fazer as sombras parecerem mais profundas e mais ameaçadoras. Isso é patentemente falso. Seja por um implemento mágico ou por um campo de intensificação de matéria escura dos mais tecnologicamente inclinados, este Caminho manipula a própria matéria das sombras. A verdadeira natureza dessa substância é fonte de muito debate nas comunidades mágicas, com uma gama de teorias tão diversa quanto aquelas a respeito do mecanismo do Despertar. O que os praticantes de fato concordam é que a matéria-sombra (shadowstuff) pode ser usada com grande efeito de uma variedade de maneiras úteis.

Sistema

Aspectos: Os Aspectos de Área, Distância, Duração e Número de Alvos, bem como o Domínio das Sombras (Shadowgrip) listado abaixo:

Domínio das Sombras (Shadowgrip)

A severidade e a persistência das sombras controladas são aferidas pelo Domínio das Sombras de cada um. Quando um alvo tenta resistir ao Caminho das Sombras, ele faz um teste de Força-de-Vontade com uma dificuldade determinada pelo Aspecto selecionado. Qualquer sucesso encerra o efeito no turno seguinte ou após um minuto.

• Aprofundar (Deepening): Trazer as sombras mais profundamente para nossa visão pode criar uma atmosfera distrativa e intimidadora. Dentro de uma área, a iluminação geral em si pode não mudar propriamente, mas as sombras se aprofundam, e até os sons tornam-se ligeiramente sufocados nas bordas. Essas sombras também podem ser lançadas sobre outros para conferir os benefícios do Caminho, como um bônus em testes de Furtividade em condições sombrias.

•• Moldar (Shaping): Assumindo maior maestria sobre o material escuro que compõe a sombra, o feiticeiro agora imprime padrão e intenção em sua tecelagem de sombras. Após uma conjuração bem-sucedida, o feiticeiro adiciona dois dados a qualquer parada de dados (dice pool) envolvendo Intimidação ou Furtividade, bem como a qualquer teste de Lábia para ocultar sua identidade. Inversamente, as sombras podem cercar um indivíduo e lançar dúvida e confusão sobre os sentidos da vítima. Neste nível de maestria, elas são fortes o suficiente para fazer o alvo hesitar ou reconsiderar suas ações devido ao desconforto não identificável. Isso causa ao alvo uma penalidade de –1 em rolagens feitas para esquivar ou que dependam de tempo de reação rápido. Um teste de Força-de-Vontade com dificuldade 6 permite à vítima afastar as sombras de seus olhos e concentrar-se na tarefa em mãos.

••• Entrincheirar (Entrenching): Não satisfeito em meramente fortalecer as sombras, o feiticeiro agora anima a própria matéria-sombra, deixando-a mudar e agitar-se ao seu redor. Caso leve suas habilidades de aprofundamento ainda mais longe, a luz agora fenece no local visado, e a cor irá dessaturar antes das sombras. Afetar outra pessoa agora é muito mais eficaz. As sombras mudam e se distorcem em seus olhos, e sussurros inquietantes podem ser ouvidos quando a vítima se aproxima demais de uma poça de sombra acumulada. Ser assediado dessa maneira causa uma dificuldade de –1 em todos os testes. O efeito pode ser rompido com um teste de Força-de-Vontade com dificuldade 7. Por fim, o conjurador pode fazer as sombras tremularem ou tremerem, criando distrações visuais e aumentando em um a dificuldade de todos os ataques à distância feitos contra o beneficiário.

•••• Comandar (Commanding): A “disposição” da sombra para agir tornou-se pura avidez. O tormento que a matéria-sombra visita sobre os inimigos do feiticeiro é enlouquecedor e agora causa uma dificuldade de –2 em todos os testes feitos pelo alvo. Qualquer tentativa de se libertar exige um teste de Força-de-Vontade com dificuldade 8 e pode lançar alguns inimigos em frenesi ou fúria se falharem. Envolver um alvo em sombras benevolentes concede +4 em todas as paradas de dados de Intimidação e Furtividade e em qualquer parada de dados de Lábia usada para mascarar a própria identidade.

••••• Governar (Ruling): As sombras sabem quem é seu mestre e agem imediatamente com abandono ao chamado do feiticeiro. Inimigos podem ser reduzidos a um monte tagarela no chão pelas horríveis sombras maléficas. Os oponentes devem obter sucesso em um teste de Força-de-Vontade com dificuldade 9 ou serão reduzidos à inutilidade, desabando no chão. Esse teste pode ser repetido em cada um dos turnos do alvo, mas o alvo só pode agir normalmente em um turno no qual obtenha um sucesso. Se o alvo deixar a área afetada, recupera a capacidade de agir normalmente. A escuridão que engolfa aqueles que desejam permanecer invisíveis é quase impenetrável de fora e de dentro, salvo para o próprio feiticeiro, diminuindo em um a dificuldade dos testes de Furtividade. Essa escuridão carrega um peso tão palpável que pode danificar equipamentos de gravação engolfados por sua influência.]==] },
				["Shapeshifting"] = { pt = [==[M20 Sorcerer, pág. 47


Shapeshifting


Mesmo entre as magias primais, a habilidade de se transformar em um animal destaca-se como excepcional. Muitos monstros que assombram a noite têm o poder da transformação, incluindo aqueles que são verdadeiros metamorfos. Os magos estáticos (hedge magicians) que estudam o Caminho da Metamorfose (Shapeshifting) imitam certa medida desse poder, transformando primeiro partes de si mesmos e mais tarde todo o seu corpo de maneiras dramáticas.

A maioria pensa neste Caminho como transformar a si mesmo ou a outros em animais. Quando magos metamorfos optam pela sutileza, podem ser espiões notáveis. Podem fazer alterações cosméticas para parecerem uma pessoa diferente e então complementar seu disfarce com sentidos aguçados. Podem se transformar em algo mais perigoso se seu disfarce for descoberto.

O maior risco deste Caminho é que a mente humana não está equipada para mudar de forma. Toda transformação incorre em risco, mas ele é maior ao fazer uma transformação completa em uma forma animal. Então, mesmo sem um desastre, o mago precisa rolar Força-de-Vontade (dificuldade 6) para conservar sua própria mente, em vez de se perder em sua natureza animal.

Sistema

Duração: Cena

Aspectos: Nenhum dos Aspectos padrão se aplica à Metamorfose. Em vez disso, ela usa:

Escala (Scale)

• Apenas alterações cosméticas, como a cor dos olhos ou o crescimento do cabelo.

•• Alterações pequenas mas perceptíveis, como o crescimento de garras ou escamas.

••• O mago pode transformar uma única parte do corpo na de alguma outra criatura.

•••• Meia-Transformação (Half-Shift): o mago pode transformar metade de seu corpo na de um animal ou assumir uma forma a meio caminho entre humano e animal.

••••• Transformação Completa (Full Shifting): O mago pode se transformar completamente em um animal.

Sujeito (Subject)

••• O mago só pode afetar a si mesmo.

•••• O mago pode transformar outro alvo.

••••• O mago pode afetar dois sujeitos ao mesmo tempo.

Disparidade (Disparity)

••• Apenas uma única característica animal.

•••• O mago pode assumir duas transformações não relacionadas, como a cabeça de um animal e o corpo de outro.

••••• Três transformações não relacionadas são possíveis.

Preço do Fracasso: Quando um metamorfo comete um desastre, o melhor cenário consiste em uma transformação inesperada e desagradável. Ele também pode se perder em sua outra forma, tornando-se funcionalmente feral. No pior cenário, pode experimentar um descontrole violento semelhante ao Defeito Berserker/Atavismo de Estresse (Berserker/Stress Atavism Flaw) (Mage 20 p. 644).]==] },
				["Spirit-Chasing"] = { pt = [==[Sorcerer’s Companion, pág. 23


Spirit-Chasing


Praticado principalmente por Magos Estáticos Parentes (Kinfolk) e por vários outros praticantes xamânicos dispersos, este Caminho pouco conhecido pode conceder habilidades únicas àqueles que o estudam. Embora o nome deste Caminho sugira semelhança com a Conjuração (Summoning), ele tem pouca relação com Summoning/Binding/Warding de qualquer espécie. A Perseguição de Espíritos (Spirit Chasing) cria, em vez disso, um vínculo entre um místico e uma planta ou animal escolhido (ou, com permissão do Narrador, algum outro tipo de Naturae).

Os praticantes deste Caminho acreditam, como os lobisomens, que dentro de toda criatura viva repousa uma alma, espírito, animus ou conceito efêmero similar. Os Perseguidores de Espíritos tentam observar e aprender com esses seres; ao contrário do aprendizado dos Dons, porém, o animus não necessariamente firma qualquer tipo de “barganha” com o místico. Em vez disso, o praticante estuda o espírito, primeiro fazendo contato com ele, depois fazendo-lhe perguntas e imitando suas habilidades naturais que se manifestam neste mundo, e por fim pondo em prática o que aprendeu por meio de rituais Feiticeiros.

Por exemplo, um Perseguidor de Espíritos que estude ursos começaria observando ursos e seus movimentos e padrões de vida. Ele então se dedicaria a algum tipo de ritual particular de sua própria concepção, suplicando que o espírito de um urso em particular aparecesse; às vezes, esse processo leva anos de trabalho. Em seguida, o místico explicaria ao espírito que gostaria de aprender os modos dos ursos em seu habitat natural. O espírito pode exigir prova da sinceridade do místico. Mas, se concordar, o Perseguidor de Espíritos pode aprender os rudimentos de viver como um urso. Ele poderia, por exemplo, descobrir como sobreviver de carne crua, raízes, frutos, nozes ou insetos, mesmo os venenosos para humanos. Conforme sua compreensão avança, o místico também poderia aprender a focar seus sentidos como um urso, hibernar ou mesmo fazer crescer garras. Os Perseguidores de Espíritos de modo algum se restringem apenas a mamíferos ou mesmo ao mundo animal. Vários deles escolhem plantas para sua Perseguição de Espíritos. Este Caminho é único para cada praticante.

Embora, por padrão, os praticantes do Caminho só possam beneficiar a si mesmos com as habilidades que aprenderam, em níveis mais altos um Feiticeiro dedicado acaba aprendendo a conceder esses dons a outro; a mecânica funciona, nesse caso, do mesmo modo que se o alvo a tivesse conjurado. Qualquer alvo dos efeitos básicos deste Caminho deve estar disposto; isso deve ser tratado como um presente, não como um fardo.

Se um Feiticeiro desejar tomar este Caminho para mais de um tipo de Espírito, deve recomprar o Caminho, passando por todo o processo novamente desde o início.

Sistema

Teste: Manipulação + Ocultismo

Custo: Um ponto de Força de Vontade

Modificadores: –1 se você tiver os méritos Médium, Visão Espiritual ou similares. +1 se você tiver irritado Naturae relacionados.

Duração: Uma cena, salvo se o ritual ou o nível disser o contrário.

Aspectos

Efeitos

• Este nível permite que o místico aprenda a “comer” o alimento do espírito escolhido. Exige que o alimento apropriado esteja disponível (por exemplo, sol e água para plantas, ou migalhas para insetos). Ele recebe todo o valor nutricional da refeição, como se fosse o animal ou a planta.
•• Com este nível de Perseguição de Espíritos, o personagem pode estender sua percepção sensorial para igualar a do animal ou planta escolhido em um aspecto. Se o Perseguidor de Espíritos tiver vínculo com um lince, por exemplo, poderia enxergar no escuro.
••• Animais e plantas têm uma compreensão inata da autopreservação. Criaturas feridas lambem suas feridas até limpá-las, enquanto plantas usam a energia da fotossíntese para reparar folhas e raízes rasgadas. Quando o inverno se aproxima e o alimento escasseia, alguns animais e plantas caem em hibernação; despertam quando a primavera chega. Este nível concede aos Perseguidores de Espíritos o mesmo luxo; eles podem cair em um sono curativo e recuperar um Nível de Vitalidade para cada sucesso obtido em Perseguição de Espíritos. Cada nível recuperado exige quatro horas de descanso. Assim, uma pessoa que obtivesse três sucessos poderia curar três níveis de Vitalidade após 12 horas de sono.
•••• Este nível de Perseguição de Espíritos concede ao místico percepção e sabedoria aguçadas. O Narrador decide, com base nos níveis de sucesso, que tipo de informação fornecer. Por exemplo, se uma personagem escolheu o carvalho como seu espírito vinculado e obtém três sucessos, a sabedoria que lhe vem pode envolver ver como um evento de muito tempo atrás afetou o presente. A ideia é que o carvalho esteve de pé por muitos anos e viu muito. O Narrador pode usar este nível do caminho para fornecer pistas ou ganchos de trama para os personagens.
••••• Neste ponto, o Perseguidor de Espíritos pode praticar uma habilidade única escolhida de seu espírito. Um praticante vinculado a um cervo poderia correr rapidamente ou saltar uma cerca alta. Se um personagem escolheu a hera venenosa, qualquer um que o tocasse poderia desenvolver uma erupção com bolhas. Um mínimo de três sucessos é necessário para invocar este efeito; é talvez o mais perto que os Parentes podem chegar de possuir as habilidades de mudança de forma de seus parentes Garou.
•••••• O raro Perseguidor de Espíritos que alcança este ápice pode praticar outra habilidade escolhida de seu espírito, mas esta pode ser mais óbvia ou simplesmente muito mais potente. Alguém que siga um espírito de pássaro pode ser capaz de voar curtas distâncias sem asas, ou alguém que siga um tipo de trepadeira pode ser capaz de sugar a vida de outro indivíduo.

Preço do Fracasso

O problema mais provável ao falhar ou falhar criticamente neste Caminho é que os Espíritos que o Feiticeiro venera se ofendam com a tentativa desajeitada de imitar suas habilidades. Isso pode aumentar a dificuldade de conjurações seguintes até que algum tipo de chiminage seja oferecido, ou, se feito repetidamente, pode fazer com que os espíritos decidam tomar uma ação mais direta contra o Feiticeiro.]==] },
				["Starlight"] = { pt = [==[M20 Sorcerer, pág. 48


Starlight


Existem Caminhos que remontam a séculos e há outros que surgem apenas dos ambientes únicos da noite moderna. As metrópoles em expansão deram aos feiticeiros uma visão de mundo única e forneceram uma bússola para as terras além da Mortalha (Shroud). Espiar as terras dos mortos não é um conceito novo para a comunidade mágica, mas aqueles que caminham pelo vale de concreto começaram a ver um padrão nas estrelas dos céus das Terras das Sombras (Shadowlands) que correspondia às luzes de suas cidades. Por meio do estudo e da ampliação de sua compreensão, nasceu o Caminho conhecido como Luz das Estrelas (Starlight). Para grande desgosto e inveja dos habitantes das Terras das Sombras, somente aqueles dotados em Luz das Estrelas parecem capazes de ver as estrelas que utilizam.

Como os navegadores da era de ouro da navegação à vela, os praticantes de Luz das Estrelas compreendem o céu único das Terras das Sombras e traçam rotas para viajar com segurança pelo reino dos mortos. Simplesmente saber para onde estão indo é apenas o começo do poder que esses navegadores possuem. Suas mentes produzem uma espécie de escudo de proteção e preservação para quaisquer mortais que viajem com eles. Isso se torna uma necessidade para a viagem, pois as terras das sombras não têm ar e o próprio solo é um anátema para os vivos. No entanto, este não é um escudo físico contra todo tipo de dano, e qualquer espectro (wraith) violento que pretenda causar-lhes mal pode facilmente satisfazer esse impulso. Caso a duração da magia expire, aqueles que viajam ficarão expostos ao ambiente letal das Terras das Sombras.

É o conhecimento das luzes-guia dos céus das Terras das Sombras que também permite aos navegadores abrir portas diretamente para as Terras das Sombras, contornando completamente a Mortalha no processo. Qualquer porta pode levar às Terras das Sombras; basta muita preparação, e a jornada começa. Aconselha-se avançar rapidamente em direção ao destino, considerando que poucos navegadores conseguiram completar uma jornada que durasse mais de um dia.

Sistema

Modificadores: Reduza a dificuldade em –1 se estiver portando um item pessoal de alguém recentemente falecido

Aspectos: Os Aspectos de Duração, Passageiros e Percurso (Wending):

Percurso

• O limiar é o primeiro obstáculo que um navegador deve dominar. Com foco e vontade, qualquer portal pode servir como limiar para as Terras das Sombras. A porta permanece aberta apenas para o navegador e permitirá que ele e seus passageiros passem. Companheiros de viagem se beneficiam do mesmo efeito de preservação da vida que o conjurador, desde que permaneçam ao alcance da visão de seu navegador. Qualquer um que tente reabrir a porta depois de fechada encontrará o limiar mundano correspondente. Esta porta desmorona depois de ter sido reaberta e fechada novamente pelo navegador durante seu retorno das Terras das Sombras, ou desmoronada deliberadamente pelo navegador para fechar o caminho atrás de si. Uma porta diferente nas Terras das Sombras pode ser usada para reentrar nas Terras da Pele (Skinlands), mas outra ativação de Luz das Estrelas deve ser realizada para criar o novo limiar. Há uma desvantagem nesta técnica; O destino nas Terras da Pele é difícil de saber sem mais capacidades como navegador.

•• As Terras das Sombras são mais familiares para um navegador deste nível. A confiança cresce em seu peito, e o reino dos mortos parece muito menos assustador. Enquanto viaja nas Terras das Sombras, o navegador se beneficia de –1 de dificuldade em todas as rolagens de Sensitividade, Liderança, Sobrevivência e Ocultismo referentes a este ambiente, bem como em rolagens de Força-de-Vontade para superar medo e intimidação.

••• O navegador encontrou um ponto nas Terras das Sombras que é semelhante à sua própria Estrela do Norte pessoal. Não importa onde esteja nas Terras das Sombras, desde que possa ver esta estrela, o navegador tem uma compreensão geral de onde poderá sair para as Terras da Pele ao abrir um novo limiar.

•••• A familiaridade com as Terras das Sombras agora é palpável para quaisquer companheiros de viagem que o navegador tenha trazido consigo. Os companheiros de viagem do navegador se beneficiam de –1 de dificuldade em rolagens de Força-de-Vontade feitas para superar medo e intimidação, bem como em rolagens de Sensitividade e Sobrevivência feitas dentro das Terras das Sombras.

••••• A luz-guia do navegador dentro das Terras das Sombras é visível para ele mesmo com os olhos fechados. Não importa quão profundamente viaje ou quão desorientado possa ficar, o navegador sempre será capaz de encontrar seu caminho até uma porta de volta para as Terras da Pele. Além disso, ele sabe exatamente para onde levará sua saída das Terras das Sombras.]==] },
				["Summoning, Binding, and Warding"] = { pt = [==[M20 Sorcerer, pág. 49


Summoning, Binding, and Warding


Feiticeiros, tanto na ficção quanto na lenda, são bem conhecidos por sua capacidade de invocar e controlar outros, tanto vivos quanto efêmeros. Com esses poderes, o mago pode invocar animais, espíritos, fantasmas, demônios e outros seres estranhos. Ele também pode se defender desses seres, vinculá-los e obrigá-los a obedecer ao mago. Embora exista sobreposição com o Caminho do Efêmero (Ephemera), este Caminho se concentra em métodos de coerção, em vez de cooperação, com os seres sendo chamados e tratados.

Todas as magias de Invocação, Vínculo e Proteção (Summoning, Binding, and Warding) são rituais, e existem rituais para alcançar seres individuais ou classes de seres. Existem rituais separados para invocar, vincular e proteger-se de cada alvo. Isso levou muitos magos à sua ruína. Embora invocar um ser possa intrigá-lo, tentar vinculá-lo tende a provocar hostilidade, e magos que não conhecem ou falham ao conjurar o ritual de proteção frequentemente se veem em sérios apuros.

Além das complicações de cada ser específico ou tipo de ser com o qual o mago estático (hedge magician) pretende trabalhar, existem várias versões deste Caminho que são aprendidas de forma completamente separada. Existem variantes para invocar criaturas materiais (como animais e pessoas), anjos e demônios, fantasmas, espíritos da natureza e outros seres sencientes. Há até relatos de variantes voltadas para objetos inanimados e criações virtuais, permitindo que alguns magos protejam seus computadores contra vírus ou invoquem seus carros quando necessário.

Sistema

Aspectos: As três partes distintas do Caminho têm Aspectos separados. Proteção tem Duração e Força, cada nível da qual subtrai um dado de todas as ações que o ser invocado realiza contra o mago. Com três sucessos, a Força de Proteção permite a criação de um Círculo de Proteção, que o ser não pode atravessar sem uma rolagem de Força-de-Vontade (dificuldade 6) na qual obtenha mais sucessos que o mago.

Invocação tem Duração como Aspecto. Além disso, tem Número de seres invocados (ou enxames) e Peso Metafísico para o ser invocado. O ser invocado é obrigado a aparecer diante do mago, mas ainda precisa se transportar até lá. Apenas os seres mais poderosos podem realmente viajar instantaneamente.

Vínculo similarmente tem os aspectos de Duração e Peso Metafísico, bem como Intensidade do Vínculo. Um ser pode gastar um ponto de Força-de-Vontade para resistir a um vínculo, mas o vínculo pode ser reconjurado. Alguns seres, especialmente aqueles com Peso Metafísico 5, são poderosos o suficiente para exigir rituais de vínculo com grandes limiares além dos requisitos usuais — às vezes tão altos quanto 20 ou mais sucessos.

Intensidade do Vínculo

• A criatura não pode agir diretamente contra o mago.

•• Qualquer pergunta isolada deve ser respondida com sinceridade.

••• Todas as perguntas durante a duração devem ser respondidas com sinceridade, e o ser pode ser obrigado a realizar um serviço, embora possa interpretar a ordem liberalmente desde que a satisfaça literalmente.

•••• Uma única tarefa é realizada conforme instruído, seguindo as ordens de perto.

••••• O mago pode transferir controle limitado do vínculo para outra pessoa. O ser realiza uma tarefa para ela e responde a quaisquer perguntas que o invocador lhe faça.

Preço do Fracasso: O Caminho de Invocação, Vínculo e Proteção não precisa de custos especiais de falha ou desastre. Em vez disso, as consequências das falhas e desastres são infligidas ao mago pelo ser invocado. A maior fonte desses problemas é que, em um desastre, o mago frequentemente acaba sob a impressão equivocada de que teve sucesso.]==] },
				["Via Geniorum"] = { pt = [==[The Hunters Hunted II, pág. 125


Via Geniorum


A Via Geniorum é uma das Vias de que os críticos da Teurgia mais desconfiam; os Teurgistas que praticam esta Via lidam com o reino dos espíritos e do demoníaco. Eles argumentam que todas as criaturas estão em última instância sob o chamado do céu, incluindo espíritos e demônios. Esses Teurgistas acreditam que há todo um espectro de Espíritos que não se aliaram nem ao Céu nem ao Inferno, e que ainda assim podem ser comandados pelo poder do Céu. Esta Via concede ao praticante poder sobre entidades espirituais não humanas (demônios, elementais, etc.).

O conhecimento do nome verdadeiro de um espírito concede poder sobre ele. Um nome verdadeiro não é o título pelo qual o espírito comumente atende, mas uma invocação mais complexa e primordial. O mundo se distorce e vibra quando nomes verdadeiros são pronunciados. São segredos zelosamente guardados, que exigem testes estendidos de pesquisa, Inteligência + Ocultismo (dificuldade 9), e uma boa biblioteca ocultista para decifrar. Cada sucesso concede uma “sílaba” do nome. O mais simples dos espíritos pode ter um nome verdadeiro de uma única sílaba, mas demônios mais poderosos terão muitas mais (a critério do Narrador). Um Teurgista pode tentar enganar um espírito para que divulgue seu nome verdadeiro. As sílabas de nomes verdadeiros são frequentemente uma forma de moeda entre espíritos e ocultistas, que tendem a acumulá-las.

Sistema

Teste: Varia (veja abaixo)

Modificadores: –2 de dificuldade se o Teurgista souber o nome verdadeiro do espírito

Custo: 1 ponto de Força de Vontade

Duração: Varia (veja abaixo)

Níveis da Via Geniorum

• Ritual da Revelação (Ritual of Revelation): O Teurgista não tanto espia o mundo espiritual quanto ordena que os seres supernos próximos se revelem. Com um teste bem-sucedido de Carisma + Ocultismo (dificuldade 8), o Teurgista pode ver todos os espíritos na área imediata (inclusive os que possuem corpos físicos).
•• Ritual da Proteção (Ritual of Protection): Com um teste bem-sucedido de Raciocínio + Ocultismo (dificuldade 7), o Teurgista pode desenhar sigilos protetores em objetos de mão ou em um pequeno círculo ao seu redor. Testes rituais estendidos podem fazer círculos maiores ou locais mais completamente protegidos, sendo 10 sucessos o bastante para proteger uma casa pequena. Espíritos não podem molestar nem entrar em uma pessoa ou local assim protegido sem obter sucesso em um teste de Força de Vontade (dificuldade 9). A proteção dura um mês ou até que o sigilo seja perturbado (um sigilo entalhado é muito mais difícil de romper que um desenhado a giz).
••• Ritual da Dispensa (Ritual of Dismissal): O Teurgista pode mandar um espírito de volta ao seu reino natal. Esta via exige um teste de Carisma + Ocultismo (dificuldade 9). O número de sucessos necessários, em um ritual estendido, varia amplamente conforme o poder do espírito (e fica a critério do Narrador).
•••• Ritual da Invocação (Ritual of Summoning): O Teurgista pode agora invocar entidades espirituais. Esta via exige um teste de Carisma + Ocultismo (dificuldade 9). O número de sucessos necessários, em um ritual estendido, varia amplamente conforme o poder do espírito (e fica a critério do Narrador). Um espírito invocado deve permanecer na presença do Teurgista por uma cena ou até ter respondido a três perguntas (não se pode forçá-lo a revelar seu nome verdadeiro dessa maneira). Interações posteriores dependem de testes Sociais, sacrifícios ou outros poderes. Uma falha crítica invoca um espírito enfurecido que provavelmente ataca o azarado Teurgista.
••••• Ritual do Vínculo (Ritual of Binding): O Teurgista pode agora forçar um espírito à servidão. Esta via exige um teste de Manipulação + Ocultismo (dificuldade 9). O número de sucessos necessários, em um ritual estendido, varia amplamente conforme o poder do espírito (e fica a critério do Narrador). A um espírito vinculado pode-se pedir uma ação específica (“Ataque aquele vampiro!”) ou uma ação contínua (“Vigie-me.”) que dura até o próximo nascer ou pôr do sol.]==] },
				["Via Necromantiae"] = { pt = [==[The Hunters Hunted II, pág. 126


Via Necromantiae


A Via Necromantiae é a Teurgia concebida para contatar ou banir os mortos. Esta Via lembra em partes as da Via Geniorum, mas é, ainda assim, distinta.

Sistema

Teste: Varia (veja abaixo)

Modificadores: –1 de dificuldade se o Teurgista tiver um objeto que foi importante para o fantasma em vida

Custo: 1 ponto de Força de Vontade

Duração: Varia (veja abaixo)

Níveis da Via Necromantiae

• Ritual do Despertar (Ritual of Wakening): O Teurgista pode ordenar que um cadáver recentemente falecido desperte. Com um teste bem-sucedido de Carisma + Ocultismo (dificuldade 7), o corpo se sentará e responderá às perguntas do Teurgista, o melhor que puder, por um minuto por sucesso. Cada vinte e quatro horas que o cadáver esteja morto soma um à dificuldade. Um cadáver morto há mais de três dias não pode ser despertado.
•• Ritual da Proteção (Ritual of Warding): Os Teurgistas podem proteger uma área contra intrusão fantasmagórica. Com um teste bem-sucedido de Raciocínio + Ocultismo (dificuldade 7), o Teurgista pode impedir que fantasmas entrem em uma área do tamanho de um cômodo. Cada sucesso indica uma semana de proteção bem-sucedida.
••• Ritual da Comunicação (Ritual of Communication): Os Teurgistas podem contatar os mortos fazendo um teste de Carisma + Ocultismo (dificuldade 10). Essa dificuldade cai, cumulativamente, se algum dos seguintes critérios for atendido: o Teurgista possui um objeto que foi importante para o fantasma em vida (–1), uma pessoa importante para o fantasma está presente (–1), o ritual é conduzido na antiga casa do fantasma (–1), o ritual é conduzido em um lugar onde o véu entre o Submundo e o mundo dos vivos é tênue (–2). Manter contato com os mortos é difícil. Cada sucesso obtido permite ao Teurgista um minuto de comunicação. O período de tempo pode ser dobrado por mais um ponto de Força de Vontade.
•••• Ritual da Expulsão (Ritual of Expulsion): Os Teurgistas podem expulsar um fantasma que assombra. Isso exige um teste de Carisma + Ocultismo (dificuldade igual à Força de Vontade do fantasma + 3, máximo de 9); é um teste sustentado, que requer um número de sucessos igual ao dobro da Força de Vontade do fantasma. Simplesmente iniciar o banimento custa 1 ponto de Força de Vontade, mas nenhum ponto adicional é exigido pelo restante da luta.
••••• Ritual da Vivificação (Ritual of Vivification): O Teurgista pode agora instar um cadáver a erguer-se. Esta via exige um teste de Manipulação + Ocultismo (dificuldade 8). Cada sucesso anima o corpo por uma semana, e esse tempo pode ser dobrado por mais um ponto de Força de Vontade. Cadáveres animados não terão muita personalidade ou inteligência, mas podem seguir instruções simples.]==] },
				["Weather Control"] = { pt = [==[M20 Sorcerer, pág. 50


Weather Control


Em sociedades que dependiam fortemente da agricultura ou da navegação marítima, aqueles que podiam controlar o clima eram valorizados, muitas vezes sendo a diferença entre a vida e a morte em suas comunidades. Fomes foram evitadas ou encerradas, e os feiticeiros mais poderosos são conhecidos por dissipar ou desviar desastres naturais.

O controle do clima permite que os feiticeiros façam o que está escrito na embalagem — eles podem controlar o clima. Embora não possam causar diretamente mudanças climáticas enormes, como El Niños, o que eles podem afetar cria ondas de efeito por áreas maiores. Nenhum padrão climático acontece no vácuo, e isso permanece verdadeiro para a manipulação mágica do clima. Muitos trabalhadores do clima (weather workers) têm alguns pontos em Ciência, para dar conta de serem capazes de discernir padrões climáticos futuros. Muitos trabalhadores do clima também aprendem pelo menos uma pequena quantidade de Divinação (Divination) para esse propósito, frequentemente praticando vidência em poças de água e nuvens como suas práticas para tal.

Embora raramente consultados na era moderna, os trabalhadores do clima ainda praticam em segredo. O poder que comandam é dramático e potencialmente capaz de alterar vidas. Como os curandeiros, os trabalhadores do clima seriam constantemente importunados para realizar milagres se suas habilidades fossem amplamente conhecidas. Ao mesmo tempo, teriam de lidar com aqueles que, por medo e inveja, alegariam que os trabalhadores do clima obtiveram seus poderes por meios malignos.

Os trabalhadores do clima raramente funcionam sozinhos. A quantidade de esforço necessária para produzir efeitos adequados muitas vezes exige trabalho em equipe. Alguns formam covens em torno do objetivo do controle do clima em grupo.

Sistema

Modificadores: O controle do clima não usa rituais. O grande número de sucessos necessários para produzir efeitos favorece testes prolongados e trabalho em equipe.

• 1 ou mais sucessos adicionais necessários para deter uma tempestade severa ou algo pior depois que ela já começou. É mais fácil provocar clima calmo do que apaziguar clima ruim.

• +1 de dificuldade para causar qualquer efeito em ambientes internos.

Aspectos: O Controle do Clima usa os Aspectos Distância (trate a medida na tabela como o raio de efeito), Duração e Intensidade:

Intensidade

• Apenas pequenas mudanças. Isso inclui brisas quentes ou frias, mudanças leves mas perceptíveis na temperatura e fazer o fogo bruxulear e flamejar momentaneamente.

•• O trabalhador do clima pode causar efeitos menores que não causam dano direto. O feiticeiro pode invocar uma névoa densa que impõe penalidades de percepção (veja Mage 20 p. 435), limpar um céu nublado ou criar ventos na direção que desejar.

••• Um feiticeiro pode formar e dissipar tempestades de chuva simples. Ventos fortes podem impor uma penalidade a ataques à distância, desviando o projétil de seu curso e causando dificuldades para mirar. O trabalhador do clima também pode alterar a temperatura em até 30 graus Fahrenheit em qualquer direção. Dependendo da temperatura inicial, isso pode impor ou remover penalidades de doenças causadas pelo calor ou de hipotermia. Enchentes repentinas também podem ser mortais.

•••• A força da tempestade de um trabalhador do clima aumenta. Ele agora pode comandar ventos de força de vendaval, relâmpagos, granizo e outros efeitos climáticos danosos. Agora pode escolher indivíduos como alvo para receber o impacto da tempestade, e os efeitos danosos causam 4 + sucessos de dano. Relâmpagos causam dano letal, enquanto o dano contundente resulta do granizo. Outros efeitos também podem causar dano, dentro do razoável. Efeitos climáticos podem causar penalidades moderadas àqueles apanhados nas tempestades.

••••• O feiticeiro pode causar efeitos extremos. Tempestades com trovões estão bem ao alcance do trabalhador do clima. Tornados destrutivos e outras atividades meteorológicas poderosas podem rasgar uma cidade. O feiticeiro pode causar 6 + sucessos contundente ou letal a cada 15 minutos àqueles no caminho da tempestade. Qualquer um apanhado na tempestade também sofre penalidades ambientais máximas.

Preço do Fracasso: Até mesmo efeitos intencionais de controle do clima podem ter consequências indesejadas no ambiente, tanto próximo quanto distante. Perturbações em padrões climáticos não são assunto pequeno. Um desastre, porém, desencadeia efeitos terríveis dependendo da natureza das mudanças buscadas. Relâmpagos podem atingir diretamente o feiticeiro ou seus aliados. Um clima árido pode ser atingido por uma monção que o solo não consegue acomodar, levando a inundações generalizadas. O clima local e possivelmente a área circundante sofrem mudanças dramáticas, talvez duradouras. Isso pode causar uma crise para a fauna local, a vida vegetal e as pessoas que não tiveram tempo de se preparar e podem não saber como lidar com o novo clima. A morte, mesmo que não imediata, é infelizmente um risco comum quando feiticeiros brincam com o clima.]==] },
				["Animal Psychics"] = { pt = [==[M20 Sorcerer, pág. 54


Animal Psychics


Algumas pessoas são naturalmente boas com animais, e alguns psíquicos o são de forma sobrenatural. Esta habilidade permite que um psíquico exerça sua vontade para se comunicar com e controlar animais. Mesmo a expressão mais baixa deste Fenômeno permite que um psíquico tranquilize um animal ao superar a lacuna de comunicação, tornando-o mais inclinado a responder positivamente ao psíquico.

Um psíquico pode falar com e comandar um animal por um método de sua escolha. Exemplos incluem travar contato visual em silêncio, imitar os ruídos que os animais fazem, gestos de adestramento, o idioma nativo do psíquico, ou um fluxo de balbucios. O método importa muito menos do que a intenção e a força de vontade do psíquico. Mesmo em seus níveis mais altos, este fenômeno não afeta insetos nem qualquer criatura, como as águas-vivas, que não possua cérebro.

• Commune (Comunhão): Um psíquico pode se comunicar com um animal que o psíquico consiga perceber por meio de sentidos mundanos (visão, audição, etc). Ele pode dar comandos simples, mas não pode ordenar que um animal ataque. O psíquico pode, no entanto, ordenar que um animal desista de um ataque pretendido. Dar um comando que o animal já estava inclinado a cumprir não exige nenhum teste adicional, mas ordenar que um animal faça algo contra sua natureza exige um teste de Carisma + Empatia com Animais com dificuldade 9 menos os pontos de Animal Psychics (Psíquicos de Animais) do psíquico.

•• Mass Communication (Comunicação em Massa): Como em Commune, mas o Psíquico agora pode se comunicar com múltiplos animais da mesma espécie de uma só vez. Comandos dados a animais podem ser mais complexos, desde que o psíquico consiga descrevê-los adequadamente; entretanto, animais normalmente não atacam pelo psíquico a menos que já estejam inclinados a fazê-lo. Este nível pode, alternativamente, ter como alvo um único animal para capacidade de comando ampliada.

••• Mind Link (Vínculo Mental): Um psíquico pode vincular mentes com um único animal para comunicação instantânea de mão dupla e a capacidade de sentir o que o animal sente. O psíquico deve inicialmente sentir o animal como em Commune, mas o animal pode viajar para fora do alcance de percepção do psíquico sem romper o vínculo. Este poder termina quando o psíquico rompe o vínculo. O vínculo pode se mostrar perigoso — qualquer dano que o animal vinculado sofra resulta em um contragolpe psíquico, que causa uma quantidade igual de dano contundente absorvível ao psíquico. Se o animal morrer enquanto o vínculo estiver ativo, o psíquico deve não apenas testar para absorver o dano, mas também testar sua Força-de-Vontade atual com dificuldade 8. Uma falha deixa o psíquico atordoado por 1 rodada. Desastres podem deixar o psíquico dominado pelo trauma da morte por uma cena e ter consequências duradouras, como reações de sobressalto intensificadas, até que o psíquico recupere um ponto de Força-de-Vontade.

•••• Domination (Dominação): Um psíquico pode ordenar que qualquer animal isolado faça qualquer coisa dentro das capacidades naturais do animal. O animal luta e morre pelo psíquico quando exigido, sem questionar. O psíquico deve descrever um comando adequadamente para que o animal entenda o que o psíquico quer. Comandos complexos ainda podem confundir um animal, embora o animal faça o melhor que pode para interpretar e executar qualquer comando que o psíquico lhe dê. Uma vez que o psíquico ative este poder com sucesso, o animal segue as ordens do psíquico até que o psíquico rompa a conexão ou o animal morra. Psíquicos que usam este poder também devem estabelecer um Mind Link se desejarem continuar dando comandos ao animal à distância. Isso não exige testes adicionais nem gasto de Força-de-Vontade, mas expõe o psíquico a sofrer dano quando o animal for ferido ou morto, conforme detalhado acima.

••••• Swarm (Enxame): Com o domínio deste Fenômeno, um psíquico agora pode usar qualquer habilidade inferior em todos os animais que o psíquico consiga sentir por meio de sentidos mundanos de uma só vez. O controle do psíquico não está mais limitado a uma espécie por vez. Usar Mind Link desta forma pode rapidamente se tornar perigoso, pois cada animal vinculado representa um risco de dano por contragolpe se for ferido. A distração de manter múltiplos vínculos mentais é avassaladora, infligindo uma penalidade de -3 dados a todos os testes baseados em Atributos até que o Mind Link termine, a menos que o psíquico gaste um ponto de Força-de-Vontade ao fazer o teste para temporariamente superar a distração.]==], },
				["Anti-Psychic"] = { pt = [==[M20 Sorcerer, pág. 55


Anti-Psychic


Anti-Psychic é o fenômeno psíquico mais raro. Dito isso, é muito sutil. Muitos Anti-Psychics (Antipsíquicos) atravessam a vida sem saber de sua habilidade. Muitas vezes é preciso um ataque de, ou outro desentendimento grave com, outro psíquico antes que o Anti-Psychic descubra seu dom.

Os Fenômenos de Anti-Psychic embaralham as habilidades de outros psíquicos com estática mental. Aqueles de paradigma científico teorizam que as emanações de Anti-Psychic usam uma base de funcionamento semelhante à da Telepathy (Telepatia). Em vez de projetar um sinal que o cérebro do receptor possa decodificar como mensagem, imagem ou impressão, a teoria é que o Anti-Psychic projeta um sinal que interfere nas ondas cerebrais responsáveis pelos fenômenos psíquicos. Devido à natureza deste Fenômeno, é impossível que um Anti-Psychic desenvolva qualquer outro fenômeno psíquico. Ele é, entretanto, capaz de aprender outros Numina.

Um Anti-Psychic perturba todos os outros fenômenos psíquicos dentro de seu alcance de efeito e desfruta de um efeito limitado sobre aqueles que usam a Esfera da Mente (Mind Sphere). Em níveis mais altos, o Anti-Psychic pode até perturbar Disciplinas vampíricas e dons Garou. Este Fenômeno permanece perpetuamente ativo, mesmo enquanto o Anti Psychic dorme, a menos que o psíquico gaste um ponto de Força-de-Vontade para suprimir completamente o fenômeno por um turno ou direcioná-lo a um único indivíduo. Ao usar Anti-Psychic contra efeitos da Esfera da Mente ou contra o Povo-da-Noite (Night-Folk), o psíquico não tem sucesso automaticamente, mas testa reflexivamente a ativação com dificuldade 7 ou o Arete do mago, o que for mais alto. Com um sucesso, aplicam-se os efeitos dos níveis do Anti-Psychic na habilidade. Para mais informações sobre como contrapor poderes do Povo-da-Noite, veja Mage: The Ascension 20th Anniversary Edition página 546.

A raridade deste Fenômeno representa uma bênção ambígua. Embora muitos não previssem a habilidade, o que confere um elemento de surpresa, a novidade pode fazer do Anti-Psychic um espécime tentador para entidades sobrenaturais de inclinação científica. Rumores sussurrados sugerem que a União Tecnocrata usa Anti-Psychics de seus Cidadãos Extraordinários para reforçar incursões contra psíquicos conhecidos ou suspeitos.

• Raio de 5 jardas. Adicione +1 de dificuldade à ativação de fenômenos psíquicos dentro do raio e +1 de dificuldade aos testes da Esfera da Mente.

•• Raio de 10 jardas. Adicione +2 de dificuldade à ativação de fenômenos psíquicos dentro do raio e +1 de dificuldade aos testes da Esfera da Mente.

••• Raio de 15 jardas. Adicione +3 de dificuldade à ativação de fenômenos psíquicos dentro do raio e +2 de dificuldade aos testes da Esfera da Mente. Adicione +1 de dificuldade para o uso de quaisquer poderes de base mental do Povo-da-Noite.

•••• Raio de 25 jardas. Adicione +4 de dificuldade à ativação de fenômenos psíquicos dentro do raio e +2 de dificuldade aos testes da Esfera da Mente. Adicione +2 de dificuldade para o uso de quaisquer poderes de base mental do Povo-da-Noite.

••••• Raio de 40 jardas. Adicione +5 de dificuldade à ativação de fenômenos psíquicos dentro do raio e +3 de dificuldade aos testes da Esfera da Mente. Adicione +3 de dificuldade para o uso de quaisquer poderes de base mental do Povo-da-Noite.]==], },
				["Astral Projection"] = { pt = [==[M20 Sorcerer, pág. 56


Astral Projection


Astral Projection permite que o psíquico separe seu espírito, mente ou consciência — ou uma combinação destes, dependendo da crença — de seu corpo. A forma astral é intangível e pode cobrir vastas distâncias em pouco tempo, pois não está sujeita às leis normais da física. Viajantes astrais podem espiar e até visitar os reinos de ideias da Umbra Astral (veja Mage 20 p. 94). O psíquico que usa Astral Projection não pode afetar o mundo físico por meios normais, embora possa fazê-lo por meio de outros fenômenos psíquicos com +2 de dificuldade. Um desastre na ativação de Astral Projection causa um contragolpe psíquico desorientador, impedindo o psíquico de deixar seu corpo por 24 horas.

O corpo de um psíquico permanece vulnerável enquanto ele está usando projeção astral, e o psíquico não pode sentir o que está acontecendo com ele. É um medo comum entre os psíquicos com esta habilidade que alguém possa mover ou ferir seus corpos enquanto estão ausentes. Muitos tendem a limitar seu uso de drogas e álcool, porque lapsos de memória podem desencadear o mesmo medo.

Psíquicos podem interagir com espíritos astrais — habitantes da Umbra Astral e outros indivíduos em viagem astral. Astral Projection não confere a capacidade de ver e interagir com fantasmas. Para combate durante a viagem astral, substitua Destreza por Raciocínio, Força por Inteligência e Vigor por Percepção. Viajantes astrais normalmente aparecem como versões ligeiramente idealizadas de si mesmos, incluindo manifestações de gênero ou de expressão estilística, livres de limitações físicas ou sociais sobre tais expressões. Alternativamente, aqueles com autoimagem excessivamente ruim às vezes aparecem com defeitos percebidos exagerados. Apesar de possíveis diferenças em relação à aparência física, viajantes astrais normalmente conseguem reconhecer uns aos outros caso se encontrem novamente no plano físico.

A maioria dos psíquicos só consegue acessar a Penumbra Astral, mas os mais poderosos afirmaram ser capazes de viajar mais longe. Viajar para os Outros Mundos (Otherworlds) é um negócio arriscado, e mais do que um punhado de psíquicos saíram explorando para nunca mais encontrar seus corpos. Alguns acreditam que deixar o corpo desabitado por tempo demais corre o risco de permitir a entrada de outra coisa.

• Peek (Espiada): O psíquico pode passar até um minuto por ponto de Vigor em projeção astral e viajar até uma milha de distância de seu corpo. Um psíquico só pode usar a visão neste nível — seus outros sentidos não funcionam durante a projeção. Um personagem também pode viajar para a Penumbra Astral por esse mesmo período de tempo.

•• Errand (Incumbência): O psíquico ganha a capacidade de ouvir durante a viagem astral. Ele pode viajar até 100 milhas de distância de seu corpo com um limite de 10 minutos por ponto de Vigor.

••• Journey (Jornada): O psíquico pode viajar até 1000 milhas de distância de seu corpo e pode permanecer em forma astral por 30 minutos por ponto de Vigor. Um psíquico pode escolher se manifestar como uma imagem borrada e fantasmagórica de sua forma astral por um turno gastando um ponto de Força-de-Vontade, mas não pode falar. Ele não aparece em gravações.

•••• Failsafe (Salvaguarda): Ao ser atordoado ou nocauteado, o psíquico pode testar a ativação de Astral Projection como uma ação reflexiva. O psíquico pode usar este poder para buscar ajuda para seu corpo prostrado, ou simplesmente como uma forma de permanecer útil enquanto estiver fora de combate. O psíquico pode se manifestar como em Journey e, enquanto manifestado, o psíquico pode se comunicar em volume de sussurro. A voz e a forma translúcida do psíquico não aparecem em gravações. O psíquico pode viajar para qualquer lugar da Terra e permanecer projetado por até uma hora por ponto de Vigor que possua, embora possa gastar um ponto de Força-de-Vontade a cada hora que desejar continuar viajando além desse limite. Ele pode usar todos os sentidos normalmente. Embora o psíquico possa retornar ao seu corpo a qualquer momento antes de seu limite normal terminar, retornar não o despertará a menos que a causa da inconsciência tenha sido resolvida.

••••• Odyssey (Odisseia): As capacidades de viagem astral do psíquico são lendárias. O psíquico pode viajar para qualquer lugar sobre ou dentro da Terra, estendendo-se ao menos até a borda da atmosfera. Tentar ir mais longe exige um teste de Força-de-Vontade com dificuldade 9. Enquanto o corpo do psíquico viver, incluindo com auxílio de tecnologia de suporte à vida, o psíquico pode viajar indefinidamente. Se manifestado, o psíquico pode falar em volume normal e pode escolher aparecer em uma forma indistinta e translúcida ou enganosamente opaca, e pode permanecer manifestado por até uma hora por ponto de Força-de-Vontade gasto. O psíquico pode escolher aparecer em gravações.]==], },
				["Biocontrol"] = { pt = [==[M20 Sorcerer, pág. 57


Biocontrol


A maioria dos fenômenos psíquicos envolve a percepção ou o controle de coisas fora do corpo do psíquico, mas Biocontrol (Biocontrole) permite que o psíquico exerça a vontade sobre o próprio corpo. Um psíquico pode ignorar a dor, aprimorar os sentidos e até desviar a circulação ou regular os níveis hormonais à vontade.

Enquanto outros conseguem para si graus menores de controle com biofeedback e meditação, psíquicos com Biocontrol podem forçar seus corpos a sobreviver ao que parecem ser situações sem esperança. A mãe que ergueu um carro de cima do filho, o homem que nunca parece bêbado por mais bebidas que tome, e o único sobrevivente de uma tragédia são todos exemplos deste fenômeno. Quanto mais miraculosa a manifestação, no entanto, mais provável que o psíquico atraia inadvertidamente a atenção errada.

Além da potencial atenção indesejada, Biocontrol não é isento de risco. Desastres podem fazer processos biológicos enlouquecerem exatamente no momento errado, proporcionalmente ao efeito que o psíquico estava tentando alcançar. Um psíquico que precisa reduzir sua necessidade de oxigênio para sobreviver a um afogamento pode aumentar seu metabolismo e acelerar sua morte, mas um psíquico que busca vantagem social com feromônios pode se envergonhar ao causar sudorese excessiva.

• Mindfulness (Atenção Plena): O psíquico se concentra em alterar seus processos biológicos de maneiras menores. Pode estancar o sangramento de pequenos ferimentos, elevar ou reduzir a temperatura central do corpo em até dois graus, prender a respiração por um tempo prolongado, ignorar a dor de ferimentos menores, incluindo penalidades de ferimento de até metade de seu índice de Biocontrol (arredondado para cima), e regular consciente e voluntariamente sua pressão sanguínea e sua pulsação dentro da faixa normal. O efeito termina se a concentração do psíquico for quebrada.

•• Healing Factor (Fator de Cura): O psíquico força seu corpo a acelerar os processos metabólicos responsáveis pela cura e pelo combate a infecções muito além da taxa normal. O psíquico deve passar tempo descansando e meditando, idealmente enquanto recebe cuidados médicos — o psíquico ainda é mortal, afinal. Para cada sucesso de ativação, o psíquico reduz em um nível o tempo para curar o nível de Vitalidade mais alto, até um mínimo de uma hora para dano contundente e um dia para dano letal ou agravado. Depois que o primeiro nível de dano é curado, o psíquico pode rolar ativação novamente para repetir o processo. Ao usar Healing Factor, psíquicos podem ignorar o risco de sequela permanente (permanent impairment) (ver Mage 20 p. 408), desde que tenham nutrição e descanso suficientes.

••• Surge (Descarga): O psíquico inunda seu sistema com hormônios a seu comando. Psíquicos escolhem Físico, Social ou Mental e dividem seus sucessos de ativação entre atributos da categoria escolhida para elevar pontos (até um máximo de 5 em qualquer atributo) por uma cena. Isso pode representar uma descarga de adrenalina que permite “força histérica” em uma emergência, uma descarga de dopamina para melhorar a função mental, ou a modulação de serotonina e feromônios para se tornar mais calmo ou subconscientemente atraente em situações sociais. Provocar picos hormonais deliberadamente desgasta o corpo: Quando o efeito passa, o psíquico deve rolar Vigor (Stamina) com dificuldade 5 para absorver os sucessos de ativação como dano contundente.

•••• Toggle Nerves (Alternar Nervos): Um psíquico com este nível de controle aprimora ou reduz a sensibilidade de seus nervos por até uma cena por sucesso de ativação. O uso mais comum é anestesiar temporariamente a dor. Um psíquico pode ignorar penalidades de ferimento causadas por dor em até o número de sucessos de ativação em níveis de Vitalidade — isso não permite que o psíquico ignore penalidades devidas a partes do corpo não funcionais ou ausentes. Um psíquico pode, em vez disso, escolher anestesiar os sentidos para ignorar outros estímulos nocivos, como odores poderosos, mudanças súbitas de iluminação ou extremos de temperatura. O psíquico pode ignorar até os sucessos de ativação em penalidades de distração e pode dividir os sucessos entre múltiplos tipos de penalidade. Alternativamente, um psíquico pode aumentar a sensibilidade nervosa, reduzindo a dificuldade de testes baseados em percepção pelos sucessos de ativação, e pode dividir os sucessos entre os sentidos. No entanto, aumentar a sensibilidade nervosa traz um risco. Cada sucesso gasto para reduzir a dificuldade de percepção com um sentido soma à dificuldade de resistir a distrações usando aquele sentido enquanto o poder estiver ativo. Se o psíquico aumentar a sensibilidade do tato e sofrer dano, ele sofre penalidades de ferimento adicionais iguais aos seus sentidos de ativação dedicados ao tato.

••••• Biological Mastery (Maestria Biológica): O psíquico alcança controle completo sobre seu corpo. Pode parar e reiniciar seu coração à vontade, regular a digestão, suspender temporariamente a necessidade de oxigênio e se colocar em hibernação para forçar feitos de cura mais extremos — inclusive regenerar partes do corpo. Pode acelerar ou suspender a regeneração em nível celular e pode anular toxinas com um teste de ativação. Cada sucesso de ativação reduz em um o Índice de Toxina (Toxin Rating) da substância. Se o Índice de Toxina restante for menor que o Vigor do psíquico, o psíquico pode direcionar a toxina para uma parte específica de seu corpo para que ela siga seu curso, sofrendo um Impediment (Impedimento) (como o defeito, ver M20 Book of Secrets p. 39) pela duração do efeito da toxina. Se o Índice de Toxina for maior que o Vigor do psíquico após usar Biological Mastery, o psíquico sofre a toxina normalmente no Índice de Toxina reduzido. Um psíquico pode gastar um turno se concentrando e rolar ativação para absorver dano letal e agravado com Vigor por uma cena.]==] },
				["Channeling"] = { pt = [==[M20 Sorcerer, pág. 58


Channeling


Um médium se posta diante de um grupo e invoca um parente morto cujo nome começa com alguma letra do alfabeto. Algum presente diz que conhece alguém morto com aquele nome. O médium lhe informa que essa pessoa cruzou para o outro lado em paz e que o espírito quer o melhor para ele. Ela perdoa os vivos por algum pecado vago que o presente reconhece, e nada mais é pedido. O consolo foi alcançado e o médium é pago. O reality show vai muito bem e a popularidade cresce. Isso é tudo besteira.

Na comunidade psíquica, existem aqueles que canalizam os mortos. Raramente é com o propósito de fazer alguém se sentir melhor, porém. Os mortos são uma riqueza de experiência inexplorada que faria até o mestre mais erudito ruborizar de inveja. Esse conhecimento está à disposição do canalizador, e quando usado corretamente ele nunca está sem a perícia certa para a tarefa em questão.

Canalizadores vêm em todos os formatos, tamanhos e estilos. Alguns deles seguem o clássico clichê vitoriano de ‘revirar os olhos e falar em outra língua’. Há uns poucos que bebem beberagens caseiras que eles mesmos preparam e que “os abrem para o outro lado”. Canalizadores modernos com pendor tecnológico usam spirit boxes (caixas de espíritos) e aparelhos de EVP para obter seu conhecimento. No fim, o psíquico está se abrindo para um espectro (wraith) nas Terras das Sombras (Shadowlands) que possui o conhecimento de que ele precisa. Quanto melhores eles são, mais forte a conexão com as perícias e os talentos dos mortos.

É um jogo perigoso de jogar, sem dúvida. Abrir aquela porta pode levar algumas peças desagradáveis a entrar tranquilamente na psique do psíquico, se ele não tomar cuidado. Quando as coisas dão errado, uma possessão completa aguarda o infeliz canalizador. Mas o outro lado da moeda é poder trazer o conhecimento de um gênio da cirurgia em uma emergência médica, de um acrobata ao cruzar um parapeito precário, ou de um assassino de sangue-frio quando a autodefesa é necessária. Canalizadores são os primeiros a dizer que o risco vale a recompensa.

Ao usar Channeling (Canalização), o psíquico pode trazer apenas um espírito por vez. A psique do canalizador poderia ser facilmente sobrecarregada se mais de um espectro recebesse acesso ao seu ser. Caso o psíquico invoque outro espírito enquanto hospeda outro de uma canalização anterior, o primeiro é liberado e substituído pelo segundo.

Por necessidade, o canalizador tem algum discernimento sobre as Terras das Sombras, o reino dos fantasmas. À medida que se tornam mais poderosos em sua prática, o canalizador pode espiar através da Mortalha (Shroud) por um número de minutos igual aos sucessos obtidos. Este é um uso separado de seu talento de canalização e custa o mesmo que canalizar um espírito por suas capacidades. A dificuldade do teste deste poder é afetada pela força da Mortalha na área e não tem restrição de frequência de uso, desde que o psíquico tenha os pontos de Força-de-Vontade para gastar.

• O canalizador pode se conectar ao outro lado e extrair as Habilidades de um fantasma, embora possa acessar apenas uma única Habilidade por uso deste poder. Sucessos no teste de ativação se tornam dados bônus para testes que utilizem o Talento, a Perícia ou o Conhecimento desejado pelo restante da cena. Ao contemplar através da Mortalha, o psíquico pode obter uma ideia vaga dos espectros presentes.

•• O psíquico agora pode acessar duas Habilidades simultaneamente, dividindo os sucessos entre os traços desejados. O canalizador também pode agora distinguir mais das Terras das Sombras ao espiar através da Mortalha. O canalizador pode discernir detalhes da paisagem e identificar fantasmas específicos que estejam presentes.

••• Um crescimento maior agora permite que uma terceira Habilidade seja canalizada, sujeita às limitações acima. O canalizador agora pode se comunicar verbalmente com fantasmas além da Mortalha.

•••• O psíquico agora pode acessar qualquer Talento, Perícia ou Conhecimento, mantendo múltiplos traços canalizados desde que obtenha sucessos suficientes no teste de ativação para cobrir os níveis de traço desejados. A comunicação não é mais limitada por uma janela curta de acessibilidade, e contemplar através da Mortalha dura uma cena inteira.

••••• Com uma psique fortalecida por muitas provações e tribulações, o psíquico está robusto o bastante para agora canalizar duas personalidades separadas ao mesmo tempo. Note que cada espectro canalizado ainda exige seu próprio custo e teste de poder. Caso a Habilidade canalizada seja a mesma em cada uso, os dados bônus de ambos os usos são somados às paradas de dados que usem o Talento, a Perícia ou o Conhecimento.

No auge de sua habilidade, com um espírito canalizado, o médium pode se abrir para um espectro e ganhar todas as Habilidades do espírito visitante. Os sucessos obtidos durante o teste de canalização ficam agora disponíveis para qualquer Talento, Perícia ou Conhecimento que aquele espectro possa ter possuído em vida. Os custos extras de canalizar com defesas tão baixas podem ser altos, no entanto. O espírito pode pedir um favor, uma tarefa a ser cumprida, ou até o direito de controlar livremente o corpo do canalizador por um período de tempo.]==] },
				["Clairvoyance"] = { pt = [==[M20 Sorcerer, pág. 59


Clairvoyance


Clairvoyance (Clarividência) refere-se à capacidade de ver além dos arredores imediatos de alguém e alcançar grandes distâncias. Em muitos casos, o sentido projetado pode ser qualquer um dos cinco sentidos, e a informação efetivamente recebida raramente é algo tão simples quanto um análogo um-para-um do local distante. Na maioria dos casos, os sentidos são bombardeados com sensações interpretativas que, somadas, formam uma única ideia unificada do local, da pessoa ou do objeto sendo percebido.

Quanto mais informação um clarissenciente (clairsentient) tem sobre seu alvo, mais clara a imagem que recebe. Montanhas de relatórios repousam em instalações governamentais de testes com nomes de projeto como Stargate, Grillflame e Sunstreak, que falam de psíquicos recrutados fornecendo impressões e sensações correlatas a observações de alvos. Itens com os quais eles eram muito familiarizados eram mantidos em locais distantes, bases nas montanhas, postos avançados no deserto e até submarinos. Os psíquicos relatavam coisas como sentir um calafrio, ver um sol do meio-dia, ou a sensação de estar flutuando em uma piscina. Embora seja um bom começo, o clarividente experiente pode alcançar muito mais precisão e clareza. Os clarividentes mais poderosos podem ver um local a centenas de milhas de distância com clareza de cristal, e rumores sussurram sobre potências com alcance global.

Existe alguma confusão entre o que constitui Clairvoyance e o que é Astral Projection (Projeção Astral). Há aqueles que insistem que são o mesmo fenômeno quando a maestria é alcançada em qualquer um dos dois. O psíquico perspicaz considera essa mistura risível. Os estudiosos psíquicos mais bem informados poderiam oferecer este esclarecimento: “Clairvoyance obviamente se aproveita da conexão inerente entre pontos no espaço, enquanto o eu interior deixa o corpo e é enviado a viajar por meio de Astral Projection.”

Essa conexão e familiaridade com o objeto de sua visualização também tem efeito direto sobre suas chances de sucesso. Encontrar alvos mais familiares exige apenas um ou dois sucessos, enquanto ser um estranho ao objeto aumentará o número de sucessos necessários para localizá-lo. Uma vez feita a conexão, o clarissenciente pode observar o local ou a área ao redor de uma pessoa ou objeto no grau de clareza que tiver alcançado. Um psíquico que tente reorientar sua segunda visão (second sight) precisa fazer outro teste (com a dificuldade ajustada em um a menos por familiaridade, se o novo objeto foi visto a partir de seu primeiro foco).

• Experimentar locais remotos é novo para o psíquico, e a maioria das observações é interpretativa. Essa impressão pode ser uma sensação física de aço frio para uma faca, o cheiro de pólvora para armas de fogo, ou uma visão de uma casinha de cachorro para cães de guarda. Em alguns casos, uma imagem real do objeto pode ser alcançada, mas será nebulosa na melhor das hipóteses. A única exceção é a audição. Os sons atravessam a ponte mental distorcidos e ininteligíveis, se puderem ser ouvidos. Mais sucessos concedem sensações simbólicas mais literais, com cinco sucessos proporcionando percepção visual real do alvo, por turva que seja. Os sentidos têm alcance limitado para novatos e chegam a aproximadamente uma milha ao redor do psíquico. Redirecionar seu foco exige outro teste de Força-de-Vontade e outro gasto de Força-de-Vontade para solidificar seu novo objeto remoto.

•• A visão remota se torna mais confiavelmente alcançável, embora ainda envolta em leve distorção ou névoa. O som atravessa com muito mais frequência, com uma chance de ser claro o bastante para ser compreensível. Três sucessos no teste de Força-de-Vontade proporcionam uma imagem quase clara do objeto com sons distorcidos, enquanto cinco sucessos concedem clareza de cristal e sons inteligíveis que poderiam transmitir o assunto geral e o clima das conversas próximas ao objeto. O psíquico agora pode empurrar seus sentidos mais longe — até dez milhas de distância de sua localização atual. A dificuldade do teste aumenta em um após 5 milhas e em dois a 8 milhas.

••• A clareza não é mais um problema, e a percepção remota traz visão e som através da extensão sem distorção. O clarividente destrava uma nova via de percepção clarificada no sentido do tato. “Tocar” psiquicamente um objeto distante devolve sensações abafadas, como se suas mãos estivessem envoltas em luvas grossas. Com a clareza não sendo mais uma preocupação, os sucessos agora definem a distância que um clarissenciente pode alcançar, com cada sucesso representando dez milhas de alcance. Neste ponto, um novo teste de Força-de-Vontade ainda é exigido para reorientar, mas não custa mais esforço para ser realizado.

•••• Visão, som e tato estão todos dentro do alcance do visualizador remoto (remote viewer). O clarividente também começa a perceber cheiros e sabores, com odores e sabores fortes sendo detectados quando estão em abundância. O alcance agora aumenta dez vezes, com cada sucesso equivalendo a 100 milhas de alcance.

••••• O mestre clarissenciente pode visualizar remotamente um local como se estivesse de pé na sala. Todos os cinco sentidos são recebidos com definição exata, sem que nenhum segredo escape de sua percepção. O alcance aumenta dez vezes mais uma vez, com cada sucesso estendendo seu alcance em 1.000 milhas. Por fim, desde que o psíquico esteja reorientando o foco para um elemento que possa ver dentro de sua visão clarividente atual, nenhum novo teste é exigido, pois ele forja novas correspondências para objetos na hora.]==] },
				["Cyberkinesis"] = { pt = [==[M20 Sorcerer, pág. 60


Cyberkinesis


Cyberkinesis é um dos Fenômenos Psíquicos descobertos mais recentemente — o primeiro caso documentado há menos de um século — e representa a capacidade de controlar maquinário eletrônico pelo pensamento. Especialistas em fenômenos psíquicos teorizam que Cyberkinesis é uma variante da telecinese (telekinesis) própria da era da informação. O psíquico gera pequenos campos eletromagnéticos que controlam e alteram o firmware e o software de aparelhos eletrônicos, indo de alarmes de incêndio a supercomputadores.

Embora o cinético cibernético (cyberkinetic) possa controlar a máquina psiquicamente, ele não pode ler psiquicamente o conteúdo dela sem Cyberpathy. Todos os poderes acima do ponto um exigem que o cinético cibernético tenha acesso ao display do aparelho ou seja capaz de acessar o aparelho por meio de Cyberpathy.

• Switch (Interruptor): O cinético cibernético pode ligar e desligar aparelhos eletrônicos sem tocá-los. +2 de dificuldade na ativação se o eletrônico exigir um relé físico em vez de um eletrônico. O psíquico precisa ser capaz de sentir o aparelho eletrônico para usar este poder. Esta é uma exceção à exigência usual de acessar o display do aparelho e se aplica a aparelhos sem display, como luminárias.

•• Remote (Remoto): O psíquico pode controlar aparelhos eletrônicos com a mente sem ter que usar um dispositivo de entrada como um teclado. Isso não fornece nenhuma credencial de login ou de sobreposição, mas, se o psíquico souber as credenciais, ele pode digitá-las. Qualquer ação mais difícil do que operar um computador de escritório aumenta a dificuldade de ativação. Este poder elimina a necessidade de dispositivos de entrada hápticos se o psíquico usar Realidade Aumentada (Augmented Reality) (M20 Operative’s Dossier, p. 58).

Modificador de Dificuldade = Exemplo
+1 = Controlar a rede de servidores de um pequeno escritório ou um sistema de segurança residencial, usar uma impressora 3-D com projetos pré-carregados
+2 = Dirigir psiquicamente um carro elétrico em velocidade de estrada
+3 = Usar equipamento especializado, como uma impressora 3-D sem projetos pré-carregados
+4 = Comandar uma fábrica controlada por computador
+5 = Operar um ônibus espacial sozinho

••• Glitch (Falha): O psíquico direciona seus campos eletromagnéticos para embaralhar processos eletrônicos causando pequenos curtos-circuitos internos e picos de energia. Ele pode fazer computadores travarem ou exibirem a tela azul e equipamentos de gravação captarem apenas estática. O efeito exige concentração ativa. A maioria dos aparelhos eletrônicos volta ao normal depois que o efeito termina, mas algumas tecnologias mais antigas simplesmente quebram. Um psíquico usando RA pode usar isto como um ataque contra Ícones e outros objetos da Digital Web, causando dano contundente. Use a ativação para atacar e substitua os pontos em Cyberkinesis pelo modificador de arma na rolagem de dano. Se o psíquico infligir 3 ou mais de dano em um ataque, o alvo fica atordoado por um turno.

•••• Spoof (Falsificar): O psíquico engana sistemas operacionais para que o deixem entrar sem credenciais válidas. Se o sistema for capaz de executar a tarefa, o psíquico pode forçar o sistema a fazê-la. O psíquico pode plantar documentos falsos, instalar malware, conceder a si mesmo privilégios de administrador ou apagar dados.

••••• Overclock (Sobrecarregar): O psíquico anula os limitadores de segurança de aparelhos eletrônicos para forçá-los a exceder suas capacidades normais. Um computador processa mais rápido ou roda softwares mais intensivos do que deveria ser capaz, um carro elétrico acelera mais rápido ou um apontador laser de escritório se torna uma arma. Cada sucesso na ativação adiciona um sucesso automático ao próximo uso da máquina pelo psíquico, mas o esforço danifica a máquina. Rolagens para operar a máquina depois que este poder é usado sofrem uma penalidade em dados igual aos sucessos de ativação até que o aparelho seja reparado. Obter 8 ou mais sucessos ao ativar este poder frita completamente a máquina depois que o efeito de Overclock termina.]==] },
				["Cyberpathy"] = { pt = [==[M20 Sorcerer, pág. 61


Cyberpathy


Como os especialistas acreditam que Cyberkinesis é uma variante da telecinese (telekinesis) própria da era da informação, eles acreditam de modo semelhante que Cyberpathy funciona sob a mesma premissa da telepatia — o ciberpata (Cyberpath) decodifica padrões eletromagnéticos nos discos rígidos de um computador para acessar informações, assim como um telepata decodifica impulsos elétricos no cérebro.

Um ciberpata precisa manter à vista o computador em questão, exceto no caso de Remote Access (Acesso Remoto), em que ele precisa, em vez disso, manter à vista o computador que serve de ponto de entrada. Esta habilidade também pode ter como alvo dispositivos e mídias de armazenamento, como pen drives, discos e discos rígidos externos ou não conectados. Normalmente, Cyberpathy leva de 10 a 15 minutos, mas cada sucesso na ativação reduz o tempo necessário em um minuto. Até que o psíquico possua o ponto 5, sistemas fortemente encriptados aumentam a dificuldade de ativação. Cyberpathy se mostra mais versátil quando combinada com Cyberkinesis, mas também pode ajudar em tentativas mundanas de hackeamento.

• Map Structure (Mapear Estrutura): O ciberpata pode examinar o diretório de computadores e dispositivos de armazenamento. O ciberpata pode encontrar a localização e as propriedades de todos os arquivos armazenados, mas não pode acessar os arquivos usando este poder. Isso pode ser útil para ciberpatas hackers que procuram dados específicos. O psíquico pode usar este nível para identificar um aparelho pelo seu Augmented Reality Object ID (ID de Objeto de Realidade Aumentada) se ele tiver capacidade de acesso à web.

•• Read-only Mode (Modo Somente Leitura): Como Map Structure, mas o ciberpata também pode ler arquivos. Arquivos de texto simples e de imagem são fáceis de visualizar, e o ciberpata pode adivinhar as funções de arquivos executáveis e aplicativos. O ciberpata é incapaz de descriptografar arquivos encriptados neste estágio. O psíquico pode visualizar o ARO associado ao aparelho se ele for de Nível 1 ou inferior e pode adivinhar as propriedades do ARO se ele for de um nível superior.

••• Download (Baixar): O psíquico pode usar o próprio cérebro como mídia de armazenamento, copiando e colando arquivos encontrados usando Cyberpathy. O ciberpata pode acessar textos, imagens e vídeos armazenados a qualquer momento a partir da própria mente, mas não pode rodar aplicativos. O psíquico pode armazenar um número máximo de arquivos igual ao total de seus atributos mentais (Exemplo: Coleen tem Percepção (Perception) 4, Inteligência (Intelligence) 3 e Raciocínio (Wits) 3. Ela pode armazenar 10 arquivos em sua mente). Arquivos e aplicativos maiores podem ocupar mais de um espaço de armazenamento, enquanto uma pasta compactada pode conter vários arquivos pequenos em um único espaço, ao custo de o psíquico ser incapaz de ler qualquer um dos arquivos enquanto estiverem armazenados dessa maneira. O ciberpata pode mais tarde gravar quaisquer arquivos que salvou dessa forma em qualquer mídia que possa acessar com Cyberpathy, com a opção de copiar o arquivo para a mídia ou transferi-lo de sua mente. Se o aparelho tiver um dispositivo de exibição conectado, o psíquico pode combinar Download com Cyberpathy para gravar e exibir um arquivo a outras pessoas no mesmo turno. Apagar arquivos da mente do psíquico é uma ação livre, mas o psíquico só pode apagar um arquivo por vez. Arquivos maiores que ocuparam mais de um espaço de armazenamento levam um número de turnos igual ao número de espaços que o arquivo ocupa para terminar a exclusão, mas o psíquico pode realizar outras ações normalmente durante a exclusão. O personagem pode baixar um ARO de um aparelho para carregá-lo depois e falsificar a identidade do aparelho.

•••• Remote Access (Acesso Remoto): O ciberpata pode se conectar a qualquer computador ou aparelho, como discos rígidos externos, na mesma rede que seu aparelho local. Este poder apenas permite que o psíquico trate o aparelho remoto como se ele estivesse à sua frente, e quaisquer outros poderes precisam ser ativados separadamente. O psíquico pode acessar múltiplos aparelhos na mesma rede ao custo de 1 de Força-de-Vontade por aparelho. Se o aparelho for capaz de acessar a internet, o psíquico pode usar esta habilidade para acessar a internet, incluindo a Digital Web. O psíquico pode usar dispositivos avançados de RA como seu ponto de acesso com este poder.

••••• Enigma (Enigma): O ciberpata se torna um algoritmo de descriptografia vivo, capaz de quebrar com facilidade até sistemas e arquivos fortemente encriptados. O psíquico pode ativar este poder para ignorar aumentos de dificuldade dos poderes inferiores de Cyberpathy e do acesso mundano em sistemas ou arquivos seguros e encriptados previamente armazenados usando Download. O psíquico pode, alternativamente, usar os sucessos de ativação para aumentar a dificuldade de Cyberpathy e de hackeamento para outras pessoas em um arquivo ou aparelho, a +1 de dificuldade por sucesso de ativação, se o psíquico possuir pontos em Informática (Computers) ou Cyberkinesis.]==] },
				["Ectoplasmic Generation"] = { pt = [==[M20 Sorcerer, pág. 62


Ectoplasmic Generation


Existem coleções de fotos de sessões espíritas (séance) do auge da fase de entretenimento ocultista da sociedade que exibem massas revoltas de muco translúcido e sem peso pairando ao redor das cabeças dos líderes das sessões. A maioria descarta isso como simples imperfeições no filme e segue em frente para apreciar as relíquias da fotografia em suas mãos. Os verdadeiros psíquicos sabem que não é assim. O ectoplasma é a matéria espiritual neutra do fantasma. Uma substância nascida de energia e atividade espirituais, o ectoplasma existe como evidência liminar de algo além do físico. Um truque de salão divertido para os iniciados, este plasma é muito mais útil do que o leigo pode presumir de imediato.

Por meio de concentração e pura força de vontade, um psíquico reúne as energias fantasmagóricas ambientes ao seu redor e as traz à existência física dentro de suas entranhas. Isso cria a visão perturbadora dessa matéria espiritual coalescida fluindo da boca e do nariz do praticante. Manifestando-se como um gel escorregadio, translúcido e frio, o ectoplasma flui sem peso quando não recebe direção. Respondendo à vontade do gerador, a maleável matéria espiritual pode assumir muitas formas macabras para repugnar ou impedir os incautos, enquanto se dissolve no nada meros minutos depois que a concentração é interrompida. Para o desgosto das testemunhas, o ectoplasma não deixa absolutamente nenhuma evidência física ou espiritual depois de sublimar.

Possivelmente a propriedade mais útil do ectoplasma é que, não importa quão tênue, viscoso ou grudento o ectoplasma possa parecer à pessoa comum, ele será tão duro e imóvel quanto chumbo puro para o espiritual. Fantasmas, wraiths, espíritos e almas em projeção astral todos consideram o ectoplasma muito sólido e quase intransponível. Isso tem uma miríade de usos, que vão de criar uma barreira ao redor de um quarto passando a substância nas paredes até revestir as próprias mãos com o material para permitir que o psíquico toque as imateriais Terras das Sombras (Shadowlands), seja com benevolência ou com violência. Este Fenômeno infelizmente não permite que o psíquico veja dentro das Terras das Sombras. Ele meramente lhe concede a habilidade de criar uma substância tanto de espírito quanto de matéria.

• Quando alguém começa a explorar suas capacidades como gerador, isso começa com práticas de aparência bastante juvenil. Geradores novatos não acham difícil o ato de criar ectoplasma. A real dificuldade está em criar um volume e uma força substanciais. Isso leva o gerador iniciante a ser incapaz de forçar o plasma semilíquido para fora de seus orifícios sem assistência. Enfiando a mão na boca, no nariz e nos ouvidos para extrair a substância manualmente ou contando com o peristaltismo, o gerador precisa se esforçar para trazê-la para fora. Cada sucesso no teste de ativação gera um volume do tamanho de uma bola de softbol da substância pegajosa. Ele dura apenas um número de turnos igual à Força-de-Vontade do gerador, mas pode ser aplicado tão rápido quanto é gerado. Cobrir um objeto com uma camada fina de ectoplasma não exige passos extras além de gerá-lo. O plasma adere a todas as superfícies e não é fácil de limpar. Ele vai se agarrar e formar fios em qualquer coisa que o toque e só sublima no nada quando a duração expira.

Outra abordagem inédita que os usuários descobrem cedo é a técnica do “homem que fuma”. Quando estimulado corretamente, o ectoplasma também pode surgir como um vapor semelhante a névoa. Lambidas e tentáculos persistentes de fumaça espessa vazam da boca, do nariz e dos dutos lacrimais do gerador. Durando um número de turnos igual à Força-de-Vontade do psíquico, isso deve ser levado em conta ao lidar com interações sociais. Usar a técnica pode adicionar um dado de bônus em situações como o número de um mágico de palco ou intimidar um brutamontes desavisado, mas incorre em uma penalidade de -1 a Habilidades como Expressão ou Liderança devido à visão desconcertante dessa nuvem ectoplásmica.

•• Uma vez que os geradores de ectoplasma pegam o ritmo, o grau de avanço no controle é impressionante. A cada sucesso na rolagem de ativação, um psíquico gera o equivalente a um quarto de galão do fluido viscoso. Com esse volume aumentado, não é necessária assistência para forçar o plasma para fora, pois ele simplesmente escorre dos orifícios nasais e esofágicos do psíquico. Não há desconforto nisso, e mais de alguns geradores sentem um prazer doentio na repulsa dos outros à sua prática. Todos os fenômenos de plasma agora duram um número de minutos igual à Força-de-Vontade do gerador.

Uma névoa gerada agora ganha uma medida de responsividade à vontade do criador. O psíquico agora pode empurrar a névoa para fora formando uma nuvem que se move e se desloca ao comando mental do gerador. A velocidade da nuvem não é impressionante, a 10 pés por turno, mas ela pode ser usada para obscurecer olhos curiosos, impondo +2 de dificuldade a testes de Percepção (Perception). Esta nuvem de névoa tem um raio de 1 pé por Força-de-Vontade do psíquico.

••• A geração de fluido de plasma é truque de criança para o gerador experiente. Cada sucesso na rolagem de ativação agora invoca um galão de líquido em um fluxo contínuo. A força do jato não é suficiente para fazer um indivíduo perder o passo, mas é suficiente para que o gerador atinja o canto do teto em um quarto padrão.

As névoas ectoplásmicas ganham um grau de solidez. Não mais apenas fios de fumaça, a névoa agora é sólida o bastante para parecer algodão-doce aos vivos. Isso vem em conjunto com um volume aumentado de 5 pés de raio por ponto de Força-de-Vontade. Tentar forçar passagem pela névoa espessa e semissólida exige uma rolagem de Força (Strength) + Esportes (dificuldade 6). Espessa o bastante agora para que a névoa seja praticamente opaca, ela também fornece cobertura visual e aumenta a dificuldade de ver e atacar através dela em +3, semelhante a uma granada de fumaça pesada.

•••• Fluido e névoa são úteis, mas o acesso a massa sólida e a formas moldadas expande as possibilidades de criatividade dez vezes. O volume não aumenta, mas agora a produção do canalizador pode resultar em matéria sólida com a consistência de banha densa. Com maior estabilidade estrutural, o ectoplasma pode manter formas definidas que só são limitadas pela criatividade do gerador. Essas criações têm um número de pontos igual à Força-de-Vontade do psíquico para ser distribuído entre Força, Destreza (Dexterity) e Vigor (Stamina). A criação tem 3 níveis de Vitalidade e não sofre penalidades por ferimento. Embora não sejam capazes de movimentos complexos, as criações efêmeras sólidas podem se mover pelo espaço a 30 pés por turno. As criações estão psiquicamente atadas ao seu criador e não podem deixar sua percepção física e manter o movimento. Por fim, todas as criações de plasma não são mais limitadas por um limite de tempo e duram enquanto o gerador se concentrar.

••••• Aparições vaporosas de torso completo e flutuando livremente estão no ápice do ofício do gerador. Ainda fantoches do criador, as criações moldadas agora podem se animar plenamente conforme apropriado às suas formas complexas. Embora incapazes de enganar alguém a ponto de fazê-lo pensar que é a coisa genuína, as formas agora podem imitar grosseiramente pessoas e criaturas, até emitindo gemidos conforme bolsões de ar escapam dentro da forma gosmenta. As formas ainda são limitadas pelo volume gerado na rolagem, com um ser de ectoplasma do tamanho de um adulto exigindo três sucessos para ser preenchido. As criações seguem as mesmas regras de distribuição de Atributos detalhadas acima, mas têm 6 níveis de Vitalidade e não sofrem penalidades por ferimento. Fantoches ectoplásmicos podem ser possuídos e controlados com facilidade por fantasmas na área. O psíquico gasta 1 de Força-de-Vontade para entregar as rédeas a um fantasma disposto que esteja próximo. O fantasma então tem controle total do construto ectoplásmico, usando-o como se fosse seu próprio corpo. Uma vez que o psíquico entrega o corpo dessa maneira, ele dura um número de turnos igual ao valor de Força-de-Vontade do psíquico, após o que o ectoplasma do fantoche se dissipa. Outras manifestações que o psíquico cria não são afetadas e permanecem existentes enquanto o psíquico se concentrar.]==] },
				["Mind Shields"] = { pt = [==[M20 Sorcerer, pág. 65


Mind Shields


A mente é uma coisa terrível de se desperdiçar. Muitos psíquicos vivem por esse credo. Existem pessoas e coisas por aí no mundo que atacam a mente diretamente, mas alguns psíquicos são dotados da habilidade de se preparar contra essa ameaça em potencial. Erguer muralhas contra ataques mentais, garantir que os pensamentos sejam caóticos demais para serem controlados, ou apenas uma fortaleza mental inerente são todas fontes possíveis para essa defesa.

Como o nome indica, Mind Shields (Escudos Mentais) só afeta poderes que afetam a mente do psíquico. Poderes que se originam da mente de outra pessoa mas afetam o mundo ao redor do psíquico protegido não são afetados. Um psicocinético (psychokinetic) não tem mais dificuldade para erguer e sustentar um psíquico com Mind Shields ativo do que teria com uma pessoa normal.

Mind Shields, sendo um Fenômeno Psíquico, lida mais facilmente com Fenômenos Psíquicos do que com outras formas de agressão mental. Um vampiro que empunha Dominação (Dominate) acessa a mente de uma maneira diferente de um psíquico com Psychic Hypnosis (Hipnose Psíquica). Infelizmente, Mind Shields tem apenas metade da eficácia contra ataques mentais de fontes não psíquicas.

Quando confrontado por uma agressão ou invasão mental, os Mind Shields do psíquico fornecem uma parada de dados para conter o efeito. O alvo rola esses dados (dificuldade 6) e subtrai seus sucessos daqueles do atacante. Um defensor que rola mais que o atacante interrompe a agressão completamente, e o ataque falha. Para poderes que normalmente pedem uma rolagem de defesa, os dados de Mind Shields são somados diretamente à rolagem de defesa.

• As defesas são finas, mas presentes. O Psíquico recebe 2 dados para conter fenômenos de ataque mental e 1 dado para ataques mentais de outras fontes. Nesse ponto, os Escudos estão sempre ativos e não conseguem distinguir efeitos amigáveis e hostis. O psíquico pode baixar seus Mind Shields para permitir acesso a um psíquico amigo, mas isso o deixa aberto a qualquer outra habilidade mental usada antes que eles sejam erguidos novamente.

•• Camadas de caos mental ou muralhas mais grossas da mente são construídas. O psíquico recebe 4 dados para conter fenômenos de ataque mental e 2 dados para ataques mentais de outras fontes.

••• A mente do psíquico é uma confusão desnorteante ou um bunker resistente para qualquer invasor. O psíquico recebe 6 dados para conter fenômenos de ataque mental e 3 dados para ataques mentais de outras fontes. A capacidade de modular os próprios Mind Shields se torna clara nesse nível. Sempre que apresentado a uma habilidade mental que tente interagir com a mente do psíquico protegido, o alvo pode decidir se deixa isso passar por seus escudos ou não. Note que isso não identifica cada habilidade usada, apenas que uma tentativa está em curso para acessar a mente do psíquico. Fica a cargo do raciocínio dedutivo do alvo descobrir quem está diante de seus portões mentais.

•••• Um baluarte mental ou um atoleiro desconcertante de pensamentos dispersos recebe os intrusos. O psíquico recebe 8 dados para conter fenômenos de ataque mental e 4 dados para ataques mentais de outras fontes.

••••• A fortaleza mental do psíquico se ergue impenetrável ou o labirinto infinito se torna inavegável. O Psíquico recebe 10 dados para conter fenômenos de ataque mental e 5 dados para ataques mentais de outras fontes.]==] },
				["Precognition"] = { pt = [==[M20 Sorcerer, pág. 65


Precognition


O psíquico experimenta pistas sobre o futuro. O futuro não é fixo e pode mudar dependendo das escolhas que as pessoas fazem. Quanto mais decisões forem necessárias para um resultado, menor a precisão da previsão. Nenhum vidente provou ser 100 por cento preciso, exceto a mítica Cassandra.

Precognition (Precognição) permite que um psíquico julgue probabilidades de resultados com precisão acima da humana. Psíquicos de mente científica racionalizam a precognição como manifestações conscientes de análise perceptiva subconsciente. Psíquicos de tendência mística entendem a precognição como uma espécie de sexto sentido sem explicação científica.

Embora um psíquico possa ativar a precognição, um Narrador pode pedir a ativação por motivos de história, caso em que nenhuma Força-de-Vontade é gasta nessa ativação.

• Intuition (Intuição): O vidente adquire um talento para adivinhar corretamente. Para eventos puramente aleatórios (loteria, rolagens de dados), as previsões podem ser bastante precisas. O psíquico pode saber intuitivamente a rota mais curta até um determinado destino e desfruta de uma probabilidade maior de encontros casuais benéficos. O psíquico não experimenta visões, ele apenas “tem um pressentimento” e adivinha muito bem. Mesmo com cinco ou mais sucessos, é improvável que as previsões sejam inteiramente precisas.

•• Insight (Discernimento): O psíquico experimenta visões oníricas tanto durante o sono quanto nas horas em que está acordado. Como sonhos, elas raramente são literais. Em vez disso, as visões são impregnadas de metáfora. Um inimigo pode aparecer como um dragão feroz ou como figuras em mantos clandestinos, enquanto um mentor amado pode aparecer como um pai há muito morto. As imagens dependem do paradigma do vidente e, embora mais sucessos ofereçam visões detalhadas, elas estão sempre sujeitas a interpretação.

••• Danger Sense (Sentido de Perigo): A conexão do vidente com o futuro se torna um sistema de alerta antecipado. O psíquico percebe isso como qualquer coisa desde uma dor lancinante na têmpora, até cãibras, até uma sensação crescente de pavor. Não importa a manifestação, ela é sempre a mesma para o vidente. Esse poder está sempre “ligado”, embora possa ser subvertido por certos efeitos de Esfera ou pelo Fenômeno Anti-Psychic (Anti-Psíquico). Quando algo não notado toma o psíquico como alvo, o Narrador rola a ativação de Danger Sense antes de rolar a emboscada. Esse poder não custa Força-de-Vontade ao psíquico para ativar.

Sucessos = Efeito
Desastre = O vidente involuntariamente se coloca em perigo ainda pior e perde sua rolagem para notar a emboscada.
Falha = O psíquico não obtém nenhuma intuição sobre a situação.
1 = O vidente sente que está em perigo, mas não obtém especificidades. Ele recebe 1 dado bônus para notar uma emboscada.
2 = O vidente sente que está em perigo e recebe instruções simples sobre como evitá-lo, como “abaixe-se” ou “corra”. O psíquico recebe 2 dados bônus para notar a emboscada e se esquiva normalmente se o atacante permanecer escondido.
3 = O vidente sabe que está em perigo, como evitá-lo e a direção do perigo. O atacante não rola emboscada e o ataque se resolve normalmente.
4 = O vidente sabe os detalhes do ataque e recebe um turno de aviso. O psíquico ganha um turno para se preparar antes que o perigo aconteça.
5 = O vidente recebe um turno de aviso e uma visão dos responsáveis. O psíquico será capaz de identificar a pessoa pela visão e/ou por intuição psíquica caso o psíquico veja ou esteja na presença da pessoa mais tarde. A impressão psíquica também funciona em gravações e criações, como pinturas ou cartas, feitas pelo atacante.

•••• Clarity (Clareza): O vidente desfruta de uma visão quase perfeita do futuro imediato. Para cada sucesso de ativação, jogadores e Narrador anunciam seus planos futuros gerais para um turno. Se o psíquico interferir com o tempo — como se mover para trás de uma cobertura para frustrar um ataque, o futuro muda, e o psíquico deve reativar esse poder para obter atualizações.

••••• Roads of Time (Estradas do Tempo): Um psíquico vê mais do que apenas os resultados mais prováveis e suas probabilidades relativas. Como Insight, mas o psíquico vê o tempo como estradas divergentes que se ramificam nas decisões. O vidente identifica pontos de decisão que de outra forma pareceriam inócuos antes que as escolhas sejam feitas. Isso também permite que um psíquico veja quais eventos futuros são difíceis de mudar e quais eventos são mais maleáveis.

Sucessos = Alcance de Tempo
1 = 12 horas
2 = 24 horas
3 = 1 semana
4 = 1 mês
5 = 1 ano
6+ = 1 ano adicional por sucesso

Fornecer informações sobre o futuro distante pode ser difícil para o Narrador. O Narrador pode, em vez disso, conceder uma nova rolagem por cada sucesso de precognição para a história. Isso representa a capacidade do psíquico de manejar probabilidades futuras relativas. Um psíquico pode usar quantas dessas novas rolagens quiser em uma única ação.]==] },
				["Psychic Healing"] = { pt = [==[M20 Sorcerer, pág. 66


Psychic Healing


Muitas culturas têm lendas de pessoas abençoadas com o poder de curar por meio de pouco mais que um toque. Alguns deles provavelmente eram curandeiros psíquicos. Ao canalizar sua vontade e energia, um psíquico pode realizar milagres. Muitos com esse dom escolhem ser discretos a respeito — a fama e a pressão para realizar milagres podem ser assustadoras, e os inimigos que um curandeiro psíquico pode fazer dentro do meio médico são prejudiciais. Praticar medicina sem licença, mesmo em áreas com pouco acesso a serviços de saúde, continua ilegal.

Embora não seja exigido, muitos com esse dom têm um grande volume de conhecimento médico, muitas vezes adquirido informalmente. Quase todos os curandeiros psíquicos têm alta empatia, da qual alguns suspeitam que o dom se origine.

Desastres ao praticar medicina de qualquer tipo são devastadores, mas um curandeiro psíquico pode transferir a lesão ou a doença para si mesmo. Outras possibilidades incluem curar um ferimento de forma grotesca ou desviar as energias de cura, causando respostas autoimunes ou cancerígenas.

• Diagnosis (Diagnóstico): O curandeiro diagnostica instantaneamente doença ou lesão pela visão ou pelo contato com a pele. A terminologia do diagnóstico depende do conhecimento médico do psíquico — alguém com pouco conhecimento pode descrever lúpus como “o corpo lutando contra si mesmo”. Um psíquico pode usar os sucessos de Diagnosis em uma rolagem complementar (veja Mage 20 p. 389) para rolagens de Medicina. Se usar trabalho em equipe, o psíquico pode contribuir com sucessos para a rolagem do profissional médico até o valor de Medicina do psíquico.

•• Restorative Slumber (Sono Restaurador): Com um toque, o curandeiro concentra as energias do corpo de seu paciente na cura. Trate uma ativação bem-sucedida como tratamento médico habilidoso para dano contundente e letal e como estabilização magicka para dano agravado. O toque deve durar pelo menos um minuto, após o qual o paciente cai em um sono profundo. Com 3+ sucessos, o paciente também recupera um ponto de Força-de-Vontade.

••• Urgent Care (Atendimento de Urgência): A habilidade de cura do psíquico agora facilita a resolução rápida de lesões e venenos leves. Um psíquico toca o paciente e pode curar até seus sucessos de ativação em dano contundente, a uma taxa de um por turno. Cada dois sucessos podem reduzir o Índice de Toxina (Toxin Rating) de um veneno, droga ou doença em um, até 3 níveis de redução.

•••• Intensive Care (Atendimento Intensivo): O curandeiro agora pode curar os gravemente feridos. O psíquico cura até 1 letal por sucesso de ativação e pode reduzir o Índice de Toxina de venenos, drogas e doenças em um nível por sucesso. Cada nível curado leva 10 minutos, durante os quais o psíquico deve manter contato físico com o paciente. O processo é claramente sobrenatural para quaisquer testemunhas, pois os ferimentos se costuram miraculosamente e as substâncias nocivas escorrem pelo suor da pele do alvo.

••••• Psychic Surgery (Cirurgia Psíquica): O psíquico agora pode curar ferimentos graves, cânceres e infecções. O psíquico cura até 1 de dano agravado por sucesso. Cada nível curado leva 10 minutos, enquanto o psíquico fecha os olhos e gesticula como se estivesse enfiando as mãos na carne. Curandeiros também podem usar essa habilidade para causar dano, alcançando o interior de uma vítima e removendo fisicamente tecido saudável — um processo horrível e sangrento. Fora de combate, o psíquico pode usar esse poder para infligir dano agravado em um alvo contido. Como na cura, essa aplicação do poder leva 10 minutos por nível de Vitalidade. Cada sucesso na rolagem de ativação causa um nível de Vitalidade de dano agravado impossível de absorver. Esse uso da cura psíquica é sádico e considerado tortura, mas, em combate, não há tempo suficiente para usar esse poder em toda a sua extensão. Psychic Surgery só pode ser usada em combate para causar dor — ela inflige penalidades de ferimento como se o psíquico tivesse ferido o alvo, mas não causa dano. A vítima pode gastar pontos de Força-de-Vontade iguais aos sucessos de ativação do psíquico para “curar” o dano.]==] },
				["Psychic Hypnosis"] = { pt = [==[M20 Sorcerer, pág. 67


Psychic Hypnosis


Embora a hipnose moderna seja uma forma de terapia que qualquer um poderia aprender, alguns psíquicos têm um dom natural para ela, com efeitos muito além da variedade treinada. Com o aumento da popularidade e as pesquisas recentes sobre hipnoterapia, hipnotizadores psíquicos podem praticar seus dons abertamente, sem muito medo de atrair a atenção errada.

A hipnose psíquica não é tão rápida quanto as disciplinas vampíricas nem tão versátil quanto a Esfera da Mente (Mind Sphere). Mesmo assim, um hipnotizador particularmente talentoso pode alcançar muitos efeitos semelhantes.

• Trance State (Estado de Transe): O hipnotizador coloca um alvo voluntário em um estado de transe calmante, embora não possa emitir comandos. Nesse estado, o alvo consegue lembrar eventos e detalhes com mais clareza e ganha uma redução de dificuldade em quaisquer testes que envolvam recordação de memória igual aos sucessos de ativação, até uma dificuldade mínima de 2. O alvo também recupera um ponto de Força-de-Vontade por cada sucesso de ativação, embora não possa se beneficiar dessa função novamente até ter descansado normalmente. Leva cinco turnos para colocar o alvo no transe, e o transe se rompe se alguém perturbar o alvo. O hipnotizador também pode colocar a si mesmo em transe.

•• Suggestion (Sugestão): O hipnotizador comanda um alvo a realizar ações após colocá-lo em transe. O psíquico pode dar um comando por sucesso, e o comando não pode obviamente resultar na morte do alvo nem ir contra a Natureza (Nature) do alvo. O psíquico pode forçar o alvo a ignorar respostas de dor e a esquecer comandos dados no transe, como comandos adicionais, se o psíquico gastar sucessos para isso. Apenas o psíquico decide quando o alvo sai do transe. O alvo ignora comandos incompatíveis em vez de romper o transe.

••• Implanted Suggestion (Sugestão Implantada): Um psíquico implanta sugestões que se ativarão fora do transe. Por cada sucesso, o psíquico pode implantar um comando ou uma condição para ativar um comando implantado. Essa condição pode ser um gatilho temporal ou sensorial. Um dos comandos pode ser entrar automaticamente em transe sob uma circunstância especificada. Como em Suggestion, a tentativa falha automaticamente se obviamente resultaria na morte do alvo ou conflitar com a Natureza do alvo. Comandos não são recorrentes a menos que o hipnotizador gaste um sucesso extra para adicionar uma condição recorrente.

•••• Fast Trance (Transe Rápido): O psíquico coloca instantaneamente sujeitos voluntários em transe e pode gastar um ponto de Força-de-Vontade para colocar um sujeito involuntário em transe, embora um sujeito involuntário possa testar Força-de-Vontade (dificuldade 7) para resistir, com cada sucesso anulando um dos sucessos de ativação do psíquico. O número de sucessos de ativação líquidos é o número de turnos que o alvo permanece no transe. O psíquico pode testar para ativar poderes adicionais a partir do seu próximo turno.

••••• Sleeper Agent (Agente Adormecido): O psíquico realiza níveis avançados de lavagem cerebral e condicionamento, do tipo que os governos anseiam. O psíquico implanta comandos para o alvo fazer qualquer coisa, mesmo até o ponto da morte, e o alvo conscientemente não lembra nada do que foi dito durante o transe. Este poder leva 10 minutos para colocar o sujeito em transe, o que não pode ser abreviado com Fast Trance. O alvo deve ouvir claramente a voz do psíquico. Sons e distrações adicionais tornam o uso deste poder impossível, então psíquicos com esta habilidade frequentemente designam salas especiais para esse propósito. O psíquico gasta um ponto de Força-de-Vontade para usar este poder em um sujeito involuntário. Cada sucesso de ativação permite que um comando seja implantado, e cada comando ou condição leva uma hora para ser implantado.]==] },
				["Psychic Invisibility"] = { pt = [==[M20 Sorcerer, pág. 68


Psychic Invisibility


Psychic Invisibility (Invisibilidade Psíquica) não é invisibilidade verdadeira. Este Fenômeno é como Psychic Hypnosis em uma escala maior, mas com escopo limitado. O psíquico engana as mentes dos outros para que simplesmente o ignorem, como se projetasse o comando “não me note”. O psíquico aparece em gravações normalmente, mas quem assiste a uma transmissão ao vivo não nota o psíquico. A atenção dessas pessoas se desvia para outros detalhes da gravação. Esta habilidade não impede o acionamento de alarmes eletrônicos ou mecânicos que não exigem nenhuma entrada humana para disparar, como alarmes de movimento.

Animais não podem ser enganados com este Fenômeno a menos que o psíquico também possua Animal Psychics (Psiquismo Animal) — suas mentes são muito diferentes das de humanos e criaturas humanoides. Se um psíquico bloqueia uma porta ou item que alguém espera ver, o indivíduo afetado também não notará a porta ou o item. Se um ser com percepção aprimorada procura pelo psíquico ou por coisas sobrenaturalmente ocultas de modo geral, ele pode tentar um teste contestado para determinar se o ser perfura a ilusão do psíquico, opondo suas reservas de dados apropriadas aos sucessos de ativação do psíquico.

Os sucessos de ativação determinam a força do efeito do Fenômeno. Um sucesso deixa o psíquico notado, mas difícil de focar e impossível de identificar. Isso também adiciona +1 de dificuldade aos testes de ataque que tenham o psíquico como alvo enquanto estiver ativo. Três ou mais sucessos mantêm o psíquico completamente oculto, a menos que contestado com sucesso. Escudos Mentais (Mind Shields) e alguns efeitos da Esfera da Mente (Mind Sphere) podem proteger contra este Fenômeno.

• Wallflower (Enfeite de Parede): Enquanto o psíquico permanecer completamente imóvel e silencioso, ele continua não notado. Entretanto, o psíquico não precisa prender a respiração — apenas uma respiração pesada ou ruidosa rompe o efeito.

•• Slink (Esgueirar-se): O psíquico se move enquanto invisível, mas não pode interagir de forma significativa com o mundo. O poder se rompe se o psíquico fizer qualquer coisa para chamar atenção para si mesmo ou interagir com o mundo, como escrever em um quadro-negro ou abrir uma porta. Um psíquico pode fazer um teste de Raciocínio (Wits) + Furtividade em dificuldade 7 ou mais para evitar romper acidentalmente seu poder em condições desfavoráveis, como pisos de floresta cobertos de gravetos ou uma sala com alarme de movimento.

••• Invisibility (Invisibilidade): O psíquico pode agora realizar qualquer ação enquanto invisível, mesmo que essas ações normalmente chamassem atenção para o psíquico. Seres com sentidos mundanos podem fazer um teste de Percepção (Perception) + Sensitividade em dificuldade 9 para ver o psíquico se o psíquico atacá-los ou se estiverem especificamente procurando pelo psíquico. O ser que procura deve exceder os sucessos de ativação do psíquico. O psíquico não pode desaparecer enquanto alguém o observa diretamente.

•••• Selective Invisibility (Invisibilidade Seletiva): O psíquico controla para quem projeta o comando “não me note”. Por cada sucesso de ativação, o psíquico pode declarar uma pessoa isenta do efeito. Qualquer pessoa declarada isenta percebe e interage com o psíquico normalmente, mas todos os demais são tratados como se o psíquico tivesse ativado Invisibility. Note que os outros ainda podem perceber qualquer um que interaja com o psíquico, e isso pode atrair atenção negativa.

••••• I Was Never Here (Eu Nunca Estive Aqui): Na expressão mais elevada deste Fenômeno, um psíquico desaparece na frente de testemunhas e apaga sua presença das mentes das testemunhas. O psíquico testa ativação em oposição à testemunha com a maior reserva de Percepção + Sensitividade. A testemunha testa em dificuldade 8. Com um sucesso líquido, o psíquico desaparece de vista, confundindo e desconcertando quaisquer testemunhas. Com três ou mais sucessos líquidos, as testemunhas também esquecem a presença do psíquico por um turno passado por sucesso. É possível que as testemunhas esqueçam de ter visto o psíquico, se a observação foi breve.]==] },
				["Psychic Vampirism"] = { pt = [==[M20 Sorcerer, pág. 69


Psychic Vampirism


Todo mundo conhece aquela pessoa de quem não se consegue ficar perto por muito tempo sem se sentir emocional e espiritualmente drenado. Um vampiro psíquico pode ser qualquer coisa, de um funcionário do DMV, um professor monótono, o colega de trabalho ansioso demais que não para de falar em uma reunião que poderia ter sido um e-mail, ou algo muito mais sinistro. Para um vampiro psíquico, a energia e as emoções que ele drena de suas vítimas desavisadas dão um barato eufórico diferente de qualquer droga, além de outros efeitos benéficos. Como muitas drogas, a sensação pode se tornar viciante.

Não está claro se o poder se desenvolve naqueles propensos a usar os outros como recursos, ou se os efeitos do poder, uma vez desenvolvido, mudam grandemente as pessoas. Em qualquer dos casos, este Fenômeno Psíquico pode trazer à tona o pior nas pessoas. De nota para aqueles que estudam o sobrenatural, vampiros psíquicos frequentemente têm ou desenvolvem muitas das mesmas idiossincrasias psicológicas às quais os Kindred são propensos.

• Tap Energy (Extrair Energia): O vampiro se alimenta das emoções fortes dos outros, tanto positivas quanto negativas. O vampiro sente quais são as emoções enquanto se alimenta e pode usar este poder para avaliar as emoções de um indivíduo ao longo do tempo. Requer apenas um sucesso para saborear o paladar nuançado das emoções de uma pessoa e dar ao vampiro um barato agradável. Com três sucessos, o vampiro recupera um ponto perdido de Força-de-Vontade, e recupera uma Força-de-Vontade adicional por sucesso além do terceiro. O vampiro deve estar a até 10 jardas da vítima e ser capaz de senti-la. A vítima fica desconcertada, e suas emoções ficam contidas — mas não ausentes — até o fim da cena.

•• Invigorate (Vigorar): O psíquico drena as energias vitais de uma vítima para fortalecer a si mesmo. Cada sucesso drena um ponto temporário de Força-de-Vontade da vítima e o adiciona à reserva do vampiro, até um máximo de 10 no total. Cada Força-de-Vontade acima do máximo normal do vampiro dá um barato eufórico e se dissipa a um ponto por hora. O alcance é de 15 jardas, e o vampiro deve sentir a vítima para tomá-la como alvo com este poder.

••• Leech Vitality (Sugar Vitalidade): Este poder extremamente perigoso permite que um vampiro use a força vital de outro para curar a si mesmo e experimentar um barato indescritível. O psíquico deve tocar a vítima por um turno por nível de Vitalidade de dano curado, até os sucessos de ativação. O dano contundente cura primeiro, depois o letal, e então o agravado é rebaixado para letal. Cada sucesso excedente que não resulte em cura restaura 2 pontos de Força-de-Vontade ao psíquico, como em Invigorate. Cada sucesso usado causa um de dano letal à vítima. Se o contato for interrompido antes de terminar, o psíquico não cura e deve fazer outra tentativa.

•••• Essence Feast (Banquete de Essência): O psíquico não está limitado a uma vítima por vez. O psíquico testa ativação para determinar o número máximo de alvos simultâneos, ganhando um alvo adicional por sucesso. Todos os alvos devem estar a até 40 jardas do vampiro, mas o vampiro não precisa ser capaz de sentir todos eles. Ao obter sucesso, o psíquico pode ativar qualquer poder inferior no mesmo turno, usando os custos e o teste de ativação normais associados ao poder inferior. O psíquico fica atordoado no turno seguinte — o influxo de múltiplos perfis de sabor de uma só vez é tão avassalador quanto eufórico para o psíquico. Um desastre pode causar uma “viagem ruim”, como se o psíquico tivesse ingerido alucinógenos, e deixá-lo atordoado pelo resto da cena.

••••• Distant Drain (Dreno Distante): O domínio do vampiro sobre a extração de energias vitais permite que ele volte a extrair de uma vítima anterior a distância. O vampiro deve ter usado Telepathy (Telepatia) ou outro poder de Psychic Vampirism (Vampirismo Psíquico) na vítima anteriormente. Os sucessos de ativação especificam um alcance máximo no qual o vampiro pode usar um poder inferior na vítima.

Sucessos = Alcance
Desastre = Não pode usar Psychic Vampirism neste alvo por um mês
Falha = Nada acontece
1 = 500 jardas
2 = 1 milha
3 = 2 milhas
4 = 5 milhas
5 = 10 milhas
6+ = +10 milhas por cada sucesso acima de 5]==] },
				["Psychokinesis"] = { pt = [==[M20 Sorcerer, pág. 70


Psychokinesis


De vez em quando, surge um vídeo no YouTube, um especial de TV, um programa de variedades ou um livro publicado sobre algum mestre iluminado que expandiu a mente até o ponto de conseguir dobrar uma colher ou deslocar um livro 6 polegadas sobre uma mesa. Toda pessoa que assiste ou lê sobre esses feitos fica admirada e maravilhada com a possibilidade de mover objetos pela pura força da mente.

A psicoquinese (psychokinesis), ou telequinese (telekinesis) para alguns, é bela em sua simplicidade. Não há truques sutis nem véus ilusórios. Há apenas o simples movimento da matéria através do espaço pela pura força de vontade. Conforme o psicoquineta (psychokinetic) cresce em força, ele aperfeiçoa sua precisão e aumenta o peso máximo que pode pôr em movimento. Os inexperientes só movem objetos pequenos, e de forma muito desajeitada. Por outro lado, um mestre psicoquineta pode levantar cargas enormes e movê-las a velocidades assustadoras, sendo também capaz de feitos de motricidade fina que a maioria tem dificuldade de executar com as próprias mãos.

A psicoquinese concede ao psíquico uma pontuação de Força e Destreza para suas ações, uma vez ativada. Isso exige apenas uma ativação por instância do Fenômeno e permanece ativo enquanto o psicoquineta mantiver a concentração ou até o fim da cena. Usar a psicoquinese exige que o psíquico consiga ver o alvo pretendido com os próprios olhos. Cada sucesso na rolagem de ativação permite que um alvo separado seja manipulado, mas o peso total de todos os alvos não pode exceder a capacidade de levantamento do psíquico. Sempre que o psíquico sofrer dano, ele deve fazer uma nova rolagem de Força-de-Vontade para manter a concentração. Se obtiver menos sucessos do que o número de alvos que está manipulando no momento, deve escolher alvos para liberar até que o número de alvos corresponda ao novo total de sucessos. Se mais sucessos forem obtidos, o número de alvos manipulados permanece inalterado.

Um psicoquineta com poder para levantar uma pessoa pode fazê-lo sem impedimentos. O alvo tem direito a um teste de Força + Esportes para se agarrar a um ponto de ancoragem firme, caso haja algum por perto onde se segurar. Se não houver um ponto de apoio seguro, o alvo fica impotente para deter o poder do psicoquineta, salvo se tiver vantagens sobrenaturais próprias.

Uma vez que um alvo está sendo manipulado, as ações realizadas com o alvo usam a Força ou a Destreza da Psicoquinese do psíquico e a Habilidade apropriada exigida para a ação. Por exemplo, uma arma de fogo sendo manipulada exigiria um teste de Destreza psicoquinética + Arm. Fogo para disparar. “Arremessar” um objeto manipulado exige que o item seja liberado enquanto é propelido com um teste apropriado de Força + Esportes. A desconexão e a falta de contato com um alvo manipulado fazem com que todas as ações realizadas por meio da manipulação psicoquinética sofram +1 de dificuldade. Tentar realizar uma ação psicoquinética com mais de um item manipulado no mesmo turno exige que o psíquico divida sua parada de dados normalmente, como ao realizar ações múltiplas.

• Com Força e Destreza mentais de 0, o psíquico só pode levantar no máximo 5 libras. Os objetos seguem um caminho lento e desajeitado pelo espaço quando movidos e têm velocidade máxima de 5+ Raciocínio (Wits) jardas por rodada.

•• A Força e a Destreza mentais do psíquico sobem para 1, e os objetos têm movimento de 7+ Raciocínio jardas por rodada.

••• O poder e a compreensão crescentes proporcionaram ao psicoquineta Força e Destreza mentais de 2. Os alvos manipulados se movem a 9+ Raciocínio jardas por rodada.

Desbloquear ainda mais sua compreensão da força cinética como ferramenta da mente dá novos frutos. O psíquico agora pode fazer um ataque à distância com sua ação pela pura força. A força psicoquinética atinge como um soco à distância, usando a Força mental do psíquico e sua Briga ou Artes Marciais como parada de dados para atacar, com dano base igual à sua Força mental. Esse ataque representa um uso concentrado do Fenômeno e não pode ser utilizado enquanto se realiza qualquer outra ação psicoquinética. Essa aplicação também é instantânea e exige o custo total de ativação do Fenômeno todas as vezes.

•••• A Força e a Destreza mentais do psíquico agora são 3, e ele pode mover objetos manipulados a 11+ Raciocínio jardas por rodada.

Mais uma nova aplicação se torna disponível ao psicoquineta. O psíquico internalizou sua força psicoquinética e agora pode levitar a si mesmo, independentemente do peso, a uma taxa equivalente à sua velocidade de caminhada. Esse uso do Fenômeno exige maior concentração do que a maioria e, portanto, não pode ser empregado enquanto se levantam outros alvos.

••••• Um mestre psicoquineta tem Força e Destreza mentais de 4 e pode mover alvos manipulados a uma taxa de 15+ Raciocínio jardas por rodada.

Ambas as ações refinadas do fenômeno recebem melhorias neste nível. A levitação agora é algo natural e pode ser realizada enquanto se levantam outros alvos, e os ataques psicoquinéticos agora podem causar dano contundente ou letal.]==] },
				["Psychometry"] = { pt = [==[M20 Sorcerer, pág. 72


Psychometry


A psicometria (psychometry) é um dos Fenômenos mais desgastantes emocionalmente para os psíquicos dotados — ou amaldiçoados — com ela. Ao tocar objetos, o psíquico pode ler as ressonâncias emocionais deixadas para trás e ver visões associadas ao objeto. Nem sempre é claro quais objetos têm ressonâncias fortes: uma caneca de café de escritório pode ter apenas impressões passageiras. No entanto, ela pode ser um presente querido de um filho ou mesmo a caneca que uma trabalhadora tinha na mão quando soube da morte de uma pessoa amada.

Leva meros segundos para ler as ressonâncias, mesmo que a visão pareça durar muito mais tempo da perspectiva do psíquico. O número de sucessos na ativação determina o nível de detalhe que o psíquico recebe. Muitos sucessos dão impressões claras e vívidas, que tendem a fazer o psíquico sentir as emoções e a dor por um tempo, enquanto menos sucessos dão apenas impressões passageiras. Em um desastre, o psíquico se perde nas visões, fundindo-se temporariamente em personalidade com um dos indivíduos do evento e possivelmente encenando-o. Quando um psíquico com Psicometria toca um objeto de imensa ressonância emocional, o Narrador pode pedir uma rolagem reflexiva de Psicometria.

• Impression (Impressão): O psíquico pode obter impressões oníricas de eventos recentes envolvendo o objeto ou de eventos mais distantes com fortes emoções associadas. O psíquico, neste estágio, obtém principalmente leituras emocionais e imagens vagas e figurativas. Com 3+ sucessos, o psíquico também pode ver uma imagem precisa da pessoa mais intimamente associada ao objeto.

•• Reveal Scar (Revelar Cicatriz): O psíquico obtém impressões do evento com a mais forte ressonância emocional associada ao objeto. Ele recebe imagens oníricas e imprecisas do evento. Com 3+ sucessos, também determina a idade aproximada do dono, indícios de personalidade, a conexão com o objeto e o que o dono sentiu na ocasião.

••• Replay (Reprise): O psíquico vivencia claramente o evento e pode reunir impressões gerais sobre o que aconteceu com o dono do objeto no dia do incidente. Alternativamente, o psíquico pode reproduzir as últimas 24 horas do objeto, mesmo que nada emocionalmente significativo tenha acontecido.

•••• Tether (Vínculo): O psíquico pode usar o objeto como um vínculo psíquico com o dono do objeto. Ativar este nível dá ao psíquico uma percepção da localização atual do dono para rastreá-lo. Além de ver claramente o evento com a mais forte ressonância emocional associada ao objeto, ele também lê impressões emocionais e visões das outras pessoas presentes no evento e dos sentimentos delas.

••••• Catalog (Catálogo): O psíquico pode usar Tether em qualquer evento ao qual o objeto esteve associado, não apenas naqueles com o maior impacto emocional.]==] },
				["Psychoportation"] = { pt = [==[M20 Sorcerer, pág. 73


Psychoportation


A psicoportação (psychoportation), também chamada às vezes de teleportação, é uma poderosa habilidade psíquica de estar subitamente em outro lugar. Este é um dos fenômenos psíquicos mais poderosos e raros. O ocasional Mago da Esfera de Correspondência de mente fechada já foi posto em seu lugar ao ver um simples psíquico se psicoportar para fora do caminho do perigo sem atrair a ira da Realidade.

Ninguém sabe ao certo como a psicoportação funciona, mas algumas teorias incluem dissipar-se no ar e reformar-se em outro ponto, uma variação da viagem astral ou buracos de verme pessoais. O que se sabe é que um psíquico não pode carregar mais de cerca de 100 libras de carga extra sem sofrer tensão severa, causando ao psíquico no mínimo 6 níveis de dano contundente que podem ser absorvidos normalmente. Isso aumenta em 1 nível de dano contundente para cada 25 libras adicionais que o psíquico tentar mover. Falhar em absorver o dano resulta em um destino desastroso para a carga, como psicoportar o conteúdo para o local errado, para dentro de um objeto sólido ou para o corpo de água mais próximo. Em raras ocasiões, a carga aparentemente deixa de existir. Para viajar a um lugar por meio da psicoportação, o psíquico deve ver o destino pretendido com sentidos mundanos ou habilidades psíquicas — próprias ou de outra pessoa.

Um desastre em psicoportação normalmente significa que o psíquico calculou mal o salto e aterrissou dentro de um objeto sólido — ou pior, de uma pessoa. Isso causa 8 dados de dano agravado ao psíquico e ao objeto desavisado. Ocasionalmente, um desastre pode transportar o psíquico para um local perigoso ou desconhecido, ou o psíquico pode deixar para trás ou trazer inadvertidamente algo que não devia.

• Short Hop (Salto Curto): Alcance de até 12 + Inteligência jardas em um turno.

•• Simple Jump (Salto Simples): Alcance de até 20 + (3 x Inteligência) jardas.

••• Long Jump (Salto Longo): Alcance de até 40 + (6 x Inteligência) jardas. O psíquico pode gastar um turno de concentração e rolar a ativação com +1 de dificuldade para dobrar esse alcance.

•••• Leap (Salto): Alcance de até 80 + (12 x Inteligência) jardas. O psíquico pode dobrar, conforme Long Jump.

••••• Leap of Faith (Salto de Fé): O psíquico não precisa mais sentir um local estável para se psicoportar até ele. O psíquico pode gastar uma cena estudando o local e rolar com sucesso Percepção + Prontidão em dificuldade 8 para memorizá-lo.]==] },
				["Pyrokinesis"] = { pt = [==[M20 Sorcerer, pág. 74


Pyrokinesis


O saber parapsicológico fala de “Firestarters” (Incendiários), indivíduos capazes de iniciar e às vezes controlar o fogo psiquicamente. Alguns parapsicólogos suspeitam que a Pirocinese (Pyrokinesis) seja uma variante da Psicocinese (Psychokinesis), na qual o psíquico faz as moléculas vibrarem a altas velocidades, gerando combustão em vez de mover objetos inteiros de forma coesa.

A Pirocinese é um dos Fenômenos Psíquicos mais perigosos para os próprios psíquicos; a maioria dos psíquicos não tem mais defesa contra as chamas que cria do que qualquer outro humano. Desastres podem ser espetacularmente desastrosos, e vários pirocinéticos se foram num literal clarão de glória.

• Spark (Faísca): O pirocinético pode gerar pequenas faíscas, normalmente a partir das pontas dos dedos. Essas faíscas normalmente só conseguem incendiar substâncias altamente inflamáveis, como papel ou gasolina, mas com 3 ou mais sucessos as faíscas do psíquico podem incendiar materiais como um fósforo faria. As faíscas podem acender qualquer coisa ao alcance do pirocinético, embora ele não precise tocar o alvo. Mesmo com muitos sucessos, as faíscas não são quentes o bastante para incendiar diretamente uma pessoa, embora o efeito de uma chama surgindo possa assustar alguém. Após a ativação, trate as faíscas como um ataque de arremesso com uma arma que não causa dano. Isso pode ser esquivado normalmente. Se o ataque acertar, o alvo rola Força-de-Vontade com dificuldade 6 para evitar ficar atordoado por um turno. Em um desastre, o alvo entra em pânico. O alvo pode, em vez disso, gastar um ponto de Força-de-Vontade para suprimir a reação de susto.

•• Combustion (Combustão): O psíquico se concentra em um objeto a até 10 jardas, fazendo-o irromper em chamas. O psíquico pode incendiar de forma confiável materiais inflamáveis como gasolina, madeira seca, carvão e vampiros. Com 3 ou mais sucessos, o psíquico pode incendiar qualquer coisa combustível, como pessoas. O fogo inicial é do tamanho de uma tocha e se comporta e se espalha normalmente. Se o psíquico tiver como alvo uma pessoa ou as roupas de uma pessoa, o alvo pode tentar esquivar normalmente, tratando os sucessos de ativação como a rolagem de mira.

••• Sun’s Fury (Fúria do Sol): O psíquico agora pode transformar pequenas esferas de ar em plasma e chama, que incendeia prontamente quase tudo o que toca. Este poder causa incêndios do tamanho de uma fogueira a até 10 jardas de distância, causando dois de dano agravado por turno pelo calor intenso. Os alvos podem tentar esquivar normalmente, tratando os sucessos de ativação como a rolagem de mira. Se acertado, o alvo deve gastar um ponto de Força-de-Vontade ou rolar Força-de-Vontade com dificuldade 6 para conseguir evitar o pânico. Se permanecer calmo, o alvo pode imediatamente usar sua ação para rolar Destreza + Esportes com dificuldade 5, apagando as chamas em si mesmo com um sucesso.

•••• Pyrotechnics (Pirotecnia): O pirocinético ganha controle sobre as chamas, incluindo as produzidas por níveis inferiores de Pirocinese. O psíquico pode aumentar, diminuir, direcionar e moldar chamas dentro de sua linha de visão à vontade. Com um sucesso, o psíquico pode controlar uma porção de chamas do tamanho de uma tocha. Com três sucessos, o psíquico arranca o controle de uma fogueira. Com cinco ou mais sucessos, o psíquico pode comandar até um inferno. Ter indivíduos como alvo com chamas é um ataque de Raciocínio + Esportes com dificuldade 7, com +1 de dificuldade para evitar ferir transeuntes próximos no processo. Este ataque pode ser esquivado. Um psíquico pode apagar uma chama à vontade. Uma fogueira ou chama menor é apagada instantaneamente, mas qualquer chama maior leva um turno inteiro de concentração para ser apagada.

••••• Inferno (Inferno): O pirocinético agora comanda chamas maiores e de crescimento mais rápido, que podem aparecer em qualquer lugar da linha de visão do psíquico. As chamas consomem tudo o que está dentro delas com 3 de dano agravado por turno, embora alvos nas bordas externas possam esquivar como em Sun’s Fury. Com um sucesso, a chama inicial é um fogo pequeno, mas com três sucessos as chamas enchem um grande salão, até um máximo de Força-de-Vontade vezes 3 jardas quadradas. Se o psíquico mantiver a concentração, as chamas resistem a ser apagadas por meios mundanos, levando rodadas iguais aos sucessos obtidos na rolagem de ativação para serem apagadas por sufocamento, água ou produtos químicos retardantes de chama. Se o psíquico quebrar a concentração, como ao sofrer dano ou ser derrubado inconsciente, as chamas perdem todas as propriedades sobrenaturais e podem ser apagadas normalmente.]==] },
				["Shadow"] = { pt = [==[M20 Sorcerer, pág. 74


Shadow


Vivemos em um mundo de luz e sombra. O psíquico que entende isso e aprende a manipular um lado dessa moeda está aproveitando um recurso sempre presente. Seja sob uma saliência, atrás de uma pilha de caixas, ou simplesmente nas rugas e fendas do rosto de alguém, o psíquico que manipula sombras pode usá-las para ocultar e confundir.

Teorias supersticiosas abundam sobre o que o psíquico que maneja Sombras (Shadow) está realmente fazendo. O fato simples é que ele está manipulando a luz — e o som, em grau limitado — para amortecer o mundo ao seu redor. Pode parecer que o psíquico de Sombra está manejando a escuridão, mas tudo se resume a ciência simples. A escuridão fica mais escura e o som fica abafado conforme a pura vontade do psíquico sufoca as formas de onda ativas no ambiente. A atmosfera assustadora e a reputação são apenas um bônus.

Por mais que as sombras possam esconder, a utilização adequada deste Fenômeno pode fornecer distrações significativas. Luz e som são interceptados antes que possam alcançar os sentidos do alvo, dando à vítima a sensação de que sua cabeça está envolta em uma manta invisível. Conforme o poder do psíquico aumenta, isso é cada vez mais angustiante, pois o cérebro pode interpretar essa perda de sentidos como sufocamento iminente. Embora cruel na avaliação de alguns, pode ser uma ferramenta especialmente útil para tirar alguém do seu caminho.

• Dispersar as bordas das sombras projetadas e perturbar o som só é suficiente para aumentar a eficácia da ocultação e da desmoralização. As sombras ficam ligeiramente mais longas, alcançam um pouco mais longe, enquanto os sons são todos inquietantemente abafados. Todas as rolagens de Intimidação e Furtividade têm sua dificuldade ajustada em −1. Alvos distraídos por sombras que escurecem e por sons abafados sofrem +1 de dificuldade em todas as rolagens que dependem de visão e audição.

•• As sombras agora crescem e se curvam à vontade do psíquico. Os sons agora confundem e distorcem, tendo a qualidade de serem tocados por um alto-falante estourado. O psíquico encarna o idiomatismo de “to darken a doorstep” (“escurecer a soleira de uma porta”), pois as salas perdem luz quando ele chega. As rolagens de Intimidação e Furtividade são feitas com −2 de dificuldade.

••• Não apenas as sombras ficam mais escuras, mas agora os esforços do psíquico fazem as fontes de luz perderem sua potência. O som viaja pela sala em ondulações erráticas, e as palavras que são inteligíveis têm um atraso perceptível em relação a quem fala. Tentativas de ver o psíquico oculto sofrem +3 de dificuldade. Os atormentados começam a sentir uma ansiedade crescente e devem fazer uma rolagem de Força-de-Vontade (dificuldade 7) para evitar o pânico, sofrendo uma penalidade de -1 em todas as ações que não envolvam sair da cena, caso falhem.

•••• Espalhando seu dom de refúgio escuro, o psíquico agora pode encobrir um pequeno grupo de três ou quatro pessoas, possivelmente até um pequeno cupê ou sedã.

Vítimas de assédio sombrio devem fazer uma rolagem de Força-de-Vontade (dificuldade 8) para evitar entrar em pânico e sair imediatamente da cena para escapar da escuridão. Intimidação e Furtividade têm −4 de dificuldade em condições propícias à exploração. Um armazém já escuro, uma floresta sombria à noite, ou um estacionamento mal iluminado, todos pedem para ter suas sombras profundas encorajadas pelo psíquico. Essa quantidade de manipulação de sombras tem um efeito inverso em ambientes mais claros, como o meio-dia em um estacionamento aberto ou ao ficar em um campo esportivo escolar com todas as luzes acesas. A escuridão ao redor do psíquico atrai mais atenção no brilho do meio-dia do que desvia.

••••• Em ambientes onde a escuridão já habita, o psíquico é mestre. Estar em um local onde as condições favorecem as sombras dá ao psíquico a chance de sufocar toda a luz ao seu redor até 50 pés. A escuridão é quase impenetrável para aqueles sem visão mística, pois até lanternas de mão de alta potência são engolidas pelo negrume. Todos os que estão dentro ficam completamente encobertos e invisíveis para o exterior e para os outros que estão dentro, exceto o psíquico. A escuridão é a dele, afinal.]==] },
				["Synergy"] = { pt = [==[M20 Sorcerer, pág. 75


Synergy


Uma habilidade sutil, psíquicos sinergéticos muitas vezes não sabem que têm qualquer talento psíquico até depois de conhecer outros psíquicos — é incomum, mas não inédito, que desenvolvam outros Fenômenos Psíquicos. Este fenômeno é considerado raro, mas a natureza sutil do poder pode ocultar o verdadeiro número de sinergistas no mundo. A Sinergia (Synergy) permite que psíquicos trabalhem juntos para construir efeitos mais poderosos do que qualquer um dos psíquicos poderia criar por conta própria.

Os psíquicos devem estar se tocando para formar um vínculo sinergético. O sinergista pode vincular um número de psíquicos igual ao dobro dos pontos que possui em Sinergia. Cada sucesso acima de um adiciona sucessos automáticos que podem ser gastos em ações que os psíquicos vinculados realizem usando Fenômenos. Desastres podem causar contragolpes para todos os envolvidos, sendo o melhor cenário uma dor de cabeça ou um sangramento nasal, enquanto o pior caso pode fazer os fenômenos psíquicos daqueles no vínculo se ativarem descontroladamente.

• Like Knows Like (Igual Reconhece Igual): O sinergista pode sentir outros psíquicos. Isso tem sucesso automático se o psíquico tocar outro, mas o sinergista pode rolar ativação para varrer em busca de psíquicos na linha de visão. Com 3 ou mais sucessos, o sinergista pode sentir o poder relativo dos outros psíquicos.

•• Share Will (Compartilhar Vontade): O sinergista forma um vínculo psíquico fraco para aumentar o poder dos participantes. Cada psíquico pode gastar um ponto de Força-de-Vontade para um sucesso automático no efeito de outro, ou permitir que o psíquico “empreste” a Força-de-Vontade e adicione temporariamente o ponto à sua reserva, até um máximo de 10. Se a Força-de-Vontade não for gasta, ela pode ser negociada múltiplas vezes entre os psíquicos no vínculo. Quaisquer Fenômenos sensoriais (Telepatia [Telepathy], Precognição [Precognition], etc.) permitem que todos os psíquicos no vínculo compartilhem os resultados.

••• Share Powers (Compartilhar Poderes): O sinergista forma um vínculo mais forte, permitindo que todos os psíquicos usem seus poderes como um grupo. Cada psíquico pode doar até dois poderes, pontos de Força-de-Vontade, ou um de cada. Apenas uma rolagem de ativação é necessária para poderes de grupo.

•••• Power Gestalt (Gestalt de Poder): Como Share Powers, mas agora os psíquicos no vínculo podem combinar efeitos de habilidades para formar um único poder compartilhado. Por exemplo, o grupo poderia combinar Psiquismo Animal (Animal Psychics) e Invisibilidade Psíquica (Psychic Invisibility) para conseguir passar despercebido por cães de guarda.

••••• Power Network (Rede de Poder): O sinergista pode vincular outros psíquicos e remover a necessidade de os psíquicos se tocarem, ou mesmo de estarem no mesmo lugar. Um psíquico com este nível de Sinergia primeiro vincula todos como nas habilidades inferiores, gastando 10 minutos em foco e meditação combinados para cimentar os laços. Uma vez formado o vínculo, os psíquicos em rede permanecem vinculados e capazes de usar qualquer uma das habilidades inferiores por um número de horas igual aos sucessos de ativação. Este vínculo não se desfaz com a distância, mas se um psíquico no vínculo sofrer dano igual ou superior ao seu Vigor de uma única fonte, todos os psíquicos na rede devem fazer uma rolagem de Força-de-Vontade com dificuldade 7 ou ser ejetados da rede. Se o psíquico que formou a rede for ejetado, derrubado inconsciente ou morto, a rede automaticamente colapsa.]==] },
				["Telepathy"] = { pt = [==[M20 Sorcerer, pág. 76


Telepathy


Diz-se que existem dois tipos de pessoas no mundo: pessoas que desejariam poder ler mentes e mentirosos. Essa afirmação, em si mesma, é uma mentira. Isso porque existem pessoas no mundo que realmente podem ler mentes, e elas são conhecidas como telepatas. Uma vez que sintam a mente de um alvo, esses psíquicos podem sondar seus pensamentos em busca de opiniões, desejos, fantasias e emoções.

Conforme a perícia e o poder melhoram, o telepata pode aprender a transmitir seus pensamentos para os outros. A comunicação dessa maneira pode ser, na melhor das hipóteses, inquietante para os despreparados, e potencialmente traumatizante. Telepatas compassivos tomam tempo para informar aqueles com quem pretendem se comunicar telepaticamente sobre o que está por vir, para evitar possíveis gritos e confusão incoerente causados por uma invasão mental não anunciada.

Aqueles que dominaram seu talento vão um passo além e fazem essas transmissões parecerem pensamentos originais, implantando ideias nas mentes de seus alvos. Isso não é nenhum tipo de controle mental ou hipnose, como se poderia pensar. Em sua essência, esta habilidade é mais parecida com ventriloquismo — uma forma de ventriloquismo essencialmente semelhante a gaslighting psíquico, e um ato muito perigoso e imoral, mas ventriloquismo, ainda assim. O telepata imita o diálogo interior do alvo e faz sugestões como se o pensamento viesse da própria mente do sujeito. Os usos deste talento vão desde o pensamento relativamente benigno de “eu bem que comeria um lanche” até projeções muito mais sinistras. Ler os pensamentos do alvo e então imitar e repetir seus impulsos mais sombrios até a exigência é apenas um exemplo perturbador do potencial de abuso telepático.

• Todos os telepatas começam sentindo os pensamentos superficiais e as emoções de um sujeito. As emoções incluem o humor atual, o desejo imediato e o bem-estar mental. Pensamentos superficiais são músicas presas na cabeça, a recordação ativa de coisas como uma lista de compras ou um código de acesso enquanto ele é digitado, ou o que eles acham que era aquele cheiro que acabaram de sentir.

•• Os pensamentos internos se abrem para o telepata. A cada sucesso na rolagem de ativação, o telepata pode fazer uma única pergunta sobre as ruminações subsuperficiais do alvo. Essas respostas têm uma frase de extensão e são o mais diretas possível. Pensamentos internos incluem inclinações políticas, livros ou filmes favoritos, ou memórias recentes.

Os inícios da comunicação telepática também se abrem neste nível. Para cada sucesso na rolagem de ativação, o telepata pode enviar ou receber uma frase de comunicação mental. Essas comunicações acontecem na velocidade do pensamento e, como tal, não ocupam nenhum tempo dentro de uma rodada nem exigem qualquer divisão de reserva de dados para múltiplas ações.

••• Pensamentos mais profundos são revelados ao telepata. Como nos níveis anteriores, cada sucesso na rolagem de ativação permite uma única pergunta que é respondida pelo alvo. Essas respostas podem ser mais detalhadas quando o assunto da pergunta não é um segredo bem guardado. Pensamentos mais profundos incluem memórias dos últimos 5 anos, senhas de contas de redes sociais e cartões bancários, e os nomes de todos, da família imediata à estendida.

A comunicação telepática vem muito mais facilmente neste estágio. Para cada sucesso na rolagem de ativação, o telepata pode enviar e receber várias frases (duas ou três) de comunicação. Novamente, essas comunicações acontecem na velocidade do pensamento e seguem as mesmas regras acima.

•••• Pensamentos subconscientes e os recessos mais profundos da mente estão ao alcance do telepata. Cada sucesso na rolagem de ativação permite uma única pergunta que é respondida pelo Narrador. Nada dentro da mente está fora dos limites neste ponto. Memórias que remontam à infância, códigos esquecidos de instalações em que costumavam trabalhar, e mesmo pensamentos que têm e que negam a si mesmos sobre seus entes queridos são todos alvos legítimos.

As conversas por conexões telepáticas não estão mais limitadas a frases. Conversas completas entre duas pessoas acontecem em um piscar de olhos. A melhoria mais impressionante é que os vínculos telepáticos podem ser ampliados para uma rede. Cada sucesso na rolagem de ativação permite que outra mente seja adicionada à conversa. Quando múltiplas mentes são adicionadas ao vínculo do psíquico, a largura de banda telepática excedente desacelera, pois a mente do psíquico está agindo como um roteador central. Conversas assim acontecem em tempo real, como se todos os envolvidos estivessem falando uns com os outros ao redor de uma mesa.

••••• Por insidioso que seja, o telepata agora pode implantar pensamentos subversivos nas mentes de seus alvos. Esses pensamentos podem ser de qualquer coisa, mas qualquer linha de pensamento que ainda não estivesse presente na mente do alvo requer uma rolagem de Manipulação + Lábia (dificuldade 7) para implantar pensamentos que complementem a personalidade e os desejos do alvo. Pensamentos implantados que vão contra a personalidade e os desejos do alvo sofrem +2 de dificuldade na rolagem. Caso esses pensamentos criem raízes, o alvo começará a agir de acordo com eles na primeira oportunidade conveniente, convencido de que os pensamentos são seus.]==] },
				-- True Faith is not one of the 43 above: it is the single Path of its own Numina
				-- and it has its own two-entry picker (SPEC T81/T82, R.16). Same shape as the
				-- rest so the renderer and the gate treat it identically.
				["True Faith"] = { pt = [==[The Hunters Hunted II, pág. 83


True Faith


Sistemas para a Fé Verdadeira

Diferente dos outros Caminhos de Númina, a Fé Verdadeira possui um único Caminho.

A Fé Verdadeira concede aos crentes benefícios especiais:

• Cada nível de Fé Verdadeira concede um ponto extra de Força de Vontade.

• Cada ponto de Fé Verdadeira age como um dado de proteção divina para resistir aos efeitos de Núminas, Disciplinas de vampiros ou outros poderes sobrenaturais. Quando um personagem seria afetado por uma Disciplina de Kindred ou outro poder, seu jogador pode gastar um ponto de Força de Vontade e rolar o índice de Fé Verdadeira do personagem como reserva de dados contra uma dificuldade de 7. Os sucessos obtidos nessa rolagem subtraem sucessos da rolagem de ativação do poder em questão. Essa proteção afeta apenas poderes que afetariam o personagem diretamente, e somente se uma rolagem de dados for necessária para determinar seu grau de sucesso. Ela não oferece proteção alguma contra usos passivos ou indiretos de poderes como Percepção de Aura ou Fortitude.

A Númina da Fé Verdadeira, como qualquer outra, tem um índice de 1 a 5. Exatamente qual proteção é concedida ao indivíduo depende desse índice, conforme descrito abaixo. A seu critério, os Narradores podem querer emendar ou alterar esses benefícios para refletir a intervenção de poderes superiores conforme isso ilustre os temas de suas próprias crônicas.

Níveis de Fé Verdadeira

• Qualquer personagem com Fé Verdadeira pode tentar repelir vampiros, fantasmas e outras criaturas sobrenaturais brandindo um símbolo sagrado ou proferindo orações. O jogador do Fiel gasta um ponto de Força de Vontade e rola o índice de Fé Verdadeira de seu personagem contra uma dificuldade igual à Força de Vontade permanente da criatura.

Os sucessos obtidos indicam o número de turnos que a criatura deve fugir do personagem enquanto ele invoca a proteção da oração ou do símbolo sagrado. Se a rolagem de ativação não render sucesso algum, a criatura sobrenatural não precisa recuar, mas não pode avançar. Uma falha crítica indica que ela pode avançar sem impedimento. Se o símbolo religioso for encostado no corpo de um vampiro, cada sucesso causa um nível de dano agravado, queimando a carne da criatura.

•• O Fiel pode sentir a presença de um vampiro. Ele não precisa tentar detectar conscientemente a presença do vampiro, mas precisa estar em um ambiente pacífico e silencioso, talvez sozinho com seus pensamentos, orando, lendo um livro religioso, meditando, etc. O Fiel não sentirá o vampiro se estiver preocupado (p.ex., discutindo) ou em um lugar lotado e ruidoso (acotovelado por uma multidão, no meio de uma festa, etc.). Essa habilidade não acende o vampiro como um farol; o Narrador revela a presença do vampiro apenas quando a atenção do Fiel indicaria isso. Note que o personagem não sabe exatamente o que sente através de sua fé. Tudo o que ele sabe é que algo sinistro está por perto.

••• O Fiel é imune a Quimerismo, Demência, Dominação, Ofuscação e outros efeitos sobrenaturais que confundem a mente.

•••• O Fiel não pode ser transformado em carniçal. Ele não é afetado por Presença nem por outros efeitos sobrenaturais que manipulam emoções.

••••• A mera presença do Fiel pode encher um vampiro ou outra criatura sobrenatural de auto-ódio, nojo, terror ou até dor física. O jogador de qualquer vampiro que ouça o Fiel orar ou pregar, ou que seja tocado pelo Fiel, deve obter sucesso em uma rolagem de Rötschreck (dificuldade 9) para resistir a fazer o Kindred fugir imediatamente e pela duração da cena. Um vampiro incapaz de fugir é reduzido a um destroço balbuciante, se debatendo no chão, gritando, soluçando ou implorando por misericórdia.

Milagres da Fé Verdadeira

Um milagre é uma instância de intervenção divina direta. Os Fiéis costumam orar ao divino como forma de adoração e meditação. Em ocasiões raras e inspiradoras, o divino responde a uma oração na forma de um milagre. Tais milagres devem ser raros, nunca mais de um por história, e sempre dramáticos.

O Narrador deve examinar a motivação do personagem que invoca o milagre. O divino provavelmente não se importa se o Fiel quer dirigir um carro de luxo, ganhar na loteria ou mesmo sobreviver a um encontro com um vampiro qualquer. Toda religião tem seus mártires, e a morte às vezes faz parte do plano divino. Orações que são altruístas e buscam ajudar ou inspirar outros têm a melhor chance de serem respondidas. Não existe sistema rígido para invocar milagres — é simplesmente um lembrete dramático de que indivíduos Fiéis carregam um dever divino e podem ocasionalmente servir como condutos para a vontade de seu poder maior no mundo.

Milagres são impossíveis de definir mecanicamente, pois devem ser especificamente adaptados à situação. Alguns exemplos incluem:

• Ajudar uma mulher estéril a poder ter um filho

• Curar uma doença terrível e dolorosa, como o câncer

• Ajudar alguém preso sob um prédio desabado

• Encontrar-se ao lado de um amigo em necessidade desesperada]==] },
				-- <<< DESC_END
};
