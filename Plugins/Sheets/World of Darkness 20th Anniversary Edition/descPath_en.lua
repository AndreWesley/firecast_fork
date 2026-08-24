-- Path descriptions, the [en] half (SPEC T495, V210).
--
-- descPath.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [en] only, descPath_pt.lua holds the other, the two carry the SAME
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
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 163


Ash Path


The Ash Path allows necromancers to peer into the lands of the dead, and even affect things there. Of the paths of Necromancy, the Ash Path is the most perilous to learn, because many of the path’s uses increase a necromancer’s vulnerability to wraiths.

• Shroudsight
Shroudsight allows a necromancer to see through the Shroud, the mystical barrier that separates the living world from the Underworld. By using this power, the vampire can spot ghostly buildings and items, the landscape of the so-called Shadowlands, and even wraiths themselves. However, an observant wraith may notice when a vampire suddenly starts staring at him, which can lead to unpleasant consequences.
System: A simple roll of Perception + Awareness (difficulty 7) allows a necromancer to utilize Shroudsight. The effects last for a scene.

•• Lifeless Tongues
Where Shroudsight allows a necromancer to see ghosts, Lifeless Tongues allows her to converse with them effortlessly. Once Lifeless Tongues is employed, the vampire can carry on a conversation with the denizens of the ghostly Underworld without spending blood or causing the wraiths to expend any effort.
System: To use Lifeless Tongues requires a roll of Perception + Occult (difficulty 6) and the expenditure of a Willpower point.

••• Dead Hand
Similar to the Sepulchre Path power Torment, Dead Hand allows a necromancer to reach across the Shroud and affect a ghostly object as if it were in the real world. Ghosts are solid to necromancers using this power, and can be attacked. Furthermore, the necromancer can pick up ghostly items, scale ghostly architecture (giving real-world bystanders the impression that he’s climbing on air!), and generally exist in two worlds. On the other hand, a necromancer using Dead Hand is quite solid to the residents of the Underworld — and to whatever hostilities they might have.
System: The player spends a point of Willpower and makes a successful Wits + Occult roll (difficulty 7) to activate Dead Hand for one scene. For each additional scene the vampire wishes to remain in contact with the Underworld, he must spend a point of blood.

•••• Ex Nihilo
Ex Nihilo allows a necromancer to enter the Underworld physically. While in the lands of the dead, the vampire is essentially a particularly solid ghost. He maintains his normal number of health levels, but can be hurt only by things that inflict aggravated damage on ghosts (weapons forged from souls, certain ghostly powers, etc.). A vampire physically in the Underworld can pass through solid objects in the real world (at the cost of one health level) and remain "incorporeal" for a number of turns equal to her Stamina rating. On the other hand, vampires present in the Underworld are subject to all of the Underworld’s perils, including ultimate destruction. A vampire killed in the realm of the dead is gone forever, beyond even the reach of other necromancers.
System: Using Ex Nihilo takes a tremendous toll on the necromancer. To activate this power, the vampire must first draw a doorway with chalk or blood on any available surface. (The vampire may draw doors ahead of time for exactly this purpose.) The player must then expend two points of Willpower and two points of blood before making a Stamina + Occult roll (difficulty 8) as the vampire attempts to open the chalk door physically. If the roll succeeds, the door opens and the vampire steps through into the Underworld.
When the vampire wishes to return to the real world, he merely needs to concentrate (and the player spends another Willpower point and rolls Stamina + Occult, difficulty 6). At Storyteller discretion, a vampire who is too deeply immersed in the Underworld may need to journey to a place close to the lands of the living in order to cross over. Vampires who wander too far into the lands of the dead may be trapped there forever.
Vampires in the Underworld cannot feed upon ghosts without the use of another power; their only sustenance is the blood they bring with them.

••••• Shroud Mastery
Shroud Mastery offers the Kindred the ability to manipulate the veil between the worlds of the living and the dead. By doing so, a necromancer can make it easier for bound wraiths in his service to function, or make it nearly impossible for ghosts to contact the material world.
System: To exercise Shroud Mastery, the necromancer expends two points of Willpower, then states whether he is attempting to raise or lower the Shroud. The player then makes a Willpower roll (difficulty 9). Each success on the roll raises or lowers the difficulties of all nearby wraiths’ attempts to cross the Shroud in any way by one, to a maximum of 10 or a minimum of 3. The Shroud reverts to its normal strength at a rate of one point per hour thereafter.]==],
				},
				["Awakening of the Steel"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 440


Awakening of the Steel


Although combat mastery is hardly the sorcerer caste’s primary goal, they have a long tradition of standing ready to defend themselves and, if need be, assisting the warrior caste on the battlefield. Awakening of the Steel is one legacy of this preparedness, a path that some say began with the alchemists who studied in the forges of Toledo and Damascus. This set of techniques focuses on the symbolism of the sword as the ultimate extension of a trained warrior’s body, drawing on the myths that various warrior traditions attached to their swords and daggers: European Crusaders and their blessed blades, the kris of Indonesian Pentjak-Silat practitioners, and Indian Ghurkas and their kukri knives, among others. The practitioner of Awakening of the Steel focuses on this symbolism as he uses the power of his blood to enhance his weapon and his skill.
A student of Awakening of the Steel finds that a keen understanding of both the form and the function of a blade is necessary for full mastery of this path. A character must have a level of either Melee or Crafts Ability equal to his level in Awakening of the Steel. Those who practice this path also find that its lessons are tightly focused, perhaps to the point of overspecialization. The path is at its most effective with swords and knives, and the wielder can only extend its effects to other edged weapons. Any attempt to use a technique of this path on another edged weapon is at +1 difficulty.

• Confer with the Blade
Although few Assamites claim to have actually spoken to a weapon’s soul, blacksmiths and warriors alike have ascribed spiritual qualities to hand-forged blades for centuries. Practitioners of Auspex are familiar with the manner in which inanimate objects can bear impressions of their own history. Confer with the Blade allows a weapon’s wielder to delve into the events that have occurred around his weapon. Some practitioners of this power claim this makes the weapon feel more “comfortable” in their hands, while others speak of the sense of history that an ancient blade bears. The actual impressions only take an instant to gain, though many prefer to spend much longer in contemplation if time permits.
System: The number of successes determines the amount of information the sorcerer gains regarding the blade’s history and its present state, as well as all information yielded by a lesser number of successes. With three or more successes, the sorcerer may lower the difficulty on his next attempt to apply a blood-magic ritual to the weapon by one.
1 success — Physical information only: precise length and weight (to the micrometer and milligram), chemical composition (assuming the character understands metallurgy), number of damage dice and type of damage (lethal or aggravated).
2 successes — Historical overview: when and where the blade was forged, the name and face of its smith, brief glimpses of significant events in its existence.
3 successes — Sorcerous understanding: the type and relative level of power of any enchantments or supernatural enhancements that the blade possesses as well as the name and face of the individual who laid them.
4 successes — Subliminal synthesis: comprehensive knowledge of the sword’s history. For the next seven nights, the character recognizes the taste of any blood that has ever stained the blade if she tastes it herself.
5 successes — Total communion: The sword and the wielder become linked at a level deeper than the physical and more enduring than the immediate. The Storyteller determines what information the sword holds for the character, but it may include any event in the blade’s history or any aspect of its present existence and condition.

•• Grasp of the Mountain
The best scimitar in all creation does its owner no good if it’s lying five yards away from him. Grasp of the Mountain strengthens the spiritual bond between the sword and the swordsman in order to reinforce the wielder’s physical grip on his weapon. A blade that is under the effect of this art never leaves its master’s hand unless he so wills it.
System: For the rest of the scene, the character has a number of automatic successes to resist all attempts to disarm him, equal to the number of successes rolled. He cannot accidentally drop the blade (which means his botches are likely to result in self-mutilation instead of an empty hand). If the character is somehow disarmed in spite of Grasp of the Mountain, he may call the blade back to his hand by successfully invoking this power again, assuming he has a clear line of sight to the weapon.

••• Pierce Steel’s Skin
At this level of understanding, the sorcerer can command his blade with such precision that he can strike at an opponent’s physical protection rather than his body. The sword transfers its full fury to the intended target, shredding even the toughest chain or plate. This strips away the victim’s defenses, leaving him vulnerable to the next attack. While this power is of limited utility in modern nights, as traditional armor has fallen by the wayside, it remains in the path’s progression of lessons due to its utility in destroying other obstacles.
System: While Pierce Steel’s Skin is in effect, an attack against an unarmored target inflicts half damage (rounded down). However, for a number of turns equal to the number of successes rolled, each successful attack the character makes against an armored foe inflicts damage on the target’s body armor rather than injuring him directly. Only metal armor can be damaged by this power. When the character makes a successful attack against an armored target, the player does not roll damage. Instead, he rolls a number of dice equal to the sword’s damage bonus (the number of dice that it adds to his Strength) against a difficulty of 7. Each success reduces the armor’s soak bonus by one die. Armor that is reduced to zero soak dice in this manner is completely destroyed and unsalvageable. Additional successes beyond those needed to destroy a piece of armor have no effect.
At the Storyteller’s discretion, Pierce Steel’s Skin may destroy other inanimate objects (walls, doors, cars, dramatically appropriate obstacles) without significant damage to the sword. For the purposes of this power, Fortitude counts as part of the target’s Stamina, not external armor.

•••• Razor’s Shield
Many swordsmen hold that the duel is the ultimate test of the warrior because it places all opponents on an equal footing: Death is only three feet of steel away, and only the skill of the combatants determines who walks away. However, observers who are more pragmatic than romantic note that an enemy with a ranged weapon (be it bow, sling, or gun) has the advantage of striking from much farther away than arm’s length. While Awakening of the Steel cannot completely counteract this advantage, this power allows the skilled sorcerer some measure of defense as the sword interposes itself between its master and attacks from afar.
System: For a number of turns equal to the number of successes rolled, the character may attempt to parry projectiles. This requires one action for each projectile that the player wishes to block, and the character must be able to see the shot coming (Heightened Senses allows visual tracking of bullets). Each parrying attempt requires a Dexterity + Melee roll, with a difficulty determined by the speed of the projectile. Thrown objects have a difficulty of 6, arrows and crossbow bolts a difficulty of 7, and bullets a difficulty of 9. Each success subtracts one success from the attacker’s attack roll.
Razor’s Shield does not allow the character to parry ranged attacks that do not incorporate solid projectiles, such as flame, lightning, or spat blood.

••••• Strike at the True Flesh
Although pacifists may find other uses for blades, a warrior knows that swords were created for one purpose: to carve an enemy’s flesh into bloody ruin. Strike at the True Flesh invokes the very essence of the sorcerer’s weapon, reducing it to the embodiment of its very definition (or, as the more classically minded would put it, invoking the Platonic form) while simplifying its target to a similarly basic level. The results of such an invocation are usually devastating on both a philosophical and practical level as weapon and victim momentarily lose all supernatural attributes.
System: The effects of Strike at the True Flesh last for a number of turns equal to the number of successes rolled, and they end with the first successful attack that the character makes within this time period. The sword inflicts only the base amount of lethal damage that a weapon of its size and type would normally cause, disregarding all enhancements that it may have received (though augmentations to the wielder’s strength or speed, such as Potence and Celerity, still have their normal effects, as do extra successes on the attack roll).
However, all the target’s supernatural defenses (including Fortitude) are likewise negated — he soaks the attack only with his base Stamina. If the negation of his powers and defenses renders the target unable to soak lethal damage, he cannot soak the attack at all. Body armor does protect against this attack, as it is a mundane form of defense.]==],
				},
				["Bone Path"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 164


Bone Path


The Bone Path is concerned primarily with corpses and the methods by which dead souls can be restored to the living world — temporarily or otherwise.

• Tremens
Tremens allows a necromancer to make the flesh of a corpse shift once. An arm might suddenly flop forward, a cadaver might sit up, or dead eyes might abruptly open. This sort of thing tends to have an impressive impact on people who aren’t expecting a departed relative to roll over in his coffin.
System: To use Tremens, the necromancer spends a single blood point, and the player must succeed on a Dexterity + Occult roll (difficulty 6). The more successes that are achieved, the more complicated an action can be effected in the corpse. One success allows for an instantaneous movement, such as a twitch, while five allow the vampire to set up specific conditions under which the body animates (“The next time someone enters the room, I want the corpse to sit up and open its eyes.”). Under no circumstances can Tremens cause a dead body to attack or cause damage.

•• Apprentice’s Brooms
With Apprentice’s Brooms, the necromancer can make a dead body rise and perform a simple function. For example, the corpse could be set to carrying heavy objects, digging, or just shambling from place to place. The cadavers thus animated do not attack or defend themselves if interfered with, but instead attempt to carry out their given instructions until such time as they’ve been rendered inanimate. Generally it takes dismemberment, flame, or something similar to destroy a corpse animated in this way.
System: A roll of Wits + Occult (difficulty 7) and the expenditure of a point of both blood and Willpower are all that is necessary to animate corpses with Apprentice’s Brooms. The number of corpses animated is equal to the number of successes achieved. The necromancer must then state the task to which he is setting his zombies. The cadavers turn themselves to their work until they finish the job (at which point they collapse) or something (including time) destroys them.
Corpses animated in this way have no initiative of their own, and are unable to make value judgments. They respond to very literal instruction. Thus, a zombie could be told “sweep this room every day until all the dust and cobwebs are gone” or “transcribe this manuscript” with an expectation of reasonable results, while a more open-ended command such as “fix this motorcycle” or “research this Necromantic ritual and write down the results” would be doomed to failure.
Bodies energized by this power continue to decay, albeit at a much slower rate than normal.

••• Shambling Hordes
Shambling Hordes creates obvious results: reanimated corpses with the ability to attack, albeit neither very well nor very quickly. Once primed by this power, the corpses wait — for years, if necessary — to fulfill the command given them. The orders might be to protect a certain site or simply to attack immediately, but they will be carried out until every last one of the decomposing monsters is destroyed.
System: The player spends a point of Willpower. The player then must succeed on a Wits + Occult roll (difficulty 8). Each success allows the vampire to raise another corpse from the grave, and costs one blood point. If the player cannot or chooses not to pay the blood point cost of additional zombies past a certain number, the extra successes are simply lost. Each zombie can follow one simple instruction, such as “Stay here and guard this graveyard against any intruders,” or “Kill them!”
Note: Zombies created by Shambling Hordes will wait forever if need be to fulfill their functions. Long after the flesh has rotted off their mystically animated bones, the zombies will wait and wait and wait, still able to perform their duties.

•••• Soul Stealing
This power affects the living, not the dead. It does, however, temporarily turn a living soul into a sort of wraith, as it allows a necromancer to strip a soul from a living body. A mortal exiled from his body by this power becomes a wraith with a single tie to the real world: his now-empty body.
System: The player spends a point of Willpower and then makes a contested Willpower roll against the intended victim (difficulty 6). Successes indicate the number of hours during which the original soul is forced out of its housing. The body itself remains autonomically alive but catatonic.
This power can be used to create suitable hosts for Daemonic Possession. It has no effect on Kindred or other supernatural creatures (except ghouls) until such creatures are dead — in the case of vampires, this means Final Death.

••••• Daemonic Possession
Daemonic Possession lets a vampire insert a soul into a freshly dead body. This does not turn the reanimated corpse into anything other than a reanimated corpse, one that will irrevocably decay after a week, but it does give either a wraith or a free-floating soul (say, that of a vampire using Psychic Projection) a temporary home in the physical world.
System: The body in question must be no more than 30 minutes dead, and the new tenant must agree to inhabit it — a ghost or astral form cannot be forced into a new shell. However, most ghosts would gladly seize the opportunity. Should the vampire, for whatever reason, wish to insert a soul into another vampire’s corpse (before it crumbles to ash), the necromancer must achieve five successes on a resisted Willpower roll against the original owner of the body. Otherwise, the interloper is denied entrance.
Note: The soul can use whatever physical abilities (Athletics, Brawl, Potence) his new fleshy home possesses, and whatever mental abilities (Computer, Law, Presence) he already possessed. He cannot use the physical abilities of his old form, or the mental abilities of his new one.]==],
				},
				["Cenotaph Path"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 166


Cenotaph Path


Practitioners of the Cenotaph Path are primarily concerned with discovering or forging links between the living world and the Shadowlands. It functions on the principle that a Kindred, already a corpse, is an unnatural bridge between the living and the dead, and the necromancer can use this to find other, similar linkages. The basic rudiments of the Cenotaph Path function easily enough once the Kindred learns to attune himself to these connections. Advanced mastery of the path usually entails some brief ritual to forge artificial connections, either through focusing unsavory passions or commanding this world and the Shadowlands together.

• A Touch of Death
Just as a necromancer may exert mastery over the Shadowlands, so too can some ghosts exert themselves in the mortal world. Whereas obvious displays of ghostly power such as bleeding walls or disembodied moans certainly won’t be mistaken, some ghostly abilities exert subtle effects that aren’t easily recognized. A necromancer sensitized to the residue of the dead, though, can feel whether an object has been touched by a ghost or sense the recent passage of a wraith.
System: The necromancer simply touches a person or object that he suspects is a victim of ghostly influence. The player rolls Perception + Awareness (difficulty 6). If successful, the necromancer can determine whether a ghost has exerted any sort of power on the subject, or even crossed nearby, to the duration detailed below.
1 success — Last turn; detect use of ghostly powers.
2 successes — Last three turns; detect use of ghostly powers.
3 successes — Last hour; detect ghost’s touch and use of ghostly powers.
4 successes — Last day; detect ghost’s touch and use of ghostly powers.
5 successes — Last week; detect nearby passage of ghost, ghost’s touch, and use of ghostly powers.
On a failure, the necromancer receives no impressions. A botch reveals a misleading answer (an object may seem tinged with ghostly power when it’s not, or vice versa). Should the necromancer succeed in detection while touching an object or person that a ghost is possessing, he immediately becomes aware that the ghost is still inside. The impression gained in such a case is sufficient to count as an image of the spirit for purposes of the Sepulchre Path’s powers, so the Kindred may be able to (for example) immediately command a ghost to exit a person whom it possesses.

•• Reveal the Catene
Necromantic compulsions function much more effectively when the caster uses an object of significance to the ghost in question. Such fetters tie the dead to the living lands through their remembered importance — a favored recliner for relaxing, a reviled piece of art foisted off by hated relatives, or some object of similarly intense emotion. Many necromancers can detect such catene through the use of rituals (see Ritual of the Unearthed Fetter, p. 181). With this power, though, the necromancer can determine a fetter with just a few moments of handling. The Kindred simply runs his hands over the object and concentrates on it. He quickly receives an impression of the item’s (or person’s) importance to wraiths, if any; should the wraith be one known to the necromancer, he immediately recognizes the object as a fetter to that (or those) ghost(s). Successful identification of a connected ghost is not exclusive; that is, if the vampire determines that the object is important to a given wraith, he can also determine if there are other ghosts tied to the item, though he must use the power again to gain their identities.
Many necromancers use this power on objects already identified with A Touch of Death, in order to determine whether the ghost is trying to attune a given fetter or simply toying with the world of the living.
System: The necromancer holds and examines the object for at least three turns — if it’s an item, this means turning it over in his hands, running his fingers along it, or otherwise giving it a critical eye; with a person, this may require a more… invasive… examination. The player then spends a blood point and rolls Perception + Occult (difficulty 7). If successful, the Kindred determines whether the object holds any significance to any ghost and, with three or more successes, the identity of at least one such ghost (which allows the Kindred to use the Sepulchre Path on that wraith, if desired). If the necromancer already knows any of the ghosts involved, their ties are revealed with their identity — so, if the necromancer already knows a wraith well enough to summon and compel it with other powers, successful identification of a fetter tells whether the object is tied to that ghost, in addition to any other impressions gained.
If a botch is scored, the necromancer can never successfully use this power on the item being examined.

••• Tread Upon the Grave
The extended awareness granted with the Cenotaph Path allows the necromancer to find locations where the Shadowlands and the living world come close. Often, the necromancer experiences a chill or shiver when stepping into an area where the Underworld lies near the living one. With practice, the vampire can tell exactly where such locations are.
Experienced necromancers learn that certain locations are susceptible to ghostly influence; these haunted areas often become homes of a sort for ghosts. A knowledgeable vampire can thus discover places where the dead are likely to congregate, the better to snare them with other Necromancy powers.
System: The player simply declares intent to sense the Shroud in an area and makes a Willpower roll (difficulty 8). Success reveals whether the location is highly attuned to the Shadowlands, about average (not particularly close to the world of the dead), or far removed from the realm of death. A failing attempt at using the power has no adverse effect, though it may be attempted only once per scene (so the necromancer must either wait for a time or move to a different area before attempting Tread Upon the Grave once more).
A botch stuns the necromancer into inaction for a full turn and costs him a temporary Willpower point, as he is overcome by shivers and a sense of overwhelming despair.
With three or more successes, the necromancer can determine whether the Shroud’s strength has been artificially altered in the area.

•••• Death Knell
Not all who die go on to become ghosts — many lack the drive to hang on after death or simply have no overwhelming needs that compel them to stick around. Normally, even necromancers have no way to sort those who might become ghosts from the masses who go on to whatever rewards await. Over time, though, a necromancer can become sensitized to the pull that occurs when a soul escapes from a body only to hover in wait, enslaved by its desires. The weight of desperation becomes like a tangible tug, and some necromancers savor this emotion even as they follow the sensation to find the new ghost.
Of course, actually discovering the new ghost can be problematic. The Kindred may need some means to see through the Shroud or may have to send other wraiths to look for the new unfortunate, especially if a large accident or massacre leaves too many corpses for the necromancer to easily discern and test names.
System: Whenever someone dies and becomes a ghost within a half-mile or kilometer of the necromancer, she automatically senses the demise (though many choose to ignore this “always-on” power unless actively seeking someone). This power does not automatically pinpoint the location of the new ghost or identify it, but the player may spend one Willpower point and roll Perception + Occult (difficulty 7) for the necromancer to gain a vague sense of the distance and direction to the new wraith. With one success, the Kindred may sense a vague pull in a general direction; with three successes, the necromancer can sense the direction and guess distance to within a quarter-mile or half a kilometer. With five successes, the necromancer immediately senses the location of the new ghost to within one foot or 30 cm. A failure carries no penalty but a botched attempt sends the necromancer scurrying off in the wrong direction.
The Storyteller may rule that disturbances in the Underworld, intervening magic, or other similar phenomena cloud this sensation, simply to prevent overburdening a chronicle with constant ghost-hunting and dice rolling.

••••• Ephemeral Binding
The most puissant necromancers learn not only to sense the ties between living and dead, but to forge such ties themselves. The master of Ephemeral Binding turns an otherwise mundane object or person into a depository for his own necromantic energy. The undying Curse transforms the subject into a sort of linkage between the living and dead. The necromancer smears his blood on the item in question, which mystically absorbs the vitae and, in doing so, becomes a vessel to anchor a spirit.
System: The necromancer must coat an object with his blood (a full blood point’s worth); if the subject is a person, then that individual must ingest the vitae. The player marks off the blood point, spends a point of Willpower, and rolls Manipulation + Occult (difficulty 8). If successful, the item temporarily becomes a fetter to one wraith. If the Kindred already knows the name of the wraith or has a strong psychic impression, then the object can become a fetter at any range, even to a ghost who normally does not come near the living world (so long as the ghost still exists). Otherwise, the necromancer must be able to see or sense the ghost (with Witness of Death, Shroudsight, or other such means).
A fetter artificially created in this fashion functions for all necromantic and ghostly purposes as a normal fetter: It can be detected with other Necromancy powers, the vampire gains a bonus to Necromancy against the wraith attuned to it, and the ghost similarly finds exertion of its powers easier upon the subject (so the vampire might turn an unwitting ghoul into a consort for a wraith familiar with possession…). The ghost can sink into the fetter to heal; conversely, if the fetter is destroyed, the wraith is banished to some inaccessible region of the Underworld, perhaps never to return.
A fetter created with Ephemeral Binding lasts for one night per success scored. The expenditure of an additional point of Willpower increases this duration to a week per success, whereas spending a permanent dot of Willpower extends the duration to a year and a day.
Botching with this power not only causes failure but also makes the ghost immediately aware of what the necromancer was trying to do. Most ghosts do not take kindly to meddling Kindred trying to make artificial chains for them.]==],
				},
				["Corpse in the Monster"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 168


Corpse in the Monster


This path enhances the necromantic understanding of the unliving form and allows the user to fully experience the corpse as a gateway between life and death. The path lets the vampire apply some of a corpse’s traits to a vampire, and she can enhance or reduce these traits at various levels of the power.

• Masque of Death
The character with this ability can assume a visage of death or inflict that shape on another vampire. The victim’s flesh becomes pallid and thin (if it is not already), and skin pulls tight against bone. This ability can be very useful, as it allows one to hide in plain sight in a tomb or crypt at any time (though the character remains as vulnerable to sunlight and fire as ever). When a necromancer uses this power on another Kindred, the victim gains the same corpselike demeanor. In this sense, the ability works as something of a minor curse.
System: The player spends one blood point for the character to gain the form described. Those afflicted with the Masque of Death lose two points of Dexterity and Appearance (minimum of 1 in Dexterity and 0 in Appearance) for the duration of the power. The player also gets two extra dice to his Intimidation dice pool, should he wish to terrify any onlookers. Further, if the character remains perfectly still, observers must roll five successes on a Perception + Medicine roll (difficulty 7) to distinguish the character from a normal corpse. The player doesn’t need to roll anything to have the character stop moving — vampires have no autonomic functions.
If the user inflicts Masque of Death on another vampire, he must spend a blood point, touch the target, and then make a Stamina + Medicine roll (difficulty equal to the target’s Stamina + 3). The Masque of Death lasts until the next sunset, unless the character who created the masque wishes to extinguish its effects earlier.

•• Cold of the Grave
The dead feel no pain, though most undead do. With this ability, the character can temporarily take on the unfeeling semblance of the dead, in order to protect herself from physical and emotional harm. When assuming the Cold of the Grave, the vampire’s skin becomes unusually cold. When she speaks, her breath mists even in warm air — those with exceptional senses might even see a slight red tinge to the breath.
The power brings a sense of lethargy over the character, as a mortal might feel under the influence of a mildly unpleasant disease. It becomes difficult to rouse oneself to action, and very little seems important enough to really worry about. A corpse has no worries, after all.
System: The player spends one Willpower point. For the remainder of the scene, the character takes no wound penalties, and the player gains an additional die to all dice pools that involve resisting emotional manipulation, such as Intimidation or Empathy. However, the player also loses a die from dice pools to emotionally manipulate others. The character is a cold fish to those she interacts with, and they do not respond readily to her. The Cold of the Grave does not protect the character against the depredations of the Beast. She may be emotionally cold on the surface, but if others taunt and anger her sufficiently, she is still subject to frenzy as normal.

••• Curse of Life
The Curse of Life inflicts some of the undesirable traits of the living upon the undead, removing their corpselike nature and creating a false life to remind them of the worst things about being alive. Targets of this power regain only the unpleasant aspects of life, as culled from the memory of the Discipline’s user. This may include mundane hunger and thirst, sweat and other excretions, the need to urinate and defecate, a decrease in sensory acuity, and a particular vulnerability to attacks that the character might normally shrug off.
System: The player spends one Willpower and rolls Intelligence + Medicine (difficulty 8) to affect a target within line of sight and no farther than 20 yards or meters from the character. If the roll succeeds, the target suffers the weaknesses of the living without gaining any benefit from that state. He does not become immune to sunlight or holy artifacts, for instance. However, he does become badly distracted by mundane needs, with the net result that his player suffers a +2 difficulty penalty to all rolls. He can ignore these distractions at the cost of one Willpower point per scene. Additionally, the victim cannot use blood to raise his Physical Attributes while this power is in effect, and Willpower cannot eliminate this penalty. The power remains in effect until the next sunset.

•••• Gift of the Corpse
This power, one of the most potent on the Corpse in the Monster path, enables a necromancer to ignore most of her race’s inherent weaknesses for a short time. A dead body is not particularly vulnerable to sunlight, holy artifacts, frenzy, or being staked through the heart, after all, and so it is with a vampire using the Gift of the Corpse. As with the Cold of the Grave, above, the character using this power takes on an even more deathlike mien. It lasts for less than a minute, typically, but that time may be enough to enable a character to charge through a burning building without fearing frenzy or instant death.
System: The player spends one Willpower and rolls Stamina + Occult (difficulty 8). For every success, the character can spend one turn in a state in which he is more akin to an animated corpse than a vampire. Holy artifacts and sanctified ground have no effect, and the character is immune to frenzy and Rötschreck. Sunlight does only bashing damage, and then only if bare skin is exposed on a clear day. Being staked through the heart is only as much of a danger as getting stabbed through his dead spleen would be. Fire harms him only as it would a mortal — causing lethal damage instead of aggravated.
Should the character end the power’s duration while exposed to any of the aforementioned harmful things, he immediately takes their full effect. If he is staked, he become immobilized; if he is on or near fire, he begins to take the damage a Cainite should take, and he must immediately roll against Rötschreck.

••••• Gift of Life
With the Gift of Life, the character can experience the best and most positive things about being alive. The overwhelming hunger for blood temporarily abates, allowing the character to consume and enjoy food and drink. She can also enjoy sex as she wishes, and the sun does not burn her. The Gift of Life comes with a dark, terrible cost, however. Its use is almost sure to result in the death of a mortal, as the vampire must expend an enormous quantity of vitae in order to initiate it. The Discipline’s effects last until the midnight after the character uses the power, so it is in her best interests to use it just after midnight.
System: The player spends 12 blood points, burning as much blood as possible each turn until she meets that level. She then rolls Stamina + Occult (difficulty 6) and needs only one success for the power to work. A botch has catastrophic effects. The character might be instantly killed or might inadvertently Embrace her victim, for example. If it takes longer than one turn to spend the necessary blood to enact this ability, it does not take effect until all 12 points have been spent. However, the blood must be spent continuously — the vampire cannot burn five, run off and feed, then burn seven more an hour later. On the other hand, she may feed as she activates the power — in one turn she might burn one blood point while drinking three. Since few Kindred above the Seventh Generation can easily expend such an amount of blood, the most efficient way to activate this power is to have a human nearby who can be sacrificed to power the transformation.
After her transformation, the character gains many traits of an ordinary human. She is largely immune to the scorching effects of the sun (Fortitude difficulties to soak damage from direct sunlight are halved, and she takes no damage if she is sufficiently covered), and she can experience and enjoy many of the fine things about human life. She retains a few of her vampiric benefits, however. Fortitude and Auspex abilities remain in place if she has either of those Disciplines, and the Storyteller may allow her to retain other Disciplines as well if he deems them dramatically appropriate. She also retains a vampire’s benefits when it comes to handling bashing damage. However, she is still vulnerable to holy artifacts, human faith, and being staked. Her blood remains vitae, not human blood. Use of this ability — which creates a mockery of human life — may interfere with a character’s Path advancement, at the Storyteller’s discretion.
The vampire is no more vulnerable to fire than any other mortal while in this half-alive state, but she still suffers somewhat from the Beast. Frenzy and Rötschreck difficulties are halved (round up). She can remain active during the day without Humanity or Path-based dice pool caps, although she is certainly tired during the day, since that is not her usual time of activity.
Her Beast exacts a dangerous retribution when her day of “life” is done. Although its influence is greatly suppressed during this power’s duration, the Beast has its way with the vampire for the next six nights, as all difficulties to resist frenzy increase by three. The wise necromancer hides herself away somewhere during that period, but, depending on morality and temperament, enforced isolation might drive her to frenzy on its own.]==],
				},
				["Die Herrschaft des Wyrm"] = {
					en = [==[Dark Ages Tome of Secrets, p. 109


Die Herrschaft des Wyrm


Die Herrschaft des Wyrm (Tyranny of the Wyrm) is a recent Path, first practiced by a line of Malkavian thaumaturgists in the region of Hesse, within the Fiefdoms of the Black Cross. Said to be mentored by babbling demons in service to a three-headed dragon, the neophyte blood magicians soon embraced infernalism with aims of overtaking the embryonic Tremere, and assisting Salubri allies in their retribution against the Usurpers. Tragically, the price of dealing with the unholy soon swept the Malkavians away from their intended course.
A Malkavian engraver, or “zettler,” as called by the native people of Hesse, betrayed his entire bloodline in sacrifice to the dragon. In exchange he gained full knowledge of the Tyranny of the Wyrm, and gifts allowing him powers beyond his neonate years. The zettler’s recent disappearance, and other Cainites’ subsequent discovery of his perfectly preserved scrolls detailing the Path, has led to a boutade of intrepid infernalists arising in the area.
All targeted Dark Thaumaturgy Path effects may be resisted with a Willpower roll (difficulty 6, plus the infernalist’s Dark Thaumaturgy rating, to a maximum of 9).
Price: Like the clan responsible for its creation, Die Herrschaft des Wyrm is unstable. Should a victim realize he’s being affected through forewarning or evidence of the infernalist’s intent, he may make a Wits + Occult roll (difficulty equal to the infernalist’s permanent Willpower, requiring as many successes as the infernalist has points in Dark Thaumaturgy). His success causes the power’s effects to rebound onto the infernalist. A botch on any Die Herrschaft des Wyrm roll also causes the effects to afflict the infernalist.
A blessing from someone with True Faith will remove any ill effects caused by this Discipline. The infernalist’s death does not remove these effects, as in her stead, demons will perpetuate the various curses and pains.

• Malfean Infection
Through use of Malfean Infection, the infernalist desecrates a holy individual, eroding his True Faith without the victim even knowing the power is taking effect.
System: The infernalist must know the name of her target, and paint an eye on her palm in vitae. For each success on the Path use, the victim loses any powers associated with his True Faith for a number of nights:
1 success — One night
2 successes — Three nights
3 successes — One week
4 successes — One month
5 successes — One year
6 or more successes — Permanent (or until removed via a blessing)
If reflected back on the infernalist due to a botched roll or the victim successfully combating the effect with a Wits + Occult roll, the Malfean Infection prevents Dark Thaumaturgy’s use for a number of nights corresponding to the number of successes, as stated above. This limitation can be removed through a new subservient deal with a demon.

•• Bane to the Soul
The Malkavians who forged Die Herrschaft des Wyrm communed with spiritual demons called “Banes,” which they successfully discovered could be summoned and attached to the souls of their enemies. By grafting a Bane onto a foe, they discovered the victim would be inclined to act on all her worst impulses.
System: The infernalist must hold an item or article once touched by her target, and drip vitae upon it. A demonic Bane will attach to the target’s soul on a success, increasing the difficulty of Virtue tests by +2 (to a maximum of 9). Each success determines how long the Bane remains:
1 success — One night
2 successes — Three nights
3 successes — One week
4 successes — One month
5 successes — One year
6 or more successes — Permanent (or until removed via a blessing)

••• Dissonant Miserere
Through chanting, incantation, and inspired clack, the infernalist penetrates her victim’s mind with the endless toiling noise of her ravings. The cacophony of a Dissonant Miserere persists night after night, planting a seed in the victim’s mind that sanctuary may only be found by calling upon a demon of madness, who might remove the babble. The power acts as a doorway for such a demon, waiting to strike when the victim is at his weakest. The victim must beg for the demon to step through in order for this to happen.
System: The infernalist must possess a piece of the victim’s skin, hair, or a nail, and soak it in vitae. The Wyrm’s screaming mouths enter the victim’s mind, increasing the difficulty of all Willpower tests and any test requiring concentration by one point per success rolled (to a maximum of difficulty 9), and removes a temporary Willpower point from the victim each night it remains.
The effect is permanent, until the victim receives a blessing or calls upon a madness demon to relieve him of this pain. If the latter occurs, the demon — a shrieking creature without tangible form — will offer the victim a reprieve in exchange for a service. The nature of this service depends on how weak-willed the demon believes the victim is at this point (and is determined by the Storyteller), but typical requests include the murder of an innocent, the divestment of all worldly goods, or a sacrifice of vitae to the infernalist.

•••• Feed the Wyrm
By drinking the blood of his victim, the infernalist creates a sympathetic link between his demonic masters and the targeted vampire. This link causes agony, and sometimes even death, as the infernalist’s magic twists and mutates the victim’s body. A reprieve is only available if the sufferer agrees to serve the Wyrm with foul future deeds.
System: The infernalist must possess a portion (one blood point) of the victim’s blood, mix his vitae with it, and drink the concoction. This may form a blood bond, if the blood is that of another vampire. Once the blood is swallowed, a successful roll inflicts one level of aggravated damage per success. This damage may be soaked with Fortitude. The victim’s body contorts with pain and manifests inhuman growths, reducing her Appearance rating by two dots. The Appearance loss is cumulative if this power is used more than once.
The victim may only recover her Appearance rating by agreeing to serve the Wyrm. If she does so, an urge demon of vanity appears in a reflective surface and demands a sacrifice, the severity of which is determined by how great a loss of beauty has occurred. Sacrifices may entail ripping the smile from a newborn’s face, slaying a dozen virgins, or the victim allowing a Maeljin to permanently inhabit her soul.

••••• House the Maeljin
According to the Malkavian thaumaturgists who founded this Path, the Maeljin are among the most powerful and wise of demons. These incarnations of vice, filth, and immorality are masters of Banes and extra-dimensional demigods. House the Maeljin allows the infernalist to play host to one of the Maeljin, at the expense of a dire sacrifice. The power benefits for hosting a Maeljin are numerous. The moral toll it takes is immense.
System: The infernalist must murder a mortal or vampire with whom they hold a close relationship. If the victim is a vampire, the infernalist must perform diablerie on his prey. A successful roll manifests one of the Maeljin in the body of the infernalist. Each success determines how long the Maeljin remains:
1 success — One scene
2 successes — One night
3 successes — Two nights
4 successes — Four nights
5 successes — One week
6 or more successes — Permanent (or until removed via a blessing)
If the Maeljin remains permanently, the vampire runs the risk of losing all control to the demon inside them. It then becomes a race to achieve purification before the Maeljin can exert absolute dominance.
The natures of the various Maeljin differ. As beings of elemental unholiness, they represent abstract sins, such as shame, loss, anger, and a multitude of further intangible concepts. Maeljin all empower their host with six points to spread among Attributes (no Attribute may gain more than two), six points to spread among Abilities, and six points to spread among Disciplines (no Discipline may gain more than two). The Storyteller decides where these points are allocated on the character sheet.
As examples of how a possessing Maeljin may empower its host, a Maeljin of Lust might allocate six points across Social Attributes, place three points in Performance and another three in Expression, with two points going to Presence, two more to Dominate, and the final two on Daimonion. A Maeljin of Lies may allocate two points to Manipulation, two to Intelligence, and two to Dexterity, with six points spread among coercive Abilities. The final six might be allocated to Obfuscate, Presence, and Chimerstry.
An inhabiting Maeljin allows its host to practice the powers it has bestowed freely. It wants the host empowered and terrible. However, occasionally it will attempt to sway or outright control its host into acting in ways favorable to its alien agenda. In such cases, the vampire must make an Instinct/Self-Control roll (difficulty 8) to not act in the way the Maeljin wishes. The Storyteller determines the Maeljin’s wishes. It may attempt to exert control once a night.
As the Maeljin approaches the conclusion of its inhabitation, it seeks to consume the host by driving him into an act of self-destruction. The Maeljin can only attempt this once, but to resist throwing himself onto a pyre, greeting the sun, or walking into a sanctified building, the vampire must succeed on a Courage roll (difficulty 9). If his coterie attempts to restrain him, he immediately falls to frenzy. The Maeljin will depart peacefully if unsuccessful in its attempt to claim the entire soul of its host.]==],
				},
				["Elemental Mastery"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 214


Elemental Mastery


This path allows a vampire limited control over and communion with inanimate objects. Elemental Mastery can only be used to affect the unliving — a vampire could not cause a tree to walk by using Animate the Unmoving, for instance. Thaumaturges who seek mastery over living things generally study paths such as The Green Path (p. 215).

• Elemental Strength
The vampire can draw upon the strength and resilience of the earth, or of the objects around him, to increase his physical prowess without the need for large amounts of blood.
System: The player allocates a total of three temporary bonus dots between the character’s Strength and Stamina. The number of successes on the roll to activate the power is the number of turns these dots remain. The player may spend a Willpower point to increase this duration by one turn. This power cannot be “stacked” — one application must expire before the next can be made.

•• Wooden Tongues
A vampire may speak, albeit in limited fashion, with the spirit of any inanimate object. The conversation may not be incredibly interesting, as most rocks and chairs have limited concern for what occurs around them, but the vampire can get at least a general impression of what the subject has “experienced.” Note that events which are significant to a vampire may not be the same events that interest a lawn gnome.
System: The number of successes dictates the amount and relevance of the information that the character receives. One success may yield a boulder’s memory of a forest fire, while three may indicate that it remembers a shadowy figure running past, and five will cause the rock to relate a precise description of a local Gangrel.

••• Animate the Unmoving
Objects affected by this power move as the vampire using it dictates. An object cannot take an action that would be completely inconceivable for something with its form — for instance, a door could not leap from its hinges and carry someone across a street. However, seemingly solid objects can become flexible within reason: Barstools can run with their legs, guns can twist out of their owners’ hands or fire while holstered, and humanoid statues can move like normal humans.
System: This power requires the expenditure of a Willpower point with less than four successes on the roll. Each use of this power animates one object no larger than human-sized; the caster may simultaneously control a number of animate objects equal to his Intelligence rating. Objects animated by this power stay animated as long as they are within the caster’s line of sight or up to an hour, although the thaumaturge can take other actions during that time.

•••• Elemental Form
The vampire can take the shape of any inanimate object of a mass roughly equal to her own. A desk, a statue, or a bicycle would be feasible, but a house or a pen would be beyond this power’s capacity.
System: The number of successes determines how completely the character takes the shape she wishes to counterfeit. At least three successes are required for the character to use her senses or Disciplines while in her altered form. This power lasts for the remainder of the night, although the character may return to her normal form at will.

••••• Summon Elemental
A vampire may summon one of the traditional spirits of the elements: a salamander (fire), a sylph (air), a gnome (earth), or an undine (water). Some thaumaturges claim to have contacted elemental spirits of glass, electricity, blood, and even atomic energy, but such reports remain unconfirmed (even as their authors are summoned to Vienna for questioning). The caster may choose what type of elemental he wishes to summon and command.
System: The character must be near some quantity of the classical element corresponding to the spirit he wishes to invoke. The spirit invoked may or may not actually follow the caster’s instructions once summoned, but generally will at least pay rough attention to what it’s being told to do. The number of successes gained on the Willpower roll determines the power level of the elemental.
The elemental has three dots in all Physical and Mental Attributes. One dot may be added to one of the elemental’s Physical Attributes for each success gained by the caster on the initial roll. The Storyteller should determine the elemental’s Abilities, attacks, and damage, and any special powers it has related to its element.
Once the elemental has been summoned, the thaumaturge must exert control over it. The more powerful the elemental, the more difficult a task this is. The player rolls Manipulation + Occult (difficulty of the number of successes scored on the casting roll + 4), and the number of successes determines the degree of control:
Botch — The elemental immediately attacks the thaumaturge.
Failure — The elemental goes free and may attack anyone or leave the scene at the Storyteller’s discretion.
1 success — The elemental does not attack its summoner.
2 successes — The elemental behaves favorably toward the summoner and may perform a service in exchange for payment (determined by the Storyteller).
3 successes — The elemental performs one service, within reason.
4 successes — The elemental performs any one task for the caster that does not jeopardize its own existence.
5 successes — The elemental performs any task that the caster sets for it, even one that may take several nights to complete or that places its existence at risk.]==],
				},
				["Grave’s Decay"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 171


Grave’s Decay


This path is derived from the observation of the working of time on all things mortal. Stone crumbles and the corpse rots away to nothing, a process of endless fascination to the lost Cainites known as Cappadocians. Indeed, for the undying, the process of decay is a fascinating disease that afflicts everyone and everything save them. Under this path, a practitioner of Necromancy channels that force.

• Destroy the Husk
Cainites who kill their victims, rather than just feeding upon them, frequently find themselves in need of a quick way to dispose of a corpse. While there are many ways to make sure that a corpse is not found — feed it to a pack of hounds or weigh it down and throw it in a river — many of these methods do involve risk to the vampire and are not guaranteed to succeed. Destroy the Husk, by contrast, is foolproof. Use of this power simply turns one human corpse to a pile of about 30 pounds (13 kilograms) of unremarkable dust, roughly the size and shape of that body.
System: The player spends one blood point as the vampire drips her vitae onto the corpse. The player then rolls Intelligence + Medicine (difficulty 6). One success is all that is needed to render the corpse into dust, although the process takes a number of turns equal to five minus the successes.

•• Rigor Mortis
One of the first changes that comes over a dead body is rigidity; the corpse becomes stiff as a board, frozen in a single pose. The Cainite who wields Rigor Mortis is able to push a living or undead body to that frozen point using only his will and understanding of the forces of decay. She forces her target to become rigid and unable to move without enormous effort of will, as his very muscles betray him.
System: The player spends a point of Willpower and rolls Intelligence + Medicine (difficulty 7). Each success freezes the target in place for one turn. A failure simply indicates the loss of the Willpower point, while a botch renders the target immune to powers in the Grave’s Decay path for the next 24 hours. The target must be visible and within about 25 yards or meters for this ability to take effect. A frozen target is treated as though he has been staked (see p. 280). With a Willpower roll (difficulty 7) and two successes, the target can break out of the rigor on her turn. Failure causes her a level of bashing damage and means another turn wasted and frozen.

••• Wither
Reminiscent of some of the powers of Vicissitude, Wither allows a vampire to cripple an opponent’s limb. Whether the foe is living or undead, muscle shrivels away, skin peels, and bone becomes brittle. The target is unable to exert any noteworthy strength in the crippled limb. This injury lasts for far longer than most injuries trouble vampires, and in mortals it simply does not heal.
Wither doesn’t have to be used on a limb, although that is its usual purpose. It can also be used simply to affect the target’s face and hair, making him appear far older than his years. It could also be applied to a target’s eye or ear, killing the sense in that organ (and thus requiring two uses to permanently blind or deafen). Wither cannot be used as an “instant-kill” power — necromancers cannot wither internal organs — but it can inflict a wide variety of injuries on a foe.
System: The player spends a Willpower point. The character chooses a limb on the target and then touches that limb. If the target is trying to avoid contact, the invoker’s player rolls Dexterity + Brawl to hit as normal. If the character succeeds in touching the intended limb, the target suffers two aggravated wounds. Unless the target soaks both wounds (such as with Fortitude), the struck limb is crippled and unusable until both of those wounds have healed. Kindred heal the wounds as they would any other aggravated wound (see p. 285). Mortals are incapable of healing aggravated wounds, so they suffer throughout their lives unless they are healed through supernatural means. A withered limb does not degenerate further, even on a mortal. The character may be crippled for life, but the limb won’t become infected or gangrenous.
The effects of the withering depend on the affected limb. A crippled arm has a Strength of 0, cannot benefit from Potence, and cannot carry anything heavier than about half a pound (200 grams). A crippled leg prevents the character from moving faster than a stuttering hop or dragging limp. The character suffers the effects of the Lame Flaw (see p. 482). A single withered eye or ear imposes a +1 difficulty to relevant Perception rolls. Losing both eyes or both ears imposes the effects of the Blind or Deaf Flaws (see pp. 484 and 483). A withered tongue imposes the effects of the Mute Flaw (p. 483), while a withered face reduces the target’s Appearance by one for each aggravated wound suffered.

•••• Corrupt the Undead Flesh
Corrupt the Undead Flesh blurs the line between life and undeath, turning an undead creature into something just living enough to carry and suffer from disease. The disease inflicts the target, causing lethargy, dizziness, loss of strength, clumsiness, and the inability to keep blood in his system. This pernicious influence is extremely virulent among mortals. They pick the disease up simply by spending a few hours near the victim. Other vampires have a harder time acquiring the disease. They must consume the victim’s blood to do so, but afterward, they suffer just as much as the original target — including passing the affliction on to others.
The disease fades after roughly a week.
System: The player chooses a target within her character’s line of sight and no more than 20 yards or meters away. She rolls Intelligence + Medicine (difficulty 6) and spends a point of Willpower. The victim’s player must roll Stamina (+ Fortitude, if appropriate) against a difficulty equal to the attacker’s Willpower. If the player scores more successes than the victim, he acquires a virulent disease immediately. The disease has the following effects:
• The victim’s Strength and Wits are halved (round down).
• The victim loses one point of Dexterity.
• The victim’s player must spend one additional blood point every evening for the vampire to rouse himself to consciousness. Mortals lose one health level per day instead.
• The victim’s player must roll Self-Control or Instinct each time the character feeds (difficulty 8). On a failure, the vampire cannot keep the blood he just ingested inside his body, and he vomits it up in great horrifying gouts of gore, losing any benefit the blood might have provided. Humans vomit up food.
Every evening at sunset, the victim has a chance to throw off the plague. The victim’s player rolls Stamina, with a difficulty equal to 10 minus the number of sunsets since acquiring the plague. On a successful roll, the character fights the disease to a standstill and begins to recover. He instantly regains his ability to manage blood, and he heals back one lost Attribute point per hour until all have returned.

••••• Dissolve the Flesh
This ability brings the Grave’s Decay path full circle, as it causes Destroy the Husk to apply to vampires. Dissolve the Flesh allows a necromancer to attempt to turn vampiric flesh to dust or ash, as though the target had been burned or left out in the sun.
System: The player spends two blood points and a Willpower point as the vampire extracts a quantity of her vitae charged with the power of the grave. If she drips it onto a single Kindred victim anytime within the next few turns (most of the blood must reach the victim, so flinging a few drops is ineffective), it causes whole chunks of the victim’s body to crumble to ash. The player rolls Willpower against a difficulty of the victim’s Stamina + 3. For every success, the target takes one aggravated wound.
The undead flesh damaged by this power turns to dust (gone for the time being), and it must be regenerated painstakingly by the victim, should he survive. That dust doubtlessly has mystical properties that various sorcerers might be able to take advantage of. Every wound inflicted by this ability represents the loss of about one-eighth of the target’s weight; the Storyteller chooses where the loss comes from. (It might also be shed from all over, leaving the victim a bit gaunter or missing chunks of flesh.)
Regenerating body parts occurs naturally while healing aggravated wounds at the normal rate (see p. 285).]==],
				},
				["Hands of Destruction"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 217


Hands of Destruction


This Path is practiced most commonly by the various thaumaturges of the Sabbat. Though it is not widely seen outside that Sect, a few Camarilla Tremere have managed to learn the secrets of this path over the centuries. The Hands of Destruction has an infamous history, and some Tremere refuse to practice it due to rumors that it is demonic in origin.

• Decay
This power accelerates the decrepitude of its target, causing it to wither, rot, or otherwise break down. The target must be inanimate, though dead organic matter can be affected.
System: If the roll is successful, the inanimate object touched by the thaumaturge ages 10 years for every minute the Kindred touches it. If the vampire breaks physical contact and wishes to age the object again, another blood point must be spent and another roll must be made. This power does not affect vampires.

•• Gnarl Wood
This power warps and bends wooden objects. Though the wood is otherwise undamaged, this power often leaves the objects completely useless. This power may also be used to swell or contract wood, in addition to bending it into unwholesome shapes. Unlike other powers of this path, Gnarl Wood requires merely a glance rather than physical contact.
System: Fifty pounds or twenty-five kilograms of visible wood may be gnarled for each blood point spent on this power (the thaumaturge may expend as much blood as she likes on this power, up to her per-turn generational maximum). It is also possible to warp multiple visible objects — like all the stakes a team of vampire-hunters wields.

••• Acidic Touch
The vampire secretes a bilious, acidic fluid from any portion of his body. The viscous acid corrodes metal, destroys wood, and causes horrendous chemical burns to living tissue.
System: The player spends one blood point to create the acid — the blood literally transmutes into the volatile secretion. One blood point creates enough acid to burn through a quarter-inch or half a centimeter of steel plate or three inches (seven centimeters) of wood. The damage from an acid-augmented hand-to-hand attack is aggravated and costs one blood point per turn to use. A thaumaturge is immune to her own acidic touch.

•••• Atrophy
This power withers a victim’s limb, leaving only a desiccated, almost mummified husk of bone and skin. The effects are instantaneous; in mortals, they are also irreversible.
System: The victim may resist the effects of Atrophy by scoring three or more successes on a Stamina + Athletics roll (difficulty 8). Failure means the limb is permanently and completely crippled. Partial resistance is possible: One success indicates that the difficulty of any roll involving the use of the arm increases by two, though these effects are still permanent with regard to mortals. Two successes signify that difficulties increase by one. Vampires afflicted by this power may spend five blood points to rejuvenate atrophied limbs. Mortals are permanently crippled. This power affects only limbs or parts of limbs (arms, legs, hands); it does not work on victims’ heads, torsos, etc.

••••• Turn to Dust
This fearsome power accelerates decrepitude in its victims. Mortals literally age at the mere touch of a skilled thaumaturge, gaining decades in moments.
System: Each success on the roll ages the victim by 10 years. A potential victim may resist with a Stamina + Courage roll (difficulty 8), but must accumulate more successes than the caster’s activation roll — it’s an all-or-nothing affair. If the victim succeeds, he does not age at all. If he does not acquire more successes than the thaumaturge, he ages the full amount. Obviously, this power, while it affects vampires, has no detrimental effect on them (they’re immortal). At most, a Kindred victim grows paler and withers slightly (-1 to Appearance) for one night.]==],
				},
				["Iter Pernix"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 297


Iter Pernix


Iter Pernix (The Swift Journey) subtly strengthens the vigor of mortals, vampires, or animals so that they can cross great distances more quickly than they ordinarily could. It does not speed up their movement in the same way that Celerity does. Instead, it instills in them a determination to press ahead and a relief from the fatigue of a constant march.
System: Choose a number of targets and roll for successes. Each success allows the targets to move along roads at a speed of thirty miles per hour/forty-five km per hour for one hour without need of rest or any negative after-effects. It has no effect on movement speeds in combat, only for long-distance travel.
Botches: Instead of speeding up travel, a botch when invoking Iter Pernix causes mounts to become difficult to handle, slowing movement to half speed for the next hour if they are connected to wagons or possibly to wander off-course if they are not.
• One being (a mount or walking human)
•• Up to six mounts or one laden wagon
••• Up to twelve mounts or four supply wagons
•••• Up to 24 mounts or eight supply wagons or one siege engine
••••• Up to 48 mounts or sixteen supply wagons or four siege engines]==],
				},
				["Lure of Flames"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 218


Lure of Flames


This path grants the thaumaturge the ability to conjure forth mystical flames — small fires at first, but skilled magicians may create great conflagrations. Fire created by this path is not “natural.” In fact, many vampires believe the flames to be conjured from Hell itself. The Lure of Flames is greatly feared, as fire is one of the surest ways to bring Final Death upon a vampire. See “Fire” (p. 297) for more information on how vampires suffer from flame.
Fire conjured by The Lure of Flames must be released for it to have any effect. Thus, a “palm of flame” does not burn the vampire’s hand and cause an aggravated wound (nor does it cause the caster to frenzy) — it merely produces light. Once the flame has been released, however, it burns normally and the character has no control over it.
System: The number of successes determines how accurately the vampire places the flame in his desired location (declared before the roll is made). One success is all that is necessary to conjure a flame in one’s hand, while five successes place a flame anywhere in the Kindred’s line of sight. Less successes mean that the flame appears somewhere at the Storyteller’s discretion — as a rough rule of thumb, the thaumaturge can accurately place a flame within 10 yards or meters of themselves per success.
Individual descriptions are not provided for each level of this path — fire is fire, after all (including potentially causing frenzy in other vampires witnessing it). The chart below describes the path level required to generate a specific amount of flame. To soak the damage at all, a vampire must have the Fortitude Discipline. Fire under the caster’s control does not harm the vampire or cause him to frenzy, but fires started as a result of the unnatural flame affect the thaumaturge normally.
• Candle (difficulty 3 to soak, one health level of aggravated damage/turn)
•• Palm of flame (difficulty 4 to soak, one health level of aggravated damage/turn)
••• Campfire (difficulty 5 to soak, two health levels of aggravated damage/turn)
•••• Bonfire (difficulty 7 to soak, two health levels of aggravated damage/turn)
••••• Inferno (difficulty 9 to soak, three health levels of aggravated damage/turn)]==],
				},
				["Mastery of the Mortal Shell"] = {
					en = [==[Rites of Blood, p. 138


Mastery of the Mortal Shell


Folklore warns of the dangers of the witches’ curse and the ability of warlocks to possess the weak and force them to do their bidding. During the early nights of Clan Tremere, Mastery of the Mortal Shell was developed to battle the Tzimisce and Gangrel marauders that attacked their chantries. The use of this Path was later expanded to enforce subservience among Gargoyles after their first revolt. A thaumaturge practicing Mastery of the Mortal Shell explores the fundamental workings of the body, granting control over the physical workings over her victim. Targets may include humans or any supernatural creatures with flesh such as vampires, werewolves, or mages, but not ghosts or demons, who are made primarily of spirit.
Lesser powers of this Path are clumsy in their control of the body, but become increasingly precise and complete.
A number of the powers in this Path are activated by touch. Depending upon the circumstances, the Storyteller may require a successful Dexterity + Brawl roll for the thaumaturge to make contact with the intended victim. Targeting rules (see V20, p. 274) apply for attacking a specific extremity if contact is not guaranteed.
Unless otherwise stated, the powers of Mastery of the Mortal Shell last a number of turns equal to the number of successes the thaumaturge scores on her activation roll. A victim may only suffer the effects of one power from this Path at a time. Thus, a thaumaturge may not enact Vertigo and Contortion at the same time upon the same victim. The most recent power activated replaces the effects of previous powers used upon the victim.

• Vertigo
The thaumaturge induces minor disorientation and dizziness through subtle manipulations in the subject’s body. The physical discomfort is temporary and minor, but a clever thaumaturge can use it on rivals at the most inopportune times, causing them to lose their aplomb.
System: A touch from the thaumaturge invokes disorientation in her victim. If successful, all of the victim’s physical actions are at +1 difficulty for the duration of the power. Subsequent uses of this Path may extend the duration, though the difficulty will not increase further.

•• Contortion
With a touch, the thaumaturge causes a group of her opponent’s muscles to contract involuntarily, reducing it to twitching fits. This effect is extremely disconcerting to the subject, rendering the limb or muscle group unusable.
System: By making physical contact with one of the limbs of the target, the thaumaturge renders it useless for the duration of Contortion. A leg rendered useless makes standing difficult, and the victim suffers from increased difficulty (+1 to +3, depending on circumstances) to appropriate Dexterity challenges related to her leg, such as dancing or balancing on ledges. A contorted arm hangs lifeless at the subject’s side. A useless head causes loss of speech and increases the difficulty of all Social rolls are at +2 as the facial muscles spasm out of control.

••• Seizure
Seizure causes the body to erupt into a fit of convulsions. All the muscles throughout the body tighten uncontrollably, while the victim foams at the mouth and spasms rack him with agony. A mortal may even choke to death as her tongue cuts off her air supply.
System: A light touch from the thaumaturge forces the very unpleasant effects of this power upon the target. For the duration of the seizure, a target’s body writhes, tormenting her to the point of incapacitation. Victims suffer a +2 difficulty penalty to all physical actions. The victim also suffers one level of bashing damage every turn, as her body helplessly twists itself. At Storyteller discretion, the effects of this power may even cause death in extremely ill or wounded mortals.
Damage may be reduced as normal (although levels from armor do not apply).

•••• Body Failure
Thaumaturges wielding this frightful power gain devastating insights into the workings of the body, allowing a complete shutdown of its systems. This sudden biological overload often proves fatal to mortals and damaging to other supernatural beings. Body Failure has been used throughout the ages to afflict horrific ailments in inconspicuous ways that suggest a stroke or heart attack.
System: The thaumaturge no longer needs to touch her victim to strike out with this level of mastery of the Path. She may affect any target within her line of sight, but she must keep visual contact with the victim at all times to maintain this effect. A successful activation of this power grants effects similar to Seizure, except that damage is lethal (and thus not soakable by mortals) due to complete mass tissue and organ failure. Additionally, the victim suffers a +2 difficulty penalty to all actions.
The subject may resist the effects of Body Failure via a Stamina + Fortitude roll when the thaumaturge attempts to strike the target (difficulty equals the thaumaturge’s current Willpower). Each success the victim gains on this roll reduces the duration of Body Failure by one turn.

••••• Marionette
The thaumaturge invoking Marionette gains such mastery over the body of others that she can magically seize control of another being and force her victim to act according to her own whims. This control is not as fine as the direct and personal command of the Dominate power of Possession, but the thaumaturge’s true body is not as vulnerable during the manipulation. Once established, the Marionette victim is under the complete sway of the thaumaturge, forced to perform as the thaumaturge’s macabre pawn.
System: The thaumaturge may affect any target within her line of sight, but she must keep visual contact with the victim at all times to maintain this effect. A subject may resist the effects of Marionette on a Stamina + Fortitude roll (difficulty equal to the thaumaturge’s current Willpower) when the thaumaturge attempts to take control. Each success the victim gains on this roll reduces the duration of Marionette by one turn. Victims lacking Fortitude do not have the physical resistance to defy this effect.
For the duration of this power, the thaumaturge can cause the victim to perform any physical action, using the target’s pools with a penalty of +2 difficulty to all rolls. The concentration this power requires also increases the thaumaturge’s own difficulties by two for all other personal actions undertaken while manipulating the victim. To extend the duration of this control, the thaumaturge must make a second activation roll. Marionette does not rob the victim of her cognizance, only physical control over her body. During this time of thaumaturge’s mastery, the target remains aware that some outside force is manipulating her physical actions, conscious that they are not her own. The victim may spend a point of Willpower to attempt to take a mental or social action, such as activating a Discipline or speaking.]==],
				},
				["Movement of the Mind"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 220


Movement of the Mind


This path gives the thaumaturge the ability to move objects telekinetically through the mystic power of blood. At higher levels, even flight is possible (but be careful who sees you…). Objects under the character’s control may be manipulated as if she held them — they may be lifted, spun, juggled, or even “thrown,” though creating enough force to inflict actual damage requires mastery of at least the fourth level of this path. Some casters skilled in this path even use it to guard their havens, animating swords, axes, and firearms to ward off intruders. This path may frighten and disconcert onlookers.
System: The number of successes indicates the duration of the caster’s control over the object (or subject). Each success allows one turn of manipulation, though the Kindred may attempt to maintain control after this time by making a new roll (she need not spend additional blood to maintain control). If the roll is successful, control is maintained. If a thaumaturge loses or relaxes control over an object and later manipulates it again, her player must spend another blood point, as a new attempt is being made. Five or more successes on the initial roll means the vampire can control the object for duration of the scene.
If this power is used to manipulate a living being, the subject may attempt to resist. In this case, the caster and the subject make opposed Willpower rolls each turn the control is exercised.
Like The Lure of Flames, individual power levels are not provided for this path — consult the chart below to see how much weight a thaumaturge may control.
Once a Kindred reaches a rating of 3, she may levitate herself and “fly” at approximately running speed, no matter how much she weighs, though the weight restrictions apply if she manipulates other objects or subjects. Once a Kindred achieves 4, she may “throw” objects at a Strength equal to her level of mastery of this path.
• One pound/one-half kilogram
•• 20 pounds/10 kilograms
••• 200 pounds/100 kilograms
•••• 500 pounds/250 kilograms
••••• 1000 pounds/500 kilograms]==],
				},
				["Neptune’s Might"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 218


Neptune’s Might


Vampires are rarely associated with the ocean in most mythologies, and most Kindred have nothing to do with water in large quantities simply because they have no reason to do so. Nevertheless, Neptune’s Might has enjoyed a small, but devoted, following for centuries among Camarilla thaumaturges. This path is based primarily around the manipulation of standing water, although some of its more disturbing effects depart from this principle.
Once a character reaches the third level of Neptune’s Might, the player may choose to specialize in either fresh water or salt water. Such specialization lowers all Neptune’s Might difficulties by one when dealing with the chosen medium but raises them by one when dealing with the opposite. Blood is considered neither fresh nor salty for this purpose, and difficulties in manipulating it are unaffected.

• Eyes of the Sea
The thaumaturge may peer into a body of water and view events that have transpired on, in, or around it from the water’s perspective. Some older practitioners of this art claim that the vampire communes with the spirits of the waters when using this power; younger Kindred scoff at such claims.
System: The number of successes rolled determines how far into the past the character can look.
1 success — One day
2 successes — One week
3 successes — One month
4 successes — One year
5 successes — 10 years
The Storyteller may require a Perception + Occult roll for the character to discern very small details in the transmitted images. This power can only he used on standing water; lakes and puddles qualify, but oceans, rivers, sewers, and wine glasses do not.

•• Prison of Water
The thaumaturge can command a sufficiently large quantity of water to animate itself and imprison a subject. This power requires a significant amount of fluid to be fully effective, although even a few gallons can be used to shape chains of animated water.
System: The number of successes scored on the roll is the number of successes the victim must score on a Strength roll (difficulty 8; Potence can add to this roll) to break free. A subject may be held in only one prison at a time, although the caster is free to invoke multiple uses of this power upon separate victims and may dissolve these prisons at will. If a sufficient quantity of water (at least a bathtub’s worth) is not present, the difficulty of the Willpower roll to activate this power is raised by one.

••• Blood to Water
The thaumaturge has now attained enough power over water that she can transmute other liquids to this basic element. The most commonly seen use of this power is as an assault; with but a touch, the victim’s blood transforms to water, weakening vampires and killing mortals in moments.
System: The character must touch her intended victim. The player rolls Willpower normally. Each success converts one of the victim’s blood points to water. One success kills a mortal within minutes. Vampires who lose blood points to this power also suffer dice pool penalties as if they had received an equivalent number of health levels of injury. The water left in the target’s system by this attack evaporates out at a rate of one blood point’s worth per hour, but the lost blood does not return.
At the Storyteller’s discretion, other liquids may be turned to water with this power (the difficulty for such an action is reduced by one unless the substance is particularly dangerous or magical in nature). The character must still touch the substance or its container to use this power.

•••• Flowing Wall
Tales of vampires’ inability to cross running water may have derived in part from garbled accounts of this power in action. The thaumaturge can animate water to an even greater degree than is possible with the use of Prison of Water, commanding it to rise up to form a barrier impassable to almost any being.
System: The character touches the surface of a standing body of water; the player spends three Willpower points and the normal required blood point and rolls normally. Successes are applied to both width and height of the wall; each success “buys” 10 feet/three meters in one dimension. The wall may be placed anywhere within the character’s line of sight, and must be formed in a straight line. The wall lasts until the next sunrise. It cannot be climbed, though it can be flown over. To pass through the barrier, any supernatural being (including beings trying to pass the wall on other levels of existence, such as ghosts) must score at least three successes on a single Willpower roll (difficulty 9).

••••• Dehydrate
At this level of mastery, the thaumaturge can directly attack living and unliving targets by removing the water from their bodies. Victims killed by this power leave behind hideous mummified corpses. This power can also be used for less aggressive purposes, such as drying out wet clothes — or evaporating puddles to keep other practitioners of this path from using them.
System: This power can be used on any target in the character’s line of sight. The player rolls normally; the victim resists with a roll of Stamina + Fortitude (difficulty 9). Each success gained by the caster translates into one health level of lethal damage inflicted on the victim. This injury cannot be soaked (the resistance roll replaces soak for this attack) but can be healed normally. Vampires lose blood points instead of health levels, though if a vampire has no blood points this attack inflicts health level loss as it would against a mortal. The victim of this attack must also roll Courage (difficulty equal to the number of successes scored by the caster + 3) to be able to act on the turn following the attack; failure means he is overcome with agony and can do nothing.]==],
				},
				["Path of Conjuring"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 220


Path of Conjuring


Invoking objects “out of thin air” has been a staple of occult and supernatural legend since long before the rise of the Tremere. This Thaumaturgical path enables powerful conjurations limited only by the mind of the practitioner.
Objects summoned via this path bear two distinct characteristics. They are uniformly “generic” in that each object summoned, if summoned again, would look exactly as it did at first. For example, a knife would be precisely the same knife if created twice; the two would be indistinguishable. Even a specific knife — the one a character’s father used to threaten her — would appear identical every time it was conjured. A rat would have repeated “tiled” patterns over its fur, and a garbage can would have a completely uniform fluted texture over its surface. Additionally, conjured objects bear no flaws: Weapons have no dents or scratches, tools have no distinguishing marks, and cellphones all look like they just came out of their packaging.
The limit on the size of conjured objects appears to be that of the conjurer: nothing larger than the thaumaturge can be created. The conjurer must also have some degree of familiarity with the object he wishes to call forth. Simply working from a picture or imagination calls for a higher difficulty, while objects with which the character is intimately familiar (such as the knife described above) may actually lower the difficulty, at the Storyteller’s discretion.
When a player rolls to conjure something, the successes gained on the roll indicate the quality of the summoned object. One success yields a shoddy, imperfect creation, while five successes garner the caster a nearly perfect replica.

• Summon the Simple Form
At this level of mastery, the conjurer may create simple, inanimate objects. The object cannot have any moving parts and may not be made of multiple materials. For example, the conjurer may summon a steel baton, a lead pipe, a wooden stake, or a chunk of granite.
System: Each turn the conjurer wishes to keep the object in existence, another Willpower point must be spent or the object vanishes.

•• Permanency
At this level, the conjurer no longer needs to pay Willpower costs to keep an object in existence. The object is permanent, though simple objects are still all that may be created.
System: The player must invest three blood points in an object to make it real.

••• Magic of the Smith
The Kindred may now conjure complex objects of multiple components and with moving parts. For example, the thaumaturge can create guns, bicycles, chainsaws, or cellphones.
System: Objects created via Magic of the Smith are automatically permanent and cost five blood points to conjure. Particularly complex items often require a Knowledge roll (Crafts, Science, Technology, etc.) in addition to the basic roll.

•••• Reverse Conjuration
This power allows the conjurer to “banish” into nonexistence any object previously called forth via this path.
System: This is an extended success roll. The conjurer must accumulate as many successes as the original caster received when creating the object in question. This can also be used by the thaumaturge to banish object she created herself with this Path.

••••• Power Over Life
This power cannot create true life, though it can summon forth impressive simulacra. Creatures (and people) summoned with this power lack the free will to act on their own, mindlessly following the simple instructions of their conjurer instead. People created in this way can be subject to the use of the Dominate power Possession (p. 155), if desired.
System: The player spends 10 blood points. Imperfect and impermanent, creatures summoned via this path are too complex to exist for long. Within a week after their conjuration, the simulacra vanish into insubstantiality.]==],
				},
				["Path of Corruption"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 221


Path of Corruption


The origins of this path are hotly debated among those who are familiar with its intricacies. One theory holds that its secrets were taught to the Tremere by demons and that use of it brings the practitioner dangerously close to the infernal powers. A second opinion has been advanced that the Path of Corruption is a holdover from the days when Clan Tremere was still mortal. The third theory, and the most disturbing to the Tremere, is that the path originated with the Followers of Set, and that knowledge of its workings was sold to the Tremere for an unspecified price. This last rumor is vehemently denied by the Tremere, which automatically makes it a favorite topic of discussion when the matter comes up.
The Path of Corruption is primarily a mentally and spiritually oriented path centered on influencing the psyches of other individuals. It can be used neither to issue commands like Dominate nor to change emotions in the moment like Presence. Rather, it produces a gradual and subtle twisting of the subject’s actions, morals, and thought processes. This path deals intimately with deception and dark desires, and those who work through it must understand the hidden places of the heart. Accordingly, no character may have a higher rating in the Path of Corruption than he has in Subterfuge.

• Contradict
The vampire can interrupt a subject’s thought processes, forcing the victim to reverse his current course of action. An Archon may be caused to execute a prisoner she was about to exonerate and release; a mortal lover might switch from gentle and caring to sadistic and demanding in the middle of an encounter. The results of Contradict are never precisely known to the thaumaturge in advance, but they always take the form of a more negative action than the subject had originally intended to perform.
System: This power may be used on any subject within the character’s line of sight. The player rolls as per normal. The target rolls Perception + Subterfuge (difficulty equal to the number of successes scored by the caster + 2). Two successes allow the subject to realize that she is being influenced by some outside source. Three successes let her pinpoint the source of the effect. Four successes give her a moment of hesitation, neither performing her original action nor its inverse, while five allow her to carry through with the original action.
The Storyteller dictates what the subject’s precise reaction to this power is. Contradict cannot be used in combat or to affect other actions (at the Storyteller’s discretion) that are mainly physical and reflexive.

•• Subvert
This power follows the same principle as does Contradict, the release of a subject’s dark, self-destructive side. However, Subvert’s effects are longer-lasting than the momentary flare of Contradiction. Under the influence of this power, victims act on their own suppressed temptations, pursuing agendas that their morals or self-control would forbid them to follow under normal circumstances.
System: This power requires the character to make eye contact (see p. 152) with the intended victim. The player rolls normally. The target resists with a roll of Perception + Subterfuge (difficulty equal to the target’s Manipulation + Subterfuge). If the thaumaturge scores more successes, the victim becomes inclined to follow a repressed, shameful desire for the length of time described below.
1 success — Five minutes
2 successes — One hour
3 successes — One night
4 successes — Three nights
5 successes — One week
The Storyteller determines the precise desire or agenda that the victim follows. It should be in keeping with the Psychological Flaws that she possesses or with the negative aspects of her Nature (for example, a Loner desiring isolation to such an extent that she becomes violent if forced to attend a social function). The subject should not become fixated on following this new agenda at all times, but should occasionally be forced to spend a Willpower point if the opportunity to succumb arises and she wishes to resist the impulse.

••• Dissociate
“Divide and conquer” is a maxim that is well-understood by the Tremere, and Dissociate is a powerful tool with which to divide the Clan’s enemies. This power is used to break the social ties of interpersonal relationships. Even the most passionate affair or the oldest friendship can be cooled through use of Dissociate, and weaker personal ties can be destroyed altogether.
System: The character must touch the target. The player rolls normally. The target resists with a Willpower roll (difficulty of the thaumaturge’s Manipulation + Empathy). The victim loses three dice from all Social rolls for a period of time determined by the number of successes gained by the caster:
1 success — Five minutes
2 successes — One hour
3 successes — One night
4 successes — Three nights
5 successes — One week
This penalty applies to all rolls that rely on Social Attributes, even those required for the use of Disciplines. If this power is used on a character who has participated in the Vaulderie or a similar ritual, that character’s Vinculum ratings are reduced by three for the duration of Dissociate’s effect.
Dissociate’s primary effect falls under roleplaying rather than game mechanics. Victims of this power should be played as withdrawn, suspicious, and emotionally distant. The Storyteller should feel free to require a Willpower point expenditure for a player who does not follow these guidelines.

•••• Addiction
This power is a much stronger and more potentially damaging form of Subvert. Addiction creates just that in the victim. By simply exposing the target to a particular sensation, substance, or action, the caster creates a powerful psychological dependence. Many thaumaturges ensure that their victims become addicted to substances or thrills that only the mystic can provide, thus creating both a source of income and potential blackmail material.
System: The subject must encounter or be exposed to the sensation, substance, or action to which the character wants to addict him. The thaumaturge then touches his target. The player rolls normally; the victim resists with a Self-Control/Instinct roll (difficulty equal to the number of successes scored by the caster + 3). Failure gives the subject an instant addiction to that object.
An addicted character must get his fix at least once a night. Every night that he goes without satisfying his desire imposes a cumulative penalty of one die on all of his dice pools (to a minimum pool of one die). The victim must roll Self-Control/Instinct (difficulty 8) every time he is confronted with the object of his addiction and wishes to keep from indulging. Addiction lasts for a number of weeks equal to the thaumaturge’s Manipulation score.
An individual may try to break the effects of Addiction. This requires an extended Self-Control/Instinct roll (difficulty of the caster’s Manipulation + Subterfuge), with one roll made per night. The addict must accumulate a number of successes equal to three times the number of successes scored by the caster. The victim may not indulge in his addiction over the time needed to accumulate these successes. If he does so, all accumulated successes are lost and he must begin anew on the next night. Note that the Self-Control/Instinct dice pool is reduced every night that the victim goes without feeding his addiction.

••••• Dependence
Many former pawns of Clan Tremere claim to have felt a strange sensation similar to depression when not in the presence of their masters. This is usually attributed to the blood bond, but is sometimes the result of the vampire’s mastery of Dependence. The final power of the Path of Corruption enables the vampire to tie her victim’s soul to her own, engendering feelings of lethargy and helplessness when the victim is not in her presence or acting to further her desires.
System: The character engages the target in conversation. The player rolls normally. The victim rolls Self-Control/Instinct (difficulty equals the number of successes scored by the caster + 3). Failure means that the victim’s psyche has been subtly bonded to that of the thaumaturge for one night per success rolled by the caster.
A bonded victim is no less likely to attack his controller, and feels no particular positive emotions toward her. However, he is psychologically addicted to her presence, and suffers a one-die penalty to all rolls when he is not around her or performing tasks for her.
Additionally, he is much less resistant to her commands, and his dice pools are halved when he attempts to resist her Dominate, Presence (or other mental or emotional control powers), or mundane Social rolls. Finally, he is unable to regain Willpower when he is not in the thaumaturge’s presence.]==],
				},
				["Path of Haunting"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 174


Path of Haunting


As the Maeghar fell farther away from the world and into darkness, their powers of illusion and trickery were warped by the shadows of Oblivion. Slowly they kindled within themselves the dark spark that would grow into the Path of Haunting. Other necromancers may also learn Path of Haunting and, indeed, Clan Giovanni has created it on its own.

• Song of the Dead
The necromancer weaves death and silence into a haunting song that instills an obsession with death in her listener. The victim becomes sure that death stalks him and sees ill omens everywhere. This constant threat can eventually lead a mortal to suicide or drive a vampire into torpor.
System: The vampire chants to the victim while her player spends one blood point and rolls Manipulation + Occult (difficulty of the target’s current Willpower). A botch indicates the vampire affects herself as though she had gained successes equal to the number of 1s rolled.
For a number of nights equal to the successes rolled, the target suffers depression and morbid anxiety. This fixation adds +2 to the difficulty of Social rolls (except those involving Intimidation) and +1 to the difficulty of all other non-reflexive rolls. If a target suffers the effects of this power for more continuous nights than his permanent Willpower, he loses a dot of permanent Willpower. This cycle continues after an interval of the new rating in days, with the victim losing a dot of permanent Willpower after each such iteration. Once a character drops to zero permanent Willpower, he commits suicide (if living) or falls into torpor (if a vampire). If the power is interrupted for at least one night, the victim recovers his permanent Willpower at the rate of one dot per week. A vampire who falls into torpor from reaching zero Willpower awakens with his original rating.

•• Summon Wisp
Straddling two worlds, the necromancer does not truly exist. She is here, yet she is not. Reaching into herself, she infuses a spark of her own ephemeral nature with dark, necromantic energy. The result is a dancing light, which is as hypnotic as it is treacherous.
System: The player spends one blood point and rolls Charisma + Occult (difficulty 5) to conjure an orb of pale light that lasts one scene. The wisp can take any color the vampire chooses and has no substance or weight. It may fly as fast as the vampire can run, casting cold illumination as bright as a candle. Mortals who behold the wisp must roll Willpower (difficulty 4) and achieve more successes than the caster or fall into a mild trance, which adds +1 to the difficulty of all actions due to distraction. If the vampire’s successes are double the mortal’s, he follows the light without regard for any but the most obvious obstacles. He walks around trees and rocks, but falls prey to quicksand or a high parapet. Any loud noise or other distraction immediately breaks the reverie.
If the vampire’s player botches the conjuration roll, the wisp appears and acts with its own malevolent agenda. Such a creature is only a nuisance, but can display remarkable cunning in luring enemies to the vampire’s haven or giving away her position.

••• Harrowing
Even dreams offer no respite to the enemies of the necromancer. Restful sleep becomes pure terror as Song of the Dead continues to haunt the sleeper through nightmares.
System: The vampire makes eye contact with the victim, while her player spends one blood point and rolls Manipulation + Occult (difficulty of the target’s permanent Willpower). If successful, the victim feels a slight sense of unease. When he next sleeps, he suffers horrible nightmares about his own demise. Even though he cannot fully remember the content of his visions after he wakes, the emotional trauma prevents him from regaining Willpower. In addition, his twisted déjà vu and unnatural paranoia give him the Nightmares and Eerie Presence Flaws (V20, p. 495) for the day. A botch in casting this power inflicts the same terrible dreams on the vampire when she slumbers.

•••• Phantasms
The necromancer recognizes the passion of the dead as an illusion. Drawing upon her insight, she may turn these illusions to haunt the living.
System: The vampire envisions the desired apparition, while the player spends one blood point and rolls Manipulation + Occult (difficulty 7). These creations have no substance and cannot speak or perform complicated actions, though they emit a surreal cold. Each success allows the vampire to create one phenomenon, or add one characteristic or condition to another phantom. For example, three successes could animate shadows to shuffle and writhe (one success) and create an illusion of dripping gore that bursts into a spray of flies when someone draws close (one success for the gore and one success for the condition). This power may create apparitions anywhere in the caster’s line of sight. The Storyteller remains the final arbiter of what is or is not possible with this power.
A botch calls the attention of a malefic ghost, giving the vampire the Haunted Flaw (V20, p. 495) for a number of nights equal to the 1s rolled.

••••• Torment
The distinction between life and death means nothing to the necromancer — it is another illusion, created for the comfort of the living. She may rend this veil and call upon malicious apparitions to haunt her victim.
System: The player spends one blood point and rolls Manipulation + Occult (difficulty 8). On a botch, the vampire permanently gains the Haunted Flaw (V20, p. 495), attracting the vilest and most hateful ghosts. If successful, the victim feels a sudden chill. The difficulty for ghosts to affect the target with any power decreases by one for every success rolled, to a minimum of difficulty 4. Malicious ghosts flock to the target, eagerly inflicting every horror at their disposal. The difficulty reduction diminishes by one every day at dawn until the victim returns to normal and the spectres lose interest. Multiple applications of this power may not be stacked to increase duration or intensity of effect. The statistics and powers of spectres are left to the Storyteller, but the experience should terrify the character utterly and may well result in derangements at the least.]==],
				},
				["Path of Mars"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 224


Path of Mars


Those rare Sabbat who have retained Thaumaturgical talents have turned their focus to the assistance of the Sect in times of war. This path has proven useful, turning the tides of several confrontations with elder vampires. The path adopts a very martial stance, whereas other blood magics tend to have subtler, less violent effects. It is rumored that some Camarilla Tremere have learned this path, but very few of them have the right temperament to wield this path effectively.

• War Cry
A vampire on the attack can focus his will, making him less susceptible to battle fear or the powers of the undead. The vampire shouts a primal scream to start the effect, though some thaumaturges have been known to paint their faces or cut themselves open instead.
System: For the duration of one scene, the vampire adds one to his Courage Trait. Additionally, for the purposes of hostile effects, his Willpower is considered to be one higher (though this bonus applies only to the Trait itself, not the Willpower pool). A character may only gain the benefits of War Cry once per scene.

•• Strike True
The vampire makes a single attack, guided by the unholy power of her Blood. This attack strikes its foe infallibly.
System: By invoking this power, the player need not roll to see if the vampire’s attack hits — it does, automatically. Only Melee or Brawl attacks may be made in this manner. These attacks are considered to be one-success attacks; they offer no additional damage dice. Also, they may be dodged, blocked, or parried normally, and the defender needs only one success (as the attacks’ number of success is assumed to be one). Strike True has no effect if attempted on multiple attacks (dice pool splits) in a single turn from one character.

••• Wind Dance
The thaumaturge invokes the power of the winds, moving in a blur. She gains a preternatural edge in avoiding her enemies’ blows, moving out of their way before the enemy has a chance to throw them.
System: The player can dodge any number of attacks with her full dice pool in a single turn. This advantage applies only to dodges — if the character wishes to attack and dodge, the player must still split her dice pool. This power lasts for one scene.

•••• Fearless Heart
The vampire temporarily augments his abilities as a warrior. Through the mystical powers of blood magic, the character becomes a potent fighting force.
System: Fearless Heart grants the vampire an extra point in each of the Physical Attributes (Strength, Dexterity, and Stamina). These Traits may not exceed their generational maximums, though the player may use blood points to push the character’s Traits even higher. The effects last for one scene, and a character may gain its benefits only once per scene. The vampire must spend two hours in a calm and restful state following the use of Fearless Heart, or lose a blood point every 15 minutes until he rests.

••••• Comrades at Arms
This ability extends the power of the previous abilities in the path. It allows any of the earlier effects to be applied to a group such as a pack or War Party.
System: The player chooses one of the lower-level powers in the path, invoking it as normal. Afterward, he touches another character and (if the roll for Comrades at Arms is successful) bestows the benefit on her as well. The same power may be delivered to any number of packmates, as long as the rolls for Comrades at Arms are successful and the thaumaturge pays the appropriate blood costs.]==],
				},
				["Path of Spirit Manipulation"] = {
					en = [==[Rites of Blood, p. 142


Path of Spirit Manipulation


Created to replace the rituals practiced by Clan Tremere in the days when it was a band of mortal wizards, Spirit Manipulation is the art of forcing spirits into actions and situations that would normally be contrary to their nature. These spirits are not the wraiths controlled by Necromancy, but a manifestation of the great powers of the universe that the limited humanoid brain perceives as spirits. Some believe that spirits are tulpas — constructs of human will created by faith to explain how the universe manages to function. Spirit Manipulation forces these spirits into a grotesque mockery of their normal behaviors to achieve magical results in the material world.

Creating Spirits (p. 142)
Spirits are constructs born from the spirit realms and are known to those with Hermetic training as the Umbrood. These spiritual constructs are not sentient as traditionally understood by those that live in the physical world, but are reflections of the spirit world and perceived aspects of the universe interpreted in a way that limited mortal perception can understand it. As such, spirits come in a wide berth of different types and potencies. The following rules are a limited guide for creating spirits for V20.
First, define the concept of the spirit. Traditionally it is limited by a single category that you can describe with a phrase. Some examples might include: nature spirit (land, sea, wood, or desert), conceptual spirit (mathematics, war, or mechanics), or an inanimate object (a computer, a knife, or a piece of jewelry).
Next, determine the potency of the spirit by defining its rank (from 1 to 5). The rank of the spirit determines its Willpower score. If the spirit must engage in any test, her dice pool is twice its rank.
For each level of rank of the spirit, assign one Discipline power based on the concept. For example, a rank 3 Fire Spirit might possess three dots of Thaumaturgy: The Lure of Flames (V20, p. 218). Willpower fuels any special ability that a spirit might possess, and Willpower points are regained every 24 hours.
Finally, assign one Ability per rank of the spirit. A spirit of war might have Brawl, Melee, Firearms, Survival, or any number of abilities related to war or fighting. Each Ability adds two dice to its base dice pool of Willpower x 2.

• Hermetic Sight
The vampire can perceive the spirit world, either by gazing deeply into it or by seeing the presence of nearby spirits as a hazy overlay on the material world.
System: Hermetic Sight allows the thaumaturge to perceive the spirit realm interlaid over the material world for one hour. Each additional level of success on the activation roll increases the duration of this power by an additional thirty minutes.

•• Astral Cant
The languages of the spirit world are infinitely varied and mainly incomprehensible to mortal (and immortal) minds. Astral Cant does not teach the thaumaturge the tongues of the spirits, but it does allow him to understand them as they speak to him and to reply in their own languages. The use of this power is not always necessary; many spirits speak human tongues, but choose to feign ignorance when dealing with vampires. Spirits are not affected by Dominate, but may be manipulated by Presence. Some thaumaturges theorize that this is because spirits are not actually sentient as a vampire would understand the concept, but are manifestations based on the perception of those that are self-aware.
System: Astral Cant allows the thaumaturge to speak to any spirit visible via Hermetic Sight for fifteen minutes. Each additional level of success on the activation roll increases the duration of this power by an additional fifteen minutes to the duration.

••• Voice of Command
This is perhaps the most dangerous power in the Spirit Manipulation arsenal, for the consequences of failure can be particularly unpleasant. Voice of Command allows the thaumaturge to issue orders to a spirit, compelling it to heed her bidding whether or not it desires to do so.
Spirits compelled by this power are fully aware that they are being forced into these actions, and may well seek revenge on their erstwhile masters at a later time. Thaumaturges who issue commands above and beyond what their spirit servants are compelled to perform may find themselves ignored or mocked. A trickster spirit may agree to a situation to follow orders only to betray its master, leaving the thaumaturge in a situation of potentially fatal embarrassment.
System: The thaumaturge makes the normal opposed Willpower roll against the spirit. The target spirit resists with Willpower (difficulty of the thaumaturge’s Manipulation + Occult). The degree of success the thaumaturge attains determines the complexity and severity of the command that she can issue.
Botch — The spirit is immune to the character’s commands for the rest of the night. It reacts however the Storyteller deems appropriate. Typically, the spirit is angry enough to seek revenge at the first opportunity. It may ignore, taunt or even attack the character, at the Storyteller’s discretion.
Failure — The spirit is unaffected, and further attempts to command it are made at +1 difficulty (cumulative).
1 success — The spirit obeys a very simple command that is of no great inconvenience to it.
2 successes — The spirit heeds a relatively straightforward command that it is not innately opposed to performing.
3 successes — The spirit agrees to perform a moderately complex task that does not violate its ethics.
4 successes — The spirit consents to an extended or intricate task that does not place it in immediate danger.
5 successes — The spirit accepts a lengthy or nigh-impossible task, or one that means its destruction.

•••• Entrap Ephemera
This power allows a thaumaturge to bind a spirit into a physical object. This can be done to imprison the target, but is more often performed to create a fetish — an artifact that grants mystical benefits powered by the spirit. Fetishes created by this power are often unreliable and fail at inopportune moments, as the spirits within are understandably displeased with their situation and will take any opportunity to escape or thwart their captors. Lupines find it offensive for vampires to possess a fetish, and often they will frenzy simply at the sight of a vampire wielding one.
System: The thaumaturge must first locate a vessel symbolically aligned with the targeted spirit that will eventually become the fetish. Then she must command the targeted spirit to enter the vessel via an opposed Willpower roll. The target spirit resists with Willpower (difficulty equals the thaumaturge’s Manipulation + Occult).
Should the thaumaturge succeed, she can create a fetish of a power level based on the number of successes achieved over the spirit, up to a level five fetish. For example, if the thaumaturge wins the opposed Willpower roll against the spirit by three successes, she creates a level three fetish.
Creating and maintaining a fetish is difficult; because of this, the number of fetishes a thaumaturge may create is limited by her Willpower. If the thaumaturge gives away said fetish, it still counts against her total available slots. She may only create an additional fetish when one of her previous fetishes has been destroyed.
A fetish grants a number of bonus dice to a specific skill comparable to the level of the fetish. For example, a healing spirit trapped inside a scalpel would grant extra dice (the level of the fetish) for any Medicine roll. The Storyteller always has final authority on what sort of fetish can be made.
A fetish is activated by rolling the user’s Willpower (difficulty equals the fetish’s power level + 3). A botch on this roll destroys the physical component of the fetish and frees the spirit that was trapped within.

••••• Duality
The thaumaturge can now fully interact with the spirit world — a strange place that only sometimes resembles the real world. While using this power, she exists on both planes of existence at once. She is able to pick up objects in the physical world and place them in the spirit world and vice versa. Beings and landscape features in both realms are solid to her, and she can engage in any manner of interaction. She can even use Thaumaturgy and other Disciplines in either world. This is not without its dangers. With a single misstep, the vampire can find himself trapped in the spirit realm with no way to return home. Several incautious thaumaturges have starved into torpor while trapped on the other side of the barrier that separates the physical and spirit realms.
System: The thaumaturge may interact with the spirit world for fifteen minutes. Each additional level of success on the activation roll increases the duration of this power by an additional fifteen minutes. Duality can only be enacted while the character begins the process in the physical world. While in this state, the thaumaturge becomes susceptible to attacks from both realms and suffers from a +1 difficulty to all Perception rolls. The character is still considered to be in the physical world for purposes of basic physics (and common sense).
Spirits who have been previously angered will seek physical revenge on unwary thaumaturges using this power.
A botch on the roll to activate this power tears the vampire out of the physical world and traps him in the spirit realm. The way back the physical realm, if there is one, is left to the Storyteller’s discretion, and may spark an entirely new story.]==],
				},
				["Path of Technomancy"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 224


Path of Technomancy


The newest path to be accepted by the Tremere hierarchy as part of the Clan’s official body of knowledge, the Path of Technomancy is a relatively recent innovation, developed in the latter half of the 20th century. The path focuses on the control of electronic devices, from cellphones to laptops, and its proponents maintain that it is a prime example of the versatility of Thaumaturgy with regards to a changing world. More conservative Tremere, however, state that mixing Tremere magic with mortal science borders on treason or even blasphemy, and some European Regents have gone so far as to declare knowledge of Technomancy grounds for expulsion from their chantries. The Inner Council did approve the introduction of the path into the Clan’s grimoires, but has yet to voice any opinion on the conservative opposition to Technomancy.

• Analyze
Mortals are constantly developing new innovations, and any vampire who would work Technomancy must be able to understand that upon which he practices his magic. The most basic power of this path allows the thaumaturge to project his perceptions into a device, granting him a temporary understanding of its purpose, the principles of its functioning, and its means of operation. This does not grant permanent knowledge, only a momentary flash of insight which fades within minutes.
System: A character must touch the device in order to apply this power. The number of successes rolled determines how well the character understands this particular piece of equipment. One success allows a basic knowledge (on/off and simple functions), while three successes grant competence in operating the device, and five successes show the character the full range of the device’s potential. The knowledge lasts for a number of minutes equal to the character’s Intelligence.
This power can also be used to understand a nonphysical technological innovation — generally a piece of software — at +2 difficulty. The character must touch the computer on which the software is installed — simply holding the flash drive or CD-ROM is not enough. Software applied remotely to a device (such as through an app store) also cannot be analyzed until it is installed.

•• Burnout
It is usually easier to destroy than to create, and sensitive electronics are no exception to this rule. Burnout is used to cause a device’s power supply (either internal or external) to surge, damaging or destroying the target. Burnout cannot be used to directly injure another individual, although the sudden destruction of a pacemaker or a car’s fuel injection control chip can certainly create a health hazard.
System: A character can use this power at a range of up to 10 times her Willpower in yards or meters, although a +1 difficulty is applied if she is not touching the target item. The number of successes determines the extent of the damage:
1 success — Momentary interruption of operation (one turn), but no permanent damage.
2 successes — Significant loss of function; +1 difficulty to use using the device for the rest of the scene.
3 successes — The device breaks and is inoperable until repaired.
4 successes — Even after repairs, the device’s capabilities are diminished (permanent +1 difficulty to use).
5 successes — The equipment is a total write-off; completely unsalvageable.
Large enough systems, such as a server cluster or a passenger aircraft, impose a +2 to +4 difficulty (at Storyteller discretion) to affect with this power. Additionally, some systems, such as military and banking networks, may be protected against power surges and spikes, and thus possess one to five dice (Storyteller discretion again) to roll to resist this power. Each success on this roll (difficulty 6) takes away one success from the Thaumaturgy roll.
Burnout may be used to destroy electronic data storage, in which case three successes destroy all information on the target item, and five erase it beyond any hope of non-magical recovery.

••• Encrypt/Decrypt
Electronic security is a paramount concern of governments and corporations alike. Those thaumaturges who are techno-savvy enough to understand the issues at stake have become quite enamored of this power, which allows them to scramble a device’s controls mystically, making it inaccessible to anyone else. Encrypt/Decrypt also works on electronic media; a DVD under the influence of this power displays just snow and static if played back without the owner’s approval. Some neonates have taken to calling this power “DRM.”
System: The character touches the device or data container that he wishes to encrypt. The player rolls normally. The number of successes scored is applied as a difficulty modifier for anyone who attempts to use the protected equipment or access the scrambled information without the assistance of the character. The caster can dispel the effect at any time by touching the target item and spending a point of Willpower.
This power may also be used to counter another thaumaturge’s use of Encrypt/Decrypt. The player rolls at +1 difficulty; each success negates one of the “owner’s.”
The effects of Encrypt/Decrypt last for a number of weeks equal to the character’s permanent Willpower rating.

•••• Remote Access
With this power, a skilled thaumaturge can bypass the need for physical contact to operate a device. This is not a form of telekinesis; the vampire does not manipulate the item’s controls, but rather touches it directly with the power of his mind.
System: This power may be used on any electronic device within the character’s line of sight. The number of successes rolled is the maximum number of dice from any relevant Ability that the character may use while remotely controlling the device. (For instance, if Fritz has Technology 5 and scores three successes while using Remote Access on a keypad lock, he can only apply three dots of his Technology rating to any rolls that he makes through any use of the power.) Remote Access lasts for a number of turns equal to the number of successes rolled, and can only be used on one item at a time.
If an item is destroyed while under the effects of Remote Access, the character takes five dice of bashing damage due to the shock of having his perceptions rudely shunted back into his own body.

••••• Telecommute
A progressive derivation of Remote Access, Telecommute allows a thaumaturge to project her consciousness into the Internet, sending her mind through network connections as fast as they can transfer her. While immersed in the network, she can use any other Technomancy power on the devices with which she makes contact.
System: The character touches any form of communications device: a cellphone, 3G-equipped netbook, Wi-Fi tablet, or anything else that is connected directly or indirectly to the Internet. The player rolls normally and spends a Willpower point. Telecommute lasts for five minutes per success rolled, and may be extended by 10 minutes with the expenditure of another Willpower point. The number of successes indicates the maximum range that the character can project her consciousness away from her body:
1 success — 25 miles/40 kilometers
2 successes — 250 miles/400 kilometers
3 successes — 1000 miles/1500 kilometers
4 successes — 5000 miles/8000 kilometers
5 successes — Anywhere in the world
While in the network, the character can apply any other Path of Technomancy power to any device or data with which she comes in contact. A loss of connection, either through the destruction of a part of the network or simply a loss of cell signal, hurls her consciousness back to her body and inflicts eight dice of bashing damage.
A character traveling through the Internet by means of this power can use her Path of Technomancy powers at a normal difficulty. Using any other abilities or powers while engaged thus is done at a +2 difficulty.]==],
				},
				["Path of the Father’s Vengeance"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 226


Path of the Father’s Vengeance


This path, based loosely on a powerful thaumaturge’s interpretations of the Book of Nod, devotes itself to delivering justice to the race of Cainites. Each power supposedly has some precedent in the parables of the ancient book, and focuses on teaching the lessons of Caine via the power of blood magic. Use of this path is hotly debated in the Sabbat, as some consider it tantamount to claiming to hold Caine’s right over all vampires oneself. Camarilla vampires don’t have the same knowledge of the Book of Nod that the Sabbat do, but the path is not entirely unheard of in Tremere chantries.
The power of this path comes not only from the magic of blood, but also incantation of verses from the Book of Nod. For any of these powers to take effect, the caster must speak the actual condemnation. For example, to invoke the third-level power, the caster must state plainly to his target that she may eat only ashes. The subject must generally be able to hear the caster for these powers to take effect, though writing them and showing them to the subject will do.
These powers apply to vampires only. They do not affect mortals, ghouls, or any other supernatural creatures.

• Zillah’s Litany
Zillah, the wife of Caine, unknowingly drank from her husband and sire three times, thus becoming bonded to him. This power reveals existing blood bonds and Vinculi to the thaumaturge.
System: If the subject has any blood bonds or Vinculi to other vampires, this power reveals them to the caster. Although the caster may not know the vampires in question, this power does reveal the names and gives rough psychic impressions of the individuals in question.

•• The Crone’s Pride
This power inflicts the curse of the crone, who bound Caine to her as he fled his wife’s spurning. Hideously ugly, the crone had to resort to trickery to get others to help or serve her.
System: This power reduces the target’s Appearance to zero. All Social rolls during this time generally fail, unless the character attempts to intimidate or browbeat the subject. This power lasts for one night.

••• Feast of Ashes
Primarily used against wanton or excessive vampires, this power temporarily removes a vampire’s dependency on blood. While some would say this negates the Curse of Caine, it reduces the vampire to little more than a wretched scavenger, as he must consume literal ashes, though he gains little sustenance from them.
System: The victim of this power can no longer consume blood, vomiting it up as he would mortal food or drink. Instead, the victim can eat only ashes, and the “blood points” he gains from this may be used only to rise each night. Ashen “blood points” may not be used to power Disciplines, raise Attributes, or feed ghouls (though actual blood points in the character’s body at the time this power is invoked may still be used for such). One blood point’s worth of ash is roughly one pint or half-liter, and any ash will do — cigarette ash, campfire leftovers, or vampire corpses destroyed by fire or sunlight. This power lasts for one week.

•••• Uriel’s Disfavor
This power invokes the darkness of the Angel of Death. All but the dimmest of light causes the subject excruciating pain, and some artificial forms of bright light may even damage the vampire. Uriel delivered God’s curse on Caine, shielding him in the blackness of his wings.
System: The presence of any light makes the subject uncomfortable, and bright light of any kind — flashlights, headlights, etc. — inflict one health level of aggravated damage on the character for every turn he remains under its direct focus. Most vampires who suffer this curse elect to sleep for the duration, hiding away in the darkness of their havens until they can walk again among the living without pain. This power lasts for one week.

••••• Valediction
Many Sabbat rightfully fear this power, though very few have ever seen it used. It levies a punishment for breaking one of Caine’s greatest commandments — the ban against diablerie. As most Sabbat attain their power and station through some measure of diablerie, they must reconcile their beliefs with the admonitions of Caine, and this power engenders a great sense of humility.
System: When this power takes effect, the subject immediately reverts to her original Generation. This change may entail losing points in certain Traits due to generational maximums. This power lasts for one week, after which any Traits reduced to higher-Generation maximums return to normal. It takes three turns to speak the full verse that implements this power’s effects.]==],
				},
				["Path of the Focused Mind"] = {
					en = [==[Rites of Blood, p. 139


Path of the Focused Mind


A would-be thaumaturge must possess a strong will and well-developed intellect to master the subtle art of Thaumaturgy. Practitioners of the Focused Mind greatly enhance their mental alacrity and readiness, allowing better comprehension of problems and situations. Thaumaturges, already mentally disciplined, become frightfully powerful in the realm of the cerebral when mastering this Path.
Developed by Melvin Liebknecht, a Tremere Kabbalah scholar, this Path of Thaumaturgy languished in obscurity until discovered in a lost chantry in Berlin after the end of the WWII. Interest in this Path quickly spread through the Pyramid as the adaptable Tremere realized its great potential and benefits. Unlike most Thaumaturgy, the powers of this Path do not require an action to invoke, although they still require the normal blood expenditure and Willpower activation roll. Thaumaturges with this Path may use any single power from this Path during a single turn.

• Readiness
Using Readiness makes the caster able to gain a quicker understanding of a predicament. Enhanced lucidity enlightens the caster, allowing increased cleverness and better reactions to changing situations.
System: This power is only usable on the thaumaturge herself. Every success on the activation roll adds one die to a special dice pool for the remainder of the turn. These dice may be used on any Wits-related rolls or actions that the thaumaturge performs during this turn. Alternatively, each die removed from the dice pool adds one to the caster’s initiative rating.

•• Centering
By invoking this power, the thaumaturge causes a sudden, intense calmness in the subject by whispering soothing words to her. While under this serenity, the target is better able to focus on tasks at hand, ignoring distractions and annoyances, including grave bodily harm. Thaumaturges in fear of frenzy often use this power on themselves to stifle their own emotions and achieve a state of tranquility.
System: This power is usable on any one subject within earshot of the thaumaturge and lasts for one turn per success on the activation roll. During this period, the target is unaffected by any power or effect (with the notable exception of Elder disciplines) that reduces her dice pools. This includes wound penalties, situational modifiers, and Disciplines. Modifications to difficulty numbers still apply during this time, however. In addition, due to the unnatural serenity that this power bestows, the target receives two additional dice in all attempts to avoid or break frenzy.

••• One-Tracked Mind
By extending her powers to other individuals, the thaumaturge is able to fixate the subject on one action. This single-mindedness of the target is so complete that they ignore everything else that occurs around them. Guards are easily distracted with this power, as their attention becomes fixated elsewhere, and research becomes a dedicated, focused task. Use of this power is sometimes colloquially referred to as “railroading someone.”
System: This power may affect anyone who can hear the thaumaturge. Successful invocation makes the target unable to split any dice pools for multiple actions and unable to change tactics after actions have been declared. As a side benefit, the target reduces the difficulty of the declared action by one. Additional actions that the victim takes (from Celerity, for example) during the duration of this power must follow up upon their initial action, as they concentrate wholly upon this one idea. If the target wishes to attempt a different course of action, she must spend a point of Willpower per scene (or per turn in combat). The duration of One-Tracked Mind is one scene, or one turn per success on the activation roll.

•••• Dual Thought
The rigors of learning Thaumaturgy strengthen the mind and the will of a thaumaturge. As a result, those skilled with Thaumaturgy often have the ability to quickly assess a situation and calculate the options available to them. At this level of mastery of the Focused Mind, the thaumaturge is able to divide her attention to two completely separate tasks without penalty or distraction. As One-Tracked Mind forces the subject’s attention into a single objective, Dual Thought expands the thaumaturge’s concentration to the point that focus upon two goals is possible.
System: Successful use of Dual Thought allows the caster to take two actions without penalty during her turn. (Note that this power specifically lifts the restrictions of multiple actions detailed in V20, p. 248.) The extra action granted by this power must be a mental action, whether it’s the use of Disciplines such as the use of Auspex or Thaumaturgy, or the contemplation of some problem. If the character is using both actions to solve a problem, she has two separate dice pools to draw from. These two actions happen at the same time, as determined by the initiative rating of the character. You may not use the extra action to re-cast Dual Thought.

••••• Perfect Clarity
Perfect Clarity brings about a Zen-like moment of focused insight for the thaumaturge as she gains a brief, perfect understanding of herself, the universe, and her place within it. This lucidity protects the thaumaturge from influences both internal and external; even the Beast within is unable to rage forth. Thought and action become one as a complete serenity of the mind descends upon the thaumaturge.
System: Perfect Clarity lasts for the duration of one scene, (or one turn plus an additional turn for every success on the activation roll if used while in combat). For this period, the thaumaturge has the difficulties of all actions reduced by two. The Kindred is immune to frenzy and Rötschreck from all sources, even supernatural triggers. Finally, any means to control or influence the thaumaturge suffer a +2 difficulty, including powers such as Presence, Dominate, and Dementation.]==],
				},
				["Path of the Levinbolt"] = {
					en = [==[Rites of Blood, p. 140


Path of the Levinbolt


Lightning has long been considered the dominion of the gods, but has traditionally been out of reach of thaumaturges due to a lack of understanding of the principles of electricity. As a result, this Path remained relatively obscure until the birth of modern science and the efforts of John Blackwood. The ample supply of electricity in the late 19th century meant that thaumaturges no longer had to wait until a convenient storm to charge their powers, but could gather the required electricity in mere seconds to direct as they chose.
Practitioners of the Path of the Levinbolt tend to cause a good deal of static electricity around them, even when not engaging their powers. Sometimes this plays havoc with cellular service, causes lights to flicker without reason, and computers to experience power surges in their presence.
A number of the powers in this Path are activated by touch. Depending upon the circumstances, the Storyteller may require a successful Dexterity + Brawl roll for the thaumaturge to make contact with the intended victim. Targeting rules (see V20, p. 274) apply for attacking a specific extremity if contact is guaranteed.

• Flicker
Novice thaumaturges learn to freely absorb power around them through electrical outlets, circuits, or batteries. A user of this power can sense the current feeding into a specific electrical system and then draw it to her, effectively turning it off.
System: The thaumaturge simply glances at a target powered by electricity. Upon a successful activation roll, she can shut down an electrical device for ten minutes per success on the activation roll. The spark of electricity arcs from the device directly into the thaumaturge in a frightening display of mystical power. The source of this power is immediately known.

•• Spark
Novice thaumaturges can build up a tiny static charge, enough to make a noticeable snap with a touch. Such a discharge poses little threat to healthy targets, though the energy can ruin delicate electronics or stun an unlucky victim.
System: The thaumaturge simply touches a target (after the requisite blood expenditure and activation roll by the player) and releases the spark. The electricity can snap from any part of the caster’s body, so a thaumaturge might give an unpleasant surprise to someone touching her. The resulting electrical discharge inflicts four dice of lethal damage to targets (difficulty 7 to soak), and short-circuits electronic equipment and devices not specifically grounded against lightning strikes.

••• Illuminate
Neonates sometimes derogatively refer to this effect as the “40-watt Tremere,” right up until they’ve felt its sting. The thaumaturge summons enough electricity to cover her hand or arm in arcing bolts. This power can charge a battery, briefly run a small device, or even leave a nasty burn on a touched subject.
System: Each success scored on the player’s activation roll translates to approximately one turn of power sufficient to run a handful of lights or a small electrical device. Alternately, the thaumaturge can shock someone by touch, as with the Spark power, but for eight dice of lethal electrical damage (difficulty 8 to soak).
The current created with this power is not strong enough to force its way through less-than-ideal conductors, and thus simply inflicts electrical damage on raw metals, woods, or other matter in the form of a burn and discoloration. The thaumaturge can alternately allow the electricity to spark around her hand, eyes, or head; this creates illumination about equal to a dim light bulb, and lowers the difficulty of any Intimidation rolls by 2.

•••• Thor’s Fury
The thaumaturge may strike her enemies from afar as though she were a god. She may direct an arc of lightning from her body to nearby targets.
System: The thaumaturge focuses her concentration upon her target and then directs hurled bolts via a Perception + Science roll (difficulty of 6 plus the range in yards/meters, maximum 4 yards/meters). Each success inflicts a level of lethal damage (difficulty 8 to soak). The source of this power is immediately known.

••••• Eye of the Storm
The thaumaturge becomes a shifting, sparking pillar of electrical power. The energy channeled in the Eye of the Storm shields her body from virtually any direct harm.
System: When a thaumaturge spends a Willpower point to invoke this power, she solidifies the stored electricity inside of her into a mystical barrier that completely surrounds her. The caster becomes immune to any ranged attacks. Metal weapons such as swords inflict injury as normal for the first strike, but are then melted from contact with the barrier, and the wielder takes a level of lethal damage. Enemies that dare to touch the caster suffer two points of aggravated damage (difficulty 8 to soak). Non-metal weapons, such as wooden stakes, are not affected by Eye of the Storm. This power lasts for a single turn, with each additional success on the activation roll extending this duration by one turn. Mental and social attacks may pass through this barrier.]==],
				},
				["Potestas Exsecrabilis"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 300


Potestas Exsecrabilis


When the Tremere were mortal wizards, they considered the common witchcraft of curses and maledictions unworthy of their scholarly attention. Now, however, they have recognized that they need every instrument at their disposal, so they have quickly adapted it for their needs.
The Accursed Power has requirements that other paths do not. First, the thaumaturge must not only be in the presence of the victim of the curse, but must declare it clearly. It need not be in a language that the victim understands, but it must still be forcefully spoken. Second, the thaumaturge requires some part of the victim’s being: hair, blood, a nail clipping, or something similar. Finally, the victim can throw off the effect of the curse by making a Willpower roll (difficulty 7 unless otherwise stated), representing her ability to hold fast against the psychological impact of the power.

• Stigma
In a time when the Tremere struggle for political status, the power to weaken their opponents’ ability to influence social situations can be as important as any display of raw force. This curse lays an aura of wrongness on the victim, causing those around him to shy away instinctively, regard him with suspicion, or simply find his presence intolerable.
System: The thaumaturge spends a blood point and rolls Willpower as usual. If successful, the target suffers a +2 penalty to all Social actions (rolls involving Charisma, Manipulation, or Appearance) to a maximum increased difficulty of 9. The effect lasts until the next sunset or until the caster decides to lift the curse.

•• Malady
Although Cainites are spared most of the diseases that permeate the Dark Medieval World, this curse allows the caster to simulate their effects. The result can be both physically crippling and psychologically damaging, as the vampire victim is suddenly and powerfully reminded of the mortality she left behind.
System: For every success that the thaumaturge rolls, the target’s Strength, Dexterity, and Stamina pools are reduced by one (to a maximum of a three-dice penalty with three successes) for a number of nights equal to the caster’s Willpower. Each night, the victim can make a Willpower roll (difficulty 7) to shake off the effect; each success reduces the penalty to Physical Attributes by one die until the next night. If she removes all penalties in a single night, the curse is broken.

••• Scapegoat
A refinement of the Stigma curse, Scapegoat causes those who see or otherwise interact with the target to perceive him as a bitter rival or hated enemy. Each person’s perceptions are affected differently; the victim becomes whoever that person despises the most. Unlike Mask of a Thousand Faces, the illusion laid by the curse cannot be pierced with Auspex; its method is too new, too unusual, for the common traces to be discernable.
System: For every success that the thaumaturge rolls, the curse lasts for one night. During that time, the victim appears to everyone he encounters as some form of enemy. Although this does not necessarily result in immediate violence, it does tend to prevent the target from interacting in any normal way with those around him.

•••• Corrupt Body
With a malediction against some feature of the target, the thaumaturge invokes this power to cause a painful and specifically directed transformation. It can cause muscles to atrophy, limbs to shiver, faces to warp, or the entire body’s frame to grow frail and emaciated. What makes it most fearsome in the eyes of other Cainites who have witnessed its effects is that it can last far longer than other Tremere curses. A few nights’ suffering under a Malady is nothing compared to the weeks or months of pain that Corrupt Body can cause.
System: Once the thaumaturge lays the curse and rolls for successes, the target can try to resist by rolling Willpower (difficulty 7), with each success reducing the effective strength of the curse by one. After that, however, there is no chance to undo it unless the caster lifts it voluntarily or the duration has elapsed.
The curse only requires one turn to cast, but the transformation takes three turns to complete. For those three turns, the pain of the change reduces the dice pool for any action the target takes by three. Afterward, for the duration of the curse, the victim‘s dice pools for all actions are reduced by one (cumulative with wound penalties). In addition, the target has one attribute of the caster’s choice — Strength, Dexterity, Stamina, or Appearance — reduced to 1. The duration depends on the number of successes rolled:
1 success — One night
2 successes — One week
3 successes — One month
4 successes — One season
5 successes — One year

••••• Acedia
This powerful curse not only lays a shroud of misfortune on the victim, but also instills such a strong sense of self-loathing and defeat that she may withdraw entirely from the world until its effects have passed. Every thought and action becomes a trial, burdened with doubt and the crushing bleakness of the belief that she will fail.
System: The effects of this curse require a Willpower roll (difficulty 8) to resist. If the target botches the roll and the caster achieved at least three successes in casting it, the curse is permanent. Otherwise, the duration is the same as Corrupt Body.
While under the influence of Acedia, the victim cannot succeed at any task automatically, and is treated as having rolled one botch in every action. (In other words, negate one success in every roll, with no successes meaning a botched result.) Even if she succeeds, the maximum effective result she can achieve is two successes, including additional success from Willpower or other sources.]==],
				},
				["Rego Calatio"] = {
					en = [==[Dark Ages Tome of Secrets, p. 111


Rego Calatio


The formation of the Rego Calatio (Rule of Summoning) dates back to an era before records were scribed in ink. The creators of this Path are unknown and unnamed, their researches engraved in stone or daubed in blood on hides and bones. The Path is dedicated to the summoning and binding of demons. In recent centuries, these demons have begun to appear in forms expected and feared by mortals, manifesting as caricatures of greed, lust, sloth, and wrath. In times past, they were as likely to appear as pillars of roiling smoke, the weeping of children, or the stench of rot. The demons contacted by Rego Calatio are not bound to any set form, and may appear however they wish.
Summoners of demons are daring. Demons know that by appearing physically, they are weakened, but can easily dominate and destroy summoners lacking sufficient wherewithal to control them. Many demons are pleased to serve under magical binding, as they’re likely to be asked to perpetrate something they’d do if free anyway; but most demons will resist attempts at control on principle. A demon summoned by Rego Calatio remains on Earth until the sun rises, or it hears church bells.
All targeted Dark Thaumaturgy Path effects may be resisted with a Willpower roll (difficulty 6, plus the infernalist’s Dark Thaumaturgy rating, to a maximum of 9).
Price: The unholy nature of Rego Calatio is such that any area in which it’s practiced becomes spoiled; the people become sick, and the livestock malformed. Use of Rego Calatio produces a necromantic sequela (see p. 52) based on its level.
The practitioner suffers horrific nightmares across a number of nights equal to the successes rolled in summoning. These nightmares force the infernalist to lose two blood points upon waking, instead of the normal one, and a Willpower roll is required (difficulty 7), otherwise two temporary Willpower are also lost. A botch on this roll causes an appropriate Derangement to wrack the infernalist for twice the duration of her summoning-induced nightmares.
System: Each level of this Discipline requires the sacrifice of another being’s life, the majority of demons requiring the death of an innocent in a circle of bloodied bones. If a named demon is being summoned, their name must be painted in the summoner’s vitae on a rock in the center of the circle. The infernalist must expend Willpower points equal to the level of Rego Calatio activated, otherwise the summoned demon is free and will either ignore or attack its summoner. Demons can soak all types of damage with their Stamina, unless that damage is caused by someone with True Faith.
• Petty Demon (Attributes 4/3/2, Abilities 3/2/1, Willpower 3, Health 4)
•• Madness Demon (Attributes 5/4/3, Abilities 4/3/2, Willpower 4, Health 6, Blood Points 5, two points of Disciplines, one of which must be Dementation)
••• Passion Demon (Attributes 6/5/4, Abilities 5/4/3, Willpower 6, Health 7, Blood Points 6, four points of Disciplines, two of which must be Presence)
•••• Murderous Demon (Attributes 7/6/5, Abilities 6/5/4, Willpower 7, Health 8, Blood Points 7, six points of Disciplines, three of which must be Potence)
••••• Named Demon (Attributes 8/7/6, Abilities 7/6/5, Willpower 9, Health 10, Blood Points 10, eight points of Disciplines, allocated wherever the infernalist chooses with a maximum of six points in a single Discipline)
The number of successes rolled determines how much control the infernalist has over his summoned demon:
Failure — The summoning does not occur. It may be retried with a new sacrifice.
1 success — The demon is bound to the circle for a night, and will only listen to the infernalist.
2 successes — The demon is bound to the circle for a night, and will listen to anyone in its proximity, answering simple questions.
3 successes — The demon is bound to remaining within eyeshot of the infernalist for a night. It is well disposed and will answer complicated questions accurately.
4 successes — The demon is bound to remaining within eyeshot of the infernalist for a night. It is forced to serve the infernalist in simple tasks.
5 successes — The demon is able to leave the infernalist’s sight and do his dark bidding. It willingly submits to the infernalist’s decrees for the night’s duration.
6 or more successes — A demon one grade higher than intended is summoned, and treated as if summoned with 4 successes. The maximum grade is the Named Demon.]==],
				},
				["Sepulchre Path"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 160


Sepulchre Path


Through the Sepulchre path, the vampire can witness, summon, and command the spirits of the dead. At higher levels, the necromancer can force the ghost to remain in a particular place or object, or even damage wraiths directly. Since many other areas of Necromancy involve dealing with ghosts, this is the most common path for necromancers to start with.
Note: If a Kindred uses a Sepulchre Path power in the presence of something of great importance to the ghost the power affects, the chances for success in the summoning increase dramatically (reduce the difficulty by 2). This might be the bathtub in which the ghost’s mortal body was drowned, the rusted-out wreck of the car where the ghost’s physical body was trapped alive, or something unrelated to the ghost’s demise, such as a favorite book or a child-ghost’s beloved nursery.

• Witness of Death
Before it is possible to control the dead, one must perceive them. This power allows just that, attuning a vampire’s unliving senses to the presence of the incorporeal. Under its effects, a necromancer sees ghosts as translucent phantoms gliding among the living and hears their whispers and moans. She feels the spectral cold of their touch and smells their musty hint of decay. Yet one cannot mistake the dead for the living, as they lack true substance, and appear dimmer and less real than creatures of flesh and blood. When a vampire uses this power, her eyes flicker with pale blue fire that only the dead can see.
Ghosts resent being spied upon, and more powerful shades may use their own powers to inflict their displeasure on the incautious.
System: The player rolls Perception + Awareness (difficulty 5). Success allows the vampire to perceive ghosts as described for the rest of the scene (in the mortal world — seeing ghosts in the land of the dead requires Shroudsight, on p. 163). Failure has no special effect, but a botch means the vampire can see only the dead for the scene; everything else appears as shapeless, dim shadows. While the vampire’s other senses remain attuned to the living, he is all but blind in this state and suffers a +3 difficulty to most vision-based Perception rolls and attacks. Ghosts notice the glowing eyes of a vampire using this power only with a successful Perception + Alertness roll (difficulty 7).

•• Summon Soul
The power of Summon Soul allows a necromancer to call a ghost back from the Underworld, for conversational purposes only. In order to perform this feat (and indeed, most of the feats in this path), the vampire must meet certain conditions:
• The necromancer must know the name of the wraith in question, though an image of the wraith obtained via Witness of Death (see above), Shroudsight (see p. 163), Auspex, or other supernatural perception will suffice.
• An object with which the wraith had some contact in life must be in the vicinity, though it need not be something of significant importance to the ghost’s living consciousness. A piece of the ghost’s corpse works well for this purpose (and even provides a -1 difficulty modifier).
Certain types of ghosts cannot be summoned with this power. Vampires who achieved Golconda before their Final Deaths, or who were diablerized, are beyond the reach of this summons. Likewise, many ghosts of the dead cannot be called — they are destroyed, unable to return to the mortal plane, or lost in the eternal storm of the Underworld.
System: The player spends one blood point and rolls Manipulation + Occult (difficulty equal to 7 or the ghost’s Willpower, whichever is higher). The vampire must know the name of the ghost and have on hand an object the ghost had contact with in life. Provided that the target has died and become a ghost, success means the shade appears before the necromancer as described above. Not everyone becomes a ghost — it requires a strong will to persevere in the face of death, and souls that have found peace pass on to their eternal rewards. Moreover, it is possible for the dead to suffer spiritual dissolution and destruction after they become ghosts. The Storyteller should consider all these factors when deciding whether a particular ghost exists for a vampire to summon.
Vampires know if their summons should have succeeded by a feeling of sudden, terrifying descent as they reach too far into the great Beyond, so this power can be used to determine whether a soul has endured beyond death. While a failure means the vampire wastes blood, a botch calls a spirit other than the one sought — usually a malevolent ghost known as a Spectre (see p. 385). Such a fiend torments the one who summoned it with every wicked power at its disposal.
Once a ghost is summoned, it may not deliberately move out of sight of the vampire, though it can take any other actions, including direct attack. The vampire’s player may spend a Willpower point to dismiss the ghost at any time (unless he rolled a botch). Otherwise, at the end of the scene, shadows engulf the spirit once more and return it to its original location.

••• Compel Soul
With this power, a vampire can command a ghost to do his bidding for a while. Compulsion of the soul is a perilous undertaking and, when used improperly, can endanger vampire and wraith alike.
System: The vampire locates and approaches the intended ghost or calls it to his presence with Summon Soul. As with the previous power, he must have the ghost’s name and an object it handled in life. His player then spends one blood point and rolls Manipulation + Occult in a resisted roll against the ghost’s Willpower (difficulty 6 for both rolls).
If the vampire wins, the number of net successes determines the degree of control he has over the ghost (as described below). Moreover, the vampire’s control keeps ghosts that have been called with Summon Soul from returning to their original locations at the end of the scene. If the ghost wins, the vampire loses a number of Willpower points equal to the ghost’s net successes. On a tie, the roll becomes an extended contest that continues each turn until one side wins. If the vampire botches at any point, the ghost is immune to any use of the vampire’s Necromancy for the rest of the scene. If the ghost botches, it must obey as if the vampire’s player had rolled five net successes.
1 success — The ghost must perform one simple task for the vampire that does not place it in certain danger. It must attend to this task immediately, although it can delay the compulsion and pursue its own business at a cost of one Willpower point per scene. The ghost may not attack the vampire until this task is complete. It is possible to issue the task of answering one question, in which case the ghost must answer truthfully and to the best of its knowledge.
2 successes — The vampire may issue two orders or ask two questions as outlined for one success. Alternatively, the vampire may demand a simple task with a real possibility of danger, as long as the danger is not certain. The ghost may delay this compulsion with Willpower.
3 successes — The vampire may issue three orders as outlined for one success. Alternatively, he may demand the ghost fulfill one difficult and dangerous task or a simple assignment that has an extended duration of up to one month. The ghost may delay such orders with Willpower.
4 successes — The vampire may issue four orders, as outlined for one success, or assign two tasks, as for two successes. Alternatively, the vampire may command the ghost to perform one complex assignment that puts the ghost at extreme risk, or perform any number of non-threatening tasks as the vampire’s slave for up to one month (or, if the necromancer spends a permanent point of Willpower, for a year and a day). It is possible for ghosts to delay individual tasks, but not put off enslavement.
5 or more successes — The vampire may issue multiple orders that have a sum complexity or danger of five successes’ worth. Instead, the vampire may order the ghost to perform any one action that it is capable of executing within one month. Such a task can place the ghost in immediate peril of destruction, or even force it to betray and assault loved ones. It is not possible for ghosts to delay a task of this magnitude with Willpower — they must obey.

•••• Haunting
Haunting binds a summoned ghost to a particular location or, in extreme cases, an object. The wraith cannot leave the area to which the necromancer binds it without risking destruction.
System: The player spends one blood point while standing at the location for the haunting or touching the intended prison. She then has the ghost brought to her by whatever means she desires, though Summon Soul is quickest and most reliable. Her player then rolls Manipulation + Occult (difficulty is equal to the target’s current Willpower points if resisted, to a minimum of 4; otherwise it is 4). The difficulty rises by one if the vampire wishes to place the ghost in an object. As usual, the difficulty decreases by one if the necromancer has a part of the spirit’s corpse in addition to knowing its name (minimum difficulty 3).
Each success binds the ghost within the location or object for one night. This duration extends to one week if the player spends a Willpower point or a year and a day for a dot of permanent Willpower. A wraith attempting to leave the area of a haunting must make an extended Willpower roll (difficulty 9, four cumulative successes necessary in a single scene) or take a level of aggravated damage for each roll. If the wraith runs out of health levels, it is hurled deep into the Underworld to face destruction.

••••• Torment
It is through the use of this power that powerful necromancers convince bound ghosts to behave — or else. Torment allows the vampire to strike a wraith as if he himself were in the lands of the dead, inflicting damage on the wraith’s ectoplasmic form. The vampire remains in the real world, however, so he cannot be struck in return.
System: The player rolls Stamina + Empathy (difficulty equal to the wraith’s current Willpower points), and the vampire reaches out to strike the wraith. Each success inflicts a level of lethal damage on the wraith. Should the wraith lose all health levels, it immediately vanishes into what appears to be a doorway to some hideous nightmare realm. Ghosts “destroyed” thus cannot reappear in or near the real world for a month.]==],
				},
				["The Bialowieza Kraina"] = {
					en = [==[Dark Ages Tome of Secrets, p. 46


The Bialowieza Kraina


Koldun of the Białowieza Forest comprise Polish and Rus Tzimisce, but all nominally fall within the Voivodate. It is a primeval forest of immense size, impassable to all but the most determined travelers; the Sixth Generation koldun Djabelek maintained a solitary domain within, housed in a fabled white tower. His recent disappearance led to the release of several childer into the wild, including the less outwardly antagonistic Grondrska. She invites rivals to face her, along with students who would learn at her feet.

• Domain Breach
The koldun is so in tune with his domain that he is able to detect when an intruder makes her way within its borders. This Discipline isn’t so focused as to identify and spotlight the location of the intruder, instead providing adequate forewarning in advance of a surprise. A common tactic upon sensing a visitor is to follow up by sending animal spies.
System: The koldun expends at least one point of blood within the area he wishes to affect with this Discipline, and the player rolls to activate this power (Attribute: Perception). One square kilometer (2/3 of a mile) surrounding the koldun is affected for each blood point spent. For the remainder of the night, the koldun senses if any visitors enter or exit the determined area.
If this power is activated within the Białowieza Forest, no initial expenditure of blood is required. This power cannot be used in a predominantly urban environment.

•• Fingers of Bialowieza
The koldun with this power commands nearby plants and trees to ensnare, and potentially immobilize, their victims. This Discipline affects plants of all size, compelling thin roots through to old, twisted branches. Koldun often use Fingers of Białowieza on plants surrounding paths leading to their havens.
System: The koldun expends blood, ensuring it touches the plant she wishes to affect, and rolls to activate this power (Attribute: Dexterity). The plant will attempt to ensnare anyone passing within two meters (2 yards) of its reach, remaining ready to grapple in this way for one night per blood point spent. For the purposes of grappling, the plant rolls six dice. It inflicts one level of bashing damage for each turn subsequent to a successful grapple. The plant gains an additional die to grappling with each subsequent turn, to a maximum of ten dice. Small plants possess two health levels for the purposes of destruction, with tree limbs holding up to six, depending on size. They hold one dot of Stamina for each health level, and can soak bashing damage.
If this power is activated within the Białowieza Forest, the plants’ bashing damage and their health levels are doubled from their initial numbers, with Stamina increasing as a byproduct of the increase in health.

••• Grondrska’s Impasse
The tale tells of a poacher who trespassed into Tzimisce lands. It wasn’t long before he was fleeing in a dread panic. He thought he knew the forest, but the trees were moving around him, cutting off his exit, herding him directly to the hungry Cainite waiting within. Grondrska’s Impasse makes this terrible legend a reality.
System: The koldun expends at least one point of blood within the area she wishes to affect, and the player rolls to activate this power (Attribute: Perception). One square kilometer (2/3 of a mile) surrounding the koldun is affected for each blood point spent. For the remainder of the night, any visitors sensed using Domain Breach suffer an increased difficulty of three on attempts to track, escape, and navigate within the area, as the undergrowth shifts and looms around the intruder. If the visitor fails his roll, the koldun can choose whether to move him closer, farther away, or in the direction of a well-placed trap.
If this power is activated within the Białowieza Forest, the undergrowth saps two dots from the visitor’s Perception, returned if he leaves the area. The koldun can choose to have this not affect certain visitors who triggered the power of Domain Breach.

•••• The Mouth of Djabelek
Djabelek is a terrifying Tzimisce buried somewhere within the Białowieza Forest. It is said that somehow he continues to feed despite his torpid state, opening his mouth while dreaming, consuming whatever falls in. This power often results in swift death for intruding mortals, as the earth opens around them. Koldun are known to make use of The Mouth of Djabelek near their havens as a security measure, and in the heat of battle to catch an opponent unawares. A tongue of cold mud drags the intruder down into the earth, with grinding rocks and crushing earth pulverizing the victim.
System: The koldun spills at least one point of blood within the earthen area she wishes to affect, and spends a point of Willpower along with making the roll to activate this power (Attribute: Strength). Should any being step within ten meters (11 yards) of where the power was activated, a pit two meters (2 yards) in diameter and three meters (3 yards) deep opens. Each blood point spent leaves the victim trapped and immobile for a turn. To break free requires a successful Strength-based roll on the part of the victim (difficulty 8) and requires five successes on an extended test. Beings trapped in the pit suffer two levels of lethal damage each turn, which can be soaked (difficulty 7).
If this power is activated within the Białowieza Forest, the duration of this power is doubled. The koldun can choose to have this not affect certain visitors.

••••• The White Tower
The Białowieza takes its name from Djabelek’s notorious tower built of his victims’ bleached white bones, stacked high to make a particularly foreboding haven. The tower has long been absent from the forest, but occasional tales of its reconstruction emerge from the wilderness — and not always in the Białowieza Forest.
The White Tower is the gift provided by the demons of the earth with whom Djabelek once made his pact. The bones of all the victims of the Białowieza kraina force their way from the earth and cocoon the koldun summoning them in a tower of earth and bone at least five meters (5 1/2 yards) tall. The koldun can remain inside the haven for as long as her blood will hold out, or fold back into the earth with the tower and reemerge elsewhere, away from danger.
System: The koldun scatters one point of blood on the soil; the player spends a point of Willpower and makes the roll to activate this power (Attribute: Stamina). The White Tower takes effect immediately, the earth shifting, jagged bones and blocks of earth forming an apparently organic circular wall to surround the koldun, at five meters (5 1/2 yards) tall. For each success on activation, another floor five meters high is constructed above the initial one, one floor a turn. The White Tower stretches beneath the earth as far as it stretches above it, and bears no entrance or exit, unless the koldun wills one. Any possessions left within the last time the Discipline was activated remain in the tower. The White Tower is highly resistant to external forces, possessing 20 levels of health and an invulnerability to all but aggravated damage.
The White Tower can fold back into the earth with the koldun in tow, at the expenditure of a further blood point and single point of Willpower. At this point, the vampire is effectively entombed five meters (5 1/2 yards) beneath the earth at the location where the White Tower stood.
For the cost of an additional blood point and point of Willpower, along with the roll for activating the power (Attribute: Stamina), the White Tower emerges anywhere within 20 kilometers (12 1/2 miles) of the previous location, providing the area is forested. The size of this new White Tower is established in the same manner as the initial roll.
The White Tower does not deconstruct if the koldun wills an exit to appear and departs the building. If any Cainite falls to torpor inside the White Tower, or mortal falls asleep within, it consumes them and adds the vampire’s bones to the others lining the walls and floors.
If this power is activated within the Białowieza Forest, it possesses double the levels of health.]==],
				},
				["The Black Sea Kraina"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 277


The Black Sea Kraina


Koldun of the Black Sea region practice these rites.

• Danubian Voices
Originating in the Black Forest and passing through a dozen nations en route to emptying into the Black Sea, the mighty Danube has been the sustaining artery of countless empires for as long as people have dwelt upon its banks. And through all of them, the Tzimisce kept watch. The koldun know its true value, for the spirits of the river speak to them, passing on what they know or carrying messages for them in exchange for a taste of the vampiric sorcerers’ vitae.
System: The koldun drips the requisite blood into a river, stream, or other flowing waterway. Even the runoff from thawing snow or a heavy rain is enough to make use of this power. If it is the Danube itself, or one of its tributaries, no initial expenditure of blood is necessary at all. They then make the activation roll (Attribute: Charisma); if they succeed, a spirit of the water appears to them and will serve them (such as they can) for a number of days equal to successes rolled. This duration may be extended any time before it expires by splashing the water with more blood; one blood point extends the spirit’s thralldom by an additional day.
What the spirit can do is quite limited; they can converse with the koldun, sharing whatever they know, or they can give it a message to carry to someone or someplace else. The spirit will be more than happy to talk of what it knows; river spirits can be quite garrulous and the Tzimisce is advised to help lead the spirit to the topics they’re most interested in lest they be regaled for hours with prosaic descriptions of surrounding countryside. The spirit is only capable of moving up and down their waterway (and upstream is much slower than down), so the recipient of the message must be someone it can encounter in its journey. Another method involves instructing the spirit to go to a place along its path and delivering the message to the first person it meets, though this obviously has its drawbacks as well. A koldun may also beseech a water spirit to remain in one place and watch for trespassers or other threats, then to move quickly along the riverbed to warn her of danger should any present itself.

•• Grave of the Marea Neagra
The Scythians of old had their own name for the great sea around which they dwelt: axšaina, which translates to “unlit” to our ears. Their description is apt; sunlight fails to penetrate much beyond the surface and in the deepest portions, even air ceases to exist. It is, in many ways, the perfect sanctuary for a corpse, as attested to by the many ships and their crews preserved for eternity along its bottom, many of them put there by koldun who dwell beneath the waves.
System: The koldun may always descend safely into the lowest depths of the Black Sea, where she may rest comfortably, protected from the sun and the outside world. By splashing her blood into a body of water large enough to contain her mass and making her activation roll (Attribute: Wits), she imbues that water with all the protective properties of the Black Sea. She cannot be harmed by sunlight, her body is perfectly preserved for as long as she remains interred within, and she becomes extremely difficult to detect. To spot the koldun, a character must roll Perception + Alertness (difficulty 8) and achieve more successes than the koldun rolled on her activation roll. Those who engage the submerged Tzimisce take two levels of lethal damage each turn they remain in the freezing cold water.

••• Pontos Euxeinos
The Greeks once called the Black Sea Pontos Euxeinos, the Hospitable Sea. For the koldun of the Black Sea kraina, it truly can be, holding them in its embrace and healing them of even their worst injuries.
System: The koldun must have access to a large enough body of water to submerge herself in. Once submerged in the comforting water, she releases the requisite blood into it (though if it is actually the Black Sea, no blood point expenditure is necessary), then make her activation roll (Attribute: Stamina). Each success may be allocated to healing just as if it were a blood point (one success heals one level of bashing or lethal damage, while five successes will heal a level of aggravated damage). This does not reduce the limitation of time upon healing; to heal aggravated damage, the koldun must remain submerged and at rest for a day per level healed.

•••• Minions of Deep Marmora
Legend says that the koldun Cyzicus, who ruled openly as king of the Dollonians in days of antiquity, discovered if he spilled his blood into the Sea of Marmora, strange beasts from its depths would emerge to do his bidding. Other koldun have found that any body of water serves the same, although the creatures that dwell in the deeps of Marmora are the strongest.
System: The koldun splashes his blood upon the surface of the water — at least one blood point, but as many as he chooses to spend — then makes the activation roll (Attribute: Manipulation). For each success, up to the total number of blood points spent, one minion emerges from the water. The Minions of Deep Marmora are strange humanoid creatures, combining the features of frog and fish. They will perform one task for the koldun, after which they are free to return to their watery abodes. Each minion may be given a different task to perform. Minions use the following stats (stats in parentheses are for those minions summoned from the Black Sea itself):
Attributes: Strength 4 (5), Dexterity 3, Stamina 4 (5), Charisma 1, Manipulation 1, Appearance 0, Perception 3, Intelligence 1 (2), Wits 2 (3)
Willpower: 3
Health Levels: Ok, Ok, -1, -1, (-1), -2, -2, -2, -5, (-5), Incapacitated
Abilities: Athletics 2, Brawl 4, Intimidation 3, Survival 3
Attack: Claws (Strength + 2, lethal), Grapple (Strength + 4, bashing), scales and blubbery flesh gives +2 dice to soak rolls.
Abilities: Minions of Marmora can breathe air or water equally well. They’re accomplished swimmers, moving as easily in water as out.

••••• Pontos Axeinos
Before the Greeks settled its southern shoreline, they called the Black Sea Pontos Axeinos, the Inhospitable Sea. For the enemies of the koldun, it can be very inhospitable, birthing storms, whirlpools, fog, and rocky barricades where there were none moments before.
System: The koldun drips his blood into a body of water (unless it is the Black Sea, in which case no blood need be expended) and makes the activation roll (Attribute: Intelligence). She may allocate their successes to manifest any number of dangerous waterborne hazards for her opponents to deal with; some examples of what each success can accomplish: a whirlpool or undertow with a Strength rating equal to the koldun’s Strength that may seize or drag others, increase the current’s Strength multiplier by one, reveal jagged rocks that do Strength + 3 lethal damage when smashed upon, fog that increases all sight-based Perception difficulties by 2, driving winds and rain with gales up to 50 miles per hour/75 km per hour, a precipitous drop in water temperature to near freezing levels, and so on. This power lasts a scene, and then dissipates.]==],
				},
				["The Blessings of the Great Dark Mother"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 86


The Blessings of the Great Dark Mother


A thaumaturgic path of relatively recent development, the Blessings of the Great Dark Mother draws directly upon the nature of her spirit-beast servants — Cat, Owl, Serpent, and Dragon among them — to assist the ashipu in their struggles against the infernal. Despite the sobriquet “Mother of Demons,” Lilith’s children are almost never either denizens of Hell or cast-off remnants of the Outer Dark, but the offspring of her many unions with strange and wonderful beings. Partaking of Lilith’s essence and that of her mates, these unions produce entities that are unique admixtures of spiritual and physical, whose mutability of substance renders them vulnerable to abuse by the ignorant and the unscrupulous. The techniques used by the sorcerers of the First Tribe to subtly alter the true Names of the Children of the Outer Dark, the ritually enforced expectations of mortal demonologists, and the potent true magic of the Awakened can all force the Lilin into demoniacal form. The arts of this path can liberate them from this bondage and distort, disrupt, and defile the unholy pacts and bonds between an infernalist and their genuinely diabolical masters and minions.

• Cradlesong
The ashipu utters an incantation that reveals to her the nature of any pacts, bonds, or spiritual ties to other beings within audible range of her voice. These bonds appear differently to each ashipu who employs the cradlesong, depending strongly on her preferred sensory stimulus. Some see the bonds as threads of light wrapped around others, pulsing with colors that define their nature; others hear them as a rich and complex song whose internal melodies, harmonies, tempo, and beat contain the information they require. Most properly sung, the incantation can also be simply spoken, whistled using the appropriate notes, or played wordlessly on a musical instrument as a tone poem; electronic amplification can and does increase its effective range.
System: The ashipu sings her cradlesong, spends one blood point, and rolls Perception + Occult (difficulty equal to the highest current Willpower rating of the individuals in the group, or the current Willpower rating of the individual if attempting to affect a singular target). If successful, the song causes any and all infernal pacts, spiritual pacts, and voluntary or involuntary bonds of any kind (including the blood bond) to become “visible” in some way to the caster.

•• Kessep
The firstborn son of Lilith and Lucifer was named “Silver” for the light of the Moon, a hue reflected in the bright silver scales of the serpent that serves the Great Dark Mother. The serpent sometimes functions as one of her many forms, symbolic of purity and purification. The ashipu who calls upon the argent serpent sings, speaks, or plays an invocation that allows her to select one infernal or spiritual bond and purify the owner of it — severing the ties of bound spirits or demons. This invocation cannot sever the blood bond (no matter how involuntarily it might have been entered into), nor can it undo an infernal pact.
System: The ashipu invokes the gift of the argent serpent, spending one blood point and rolling Manipulation + Occult, with a difficulty equal to the target’s current Willpower. If successful, the invocation causes a single selected bond between the target and an enthralled spirit or bound demon to be broken. This, of course, frees the previously bound spirit or demon to flee, take vengeance, or visit whatever consequences of bondage they prefer upon their former owner.

••• Sotheq
The second-born son of Lilith and Lucifer was named “Silence,” for the peace and stillness of D’hainu, the Great Dark Mother’s garden of renewal, and is also an attribute of the watchful, night-hunting owl that both serves and embodies her. The ashipu who calls upon the owl with wings of twilight sings, speaks, or plays an invocation that allows her to silence all of the infernal or spiritual ties of her target, pacts and bonds alike.
System: The ashipu invokes the gift of the twilight owl, spending one blood point and rolling Manipulation + Occult, with a difficulty equal to the target’s current Willpower. If successful, the invocation causes a psychic or spiritual silence to fall across all bonds and pacts in which the target is involved — he can no longer issue commands to his bound spirits or servitor demons, nor can he receive communication or commands from any spirit or demon that holds him in thrall. Exceptional success (four successes or more) extends this effect to the Cainite at the other end of any blood bond in which the target is engaged.

•••• Allah
The youngest daughter of Lilith and Lucifer was named “Night,” for the realm that would have been hers had she lived to maturity. Such darkness is also an attribute of the soft-pawed, sharp-clawed cat that warded the borders of D’hainu and protected those who dwelt within the Garden of Renewal. The ashipu who calls upon the cat with the pelt of shadow sings, speaks, or plays an invocation that allows her to directly assault all of the lesser infernal or spiritual ties of their target, parting the bonds as with a swipe of deadly claws and disarming the target of their spiritual weapons.
System: The ashipu invokes the gift of the night-shadow cat, spending one blood point and rolling Manipulation + Occult, with a difficulty equal to the target’s current Willpower, for each spirit or demon that the target holds enthralled as a servitor. Success frees the bound spirit or demon to do as it wills. Failure not only fails to free the spirit or demon, but also allows those entities to know precisely who attempted to sever those ties.

••••• Memo
The firstborn and eldest child of Lilith and Lucifer was their daughter, named “Water” after her mother’s fond memory of both the crystal streams of lost Eden and the vast oceanic depths in which she took shelter after her expulsion. In the oceans, she bore the first of her many broods and emerged from her exile more powerful than before. Mighty and deep are the powers of that great primordial realm, and mighty was the form that the Great Dark Mother took there. She lent the secrets and gifts of that form to her first child and eldest daughter, the dragon whose wings blotted out and the moon and the sun and the stars, and whose scales shone with all the hues of the sea, greatest of all the purifiers. The ashipu who calls upon the dragon who weeps tears of salt sings, speaks, or plays an invocation that allows her to directly attack the principal infernal or spiritual pact of her target.
System: The ashipu invokes the gift of the great serpent of the ocean, spending one blood point and rolling Perception + Occult, with a difficulty equal to the current Willpower of the target. By so doing, she gains the knowledge of what impelled the target to enter into a bargain in which his soul would be forfeit. Each success rolled yields more detailed knowledge of her target, the nature and strengths of the pact, and any infernal investments or gifts that the target possesses. Spectacular success yields the True Name of the target’s demonic patron and the opportunity to directly engage it in a contested Manipulation + Occult (difficulty equal to it’s permanent Willpower) roll. Success on the part of the ashipu severs the bond between the infernalist and their patron; success on the part of the patron allows the bond to remain intact. Failure of any roll in this sequence allows the infernality’s patron to perceive the ashipu and derive substantial information about her through the contact.]==],
				},
				["The Covenant of Enki"] = {
					en = [==[Rites of Blood, p. 160


The Covenant of Enki


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Covenant of Enki is one of those paths: it is functionally identical to Neptune’s Might (V20, pp. 218-220).]==],
				},
				["The Fires of the Inferno"] = {
					en = [==[Rites of Blood, p. 167


The Fires of the Inferno


Practitioners of the Fires of the Inferno may summon forth balefire that springs forth from her hands in jets or globes. Many believe that this malignant green flame is conjured from the very depths of Hades. Being burned by these fires is to taste the agonies that await them in Hell. Witnessing the conjuring of the Fires of Inferno allows anyone with mystical senses to know the source is infernal. Balefire is greatly feared, as fire is one of the surest ways to bring Final Death to a vampire.
System: The number of successes determines how accurately the vampire places the flame in his desired location (declared before the roll is made). Individual descriptions are not provided for each level of this path — fire is fire, after all (and can potentially cause frenzy in other vampires witnessing it). The chart below describes the path level required to generate a specific amount of flame. To soak the damage at all, a vampire must have the Fortitude Discipline.
Fire under the caster’s control does not harm the vampire or cause him to frenzy, but fires started as a result of the unnatural flame affect the thaumaturge normally.
• Lighter (difficulty 3 to soak, one health level of damage/turn)
•• Stovetop (difficulty 4 to soak, two health levels of damage/turn)
••• Blowtorch (difficulty 5 to soak, three health levels of damage/turn)
•••• Flame-thrower (difficulty 7 to soak, four health levels of damage/turn)
••••• Conflagration (difficulty 9 to soak, five health levels of damage/turn)]==],
				},
				["The Flow of Ashe"] = {
					en = [==[Rites of Blood, p. 165


The Flow of Ashe


The Flow of Ashe (Wanga Path) is unusual even among sorcery Paths in that it does not cost blood to use. Indeed, its purpose is to prevent the wangateur from requiring the use of vitae in other contexts. Derived from Yoruban herbalism, the Flow of Ashe may more accurately be described as a series of rituals which must be learned sequentially. Each ritual produces an herbal mixture which, if used properly, can take the place of blood under different circumstances. The Willpower roll is made when the blood point would normally be spent. If it fails, the vampire loses two points of blood instead of the one he would have spent had he skipped the ritual altogether. Normally, the ingredients must be mixed and then the mixture used on the next turn, but Gift of Ashe overcomes that limitation. More importantly, if circumstances allow for it, many of these mixtures may even be used on others besides the wangateur.

• Touch of Life
The wangateur may ingest a special mixture of herbs and powders in lieu of expending blood when trying to imitate the characteristics of the living. The effect lasts for one scene. The wangateur may ingest this mixture for himself or provide it to another Kindred (but not a mortal) who must swallow the mixture during that scene. In the latter case, the wangateur decides which aspect of the living the other Kindred will imitated.

•• Strength of Root and Stone
The wangateur may inhale a mixture of herbs and powders through the nose instead of expending blood when trying to augment a Physical Attribute. The effect is the same as if the vampire had spent one point of blood to improve a Physical Attribute. The effect lasts for one scene. The wangateur may use this mixture himself or provide it for another (including a mortal). If it is to be used by another, the wangateur decides which Attribute is to be augmented when the mixture is prepared.

••• Breath of Life
The wangateur may use a mixture of herbs and powders in place of blood when trying to heal herself. The specific mixture produces a paste which the wangateur must physically smear on the area to be healed. The effect is the same as if the vampire had spent one point of blood to repair physical damage. This power cannot be used to heal aggravated damage, only bashing or lethal. The wangateur may use this mixture for himself or for another (including a mortal).

•••• Favor of the Orishas
The wangateur may use a mixture of herbs and powders in order to fuel any Discipline (including blood magic) that requires exactly one point of blood to function. This formula also requires a small quantity of blood to function, but it need not come from the wangateur and, in fact, can come from an enemy (human or Kindred) who has shed blood nearby. The wangateur may only use this mixture on herself and must make a superficial cut on her arm and then rub the mixture into the open wound.

••••• Gift of Ashe
The wangateur may now create mixtures using the first three levels of this path which will maintain their efficacy for an entire night rather than just one turn or scene. Furthermore, the wangateur can maintain a number of mixtures up to his Intelligence simultaneously. Thus, he can provide the mixtures to allies and no longer needs to be nearby in order to provide the appropriate benefits — he can simply give the mixture to an ally and send her on her way.]==],
				},
				["The Green Path"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 215


The Green Path


The Green Path deals with the manipulation of plant matter of all sorts. Anything more complex than an algae bloom can theoretically be controlled through the appropriate application of this path. Ferns, roses, dandelions, and even ancient redwoods are all valid targets for this path’s powers, and living and dead plant matter are equally affected. While not as immediately impressive as some other more widely practiced paths, the Green Path (sometimes disparagingly referred to as “Botanical Mastery”) is as subtle and powerful as the natural world which it affects.

• Herbal Wisdom
With a touch, a vampire can commune with the spirit of a plant. Conversations held in this manner are often cryptic but rewarding — the wisdom and experience of the spirits of some trees surpasses that of the oracles of legend. Crabgrass, on the other hand, rarely has much insight to offer, but might reveal the appearance of the last person who trod upon it.
System: The number of successes rolled determines the amount of information that can be gained from the contact. Depending on the precise information that the vampire seeks, the Storyteller might require the player to roll Intelligence + Occult in order to interpret the results of the communication.
1 success — Fleeting cryptic impressions
2 successes — One or two clear images
3 successes — A concise answer to a simple query
4 successes — A detailed response to one or more complex questions
5 successes — The sum total of the plant-spirit’s knowledge on a given subject

•• Speed the Season’s Passing
This power allows a thaumaturge to accelerate a plant’s growth, causing roses to bloom in a matter of minutes or trees to shoot up from saplings overnight. Alternately, she can speed a plant’s death and decay, withering grass and crumbling wooden stakes with but a touch.
System: The character touches the target plant. The player rolls normally, and the number of successes determines the amount of growth or decay. One success gives the plant a brief growth spurt or simulates the effects of harsh weather, while three noticeably enlarge or wither it. With five successes, a full-grown plant springs from a seed or crumbles to dust in a few minutes, and a tree sprouts fruit or begins decaying almost instantaneously. If this power is used in combat, three successes are needed to render a wooden weapon completely useless. Two successes suffice to weaken it, while five cause it to disintegrate in the wielder’s hand.

••• Dance of Vines
The thaumaturge can animate a mass of vegetation up to his own size, using it for utilitarian or combat purposes with equal ease. Leaves can walk along a desktop, ivy can act as a scribe, and jungle creepers can strangle opponents. Intruders should beware of Tremere workshops that harbor potted rowan saplings.
System: Any total amount of vegetation with a mass less than or equal to the character’s own may be animated through this power. The plants stay active for one turn per success scored on the roll, and are under the complete control of the character. If used for combat purposes, the plants have Strength and Dexterity ratings each equal to half the character’s Willpower (rounded down) and Brawl ratings one lower than that of the character.
Dance of Vines cannot make plants uproot themselves and go stomping about. Even the most energetic vegetation is incapable of pulling out of the soil and walking under the effect of this power. However, 200 pounds (100 kilograms) of kudzu can cover a considerable area all by itself….

•••• Verdant Haven
This power weaves a temporary shelter out of a sufficient amount of plant matter. In addition to providing physical protection from the elements (and even sunlight), the Verdant Haven also establishes a mystical barrier which is nearly impassable to anyone the caster wishes to exclude. A Verdant Haven appears as a six-foot-tall (two-meter-tall) hemisphere of interlocked branches, leaves, and vines with no discernible opening, and even to the casual observer it appears to be an unnatural construction. Verdant Havens are rumored to have supernatural healing properties, hut no Kindred have reported experiencing such benefits from a stay in one.
System: A character must be standing in a heavily vegetated area to use this power. The Verdant Haven springs up around the character over the course of three turns. Once the haven is established, anyone wishing to enter the haven without the caster’s permission must achieve more than the caster’s original number of successes on a single roll of Wits + Survival (difficulty equal to the caster’s Willpower). The haven lasts until the next sunset, or until the caster dispels or leaves it. If the caster scored four or more successes, the haven is impenetrable to sunlight unless physically breached.

••••• Awaken the Forest Giants
Entire trees can be animated by a master of the Green Path. Ancient oaks can be temporarily given the gift of movement, pulling their roots from the soil and shaking the ground with their steps. While not as versatile as elementals or other summoned spirits, trees brought to ponderous life via this power display awesome strength and resilience.
System: The character touches the tree to be animated. The player spends a blood point and rolls normally. If the roll succeeds, the player must spend a blood point for every success. The tree stays animated for one turn per success rolled; once this time expires, the tree puts its roots down wherever it stands and cannot be animated again until the next night. While animated, the tree follows the character’s verbal commands to the best of its ability. An animated tree has Strength and Stamina equal to the caster’s Thaumaturgy rating, Dexterity 2, and a Brawl rating equal to the caster’s own. It is immune to bashing damage, and all lethal damage dice pools are halved due to its size.
Once the animating energy leaves a tree, it puts down roots immediately, regardless of what it is currently standing on. A tree re-establishing itself in the soil can punch through concrete and asphalt to find nourishing dirt and water underneath, meaning that it is entirely possible for a sycamore to root itself in the middle of a road without any warning.]==],
				},
				["The Hand of the Magi"] = {
					en = [==[Rites of Blood, p. 160


The Hand of the Magi


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Hand of the Magi is one of those paths: it is functionally identical to The Lure of Flames (V20, p. 218).]==],
				},
				["The Hunter’s Winds"] = {
					en = [==[Rites of Blood, p. 159


The Hunter’s Winds


This path was originally developed by Assamite sorcerers and is rarely encountered outside of that Clan, but knowledge of it has passed into the larger pool of Dur-An-Ki lore. The Path is designed to augment a vampire’s natural stealth and skill with Obfuscate. While many aspects of this Path seem redundant given the existence of Obfuscate, the Path offers a powerful advantage over that Discipline — for example, Auspex does not automatically pierce the veil provided by The Hunter’s Winds. While Auspex may add to the observer’s Perception-based rolls as the Storyteller sees fit, the observer does not automatically see through deceptions just because his Auspex exceeds the ashipu’s Path rating, as is the case with Obfuscate or Chimerstry.

• Scent of Deception
The target of this power gains the ability to alter her scent or eliminate it completely.
System: A successful roll means that the target either leaves no scent that can be detected or tracked, or she leaves the scent of someone else known to her. A failure means nothing happens. A botch means that her scent is more easily identifiable to others (in addition to the other penalties for botching a blood magic roll).

•• Chameleon’s Skin
The target’s skin and clothing automatically assume the coloring and texture of whatever he stands near.
System: For the duration of the scene following the activation scene, the difficulty of all Perception rolls to detect the target increase by +4 so long as he remains stationary. While he is in motion, the effect is negated, but once he comes to rest again against a different surface, he can reassert the camouflage with a successful Perception + Stealth roll (difficulty 6, or 9 if someone is actively searching for him at the time). Any texture changes are illusory; the target does not gain the durability of a brick wall just by standing near it.

••• Unassuming Pose
The target effortlessly blends into any crowd of people. Everyone present will assume the target belongs there, including any pursuers.
System: If the roll succeeds, any observer will automatically assume that the target belongs in whatever location he is found. Those searching for him are incapable of perceiving that he is an intruder. However, this effect cannot fool technology, and anyone observing through CCTV, for example, can spot him as an interloper.

•••• Whiff of Kalif
The target of this effect generates an aura which is physically intoxicating to anyone who directly observes her. Those affected may experience a pleasant daydream, or may just be left standing slack-jawed as the target goes on his way.
System: If the effect is successfully activated, anyone who observes the target during the rest of the scene must reflexively roll Wits + Alertness (difficulty 7) or become intoxicated for a number of hours equal to the ashipu’s successes in triggering the effect. Affected individuals are incapable of taking any action beyond staring vacantly at visions only they can see or perhaps giggling from time to time. However, any direct threat to an affected individual immediately causes the intoxication to fade.

••••• Ghost Body
As a particularly powerful effect, Ghost Body requires the ashipu to expend three points of blood instead of the normal one. When the effect is activated, the target becomes completely invisible, inaudible, and intangible, and she can move freely through any barriers other than wards against vampires.
System: If activated successfully, the target becomes immaterial in nearly every sense. The effect does not make her into a true ghost, and she is incapable of interacting with wraiths or spirits while in this form. She is also incapable of using any Disciplines while in this form. The effect ends as soon as the target makes the conscious decision to affect the physical world in any way.]==],
				},
				["The Keeper’s Way"] = {
					en = [==[Dark Ages Tome of Secrets, p. 42


The Keeper’s Way


The Keepers practice an eponymous path of Assamite Sorcery known only by them.
Keepers are unable to go without drinking at least one blood point from the Great Pool each night. When they fail to do so, they take one unsoakable level of aggravated damage each night without. When Keepers must leave Alamut for especially important business, they carry wineskins full of blood from the Great Pool for the sake of personal consumption. When traveling, Keepers may have need of their arts; any of the rituals listed below, save the fifth, may be used just as well with the Keeper pouring the blood into an open-mouthed container.

• Sense the Ripples
Assamites learning this path learn first to listen and read the largest ripples in the Great Pool, indicting dramatic events: the death or torpor of an Elder or Eldest, a planned treachery, or worse. Though dramatic events can be seen as they occur, it is only with higher knowledge that a practitioner can know in any detail what has occurred. With each success, she may ask one clarifying question related to the subject that can be answered with yes or no. Paradoxical questions cannot be answered.

•• The Gift of Haqim
With greater study, a practitioner can stretch the blood drawn from the Great Pool. He must drink at least one blood point from the pool. His body is filled by the pool, regardless of how far he is from the actual pool. He gains blood points equal to the number of successes, which come once per hour until fully awarded.

••• The Distant Crimson
With this spell, a practitioner can observe the physical surroundings of any Assamites in a one hundred kilometer radius. She may see through the eyes of the Assamites present at the location, and can tell their general emotional states, whether they have sufficient blood to get through the week, and whether they have been in combat in the last night. With additional successes, she may filter her perceptions based on an additional, formally recognized trait such as caste or age.

•••• Know the Fate of One
By examining the minute stirrings of the pool with more clarity, a practitioner can sense a dramatic change in the fate of one vampire. She may ask questions that can be answered with a yes or a no, equal to the number of successes on her roll. This spell is frequently done to discern the true depravity of especially powerful vampires. When the warriors believe they must inflict Final Death on a Prince, they first ask the Keepers.

••••• Cast into the Pool of Blood
This spell must always be cast by four sorcerers. By emptying themselves of blood points with their hands in the pool, the practitioners can feel the blood of all members of the clan flowing through them, and can impact the immediate fate of the Clan Assamite. All participants’ Generation increase by one, as they sacrifice their blood’s potency to influence the clan’s fate. Though they may not control time, nor impact things directly, through the power of this ritual they may dramatically impact the result of a series of events. In effect, they choose a goal to accomplish, which must be agreed to by all casting members. For each success, choose one of the following:
• Individuals gain –1 difficulty on relevant actions (to a minimum difficulty 3).
• Individuals gain +1 die on relevant actions (to a maximum +5 dice).
• Those obstructing the goal gain +1 difficulty (to a maximum difficulty 9).
• Those obstructing the goal lose 1 die (to a minimum dice pool 1).
For example: If the goal is to prevent an army from invading Alamut, all warriors would receive bonuses to their rolls made to defend the city, and all sorcerers would gain bonuses to rituals in defense of the collective, while enemies would suffer penalties to attack the Assamites therein.]==],
				},
				["The Kraina of Enoch"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 169


The Kraina of Enoch


Old Clan Tzimisce Embraced within the Underworld who claimed Enoch for their territory pioneered this kraina. The Kraina of Enoch is as unique in methodology as the land that birthed it. Koldun and their land are one; all kraina awaken the nature of that land. Whereas most kraina require that the koldun grant an offering of blood to the land, the Kraina of Enoch reflects the heart of the Underworld itself. The koldun seeking to rouse it must first become one with the lands of the dead by sacrificing a portion of their body.
In the Underworld, koldun with this kraina always have an intuitive sense of Enoch’s exact location within the Tempest.
The Kraina of Enoch is accessible to any Old Clan koldun initiated in the Tal’Mahe’Ra.

• Shroud of Oblivion
Existence in the Underworld grants Cainites certain advantages not available on the Earth; the koldun tears out a piece of the Underworld’s fabric to saturate the area around him with its attributes.
System: The koldun spends a Willpower point, then makes the activation roll (Attribute: Stamina). With a success, the koldun’s skin turns to ash and crumbles to nothing, exposing his meat to the elements. He plunges his hands into the earth, parting any impediment as if it were fresh tilled soil, and wrenches forth an insubstantial sheet of inky night, yanking out a piece of the Underworld with which to wrap himself. Once donned, the appearance of anything blanketed by the shroud becomes visibly muted; in the physical world, all beneath its shield resembles black-and-white television images in a full color world, while in the Underworld, things take on a more ghastly hue of deeper darkness and decay.
Shroud of Oblivion centers on and follows the koldun. The power has a radius of five feet/two meters per success scored on the activation roll, and a duration (in turns) equal to the successes. All those within the radius benefit from the shroud’s effects. The effects of this power differ according to what land the koldun is currently located (see the sidebar “Vampires in the Underworld” on p. 119): while in the mortal world, damage from sunlight lessens to bashing. If anywhere in the Underworld, the faint sun deals no damage.
When the duration of the power expires, the koldun bleeds out, losing one point of blood each turn until he expends a blood point to rejuvenate his skin (unless in the Underworld, in which case no blood is lost). Penalties sustained to activate this power are tallied after the duration ends. Healing prior to that time suspends the power’s effects.

•• Spectral Cloak
By harnessing the sight of the dead, the koldun aggrieves those in the vicinity with a glimpse of the world beyond that of the living. Spectral Cloak conceals the koldun from unfriendly eyes and drives away unwanted observers in terror.
System: The koldun plucks out her eyes, crushes them in her hands, and extends her palms to the sky, then makes the activation roll (Attribute: Perception). With a success, the pulp turns to dust and takes flight on an eerie howl of wind that pours from a fathomless darkness within her empty sockets. Shadows drawn from the surroundings engulf the koldun who vanishes, rendering her invisible to standard vision (for those with Auspex, see the sidebar “Seeing the Unseen” on p. 142 of V20, using the koldun’s rating in this kraina). Though the koldun sees normally inside the radius of the power’s effect, she is blind to anything outside of this area. Others within the radius must succeed on a Willpower roll (difficulty equal to the koldun’s rating in the kraina plus successes scored on the activation roll, maximum 9), or be afflicted with the Deathsight Flaw (V20, p. 494) and attempt to flee in fright for a number of turns equal to the successes scored on the activation roll.
The power’s radius centers on and follows the koldun, allowing her to move about and act on others, even violently, without being revealed. Spectral Cloak has a radius of ten feet/three meters per success scored on the activation roll and a duration (in turns) equal to the successes. When the duration of the power expires, the koldun is abandoned to blindness until she expends one blood point to heal (unless in the Underworld, where the koldun may continue to see indefinitely, despite the loss of her eyes). Penalties sustained to activate this power are tallied after the duration ends. Healing prior to that time suspends the power’s effects.

••• Pond of Malevolent Dread
Nestled just above the abyss in the Underworld, no place is more frigid, devoid of light, tenebrous, or bleak than the Sea of Shadows, an ocean of souls on the precipice of total annihilation. The koldun forms a shaft to sup from the doom of this sea and release its flow.
System: The koldun spends a turn eviscerating himself, thrusting his hands deep in his abdomen to expel his entrails onto the ground, then makes the activation roll (Attribute: Stamina). With a success, his bowels bore through the earth past any obstruction blocking their path, then cross over the threshold which separates the vibrant lands of the living from the desiccated lands of the dead. His entrails touch the very depths of the Underworld’s bottom layer, taking root in the Sea of Shadows. The vampire drains its essence into himself and discharges it outward in pulsating waves of despair that bubble up through the earth to ring him in a liquid pool of seething, writhing spectres. Ghostly arms stretch out to clutch and feast upon those walking through the circle’s radius. The rippling pool centers below the koldun, who remains locked in place from the waist down until the power ends.
The power has a radius of fifteen feet/five meters per success scored on the activation roll and a duration (in turns) equal to the successes. All those within the radius have their speed slowed to ¼ and must succeed at a Willpower roll each turn (difficulty equal to the koldun’s rating in the kraina plus successes scored on the activation roll, maximum 9) or lose 1 point of permanent Willpower.
When the duration of the power expires, the koldun severs his viscera buried in the earth and incurs two levels of unsoakable lethal damage. This damage cannot be healed by any other means other than by spending blood. Additionally, the koldun loses an amount of blood points equal to half the successes scored on the activation roll, rounded up (unless in the Underworld, in which case no blood is lost). Wounds sustained to activate this power are tallied after the duration ends. Healing prior to that time suspends the power’s effects.

•••• Wrath of the Tempest
Permeating most of the Underworld is the Tempest: a roiling, limitless typhoon made of fractured memories, broken dreams, nightmares, fear, and misery. The koldun summons the death rattles of all whom she has vanquished, pricking a hole in the barrier between worlds to let bleed the metaphysical storm.
System: The koldun spends one Willpower point and lifts her head to the sky, then makes the activation roll (Attribute: Strength). With a success, she opens her mouth and a choir of voices not her own issue a deafening cry that blends into thunder as storm clouds gather above her for the remainder of the turn. A still silence follows as the koldun stands frozen, her expression transfixed, echoing the call. Moments later, a roaring hurricane explodes around her, breaching forth from the land of the dead with all the fury of the Underworld. Its eye, a focused funnel, descends into the koldun’s mouth, causing her to convulse and writhe as she rises thirty feet into the air.
The tempest has a radius of twenty feet/seven meters per success scored on the activation roll and a duration (in turns) equal to the successes. All those within the radius must succeed on a Willpower roll (difficulty 8) each turn or gain a derangement and enter a strange fugue state (described on p. 291 of V20) called a “Harrowing” as the storm warps memories, trapping those within in an internal labyrinth of regret, depression, and hopelessness for the rest of the scene. While the storm rages, the koldun is mindless and completely unaware of her surroundings; she sustains one level of unsoakable bashing damage each turn as the tempest pounds her from within (unless in the Underworld, in which case the bashing damage may be soaked normally). Penalties sustained to activate this power are tallied after the duration ends. Healing prior to that time suspends the power’s effects.

••••• Hunger of the Void
The koldun embodies the distortions of the Tempest, torturing his soul to cleave a pit of perfect destruction into reality.
System: The koldun spends a Willpower point, reaches down his throat, and pulls out his own soul. He spends a turn tormenting and stretching the spirit’s mouth ever wider as it mutely protests, clawing impotently at its violator in shocked disbelief. He tosses the contorted soul to the earth at his feet, then makes the activation roll (Attribute: Strength) before diving into it. With a success, the giant maw transforms into a cavity five feet in circumference that begins sucking in all it can to appease its insatiable appetite.
The power has a radius of twenty five feet/eight meters per success scored on the activation roll and a duration (in turns) equal to the successes. All those within the radius are dragged ten feet/three meters per turn toward the Nihil, and have their speed slowed by half every five feet/two meters nearer they are to it. If consumed by the maw, they disappear and must make a Willpower roll (difficulty 9). After the power ends, the Nihil implodes, leaving an enormous crater in its wake. At the base of the crater lies the koldun with all the maw has consumed resting on top of him. Characters who have failed the roll are turned into mindless creatures, their virtues and morality stripped from them completely and reduced to zero. Vampires succeeding on the roll enter a Harrowing (see Wrath of the Tempest) for the rest of the scene and gain a derangement. Regardless of success or failure, any mortal consumed by the pit has its soul obliterated and enters a permanent coma.
A vampire’s undead stasis cannot incarnate this otherworldly energy. Upon the power’s conclusion, fissures of unfiltered nothingness shred the koldun’s soul from within as searing chars erupt to split the flesh across his entire frame (inflicting two levels of aggravated damage).]==],
				},
				["The Kraina of the Well"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 172


The Kraina of the Well


Legend holds that this kraina is the very first kraina, developed by the Eldest upon its discovery of the original Well of Sacrifice. Unlike others of its ilk, the Kraina of the Well is not harbored in exclusivity by the Old Clan alone. The Old Clan also instructs those Baali on Via Hyron dedicated to the Order of Moloch’s mission to conquer or slay the demonic with zero tolerance for all who’ve fallen into its infernal maw. Baali students do not cultivate a primary kraina and cannot learn other kraina other than the Well.
In order to enact the power of this kraina, the koldun is obligated to establish a sympathetic bond to the original Well of Sacrifice by building a duplicate for her own use and anointing it with her blood. Wells of Sacrifice are often constructed in secluded areas hidden from potential disturbance (see Wells of Sacrifice on p. 102), and their spiraling pattern is reminiscent of (and pays homage to) the symbol of Clan Tzimisce. In the wilderness, the “roots” of a mountain, in a cave, or the base of a tree are traditionally favored locations. A koldun abiding in the sprawl of a modern city might choose a deserted rooftop water reservoir, the remnants of a retired or never completed subway system, or an abandoned building or elevator shaft open to the sky.
The construction of a Well requires six hours of uninterrupted work every night for one full week, followed by enchantment and a mortal sacrifice each month thereafter to maintain. During construction, the koldun gives six blood points per night to the Well and makes an extended Manipulation + Occult roll (difficulty 7). If a night’s work is missed or if the seven rolls do not accumulate at least 25 net successes, the Well remains dormant and the koldun must begin anew from scratch. To maintain a Well, the koldun prepares her sacrifice and again makes a gift of six blood points, then rolls Manipulation + Occult (difficulty 7, needing a minimum of three successes). A sympathetic Well constructed in this manner lasts indefinitely unless its structure is ruined. Should a koldun’s Well be destroyed, she loses access to all powers in this kraina until a new Well is erected.

• Call the Children
In order to command a thing, one should venture to know it. Demons, much like dogs, always endeavor to come when called by their masters. The technique of conjuring forth Hell’s dwellers has ever been a staple at the table of infernal practice.
System: Necessitating a full scene of uninterrupted focus and the expenditure of one blood point to enact, the koldun performs a long series of incantations while tracing glyphs surrounding a circle in his own blood around the entrance to his Well of Sacrifice. The power and strength of a demon the koldun is capable of summoning rises proportionate to the level of his advancement in the kraina.
As the koldun’s skill in the kraina rises, so, too, does his ability to invoke demons of increasing power. Over the course of the scene he makes an extended invocation roll (Attribute: Wits), requiring an amount of successes equal to the difficulty level of the demon summoned.
Kraina Level 1 — Difficulty Level 5 Successes; Fallen Tempter
Kraina Level 2 — Difficulty Level 6 Successes; Fallen Tempter: +30
Kraina Level 3 — Difficulty Level 7 Successes; Fallen Tempter: +55
Kraina Level 4 — Difficulty Level 8 Successes; Earthbound Defiler in Darkness
Kraina Level 5 — Difficulty Level 9 Successes; Earthbound Defiler in Darkness: +30
Demons use the statistics presented on pp. 386-387 of V20. Storytellers should freely exchange specific Abilities and Disciplines for others and vary Attribute scores to suit the needs of their game. Demons invoked through Call the Children are not in possession of a mortal host, retaining the countenance of their Apocalyptic Form described under Powers and Weaknesses. Without being bound, a demon cannot exit the confines of the summoning circle within and will be ripped back into Hell after a number of turns equal to the difficulty level of its conjuration have expired. The demon can communicate, but generally demand an exchange of goods or services (sometimes even a contract) for any information asked of them, and even then, there’s no guarantee they need answer truthfully. The player may choose to summon the same demon again at a later date if a bargain was struck but unfulfilled before the conclusion of the power’s duration. Two or more koldun with this power may elect a primary summoner and work in concert to invoke an entity. The difficulty level is reduced by one (minimum 4) for each koldun assisting in the invocation.

•• Heed the Hell-bound Heart
Whether by blessing or familiarity, a koldun who drinks from her Well gains a supernatural sense that alerts her when demonic influence is near, wielding the ability to scan places, objects, or beings corrupted by the stamp of infernal company.
System: By sipping a blood point directly from her Well, the koldun adds her levels attained in Kraina of the Well to her Awareness Ability for detecting demonic influence in areas tainted by its presence or souls stained by its touch. This effect last for as long as the blood point remains in her system. Blood is always consumed in the order it was ingested.

••• Aegis Alighieri
Named in the modern nights for the famed Venetian poet, Aegis Alighieri shields the koldun from violating onslaughts, predations, and defilement by demonic forces.
System: The koldun lacerates a vein, spending one turn and a blood point to coat an amulet in her blood, then makes the activation roll (Attribute: Charisma). For the remainder of the scene, the koldun adds successes scored on the activation roll to the difficulty rating for supernatural attacks and influences of infernal origin used to target her (such as infernally blessed objects, Investments and Gifts, or any Disciplines and blood sorcery powers wielded by infernalists and demons). She also gains an amount of extra dice on rolls to resist those same effects equal to the amount of successes scored. Any mundane or mystical object may be consecrated as an amulet; popular choices include ceremonial daggers, shamed crucifixes, or decapitated heads that animate to scream endlessly in silence. However, only the koldun benefits from the protection granted through Aegis Alighieri and must have the amulet on her person for this power to function. Prior to activating this power, the koldun is required to have dipped the amulet in her Well, letting it soak therein for one full night. Two or more koldun working together in close proximity (within 50 feet/15 meters) grant each other one extra success on resistance rolls and increase the difficulty to target by one (maximum 9) for all koldun present with this power activated.

•••• Heave the Host of Hell
After learning to call, to sense, and then to defend against infernal marring, the koldun now may erase its scars entirely.
System: The koldun creates a link to his Well by molding or digging a bowl-shaped impression (minimum one foot/30 cm in diameter) into the earth and christening it with one blood point. He chants a litany of admonishments and curses while sprinkling the blood on the area or baptizing the subject he intends to exorcize, then makes the activation roll (Attribute: Manipulation).
To cleanse an area, being, or thing of infernal imprint or evict a demonic entity, an amount of successes are required relative to the degree of corruption infused (1 to 2 for minor blemishes, 3 for subtle infections of noticeable evil, 4 or more for objects and spaces radiating a palpably potent malevolence). Infernalists imbued with the diabolical and demonic spirits disgracing an area with their presence (or directly in possession of beings, locations, or things) may resist by spending a Willpower point, then rolling Willpower (difficulty equal to the koldun’s permanent Willpower rating). Demons failing the roll are dismissed and banished back to Hell. Cleansed infernalists do not regain their damned souls, but any infernal mark that once permeated there being is permanently expelled.
One or more koldun with Heave the Host of Hell may assist a primary exorcist to negate an infernal blight. The difficulty level to cleanse or evict is reduced by one (minimum 4) for each koldun aiding in the exorcism.

••••• Reap the Well
Kolduns who attain full mastery in Kraina of the Well earn the sobriquet of “Hellreaper” by their peers, and for good reason.
System: Upon summoning a demon or discovering an escapee unfettered and loose outside the prison of Hell, the koldun may attempt to bind and enslave the creature to her will. The koldun cuts her wrists, taking a turn to pool one blood point in her cupped hands in order to fabricate a connection to her Well. When ready, she spends a Willpower point and makes the activation roll (Attribute: Strength). The blood leaps from her hands in the form of six interlocking hooked chains anchored beneath her slit wrists which lunge toward the target with unerring precision (maximum 100 feet/30 meters). If the roll is a success, the blood-hooks painfully latch into the entity, creating gory wounds (no damage) regardless of whether the creature possesses a physical form. An ensnared creature may struggle to break one chain per turn by spending a Willpower point, then rolling Willpower (difficulty equal to the koldun’s permanent Willpower rating).
For as long as the hooks penetrate the entity’s body, once per turn the koldun may demand its True Name, tormenting the demon by rolling Intelligence + Intimidation against the target’s current Willpower points to wrack its soul with excruciating pain. With a success, the victim cries out the answer in supplication. The koldun has two choices: she may unshackle and dismiss the demon through Heave the Host of Hell, or absorb it into herself.
A koldun that has acquired a demon’s True Name reduces the difficulty level by two when evoking it at a later date through Call the Children. Demons bound by their True Name may exit the confines of a circle they’ve been invoked within, and can be commanded by a koldun to complete a number of tasks for a number of days equal to the successes scored on the invocation roll. The demon will answer any of the koldun’s questions, and the koldun does not need to offer an exchange of services for questions or tasks.
If choosing to absorb a chained demon, the koldun may spend a blood point to instantly call it forth again. Chained demons are wholly compliant and serve the will of the koldun in whatever capacity she demands, but must remain in bondage (maximum 100 feet/30 meters) to the koldun. A koldun can control up to six chained demonic thralls; each chain divided decreases the amount of chains available for future binding and increases the difficulty to torment untamed demons by one.
A demon who disobeys or lies to a summoner who knows its True Name when conjuring it causes a demon crippling agony. Should Reap the Well be used to perform a violent exorcism on a living host possessed by a demon, the host rolls Stamina against a difficulty equal to the amount of turns taken to tame the demon into revealing its True Name. A failure results in the host dying of shock. Multiple koldun may Reap the Well together, collectively decreasing the difficulty to torment a demon by one per chain (minimum 4). The Hellreaper who successfully extracts the demon’s True Name on their turn may choose to bind it or dismiss it. All koldun present hear the demon howl its True Name, and if dismissed, may individually conjure it. A demon in thrall to a Hellreaper cannot be evoked until released from service.]==],
				},
				["The Laws of Suleiman"] = {
					en = [==[Rites of Blood, p. 160


The Laws of Suleiman


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Laws of Suleiman is one of those paths: it is functionally identical to Path of Spirit Manipulation (Rites of Blood, pp. 142-145).]==],
				},
				["The Nightshade Path"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 70


The Nightshade Path


Developed by the Drakaina, this Path of Necromancy studies natural cycles, including the savage interplay of life and death. All life is a manifestation of entropy, a chaotic miracle punctuating Creation’s flow toward destruction. When rot claims a body, it impregnates the flesh with insects and lush plants, and its stench calls scavengers who sustain themselves with death’s bounty. Vampires demonstrate how this process can be arrested and manipulated, for Kindred stand suspended at the moment of death, before nature blesses them with the power to decompose and feed living things. The black seed lies dormant within them, but they can encourage its growth in others, manipulating rot and staining life with the ghostly essence.
Although the Drakaina developed the Path, they don’t hoard it — it’s the Dark Mother’s gift, to share with all who worship her. Any Bahari necromancer may learn it from a Drakaina teacher. Lilin Nagaraja practice this Path in increasing numbers because it unifies the life and death principles in ways anticipated (but never realized) by their Idran forebears.

• Tend the Body Garden
Modern forensics makes it possible to determine time of death with remarkable accuracy — a frightening prospect for Kindred with bodies to hide. On the other hand, sometimes it’s better for people to find corpses before rot takes them. Presenting evidence that elder Kindred have suffered the Final Death is sometimes difficult to come by, as their bodies rapidly molder into nondescript ash. A necromancer with this power overcomes these difficulties. She can speed up or slow the process of decay, turning a dead mortal into a bloated host for flies in seconds or nullifying the decay of Final Death.
System: The player spends one blood point as the vampire lets some of her blood drip on to a corpse, and rolls Wits + Occult (difficulty 6). Successes allow the vampire to accelerate or arrest decomposition as follows:
1 success — Delay or accelerate rot by up to one day
2 successes — Up to one week
3 successes — Up to one month
4 successes — Up to one year
5 or more successes — Storyteller’s discretion
The vampire may use this power on mortals and animals as long as the remains have not been substantially scattered. It may be used on Kindred no longer than one turn after they’ve met Final Death. Corpses that recently belonged to the living change according to local conditions, so that one stored in a dry place might mummify, while another that rests on soil quickly sprouts plants and maggots. Living things that feed from the dead are quickened or held in stasis as the corpse is, provided they’re plants, fungi, or no larger than a scarab beetle. Kindred under Final Death wither and fall to dust without attracting such organisms.

•• Witch’s Fruit
Every plant relies on death to grow. Rotting things enrich the soil, and the trees, vines, and grasses drink up necrotic echoes along with vital nutrients. A necromancer can awaken this death aura by exposing their fruits to her blood. She awakens and concentrates their trace necrotic energies so that anyone who consumes them can sense and touch the Shadowlands.
System: The player spends a blood point while the vampire touches edible plant matter. No roll is required. The first living creature to eat this tainted meal falls into a waking, ambulatory trance for a scene, during which she may see into the Shadowlands, hear its denizens, and even touch and be touched by ghosts. The target may not make physical contact with buildings and other objects that were never alive, and may not be dragged into the Tempest or any other place that has no corresponding location in the living world. Tainted plant matter rots by the next sunrise and loses the ability to impart this state.
Witches’ fruits are mild hallucinogens. Twisted visions of ghosts and long-fallen buildings disorient mortals under their influence. This normally imposes +2 to difficulties to perform any actions except for Willpower rolls while affected. Creatures who are familiar with supernatural phenomena don’t suffer this penalty.

••• Raise the Green One
Tales of Kid, Osiris, and the Green Man all describe beings who were brought back from death and clothed in verdant color. Isis raised Osiris to become a symbol of rebirth and growth, and neopagans say Green Man iconography remembers the god who is slain by Winter and reborn in the Goddess’ womb. Nightshade necromancers channel these legends into the act of raising a corpse bound and strengthened by plant matter. Leaves cover its skin and strong vines supplement its rotted sinews. The living shell grants speed and self-preservation instincts not seen in other animated dead.
System: The player rolls Wits + Occult (difficulty 8). He spends one Willpower point and one blood point while concentrating on a corpse that lays upon or within fertile soil. If the roll succeeds, red-tinged vines, branches, and leaves envelop the corpse, and it rises to do the necromancer’s bidding. The necromancer may only raise the Green Ones one at a time, and may never have multiple Green Ones active at the same time.
Green Ones are stronger, faster, and possess better instincts than most zombies. Their traits are Strength 4, Dexterity 4, Stamina 4, Athletics 2, Brawl 3, and the equivalent of 2 dots of Fortitude, as their damp bodies resist injuries. Bashing damage inflicts half damage to a Green One. Like vampires, they suffer bashing damage from gunfire. Unlike ordinary zombies, they act in standard initiative order.

•••• Wails and Whispers
As the necromancer’s understanding deepens, she explores the wavering barrier between life and death. When she screams like a banshee, she can lure a soul to its demise, increasing the chance of a fatal injury. When she whispers like a mother to her child, she can fix a soul in the lands of the living, even when it occupies a body that should be dead.
System: The vampire concentrates on a target, screaming or whispering as her intentions dictate. (The target does not need to be able to hear the vampire.) The player spends one point of Willpower and rolls Wits + Occult (difficulty 8). If she wishes to lure her target closer to death, each success adds one level of lethal damage to the total inflicted by the next injury he suffers in that scene. If she wishes to prevent the target from dying, each success sets aside one level of damage (of any kind) from the next injury the target suffers during the scene, but this benefit only lasts until the end of the scene, after which the set aside damage returns. The target suffers injury but doesn’t feel its effects, up to and including death, until the scene ends and the damage returns. Note that the Storyteller can rule that very large amounts of damage may cause death due to total or near-total destruction of the body, regardless of this power’s effects.

••••• Chthonic Womb
At the apex of this Path, a necromancer combines murder and fertility to give birth to the ghost of a mortal she has slain. She drinks the victim’s blood to grab hold of his soul, and after dispatching him, traps it within her. At a later time, she may call it forth as a ghost to do her bidding.
System: The vampire must drink at least one point of a mortal victim’s blood, but may kill him using another method. Another person or incident may cause the mortal’s demise, but the necromancer must make physical contact with him at the moment of death. At that point the player spends one point of Willpower and rolls Wits + Occult (difficulty 8). If the player succeeds, the soul occupies the vampire’s body in a dormant state for up to one month per success. (Aura Perception or similar powers will reveal the presence of the dormant soul, which might be mistaken for a form of possession.) The necromancer may store multiple souls this way, but “twins,” “triplets,” and more tax the “mother’s” energy. Each soul stored beyond the first drains one additional blood point when the vampire awakens each night.
At any point before the soul leaves her body, the vampire may summon it forth to manifest with either the traits of a recently deceased ghost (see V20, p. 385) or those it possessed in life, along with a recently deceased ghost’s supernatural abilities. It must perform three services for its “mother.” After that, the soul is free to move on to its ultimate destiny. If the ghost is commanded to perform any task that would traumatize a mortal (typically, those which would risk a Humanity check in a vampire with that trait at 7) it may, at the Storyteller’s discretion, treat the necromancer as a “fetter,” an object that the ghost fixates upon and uses as a tie to the living world. This gives the ghost the ability to haunt the necromancer until it is banished. The necromancer may always simply dismiss the soul when it appears, or even command it to leave her body while the soul still slumbers.]==],
				},
				["The Path of Blood"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 213


The Path of Blood


Almost every Tremere studies the Path of Blood as her primary path. It encompasses some of the most fundamental principles of Thaumaturgy, based as it is on the manipulation of Kindred vitae. If a player wishes to select another path as her character’s primary path, the Storyteller may require additional reasoning (though choosing a different path is by no means unheard of).

• A Taste for Blood
This power was developed as a means of testing a foe’s might — an extremely important ability in the tumultuous early nights of Clan Tremere. By merely touching the blood of his subject, the caster may determine how much vitae remains in the subject and, if the subject is a vampire, how recently he has fed, his approximate Generation and, with three or more successes, whether he has ever committed diablerie.
System: The number of successes achieved on the roll determines how much information the thaumaturge gleans and how accurate it is.

•• Blood Rage
This power allows a vampire to force another Kindred to expend blood against his will. The caster must touch her subject for this power to work, though only the lightest contact is necessary. A vampire affected by this power might feel a physical rush as the thaumaturge heightens his Physical Attributes, might find himself suddenly looking more human, or may even find himself on the brink of frenzy as his stores of vitae are mystically depleted.
System: Each success forces the subject to spend one blood point immediately in the way the caster desires (which must go towards some logical expenditure the target vampire could make, such as increasing Physical Attributes or powering Disciplines). Note that blood points forcibly spent in this manner may exceed the normal “per turn” maximum indicated by the victim’s Generation. Each success gained also increases the subject’s difficulty to resist frenzy by one. The thaumaturge may not use Blood Rage on herself to circumvent generational limits.

••• Blood of Potency
The thaumaturge gains such control over his own blood that he may effectively “concentrate” it, making it more powerful for a short time. In effect, he may temporarily lower his own Generation with this power. This power may be used only once per night.
System: One success on the Willpower roll allows the character to lower his Generation by one step for one hour. Each additional success grants the Kindred either one step down in Generation or one hour of effect. Successes earned must be spent both to decrease the vampire’s Generation and to maintain the change (this power cannot be activated again until the original application wears off). If the vampire is diablerized while this power is in effect, it wears off immediately and the diablerist gains power appropriate to the caster’s actual Generation. Furthermore, any mortals Embraced by the thaumaturge are born to the Generation appropriate to their sire’s original Generation (e.g., a Tenth-Generation Tremere who has reduced his effective Generation to Eighth still produces Eleventh-Generation childer).
Once the effect wears off, any blood over the character’s blood pool maximum dilutes, leaving the character at his regular blood pool maximum. Thus, if a Twelfth-Generation Tremere (maximum blood pool of 11) decreased his Generation to Ninth (maximum blood pool 14), ingested 14 blood points, and had this much vitae in his system when the power wore off, his blood pool would immediately drop to 11.

•••• Theft of Vitae
A thaumaturge using this power siphons vitae from her subject. She need never come in contact with the subject — blood literally streams out in a physical torrent from the subject to the Kindred (though it is often mystically absorbed and need not enter through the mouth).
System: The number of successes determines how many blood points the caster transfers from the subject. The subject must be visible to the thaumaturge and within 50 feet (15 meters). Using this power prevents the caster from being blood-bound, but otherwise counts as if the vampire ingested the blood herself. This power is spectacularly obvious, and Camarilla princes justifiably consider its public use a breach of the Masquerade.

••••• Cauldron of Blood
A thaumaturge using this power boils her subject’s blood in his veins like water on a stove. The Kindred must touch her subject, and it is this contact that simmers the subject’s blood. This power is always fatal to mortals, and causes great damage to even the mightiest vampires.
System: The number of successes gained determines how many blood points are brought to boil. The subject suffers one health level of aggravated damage for each point boiled (individuals with Fortitude may soak this damage using only their Fortitude dice). A single success kills any mortal, though some ghouls with access to Fortitude are said to have survived after soaking all of the aggravated damage.]==],
				},
				["The Path of Jinn’s Gift"] = {
					en = [==[Rites of Blood, p. 160


The Path of Jinn’s Gift


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Path of Jinn’s Gift is one of those paths: it is functionally identical to The Path of Conjuring (V20, pp. 220-221).]==],
				},
				["The Path of Life’s Waters"] = {
					en = [==[Rites of Blood, p. 160


The Path of Life’s Waters


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Path of Life’s Waters is one of those paths: it is functionally identical to The Path of Blood (V20, pp. 213-214).]==],
				},
				["The Path of Phobos"] = {
					en = [==[Rites of Blood, p. 168


The Path of Phobos


Infernalists know the power of fear and the leverage of desperation. Practitioners of this path mystically tap into the depths of their victims’ psyches, prying the terrors from their minds and making them appear real. Sophisticated Sabbat infernalists prefer this path, as they enjoy the sublime effects of using the subjects’ own fears against them rather than vulgar, brutal displays of fire and demonic servants.
Infernalists that inflict nightmares upon others risk consuming the horrible memories that have leached from their victims, only to relive them later. Storytellers should force a Manipulation + Empathy roll (difficulty 7) on any character that utilizes the Path of Phobos more than once in a given story. Each evening while reliving the nightmares of her victims, she will wake soaked with blood; effectively costing an extra point of blood to wake due to the lack of sound sleep. Such is the price of hellish insight. The number of successes indicates how long the character must cope with the sea of stolen terrors rampaging in her mind.
1 success — One Week
2 successes — Five Days
3 successes — Four Days
4 successes — Two Days
5 successes — One Day

• Induce Fear
The infernalist harnesses the power of Hell to twist the mind of her victim, leaving her to feel paranoid. Subtle shapes and shadows shimmer at the edge of the victim’s vision, tormenting her by lurking just beyond her range of sight.
System: The infernalist may target any subject within her line of sight. She must concentrate, gesture toward the victim, and chant the proper invocation to Hell. Should she succeed, the victim becomes noticeably upset and preoccupied, which should be role-played. To resist, the victim must make a Courage roll (difficulty 4 + the number of successes achieved on the activation roll, to a maximum of 9) to take any action other than looking for the imagined stalker.
All of the victim’s dice pools for the duration of this power are automatically reduced by one. The duration of this power is limited by the number of successes achieved on the activation role:
1 success — One Turn
2 successes — Five Turns
3 successes — One Hour
4 successes — One Night
5 successes — Two Nights

•• Spook
This power transforms suspicion to dread, as the flitting shadows become frightening threats. The victim senses something terrible is about to happen to him unless he immediately flees the area. He might imagine she sees the flash of a gun barrel or hears the clicking of hard-soled shoes on the pavement just behind her. He might even believe she smells her pursuer’s sweat or feels his damp breath on the back of her neck.
System: The infernalist must see her victim and whisper a prayer to Hell for this power to work. The nagging sense of discomfort in the back of the character’s mind becomes more tangible. Mortals must make a successful Courage roll (difficulty 7) to keep from fleeing the area in terror. Vampires must make the same roll, but if they fail they enter Rötschreck.

••• Terrorize
The infernalist can draw out his victim’s fear and present her with it. The victim sees that which terrifies her the most. If she fears spiders, she may imagine spider webs brushing her face and hands as thousands of illusory arachnids scuttle across her flesh. She may hear them skittering across the floor or clicking their horrid chelicerae. To the victim, the effects seem very real, though they are simply illusions and invisible to onlookers.
System: The infernalist must concentrate for a moment and then gesture toward her victim. Should she succeed, the terrorized subject must succeed in a Courage roll (difficulty 7) to shake off her fear in order to act. Otherwise she simply cowers, feebly hiding from her imagined object of terror. Botching this Courage roll results in a derangement, preferably suited to the fear visiting the victim.
The duration of this power is limited by the number of successes achieved on the activation role:
1 success — One Turn
2 successes — Five Turns
3 successes — 30 Minutes
4 successes — One Hour
5 successes — One Night

•••• Fear Plague
The infernalist can now taste her victim’s most deep-rooted fear. She can force her subject to plunge deep into this phobia every waking moment. A person afraid of drowning would feel the air thicken and coagulate in his throat and lungs until he cannot take a breath, while a person afraid of vampires may see fanged nemeses in his coworkers or lurking behind every corner. Eventually, the victim becomes so exhausted that he is unable rise and face a new night of swarming horrors.
System: The infernalist must see and then loudly curse her victim for this terrible power to take effect. Once cursed, this power lasts for a week. The victim is constantly harassed by his fear every moment. For the duration of this power, all Willpower rolls are made as though the character’s permanent rating is three lower than normal (to a minimum of 1).

••••• Leech of Fear
This power enables the infernalist to temporarily feed on fear as though it was blood. This experience gives a euphoric high stronger than conventional feeding, but it is a dangerous practice if used too frequently. The infernalist converts the pure emotional charge drawn from the victim’s terror into a mystical substitute for vitae.
System: As long as she has her subject in sight, the infernalist may attempt to gain sustenance from any fear that the victim might be currently suffering. Naturally, the victim must have cause to be afraid of something or someone while the infernalist practices this power. These fears may not be caused by other applications of this path.
The number of successes achieved on the activation roll determines the number of points transmuted into the infernalist’s “fear pool.” Each point in this “fear pool” may be spent exactly like a blood point, beyond normal Generation limits. However, this extra source of power must be utilized before sunrise or it will disappear.
In addition to the lost Willpower point, a botch means that the infernalist gets no “fear pool” from the victim, and cannot use the power on that victim again for 24 hours.]==],
				},
				["The Path of Praapti"] = {
					en = [==[Rites of Blood, p. 165


The Path of Praapti


Praapti (Sadhana Path) is the power of instantaneous travel. The Indian Sadhana practitioners developed this Path to match their mysterious Asian rivals, who have the power to travel instantly along lines of mystical force. Later, turncoat sadhus sold the secret of this Path to the Tremere, who reverse-engineered it into what they call the Path of Mercury. A handful of New Age Anarchs have also stumbled onto the secret of this path, which they simply call Teleportation.
Individual levels of this Path do not have distinct effects. Instead, a higher mastery simply indicates a farther distance that can be traveled. Ideally, the sorcerer must be able to see the target location or know it intimately. Failure on a roll to activate this path means that nothing happens at all, but botches are more problematic. If the target location is within sight or is very near (the other side of a wall, for example), a botch causes the character the usual catastrophic problems for blood magic. If the sorcerer attempts a blind teleport, however, botches are much more dangerous. Typically, the sorcerer finds himself merged with a solid object, suffering one level of aggravated damage per “1” rolled. Three or more levels of damage also means that the sorcerer is stuck inside a large object such as a wall or the ground, and may not be able to break free. Fortitude soaks this damage as normal but will not help a character who materializes six feet underground. Familiarity with the target location of a blind teleport affects the difficulty of the roll as follows.
Intimate (one’s own haven) — difficulty modifier -1
Visited regularly — +0
Unseen but understood (such as the other side of this wall) — +0
Unfamiliar (visited a few times) — +1
Very unfamiliar (a known location) — +2
• Teleport up to 10 yards/meters.
•• … up to 50 yards/meters.
••• … up to 500 yards/meters.
•••• … up to 5 miles/8 kilometers.
••••• … up to 500 miles/800 kilometers.
Teleportation is rarely exact. Every “1” rolled on a successful roll throws the sorcerer off by 10% of the total destination. The number of successes rolled determines what can be conveyed. A single success allows for the teleportation of the sorcerer’s nude body. Each additional success allows for the conveyance of an additional twenty pounds. If the successes rolled are not enough to encompass what the sorcerer seeks to carry, the Storyteller decides what is left behind.]==],
				},
				["The Path of Skulls"] = {
					en = [==[Dark Ages Tome of Secrets, p. 54


The Path of Skulls


Cappadocians are often dismissed as apolitical, fit only for work in dungeons and plague pits. They possess none of the blood-borne talents allowing for manipulation and control of mortals. The expectation that a Graverobber would be more at home elbow-deep in a cadaver isn’t fanciful, but there exists a strata of the clan who enjoy remaining hidden, allowing their childer to wade through corpses while they play kingmaker. These Cappadocians call themselves Harbingers. Their order has existed for millennia. It would form the backbone of the clan, were its numbers not depleted in recent centuries. Rumor holds that the founder of the clan confined a large number of Harbingers to Hell itself.
The Harbingers use Necromancy in an atypical fashion. Before the Long Night degenerated into the War of Princes, they created the Path of Skulls — a necromantic Path dedicated to the theft of identity and knowledge from the dead. From throne rooms to merchant caravans, necromancers who channel the Path of Skulls exert mastery over the diplomatic scene and Jyhad. Cappadocians invidiously guard the Path of Skulls, largely due to the secrecy of the Harbinger agenda. Cappadocians who know the Path will occasionally mentor those who show a subtle political acumen. Knowing whether to assassinate a monarch, his queen, or their heir; perceiving whether to deliver, amend, or destroy a message from one court to another — such behaviors are observed by the Cappadocians who call themselves Harbingers, and rewarded by tutelage on the Path of Skulls.

• Calvaria Emissicius
One of Clan Cappadocian’s most prized secrets is the ability to spy via the eye-sockets of the dead. Few enquire why Graverobbers festoon their havens with the skulls of their victims. A simple Cainite may pass off a cluster of skeletal remains as morbid decoration, not realizing from the empty sockets of a skull peers the gaze of a necromancer.
System: The necromancer must possess the skull of any creature he’s personally slain. The player spends a blood point and rolls Perception + Occult (difficulty 5). Failure has no effect; a botch means the skull crumbles to dust immediately. Success means the necromancer can instantly enter a meditative state in which he can see through the sockets of the skull, canceled only once the trance is broken or the sun rises. This spying state can be reentered a number of times equal to the number of successes.

•• Consilium Mortuus
Myth holds that the dead tell no lies. In truth, wraiths and animate corpses are as capable of falsehood as any other being, but the Harbingers believe there’s a grain of truth to the fable. The Cappadocians seek a way to guarantee truthful responses from the deceased, and possession of the skull is the key. By conversing with the decapitated head of the departed target, it transpires that prying a guaranteed truth from decayed lips is quite possible.
System: The necromancer must possess the decapitated head of a being whose language he would understand. The player must spend at least one blood point and roll Manipulation + Empathy (difficulty 6). Failure has no effect; a botch means the head will answer only in lies to the necromancer’s questioning. Success forces the head to answer one question posed by the necromancer truthfully, but it must be to a question to which the head’s former owner would know an answer. For each blood point spent above the initial one, an additional question may be asked.
No spirit is summoned with Consilium Mortuus — the dead being with whom the necromancer communicates isn’t even aware of being channeled. The answer comes through vestigial memory, traces left in the head’s rotting brain, imprinted on its putrefying tongue.

••• Ammorsus Vicarius
Those practicing the Path of Skulls know being the recipient of sensitive information is a deadly business. The fetish of the Path — the eponymous skull — bears more utility than a simple medium for communication. It can act as a brutal tool in the hands of an accomplished necromancer, and often must do, for necromancers make many enemies.
Using this power, the necromancer can grip the mandible and maxillae of the skull to use as a bizarre close-quarters weapon, affix the skull to a spear-point to attack from a distance, or even leave the skull alone, to act as a trap. If not under the manual control of its wielder, the skull has a limited range. Such a restriction often leads necromancers to place these skulls in beds, on desks, or inside chests. When the teeth clamp down on a victim, blood flows. Each drop rejuvenates the necromancer.
System: The necromancer must possess a skull or rotting head with all teeth removed. The player must spend one point of Willpower and at least one point of blood for this power to take effect. In place of teeth, a vicious row of fangs emerges in the skull, remaining until it consumes as many blood points as spent by the necromancer in its activation. At this point, the skull becomes inert and its fangs fall out.
The skull instinctively bites when in a half-meter (1 1/2 feet) proximity to living flesh and warm blood. With the vampire’s expenditure of a second Willpower point, it will also tackle Cainites. The skull is able to propel itself half a meter (1 1/2 feet) with jaws wide on a single occasion, with a total combat dice pool of 6 and standard difficulty. A successful bite from an independent skull is an immediate clinch from which the skull will not retract until destroyed.
The skull may be wielded as a weapon by the necromancer, in which case it holds the same combat dice pool and difficulty as the weapon upon which it’s affixed (see V20 Dark Ages p. 349). In this case, the skull will willingly retract its bite if the necromancer pulls it away from a victim.
The skull’s bite deals three levels of aggravated damage for every turn its fangs are gripped on a target. It also consumes one blood point per turn, which is necromantically channeled to the Cainite who gave it power. Vitae channeled in this way can count toward a blood bond.
The skull is destructible, but takes at least one turn of focused attack to destroy. For the purposes of defense, the skull cannot dodge or maneuver. It has a Strength rating of 3 for determining resistance to being pried free and a Stamina rating of 2; it only has three health levels, and it can only soak bashing damage.
A necromancer may animate multiple skulls by making the expenditure of Willpower and blood for each.

•••• Exedo Animus
Outsiders are to never know the benefits of this power, for they will assume the practitioner guilty of the Amaranth. The necromancers who perform Exedo Animus are not consuming the soul of one of the dead, but are allowing the memories of the deceased to inhabit their bodies for a time. Such presence gives the spirit no power over the host, but does give the host complete access to the identity, personality, and memory of the deceased.
By bearing a skull — either from a mortal or Cainite — the necromancer forms a sympathetic bond with the skull’s former owner. Necromancers have used this power to fool the loved ones of the deceased, by indicating they speak for the dead’s last wishes. Others slay rivals, gaining access to their secrets by drinking memories from the skull of the deceased.
System: The necromancer must possess a skull, and know the identity of the person of whom the skull once formed a part. The player must spend two Willpower and two blood points, and roll Intelligence + Occult (difficulty 7). Failure has no effect; a botch means the memories of the deceased will be confused and misleading. Success allows the necromancer to upend the skull and drink the personality from it. For each success, the necromancer gains an hour as host to the skull’s memories and identity.
The effects of Exedo Animus allow the necromancer to perform Intelligence-based rolls surrounding recollection and memories of the deceased at a difficulty decreased by 3. These memories stop at the point of death — the spirit in communion is a shadow of life, rather than an independent, thinking wraith.
Exedo Animus also grants the necromancer the power to impersonate the identity of the deceased, gaining three dice on Performance-based rolls when doing so. Such an imitation suffers penalties when the necromancer doesn’t physically resemble the dead source of her mimicry, but when utilizing Obfuscate or explaining she’s channeling the dead instead of being the dead, these acts are more successful.

••••• Degulo
When Degulo was first practiced, its necromancer creators celebrated in a long, grim reverie. These nights, Degulo’s efficacy is weighed against the dangers it presents. Where Daemonic Possession (see V20 Dark Ages p. 280) focuses on the art of transposing a departed spirit into the empty shell of a corpse, Degulo is the method by which a necromancer consumes a fragment of soul and retains it forever as a part of himself.
The process by which a necromancer eats a spirit requires great sacrifice on the part of the practitioner, who must give up a part of himself to allow the dead to move in. Some necromancers are known to strip their bodies of frailty in order to take on the souls of mighty warriors, where others lose knowledge of their own languages to make room for ancient, arcane dialects. At the extreme end, some Harbingers divest themselves of their clan-given powers in exchange for Disciplines possessed by passed Cainites. Tales tell of Cappadocians who attempt to lose their curse, replaced with that held by another clan. To date, these attempts have been met with failure, but necromancers are known for their commitment to incessant experimentation.
System: The necromancer must possess the skull of the being whose powers he wishes to ingest and subsume. The player must spend two Willpower and make a Willpower roll (difficulty 9). Willpower cannot be spent to create an automatic success on this roll. Failure has no effect; a botch means the necromancer loses whatever he was prepared to sacrifice for the Discipline, but gains none of the benefits. Success allows the necromancer to unhinge his jaw and consume the skull whole, subsequently subsuming elements of the devoured spirit.
Degulo forces the vampire to lose any one trait on his character sheet. The Storyteller then replaces this trait rating with that held by the dead person whose skull has been consumed.
The vampire using Degulo is restricted to swapping only one trait rating, and as the skull is consumed in the act, this act cannot be repeated with further traits from the same spirit. Unlike the other levels of the Path of Skulls, if there is a wraith of the deceased, it is affected by this power, gaining the trait bequeathed by the necromancer in exchange for its own.
Degulo’s sole restriction applies to Disciplines, allowing only for an equal rating swap of Cainite powers. A necromancer cannot exchange his one dot in Auspex for another Cainite’s four dots in Dominate, but can exchange his one dot in Auspex for the first dot of the deceased Cainite’s Dominate Discipline. The practitioner of Degulo then loses his chosen Discipline as a Clan Discipline, gaining the consumed Discipline as his new Clan Discipline.]==],
				},
				["The Path of Woe"] = {
					en = [==[Dark Ages Tome of Secrets, p. 57


The Path of Woe


The Giovani proficiency in handling spirits is widely respected by other necromancers, excepting one rare breed — a syndicate of Roman mortals and vampires bearing the name Rosselini, or variations of it. The necromancers following supposed matriarch Rosalina are as adept at ensnaring wraiths as any Giovani, but where the Young Ones probe, interrogate, and barter with ghosts, Rosselini necromancers torture and drain the dead, despoiling the lands of the living in the process. Ironically, most see the Giovani as crude amateurs at best, especially disparaging the Path of the Sepulchre. To its Rosselini founders, the Path of Woe parallels a sacred art form, bearing righteous support from mortal hunters operating under the papacy. These inquisitors would see heretics’ souls suffer further, begging for absolution even beyond death. The necromancers who know the Path of Woe are only too happy to carry out the papal edict.
The mortal Rosselinis — bearing the name simply as tribute to their scarlet-maned leader’s epithet — have been Embraced into diverse clans and bloodlines. While the Cappadocians and Giovani are chief among their regnants, practitioners of the Path of Woe are found among the Followers of Set, Toreador, and Lasombra in smaller numbers. The Path is new in these nights, but with Louis IX of France preparing another crusade to retake Jerusalem and Christian fervor burning hot, Necromancy styled as a holy form enters vogue within Cainite courts.

• Finding the Locus
Wraiths are often bound to objects, locations, and individuals known as Fetters. Rosselini necromancers know that to flush one out into the open typically requires detecting and threatening its Fetters. From there, interrogation or destruction can commence.
System: The player spends one blood point as her vampire rubs vitae into her eyes, and rolls Perception + Awareness (difficulty 5). Failure has no effect; a botch means the necromancer mistakes the wrong object for a Fetter. Success allows the necromancer to see an ectoplasmic glow surrounding something important to a wraith, such as the sword used to kill him, the dress she died in, the house in which he grew up, or the daughter she gave up to the Church. Each additional success allows the necromancer to see trails to other Fetters for the same wraith. The Discipline effects last for one scene. This power only allows the vampire to see a Fetter. While the wraith will often manifest if its Fetter is threatened, the necromancer will not be able to see it until it makes its presence obvious.

•• Expurgate the Damned
Rosselini necromancers don’t care to summon or bargain with spirits. They threaten the dead, and strip away their defenses. If a necromancer is confident that a spirit is in the room, circle of bones, or vitae-painted boundary, Expurgate the Damned forces the wraith to make itself known. It doesn’t bind the spirit, or compel it to talk, but it puts the wraith exactly where the Rosselini wants it.
System: The necromancer must be in an enclosed space, form a circle of human bones, or paint one using his own vitae. The player must spend one blood point (more if painting a circle, with volume at Storyteller discretion) and roll Wits + Theology (difficulty 7, reduced by one if a Fetter within the area is identified, by two if the Fetter is harmed, and three if the Fetter is destroyed). If the wraith was within the area affected by Expurgate the Damned prior to the roll, a success ejects it from the Shadowlands and in to the living world in a vulnerable, physical form. A failure results in the Power not working; a botch pulls the vampire through the Shadowlands, where she finds herself subject to whatever the wraith has planned.
Wraiths expurgated into the necromancer’s area bear the statistics in V20 Dark Ages (p. 403), and can soak both bashing and lethal damage. Wraiths brought forth in this way can freely return to the Shadowlands, but few do when their Fetters are under threat.

••• Blood Scourge
Blood Scourge allows a necromancer to inflict torturous pain on a wraith, much to the delight of the Inquisition and Rosselini necromancers. The power demands sacrifice on the part of the necromancer, as she must give of her own vitae. As a bearer of True Faith may possess blood of burning glory, the necromancer’s sanctified vitae inflicts purgative pain on the damned. Most necromancers take their time using this power, as a means of drawing out the suffering, and whittling secrets from the spiritual victim. The corpus of the wraith peels off in rotting chunks as the vitae connects with it. The Blood Scourge is a truly foul necromantic weapon.
System: The player spends a minimum of one blood point. The vitae flows freely from the palms and soles of the necromancer, who may cast her hands as if wielding a whip against the spirit before her. The player must roll Melee + Dexterity for her Cainite to hit the wraith, with the wraith granted the chance to dodge if in a position to do so. For every point of blood spent, the necromancer will inflict this number in aggravated damage on the wraith. This burning vitae causes such agony as to increase the difficulty by two on any attempt by the wraith to use its powers.
Blood Scourge cannot harm wraiths in the Shadowlands, unless the necromancer is present there.

•••• Cursed Eucharist
Necromancy is a costly endeavor, often leaving its masters drained and cursed for following paths none were meant to tread. The Path of Woe allows a resurrection for the necromancer, at the point her determination is flagging. To the necromancers on this Path, the Cursed Eucharist is a gift from God and proof He wants them to continue their holy work. Only by locking their fangs on a wraith, does God show this blessing.
System: The player rolls Stamina + Theology (difficulty 6) while the necromancer attempts to feed from a wraith. On a failure, nothing happens; a botch results in burning ichor being drained from the spirit, causing one level of aggravated damage to the Cainite. Success converts the Passion being drained from the wraith into temporary Willpower, at a rate of one Willpower to every two points of Passion being consumed.

••••• Purge the Apostate’s Soul
The Rosselini take their papal mandate seriously. It allows them to practice their Necromancy freely in a world increasingly hostile to magic. Boiling heretics’ souls and drinking the run-off is an honor and bonus to the truly malign members of the faith, who recognize the warm benevolence of God in the allowance of their terrible acts. Purge the Apostate’s Soul is an infallible method of sending spirits to Oblivion.
Blood magicians narrow their eyes at practitioners of this power, recognizing similarities to their own Cauldron of Blood (see V20 Dark Ages p. 302), and wondering whether a necromancer stole and reworked their power. Necromancers of course insist that it’s quite the other way around, their power being eminently superior and blessed by the Inquisition.
System: The player spends three points of Willpower and rolls Intelligence + Theology (difficulty 8), while the necromancer is in the presence of at least one wraith. Failure results in nothing happening; a botch reverses the effect onto the vampire. Each success inflicts a level of aggravated damage on the soul of the wraith and anyone else within a 10-meter (11 yard) radius of the necromancer, mortal or undead. For every health level lost by the wraith, a sloughed pool of ectoplasm is produced. The necromancer can drink this, recovering one point of Willpower for each pool lapped up from the ground.
The use of this power irreversibly contaminates the 10 meter (11 yard) radius surrounding the necromancer, making it a sphere where life is incapable of growing, and into which wraiths can never again enter.]==],
				},
				["The Path of the Ailing Jackal"] = {
					en = [==[Rites of Blood, p. 160


The Path of the Ailing Jackal


Many of the paths associated with Dur-An-Ki are functionally identical to various Thaumaturgy paths. In many cases, the Dur-An-Ki version came first and was adapted to Thaumaturgy by Tremere.
The Path of the Ailing Jackal is one of those paths: it is functionally identical to The Path of the Father’s Vengeance (V20, pp. 226-228).]==],
				},
				["The Path of the Evil Eye"] = {
					en = [==[Rites of Blood, p. 160


The Path of the Evil Eye


Throughout history, the ignorant and superstitious have feared the Evil Eye — a belief that some people have the power to curse their enemies, whether through the invocation of dark powers or simply through malicious will. In some places, such beliefs persist, perhaps in part because of the existence of this Path, which allows an ashipu to invoke wrathful djinn to embarrass, injure, or even kill his enemies. But this Path is not the exclusive province of Dur-An-Ki. Its ancient pedigree means that it is known to many Old Skool Anarchs who have preserved the power to curse over the ages, while its sheer vindictiveness has ensured that modern Punk Sorcerers have learned to duplicate its effects.
To use the Evil Eye against a target, the sorcerer must either be able to make eye contact with her and say something to indicate his disdain, whether a traditional Arabic curse or simply a shouted “Fuck You!” Alternatively, the sorcerer can make use of an effigy to cast the curse over a longer distance (as described under the Principles of Contagion and Sympathy on pp. 133-135). The target will not necessarily realize that she has been cursed. An Intelligence + Occult (difficulty 6) roll is required of the target if the sorcerer casts the curse in her face, while a roll at difficulty 9 is required to realize that recent bad luck is the result of a curse cast from afar. A character with Aura Perception or who has at least one dot in this Path may notice tell-tale signs of a curse lingering in the target’s aura and may recognize this as the residue of a curse with a Wits + Occult roll (difficulty 7). A character who successfully identifies a curse this way may treat the curse itself as a mystical connection equivalent to a prized possession while in the presence of the cursed individual.
The sorcerer who laid the curse can negate it at will. Any other character capable of recognizing the curse (including the target herself, if she has the appropriate knowledge of blood magic) may attempt to negate it with Thaumaturgical Countermagic (V20 p. 228) or any comparable blood magic effect. The one who lays the curse never knows exactly how the curse will manifest itself. Each level of this Path sets the parameters for what type of harm may occur, but the Storyteller determines the precise nature of the manifestation.

• Humiliation
The simplest application of the Evil Eye causes the target to embarrass himself in some public way. Possible results include saying something embarrassing in front of one’s peers, failing disastrously at a feeding attempt, or simply ripping the seat out of one’s pants while in a crowded bar.
System: Each success represents one night during which the target is affected by the curse. The curse triggers once per night at a time of the Storyteller’s choosing, usually the scene during which the character is in front of the largest number of individuals or in which he is in front of the largest number of socially important people. That is, it may trigger while the character is in a crowded restaurant or when he is alone with the Prince, whichever has the greatest potential for personal embarrassment. The Storyteller determines when the curse triggers, but it should do so at least once per night.
During the trigger scene, on every Social roll made for the character, the player must add a number of automatic 1s equal to the sorcerer’s rating in the Path of the Evil Eye, thereby increasing the likelihood of a botch on a Social roll. In addition, during the trigger scene, the Storyteller should roll a number of dice equal to the sorcerer’s rating in this path (difficulty 5). Successes mean that some external event happens that causes embarrassment to the character, such as a waiter spilling drinks on him or a car splashing him with mud.

•• Loss
This curse affects the target’s material worth. It most commonly causes the target to be stripped of money, but it may also cause her Herd to diminish, or destroy a Haven. The curse can target any tangible asset represented as a Background. If the character has no suitable Backgrounds, it targets personal items of emotional significance.
System: Within one week, the target loses one dot from an appropriate Background. Generally, the curse preferentially attacks Resources over other Backgrounds, but theoretically any form of tangible Background representing a personal asset can be a valid target. The sorcerer has no control over how the Background point is lost or even which Background point is lost. The Storyteller may even choose to decide randomly.

••• Peril
At this level of mastery, the ashipu may finally endanger her enemy rather than merely inconvenience her. The curse cannot directly harm the target, but it can create a situation in which it is possible for her to be harmed, whether at the hands of a drunken lout who takes offense to the target’s manner at a bar or a pack of werewolves who, by happenstance, choose to board the same lonely subway car as the victim.
System: The number of successes determines how many nights the character is at risk. At the start of each night, the Storyteller must roll a die and, depending on the results, fashion an encounter for the targeted character.
1-3 — None. The curse does not trigger during this night.
4-6 — Minor: An encounter which is not likely to harm the character but which has a chance to do so. A mortal tries to mug the character while she is in front of mortals, or simply tries to hold up a convenience store while the character is in line paying for gas. A bar patron takes offense to something the character does or says and tries to pick a fight.
7-8 — Moderate: An encounter with a significant likelihood of at least some harm to the character. The character is involved in a car wreck or struck by a hit-and-run driver. Stairs give way while the character is climbing them.
9 — Severe: An encounter in which the character is almost certain to suffer some lethal damage. The character inadvertently says something offensive that provokes frenzy rolls in nearby vampires. The building collapses while the character is in it or a fire breaks out.
10 — Catastrophic: An encounter that is potentially deadly. The character’s is locked out of his haven during the day. The character unwittingly says something that offends a pack of nearby Lupines.
Nights on which there is no peril do not count against the ashipu’s successes; the curse will continue until the target has suffered a number of dangerous encounters equal to the successes or the curse is lifted. During any dangerous encounter, a targeted character has a chance to realize she is under a curse (if she didn’t already know it). The roll is Intelligence + Occult. The default difficulty is 9, but it drops to 8 if the character has Auspex or to 6 if the character has any knowledge of this Path.

•••• Enemy
This potent curse causes the target’s friends and allies to turn against him, even as it causes the numbers of his enemies to grow.
System: For each success on the Willpower roll, the target loses one dot of Allies, Contacts, Influence, or Retainers. This may reflect friends and allies who have become angry with the character and turn their back on him, it may reflect contacts and allies who are simply unavailable for a time, or it may actually result in such characters being injured or even dying due to ill fortune. Alternatively, the player may choose to spend some or all of the successes to give the target a new Enemy (as per the Enemy Flaw) who arrives to pursue a vendetta against the character. Regardless, the effects manifest within a week, and the player of the targeted character may neither regain lost Backgrounds nor remove the Enemy Flaw without learning about and neutralizing the curse.

••••• The Eye That Wounds
The ultimate expression of this malefic path, the Eye That Wounds does not require time to establish a chain of ill fortune. It strikes immediately. The ashipu must make eye contact with her target and utter some exclamation pertaining to a characteristic of his. It can be praise or insult, sarcasm or fury, but whatever form it takes, the target is immediately struck with an agonizing injury that damages that characteristic.
System: While the curse allows for flexibility, the default assumption is that for every two successes (rounded up), the target (or object, if the curse is directed toward a possession of the target) suffers one level of aggravated damage. Generally, even a single level of damage is sufficient to slay an animal or destroy most objects. If used against a mortal, this power will permanently maim him. If used against a Kindred, the curse will inflict damage shaped by the ashipu’s words. If she compliments his beautiful eyes, they will be burned and he might be rendered blind until he can heal. If she mocks his honeyed words, the curse might burn out his tongue and leave him unable to speak. This curse may be transmitted through an effigy, but the normal difficulty penalty imposed for using an effigy increases by +2 (see Principles of Contagion and Sympathy on pp. 133-135).]==],
				},
				["The Path of the Twilight Garden"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 289


The Path of the Twilight Garden


Known to outsiders as “The Path of the Four Humors,” the Path of the Twilight Garden is among the most closely-guarded secrets of the Lamiae. The Discipline arose from ritual practices of the Cult of Lamia, though like the Lilin themselves, the Path of the Twilight Garden has a martial bent.

• Whispers to the Soul
Merely a hearing the whisper of the true name of the Dark Mother is enough to drive mortals mad, and fill the hearts of the Cainites with terror.
System: A Lilin whispers one of the secret names of Lilith. Any single target within 100 paces and in the character’s line of sight will hear the whisper as if the invoker were speaking directly into his ear. The target must immediately make a Willpower roll (difficulty 8) or be tormented by nightmares and hallucinations for a number of days and nights equal to the invoker’s Manipulation score. This causes the target to lose two dice from all dice pools for the duration of of the power.

•• Kiss of the Dark Mother
The Lilin bites her tongue and fills her mouth with a foul, acrid mix of black bile and vitae. Her bite becomes even more terrible, and she can devour the life from her victims with ease.
System: The player spends a blood point as the vampire fills her mouth with the caustic substance. The next bite attack she makes deals double damage before soak is applied. This does not make feeding more efficient, nor does it exacerbate the damage done by blood loss. If the vampire does not use a bite attack on a target, her bite remains potent for the rest of the night.

••• Dark Humors
The Lamiae are known for their athleticism and mastery of their bodies. Not only are they able to perform feats of incredible physical prowess, but they can also manipulate the balance of humors in their body by sheer force of will. With the use of this power, a Lamia can transubstantiate her own vitae into one of four corrupted bodily humors, each with its own effect.
System: The player spends two blood points as the Lamia cuts open her skin (she may use a knife, bite her tongue, or simply rake her skin with her claws). She transubstantiates a small amount of blood into one of the humors described below. She may also use this as a defense against another vampire that is feeding on her. The target needn’t ingest the humor to suffer its effects; skin contact is all that is required.
The four humors are:
Phlegmatic: Exposure to phlegmatic humors makes the target lethargic. All dice pools are reduced by two for the remainder of the scene.
Melancholy: Melancholic humors plunge the target into deep despair. For the rest of the scene, he may not spend any Willpower points and the difficulty of all his Willpower rolls is increased by two.
Sanguine: When exposed to sanguine humors, the target becomes prone to excessive bleeding. Any lethal or aggravated wounds will deal an extra level of damage of the appropriate type on the following turn.
Bilious: Bilious humors poison the target, inflicting a number of levels of lethal damage equal to the necromancer’s Stamina.

•••• Caul of the Neverborn
With the use of this power, the Lamia strengthens her connection to the black heart of the Dark Mother. By completing a short ritual wherein she drinks at least five points’ of blood from a cold corpse, she gains some of the hard-won strength and wisdom of the long-suffering Lilith.
System: The vampire drinks at least five points’ of blood from a cold corpse, then spends five points to invoke the power. She then transforms on a spiritual and physiological level; her eyes become solid black, her manner becomes distant and cold. She gains two additional soak dice and immunity to all wound penalties for the remainder of the scene. With a successful Perception + Occult roll (difficulty 7), she may see into the Shadowlands and speak with any ghosts there. Finally, she can immediately tell the relative health of any being she sees, as injuries and diseases manifest themselves vividly on a creature’s aura.

••••• Lament of D’hainu
The Lamia howls in agony, and the very earth trembles. A miasma of writhing darkness rises from the ground and ensnares her enemies. Those caught by the darkness are not physically bound, but are immediately stricken with emotional anguish so rich and raw that they seek to end their lives in the most expedient way possible.
System: The player rolls spends two Willpower points and rolls Stamina + Athletics, difficulty 7. For every success she rolls, the radius of Lament of D’hainu increases by five yards/meters. Anyone within the radius of the Lament (except the necromancer) must make a Willpower roll, difficulty 7. If the Willpower roll fails, the Lament’s victims are overcome with despair and seek to end their lives immediately. Men will fall on their swords, lupines will tear out their own throats, and mages will turn their magics against themselves. Unless stopped, a victim of the Lament will not cease in her quest for death until she succeeds in killing herself. Cainites affected by the Lament are not driven to suicide, but rather fall into torpor immediately. Even if the target succeeds at the Willpower roll, he shakes off his suicidal urges, but her dice pool for all actions is reduced by two for the remainder of the scene. If a victim who failed the Willpower roll has not succeeded in killing herself by the end of the scene, the effects of the Lament wear off, but her dice pool for all actions is reduced by two until the next sunrise.]==],
				},
				["The Revelations of Duat"] = {
					en = [==[Dark Ages Tome of Secrets, p. 61


The Revelations of Duat


The Spell of Life is the purview of those dedicated to Set’s ancient enemy, Osiris. While Witches of Echidna are unable to replicate the powers of the Spell, they long ago forged the first steps on a Path of Akhu; named The Revelations of Duat. After teaching Orthodox Setites from Saqqara to Luxor in the precepts, the Gorgons abruptly abandoned Egypt and retreated to Greece. The reasons behind their departure have fallen into apocrypha, if ever they were known.
Shortly after the Gorgons departed Egypt, Cappadocians in the cult of Lazarus arrived to seek sanctuary with sympathetic Setites. The Setites — novitiates in the promising Revelations of Duat — turned to Lazarus’ get for further tutelage. The result is a Path of Setite Sorcery tainted with the gifts of Necromancy, often shared between Setites and Cappadocians willing to devote themselves to the study of death and — at the very least — lip service to Anubis or Hades.
Initiating the powers of Setite Sorcery is identical to that of Thaumaturgy (see V20 Dark Ages p. 297), except that in the place of Occult, use Theology.

• Sight of the Jackal
Sorcerers with Sight of the Jackal immediately identify ghosts who resist the call of Duat, spying free dead as they ride living vessels or hide in objects and structures. The sorcerer’s eyes gain a translucent grey film until the duration of the power concludes.
System: Additional successes allow greater perception of the strength, shape, and history of the ghost. The power lasts for the remainder of the scene. Ghosts become aware of the sorcerer on a botch, and depending on their temperament they may attack the vampire. Sight of the Jackal does not allow sorcerers to communicate with the dead.

•• Weigh the Virtues
To judge the dead, Anubis must weigh virtues and sins. The Setite practicing Weigh the Virtues is able to identify any morally compelling deeds performed by a once-living being, whether they’re using this power on a ghost, a corpse, or a vampire. Knowledge of these deeds is key to practicing the further powers on this Path, as Imbue with the Grace of Anubis is predicated on understanding the deceased’s crimes.
System: For each success, a different deed — from saving a child from a crocodile’s jaws to murdering a rival over a lover — appears to the sorcerer in vivid detail. On a botch, this power reveals one of the sorcerer’s sins to his most trusted companions.

••• Pharaoh’s Sentry
Unthinking, unemotional, unyielding sentries are the best guards a Prince could want, but to create them a sorcerer requires a dead body and a dispossessed spirit. Pharaoh’s Sentry creates an emotionless automaton who forever serves the sorcerer’s edict, acting as a warrior and vigilant guard with no moral qualms against killing, or fear of dying in service.
System: When a sorcerer practices Pharaoh’s Sentry on a corpse dead for a single night in a place a ghost haunts, a fragment of the ghost’s soul moves to the corpse and causes its reanimation. The sorcerer must have used Weigh the Virtues previously to identify a spiritual hook with which to snare the spirit. Each success allows the power to be used on a corpse dead for an additional night.
The sorcerer’s edict must be a single sentence, i.e. “You must guard this tomb from all intruders but me,” or “You must follow this man to his house, and kill him inside.” Ambiguity leads to grave mistakes. In the previous examples, “You must guard this tomb from all intruders,” would lead to even the sorcerer being attacked should he attempt to enter the tomb; and “You must follow this man to his house and kill him,” may lead to the victim’s murder at a premature point, rather than inside the hoped-for building.
The animated corpse remains active permanently without succumbing to decomposition.
A botch on attempting the Pharaoh’s Sentry causes the corpse to rise and mindlessly attack its summoner until destroyed.
Attributes: Strength 4, Dexterity 3, Stamina 5, Charisma 0, Manipulation 0, Appearance 0, Perception 1, Intelligence 0, Wits 1
Abilities: Alertness 2, Athletics 2, Brawl 3, Intimidation 2, Melee 2, Stealth 2
Disciplines: Fortitude 1
Willpower: 5
Health: 7
Notes: These sentries commonly have a reserve of seven blood points, and crumble to dust after using them. This blood is dead for the purpose of feeding, so cannot be consumed by vampires.

•••• Imbue with the Grace of Anubis
An unthinking guardian is a potent defender for havens and temples, but sometimes a sorcerer requires Anubis to return more than a flicker of life. By the jackal god’s grace, a sorcerer taps into the good deed or sin identified through Weigh the Virtues, and imbues the corpse animated through Pharaoh’s Sentry with a compulsion based on that deed. The animated corpse is still victim to the one-line edict, but now harbors emotions and inclinations based on the harvested spirit’s former deeds and will act on them when not specifically directed to do otherwise. These inclinations always manifest themselves violently.
The utility of this power comes through the chaos it causes. A sorcerer who sends a horde of corpses possessed by violent emotion into a town, knows the domain will come apart at the seams.
System: A sentry with basic memory of its defining deeds will act impulsively in ways similar to its former life; i.e. a former murderer who cut the throats of merchants will always slay any traders it meets with attacks to the neck, while a priest who assisted the poor will target the homes of the wealthy, burning them down and massacring the inhabitants. A single success plants the memory of one deed in the mind of the sentry, with each additional success giving the sorcerer the option to place another.
The spirit from which the deed is drawn for the creation of this powered sentry is aware of its virtues or sins being drained, but without the sorcerer’s aid cannot recover the piece it loses to this power. The sorcerer must spend a blood point to return the deed to the spirit from which it originated, at which point it becomes an unthinking sentry retaining the same statistics, but none of the freedom of thought.
The sentry attacks its master on a botched roll.
Attributes: Strength 5, Dexterity 4, Stamina 5, Charisma 0, Manipulation 0, Appearance 0, Perception 2, Intelligence 0, Wits 2
Abilities: Alertness 2, Athletics 3, Brawl 3, Intimidation 3, Melee 3, Stealth 3
Disciplines: Fortitude 2, Potence 1
Willpower: 7
Health: 8
Notes: These sentries commonly have a reserve of eight blood points, and crumble to dust after using them. Storytellers may augment statistics appropriate for the deed imbued in the corpse.

••••• The Sorcery of Life
In Setite apocrypha, it is said Set’s favored servants were the immortal entities known as Bane Mummies. Set and his childer attempted a version of Osiris’ Spell of Life in attempts to create their own eternal servants, but the Spell went horribly wrong. Where Osiris’ children were given eternal life, purity, and wisdom; Set’s immortal servants were possessed only of impurities, regurgitated by the demon Ammut, and reborn as Bane Mummies. Set’s frustration was destructive. He blamed his childer, and destroyed every Setite of the Fourth Generation unlucky enough to be in his presence.
Eventually, Set devoted adoration to the Bane Mummies, but ever resented the failures of his childer in their creation. Bane Mummies still exist, but the secret of their conception is something guarded within the temple sanctums of the Hierophants. Few wish to anger Set in such an egregious way as to create new Bane Mummies.
The Witches of Echidna — certain of an impending doom — are not so apprehensive. Their studies reveal a different route to empowering their servants, and in concordance with Lazarus’ Cappadocians bequeath this research to the Egyptian Setites. With the Sorcery of Life, a form of Proto-Bane Mummy is twisted into life. The practitioners risk their founder’s displeasure creating of these servants, but measure the gamble as one worth taking.
System: The sorcerer must have taken steps necessary to Imbue with the Grace of Anubis, and hold in their thrall an animated corpse bearing the fire of emotion-fueled deeds. Each success converts to points the sorcerer can assign to the sentry’s Attributes or Disciplines. Any Disciplines granted to the sentry must be from those the sorcerer holds. The Proto-Bane Mummy is still subject to the sorcerer’s whims, but will attempt intricate tasks if its Intelligence is increased to allow understanding of complicated commands.
As with Imbue with the Grace of Anubis, the spirit harvested for the creation of this Proto-Bane Mummy is aware of its virtues or sins being stolen. The sorcerer must spend a blood point to return the deed, at which point the corpse becomes an unthinking sentry retaining the same statistics, but none of the freedom of thought or capability to use Disciplines.
Attributes: Strength 6, Dexterity 4, Stamina 6, Charisma 1, Manipulation 1, Appearance 0, Perception 3, Intelligence 1, Wits 2
Abilities: Alertness 3, Athletics 3, Brawl 3, Intimidation 4, Leadership 1, Melee 3, Stealth 3, Survival 2, Occult 2, Theology 1
Disciplines: Fortitude 2, Potence 2
Willpower: 9
Health: 12
Notes: These are the default statistics for the Proto-Bane Mummy, before additional successes are translated to additional points. These monsters commonly have a reserve of ten blood points, and crumble to dust after using them. They can acquire further blood through eating a vampire or mortal’s flesh. Storytellers may augment statistics appropriate for the deed imbued in the corpse. Proto-Bane Mummies can soak all but aggravated damage.]==],
				},
				["The Revelations of Eden"] = {
					en = [==[Dark Ages Tome of Secrets, p. 64


The Revelations of Eden


Cainites know the Followers of Set for their duplicity and prowess in manipulation. Few warrant this reputation more than the Decadents of Constantinople, otherwise known as the Children of Judas. Referred to as heretics by the Hierophants, the Children of Judas are suspected to be the next targets for elimination once the Theophidian Witches’ fall is complete.
Despite opposed ideologies, it’s perhaps their shared desperation forcing the Witches of Echidna to provide fleeting tutelage to the Decadents. Khay’tall’s faction never requested their aid, but welcomed it before his destruction; his Setite followers have picked up the reins of the Revelations of Eden in the wake of the Witches’ departure.
A simple Path at its core, the Revelations of Eden break down the will and faith of a victim, allowing room for the Serpent of Eden, Sutekh, or whichever god the sorcerer chooses to take its place. The ultimate corruption found in Path comes with most victims’ willing submission to its powers. Like Presence, this Discipline generates a feeling of contentment and desire in its subjects.
Initiating the powers of Setite Sorcery is identical to that of Thaumaturgy (see V20 Dark Ages p. 297), except that in the place of Occult, use Theology.
System: One success is enough to erode a victim’s temporary Willpower. Every additional success removes a further point of temporary Willpower, with higher ratings in the Path bestowing additional effects on the victim. These effects are not cumulative. The victim may attempt to resist the effects of the Discipline with a Willpower roll (difficulty 6). A botch by the sorcerer grants the victim a recovery of all temporary Willpower. A botch by the victim forces the loss of one point of Conscience/Conviction. This power cannot be resisted by using temporary Willpower. Losses noted as permanent can only be recovered via the torpor or Final Death of the Setite sorcerer responsible.

• Remove one point of temporary Willpower from the victim, and one dot from her Willpower rating.

•• From the victim remove one point of temporary Willpower, and one dot from her Road rating.

••• From the victim remove one point of temporary Willpower, and one dot from her Self-Control/Instinct.

•••• From the victim remove one point of temporary Willpower, and choose her new Demeanor.

••••• From the victim remove one point of temporary Willpower, and choose her new Nature.]==],
				},
				["The Revelations of Midgard"] = {
					en = [==[Dark Ages Tome of Secrets, p. 65


The Revelations of Midgard


The story of Arnulf “Jörmungandrsson” is infamous among Setites. A Norse merchant turned cultist, ghoul, and ultimately a vampire, Jörmungandrsson was Embraced in Egypt with great pomp and ceremony. His return to the Kingdom of Norway was predicted by the Witches of Echidna to spawn a new front in Typhon’s battle against the Aeons. Instead, Jörmungandrsson formed a new cult dedicated to the Midgard Serpent as an aspect of Apep; antithetical to the majority of Setites, but far enough away to not be immediately destroyed by the Theophidians. The Jörmungandrsson imbroglio is a sore point among Orthodox Setites, who swiftly erased record of Arnulf’s Embrace, but could do little to remove the widespread word of the prodigal son who abandoned his clan.
For centuries the Hall operated its cults in pleasurable isolation from other members of their clan, their philosophers following a version of the Path of Apep (see V20 Dark Ages p. 449) they call the Path of Jörmungandr. In recent years, members of the cult traveled beyond Scandinavia and encountered the Witches of Echidna in the Courts of Love and Fiefdoms of the Black Cross, suffering persecution from the clan’s Orthodoxy. In solidarity, the Hall granted the Witches alms, and in turn were taught the principles of a sorcery they call The Revelations of Midgard. The Gorgons were impressed by the Hall’s devotions to its cultists, seeing in the Norse vampires a devotion to family once shared by the Setites of the Nile.
The Revelations of Midgard allow members of the Hall of Jörmungandr to draw on their inner faith, and with it bolster their ghouls, beasts, and mortal servants. While their faith is inarguably debased, the powers gifted to them by the Gorgons reinforce followers’ devotion to the cult.
Initiating the powers of Setite Sorcery is identical to that of Thaumaturgy (see V20 Dark Ages p. 297), except that in the place of Occult, use Theology.

• Bestowment of Scales
Perhaps more than any clan, the Followers of Set value the worth of their cultists. Many see little difference between the status of a mortal, ghoul, or vampire, in service to their god. This is a belief permeating the clan in all its varied forms. For the love of their cultists, practitioners of Bestowment of Scales may absorb harm dealt to their favored servants, who gain patches of serpent scales on the flesh that would have otherwise been harmed. These scales never disappear, evidencing the grace of Set and the Midgard Serpent.
System: Bestowment of Scales affects any living creature or ghoul from whom the Cainite has fed, no matter the distance. When such a cultist incurs harm, the sorcerer can reflexively apply her undead endurance to the cultist’s body, the damage being transferred to the vampire. The Cainite can soak this damage in the normal way, though any damage not soaked by the vampire is suffered by the cultist. The cultist develops scales in the place they would have suffered harm. Depending on the location, this can reduce the cultist’s Appearance rating, though Setites acknowledge the deformity as a blessing. A botch on this power allows the vampire to absorb the damage, but prevents her from soaking any of it.

•• Suffer for Jormungandr
Above all else, the Followers of Set are a clan of faith. Belief inspires its bearers with the ability to perform great deeds, both noble and destructive. The Hall of Jörmungandr teaches all its cultists to suffer for their beliefs; with sacrifice comes reward. Those who give of themselves for faith will surely receive spiritual recompense. Vampires who use Suffer for Jörmungandr put this belief to the test, as for their own survival, they bestow heinous wounds on their cultists. The cultists suffering in this way gain serpentine features — a narrowing of eyes, flattening of a nose, webbed fingers, and loss of hair.
System: When a Cainite schooled in Suffer for Jörmungandr receives physical harm, she may apply that harm to a mortal servant from whom she has taken blood, and to whom she has given vitae. The cultist must be within eyeshot of the sorcerer. Suffer for Jörmungandr is activated reflexively unless the vampire chooses not to use it. For each success accrued beyond the first, the vampire may inflict an additional level of the damage that she has incurred on her chosen cultist. Damage acquired in a single turn may not be distributed among multiple cultists, and any damage exceeding the cultist’s health track will return to the vampire to soak or incur. The manifestation of this power reduces the cultist’s Appearance rating gradually, at Storyteller discretion. A botch on the roll for this power still transfers all damage to a cultist, but each point is converted to aggravated if it’s not already so.

••• Swallow the Tail
The Hall of Jörmungandr believes in the pre-eminence of the Midgard Serpent, fated to ingest its own tail until it rears and devours the world. This strange power’s symbolically similar to the myth, allowing the vampire to replenish any blood spilt in battle. Whether pouring from a lesion, staining clothes, or pooled on the ground — sorcerers are able to draw the blood to them in dancing rivulets. Setites are known to take grievous injuries, their vitae scattering around them, before locking their foes in a hypnotic gaze as the blood upon the earth crawls its way back into their mouths like tiny snakes. Any cultists in the presence of the Setite practicing this power find the blood in their veins bulging to escape. It does not, but forever after the cultists bear snakelike blood vessels prominently marking their skin.
System: This power is always activated as the final action of a turn, after Celerity actions. Blood within eyeshot of the vampire slithers towards her, taking a turn to reach her mouth and replenish lost blood points. It is the Storyteller’s discretion how many blood points are in the surrounding area, but each success rolled allows one blood point to slink towards the sorcerer. On a botch, the power forces the vampire to disgorge ten blood points minus her Road rating. This power cannot be used to drain blood from a living or undead vessel.

•••• Cycle of the Midgard Serpent
The Hall of Jörmungandr places family upon a high pedestal. Sorcerers know the importance of mortals and ghouls; cultists sustain their efforts. As they drain blood from the kine, the sorcerers return terrible, poignant gifts to the cult as proof of their god’s pleasure. Setites who learn Cycle of the Midgard Serpent impose one of the greatest gifts of blood magic possible on their cultists — the ability to draw on their masters’ Disciplines. Cycle of the Midgard Serpent allows sorcerers to vicariously act through their followers, though they have no control over how their cultists use the powers imparted.
System: A Setite using this power may impart points in Disciplines to a ghoul who’s consumed at least one point of her blood. The number of Discipline points bestowed is equal to the number of successes rolled. The power remains until the sun next sets. Some powers are dangerous or actually self-destructive if a mortal uses them. The Storyteller has the final ruling on whether a ghoul can use a given Discipline.
For the purposes of Disciplines that require the expenditure of blood points to activate, the ghoul possesses an equal number of blood points to those consumed from the regnant on the night the power is activated. A botch on this roll results in the ghoul gaining the points in Disciplines until the next sunset, but the blood bond to his domitor breaks. The breaking of this bond is not known to the vampire.

••••• Apep’s Transformation
To some carrying Set’s blood, their epithet as Followers of Set is inaccurate. The Witches of Echidna did, in recent years, come to the suspicion that while their founder may be a monstrous demigod of capricious and devastating power, the name Set is incorrect. Whatever their founder was, it posed as Set, Typhon, Apep, and even the Midgard Serpent in efforts to achieve worship and slavish adherents. Something in the blood of this Mother of Monsters manifests through Setites using high levels of Serpentis to change form. Apep’s Transfiguration allows a Setite to inflict this change — one the Gorgons claim is Set’s true form — on a loyal follower. The change is wracking, and painful, but the glorious physique achieved quickly converts or consumes non-believers.
System: This power only affects a mortal or ghoul cultist who’s imbibed the blood of the vampire sorcerer. On a successful roll, the cultist’s body spends ten turns — minus the number of successes rolled — contorting and shifting into a limbless serpent, its arms and legs sloughing off as an amalgamation of dead skin, tissue, and bone. The Apep cultist bulges into a serpent form approximately the size of a destrier. It cannot speak, but can understand its creator’s language. The change into an Apep cultist is permanent. The serpent remains loyal to the vampire as a bestial ghoul, still requiring regular doses of vitae. Any Revelations of Midgard powers usable on followers remain usable on the Apep cultist. A botch on the roll to perform this power kills the cultist and provokes a frenzy test for the sorcerer, as she’s presented with a humiliating failure of faith.
The Apep cultist has the following statistics:
Attributes: Strength 5, Dexterity 5, Stamina 4, Charisma 3, Manipulation 1, Appearance 1, Perception 3, Intelligence 2, Wits 3
Abilities: Alertness 4, Athletics 4, Brawl 5, Intimidation 5, Performance 3, Stealth 4, Survival 3, Theology 3
Disciplines: Fortitude 1, Potence 2, Presence 2
Willpower: 9
Health: 15, no wound penalties
Notes: The Apep cultist commonly has a reserve of ten blood points, and sinks into a torpid state without blood. They can acquire further blood through drinking from a victim. Apep cultists can soak all but aggravated damage. Its bite attack uses eight dice (Strength + 3).]==],
				},
				["The Taking of the Spirit"] = {
					en = [==[Rites of Blood, p. 170


The Taking of the Spirit


By calling upon the power of Hell, this path allows the infernalist to strip away the temporary Willpower of her victim, leaving an almost soulless automaton ready to serve the infernalist without question. Some fiendish vampires have built entire legions of servants for themselves with this power. This fearsome path works on vampires and kine alike.
System: The infernalist loudly calls forth the legions of Hell to steal away the spirit of her target and then touches her target. Depending upon the circumstances, the Storyteller may require a successful Dexterity + Brawl roll for the thaumaturge to make contact with the intended victim. Once contact is made, the infernalist must engage in a contested Willpower roll against the subject (difficulty 8). Success means the victim loses a number of Willpower equal to the infernalist’s successes.
If the victim accumulates more successes on this contested Willpower roll before being reduced to zero Willpower, he resists the powers of Hell. In addition, the suffering he endured hardens his mind, and this infernal path may not be used against him again a full year.
If the victim is reduced to zero Willpower, he must do the vampire’s bidding, not speaking, staring blankly forward, in a state much like a zombie until he has regained one dot of Willpower, as per the chart below.
If the infernalist is killed, the victim regains all of his lost Willpower immediately.
A botch on the part of the infernalist has unique results: He loses a number of temporary Willpower points that corresponds with his mastery of said path. These Willpower points return at a rate of one per night. If all points are lost, he may come under the control of otherworldly forces.
The Willpower siphoned by this power returns at a rate determined by the infernalist’s rating in the path:

• Return of 3 Willpower points per day’s rest

•• Return of 2 Willpower points per day’s rest

••• Return of 1 Willpower point per day’s rest

•••• Return of 1 Willpower point per week’s rest

••••• Return of 1 Willpower point per two week’s rest]==],
				},
				["The Transylvanian Kraina"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 275


The Transylvanian Kraina


Koldun of the Transylvania region practice the following magics.

• Burebista’s Throne
Legend has it that King Burebista, who terrorized the Greeks for centuries — first as the mortal king of Dacia, and later as a mighty koldun — built a great throne atop a mountain peak from which he could survey all his lands and track the movements of all his enemies. The legend is true, though in time Burebista no longer needed the throne to observe his kingdom. He passed on this secret to his childer, and today most every koldun of the Transylvanian kraina can sit upon his throne.
System: The koldun spends a blood point and makes the activation roll (Attribute: Perception). If atop any mountain in Carpathia, there is no need to expend blood. On a success, the koldun can send his senses soaring high into the air, or extend them beyond their body; how far depends on how many successes are rolled (see below). This effect lasts until the koldun pulls back his senses or the end of the scene, whichever comes first.
1 success — A 50 yard/meter radius
2 successes — A 100 yard/meter radius
3 successes — A 500 yard/meter radius
4 successes — A mile/1.5 kilometer radius
5 successes — A three mile/ten kilometer radius

•• Pietrosu’s Hospitality
Mount Pietrosu is the highest, and most dangerous, peak in the Carpathians, where the biting winds and frigid temperatures will kill an unprotected man in mere moments. A perfect setting to destroy one’s enemies. Getting an unprepared foe up Pietrosu is quite difficult, however; much easier, the kolduns reason, to take the mountain with them.
System: The koldun must toss the requisite blood into the air (unless they are standing within sight of the Carpathians, in which case no blood expenditure is required) and make the activation roll (Attribute: Dexterity). If they succeed, a powerful, frigid wind arises all around the koldun for a number of turns equal to successes rolled. This wind causes one level of bashing damage each turn and numbs the bodies of anyone except the koldun caught within, reducing their movement by half and Dexterity pools by two. On the turn after this power expires, the Dexterity penalty is reduced to one and movement is three-quarters, and the turn after that the victim regains full Dexterity and mobility. A useful side effect of this power is that the koldun is immune to the cold and force of wind while this is active; when trekking in mountains or other environs where wind may be a hazard, they need only activate Pietrosu’s Hospitality to ward themselves from danger.

••• The Banks of the Basca
When the rains come in the Carpathians, the Bâsca leaps its banks and whole villages are swept away, along with any person, living or dead, unwise enough not to seek higher ground. The koldun wielding this power carries with her the surging might of the Bâsca wherever she goes.
System: The koldun releases her blood into running water - a river or stream is most common, though a rivulet or even just runoff from thawing snow is enough — and rolls to activate this power (Attribute: Strength). On a success, the blood bolsters the flow, causing it to swell and surge forward, a flash flood given magical life. Anyone, as well as most anything not secured to the ground, caught in its path will be swept away towards the point of lowest elevation at a rate of a hundred yards a turn, and must soak five dice of bashing damage per turn. Any subject somehow prevented from being carried downstream — wedged against a wall or other immoveable object, for instance — takes twice the normal amount of damage. Additionally, mortals must make a swimming roll (difficulty 8) each turn to avoid swallowing great mouthfuls of water; failure inflicts one additional level of lethal damage which cannot be soaked. These rushing waters last for a number of turns equal to successes rolled to activate the power, or twice that number if the source of the flooding is any Carpathian river.

•••• Kupala’s Exhalation
In the Berca basin, near the Eastern Orthodox monastery of Ratesti, vegetation ceases to grow and the strange gasses of the underworld bubble up into our world, forming tiny cones of mud that quickly harden while they exhale their frigid breaths. Some koldun have learned to summon these deadly gasses for themselves; they claim it’s the breath of Kupala himself. They may be right.
System: The koldun expends blood, at least one point’s worth but as much as she wants, and rolls to activate this power (Attribute: Stamina). Once per turn, for a number of turns equal to the successes she rolled, to a limit of however much blood was spent, she may cause the gasses beneath the ground to erupt upward, forming a tiny volcanic crater. These gasses are bitingly cold; anyone caught within a ten-foot radius of the cone is subject to the same damage and penalties as Pietrosu’s Hospitality. Even worse, the bubbling gas is highly flammable; any nearby flame will ignite the gas in a terrible explosion, inflicting five dice of lethal damage (aggravated to vampires) to all those within range of the cone. If this power is activated within the Berca basin, each blood point spent counts for double.

••••• Restless Medias
From time to time, the ground beneath the village of Medias will shake and roil, tearing buildings from their moorings and sometimes even killing the unwary. The locals blame the gods, but the koldun know it is Kupala, restlessly stirring within his earthen tomb. Those with the greatest skill know how to rouse his agitations.
System: The koldun spends a Willpower point in addition to the usual blood point and activation roll (Attribute: Strength). If used within sight of the Carpathians, no blood point expenditure is necessary. Each success allows the koldun to either affect a larger area (see below) or prolong the earthquake’s duration. Anyone and anything caught within range of the quake is subject to ten dice of lethal damage each turn they remain in its area of effect, and must make a Dexterity + Athletics roll (difficulty 8) or else be knocked off their feet. Most homes and simple structures will collapse after a turn or two; structures of sturdier construction, such as castles, remain standing four or five turns before they are utterly destroyed.
1 success — One home or a small building
2 successes — Several buildings, as many as five
3 successes — An entire street in a town or village
4 successes — A large structure, such as a castle
5 successes — An entire village, or a portion of a city]==],
				},
				["The Way of Earth"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 448


The Way of Earth


Capable of great destruction and great healing, the earth is the womb of life and the sepulcher of death. It drinks all blood violently spilled upon its soil, and so mirrors the vampire. It is by association with the earth as a source of strength that a koldun enacts his will.
Attribute: Stamina

• Grasping Soil
A koldun invoking this power may command earth to rise in a spray of dirt and crawl up a victim’s legs. This power can only command soil, not stone, and may only target victims standing on the earth.
System: The koldun may direct any patch of earth within a 100-foot/30-meter radius to ensnare a target for two turns per success rolled. Animated dirt ascends and constricts midway between the victim’s knees and hips, holding her fast unless her player scores five successes on Strength + Survival roll (difficulty 6). It is also possible to use this power as an attack, in which case the grasping earth crushes once and then releases. Used in this manner, each success on the casting inflicts one level of lethal damage. Such damage manifests as broken legs and crushed feet.

•• Endurance of Stone
Drawing the essence of earth into himself, a koldun may gain a measure of its preternatural resilience. Under the effects of this power, a vampire’s skin resembles a horrid fusion of flesh and stone that cracks and flows impossibly with every movement.
System: A successful activation roll grants the koldun two extra dots of Stamina for the rest of the scene. These dots are considered part of the character’s natural Stamina and may aid in any uses of that Attribute, including soak.

••• Hungry Earth
Expanding on the power of Grasping Soil, a koldun may use this power to drag a victim into the earth. He need only gesture and the soil beneath his victim opens like the maw of a great beast. This power may ensnare any victim who stands upon the earth within 100 feet/30 meters of the koldun.
System: Like Grasping Soil, every success on the activation roll leaves the victim immobile for one turn. However, the difficulty of the Strength + Survival roll to break free increases to 8 and doing so still requires five successes. As the earth continues to shift and grasp while the power remains active, this roll must be made as a single (though repeatable) attempt rather than an extended test. In addition, beings trapped in the crushing pit suffer one level of lethal damage each turn. Beings capable of soaking this damage may do so, but at difficulty 7. At the end of the power’s duration, the earth yawns once more to release the victim.

•••• Root of Vitality
As with Hungry Earth, the koldun may direct the land to bury any target standing on the earth within a 100-foot/30-meter radius. Yet this power is far more benevolent in its intent, if no less disturbing in its manifestation. The soil ripples, parting and closing like some obscene womb as it draws the target a full yard beneath the surface. Living beings entombed in this fashion do not suffocate, as the enchanted soil pumps air from above in undulating breaths. Better still, the fertile essence of the earth presses upon her flesh and restores it to new health. Still, the process is highly disturbing and unnatural, especially as targets remain wholly aware in silent, helpless immobility for the full duration. It is possible for a koldun to heal himself with this power.
System: The player spends as many blood points as desired (which may require multiple turns depending on Generation) and makes the activation roll. Each success permits the earth to heal two levels of bashing damage or one level of lethal damage. Healing aggravated damage requires two successes per level. The total number of health levels that may be restored with each use of this power is the number of blood points invested or the number of successes on the activation roll, whichever is lower. Any blood points spent beyond the number of successes drain away to no effect. The actual healing process takes one turn per bashing level, one minute per lethal level, and one hour per aggravated level. Once the healing is complete or the power is interrupted through determined excavation, the earth expels the target back to the surface.

••••• Kupala’s Fury
Mortals pray in fear when the mountains shake. They fear the wrath of the Old Gods, and rightfully so. This is not a power used lightly or capriciously, because it represents one of the greatest weapons available to Koldunic Sorcery.
System: This power requires a Willpower point in addition to the usual cost and activation roll. The koldun smites the earth with his fist, and his anger flows through the soil to any target in his line of sight. The quake erupts outward from that point, inflicting 10 dice of lethal damage on everything and everyone in the area of effect. Most wooden structures collapse entirely and even buildings of concrete and steel may grow cracked and pitted with superficial damage from the shaking earth. This tremor lasts one turn and affects an area determined by the number of successes rolled. It is not possible to apply fewer successes than those rolled.
1 success — One house or single storefront
2 successes — Five lesser structures or a small city block
3 successes — An entire side street or a large city block
4 successes — Multiple square blocks or a large structure (like a stadium)
5 successes — An entire neighborhood or massive industrial complex]==],
				},
				["The Way of Fire"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 452


The Way of Fire


The ancient anathema of vampires, the element of fire offers the most powerful and dangerous tool available to koldun. The Way of Fire shares aspects with the Way of Earth, in that it focuses more on magma and fiery rock than pure, naked flame.
Attribute: Manipulation

• Fiery Courage
No vampire can master an element he fears, so this power dims that fear to a mere ember of its former intensity.
System: Once learned, this power is permanent and requires no activation roll or blood. The koldun subtracts his rating in the Way of Fire from the difficulty of Courage rolls to resist Rötschreck from exposure or proximity to flame. This power does not aid in resisting the panic that accompanies sunlight or any other causes apart from actual fire. If this reduces the difficulty of a Courage roll below two, the koldun simply does not succumb to the Red Fear. Koldun never risk Rötschrek from fire and magma they conjure.

•• Combust
The Cainite’s eyes flash vivid orange with sorcerous power as superheated air coils around the target. In moments, the target bursts into spontaneous flame.
System: For every success on the activation roll, the target suffers one level of aggravated damage. This attack may be dodged, but not blocked, and can affect living (or unliving) beings at +2 difficulty. It is only possible to make one fiery attack per turn.

••• Wall of Magma
The koldun raises his hand and the earth splits, spraying a wall of glowing magma 10 feet/3 meters high. Normally, this wall forms a 10-foot/3-meter radius circle around the vampire, although the sorcerer can raise other shapes with practice and skill.
System: The wall of magma summoned with this power has a lifespan of two turns per success rolled. If the koldun wishes to release the magma along a shape other than a protective circle, increase the base difficulty by one. Characters cannot approach a wall of molten rock without a Courage roll (difficulty 8), and even then, the close blistering heat inflicts a level of aggravated damage. Actual contact with the lava increases the damage to three levels and raises the soak difficulty to 9, assuming any sort of soak is possible. The koldun takes no damage from his proximity to the summoned magma (although contact with it still damages him as normal).

•••• Heat Wave
The koldun acts as a conduit for steam geysers and channels a blast of desiccating air at a victim within line of sight. This fiery wind appears as a rippling heat wave enveloping the victim. Individuals slain with this gruesome power appear as withered, mummified husks.
System: On a successful activation roll, the victim suffers five levels of lethal damage that may be soaked by beings capable of such. Vampire targets also lose five blood points, regardless of the damage inflicted.

••••• Volcanic Blast
At the final mastery of Way of Fire, a koldun commands lava to explode from the ground in a huge geyser. The molten rock spews across a wide swath before crashing to earth and flowing in all directions. Anything in the path of the molten rock burns, melts, or vaporizes within moments. The caster may direct the lava to erupt anywhere in his line of sight.
System: This power costs one Willpower point in addition to a blood point. For every success on the activation roll, the initial lava burst lasts one turn. The rivers of burning liquid rock then flow sluggishly for twice this duration before suddenly cooling and hardening. Even if an object survives the heat, it now lies trapped beneath the rock. Anything that makes contact with lava (including the koldun) suffers a minimum of three levels of aggravated damage. For objects that don’t have health levels, the Storyteller must decide how many turns they last before melting or erupting into their own inferno. A botch on this power opens the lava geyser under an unintended target, possibly the koldun himself.]==],
				},
				["The Way of Sorrows"] = {
					en = [==[Rites of Blood, p. 157


The Way of Sorrows


While a part of the broader Koldunic school, this Path does not overtly rely upon a direct connection to Kupala. Rather, it invokes a number of curses in the name of various pre-Christian Slavic deities. Then again, some Tzimisce scholars speculate that at least some of those deities are themselves merely aspects of the being which calls itself Kupala. All of these effects require the koldun to be able to directly perceive the target. They cannot generally be used at range through sympathetic magic, but they can be used against a distant target whom the koldun can perceive through powers such as The Way of the Spirit or Scry (p. 153).
Koldunic Sorcery dice mechanics (Rites of Blood p. 156): the roll to activate a Koldunic Sorcery Path is a Willpower roll with a difficulty equal to (3 + Path rating), and each such roll also requires the expenditure of one blood point. The roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. These rules supersede those in V20. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.

• The Frustrations of Nestrecha
The koldun may destroy her enemy’s resolve, instilling feelings of pessimism and hopelessness.
System: For one turn per success, the target may not spend Willpower for any purpose.

•• The Insults of Krivda
The koldun unleashes a hateful insult toward his foe, thereby provoking her to mindless anger.
System: In response to the insult, the target must immediately roll Self-Control to resist frenzy against a difficulty of 5 + the number of successes on the activation roll, maximum difficulty 9.

••• The Weeping of Kruchina
The koldun may instill a crushing despair or nigh-suicidal depression in her enemy.
System: For one turn per success, the target is overwhelmed by intense misery and weeps uncontrollably. She cannot engage in any action that requires concentration, and a Kindred loses one blood point each turn as vitae streams from her eyes.

•••• The Misfortune of Chernogolov
The koldun taunts his enemy with a prediction of certain doom, which then comes to pass.
System: The target automatically loses two successes on every roll she attempts. The effect lasts for a number of consecutive rolls equal to the successes rolled.

••••• The Starvation of Marena
The koldun may now inflict direct damage on her enemy in the form of bitter cold and starving hunger.
System: For each success, the target suffers two levels of bashing damage that can be soaked normally. In addition, a vampire targeted with this power loses one blood point per success.]==],
				},
				["The Way of Water"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 450


The Way of Water


Largely practiced by koldun with havens near a large water source, this way can raise watery spirit slaves and dash a ship to splinters. More subtly, the vampire may lurk in the depths or conjure illusions to confound and dazzle his foes.
Attribute: Wits

• Pool of Lies
This versatile power creates three-dimensional illusions along the surface of a water source. How a koldun uses such illusions depends on his temperament and will. It is just as easy to feign a divine visitation as a cunning seduction.
System: With a successful activation roll, the koldun may project an illusion on any water surface in line of sight. The illusion may speak and move however the vampire wishes, though it has no substance and cannot step beyond the bounds of the water. The phantom lasts one turn per success rolled, after which it slowly dissipates into fine mist. It is possible to extend this lifespan with subsequent activations of the power, each of which stack in determining final duration. Rolls to extend an illusion’s duration add one to the base difficulty, but require no blood. Once an illusion fades away, it must be cast anew.

•• Watery Haven
Just as the Gangrel meld with the earth, so may a koldun with this power sink beneath the water to escape the sun. The vampire does not so much submerge as merge with the water. Though his slumbering form may be visible at odd angles from above, only the most determined splashing can disturb his rest.
System: This power requires no blood. If the player gains two or more successes on the activation roll, the vampire sinks into the water as per the Protean power Earth Meld. A body of water must be at least two feet deep and as large in other dimensions as the vampire’s body to contain him. Catching a glimpse of a hidden koldun in the water requires a successful Perception + Alertness roll (difficulty 8).

••• Fog Over Sea
Moving with the unnatural grace of a ghost, a koldun employing this power may stride across water as readily as land, leaving nary a ripple to mark his passing. Some vampires delight in using this power in conjunction with Pool of Lies to conjure phantasms to attend them.
System: For every success on the activation roll, the koldun may walk on water for one scene or one hour, whichever is longer. A koldun may choose to drop the effects of this power in order to submerge or swim; however, the vampire may not walk on water again unless he reactivates the power.

•••• Minions of the Deep
By dripping his blood into a body of water, a koldun may summon or rouse embodied water elementals to serve him for a night. Such minions are infallibly loyal, if not especially clever. Despite their liquid form, they are solid enough to grab a man and drag him to a watery grave or pummel him like the crashing surf.
System: The player spends one Willpower point and makes the standard activation roll. With success, the player may spend blood to summon elemental minions. This blood must be dripped or flung into a body of water, which may require multiple turns depending on generational limits for blood expenditure.
Once the last drop of blood falls, the water rises into whatever form the koldun desires. The caster may create as many minions as blood points spent, though not more than the total number of successes rolled. Regardless of their form, the spirits have a rating equal to the vampire’s Wits in all Traits. These beings have no Knowledges and no Skills apart from Stealth. Furthermore, their Mental and Social Attributes are considered to have a rating of 1 except in passive or defensive situations (such as to resist persuasion or mind-control).
Water elementals soak and otherwise suffer damage as vampires, including from sunlight. Fire harms them less, inflicting bashing damage only. Moreover, the watery creatures may extinguish flames with their liquid bodies, though not without suffering injury. An elemental who leaves the body of water that spawned it suffers one level of aggravated damage per hour. Minions regenerate one level of damage of any kind (including aggravated) each turn they remain in contact with a large body of water, but do not otherwise heal. Unless destroyed, summoned minions last until the next dawn before collapsing into inanimate puddles.

••••• Doom Tide
Many ships lie at the bottom of the Black Sea, shattered by the whirlpools of the koldun. Victims of this power must fight with every ounce of their strength or fall into the whirling, airless depths below.
System: The player spends a Willpower point in addition to the usual blood. For every success on the activation roll, the resulting whirlpool has a radius of five feet/1.5 meters, centered anywhere in the vampire’s line of sight. Whirlpools have a base Strength of 15, increasing by 5 dots per success after the first. Victims must successfully oppose this Strength with their own Strength + Survival (difficulty 8) in order to break free. Those who fail are sucked into the depths and pounded with crushing currents. Living beings drown normally, while vampires and other non-breathing creatures simply remain trapped helplessly in the vortex. This power lasts for one scene.]==],
				},
				["The Way of Wind"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 449


The Way of Wind


Subtler than mastery over earth, this way evokes the air in the breath of the living and last rattle of a dying man. In stillness or motion, koldun turn all aspects of air to their unliving design.
Attribute: Perception

• Breath of Whispers
Even in their absence, koldun instill deep fear in their servants. This power carries the vampire’s words on a light breeze and returns with the target’s reply. The vampire need only address the target by name and forcibly mimic a deep exhalation of breath as he speaks his message.
System: Every time the koldun wishes to send a new message via this power, his player makes the usual activation roll. However, the player need only spend blood the first time the power is used during a given scene. Each success permits one turn of speech. After the vampire concludes the message, swift winds carry it to its destination. Within a minute, the target hears the koldun as if the vampire whispered in his ear. He may reply or remain silent, but anything he says within a number of turns equal to the koldun’s successes flies back to the koldun. This power may bring words to anyone within a mile (one and a half kilometers) who is not in a sealed room. While using this power, a koldun must concentrate fully. Any disturbance breaks the communication.

•• Biting Gale
Vengeful koldun sought to invoke a wind as chill as air atop the Carpathian Mountains. This power achieves that end, unleashing a cutting wind that can freeze a man’s blood in his veins as it swirls through an area of his choosing. Besides its obvious combat applications, this power also facilitates a dramatic entrance for those so inclined.
System: With a successful activation roll, the koldun summons a freezing wind within a maximum of a 100-yard/meter radius. Anyone caught in this frigid blast suffers one die of bashing damage each turn (which may be soaked normally), loses two dice from all Dexterity pools, and moves at half normal speed. The winds last as long as the koldun wills, provided he maintains concentration. Any non-reflexive actions on the part of the vampire cause the winds to still and dissipate. This includes any movement.

••• Breeze of Lethargy
Although they cannot induce immediate sleep, the winds evoked by this power bring growing exhaustion and numbing weariness through every muscle. Victims of this power often smell a hint of bittersweet smoke before they fall entranced.
System: For two turns per success, the koldun creates a wind inflicting extreme lethargy within a 200-foot/60-meter radius. Players of characters caught in this wind must roll Stamina + Survival (difficulty 8). This roll is made once every ten minutes of exposure. Failure means the character halves all dice pools involving physical actions for the remaining duration of the wind and halves all movement rates for the scene. A botch puts the character to sleep (or a state of light torpor for vampires) for the scene. Sleeping characters awaken if prodded, shaken, or otherwise manhandled, though they move slowly and may suffer halved dice pools if the wind persists.

•••• Ride the Tempest
A koldun employing this power moves at incredible speeds as he rides along the winds. While traveling with this power, a vampire assumes a blurred form that coalesces as he reaches his destination.
System: With a successful activation roll, the koldun fades into the wind and flies at 250 mph/400 kph to his destination. This power cannot effectively function in caves, buildings, or other enclosed areas. Outside, the vampire’s flight navigates all obstacles. Once the koldun arrives at his destination or the scene ends, the vampire descends to earth and solidifies.

••••• Tempest
Applying fury magnified by blood and will, a koldun may project the full measure of his anger into the night sky. Churning gray clouds blot out stars and moon, unleashing spiraling gusts and a driving downpour of freezing rain. Lightning arcs overhead, with each thunderous flash casting jagged shadows.
System: With a successful activation roll and a point of Willpower (in addition to the usual blood), a koldun may conjure a terrible storm. It takes six hours for the clouds to gather and thicken overhead, minus one hour for every success rolled. If this results in a duration of less than one hour, the clouds blossom outward from directly overhead like a black canopy, filling the sky in mere minutes. Once the clouds form, the rain begins to fall in torrents and the lightning begins. The storm persists at full strength for one hour per success rolled. It gradually dissipates over the hour following that. During the peak of its fury, the storm may cause flooding and certainly chills any exposed mortal to the bone (1 die of unsoakable bashing damage every five minutes of full exposure). Lightning strikes regularly, far more than a usual storm. Indeed, for a cost of one Willpower point, a koldun may direct lightning at a foe using his Perception + Occult (difficulty 6). A successful strike inflicts 10 dice of lethal damage (which can be soaked normally). Only one such attack may be made each turn.]==],
				},
				["The Way of the Spirit"] = {
					en = [==[Rites of Blood, p. 156


The Way of the Spirit


This Path is rarely found outside of Old Clan Tzimisce, whose members still stalk the same ancestral lands as their sires and their sires’ sires. But it has utility even for Sabbat Tzimisce, and so its knowledge spreads even to more cosmopolitan Clan-mates. The path allows the koldun to diffuse his perceptions across an increasingly large area. If the magic is performed correctly, the koldun will be able to perceive potentially everything that takes place in the affected area (which might be many square miles), though opening one’s self up fully to such awareness is dangerous for all but the most strong-willed kolduns. Instead, most reflexively limit their perceptions to “all intruders” or “all potential feeding vessels” as they desire, and even the most perceptive koldun might miss something important if she has inadvertently excluded it from her gaze. While the power is active, the koldun may also target any location or person he can perceive with any other Koldunic Path power or ritual, provided that the rating of the Path power or ritual does not exceed that of the koldun’s rating in The Way of the Spirit. This power also defeats the use of Obfuscate by any Kindred within the area of effect.
Koldunic Sorcery dice mechanics (Rites of Blood p. 156): the roll to activate a Koldunic Sorcery Path is a Willpower roll with a difficulty equal to (3 + Path rating), and each such roll also requires the expenditure of one blood point. The roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. These rules supersede those in V20. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.

• The koldun can perceive everything within a 50-foot/20-meter radius.

•• ... within a 100-yard/meter radius.

••• ... within a quarter-mile/half-kilometer radius.

•••• ... within a mile/1.5 kilometer radius.

••••• ... within a five mile/eight kilometer radius.

System: The number of successes on the activation roll determines how many successive scenes the effect lasts. If activated before the sun rises, the koldun’s awareness can extend into the daylight hours, and the koldun suffers no negative effects from monitoring his lands during the day. He does still suffer the usual dice penalties for taking any other actions during the day.]==],
				},
				["Ushabti"] = {
					en = [==[Rites of Blood, p. 163


Ushabti


Ushabti derives its name from the figurines crafted for the tombs of the wealthy and powerful in ancient Egypt. It was believed that such figurines would come to life in the Underworld to serve their masters as laborers or playthings. Each application of this Path creates a different ushabti, and each ushabti can only be activated once. The sorcerer must forge the figurine from wax or clay mixed with a point of blood. Then, he must carve Egyptian words of power onto the figurine before bathing it in honey and beer. Activating a figurine requires the sorcerer to spend a point of blood and speak an incantation, and the player rolls Willpower to determine whether the ushabti activates. If it does, the figurine expands into a life-sized, animate figure that obeys the sorcerer’s will. In the case of a botch, in addition to the normal effects, the ushabti will activate but will be hostile to the sorcerer.
Activated ushabti have Attributes and Abilities determined by the level of the path used to create them. The sorcerer may not grant an ushabti Abilities she does not have nor Ability ratings higher than her own. The successes on the Willpower roll determine how realistic the activated ushabti is. However, the successes applied to “realism” can never exceed the path rating used. Thus, only an ushabti created with Gift of Khnum (Ushabti •••••) can be indistinguishable from a living creature.
1 success — A crude thing obviously made of wax.
2 successes — As realistic as a well-made waxwork or a china doll.
3 successes — Lifelike enough to fool a casual viewer (difficulty 6 to detect as fake)
4 successes — Extremely lifelike (difficulty 8 to detect as unreal)
5 successes — Indistinguishable from a living creature
Once activated, the ushabti endures for one lunar month, but this can be extended indefinitely at a cost of one point of blood per additional month. However, this assumes that the ushabti remains within its master’s haven and does not interact with mortals. If those conditions are broken, the ushabti will degrade into nothingness within an hour. A sorcerer can craft an ushabti for use by another, but doing so costs him one Willpower.

• Laborer
The ushabti can be a human or an animal. It is mindless and obeys all orders from its master. It has two dots in each Physical Attribute, one dot in each Mental Attribute, and no dots in any Social Attribute. It has no Abilities.

•• Servitor
To the Laborer, add three additional Attribute dots. None can be applied to any Social Attribute, and no Mental Attribute can rise above 2. Add two dots of non-combat Abilities.

••• Guard
To the Laborer, add six dots of Attributes and four dots of Abilities. Guards may have Social Attributes, but no Social or Mental Attribute may exceed 2, nor can any Ability.

•••• Overseer
To the Laborer, add nine dots of Attributes and six dots of Abilities; no Social or Mental Attribute may exceed 3, nor can any Ability.

••••• Gift of Khnum
The ultimate expression of this art, the Gift of Khnum (the legendary creator of humanity according to Egyptian lore) allows the sorcerer to create what is effectively a living body, either as an obedient slave or as a ready-made vessel for a wraith or a spirit. The character who activates the ushabti decides which, although the latter option requires her to have a compliant wraith or spirit handy.
To the basic Laborer, add 12 dots of Attributes and eight dots of Abilities. The ushabti gains the Virtues, Humanity, and Willpower of a starting vampire. It is sentient but emotionally bound to the one who activates it as if by a blood bond. This is true even if a spirit or wraith possesses it. Each use of Gift of Khnum costs two Willpower points at the time of activation, and the player may spend additional Willpower points to gain automatic successes on the activation roll. An ushabti created with this Path does not degrade unless someone actively challenges its identity and persuades it that it is not real. Absent proof of its own unreality, the ushabti is effectively immortal.]==],
				},
				["Vitreous Path"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 174


Vitreous Path


The Vitreous Path allows a necromancer to control and influence the energies pertaining to death. This extremely rare path manipulates entropy, a force that even most necromancers are uncomfortable harnessing. A development of the Nagaraja bloodline (p. 406, although they sometimes call the path “Nihilistics”), the Vitreous Path makes a formidable complement to the necromantic craft, and those obsessed with mastery over death and souls — such as the Harbingers of Skulls — would certainly risk much to uncover this path’s secrets.
Like most necromancers, Nagaraja generally learn the Sepulchre Path before any others. The Vitreous Path is usually their second focus of study.

• Eyes of the Dead
The necromancer employing the Eyes of the Dead can see with the perceptions of the Restless Dead (called Deathsight). To such a manipulator of ghostly energies, the auras of surrounding beings give off telltale hints as to their health and even their ultimate fate; the necromancer can see the energies of death flowing through everyone, just as ghosts can. By looking at the entropic markings on a person’s body, the necromancer can gain rough knowledge of how far that person is from death, how soon that person is likely to die, and even what the cause of her death is likely to be. The information thus gained is not exact by any means, but it gives the necromancer an edge over those she scrutinizes.
System: The player rolls Perception + Occult, difficulty 6. One success lets a necromancer determine whether someone is injured, diseased, or dying, as well as whether the individual labors under any sort of curse or baleful magic.
Further, the vampire can divine the target’s eventual demise, depending on the successes scored. One success means the character can guess how long the target has to live to within a few weeks. Three successes means the character can estimate how long the target has to live and what the probable source of death will be, as the entropic markings show the wounds that will someday exist on that person. Five successes means the character can actually see where and when the event will occur by interpreting the black marks on the target’s soul.
This ability lasts for one scene, though the necromancer may choose to end the power early. It can be used to read the fate of only one target at a time. Storytellers should exercise judgment with this power, since the markings of death are typically unavoidable. He may decide to roll the dice himself, so that the player has no way of knowing whether her insight is correct.

•• Aura of Decay
The necromancer can strengthen the feeling of entropy around her to the point where it breaks down nonliving objects and machines. It can gnarl wood, rust metal, crack silicon chips, and erode plastic, glass, and dead organic material. This power has a range of one yard or meter from the necromancer’s body, but all those in the presence of the vampire can feel her corruption as an icy wind.
System: No roll is required, but this power does cost at least one blood point. Objects subjected to this Aura of Decay break down and become useless after being targeted. How the object gives out, as well as the exact mechanism of failure, is up to the Storyteller. Corrosion, metal fatigue, or sheer brittleness are all suitably likely for any given item’s demise, but the in-game effect of using a doomed item is as if the owning character rolled a botch. The speed at which an item breaks down depends on how many blood points are spent.
One blood point — One week
Two blood points — One day
Three blood points — End of scene
Four blood points — Five turns
Five blood points — One turn
Note that since this power requires the expenditure of blood points, a character cannot cause an Aura of Decay while staked.

••• Soul Feast
Just as the necromancer can release entropic energies from within, she may also pull them into herself as a source of power. Soul Feasting allows the caster to either draw on the ambient death energies around her or to actively feed on a ghost, stealing the wraith’s substance and mystically transforming that energy into sustenance.
System: The player spends one Willpower point to allow the vampire to feed on the negative energies of the dead. If the character is drawing the energies from the atmosphere, she must be in a place where death has occurred within the hour or in a place where death is common, such as a cemetery, a morgue, or the scene of a recent murder. Generally, the necromancer can draw anywhere from one to four points of entropy from such a location, although the difficulty in using all Necromancy and similar deathly powers within the area increases by an equal amount for a number of nights equal to the points taken. The energies of such an area may only be drained once until the area’s entropy replenishes.
In cases when the necromancer feeds on a ghost, the vampire must actually attack the wraith as if feeding normally. Wraiths have up to 10 “blood points” that may be taken from them, and they become less and less substantial as their spirit essence drains away. The character is vulnerable to any attack the ghost might make, even those that do not normally affect the physical world; while feeding, the vampire is essentially in a half-state, existing in both the living lands and the Underworld simultaneously. The wraith so attacked is considered immobilized and cannot run or escape unless it can defeat the vampire in a resisted Willpower roll (difficulty 6 for both sides). This power may also be used in conjunction with Ash Path Necromancy, allowing the vampire to drain power (though not sustenance) from ghosts while traveling in the lands of the dead.
This soul energy may be used just like blood in every respect except for when the vampire rises for the night. It can activate Disciplines, heal wounds, boost Attributes, etc. Botching this power renders the vampire unable to feed through the Shroud for the rest of the night. However, she remains susceptible to the assaults of ghosts and spirits for several turns (generally, a number of turns equal to the amount of energy that could have been drawn from the area, or one turn if attacking a ghost) as she hovers between worlds, unable to function effectively in either.

•••• Breath of Thanatos
The Breath of Thanatos allows the necromancer to draw out entropic energy and focus it upon an area or person by taking a deep breath and then forcefully exhaling a fog of necromantic energy. This cloud of virulence is completely invisible to anyone without the ability to see the passing of entropy. The energy of this cloud is like a beacon for Spectres, and they are drawn to the entropic force like moths to a flame.
Once the energy is pulled from the necromancer’s body, she can either disperse it over a large area as a lure for Spectres, or use the mist for more sinister purposes. Channeled into an object or person, the deathmist inflicts the subject with a debilitating, wasting illness. Furthermore, the focused energies are tainted and eerie, and though generally invisible (except to powers such as Aura Perception), they tend to cause people and animals to feel uncomfortable around the victim.
System: The player spends one blood point and rolls Willpower (difficulty 8). Only one success is needed to draw out the Breath of Thanatos. If dispersed to summon Spectres, the energies cover roughly one-quarter of a mile (400 meters) in radius, centered around the necromancer. The range increases by an additional one-quarter mile or 400 meters for every additional blood point expended.
Spectres summoned with this power will ignore the summoning necromancer for the duration of the power unless provoked, but may well go out of their way to wreak havoc on anyone else in the vicinity. The necromancer can then use other Necromancy powers (such as those in the Sepulchre Path) to manipulate and affect these Spectres. Ghosts so targeted may then interact with the necromancer as normal, although the other Spectres in the area will continue to ignore both the vampire and the targeted ghost. This energy disperses after a scene, after which the Spectres leave to find new prey. Mechanics for Spectres can be found on p. 385.
If the cloud is directed toward a particular target, the necromancer must either touch the target or direct the stream of entropy using Dexterity + Occult (difficulty 7). A target laden with entropy suffers one (and only one) level of aggravated damage; this generally manifests as sudden illness or decay. The target’s social difficulties while interacting with those unfamiliar with the touch of death — most normal humans, as well as some supernatural creatures — increase by 2. Furthermore, supernatural perceptions indicate the target is tainted with decay, which can be dangerous. This form of taint lasts until sunrise; a victim already plagued by this power cannot be affected again until the previous fog of entropy has dispersed.
A botch on the roll to control this power indicates that the vampire has turned the energy upon himself, and suffers all the effects of the vitriolic breath. This inflicts the usual injury and may subject the necromancer to the possibly dangerous attention of provoked Spectres and other creatures from beyond the grave.

••••• Night Cry
The breath of entropic energy becomes a scream of pure chaos. The necromancer can issue an unearthly cry (heard both in the living world and in the Shadowlands). The howl pours icy oblivion into a target or group of targets — either sweeping away the inherent entropy or collecting that destruction and unleashing it.
System: The vampire chooses a number of targets within one yard or meter per dot of Necromancy and invokes Night Cry with a terrible scream. The player spends a Willpower point and a blood point for each target beyond the first. (In other words, she spends no blood if only going after one target, or one blood for two targets. Generational blood limits apply, and the vampire may not “pre-spend” blood prior to using Night Cry.)
The player then chooses whether the vampire will aid or harm the targets, and rolls Manipulation + Occult (difficulty 6). If she chooses to aid the target or targets, each success gives each affected target a -2 difficulty modifier to all of his actions for one turn per success. If she instead chooses harm, each success causes an aggravated wound to each target. Targets may be any kind of living creature, including supernatural ones.
No matter the result, the Night Cry is heard on both sides of the Shroud, attracting the attention of anyone nearby. On a botch, the necromancy may summon unruly ghosts or Spectres, similar to Breath of Thanatos.]==],
				},
				["Weather Control"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 228


Weather Control


Command over the weather has long been a staple power of wizards both mortal and immortal, and this path is said to predate the Tremere by millennia. The proliferation of usage of this path outside the Clan tends to confirm this theory; Weather Control is quite common outside the Tremere, and even outside the Camarilla. Lower levels of this path allow subtle manipulations, while higher stages of mastery allow a vampire to call up raging storms. The area affected by this power is usually rather small, no more than three or four miles (five to six kilometers) in diameter, and the changes the power wreaks are not always immediate.
System: The number of successes rolled indicates how long it takes the weather magic to take effect. One success indicates an entire day may pass before the weather changes to the thaumaturge’s liking, while a roll with five successes brings an almost instant effect.
The difficulty of the Willpower roll necessary to invoke this power may change depending on the current local weather conditions and the weather the character is attempting to create. The Storyteller should impose a bonus (-1 or -2 difficulty) for relatively minor shifts, such as clearing away a light drizzle or calling lightning when a severe thunderstorm is already raging. Conversely, a penalty (+1 or +2 difficulty) should be applied when the desired change is at odds with the current conditions, such as summoning the same light drizzle in the middle of the Sahara Desert or calling down lightning from a cloudless sky.
If the character tries to strike a specific target with lightning, the player must roll Perception + Occult (difficulty 6 if the target is standing in open terrain, 8 if he is under shelter, or 10 if he is inside but near a window) in addition to the base roll to use Thaumaturgy. Otherwise the bolt goes astray, with the relative degree of failure of the roll determining where exactly the lightning strikes.
Effects of the power default to the maximum area available unless the caster states that he’s attempting to affect a smaller area. At Storyteller discretion, an additional Willpower roll (difficulty 6) may be required to keep the change in the weather under control.
Weather Control is not the sort of power that lends itself well to indoor application. While certain of the path’s uses (changes of temperature, high winds, and possibly even fog) do make a certain amount of sense in interior settings, others (precipitation of any sort, lightning) don’t. The difficulty for all rolls to use Weather Control indoors is at +2, and the Storyteller should feel free to disallow any proposed uses that don’t make sense.
Individual power descriptions are not provided for this path, as the general principle is fairly consistent. Instead, the strongest weather phenomenon possible at each level is listed.

• Fog: Vision is slightly impaired and sounds are muffled; a +1 difficulty is imposed on all Perception rolls that involve sight and hearing, and the effective range of all ranged attacks are halved.
• Light breeze: A +1 difficulty is imposed on all Perception rolls that involve smell.
• Minor temperature change: It is possible to raise or lower the local temperature by up to 10 degrees Fahrenheit or 5 degrees Celsius.

•• Rain or snow: As Fog, but Perception rolls are impaired to a much greater extent; the difficulty modifier for all such rolls rises to +2. In addition, the difficulty on all Drive rolls increases by two.

••• High Winds: The wind speed rises to around 30 miles per hour or 50 kilometers per hour, with gusts of up to twice that. Ranged attacks are much more difficult: +1 to firearm attacks and +2 to thrown weapons and archery. In addition, during fierce gusts, Dexterity rolls (difficulty 6) may be required to keep characters from being knocked over by the winds. When gale-force winds are in effect, papers go flying, objects get picked up by the winds and hurled with abandon, and other suitably cinematic effects are likely.
••• Moderate temperature change: The local temperature can be raised or lowered by up to 20 degrees Fahrenheit or 10 degrees Celsius.

•••• Storm: This has the effects of both Rain and High Winds.

••••• Lightning Strike: This attack inflicts 10 dice of lethal damage. Body armor does not add to the target’s dice pool to soak this attack.]==],
				},
				-- <<< PATH_DESC_END
};
