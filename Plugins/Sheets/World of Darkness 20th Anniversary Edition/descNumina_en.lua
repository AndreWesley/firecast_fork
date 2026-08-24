-- Numina descriptions, the [en] half (SPEC T495, V210).
--
-- descNumina.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [en] only, descNumina_pt.lua holds the other, the two carry the SAME
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
				["Alchemy"] = { en = [==[M20 Sorcerer, p. 18


Alchemy


The study of transformation and purification, Alchemy is an ancient art and science. Practitioners draw from disparate practices, both magical and scientific, to understand the hidden properties of matter and the soul. The most traditional goal of alchemy is not the more famous transformation of base matter into more “noble” counterparts — such as lead into gold — but rather the perfection of the alchemist.

As a Path, Alchemy creates one-use magic items and transformations. Many of the things it produces are meant to be ingested, though few are made with taste or even the health and wellness of the consumer in mind. Alchemy also produces coatings that may be applied to the skin or objects, and reagents that catalyze transmutations of base elements into other matter.

Though often studied as a means of perfecting the soul, this pursuit is very much bound up with actual Alchemical practice. Other practices put their own spin on it: Practitioners of Witchcraft call the Path Herbalism and focus on natural ingredients and effects related to them, while Hypertech engineers and tinkerers utilizing Weird Science call it Advanced Chemistry, and completely eschew the metaphysical implications the Alchemy practice places on the Path.

In all cases, the Path of Alchemy is expensive. For most versions of the Path, it requires a well-equipped laboratory and strange ingredients. The most powerful applications require increasingly exotic components and extremely specialized Tass. Though the Herbalism variant tends to be cheaper in terms of money, it requires more time and effort, with plants and fungi collected under strict conditions.

Many applications of this Path have passed into legend. Few alchemists are known to have actually completed the so-called “Great Work,” the creation of a Philosopher’s Stone, or any other product conducive to immortality, but most masters of the Path make an attempt.

This Path has no spells. It does everything through rituals called recipes.

System

Modifiers: Once the magician successfully follows a recipe three times, the difficulty is reduced by one.

Time: Alchemy takes longer to obtain results than most Paths. Recipes require one day per level to prepare, but this can be shortened if the Path Ability exceeds the recipe level. Each dot of the Ability higher than the ritual level reduces the total time spent by one day. If this would reduce preparation time below one day, instead assume several hours of work.

Duration: Effects last for a single scene unless otherwise noted.

Effects: Alchemy doesn’t have Aspects; instead, each dot increases the practitioner’s power and control. Except for the most potent recipes, they only require a single success to make. Additional successes are split between providing additional doses and keeping those doses potent for one day per success spent.

• Distillations at this level do not appear magical in any way. These recipes are simply more advanced versions of extant chemicals and concoctions, producing more potent painkillers, poisons, glues, solvents, etc., and increasing the Toxin Rating of the chemical by one (as per Mage 20 p. 442). Higher Path levels can further alter the Toxin Rating, increasing or decreasing the rating by one per dot.
•• Now the substances created let the imbiber exceed their usual physical limits. Any one Attribute can be increased by one dot, up to a maximum of five, for the scene. Special preparations can expand one’s mystical awareness, mostly through induced dreams or hallucinations. These visions are left to the Storyteller’s discretion and should remain cryptic and uncertain. Visions attained at this level lack the power of a system benefit and are included as a narrative device.
••• Not only can the alchemist now enhance their targets beyond the normal capabilities of humans, but they can also grant low-level psychic abilities (see Chapter Two) for an hour at a time. These psychic abilities begin at a single dot, but every additional two successes provides an additional dot, to a maximum of the alchemist’s Path rating.
•••• Alchemists can bring about truly potent improvements to living beings. They can increase a single Attribute or Ability by two or two Attributes or Abilities each by one, and the normal human limit of five no longer applies.
••••• The alchemist can now craft recipes that reproduce up to three dots worth of supernatural powers. Each dot reproduced this way mimics a single effect — chosen when the recipe is crafted — even if the replicated power offers multiple effects. These are some of the hardest potions to produce and require exotic components, such as pieces of the supernatural being in question.

Price of Failure: Working with volatile compounds is dangerous in and of itself. Even mere failure results in broken equipment and ruined reagents, requiring expensive replacements. In the best-case scenario with an actual botch, the alchemical product explodes, potentially damaging the magician (as well as their neighbors). More commonly, though, the botched recipe appears to come together perfectly, but produces undesirable, and possibly harmful, effects. Even an unexpected but benign effect can be catastrophic at the wrong time.]==] },
				["Chronomancy"] = { en = [==[Sorcerer’s Companion, p. 29


Chronomancy


It’s well known that mages are supposedly masters of time and space, and Sorcerers have worked to keep up with this sort of belief as well. While Divination allows a Sorcerer to see aspects of the future, and Fortune allows one to tug the strings of fate, some magic users prefer to focus on manipulations of time within the present. Traveling years through time is beyond the capability of Sorcery, but a user of this Path may gain keener insight on the flow of time, make subtle alterations, or even speed it up and slow it down. Some may consider these effects comparatively minor when measured against some of the things a “true” Mage can do, but most Sorcerers will quickly discover just how useful this Path can be.

System

Roll: Wits + Occult

Cost: One Willpower

Modifiers: –1 if the character has successfully Meditated that day.

Duration: Varies.

Effects

Chronomancy does not have Aspects, per se, and instead its effects are based on raw level.

• See the Flow: At this level, the Sorcerer becomes aware of the flow of time, able to keep track of it perfectly, and to react accordingly. He may be able to sense an area is warped by time magics or fae manipulations of chronos, and his own ability to react quickly to things is improved because of it. In combat, the Sorcerer gains a bonus to his Initiative equal to successes rolled, but capped by Path rating. Either way, this lasts for a scene.
•• Perfect Timing: After managing to sense the flow of Time, the sorcerer learns to sync himself up to it, giving him the ability to perform actions that require good timing or the syncing of events more easily. Any action that requires precise timing, including most combat maneuvers, can gain a dice bonus equivalent to the lower of successes rolled or the caster’s Path rating. This lasts until used, but no longer than a scene, after which the unused bonus disappears.
••• Accelerate: Disciples of this Path are able to more deliberately alter the flow of time itself, speeding themselves up by slowing things down to their perception. After casting this spell, the Sorcerer has a number of extra actions he can take in combat or similar, spread out as desired, equal to his successes rolled, though capped by Path rating. This cannot be stacked; only one instance can be active at a time. This follows similar rules for extra actions as Celerity or Rage; these extras may not be split further, they occur at the end of the round, and they must be declared as being used at the beginning of a round.
•••• Decelerate: With this use of the power, the Sorcerer becomes able to slow down others as he previously sped up himself. Each success rolled, capped by path rating, causes the loss of one action from another character starting in the next turn. For instance, if 3 successes are gained, the target would either lose 3 turns of actions, or would need to ‘split’ their dice pool as if performing the fourth action in a turn (so, a –7 penalty), or some combination thereof. This can be canceled out by anything that would grant extra actions, on a 1 to 1 basis.
••••• Freeze: The sorcerer, at this level of power, can stop time in a small area (1 yard diameter), preventing any actions or any movement for a number of turns or minutes (in combat or out, respectively) equal to successes rolled, capped by Path Rating. Anything moved within becomes frozen as well, but something that’s only partially within might be manipulated from the outside; pushing a mattress below someone you froze right before hitting the ground, for instance.
•••••• Time-Hop: While true time travel is beyond what any Sorcerer is capable of, this spell allows a Sorcerer to ‘hold’ themselves in time, disappearing and then reappearing a number of turns or minutes later (Depending on if in combat or not, respectively) equal to the number of successes rolled (no cap). Alternatively, the caster may hop backwards a number of turns equal to successes gained (capped by Path rating), in which case the sorcerer remains as he is (damage taken and all) but may redo these turns upon reappearing and replacing his former self, with knowledge of what happens (actions may generally not be changed until the Sorcerer does something different). This is a spell that can be aborted to, but still costs an action to cast as normal (thus, it works as a perfect Dodge, so to speak). If something is occupying the space the Sorcerer would reappear at after the duration, they’re moved to the closest available area instead, and they take 1 lethal damage.]==] },
				["Conjuration"] = { en = [==[M20 Sorcerer, p. 20


Conjuration


Conjuration is the quintessential Path of stage magicians: pulling rabbits from hats and cards from an audience member’s pocket are common examples of its most basic applications. Sorcerers who wish to make a living from their studies often learn Conjuration. Because of this inextricable association with stage magic, Sleepers tend to rationalize Conjuration as simply expert sleight-of-hand.

The path of Conjuration is the ability to move or summon an object or being. While a novice might only perform parlor tricks like coin spinning, an advanced Conjuration sorcerer can hang a spell on their companion before entering a dangerous situation, letting them pull their friend from the (perhaps literal) jaws of death if need be.

Nearly as important as what Conjuration is is what Conjuration is not. Conjuration is very similar to the path of Conveyance mechanically, to the point that there’s often confusion between the two paths — especially among Awakened Mages who can achieve results common to both Paths with the Correspondence Sphere. Conjuration can’t move the sorcerer wielding it, whereas Conveyance can. A sorcerer also may not use this path to “summon” elemental attacks — that’s the domain of Hellfire. Conjuration can summon a bucket of sand but cannot create a sandstorm.

System

Modifiers: For any application that can be played off as — or described similarly enough to — stage magic, keep one success that would’ve otherwise been removed by witnesses. Even rational consensus is primed by pop culture to believe conjuring an elephant from nowhere is possible with clever visual trickery. Note that actions causing obvious physical harm can’t be explained in this manner.

Using Conjuration on an object in the grasp of someone actively resisting incurs a +1 difficulty. Attempting Conjuration to move a resisting target incurs a +2 difficulty. Apply a –1 difficulty for an object well-known to the sorcerer (see also Object Permanence below).

Aspects: Conjuration uses the Aspects of Distance, Number of Targets, and Weight. Conjuration notably doesn’t use Speed. The summoned target appears instantaneously on the successful completion of a spell or ritual. The sorcerer may also choose to buy the following effects with additional successes:

• 1 success to be able to use Conjuration to clumsily attack without touching the weapon (–1 die penalty to attack).
• 2 successes to attack as above but without penalty, or to give fine motor control to any object conjured, such as using a set of lock picks from a distance.
• 1 success for each additional round the sorcerer wishes to maintain the effect. The Sorcerer can’t drastically change the effect, such as throwing a puppet to strike someone after making the puppet dance, without rolling Conjuration again.

Price of Failure: While simple failure means no item is transported, a Conjuration botch runs the gamut from highly inconvenient to gruesome. A sorcerer might send an object to the wrong place, such as sending an item further out of reach or conjuring a prepared weapon directly to their own hand. Sometimes the sorcerer summons the wrong object entirely. Alternatively, a sorcerer might only conjure part of the intended item, and one only needs to imagine the horror of botching the Conjuration of a living being.]==] },
				["Conveyance"] = { en = [==[M20 Sorcerer, p. 22


Conveyance


Whether dreaming of teleportation or flying broomsticks, people have always wanted to travel quickly from place to place. No matter how quickly they can manage it, it’s never fast enough, and many turn to magic and strange sciences to get where they’re going that much sooner. To hedge magicians, these feats may not be routine, but few of them worry about being booked to a middle seat on an airline.

Until they reach the pinnacles of Path mastery, a hedge magician using the Path of Conveyance requires some sort of vehicle, which is prepared for a single journey by the magician. Mystics tend to favor seven-league boots, flying carpets and brooms, and stranger things like chariots drawn by divine cats, while the more scientific magicians use jet packs, transforming cars, and the like.

Powerful wielders of this Path, however, can cover distance without crossing the intervening space. Teleportation need not be instantaneous, but it tends not to need a vehicle; usually a ritual or device at the point of origin will suffice to send the magician wherever they want to go.

System

Modifiers: +2 difficulty for each unwilling target, –1 difficulty for well-known locations

Aspects: In addition to the Aspects of Distance, Travel Speed, and Passengers, the following each increase the number of successes needed:

• 1 success to travel to a location the magician has never been to.
• 2 successes to teleport, even if not instantaneous This is required to attempt to use Conveyance offensively.
• Each barrier crossed costs one success. Barriers must be possible to bypass. This Path can’t penetrate hermetically sealed chambers.

Price of Failure: Mishaps with the Path of Conveyance can be extremely dangerous. Failures are innocuous enough, as simply nothing happens. Botches, however, tend to be specific to the method of transportation used and tend to impact the conjurer (pun intended) part way through the trip. Flying broomsticks fall out of the sky, seven-league boots leave you stranded leagues from your destination, and entire bodies of science-fiction discuss what happens when teleportation goes badly.]==] },
				["Curses"] = { en = [==[The Hunters Hunted II, p. 72


Curses


The curse is one of the most ancient and potent forms of Hedge Magic. It can take many forms, from the “evil eye” of the Mediterranean and the Middle East to the “jinx” of hoodoo to the “hex” of Eastern European folklore. Curses have been known to cause grave misfortune in a variety of forms: accidents, illnesses, and even death.

At the core of any curse is maleficent intent directed toward an enemy. The Hedge Magician focuses her will, her directed hatred, toward her target and releases that intent in the form of harmful energy. The curse quickly afflicts its victim’s life and slowly fades as the hateful energy dissipates.

The basic mechanic for cursing is simple. The Hedge Magician determines what level of curse she wants to inflict (within her ability), and then she spends one turn per level of severity gathering and honing her mystic hatred. Once the Hedge Magician is prepared, she discharges the curse in a cathartic fashion directly toward the target (who must be visible to her). Examples of a proper discharge include a scream, a dance, rending a puppet that represents her victim, or offensive gestures.

The Hedge Magician’s player makes a Manipulation + Intimidation (difficulty 7) activation roll to determine if the curse is successful and the duration of the curse, as listed under Effects.

Each level of the Path of Curses allows for a greater range of misfortune to occur. Mechanically, a curse takes the form of penalties to difficulties and, eventually, dice pools. The Storyteller should apply the effects of a curse carefully to ensure that this Numina Path does not overwhelm the entire chronicle.

When mucking about with the threads of fate, however, a Hedge Magician runs the risk of entangling herself. Botching a curse will bring the effects back upon her three-fold, in which case, the curse intended for her enemy applies immediately to the Hedge Magician.

A Hedge Magician may attempt to banish any curse, even one of her own, but it isn’t easy. Her player must spend a Willpower point and roll Wits + Subterfuge (difficulty 9). Each level of success reduces the level of the curse inflicted by a single rating. If the roll botches, the Hedge Magician suffers from the very curse she attempted to banish for the remainder of the original duration of the curse, with no further chance at breaking it.

The Path of Curses eventually takes a toll upon the human soul. Practitioners rarely live happy lives, as the hate and anger required to fuel this Path tends to twist their insides. Mechanically, this often translates into a low Humanity score for characters who practice this Path. Storytellers are encouraged to require Humanity rolls for Hedge Magicians who have a high Humanity or who invoke curses more than once per month.

System

Roll: Manipulation + Intimidation (difficulty 7)

Modifiers: N/A

Cost: 1 Willpower

Duration: Varies (see below)

Path of Curses Levels

• The victim suffers brief inconveniences, such as dropping an object, saying something foolish, or having a motorcycle run over her foot. Mechanically, this is represented by the Storyteller adding a +1 difficulty to dice pools appropriate to the specified situation for the duration of the curse. For example, the injured foot might increase Athletics difficulties by 1, while saying something foolish might cause Etiquette difficulties to increase thus.
•• The victim suffers from a string of errors and bad luck that result in lasting injury or embarrassment, such as stepping on a nail, breaking an heirloom, or catching a minor disease. Mechanically, this is represented by the Storyteller increasing the difficulty of rolls appropriate to the curse by 2 for the duration of the curse.
••• The victim suffers severe accidents and misfortune. Typical effects might be broken bones, loss of income, or grievous illness. Mechanically, this is represented by the Storyteller increasing the difficulty of rolls appropriate to the curse by 3 for the duration of the curse.
•••• The victim suffers from major catastrophes and chronic illnesses. Mechanically, this is represented by the Storyteller increasing the difficulty of rolls appropriate to the curse by 3 for the duration of the curse. In addition, the victim subtracts one from associated dice pools during appropriate moments in the story.
••••• Curses inflicted at this level are nigh upon Biblical in scope. Nothing goes right for the victim for the duration of the curse. Her life is an exercise in misery, and may well be accompanied by plagues of locusts, being stricken barren, or causing despair in those she meets. Mechanically, this is represented by the Storyteller increasing the difficulty of rolls appropriate to the curse by 4 for the duration of the curse. In addition, the victim subtracts two from associated dice pools during appropriate moments in the story. Invoking a curse of this magnitude requires a Humanity roll for those Hedge Magicians of Humanity 4 or greater.

Curse Duration

The duration of a specific curse is determined by the number of successes achieved during the activation roll.

One success — The next action
Two successes — One scene
Three successes — One day
Four successes — One week
Five successes — One month
Six+ successes — Up to one year, decided upon the activation of the curse]==] },
				["Divination"] = { en = [==[M20 Sorcerer, p. 23


Divination


Reading tea leaves, casting rune stones or bones, studying the night sky — all these are examples of traditional practices of Divination, variations of which span a multitude of cultures. As long as there’s been the concept of a future, there’ve been people wanting to know what it held for them. Some of the newest, though more difficult, practices involve using advanced computer programming based on extraordinary sciences and hypermath.

A hedge magician performing acts of Divination attempts to predict the future. However, the future’s an ever-changing and muddied mess. A sorcerer may use Divination to find clues to the most likely outcomes, but the wise seer knows the value of accurately interpreting the imprecise and dream-like symbolism to judge likely probability changes.

Rarely is anything about the future set in stone. Mortals die, but the where, when, and how are determined by infinite variables: choices of action and inaction alike. The mere decision to scry the future and tell anyone about it could drastically change outcomes.

Because Divination leans on ritualistic practices, there’s no distinction between spells and rituals for this Path save casting time and effort. Divination rarely qualifies as vulgar magic, and many hedge magicians skilled in this art find it profitable to perform in the open. However, some practices such as Haruspicy (predicting the future by studying the entrails of a sacrifice) run the risk of legal consequences if discovered. Most Diviners choose one practice, but it’s not unheard of for sorcerers to have a few practices they use depending on the situation or client, especially if a favored practice is illegal or subject to being thwarted by the weather, such as with astrology.

System

Modifiers: +1 difficulty if using Extraordinary Science, but this Practice gives more precise probabilities.

–1 difficulty when under the influence of mind-altering substances. Visions and signs may come easier and more vibrant in altered states but remain up to interpretation.

Aspects: Divination uses the following:

Time Period

• one day

•• one week

••• one month

•••• one year

••••• 10 years

Accuracy

• Visions and signs are incredibly vague and difficult to interpret with any certainty

•• Typically accurate but deeply buried in symbolism

••• Accurate but vague and open to misinterpretation

•••• The truth’s there under layers of symbolism, but not terribly difficult to interpret

••••• Accurate and often easy to understand, though still subject to human error

Query

• A simple question that could be answered yes or no if you were talking to a person rather than stars or entrails

•• A specific question that can be answered with a short and simple explanation. For example, “Which road ahead is safest?” but not “What’s our enemy’s plan?”

••• The question could be researched and answered with public source knowledge if only you had the hours to put in.

•••• The question may be detailed and require hidden information, but the information could be uncovered given enough time and know-how.

••••• A very detailed query that would normally require lost, destroyed, or deliberately hidden information to answer.

Price of Failure: In the best-case scenario, the sorcerer simply receives no visions or intuition due to failure. A botch, however, can give patently false or dangerously misleading readings. The hedge magician may divine that there’s no security at the location their coven is planning on breaking into, when the place uses enough security to rival Fort Knox. Alternatively, the sorcerer might correctly divine that a door’s lock is broken but fail to understand that the owner knows this and placed armed guards to watch it. The Storyteller should vary approaches to Divination botches lest they become predictable in and out of character.]==] },
				["Dowsing"] = { en = [==[Sorcerer’s Companion, p. 21


Dowsing


With this Path, a magician uses ritually prepared but ultimately mundane items to answer simple questions, locate elemental sources, and find specific items. This Path is related to Divination in that both allow the magician to use external foci and interpretation to read facts from the world around them. Dowsing is much more results-oriented than Divination, as it is dedicated to specific, limited, practical matters rather than overarching possibilities and circumstances. It might be said that while Divination focuses on the universal, Dowsing attends to the specific.

When dowsing, the magician uses a specific item, or items, made from normal everyday materials, to find some sort of object, person, substance, or location, or to determine an immediate fact. The stereotype of the dowser is that of the peasant yokel with a forked stick looking for water, and indeed, that is a common use of the ability. True dowsers know there is much more to this magic, however. Facts may be learned through the judicious asking of questions. Specific items can be found, and at higher levels even hidden emotions (like malice, hatred, or even love) can be detected in those around you.

Dowsers are more reliant than most on their Foci, which often act as their divining tool. If the Dowser lacks the “Prepare Implement” ritual, he must have a Personalized or Unique focus dedicated to this Path to be able to use it. As such, most do learn that basic ritual early on, to provide them with additional options in how to go about their spells.

Any questions asked with Dowsing should be related to the present or immediate past, and only relating the immediate area/situation; predicting the future or finding information relating to far-reaching circumstances is the purview of Divination. The distance Aspect must cover anything being questioned, as well as the distance to anything being sought out more directly.

System

Roll: Perception + Awareness

Modifiers: –1 for well known object/location/etc. +1 to +3 for vaguely defined targets.

Cost: None for ritually prepared tool, one Willpower to use foci directly.

Duration: Approximately a scene of searching

Aspects

Potency

• The dowser is able to find small items (up to the size of a small book) that already belong to her, or gain a vague sense of an answer to a yes/no question about immediate circumstances relating to herself.
•• The dowser can find personal items of any size, and small, specifically defined objects belonging to others (“Joe’s wedding ring” is applicable, but not “Any book that has the ritual I need”). She may also gain a general sense of the answer to a yes/no question relating to another individual’s immediate circumstances.
••• The dowser can find specifically defined items of any size belonging to anyone, seek out small, vaguely defined objects, or find accumulations of mundane substances (an underground spring, or unexpected “pocket of air” in a building’s walls representing a secret room). Any sort of yes/no question relating to the immediate circumstances can be asked instead (“Is there a god?” is beyond their ken, but “Is this soup poisoned?” is valid).
•••• The dowser may seek out less material or obvious phenomena, such as seeking out magic, Mana, illness, or emotions, although the specifics must be defined (“Wards”, not “any magic I might want to see”).
••••• The dowser can seek out less well defined immaterial phenomena, such as seeking out any sort of Awakened magic, or Mana of any resonance.
•••••• The dowser can seek out incredibly vaguely defined objects, people, locations, substances, or phenomena of any size, for instance seeking out “the weakness of the Demon that’s hounding me” or “the best resource to improve my studies”.

Distance

• The immediate vicinity (20 feet, or a small room)
•• Same building or area (about 50 feet).
••• About 1 mile.
•••• About 10 miles.
••••• Around 100 miles.
•••••• No limit, although the power may need to be reactivated to home in on something far away.

Price of Failure

The most obvious failure is simply an inability to discern what the Sorcerer desires, but botches can cause them deeper troubles. It might lead them into a dangerous situation, provide deliberately misleading and dangerous answers, or fool them into thinking what they’re seeking out doesn’t exist to begin with.]==] },
				["Ephemera"] = { en = [==[M20 Sorcerer, p. 25


Ephemera


Some magicians — those focusing on the Path of Summoning, Binding, and Warding — command spirits. Those who follow the Path of Ephemera seek a relationship of greater familiarity with them. To magicians who use the Path of Ephemera, their relationship to spirits is more like family and friends than master and servant. When they call for a spirit, it’s an invitation, not a subpoena.

Instead of binding and commanding spirits, the Path of Ephemera allows the magician to negotiate with them. This process, called chiminage, is a give-and-take. Each spirit wants something different, related to their nature. The spirit’s request depends on the power of the spirit and the size of the task involved. Asking an Incarna to undertake a difficult and long-term task requires a lot from the magician, perhaps something only possible with a difficult quest of their own. Asking a Gaffling to do something simple that ties directly into their nature (e.g., asking a fire spirit to light a candle) would, conversely, require almost nothing of the magician, perhaps only the opportunity to do it. This process, naturally, has a steep learning curve. Most magicians find themselves on the worse end of a deal or two before they get a sense of it.

This Path almost always focuses on the Middle Umbra and, more rarely, on the Low Umbra. Rumors of versions that work with the High Umbra are persistent but remain nothing more than hearsay.

System

Modifiers: –2 to +2 difficulty depending on the spirit’s opinion of the magician.

Aspects: Metaphysical Weight and Spiritual Reach.

Spiritual Reach

• The magician can sense spirits and get their attention but can do little else.

•• The magician is restricted to calling upon a general type of spirit

••• Now specific spirits can be called through tailor-made rituals, and almost always show up unless the magician has offended them in some way.

•••• Spirits begin to approach the magician unprompted. The magician can see into the Penumbra, which increases the numbers and types of spirit they can interact with. The magician can also fight back against spirits if they need to, though most try to avoid it.

••••• The magician can now go to the spirits instead of needing them to come to the physical world. Though physical travel into the Umbra is still impossible, the magician can astrally project there, using Wits for Dexterity, Manipulation for Strength, Intelligence as Stamina, and Willpower as Health Levels. They are connected to their body by a silver thread, and if they run out of Willpower, it snaps, severing their connection and leaving them stranded.

Price of Failure: Dealings with spirits can be dangerous, especially at the early stages when all a magician can do is get the attention of whatever is nearby. Even at the higher levels, the most dangerous thing possible on a botch is to call the wrong spirit, with banes being particularly common.]==] },
				["Enchantment"] = { en = [==[M20 Sorcerer, p. 26


Enchantment


The Path of Enchantment rewards patience and forethought more than any other Path. There are no spells in this Path, only rituals, causing the hedge wizard to need to learn — or invent — a new ritual each time they want to make an Artifact they haven’t made before. Each of these Artifacts must be carefully crafted by the Enchanter. The first step is to create the mundane base item. Usually these are hand-crafted by the Enchanter, pushing their mundane skills to their limits to make just the right vessel for their magic. Sometimes, however, the right vessel can be found in the form of a rare or ancient object. Once the vessel has been made or found, the Enchanter can get to the process of infusing the object with magical energy to be used later. The first stage is usually accomplished through Crafts rolls (or, for technosorcerers, Technology or Hypertech rolls), while the latter is a Path roll.

The Artifacts created through Enchantment differ in several key ways from the recipes of Alchemy. Artifacts are usually persistent, or at least can be used many times. Some may be permanent, or nearly so, while others can be used a fixed number of times before their magic dissipates. Additionally, they tend to be weaker than the Wonders created by mages, and more focused. An Artifact can only have a single power, a restriction Wonders don’t have.

Enchanters tend to spend a lot of time and effort on their workshops. Whatever sort of crafting they do to make their Artifacts defines them. They often see themselves as blacksmiths, jewelers, electronics engineers, or woodworkers first, and the magic they can do comes later. This leads Enchanters to pursue high levels of the Resources Background, as well as others representing a safe and secure space to do their work and the ability to acquire high quality and often exotic raw materials.

System

Modifiers: Once a magician creates a Talisman three times, the difficulty is reduced by 1.

Time: Crafting time for the object, plus 1-3 days per level of the enchantment

Effects: Enchantment doesn’t have Aspects, instead it has the following Effects:

• The Enchanter can create minor items that are rarely noticeably magical to those who aren’t already aware of their powers. This can add one (or, for restricted circumstances, two) dice to an Attribute or Ability roll or decrease the difficulty by 1 for an attack or skill. Other small boons are also possible.

•• More powerful versions of already possible Artifacts offer two additional dice or a –2 difficulty on a task. Some of the objects created at this level can change reality in a subtle way, being more magical than previously possible.

••• Obviously magical items are now possible, though they’ll still seem merely “very weird” to the magically unaware. These include items that offer two additional dice on up to three different Attribute or Ability rolls, and those that confer supernatural perceptions to the user by replicating supernatural powers of no greater than a single dot.

•••• Objects of truly superhuman power. These can raise Attributes above 5, duplicate powers (up to the second dot) of other supernatural beings, and otherwise warp reality in significant ways.

••••• Extremely powerful items often bordering on the mythic. Minor miracles are possible, and often these powers are quite blatant. Items created at this level can reproduce up to three dots worth of supernatural powers. Each dot reproduced this way mimics a single effect — chosen when the item is crafted — even if the replicated power offers multiple effects.

Price of Failure: Failure usually means the magician has wasted days or weeks of their time, possibly ruining the item they were trying to enchant, but nothing worse. Botches tend to be more varied. They can result in explosions that destroy the workshop. Worse, though, they can result in objects that seem to work, but have some sort of unanticipated side effect. These cursed items tend to be hard to destroy or get rid of, often lingering long after the Enchanter is gone and even finding their way into Sleeper hands.]==] },
				["Fascination"] = { en = [==[M20 Sorcerer, p. 29


Fascination


Stories of the enthralling sorcerer or the bewitching magician are found in folktales across the world. Devious enchanters bring the innocent under their sway, and deals struck for power entrap the hearts and minds of those so foolish as to sign away their souls to such bargains. The kernel of truth to this old trope is solid as diamond. Unscrupulous magicians bending the minds of others to their will have practiced this Path as long as anyone has wished another would just act or think in an agreeable manner.

The methods vary, but the result is the same: Break the subject’s will and enthrall them. A sorcerer employing a mystical practice may apply makeup that makes their eyes sparkle with entrancing radiance. They may spritz themselves with an alluring fragrance, drawing the attention of anyone within wafting distance. Others may simply hone their confidence into a razor’s edge, impossible to resist. Extraordinary Citizens carry tested and approved harmonic resonators that emit a subsonic frequency that rebalances neurotransmitters to facilitate compliance.

Those with mind-altering powers already can resist with powers of their own if they are the specific target of a power. This goes both ways, as a student of this Path may recognize other uses of mind-altering effects and prepare themselves to resist or overcome them.

System

Modifiers: +1 difficulty for being disliked by the target, +2 difficulty for being hated by the target

Aspects: In addition to the Aspects of Number of Targets, Range, and Sympathetic Connection, Fascination uses the Allure and Willbending Aspects:

Allure

• Add 1 die to social die pools
•• Add 2 dice to social die pools
••• Add 3 dice to social die pools
•••• Add 4 dice to social die pools
••••• Add 5 dice to social die pools

Willbending

• Intriguing: You draw attention even in a crowd, and individuals find you interesting in one-on-one conversation. You may make mild suggestions that align with the target’s personality and situation such as getting another drunk if they are at a bar.
•• Alluring: Almost everyone at the gathering knows you were there, and individuals will try to find a way to see you again. You may make strong suggestions that align with the target’s personality and situation, such as heading home with the hedge wizard after a fun night.
••• Beguiling: Everyone assumes that you had a hand in setting up the party, and individuals around you will vie for your attention. You may make suggestions that don’t necessarily align with the target’s personality and situation, such as suggesting they break up with their long-term partner to give the caster of the spell a one-off chance.
•••• Entrancing: Invitations or not, the party is held for you by everyone’s estimation. Individuals no longer just want your attention, they crave your approval, possibly making fools of themselves in the process. You may make strong suggestions that don’t align with the target’s personality or interests, such as suggesting that the target fight another to defend the magician’s honor.
••••• Enthralling: If you started throwing things, this place would become a full-scale riot; those present find themselves hard-pressed to resist your requests, doing almost anything you might request. Hell, they may even kill for you or put their life on the line for you if you ask the right way. You may make strong suggestions that wildly defy the target’s character and circumstances, such as suggesting that the spell’s victim burns down a bar for daring to announce last call.

Price of Failure: The consequences of failure when manipulating hearts and minds tend to be based on the context of the situation. A simple failure at a party may go largely unnoticed after a moment of minor embarrassment, such as a spilled drink during an attempt at a grand flourish or stepping on others’ toes while making tracks across the dance floor. A botch, however, inevitably leads to humiliation, or worse. This can be represented by reversing any bonus into a penalty for the duration. The target of enchantment becomes a sworn enemy instead of a paramour or may lose the ability to feel emotions at all. The subject of the latter effect becomes numb to all forms of empathy and sympathy and requires great lengths or the passage of time to return to normal. The converse may see the victim become unhinged, transforming into a violently jealous abuser that will harm anyone they perceive as encroaching upon their claim.]==] },
				["Fortune"] = { en = [==[M20 Sorcerer, p. 30


Fortune


Fate is fickle, even before accounting for the manipulations of magicians. The Path of Fortune allows them to wield luck like a weapon, cutting down their enemies with curses or fortifying their allies with blessings. While methods and explanations may vary, from the Evil Eye, to the Hand of God, to probability manipulation, the Path of Fortune never makes the truly impossible happen, only the exceedingly unlikely. It’s also one of the least precise Paths: While the hedge magician sets Fortune in motion and controls the magnitude and general range of potential outcomes, the effects of this Path often surprise them or disappear into the noise of daily life.

Night-Folk are harder to curse with this Path than Sleepers are. They make a Willpower roll against 4 + the magician’s Path rating, and effects without an Aspect at 5 require only a single success to negate. Those extremely powerful curses can be ignored with only two successes, though the difficulty will be 9, making it quite challenging. To resist, the victim must be aware of the magician’s curse and actively attempt to resist it. Discovering an unannounced curse can be difficult, but is possible through supernatural perceptions, such as aura reading. Mages with Prime or Entropy might notice it, and magicians with the Path of Fortune can usually recognize the work of one of their own.

The Arcane/Cloaking Background provides an additional layer of protection against curses. Targeting anyone with that Background without their explicit permission subtracts a success from the roll for each dot of Arcane they have.

System

Modifiers: –1 difficulty with a weak sympathetic connection (object owned by the target), –2 difficulty for a strong sympathetic connection (prized possession of target, piece of the target such as hair or nail clippings)

Aspects: Fortune uses the Duration Aspect, but treats all durations as one higher, with Duration 5 consisting of spells lasting for several years. Additionally, it uses the Number of Targets Aspect, but all targets must be related (members of a family, the population of a small town, etc.). The Fortune Path also uses an Aspect called Severity, as follows:

Severity

• A minor blessing or curse, generally something simple, such as a Freudian slip or managing to just barely catch a bus the target needs.
•• A lasting but non-permanent inconvenience, injury, or small benefit. Sprains, non-life-threatening illness, and broken objects are standard bad luck, whereas good luck might be as simple as avoiding the flu for a season, a minor combat advantage, or the resolution of a minor obstacle.
••• A major setback or bonus. Temporary but grave illnesses and serious social faux pas are the most common curses, while finding helpful bureaucrats, success with gambling or relationships, or an additional die to combat pools are the most common blessings.
•••• Now the blessings and curses can have serious and permanent effects. Debilitating injuries, bankruptcy, a social tragedy that leaves the target a pariah, winning the lottery, surviving almost certain death, or just a chance encounter that changes the target’s social standing are all possible.
••••• Curses at this level almost always result in a painful and unusual death. Targets get decapitated, suffer incurable wasting illnesses, experience horrific car accidents, and more. Blessings are similarly dramatic, such as being rescued from state execution by a call from the governor. Other last-minute saves from certain death are possible, but also victories far rarer than one in a million: An enemy in combat may trip and break their neck, the beneficiary might find a lost tome in a used bookstore bargain bin, or they could win political office with no name recognition.

Price of Failure: Some failed Fortune spells are undetectable. The target is either lucky or unlucky naturally, resulting in the appearance of a success. Botches are a more serious matter. A twisted blessing or curse still results. Blessings first appear beneficial but every time it helps the target there are horrible consequences. Curses likewise appear to be harmful but turn out to benefit the target of the magician’s ire. This is especially dangerous for a magician who attempts to use the Path of Fortune on themself. Instead of twisted blessings, the full force of a more powerful curse, often the most powerful the magician can cause, targets them. Worst of all, the magician cannot unweave the spell they botched on themself, though they can on others.]==] },
				["Healing"] = { en = [==[M20 Sorcerer, p. 32


Healing


Wherever humanity thrives, there’s a need for healing. Since the dawn of civilization, healers sprung up out of empathy and community need. Long before science knew what germ theory was, healers learned how to serve their people from tradition, communing with spirits, trial and error, and a host of other ways. Now, even when science can prevent and cure horrifying diseases, many remain without access to such techniques. In medical deserts and communities who have historically been wronged by the medical establishment, there’s still need. People still desperately seek healers. They may not fully believe in magic or miracles, but between the choice of assured agony and a sliver of hope, many take the chance.

Hedge magic can achieve miraculous results. A master healer can cure cancers and speed up the healing of grievous injury beyond what should be possible, but they don’t advertise this. Even when so many are ignored and failed by the medical establishment, it’s illegal to practice medicine without a license. Beyond that, fame can be a heavy burden to carry. Many eager and empathetic hedge magicians begin learning the path of Healing, but few master it — they often burn out early from the cold and thankless world, switching to other Arts if they continue practicing magic at all.

Though not always required by their Practice, many hedge magician Healers do learn some form of medicine. Those who don’t rely on extraordinary science often learn forms of healing not based on modern medicine. At the very least, in instances they do learn the basics of modern medical science, their approach to treatment can be wildly different in philosophy and technique.

A healer might heal mild to moderate congenital illnesses or deformities, but more extreme examples such as regenerating limbs or raising the recently dead are the realm of legend.

System

Modifiers: Fast casting may only be used to stabilize lethal or aggravated damage or reduce wound penalties. All other uses must use regular spells, extended roll spells, or rituals.

• 1 additional success to fix a badly healed wound
• +1 difficulty to heal an uncooperative patient

Aspects: This path uses the Damage/Healing Aspect. Bashing damage can be healed with one success per damage level. Additionally, each success can reduce a toxin, disease, or wound penalty (caused by pain rather than a missing limb, for example) by one level. See Mage 20 p. 406 for information on wound penalties and p. 442 for the toxin and disease chart.

Price of Failure: A failure simply means the magic didn’t work; the damage was beyond the sorcerer’s ability to heal. A botch can turn horrific quickly. A Healer might make the person more susceptible to the toxin they’re trying to fight off, increasing the effective Toxin Rating. They might outright cause damage or heal something incorrectly, such as fusing eyelids shut or setting a bone crooked, so that it needs to be re-broken later. The healer might also infect themself with the disease they were trying to heal.]==] },
				["Hellfire"] = { en = [==[M20 Sorcerer, p. 33


Hellfire


The Path of Hellfire remains one of the most popular Paths of hedge magic, despite there being something of a bad reputation associated with it. For most people, the allure of throwing elemental power around and destroying your enemies outweighs the belief it may somehow be tainted by evil, if not outright infernal. Despite these sentiments, many hedge magicians specialize in the pyrotechnics this Path makes available to them, being one of the more dramatic Paths of hedge magic.

Even beginning students of Hellfire are often accorded respect, and not a small amount of fear, by their fellows. They learn early that they can summon lightning and fire, cause earthquakes, and drown their enemies should they so choose, even if they don’t personally know how. Apprentices are also given one essential warning: They are not immune to their own powers. This vulnerability is not limited to botched attempts at magic (see the Price of Failure below). Practitioners must be careful not to be within the areas they target, and fire, once unleashed, can be difficult to control.

System

Aspects: Damage, Range, Area, and the following Special Effects can be added:

• Decay: Instead of damaging living targets, the spell breaks down anything they are wearing or carrying. For each point of damage it would inflict, it can turn three pounds of material to junk.
• Dust Storm: The spell summons a storm of dust, scouring the area (which must have at least three dots) and, in addition to damage, causing blindness in the area for one turn per health level inflicted.
• Sleet: A stream of ice and freezing water causes brief blindness and leaves the ground slippery. This cannot be made aggravated.
• Smoke: The caster emits a cloud of poisonous smoke that envelops the area (which must be at least three dots in the Area Aspect). Everyone within the cloud takes one level of damage per turn unless protected. A normal gas mask provides two turns of protection before becoming useless. Beings that do not need to breathe are immune to this damage. Vision, even if enhanced, is completely obscured while in the cloud.
•• Earthquake: the spell causes the ground to split open and engulf, then crush, the target. They can roll Strength at difficulty 6 to try to dig free. They need as many successes as health levels of damage they suffered. This cannot be made aggravated.
•• Lightning: Instead of fire, the spell fires a bolt of electricity. Anyone in contact with the target through a conductive material takes the same damage as the target.
•• Tanglewood: Plants flail and attack the target, throwing thorns, splinters, and other bits of wood at it. With extreme luck (at least three successes beyond the spell’s requirement) this can stake a vampire, but a magician who counts on it will likely be badly disappointed. If the target is standing in dense undergrowth, they are captured by the plants. A creature restrained in this fashion cannot move until they accumulate as many successes on a Strength roll (difficulty 7) as damage dealt by the spell. This cannot be made aggravated.
•••• Drowning Tide: This requires an Olympic sized swimming pool or larger body of water. The target is pulled underwater by a sudden wave or undertow, causing them to start drowning (see M20 page 440-441). Escape from the water requires an extended Strength roll, difficulty 8, with at least two successes necessary, often more. This only does drowning damage.

The Special Effects above must be purchased with Freebie or Experience Points at a cost of the dot rating + 1.

Price of Failure: When you play with fire sometimes you get burned. Botching when using the Path of Hellfire typically results in the spell rebounding on the caster. They take whatever damage they were attempting to inflict on their target.]==] },
				["Illusion"] = { en = [==[M20 Sorcerer, p. 35


Illusion


One of the most fundamental magics is the power to deceive others into believing what the magician wants. The Path of Illusion confounds the senses, making its targets perceive things that aren’t there or altering their perception of what is there. Most people trust their senses. “Seeing is believing,” but when an illusionist is nearby, this old adage can kill you.

The Path of Illusion is much less direct in most of its applications than some of the other Paths. Illusionists tend to be clever manipulators, at the least in order to choose just the right false vision for whatever task must be completed. This often requires strange patterns of thought and lateral thinking, leading illusionists to become eccentric over time.

When targeted with the Path of Illusion, avoiding the deception is always a possibility. A Perception + Alertness roll at difficulty (4 + Realism Aspect) for spells, and difficulty (4 + Rank) for rituals reveals the slight imperfections in the illusion. This requires one success for each sense covered by the illusion, though in cases where an essential sense, as determined by the Storyteller, is left out, the number of successes required may decrease. Anyone who makes this roll can tell that what they are perceiving isn’t real, though they perceive both it and the truth. If they alert others to this fact, they can reroll once.

System

Modifiers: –1 to –3 difficulty if using a base similar to the goal (making a table appear differently is easier than making a table appear from nothing)

Aspects: Duration, Number of Targets, and the following:

Senses

• Affects one sense
•• Affects two senses
••• Affects three senses
•••• Affects four senses
••••• Full sensory range

Realism

• Completely immobile and fixed; if visual, flat
•• Changes with perspective so the viewer moving doesn’t disrupt it immediately
••• Illusions can have moving parts, but only large ones
•••• Smaller motions and variations are possible, but there are still subtle tells
••••• Fully immersive, this level completely fools all targeted senses

Price of Failure: Naive magicians think botching an illusion must be no big deal. The spell did nothing real, so nothing real should happen when it goes awry. On the contrary, the caster’s perceptions are altered. Worse, most of the alterations are subtle and easily missed. For larger spells, though, there will eventually be a substantial change, likely when most dangerous for the caster to be caught unaware.]==] },
				["Maelstroms"] = { en = [==[M20 Sorcerer, p. 37


Maelstroms


Discovered by accident, the Path of Maelstroms was originally an attempt to rediscover Weather Control. Traditionally referred to as “Whistle” (as in, “whistling up a storm”), the magicians using it sought to conjure intense gales of wind and rain in the world of the living. It took until the 19th century to discover that these tempests were stolen from the Shadowlands.

Maelstrom pulls the energy to create its storms from two sources. The first is the caster’s force of will. Spells and rituals of this Path cost one Willpower point per level rather than the usual flat one point for most Paths. The other source of power is the Shadowlands itself, pulling its energy out and rendering ghosts in the area calm or forcibly driving the dead from the area depending on the size of the storm.

The most common instrument for this Path is, by far, music. Most users say that from the moment they learned it, they could hear music in their head, and some believe it grows louder when the storms they can draw from are stronger. For these people, their Alertness is capped at 3, due to the distraction of the music. Others, however, don’t experience this effect and suffer no penalty.

System

Aspects: Area, Duration, and Intensity

Intensity

• Drawing a breeze and fog from the underworld into the world of the living pacifies the local Shadowlands. Ghosts in the area are calmed. They’ll defend themselves, but otherwise they won’t attack anyone in the area for the duration without succeeding on a Willpower roll (difficulty 6).
•• A rainstorm is summoned, and it drains so much energy from the underworld that ghosts are frozen in place unless they make a Willpower roll (difficulty 7). They’re made just corporeal enough that the magician can physically move them. Usually, they remove the ghosts from an area where they are unwelcome.
••• Calling a full-scale thunderstorm does even more to quiet the Shadowlands. This drains the power of Oblivion from the area. Ghosts are sedated as in the first rank, but those under control of their Shadows are restored to reason. Results vary with spectres, but legends exist of hedge magicians with this Path pulling a spectre away from Oblivion.
•••• Powerful storms in the world of the living, with gale-force winds, hail, and plenty of property damage can truly sap the power of Oblivion in the Shadowlands. Spectres and other deeply malicious ghosts who fail a Willpower roll (difficulty 8) disappear within the barrage of wind and hail. No hedge magician knows for sure what happens to these spirits, but they are never seen in the location where the power was evoked for a year and a day.
••••• A massive storm draining all energy from the corresponding region of the Shadowlands. Both the area and its reflection in the Shadowlands becomes utterly uninhabitable for ghosts. The Restless Dead must flee the area, or else suffer five dice of damage per round until they do so.

Price of Failure: The magician’s control over these storms is tenuous at best. On a failure, the Willpower is still expended but nothing happens. Botches, however, result in storms that go out of control, both in the world of the living and the Shadowlands. When a hedge magician loses control of the energies of this Path, they call forth a piece of the Tempest. This causes normal ghosts to become disoriented and have difficulty moving around. Spectres, on the other hand, thrive in this environment. These most malicious of spirits ride the Tempest directly up to the Shadowlands and have an easier time manifesting in the area for the duration the spell would have had.]==] },
				["Necromancy"] = { en = [==[M20 Sorcerer, p. 39


Necromancy


Some things should stay buried. Chief among them: the dead. But those who follow the Path of Necromancy see things a bit differently. Like Hellfire, Necromancy has a reputation for being foul, practiced only by the worst of the worst. Unlike Hellfire, this reputation is at least somewhat deserved. Even the simplest of Necromancy spells involve forcibly bending the dead to the magician’s will, and the most powerful of them can manipulate the powers of the Shadowlands to affect the living as well.

Though methods vary wildly with practice, Necromancy always requires that the magician’s first instruments include the preserved piece of the corpse of someone they cared for, almost always a family member. This creates the link between the magician and the underworld, allowing them to become a conduit for the energies of death itself. While for mystical magicians, crafting such an instrument often feels natural, technomagicians tend to find themselves with unique, grisly objects, like keyboards with keys made of bone or computer chips with brain neurons embedded in the circuitry.

Using this Path is difficult. Not in the sense of technique — it is no more complex to use than any other Path. Rather, it takes an emotional toll on the magician. The living are not meant to channel the energies of death so directly. They feel the grief of their ancestors, back for centuries, perhaps millennia. This overwhelming despair at the loss of countless generations leads to complications, particularly for magicians who are low on Willpower. Finally, those energies cause harm to the user, and each spell or ritual causes the caster to take one level of bashing damage per level of the power being invoked, unless otherwise mentioned in the description.

System

Aspects: Duration along with Ghost Binding:

Ghost Binding

• The caster can see, hear, and speak to ghosts in their vicinity, whichever side of the Shroud they are on.
•• The magician can now terrify the restless dead. Filling themself with the necrotic energy of the Shadowlands, the dead can see them as alive but infused with the power of death. This results in a –2 difficulty on all Intimidation and Subterfuge rolls against the dead.
••• The caster forces a ghost to take on a corporeal form, whether they could do so on their own or not. For the duration, the ghost is for all intents and purposes a living person again, including the usual seven Health levels. If killed, however, they don’t simply return to being a ghost. Instead, the experience transforms the ghost into a spectre, a ghost consumed by and subservient to the powers of Oblivion. And this spectre has a grudge against the caster.
•••• Any ghost can be summoned to the caster at this level. All the magician needs is the ghost’s True Name and to win a contested Willpower roll. If the necromancer is successful, the ghost must then immediately arrive. Keep in mind that most dead people do not become ghosts, and most ghosts do not appreciate being summoned.
••••• Masters of Necromancy can compel obedience from the dead. In addition to the Path roll, they must win a contested Willpower roll. If they do so, they can demand the ghost perform one simple task or answer one simple question to the best of their ability. For tasks, the Duration Aspect covers how long the ghost must attempt to accomplish it.

Price of Failure: Failure for most Paths simply results in nothing happening. For Necromancy, the despair of generations overwhelms them, resulting in a derangement, usually severe depression, for an hour. If they have less than three temporary Willpower points, then the derangement instead lasts a week. Botches are truly dangerous, with not only the derangements lasting longer (a full month) and the near certainty of very angry ghosts, but the magician runs the risk of being pulled out of his body, leaving it apparently comatose while their mind spends the month “living” as one of the restless dead.]==] },
				["Necronics"] = { en = [==[M20 Sorcerer, p. 40


Necronics


One of the newest Paths, only discovered by ghost hunters in the late 1990s, the Path of Necronics was first studied by “Black Hat” hackers attempting to combine their understanding of electronics with the world of the dead. They use various techniques to manipulate their own bioelectricity, or life energy, to affect the world of the dead in some way. Because living energy is antithetical to the Shadowlands, this tends to result in impeding ghosts’ efforts to manage their hauntings.

As a new Path, there’s a lot not yet understood about Necronics. Almost all current practitioners use electronic devices — usually computers, phones, and tablets — to cast Necronics spells. Though analogues in traditional cultures exist, those Paths may or may not be the same as Necronics, using lower-tech and more traditional methods. Ghost hunters investigating Necronics tend to be fascinated by these practices. They think studying them will provide new techniques they can apply to handle hauntings.

In addition to the consequences of botching noted below, Necronics holds one other great danger for the magician. Because users are manipulating their bioelectricity so strongly, touching them while they are working is dangerous. Even the lightest touch by another living thing throws off the magician’s focus and control of bioelecticity, causing a feedback loop to form. This feedback causes them to take a level of aggravated damage and fail the spell or ritual. The magician needs immediate medical attention to stabilize them and is left weakened (–1 die to all actions) for one week per level of the spell or ritual disrupted.

System

Aspects: Area, Duration, and Impedance:

Impedance

• The magician floods the local underworld with electrical energy, shutting down all active ghostly powers. Ghosts may ignore this, continuing as they were, if they succeed on a Willpower roll (difficulty 8).
•• At this level, instead of merely stopping a haunting, the magician can increase the Shroud rating. This costs one success per rank increased, with the first rank included in the base cost of the spell (so in addition to the regular requirements, 2 successes are needed to increase the Shroud from 6 to 9).
••• Places can be defended from haunting by the simple technique of tricking the ghost into haunting somewhere else. At this rank, the magician can create a trap, a fake realm the ghost can haunt instead of the real location. A ghost can realize they’ve been tricked with a Wits + Enigmas roll (difficulty 8) and can escape with another one.
•••• At this level, the magician may directly use their bioelectricity as an attack against a ghost. When using this rank of Necronics, the Area and Duration Aspects are replaced by Damage and Range.
••••• Masters of this Path are capable of devastating a region of the Shadowlands and its inhabitants. They call it “creating a zero,” and they “format” the space to a default pattern. When successful, there’s nothing left. For the duration of the spell, the region becomes uninhabitable to ghosts, causing the Restless Dead to lose Corpus at a rate of 3 per turn until they can escape the area. If they fail to escape before running out of Corpus levels, they disappear. Magicians generally believe these ghosts have been destroyed completely, rather than the usual consequences of running out of Corpus. As no Necronics expert has ever seen one that survived being “zeroed out,” this seems to be the best guess.

Price of Failure: Because the Necronics magician uses their own bioelectricity to interact with the dead, botches are particularly risky. They aren’t just extending mystical senses, but rather a very real and physical part of themself. On a botch, the intended effect doesn’t happen. Instead, all ghosts in the area gain Pathos and Angst equal to the level of the spell or ritual being performed. They also become acutely aware of the magician trying to control or banish them and can affect the magician directly with their powers as though they were a ghost, rather than having to work through the Shroud or specific powers allowing them to touch the living.]==] },
				["Oneiromancy"] = { en = [==[M20 Sorcerer, p. 42


Oneiromancy


The Realm of Dreams is a fluid place that responds to the mood and imagination of the dreamer. Some people, particularly those with the Lucid Dreaming Talent (Mage 20 p. 294), can take control of their own dreams, rendering normal bad dreams controllable, good dreams fun experiences, and other dreams possible sources of insight into themselves. Without magic, though, the greater Realm of Dreams is still locked away, with each dreamer confined to their own psyche.

Magicians who learn the Path of Oneiromancy learn to walk into the dreams of others. Once there, they try to take control, and can glean information or alter dreams to the benefit or harm of the dreamer. At the peak of their power, oneiromancers can even bring several people together in a shared dream. According to legend, some can even make dreams real or become capable of physically entering dreams.

System

Aspects: The Path of Oneiromancy has two Aspects: Sympathetic Connection and Dreamwalking

Dreamwalking

• Basic Oneiromancy allows the magician to touch the dreams of others, seeing flashes of imagery that could be interpreted to get insights into their target’s nature and history.
•• The oneiromancer can now enter the dreams of others, not merely see them. They become a part of the dream, forced to take on a role appropriate to the dream itself. Once in the dream, changes can be made. The magnitude of the changes determines the difficulty of an additional Oneiromancy roll, with creating small items being difficulty 6 but violating the theme of the dream being difficulty 8, perhaps with a Threshold.
••• Dreamwalkers can now watch dreams from the outside, seeing them clearly but not being pulled into them. They can now truly transform the dreams they encounter. With this rank, they can create terrors mimicking the Nightmares Flaw or soothe a dream to the point of helping the dreamer regain an additional point of temporary Willpower.
•••• Dream Sendings become available to the caster at this level. They can craft specific and detailed dream sequences for their target that repeat once per success. If they repeat more than once or twice per night, the target can become suspicious that their dreams are being manipulated.
••••• Masters of Oneiromancy can create shared dreams, bringing one person into the dream for each success on the casting roll. The environment begins as a mixture of their subconscious influences, but the oneiromancer can manipulate it further using lower levels of the Path.

Price of Failure: Botching on Oneiromancy tends to be psychologically harmful. Many oneiromancers get tossed into a Nightmare Realm, which torments them in a way similar to the Paradox Realms (Mage 20 p. 102-103) feared by mages. At best, they lose control of any dream they’re interacting with. Of course, even if they succeed, interacting with the dreams of someone with the Nightmares Flaw can be its own sort of hell.]==] },
				["Quintessence Manipulation"] = { en = [==[M20 Sorcerer, p. 43


Quintessence Manipulation


Nearly all sorcerers can agree on one fact. There is a flow of power that fuels their works. The name of that power has taken on a multitude of faces and philosophies: mana, qi, gnosis, shakti, sekhem, and many others. Every magician can describe the flow of energy as they work their will on reality. Coursing through them like charge through a powerline, it can be felt, and for some it can be directly harnessed. Through Practices like those of geomancy and feng shui, hedge wizards can sense and redirect the unrefined energy of the universe.

In contrast, very few sorcerers consider this to be a Path of its own. Most look to Quintessence Manipulation as a standard exercise and refinement of their already defined craft. Each magician’s personal style already informs them how to achieve manipulations to perform all their other spells. Wands direct the energy, drawn patterns on boxes create traps to hold it, while knives cut and disrupt as they perform all their other works. Yet, those who focus on mastering this fundamental skill on its own find their work is never without a source to draw on, and their mystical surroundings are rarely a mystery.

System

Modifiers: –1 to –3 difficulty based on distractions in the surrounding area, with –1 representing a loud sound system playing in the same room and –3 representing Time Square at midnight on New Years.

Aspects: Area and Duration as well as Flow listed below:

Flow

• Sense Surroundings: Sensing the energies of the area becomes a routine task. With a moment of meditation or invocation, a sorcerer determines if an area or item is charged with power (whether Quintessence, vampire blood, Gnosis, or another mystic source). With three successes, the sorcerer identifies the Resonance of said energy.

•• Focused Awareness: The ability to sense the ebb and flow of energy transcends local surroundings and the inanimate and crosses into the realm of individuals. Now the sorcerer can perceive another individual using subtle magics and allow them to see obstructed meridians or occluded energy flows. This reveals curses left on individuals or blocked Quintessence flow through the body imposed by malicious disruptions. The ability to gauge magical potential in a subject also becomes available. While especially useful in identifying potential threats, the amount of information gleaned in this way lacks detailed nuance to fully define if the subject is a supernatural creature or a normal human with a certain aptitude.

••• Disrupt: No longer held to observing, now the skilled sorcerer can begin to affect the Quintessence around them. Still unable to bend and gracefully manipulate the energy, the practitioner of this path is at least versed enough to cause disruptions to the flow around them. With their invocation or focus, the sorcerer can quell the flow in the local area, causing a Quintessence source to become dormant for a time. Disruption also can mean diverting. A flow of Quintessence may be turned aside and sent along a new path in much the same way. Alternatively, with some effort a practitioner can trap a mote of Quintessence in a simple object for a limited amount of time.

•••• Control: Mere brute force gives way to nuanced control of the flow of Quintessence within themselves, the world around them, and within the pattern of others. The flows of energy through themselves are now flowing rivers with metered channels and locks allowing the practitioner to harness the Quintessence in a place of power. Each success on an effort of this type allows the sorcerer to channel one point of Quintessence per success, up to the limit of that area’s power. Quintessence drawn this way dissipates unless used within the next turn.

An enemy’s flow of energy is now a viable target for disruption at this level of understanding. Stripping the energy from another’s pool destroys one Quintessence for every success rolled. More alien energies of other supernatural creatures are still accessible, but doing so is more taxing. The energy of other supernatural creatures is disrupted by one point for every two successes.

The flow of energy through an individual’s pattern is essential to their health. A sorcerer with this knowledge can cause great harm or provide great help, albeit over an extended period through something akin to a curse or boon. Altering the flow of another’s life energy can promote or deteriorate their health but takes a great deal of time to become evident. They become ill more often, finding it difficult to fight off a mere cold, and take longer to recover from simple injury. If left unchecked they will inevitably fall victim to an environmental carcinogen or a malady that runs in their family history. On the other hand, benefitting the flow of Quintessence in an individual will see the recipient barely ever falling ill for more than a day, bouncing back from any injury as though it were a mere inconvenience and living to a ripe old age. Through this function the hedge wizard can grant physical Merits or inflict physical Flaws, by spending 2 successes per point of the Merit or Flaw.

••••• Rule: Masters of Quintessence Manipulation have attained a level of understanding that puts the flow of energy at their beck and call, impressing even the Awakened. Now, stored Quintessence can be directly infused into countermagic, adding dice to countermagic pools. Sensing Quintessence being directed, the sorcerer can interrupt the flow of energy, preventing another sorcerer from using Quintessence of their own. Each success blocks a point of Quintessence or Tass from empowering an effect.]==] },
				["Shadows"] = { en = [==[M20 Sorcerer, p. 45


Shadows


Power over darkness is a cliché that some sorcerers have no problem clinging to out of ironic giddiness or genuine belief. One wouldn’t be remiss in guessing the Path of Shadows as the source of the concept that dark forces empower the mystic arts, given how often hucksters make the claim. Regardless of its reputation, the Path does carry a foreboding and intimidating air, as it shapes and shifts the substance of instinctual fear — shadows and darkness.

Practitioners have found the application of the Path of Shadows far more malleable than other Paths. Shadows are omnipresent, and even in the brightest days stand out and provide contrast. The availability of shadows and the potential of adjusting the depth of shades grants greater possibilities than less versatile Paths.

One may think that the Path manipulates the quality of ambient light, focusing it away from darker areas to make shadows appear deeper and more menacing. This is patently false. Whether it’s a magical implement or a dark matter enhancement field of the more technologically minded, this Path manipulates the very stuff of shadows. The actual nature of this substance is the source of much debate in the magical communities, with a range of theories just as diverse as those concerning the mechanism of Awakening. What practitioners do agree on is that shadowstuff can be used to great effect in a variety of useful ways.

System

Aspects: The Aspects of Area, Distance, Duration, and Number of Targets, as well as Shadowgrip listed below:

Shadowgrip

The severity and persistence of the controlled shadows is gauged by one’s Shadowgrip. When a target attempts to resist the Path of Shadows, they make a Willpower test with a difficulty determined by the selected Aspect. Any success ends the effect on the following turn or after one minute.

• Deepening: Bringing shadows deeper into our vision can create a distracting and intimidating atmosphere. Within an area the overall lighting itself may not change per se, but the shadows deepen, and even sounds become slightly smothered at the edges. These shadows can also be cast upon others to confer the Path’s benefits, such as a bonus to Stealth tests in shadowy conditions.

•• Shaping: Taking further mastery of the dark material that comprises shadow, the sorcerer now crafts pattern and intent behind their shadow weaving. Upon a successful casting, the sorcerer adds two dice to any pools involving Intimidation or Stealth as well as any Subterfuge test to hide their identity. Conversely, the shadows can surround an individual and cast doubt and confusion upon the victim’s senses. At this level of mastery, they are strong enough to cause the target to hesitate or reconsider their actions due to the unidentifiable unease. This causes the target a –1 penalty to rolls made to dodge or that rely on quick reaction time. A Willpower test at difficulty 6 allows the victim to shake the shadows from their eyes and focus on their task at hand.

••• Entrenching: Not content with merely strengthening shadows, the sorcerer now animates the shadowstuff itself, letting it shift and roil about them. Should they take their deepening skills further, light now withers in the target location, and color will desaturate before the shadows. Affecting another is now far more effective. Shadows shift and distort in their eyes, and unsettling whispers can be heard when the victim gets too close to a pool of gathered shade. Being harried in such a way causes a –1 difficulty on all tests. The effect can be broken with a Willpower test at difficulty 7. Finally, the caster can cause shadows to flutter or shake creating visual diversions and increasing the difficulty of all ranged attacks made against the beneficiary by one.

•••• Commanding: The shadow’s “willingness” to act has become outright eagerness. The torment the shadowstuff visits upon the sorcerer’s foes is maddening and now causes a –2 difficulty on all tests made by the target. Any attempt to shake free calls for a Willpower test at difficulty 8 and may send some enemies into a frenzy or rage if they fail. Wreathing a target in benevolent shadows gives a +4 on all Intimidation and Stealth dice pools and any Subterfuge dice pool that is used to mask one’s identity.

••••• Ruling: Shadows know who their master is and immediately act with abandon at the sorcerer’s call. Enemies may be reduced to a gibbering heap on the floor from the horrific maleficent shades. Opponents must succeed at a difficulty 9 Willpower test or be reduced to uselessness, crumpling to the ground. This test can be repeated on each of the target’s turns, but the target may only act normally on a turn in which they gain a success. If the target leaves the affected area, they regain the ability to act normally. The darkness that engulfs those who wish to remain unseen is nigh impenetrable from without and within, save for the sorcerer themselves, decreasing the difficulty of Stealth tests by one. This darkness carries a weight so palpable, it may damage recording equipment engulfed by its influence.]==] },
				["Shapeshifting"] = { en = [==[M20 Sorcerer, p. 47


Shapeshifting


Even among primal magics, the ability to change into an animal stands out as exceptional. Many monsters haunting the night have the power of transformation, including those who are true shapeshifters. Hedge magicians who study the Path of Shapeshifting mimic a certain amount of their power, transforming first pieces of themselves and later their entire body in dramatic ways.

Most think of this Path as turning oneself or others into animals. When shapeshifting magicians choose subtlety, they can be remarkable spies. They can make cosmetic changes to look like a different person, and then supplement their disguise with sharpened senses. They can transform into something more dangerous if their cover is blown.

The biggest risk of this Path is that the human mind is not equipped to change shapes. Every transformation incurs risk, but it’s greatest when making a full shift to an animal form. Then, even without a botch, the magician needs to roll Willpower (difficulty 6) to retain their own mind, rather than losing themself to their animal nature.

System

Duration: Scene

Aspects: None of the standard Aspects apply to Shapeshifting. Instead, it uses:

Scale

• Cosmetic changes only, such as eye color or growing hair.

•• Small but noticeable changes, such as growing claws or scales.

••• The magician can change a single body part to that of some other creature.

•••• Half-Shift: the magician can either change half of their body to an animal’s or take a form halfway between human and animal.

••••• Full Shifting: The magician can change completely into an animal.

Subject

••• The magician can only affect themselves.

•••• The magician may transform another target.

••••• The magician may affect two subjects at once.

Disparity

••• Only a single animal feature.

•••• The magician can take on two unrelated shifts, such as the head of one animal and the body of another.

••••• Three unrelated shifts are possible.

Price of Failure: When a shapeshifter botches, the best-case scenario consists of an unexpected and unpleasant transformation. They can also lose themselves to their other form, functionally going feral. In a worst-case scenario, they can experience a rampage similar to the Berserker/Stress Atavism Flaw (Mage 20 p. 644).]==] },
				["Spirit-Chasing"] = { en = [==[Sorcerer’s Companion, p. 23


Spirit-Chasing


Practiced primarily by Kinfolk Hedge Magicians and various other scattered shamanic practitioners, this little-known Path can provide unique abilities to those that study it. While this Path’s name implies a similarity to Summoning, it has little relation to Summoning/Binding/Warding of any kind. Spirit Chasing instead creates a bond between a mystic and a chosen plant or animal (or, with Storyteller permission, some other sort of Naturae).

Practitioners of this Path believe, as do werewolves, that within every living creature rest a soul, spirit, animus or similar ephemeral concept. Spirit Chasers try to watch and learn from these beings; unlike the learning of Gifts, however, the animus doesn’t necessarily enter into any kind of “bargain” with the mystic. Instead the practitioner studies the spirit, first by making contact with it, then by asking it questions and mimicking its natural abilities that manifest in this world, and finally by putting what it’s learned into practice through Sorcerous rituals.

For example, a Spirit Chaser studying bears would begin by watching bears and observing their movements and patterns of life. He would then engage in some sort of private ritual of his own devising, pleading for a bear’s particular spirit to appear; sometimes, this process takes years of work. Next, the mystic would explain to the spirit that he’d like to learn the ways of bears in their natural habitat. The spirit might require proof of the mystic’s sincerity. But if it agrees, the Spirit Chaser can learn the rudiments of living like a bear. He could, for example, discover how to survive on raw meat, roots, berries, nuts or insects, even those poisonous to humans. As his understanding progresses, the mystic could also learn to focus his sense like a bear, hibernate or even grow claws. Spirit Chasers by no means restrict themselves only to mammals or even the animal world. A number of them choose plants for their Spirit Chasing. This Path is unique to every practitioner.

While, by default, the practitioners of the Path may only benefit themselves with the abilities they’ve learned, at higher levels a dedicated Sorcerer eventually learns to grant these gifts to another; the mechanics work the same way in that case as if the target had cast it themselves. Any target of this Path’s base effects must be willing; it’s to be treated as a gift, not a burden.

If a Sorcerer wishes to take this Path for more than one type of Spirit, they must re-purchase the Path, going through the whole process again from the beginning.

System

Roll: Manipulation + Occult

Cost: One Willpower

Modifiers: –1 if you have Medium, Spirit Sight, or similar merits. +1 if you’ve angered related Naturae.

Duration: A scene, unless the ritual or level says otherwise.

Aspects

Effects

• This level allows the mystic to learn how to “eat” the food of the chosen spirit. It requires that the proper food be available (e.g., sunshine and water for plants or crumbs for insects). He receives full nutritional value from the meal, as if he were the animal or plant.
•• With this level of Spirit Chasing, the character can extend his sensory perception to match that of his chosen animal or plant in one aspect. If the Spirit Chaser has a bond with a lynx, for example, he could see in the dark.
••• Animals and plants have an innate understanding of self-preservation. Hurt creatures lick their wounds clean, while plants use energy from photosynthesis to repair torn leaves and roots. When winter approaches and food is scarce, some animals and plants fall into hibernation; they awake when spring comes. This level allows Spirit Chasers the same luxury; they can fall into a healing sleep and recover one Health Level for every success rolled on Spirit Chasing. Each level regained requires four hours of rest. Thus, a person who got three success could heal three Health levels after 12 hours of sleep.
•••• This level of Spirit Chasing grants the mystic keen insight and wisdom. The Storyteller decides, based upon the levels of success, what sort of information to provide. For example, if a character has chosen the oak tree as her bonded spirit and rolls three success, the wisdom that comes to her might involve seeing how an event long ago affected the present. The idea is that the oak has stood for many years and seen much. The Storyteller can use this level of the path to provide clues or plots hooks for the characters.
••••• At this point, the Spirit Chaser may practice a unique ability chosen from their spirit. A practitioner bonded to a deer could run quickly or jump over a high fence. If a character chose poison ivy, anyone who touched him might develop a blistering rash. A minimum of three successes is necessary to invoke this effect; it’s perhaps the closest Kinfolk can ever come to possessing the shapechanging abilities of their Garou relatives.
•••••• The rare Spirit Chaser that reaches this pinnacle may practice another ability chosen from their spirit, but this one may be more obvious or simply a lot more potent. Someone following a bird spirit may be able to fly short distances without wings, or someone following a type of vine may be able to suck the life from another individual.

Price of Failure

The most likely issue with failing or botching this Path is that the Spirits the Sorcerer venerates become offended by the clumsy attempt to mimic their abilities. This might increase the difficulty for further castings until some sort of chiminage is offered, or if done repeatedly might cause the spirits to decide to take more direct action against the Sorcerer.]==] },
				["Starlight"] = { en = [==[M20 Sorcerer, p. 48


Starlight


There are Paths that go back centuries and then there are some that only arise from the unique environments of the modern night. Urban sprawls gave sorcerers a unique worldview and provided a compass for the lands beyond the Shroud. Peering into the lands of the dead is not a new concept to the magical community, but those who walk the concrete valley started to see a pattern in the stars of the Shadowland skies that matched the lights of their cities. Through study and the broadening of their understanding, the Path known as Starlight was born. Much to the dismay and jealousy of the inhabitants of the Shadowlands, only those gifted in Starlight seem able to see the stars that they use.

Like navigators of the golden age of sail, Starlight practitioners understand the unique sky of the Shadowlands and chart courses to safely travel through the realm of the dead. Simply knowing where they are going is only the start of the power these navigators have. Their minds produce a sort of protection and preservation shield for any mortals traveling with them. This becomes a necessity for travel since the shadowlands have no air and the very ground is anathema to the living. This is no physical shield against all harm, though, and any violent wraith that means them harm can easily indulge that urge. Should the duration of the spell expire, those traveling will be exposed to the lethal environment of the Shadowlands.

It is knowledge of the guiding lights of the Shadowland skies that also allow navigators to open doorways into the Shadowlands directly, completely bypassing the Shroud in the process. Any door can lead to the Shadowlands; it just takes a lot of preparation, and the journey begins. Moving quickly towards the destination is advised, considering few navigators have been able to complete a journey that took longer than one day.

System

Modifiers: Decrease difficulty by –1 if carrying a personal item of the recently deceased

Aspects: The Aspects of Duration, Passengers, and Wending:

Wending

• The threshold is the first obstacle a navigator must master. With focus and will, any doorway can serve as a threshold into the Shadowlands. The door only remains open for the navigator and will allow them and their passengers to pass. Traveling companions benefit from the same life preserving effect as the caster so long as they remain within sight of their navigator. Anyone attempting to reopen the doorway once closed will find the mundane corresponding threshold. This door collapses after it has been reopened and closed again by the navigator during their return from the Shadowlands, or willfully collapsed by the navigator to close the way behind them. A different doorway in the Shadowlands can be used to re-enter the Skinlands, but another activation of Starlight must be performed to create the new threshold. There is a drawback to this technique; The destination in the Skinlands is difficult to know without more capabilities as a navigator.

•• The Shadowlands are more familiar to a navigator of this level. Confidence swells in their chest, and the realm of the dead seems far less frightening. While traveling in the Shadowlands, the navigator benefits from –1 difficulty on all Awareness, Leadership, Survival, and Occult rolls concerning this environment, as well as Willpower rolls to overcome fear and intimidation.

••• The navigator has found a point in the Shadowlands that is akin to their own personal North Star. No matter where they are in the Shadowlands, so long as they can see this star, the navigator has a general understanding of where they may exit into the Skinlands when opening a new threshold.

•••• The familiarity with the Shadowlands is now palpable to any traveling companions the navigator has brought along. Traveling companions of the navigator benefit from a –1 difficulty to Willpower rolls made to overcome fear and intimidation, as well as Awareness and Survival rolls made within the Shadowlands.

••••• The navigator’s guiding light within the Shadowlands is visible to them even with their eyes closed. No matter how deep they travel or how turned around they may get, the navigator will always be able to find their way to a door back to the Skinlands. Furthermore, they know exactly where their exit from the Shadowlands will lead.]==] },
				["Summoning, Binding, and Warding"] = { en = [==[M20 Sorcerer, p. 49


Summoning, Binding, and Warding


Sorcerers in both fiction and legend are well-known for their ability to summon and control others, both living and ephemeral. With these powers, the magician can summon animals, spirits, ghosts, demons, and other strange beings. They can also defend against these beings, bind them, and compel them to obey the magician. Though overlap exists with the Path of Ephemera, this Path focuses on methods of compulsion, rather than cooperation, with the beings being called and dealt with.

All Summoning, Binding, and Warding magics are rituals, and rituals exist for reaching individual beings or classes of beings. There are separate rituals to summon, bind, and ward each target. This has led many magicians to their doom. Though summoning a being may intrigue it, attempting to bind them tends to incur hostility, and magicians who either don’t know or fail at casting the warding ritual often find themselves in a great deal of trouble.

In addition to the complications of each specific being or type of being the hedge magician intends to work with, there are several versions of this Path which are learned completely separately. Variants exist for summoning material creatures (like animals and people), angels and demons, ghosts, spirits of nature, and other sentient beings. There are even reports of variants focused on inanimate objects and virtual creations, allowing some magicians to ward their computers against viruses or summon their cars at need.

System

Aspects: The three distinct parts of the Path have separate Aspects. Warding has Duration and Strength, each level of which subtracts one die from all actions the summoned being takes against the magician. For three successes, Warding Strength allows the creation of a Warding Circle, which the being cannot cross without a Willpower roll (difficulty 6) where they achieve more successes than the magician.

Summoning has Duration as an Aspect. Additionally, it has Number of summoned beings (or swarms) and Metaphysical Weight for the summoned being. The summoned being is compelled to appear before the magician but must still transport themself there. Only the most powerful beings can truly travel instantaneously.

Binding similarly has the aspects of Duration and Metaphysical Weight, as well as Binding Intensity. A being may spend a point of Willpower to resist a binding, but the binding can be recast. Some beings, especially those with Metaphysical Weight 5, are powerful enough to require binding rituals with large thresholds in addition to the usual requirements — sometimes as high as 20 or more successes.

Binding Intensity

• The creature cannot directly act against the magician.

•• Any single question must be answered truthfully.

••• All questions for the duration must be answered truthfully, and the being may be compelled to perform one service, though they may interpret the command liberally so long as they literally satisfy it.

•••• A single task is performed as directed, following the orders closely.

••••• The magician may transfer limited control of the binding to another person. The being performs one task for them and answers any questions the summoner asks of it.

Price of Failure: The Path of Summoning, Binding, and Warding has no need for special failure or botch costs. Instead, the consequences of failures and botches are visited upon the magician by the being summoned. The biggest source of these problems is that, on a botch, the magician often ends up under the mistaken impression they have succeeded.]==] },
				["Via Geniorum"] = { en = [==[The Hunters Hunted II, p. 125


Via Geniorum


Via Geniorum is one of the Ways that is most distrusted by Theurgy’s critics; Theurgists who practice this Via deal with the realm of spirits and the demonic. They argue that all creatures are ultimately under the call of heaven, including spirits and demons. These Theurgists believe that there is an entire spectrum of Spirits who allied neither with Heaven nor Hell, yet can be commanded by the power of Heaven. This Way grants the practitioner power over non-human spiritual entities (demons, elementals, etc.).

Knowledge of a spirit’s true name grants one power over it. A true name is not the title that the spirit commonly goes by, but a more complex, primal invocation. The world warps and flutters when true names are spoken. They are jealously guarded secrets, requiring extended research rolls, Intelligence + Occult (difficulty 9), and a good occult library to decipher. Every success grants a “syllable” of the name. The simplest of spirits might have a single syllable true name, but more powerful demons will have many more (up to the discretion of the Storyteller). A Theurgist may try and trick a spirit into divulging its true name. True name syllables are often a form of currency amongst spirits and occultists, who tend to hoard them.

System

Roll: Varies (see below)

Modifiers: –2 difficulty if the Theurgist knows the spirit’s true name

Cost: 1 Willpower

Duration: Varies (see below)

Via Geniorum Levels

• Ritual of Revelation: The Theurgist does not peer into the spirit world so much as command nearby supernal beings to reveal themselves. On a successful Charisma + Occult roll (difficulty 8), the Theurgist can see all spirits in the immediate area (including those possessing physical bodies).
•• Ritual of Protection: On a successful Wits + Occult roll (difficulty 7), the Theurgist may draw protective sigils into handheld objects or in a small circle around her. Extended ritual rolls can make larger circles or more completely protected locations, with 10 successes being enough to protect a small house. Spirits cannot harass or enter a person or location, thus protected, without succeeding in a Willpower roll (difficulty 9). Protection lasts for one month or until the sigil is disturbed (a carved sigil is much harder to disrupt than one drawn in chalk).
••• Ritual of Dismissal: The Theurgist can send a spirit back to its native realm. This via requires a Charisma + Occult roll (difficulty 9). The number of success needed, in an extended ritual, vary widely based on the power of the spirit (and left to the Storyteller’s judgment).
•••• Ritual of Summoning: The Theurgist can now summon spirit entities. This via requires a Charisma + Occult roll (difficulty 9). The number of success needed, in an extended ritual, vary widely based on the power of the spirit (and left to the Storyteller’s judgment). A summoned spirit must remain in the Theurgist’s presence for a scene or until it has answered three questions (it cannot be made to reveal its true name in this manner). Further interaction relies on Social rolls, sacrifices, or other powers. A botched roll summons an enraged spirit who likely attacks the unlucky Theurgist.
••••• Ritual of Binding: The Theurgist can now force a spirit into servitude. This via requires a Manipulation + Occult roll (Difficulty 9). The number of success needed, in an extended ritual, vary widely based on the power of the spirit (and left to the Storyteller’s judgment). A bound spirit may be asked to do a specific action (“Attack that vampire!”) or an ongoing action (“Watch over me.”) lasting until the next sunrise or sunset.]==] },
				["Via Necromantiae"] = { en = [==[The Hunters Hunted II, p. 126


Via Necromantiae


The Via Necromantiae is Theurgy designed to contact or banish the dead. This Via resembles in parts those of the Via Geniorum, but it is, nonetheless, distinct.

System

Roll: Varies (see below)

Modifiers: –1 difficulty if Theurgist has an object important to the ghost in life

Cost: 1 Willpower

Duration: Varies (see below)

Via Necromantiae Levels

• Ritual of Wakening: The Theurgist may command a recently deceased cadaver to awaken. On a successful Charisma + Occult roll (difficulty 7), the corpse will sit up and answer the Theurgist’s questions, to the best of its ability, for one minute per success. Every twenty-four hours the cadaver has been dead adds one to the difficulty. A cadaver more than three days dead cannot be wakened.
•• Ritual of Warding: Theurgists may protect an area from ghostly intrusion. With a successful Wits + Occult roll (difficulty 7), the Theurgist may block ghosts from entering a room-sized area. Each success indicates one week of successful warding.
••• Ritual of Communication: Theurgists may contact the dead by making a Charisma + Occult roll (difficulty 10). That difficulty drops, cumulatively, if any of the following criteria are met: Theurgist possesses an object important to the ghost in life (–1), a person important to the ghost is present (–1), the ritual is conducted in the ghost’s former home (–1), the ritual is conducted in a place where the veil between the Underworld and the world of the living is thin (–2). Maintaining contact with the dead is difficult. Each success rolled allows the Theurgist one minute of communication. The time period can be doubled for another point of Willpower.
•••• Ritual of Expulsion: Theurgists may expel a haunting ghost. This requires a Charisma + Occult roll (difficulty of the ghost’s Willpower + 3, maximum of 9); this is a sustained roll, requiring a number of successes equal to twice the ghost’s Willpower. Simply initiating the banishing costs 1 Willpower, but no more Willpower is required for the remainder of the struggle.
••••• Ritual of Vivification: The Theurgist can now urge a cadaver to rise. This via requires a Manipulation + Occult roll (difficulty 8). Every success animates the corpse for one week, and that time can be doubled for another point of Willpower. Animated cadavers will not have much in the way of personality or intelligence, but can follow simple directions.]==] },
				["Weather Control"] = { en = [==[M20 Sorcerer, p. 50


Weather Control


In societies that relied heavily on agriculture or seafaring, those who could control the weather were prized, often being the difference between life and death in their communities. Famines have been prevented or ended, and the most powerful sorcerers have been known to dispel or divert natural disasters.

Weather control allows sorcerers to do what it says on the package — they can control the weather. While they can’t directly make enormous weather shifts such as El Niños, what they can affect creates ripples through larger areas. No weather pattern happens in a vacuum, and this remains true for magical tampering with the weather. Many weather workers have some dots in Science, to account for being able to discern upcoming weather patterns. Many weather workers also learn at least a small amount of Divination for this purpose, frequently scrying in pools of water and clouds as their practices for such.

Though rarely consulted in the modern era, weather workers still practice in secret. The power they command is dramatic and potentially life-altering. Like healers, weather workers would be constantly pestered to perform miracles if their abilities were commonly known. At the same time, they would have to contend with those claiming out of fear and jealousy that the weather workers gained their powers through evil means.

Weather workers rarely function alone. The amount of effort required to produce adequate effects often necessitates teamwork. Some form covens around the goal of group weather control.

System

Modifiers: Weather control uses no rituals. The large number of successes required to produce effects lends itself to extended rolls and teamwork.

• 1 or more additional successes required to stop a severe thunderstorm or worse once it’s started. Calm weather is easier to stir up than nasty weather is to allay.

• +1 difficulty to cause any effect indoors.

Aspects: Weather Control uses the Aspects Distance (treat the measurement on the chart as the radius of effect), Duration, and Intensity:

Intensity

• Small changes only. This includes warm or cold breezes, slight but noticeable changes in temperature, and causing fire to momentarily flicker and flare.

•• The weather worker can cause minor affects that do not cause direct damage. The sorcerer might call up a dense fog that imposes perception penalties (see Mage 20 p. 435), clear a cloudy sky, or create winds in the direction they desire.

••• A sorcerer may form and dispel simple rainstorms. Strong winds can impose a penalty on ranged attacks by blowing the projectile off course and causing difficulties aiming. The weather worker may also change the temperature up to 30 degrees Fahrenheit in either direction. Depending on the starting temperature, this may impose or remove penalties from heat illness or hypothermia. Flash floods can also be deadly.

•••• A weather worker’s storm strength increases. They can now command gale-force winds, lightning, hail, and other damaging weather effects. They may now target individuals to take the brunt of the storm, and damaging effects do 4 + successes damage. Lightning causes lethal damage while bashing damage results from hail. Other effects may also cause damage, within reason. Weather effects can cause moderate penalties to those caught in the storms.

••••• The sorcerer can cause extreme effects. Thunderstorms are well within the weather worker’s grasp. Destructive tornadoes and other powerful meteorological activity can tear through a city. The sorcerer may cause 6 + successes bashing or lethal every 15 minutes to those in the storm’s path. Anyone caught in the storm also suffers maximum environmental penalties.

Price of Failure: Even intentional weather control effects might have unintended consequences on the environment both near and far. Weather pattern disruptions are no small matter. A botch, however, unleashes terrible effects depending on the nature of the changes sought. Lightning might directly strike the sorcerer or their allies. An arid climate might be hit with a monsoon the ground can’t accommodate, leading to widespread flooding. The local climate and possibly the surrounding area suffers dramatic, perhaps long-lived, changes. This can cause a crisis for the local fauna, plant life, and people who had no time to prepare and may not know how to cope with the new climate. Death, even if not immediate, is unfortunately a common risk when sorcerers play with the weather.]==] },
				["Animal Psychics"] = { en = [==[M20 Sorcerer, p. 54


Animal Psychics


Some people are naturally good with animals, and some psychics supernaturally so. This ability allows a psychic to exert their will to communicate with and control animals. Even the lowest expression of this Phenomenon allows a psychic to put an animal at ease by bridging the communication gap, rendering it more inclined to respond positively to the psychic.

A psychic may speak to and command an animal through a method of their choosing. Examples include silently locking eye contact, imitating noises animals make, dressage gestures, the psychic's native language, or a stream of gibberish. The method matters much less than the psychic's intent and force of will. Even at its highest levels, this phenomenon does not affect insects or any creature, such as jellyfish, which lacks a brain.

• Commune: A psychic may communicate with one animal the psychic can perceive through mundane senses (sight, hearing, etc). They may issue simple commands but cannot command an animal to attack. The psychic can, however, command an animal to stand down from an intended attack. Issuing a command an animal was inclined to do anyway requires no additional roll, but to command an animal to do something against its nature requires a roll of Charisma + Animal Ken with a difficulty of 9 minus the psychic's dots of Animal Psychics.

•• Mass Communication: As with Commune, but the Psychic may now communicate with multiple animals of the same species at once. Commands to animals may be more complex so long as the psychic can adequately describe it; however, animals won't typically attack for the psychic unless already inclined to do so. This level may alternatively target a single animal for expanded command capability.

••• Mind Link: A psychic may link minds with a single animal for instant two-way communication and the ability to sense what the animal senses. The psychic must initially sense the animal as per Commune, but the animal may travel outside of the psychic's perception range without breaking the link. This power ends when the psychic severs the link. The link can prove dangerous — any damage the linked animal takes results in psychic backlash, which causes an equal amount of soakable bashing damage to the psychic. If the animal dies while the link is active, the psychic must not only roll to soak the damage, but also roll current Willpower at difficulty 8. A failure renders the psychic stunned for 1 round. Botches can leave the psychic overwhelmed by the trauma of death for a scene and have lasting consequences, such as heightened startle responses, until the psychic regains one Willpower.

•••• Domination: A psychic may order any single animal to do anything within the animal's natural capabilities. The animal fights and dies for the psychic on demand without question. The psychic must adequately describe a command for the animal to understand what the psychic wants. Complex commands may still confuse an animal, though the animal does its best to interpret and carry out any command the psychic gives it. Once the psychic successfully activates this power, the animal follows the psychic's orders until either the psychic severs the connection, or the animal dies. Psychics using this power must also establish a Mind Link if they wish to continue issuing commands to the animal at range. This does not require additional rolls or Willpower expenditure, but it does open the psychic up to suffering damage when the animal is injured or killed as detailed above.

••••• Swarm: With mastery over this Phenomenon, a psychic may now use any lower ability on all animals the psychic can sense through mundane senses at once. The psychic's control is no longer limited to one species at a time. Using Mind Link in this way can quickly become dangerous, as every linked animal presents a risk of backlash damage if injured. The distraction of maintaining multiple mental links is overwhelming, inflicting a -3 dice penalty to all Attribute-based rolls until the Mind Link ends unless the psychic spends a point of Willpower when making the roll to temporarily push past the distraction.]==] },
				["Anti-Psychic"] = { en = [==[M20 Sorcerer, p. 55


Anti-Psychic


Anti-Psychic is the rarest psychic phenomenon. That said, it is very subtle. Many Anti-Psychics go through life unaware of their ability. It often takes an attack by, or other serious misunderstanding with, another psychic before the Anti-Psychic learns of their gift.

Anti-Psychic Phenomena scramble the abilities of other psychics with mental static. Those with a scientific paradigm theorize Anti-Psychic emanations use a similar basis for function as Telepathy. Instead of projecting a signal the recipient's brain can decode as a message, image, or impression, the theory is the Anti-Psychic projects a signal that interferes with the brainwaves responsible for psychic phenomena. Due to the nature of this Phenomenon, it's impossible for an Anti-Psychic to develop any other psychic phenomena. They are, however, capable of learning other Numina.

An Anti-Psychic disrupts all other psychic phenomena within their range of effect and enjoys a limited effect on those using the Mind Sphere. At higher levels, the Anti-Psychic may even disrupt vampiric Disciplines and Garou gifts. This Phenomenon remains perpetually active, even while the Anti Psychic sleeps, unless the psychic spends a point of Willpower to completely suppress the phenomenon for a turn or direct it to a single individual. If using Anti-Psychic against Mind Sphere effects or Night-Folk, the psychic does not automatically succeed but reflexively rolls activation at difficulty 7 or the mage's Arete, whichever is higher. On a success, the effects of the Anti-Psychic's ranks in the ability applies. For more information on countering Night-Folk powers, see Mage: The Ascension 20th Anniversary Edition page 546.

The rarity of this Phenomenon represents a mixed blessing. While many would not anticipate the ability, lending an element of surprise, the novelty can make the Anti-Psychic a tempting specimen for scientifically inclined supernatural entities. Whispered rumors imply that the Technocratic Union uses Anti-Psychics from their Extraordinary Citizens to bolster raids on known or suspected psychics.

• 5-yard radius. Add +1 difficulty to psychic phenomenon activation within the radius and +1 difficulty to Mind Sphere rolls.

•• 10-yard radius. Add +2 difficulty to psychic phenomenon activation within the radius and +1 difficulty to Mind Sphere rolls.

••• 15-yard radius. Add +3 difficulty to psychic phenomenon activation within the radius and +2 difficulty to Mind Sphere rolls. Add +1 difficulty for use of any mental-based Night Folk powers.

•••• 25-yard radius. Add +4 difficulty to psychic phenomenon activation within the radius and +2 difficulty to Mind Sphere rolls. Add +2 difficulty for use of any mental-based Night Folk powers.

••••• 40-yard radius. Add +5 difficulty to psychic phenomenon activation within the radius and +3 difficulty to Mind Sphere rolls. Add +3 difficulty for use of any mental-based Night Folk powers.]==] },
				["Astral Projection"] = { en = [==[M20 Sorcerer, p. 56


Astral Projection


Astral Projection allows the psychic to split their spirit, mind, or consciousness — or a combination of those depending on belief — from their body. The astral form is intangible and can cover vast distances in a short time, as it's not beholden to normal laws of physics. Astral travelers can peer into and even visit the Astral Umbra's realms of ideas (see Mage 20 p. 94). The psychic using Astral Projection cannot affect the physical world through normal means, though they may do so through other psychic phenomena at +2 difficulty. Botching Astral Projection activation causes a disorienting psychic backlash, preventing the psychic from leaving their body for 24 hours.

A psychic's body remains vulnerable while they are using astral projection, and the psychic cannot sense what's happening to it. It's a common fear among psychics with this ability that someone might move or harm their bodies while they're away. Many tend to limit their use of drugs and alcohol, because memory lapses can trigger the same fear.

Psychics can interact with astral spirits — denizens of the Astral Umbra and other astral traveling individuals. Astral Projection does not confer the ability to see and interact with ghosts. For combat while astral traveling, substitute Wits for Dexterity, Intelligence for Strength, and Perception for Stamina. Astral travelers usually appear as slightly idealized versions of themselves, including manifestations of gender or stylistic expression, freed from physical or societal limitations on such expressions. Alternatively, those with exceedingly poor self-image sometimes appear with exaggerated perceived flaws. Despite potential differences from physical appearance, astral travelers are typically able to recognize each other should they meet again in the physical realm.

Most psychics are only able to access the Astral Penumbra, but the most powerful have claimed to be able to travel further. Traveling into Otherworlds is risky business, and more than a handful of psychics have gone exploring, never to find their bodies again. Some believe leaving the body uninhabited for too long risks letting something else in.

• Peek: The psychic may spend up to one minute per point of Stamina astral projecting and travel up to one mile away from their body. A psychic can only use sight at this level — their other senses do not function while projecting. A character may also travel into the Astral Penumbra for this amount of time.

•• Errand: The psychic gains the ability to hear while astral traveling. They may travel up to 100 miles away from their body with a limit of 10 minutes per point of Stamina.

••• Journey: The psychic can travel up to 1000 miles away from their body and may remain in astral form for 30 minutes per point of Stamina. A psychic may choose to manifest as a blurry, ghost-like image of their astral form for one turn by spending a point of Willpower but may not speak. They do not show up on recordings.

•••• Failsafe: Upon being stunned or knocked out, the psychic may roll Astral Projection activation as a reflexive action. The psychic may use this power to seek help for their prone body, or simply as a way to remain useful while otherwise out of commission. The psychic may manifest as Journey, and while manifested, the psychic can communicate at whisper volume. The psychic's voice and translucent form do not show up on recordings. The psychic may travel anywhere on Earth and remain projected for up to an hour per dot of Stamina they possess, though they may spend a point of Willpower every hour they wish to continue traveling beyond this limit. They may use all senses as normal. Though the psychic may return to their body at any time before their normal limit is up, returning will not wake them unless the cause of unconsciousness has resolved.

••••• Odyssey: The psychic's astral travel abilities are legendary. The psychic can travel anywhere on or in Earth, extending to at least the edge of the atmosphere. Attempting to go further requires a Willpower roll at difficulty 9. So long as the psychic's body lives, including aid with life support technology, the psychic may travel indefinitely. If manifested, the psychic may speak in normal volumes and may choose to either appear in an indistinct, translucent form or deceptively opaque and may stay manifested for up to an hour per point of Willpower spent. The psychic may choose to show up on recordings.]==] },
				["Biocontrol"] = { en = [==[M20 Sorcerer, p. 57


Biocontrol


Most psychic phenomena involve the perception or control of things outside the psychic’s body, but Biocontrol allows the psychic to exert will over their body itself. A psychic can ignore pain, enhance senses, and even divert circulation or regulate hormonal levels at will.

While others can afford themselves minor degrees of control with biofeedback and meditation, psychics with Biocontrol can force their bodies to survive what appear to be hopeless situations. The mother who lifted a car off her child, the man who never seems drunk no matter how many drinks he downs, and the lone survivor of a tragedy are all examples of this phenomenon. The more miraculous the expression, however, the more likely the psychic inadvertently draws the wrong attention.

Beyond potential unwanted attention, Biocontrol isn’t without risk. Botches can cause biological processes to go haywire at exactly the wrong time, proportional to the effect the psychic was trying to achieve. A psychic needing to reduce their oxygen requirement to survive drowning might increase their metabolism and expedite their demise, but a psychic seeking social advantage with pheromones might embarrass themself by causing excessive sweating.

• Mindfulness: The psychic concentrates on altering their biological processes in minor ways. They can stop small wounds from bleeding, raise or lower their core body temperature by up to two degrees, hold their breath for an extended time, ignore pain from minor wounds, including wound penalties of up to half their Biocontrol rating (rounded up), and consciously regulate their blood pressure and pulse within normal range. The effect ends if the psychic’s concentration breaks.

•• Healing Factor: The psychic forces their body to accelerate the metabolic processes responsible for healing and fighting infections far beyond the normal rate. The psychic must spend time resting and meditating, ideally while receiving medical care — the psychic’s still mortal, after all. For every activation success, the psychic reduces the time to heal the highest health level by one level, to a minimum of one hour for bashing damage and one day for lethal or aggravated damage. After the first level of damage heals, the psychic may roll activation again to repeat the process. If using Healing Factor, psychics can ignore the permanent impairment risk (see Mage 20 p. 408) so long as they have sufficient nutrition and rest.

••• Surge: The psychic floods their system with hormones at will. Psychics choose Physical, Social, or Mental and split their activation successes between attributes from the chosen category to raise dots (to a maximum of 5 in any attribute) for one scene. This can represent an adrenaline surge allowing for “hysterical strength” in an emergency, a surge of dopamine to improve mental function, or modulation of serotonin and pheromones to make themselves calmer or subconsciously attractive in social situations. Deliberately causing hormone spikes strains the body: When the effect wears off, the psychic must roll Stamina at difficulty 5 to soak activation successes as bashing damage.

•••• Toggle Nerves: A psychic with this level of control enhances or reduces sensitivity in their nerves for up to one scene per activation success. The most common usage is temporarily deadening pain. A psychic may ignore wound penalties caused by pain by up to activation success number of health levels — it doesn’t allow the psychic to ignore penalties due to non-functional or missing body parts. A psychic may instead choose to deaden senses to ignore other noxious stimuli, such as powerful scents, sudden lighting changes, or temperature extremes. The psychic may ignore up to activation successes in distraction penalties and may split the successes across multiple penalty types. Alternatively, a psychic may increase nerve sensitivity, lowering the difficulty of perception-based rolls by activation successes and may split the successes across senses. However, increasing nerve sensitivity comes at a risk. Every success spent toward lowering perception difficulty with a sense adds to the difficulty of resisting distractions using that sense while the power is active. If the psychic increases touch sensitivity and sustains damage, they suffer additional wound penalties equal to their activation senses devoted to touch.

••••• Biological Mastery: The psychic achieves complete control over their body. They can stop and restart their heart at will, regulate digestion, temporarily suspend the need for oxygen, and put themselves in hibernation to force more extreme feats of healing — including regrowing parts. They can accelerate or suspend regeneration at a cellular level and may nullify toxins with an activation roll. Each activation success reduces the Toxin Rating of the substance by one. If the remaining Toxin Rating is lower than the psychic’s Stamina, the psychic may direct the toxin to a specific part of their body to run its course, suffering an Impediment (as the flaw, see M20 Book of Secrets p. 39) for the duration of the toxin’s effect. If the Toxin Rating is higher than the psychic’s Stamina after using Biological Mastery, the psychic suffers the toxin normally at the lowered Toxin Rating. A psychic may spend a turn concentrating and roll activation to soak lethal and aggravated damage with Stamina for a scene.]==] },
				["Channeling"] = { en = [==[M20 Sorcerer, p. 58


Channeling


A medium stands before a group and calls forth a dead relative with some letter of the alphabet for a name. Some attendee says they know someone dead with that name. The medium lets them know that they crossed over peacefully, and the spirit wants the best for them. They forgive the living for some vague sin that the attendee acknowledges, and nothing further is asked. Solace has been achieved and the medium gets paid. The reality show does great, and popularity grows. That’s all crap.

In the psychic community, there are those that channel the dead. It’s rarely for the purpose of making someone feel better though. The dead are a wealth of untapped experience that would make even the most learned master blush with envy. That knowledge is at the beck and call of the channeler, and when used correctly they are never without the right skill for the task at hand.

Channelers come in all shapes, sizes, and styles. Some of them are into the classic ‘eyes roll back and speak in another tongue’ Victorian-era trope. There are a few that drink home-brewed concoctions they’ve made for themselves that “open them up to the other side.” Modern channelers with a technological bent use spirit boxes and EVP devices to get their knowledge. In the end, the psychic is opening themselves up to a wraith in the Shadowlands that has the knowledge they need. The better they are, the stronger the connection to the skills and talents of the dead.

It’s a dangerous game to play, to be sure. Opening that door can lead to some nasty pieces of work sauntering into the psychic’s psyche if they aren’t careful. When things go wrong, full blown possession awaits the unfortunate channeler. But the flip side is being able to bring in the knowledge of a surgical genius in a medical emergency, an acrobat when crossing a precarious ledge, or a stone-cold killer when self-defense is required. Channelers are the first to say the risk is worth the reward.

When Channeling, the psychic can only bring forth one spirit at a time. The psyche of the channeler could easily be overwhelmed if more than one wraith is given access to their being. Should the psychic summon another spirit while currently hosting another from a previous channeling, the first is released and replaced by the second.

By necessity, the channeler has some insight into the Shadowlands, the realm of the ghosts. As they grow more powerful in their practice, the channeler can peer across the Shroud for a number of minutes equal to successes rolled. This is a separate use of their channeling talent and costs the same as channeling a spirit for their capabilities. The difficulty of this power roll is affected by the strength of the Shroud in their area and has no restriction on frequency of use, so long as the psychic has the Willpower points to spend.

• The channeler can tap into the other side and draw forth a ghost’s Abilities, though they may only access a single Ability per use of this power. Successes on the activation roll become bonus dice for rolls utilizing the desired Talent, Skill, or Knowledge for the remainder of the scene. When gazing across the Shroud, the psychic can gather a vague idea of the wraiths present.

•• The psychic can now access two Abilities simultaneously, splitting successes between desired traits. The channeler also can now make out more of the Shadowlands when peering across the Shroud. The channeler can discern details of the landscape and identify specific ghosts that are present.

••• Further growth now allows a third Ability to be channeled, subject to the limitations above. The channeler can now verbally communicate with ghosts beyond the Shroud.

•••• The psychic can now access any Talent, Skill or Knowledge, maintaining multiple channeled traits as long as they gain sufficient successes on the activation roll to cover the desired trait levels. Communication is no longer hindered by a short window of accessibility, and gazing across the Shroud lasts a whole scene.

••••• With a psyche girded by many trials and tribulations, the psychic is fortified enough to now channel two separate personalities at once. Note that each wraith channeled still requires its own cost and power roll. Should the Ability channeled be the same on each use, the bonus dice from both uses are added to dice pools using the Talent, Skill, or Knowledge.

At the pinnacle of their skill, with one spirit channeled, the medium may open themselves to a wraith and gain all the Abilities of the visiting spirit. Successes rolled during the channeling roll are now available to any Talent, Skill, or Knowledge that wraith may have possessed in life. The extra costs of channeling with such lowered defenses can be high, however. The spirit may request a favor, a task to be completed, or even the right to freely control the channeler’s body for a period of time.]==] },
				["Clairvoyance"] = { en = [==[M20 Sorcerer, p. 59


Clairvoyance


Clairvoyance refers to the capability to see beyond one’s immediate surroundings and out to great distances. In many cases, the projected sense can be any of the five senses, and the actual input received is rarely something so simple as a one-to-one analogue of the distant location. In most cases, the senses are bombarded with interpretive sensations that all add up to a single unified idea of the location, person, or object being perceived.

The more information a clairsentient has about their target, the clearer the image they receive. Reams of reports sit in government testing facilities with project names like Stargate, Grillflame, and Sunstreak that tell of scouted psychics giving impressions and corollary sensations to target observations. Items they were very familiar with were held in far off locations, mountain bases, desert outposts, and even submarines. The psychics would relay things such as getting a chill, seeing a noon-day sun, or feeling as though they were floating in a swimming pool. While a good start, the practiced clairvoyant can achieve far more accuracy and clarity. The most powerful clairvoyants can see a location hundreds of miles away with crystal clarity, and rumors whisper of powerhouses with global reach.

Some confusion does exist between what constitutes Clairvoyance and what is Astral Projection. There are those that insist they are the same phenomenon when mastery is achieved in either. The discerning psychic sees this conflation as laughable. The most well-informed physic scholars might offer this clarification: “Clairvoyance obviously takes advantage of the inherent connection between points in space, while the inner self leaves the body and is sent traveling via Astral Projection.”

This connection and familiarity with the subject of their viewing has a direct effect on their chances of success as well. Finding more familiar targets requires only one or two successes, while being a stranger to the subject will increase the number of successes needed to locate it. Once a connection is made, the clairsentient can observe the location or the area surrounding a person or object to whatever degree of clarity they achieved. A psychic attempting to refocus their second sight needs to make another roll (with the difficulty adjusted one lower for familiarity, if the new subject was viewed from their first focus).

• Experiencing remote locations is new to the psychic, and most observations are interpretive. This impression can be a physical sensation of cold steel for a knife, the smell of gunpowder for firearms, or a vision of a doghouse for guard dogs. In some cases, an actual image of the subject can be achieved, but this will be hazy at best. The one exception is hearing. Sounds come across the mental bridge garbled and unintelligible, if they can be heard at all. More successes grant more literal symbolic sensations, with five successes affording actual visual perception of the target, cloudy as it may be. Senses have a limited range for novices and reach to approximately one mile around the psychic. Retraining their focus requires another Willpower roll and another expenditure of Willpower to solidify their new remote subject.

•• Remote sight becomes more reliably achievable, albeit still shrouded in mild distortion or haze. Sound comes across far more frequently, with a chance of being clear enough to be understandable. Three successes on the Willpower test affords a near clear image of the subject with distorted sounds, while five successes grant crystal clarity and intelligible sounds that could convey the general subject and mood of conversations near the subject. The psychic can now push their senses further — out to ten miles away from their current location. The difficulty of the roll increases by one past 5 miles and by two at 8 miles.

••• Clarity is no longer an issue, and remote sensing brings sight and sound across the expanse without distortion. The clairvoyant unlocks a new avenue of clarified perception in the sense of touch. “Touching” a distant subject psychically returns muffled sensations, as though their hands were encased in heavy mittens. With clarity no longer a concern, successes now define the distance a clairsentient can reach, with each success representing ten miles of range. At this point, a new Willpower roll is still required to refocus but no longer costs more effort to perform.

•••• Sight, sound, and touch are all within the purview of the remote viewer. The clairvoyant also begins perceiving smells and tastes, with strong odors and flavors being detected when they are in abundance. Range now increases ten-fold, with each success equating to 100 miles of range.

••••• The clairsentient master can remotely view a location as though they are standing in the room. All five senses are received with exact definition, with no secret escaping their perception. Range increases ten-fold once more, with each success extending their reach by 1,000 miles. Finally, so long as the psychic is refocusing on an element that they can see within their current clairvoyant view, no new roll is required, as they forge new correspondences to subjects on the fly.]==] },
				["Cyberkinesis"] = { en = [==[M20 Sorcerer, p. 60


Cyberkinesis


Cyberkinesis is one of the most recently discovered Psychic Phenomena — the first instance documented less than a century ago — and represents the ability to control electronic machinery by thought. Experts in psychic phenomena theorize that Cyberkinesis is an information age variant of telekinesis. The psychic generates small electromagnetic fields that control and alter the firmware and software of electronics, ranging from fire alarms to super computers.

Though the cyberkinetic may psychically control the machine, they can’t psychically read its contents without Cyberpathy. All powers above dot one require the Cyberkinetic to have either access to the device’s display or to be able to access the device via Cyberpathy.

• Switch: The cyberkinetic may turn electronics off and on without touching them. +2 difficulty to activation if the electronic requires a physical relay rather than an electronic one. The psychic must be able to sense the electronic device to use this power. This is an exception to the usual requirement to access the device’s display and applies to devices without displays such as light fixtures.

•• Remote: The psychic may control electronics with their mind without having to use an input device such as a keyboard. This does not give any login or override credentials, but if the psychic knows credentials, they may enter them. Any action more difficult than operating an office computer raises the activation difficulty. This power removes the need for haptic input devices if the psychic uses Augmented Reality (M20 Operative’s Dossier, p. 58).

Difficulty Modifier = Example
+1 = Controlling a small office’s server network or a home security system, using a 3-D printer with pre-loaded designs
+2 = Psychically driving an electric car at highway speeds
+3 = Using specialized equipment such as a 3-D printer with no pre-loaded designs
+4 = Directing a computer-controlled factory
+5 = Operating a space shuttle single-handedly

••• Glitch: The psychic directs their electromagnetic fields to scramble electronic processes by causing tiny internal shorts and power surges. They can cause computers to lock up or blue screen and recording equipment to pick up only static. The effect requires active concentration. Most electronics return to normal after the effect ends, but some older tech simply crashes. A psychic using AR may use this as an attack on Icons and other Digital Web objects, dealing bashing damage. Use activation to attack, and substitute dots in Cyberkinesis for the weapon modifier in the damage roll. If the psychic inflicts 3 or more damage in one attack, the target is stunned for a round.

•••• Spoof: The psychic tricks operating systems into letting them in without valid credentials. If the system would be able to perform the task, the psychic can force the system to do it. The psychic may plant fake documents, install malware, give themself admin privileges, or erase data.

••••• Overclock: The psychic overrides safety limiters in electronics to force them to exceed their normal capabilities. A computer processes faster or runs more intensive software than it should be able to, an electric car accelerates faster, or an office laser pointer becomes a weapon. Every activation success adds an automatic success to the psychic’s next use of the machine, but the exertion damages the machine. Rolls to operate the machine after this power is used suffer a dice penalty equal to the activation successes until the device is repaired. Acquiring 8 or more successes when activating this power completely fries the machine after the Overclock effect ends.]==] },
				["Cyberpathy"] = { en = [==[M20 Sorcerer, p. 61


Cyberpathy


As experts believe Cyberkinesis is an information age variant of telekinesis, they similarly believe Cyberpathy functions on the same premise as telepathy — the Cyberpath decodes electromagnetic patterns in a computer’s hard drives to access information, just as a telepath decodes electrical impulses in the brain.

A Cyberpath must keep the computer in question in sight, except for Remote Access, where they must instead keep the entry point computer in sight. This ability may also target storage devices and media such as flash drives, disks, and external or unconnected hard drives. Typically, Cyberpathy takes 10 to 15 minutes, but each activation success reduces the time required by one minute. Until the psychic possesses dot 5, heavily encrypted systems increase the activation difficulty. Cyberpathy proves most versatile when combined with Cyberkinesis but can also aid mundane hacking attempts.

• Map Structure: The Cyberpath can examine the directory of computers and storage devices. The Cyberpath can find the location and properties of all files stored but cannot access the files using this power. This can be useful for Cyberpath hackers looking for specific data. The psychic can use this level to identify a device by its Augmented Reality Object ID if it is web-capable.

•• Read-only Mode: As Map Structure, but the Cyberpath may also read files. Plain text and graphics files are simple to view, and the Cyberpath may divine the functions of executable files and applications. The Cyberpath is unable to decrypt encrypted files at this stage. The psychic may view the device’s associated ARO if it is Level 1 or below and may divine the ARO’s properties if it’s a higher level.

••• Download: The psychic can use their brain as storage media, copying and pasting files found using Cyberpathy. The Cyberpath may access stored text, graphics, and videos at any time from their mind, but cannot run applications. The psychic may store a maximum number of files equal to the total of their mental attributes (Example: Coleen has Perception 4, Intelligence 3, and Wits 3. She may store 10 files in her mind). Larger files and applications may use more than one storage slot, while a zipped folder may contain multiple small files in one slot, at the cost of the psychic being unable to read any of the files while stored in this manner. The Cyberpath may later write any files they saved this way to any media they can access with Cyberpathy, with the option to either copy the file to the media or transfer it from their mind. If the device has a connected display device, the psychic can combine Download with Cyberpathy to write and display a file to others in the same turn. Deleting files from the psychic’s mind is a free action, but the psychic may only delete one file at a time. Larger files that took more than one storage slot take a number of rounds equal to the number of slots the file occupies to finish deletion, but the psychic may perform other actions as normal during deletion. The character may download an ARO from a device to upload later to spoof the device’s identity.

•••• Remote Access: The Cyberpath may connect to any computer or device, such as external hard drives, on the same network as their local device. This power only allows the psychic to treat the remote device as if it were in front of them, and any other powers must be activated separately. The psychic may access multiple devices on the same network at a cost of 1 Willpower per device. If the device is capable of internet access, the psychic may use this ability to access the internet, including the Digital Web. The psychic may use advanced AR devices as their point of access with this power.

••••• Enigma: The Cyberpath becomes a living decryption algorithm, able to crack even heavily encrypted systems and files with ease. The psychic may activate this power to ignore difficulty increases for lower Cyberpathy powers and mundane access on secure and encrypted systems or files previously stored using Download. The psychic may alternatively use activation successes to increase Cyberpathy and hacking difficulty for others on a file or device, at +1 difficulty per activation success if the psychic possesses dots in Computers or Cyberkinesis.]==] },
				["Ectoplasmic Generation"] = { en = [==[M20 Sorcerer, p. 62


Ectoplasmic Generation


There exist collections of séance photos from the height of the occult entertainment phase of society that display roiling masses of translucent, weightless mucus hovering about the heads of session leaders. Most write these off as simple imperfections in the film and move on to appreciate the relics of photography in their hands. True psychics know otherwise. Ectoplasm is the neutral spirit stuff of the ghost. A substance born from spiritual energy and activity, ectoplasm exists as liminal evidence of something beyond the physical. An entertaining parlor trick for the initiated, this plasm is far more useful than the layman may readily assume.

Through concentration and sheer force of will, a psychic gathers up ambient ghostly energies from around them and brings it into physical being inside their gut. This creates the unsettling sight of this coalesced spirit stuff flowing from the mouth and nose of the practitioner. Manifesting as slick, translucent, and cold gel, ectoplasm flows weightlessly when not given direction. Responding to the will of the generator, the pliable spirit matter can take many ghastly forms to disgust or impede the unwary, while dissolving into nothing mere minutes after concentration is broken. Much to the dismay of witnesses, ectoplasm leaves no physical or spiritual evidence at all once sublimated.

Possibly ectoplasm’s most useful property is that no matter how wispy, slimy, or goopy the ectoplasm may seem to the average person, it will be as hard and immoveable as pure lead to the spiritual. Ghosts, wraiths, spirits and astrally projected souls all find ectoplasm very solid and nigh impassable. This has a myriad of uses ranging from creating a barrier around a room by smearing the walls to coating one’s hands in the stuff to allow the psychic to touch the immaterial Shadowlands, whether with benevolence or violence. This Phenomenon does not allow the psychic to see into the Shadowlands unfortunately. It merely allows them ability to create a substance of both spirit and matter.

• When one first starts exploring their capabilities as a generator, it starts with rather juvenile seeming practices. Novice generators don’t find the act of creating ectoplasm difficult. The real difficulty lies in creating a substantial volume and force. This leads to the fledgling generator being unable to force the semi-liquid plasm from their orifices without assistance. Reaching into their mouth, nose, and ears to draw forth the substance by hand or by relying on peristalsis, the generator must work to bring it forth. Every success on the activation test generates a softball sized volume of the sticky substance. It only lasts a number of turns equal to the generator’s Willpower, but it can be applied as quickly as it is generated. Covering an object with a thin layer of ectoplasm takes no extra steps beyond generating it. The plasm sticks to all surfaces and does not wipe away easily. It will cling and string to anything touching it and only sublimates into nothingness when the duration expires.

Another novel approach users find early is the “smoking man” technique. When coaxed correctly, ectoplasm can also come forth as a mist like vapor. Lingering licks and tendrils of thick smoke seep from the mouth, nose, and tear ducts of the generator. Lasting for a number of turns equal to the psychic’s Willpower, this should be taken into account when dealing with social interactions. Using the technique can add a bonus die for situations such as a stage magician’s routine or intimidating an unsuspecting tough but incurs a -1 penalty to Abilities such as Expression or Leadership due to the disconcerting sight of this ectoplasmic cloud.

•• Once Ectoplasmic generators hit their stride, the degree of advance in control is astounding. With each success on the activation roll, a psychic generates a quart’s worth of the slimy fluid. With such an increased volume, assistance is not required to force the plasm out, as it simply pours from the nasal and esophageal orifices of the psychic. There is no discomfort in this, and more than a few generators take a sick glee in others’ revulsion to their practice. All plasm phenomena now last a number of minutes equal to the generator’s Willpower.

A mist generated now gains a measure of responsiveness to the creators will. The psychic can now push the mist outward into a cloud that moves and shifts at the generator’s mental command. The speed of the cloud is not impressive at 10 feet per round, but it can be used to obscure prying eyes, imposing a +2 difficulty to Perception tests. This mist cloud has a radius of 1 foot per Willpower of the psychic.

••• Plasm fluid generation is a child’s trick to the seasoned generator. Each success on the activation roll now summons forth a gallon of liquid in a steady flow. The force of the stream is not enough to cause an individual to lose a step, but it is enough for the generator to strike the corner of the ceiling in a standard room.

Ectoplasmic mists gain a degree of solidity. No longer just smoky wisps, the mist is now solid enough to feel like cotton candy to the living. This is in concert with increased volume of 5 feet of radius per dot of Willpower. Attempting to force past the thick semi-solid mist requires a Strength + Athletics roll (difficulty 6). Thick enough now that the mist is all but opaque, it also provides visual cover and increases the difficulty of seeing and attacking through it by +3, similar to a heavy smoke grenade.

•••• Fluid and mist are useful, but access to solid mass and crafted forms expand possibilities for creativity tenfold. The volume does not increase, but now the channeler’s output can result in solid matter the consistency of heavy lard. With greater structural stability, the ectoplasm can hold definite shapes that are only hindered by the generator’s creativity. These creations have a number of points equal to the Willpower of the psychic to be distributed between Strength, Dexterity, and Stamina. The creation has 3 health levels and suffers no wound penalties. While not capable of complex movements, the solid ephemeral creations can move through space at 30 feet per turn. The creations are psychically tethered to their creator and cannot leave their physical perception and retain movement. Finally, all plasmic creations are no longer hindered by a time limit and last as long as the generator concentrates.

••••• Full torso-ed, free floating, vaporous apparitions are at the pinnacle of the generator’s craft. Still puppets of the creator, shaped creations may now fully animate as appropriate to their complex forms. While unable to fool someone into thinking it’s the genuine article, the shapes can now roughly mimic people and creatures, even emitting groans as pockets of air escape within the gooey form. The forms are still limited by the volume generated on the roll, with an adult-sized being of ectoplasm taking three successes to fill out. The creations follow the same rules for Attribute distribution as detailed above but have 6 health levels and suffer no wound penalties. Ectoplasmic puppets can be possessed and controlled easily by ghosts in the area. The psychic spends 1 Willpower to hand the reins to a nearby, willing ghost. The ghost then has total control of the ectoplasmic construct, using it as though it were their own body. Once the psychic hands the body over in this fashion, it lasts for a number of rounds equal to the psychic’s Willpower score, after which the puppet’s ectoplasm dissipates. Other manifestations the psychic creates are not affected and remain extant as long as the psychic concentrates.]==] },
				["Mind Shields"] = { en = [==[M20 Sorcerer, p. 65


Mind Shields


A mind is a terrible thing to waste. Many psychics live by this credo. There are people and things out there in the world that assault the mind directly, but some psychics are gifted with the ability to prepare against this potential threat. Building walls against mental attacks, ensuring thoughts are too chaotic to control, or just inherent mental fortitude are all possible sources for this defense.

As the name implies, Mind Shields only affect powers that affect the psychic's mind. Powers that originate from the mind of another but affect the world around the shielded psychic are unaffected. A psychokinetic has no harder a time lifting and holding a psychic with Mind Shields in place than they would a normal person.

Mind Shields, being a Psychic Phenomenon, have an easier time dealing with Psychic Phenomena than other forms of mental assault. A vampire who wields Dominate taps into the mind in a different manner than a psychic with Psychic Hypnosis. Unfortunately, Mind Shields are only half as effective against mental attacks from non-psychic sources.

When confronted by a mental assault or invasion, the psychic's Mind Shields provide a dice pool to counter the effect. The target rolls these dice (difficulty 6) and subtracts their successes from those of the attacker. A defender that rolls more than the attacker disrupts the assault completely, and the attack fails. For powers that normally call for a defense roll, Mind Shields dice are added directly to the defense roll instead.

• Defenses are thin, but present. The Psychic receives 2 dice to counter mental attack phenomena and 1 dice for mental attacks from other sources. At this point, Shields are always active and cannot discern friendly and hostile effects. The psychic can lower their Mind Shields to allow access to a friendly psychic, but this leaves them open to any other mental ability used before they are raised once again.

•• Layers of mental chaos or thicker walls of the mind are built. The psychic receives 4 dice to counter mental attack phenomena and 2 dice for mental attacks from other sources.

••• The psychic's mind is a confusing mess or a sturdy bunker to any invader. The psychic receives 6 dice to counter mental attack phenomena and 3 dice for mental attacks from other sources. The ability to modulate one's Mind Shields becomes clear at this level. Whenever presented with a mental ability that attempts to interact with the shielded psychic's mind, the target may decide whether to let this pass their shields or not. Note that this doesn't identify every ability used, merely that an attempt is underway to access the psychic's mind. It is up to the deductive reasoning of the target to work out who stands before their mental gates.

•••• A mental bulwark or a confounding mire of scattered thought greets intruders. The psychic receives 8 dice to counter mental attack phenomena and 4 dice for mental attacks from other sources.

••••• The psychic's mental fortress stands impenetrable or infinite maze unnavigable. The Psychic receives 10 dice to counter mental attack phenomena and 5 dice for mental attacks from other sources.]==] },
				["Precognition"] = { en = [==[M20 Sorcerer, p. 65


Precognition


The psychic experiences clues about the future. The future isn't fixed and may change depending on the choices people make. The more decisions required for an outcome, the lower the prediction accuracy. No seer has proven 100 percent accurate, except for the mythical Cassandra.

Precognition allows a psychic to judge outcome probabilities with above-human accuracy. Scientifically minded psychics rationalize precognition as conscious manifestations of subconscious perception analysis. Mystical-leaning psychics understand precognition as a sort of sixth sense with no scientific explanation.

While a psychic may activate precognition, a Storyteller may call for activation for story purposes, in which case no Willpower is expended for that activation.

• Intuition: The seer gains a knack for guessing correctly. For purely random events (lottery, dice rolls), the predictions can be rather accurate. The psychic can intuitively know the shortest route to a given destination and enjoys a higher likelihood for beneficial chance meetings. The psychic experiences no visions, they just “have a feeling” and guess very well. Even with five or more successes, predictions are unlikely to be entirely accurate.

•• Insight: The psychic experiences dreamlike visions during sleep and waking hours alike. Like dreams, they are rarely literal. Instead, the visions are steeped in metaphor. An enemy might appear as a fierce dragon or figures in clandestine robes, where a beloved mentor might appear as a long-dead parent. The imagery depends on the seer's paradigm, and while more successes offer detailed visions, they are always subject to interpretation.

••• Danger Sense: The seer's connection to the future becomes an early-warning system. The psychic perceives this as anything from a piercing temple headache, to cramps, to a creeping sense of dread. No matter the manifestation, it's always the same for the seer. This power is always “on,” though may be subverted with certain Sphere effects or the Anti-Psychic Phenomenon. When something unnoticed targets the psychic, the Storyteller rolls Danger Sense activation before rolling ambush. This power does not cost the psychic Willpower to activate.

Successes = Effect
Botch = The seer unwittingly puts themself in worse danger and loses their roll to spot the ambush.
Failure = The psychic gets no intuition about the situation.
1 = The seer senses they're in danger but gets no specifics. They get 1 bonus die to spot an ambush.
2 = The seer senses they're in danger and receives simple instruction on how to avoid it such as “duck,” or “run.” The psychic gets 2 bonus dice to spot the ambush and dodges normally if the attacker remains hidden.
3 = The seer knows they're in danger, how to avoid it, and the direction of the danger. The attacker doesn't roll ambush and the attack resolves normally.
4 = The seer knows the details of the attack and gets a turn of warning. The psychic gains a turn to prepare before the danger happens.
5 = The seer gets a turn of warning and a vision of those responsible. The psychic will be able to identify the person by sight and/or with psychic intuition should the psychic see or be in the presence of the person later. The psychic imprint also functions on recordings and creations, such as paintings or letters, made by the attacker.

•••• Clarity: The seer enjoys a near-perfect view of the immediate future. For every activation success, players and Storyteller announce their general future plans for one turn. If the psychic interferes with time — such as moving behind cover to foil an attack, the future changes, and the psychic must reactivate this power for updates.

••••• Roads of Time: A psychic sees more than only the most likely outcomes and their relative probabilities. As Insight, but the psychic sees time as diverging roads branching off at decisions. The seer identifies otherwise innocuous-seeming decision points before the choices are made. This also allows a psychic to see which future events are difficult to change and which events are most malleable.

Successes = Time Range
1 = 12 hours
2 = 24 hours
3 = 1 week
4 = 1 month
5 = 1 year
6+ = 1 additional year per success

Providing information about the far future can be difficult for the Storyteller. The Storyteller may instead grant one reroll for every precognition success for the story. This represents the psychic's ability to juggle relative future probabilities. A psychic may use as many of these rerolls on a single action as they wish.]==] },
				["Psychic Healing"] = { en = [==[M20 Sorcerer, p. 66


Psychic Healing


Many cultures have legends of people blessed with the power to heal through little more than a touch. Some of these were likely psychic healers. By channeling their will and energy, a psychic may perform miracles. Many with this gift choose to be discrete about it — fame and pressure to perform miracles can be daunting, and the enemies a psychic healer can make within the medical establishment are detrimental. Practicing medicine without a license, even in areas with little healthcare access, remains illegal.

Though not required, many with this gift have a great deal of medical knowledge, often acquired informally. Nearly all psychic healers have high empathy, which some suspect the gift stems from.

Botches when performing medicine of any kind are devastating, but a psychic healer might transfer the injury or illness to themself. Other possibilities include healing a wound grotesquely or misdirecting healing energies, causing autoimmune or cancerous responses.

• Diagnosis: The healer instantly diagnoses disease or injury through sight or skin contact. The diagnosis terminology depends on the psychic's medical knowledge — one with little knowledge might describe lupus as “the body fighting itself.” A psychic may use Diagnosis successes in a complimentary roll (see Mage 20 p. 389) for Medicine rolls. If using teamwork, the psychic may contribute successes to the medical professional's roll up to the psychic's Medicine rating.

•• Restorative Slumber: With a touch, the healer focuses their patient's body's energies on healing. Treat successful activation as skilled medical treatment for bashing and lethal damage and as magickal stabilization for aggravated damage. The touch must last at least one minute, after which the patient falls into a deep sleep. At 3+ successes, the patient also regains one point of Willpower.

••• Urgent Care: The psychic's healing ability now facilitates the rapid resolution of mild injuries and poisons. A psychic touches the patient and may heal up to their activation successes in bashing damage at a rate of one per turn. Every two successes can reduce the Toxin Rating of a poison, drug, or illness by one, up to 3 levels of reduction.

•••• Intensive Care: The healer may now heal the gravely wounded. The psychic heals up to 1 lethal per activation success and can reduce the Toxin Rating of poisons, drugs, and illnesses by one level per success. Each level healed takes 10 minutes, during which time the psychic must maintain physical contact with the patient. The process is clearly supernatural to any witnesses, as wounds miraculously stitch themselves shut and harmful substances sweat out of the target's skin.

••••• Psychic Surgery: The psychic may now heal grievous wounds, cancers, and infections. The psychic heals up to 1 aggravated damage per success. Each level healed takes 10 minutes as the psychic closes their eyes and gestures as if reaching into flesh. Healers may also use this ability to harm, by reaching into a victim and physically removing healthy tissue — a horrific and bloody process. Outside of combat the psychic can use this power to inflict aggravated damage on a restrained target. Like healing, this application of the power takes 10 minutes per health level. Each success on the activation roll causes one health level of unsoakable aggravated damage. This use of psychic healing is sadistic and considered torture, but in combat, there's not enough time to use this power to its fullest extent. Psychic Surgery can only be used in combat to cause pain — it inflicts wound penalties as if the psychic had wounded the target but causes no damage. The victim may spend points of Willpower equal to the psychic's activation successes to “heal” the damage.]==] },
				["Psychic Hypnosis"] = { en = [==[M20 Sorcerer, p. 67


Psychic Hypnosis


While modern hypnosis is a form of therapy anyone could learn, some psychics have a natural gift for it with effects far beyond the trained variety. With the increase in popularity and recent research on hypnotherapy, psychic hypnotists can practice their gifts in the open without much fear of attracting the wrong attention.

Psychic hypnosis is neither as fast as vampiric disciplines nor as versatile as the Mind Sphere. Even so, a particularly gifted hypnotist can achieve many similar effects.

• Trance State: The hypnotist puts a willing target in a calming trance state, though they cannot issue commands. In this state, the target can remember events and details more clearly and gains a difficulty reduction to any rolls involving memory recall equal to activation successes, to a minimum difficulty of 2. The target also regains one point of Willpower for every activation success, though they cannot benefit from this function again until they’ve rested normally. It takes five turns to place the target in the trance and the trance breaks if anyone disturbs the target. The hypnotist may also put themself in a trance.

•• Suggestion: The hypnotist commands a target to perform actions after placing them in a trance. The psychic may give one command per success, and the command can neither obviously result in the target’s death nor go against the target’s Nature. The psychic may force the target to ignore pain responses and forget commands given in the trance as additional commands if the psychic spends successes to do so. Only the psychic decides when the target comes out of the trance. The target ignores incompatible commands instead of breaking the trance.

••• Implanted Suggestion: A psychic implants suggestions that will activate outside of the trance. For each success, the psychic may implant a command or condition to activate an implanted command. This condition may be a time or sensory trigger. One of the commands may be to automatically enter a trance under a specified circumstance. As Suggestion, the attempt automatically fails if it would obviously result in the target’s death or conflicts with the target’s Nature. Commands aren’t recurring unless the hypnotist spends an extra success to add a recurring condition.

•••• Fast Trance: The psychic instantly puts willing subjects in a trance and may spend a point of Willpower to put an unwilling subject in a trance, though an unwilling subject may roll Willpower (difficulty 7) to resist, with each success negating one of the psychic’s activation successes. The number of net activation successes is the number of turns the target remains in the trance. The psychic may roll to activate additional powers starting on their next turn.

••••• Sleeper Agent: The psychic performs advanced levels of brainwashing and conditioning, the kind governments clamor for. The psychic implants commands for the target to do anything, even to the point of death, and the target consciously remembers nothing said during the trance. This power takes 10 minutes to put the subject in a trance, which cannot be shortened with Fast Trance. The target must clearly hear the psychic’s voice. Additional sounds and distractions make the use of this power impossible, so psychics with this ability often designate special rooms for the purpose. The psychic spends one point of Willpower to use this power on an unwilling subject. Each activation success allows one command to be implanted, and each command or condition takes one hour to implant.]==] },
				["Psychic Invisibility"] = { en = [==[M20 Sorcerer, p. 68


Psychic Invisibility


Psychic Invisibility is not true invisibility. This Phenomenon is like Psychic Hypnosis on a larger scale but with limited scope. The psychic tricks others’ minds to simply overlook the psychic, as if projecting the command “don’t notice me.” The psychic shows up on recordings as normal, but those watching a live feed don’t notice the psychic. Their attention diverts to other details in the recording instead. This ability doesn’t prevent tripping electronic or mechanical alarms that require no human input to trigger, such as motion alarms.

Animals can’t be fooled with this Phenomenon unless the psychic also possesses Animal Psychics — their minds are too different from humans and humanoid creatures. If a psychic blocks a door or item someone expects to see, the affected individual won’t notice the door or item either. If a being with enhanced perception searches for the psychic or other supernaturally hidden things generally, they may attempt a contested roll to determine whether the being pierces the psychic’s illusion, pitting their appropriate dice pools against the psychic’s activation successes.

Activation successes determine the strength of the Phenomenon’s effect. One success leaves the psychic noticed but difficult to focus on and unable to be identified. This also adds a +1 difficulty to attack rolls targeting the psychic while active. Three or more successes keeps the psychic completely concealed unless successfully contested. Mind Shields and some Mind Sphere effects can protect against this Phenomenon.

• Wallflower: So long as the psychic remains completely still and silent, they stay unnoticed. However, the psychic needn’t hold their breath — only heavy or loud breathing breaks the effect.

•• Slink: The psychic moves while invisible but can’t interact meaningfully with the world. The power breaks if the psychic does anything to draw attention to themself or interacts with the world, such as writing on a chalkboard or opening a door. A psychic may make a Wits + Stealth roll at difficulty 7 or higher to avoid accidentally breaking their power in unfavorable conditions like twig-covered forest floors or a room with a motion alarm.

••• Invisibility: The psychic may now perform any action while invisible, even if those actions would normally draw attention to the psychic. Beings with mundane senses may make a Perception + Awareness roll at difficulty 9 to see the psychic if the psychic attacks them or they are specifically searching for the psychic. The being searching must exceed the psychic’s activation successes. The psychic cannot vanish while someone directly observes them.

•••• Selective Invisibility: The psychic controls who they project the “don’t notice me” command to. For every activation success, the psychic may declare one person exempt from the effect. Anyone declared exempt perceives and interacts with the psychic normally, but everyone else is treated as if the psychic activated Invisibility. Note that others can still perceive anyone interacting with the psychic, and this may draw negative attention.

••••• I Was Never Here: At the highest expression of this Phenomenon, a psychic vanishes in front of witnesses and erases their presence from witness minds. The psychic rolls activation opposed to the witness with the highest Perception + Awareness pool. The witness rolls at difficulty 8. At one net success, the psychic vanishes from view, confusing and unnerving any witnesses. At three or more net successes, the witnesses also forget the psychic’s presence for one past turn per success. It’s possible that witnesses could forget ever seeing the psychic, if the observation was short.]==] },
				["Psychic Vampirism"] = { en = [==[M20 Sorcerer, p. 69


Psychic Vampirism


Everyone knows that one person you can’t be around long without feeling emotionally and spiritually drained. A psychic vampire could be anything from a DMV worker, a droning professor, the one too-eager coworker who won’t shut up at a meeting that could’ve been an email, or something far more sinister. For a psychic vampire, the energy and emotions they drain from their unwitting victims gives a euphoric high unlike any drug in addition to other beneficial effects. Like many drugs, the feeling can become addictive.

It’s unclear whether the power develops in those prone to using others as resources, or the effects of the power once it develops greatly changes people. In either case, this Psychic Phenomenon can bring out the worst in people. Of note to those who study the supernatural, psychic vampires often have or develop many of the same psychological idiosyncrasies Kindred are prone to.

• Tap Energy: The vampire feeds on others’ strong emotions, both positive and negative. The vampire senses what the emotions are as they feed and may use this power to gauge an individual’s emotions over time. It only requires one success to taste the nuanced palate of a person’s emotions and give the vampire a pleasant high. At three successes, the vampire regains one lost Willpower, and regains an additional Willpower per success beyond the third. The vampire must be within 10 yards of the victim and be able to sense them. The victim is unnerved, and their emotions are muted — but not absent — until the end of the scene.

•• Invigorate: The psychic drains a victim’s vital energies to empower themself. Every success drains one temporary Willpower from the victim and adds it to the vampire’s pool, up to a maximum of 10 total. Every Willpower over the vampire’s normal maximum gives a euphoric high and fades at one point per hour. The range is 15 yards, and the vampire must sense the victim to target them with this power.

••• Leech Vitality: This extremely dangerous power allows a vampire to use another’s life force to heal themself and experience an indescribable high. The psychic must touch the victim for one turn per health level of damage healed, up to activation successes. Bashing heals first, then lethal, and then aggravated downgrades to lethal. Every excess success that doesn’t result in healing restores 2 Willpower points to the psychic, as Invigorate. Every success used deals one lethal damage to the victim. If contact is interrupted before finishing, the psychic does not heal and must make another attempt.

•••• Essence Feast: The psychic isn’t limited to one victim at a time. The psychic rolls activation to determine the maximum number of simultaneous targets, gaining one additional target per success. All targets must be within 40 yards of the vampire, but the vampire doesn’t have to be able to sense all of them. On success, the psychic may activate any lower power on the same turn, using the normal costs and activation roll associated with the lower power. The psychic is stunned for the next turn — the influx of multiple flavor profiles at once is as overwhelming as it is euphoric for the psychic. A botch can cause a “bad trip” as if the psychic ingested hallucinogens and leave them stunned for the remainder of the scene.

••••• Distant Drain: The vampire’s mastery over tapping vital energies allows them to re-tap a previous victim over a distance. The vampire must have used either Telepathy or another Psychic Vampirism power on the victim previously. The activation successes specify a maximum range at which the vampire may use a lower power on the victim.

Successes = Range
Botch = May not use Psychic Vampirism on this target for one month
Failure = Nothing happens
1 = 500 yards
2 = 1 miles
3 = 2 miles
4 = 5 miles
5 = 10 miles
6+ = +10 miles for every success above 5]==] },
				["Psychokinesis"] = { en = [==[M20 Sorcerer, p. 70


Psychokinesis


Every once in a while, there is a YouTube video, a TV special, a variety show, or a book published about some enlightened master who has expanded their minds to the point where they can bend a spoon or shift a book 6 inches across a table. Every person that watches or reads about these feats sit in awe and wonder of the possibility of moving objects with the sheer force of their mind.

Psychokinesis, or telekinesis to some, is beautiful in its simplicity. There are no subtle tricks or illusory veils. There is only the simple movement of matter through space through sheer force of will. As the psychokinetic grows in strength, they hone their accuracy and increase the maximum weight they can set in motion. The inexperienced only moves small objects, and very clumsily at that. On the other hand, a master psychokinetic can lift massive loads and move them at startling speeds, while also being capable of feats of fine motor skill that most have trouble performing with their own hands.

Psychokinesis grants the psychic a Strength and Dexterity score for their actions once activated. This only requires one activation per instance of the Phenomenon and remains active as long as the psychokinetic maintains concentration or until the end of the scene. Using psychokinesis requires the psychic be able to see their intended target with their own eyes. Each success on the activation roll allows for one separate target to be manipulated, but the total weight of all targets cannot exceed the lifting capacity of the psychic. Any time the psychic takes damage, they must make a new Willpower roll to maintain concentration. If they roll fewer successes than the number of targets they are currently manipulating, they must select targets to release until the number of targets matches the new success total. If more successes are rolled, the number of manipulated targets remains unchanged.

A psychokinetic with the power to lift a person may do so unimpeded. The target is allowed a Strength + Athletics test to grab hold of a sturdy anchor point if one is nearby to hold on to. If a secure grip point is not available, the target is helpless to stop the power of the psychokinetic barring supernatural advantages of their own.

Once a target is being manipulated, actions taken with the target use the Strength or Dexterity of the psychic’s Psychokinesis and the appropriate Ability required for the action. For example, a gun being manipulated would call for a psychokinetic Dexterity + Firearms test to fire. “Throwing” a manipulated object requires that the item be released while propelling it with an appropriate Strength + Athletics test. The disconnect and lack of contact with a manipulated target causes all actions taken via psychokinetic manipulation to suffer a +1 difficulty. Attempting to perform a psychokinetic action with more than one manipulated item in the same turn requires the psychic to split their dice pool as normal for taking multiple actions.

• With a mental Strength and Dexterity of 0, the psychic can only lift a maximum of 5 pounds. Objects take a sluggish and clumsy path through space when moved and have a maximum speed of 5+ Wits yards per round.

•• The psychic’s mental Strength and Dexterity rise to 1, and objects have a movement of 7+ Wits yards per round.

••• Growing power and understanding have provided the psychokinetic with a mental Strength and Dexterity of 2. Manipulated targets move at 9+ Wits yards per round.

Further unlocking their understanding of kinetic force as a tool of the mind bears fresh fruit. The psychic can now make one ranged attack with their action through sheer force. The psychokinetic force hits like a punch from a distance using the psychic’s mental Strength and their Brawl or Martial Arts as a dice pool to attack, with base damage equal to their mental Strength. This attack represents concentrated use of the Phenomenon and cannot be used while performing any other psychokinetic action. This application is also instant and requires the full cost of activating the Phenomenon every time.

•••• The psychic’s mental Strength and Dexterity are now 3, and they can move manipulated objects at 11+ Wits yards per round.

Yet another new application becomes available to the psychokinetic. The psychic has internalized their psychokinetic force and now may levitate themselves regardless of weight at a rate equivalent to their walking speed. This usage of the Phenomenon takes greater concentration than most and therefore cannot be used while lifting other targets.

••••• A psychokinetic master has a mental Strength and Dexterity of 4 and can move manipulated targets at a rate of 15+ Wits yards per round.

Both refined actions of the phenomenon receive upgrades at this level. Levitation is now second nature and can be performed while lifting other targets, and Psychokinetic assaults may now cause bashing or lethal damage.]==] },
				["Psychometry"] = { en = [==[M20 Sorcerer, p. 72


Psychometry


Psychometry is one of the more emotionally taxing Phenomena to the psychics gifted — or cursed — with it. By touching objects, the psychic can read the emotional resonances left behind and see visions associated with the object. It’s not always clear which objects have strong resonances: an office coffee mug could have only fleeting impressions. However, it could be a cherished gift from a child or even the mug a worker had in her hand when she learned of a loved one’s death.

It takes mere seconds to read the resonances, even if the vision seems to last much longer from the psychic’s perspective. The number of activation success dictates the level of detail the psychic receives. Many successes give clear and vivid impressions, which are prone to making the psychic feel the emotions and pain for a time, where fewer successes only give fleeting impressions. On a botch, the psychic becomes lost in the visions, temporarily merging in personality with one of the individuals from the event and possibly acting it out. When a psychic with Psychometry touches an object with immense emotional resonance, the Storyteller may call for a reflexive Psychometry roll.

• Impression: The psychic can get dreamlike impressions of recent events involving the object or more distant events with strong associated emotions. The psychic at this stage mostly gets emotional readings and vague, figurative imagery. At 3+ successes, the psychic may also see an accurate image of the person most closely associated with the object.

•• Reveal Scar: The psychic gets impressions of the event with the strongest emotional resonance associated with the object. They get dreamlike and imprecise images of the event. With 3+ successes, they also determine the owner’s approximate age, personality cues, connection to the object, and what the owner felt at the time.

••• Replay: The psychic clearly experiences the event and may gather general impressions of what happened to the object’s owner the day of the incident. Alternatively, the psychic may replay the object’s last 24 hours, even if nothing emotionally significant happened.

•••• Tether: The psychic may use the object as a psychic tether to the object’s owner. Activating this level gives the psychic insight into the owner’s current location to track them. In addition to clearly seeing the event with the strongest emotional resonance associated with the object, they also read emotional impressions and visions of the other people at the event and their feelings.

••••• Catalog: The psychic may use Tether on any event the object was associated with, not only the ones with the strongest emotional impact.]==] },
				["Psychoportation"] = { en = [==[M20 Sorcerer, p. 73


Psychoportation


Psychoportation, also sometimes called teleportation, is a powerful psychic ability to suddenly be elsewhere. This is one of the more powerful and rare psychic phenomena. The occasional narrow-minded Correspondence Sphere Mage has been put in their place by watching a simple psychic psychoport out of danger’s way without earning Reality’s ire.

No one knows for sure how psychoportation works, but some theories include dissipating into the air and reforming in another spot, a variation of astral travel, or personal wormholes. What’s known is a psychic can’t carry more than about 100lb of extra cargo without suffering severe strain, causing the psychic at minimum 6 levels of bashing damage that can be soaked normally. This increases by 1 level of bashing damage for each additional 25 lbs. the psychic attempts to move. Failing to soak the damage results in a disastrous fate for the cargo, such as psychoporting the contents to the wrong location, into a solid object, or the nearest body of water. On rare occasions the cargo seemingly ceases to exist. To travel to a place via psychoportation, the psychic must see the intended destination with mundane senses or psychic abilities — their own or someone else’s.

A psychoportation botch typically means the psychic misjudged the jump and landed inside a solid object — or worse, a person. This causes 8 dice of aggravated damage to the psychic and the unsuspecting object. Occasionally, a botch might transport a psychic to a hazardous or unfamiliar location, or the psychic might leave or inadvertently bring something they weren’t supposed to.

• Short Hop: Range up to 12 + Intelligence yards in a turn.

•• Simple Jump: Range up to 20 + (3 x Intelligence) yards.

••• Long Jump: Range up to 40 + (6 x Intelligence) yards. The psychic may spend a turn of concentration and roll activation at +1 difficulty to double this range.

•••• Leap: Range up to 80 + (12 x Intelligence) yards. The psychic may double, as per Long Jump.

••••• Leap of Faith: The psychic no longer needs to sense a stable location to psychoport to it. The psychic may spend a scene studying the location and successfully roll Perception + Alertness at difficulty 8 to commit it to memory.]==] },
				["Pyrokinesis"] = { en = [==[M20 Sorcerer, p. 74


Pyrokinesis


Parapsychological lore speaks of “Firestarters,” individuals able to psychically start and sometimes control flame. Some parapsychologists suspect Pyrokinesis is a variant of Psychokinesis, where the psychic causes molecules to vibrate at high speeds, generating combustion rather than moving entire objects cohesively.

Pyrokinesis is one of the more dangerous Psychic Phenomena to the psychics themselves; most psychics have no more defense against the flames they create than any other human. Botches can be spectacularly disastrous, and several pyrokinetics have gone out in a literal blaze of glory.

• Spark: The pyrokinetic can generate small sparks, usually from their fingertips. These sparks are typically only able to light highly flammable substances on fire, such as paper or gasoline, but with 3 or more successes, the psychic’s sparks can light materials on fire as a match could. The sparks can light anything within the pyrokinetic’s reach, though they don’t have to touch the target. Even with many successes, the sparks aren’t hot enough to directly light a person on fire, though the effect of a flame appearing can startle someone. After activation, treat the sparks as a thrown attack with a weapon dealing no damage. This can be dodged normally. If the attack succeeds, the target rolls Willpower at difficulty 6 to avoid being stunned for one turn. On a botch, the target panics. The target may instead spend one Willpower point to suppress a startle response.

•• Combustion: The psychic concentrates on an object within 10 yards, causing it to burst into flame. The psychic can reliably light flammable materials like gasoline, dry wood, charcoal, and vampires on fire. At 3 or more successes, the psychic can light anything combustible, such as people, on fire. The initial fire is as big as a torch and behaves and spreads normally. If the psychic targets a person or person’s clothing, the target may attempt to dodge as normal, treating activation successes as the targeting roll.

••• Sun’s Fury: The psychic can now turn small balls of air into plasma and flame, which readily lights nearly anything it touches on fire. This power causes bonfire-sized fires up to 10 yards away dealing two aggravated damage per turn from the intense heat. Targets may attempt to dodge as normal, treating activation successes as the targeting roll. If hit, the target must spend a Willpower point or roll Willpower at difficulty 6 to be able to avoid panic. If they remain calm, the target may immediately use their action to roll Dexterity + Athletics at difficulty 5, extinguishing themselves on a success.

•••• Pyrotechnics: The pyrokinetic gains control over flames, including those produced by lower levels of Pyrokinesis. The psychic can grow, shrink, direct, and shape flames within their line of sight at will. With one success, the psychic may control a torch-sized portion of flames. With three successes, the psychic wrestles control of a bonfire. At five or more successes, the psychic may command even an inferno. Targeting individuals with flame is a Wits + Athletics attack at difficulty 7, with +1 difficulty to avoid harming nearby bystanders in the process. This attack can be dodged. A psychic may extinguish a flame at will. A bonfire or smaller flame is extinguished instantly, but any larger flame takes an entire turn of concentration to extinguish.

••••• Inferno: The pyrokinetic now commands larger and faster-growing flames, which may appear anywhere in the psychic’s line of sight. The flames consume anything inside them with 3 aggravated damage per turn, though targets on the outer edges may dodge as Sun’s Fury. At one success, the starting flame is a small fire, but at three successes the flames fill a large room, to a maximum of Willpower times 3 square yards. If the psychic maintains concentration, the flames are resistant to being extinguished by mundane means, taking rounds equal to the successes gained on the activation roll to extinguish through smothering, water, or flame retardant chemicals. If the psychic breaks concentration, such as by sustaining damage or being knocked out, the flames lose all supernatural properties and may be extinguished normally.]==] },
				["Shadow"] = { en = [==[M20 Sorcerer, p. 74


Shadow


We live in a world of light and shadow. The psychic that understands this and learns to manipulate one side of that coin is taking advantage of an ever-present resource. Whether it is under an overhang, behind a stack of boxes, or simply within the cracks and crevices of one’s face, the psychic manipulating shadows can put them to use to conceal and confound.

Superstitious theories abound concerning what the psychic wielding Shadows is actually doing. The simple fact is they are manipulating light — and sound to a limited degree — to dampen the world around them. It may seem like the Shadow psychic is wielding darkness, but it all boils down to simple science. Darkness grows darker and sound becomes muffled as the psychic’s sheer will smothers active waveforms in the environment. The spooky atmosphere and reputation are just bonus.

As much as shadows can hide, proper utilization of this Phenomenon can provide significant distractions. Light and sound are intercepted before they can reach the target’s senses, giving the victim the feeling that their head is wrapped in an invisible blanket. As the psychic’s power rises, this is more and more harrowing as the brain can interpret this loss of sense as impending suffocation. While cruel by the reckoning of some, it can be an especially useful tool when getting someone off your back.

• Scattering the edges of cast shadows and disrupting sound is only sufficient to increase the effectiveness of concealment and demoralization. Shadows become slightly longer, reach somewhat further, while sounds are all unnervingly stifled. All Intimidation and Stealth rolls have their difficulty adjusted by −1. Targets distracted by darkening shadows and muffled sounds suffer a +1 difficulty to all rolls reliant on sight and hearing.

•• The shadows now grow and bend to the will of the psychic. Sounds now baffle and distort, having the quality of being played through a blown speaker. The psychic embodies the idiom of “to darken a doorstep,” as rooms lose light when they arrive. Intimidation and Stealth rolls are made at −2 difficulty.

••• Not only do shadows grow darker, but now the psychic’s efforts causes light sources to lose their power. Sound travels through a room in erratic warbles, and the words that are intelligible have a perceptible delay with the speaker. Attempts to see the concealed psychic suffer a +3 difficulty. The harrowed begin to feel a swelling anxiety and must make a Willpower roll (difficulty 7) to avoid panic, suffering a -1 penalty to all actions that don’t involve leaving the scene if they fail.

•••• Spreading their gift of dark refuge, the psychic can now cloak a small gathering of three or four people, possibly even a small coupe or sedan.

Victims of shadowy harassment must make a Willpower roll (difficulty 8) to avoid panicking and immediately leaving the scene to escape the darkness. Intimidation and Stealth have a −4 difficulty in conditions that are ripe for exploitation. An already dark warehouse, a shadowy forest in the night, or a poorly lit parking garage all beg to have their deep shadows emboldened by the psychic. This amount of shadow manipulation has an inverse effect in brighter setting, like midday in an open car park or standing on a school sports field with all the lights on. The darkness around the psychic draws more attention in the brightness of noon than it diverts.

••••• In settings where darkness already lives, the psychic is master. Standing in a location where conditions favor shadows gives the psychic the chance to smother all light around them out to 50 feet. The darkness is near impenetrable for those without mystic sight, as even high-powered handheld lights are swallowed by the inky black. All within are completely shrouded and invisible to the outside and others within, save the psychic. The darkness is their own after all.]==] },
				["Synergy"] = { en = [==[M20 Sorcerer, p. 75


Synergy


A subtle ability, synergistic psychics often don’t know they have any psychic talent until after meeting other psychics — it’s unusual but not unheard of for them to develop other Psychic Phenomena. This phenomenon is considered rare, but the power’s subtle nature may conceal the true number of synergists in the world. Synergy allows psychics to work together to build effects more powerful than either psychic could create on their own.

Psychics must be touching to form a synergistic link. The synergist may link a number of psychics equal to twice the dots they have in Synergy. Every success above one adds automatic successes that can be spent on actions the linked psychics take using Phenomena. Botches can cause backlashes for all involved, with the best-case scenario being a headache or nosebleed, where the worst case can cause the psychic phenomena of those in the link to activate uncontrollably.

• Like Knows Like: The synergist can sense other psychics. This automatically succeeds if the psychic touches another, but the synergist can roll activation to scan for psychics in line of sight. With 3 or more successes, the synergist can sense the relative power of the other psychics.

•• Share Will: The synergist forms a weak psychic link to enhance the power of the participants. Each psychic can either spend a point of Willpower for an automatic success on another’s effect or allow the psychic to “borrow” the Willpower and temporarily add the point to their pool, up to a maximum of 10. If the Willpower isn’t spent, it can be traded multiple times between the psychics in the link. Any sensory Phenomena (Telepathy, Precognition, etc.) allow all the psychics in the link to share the results.

••• Share Powers: The synergist forms a stronger link, allowing all psychics to use their powers as a group. Each psychic may donate up to two powers, points of Willpower, or one of each. Only one activation roll is necessary for group powers.

•••• Power Gestalt: As Share Powers, but now psychics in the link may combine ability effects to form one shared power. For example, the group could combine Animal Psychics and Psychic Invisibility to be able to sneak past guard dogs unnoticed.

••••• Power Network: The synergist may link other psychics and remove the need for the psychics to touch, or even be in the same place. A psychic with this level of Synergy first links everyone as with lower abilities, spending 10 minutes on combined focus and meditation to cement the ties. Once the link forms, the networked psychics remain linked and able to use any of the lower abilities for a number of hours equal to activation successes. This link does not fade with distance, but if a psychic in the link takes their Stamina or more in damage from a single source, all psychics in the network must make a Willpower roll at difficulty 7 or be ejected from the network. If the psychic who formed the network is ejected, knocked unconscious, or killed, the network automatically collapses.]==] },
				["Telepathy"] = { en = [==[M20 Sorcerer, p. 76


Telepathy


It is said that there are two kinds of people in the world: people who wish they could read minds and liars. That statement, in and of itself, is a lie. That is because there are people in the world that can actually read minds and they’re known as telepaths. Once they sense the mind of a target, these psychics can plumb their thoughts for opinions, desires, fantasies, and emotions.

As skill and power improve, the telepath can learn to broadcast their thoughts into others. Communication in this manner can be unsettling at best to the unprepared and potentially outright scarring. Compassionate telepaths take time to inform those they intend to telepathically communicate with of what is coming, to avoid possible screaming and incoherent confusion caused by unannounced mental invasion.

Those who have mastered their talent go one step further and make those broadcasts seem like original thoughts, implanting ideas into the minds of their targets. This is not any kind of mental control or hypnosis as one might think. At its core, this ability is more akin to ventriloquism — a form of ventriloquism essentially akin to psychic gaslighting, and a very dangerous and immoral act, but ventriloquism nonetheless. The telepath mimics the inner dialogue of the target and makes suggestions as though the thought came from the subject’s own mind. The uses of this talent range from the relatively benign thought of “I could use a snack” to projections far more sinister. Reading the target’s thoughts, then mimicking and repeating their darkest impulses to exigence, is but one troubling example of the potential for telepathic abuse.

• All telepaths begin by sensing the surface thoughts and emotions of a subject. Emotions include current mood, immediate desire, and mental wellbeing. Surface thoughts are songs stuck in their head, active recollection of things like a grocery list or a keycode as it’s punched in, or what they think that smell was that they just sniffed.

•• Inner thoughts open to the telepath. With every success on the activation roll, the telepath may ask a single question about the target’s subsurface ruminations. These responses are one sentence in length and as straightforward as possible. Inner thoughts include political leanings, favorite books or movies, or recent memories.

The beginnings of telepathic communication open at this level as well. For every success on the activation roll, the telepath can send or receive one sentence of mental communication. These communications happen at the speed of thought, and as such do not take up any time within a round or require any dice pool splitting for multiple actions.

••• Deeper thoughts are laid bare to the telepath. As with previous levels, every success on the activation roll allows for a single question that is answered by the target These responses can be more detailed when the subject of the question is not a closely guarded secret. Deeper thoughts include memories from the last 5 years, passwords to social media accounts and bank cards, and the names of everyone from their immediate to extended family.

Telepathic communication comes much easier at this stage. For every success on the activation roll, the telepath can send and receive several sentences (two or three) worth of communication. Again, these communications happen at the speed of thought and follow the same rules as above.

•••• Subconscious thoughts and the deepest recesses of the mind are within reach of the telepath. Every success on the activation roll allows for a single question that is answered by the Storyteller. Nothing within the mind is off limits at this point. Memories back to their childhood, forgotten codes to facilities they used to work at, and even thoughts they have that they deny to themselves about their loved ones are all fair game.

Conversations over telepathic connections are no longer held to sentences. Full conversations between two people happen in the blink of an eye. The more impressive improvement is that telepathic links can be widened to a net. Each success on the activation roll allows another mind to be added to the conversation. When multiple minds are added to the psychic’s link, the excess telepathic bandwidth slows down as the psychic’s mind is acting as a routing hub. Conversations like this happen in real time, as though everyone involved were speaking to each other around a table.

••••• Insidious as it may be, the telepath can now implant subversive thoughts into the minds of their targets. These thoughts can be of anything, but any train of thought that wasn’t already present in the mind of the target requires a Manipulation + Subterfuge roll (difficulty 7) to implant thoughts that complement the target’s personality and desires. Implanted thoughts that run contrary to the target’s personality and desires suffer a +2 difficulty to the roll. Should these thoughts take root, the target will begin to act on them at the nearest opportune time, convinced the thoughts are their own.]==] },
				-- True Faith is not one of the 43 above: it is the single Path of its own Numina
				-- and it has its own two-entry picker (SPEC T81/T82, R.16). Same shape as the
				-- rest so the renderer and the gate treat it identically.
				["True Faith"] = { en = [==[The Hunters Hunted II, p. 83


True Faith


Systems for True Faith

Unlike the other Numina Paths, True Faith only has a single Path.

True Faith grants the believers special benefits:

• Each level of True Faith grants an extra point of Willpower.

• Each point of True Faith acts as a die of divine protection to resist the effects of Numina, vampire Disciplines, or other supernatural powers. When a character would be affected by a Kindred Discipline or other power, her player may spend a point of Willpower and roll the character’s True Faith rating as a dice pool against a difficulty of 7. Successes earned on this roll subtract successes from the activation roll of the power in question. This protection affects only powers that would directly affect the character, and only if a dice roll is required to determine their degree of success. It offers no protection against passive or indirect uses of powers such as Aura Perception or Fortitude.

The True Faith Numina, like any other, has a rating of 1 to 5. Exactly what protection is afforded to the individual depends on this rating, as described below. At their discretion, Storytellers may wish to amend or alter these benefits to reflect the intervention of higher powers as it illustrates the themes of their own chronicles.

True Faith Levels

• Any character with True Faith may attempt to repel vampires, ghosts, and other supernatural creatures by brandishing a holy symbol or uttering prayers. The player of the Faithful spends a Willpower point and rolls her character’s True Faith rating against a difficulty equal to the creature’s permanent Willpower.

The successes garnered indicate the number of turns that the creature must flee from the character while she invokes the protection of prayer or the holy symbol. If the activation roll yields no successes, a supernatural creature need not step back, but may not advance. A botch indicates that it may advance unhindered. If the religious symbol is placed against a vampire’s body, each success causes a level of aggravated damage, burning into the creature’s flesh.

•• The Faithful may sense the presence of a vampire. She need not consciously try to detect the vampire’s presence, but she must be in peaceful, quiet surroundings, perhaps alone in thought, praying, reading a religious book, meditating, etc. The Faithful will not sense the vampire if she is preoccupied (e.g., arguing) or in a crowded, noisy place (jostled by a mob, in the midst of a party, etc.). This ability doesn’t light up the vampire like a beacon; the Storyteller reveals the presence of the vampire only when the Faithful’s attention would indicate such. Note that the character doesn’t know exactly what she senses through her faith. All she knows is that something sinister is nearby.

••• The Faithful is immune to Chimerstry, Dementation, Dominate, Obfuscate, and other supernatural effects that confound the mind.

•••• The Faithful may not be turned into a ghoul. She is unaffected by Presence and other supernatural effects that manipulate emotions.

••••• The mere presence of the Faithful may fill a vampire or other supernatural creature with self-loathing, disgust, terror, or even physical pain. The player of any vampire who hears the Faithful pray or preach, or who is touched by the Faithful, must make a successful Rötschreck roll (difficulty 9) to resist having the Kindred flee immediately and for the duration of the scene. A vampire who is unable to flee is reduced to a gibbering wreck, flailing on the floor, screaming, sobbing, or begging for mercy.

Miracles of True Faith

A miracle is an instance of direct divine intervention. The Faithful often pray to the divine as a form of worship and meditation. On rare and inspiring occasions, the divine answers a prayer in the form of a miracle. Such miracles should be rare, never more than one in a story, and always dramatic.

The Storyteller should examine the motivation of the character invoking the miracle. The divine likely doesn’t care if the Faithful wants to drive a luxury car, win the lottery, or even survive an encounter with a random vampire. Every religion has martyrs, and death is sometimes in the divine plan. Prayers that are selfless and seek to help or inspire others have the best chance of being answered. No hard-and-fast system for invoking miracles exists — it’s simply a dramatic reminder that Faithful individuals bear a divine duty and can occasionally serve as conduits for their greater power’s will in the world.

Miracles are impossible to define mechanically, as they should be specifically tailored to the situation. Some examples include:

• Helping a barren woman be able to bear a child

• Curing a terrible and painful disease, such as cancer

• Helping someone trapped under a collapsed building

• Finding yourself at the side of a friend in desperate need]==] },
				-- <<< DESC_END
};
