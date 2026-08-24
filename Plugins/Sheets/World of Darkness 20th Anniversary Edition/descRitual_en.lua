-- Ritual descriptions, the [en] half (SPEC T495, V210).
--
-- descRitual.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [en] only, descRitual_pt.lua holds the other, the two carry the SAME
-- keys, and the renderer requires the half the sheet is set to - require("descRitual_" .. lang ..
-- ".lua"), never a constant name (SPEC V210b). Nothing was removed: both files ship in the
-- .rpk and no entry is dropped (SPEC V210a). The generator markers migrated verbatim to
-- both sides, so every region parser still aims at the same shape (SPEC I24).
--
-- Ritual descriptions for the Vampire tab (SPEC I21). One entry per canonical picker
-- value, keyed in ENGLISH because that is what the sheet saves (SPEC V24); `pt` is a
-- translation of the same three blocks, source line for source line.
--
-- SPEC I24 / T479-T481: this table used to be an upvalue inside the <script> of HH.14.lfm.
-- The <script> CDATA is copied raw into constructNew_*(), so every open sheet parsed and
-- kept its own copy. As a module it is parsed once and cached in package.loaded, and the
-- require that pulls it lives INSIDE ritualText (SPEC V198).
--
-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24). The generator
-- markers migrated verbatim, so research/rebuild_ritual_desc.sh and the .tsv maps still aim
-- at the same region - only the path of the target changed.

return {
				-- >>> RITUAL_DESC_BEGIN (generated - SPEC T446)
				["1. Ambrus Kelemen’s Aegis"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 303


1. Ambrus Kelemen’s Aegis


This ritual was a primary source of protection against the Tzimisce during the nascent clan’s ascension. The ritualist crafts a bauble, a piece of jewelry, and wears it until expended. The bauble contains charges equal to the vampire’s Thaumaturgy rating. Charges can be expended for additional dice added to any roll to detect surprise, or to any soak dice pool against bashing or lethal damage. A character may only have one Aegis enchanted at a time, but may give it to another character.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["1. Armor of Diamond Serenity"] = {
					en = [==[Rites of Blood, p. 166


1. Armor of Diamond Serenity


Armor of Diamond Serenity is a Level One Sadhana Ritual. This ritual calls upon Shiva to purge the sorcerer’s mind of mortal passions and to grant Enlightenment.
System: For the rest of the night, the sadhu is immune to frenzy of all types, reduces the difficulty of all Willpower rolls by -2, and treats his Willpower as if it were two higher against effects which use his Willpower (temporary or permanent) as the target number. However, while the effect lasts, the sadhu loses the ability to spend blood to increase Physical Attributes.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Bind the Accusing Tongue"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 230


1. Bind the Accusing Tongue


This ancient ritual is said to have been one of the first developed by the Tremere and a primary reason for the lack of cohesive opposition to their expansion. Bind the Accusing Tongue lays a compulsion upon the subject that prevents him from speaking ill of the caster, allowing the thaumaturge to commit literally unspeakable acts without fear of reprisal.
System: The caster must have a picture or other image or effigy of the ritual’s target, a lock of the target’s hair, and a black silken cord. The caster winds the cord around the hair and image while intoning the ritual’s vocal component. Once the ritual is complete, the target must score more successes on a Willpower roll (difficulty of the caster’s Thaumaturgy rating + 3) than the caster scored in order to say anything negative about the caster. The ritual lasts until the target succeeds at this roll or the silk cord is unwound, at which point the image and the lock of hair crumble to dust.]==],
				},
				["1. Blood Mastery"] = {
					en = [==[Rites of Blood, p. 145


1. Blood Mastery


Kindred scholars urgently warn against allowing any blood magician to have access to your blood unless you have complete trust in her. A thaumaturge with a small quantity of vitae can focus its power into sympathetic forms. By destroying a point of blood from an enemy, the thaumaturge gains symbolic power over the target, which in turn allows her to manifest her supremacy over the victim in the next challenge.
System: The thaumaturge must mix a tiny quantity of her own vitae (a negligible amount, less than a point) with that of her victim, and then slowly burn it in a fire or boil the blood slowly over an open flame. The caster speaks the phrases of symmetry as she finishes. Once complete, the thaumaturge gains a limited magical mastery over the victim until dawn. In the next test that the caster initiatives against the victim, the caster automatically succeeds in the attempt.
If the task would require a roll, the caster garners one success automatically, but no more (and cannot roll or spend Willpower to improve the roll). This means that the caster is guaranteed a marginal success against his opponent, though it may not be in a fashion that the thaumaturge desires. For example, one success alone is not enough to completely mesmerize an enemy, but it might influence him briefly with Dominate. Similarly, if the victim takes some action first, Blood Mastery is of no help if the caster could not normally make a countering roll. For example, the caster would still be subject to an opponent’s use of Presence, because he may not normally make a roll to resist. If the victim uses some Discipline that would require the caster to resist, though, then the thaumaturge automatically counters it and thus ends the power of the ritual.
Blood Mastery can only guarantee success in one limited endeavor — a thaumaturge cannot burn multiple points of blood to gain additional successes or success on multiple consecutive actions. Once the ritual is in place, it must be discharged before it can be invoked again against the same subject. Blood Mastery expires if its effects remain unused by sunrise.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Blood Rush"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 230


1. Blood Rush


This ritual allows the vampire to create the sensation of drinking blood in himself without actually feeding. The ritual can be used for pleasure, but it is more often used to prevent frenzy when confronted with fresh blood. The vampire must carry the fang of a predatory animal on his person for this ritual to work.
System: Performance of the ritual results in the Beast being kept in check automatically. Blood Rush allows the vampire to resist hunger-based frenzy for up to one hour, at which point the Cainite feels hungry again (assuming he did before). This ritual takes only one turn to enact.]==],
				},
				["1. Blood into Water"] = {
					en = [==[Rites of Blood, p. 145


1. Blood into Water


Mortals have discovered clever ways to use science and technology to discover hidden traces of blood in crime scenes. Kathryn Malcolm, a neonate Tremere in New York, realized that the police department was tracking a series of murders linked to vampires via blood evidence, and crafted this ritual to remove tainted evidence from a crime scene. Once the caster has completed this ritual, all spilled blood within the ritual’s reach transmutes to water. This ritual is most frequently used to remove bloodstains, whether as a result of foul play or rites that involve blood.
System: The thaumaturge pours a cup of purified water through the fingers of her outstretched hand while chanting. The ritual transmutes all spilled blood within a radius of five feet/two meters per success on the activation roll. Blood in containers and in living things will not be affected — only spilled blood.
This power has no effect on blood used to create active or passive Discipline effects. Blood into Water could not be used to remove a ritual such as Ward Versus Ghouls (V20, p. 234) due to the magic properties of the ritual having transformed the blood, though it could be used to clean up a drawn blood circle used to bind a demon, so long as that binding is done and over with.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Brand"] = {
					en = [==[Rites of Blood, p. 23


1. Brand


An enterprising Tremere neonate from Boston once overheard a powerful Brujah named Alighieri wish she could acquire a new tattoo that wouldn’t fade away on the following evening. Curious, he made several trips to the local chantry archives and came across references to a ritual used in France to brand criminals. Considering the dark reputation of the Warlocks, this ritual is surprisingly popular amongst neonates of all Clans, especially Anarchs. The Tremere merely smile and collect the boons.
Brand allows the thaumaturge to transmute temporary tattoos and other body modifications received post-Embrace into a permanent state on the vampire’s body. The thaumaturge does not need to be present at the creation of the tattoo, but the ink must have been imprinted within an hour of the casting of the ritual. After reciting the proper incantations, the caster must slowly spread an ounce of molten silver over the area of skin tattooed.
Brand was designed to be a punishment, and thus is exceptionally painful. Some Kindred view this ritual as a rite of passage for neonates and a demonstration of their courage.
System: This painful process burns an aggravated level of damage to the area of skin branded. This tattoo may be placed anywhere on the subject’s body. Once the damage has healed, the tattoo remains upon the skin, unblemished. Due to the pain, the Storyteller may force the target to make a Self-Control roll to hold still during the procedure.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. CCTV"] = {
					en = [==[Rites of Blood, p. 67


1. CCTV


Normally, Thaumaturgy requires either direct line of sight or a sympathetic effect. The Hacktivists pride themselves on eschewing normality. This ritual allows the thaumaturge to use a CCTV camera or even a web camera as a “third eye.” The thaumaturge must disassemble the camera, inscribe every inch of it with a mixture of occult sigils and mathematical formulae, and then put it back together (Intelligence + Technology, difficulty 8). Then, she must cut her thumb and hold it against the camera lens until a full blood point has been absorbed by the camera.
System: The ritual lasts for one night per success, and it can be renewed for the same interval indefinitely so long as the vampire can feed additional points of blood to the lens. While the ritual lasts, the thaumaturge can treat the video feed from the camera as if she were experiencing it directly for purposes of targeting people or places with either paths or rituals. If the camera takes the form of a spy camera that is smuggled into an enemy’s haven, this can allow for devastating effects. However, the ritual is not without risk. So long as the ritual is active, any other blood magician who obtains the enchanted camera can use it as a sympathetic link back to the thaumaturge as if it were a sample of his own vitae. Even after the ritual ends, a lesser sympathetic link persists (equivalent to a personal possession of the thaumaturge) until the camera is destroyed.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Call of the Hungry Dead"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 177


1. Call of the Hungry Dead


Call of the Hungry Dead takes only 10 minutes to cast and requires a hair from the target’s head. The ritual climaxes with the burning of that hair in the flame of a black candle, after which the victim becomes able to hear snatches of conversation from across the Shroud. If the target is not prepared, the voices come as a confusing welter of howls and unearthly demands; he is unable to make out anything intelligible, and may go briefly mad.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Calling Card"] = {
					en = [==[Rites of Blood, p. 65


1. Calling Card


The Tremere know that Anarchs have duplicated their Encrypt Missive ritual (see pp. 145-146), but they are thus far unaware of the unique modifications that Victor Therron, Malkavian anarchist, made to it. The basic application of this ritual allows the sorcerer to leave a message in the form of graffiti which can only be understood by readers who meet certain criteria. The sorcerer’s message may be visible to any Kindred, to any Anarch, or to specific individuals. That much is known. What the Tremere do not realize is that the placement matters as much as the message, for if a punk sorcerer uses this ritual to tag a particular location — specifically a place which the sorcerer has vandalized in some way and which belongs either someone he perceives as an authority figure (whether the Prince or the mortal government) or someone he personally perceives to be an enemy — the ritual has a secondary effect that makes it easier to perform other punk magic at the scene.
System: The graffiti message will last until it is removed and its true meaning will be visible to any intended target for that time. To trigger the secondary effect, the sorcerer (and any allies he brings) must actually vandalize the area and then leave a message taunting some figure of authority. This message may or may not have a hidden meaning in it, but it must somehow identify the sorcerer, either by his commonly used identity or by a regularly used alias which is known to whichever local authority figures might be expected to visit the scene. For one hour per success, the difficulty of all rituals and path effects executed by the sorcerer within sight of the graffiti is reduced by 1 if the graffiti incorporates an alias or by 2 if it reveals a name by which the sorcerer is personally known by the authorities.
Some punk sorcerers leave hidden messages visible only to specific vampires like the Sheriff or Prince, and then use the benefits provided by Calling Card to cast delayed action rituals as traps triggered whenever he reads the hidden message. The BFU ritual, for example, is designed explicitly for this purpose.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Chime of Unseen Spirits"] = {
					en = [==[Rites of Blood, p. 23


1. Chime of Unseen Spirits


During the nascent Camarilla’s conflicts with the Giovanni, the greatest danger to the Ivory Tower was the Necromancers’ ability to spy upon their enemies with impunity. Clan Tremere created a ritual that would allow them to detect ghost, spirits, and demonic entities.
The thaumaturge must collect the wedding rings of three dead women and melt them to cast a metallic chime. She must chant over the chime over the course of the evening, naming each of the brides once per hour. Once the chime has cooled, it imprints the memory of the ritual in the metal.
Once it is hung in a room, the chime will harmoniously ring a soft warning when in the presence of an unseen spirit, ghost, or devil. Anyone that understands the mystical nature of the chime and is within earshot may benefit from this warning. This thaumaturgical device will work for a year before the ritual must be recast.
System: Once the chime has been enchanted, it will ring once every time an unseen spirit, ghost, or devil is within thirty feet/ten meters of its physical presence. Otherwise, the chime has been charmed to not ring, even in heavy wind or by manual manipulation. Some powers may block the ability of the chime to detect a specific entity, per the discretion of the Storyteller.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Communicate with Kindred Sire"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 230


1. Communicate with Kindred Sire


By enacting this ritual, the caster may join minds with her sire, speaking telepathically with him over any distance. The communication may continue until the ritual expires or until either party ends the conversation. The caster must possess an item once owned by her sire for the ritual to work.
System: The caster must meditate for 30 minutes to create the connection. Conversation may be maintained for 10 minutes per success on the activation roll.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Death’s Communion"] = {
					en = [==[Lore of the Clans, p. 108


1. Death’s Communion


The Giovanni have spent centuries going through the motions, making sure that nobody can question their public devotion to the Catholic Church. In private, however, the family often practices their own warped Black Mass, showing devotion to Dis Pater and drawing power from the darkness. This ritual acts as a grim parody of the traditional communion, ingesting literal blood (perhaps even of the father) and dedicating the subject to the Endless Night.
This ritual is not performed at every family black mass. An expedited, powerless version may be observed, but the full ritual is more involved.
System: The caster of this ritual is usually not the beneficiary. If the caster and the subject are the same, the caster suffers a +1 difficulty to her casting roll. Death’s Communion takes one hour to complete. The subject of the ritual gains a bonus of +2 dice to all Necromancy rolls for one night per success achieved on the casting roll.
Necromantic ritual casting (V20, p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Defense of the Sacred Haven"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 230


1. Defense of the Sacred Haven


This ritual prevents sunlight from entering an area within 20 feet (six meters) of this ritual’s casting. A mystical darkness blankets the area, keeping the baleful light at bay. Sunlight reflects off windows or magically fails to pass through doors or other portals. To invoke this ritual’s protection, the caster draws sigils in her own blood on all the affected windows and doors. The ritual lasts as long as the thaumaturge stays within the 20-foot (6-meter) radius.
System: This ritual requires one hour to perform, during which the caster recites incantations and inscribes glyphs. One blood point is required for this ritual to work.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Deflection of Wooden Doom"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 231


1. Deflection of Wooden Doom


This ritual protects the caster from being staked, whether she is resting or active. While this ritual is in effect, the first stake that would pierce the vampire’s heart disintegrates in the attacker’s hand. A stake merely held near the caster is unaffected; for this ritual to work, the stake must actively be used in an attempt to impale the vampire.
System: The caster must surround herself with a circle of wood for a full hour. Any wood will work: furniture, sawdust, raw timber, 2’ x 4’s, whatever. The circle must remain unbroken, however. At the end of the hour, the vampire places a wooden splinter under her tongue. If this splinter is removed, the ritual is nullified. This ritual lasts until the following dawn or dusk.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Devil’s Touch"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 231


1. Devil’s Touch


Thaumaturges use this ritual to place curses upon mortals who earn their ire. Using this ritual marks an individual invisibly, causing all those who come in contact with him to receive him poorly. The mortal is treated as the most loathsome individual conceivable, and all who deal with him do everything in their power to make him miserable. Even bums spit at an afflicted individual, and children taunt him and barrage him with vulgarities.
System: The effects of this ritual last one night, disappearing as the sun rises. The mortal (it doesn’t work on vampires) must be present when the ritual is invoked, and a penny must be placed somewhere on his person (in a pocket, shoe, etc.).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Domino of Life"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 231


1. Domino of Life


A vampire wanting or needing to simulate a human characteristic can do so once Domino of Life is cast. For one entire night, the vampire can eat, breathe, maintain a normal body temperature, assume a human flesh tone, or display some other single trait of humankind she desires. Note that only one trait can be replicated in this fashion. The vampire must have a vial of fresh human blood on his person to maintain this ritual.
System: Using this ritual adds one die to the caster’s dice pools when attempting to pass as human. Unless onlookers are especially wary, the Domino of Life should fool them into thinking the caster is mortal — not that they should have any reason to suspect otherwise.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Drinking Death"] = {
					en = [==[Dark Ages Tome of Secrets, p. 48


1. Drinking Death


Level One Rite — The Białowieza Kraina — Attribute: Strength
Mortals farm the earth, and Cainites farm the mortals. When mortals become victim to plague and war, however, a vampire can struggle to find blood. This rite allows a koldun to consume blood from the gravesites of deceased mortals.
System: Upon completion of the rite, the koldun is subsequently capable of drinking blood from the earth of a gravesite. The koldun must lay prostrate on the ground, face in the soil, and take the earth in his mouth. Only one blood point can be gained this way from each grave, and one such grave in the immediate area can be affected per success in the casting. The rite’s effects are permanent until one of the graves is consecrated by an individual with True Faith.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Eldritch Beacon"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 177


1. Eldritch Beacon


Eldritch Beacon takes 15 minutes to cast. The material component is a green candle, the melted wax from which must be collected and molded into a half-inch (1.5 cm) sphere. Whoever carries this sphere, whether in his hand or in a pocket, is highlighted in the Shadowlands with a sickly-glowing green-white aura. All ghostly powers affect this individual with greater ease and severity. The sphere retains its power for one hour per success on the casting roll.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Encrypt Missive"] = {
					en = [==[Rites of Blood, p. 145


1. Encrypt Missive


Letters were once the dominant form of communication and information collection. Cautious Kindred learned to either be discreet in their dealings on paper or to send blood-bound or Dominated personal messengers. Neither option was ideal when you needed to be explicit and ensure that only your intended recipient received the message. To insure that important messages remain secure against prying eyes, the Tremere utilized this ritual to encode documents magically. This ritual is not used as often in the age of instant electronic communications, but is occasionally used to communicate between chantries or to issue important edicts.
System: The thaumaturge writes the message in blood over the course of a night and speaks the name of the person or group that she wishes to read it. Only the writer and the target to which the letter is addressed can read the document. To any others who observe the letter, the writing appears to be gibberish. Obviously, this ritual may only be used for written communication. Encrypt Missive only works with the original document. If someone else tries to scan or copy the document, the magic holds and the message remains scrambled.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Engaging the Vessel of Transference"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 231


1. Engaging the Vessel of Transference


This ritual enchants a container to fill itself with blood from any living or unliving being who holds it, replacing the volume of blood taken with an equal amount previously held inside the container. When the ritual is enacted, the vessel (which must be between the size of a small cup and a one-gallon/four-liter jug) is sealed full of the caster’s blood and inscribed with the Hermetic sigil which empowers the ritual. Whenever an individual touches the container with his bare skin, he feels a slight chill against his flesh but no further discomfort. The container continues to exchange the blood it contains until it is opened. The two most common uses of this ritual are to covertly create a blood bond and to obtain a sample of a subject’s blood for ritual or experimental purposes.
System: This ritual takes three hours to enact (reduced by 15 minutes for each success on the casting roll) and requires one blood point (although not necessarily the caster’s blood), which is sealed inside the container. The ritual only switches blood between itself and a subject if it is touched with bare skin — even thin cotton gloves keep it from activating.
Individuals with at least four dots in Occult recognize the Hermetic sigil with two successes on an Intelligence + Occult roll (difficulty 8).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Eyes of the Abyss"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 271


1. Eyes of the Abyss


With this ritual, the Abyss Mystic summons tiny denizens of the Abyss to act as her servants, most often being used as spies.
System: The vampire crushes a small flame (e.g. a lit candle) in her bare hand, taking a level of aggravated damage. She then makes a Rötschreck check, difficulty 4. If she succeeds, roll Intelligence + Occult, difficulty 6. A botch results in an additional level of aggravated damage. On a success, a tiny Abyss elemental is summoned and consumes the extinguished flame.
Talon of the Abyss (p. 272): The Abyss Elemental looks the part of an amorphous blob of inky shadow. It can temporarily take whatever shape it’d like, up to the size of a human child.
Attributes: Strength 2, Dexterity 5, Stamina 1, Charisma 1, Manipulation 3, Appearance 0, Perception 3, Intelligence 2, Wits 3
Abilities: Alertness 3, Athletics 3, Brawl 3, Intimidation 2, Stealth 5 (+1 while in shadows)
Disciplines: Obtenebration 3
Willpower: 5
Health: OK x 3, Faded (-2) x2, Destroyed
The creature remains a number of nights equal to the successes rolled. The elemental will respond to and obey all commands given by the caster. It cannot affect the material world, though it can communicate mentally by entering a person’s shadow. Any non-mystic who communicates with an Abyss elemental in such a fashion must make a Courage check, difficulty 6. Failure results in a temporary Derangement that lasts the remainder of the evening. On a botch, the Derangement is permanent and can only be cured through repeated use of Willpower.
The elemental is always in shadow form (as Tenebrous Avatar, see p. 230), can fly 30 yards/meters per turn, and is instantly destroyed by fire or sunlight. A level 2 version of this ritual, Talons of the Abyss, can summon shadow elementals that are corporeal and can even attack enemies.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["1. Final Sight"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 292


1. Final Sight


There are two schools of thought on how to conduct the ritual of Final Sight. Adherents of the first school of thought conduct the ritual by dripping a few drops of blood on a dead man’s eye and saying a brief prayer for his soul. Others conduct the ritual by slowly and reverentially eating one of the dead man’s eyes. Most necromancers have a strong preference for one method. Regardless of which method the necromancer uses, this ritual must be used on a corpse with at least one intact eye, and it takes approximately five minutes.
The number of successes on the ritual roll determines the clarity of her results.
1 success — A basic sense of the subject’s death
2 successes — A clear image of the subject’s death and the seconds preceding it
3 successes — A clear image, with sound, of several minutes preceding the subject’s death
4 successes — A clear image, with sound, of the half-hour before the subject’s death
5 successes — Full sensory perception of the hour leading up to the subject’s death
If the player botches, her character is assaulted with vague and confusing visions of her own Final Death, which will immediately provoke a Rötschreck check (see p. 357).
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["1. Flatline"] = {
					en = [==[Rites of Blood, p. 158


1. Flatline


This ritual targets a mortal and causes her to appear to be dead in every way except for the fact that she still walks and talks. She has no pulse and her breath will not fog a mirror. If she is unconscious, she is indistinguishable from a corpse. Not even the most sensitive medical instruments will indicate that she is alive, even as she desperately tells the paramedic that she is. The sorcerer must place a small, dead animal somewhere in the target’s home.
System: The effect lasts until the next morning and can only be used on one target per month. The dead animal must be placed in the target’s real home. The ritual won’t work if it is left in a hotel room or somewhere she is house-sitting or squatting. The power will not affect any supernatural being. This ritual is most often used by Punk Sorcerers who either want to terrorize a mortal or embarrass some Camarilla Lick by causing one of his blood dolls to think she’s become a vampire and cause a scene.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Foxfire"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 292


1. Foxfire


The celebrant must burn a small green candle down to the bottom (which takes about fifteen minutes) and form the remaining ash and wax into a small sphere. The sphere is then placed somewhere on the intended target’s person.
Anyone who carries the sphere appears to be normal by any observer in the living world, but to anyone in the Underworld, the target appears to be illuminated with a sickly green glow. Ghosts find it trivially easy to affect the target with their dark magic, and receive a -1 difficulty on all magic-related rolls directed at the target. The sphere remains for one hour per success on the casting roll.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["1. Horoscope"] = {
					en = [==[Rites of Blood, p. 162


1. Horoscope


Using Babylonian astrology techniques, the ashipu can study the stars to gain insight into his enemies. To cast a horoscope of a mortal, the ashipu must know her birth name, as well as the location and the date of her birth. To cast a horoscope for a vampire, the ashipu must know both of those and also the date of her Embrace. Armed with such knowledge, the ashipu can both learn his enemy’s innermost secrets and target her more effectively with his magic.
System: Each success allows the ashipu to discover one secret about the target of the horoscope, chosen from the following: Nature, primary aptitudes (i.e. Traits rated at 3 or higher), Flaws, or major tragedies from her life (or unlife). Alternatively, the ashipu may use the horoscope in conjunction with an effigy to improve the efficacy of sympathetic magic, with the successes on the ritual roll reducing the difficulty penalty applied to such rolls. However, the ashipu may not use a horoscope to reduce the dice penalty by more than his Dur-An-Ki rating, nor may he use it to reduce the penalty to less than zero.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Illuminate the Trail of Prey"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 231


1. Illuminate the Trail of Prey


This ritual causes the path of the subject’s passing to glow in a manner that only the vampire can see. The tracks shine distinctly, but only to the eyes of the caster. Even airplane trajectories and animal tracks shine with unhealthy light. The ritual is nullified if the target wades through or immerses himself in water, or if he reaches the destination of his journey. The caster must burn a length of white satin ribbon that has been in her possession for at least 24 hours for this ritual to take effect.
System: The thaumaturge must have a mental picture of or know the name of her prey. The individual’s wake glows with a level of brightness dependent on how long it has been since he passed that way — old tracks burn less brightly, while fresh tracks blaze.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Impressive Visage"] = {
					en = [==[Rites of Blood, p. 146


1. Impressive Visage


Beauty and sexual magnetism have always opened doors. Influence in the Ivory Tower is won via elegant social battles of wit, elegance, and charm. Apex predators navigate these choppy waters with sly smiles to obfuscate their intentions. Rumor has it that this particular ritual was developed by Aiden Balfour, a bitter, plain-looking Tremere tired of the local Toreador Harpy unduly influencing the Prince’s favor with his pretty smile. When this ritual is cast, the thaumaturge gains a heightened degree of sexual attractiveness; she is much more desirable and commands attention as if she were a top model. For this ritual to take effect, the caster must wash her face with a point of virgin blood and place a sprig of dried mint in her shoe.
System: The caster gains two dice on all Appearance-related rolls for the duration of this ritual. This ritual lasts for a number of hours equal to the successes scored on the activation roll.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Incantation of the Shepherd"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


1. Incantation of the Shepherd


This ritual enables the caster to mystically locate all members of his herd. While intoning the ritual’s vocal component, he spins in a slow circle with a glass object of some sort held to each of his eyes. At the end of the ritual, he has a subliminal sense of the direction and distance to each of his regular vessels.
System: This ritual gives the character the location (relative to him) of every member of his Herd. If he does not have the Herd Background, Incantation of the Shepherd locates the closest three mortals from whom the caster has fed at least three times each. This ritual has a maximum range of 10 miles or 15 kilometers times the character’s Herd Background, or five miles (eight kilometers) if he has no points in that Background.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Insight"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 177


1. Insight


This ritual allows a necromancer to stare into the eyes of a corpse and see reflected there the last thing the dead man witnessed. The vision appears only in the eyes of the cadaver and is visible to no one except the necromancer using Insight. The player rolls as normal as the vampire stares into the target’s eyes for five minutes. The number of successes on the roll determines the clarity of the vision. A botch shows the necromancer his own Final Death, which can provoke a Rötschreck roll (see p. 299).
This power cannot be used on the corpses of vampires who have reached Golconda, or on bodies in which both eyes are missing or advanced decomposition has already occurred.
1 success — A basic sense of the subject’s death
2 successes — A clear image of the subject’s death and the seconds preceding it
3 successes — A clear image, with sound, of the minutes preceding death
4 successes — A clear image, with sound, of the half-hour before the subject’s demise
5 successes — Full sensory perception of the hour leading up to the target’s death
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Knowing Stone"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 177


1. Knowing Stone


By use of her own blood and the proper rituals, a necromancer can mark a person’s spirit, allowing the vampire to see where her subject is at any time, even after he has died. In this fashion many of the spirit-haunted vampires keep tabs on their close kin and their enemies.
The necromancer cuts her skin or otherwise bleeds herself, and then uses the vitae to paint the name of the target on a consecrated stone. If the ritual is successful, she can afterward learn the target’s current whereabouts by dancing around the stone in a trance state until one of the spirits whispers the desired information into her ear. The stone loses its powers on the night of All Saints Day unless the vampire spends a blood point.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Learning the Mind Enslumbered"] = {
					en = [==[Rites of Blood, p. 146


1. Learning the Mind Enslumbered


This ritual is used to determine the cause of torpor in a vampiric body or the cause of destruction in a Kindred’s ashen remains. To conduct this ritual, the thaumaturge places a penny or other small coin over the eye of the torpid Kindred. He can then hear — in the vampire’s voice — the cause of her cold rest. If all that remains of the body is ashes, the thaumaturge need only lay the penny in the remains to complete the ritual.
System: This ritual requires a half hour to cast, at the end of which the thaumaturge hears a ghostly message from the victim naming who she believes torpored or killed her. This is not a divination ritual, and therefore the information may not be accurate. If the culprit was disguised or hidden, the spirit of the victim will do her best to answer the question. This power has no effect on creatures other than Kindred.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Light within Shadow"] = {
					en = [==[Lore of the Clans, p. 126


1. Light within Shadow


One of the first powers a savant of darkness learns is the ability to see in darkness. Using this ritual, the mystic summons up a ball of shadow and stares into it for so long that her eyes permanently attune themselves to the dark.
System: Upon successful casting this ritual, the Lasombra summons into her hand a sphere of pure shadow. As she stares into the sphere, she makes a Perception + Occult (difficulty 8) roll. If the roll is successful, she permanently gains the Controllable Night Sight Merit (see p. 122). If they fail, they may try again the next night, but if they botch they permanently gain the Uncontrollable Night Sight Flaw (p. 123).
Side Effect: Whenever the vampire uses her new vision, her eyes become disturbing inky black pits of shadow. If she has no control over her sight, her eyes will always look like this.
Abyss Mysticism (p. 125): Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level. Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.]==],
				},
				["1. Locating the Oubliette"] = {
					en = [==[Dark Ages Tome of Secrets, p. 35


1. Locating the Oubliette


Abyss Mystics obsessively guard the locations of their Oubliettes from Cainites outside their ideology. Among their own, it becomes useful to know the nearest entry-point to the Abyss. Despite the dangers within that plane, Inquisition or Lupine hunters often drive a Mystic to hide within the darkness, or even lure her pursuers inside to face perils far worse than Cainites.
System: The Cainite must cut herself and expend at least one blood point. On a successful Perception + Occult roll (difficulty 5); the vampire is able to see a line one kilometer (2/3 of a mile) long (with an additional kilometer per success), leading to the nearest Oubliette if one exists. This line remains visible to the Abyss Mystic for one night per blood point spent. On a failure, nothing happens; a botch leads the Cainite to the nearest location bearing True Faith, regardless of distance.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["1. Master of the Domain"] = {
					en = [==[Dark Ages Tome of Secrets, p. 49


1. Master of the Domain


Level One Rite — The Transylvanian Kraina — Attribute: Appearance
All mortals must fear the Voivode. This rite allows koldun to take fear to the extreme, a perpetual aura of fear manifesting to make the vampire look large, dangerous, and constantly on the edge of frenzy.
System: Once the rite’s complete, the koldun gains a permanent additional two dice to attempts at Intimidation against both mortal and Cainite subjects within her domain. Master of the Domain also prevents the victims of such bullying from spending temporary Willpower to overcome its effects. The rite can be undone by the koldun’s subjects seeing the Cainite bested in any form of contest.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Memento Mori"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 293


1. Memento Mori


This ritual harrows a target with terrifying visions of his own demise. To conduct the ritual, a necromancer takes a small personal token from a target. This might be a sample of bodily fluid, a hair, or even a well-used possession. The celebrant must dig a grave at least six feet/two meters deep and no less than three feet/one meter wide. She may use supernatural means to aid her such as Potence or Protean, but she must do the work directly and not with any other aid. When she has finished burying the token, the ritual begins to take effect.
The target suffers intermittent, terrifying visions of his own death for a period of one week. Every time a target is subjected to a vision, he must roll his Courage (difficulty 7). If he fails, he can take no action other than cowering in terror until the vision passes.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["1. Minestra di Morte"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 177


1. Minestra di Morte


The necromancer obtains a piece of a dead body and simmers it in a pot with half a quart (or half a liter) of vampiric vitae. To this stew, the necromancer adds rosemary (for remembrance), basil (the funerary herb), and salt (the alchemic principle of clarification). After bringing the concoction to a full boil, the necromancer eats it.
If the roll to activate this ritual is successful, the character discovers whether the subject of the grisly rite became a wraith or Spectre after death, or if indeed she became either. Unfortunately, this information can be learned only about the person from whose body the “stew meat” was taken.
The blood component is spent progressively through the ritual: If the Necromancer takes the blood from another Kindred, she doesn’t become partially bound from drinking it, nor does she add a point to her blood pool. Similarly, if she uses her own blood, her pool decreases by a point but does not increase when she consumes the soup.
Necromantic vampires without the Eat Food Merit (see p. 480) can’t keep the soup down, but can still use the ritual and gain the information.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Pierce the Veil"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 271


1. Pierce the Veil


When one stares into the Abyss, the Abyss stares back. This ritual attunes the mystic’s vision to darkness by harnessing the watchful gaze of Ahriman, though it marks the mystic forever.
System: Using Shadow Play, the mystic forms a ball of shadows in her hand and gazes into its depths. The player rolls Perception + Occult, difficulty 8. A success results in the character permanently gaining the Merit Darksight. Failure simply means that the ritual does not succeed and must be tried another night, while a botch results in Darksight being acquired as a Flaw.
When a character uses Darksight gained through use of this ritual, her eyes become completely black, without reflection — windows into the Abyss itself. This effect is permanent for characters who obtained Darksight as a result of a botched ritual.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["1. Preserve Corpse"] = {
					en = [==[Rites of Blood, p. 103


1. Preserve Corpse


Level One Necromancy Ritual. This ritual enables the user to create an elixir that keeps dead flesh from rotting. The ritual requires the caster to physically coat the dead flesh with a liquid composed of grave dirt, defiled holy water, and rare herbs. Once the liquid dries, the flesh is indefinitely preserved — some have been known to last for hundreds of years. The ritual produces enough elixir to coat one adult human corpse.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Purify Blood"] = {
					en = [==[Rites of Blood, p. 147


1. Purify Blood


The Black Death killed more than seventy-five million people across Europe during the Dark Ages. Early experimentation showed that most diseases, even blood-borne ones, rarely have any effect upon Kindred, yet vampires can carry such diseases and pass them to their victims. This devastated private herds and caused a severe blood shortage that strained the Masquerade to its breaking point. There had previously been mystical methods of cleansing blood, but they were time consuming and complicated processes.
A solution came from the Tremere — then a struggling Clan seeking to buy their way into polite society — in the form of this simple ritual. The tainted blood must be decanted into a suitable container and then stirred with a special mixture of ash and crushed ginger as the thaumaturge chants the ritual incantation. The blood lightens slightly in color if the ritual succeeds, and the rite cleanses all poison or disease from the sample.
Purify Blood does not function on blood that’s still in a creature’s system. The ritual therefore cannot cleanse a human of disease or make drinking from such a vessel safe; it will only purify blood that is removed from the human first. Some vampires shun this ritual because of the extra work involved in securing blood without the Kiss, and the less-than-satisfactory taste (not to mention the lack of a warm, beating pulse) definitely puts off Kindred connoisseurs. For these reasons, Purify Blood remains a ritual of last resort during desperate epidemics and not a nightly staple.
System: Purify Blood functions on up to one point of blood. Because of the volume limitations, Purify Blood can cleanse only one blood point at a time. Poisons, diseases, and other mixtures disappear, while foreign substances bubble to the top and can be skimmed off. However, the ritual does not in any way change the potency of the blood; vitae can still cause a blood bond, and blood rendered acidic or caustic by a Discipline (like Quietus or Vicissitude) cannot be cleansed. This ritual cannot counter the Vaulderie (nor is it stealthy enough to perform unnoticed in the midst of such a rite). Rotten, solidified, or excessively befouled blood also vanishes if subjected to the ritual (at Storyteller discretion), so a vampire needn’t fear gagging on old, dead blood.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Purity of Flesh"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


1. Purity of Flesh


The caster cleanses her body of all foreign material with this ritual. To perform it, she meditates on bare earth or stone while surrounded by a circle of 13 sharp stones. Over the course of the ritual, the caster is slowly purged of all physical impurities: dirt, alcohol, drugs, poison, bullets lodged in the flesh, and tattoo ink are equally affected, slowly rising to the surface of the caster’s skin and flaking away as a gritty gray film that settles within the circle. Any jewelry, makeup, or clothes that the caster is wearing are also dissolved.
System: The player spends one blood point before rolling. Purity of Flesh removes all physical items from the caster’s body, but does not remove enchantments, mind control, or diseases of the blood.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Reawakening the Dead Water"] = {
					en = [==[Rites of Blood, p. 157


1. Reawakening the Dead Water


The koldun must drop one point of blood into pool of water and then drink the equivalent of one blood point from that source. The koldun will be able to ingest this water without difficulty.
System: If the ritual is successfully performed (with at least one success), the koldun regains a point of spent Willpower. This cannot raise his Willpower above its normal maximum. This ritual can only be performed once per night.
Koldunic Sorcery dice mechanics (p. 156): the roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.]==],
				},
				["1. Rite of Introduction"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 311


1. Rite of Introduction


Tremere Ritual. The Tremere use this ritual as the formal method of presentation for arrivals in a new city, though it is also possible to use this ritual to request aid. The caster boils a handful of ground tamarisk root and a drop of galangal oil in a pot of rainwater, and then recites a short incantation into the vapors that form over the pot. She then speaks a brief thirty-second message, which is telepathically communicated first to the regent and then to the other clan members in the city, according to their place in the hierarchy. The ritual allows the regent to reply telepathically and engage in a five-minute conversation with the caster, if he so desires.
Clan rituals (p. 302): Clan rituals are jealously guarded secrets that are never shared with those not belonging to the clan or bloodline harboring its mysteries.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["1. Rite of Reclamation"] = {
					en = [==[Rites of Blood, p. 76


1. Rite of Reclamation


All Assamites on some level accept the possibility that one night they might fall in battle. If that fateful night should come, Assamite Sorcery has provided a way that the Clan can reclaim what is rightfully theirs. By standing on bare earth under the open night sky, the Sorcerer asks for his blood to be transported back to the Mountain upon the moment of his final death. Here, under the ceremonial supervision of fellow Assamite Sorcerers, the blood becomes one with the Heartblood of the Clan, rejoining the blood of Haqim from which it is ultimately descended.
System: The effects of the ritual last until a number of sunrises pass equal to the number of successes rolled during the casting. When the Sorcerer reaches Final Death, all of his blood seeps out through his pores and is claimed by the earth, mystically transporting it to Alamut. If the moment of Final Death comes as the result of being diablerized, the would-be diablerist feels all of the blood gained from the Assamite clawing its way out of her, causing a number of lethal damage equal to the successes rolled in the casting of the ritual. It seeps through her pores and is sucked into the ground. The diablerie is still considered successful, but no blood is gained from the act, which could provoke a hunger frenzy check.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Ritual of Return"] = {
					en = [==[Dark Ages Tome of Secrets, p. 42


1. Ritual of Return


Only Assamites hold the necessary knowledge to locate Alamut, stored deep within the Blood of Alamut itself. When a vizier needs to send an Assamite to or from Alamut, or summon him to the Holy City, the sorcerer casting this ritual uses one of three variations. When the Ritual of Return is invoked, unless specified, the affected Assamite enters the Trance of Return described on p. 40 as soon as he sets out to journey for Alamut. Pragmatically, if an Assamite had taken refuge in a Prince’s court, this would take affect once he left the Prince’s demesne.
If all participants are in Alamut, then the sorcerer needs only to spit in dirt or dust to make mud before marking each heel of the Cainite being sent forth. Once the vizier speaks the name of the place, the Assamite immediately enters the Trance of Return. She travels to her destination as quickly as possible, and forgets her journey, only stopping to eat, take refuge from the sun, and at the clan’s Watchtowers on her way out.
If all participants are in the same place and that place is not Alamut, the sorcerer casting the spell must set a traveler’s hood upon the Assamite and instruct him to return home. The vizier then asks him if he has served Haqim faithfully (to which the Assamite is expected to answer yes). The sorcerer takes the vial of blood kept on the vizier’s person and draws a circle around the traveler using the vial as a tool to mark the ground. When the vizier speaks the name of Alamut, the Assamite repeats it and immediately enters the Trance of Return.
If the vizier and sorcerer are in Alamut, but the Assamite being summoned home is not, then the ritual is more complicated. The sorcerer invokes the Blood of Alamut to call home the wandering member of the clan. This requires that the caster be a member of the Keepers of the Pool (as described on p. 41). The Keeper must draw a circle around the vizier, who speaks the name of the summoned Assamite three times while having blood from the pool poured over her head. The clan member feels irrevocably drawn, but may spend the night settling affairs before he begins his journey home the next night, at which point he enters the Trance of Return immediately. The use of this ritual is generally limited to times when an Assamite is nowhere near a major city where viziers and sorcerers would be able to use the second method of invoking the Ritual of Return.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["1. Ritual of the Smoking Mirror"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 178


1. Ritual of the Smoking Mirror


This ritual allows the necromancer to use an obsidian mirror to see as ghosts do. By gazing into the mirror’s ebony depths, the vampire may discover an object’s flaws, assess the general health of mortals, or even read a being’s aura.
At the start of the ritual, the Kindred decides which of the ritual’s two aspects she will use — she may not use both at the same time. With Lifesight, the necromancer may read auras as if she had the level two Auspex power Aura Perception. Deathsight, on the other hand, grants the necromancer the ability to see ghosts and the Shadowlands. It also shows the stain of oblivion on the living, as per Eyes of the Dead (p. 174). At the Storyteller’s discretion, the Kindred may make a similar study of an inanimate object’s flaws and how to repair them, if that object has a strong link to either life- or death-energies (such as a murderer’s knife or a window box used to grow healing herbs).
To perform the ritual, the necromancer grasps an obsidian mirror that has had its edge sharpened so that it cuts the flesh of whoever takes hold of it. As the vitae flows onto the mirror’s surface, it allows the mirror’s reflective power to bridge the worlds of the living and the dead, much as it allows the necromancer herself to do. The player then rolls to activate the ritual as normal. If successful, the Necromancer may view the world as a ghost does via the reflective surface of the mirror, for one scene. On a botch, the vampire may well invoke the ire of the spirits upon whom she calls.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["1. Sanctify the Temple"] = {
					en = [==[Rites of Blood, p. 62


1. Sanctify the Temple


The Old Skool Anarchs are usually the most religious of all Anarch blood magicians, although the gods they worship are more obscure than those of most contemporary religions. Regardless, like all religionists, the Old Skoolers prefer to have a place of worship sanctified to their beliefs. The precise form of this ritual varies according to whichever god, spirit, or loa the Anarch serves, but if it’s inside a building, the entire space must be decorated to reflect the iconography of the entities worshiped as well as the ritual sacrifice of some kind of animal. Outside spaces such as those used by Kindred Wiccan groups or Voudoun cults require less in the way of decoration but have a greater risk of discovery and desecration by outsiders. Regardless of who or what is worshiped, the results from this ritual are the same — a safe space in which magic can be performed more easily.
System: The ritual lasts for one lunar month but it can be renewed indefinitely. While the ritual is active, the difficulty of all rolls to activate Old Skool paths or rituals performed within the temple space is reduced by -1. The number of successes determines the maximum size of the space which can be sanctified.
1 success — a five-by-five foot/two-by-two meter area, such as a large walk-in closet, a secret room, or a tiny grove
3 successes — a twenty-by-twenty foot/six-by-six meter area, such as the sanctuary of a small church or a large grove
5 successes — an area of 100 square feet/30 square meters or so, such as a medium-sized church or a small wood
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Sanguineous Phial"] = {
					en = [==[Rites of Blood, p. 147


1. Sanguineous Phial


The Followers of Set have long practiced an archaic version of this ritual during their religious rites and devotions to their dark god. The Tremere streamlined the ritual to allow them to quickly hold large quantities of blood for an indefinite amount of time without it spoiling. In modern nights, it is useful for Kindred who do not have the medical knowledge or technology required to preserve blood in a more mundane fashion. A side benefit to this ritual is that it works on Kindred vitae without severing the Principle of Identity (pp. 132-133). This allows a cagey thaumaturge to store the blood of her enemies and use it at just the right moment.
System: To prepare for this ritual, the thaumaturge buries a covered earthenware container for two nights and then unearths it. The following evening, she crumbles dried ash leaf into the empty canister and then whispers the proper incantation. Afterwards, she may pour blood into the vessel and then seal it closed with tallow melted from a candle. The blood will remain fresh until the seal is broken. After the container is opened, the blood begins to spoil at a normal rate. If the vessel is broken, the blood immediately deteriorates to the state it would have attained had it not been preserved at all. The vessel may be used more than once, but the ritual must be recast or the blood will go bad.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Sense the Mystical"] = {
					en = [==[Rites of Blood, p. 147


1. Sense the Mystical


Blood magic creates a resonance in the space in which is it cast. This mystical energy can be detected and measured. A thaumaturge can use this ritual to sense this resonance left by magical objects and effects. This ritual was originally developed to seek out non-Tremere thaumaturges and magical artifacts, and is commonly used among the younger Tremere seeking to make a name for themselves. The thaumaturge chants over a mystically prepared candle and then lights it. All sources of blood magic within the radius of the candle light glitters visibly to all present.
System: The effect of this ritual lasts for a number of hours equal to the successes scored on the activation roll. Sense the Mystical can detect Thaumaturgy, Necromancy, and similar blood magic if used within the radius of the candle light. This power does not distinguish between the different types of blood magic, nor does it pick up normal Disciplines. This ability lasts for one hour.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Servitor’s Perception"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


1. Servitor’s Perception


Level One Rite — Genius Loci — Attribute: Perception
When a koldun wants to see farther than her Genius Loci would usually allow, she can stand atop a mountain, tower, or other elevated location, and imbue an animal servitor with her Koldun Sorcery. Depending on the other Disciplines the koldun may hold, she may then command the animal to spy and return, or even observe through the animal’s eyes.
System: Upon completion of the rite, the koldun imbues any animal with as many points as she has in Genius Loci. The koldun will require a way of commanding or possessing the animal if she wishes to have any influence on what the animal looks for, or reports back. This rite is broken if the animal is slain.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Shew-Stone"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 293


1. Shew-Stone


This Impundulu ritual creates a magical stone, which can be used to keep track of a necromancer’s friends or enemies, living or dead. To create a Shew-Stone, a necromancer must paint a person’s name in a bird’s blood (Germanic traditions insist on using the blood of a hoopoe) on a consecrated, polished stone. The necromancer must appease the spirits by performing a ritual such as a dance, a prayer, or an offering. Ghostly spirits will then appear in the Shew-Stone and whisper the target’s whereabouts in the necromancer’s ear.
The stone loses its powers after a month unless the necromancer spends a blood point to renew the magic.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["1. Sigil of Authority"] = {
					en = [==[Rites of Blood, p. 24


1. Sigil of Authority


Sigil of Authority utilizes the principle of sympathetic magic to create a link between the known authority of an office and the enforcer of said office, via a mystical sigil. When the Sigil of Authority is revealed to a vampire beholden to the specific office, she immediately knows that the possessor of the Sigil represents and carries the word of said office.
Initially, this ritual was designed by a Tremere Justicar to mark his agents traveling across the globe in his service. Popularity of this ritual spread, and many Princes now issue Sigils of Authority to officers of their court to ensure that new arrivals immediately know and understand who the court officers are of a domain.
System: The thaumaturge methodically cuts a design into the flesh of the willing subject with a silver-tipped blade. This sigil must be at least three inches in diameter and may be placed anywhere on the body of the subject. The design should metaphorically present the authority of the office represented and the meaning easily understood by those that see it. For example, the sigil of a domain’s Sheriff might be a star shaped badge or police shield.
The thaumaturge must spend an evening in the willing presence of the Sigil Investor (the vampire that holds the office from which the authority arrives) and the Sigil Bearer (the vampire that will carry the voice of said office) to attune the sigil to the resonance of the office. At the end of the evening, the Sigil Bearer must swear an oath to the office. Once activated, everyone present instinctively knows that the Sigil Bearer lawfully represents the office of the Sigil Investor.
The Sigil Bearer must expose the sigil and expend a temporary point of Willpower to project the weight of authority of the Sigil Investor. Any vampire in her presence must make a Self-Control roll (difficulty 8) or be down three dice on all Social rolls against the Sigil Bearer for the next fifteen minutes.
The Sigil of Authority lasts one year per success on the activation roll, and the Bearer is aware of when it fades. This ritual may be renewed by the Sigil Bearer re-swearing the oath of office.
The authority of the sigil may be revoked immediately if the Sigil Investor expends a point of Willpower. Should this happen, the Sigil Bearer learns this immediately as the symbol cut into her flesh is burned until the symbol is no longer visible. This rejection is painful, and burns an aggravated level of damage into the former Sigil Bearer’s flesh.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Strength of Haqim"] = {
					en = [==[Dark Ages Tome of Secrets, p. 42


1. Strength of Haqim


One of the first rituals a new Assamite sorcerer can learn is this protective spell meant to allow her to draw on the power of all Assamites, past and present, to resist domination or blood addiction. By carrying with her an amulet bathed in the Blood of Alamut and reciting a brief incantation, an Assamite may gain additional dice equal to her dots in Thaumaturgy to resist the affect of mind-altering spells or Disciplines. The vampire’s defense to these same effects is reduced by one after every failed casting. If the effect does not allow for a defense, this applies as a penalty to the activation.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["1. Tame the Maddening Flame"] = {
					en = [==[Dark Ages Companion, p. 116


1. Tame the Maddening Flame


Note: This is a Haven Ritual (see Dedicate the Haven, V20 Dark Ages, p. 310)
Fire lights the Dark Medieval and, though Cainites fear it, they can usually control their response in the face of a tamed campfire, hearth, or torch. This ritual protects them when fire might spread unpredictably, such as on a battlefield or when it’s otherwise used as a weapon.
The Tremere pollutes a jug of water with a trivial amount of his blood, and uses it to wet the perimeter of a room or outdoor location. An enclosed space of almost any size can be protected, but an outdoor area is limited to a 150 foot (roughly 50 meter) radius. New or existing fire in the protected area takes on a greenish hue and its smoke smells sweet. It can no longer provoke Rötschreck. Furthermore, reduce the damage of all injuries inflicted by fire within the area by one Health Level. This lasts for as long as the caster is present.
Haven Ritual (V20 Dark Ages, p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["1. The Abyss Knows"] = {
					en = [==[Dark Ages Tome of Secrets, p. 35


1. The Abyss Knows


Mystics make clear that any Cainites implementing the rituals of Abyss Mysticism must stare into the starlit sea and dedicate their eternal selves to the Abyss. They must open all their secrets to intrusion by the darkness. The pledge is only words, but those who do not make it, or state it without conviction in their hearts, are visibly liars to practitioners of The Abyss Knows.
System: The Cainite must possess the Abyss Mysticism ritual Pierce the Veil (see V20 Dark Ages p. 271) and have the Darksight Merit. By spending one blood point and rolling Perception + Awareness (standard difficulty versus an opposed Conscience/Conviction roll, if resisted), success indicates whether the target is a true servant of the Abyss or an impostor. Failure has no effect; a botch means the Abyss Mystic misreads the result.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["1. The Word of the Dark God"] = {
					en = [==[Rites of Blood, p. 83


1. The Word of the Dark God


Many Sorcerers, upon learning the foundations of Setite Sorcery, wish to appease the Dark God further and bask in even more of his favor. What better way than to fulfill his direct command?
Taking a corpse (perhaps a mummy desecrated in the process of obtaining Akhu or the body of a Nahuallotl sacrifice), the Sorcerer kneels above its head and prays for guidance from the Dark God. The caster offers a point of blood into the mouth of the corpse and, upon the completion of the ritual, the corpse whispers a name from its dead mouth. This is the name of a person Set wishes to be corrupted. If the Setite is successfully in corrupting this individual, the act will earn her further favor from the Dark God.
System: This is purely a narrative device for the Storyteller to take advantage of, with no other mechanical benefit. As an optional rule, Storytellers could employ the tasks set by practicing this ritual as tests to complete before being granted access to higher levels of Setite Sorcery. Otherwise, the favor of Set can manifest itself in any way the Storyteller desires.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Treasured Ornaments"] = {
					en = [==[Dark Ages Tome of Secrets, p. 49


1. Treasured Ornaments


Level One Rite — The Transylvanian Kraina — Attribute: Manipulation
Treasured Ornaments awakens the spirit of every ornament with a colorful past in the koldun’s haven. The spirits will not speak unless spoken to, and will be entirely fearful of the koldun. The purpose of this rite is primarily the creation of immobile sentries. They will — in simple terms — report what they’ve witnessed when questioned.
System: Upon completion of the rite, the koldun can converse with important ornaments in her haven. The effects are permanent, though leaving the spirits in situ tends to aggravate them over time. An ornament of importance is one with a history — perhaps a gifted weapon, or the cot of a deceased child. The rite is dismissed when an uninvited guest touches the ornaments.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Truth in Water"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


1. Truth in Water


Level One Rite — The Black Sea Kraina — Attribute: Appearance
Truth in Water is a trick held dear by koldun of the Black Sea Kraina. The rite conveys purification using the simple element of water. Any lies told by a mortal containing the water in their body, or by a party immersed in that water, forces the liquid to heat up to boiling temperatures.
System: Success of the rite converts water into a form of lie detector. The rite only affects enough water to fill a barrel, but this water remains pure until it’s spilled on the ground. Once boiling, it deals one level of lethal damage to mortals who lie while in contact with it, and one level of bashing damage per turn to Cainites.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Typhon’s Brew"] = {
					en = [==[Rites of Blood, p. 84


1. Typhon’s Brew


Most preparations of Setite alchemy begin with this magical, vitae-laced beer. A Lector Priest who does not know how to create Typhon’s Brew can forget about pursuing further knowledge of alchemy. This beer sustains ghouls as if it were true vampiric vitae. Vampires can drink it, too, with similar results.
By itself, Typhon’s Brew has no other properties. It cannot be used to Embrace a mortal, nor to blood bond. The brewing process negates this aspect of vitae.
System: Brewing the Typhon’s Brew takes a full lunar month, beginning and ending at the dark of the moon. For every gallon brewed, the alchemist includes one blood point’s worth of his own vitae. The brewing process multiplies the vitae, so that a ghoul can gain one blood point per quart of the magic beer. Vampires, however, gain only one blood point per gallon consumed — the same rate as in brewing the beer. For vampires, the beer’s magic is limited to the fact that they can drink it at all without heaving it up seconds later. They can even get drunk on it (and may suffer a hangover later).
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["1. Unnatural Decay"] = {
					en = [==[Dark Ages Tome of Secrets, p. 48


1. Unnatural Decay


Level One Rite — The Białowieza Kraina — Attribute: Stamina
Koldun hold special ire for mortals who dare refuse to settle taxes and make blood sacrifices when required. Such disrespect is punishable by souring the earth itself, cursing the bounty it produces and those who consume it.
System: Upon completion of the rite, all crops within one kilometer (2/3 of a mile) of the rite’s completion become mildly poisonous to humans, causing those who consume the toxic produce to lose one dot of Stamina a week. The rite is undone through a mortal’s bloodletting on the cursed earth. This only technically requires the loss of about three blood points, but often means the mortal’s death in practice.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["1. Wake with Evening’s Freshness"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


1. Wake with Evening’s Freshness


This ritual allows a vampire to awaken at any sign of danger, especially during the day. If any potentially harmful circumstances arise, the caster immediately rises, ready to face the problem. This ritual requires the ashes of burned feathers to be spread over the area in which the Kindred wishes to sleep.
System: This ritual must be performed immediately before the vampire goes to sleep for the day. Any interruption to the ceremonial casting renders the ritual ineffective. If danger arises, the caster awakens and may ignore the Humanity/Path dice pool limit rule for the first two turns of consciousness. Thereafter, the penalty takes effect, but the thaumaturge will have already risen and will be able to address problematic situations.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Water Walking"] = {
					en = [==[Rites of Blood, p. 63


1. Water Walking


It is said that masters of Pranayama Yoga have the power to walk across waters without sinking. Whether mortal yogi have that power or not, New Age Anarchs have certainly claimed it for themselves. The magician must close her eyes and quietly recite a personal mantra relevant to the elevation of the spirit over base matter. If her will properly manifests through the ritual, she may walk across water or any other material not normally capable of supporting her weight (such as across treetops) so long as she remains in constant motion.
System: In combat, the successes determine how many turns the New Ager can continue to move without sinking or falling. Out of combat, the effects of the ritual last for as long as the ritualist remains in motion or until the end of the scene.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Weight of Shadows"] = {
					en = [==[Rites of Blood, p. 38


1. Weight of Shadows


Level 1 Abyss Mysticism Ritual. For the rest of the evening, the caster may concentrate and control naturally occurring shadows, making them move, act, or otherwise obey the caster’s commands. So long as the caster takes no other action, she may thus control any shadow that is not currently being controlled by another individual.
System: This ritual only allows the caster to control natural shadows, not shadows created by Obtenebration. Shadows controlled by the caster can gain or lose a small amount of size (thus a woman’s shadow could be made look like a man’s, but a dog’s shadow could not). Only one such shadow may be controlled at a time. The Storyteller is the arbiter of what kinds of shadows are simply too large for this power to affect (such as the shadow of a skyscraper). The effects of this ritual last until the next sunrise.
Side Effect: Shadows are drawn toward the caster, and when not controlled, will attempt to move toward her, even to the point of bending against the light. The caster gains the Flaw Eerie Presence (with the above descriptor) for the duration of this ritual’s effects. (V20, p. 495).
Abyssal Rituals (p. 37): The following rituals do not adhere to the same rules as other forms of magic, in large part because they build on a Discipline that is not truly a form of sorcery. To learn Abyss Mysticism, a Cainite must have at least one dot in both Obtenebration and one dot in Occult. Such a character may not learn Abyss rituals rated higher than her Obtenebration or Occult score (whichever is lower). Casting Abyss rituals requires a successful Wits + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to succeed. Unlike normal rituals, each Abyss Mysticism ritual costs 3 times the ritual level in experience points to learn. All rituals of Abyss Mysticism also have permanent side effects; under no circumstances do Flaws obtained from these side effects reward the vampire with bonus or experience points, nor can they be bought off.]==],
				},
				["1. Widow’s Spite"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


1. Widow’s Spite


This ritual causes a pain, itch, or other significant (but not deadly) sensation in the subject. Similar in effect to legendary “voodoo doll” effects, this ritual is used more out of scorn or malice than actual enmity. In fact, it requires a wax or cloth doll that resembles the target, which bleeds when the power takes effect.
System: The ceremonial doll must resemble, however rudely, the victim of the ritual. It produces no mechanical effect, other than a simple physical stimulus. The caster may determine where on the subject’s body the pain or itch appears.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["1. Word of Insight"] = {
					en = [==[Rites of Blood, p. 93


1. Word of Insight


Necromancers in the Classical Era called forth the spirits of the dead to gain insight upon the future. It is believed that one of the Premascines, Antonius Giovanni, preserved this ritual to the modern nights, and modern Necromancers still perform this form of divination. The Necromancer travels to a known haunted location, or a place where the barrier between this world and the next is known to be weaker. There she sets up a triangle comprised of three items that represent her own past, present, and desired future. An incense burner is positioned and lit in the center of the triangle. The Necromancer calls upon the spirits present to grant insight into events yet to come that will enable her to reach her desired goal.
System: Upon successfully casting the ritual, smoke billows from the incense burner and a myriad of ghostly faces can be seen within. Each face mutters or whispers a word or phrase, each one overlapping, making a cacophonous din. The vision and the voices fade after a few seconds.
The future is a wide, changing sea of possibilities, so at the outset, the Necromancer must specify a particular subject that she is enquiring about (closing a successful deal, obtaining a particular item, overcoming a certain problem, etc.). The Necromancer doesn’t necessarily find the voices coherent or understandable, but when the ritual comes to fruition, she experiences a moment of clarity and knows what the message meant.
Mechanically, this insight allows the Necromancer to reroll one failed action later on in the same night the ritual was cast, as long as it is in direct pursuit of the future she divined. She foresaw this failure, and potentially knew how to avoid it. If she fails the second roll, she still fails, realizing the insight just a moment too late.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Abyssal Blade"] = {
					en = [==[Dark Ages Tome of Secrets, p. 35


2. Abyssal Blade


Abyss Mystics are assassins and warriors as often as they are cloistered scholars; the Abyssal Blade ritual grants them a deadly force against even the most hardened of opponents. The Abyss wreathes around a Mystic’s edged weapon, coating the metal in a swirling ichor of shadow. The ritual enables the blade to cut through armor as if it were immaterial, and inflict wounds impossible for mortals to heal.
System: The Abyss Mystic must immerse the blade of her weapon in the blood of any living creature, holding the weapon’s handle as she dedicates her future kills to the Abyss. She rolls Strength + Occult (difficulty 7), with success imbuing the weapon with an unholy power allowing a weapon to bypass armor — not Fortitude — and inflict aggravated damage on mortals. Each success results in the weapon remaining imbued for a night. Once the power runs out, the weapon corrodes and becomes useless. The ritual can be enacted more than once on the same weapon, prior to corrosion. Failure leads to no result; a botch causes the weapon to corrode immediately, and prevents the ritual from being incanted again that night.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["2. Antonius’s Denial"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 293


2. Antonius’s Denial


A prodigy of Augustus Giovani’s blood, called Antonius Giovani, crafted this wicked rite early in the bloodline’s studies. It denies death to a victim, albeit temporarily. It does not, however, deny pain. The ritual requires the vampire temporarily sacrifice a dot (not a point) of Willpower, which only returns the night after he chooses to end the effects. Upon casting this ritual, the victim gains a number of phantom Incapacitated Health Levels equal to the casting successes. The character cannot be Incapacitated, only Crippled, no matter the damage he takes. The victim cannot heal these phantom Health levels under any circumstance, and if the ritual ends, any wounds in those boxes are added as aggravated damage to his normal Health track.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["2. Ascension of the Blood"] = {
					en = [==[Lore of the Clans, p. 221


2. Ascension of the Blood


As the Tremere have plenty of blood rituals that require ingestion, it has become useful to be able to remove some of its inherent qualities. This ritual “purifies” the blood used in it, so it does not count as drinking from an individual for the purposes of blood bond.
System: The ritualist prepares a special chalice into which she puts as much of her blood as she requires. With at least one success, the blood in the chalice can no longer create a blood bond and is safe for anyone else to drink. Of course, the blood still looks the same whether the ritual is a success or the Tremere is simply lying.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Autumn’s Armor"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


2. Autumn’s Armor


Level Two Rite — The Białowieza Kraina — Attribute: Stamina
The koldun possessing Autumn’s Armor is permanently augmented by the minerals of the earth. After consecrating herself in a swamp or grave, she emerges with small stones and roots embedded in her flesh. As well as making her a sight to behold, the extra layer constitutes unnatural armor.
System: Upon conclusion of the rite, the koldun emerges from the land bearing earthen armor with a permanent rating of 2 against all forms of damage. The armor increases the difficulty of Social actions by 2. The rite concludes if the koldun is struck by a stone-tipped weapon.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["2. Banning Rituals"] = {
					en = [==[Dark Ages Companion, p. 116


2. Banning Rituals


Banning Rituals (Level Two or Higher; See Below)
Note: This is a Haven Ritual (see Dedicate the Haven, V20 Dark Ages, p. 310)
Where wards (see V20 Dark Ages, pp. 305-306) hinder mundane intruders and thieves, bans target supernatural powers such as Disciplines and the mortal magic the Tremere once practiced. Without bans, the Tremere would have been at the mercy of mortal Hermetic sympathetic magic, which can annihilate enemies from vast distances.
Like a ward, a ban can be cast on an object or an enclosed space. After one hour of preparation, the Tremere draws a sign in the occult Enochian language that symbolizes the phenomena to be banned.
Each category of power must be learned as a separate ritual, with a level set by the maximum strength of the phenomena to be banned, which is one dot lower. Thus, a Level Two version bans first dot phenomena from one category. The categories are:
• Infernal Powers: Demonic powers, Infernal magic of all kinds.
• The Kindly Ones: Powers of the Fae
• Sorcery: Mortal magic as learned by Path or Pillar
• Spiritual Malice: Lupine and spirit Gifts.
• Wrath of the Dead: Ghostly Arcanoi
• Wisdom of the Curse: Cainite Disciplines.
If the power does not possess a dot rating, use the highest Trait rating involved in its operation. Powers within the category cannot affect a banned object, or cross the threshold of a banned space in either direction, but may still be used within it. For instance, a mortal magus might read a Tremere’s mind while both stand in a haven Banned against Sorcery, but not while one stands outside and the other inside.
Similar to wards, bans may be resisted with an extended Willpower roll with a difficulty of 4 + ban level, accumulating successes equal to the ban caster’s Thaumaturgy rating. The character challenging the ban must be able to see or touch the object or threshold, however. Success destroys the ban, and no matter the caster’s location, she hears a sharp cracking sound when it falls.
Bans last for a number of weeks equal to the successes scored on the casting roll.
Haven Ritual (V20 Dark Ages, p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Beat Your Way to Glory"] = {
					en = [==[Rites of Blood, p. 65


2. Beat Your Way to Glory


This ritual allows an Anarch to copy aspects of the appearance of a particular mortal — hair color or style, eye color, tattoos, piercings, even clothing choices — by essentially beating them out of the target. The sorcerer may perform this ritual herself or she may perform it through another Anarch by rubbing his shoulders from behind and whispering what to say. The sorcerer must spend one point of blood and make the activation roll whether he is performing the ritual for himself or another. Regardless, the one to be altered must then walk up to a particular mortal with the desired physical characteristics and say “I like your look. I’m taking it.” Then, the vampire must punch the mortal in the face.
To complete the ritual, the vampire must render the mortal unconscious through brute force unaided by vampiric powers. In fact, merely speaking the incantation causes the vampire to lose access to all of his Disciplines and prevents him from spending blood for the duration of the fight (or for the rest of the scene if the mortal wins) — Punk Sorcerer philosophy says that a vampire who can’t take a mortal in a fair fight deserves to get his ass kicked anyway.
Once the mortal is rendered unconscious, the vampire claims his prize. If he wants to copy the mortal’s hair style, he must remove a large handful of the mortal’s hair. If he wants eye color, he gives the mortal a black eye. If he wants a piercing, he rips the mortal’s piercing straight out of the skin and swallows it. If he wants a tattoo, he damages the mortals tattoo in some permanent way. If he likes the mortal’s clothes, he slices them to bits, keeping a few rags for himself.
System: Each success causes the vampire to gain one Appearance-related characteristic of the mortal victim, chosen from hair color, hair style, facial hair, tattoos, piercings, or clothing. When the vampire awakens the next night, he will have those traits (and if appropriate, will awaken wearing a copy of the mortal’s clothes sized perfectly to fit him). The ritual will not change overall appearance — the vampire still looks basically the way he did before, and only superficial traits are changed. Piercings and tattoos appear on the vampire’s body in roughly the same location as they were on the mortal’s body but adjusted where necessary due to differences in size and build. Clothing will last until destroyed, but all other acquired characteristics become part of the vampire’s default appearance.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Blade of Smoke and Shadow"] = {
					en = [==[Rites of Blood, p. 77


2. Blade of Smoke and Shadow


Ever since the nights of the Second City, the Assamites have fought against demonic forces. Mundane physical weapons normally have no effect upon such ephemeral beings, but Assamite Sorcerers have long-known the secret of enchanting a blade so that it can strike demons.
The Sorcerer first obtains an obsidian dagger with an iron handle. This may be prepared by the Sorcerer or otherwise obtained — the significance is in the composition of the weapon rather than the method in which it is created. Next, she prepares a chamber where no light can naturally enter. This ritual must be cast in complete darkness, or it automatically fails.
The following must be present in the chamber, but can be real or depicted in any way the Sorcerer chooses: a collection of water, representing the primordial ocean, and a block of hardened clay, representing the Sumerian Tablet of Destinies.
The Sorcerer invokes the name of the Sumerian hero Marduk in any way she desires, as long as she is calling upon his aid to strike at the forces of Tiamat, the forces of chaos and darkness. While chanting, the Sorcerer lets the blade taste her blood.
After ten minutes of invocation, if the roll is successful (which also incurs one lethal damage from the bloodletting), the ritual is complete. The obsidian blade becomes completely insubstantial, leaving only the handle solid. The blade now appears as a slowly swirling column of smoke extending from the handle but generally retaining its former shape. It remains in this fashion until a number of sunrises pass equal to the number of successes rolled. Afterward, the smoke dissipates and the obsidian blade is gone forever (thus requiring a new blade to be obtained for a new casting).
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Blood Calls to Blood"] = {
					en = [==[Dark Ages Tome of Secrets, p. 43


2. Blood Calls to Blood


A vizier often needs to contact a member of the clan who is roving the world, in a court in Europe, or infiltrating a coterie to judge one of its members. By invoking the name of the Cainite he wishes to contact, the vizier can direct a sorcerer to reach out to the clan member in question as long as he faces that clan member’s general direction. If the vizier requesting the conversation is of lower generation than his target, the connection begins immediately and he may then speak into the clan member’s mind, hear sent thoughts, and even see through the eyes and hear through the ears of his fellow Assamite. If the requester is of a higher generation, the traveler gains full knowledge of who he and his sire are, where they are, and their general state of mind, and may accept or reject the communication.
The sorcerer merely acts as a conduit enabling the communication, and cannot take part nor hear any part of the exchange. She must spend a point of blood for every five minutes the connection stays open, rounded up. An Assamite of lower generation can use any Clan Disciplines that normally require physical proximity while communicating in this way.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Blood Crystal"] = {
					en = [==[Rites of Blood, p. 63


2. Blood Crystal


For centuries, crystals have played a part in the practices of the New Age movement. Even today, many mortal New Age adherents believe that meditating on crystals can facilitate healing or provide other beneficial effects; when provided by a New Age sorcerer, they can. The sorcerer must place a piece of clear quartz into an earthen bowl full of purified water. Then, she must add her own vitae to the waters and begin meditating over the bowl. Over the next hour, the water will slowly clear again as the vitae is absorbed into the crystal, which will turn a soft pink. Crystals infused in this way have several effects. First, at any time, the sorcerer may hold a crystal, meditate for a few seconds, and withdraw the stored vitae back into her own body. More importantly, however, the sorcerer may provide a crystal to another for meditation purposes, and if the recipient spends at least one scene meditating on the crystal (for whatever purpose she chooses), the vitae will flow into her with the exact same results as if she had drunk directly from him. Many New Age cult leaders use this technique to blood bond potential cultists long before meeting their new servants face-to-face.
System: The number of successes determines the maximum number of blood points that can be stored in a single crystal. The sorcerer can withdraw any or all of his own vitae from a crystal at will. Any other character who handles the crystal and meditates upon it will magically withdraw one point of vitae from it into her own body if she obtains even one success on a Willpower roll (difficulty 7). This includes mortals or even supernatural beings such as Lupines or mages. If the meditating character has suffered any injuries, the blood heals her as if she were a ghoul who had consciously spent blood for healing. A character who meditates on a crystal successfully on three occasions will become blood bound to the crystal’s creator (assuming it contained enough vitae). However, while the crystal still contains vitae, it carries a sympathetic link to its creator equivalent to a point of his vitae when in the hands of a rival blood magician.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Blood Walk"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


2. Blood Walk


A thaumaturge casts this ritual on a blood sample from another vampire. Blood Walk is used to trace the subject’s Kindred lineage and the blood bonds in which the subject is involved.
System: This ritual requires three hours to cast, reduced by 15 minutes for each success on the roll. It requires one blood point from the subject. Each success allows the caster to “see back” one Generation (to a limit of the Fourth Generation — the Third Generation do not give up their secrets so easily), giving the caster both the true name of the ancestor and an image of his face. The caster also learns the Generation and Clan or bloodline from which the subject is descended. With three successes, the caster also learns the identities of all parties with whom the subject shares a blood bond, either as regnant or thrall.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Borne by Wind"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


2. Borne by Wind


Level Two Rite — The Transylvanian Kraina — Attribute: Dexterity
First impressions are everything. Koldun using Borne by Wind are capable of riding breezes and gales to arrive at locations as if from thin air, in a flourish of sweeping cloaks and chill wind. Tales tell of koldun who use the wind as their steeds in battle, appearing from nothing with sword in hand and fangs extended.
System: Once the rite is completed, the koldun is capable of swooping into an area if a wind is present and he can see his destination. With one turn’s focus, he disappears from his original location, traveling at the speed of the wind, and reappears at his intended destination. This rite cannot be used if being attacked, as the Cainite cannot focus in such an occasion. It allows him to make a surprise attack on an unsuspecting foe, however. This rite is neutralized if the koldun utilizes it to launch an attack, and misses his first blow.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["2. Burning Blade"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 232


2. Burning Blade


Developed during Clan Tremere’s troubled inception, Burning Blade allows a caster to temporarily enchant a melee weapon to inflict unhealable wounds on supernatural creatures. While this ritual is in effect, the weapon flickers with an unholy greenish flame.
System: This ritual can only be cast on melee weapons. The caster must cut the palm of her weapon hand during the ritual — with the weapon if it is edged, otherwise with a sharp stone. This inflicts a single health level of lethal damage, which cannot be soaked but may be healed normally. The player spends three blood points, which are absorbed by the weapon. Once the ritual is cast, the weapon inflicts aggravated damage on all supernatural creatures for the next few successful attacks, one per success rolled. Multiple castings of Burning Blade cannot be “stacked” for longer durations.
Furthermore, the wielder of the weapon cannot choose to do normal damage and “save up” aggravated strikes — each successful attack uses one aggravated strike until there are none left, at which point the weapon reverts to inflicting normal damage.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Comforting Darkness"] = {
					en = [==[Lore of the Clans, p. 126


2. Comforting Darkness


The Abyss can heal as well as harm. Using this power, the vampire draws darkness into herself and uses it to heal her wounds. However, there is a price to be paid, and the Abyss will claim it in blood.
System: Once this ritual is cast, the vampire makes a Stamina + Occult roll (difficulty 8). If she botches, the darkness burns her, and she takes an aggravated level of damage. If she succeeds, she may then spend one blood point for each success, regardless of Generational limits. For each blood point she spends in this way, she may heal three levels of bashing or lethal damage.
Unfortunately there is an additional cost before the darkness inside is sated. All blood the vampire consumes feeds the dark inside, not even entering her own system. This goes on until twice as much blood has been consumed as was originally spent. Until this cost is paid, the Cainite cannot use this ritual again. It can also only be used once each night.
Side Effect: The taint of darkness never leaves the caster’s blood, turning it a dark ruddy hue, almost black, forever.
Abyss Mysticism (p. 125): Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level. Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.]==],
				},
				["2. Commune with Cainite"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 304


2. Commune with Cainite


By enacting this ritual, a caster may join minds with another Cainite, speaking telepathically with her over any distance. The caster must meditate for ten minutes over a physical token once owned by the other Cainite to create the connection. The communication may be maintained for one scene, or until either party ends the conversation.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Concentrated Vitae"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


2. Concentrated Vitae


Level Two Rite — The Black Sea Kraina — Attribute: Stamina
To any other Cainite, blood mixed with water would be foul, if not indigestible. The koldun with Concentrated Vitae is the opposite. Any blood poured into water increases in potency, leading to a fine way of maintaining a herd’s reserves.
System: Upon completion of the rite, blood consumed when mixed with the chosen water conveys double the number of blood points as normal. The rite only concludes if the water is befouled with another substance.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["2. Craft Bloodstone"] = {
					en = [==[Rites of Blood, p. 147


2. Craft Bloodstone


A Bloodstone is a small pebble that has a sympathetic link with the thaumaturge that created it, allowing her to always know the direction and general distance of the object. This ritual was widely used by the Tremere during the many wars of the Dark Ages, when knowing the position of troops, messengers, and property could give your side an incredible tactical advantage. As technology advanced with the invention of satellite communication and GPS systems, Bloodstones fell out of favor. However, more conservative thaumaturges have returned to this older method for tracking their allies, mumbling fears about “hackers” and “technomancers.”
To create a Bloodstone, the thaumaturge must place a small pebble into a vial filled with three points of blood from any source. (This blood does not need to be human.) Once a night, over the course of three nights, she must recite an invocation over the vial. The bloodstone slowly absorbs a single point of blood each night, and the liquid becomes slightly clearer, until on the third night it becomes as transparent as water. The thaumaturge then has a mystical connection to the stone, and knows its relative position at all times.
System: A thaumaturge may create a number of Bloodstones up to her permanent Willpower rating. She instinctively knows the precise direction and general distance from the caster. If a Bloodstone is obfuscated or mystically hidden, the caster may follow the trail until she reaches the general location. Once there, the connection becomes blurred and she can no longer quite feel the Bloodstone. A Bloodstone that is destroyed severs its connection to the thaumaturge immediately, often with some form of painful backlash (which is distracting, but not damaging).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Craft Gris-Gris"] = {
					en = [==[Rites of Blood, p. 166


2. Craft Gris-Gris


Craft Gris-Gris is a Level Two Wanga Ritual. Well-known to those familiar with Voudoun, a gris-gris bag is a cursed item which inflicts pain and misery on the target. The wangateur must fill a bag with herbs, mineral powders, the finger bone of an infant, nine pinches of grave dirt, some item taken from the target, and two points of her own blood. The bag must then be hidden (ideally buried) within a few feet of the target’s home or haven.
System: While under the effects of the gris-gris curse, the target suffers a -1 penalty on all dice pools due to a constant, throbbing headache. This effect is permanent against mortals unless the bag is found and removed. Against Kindred, it lasts for one night per success but ends early if the bag is removed. In the hands of another wangateur with a higher Wanga rating, the bag has a sympathetic connection to its creator equal to a point of the creator’s blood.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Donning the Mask of Shadows"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 233


2. Donning the Mask of Shadows


This ritual renders its subject translucent; her form appears dark and smoky, and the sounds of her footsteps are muffled. While it does not create true invisibility, the Mask of Shadows makes the subject much less likely to be detected by sight or hearing.
System: This ritual may be simultaneously cast on a number of subjects equal to the caster’s Occult rating; each individual past the first adds five minutes to the base casting time. Individuals under the Mask of Shadows can only be detected if the observer possesses a power (such as Auspex) sufficient to penetrate Obfuscate 3. The Mask of Shadows lasts a number of hours equal to the number of successes rolled when it is cast or until the caster voluntarily lowers it.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Draining the Well of Life"] = {
					en = [==[Rites of Blood, p. 93


2. Draining the Well of Life


Many Necromancers keep wraiths as their personal servants. Whether they control them with an iron fist or a velvet glove, it doesn’t change the fact that wraiths need to feed, just like Kindred. However, while the Kindred feeds on blood, the wraith feeds on emotion. Whether used as a practical tool to empower his servants, or as a reward for loyal servitude, by casting this ritual, the wraiths in service to the Necromancer can partake in their masters’ feeding by drinking from the wave of emotion generated by the Kiss.
The Necromancer gathers his wraith retainers and spirit slaves around the intended victim, and then carves the names of his ghostly servants into the flesh of the victim. Once this is complete, he begins to drain the victim dry. For some Necromancers (the Giovanni and the Nagaraja, for example) the act of feeding is not pleasurable for the victim, and they are gripped by intense pain. For others, the Kiss works as normal and generates an intense wave of euphoria. It is the intensity of the sensation that is important here, not whether it is considered positive or negative; the wraith gets to indulge all the same. Terror or euphoria sustains them equally well.
System: Upon successfully casting the rite, the Necromancer gains all the blood he would normally obtain from the act of feeding from the victim, and each of his ghostly companions may replenish each of their Passion Pools by the same amount (ignoring any excess — see V20, p. 385). This is ultimately an act of murder and should therefore prompt a Humanity check. As such, this ritual is therefore practiced more often by those on a Path of Enlightenment (such as the Path of the Bones) that would not object to such an act being committed.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Extinguish"] = {
					en = [==[Rites of Blood, p. 148


2. Extinguish


Fire is a primal fear for Kindred. It triggers the Beast and expels reason. Some elders still shiver when they recall the dark nights of the torch-wielding Inquisition. This ritual eliminates some of the threat fire poses. The caster is able to douse dangerous flames, leaving vampire hunters quite surprised when their torches and brands are no longer effective tools.
System: Casting the ritual requires that the thaumaturge recite an incantation and then pinch out a candle’s flame while spitting on the floor. Once completed, for the rest of the night, the thaumaturge may speak a single magical syllable to automatically extinguish a single fire up to the size of a bonfire. This power may be used a number of times equal to the number of successes on the activation roll for the ritual. The casting of this ritual may trigger a Rötschreck check (see V20, p. 299).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Eyes of Babel"] = {
					en = [==[Rites of Blood, p. 24


2. Eyes of Babel


It is said that after the Great Flood, all of humanity spoke a single language in the shadow of the Tower of Babel, but that the Lord struck down the tower, scattered the people of the world, and divided them with different languages. This ritual leverages the symbolism of that story to grant a thaumaturge the ability to read and speak a language she does not know. She must find someone (Kindred or kine) that knows the language and bind them in chains. During the casting of the ritual, the thaumaturge must pluck out the tongue and an eye of the victim (it must be both) and then consume them. While the ritual lasts, the caster may now speak, read, and write the language in question. Once the ritual is finished, the thaumaturge purges the foreign materials from her system by vomiting the flesh.
System: The duration of the ritual is one week per success on the activation roll. This is a horrific ritual that will permanently maim a mortal (and isn’t too pleasant for Kindred, either), and all but the most inhumane Kindred are likely to have to make a Degeneration roll for attempting this ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Eyes of the Dead"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


2. Eyes of the Dead


Level Two Rite — Genius Loci — Attribute: Perception
As Servitor’s Perception allows the koldun to see through the eyes of beasts, Eyes of the Dead conveys the ability to see through the eyes of spirits.
System: As per Servitor’s Perception, with the same restrictions and method of neutralization, but on spirits.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["2. Eyes of the Grave"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 179


2. Eyes of the Grave


This ritual, which takes two hours to cast, causes the target to experience intermittent visions of her death over the period of a week. The visions come without warning and can last up to a minute. The caster of the ritual has no idea what the visions contain, as only the victim sees them. Each time a vision manifests, the target must roll Courage (difficulty 7) or be reduced to quivering panic. The visions, which come randomly, can also interfere with activities such as driving, studying, shooting, and so on.
Eyes of the Grave requires a pinch of soil from a fresh grave.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Eyes of the Night Hawk"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 233


2. Eyes of the Night Hawk


This ritual allows the vampire to see through the eyes of a bird, and to hear through its ears. The bird chosen must be a predatory bird, and the vampire must touch it when initiating this ritual. At the end of this ritual, the caster must put out the bird’s eyes, or suffer blindness herself.
System: The vampire is able to mentally control where the bird travels for the duration of the ritual. The bird will not necessarily perform any other action than flight — the caster cannot command it to fight, pick up and return an object, or scratch a target. The bird returns to the vampire after finishing its flight. If the vampire does not put out the bird’s eyes, she suffers a three-night period of blindness. This ritual ceases effect at sunrise.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Feed the Darkness"] = {
					en = [==[Rites of Blood, p. 38


2. Feed the Darkness


Level 2 Abyss Mysticism Ritual. For the rest of the evening, the caster may feed through the touch of an Arm of the Abyss. Any Flaws or other issues the caster naturally suffers are still in effect: The Arm’s absorption of blood can be excruciatingly painful if the caster has the flaw Grip of the Damned (V20, p. 495), all feeding restrictions still apply, and so forth. However, the Arm of the Abyss leaves a deep, black bruise on the subject’s body that looks similar to the mark of a feeding leech, rather than the tell-tale sign of a vampire’s fangs.
System: The caster must spend fifteen minutes in contemplation at the beginning of the evening, chanting in Abyssal tongues and calling upon the spirits of the Abyss. The effects of this ritual last until the next sunrise.
Side Effect: While the caster’s body contains any vitae gained through the use of this ritual, her blood is a dark, blackish color. This causes notable dark streaks where her veins and arteries are near the surface of her flesh.
Abyssal Rituals (p. 37): The following rituals do not adhere to the same rules as other forms of magic, in large part because they build on a Discipline that is not truly a form of sorcery. To learn Abyss Mysticism, a Cainite must have at least one dot in both Obtenebration and one dot in Occult. Such a character may not learn Abyss rituals rated higher than her Obtenebration or Occult score (whichever is lower). Casting Abyss rituals requires a successful Wits + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to succeed. Unlike normal rituals, each Abyss Mysticism ritual costs 3 times the ritual level in experience points to learn. All rituals of Abyss Mysticism also have permanent side effects; under no circumstances do Flaws obtained from these side effects reward the vampire with bonus or experience points, nor can they be bought off.]==],
				},
				["2. Flaming Weapon"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 304


2. Flaming Weapon


This ritual affects only weapons usable by humans; it does not affect boulders or siege weaponry. The caster must cut the palm of her hand using the weapon (or a sharp object if the weapon has no edge) inflicting one level of unsoakable lethal damage; the player spends three blood points. If the ritual succeeds, the weapon is sheathed in a green, heatless flame that does not provoke Rötschreck. The flame can be obscured by covering it, and will not ignite other objects. The weapon inflicts aggravated damage for a number of strikes equal to the successes rolled. A wielder cannot choose whether a strike inflicts normal or aggravated damage, though the weapon must hit an object to deplete one of its charges. If a charged wooden melee weapon stakes a vampire, he suffers one level of aggravated damage per number of remaining successes left in the weapon, thus draining it of all charges. Enchanted missiles retain their magic for only one attack; each success scored in casting adds one extra die to the weapon’s damage. Only one casting of Flaming Weapon can be active on any given weapon; the charges on the weapon must be depleted before the ritual can be cast on the weapon again.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Generation of the Acheron Vortex"] = {
					en = [==[Lore of the Bloodlines, p. 49


2. Generation of the Acheron Vortex


Harbingers of Skulls who taste the blood of Lasombra find their link to the Styx reawakened. Under the new moon, the necromancer must spill blood comprising Harbinger and Lasombra vitae into any body of water (from a puddle, to an ocean) and listen to voices from across the Shroud with a ritual such as Call of the Hungry Dead (V20, p. 177). A vortex forms, with each point of blood spilt making the whirlpool last an additional turn. Stepping into the vortex takes the vampire to the Shadowlands equivalent of the body of water, and a single person (mortal or vampire) can follow for each turn the vortex is still active. The ritual works in reverse, but requires the expenditure of two blood points from each individual following the necromancer from the Shadowlands to the Skinlands, and can only take place on a night under the full moon.
Necromantic ritual casting (V20, p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Haruspicy"] = {
					en = [==[Rites of Blood, p. 62


2. Haruspicy


Haruspicy was the name given by Romans to the practice of reading omens and portents from the entrails of sacrificed animals, usually sheep or poultry. However, the practice predates Rome by millennia and has been practiced by countless other occult societies since. The ritualist (or “haruspex”) must perform the sacrifice in a space purified by the Sanctify the Temple ritual. After slaying the animal and slicing open its belly to let the entrails fall out, the haruspex must douse them with a quantity of her own vitae, cut from her wrists with a ritual dagger. Poultry sacrifices require one point of blood. Sheep or larger animals require two points of blood. If the haruspex is sufficiently ruthless, she can even sacrifice a mortal (almost certainly requiring a Degeneration roll). A haruspex may never perform a reading for herself. She can only do so on behalf of another who must provide some personal item to be incorporated into the ritual sacrifice. Naturally, this also means that the ritual may also be performed on an unwilling and unknowing target through sympathetic magic (see pp. 133-135). The Haruspicy ritual may only be performed for a single target, and only once every seven nights.
System: Each success allows the haruspex to ask one question about the subject’s past or present, while two successes may be spent to ask one question about the subject’s future. Using a larger sacrifice reduces the difficulty by 1. Using a human sacrifice reduces it by 3. These benefits stack with the -1 difficulty reduction from using a sanctified temple.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Haunting Breeze"] = {
					en = [==[Rites of Blood, p. 103


2. Haunting Breeze


Level Two Necromancy Ritual. The vampire can summon a light supernatural wind which serves to frighten and confuse all those within a small area or single building no larger than 100 feet/30 meters in diameter. Until the next sunrise (or until willfully dispelled by the caster), the wind in this location is filled with the soft echoes of whispers, warnings, curses, and the laughter of the dead. These terrifying sounds distract and disquiet, increasing the difficulty of Perception rolls by 2 and all other rolls by 1 for all those who remain within the area. In addition, all mortals must make a Courage roll (difficulty 4) or be spooked badly, leaving the area. Such individuals are unwilling to return under any circumstances for at least one hour.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Hidden Haven"] = {
					en = [==[Rites of Blood, p. 101


2. Hidden Haven


This ritual is said to have been developed by the Council of Twelve to hide their massive library within the Carpathian Mountains. The ritual is difficult to cast, and must target a building no bigger than a large house. Once enacted, the building becomes generally unnoticeable; even individuals who know it exists do not notice it, nor do they remember it when asked. During the ritual, the caster must specify a physical “key” (such as spinning twice in a circle, tapping one heel on the ground three times, and then saying “Vitae Incorpora”). Any individual within 100 yards/meters of the building who performs this physical key correctly will penetrate the ritual and be able to see and locate the building without difficulty.
System: The caster must surround the building, and mark all corners, doorways, and windowsills with chalk made of owl-feather ash. The ritual takes a full night to cast, and requires the caster to sacrifice a permanent point of Willpower. Those who wish to find the building without knowing the proper physical key must approach within 100 yards/meters of the structure’s location and make a successful Intelligence + Occult roll (difficulty 9) each time they wish to see through this ritual’s protection. Hidden Haven’s effects last for one year.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Illusion of Peaceful Death"] = {
					en = [==[Rites of Blood, p. 148


2. Illusion of Peaceful Death


The Masquerade can be difficult to maintain with factions of warring vampire coteries fighting for dominance and resources. A bloody murder at the wrong time can draw undue attention from the police to an already complex situation. A Tremere from Chicago created this ritual to distract local police from looking too closely at the victims of vampire attacks. This ritual heals obvious wounds on a corpse, causing a body to appear as though it died a natural death.
System: The caster must have a pristine feather soaked in the blood of a good man that died peacefully. She must carefully dust the corpse with it while chanting the phrase “It must have been Frank’s time to go. At least he went out in his sleep.” This ritual does not add blood to a corpse, but it does reduce the chance that anyone will notice how much is gone. The body must still have at least half its original blood for this ritual to succeed. This increases the difficulty of any investigation powers or abilities used on the corpse by one per success on the ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Implant the Bezoar"] = {
					en = [==[Dark Ages Tome of Secrets, p. 35


2. Implant the Bezoar


Bezoars are native to the Abyss, but Mystics know of ways to draw them out into the world above. Among the smallest creatures in the Abyss, windows of darkness give up these tumorous parasites. Initially stored in pools of blood by Abyss Mystics, they are set loose on the Mystics’ enemies to act as a slow poison. Many a foe has fallen to torpor without even knowing she bore a Bezoar clamped to her dried-out heart. The only evidence is a bowl stained with dried blood found outside the vampire’s haven, and a small slug-like trail leading from it to the Cainite’s preferred resting place.
System: The Abyss Mystic must have access to an Oubliette, or stand in a lake during the new moon, and cut off a finger to produce a blood point. An Infantile Bezoar heads for the vitae, and attempts to enter the Abyss Mystic, unless she is prepared with an existing bowl of separate blood. The Bezoar will remain in the bowl for a night as it drinks its fill, during which time the Mystic can exit the Oubliette — if she knows the way out — carrying the bowl and the feeding parasite. The Bezoar will continue to feed until dawn, at which point it will travel to the nearest sleeping Cainite and crawl inside its mouth to avoid the daytime. The Infantile Bezoar’s statistics are stated on p. 33. It dissolves into a puddle of shadow after exiting its victim.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["2. Infusion of Kalif"] = {
					en = [==[Rites of Blood, p. 162


2. Infusion of Kalif


This ritual is important to all ashipu who seek enlightenment, but its effects have been duplicated by a number of blood magicians from a number of schools who abuse its ancient pedigree for a baser purpose: getting high. The ritual allows the blood magician to ritually infuse vitae into hashish so that Kindred may imbibe of it through a hookah and become intoxicated.
System: The sorcerer must obtain a quantity of hashish and soak it in a quantity of his own blood. The ratio is fairly high — twenty ounces of hashish is soaked in one point of blood, and the process (which takes three full nights) yields only one ounce of kalif per success. The “quality” of the kalif is determined by the Generation of the vampire whose blood was used in the ritual (which need not be that of the sorcerer). Each dot of Generation increases the quality by +1, so kalif successfully infused with the vitae of a Ninth Generation vampire would have a quality of four.
To properly use the kalif as part of a Dur-An-Ki ritual, one ounce of it must be placed into a hookah along with specially prepared rosewater. After smoking for at least half an hour, the player of the imbibing character must roll Stamina + Fortitude (difficulty 6, with a dice penalty equal to the quality of the kalif used in the ritual). There is something of a “sweet spot” that the sorcerer must reach. If sorcerer fails or botches, he becomes too intoxicated to do anything more than continue to enjoy the kalif (and for many Kindred, that’s enough). On the other hand, if the player rolls more successes than the character’s Dur-An-Ki rating, the character doesn’t get high at all and must continue smoking for another half hour interval before rolling again.
Only a number of successes greater than zero but equal to or less than the character’s Dur-An-Ki rating allow for him to reach the ecstatic state required to properly use kalif in further rituals. If the proper number of successes are rolled, the character enters a state of heightened awareness in which Dur-An-Ki is easier to perform. For the rest of the scene, the difficulty of any roll related to Dur-An-Ki paths or rituals is reduced by an amount equal to half the quality of the kalif.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Invoke the Lesser Sign of Power"] = {
					en = [==[Rites of Blood, p. 157


2. Invoke the Lesser Sign of Power


The koldun may invoke the authority of the spirits which are the source of her magical birthright. She must concentrate for a single turn and then make the Lesser Sign of Power with her hands. If the ritual succeeds, her eyes glow with power.
System: For one hour per success, the koldun gains a -2 difficulty reduction on all Intimidation or Leadership rolls made against mortals, provided that she can make eye contact with them.
Koldunic Sorcery dice mechanics (p. 156): the roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.]==],
				},
				["2. Iron Body"] = {
					en = [==[Rites of Blood, p. 158


2. Iron Body


This common ritual augments the resilience of the subject (which can be the sorcerer or anyone he chooses). The ritual requires a spent shell casing which has been soaked in a point of blood from the person who will benefit. While that person carries the shell casing on his person, he may soak damage from fire and sunlight with his normal Stamina. The effects of this do not stack with Fortitude; only the higher of the two apply.
System: The ritual lasts for one hour per success and does not allow the recipient any additional soak. It just extends his normal soak to include fire and sunlight.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Machine Blitz"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 233


2. Machine Blitz


Machines go haywire when this ritual is cast. It takes effect instantly and lasts as long as the vampire concentrates on it. This ritual may be used to kill car engines, erase flash drives, drain the battery of a cellphone, stop life-support machines, et cetera. Essentially, Machine Blitz stops any machine more complex than a rope-and-pulley. The thaumaturge must have a scrap of rusted metal in her possession for this ritual to work, though some vampires use a variant that requires a knot steeped in human saliva to be untied.
System: This ritual only stops machines; it does not grant any control over them. The effects of this ritual are invisible and appear to be coincidental.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Occhio d’Uomo Morto"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 179


2. Occhio d’Uomo Morto


To cast this ritual, the necromancer needs an eye from a corpse whose absent soul became a ghost or Spectre. The eye is ritually prepared in a process involving incense, the new moon, and a period of midnight chanting. The chanting climaxes when the necromancer removes one of her own eyes and replaces it with the one from the corpse (fresher is better). Kindred healing takes over at that point, sealing the eye within the socket.
If the ritual succeeds, the Necromancer permanently gains the Shroudsight ability (see p. 163). This ability is always active and does not require a roll.
Furthermore, if it was a Spectre’s corpse, the vampire can hear the vague murmuring of any Spectres in the area. This ability isn’t very precise; rather than mind reading, it’s more like trying to overhear a low-voiced conversation in the next room. With a Perception + Occult roll, the Necromancer can glean a very vague impression of what nearby Spectres are up to. Botching this roll may well earn the necromancer a new derangement (at the Storyteller’s discretion), as the whispers creep into the caster’s subconscious.
This ritual has some major drawbacks, the first being that its proper result is hideously ugly. Unless the vampire wears sunglasses or finds some other way to conceal her eye, her Appearance is reduced by one dot.
Also, dead or rotted tissue is not the best for normal perception. Any mundane visual Perception rolls are at +1 difficulty (possibly more if the corpse had bad eyesight in life). On the other hand, since the eye offers a window into a different soul than the necromancer, it offers some protection against powers requiring eye contact. These Disciplines are used against the dead-eyed necromancer at +1 difficulty.
Most importantly, however, the ghost whose body was desecrated knows it, and very likely hates it. The ghost can find the necromancer possessing his eye anywhere, and all ghostly powers used against the necromancer by that particular ghost are at –1 difficulty.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Oinos of Dionysus"] = {
					en = [==[Rites of Blood, p. 148


2. Oinos of Dionysus


This ritual allows the thaumaturge to ritually brew a special cask of spiced oinos, an ancient Greek wine believed to have been created by the god Dionysus. Mortals that consume this wine feel a pleasant drowsiness, vague ethereal happiness, and arousal, until they eventually lose consciousness and sleep for the remainder of the evening. They awake to vague pleasant memories, completely forgetting the details of everything that happened the night before.
A draught of the Oinos of Dionysus serves to protect the Masquerade at special parties where vampire guests wish to feed in the open. Vampires that drink from mortals tainted with the mystical oinos feel a slight buzz — not strong enough to be considered intoxicated, but just enough to get a taste of nights when they still breathed and hungered for appetites other than blood.
System: The caster must mix at least one point of his blood with the wine and spices. Once completed, the oinos must be ingested to take effect. After imbibing the oinos, a mortal must make a successful Willpower roll (difficulty 8) to take any action, as she is overcome by an artificially induced lethargy. This effect lasts a number of hours equal to the number of successes achieved on the activation roll. Subjects may resist this effect by scoring at least three successes on a Stamina roll (difficulty 8). Vampires and other supernatural creatures are unaffected by the Oinos of Dionysus, as their blood is too potent to be overpowered by this concoction.
Vampires that feed from a mortal under the effects of the Oinos of Dionysus feel a similar effect, but not one that overpowers them or impairs them. They feel an artificially inflated sense of happiness and remember nights when they were a mortal. In an emergency, the vampire under these effects can expend a blood point to flush the toxin from her system.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Parting the Veil"] = {
					en = [==[The Black Hand: A Guide to the Tal’Mahe’Ra, p. 176


2. Parting the Veil


Subsisting on souls is a harrowing affair, leaving morality in tatters with each feeding. In more practical terms, the corpus of wraiths are sufficient nourishment for the fuel of Disciplines, but leave a vampire hollow upon waking each night. When the Harbingers of Skulls first entered the Shadowlands, it became apparent that a source of blood would be required, otherwise torpor or diablerie would be left as the alternatives.
The ancient Lazarene Abraham long ago studied a relic known as the Black Torah. This set of scrolls illuminated much of the mystery of the Underworld, and through its review he developed understanding of how the dead interfered with the world of the living. Through recollection of the Black Torah’s words, he successfully practiced Parting the Veil on a Christian temple in Tarsus, temporarily weakening the Gauntlet sufficiently to allow mortals to pass into the land of the dead. None returned, but the Harbingers were fed for the first time since their exile.
The rite is enacted in the Shadowlands reflection of a location. The necromancer must sacrifice blood in order to obtain more, holding her wrists over open flames until skin begins to crack and part. She must then snuff the flames with her own blood. The heady mix of pain, will, and necromancy allows the world of the living to become more visible to the necromancer. Mortals on the other side who are unfortunate enough to pass between the two doused flames unknowingly enter the Shadowlands.
Although kine can cross over, Kindred cannot leave. Abraham theorizes this restriction is placed on his bloodline rather than the ritual, and craves to find the shadow of the Black Torah in order to ascertain the truth of this notion and create a ritual allowing two-way travel. The Black Torah of the world above was destroyed in an inferno when Abraham faked his own demise to deter his Giovanni hunters.
In the present night, many Shadowlands necromancers strive for this ritual. It’s never been shared with the Giovanni, but the Harbingers revealed it to their hosts in the Tal’Mahe’Ra. Wherever the ritual is practiced, mortals disappear with a greater propensity, at least until the veil closes.
System: To successfully cast the rite, the necromancer will first need to find the Shadowlands reflection of a location of spiritual resonance, such as a temple, graveyard, or murder site, or a place where passions run highly, such as a sports stadium, drug den, or adolescent’s bedroom.
After lighting flames in the Shadowlands version of this location and exposing the flesh of her wrists to them (typically one either side of the caster), the necromancer will need to make a Courage roll to resist Rötschreck with a difficulty of 7. If Fortitude is used to mitigate the damage dealt by the fire (V20, p. 297), the ritual fails.
The caster must expend two blood points in order to douse the flames (more points must be spent if the flames are larger than those of torches). The Gauntlet is weakened for hours equal to the caster’s number of points in her highest Necromancy Path, and allows a translucent view into the mortal world.
A number of mortals equal to the number of blood points spent can pass through between the flames used in the rite, becoming trapped in the Shadowlands. The veil closes after either the requisite number of mortals passes through, or the hours run out.
Necromantic ritual casting (V20, p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Prepare the Vessel"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 293


2. Prepare the Vessel


This ritual works well as a method of facilitating mediumship, a bargaining chip for ghosts who long to walk in the Skinlands, or as a rather unique form of psychological torture. Prepare the Vessel renders a subject (willing or unwilling) a fitting receptacle for spiritual possession. The target must have a hood (such as one used for hanged men) placed over his head for one hour. Until the next sunrise (regardless of whether the hood remains in place), any ghost or spirit attempting to possess the target gains two automatic successes when doing so. For more on ghostly possession, see p. 403.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["2. Preserve"] = {
					en = [==[Rites of Blood, p. 24


2. Preserve


Clan Tremere has collected wisdom and lore from the dawn of antiquity that had been previously protected and preserved by their mortal magic. However, that magic started to fail. A thousand years of collected occult knowledge was in danger of being lost within a few decades if a solution was not discovered. A devoted Tremere apprentice leveraged preservation techniques learned from monks along with knowledge stolen from the Assamites to create a ritual that chantries could use to preserve their research.
Once their precious libraries were protected, the Tremere realized that this ritual could be turned to political advantage. Ventrue were willing to pay boons to ensure that their own secret documents and treaties were preserved for the future. When it became clear that this ritual could be used for other purposes, Toreador clamored for the opportunity to protect their precious paintings, sculpture, and rare first drafts of a perfect poem or symphony.
Rumors abound that the famous Shroud of Turin and a number of other hidden church relics were preserved via this ritual. A number of the faithful amongst the Followers of Set claim that the Tutankhamen sarcophagus has been preserved via the will of Set, but many suspect that an older (and potentially more potent) form of this ritual has been cast over it.
System: Preserve allows the thaumaturge to mystically shield an item from the effects of time and usage. The thaumaturge must lightly coat the item with a point of her blood over the course of a night while chanting the proper incantations. Each success of the activation roll mystically preserves the item for an additional decade. The preserved item remains protected until the ritual expires. This ritual does not create a sympathetic link to the thaumaturge, as the blood used to power the ritual is absorbed completely by the object.
This ritual was designed primarily to preserve documents and texts, but a clever thaumaturge can utilize it for almost any item that can be held in the hand. The targeted item must be made of worked minerals and other natural materials, as artificial compounds (such as plastic) disrupt the ritual. Items that can be preserved include, but are not limited to, artwork, ancient weapons, jewelry, or clothing. This ritual does not make the targeted item invulnerable or even resistant to someone purposely harming it. For example, an ancient roman gladius will remain sharp and in good condition, but will still shatter if used improperly or if someone of sufficient strength attempts to snap the blade.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Principal Focus of Vitae Infusion"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


2. Principal Focus of Vitae Infusion


This ritual imbues a quantity of blood within an object small enough for the vampire to carry in both hands. (The object may not be any larger than this, though it may be as small as a dime.) After the ritual is conducted, the object takes on a reddish hue and becomes slick to the touch. At a mental command, the caster may release the object from its enchantment, causing it to break down into a pool of blood. This blood may serve whatever purpose the vampire desires; many thaumaturges wear enchanted baubles to ensure they have emergency supplies of vitae.
System: An object may store only one blood point of vitae. If a Kindred wishes to make an infused focus for an ally, she may do so, but the blood contained within must be her own. (If the ally then drinks the blood, he is one step closer to the blood bond). The ally must be present at the creation of the focus.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Puppet"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 179


2. Puppet


Used primarily to facilitate conversations with the recently departed, though also applied as a method of psychological torture, Puppet prepares a subject (willing or unwilling) as a suitable receptacle for ghostly possession. Over the course of one hour, the necromancer smears grave soil across the subject’s eyes, lips, and forehead. For the remainder of the night, any wraith attempting to take control of the subject gains two automatic successes. The ritual’s effects remain even if the soil is washed off.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Recure of the Homeland"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


2. Recure of the Homeland


The vampire calls on the power of the earth to heal grave wounds she may have received. The thaumaturge must use at least a handful of dirt from the city or town of her mortal birth and recite a litany of her mortal family tree as she casts this ritual.
System: The Cainite must mix the earth with two points of her own blood to make a healing paste. One handful will heal one aggravated wound, and only one handful can be used per night. This ritual can only be used on the vampire who knows it.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Seal Egress"] = {
					en = [==[Rites of Blood, p. 25


2. Seal Egress


Thaumaturges jealously guard their research. Sometimes preserving a secret is as simple as keeping trespassers out of their libraries and workshops. Legend has it that the Followers of Set created the original version of this ritual to safeguard their hidden tombs and the sacred depths of their pyramids where their eldest sleep. Some secret excursions in Cairo gave the Tremere key components to develop their own version.
Seal Egress allows the thaumaturge to mystically seal a room closed to prevent unwanted trespassers from entering or leaving it until the proper passcode chosen by the caster is spoken aloud near the entrance. Some Tremere trap an enemy in a small room and allow him to go mad from hunger.
System: To cast Seal Egress, the thaumaturge must spread a point of her blood upon the four walls of the room she wishes to seal and then chant the proper incantation (which can be done outside the room). This ritual is a lengthy process requiring an hour to cast. Each success achieved on the activation roll extends the duration of the ritual by a decade. Seal Egress mystically seals every entrance to the room. Materials from the surrounding walls physically close over any openings into or out of the room, creating a perfect air-tight seal. Trespassers with mystical rituals such as Incorporeal Passage (V20, p. 236) or Disciplines such as Spectral Body (V20, p. 202) find that this room is mystically protected against their abilities. However, this ritual does not strengthen or protect the walls of said room, and thus it is possible for someone of sufficient strength to simply break through the walls of the room. Ghosts, spirits, and other creatures naturally immaterial may enter the room at will. (To bar such creatures, warding circles are required. See V20, p. 234)
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Self-Executing File"] = {
					en = [==[Rites of Blood, p. 68


2. Self-Executing File


The Hacktivist coterie known as the Digital Draculas invented this ritual, and it is the backbone of their agenda for the Anarch community. For centuries, the Tremere have had a ritual called “Inscription” (see p. 150) which allows a thaumaturge to reduce a simple ritual to a written format which can then be unlocked and activated by a non-thaumaturge at a later date. The Self-Executing File ritual functions according to the same principles, but instead of allowing someone outside the Clan to cast a “borrowed” ritual at a time of her choosing, this ritual allows her to install a Technomancy-based ritual directly into a computer. To date, the Digital Draculas have carefully limited the number of techno-rituals which they have widely disseminated to two: “Fangbook” and “Bloodspot.” A third techno-ritual — FangChat — is currently being beta-tested and is exclusively available to the coterie’s closest allies.
System: To use Self-Executing File, the thaumaturge must first prepare the Technomancy ritual she wishes to disseminate into a computer file format. The Hacktivists and the Tremere technomancers alike use a special programming code that integrates a mixture of defunct computer languages and dead written languages. Using this language, the thaumaturge codes a complete description of the ritual to be transmitted and then reduces it to a .zip file. She then emails the file to the intended recipient. When the recipient clicks on the file to open it, a text box appears that informs the recipient that he has sixty seconds to activate the program by smearing some of his blood onto his right thumb and then placing it over the white box below the text. If the recipient does so before time runs out, the blood dissipates harmlessly, and the program automatically opens and downloads itself into the computer’s hard drive. An icon for the associated program appears on the desktop that is visible only to the recipient, and the program itself is an invisible file that cannot be detected on the hard drive by any means other than Technomancy. Every success after the first allows for one additional recipient, should the thaumaturge wish to send out more than one copy of the file.
Sample Programs (p. 68): Fangbook modifies the user’s computer, smartphone, or tablet so that any messages, pictures, or videos she uploads to Facebook, Twitter, or any other equivalent social networking site appear to be innocuous posts such as birthday greetings to random strangers or widely-shared photos or video memes of the day when viewed by non-vampires. Bloodspot, similarly, is a shareware blogging platform that can only be perceived as such by Kindred; when a Bloodspot page is viewed by one of the kine, she sees only a “Server Not Found” message or some comparable error message. FangChat is a chat messenger program that is capable of finding any Kindred who is online and opening a chat window on their computer which, according to the program’s creators, is completely untraceable; the message deletes itself after a couple of minutes, leaving no trace.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Subsume the Darkness"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 272


2. Subsume the Darkness


By using this ability, the Mystic consumes the Abyss to accelerate healing.
System: The vampire spends a full turn meditating on the Abyss, then spends one point of Willpower and rolls Stamina + Occult (difficulty 8), with a botch resulting in one level of aggravated damage. Each success allows the vampire to spend one blood point to heal two levels of lethal damage or four levels of bashing damage, ignoring generation limits for such an expenditure.
However, once the Mystic casts this ritual, the Abyss consumes all blood gained from feeding until it receives a number of blood points equal to the blood spent to heal. A Mystic may not use this ritual more than once per night, and may not use it until her debt to the Abyss has been paid in full. Furthermore, use of this ritual stains the Mystic’s soul. After use of this ritual, the Mystic’s blood becomes black and absorbs all light. This effect clearly marks the Mystic as something terrifyingly alien. Any mortal who sees the Mystic bleed (or cry) must pass a Courage check of 6 or roll one less die for all rolls for the remainder of the scene.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["2. Summon Guardian Spirit"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 305


2. Summon Guardian Spirit


The caster summons a spirit for the express purpose of guarding him. The spirit serves the caster for 24 hours and aids in no other way except to alert the caster to danger. Though the spirit cannot speak, the caster is often jarred (and awakened if at rest) by a sudden and strong intuitive sense when something is amiss. The spirit is only visible to the caster or those capable of seeing it through supernatural perception, such as Auspex. The spirit only appears during times of danger, staring at the caster while pointing in the threat’s direction.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Thanatos’ Caress"] = {
					en = [==[Rites of Blood, p. 90


2. Thanatos’ Caress


The first recorded success recreating the effects of Thanatosis with Necromancy was this ritual. First, the Necromancer obtains a rotting corpse. He then proceeds to bathe, symbolizing his ritual purification. Then, he lies down upon the corpse, not necessarily to indulge in necrophilia (although the act will not interfere with the ritual), but to cause the corpse to break open and fall apart. Finally, once the Necromancer is covered in rotting, decaying flesh, he consumes the heart of the corpse (or what remains of it) and the ritual is complete.
System: Until the next sunrise, the Necromancer may perform a single use of “Putrefaction” upon a target (V20, p. 471), using the same systems as outlined for the original power.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. The Hand of Glory"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 179


2. The Hand of Glory


The Hand of Glory is a mummified hand used by the necromancer to anesthetize a home’s residents and, thereby, allow him free rein to do what he will in the residence. To create one, the necromancer wraps the severed hand of a condemned murderer in a shroud, draws it tight to squeeze out any remaining blood, and preserves the hand in an earthenware jar with salt, saltpeter, and long peppers. After a fortnight, the vampire removes the hand and dries it in an oven with vervain and fern. At the end of this process, if the roll to activate the ritual garners any successes, the creation is viable.
To use the Hand of Glory, the vampire first coats the fingertips of the mummified hand with a flammable substance derived from the fat of a hanged man and sets the fingers alight. The necromancer then recites the phrase, “Let all those who are asleep be asleep, and let those who are awake be awake.” All mortals within a household who are affected fall into a deep sleep and cannot be roused (the hand has no effect on supernatural creatures). For each unaffected occupant of a home, one finger of the hand will refuse to light. Botches may result in all of the fingers being lit but no one in the home being asleep. The hand may be extinguished at any time by the necromancer who created it. Anyone else wishing to douse the hand must use milk to do so — nothing else works. Once made, the Hand of Glory may be reused indefinitely. Effects last for one scene.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. The Jinx"] = {
					en = [==[Rites of Blood, p. 148


2. The Jinx


Some historical records suggest that the Jinx could be one of the oldest rituals of blood magic in existence. This ritual is used to punish the enemies of the thaumaturge without directly attacking them or leaving behind evidence. The Jinx requires a point of blood, and either a part of the victim such as a lock of hair or an item of significance to her in order to properly connect the victim with the power behind the ritual.
The thaumaturge must meditate for ten minutes upon her hatred and anger toward the victim and then burn the spell’s components. Once completed, the victim is vexed with bad luck, causing her to fail in a mundane task. This can cause anything from minor typographical errors to automobile accidents, depending upon how the thaumaturge jinxes his mark.
System: The thaumaturge must concentrate his anger toward the victim while burning an object that has a psychic resonance with the intended target as per the Principle of Identity (pp. 132-133). Each success gained on the activation roll for the casting of this ritual causes an automatic failure for the next roll the jinxed character makes, regardless of the outcome. If the caster achieves four successes on the activation roll, then the next four rolls for the jinxed character fail regardless of the outcome. The Jinx does not cause a botch, just a simple failure. If the Jinx is applied to a contested or extended action, the roll simply yields no successes for the current turn until the number of pending failures is expended.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. The Ritual of Pochtli"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


2. The Ritual of Pochtli


This ritual cannot be cast by itself, but only in conjunction with another Necromantic ritual, or with the heavily ritualized use of a Necromantic path. The action of the ritual is this: Two or more Kindred necromancers restrain a mortal vessel and inflict incisions in the shape of blasphemous symbols (typically subverted Egyptian hieroglyphs or Aztec symbols). They then drink from these injuries. Each participating Necromancer must make his own cut and drink from no other cut. Thereafter, the Necromantic power the Kindred seek to employ gains the benefit of all the participants’ knowledge. This ritual makes it possible for Necromancers to create truly fearsome feats of death magic.
The player rolls to activate this ritual as normal. If the roll succeeds, the Kindred who have participated in the ritual may work together on the path or ritual the Ritual of Pochtli is intended to assist, and players share successes. Note that the primary application of Necromancy requires its own roll, and that successes (and failures) garnered by the group are pooled. All Kindred participating in the ritual must know the Ritual of Pochtli as well as the ritual or path power the group seeks to enact.
The downside of this power is that a single player’s botch negates the successes of the entire group, resulting in a horrific failure for all the ritual workers.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. To Lace with Hidden Nectar"] = {
					en = [==[Rites of Blood, p. 84


2. To Lace with Hidden Nectar


Many of those that have sampled Typhon’s Brew (see sidebar) often find themselves coming back for more. The ability to drink as though they were alive once again is something that has a great appeal to some Kindred, and thus it is something that the Followers of Set have been able to exploit to great effect.
System: This ritual relies on the Sorcerer being able to brew Typhon’s Brew to begin with. The Sorcerer brews a batch of the drink as per normal for the ritual, and casts To Lace with Hidden Nectar on the last night of the full month of the process. She then invests again the same amount of blood in the mixture as at the start of the process, and spends an equal amount of Willpower points. Any vampire who drinks a gallon of the brew loses the same amount of Willpower points (spread evenly over the following hour) as he becomes rapidly intoxicated. This has proven to be a remarkably useful tool for manipulating inebriated Kindred.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["2. Totenpass"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 294


2. Totenpass


The Impundulu necromancer ceremonially “kills” a mortal, laying him out on a bier and placing either two coins over his eyes or an inscribed tablet on his chest. The mortal may then leave his body and travel into the Underworld. He is not completely separated from this body – ghosts and other entities using Lifesight or Aura Perception will see a silver cord trailing from his soul to his still-living body. He can perceive the Underworld and speak to ghosts, but he cannot affect the Underworld physically.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["2. Two Centimes"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


2. Two Centimes


The necromancer ceremonially “kills” a mortal, laying him out on a pallet and putting pennies on his eyes. The mortal’s soul journeys to the Underworld, which he perceives, initially at least, as a way-station. The mortal can interact with the souls of the dead and travel elsewhere in the Underworld, while also retaining the power to speak to the vampire and describe what he’s experiencing. While in the Underworld, however, the subject’s soul cannot affect the environment. Although he may talk to other spirits, he may not physically interact with them or their surroundings — he is a “ghost among ghosts,” as it were. Minions may voluntarily undergo the ritual to assist necromancers, or the vampire may use Two Centimes to terrify unwilling victims.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["2. Ward"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 305


2. Ward


By invoking this ritual, the caster creates a ward that prevents unwanted trespassers from entering a location or handling an item. Wards can be cast on objects or enclosed spaces, such as a hallway or a portcullis arch, but only one ward may be cast on a particular object or space at any given time. The caster spends an hour ceremonially preparing the area or object to be warded, followed by plucking a hair from her head and snapping it in half. With a successful casting roll, a warded object or space cannot be moved or breached even slightly by a subject who does not meet the minimum requirement as set by the caster. All wards are tied to a single Attribute chosen by the caster when she enacts the ritual. In order to pick up a warded object or cross into a warded room, a subject must possess dots in the particular Attribute equal to or higher than the level of the Ward. Trait ratings for Wards begin at 2, as a level two ritual. Casting a ritual Ward at a higher level increases the trait rating proportionate to the level of the ritual cast. For example, a level three Ward has a minimum trait rating of 3 tied to a particular Attribute chosen by the caster when enacted. No one possessing a trait rating lower than 3 in the Attribute tied to the Ward may enter the premises or pick up the object the ward has been cast on. If she so desires, the caster may designate a password that, when mentally intoned while touching the Ward, allows others to bypass its minimum Attribute requirement. Wards last for a number of weeks equal to the amount of successes scored on the casting roll.
At the cost of one Willpower point per attempt, a subject prevented from interacting with a warded object or space may roll Willpower as an extended action (difficulty equal to 4 + the level of the ward), requiring an amount of successes equal to the caster’s Thaumaturgy rating to break an individual ward. A broken ward is accompanied by the sound of shattered glass, which the caster can hear regardless of her location. Thereafter, the ward is completely nullified and any may interact freely with the object or within the space.
This is a Haven Ritual (see Dedicate the Haven on p. 310).
Haven Ritual (p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["2. Ward Versus Ghouls"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


2. Ward Versus Ghouls


Wary Tremere created this ritual to protect themselves from the minions of vengeful rivals. By invoking this ritual, the caster creates a glyph that causes great pain to any ghouls who come in contact with it. The Kindred pours a point’s worth of blood over the object he wishes to ward (a piece of parchment, a coin, a doorknob, etc.), and recites the incantation, which takes 10 minutes. In 10 hours, the magical ward is complete, and will inflict excruciating pain on any ghoul unfortunate enough to touch the warded object.
System: Ghouls who touch warded objects suffer three dice of lethal damage. This damage occurs again if the ghoul touches the object further; indeed, a ghoul who consciously wishes to touch a warded object must spend a point of Willpower to do so.
This ritual wards only one object — if inscribed on the side of a car, the ward affects only that door or fender, not the whole car. Wards may be placed on weapons, even bullets, though this usually works best on small-caliber weapons. Bullets often warp upon firing, however, and for a ward to remain intact on a fired round, the player needs five successes on the Firearms roll.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Warding Circle versus Ghouls"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


2. Warding Circle versus Ghouls


This ritual is enacted in a manner similar to that of Ward versus Ghouls, but creates a circle centered on the caster into which a ghoul cannot pass without being burned. The circle can be made as large and as permanent as the caster desires, as long as she is willing to pay the necessary price. Many Tremere chantries and havens are protected by this and other Warding Circle rituals.
System: The ritual requires three blood points of mortal blood. The caster determines the size of the warding circle when it is cast; the default radius is 10 feet/3 meters, and every 10-foot/3-meter increase raises the difficulty by one, to a maximum of 9 (one additional success is required for every increase past the number necessary to raise the difficulty to 9). The player spends one blood point for every 10 feet/3 meters of radius and rolls. The ritual takes the normal casting time if it is to be short-term (lasting for the rest of the night) or one night if it is to be long-term (lasting a year and a day).
Once the warding circle is established, any ghoul who attempts to cross its boundary feels a tingle on his skin and a slight breeze on his face — a successful Intelligence + Occult roll (difficulty 8) identifies this as a warding circle. If the ghoul attempts to press on, he must roll more successes on a Willpower roll (difficulty of the caster’s Thaumaturgy rating + 3) than the caster rolled when establishing the ward. Failure indicates that the ward blocks his passage and inflicts three dice of bashing damage, and his next roll to attempt to enter the circle is at +1 difficulty. If the ghoul leaves the circle and attempts to enter it again, he must repeat the roll. Attempts to leave the circle are not blocked.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Whispers of the Ghost"] = {
					en = [==[Rites of Blood, p. 149


2. Whispers of the Ghost


Communication with the physical world is difficult while astrally projecting. Astral travelers typically must spend a point of Willpower to manifest visually as a ghostlike shape in order to communicate, and this can strain the strength of even the hardiest of Kindred. The Tremere spent decades attempting to overcome this taxing cost of one of their primary Disciplines, and eventually created Whispers of the Ghost as a way to sidestep the costly requirements of astral communication. Upon completing this ritual, the thaumaturge may communicate from her Psychic Projection form into the material world. The caster can speak with anyone she encounters, but her words come as faint whisperings. People who hear these susurrations often mistake them for the words of ghosts or spirits. While astrally traveling, the thaumaturge must grip the ear of a still-living creature in the left hand of her physical body.
System: The caster must meditate for fifteen minutes in complete silence. Then she must sever the ear of a still-living creature and hold said ear in her left hand before using Astral Projection (V20, pp. 138-139 — the thaumaturge must possess Astral Projection in order to use this ritual). The thaumaturge may speak to the physical world in a ghostly whisper. If she wishes to be seen, she must spend a point of Willpower to manifest as normal, but that cancels the ritual. Should the “donor” of the ear die, the ritual immediately ends. Loss of morality may apply if the donation was not voluntary.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["2. Witch Eye"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 293


2. Witch Eye


By implanting an enchanted eye from the corpse of a restless soul in her own eye socket, the necromancer can permanently gain the Deathsight ability (see p. 403). The ritual is complex and takes an entire evening to perform. At midnight, the celebrant cuts out her own eye and the eye of the corpse. She then places the corpse’s eye in her own eye socket, and places her eye in the corpse. Vampiric healing takes place instantaneously, sealing the dead man’s eye into her eye socket. The eye itself does not heal, however. It remains unmoving and rotten in the necromancer’s face, causing her Appearance to decrease by 1 when the eye is visible. Even a freshly-harvested eye will cloud over and decay in a matter of hours. This increases the difficulty of Perception rolls involving mundane eyesight by 1. As the eye is no longer a proper window into the necromancer’s soul, however, the Witch Eye increases the difficulty of all Disciplines that require eye contact by 1.
The Witch Eye may also complicate a vampire’s life on a supernatural level. Any ghost whose body is being desecrated by the ritual knows immediately, and will likely be displeased by the necromancer’s actions. Even if the necromancer completes the ritual successfully, the ghost maintains a supernatural connection to the Witch Eye, causing all magical rolls he makes against the necromancer to be made at a -1 difficulty.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["2. Witness of Whispers"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 304


2. Witness of Whispers


This ritual creates a scrying device which can be used to either observe enemies and events from a position of relative safety or hear sounds over a great distance. The ritual requires a three-inch pin, a length of thread, the claw of a raven, three points of the caster’s vitae, a container, and one healthy human ear or eye (one or the other, but not both). The caster sews the eye or ear to the claw, and then seals the device in a container of her vitae. After a week has passed, the device animates and can now be placed in any location the caster wishes to survey from a distance. The claw allows the Witness of Whispers limited mobility and the ability to secure to any surface. To see or hear through the device, the user concentrates for five minutes and spends one blood point. Once a connection has been established, the caster may mentally move the device one foot per turn at will. For as long as the caster wishes, the device takes over her visual or auditory perceptions (depending on if she used an eye or an ear to create the device); instead of what stands before her, she sees or hears what the device sees or hears, but uses her own Perception. A Witness of Whispers has one health level and one dot in each Physical Attribute. The caster may deactivate the Witness of Whispers at will and may reactivate it anytime through following the above steps. It remains potent until destroyed,
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. A Shield of Mirror"] = {
					en = [==[Dark Ages Tome of Secrets, p. 43


3. A Shield of Mirror


With a dance performed in the light of the moon and the proper incantation, an Assamite may protect herself or another from a diablerist external to the clan. If performed correctly, this ritual will grant the recipient a blessing against diablerie. If any vampire attempts Amaranth against him within the same month, he instead takes all her blood into himself – this does not cause a blood bond.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. A Touch of Nightshade"] = {
					en = [==[Rites of Blood, p. 149


3. A Touch of Nightshade


Legends of the deadly poison nightshade stretch back to antiquity when it was used to weaken the legions of Marcus Antonius during the Parthian Wars. This ritual builds on these stories to create a poison that can punish a single victim, Kindred or kine, with only a touch.
The caster must anoint her hands with the bitter extract of nightshade before conducting this ritual, and then engage in skin to skin contact with her intended victim. Within half an hour, the victim begins to suffer effects that mirror that of actual nightshade poisoning. Some of the symptoms include dilated pupils, sensitivity to light, blurred vision, headaches, confusion, and convulsions.
System: This ritual creates a skin-contact poison that may only be used once before it turns inert. If the poison is not used by the end of the evening, the power fizzles and the poison is rendered useless.
The thaumaturge must apply the mystical poison to her own skin (which is immune to the poison) and then touch her intended target. The Storyteller may require a Dexterity roll or a Manipulation roll to touch the victim, depending upon the circumstances. Once per night, until the potency of the poison fades, the victim must make a Stamina + Fortitude (difficulty 8) check to resist the effects of the poison. With three or more successes, the target resists the toxic effects of the poison, but still suffers from minor headaches and feels that something is wrong. Otherwise, the victim suffers an extreme reaction to the poison, causing sweating, blurred vision, and convulsions. The difficulty for all rolls for the remainder of the evening is increased by one. (Remember that Kindred sweat blood! This can be a real problem for Kindred trying to preserve the Masquerade.)
The numbers of successes on the activation roll for the ritual determines the potency of the poison. Each success adds an additional night of effectiveness for the poison.
The effects of this mystical poison may be countered by the ritual Purity of the Flesh (V20, p. 232).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Abyssal Threads"] = {
					en = [==[Rites of Blood, p. 38


3. Abyssal Threads


Level 3 Abyss Mysticism Ritual. The caster creates a shining, jet-black thread and affixes it to a single target of any kind. The thread stretches through shadow and into the Abyss, to the caster’s wrist. If the thread is affixed to a person or creature, at any point during the evening, the individual on either end may tug on this thread, causing a similar pull to manifest on the other end. If the thread is attached to an inanimate object, a tug will manifest on the caster’s end of the thread if that object is moved in any way.
System: The individual or item to which the thread is being affixed must be present while the ritual is cast. This ritual takes thirty minutes of casting, during which time the Abyss Mystic draws forth a point of his blood and mixes it with the preternatural essence of the Abyss. By spinning this combined matter upon a skein, the caster forms the Abyssal Thread, and may then attach it as desired. The effects of this ritual last until the next sunrise.
Side Effect: While this ritual is in effect, the cold air of the Abyss circulates around the caster, and may draw unwanted attention. The caster effectively gains the Flaw Cold Breeze for the duration of this ritual’s effects. (V20, p.494).
Abyssal Rituals (p. 37): The following rituals do not adhere to the same rules as other forms of magic, in large part because they build on a Discipline that is not truly a form of sorcery. To learn Abyss Mysticism, a Cainite must have at least one dot in both Obtenebration and one dot in Occult. Such a character may not learn Abyss rituals rated higher than her Obtenebration or Occult score (whichever is lower). Casting Abyss rituals requires a successful Wits + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to succeed. Unlike normal rituals, each Abyss Mysticism ritual costs 3 times the ritual level in experience points to learn. All rituals of Abyss Mysticism also have permanent side effects; under no circumstances do Flaws obtained from these side effects reward the vampire with bonus or experience points, nor can they be bought off.]==],
				},
				["3. Amulet of Mnemosyne"] = {
					en = [==[Rites of Blood, p. 25


3. Amulet of Mnemosyne


Careful lies and half-truths are amongst the most common and potent weapons a vampire has in her arsenal in the arena of politics. The right secret whispered at the wrong moment can shatter a sterling reputation and topple plans crafted over centuries. Locking away such secrets takes a good deal of will and a mastery of the art of deception. However, there are Disciplines and rituals that have the ability to pick thoughts from the head of an unsuspecting victim, force her to reveal secrets, or prevent her from lying at all.
A small chantry during the Regency era decided to devote their research to tackling this problem. Truth was a concept too powerful to completely remove from a subject’s mind. They could obfuscate or rewrite the memories, but there was always an element of the truth in the vessel. Once the thaumaturges realized that truth could be measured, a solution became obvious. The Amulet of Mnemosyne allows a subject to whisper a secret into the amulet and thus transfer the energy of the truth into the mystical shell.
System: The thaumaturge creates an amulet forged from brass and soaked in a pool of her blood. Next, she must recite the proper incantations over the amulet while it is resting on an object that symbolizes the truth to the thaumaturge. Finally, the subject (who does not need to be the thaumaturge) must prick her lips, kiss the amulet, and then whisper her secret.
Once activated, this secret is completely removed from the mind of the subject until she reverses the ritual by again kissing the amulet. Memories are completely rewritten to account for the missing information. These new memories are generated by the power of the magic; neither the thaumaturge nor the subject has any control over the specific details.
Should the amulet be destroyed, the secret will return to the mind of the owner.
If a rival thaumaturge discovers the amulet, and knows or researches this ritual, he may attempt to learn the secret it contains. Holding the amulet to his ear, the rival thaumaturge engages the original caster in a contested Willpower roll. Should the rival thaumaturge win, the secret is implanted in his mind. The caster will feel uneasy as though something is wrong, but will not know the root cause as she has forgotten the secret.
The downside of this ritual is that the subject has no idea that the secret exists or that she has hidden it within the amulet. She will act as per her typical personality would suggest, which could cause a number of complications. Ironically, by hiding the secret, the subject leaves herself vulnerable. For example, if the subject murdered the Prince’s childe, she won’t know to be careful at court or to be watchful that others might have learned her secret.
A crafty thaumaturge will ensure that the amulet is placed in her hands after the danger in passed by mailing it to herself or hiding it away with a trusted retainer with a note written in her own hands. Because of this, any thaumaturge who knows the ritual will flinch anytime she finds an Amulet of Mnemosyne, dreading the secret she might unlock.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Angra Mainyu Consumes Spenta Mainyu"] = {
					en = [==[Dark Ages Tome of Secrets, p. 37


3. Angra Mainyu Consumes Spenta Mainyu


Abyss Mystics despise the light; with its presence, they are incapable of practicing their rituals. This ritual allows them to snuff all light — whether from natural sources, the flame of a torch, or even the Thaumaturgy of Tremere. With retching convulsions, the Cainite practitioner spews a foul torrent of darkness, which consumes all light in the area.
System: The Abyss Mystic must drink a goblet of hot tar, succeeding on a Stamina-based roll (difficulty 9) to avoid throwing it up immediately. Consuming the tar deals two levels of aggravated damage, which may be soaked with Fortitude. This tar remains within the body of the Mystic for a number of nights equal to the successes rolled. At any point while bearing the tar, the Abyss Mystic may roll a Courage test (difficulty 6) to vomit the tar in a shower of unnatural darkness that filters through the air like inky bubbles, gravitating to any light. The tar wraps itself around any such light, and prevents it from relighting for the remainder of the night. The radius over which the tar will travel is equal to 10 meters (11 yards) per success on the Courage test. This does not protect from the sun.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["3. Animate Curios"] = {
					en = [==[Dark Ages Tome of Secrets, p. 50


3. Animate Curios


Level Three Rite — The Transylvanian Kraina — Attribute: Manipulation
As with Treasured Ornaments, the koldun rouses the spirits of objects around his haven. With Animate Curios, the ornaments gain animation and levitation — a sword may fight, a mirror break upon an intruder passing, and so on. While their skill in guarding may be limited, such animated ornaments easily alarm the superstitious.
System: Once the rite is concluded, the combat and intimidation ability of anything animated is determined by Storyteller discretion. A mundane, traditionally non-violent tool or object bears an Intimidation pool no greater than 3, and a combat pool no greater than 4; a weapon or dangerous apparatus has an Intimidation pool no greater than 5, and a combat pool no greater than 7. The rite concludes if the koldun’s haven is put to the torch or the objects are destroyed.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["3. Animated Assistants"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 306


3. Animated Assistants


This ritual allows the intrepid caster to animate temporary servants. The caster slices open her arm and flicks one blood point while incanting for five minutes for every ten feet of space. The ritual lasts one night per success rolled, animating whatever items happen to be lying around, such as rocks, glass beakers, dissection tools, quill pens, or books. All of the animated objects are intuitively linked to the caster’s subconscious. Any tool the caster needs readies itself within reach of the caster or accomplishes minor tasks for her, like note taking, cleaning, sewing, grinding ingredients in a mortar and pestle, etc. However, these objects cannot physically attack or defend the caster.
This is a Haven Ritual (see Dedicate the Haven on p. 310).
Haven Ritual (p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. BFU"] = {
					en = [==[Rites of Blood, p. 66


3. BFU


The Anarch drafts a message for a specific individual, a message interspersed with a mix of occult symbols and vulgar personal insults. This message can be left behind at the scene of the Anarch’s use of the Calling Card ritual in letters ten-feet high, or it can be written with a quill pen on expensive stationary and delivered via courier. Regardless, if the ritual is performed properly, the message fades and is invisible except to the intended recipient. When the recipient reads the message, he becomes so incensed that he has a chance to fall into a rage frenzy. Obviously, this effect primarily applies to vampires, werewolves, and other beings capable of being provoked into a rage state, but even mortals targeted by the message find themselves prone to irrational fury. An innovative sorcerer might well use this ritual for a revenge ploy, such as slandering a mortal recipient’s wife as an adulteress and thereby driving him into a homicidal fury. The most common use, however, is simply to embarrass prominent Cainites by provoking them to frenzy at public gatherings.
System: Once the target reads that message, she must immediately roll for rage frenzy at a +2 difficulty. Furthermore, the effects persist, and for the next several nights, she will find that all difficulties to resist rage frenzy are increased by 1. The message itself lasts for one night per success, and if it is not observed by the intended recipient, the ritual is wasted. If the recipient does see it, the increased frenzy difficulties persist for an additional one night per success, even if she sees the message on the last night that it could possibly affect her.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Balthazar’s Revelation"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 272


3. Balthazar’s Revelation


This strange expression of Abyss Mysticism comes from the Kiasyd bloodline. It peels back the veils that keep a stable mind safe from the dark truths of the world. The ritualist enchants a small object, usually a coin. Anyone holding the coin must make a Willpower roll, difficulty 9 minus their Obtenebration rating. Failure imposes a Derangement chosen when the object was enchanted, which lasts until the victim has spent Willpower equal to the ritualist’s Obtenebration rating. Additionally, the victim sees nightshades and other strange entities everywhere. This causes +2 difficulty to all Perception rolls, and +2 to all Courage difficulties so long as the Derangement persists.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["3. Bind the Familiar"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 306


3. Bind the Familiar


Though the Blood Oath is far easier than ritual binding (allowing Cainites to transform mortals and beasts into ghouls with a draught of vitae), some thaumaturges yearn for more enlightened companionship. Beginning at dusk, the caster paints a circle of sigils in fresh human blood, finishing the last symbol at the stroke of midnight. The caster drains a beast intended to host a familiar spirit entirely of blood, then feeds it vitae in a parody of the Embrace while incanting. If the ritual succeeds, a familiar spirit is drawn to the animal and captured within the confines of the warding circle; it eventually succumbs to its new body as the ritual fuses it with the beast to restore the animal to full health. The familiar spirit may resent its bondage at first, but it can be mollified with good treatment. A familiar is identical to its animal counterpart in every way (use the statistics for the type of animal chosen, found on p. 396), but has the following additional characteristics:
• It is immune to the Blood Oath, mental or social compulsion of a supernatural nature (such as Animalism), and may not be made into a ghoul.
• It gains one additional dot of Intelligence, possessing roughly the same intellectual capability as a 10-year-old child.
• It may verbally speak the native language of its master and communicate telepathically with him, regardless of the distance separating them.
• Pain (though not actual damage) is mutually felt by and shared between the caster and the familiar.
• The caster may spend one blood point to adopt the perceptions of the familiar at the expense of his own, allowing his consciousness to reside within its body and experiencing through its senses.
• All familiars are loyal as if bound by the Blood Oath, and so long as they are properly fed their normal diet, they never age and remain perfectly healthy. At Storyteller discretion, casters may increase the strength of a familiar as a Background through spending their own experience points to improve the creature’s statistics.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. Blood Dance"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


3. Blood Dance


The Blood Dance allows a ghost to communicate with a living relative. Necromancers sometimes perform this ritual for people in exchange for money or favors.
The vampire must dance and chant for two hours, calling forth the right spirit and entreating all other ghosts to leave the area. While dancing, the vampire pours colored sands and ocean salt on the ground in a precise pattern and then makes the link between the living person and the deceased. If successful, the ghost “appears” within the necromancer’s sand-sigil and the living person can communicate with her for one hour. Failure means the spirit could not be contacted.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. Blood and Bane"] = {
					en = [==[Rites of Blood, p. 37


3. Blood and Bane


Level 3 Dur-An-Ki Ritual. This Assamite Sorcery ritual is native to the lineage of Al-Aziz, and only known to these Sabbat practitioners. It is said that the first member of this lineage created it to assist in her flight from the Mountain of Alamut, and taught it to her childer thereafter. It is a corruption of the ritual “Infusion of Kalif” (pp. 162-163).
This ritual constitutes a powerful hex, causing its target’s spirit to deteriorate slowly while under the effect of this spell. Other magical casters can feel when this ritual is in effect, and receive instinctive knowledge of the general direction and distance to the caster.
System: The Al-Aziz must spend an hour in ecstatic dance, chant, and meditation. Using the birth name of her victim and a small token belonging to that individual – a lock of hair, or some item of personal significance – she targets her spell upon that person. The caster must make a Wits + Occult roll (difficulty 7). For each success, she reduces the target’s level of Thaumaturgy in their primary path by one dot. The effects of this ritual lasts until the next sunrise, or until the caster releases the spell or is destroyed.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Bound by Oath"] = {
					en = [==[Rites of Blood, p. 77


3. Bound by Oath


Mithra is the Zoroastrian angelic deity of oaths and covenants. By recreating his legendary bull-slaying, Assamite sorcerers can confer his blessing on an operation against a single target.
First, the Sorcerer ritually cleans an underground chamber and positions a bull which will be sacrificed. The Sorcerer and participants gather over the bull and chant the name of a single target for one hour. Each participant then smears a point of their own blood on the blade of a two-handed sword. In unison, the participants chant the target’s name one last time and the Sorcerer plunges the blade deep into the throat of the bull to complete the ritual. As one, the participants kill the bull, and as one, they vow to kill their target.
Not all the participants need to know the ritual in order to take part, only the presiding Sorcerer. In order for the ritual to be cast, it must have at least two participants and no more than seven.
System: When the participants make an attack in unison against the selected target, a number of them (equal to the successes achieved in the casting) can propel themselves up the initiative order to act one round before the target. For example, four Assamites are attacking a target. The target acts on initiative 10, but three of the Assamites roll initiatives of 9, 9 and 7 respectively. Two successes were achieved in the casting, allowing two of the three stragglers to act on initiative 11 instead. The third remains on their original initiative order. The ritual only grants its benefit if all of the participants (including the Sorcerer) actively engage their target at the beginning of the combat.
In addition, each participant in the combat has a bonus (equal to the successes in the casting) to any Alertness rolls for that scene. The effects of the ritual last until the following sunrise, or until the end of the first combat against their target, whichever comes first.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Brotherhood of the Cup"] = {
					en = [==[Lore of the Clans, p. 221


3. Brotherhood of the Cup


Sometimes the Tremere need to enforce a limited form of blood bond on an agent or even one of their own, so a variation on the Ascension of the Blood ritual was developed. With Brotherhood of the Cup, a Tremere can impose such a bond, but one designed to inspire loyalty to the Clan as a whole rather than an individual.
System: While no Tremere would admit it, this ritual bears a concerning similarity to the Vaulderie. In addition to the ritualist, it requires at least four other Tremere (although tradition requires a total of seven) to put their blood into a chalice. Anyone who drinks from the cup becomes blood bound, but to Clan Tremere and what they perceive to be its goals. The effect lasts for one hour for each success gained on the roll. Once the ritual wears off, so do the effects. This does not count as having drunk once from any of the Tremere who conducted the ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Bull of Heaven"] = {
					en = [==[Rites of Blood, p. 163


3. Bull of Heaven


In imitation of the rituals supposedly used by the goddess Ishtar when she prepared the great Bull of Heaven to face Gilgamesh, this ritual allows the ashipu to enchant and command an animal to do its bidding. The result is similar to the Animalism power Subsume the Spirit.
System: The ashipu must drink from the animal while simultaneously feeding it blood. One point of blood is sufficient for any animal smaller than a man. Three points is required for any animal larger than man-sized, up to the size of a bull. Animals larger than cannot be used for this ritual. Upon receiving the blood, the animal immediately becomes a ghoul, gaining one dot of Potence and one dot of either Fortitude or any other Discipline possessed by the ashipu which does not require sapience (such as Dominate or Dur-An-Ki). For the remainder of the night, the ashipu can reflexively direct the animal at will and see through its senses while retaining his normal awareness of his surroundings.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Calling the Hungry Shade"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 272


3. Calling the Hungry Shade


With this ritual, the Mystic calls a Hungry Shade, a human-sized soldier of the Abyss. Eternally hungry and fiercely independent, they will attempt to destroy any vampire foolish enough to summon them.
System: Beginning just after dusk, the Mystic paints a circle in his own blood. She spends hours in chants of evocation, completing the summoning just after moonset. Upon completion, the Mystic rolls Intelligence + Occult, difficulty 9. The difficulty may be lowered by 1 for each additional Mystic that assists in the ritual, with a maximum number of participants equal to the caster’s Occult rating. Failure means the ritual fails to produce a Shade, and a botch results in the Shade attacking the caster.
On a success, the Mystic summons a Hungry Shade. The Hungry Shade possesses Strength, Dexterity, and Stamina equal to the caster’s rating in Obtenebration, with a maximum value of 4. It is always in shadow form, as Talon of the Abyss.
Hungry Shade (p. 272): The following scores are equal to the caster’s rating in Obtenebration.
Attributes: Strength, Stamina, Dexterity
Abilities: Alertness, Athletics, Brawl, Intimidation, Melee, Stealth
It also possesses the following:
Disciplines: Assign a number of points to Disciplines equal to the caster’s rating in Obtenebration. The Hungry Shade may not possess Disciplines not known by the caster or assisting Mystics (if any).
Willpower: 6
Health: 12
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["3. Claiming the Dark"] = {
					en = [==[Lore of the Clans, p. 126


3. Claiming the Dark


This ritual allows the caster to merge with the shadows, drawing the power of the Abyss into herself. However, the cost for this power, as always, is blood.
System: When casting this ritual, the vampire cuts herself open with a knife and draws the surrounding shadows into her own body. The process takes an hour and is very painful, subtracting two dice from any rolls the Cainite makes for the duration. After this torment, the vampire makes a Manipulation + Occult roll (difficulty 8) to hold the power of the shadows inside her. If she fails, the shadows escape her, and if she botches, the shadows take a blood point for each 1 rolled as well.
If she succeeds, her skin turns dark and her eyes become black. All her physical attributes rise to the level of her Obtenebration if they are lower. Obtenebration powers up to level three are used at -2 difficulty, and the blood point cost for Arms of the Abyss is eliminated. This augmentation lasts for as long as the vampire desires.
Unfortunately, upon rising from slumber each night, the vampire in this condition must pay an additional blood point cost equal to their Obtenebration rating. Should she fail to do so, she returns to normal. In her augmented form, she is also more vulnerable to sunlight and takes triple damage from it. Her Appearance also drops by one point while empowered.
Side Effect: Should the vampire spend more consecutive days in this form than her highest Virtue, her skin begins to darken permanently, in a similar way to elder Assamites.
Abyss Mysticism (p. 125): Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level. Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.]==],
				},
				["3. Clinging of the Insect"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 235


3. Clinging of the Insect


This ritual allows the caster to cling to walls or ceilings, as would a spider. She may even crawl along these surfaces (as long as they can support her). Use of this power seriously discomfits mortal onlookers. The character must place a live spider under her tongue for the duration of the ritual (though the spider may die while in the thaumaturge’s mouth without canceling the power).
System: The character may move at half her normal rate while climbing walls or ceilings. This power lasts for one scene, or until the vampire spits out the spider.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Cowing the Servant"] = {
					en = [==[Rites of Blood, p. 157


3. Cowing the Servant


The Tzimisce enjoy the feeling of control over their servants, even more so when those servants quake with fear. This ritual heightens the normal devotion of a ghoul, revenant, or other blood bound servant. The koldun mixes a sheep’s brain with soil from his domain and a point of his own blood, while chanting an ancient Slavic incantation. Then, he forces the servant to eat the foul mixture.
System: For one week per success, the difficulty of any roll made for the koldun to manipulate the servant is reduced by -1.
Koldunic Sorcery dice mechanics (p. 156): the roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.]==],
				},
				["3. Craft Dream Catcher"] = {
					en = [==[Rites of Blood, p. 62


3. Craft Dream Catcher


A dream catcher (well-known to Native American vendors in U.S. tourist traps) is a minor artifact which protects a sleeping person. The ritualist must craft the dream catcher by hand and incorporate tiny bits of hair, blood (less than one point), and spittle from the individual for whom the item is crafted.
System: Once created, the dream catcher lasts for one week per success. As long as the owner has the dream catcher on his person or within five feet/three meters, he gains the following benefits: First, the difficulty for all attacks made against him by spirits increases by 2. Second, the difficulty for all attempts to influence his mind or his dreams while he sleeps increases by 2. Finally, if the owner is a vampire, the difficulty for him to awaken during the day in response to potential danger decreases by 2.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Dante’s Urban Legend"] = {
					en = [==[Rites of Blood, p. 26


3. Dante’s Urban Legend


People love to share urban legends. These dubious stories of modern folklore have limited veracity, but something powering the stories pushes the communities to preserve and propagate them through the generations. Tapping into the power of these stories, the thaumaturge can create a psychically-charged urban legend that discourages visitors to a specified house or location.
The caster recreates a popular urban legend upon the grounds that she wishes to protect. Tales shall arise in the community of something that happened to a friend of a friend recounting the horror of that location, such as a legend about a group of teenagers ambushed by the hook-man and then anesthetized only to find a kidney missing. Overly excessive uses of this may attract the attention of hunters or malicious supernatural creatures, so this ritual is used with care.
Some believe that this is a minor breach of the Masquerade, as it encourages a belief of the supernatural. However, those that practice this ritual argue that Dante’s Urban Legend preserves the Masquerade by pushing away mortals from places they should not be, and upholds the tradition of Domain. A few Princes that have discovered this ritual have limited its use within their domains.
System: The caster must recreate the exact urban legend she wishes to propagate at the location. For example, she might need to steal some kidneys from a drunken mortal or kill a group of teenagers with a hook. Afterwards, she must sacrifice a point of blood to each entrance of the house or location.
Typically thaumaturges are careful to select an urban legend that does not remind others of vampires. Some will cast this ritual on the property of their rivals to make a point. Once the ritual is enacted, rumors will soon circulate among the mortals that the house is haunted or cursed, and therefore should be avoided by anyone with sense. Property values around the “haunted” house will plummet as neighbors move to avoid living next to the house that causes them nightmares.
These mortals rationally disbelieve in the supernatural, but they will feel disturbed by the thought of the location protected by the ritual and attempt to avoid it. Strong-willed mortals may feel curious enough to make a Willpower check (difficulty 8) to attempt to enter the building or area – failure means that they create some excuse to avoid entering. The duration of this ritual is one decade plus an additional year for every additional success achieved on the activation roll.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Death’s Head"] = {
					en = [==[Rites of Blood, p. 103


3. Death’s Head


Level Three Necromancy Ritual. Some necromancers of the Tal’Mahe’Ra collect fragments of hair, bone, ash, or flesh from their enemies as a reminder of a victory. Using Necromancy, they use these remains to create a paint-like residue with which they decorate porcelain masks known as Death’s Heads. Once activated, such a mask causes its wearer (who may be someone other than the Necromancer who made the mask) to appear as a wraith so long as she wears the mask. In the physical world, the wearer looks translucent and ghostlike (but is granted no special ability to pass through physical items or cross into the Shadowlands). In the Shadowlands, the wearer can pass as a wraith even among true wraiths. Note that the user’s aura becomes pale, like that of a wraith (and their creature type reads as a wraith), but this does not hide or alter any other patterns or colors (such as diablerie streaks).
A Death’s Head, once painted, is enchanted but inactive until used. Once activated (by putting the mask on), the mask crumbles into dust, leaving a faint pattern of bone-white marks across the user’s face. If the user wills the effect to end early; the soft patterns fade into nothingness and the user is returned to their normal physical appearance. A necromancer may create only one Death’s Head at a time; any already-existing masks are destroyed (or active uses cancelled) when a second is created. It takes one full night to create a Death’s Head.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Din of the Damned"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


3. Din of the Damned


This ritual is similar to the Level One Ritual Call of the Hungry Dead (see p. 177) in that it makes the sounds of the Underworld audible in the physical realm. However, Din of the Damned is an area-effecting ritual used to ward a room against eavesdropping. Over the course of half an hour, the necromancer draws an unbroken line of ash from a crematorium along the room’s walls (this line may pass over doorframes to allow entrance and egress). For the rest of the night, any attempt to listen in on events inside the room, whether simple (such as a glass to the wall), electronic (like a laser microphone), or mystic (including powers such as Heightened Senses), requires the eavesdropper to score more successes in a Perception + Occult roll (difficulty 7) than the caster of the ritual scored. Failure to beat this mark gives the listener an earful of ghostly wailing and moaning and the sound of howling winds; a botch deafens him for the rest of the night.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. Displacement of the Pneuma"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 311


3. Displacement of the Pneuma


Follower of Set Ritual. This ritual takes twenty minutes to perform and requires a mortal victim restrained upright on a flat surface, as well as an animal (such as a goat or pig) tethered nearby. The witch cuts her wrist and ritually “slays” the prisoner by drawing a dull blade across his throat (doing no damage), while allowing the blood to gush from her wrist down the victim’s chest. The ritual only works if the victim is unaware of the trickery and momentarily believes his own throat has been slashed. At this moment, the witch shouts a word of power as loudly as she can into the victim’s ear. If successful, she shocks the victim’s soul out of his body and into that of the animal. The victim lives the rest of the animal’s lifespan trapped in its body; lacking in the animal’s instincts, he may be ill-equipped to survive. A semblance of the victim’s intellect, shorn of memory, desire or Willpower, remains in the human body. The soulless being is suggestible and follows the witch’s instructions, so long as they require no interpretation. Without volition, the thrall doesn’t seek its own basic survival and will perish of thirst if not ordered to drink.
Clan rituals (p. 302): Clan rituals are jealously guarded secrets that are never shared with those not belonging to the clan or bloodline harboring its mysteries.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. Divine Sign"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


3. Divine Sign


Upon learning a person’s birth date, the necromancer’s player may roll to activate this ritual. If successful, the Kindred may use this to predict the target’s next course of action, allowing him to deal with it accordingly. The effect on ghosts is quite different: Instead, the ritual imparts upon the necromancer so intimate an understanding of the wraith in question that it acts as a connection to the ghost, making it easier to invoke other Necromancy effects on that spirit. For story purposes, it’s the equivalent to holding one of that wraith’s fetters (see Ritual of the Unearthed Fetter, below).
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. Enfolding the Believers"] = {
					en = [==[Rites of Blood, p. 64


3. Enfolding the Believers


Kindred with multiple ghouls often find that jealousy over the regnant’s affections can lead to rivalry and conflict, and New Age vampire cult leaders find such discord counter-productive to the enlightenment they seek, hence this ritual. The sorcerer first prepares a quantity of some kind of liquid to which she adds one point of vitae per gallon of liquid. Red Kool-Aid or fruit punch works perfectly well for purposes of this ritual, although “drinking the Kool-Aid” has a sinister connotation in the context of New Age cults that some Kindred choose to avoid. The sorcerer must have her followers drink a quantity of the prepared liquid before leading them in an extended meditation exercise lasting at least one hour. If the ritual is effective, all of the followers acquire what is essentially a secondary blood bond to one another and to the group as an abstract unit.
System: The effects last for one week per success. Each follower still retains his normal blood bound loyalty to the regnant, but he will also experience strong feelings of love and affection to every mortal who participates in the ritual with him, no matter how many that may be. Each participant will also feel a strong sense of loyalty and devotion to the ideals and dogmas of the cult. It is still possible for conflict to erupt if two or more followers express genuine disagreement about the cult’s beliefs or the regnant’s desires, but if the regnant herself is on hand, such squabbles can be easily resolved. In addition to any other benefits of group loyalty, this ritual can also indirectly benefit the sorcerer herself. For every five people who are under the effect of this ritual and who are present to assist the sorcerer in her other occult activities, the sorcerer gains a +1 die bonus on all rolls pertaining to paths or rituals. This ritual has no effect on Kindred.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Father’s Freedom"] = {
					en = [==[Rites of Blood, p. 101


3. Father’s Freedom


This ritual takes an hour to cast, and must be cast upon a target who has diablerized at any point in her existence. If the ritual is successful, one diablerized soul (chosen by the caster, if there are multiples) is released from its captivity, pouring out of the target’s mouth in a wash of brilliant light. The spirit remembers everything that has happened both before and after its death. By maintaining the ritual, the caster may keep the diablerized soul intangibly materialized, so that she can question it. The soul has no compulsion to be honest or reveal anything, but is likely to be well-intentioned toward the individual who set it free. Once the ritual circle is broken, the spirit is released and moves on from the physical world.
Most of the Inconnu who are privileged enough to learn this ritual utilize it to free (and question) Salubri who were long ago diablerized by the Tremere. However, a few cunning — and less moral — members of the society have been known to deliberately diablerize their enemies in order to escape with their souls, and then later cast this ritual on themselves.
System: This ritual takes an hour to enact, and requires 10 points of blood be spent by the caster during the course of the casting. The target of the ritual must remain within the ritual circle (a maximum 100 square foot/10 square meter area) throughout the casting, although she may be restrained by physical force or supernatural means. If the ritual is successful, it immediately removes all effects of this diablerie (both good and bad) from the target, except that the ritual does not restore any morality loss incurred by diablerizing.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Flesh of Fiery Touch"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 235


3. Flesh of Fiery Touch


This defensive ritual inflicts painful burns on anyone who deliberately touches the subject’s skin. It requires the subject to swallow a small glowing ember, which does put off some vampires with low pain thresholds. Some vain thaumaturges use this ritual purely for its subsidiary effect of darkening the subject’s skin to a healthy sun-bronzed hue.
System: Flesh of Fiery Touch takes two hours to cast (reduced by 10 minutes per success). It requires a small piece of wood, coal, or other common fuel source, which ignites and is swallowed at the end of the ritual. The subject who swallows the red-hot ember receives a single aggravated health level of damage (difficulty 6 to soak with Fortitude). Until the next sunset, anyone who touches the subject’s flesh receives a burn that inflicts a single aggravated health level of damage (again, difficulty 6 to soak with Fortitude). The victim must voluntarily touch the subject; this damage is not inflicted if the victim is touched or accidentally comes in contact with the subject.
This ritual darkens the subject’s skin to that which would be obtained by long-term exposure to the sun in a mortal. The tone is slightly unnatural and metallic, and is clearly artificial to any observer who succeeds in a Perception + Medicine roll (difficulty 8).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Hell’s Calling"] = {
					en = [==[Rites of Blood, p. 158


3. Hell’s Calling


This ritual requires a sympathetic link to the target at least equal to a personal possession (p. 133). The object must be set inside a rusty hubcap and doused in gasoline. Then, the sorcerer must spend thirty minutes meditating on the item while whispering “Burn, baby, burn,” before finally setting the item on fire. The target, wherever she is, suffers the effects of Rötschreck.
System: Upon this ritual’s completion, the target must immediately roll for fear frenzy. The effect may be overcome by spending a Willpower point, but otherwise, a failed roll causes the target to enter frenzy and flee the area in terror. The character will also have no idea why she is suddenly overcome with terror, and once she thinks to ask herself what she is afraid of, the effect will end.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Incorporeal Passage"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 236


3. Incorporeal Passage


Use of this ritual allows the thaumaturge to make herself insubstantial. The caster becomes completely immaterial and thus is able to walk through walls, pass through closed doors, escape manacles, etc. The caster also becomes invulnerable to physical attacks for the duration of the ritual. The caster must follow a straight path through any physical objects, and may not draw back. Thus, a Kindred may walk through a solid wall, but may not walk down through the earth (as it would be impossible to reach the other side before the ritual lapsed). This ritual requires that the caster carry a shard from a shattered mirror to hold her image.
System: This ritual lasts a number of hours equal to the number of successes scored on a Wits + Survival roll (difficulty 6). The caster may prematurely end the ritual (and, thus, her incorporeality) by turning the mirror shard away so that it no longer reflects her image.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Inscription"] = {
					en = [==[Rites of Blood, p. 150


3. Inscription


Blood magic is the ultimate advantage in the Jyhad, but not everyone can (or is allowed to) learn Thaumaturgy. The thaumaturge can craft an annotated version of a ritual, fueled with her blood, to make the formula accessible to someone else.
Clan Tremere created this ritual as an aid to teach their Apprentices the basics of blood magic by practicing a specific ritual. They later used Inscription to provide a one-time ritual advantage to their allies, allowing the Tremere to force a dependence upon them for magic.
The Inscription ritual allows the thaumaturge to cast any first or second level ritual onto a page or other flat surface (something portable and easy to fold is preferred). A reader can then unlock the power of that ritual by reading the inscription and following its instructions. The scribe uses her blood as a base for the ink, and her vitae’s power remains in the mixture to help fuel the ritual. An inscribed ritual is in imperfect form and cannot be used to learn Thaumaturgy. It’s a simplified set of instructions, with the scribe’s vitae overcoming any omissions or sloppiness on the part of the practitioner.
System: A thaumaturge who knows the techniques of Inscription can write an abbreviated form of any first or second level ritual that she knows, at a cost of two blood points. Anyone who can read the language used may then recast the ritual later. Casting the ritual from the notes requires the use of the usual components and time, as well as an Intelligence + Occult roll, but the caster need not have any knowledge of Thaumaturgy. Once an inscription is complete, the power of the writer’s vitae is trapped in the object; her maximum blood pool is effectively reduced by one until the inscription is used. After use, the inscription dries into a fine, illegible ash, with all the power expelled from the ink. The scribe can use the inscription himself (which is rather pointless) or give it to someone else.
It is well known in magical circles that the blood powering Inscription can be used for links of Sympathy and Identity, and an incautious thaumaturge could find her blood in the hands of an enemy who can use it against him. To prevent an inscription from reaching the wrong subject, many scribes also use the Encrypt Missive on their enchanted notes to ensure that only the intended recipient may use this ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Mirror of Second Sight"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 236


3. Mirror of Second Sight


This object is an oval mirror no less than four inches (10 cm) wide and no more than 18 inches (45 cm) in length. It looks like a normal mirror, but once created, the vampire can use it to see the supernatural: It reflects the true form of Lupines and faeries, and enables the owner to see ghosts as they move though the Underworld. The caster creates the mirror by bathing an ordinary mirror in a quantity of her own blood while reciting a ritual incantation.
System: The ritual requires one point of the vampire’s blood. Thereafter, the mirror reflects images of other supernatural creatures’ true forms — werewolves appear in their hulking man-wolf shapes, magi glow in a scintillating nimbus, ghosts become visible (in the mirror), and so on. Sometimes, the mirror also reveals those possessed of True Faith in clouds of golden light.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Nightmare Drums"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 180


3. Nightmare Drums


The necromancer using this ritual sends the dead to haunt the dreams of an enemy, using the ghosts to drive an opponent slowly insane. Once the ritual is cast, the vampire has no control over this power, except to stop it from continuing. The shape of the nightmares and the images that assault the target are not under the control of the necromancer; they are under the control of the ghosts who actually do the haunting.
The necromancer uses his own blood and a personal possession of the target’s in this ritual. Once the item has been coated with blood, the vampire must burn the item, sending a ghostly icon of it to the Shadowlands both as an identifying badge and as a reward to the ghosts who agree to haunt the target. While the item burns, the necromancer (and assistants, if available) pound out a relentless beat on gigantic drums of human skin. The drums are inaudible in this realm but thunderous in the home of the dead. To silence the deafening drums, the ghosts resignedly agree to negotiate with the necromancer. They promise to send nightmares to the victim for as long as the vampire demands, in return for a favor. Their request normally runs along the lines of passing a message to a living relative or exacting revenge against someone who slighted them.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. One with the Dark"] = {
					en = [==[Dark Ages Tome of Secrets, p. 36


3. One with the Dark


Accessing the Abyss within is a physical ordeal, producing convulsions in the Cainite attempting to do so and requiring a great expenditure of blood. Despite this, Abyss Mystics are enthusiastic to become One with the Dark, teaching this ritual with great pomp and pageantry. Those Mystics who are One with the Dark are seen not as novices, but as adepts — fully prepared to sacrifice their souls for hidden truths, forbidden knowledge, and greater power.
System: The Abyss Mystic must be in an Oubliette, or an enclosed space with no light on a night of the half moon. He must prepare his body with ritual tattoos designed by master Mystics, said to be in the language of the Abyss. Stripped naked and covered in pitch, the Cainite convulses and produces a minimum of three blood points from his orifices, requiring a Stamina + Occult roll (difficulty 6). Each success grants the Mystic a secret belonging to any of the Cainites named in the ritual — the secrets to be determined by the Storyteller — and makes the skin of the Abyss Mystic turn an unnatural, smoking black in color. The Abyss Mystic’s Appearance rises to four dots, or by one dot regardless of Generation limits — whichever would be higher — until the next half moon; if the Cainite is on any Road other than that of Sin or the Abyss, performing this ritual reduces the rating by one permanently. On a failure, the ritual does not succeed and his peers shun the Abyss Mystic for at least a month. On a botch, every Cainite in the local domain sees the Abyss Mystic’s secrets while they sleep.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["3. One with the Forest"] = {
					en = [==[Dark Ages Tome of Secrets, p. 51


3. One with the Forest


Level Three Rite — The Białowieza Kraina — Attribute: Stamina
Koldun speak of a time before the Long Night, when they studied kraina with the Lhiannan. One with the Forest allows the koldun to fold himself into a tree within his homeland, and emerge from another in the same area.
System: In the forest where the rite concluded, the koldun may step into any tree broader than him, and emerge from another in the same forest, of equal or greater breadth. The vampire cannot remain in the tree. This permanent effect is neutralized when a tree the Cainite has stepped into that night is felled.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["3. Pavis of Foul Presence"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 236


3. Pavis of Foul Presence


The Tremere joke privately that this is their “ritual for the Ventrue.” Kindred who invoke the Presence Discipline on the subject of this ritual find the effects of their Discipline reversed, as if they had used the power on themselves. For example, a vampire using Presence to instill fear in a Kindred under the influence of this ritual feels the fear herself; a vampire summoning the caster is instead drawn to the thaumaturge’s location. This ritual is an unbroken secret among the Tremere, and the Warlocks maintain that its use is unknown outside their Clan. The magical component for this ritual is a length of blue silken cord, which must be worn around the caster’s neck.
System: This ritual lasts against a number of effects equal to the successes rolled, or until the sunrise after it is enacted. Note that the Presence Discipline power must actually succeed before being reversed by the ritual. As such, only powers that specifically target the caster (and thus, require a roll to succeed) can be reversed — “passive” powers such as Majesty are not affected.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Rings Like Chains"] = {
					en = [==[Rites of Blood, p. 84


3. Rings Like Chains


Turquoise was believed by many ancient civilizations to be prophylactic in nature, protecting those that wore it. Perverting this belief, a Setite Sorcerer can craft jewelry that actively does the reverse. The Sorcerer takes a large piece of turquoise and bathes it in a point of his blood for an entire lunar month. At the end of this period, the stone becomes red like jasper. He then cuts the stone in two, and incorporates each half into a separate piece of jewelry, inscribing the name of an intended target upon both stones. This can be any form of jewelry, not just rings as the name of the ritual suggests, although these tend to be the most commonly produced items. One piece is given to the intended target, while the other stays with the Sorcerer.
System: As long as both the Sorcerer and recipient are wearing the items of jewelry, when the intended target next partakes of an addictive substance (drugs, alcohol, Vitae, etc.), the Sorcerer becomes aware of it and has the choice of making them both become automatically addicted to the substance in question. The effects of the ritual fade after this first instance, whether the Sorcerer activates it or not. This provides a Setite Sorcerer an immense amount of leverage over a given target, by creating a new vice for him to exploit.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Ritual of The Unearthed Fetter"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 181


3. Ritual of The Unearthed Fetter


This ritual requires that a necromancer have a finger bone from the skeleton of the particular ghost he’s interested in. When the ritual is cast, the finger bone becomes attuned to something vitally important to the wraith, the possession of which by the necromancer makes the casting of Necromantic powers against that ghost much easier (see the Sepulchre Path, p. 160, for an example). Most necromancers take the attuned finger bone and suspend it from a thread, allowing it to act as a sort of supernatural compass and following it to the special item in question.
Ritual of the Unearthed Fetter takes three hours to cast properly. It requires both the name of the ghost targeted and the finger bone already mentioned, as well as a chip knocked off a gravestone or other marker (not necessarily the marker of the bone’s former owner). During the course of the ritual the stone crumbles to dust, which is then sprinkled over the finger bone.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. Rutor’s Hands"] = {
					en = [==[Rites of Blood, p. 150


3. Rutor’s Hands


The creation of life, twisted and obscene as it might be, has long been a goal of some thaumaturges. While Gargoyles and homunculi are among the more well-known creatures created by Thaumaturgy, the Rutor’s Hands are a more obscure and horrifying creation. A thaumaturge of sufficient will can pluck out her own eye and set it atop one of her own severed hands and animate this thing as a scurrying, malevolent spy. The eye rests on the back of the hand and swivels about to watch its surroundings, while the hand scuttles about like a desiccated spider. The construct obeys the will of its owner and can relay what it sees and hears (even though it has no ears) back to its master, as the thaumaturge desires.
System: The casting of this ritual requires that the thaumaturge cut off her hand and pluck out her eye at the conclusion of this ritual; this causes five-levels of unsoakable aggravated damage. Once this damage is healed, the Tremere regenerates her hand and eye, though the ghastly homunculus may still prowl. Completing this ritual may also require a Willpower roll at the Storyteller’s discretion, simply to carry out the painful finale. The animate hand has one health level of its own and moves about with the equivalent of two dots in each Physical Attribute and in Perception (see p. 108). The caster mentally directs the thing’s movement at will (so long as the thaumaturge remains conscious, of course). The Hand must have one point of blood each week, or else it crumbles to dust. Likewise, if the hand is exposed to sunlight or fire, it vanishes with a squeal, leaving behind a putrid stench.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Samira’s Kihanah"] = {
					en = [==[Dark Ages Tome of Secrets, p. 117


3. Samira’s Kihanah


Samira’s Kihanah allows the caster to know that which is truly unknown. To use this ritual, she takes a small, metal, hand-crafted object, no larger than her forearm, and smears it with three blood points over six hours, under the blood moon. The object absorbs the blood, and it takes a reddish hue. Once the ritual is cast, it summons forth a djinn. The caster, or indeed anyone else who holds the object, may ask a question lost to time. This is to say, a question to which no living (or Cainite) person knows the answer. Otherwise, the question remains unanswered. The djinn spreads its consciousness throughout space and time, and returns instantaneously with the answer. However, the djinn will always try to phrase the answer in such a way that the curious questioner will find massive trouble, despite its truth. With each answered question, the red fades slightly, until the third question, at which time the djinn flees the world of flesh. The object remains enchanted until fully depleted. Unanswered questions do not deplete the object.
Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. Sanguine Assistant"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 236


3. Sanguine Assistant


Thaumaturges often need laboratory assistants whom they can trust implicitly. This ritual allows the intrepid vampire to conjure a temporary servant. To cast the ritual, the thaumaturge slices open his arm and bleeds into a specially prepared earthen bowl. The ritual sucks in and animates whatever random unimportant items the wizard happens to have lying around his workshop — glass beakers, dissection tools, pencils, crumpled papers, semiprecious stones — and binds the materials together into a small humanoid form animated by the power of the ritual and the blood. Oddly enough, this ritual almost never takes in any tool that the caster finds himself needing during the assistant’s lifespan, nor does it take the physical components of any other ritual nor any living thing. The servant has no personality to speak of at first, but gradually adopts the mannerisms and thought processes that the thaumaturge desires in an ideal servant. Sanguine Assistants are temporary creations, but some vampires become fond of their tiny accomplices and create the same one whenever the need arises.
System: The player spends five blood points and rolls. The servant created by the ritual stands a foot (30 cm) high and appears as a roughly humanoid shape composed of whatever the ritual sucked in for its own use. It lasts for one night per success rolled. At the end of the last night, the assistant crawls into the bowl used for its creation and falls apart. The assistant can be reanimated through another application of this ritual; if the caster so desires, it re-forms from the same materials with the same memories and personality.
A Sanguine Assistant has Strength and Stamina of 1, and Dexterity and Mental Attributes equal to those of the caster. It begins with no Social Attributes to speak of, but gains one dot per night in Charisma and Manipulation until its ratings are equal to those of the caster. It has all of the caster’s Abilities at one dot lower than his own. A Sanguine Assistant is a naturally timid creature and flees if attacked, though it will try to defend its master’s life at the cost of its own. It has no Disciplines of its own, but has a full understanding of all of its master’s Thaumaturgical knowledge and can instruct others if so commanded. A Sanguine Assistant is impervious to any mind-controlling Disciplines or magic, so completely is it bound to its creator’s will.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Sanguine Trail"] = {
					en = [==[Lore of the Clans, p. 221


3. Sanguine Trail


By touching a target she believes to be blood bound, the user of this power can trace the target’s regnant and anyone else connected to him by such a bond. A thin red thread appears to stretch out from the target and connects to anyone he has a blood bond connection with, whether they are master or servant. This does not work on vampires connected by the Vinculum, as the bond is too diffuse.
System: If the ritual is successful, the caster can see a connection between the target and anyone he is blood bound to. If multiple bonds are in place, the power user can see one for each success she makes. If she achieves five successes, she can also see which direction each bond goes, revealing who is bound to whom.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Scorpion Sending"] = {
					en = [==[Rites of Blood, p. 166


3. Scorpion Sending


Scorpion Sending is a Level Three Akhu Ritual. The sorcerer crafts a scorpion out of wax, incorporating some material that came from the target’s body. She writes the name of Set on the scorpion and recites the story of the poisoning of Horus, leaving out the part where he recovers. Then, she leaves the model in an area where the target will come, at which point it will come to life and attack him.
System: The scorpion has the normal traits for an animal of its size, but if it strikes the target successfully, he is poisoned. The poison inflicts one level of lethal damage every fifteen minutes. The damage ends if the target successfully rolls Stamina (difficulty 7) with one roll every fifteen minutes. The venom attacks mortals and supernaturals alike. The scorpion is small and therefore difficult to see (Perception + Alertness, difficulty 7).
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Scry the Hearthstone"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 307


3. Scry the Hearthstone


With this ritual, the caster or a subject whom she casts it on becomes linked with a haven (up to the size of a small castle). The subject may detect intruders of any sort, even if they are out of sight or under the veil of Obfuscate or similar powers. The ritual takes an entire night to complete and involves continuous incantation in conjunction with marking the subject’s vitae at the cardinal boundaries of the haven, followed by the caster expending a point of Willpower to activate the effects. When completed, the subject gains an innate sense of the location and approximate size and physical condition of all living or unliving beings within the structure. To pinpoint an individual’s location, the player rolls Perception + Awareness (difficulty 6); if the target is attempting to hide, she contests with a Wits + Stealth roll (difficulty 6), and whoever achieves the most successes is the victor. Regardless of the subject’s success or failure on the roll, she knows there is someone present, even if she cannot see the individual in question. To detect intruders employing magical or supernatural abilities of concealment such as Obfuscate, the subject must possess and have supernatural perception (such as Auspex) of her own activated at the time (see “Seeing the Unseen” sidebar on p. 195). Scry the Hearthstone lasts for a number of weeks equal to the successes scored on the initial casting roll and is only tied to the location associated with the casting.
This is both a Gargoyle and a Haven Ritual (see Enchant Talisman on p. 309 and Dedicate the Haven on p. 310).
Haven Ritual (p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Gargoyle Rituals (p. 309): Tremere thaumaturges may cast Enchant Talisman onto a Gargoyle to permanently enchant it with a specific ritual she knows. To accomplish this feat requires six hours per night, and one week per level of the ritual. Once successfully cast, a ritual permanently enchanted onto a Gargoyle becomes inherent to him, like a Discipline, and may be activated, deactivated, and reactivated at will by the Gargoyle spending one blood point. If the ritual is tied to a specific item, it is instead tied to the Gargoyle itself. A Gargoyle invoking Scry the Hearthstone may utilize the effects of the ritual on any dwelling by directly touching it and spending a point of Willpower. Rituals activated by a Gargoyle require no roll to cast and last a scene or until dismissed.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. Shaft of Belated Quiescence"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 237


3. Shaft of Belated Quiescence


This ritual turns an ordinary stake of rowan wood into a particularly vicious weapon. When the stake penetrates a vampire’s body, the tip breaks off and begins working its way through the victim’s flesh to his heart. The trip may take several minutes or several nights, depending on where the stake struck. The stake eludes attempts to dig it out, burrowing farther into the victim’s body to escape surgery. The only Kindred who are immune to this internal attack are those who have had their hearts removed by Serpentis.
System: The ritual takes five hours to enact, minus 30 minutes per success. The stake must be carved of rowan wood, coated with three blood points of the caster’s blood, and blackened in an oak-wood fire. When the ritual is complete, the stake is enchanted to act as described above.
An attack with a Shaft of Belated Quiescence is performed as with a normal stake: a Dexterity + Melee roll (difficulty 6, modified as per the normal combat rules; the attack does not need to specifically target the heart) with a lethal damage rating of Strength + 1. If at least one health level of damage is inflicted after the target rolls to soak, the tip of the stake breaks off and begins burrowing. If not, the stake may be used to make subsequent attacks until it strikes deep enough to activate.
Once the tip of the stake is in the victim’s body, the Storyteller begins an extended roll of the caster’s Thaumaturgy rating (difficulty 9), rolling once per hour of game time. Successes on this roll are added to the successes scored in the initial attack. This represents the tip’s progress toward the victim’s heart. A botch indicates that the tip has struck a bone and all accumulated successes are lost (including those from the initial attack roll). Removing the part of the body where the tip impacted (such as a Tzimisce turning into blood or a vampire cutting off their arm) may stop the tip’s progress, depending on the number of successes acquired and the Storyteller’s discretion. When the shaft accumulates a total of 15 successes, it reaches the victim’s heart. This paralyzes Kindred and is instantly fatal to mortals and ghouls.
Attempts to surgically remove the tip of the shaft can be made with an extended Dexterity + Medicine roll made once per hour (difficulty 7 for Kindred and 8 for mortals). The surgeon must accumulate a number of successes equal to those currently held by the shaft in order to remove the tip. Once surgery begins, however, the shaft begins actively evading the surgeon’s probes, and its rolls are made once every 30 minutes for the duration of the surgery attempt. Each individual surgery roll that scores less than three successes inflicts an additional unsoakable level of lethal damage on the patient.
Shaft of Belated Quiescence may be performed on other wooden impaling weapons, such as spears, arrows, practice swords, and pool cues, provided that they are made of rowan wood. It may not, however, create a Bullet of Belated Quiescence.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Soul of the Homunculus"] = {
					en = [==[Rites of Blood, p. 151


3. Soul of the Homunculus


A thaumaturge in need of assistants for research work cannot always rely upon the loyalty of apprentices, but who doubts the loyalty of one’s own flesh? A homunculus is a tiny creature crafted out of the caster’s blood and tissue and invested with life via Thaumaturgy. Crafting a homunculus takes several hours of uninterrupted work, and a thaumaturge can have only one homunculus at a time.
The horrid little entity takes shape in a bubbling morass of oil, blood, denuded bone, and chunks of the caster’s body. At the conclusion of the ritual, the homunculus crawls from its fatty birthing caul to serve its master. It can move about under its own power, and may be used as a spy or a means to fetch materials. The homunculus acts according to its master’s orders, which may be issued by thought as long as the beast is in its creator’s presence. Over time, some homunculi may develop their own personalities and goals.
System: A homunculus (see p. 107) has two health levels and two dots in each Physical Attribute. It works much like a limb of the creator, as the homunculus only moves or acts if the caster so wills it. Homunculi are damaged by sunlight and fire like Kindred. A homunculus, though created from the caster’s flesh, is a separate physical entity, and thus does not count as an arcane connection, nor do its bodily fluids count as its creator’s blood.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Strength in Wisdom"] = {
					en = [==[Dark Ages Tome of Secrets, p. 43


3. Strength in Wisdom


A sorcerer who witnesses an immoral act that serves as evidence of a Cainite’s unworthiness may instill protections upon the warrior or warriors sent to apprehend him. This ritual grants bonus dice equal to the successes rolled. These dice can be divided however the sorcerer wishes among any physical or mental defenses against the target. Any roll using these bonus dice benefit from -1 difficulty.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["3. Summoning the Blatherskites"] = {
					en = [==[Dark Ages Tome of Secrets, p. 36


3. Summoning the Blatherskites


Mystics publicly snub those who practice this ritual. Blatherskites are uncontrollable Abyssal entities known for attacking victims randomly, albeit in a devastating manner. When Lasombra wish for chaos to reign in a rival domain, however, blatherskites ease from the shadows to tear herds and retainers apart. Mystics may deny involvement, but this ritual sees increasing use as Magisters secure their grip on the Sea of Shadows.
System: The Cainite incanting this ritual must have familiarity with the domain in which she wishes the blatherskites to emerge, having already succeeded on a Perception + Survival roll (difficulty 6) on a night prior to the summoning, in order to identify the darkest cracks. From these, the blatherskites birth. The Abyss Mystic must submerge herself in a body of water and make an extended test of Manipulation + Occult (difficulty 7) with a target of 10, 15, or 20 successes. Over the course of that night, for each target number hit, a blatherskite emerges in the chosen domain and attacks at random whomever it comes across. You do not choose a target; another blatherskite emerges at each benchmark. It can only be harmed by aggravated damage and it melts when the sun rises. On a botched extended test, a blatherskite emerges from the body of water in which the Cainite performs the rite, and attacks its summoner. The blatherskite’s statistics are stated on p. 33.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["3. Telecommunication"] = {
					en = [==[Rites of Blood, p. 68


3. Telecommunication


Telecommunication is one of the earliest rituals associated with Technomancy. In fact, the insights gained from the creation of this ritual were the very signposts that proved that Technomancy was possible. The thaumaturge must trace a sigil on the screen of a television or a computer monitor. While the ritual lasts, the thaumaturge can see and hear what is near the screen as if he were looking out of it. More importantly, with a thought, he can change what appears on the screen, whether to create a fake news story to deceive others or simply to make his own face appear so that he can converse with watchers.
System: The successes rolled create a dice pool which the thaumaturge can use to either observe through or control the screen at any point over the next seven nights. The player must roll this dice pool either to see and hear through the screen (difficulty 4) or to control what the screen plays for others (difficulty 7). A botch on either of those rolls ends the ritual’s effect immediately.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Tempest Prison"] = {
					en = [==[Rites of Blood, p. 94


3. Tempest Prison


In order to pay the tithe of souls that Venice demands, many Giovanni Necromancers previously bound wraiths to a set of objects and sent these to the Mausoleum. However, as the demands of the Elders become greater, some Necromancers have sought to find a more effective way of transporting greater numbers of wraiths in one shipment. The Tempest Prison was their solution.
The Necromancer first obtains a large, glass container (such as a gallon glass jug) and takes it to a graveyard. She then buries the sealed jar in the earth above a grave of someone that died prematurely, or by violence, or in some fashion that meant they stood a good chance of creating a wraith upon their demise (which may require a bit of research prior to casting). The Necromancer then laces the ground with blood as she chants, calling forth the power of the storm that rages deep within the lands of the dead.
System: Upon completion of the rite, the ground shudders for a moment to indicate its success. Digging up the glass container, it is now full of a swirling purple and black mist, in which can be seen occasional flecks of light, like miniature lighting. When the Necromancer opens the bottle, any wraith in line of sight of the container must make a Strength test (using their Strength stat as it is when in the Shadowlands) against a Difficulty of 6 plus the number of successes gained upon on the casting of the Ritual. This test is repeated each round until the wraith is out of sight of the container, or it fails and is sucked immediately into the vortex (which does not leave the container).
The Tempest Prison can hold a number of wraiths equal to five times the number of successes rolled in its activation. It also lasts for a number of nights equal to five times successes rolled, after which time, the vortex subsides and the wraiths are released. This may also be ended prematurely by simply smashing the container (which may lead to suddenly dealing with a storm of angry wraiths).
The Tempest Prison does not necessarily need to be wielded by a Necromancer after it has been created. It requires a Necromancer to create it, but not to use it. Indeed, many Giovanni who are called upon to rid an area of ghostly interference lend their employers such a container to collect the troublesome ghosts. They then “dispose” of the ghosts elsewhere. In these cases, both sides of the deal get what they want.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["3. Tempesta Scudo"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 181


3. Tempesta Scudo


Unlike most rituals, Tempesta Scudo can be cast speedily. The necromancer performs a short and awkward dance that ends with her biting through her own lip and spitting the blood in a circle around her. All ghosts’ actions within the circle of blood are made at +2 difficulty.
To cast this ritual successfully, the necromancer must spend one combat turn performing the dance. At the end of the turn, she makes a Dexterity + Performance roll against difficulty 7 (if done outside of combat, the difficulty is only 6). During the next combat turn, she bites through her own lips (taking a level of bashing damage) and spits (spending one blood point). Then the normal ritual roll is made to see whether the power takes effect.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["3. The Bottled Voice"] = {
					en = [==[Rites of Blood, p. 150


3. The Bottled Voice


To rob an enemy of her voice strikes into the heart of her identity. This ritual is often used as a public punishment for those rebel souls that refuse to moderate their behavior in court or Elysium. The victim must be immobilized as a crystal bottle is placed over her heart while the caster chants the incantation that draws out the target’s voice. Next, the thaumaturge must seal the crystal bottle with wax to trap the voice and complete the ritual. Afterwards, the victim is no longer able to speak or make any sort of verbal sound. This curse can seriously limit a Kindred’s powers. Without the ability to speak, disciplines such as Dominate or Presence may be useless to the target, as are blood magic rituals with a verbal component.
System: To cast the ritual, the thaumaturge must immobilize the victim. This can be done via staking or binding the target. The caster must have unfettered access to the victim while he attempts to draw forth the voice. Each point of Willpower the victim currently possesses extends the required casting time by fifteen minutes. Once the ritual is complete, the crystal bottle contains the essence of the victim’s voice, and she may not speak nor make any verbal sound until the seal or the crystal bottle has been broken. The death of the thaumaturge does not break this curse.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. The Floating Dead"] = {
					en = [==[Dark Ages Tome of Secrets, p. 51


3. The Floating Dead


Level Three Rite — The Black Sea Kraina — Attribute: Dexterity
Water is no enemy to the koldun. The Floating Dead allows the Cainite to step upon and cross any body of water without sinking, no matter the load he carries.
System: When the rite is concluded, the Cainite gains the ability to cross rivers, lakes, and even seas without sinking beneath the waves. This permanent power is nullified if the Cainite is ever submerged in water, by choice or force.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["3. The Third Eye of Rickard Argentis"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 273


3. The Third Eye of Rickard Argentis


This ritual summons forth a mysterious third eye, forged from abyssal energies, which rests upon the caster’s forehead and protects him from harm. The ritual takes ten minutes to cast as close to dusk as he is able, at which time the caster chooses how much blood to invest in the eye. At any time the caster would be ambushed or surprised, the eye will expend one of the blood so invested. When this happens, the caster automatically succeeds on the roll to react to surprise, and the eye reflexively summons forth one Arm of Ahriman (see p. 229) against his attacker, which can act immediately. If the player chooses to expend further blood points, additional Arms can be summoned against other attackers, but no more than one per attacker.
Once the blood is fully expended, the eye vanishes until recast.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["3. Translocation of the Vessel"] = {
					en = [==[Rites of Blood, p. 27


3. Translocation of the Vessel


Legends abound of mighty wizards summoning forth items of great power with an incantation and a sweeping gesture. Rumored to have been created by Etrius during the siege of Ceoris when the entire Clan needed to be armed at a moment’s notice, this ritual allows a thaumaturge to mystically link herself to a specially prepared vessel via the power of her vitae. By speaking the name of the object in question, the caster may teleport this vessel directly into her hand with a burst of shimmering black light.
System: Translocation of the Vessel requires that the thaumaturge select a vessel to attune to her vitae. This item must be small enough that she can easily lift it with one hand. Examples might include a scalpel, a walking stick, a handbag, a pouch, or a wand. Next, she must soak the vessel in a point of her blood over the course of an evening. The object will slowly absorb the vitae, creating a sympathetic bond between the vessel and the thaumaturge. The caster may sever the link at any time by spending a point of Willpower or if the vessel is broken.
When the caster wishes to have the vessel ready for translocation, she draws a circle of protection onto the ground with purified salt and a point of her blood. This circle must be large enough to completely surround the vessel. Once the vessel is placed into the circle of protection, it can be summoned to the thaumaturge by name, anywhere in the world. The caster must extend her hand, chant the incantation involving the name of the object, and it appears in her hand.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Transubstantiation of Seven"] = {
					en = [==[Rites of Blood, p. 151


3. Transubstantiation of Seven


The Tremere hold a special loyalty to House and Clan, but the extent of this loyalty and the means by which it is garnered remain a secret to the Kindred at large. In reality, every Tremere Apprentice holds a partial bond to the Council of Seven through their mixed blood.
After the Embrace, a Tremere neonate undergoes a formal oath-swearing of the Code of Tremere. No magic compels that oath, but the presiding regent (or higher ranking Tremere) ends the formality with the Transubstantiation. The caster fills a large chalice with his own blood and intones the syllables of the ritual. The neonate, still grappling with the new phenomenon of blood-thirst, drinks the entire contents of the chalice. As the blood enters and spreads through her system, the rite mystically transforms it into the blood of the Council of Seven.
By this means, the Tremere place each neonate one step toward a full bond with the council, without the risk of having enemies steal the council’s blood. Partaking of the Transubstantiation is considered a requirement for a fledgling to be recognized socially as a true member of the Tremere Clan.
Those who undergo the ritual, and indeed, many who have the ability to perform it, know little of its mystical design or purpose. Obviously, the transmuted blood is that of the Council of Seven — but how vast are their stores that they can transfuse neonates at the whims of those conducting the ritual? Where does the neonate’s blood go? Whispers of a hidden vault beneath Vienna with labeled, preserved vials of vitae from every Kindred who has ever undergone this ritual can’t possibly be true… can they?
System: The caster of the Transubstantiation must sacrifice a point of her own blood. The blood placed in the chalice remains unchanged until after it’s imbibed and then spread throughout the subject’s system, at which point it takes on the properties of the Council of Seven.
This causes one step toward a blood bond to the whole council, but guarantees that the councilors’ vitae cannot be stolen. Because the blood is already in the subject’s system, it counts as his own vitae if it is later drained out.
In truth, there is no physical requirement that this rite be used on a new neonate. A rare few Tremere neonates escape the process. Theoretically, the rite could also be used to generate a stronger bond in older Tremere or even in ghouls or Kindred of other Clans. Kindred of the 14th or 15th generations, ghouls, and revenants cannot use this rite — their blood is not sufficiently strong enough to channel the councilors’ power.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Ward of the Winged Sepulcher"] = {
					en = [==[Lore of the Bloodlines, p. 37


3. Ward of the Winged Sepulcher


Level 3 Gargoyle Ritual. The Gargoyle (or its master) can prepare the creature to provide temporary shelter from the damning rays of the sun. When the rays of the sun strike the caster’s skin, wings billow out and dramatically wrap around itself and anyone in the creature’s grasp. Both the caster and its charge are protected from taking sunlight damage until the sun sets the next evening.
System: The caster must prepare a small cube, half an inch in diameter, carefully cut from a tombstone marking an empty grave in a graveyard. Spending a blood point, he dabs each side of the cube with a drop of blood, whispering an incantation. The caster ingests the cube and the ritual lies dormant until the creature’s skin is touched by sunlight, at which point wings unfurl to protect the caster. The wing hardens to a stone-like substance and it is able to protect one person inside its space. If the caster does not already possess wings, the ward does one level of aggravated damage if only protecting the caster, two if protecting the caster and one other subject.
Gargoyle rituals (p. 37): Enchanting a Gargoyle with a ritual requires casting the ritual for six hours a night, for one week per level of the ritual to be applied, but otherwise uses the same rules as Enchant Talisman. Rituals activated by a Gargoyle require no roll to cast, and last a scene or until dismissed. A Gargoyle enchanted in this matter can spend its own blood or Willpower as if it were the caster of the ritual enchanted into its blood. If no cost is normally required for the ritual, however, the Gargoyle must still spend at least one blood to activate it. If the ritual requires a specific item, the Gargoyle herself is considered to be the “item” for purposes of the ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Ward versus Lupines"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 237


3. Ward versus Lupines


This wards an object in a manner identical to that of the Level Two ritual Ward Versus Ghouls, except that it affects werewolves.
System: Ward versus Lupines behaves exactly as does Ward versus Ghouls, but it affects werewolves rather than ghouls. The ritual requires a handful of silver dust rather than a blood point.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Warding Circle versus Lupines"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


3. Warding Circle versus Lupines


The Tremere have access to several other Warding Circle rituals: Warding Circle versus Lupines (Level Three), Warding Circle versus Kindred (Level Four), and Warding Circles versus Spirits, Ghosts, and Demons (Level Five). Each Warding Circle ritual must be learned separately. The material components required for each warding circle are the same as those needed for the corresponding ward, but in larger amounts. The effects against the targeted beings are the same as for Warding Circle versus Ghouls.
System: As Warding Circle versus Ghouls (p. 234), but the circle affects werewolves. The ritual requires the same material component as Ward versus Lupines — silver dust — but in a larger amount. The caster determines the size of the warding circle when it is cast; the default radius is 10 feet/3 meters, and every 10-foot/3-meter increase raises the difficulty by one, to a maximum of 9. The ritual takes the normal casting time if it is to be short-term (lasting for the rest of the night) or one night if it is to be long-term (lasting a year and a day).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["3. Wield the Spear of Damnation"] = {
					en = [==[Dark Ages Companion, p. 116


3. Wield the Spear of Damnation


This ritual recalls the legend of Caine itself, dedicating a weapon to satisfy a vampire’s nature just as the Dark Father cursed himself, when he raised a sharp stone against his brother. The Tremere writes Genesis 4:10 (“And he said, ‘What hast thou done? the voice of thy brother’s blood crieth unto me from the ground.’”) upon an edged weapon in purported angelic script, during a meditative trance. This requires one hour. From that moment forward, half the lethal damage inflicted by the weapon (rounded up) converts to blood points, filling the wielder’s pool. This persists until the weapon has harvested the caster’s Thaumaturgy rating + ritual successes in blood points. Blood so harvested doesn’t inflict extra damage (it comes straight from blood shed by the wound), but is of the target’s type. Lupine blood remains doubly potent, and other blood types have their signature effects.
Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Animated Weapon"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 307


4. Animated Weapon


This ritual allows the caster to animate a weapon for future use. The caster collects the skin of a scavenger animal that nourishes itself on the dead. The caster then binds the skin around the weapon in wax-sealed nightshade twine, requiring 12 hours to cast, minus one hour per success. When the binding is torn off, the weapon leaps to life, animating itself and attacking whomever the wielder verbally commands it to during the same turn. An Animated Weapon has the following qualities:
• The weapon has an effective life of five combat turns per success rolled on its creation.
• The weapon’s attack dice pool is equal to the caster’s Wits + Occult, and its damage dice pool equal to the caster’s Thaumaturgy rating. The weapon always aims for the heart (difficulty 9). If the weapon is wooden, use the staking rules (p. 348) to judge its success. Three successes on a Dexterity roll (difficulty 8) are required to remove animated wooden splinters from a victim’s heart without leaving behind any shards.
• The weapon’s maximum movement rate is 30 yards/meters per turn, and it may only perform actions to attack or move toward its target. The weapon cannot dodge or split its dice pool to perform multiple attacks.
• The weapon has three health levels, and the difficulty of attacks directed against it are increased by three due to its spastic movement patterns.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Baleful Doll"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 181


4. Baleful Doll


A baleful doll is a powerful figure that is linked directly to the spirit of the target. This doll must be handcrafted, and is only finished when it has been painted with the blood of the necromancer and dressed in some article of clothing from the victim (which should be unwashed for a better connection). Once the doll has been cursed, the vampire can use it to cause physical damage to the target. If the doll is injured (often with pins or other items), the victim takes six dice of bashing damage. If the doll is destroyed, the target suffers six dice of lethal damage.
The necromancer must craft the doll, using ritual chants throughout the process. This normally takes four to five hours. The player rolls Stamina + Crafts (difficulty 8) to succeed in this part of the ritual — a doll that does not resemble its victim is useless for the purposes of this ritual, though some necromancers sell failures as “authentic voodoo dolls” to tourists.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["4. Baron Zaraguin’s Sting"] = {
					en = [==[Rites of Blood, p. 66


4. Baron Zaraguin’s Sting


A curious syncretic ritual that combines Haitian Voudoun with imagery and ideas drawn from a comic book, Baron Zaraguin’s Sting is a powerful defensive ritual. The ritualist must imbibe blood laced with LSD just before sunrise and spend the day in a wooden coffin containing at least ten live scorpions. The visions the vampire suffers during her long day of confinement combined with the stings of the angry scorpions open her mind to communion with Baron Zaraquin, the patron loa of scorpions and spiders.
System: For every two successes (rounded up) rolled on the ritual, the vampire takes one level of lethal damage from scorpion stings. This damage is unsoakable but can be healed normally. In exchange for submitting to the scorpions’ stings, however, the vampire also gains Baron Zaraquin’s blessing for one night per success. During that time the difficulty on all rolls to supernaturally influence the sorcerer (such as Dominate or Majesty) or to read her aura or her mind increases to 9. Furthermore, any character who attempts to use such powers against the sorcerer suffers one unsoakable point of psychic bashing damage for every 1 rolled on the attempt. If such a roll actually botches, the damage is lethal and the character also has a brief vision of a giant spiritual scorpion, a manifestation of Baron Zaraguin, as its tail strikes her in the forehead for the affront.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Bastone Diabolico"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 181


4. Bastone Diabolico


Casting this ritual is tricky because it requires the removal of a leg bone from a living person. The donor must survive the removal, at least for a little while. The bone is then submerged in molten lead. Once it cools, the thin lead coating is inscribed with various runes. The necromancer then uses this metal-shod bone to beat its donor to death while repeating a droning Greek chant.
With a successful roll, this ritual produces a bastone diabolico or “devil stick.” The stick can be activated by anyone who holds it and expends a point of Willpower. Activation lasts for a scene, and during that time any ghost hit with the devil stick loses a point from its Passion pool (see p. 385). In addition to its normal effects, this club does an additional die of damage when used against the walking dead (not vampires), and such damage is aggravated.
Unfortunately for the necromancer, ghosts can sense that the bastone diabolico is bad news, even if they don’t know exactly what the thing does. They tend to stay away from anybody carrying one, which means that all rolls for such a character to use powers that summon or attract ghosts occur at +1 difficulty.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["4. Bone of Lies"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 237


4. Bone of Lies


This ritual enchants a mortal bone so that anyone who holds it must tell the truth. The bone in question is often a skull, though any part of the skeleton will do — some casters use strings of teeth, necklaces of finger joints, or wands fashioned from ribs or arms. The bone grows blacker as it compels its holder to tell the truth, until it has turned completely ebony and has no magic left.
This ritual binds the spirit of the individual to whom the bone belonged in life; it is this spirit who wrests the truth from the potential liar. The spirit absorbs the lies intended to be told by the bone’s holder, and as it compels more truth, it becomes more and more corrupt. If summoned forth, this spirit reflects the sins it has siphoned from the defeated liar (in addition to anger over its unwilling servitude). For this reason, anonymous bones are often used in the ritual, and the bone is commonly buried after it has been used to its full extent. A specific bone may never be used twice for this ritual, though different bones from the same corpse can.
System: The bone imbued with this magical power must be at least 200 years old and must absorb 10 blood points on the night that the ritual is cast. Each lie the holder wishes to tell consumes one of these blood points, and the holder must speak the truth immediately thereafter. When all 10 blood points have been consumed, the bone’s magic ceases to work.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Boukephos’ Gateway"] = {
					en = [==[Dark Ages Tome of Secrets, p. 37


4. Boukephos’ Gateway


This ritual is fraught with peril. Abyss Mystics who open their souls to the Abyss irrevocably change their beings, putting power within easy reach but potentially damning the practitioners. The infamous Boukephous designed the ritual as a lesson to Mystics who dabble but do not embrace the Abyss. Boukephos’ Gateway makes clear the breadth of powers a Lasombra can attain, if only he is prepared to accept the risk of destruction.
System: The Abyss Mystic spends one whole night staring into a mirror, only darkness reflected back. As the night proceeds, the Mystic must spend three Willpower points, and then succeed on a Conviction roll (difficulty 8) on which no Willpower can be spent. The vampire remains in place, staring at the mirror, even after the sun comes up. Another three Willpower points must be spent, and another Conviction roll must be made (difficulty 9) on which no temporary Willpower points can be spent. Come the following night, the vampire turns from the mirror having gazed into the Abyss and her own, empty soul. If successful, the Cainite bears a broad grin and is now on the Road of the Abyss. In addition, he spends one fewer blood point on Obtenebration powers forevermore. On a failure, the vampire can never move on to the Road of the Abyss, but can attempt the ritual again for the Obtenebration benefit. A botch results in the vampire falling directly into torpor, from which only the vitae of a Lasombra of lower Generation can rouse her. She may never attempt the ritual again, and gains a Derangement.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["4. Cadaver’s Touch"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 182


4. Cadaver’s Touch


By chanting for three hours and melting a wax doll in the shape of the target, the necromancer turns a mortal target into a corpselike ruin. As the doll loses the last of its form, the target becomes cold and clammy. His pulse becomes weak and thready, and his flesh pale and chalky. For all intents and purposes, he becomes a reasonable facsimile of the walking dead. This can have some adverse effects in social situations (+2 difficulty on all Social rolls). The effects of the ritual wear off only when the wax of the doll is permitted to solidify. If the wax is allowed to boil off, the spell is broken.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["4. Candle of Haunting"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 308


4. Candle of Haunting


On a Friday night, the caster creates a black candle incorporating the brains and bones of a dead man with nine pinches of cemetery dirt. By burning the candle for 20 minutes each night while clutching and concentrating on an item that once belonged to the target, the caster plagues the victim with poltergeist-like activity such as thrown objects or furniture that moves to trip her. The candle is large enough to burn for a number of 20-minute periods equal to the caster’s successes on the casting roll. Each 20-minute increment costs the caster one blood point. A single success will set the poltergeist against the victim for 24 hours. The poltergeist has an Intimidation and a Fright rating of 4 each (each Fright point adds one die to attempts to scare), Strength 2, and a dice pool of 4 for its pranks and attacks. In order to scare the target, the poltergeist must make a contested roll using its Fright rating + Intimidation against the victim’s Self-Control or Instinct + Courage. With five or more successes, the target’s hair turns white and if mortal, she may very well have a heart attack. The poltergeist tries to cause serious harm at least once every night that it harasses the target, using whatever props it finds on hand. If the ghostly force shoves the target while she walks down a steep flight of stairs or throws something while she rides a horse or steers a carriage, the target is likely to be seriously injured.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Directing Ahriman’s Lance"] = {
					en = [==[Rites of Blood, p. 163


4. Directing Ahriman’s Lance


The ashipu must fashion a sympathetic connection to a target out of a talisman small enough to be swallowed. Then, she must swallow it, wait an hour, and then cut the talisman out of her own belly. Other sorcerers may assist in this undertaking, which inflicts a minimum of two levels of unsoakable lethal damage on the one performing the ritual. Until the next inauspicious night, any Kindred who holds the talisman will find that the spirits bless his efforts to kill the target.
System: To determine how long the ritual lasts, the ashipu must first use the Horoscope ritual against the target or, if the birth date and death date of the target is unknown, he may cast a horoscope for the assassin who will wield the talisman. In the latter case, only that assassin may benefit from the talisman’s properties, but in the former case, anyone can use the talisman. When Horoscope is used in conjunction with this ritual, the talisman will function for a number of nights equal to the successes rolled for the Horoscope. During that time, any roll made by the bearer of the talisman which bring him closer to killing the target benefit from a difficulty reduction equal to the successes rolled for this ritual.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["4. Dismemberment of Osiris"] = {
					en = [==[Rites of Blood, p. 167


4. Dismemberment of Osiris


Dismemberment of Osiris is a Level Four Akhu Ritual. The sorcerer ritually dismembers the leader or spokesperson of a group or organization (who must be a male; female-led organizations cannot be affected by this power). Then, after the victim is dead, the sorcerer removes his phallus and drops it into a tank of fish who then devour it. In response, the group or organization suffers an external setback over the next six months.
System: The results are largely a matter of Storyteller discretion, influenced by the success of the ritual. As a general rule, assume that each success on the roll results in a cumulative 10% reduction in the size and resources of the targeted group.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["4. Evoke the Storm"] = {
					en = [==[Dark Ages Tome of Secrets, p. 52


4. Evoke the Storm


Level Four Rite — The Transylvanian Kraina — Attribute: Wits
One of the mightiest known kraina rites; Evoke the Storm allows the Cainite to summon foul weather, lightning strikes, and horrendous gales. The koldun using this rite have sunk ships, electrocuted warlords to death in their gleaming armor, and made rivers burst their banks and wash away villages.
System: To activate the powers imbued by this rite, the Cainite must stand somewhere elevated and open, where the full horizon can be viewed without obstruction, such as a cliff or grand castle. From this point, the koldun can summon forth gales and storms anywhere he can see, stopping just short of hurricanes. The effects of this power are to be determined by the player, with agreement by the Storyteller. This permanent rite is waived if the practitioner is ever awake past the dawn.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["4. Firewalker"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 238


4. Firewalker


This ritual imbues the vampire with an unnatural resistance to fire. Only a foolish vampire would actually attempt to walk on or through fire, but this ritual does grant an advanced tolerance to flame. Some Sabbat use this ritual to show off, while other thaumaturges use it only for martial concerns. To enact the ritual, the caster must cut off the end of one of his fingers and burn it in a Thaumaturgical circle.
System: Cutting off one’s finger does not do any health levels of damage, but it hurts like hell and requires a Willpower roll to perform. This ritual may be cast on other vampires (at the expense of the caster’s fingertips...). If the subject has no Fortitude, he may soak fire with his Stamina for the duration of this ritual. If the vampire has Fortitude, he may soak fire with his Stamina + Fortitude for the duration of the ritual. This ritual lasts one hour.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Heart of Stone"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 238


4. Heart of Stone


A vampire under the effect of this ritual experiences the transformation suggested by the ritual’s name: his heart is completely transmuted to solid rock, rendering him virtually impervious to staking. The subsidiary effects of the transformation, however, seem to follow the Hermetic laws of sympathetic magic: The vampire’s emotional capacity becomes almost nonexistent, and his ability to relate to others suffers as well.
System: This ritual requires nine hours (reduced by one hour for every success). It can only be cast on oneself. The caster lies naked on a flat stone surface and places a bare candle over his heart. The candle burns down to nothing over the course of the ritual, causing one aggravated health level of damage (difficulty 5 to soak with Fortitude).
At the end of the ritual, the caster’s heart hardens to stone. The caster gains a number of additional dice equal to twice his Thaumaturgy rating to soak any attack that aims for his heart and is completely impervious to the effects of a Shaft of Belated Quiescence (see p. 237). Additionally, the difficulty to use all Presence or other emotionally manipulative powers on him is increased by three due to his emotional isolation. The drawbacks are as follows: the caster’s Conscience/Conviction and Empathy scores drop to 1 (or to 0 if they already were at 1) and all dice pools for Social rolls except those involving Intimidation are halved (including those required to use Disciplines). All Merits that the character has pertaining to positive social interaction are neutralized. Heart of Stone lasts as long as the caster wishes it to.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Houngan’s Doll"] = {
					en = [==[Rites of Blood, p. 62


4. Houngan’s Doll


There is a well-known Necromancy ritual for creating an effigy doll (Baleful Doll, V20, p. 181), but that is not the only type of effigy that can be created. This ritual is performed just like the Baleful Doll ritual, but while Baleful Doll allows the vampire to inflict actual physical damage to the associated target, it is useless for more subtle effects. For that, the Houngan’s Doll is needed. This effigy cannot be used to directly inflict damage on the target, but it will allow the sorcerer to see and hear through the target’s eyes, to whisper things to the target that only he can hear, and to inflict physical sensations on him that are not harmful but certainly feel real. Sticking the doll with a pin still hurts the target even if it inflicts no damage. Holding a lit candle near the doll’s head may cause the target to suffer Rötschreck. One impudent (and reckless) Anarch famously humiliated a prominent Tremere in front of his Prince and Primogen simply by tickling the doll with a feather during a council meeting. The thought of a powerful elder rolling on the floor and laughing hysterically was one the Anarch treasured... until her brutal murder a few weeks later.
System: The requirements for constructing a Houngan’s Doll are identical to those for the Baleful Doll. However, the Baleful Doll is an instant-use item — the creator fashions the doll, enacts the ritual, and inflicts what damage she can. The Houngan’s Doll, on the other hand, lasts until it is destroyed (which has no effect on the target). Once per week, the Anarch may cast the ritual, which begins when he lights a votive candle and sets it afloat in a cup containing one point of his vitae. If the ritual succeeds, then until the fire blows out (usually 30 minutes unless the ritual is disrupted somehow), any physical sensation imposed on the doll is sympathetically experienced by the target. For that duration, the sorcerer sees and hears only what the target does, so he must be careful to leave any tools or implements where they can be found by touch. The sorcerer is blind and deaf to his own surroundings while the ritual lasts.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Impregnable Soul"] = {
					en = [==[Rites of Blood, p. 104


4. Impregnable Soul


Level Four Necromancy Ritual. Believed to be stolen from a mortal mage by the name of Eochar, this ritual shields the user against possession by ghosts, infernal entities, or other spiritual powers. Rumors are that Eochar used this magic to protect himself and his students from the machinations of the dead. While this ritual is active, the necromancer’s body cannot be taken over, nor can his soul be pulled out of his flesh. Powers that command the mind (such as Dominate) are still effective. This ritual may be cast on others, but if done against their permission (such as to keep an enemy from activating Psychic Projection, Subsume the Spirit, or Possession), the ritualist must have a bit of the target’s hair, spend a Willpower, and make a successful Manipulation + Occult, while the subject rolls his Willpower in a resisted action (difficulty 7 for each). Once activated, Impregnable Soul remains until cancelled by the user, or until the next sunrise.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["4. Infirm Inert"] = {
					en = [==[Rites of Blood, p. 152


4. Infirm Inert


Amongst the vast arsenal of mystical powers of Kindred, perhaps the most important is the ability to leverage blood to heal wounds that would stagger or kill mortals. Kindred can quickly knit and heal their injuries from abrasions, lacerations, and even the loss of appendages. This ritual allows a thaumaturge to transmute a drop of her blood into a mystical poison that temporarily blocks her victim’s ability to use her vitae for healing. Before casting Infirm Inert, the thaumaturge must imbibe a small quantity of blood laced with laudanum and then meditate for twenty minutes. Finally, she must expel a drop of blood into the palm of her hand. The next Kindred the caster touches before dawn suffers the effects of the ritual.
System: Infirm Inert creates a skin-contact poison that may only be used once before it turns inert. If the poison is not used by the end of the evening, the power of the ritual fizzles and the poison is rendered useless. The thaumaturge must apply the mystical poison to her own skin (she is immune) and then touch her intended target. The Storyteller may require a roll to touch the victim, depending upon the circumstances.
Upon skin contact, Infirm Inert temporarily cancels the victim’s ability to heal, though she may not be aware of this until she actively attempts to use her blood to do so. Victims may spend a point of Willpower to ignore this effect for one turn. When this ritual expires, all wounds may be healed according to the type of damage suffered, as normal. Each success on the activation roll for the ritual adds an additional night of effectiveness for the poison. The effects of this mystical poison may be countered by the ritual Purity of the Flesh (V20, p. 232).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Innocence of the Child’s Heart"] = {
					en = [==[Rites of Blood, p. 152


4. Innocence of the Child’s Heart


It is difficult to be subtle when your fellow predators can sense your motivations. Innocence of the Child’s Heart masks the aura of the caster from the Auspex power of Aura Perception. Any who use that power on the caster will perceive a white aura, untainted by any signs of vampirism. This ritual requires a high price: the sacrifice of a mortal child.
System: Innocence of the Child’s Heart requires the ritualistic sacrifice of a mortal child and the harvesting of her heart. The thaumaturge must dip a beloved toy that once belonged to the child in the heart’s blood. The toy will quickly absorb all of the blood until it appears to be clean again. As long as the caster carries the toy, her aura will be pure white untainted by any signs of vampirism. The duration of the effect is one week, plus an additional week per success on the activation roll. This horrific ritual imposes an extreme cost on the caster’s Humanity.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Invisible Chains of Binding"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 308


4. Invisible Chains of Binding


This ritual allows the caster to create a supernatural force that holds a target immobile with invisible and intangible chains. The caster must make bold hand gestures, but no material component is required, and the caster may perform the ritual instantaneously. The target may try to move, but the chains require the target score two successes in one turn on a Strength (plus Potence, if any) roll (difficulty 8) to break. A number of targets equal to the caster’s Occult rating may be chained through the ritual.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Lord Aludian’s Orifices"] = {
					en = [==[Dark Ages Tome of Secrets, p. 37


4. Lord Aludian’s Orifices


This ignominiously named ritual is one of the strangest and most horrific among those practiced by the Abyss Mystics. Lord Aludian Thex, in his role as courtier and spy, often uses his body as a weapon; and as such, Clan Lasombra prizes him as a merciless killer and true Magister. Thex devised a way for the Abyss to exist in his body, allowing him to sacrifice anyone who breaches it. On the battlefield, the utility of this ritual is limited at best. In the bedchamber, Lord Aludian’s Orifices are deadly.
System: The Cainite must for an hour seclude herself in an Oubliette, or a subterranean cave on a night of the full moon. During this time, she must force vitae into each of her orifices, until they swell and blush with life, at a cost of two blood points. The vampire must then make a Stamina + Medicine roll (difficulty 6); a success results in the blood turning black and forming small gateways into the Abyss. Failure produces no effect, while a botch causes the vampire two levels of aggravated damage, which can be soaked with Fortitude. Any being who enters anything inside one of the orifices — while having sex, for instance — loses one blood point a turn. A reflexive Perception + Awareness roll will notice this, requiring five successes minus the blood lost (to a minimum of one). Attempting to extract the penetrative party causes one level of aggravated damage a turn for as long as the Abyss Mystic successfully grapples her prey. It is possible to utterly consume a victim this way, devouring his weakened body via an Abyss-linked orifice.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["4. Maw of Ahriman"] = {
					en = [==[Rites of Blood, p. 38


4. Maw of Ahriman


Level 4 Abyss Mysticism Ritual. Once a caster has invoked this ritual, her mouth becomes a portal to the Abyss. She may not speak or make sounds, and anyone looking into her mouth will see a deep chasm of blackness beyond instead of the workings of human physiology.
System: The caster may consume anything she can fit into her mouth, eradicating the item (or creature, or part of a creature) utterly by absorbing it into the Abyss. Biting an opponent deals aggravated damage as per a standard bite, but also removes one Willpower dot from the opponent’s total Willpower. Willpower lost in this manner may not be regained for one lunar month. The effects of this ritual last until the next sunrise, or the caster may end the ritual at any time.
Side Effect: The caster cannot speak or otherwise use her vocal cords, mouth, tongue, or fangs for the duration of this ritual’s effects.
Abyssal Rituals (p. 37): The following rituals do not adhere to the same rules as other forms of magic, in large part because they build on a Discipline that is not truly a form of sorcery. To learn Abyss Mysticism, a Cainite must have at least one dot in both Obtenebration and one dot in Occult. Such a character may not learn Abyss rituals rated higher than her Obtenebration or Occult score (whichever is lower). Casting Abyss rituals requires a successful Wits + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to succeed. Unlike normal rituals, each Abyss Mysticism ritual costs 3 times the ritual level in experience points to learn. All rituals of Abyss Mysticism also have permanent side effects; under no circumstances do Flaws obtained from these side effects reward the vampire with bonus or experience points, nor can they be bought off.]==],
				},
				["4. Mirror Walk"] = {
					en = [==[Rites of Blood, p. 152


4. Mirror Walk


Practitioners of Astral Projection understand that there are multiple layers to the universe. A Malkavian thaumaturge obsessed with mirrors is rumored to have created this ritual, allowing her to travel from place to place in the material world. Mirror Walk creates a sympathetic link between two mirrors, allowing the caster to travel between them as long as they are within a mile of each other.
System: The thaumaturge must create two identical mirrors of the appropriate size made with silver. She must soak both mirrors in two points of her own blood and chant over her creation for three nights to create a special resonance link between the two objects. Once completed, the thaumaturge may stand before either mirror and recite the mystical password to open a magical gate between the two mirrors. Such powerful magic cannot be done swiftly, as it requires three turns for the portal to open. The glass ripples and shimmers when ready, and then the caster may step through. She may take one passenger with her on this trip, but she must act swiftly, as the gateway closes after 2 turns. If the thaumaturge or her passenger is delayed, they may become trapped between locations and lost in another realm.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Non-Disclosure Clause"] = {
					en = [==[Rites of Blood, p. 69


4. Non-Disclosure Clause


Since their defection to the Anarchs, the Hacktivists have committed themselves to furthering the Movement in the manner that best fits their skills, principally in the spreading of information. In particular, the Hacktivist members of the mysterious Red Question faction (see Anarchs Unbound for more information) have spent considerable effort on spreading the philosophy of the Anarch Movement, to say nothing of specific tactical information that aids Anarchs struggling in Camarilla territories. This ritual allows them to do so without fear of exposure or betrayal.
The ritual enchants a text file, which is then encrypted and emailed to another person. When the recipient opens the emails, she receives an offer of secret information that may be of assistance in the spread of Anarch ideals. However, to acquire the information, the recipient must agree to the Non-Disclosure Clause by spreading some of her blood onto her thumb and placing it on a square that appears on her screen (similar to the Self-Executing File ritual). If she complies, the blood is absorbed into the computer, and the entire contents of the text file (which might be hundreds of pages of text) instantly download into her mind.
Only raw data can be conveyed in this way. The ritual cannot be used to help a Kindred learn a Discipline or a ritual, nor improve an Ability. However, the recipient does gain an eidetic recollection of the information that she downloaded. The “non-disclosure” aspect of the ritual comes into play if she is captured or interrogated by someone hostile to the Anarch Movement. The moment that she believes she is in danger of revealing Anarch secrets (regardless of her personal desire to betray the Movement or stay loyal), all of the downloaded information vanishes from her mind. Depending on the wishes of the sender, she may remember nothing of the information at all, she may remember a few details, or she may even remember copious amounts of disinformation that she honestly believes to be true.
System: One success is sufficient to prepare the information to be downloaded by the recipient. Three successes are needed to prepare backup misinformation that the recipient will believe to be true once she is captured and the failsafe is triggered.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Peek Past the Shroud"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 182


4. Peek Past the Shroud


This hour-long ritual enchants a handful of ergot fungi mold to act as a catalyst for second sight. By eating a pinch of the mold, a subject gains the benefits of Shroudsight (p. 163) for a number of hours equal to the necromancer’s Stamina score. Three doses of the enchanted ergot are created for every success on the roll. Ergot is normally poisonous to some degree; this ritual removes its toxic properties. However, a botch renders the ergot highly and instantaneously toxic, inflicting eight dice of lethal damage on any subject who ingests it — including vampires.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["4. Point of the Needle"] = {
					en = [==[Rites of Blood, p. 90


4. Point of the Needle


New Level Four Necromancy Ritual. This ritual was discovered by Voudoun Necromancers that were already adept at being able to create Baleful Dolls (V20, p. 181). By taking a needle that has been previously stabbed into a Baleful Doll, the Necromancer immerses the needle completely in blood under the light of the moon for a whole night. Upon successful completion of the ritual, the blood turns to ash and the needle develops a red tint.
System: Until the next sunrise, the Necromancer may perform a single use of “Withering” upon a target (V20, p. 472), using the same systems as outlined for the original power, but with a prick from the needle replacing a touch attack.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["4. Preservation of the Sanguine Heart"] = {
					en = [==[Rites of Blood, p. 27


4. Preservation of the Sanguine Heart


Loyalty is an exceptionally rare commodity, and perhaps that is why so many are willing to rob others of their free will to secure it. Blood bonds are one of the oldest means of control and ensuring loyalty by the elders in vampire society. The Anarchs now utilize many of the same tactics that were once the tools of their oppression. The Sabbat have embraced what once terrified them in their own communal Vaulderie. Agents of the Camarilla often must disguise their allegiances while working undercover for the Ivory Tower in Anarch or Sabbat territory where proving loyalty is often as simple as sharing blood.
Clan Tremere developed this ritual to protect Archons and Sheriffs from blood bonds and the Vaulderie, even if only temporarily.
System: The thaumaturge must anoint the forehead of the target with a point of the caster’s vitae and then pass to her a prepared chalice with a drop of mercury. She must drink the metal and suffer one aggravated wound to her internal organs as the mercury covers her insides with a mystical barrier. Afterward, the target is magically protected against being blood bound or the effects of the Vaulderie (including getting the Mark of the Betrayer for some Tremere antitribu) for one day per success achieved on the activation roll. This protection comes at a steep price. In addition to the aggravated wound, the target may not receive sustenance from blood without the target willingly canceling the ritual.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Rebirth in the Light of Haqim"] = {
					en = [==[Dark Ages Tome of Secrets, p. 43


4. Rebirth in the Light of Haqim


Each Assamite is initiated to the clan after Embrace with blood from the collective pool. Her head is anointed with the blood and her true purpose calls to her. It is only at this point that she is fully welcomed as a warrior, sorcerer, or vizier, as the blood of the entire clan decides her fate. Many consider this to be the will of Haqim.
This rebirth breaks any existing blood bonds. It can also effectively change the character’s Clan Disciplines; any Disciplines that become out-of-clan accrue an “experience debt” that must be paid off with incoming experience points. Newly in-clan Disciplines are purchased at in-clan costs.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Reflections of Hollow Revelation"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 273


4. Reflections of Hollow Revelation


A character with this ability stares through the darkness of the Abyss to view distant objects, places, or people.
System: The caster summons a Nocturne (see p. 228) and bends its shape to her will, forcing it to contract into a sphere that can be held in both hands. To attempt this, the caster rolls Perception + Occult, difficulty 7. A botch leaves the character drained by the attempt – she rolls two less dice on all rolls for the remainder of the scene. On a failure, the Nocturne expands and acts as it normally would. On a success, the Nocturne becomes a fixed window upon any object, place, or person that the caster has previously personally witnessed. This window remains open for the remainder of the scene, or until the target leaves the vicinity of the window. Maintaining the window requires concentration, however; the caster loses two dice from Alertness dice pools as long as the window is active.
Any character with Obtenebration or with abilities that supernaturally augment senses, such as Auspex, may roll Perception + Occult (difficulty 8) to detect the watchful gaze of the shadows around them.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["4. Return of the Heart"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 310


4. Return of the Heart


Assamite Ritual. Cainites targeted by this ritual have the portion of their soul that has been slowly dying returned to them. Invoking this power requires a quantity of the target’s blood and takes five minutes to cast. If successful, the target becomes temporarily governed by the Hierarchy of Sins for the Road of Humanity as if she had a Road rating of 9, forcing the Cainite to perform Degeneration tests and be overwhelmed with guilt for the most minor of deeds. This does not actually impart a Road of Humanity rating of 9 to the target; the subject still has the Road rating that she normally would have, but is no longer inured to the cruelties of the world. This power lasts for one hour per success on the ritual roll.
Clan rituals (p. 302): Clan rituals are jealously guarded secrets that are never shared with those not belonging to the clan or bloodline harboring its mysteries.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["4. Ritual of Xipe Totec"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 182


4. Ritual of Xipe Totec


To perform the ritual, the Kindred removes his victim’s top layer of skin with an obsidian dagger, taking care to damage the skin as little as possible in the process. The victim must survive this process (though she may well die of blood loss shortly after the ritual if not seen to properly). He then drains the victim’s blood into a large ceremonial golden bowl. There the blood is mixed with octli, amaranth flower, and other ingredients. When imbibed by the necromancer, this mixture causes him to sweat a glistening sheen of blood (equal to one blood point). The Kindred then dons the skin of his victim, which on a successful roll absorbs the Kindred vitae and begins to heal, forming a second skin over the vampire’s own. The victim needs to be of similar stature — otherwise, the features become distorted and the disguise is rendered useless. This power also has no effect on supernatural creatures (although it can affect ghouls).
Under normal visual scrutiny, the ruse is flawless. Of course, it imparts none of the victim’s knowledge or mannerisms (and does nothing to mask the Kindred’s own undead nature). Therefore, it works best for situations in which contact with friends and family may be minimized. To preserve the skin’s condition, the Kindred must bathe it in a blood point’s worth of vitae nightly. When the necromancer removes the skin (which causes one level of unsoakable lethal damage to the user and must be done with the same knife used to flay the victim in the first place), it is ruined in the process.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["4. Scry"] = {
					en = [==[Rites of Blood, p. 153


4. Scry


Scrying is the practice of remote viewing via a reflective, translucent substance such as water. The thaumaturge must craft a wide silver bowl and then fill it with purified spring water mixed with a drop of owl’s blood. Next, she must concentrate upon her intended target and gaze into the bowl. If successful, the caster can see and hear what is happening around the target as though she were personally there.
System: Once the bowl and water is prepared according to the specifications, the thaumaturge must concentrate for a minute before attempting to scry her target. This ritual lasts for a number of hours equal to the successes for the activation roll. The thaumaturge only has to concentrate during this duration to view scenes through the water. If a location is the center of the Scry, this location cannot be changed throughout the duration of the ritual. The caster cannot use Auspex powers, Thaumaturgy, or similar mental Disciplines through the Scry.
If the caster is attempting to scry an item or place, she must be familiar enough with it to have formed a psychic attachment with it. If the caster intends to scry upon a person, she might have in her possession an object with a psychic resonance with the target (p. 133).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Scrying Pool"] = {
					en = [==[Dark Ages Tome of Secrets, p. 51


4. Scrying Pool


Level Four Rite — The Black Sea Kraina — Attribute: Intelligence
Scrying Pool allows the koldun to utter the name of anyone she knows and see their current activities displayed in a body of water, in place of her own reflection. The target’s location may not be obvious, and sound isn’t transferred, but the view — which is a reflection of the target’s face and surrounding background — provides useful clues.
System: By stating the name of someone she knows, the koldun can immediately see what that individual is doing by peering into water. The ability to activate the rite’s powers is only terminated if the subject of a scrying is informed someone is spying upon them. This accusation can be unrelated to the koldun.
Learning and practicing kraina (p. 48): All kraina rites must be taught by a Cainite, spirit mentor, or demon. The vampire learning rites requires the same level in Koldunism, and the affiliated kraina. To learn kraina rites, the player must roll Intelligence + Occult (the difficulty is the rite’s level + 4), and sacrifice the blood and Willpower points stated below. Kraina rites must be practiced in a location predominantly possessed of the rite’s focus, such as a forest or river; these locations cannot be left once the rite has commenced, and if the rite is interrupted, the extended roll requirements reset. Practicing kraina rites requires the rite leader to roll dice equal to her Occult rating and the Attribute designated by the rite. The difficulty is the rite’s level + 4, with each murder committed at the ritual site reducing the difficulty by 1 to a minimum difficulty of 3. Each additional Cainite partaking in the ritual contributes dice equal to his Occult rating, and is subject to the rite’s blood and Willpower sacrifice requirements. Removing two dice from the pool reduces the number of successes required by one, to a minimum of one; these dice remain out of the pool for future rolls on the extended task. Each time a roll of dice is made by the rite leader, each participant loses one blood point in addition to the number committed to the rite’s practice. If the rite is aborted or failed, the initial blood and Willpower cost is deducted in full from the rite leader on top of anything already lost.
Level 1 — cost to learn 1b + 1W — cost to practice 3b + 2W — 5 successes required
Level 2 — cost to learn 2b + 2W — cost to practice 6b + 4W — 10 successes required
Level 3 — cost to learn 3b + 3W — cost to practice 9b + 6W — 15 successes required
Level 4 — cost to learn 4b + 4W — cost to practice 12b + 8W — 20 successes required
Level 5 — cost to learn 5b + 5W — cost to practice 15b + 10W — 25 successes required
b = Blood points. W = Willpower points]==],
				},
				["4. Splinter Servant"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 238


4. Splinter Servant


Another ritual designed to enchant a stake, Splinter Servant is a progressive development of Shaft of Belated Quiescence. (The two rituals, however, are mutually exclusive.) A Splinter Servant consists of a stake carved from a tree which has nourished itself on the dead. The stake must be bound in wax-sealed nightshade twine. When the binding is torn off, the Splinter Servant leaps to life, animating itself and attacking whomever the wielder commands — or the wielder, if she is too slow in assigning a target. The servant splits itself into a roughly humanoid form and begins singlemindedly trying to impale the target’s heart. Its exertions tear it apart within a few minutes, but if it pierces its victim’s heart before it destroys itself, it is remarkably difficult to remove, as pieces tend to remain behind if the main portion is yanked out.
System: The ritual requires 12 hours to cast, minus one per success, and the servant must be created as described above. When the binding is torn off, the character who holds it must point the servant at its target and verbally command it to attack during the same turn. If this command is not given, the servant attacks the closest living or unliving being, usually the unfortunate individual who currently carries it.
A Splinter Servant always aims for the heart. It has an attack dice pool of the caster’s Wits + Occult, a damage dice pool of the caster’s Thaumaturgy rating, and a maximum movement rate of 30 yards or meters per turn. Note that these values are those of the caster who created the servant, not the individual who activates it. A Splinter Servant cannot fly, but can leap its full movement rating every turn. Every action it takes is to attack or move toward its target; it cannot dodge or split its dice pool to perform multiple attacks. The servant makes normal stake attacks that aim for the heart (difficulty 9), and its success is judged as per the rules for a normal staking (see p. 280). A Splinter Servant has three health levels, and attacks directed against it are made at +3 difficulty due to its small size and erratic movement patterns.
A Splinter Servant has an effective life of five combat turns per success rolled in its creation. If it has not impaled its victim by the last turn of its life, the servant collapses into a pile of ordinary, inanimate splinters. Three successes on a Dexterity roll (difficulty 8) are required to remove a Splinter Servant from a victim’s heart without leaving behind shards of the stake.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Stolen Kisses"] = {
					en = [==[Rites of Blood, p. 153


4. Stolen Kisses


Thaumaturges cast this ritual when they do not wish to feed by mouth. Instead, Stolen Kisses allows them to drain small portions of vitae through other parts of a vessel’s body. Some vampires prefer the strong handshake in a crowded room. Sadists enjoy choking vessels, providing a double pleasure of asphyxiation and the flush of new vitae coursing through cold veins. Others seek to relive mortal experiences by draining blood from a vessel during sex. Victims from this ritual are not immediately aware that blood is drained from their bodies, but will experience a slight sensation of dizziness and light-headedness. This ritual requires the caster to carry a “witch’s kiss” — a thistle steeped in the blood of a vampire — somewhere on his person
System: The thaumaturge must first make a small incision on his body where she intends to make physical contact with a vessel. Once the ritual is cast, the wound knits itself closed and then opens to create a lip-and-mouth mystical orifice that when pressed against a vessel’s flesh will drink one blood point every other turn from the victim as long as contact persists. After the second point of vitae is consumed, a vessel is likely to feel woozy, while taking five blood points can cause the victim to black out from the substantial lack of blood in her body. Stolen Kisses remains active for one night. Note that the thaumaturge does not cause ecstasy or rapture when taking blood in this manner, as he would if he fed on a vessel normally.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Summon Ethereal Horde"] = {
					en = [==[Rites of Blood, p. 89


4. Summon Ethereal Horde


New Level Four Necromancy Ritual. Based upon accounts of the Telyavelic Tremere’s ability to summon temporary hordes of ghostly combatants, the Giovanni have been able to partially replicate the power previously known as the “Army of Souls.” The Necromancer chants a prayer to the dead while standing in the center of a circle made from the ground-up remains of a cremated corpse, the coffin in which it was buried, and the headstone of the deceased’s grave.
System: At the end of the chant, if the ritual is successful, the number of successes rolled determines how many drones (mindless ghosts, rather than full-blown wraiths) the Necromancer can summon. These ghosts appear as ethereal images of warriors long dead. Although they can not materialize fully in the physical world, they can use their own powers to hurl objects or frighten away attackers, in defense of the Necromancer. The ghosts return to their rest at the next sunrise.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["4. Summon the Blood Imp"] = {
					en = [==[Rites of Blood, p. 27


4. Summon the Blood Imp


Mastery of blood magic requires dedication and time away from the politics and socialization of vampire society. Trust is a rare commodity, especially to a fellow vampire and predator, and certain tasks require a certain delicate touch. This creature was created by a Tremere elder to serve as a clever thief and saboteur. He discovered in his experiments on some Tzimisce subjects that there was a very minute trace of the mutability inherent in vitae, and in that moment received the inspiration for the creation of the blood imp.
The thaumaturge must stitch together the form of the blood imp from the dead parts of animals, inanimate objects, and even human cadavers. This is a personal, individualized process, and rarely will two blood imps look exactly the same even if made by the same caster. (The flesh of a former supernatural creature doesn’t work, and attempts to use it with this ritual will automatically fail.)
Once the blood imp has been given the spark of life, it forms its own personality based on that of its creator. The blood imp was created to love the thaumaturge, and will go out of its way to do things that it believes will make her happy. A cruel caster will find that her blood imp delights in tormenting lesser creatures to make its master laugh, while a solemn thaumaturge will find a quiet, thoughtful servant that works subtly and efficiently.
Homunculi are created to be useful and devoted laboratory assistants and so gain their creators’ knowledge of Thaumaturgy. Blood imps, however, are made for mayhem.
System: Summon the Blood Imp requires that the thaumaturge stitch together fresh (within three days) corpses of animals and humans into a frightening humanoid creation. The blood imp has an animal cunning and empathic link to its master that allows it to innately understand the needs and desires of its master. Next, the caster must add six points of Tremere blood into the mix and allow it to simmer over the course of three nights.
Such devoted service is not without a cost. The blood imp requires a certain amount of attention lest it turn spiteful. Nothing is more frustrating than an angry blood imp disrupting important rituals or breaking priceless artifacts in a temper tantrum. Blood imps must be fed regularly with vitae and flesh.
A blood imp can fight, but not with tremendous effectiveness; it will nevertheless destroy itself if necessary to protect its creator. It can also push or carry small objects, and makes an effective spy (though it detests being away from its master for long periods of time). Blood imps are damaged by sunlight and fire like Kindred, and can also be destroyed utterly by immersion in sanctified water.
More information on the capabilities of a blood imp can be found on p. 108.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. The Curse Belated"] = {
					en = [==[Rites of Blood, p. 151


4. The Curse Belated


The training of a ghoul to serve the needs of a thaumaturge can take years. Some use this process to weed out undesirables and test potential Embrace candidates. The amount of effort involved inspired the creation of the ritual known as the Curse Belated. By performing this ritual on a ghoul, the caster invests a portion of her power so that, should the unthinkable happen, her thrall shall be resurrected as a vampire.
This ritual was originally used by the sorcerers of the Assamites and the Followers of Set. Clan Tremere has an organized system of schooling their apprentices, and while most are forever regulated to the position of research assistant, some were important enough that elders sought out and converted this ritual to preserve those that they put so much time into.
System: The thaumaturge must first prepare a brand with her sigil. She must feed her ghoul a point of blood while chanting the incantation, and then seal the covenant by branding her sigil onto the body of her thrall. The thaumaturge loses access to one permanent point from her blood pool until this ritual is triggered. The moment that the ghoul’s heart stops beating, the stored vitae inside her body activates and resurrects her as a full-fledged vampire. Once “Embraced,” the sigil disappears and the empty spot in the caster’s blood pool unlocks, allowing her to once again spend that blood point. The caster is immediately aware that the ritual has been triggered and that her former ghoul is now dead and might be her new childer. (Though she can sense the ritual’s activation, the thaumaturge may have no way to know whether the former ghoul managed to survive the process.)
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Ties That Bind"] = {
					en = [==[Rites of Blood, p. 158


4. Ties That Bind


The koldun must spill four points of her own blood onto a patch of earth that she has claimed. Then, she must ritually devour a handful of the blood-soaked soil. Doing so reconnects her with the spirit of the land and facilitates the workings of koldunism. This is often used by kolduns outside of Eastern Europe to offset the distant connections to their homeland.
System: For one night per success, the koldun reduces the difficulty for all rolls pertaining to Koldunic Sorcery by -1. This ritual cannot be performed more than once per week.
Koldunic Sorcery dice mechanics (p. 156): the roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.]==],
				},
				["4. Track Transgressor"] = {
					en = [==[Rites of Blood, p. 152


4. Track Transgressor


Transgressor is the term for outsider thaumaturges or rogue Tremere that use blood magic to attack the Ivory Tower. Track Transgressor was designed to track these enemies of the Camarilla. Clan Tremere vigilantly hunts these enemies to protect the Camarilla from mystical assaults (or so it claims). Skeptics whisper that the Warlocks simply don’t like the competition.
System: To cast the ritual, the thaumaturge must locate a site where Thaumaturgy has been cast within the past twenty-four hours. She must then spill her blood (spending a blood point) upon the ground while reciting the proper incantation. Bloody footprints that are only visible to the caster appear on the ground and lead away to the transgressor. After casting this ritual, the Tremere is able to flawlessly track down the transgressor until dawn. This tracking follows the exact path that the magus took after leaving the area where the magic was used. This ritual may track down only Thaumaturgy and related rituals, not Necromancy or other types of magic.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Transcending Barriers Through Love"] = {
					en = [==[Rites of Blood, p. 64


4. Transcending Barriers Through Love


Having transformed common mortals into loyal cultists with his magic, the New Age sorcerer can feed on their devotion and their vitae alike from afar. If the ritual is successful, the sorcerer can recover vitae and even Willpower from one or more of his followers who are currently under the effects of Enfolding the Believers. The ritual requires thirty minutes of meditation on the names and faces of the targeted followers.
System: For each success rolled, the sorcerer may cause one of his followers who is a valid target for this ritual to lose two points of blood, with the sorcerer regaining one point of blood for every two points lost. Alternatively, for every three successes rolled, the sorcerer may cause a valid target to lose two points of Willpower, with the sorcerer recovering one Willpower for every two lost. There is a downside to this latter application, as it immediately causes anyone who loses Willpower in this manner to be freed of the effects of Enfolding the Believers and, worse, free of the effects of the blood bond itself. The ritual can target multiple cultists, but cannot target a single cultist more than once per use. Once a sorcerer has used this ritual, he may not use it again until he has successfully cast Enfolding the Believers on his cult again or until one week has passed, whichever is longer.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Unweave Ritual"] = {
					en = [==[Rites of Blood, p. 154


4. Unweave Ritual


Thaumaturges have long used their powers to inflict harm upon those that have offended them or compete against their interests. Often, it is a rival thaumaturge that is the most dangerous and willing to strike out against a blood magician. Unweave Ritual allows a thaumaturge to identify the enemy ritual under which she labors and then create a countering blood magic ritual to unweave it. Thaumaturges skilled in this magic learn general principles to confound other rituals, shrug off their effects, or collapse them prematurely.
System: First, the caster must figure out what ritual currently afflicts her. If she possesses the ritual, this is automatic. Otherwise, this may require some research via an Intelligence + Occult roll with a difficulty base of 4, plus 1 for every level rating of the ritual. Next, the caster must secure a component that would be used in the casting of the offending ritual, then destroy it in some fashion. Her successes subtract from the successes scored by the original caster; if she manages to wipe away all of the successes, the offending ritual immediately ends, with all concomitant effects. Thus, a quick end to Bind the Accusing Tongue (V20, p. 230) would allow the victim to speak ill of her enemies again, but a premature end to a Blood Contract (V20, p. 239) would painfully shove her into torpor.
Only rituals that have a duration can be unwoven. For instance, a thaumaturge who has thrown off a blood bond through Abandon the Fetters (below) is not constantly under the effects of that ritual. Once the ritual is complete, the bond is gone and the ritual is done. However, a thaumaturge suffering from The Bottled Voice (p. 150) would be considered to be under the duration of the ritual as long as the crystal bottle remained sealed, so it could be unwoven. Note that a thaumaturge can only unweave a ritual on herself, not one on someone else. A thaumaturge suffering from multiple rituals must unweave each one separately. Multiple unweavings can be accumulated against a ritual so long as the appropriate time and components can be acquired.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Vigil of the Stone Guardian"] = {
					en = [==[Rites of Blood, p. 29


4. Vigil of the Stone Guardian


Clan Tremere has long utilized mystical servants to protect their havens and laboratories. Vigil of the Stone Guardian allows the thaumaturge to create a mystical sentry to protect a door or gate, in the form of a stone gargoyle door-knocker.
The stone guardian watches over the entry and mystically alerts its master when there is a visitor or trespasser. The thaumaturge may remotely possess the guardian by expending a point of blood. She can observe what is happening through the guardian’s eye and speak through its horrific stone face. This ritual does not technically violate the Tremere oath against the creation of new Gargoyles, but some quietly feel that it skirts the spirit of said promise, or at least insults the Clans the Tremere once hunted.
System: To create a Stone Guardian, the thaumaturge must find or create an appropriate door-knocker (with both eyes and a mouth) and then soak it in her blood over the course of three nights. She must then hang it upon the door or gate that will become the new home for the guardian and enact the ritual. If successful, the stone guardian bonds with the door or gate and cannot be removed without being destroyed.
The thaumaturge may remotely possess the guardian by expending a point of blood. Once it is possessed, the caster can observe what is happening through the guardian’s eye and speak through its mouth. By expending a point of Willpower, the thaumaturge may attempt (if she possesses the ability) to utilize the first two levels of Dominate, Presence, or Dementation to chase away intruders. The stone guardian may not physically attack or block entry to trespassers otherwise, but it can open the door or gate upon command from the thaumaturge.
Such protection comes at a cost to the thaumaturge. The Stone Guardian requires a point of blood per night to continue its vigilance. If the stone guardian is not fed, it will sleep until reactivated by the thaumaturge with a point of blood.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Vision of Shadow"] = {
					en = [==[Lore of the Clans, p. 126


4. Vision of Shadow


There are shadows everywhere, and with this power, the mystic can use them to observe her enemies without their notice. Using the Obtenebration power, the Cainite calls up a ball of shadows and uses it like a crystal ball to see what her enemies are up to several miles away.
System: The vampire makes a casting roll to call up a ball of shadow that she will use to scry on a target. If the caster fails the roll, nothing happens, but a botch leaves her confused and disoriented, suffering –2 to all dice pools for the rest of the scene.
The Cainite then concentrates on a person or location she has previously seen. As she does so, the shadow ball will become clear to reveal a vision of that place or person at that very moment, complete with sound. There must be shadows near the target, and the vision will come from the most optimal position in these shadows. The vision can be anywhere within a radius of the caster’s Obtenebration + Occult in miles, or 1.5 times that number in kilometers.
The vision lasts for a scene, or until the target leaves the area. If the target has the ability to sense such scrying (such as with Auspex or a similar power), he can attempt a Perception + Occult roll (difficulty 8) to know he is being watched.
Side Effect: Looking too far into the distance makes the Cainite less aware of what is happening right under her nose. For the rest of the night after successfully casting this ritual, she suffers -2 to all Alertness checks to notice nearby events.
Abyss Mysticism (p. 125): Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level. Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.]==],
				},
				["4. Vision of St. Anthony"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 294


4. Vision of St. Anthony


With this ritual, the necromancer can grant others Shroudsight (as described on p. 288) for a number of hours equal to her Stamina score. She enchants a handful of wheat infected with ergot (a common type of toxic fungus) with an hour-long ritual. For every success on her ritual roll, she creates three doses. The enchantment removes any toxicity from the ergot, but if she botches, she creates three doses of highly-toxic wheat that will inflict eight dice of lethal damage on anyone who ingests it, mortal and vampire alike.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["4. Ward versus Kindred"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 239


4. Ward versus Kindred


This warding ritual functions exactly as do Ward versus Ghouls and Ward versus Lupines, but it inflicts injury upon Cainites.
System: Ward versus Kindred behaves exactly as does Ward versus Ghouls, but it affects vampires rather than ghouls. The ritual requires a blood point of the caster’s own blood and does not affect the caster.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Ward versus Vitae"] = {
					en = [==[Rites of Blood, p. 158


4. Ward versus Vitae


This peculiar ward is inferior to most wards used by the Tremere, but it is often sufficient for the needs of Anarchs. The sorcerer must make a sigil out of her own vitae on some object or surface. If a vampire of lower Generation touches the object or surface, he is affected. Kindred of equal or higher Generation are not affected.
System: Kindred below the caster’s Generation who touch the ward suffer two dice of lethal damage each time they do so. After the first touch, however, a Kindred who wishes to proceed again must roll Willpower (difficulty 7) or spend a Willpower point. Each use of this ritual costs one point of blood and can only ward one discrete object: a single window, a door, a book, or one door of an automobile. Larger objects can be warded but only if the ritual is cast multiple times.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["4. Warding Circle versus Kindred"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


4. Warding Circle versus Kindred


The Tremere have access to several other Warding Circle rituals: Warding Circle versus Lupines (Level Three), Warding Circle versus Kindred (Level Four), and Warding Circles versus Spirits, Ghosts, and Demons (Level Five). Each Warding Circle ritual must be learned separately. The material components required for each warding circle are the same as those needed for the corresponding ward, but in larger amounts. The effects against the targeted beings are the same as for Warding Circle versus Ghouls.
System: As Warding Circle versus Ghouls (p. 234), but the circle affects vampires. The ritual requires the same material component as Ward versus Kindred — the caster’s own blood — but in a larger amount, and it does not affect the caster. The caster determines the size of the warding circle when it is cast; the default radius is 10 feet/3 meters, and every 10-foot/3-meter increase raises the difficulty by one, to a maximum of 9. The ritual takes the normal casting time if it is to be short-term (lasting for the rest of the night) or one night if it is to be long-term (lasting a year and a day).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Abandon the Fetters"] = {
					en = [==[Rites of Blood, p. 154


5. Abandon the Fetters


Created by Clan Tremere during the Anarch Revolt, Abandon the Fetters shatters the blood bond between master and thrall through a grueling, excruciating process that lasts an entire night. The thaumaturge forms a bond to the thrall and master by mixing a concoction made from blood from all three of them and placing it in a glass container. Next, the caster must exsanguinate and excoriate the thrall. The exact method is determined by the ritualist’s individual style: some prefer mortification with a whip, while others might apply brands. Once the subject is almost dead, the caster shatters the glass container, spilling the blood to the ground and snapping the thread of the bond. The mixture of blood evaporates in a hissing, scalding steam, and the subject is freed.
Some princes forbid the practice of this ritual in their domains, believing that it could be a threat to the Second Tradition for a thaumaturge to undo one of their punishments.
System: The thaumaturge must have one point of blood each from himself, the thrall, and the subject’s master. (If the caster happens to be the subject or regnant, no additional blood is needed.) The excoriation causes three levels of unsoakable aggravated damage to the subject as flesh is flayed or burned away. The final venomous steam inflicts an additional level of unsoakable aggravated damage on both the caster and the subject. The subject loses a permanent point of Willpower, but if the ritual succeeds, the blood bond dissipates immediately. However, this offers no protection against the formation of another, later bond. Abandon the Fetters may not be used to break the vinculum of a Vaulderie or the effects of the Transubstantiation of Seven ritual (p. 151).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Ahriman’s Wight"] = {
					en = [==[Rites of Blood, p. 38


5. Ahriman’s Wight


Level 5 Abyss Mysticism Ritual. By drawing on the Abyss in time of need, a caster may allow the sentience within the darkness to move through their very spirit and reinforce his flesh.
System: After casting this ritual, the character gains a number of additional “Shadow” wound levels at the “Wounded” health level, equal to his dots in Obtenebration. However, if the character takes an injury that crosses off one of these Shadow health levels, he loses a commensurate number of dots of Obtenebration as well. Dots of Obtenebration lost in this way return after one week.
Side Effect: While this ritual is in effect, all failed rolls using the caster’s Conscience/Conviction are considered to be botches.
Abyssal Rituals (p. 37): The following rituals do not adhere to the same rules as other forms of magic, in large part because they build on a Discipline that is not truly a form of sorcery. To learn Abyss Mysticism, a Cainite must have at least one dot in both Obtenebration and one dot in Occult. Such a character may not learn Abyss rituals rated higher than her Obtenebration or Occult score (whichever is lower). Casting Abyss rituals requires a successful Wits + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to succeed. Unlike normal rituals, each Abyss Mysticism ritual costs 3 times the ritual level in experience points to learn. All rituals of Abyss Mysticism also have permanent side effects; under no circumstances do Flaws obtained from these side effects reward the vampire with bonus or experience points, nor can they be bought off.]==],
				},
				["5. Asymmetrical Reproduction"] = {
					en = [==[Rites of Blood, p. 109


5. Asymmetrical Reproduction


Created by the Tremere alchemist David Witz, clones were an attempt to grasp the secret of eternal life without the burden of vampirism. Using computers to map key points of individual personalities and combining this research with biothaumaturgy, Witz has created “clones,” alchemical homunculi programmed with simulations of individuality. By using the discipline of Dominate, he can even give these clones limited memory of the individual they are to replace. The argument exists that these clones are too close to a violation of the Montmartre Pact, and thus the ritual to create them has been taught to only a few.
Each clone is the precise replication of a mortal, ghoul, or vampiric individual. The clone is created on a template of DNA and psychic impressions taken from that individual through study and the use of stolen genetic material. This clone is perfect, and emotionally pliable for a time — but over the course of a few days to weeks, subtle imperfections begin to creep into the programming, eventually driving the clone insane. If the clone is not destroyed by this time, it will go murderously rogue, attempting to eradicate its original (the individual whom it is a copy of) and destroy its creator.
System: This ritual takes three nights to complete, and the caster must possess some amount of the target’s genetic material (such as skin cells or a hair), which is destroyed in the casting. The clone created by this ritual is a perfect, but living, duplicate of its target in every way, including all appropriate Merits, Disciplines, and personality traits, but only possesses the most rudimentary memories of the individual it is replicating. Over the course of the next seven days, the clone’s psychology becomes more and more psychotic, and its Disciplines or other powers (as appropriate) become wildly unstable, until it becomes almost entirely unrecognizable from their original state. If allowed to survive, at some point after the seventh night, the clone will go on a violent murder spree — ending only in its death, preferably after the death of the individual it was created to replicate.
Although the clone is a living creature (and must eat, sleep, and breathe), if it is a replication of a vampire, it appears to be a vampire to all ordinary and supernatural means of detection.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. At Our Command It Breathes"] = {
					en = [==[Rites of Blood, p. 106


5. At Our Command It Breathes


The Tremere ceased making Gargoyles after the Slaves revolt, and, as part of the Camarilla negotiations, promise never to revive the technique. This horrific ritual creates a Gargoyle from the dismembered parts of slain Cainites, and is the process through which the first of that line came into being.
To enact this ritual, the caster must prepare at least two other vampires (of the Nosferatu, Tzimisce, or Gangrel Clans) for at least a full turn of the moon, feeding them a very small amount of cursed and defiled blood, and starving them to within an inch of wassail. These individuals are tortured nightly, and various humiliations and physical horrors inflicted upon them, to break their sanity and weaken their bodies.
After the subjects are prepared, they are staked, and brought into a prepared room where this ritual is begun. Over the next few nights, the victims’ limbs are cut from their bodies (the ritual prevents the parts from falling to dust). The ritualist sews the two (or more) vampiric corpses together into a single vaguely-humanoid shape, and then wraps the resultant form (and all extra parts) within the stretched womb of a deer or horse. The bodies must remain undisturbed in this sac for a period of three months, while the thaumaturge periodically visits and performs various incantations. If the thaumaturge misses even a night of these incantations, the ritual is increasingly likely to fail — if it does, the fetal Gargoyle dies, and the creature cannot be revived. If the thaumaturge is successful, at the end of the three months a newborn Gargoyle will force its way out of the thick sac of flesh.
System: The blood cost of this ritual is 5 points for each Cainite used in the Gargoyle’s manufacture. After three months of casting, on the final night of the ritual, the thaumaturge must make a roll as the fetal sac is cut open. The roll is Intelligence + Occult (difficulty 9, but the roll requires three successes). Subtract one die for every night the thaumaturge did not perform her incantations. A single success allows the creation of a Gargoyle (if this is a player character, it must be built according to the standard character creation rules). Attempted use of this ritual, whether successful or not, removes a single point of morality from the user’s morality total. No matter what path a character espouses, this ritual (and the activities required to perform it) is deeply and utterly abhorrent. Gargoyles created with this ritual are infertile, and cannot Embrace.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Beckon the Ingurgitant"] = {
					en = [==[Dark Ages Tome of Secrets, p. 37


5. Beckon the Ingurgitant


Abyss Mystics know the horror of the Ingurgitant Vortex, and some believe it a grand idea to launch these dreaded beasts on their enemies. Ingurgitant vortices are difficult to coax away from the Abyss, so when a Mystic makes the attempt, she tends to aim the sucking hole at a rival Cainite’s haven, sleeping quarters, or even a throne if she’s intent on humiliation. Ingurgitant vortices have appeared in domains throughout the Sea of Shadows due to this ritual. Lasombra outside the Mystics find the practice of summoning these creatures abhorrent, and just cause for the elimination of Mystics operating outside the clan hierarchy.
System: The vampire must paint a spiral of vitae on the target area, spending two blood points per meter (1 yard) in intended vortex dimensions. The blood then soaks into whatever surface it’s painted on, leaving no stain. The Cainite must then chant and pray to the Abyss for an hour, within sight of the target area, spending two temporary points of Willpower. Finally, she must roll Manipulation + Occult (difficulty 6), with each success allowing the ingurgitant vortex to remain for two turns. Failure results in nothing happening; a botch prevents the Abyss Mystic from summoning any entities of the Abyss for seven nights. When any creature stands in close proximity to the painted sigil, the Abyss Mystic senses its presence and whether it’s a mortal or vampire. By spending a blood point, the vampire forces the ingurgitant vortex to form in the surface and attack whatever’s close by, strangling and chewing any victims, before dragging them to the Abyss. Those taken to the Abyss remain there for a number of nights equal to the Abyss Mystic’s Obtenebration rating, where they suffer the effects listed under Evocation of the Oubliette (see V20 Dark Ages p. 274). The vortex’s statistics are stated on p. 34.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["5. Blood Contract"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 239


5. Blood Contract


This ritual creates an unbreakable agreement between the two parties who sign it. The contract must be written in the caster’s blood and signed in the blood of whoever applies their name to the document. This ritual takes three nights to enact fully, after which both parties are compelled to fulfill the terms of the contract.
System: This ritual is best handled by the Storyteller, who may bring those who sign the blood contract into compliance by whatever means necessary (it is not unknown for demons to materialize and enforce adherence to certain blood contracts). The only way to terminate the ritual is to complete the terms of the contract or to burn the document itself — attempts to add a clause forbidding burning the contract have resulted in the contract spontaneously combusting upon completion of the ritual. One blood point is consumed in the creation of the document, and an additional blood point is consumed by those who sign it.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Bloody Mary"] = {
					en = [==[Rites of Blood, p. 67


5. Bloody Mary


One of the darkest rituals in the annals of Punk Sorcery, Bloody Mary summons that malefic urban spirit and allows her to possess a mortal vessel in exchange for a period of service to the summoner. The ritual must be performed in a public bathroom, and the mortal vessel must be persuaded of his own free will to participate in the ritual. He need not know what the ritual’s ultimate effect will be, and few mortals would participate if they did, but he cannot be Dominated or otherwise compelled to take part. Trickery is perfectly fine, however, and many of those who use this ritual will manipulate mortals through means as simple as telling them about the urban legend and then daring them to risk summoning the legendary figure.
Once persuaded, the mortal must look into the mirror and say “Bloody Mary” three times, while the sorcerer flips the lights on and off in a particular pattern and quietly mouths an incantation that offers the mortal’s soul to the spirit in exchange for service. The sorcerer will know the ritual has succeeded when, at one point when the lights are on, the mirror will show the mortal’s reflection as well as that of the hideous crone looming behind him ready to pounce. Then, the vampire must turn the lights off again and leave them off until the screaming has stopped.
System: If the ritual succeeds, then Bloody Mary will possess the mortal’s body and be bound to serve the summoner for one lunar month. The successes on the roll determine how loyal Bloody Mary is during the length of possession, for she is a spirit of violence and murder and will seize nearly any opportunity to kill while wearing a human host. With one success, she will grudgingly obey any direct commands and will refrain from attempting to harm the summoner in any way, but she will have no real loyalty. With five successes, her instinct is to obey every command without question and to refrain from any activities which might cause problems for the summoner later. If there is any conflict between Bloody Mary’s instinct to maim and kill and the needs of the summoner, roll the vampire’s successes on the summoning roll. If there are any successes, the player decides what Mary will do.
While Bloody Mary is riding the mortal vessel, she gains the equivalent of Potence 2 and Fortitude 2. She knows everything he knew, and she can impersonate him effortlessly. However, animals are instinctively afraid of any mortal ridden by Bloody Mary, and characters who succeed on a Perception + Empathy roll (difficulty 7) find him frightening and off-putting. For children, the difficulty is only 5. Statements from anyone close to the mortal indicating love or affection to him require the player to roll a number of dice equal to the summoning successes (difficulty 7). Failure means that Bloody Mary will frenzy and attack the loved one. When the month of servitude ends, Blood Mary departs, leaving behind a mortal who is irretrievably insane. As noted, this is a dark ritual, and any sorcerer who performs it must make a Conscience roll if his Humanity is two or higher.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Cheat the Scale of Hades"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 311


5. Cheat the Scale of Hades


Follower of Set Ritual. This ritual allows a witch to remove the heart (as well other vital organs) from his body entirely and wraps his flesh in a protective cocoon. This ritual takes three hours to complete and can only be performed on oneself in the dark of the night, either after the moon has set, before it has risen, or during the new moon. The player makes an extended Dexterity + Medicine roll (difficulty 7). Each roll represents an hour of activity, and the ritual ends in failure if the moon or sun rises before the player achieves the necessary successes (five to remove a heart, twelve to achieve the mummified form). Any vampire who witnesses the process is subject to Rötschreck (difficulty 6). Once the witch has removed his heart, liver, and brain, he falls into a sort of torpor. His vitae and undead flesh combine to wrap him in a dry, scaly shroud that leaves a small opening around his mouth, but is otherwise nearly impenetrable. A witch so preserved may remain in stasis indefinitely, and the enshrouded vampire is virtually impervious to harm as if under the effects of Stone Slumber (p. 310). However, the extracted organs are extremely vulnerable, especially the heart. Destroying an organ causes an unsoakable level of aggravated damage to the vampire, while exposing the heart to sunlight or burning it instantly destroys the vampire in a terrible immolation. Only feeding the witch his removed organs can awaken him. After ingesting his organs, it takes one minute for the cocoon around him to crumble to dust and an hour for him to rise.
It is possible to undertake this ritual only partially, stopping with the removal of the heart. Indeed, it is also possible to perform the first part of this ritual upon another Cainite. A vampire is perfectly able to move about without a heart, and as an added benefit, she becomes immune to standard staking or diablerie. Due to the heart being the seat of emotion, the difficulty of all rolls to resist frenzy are two lower. However, if an enemy gains possession of her heart (or if the heart is removed by the witch) the vampire is in dire straits. Not only does it provide a powerful ritual connection to the vampire, but a simple flame or glint of sunlight upon the heart destroys the Cainite outright. In addition, driving a stake through the heart forces her into torpor, and any Cainite drinking more than two blood points from it passes straight to the heart’s blood, reducing the difficulty for diablerie to 7.
Clan rituals (p. 302): Clan rituals are jealously guarded secrets that are never shared with those not belonging to the clan or bloodline harboring its mysteries.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Chill of Oblivion"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 183


5. Chill of Oblivion


Performed over the course of 12 hours (reduced by one hour per success on the casting roll), this ritual infuses the necromancer or a willing subject with the chill of the grave. The ritual’s material component is a one-foot (half-meter) cube of ice, which is slowly melted on the subject’s chest (inflicting three health levels of bashing damage on mortal subjects). The subject must lie naked on bare earth for the entire duration of the ritual. Once the ritual is completed, its effects remain for a number of nights equal to the caster’s Occult rating.
An individual affected by Chill of Oblivion treats aggravated damage from fire and high temperatures as if it were lethal damage. Furthermore, he may attempt to extinguish any fire by rolling Willpower (difficulty 9); each success reduces the fire’s soak difficulty (see p. 297) by 1, and a fire with a soak difficulty of 2 dwindles to glowing embers.
However, this ritual has several drawbacks. First and foremost, the subject’s aura is laced with writhing black veins that resemble those left by diablerie, and may well be mistaken for such by any observer who is not familiar with this ritual. The subject also radiates a palpable aura of cold that extends to about arm’s length from him; this can be extremely disconcerting to mortals, though it causes no damage, and its game effects mirror those of the Flaws Touch of Frost (p. 494) and Eerie Presence (p. 495). Finally, the mystical nimbus of the ritual draws hostile ghosts to the subject, who may plague him with unwholesome acts.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["5. Cobra’s Favor"] = {
					en = [==[Rites of Blood, p. 154


5. Cobra’s Favor


During the war between the fledgling Camarilla and Clan Assamite, there were a vast number of casualties. The Tremere created this ritual as a precaution against being diablerized by their many enemies, especially the Assamites, who seemed to delight in targeting the Warlocks. Some historians have speculated that Cobra’s Favor was the first of many thaumaturgical experiments that eventually lead to the ritual that cursed the Assamites at the signing of the Treaty of Tyre.
Cobra’s Favor manipulates the vitae of the caster, causing it to burn with a toxin that causes horrific damage to anything that consumes it. The ritual requires an herbal poultice and the venom of a snake to be mixed with some of the thaumaturge’s blood.
System: By spilling one point of blood into a prepared container and combining it with the necessary herbs and poison, the thaumaturge recites an incantation, willing her magic into the concoction until it turns jet black. The caster must ingest the elixir for the ritual to take effect, suffering one level of unsoakable aggravated damage in the process. Afterwards, for the next week, anything that consumes the blood of the caster suffers a level of aggravated damage per point ingested. Each additional success on the activation roll extends the duration of the ritual by an additional week.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Commune with the Abyss"] = {
					en = [==[Lore of the Clans, p. 127


5. Commune with the Abyss


The Abyss listens. It is a place of secrets, and they say it hears every whisper ever spoken. With this power, the mystic infuses herself with the shadow so completely that their minds become one. Once joined, the petitioner can ask one question of the darkness, which for once cannot hide the answer.
System: By casting this ritual, the vampire draws into herself the surrounding shadows and darkness. Once they are gone, the vampire falls into a deep torpor-like sleep from which she cannot awaken. The character may then ask one question, which may be as mundane or as complicated as she desires. The Storyteller gives this question a rating based on how obscure or difficult it might be to answer, from one to ten. The rating may even be higher than ten if the question is truly momentous.
Each night the vampire remains in their torpid slumber, she rolls Intelligence + Occult (difficulty 9) and keeps a note of her cumulative successes. Once the amount of successes equals the rating of the question, the vampire awakes suddenly knowing the answer. This answer will be true and complete, and not hidden in a riddle. The Abyss only hides the truth; it does not confuse it or guard it jealously.
Should the vampire fail to gain any successes on one of the rolls, the interval between making rolls moves from days to weeks. Continued failure moves this interval from weeks to months, to years, millennia, and even further. It is said that ancient mystics have lain for centuries contemplating the ultimate questions of the universe. There may even be Gehenna cults that await their awakening.
Abyss Mysticism (p. 125): Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level. Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.]==],
				},
				["5. Court of Hallowed Truth"] = {
					en = [==[Rites of Blood, p. 155


5. Court of Hallowed Truth


House and Clan Tremere have long utilized this ritual for tribunals and internal matters. Recent nights have seen a number of Princes call upon Tremere to use the ritual within their political halls in exchange for favors. Casting this ritual is an expensive and lengthy process, but there are always those willing to pay the price for the added assurance. Unbiased testimony and blatant truth become standard within the court, and many connivers and liars have betrayed their own plans under the effects of this power.
To cast this ritual, the thaumaturge must place a skull and a pair of crossed bones upon every entry to the room, including windows. Once the court is assembled, the caster must then spend a point of blood at each of the entries into the room to symbolically seal the room from falsehoods. This ritual can be quite costly if the ritual is cast in a large room with multiple entrances and windows.
Several Princes have come to rely too much on this ritual, much to their undoing, as either the Prince becomes preposterously indebted to the Tremere or other Kindred resent her heavy-handed tactics and refuse to attend meetings. This power invariably erodes the power of Princes who rely on it, though some are too shortsighted to understand this.
System: Once the ritual is complete, all who enter the room are bound to abide by the truth-telling edict it enforces. No falsehood may be spoken, and direct questions from the presiding judge or power are answered candidly with no omissions or deceit. The magic persists within the room for the length of one week. Each additional success on the activation roll extends the duration of the ritual by an additional week.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Creation of the Shabti"] = {
					en = [==[Rites of Blood, p. 109


5. Creation of the Shabti


Level Five Setite Sorcery Ritual. The practitioner of Ahku casts this ritual upon a perfectly carved statue made of gold, lacquered or petrified wood, marble, or some other expensive material. The thaumaturge recites in ancient Egyptian, “Oh, shabti, if I be called by Set to sleep, or if the sun shine upon my labors, I ask you to bring the sands of the east to the west, and judge me with His eye.”
The shabti then awakens, responding, “I will do it, verily, I am here when thou callest.”
From there forward, the statue is inhabited by a sentient funerary spirit. It can fight (but cannot fly, even if the statue is carved with wings), but is not capable of further speech or creative behavior. Effectively, the shabti is a golem. A shabti moves extremely slowly, and is not fit for offensive battles, but makes an exceptional defender. This creature is unfailingly loyal to its creator, and will stand guard over the vampire’s sleeping form during the day (or through periods of long torpor).
System: The statue must be of at least human size (though it may be up to three times as large, and it may be shaped like a biped or like an Egyptian animal), and must be made with at least Crafts 4 (and be commensurably expensive). The thaumaturge’s player rolls Charisma + Occult (difficulty 8). Once a shabti is created, the spirit remains until the next time its caster wakes up (whether that is the next sunset, or after a hundred years of torpor). At that time, the statue crumbles to dust and the funerary spirit is freed.
Regardless of its size or shape, a shabti has four health levels, four Willpower, six dots in each Physical Attribute, and two dots in all other attributes. These constructs may spend a point of Willpower to move at a walking pace for one turn; otherwise, they are stationary. They cannot be targeted by mental and social powers, with the exception of powers that remove the spirit (such as soul stealing), which immediately destroy a shabti.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["5. Dead Man’s Hand"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 183


5. Dead Man’s Hand


The necromancer takes a rag stained in the blood, sweat, or tears of the intended victim. She takes a freshly severed human hand (which can come either from a corpse or a living “donor”) and closes it around the rag. As the hand decomposes, so does the victim. His flesh bloats, turns gray and then green, then starts to slough off. The victim’s brain remains fresh until the very end, so he can see the maggots writhe in the putrescent rack of meat that once was his healthy body.
The necromancer makes the standard roll and spends two blood points for each point of Stamina (and Fortitude) possessed by the victim. The victim loses health levels according to the timetable below. Only the removal of the rag from the hand can stop the process. If this happens, health levels return, also according to the chart below.
Bruised — 12 hours until next loss
Hurt — 12 hours until next loss
Injured — Six hours until next loss
Wounded — Three hours until next loss
Mauled — One hour until next loss
Crippled — 30 minutes until next loss
Incapacitated — 12 hours until next loss
Mortal characters who suffer more than 12 hours of incapacitation die, while Kindred who remain Incapacitated for more than 12 hours succumb to torpor.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["5. Dedicate the Haven"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 310


5. Dedicate the Haven


The havens of thaumaturges often house arcane documents, special resources, and other major assets. To defend them, thaumaturges frequently cast Wards over a site. Dedicate the Haven cements this process. The caster must take a minimum of one hour to walk a counterclockwise circle around the entire haven grounds while carrying a smoking thurible that contains a burning mixture of her blood, frankincense, and sage. Once complete, the thaumaturge must return to the rough center of her haven and douse herself with the remainder of the blood. A dedication covers a single building, and a complex of homes or an estate and grounds may require several castings to ensure proper protection. Once dedicated, a haven is open to more defenses; any Haven Ritual (specified as such in the description of individual rituals) cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Enchant Talisman"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 239


5. Enchant Talisman


This ritual is the first taught to most Tremere once they have attained mastery of their first path. Create Talisman allows the caster to enchant a personal magical item (the fabled wizard’s staff) to act as an amplifier for her will and thaumaturgical might. Many talismans are laden with additional rituals (such as every ward known to the caster). The physical appearance of a talisman varies, but it must be a rigid object close to a yard or a meter long. Swords and walking sticks are the most common talismans, but some innovative or eccentric thaumaturges have enchanted violins, shotguns, pool cues, and classroom pointers.
System: This ritual requires six hours per night for one complete cycle of the moon, beginning and ending on the new moon. Over this time, the vampire carefully prepares her talisman, carving it with Hermetic runes that signify her true name and the sum total of her thaumaturgical knowledge. The player spends one blood point per night and makes an extended roll of Intelligence + Occult (difficulty 8), one roll per week. If a night’s work is missed or if the four rolls do not accumulate at least 20 net successes, the talisman is ruined and the process must be begun again.
A completed talisman gives the caster several advantages. When the character is holding the talisman, the difficulty of all magic that targets her is increased by one. The player receives two extra dice when rolling for uses of the character’s primary path and one extra die when rolling for the character’s ritual castings. If the talisman is used as a weapon, it gives the player an additional die to roll to hit. If the thaumaturge is separated from her talisman, a successful Perception + Occult roll (difficulty 7) gives her its location.
If a talisman is in the possession of another individual, it gives that individual three additional dice to roll when using any form of magic against the talisman’s owner. At the Storyteller’s discretion, rituals that target the caster and use her talisman as a physical component may have greatly increased effects.
A thaumaturge may only have one talisman at a time. Ownership of a talisman may not be transferred — each individual must create her own.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Enochian Passage"] = {
					en = [==[Rites of Blood, p. 104


5. Enochian Passage


Level Five Necromancy Ritual. The vampire can physically pass into the Shadowlands, appearing in the fields before the mystical city of Enoch. This requires that the vampire symbolically “kill” herself by plunging a silver dagger into her heart (doing at least two lethal wound levels) and falling into a body of water deep enough to cover her body. Members of the Tal’Mahe’Ra use this ritual to go to Enoch, and thus rabidly protect it from falling into anyone else’s hands.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["5. Escape to a True Friend"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 239


5. Escape to a True Friend


Escape to a True Friend allows the caster to travel to the person whose friendship and trust she most values. The ritual has a physical component of a yard-wide/meter-wide circle charred into the bare ground or floor. The caster may step into the circle at any time and speak the true name of her friend. She is instantly transported to that individual, wherever he may be at the moment. She does not appear directly in front of him, but materializes in a location within a few minutes’ walk that is out of sight of any observer. The circle may be reused indefinitely, as long as it is unmarred.
System: This ritual takes six hours a night for six nights to cast, reduced by one night for every two successes. Each night requires the sacrifice of three of the caster’s own blood points, which are poured into the circle. Once the circle is complete, the transport may be attempted at any time. The caster may take one other individual with her when she travels, or a maximum amount of “cargo” equal to her own weight.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Esilio"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 183


5. Esilio


Like Tempesta Scudo, Esilio is a quick and dirty ritual. The necromancer simply speaks five syllables. No one can identify the casting language, but according to the ritual’s oblique history, the language is what God gave humankind before the confusion of Babel. The legend further states that while the particular meaning of the words is lost, they are what Caine’s father said to him while exiling him to Nod.
Regardless of the truth of the matter, the Words of Exile are not spoken lightly. When the ritual is cast successfully, it opens a hole within reality itself — a rip between the lands of the living and the darkest depths of the Underworld. This tear is invisible to normal vision, but to Witness of Death or Shroudsight it looks like a black vortex opening within the vampire’s own body (the very few unfortunate enough to look into the gap with high levels of Auspex are generally unwilling or unable to discuss it). Any ghost clutched to the Kindred’s chest is instantly torn to shreds. Grabbing a ghost in this fashion requires a Clinch or Tackle maneuver. Destroyed spirits don’t come back for at least a month, if ever. A wraith destroyed in this fashion tends to return as a Spectre, if it returns at all.
The necromancer may clutch and destroy a number of spirits equal to the number of successes she rolled. After that, the vortex closes. It closes at the end of the scene if it hasn’t already.
Of course, using one’s body as a portal between our world and what some people might call Hell is neither simple nor healthy. For starters, it costs a blood point and a point of Willpower (which does not give an automatic success on the ritual roll). More importantly, each success rolled inflicts a level of unsoakable lethal damage on the necromancer. Most significantly, every use of Esilio permanently reduces the necromancer’s Humanity by one point if he follows that morality, and may impact other Paths at the Storyteller’s discretion.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["5. From Marduk’s Throat"] = {
					en = [==[Lore of the Clans, p. 31


5. From Marduk’s Throat


New Dur-An-Ki Ritual. This ritual is the means by which Assamites can continue to reduce their Generation despite the limitations imposed by the Tremere Curse. It is also the mechanism by which the sorcerer caste maintains some influence and control over the Clan despite their small numbers, as the ritual’s difficulty means that only very experienced sorcerers can use it. The sorcerer creates an alchemical substitute for vampiric blood, allowing an Assamite who drinks enough to decrease her Generation. The ingredients include a wide variety of chemicals, herbs, and other exotic materials, but the most important ingredient is Kindred blood.
To reduce the drinker’s Generation by one level, the potion must incorporate a number of blood points from vampires of lower Generation than the drinker equal to four times the maximum blood point value of the desired Generation. For example, an Assamite who sought to reduce her Generation from Eighth to Seventh would need to procure twenty-eight points of blood from Kindred whose own Generation was Seventh or lower. Regardless of how much vitae that is, the result of the alchemical process will evaporate down into a thick sludgy material that the imbiber must consume in a single attempt.
The potion is foul, and requires the imbiber to successfully roll Willpower (difficulty 9). If that roll succeeds, the Assamite must then successfully assimilate the blood into her body. This requires an extended Willpower roll (difficulty 9), seeking 15 successes for a new Generation. Failures don’t stop the process, but they do deal six dice of lethal damage apiece (soaked normally). Assimilation is so painful and distracting that any attacks made against her during this time face a difficulty of only 2.
Assamite Sorcery ritual casting: Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9).]==],
				},
				["5. Ghost in the System"] = {
					en = [==[Rites of Blood, p. 69


5. Ghost in the System


In these modern times, when the Internet remembers all and government-backed identification is needed for nearly every transaction, it is no longer enough for a newly arrived Kindred to simply dominate the local city clerk into providing him with papers. This exhaustive ritual can takes a week or more to perform (when used to create false identities for Kindred or other supernatural beings), though simple uses directed against mortals may take only a single night. At the conclusion, though, the results can be most impressive. For Kindred, the ritual creates not just a fake ID but an entire paper trail for the target all the way back to his “date of birth.”
The false records, to the extent they exist on the Internet, are perfect, and show whatever history the thaumaturge desires. Only personal examination of the actual hard copies contained in dusty filing cabinets will reveal the truth of the target’s life. When this ritual is turned against mortals, it can achieve such effects as giving an innocent man a criminal record or cleaning the slate for a wanted criminal, stealing away the ownership of someone’s home, or even sabotaging someone’s medical records so that a well-meaning nurse actually gives her an unnecessary and lethal injection.
System: The ritual requires an extended Intelligence + Occult roll, with each roll representing one full night spent reshaping the Internet and doing nothing else except devoting an hour or two to feeding. The Storyteller determines how many successes are needed based on the number of “Internet facts” that must be changed in order to achieve the desired results. Changing a single mortal’s medical diagnosis or reporting all her credit cards as stolen might require only one or two successes, while creating an entirely new identity for a vampire on the run might require five to ten, depending on how complicated and important the new identity is. Particularly successful uses of this ritual may lead to dots in the Alternate Identity Background (V20, p. 111).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Grasp the Ghostly"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 184


5. Grasp the Ghostly


Requiring a full six hours of chanting, this ritual allows a necromancer to bring an object from the Underworld into the real world. It’s not simple, however — a wraith may object to having his possessions stolen and fight back. Furthermore, the object taken must be replaced by a material item of roughly equal mass, otherwise the target of the ritual snaps back to its previous, ghostly existence.
Objects taken from the Underworld tend to fade away after about a year. Only items recently destroyed in the real world (called “relics” by ghosts) may be recaptured in this manner. Artifacts created by wraiths themselves were never meant to exist outside the Underworld, and vanish on contact with the living world.
Necromantic ritual casting (p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["5. Mirror Prison"] = {
					en = [==[Rites of Blood, p. 29


5. Mirror Prison


The thaumaturge using this ritual possesses the ability to create a modest prison cell in the astral plane anchored to a specially prepared silver mirror. The caster may then open the mirror portal to the prison cell with a verbal incantation and physically deposit an incapacitated prisoner.
Some thaumaturges use this ritual to create a private space to meditate without distractions.
System: The thaumaturge must polish a silver mirror with a point of her blood and the tears of an innocent child. The thaumaturge must expend a point of Willpower that is permanently absorbed by the mirror.
Once created, the thaumaturge may open a portal through the glass by touching it with a point of her blood. The opening to the mirror prison lasts as long as desired by the caster. Incapacitated prisoners may be passed through with no difficulty, but an unwilling target requires an opposed Strength roll to force the victim through the portal.
Escaping the mirror requires the prisoner to defeat the caster in an opposed Willpower roll with a difficulty of 8. A prisoner may only attempt to escape in this fashion once every thirty days. The cell can comfortably contain up to three individuals. A person inside may not be scried for or be the target of Clairvoyance (or similar powers, at Storyteller discretion). The prisoner needs neither sustenance nor sleep, as she remains untouched by the passage of time.
Should the mirror be destroyed or the thaumaturge wish to cancel the ritual, the stored Willpower point will return to her and any prisoners will instantly be released.
If the caster spends a point of blood and touches the mirror, she can increase or decrease the opaqueness of the glass, allowing the prisoner to see outside of her prison as she wills. If the mirror is clear, the prisoner can appear in the mirror as a floating head to communicate.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Mirror of Blood"] = {
					en = [==[Rites of Blood, p. 107


5. Mirror of Blood


This legendary ritual is used to create entire packs of Blood Brothers, forging them from mortal flesh and Cainite vitae completely outside of the Embrace. Some Cainites consider Mirror of Blood to be a heresy against the vampiric condition. Others refer to it as the pinnacle of unified magical research and experimentation. Nevertheless, all agree: it is dangerous, in the extreme.
The Tzimisce and the Tremere antitribu of the Sabbat created this ritual together, after centuries of trial and error. It is incredibly difficult to master and extremely delicate to carry out. To enact this ritual, the caster must capture ten children less than seven years old. These children may be of any race or sex, but they must all be of the same blood type and have no diseases or genetic imperfections of any sort.
All of the children are ghouled to the same vampire. This vampire is generally a patsy of some sort; either a newly created and disposable childe, or a captive from some other sect. For the next three months, the children are alternately pampered by their domitor and tortured by the ritualist, shaped night by night into perfect replicas of one another. The torments, as well as the delights, escalate rapidly, until by the end of the three months, the children have broken minds and equally deteriorated bodies. In this state, they psychologically transfer their self-will to their domitor, offering an implicit, soul-deep trust. It is at that point that they are made to watch that domitor die at the hands of their tormentors — and then allowed to slaughter their domitor during the final night of the ritual. With a final, twisted application of spells both Hermetic and elemental, the children are murdered, their minds are merged and their memories shared, and then they are brought back from the dead by the power of the ritual. The bond they share — their domitor’s original blood-bond, now amplified and twisted into something far greater — establishes the permanent and unalterable unity of a new pack of perfectly identical Blood Brothers.
System: The blood cost of this ritual is 3 points for each child to be transformed into a Blood Brother. After three months of casting, on the final night of the ritual, the thaumaturge must make ten rolls — one for each child involved in the ritual. These rolls are made with Intelligence + Occult (difficulty 9). If the thaumaturge achieves at least one success on a roll, that child survives. If two or fewer children survive the process, the entire ritual is a failure, and all of the children die. If three or more of the original ten children survive, the ritual is a success. The number of children who survive are the numbers of Blood Brothers in the new, unified pack.
Attempted use of this ritual, whether successful or not, removes a single point of morality from the user’s morality total if they are on Humanity. Other paths (particularly those which eschew killing) may require a similar (or greater) morality loss. Blood Brothers created with this ritual are infertile, and cannot Embrace.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Nectar of the Bitter Rose"] = {
					en = [==[Rites of Blood, p. 155


5. Nectar of the Bitter Rose


A secret known only to the elder Tremere and vile diablerists, Nectar of the Bitter Rose breaks the usual constraints of diablerie, allowing multiple vampires to share in the fruits of a victim’s power. This ritual is considered a dark stain from the Tremere’s past, and evidence of any knowledge of this ritual would be cause for scandal in the Camarilla.
System: The thaumaturge must restrain the victim in some fashion while casting this hour-long ritual over him. She must chant the proper incantations while her coterie of would-be diablerists taunt the victim over his impending doom. While distracted, the caster mystically identifies different aspects of the soul and symbolically separates them from the whole by draining the target of vitae in small batches.
At the ritual’s completion, the caster and up to five vampires may attempt to gain the benefits of diablerizing the subject. Each would-be diablerist must make a separate challenge to claim the dark prize. Nectar of the Bitter Rose does not allow a vampire to gain benefits from diablerizing a victim of weaker or lesser generation — it simply lets multiple people share in a diablerie.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Occlude the Western Road"] = {
					en = [==[Dark Ages Tome of Secrets, p. 43


5. Occlude the Western Road


The sorcerer enacts the ritual that Haqim himself first created to keep the Holy City of Alamut hidden from the rest of the world. While wearing a traveling cloak and sandals, she must request the blessing of the Eldest in her task. The Eldest recites the teachings of Haqim, and instructs the sorcerer to keep safe the ways to Alamut. The sorcerer then meditates for an hour. Within an hour of sunrise, the sorcerer must take a vial with blood from the pool at the center of Alamut and mix it with dust from the Western Road while speaking the name of Alamut in the language of the First City under slowly brightening skies. She draws a circle around herself with the blood and implores the sun to erase all signs of travel to and from her location when it rises. The Cainite then anoints her own head with the blood and lays down flat, facing up with arms outstretched. After another incantation, a steady wind rises, at which point the sorcerer must hurry to shelter before the sun crests the horizon. When she sleeps, she is drained of blood, save for one point when she wakes. The sorcerer’s ritual erases all evidence of paths to and from her location. Anyone coming within a half mile radius of the location will travel around if reasonably possible, or will pass by without noticing her or the location she wishes to protect.
This effect lasts one month. Used within Alamut, it affects the whole of Alamut.
Assamite Sorcery ritual casting: the Tome of Secrets states no roll of its own for these rituals; Assamite Sorcery is mechanically identical to Thaumaturgy (V20, p. 440). Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Orphic Sojourn"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 296


5. Orphic Sojourn


Orphic Sojourn allows a necromancer to project her soul from her body and effectively exist as a ghost for the duration of the ritual.
Orphic Sojourn requires that the vampire dress herself in funerary garb and surround herself with grave goods. She lies down and meditates from dusk until midnight. After midnight, she is freed from her body. She may wander the Underworld and interact with the objects and creatures as if she were a ghost for a number of hours equal to her successes on her ritual roll. When the ritual expires, she immediately returns to her body. Orphic Sojourn may not be used to retrieve objects from the Underworld.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["5. Paper Flesh"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 240


5. Paper Flesh


This dreadful ritual enfeebles the subject, making her skin brittle and weak. Humors rise to the surface and flesh tightens around bones and scales away at the slightest touch. Used against physically tough opponents, this ritual strips away the inherent resilience of the vampiric body, leaving it a fragile, dry husk. The thaumaturge must inscribe his subject’s true name (which is much harder to discern for elders than it is for young vampires) on a piece of paper, which he uses to cut himself and then burns to cinders.
System: This ritual causes the subject’s Stamina and Fortitude (if any) to drop to 1 each. For every Generation below Eighth, the subject retains one extra point of Stamina or Fortitude (keeping Fortitude first, though she may not exceed her original scores). For example, a vampire of the Fourth Generation with Fortitude targeted by Paper Flesh would drop to a Stamina + Fortitude score of 6 (assuming the score was 6 or more to begin with). This ritual lasts one night.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Ravening Walls of Ceoris"] = {
					en = [==[Dark Ages Companion, p. 117


5. Ravening Walls of Ceoris


Note: This is a Haven Ritual (see Dedicate the Haven, V20 Dark Ages, p. 310)
This ritual is named for the fortress it was first used to protect. The caster sheds one blood point per 50 feet of a stone wall’s length (and spends 15 minutes per section) while invoking the names of earth spirits stolen from the lore of the Tzimisce. For the rest of the night, anyone touching or climbing the wall for the first time is drained of one blood point.
Immune to the ritual’s effects, the caster may touch the wall and harvest the stolen blood at a rate equal to her Generation-based expenditure limit, as an instant action. Each section of wall can hold as many blood points as the caster’s Thaumaturgy rating at any one time. The wall keeps draining excess blood, but sheds it in the form of a foul black ooze that cannot be used for sustenance.
For every dot of the caster’s Thaumaturgy above 5, she can designate one additional Cainite as immune to the wall’s blood-draining effects, and able to harvest blood from it.
Haven Ritual (V20 Dark Ages, p. 310): Once dedicated by Dedicate the Haven, a haven is open to more defenses; any Haven Ritual cast upon it is rendered permanent and has its casting difficulty decreased by three.
Thaumaturgical ritual casting (V20 Dark Ages, p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Rickard Argentis’s Homunculus"] = {
					en = [==[Dark Ages Tome of Secrets, p. 116


5. Rickard Argentis’s Homunculus


This odd ritual allows the caster to take the personality of a slain mortal, and invest it into a shadow entity. The ritual must be completed with a human sacrifice. The ritual creates a single Arm of Ahriman, which is statistically normal as if created by the caster, except that it can listen, speak, and act of its own will. It also gains Mental Attributes and Charisma and Manipulation equal to the slain mortal’s. The shadow becomes, for all intents and purposes, a copy of the mortal’s personality, but under a full blood bond to the caster. It persists until slain, but requires a blood point per week to survive.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				["5. Rite of Marduk Slain and Risen"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 310


5. Rite of Marduk Slain and Risen


Assamite Ritual. The sorcerer makes contact with a vizier, who names a victim that a warrior intends to diablerize. The sorcerer then takes part in a one-hour group ceremony with three other participants who know the ritual. All don robes and masks to ceremonially re-enact the myth of Marduk; taking the parts of Marduk, Ea, Sarpanitu, and the chaos dragon, Tiamat. If successful, and the beneficiary diablerizes his specified target before the next sunrise, the victim’s sire, all of the sire’s and the victim’s childer, and any vampire holding a Blood Oath with the victim share her final sensations as she perishes. Each affected subject loses one blood point and three Willpower points, which go to the diablerist (this cannot exceed Trait maximums). If the diablerist’s blood pool and Willpower are full, the remainder goes to the vizier, and following that, to the sorcerer. Furthermore, all of these collateral targets lose one point of Willpower for every ten minutes they spend in the presence of the diablerist, the vizier, or the sorcerer due to suffering flashbacks of the original victim’s demise. This effect lasts for 13 nights.
Clan rituals (p. 302): Clan rituals are jealously guarded secrets that are never shared with those not belonging to the clan or bloodline harboring its mysteries.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Sanctuary"] = {
					en = [==[Rites of Blood, p. 29


5. Sanctuary


In the 18th century, a religious-minded Tremere developed this ritual, which allowed him to consecrate a protected space and then extend a certain amount of its sanctuary to those that inhabit it with her. The thaumaturge casting this ritual must first find and acquire a building that has not been tainted with violence of any kind (or not in the past fifty years, if it is older than fifty years). Next, she must build a shrine at the metaphoric center of the building that all who visit must be able to see. The exact nature of the shrine depends upon the faith of the caster. Said shrine need not be of a religious faith, but it must represent a concept in which that the thaumaturge places her own faith and belief.
Finally, the thaumaturge must consecrate the building via a sacrifice of her blood and will over three nights.
System: To complete this ritual, the thaumaturge must invest a permanent point of Willpower into the consecration of the targeted building at the end of the three-night ritual. Once completed, the shroud of sanctuary completely envelops the boundaries of the targeted building. All souls, living or otherwise, that are not specifically invited by the caster cannot enter the building. Further, those inside the building are protected against all uses of Animalism, Auspex, Dominate, Dementation, and Presence (and related Disciplines, at Storyteller discretion).
However, this protection does not come without a price. The shroud of sanctuary only lasts as long as the grounds remain consecrated. Any acts of violence committed within the building will immediately taint it, making it impossible to benefit again from Sanctuary. Should the ritual be broken, the caster will immediately become aware of this, as the Willpower point invested into the building reverts back to her.
If the building remains consecrated, the magic of this ritual continues for one year per success from the activation roll. Afterward, the caster must either reinvest the Willpower point or allow the sanctuary to dissipate.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Seeing With the Sky’s Eyes"] = {
					en = [==[Rites of Blood, p. 163


5. Seeing With the Sky’s Eyes


By meditating on the universe, the sorcerer can look down on his enemy with the eyes of Heaven. The ashipu must enter an ecstatic trance. Then, he must concentrate on an individual by studying an effigy of her. The effigy must incorporate at least a recent photograph of the target, if not something with a stronger connection. This ritual cannot be achieved with just the target’s name (see Principles of Sympathy and Contagion on pp 133-135).
System: Each success allows the player to ask one question about the target’s current location and activities.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["5. Severed Hand"] = {
					en = [==[Rites of Blood, p. 155


5. Severed Hand


The Amr of Clan Assamite created this ritual as a means of showing mercy to criminals that deserved punishment, but not the Final Death. Severed Hand allows the thaumaturge to permanently sever a part of a restrained Kindred’s body in such a fashion as to prevent the vampire from ever regenerating the lost body part. Although the hand is typically the most common appendage removed, this ritual can affect eyes, fingers, tongues, and other body parts.
The most important component is the severed anatomy of the subject, which is why this ritual is almost always performed at the maiming. The Tremere stole the secrets of this ritual and then removed references to the veneration of Haqim. Clan Assamite was quite surprised to learn that Camarilla had adopted the same practices in their courts.
System: This ritual takes an entire night to perform, during which time the wound is treated with different alchemical compounds to prevent the regeneration process. Although the health levels can heal in the normal way, the severed body part is unable to be restored to its former condition without magical healing (such as Obeah, V20, p. 457).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Shackles of Blood"] = {
					en = [==[Rites of Blood, p. 167


5. Shackles of Blood


Shackles of Blood is a Level Five Wanga Ritual. The wangateur brews a potion that can create a temporary blood bond even at a distance. She must incorporate three points of her own blood, a variety of natural ingredients, and the heart of a recently deceased mortal whose gender is opposite that of the target. She then stirs the mixture for three hours and strains it through unbleached cotton before feeding the finished mixture to the target.
System: The false bond lasts for a number of nights equal to the successes. At the end of that, the effect ceases, but if the wangateur successfully blood bonds the target for real during that time, it acts like any normal blood bond. While this ritual would seem to be needlessly overcomplicated compared to blood bonding through conventional means, it has a potent advantage — if the potion is fed to a mortal, any vampire who feeds on that mortal within the next 24 hours is affected as if he had drunk it directly. In this way, a devious wangateur can gain power over a vampire who does not even know she exists.
Blood magic dice mechanics (p. 130): for the purposes of this book every school of blood magic works the same way — Willpower rolls for path powers and Intelligence + Occult rolls for all rituals, at a difficulty of 3 + the ritual’s level. Storytellers who prefer the dice pools listed in V20 or in prior supplements may use those instead.]==],
				},
				["5. Skinwalker’s Belt"] = {
					en = [==[Rites of Blood, p. 63


5. Skinwalker’s Belt


Derived from the Navajo tales of the yee naaldlooshii, this ritual allows the sorcerer to craft an item of clothing from the pelt of a ritually sacrificed animal no smaller than a mouse and no larger than a bear. While the pelt endures, the sorcerer may don it and transform himself into a perfect copy of the animal which was sacrificed. Werewolves may still detect the animal as “unclean,” and Kindred with Aura Perception may realize that it is somehow “undead,” though Kindred are more likely to think that the animal is merely possessed via Subsume the Spirit (Animalism 4) rather than shapechanged. The animal must be killed and skinned at a place purified by the Sanctify the Temple ritual. After the pelt is removed, it must be cured for three nights in a mixture of brine and the ritualist’s own blood. The ritual requires one point of blood for animals significantly smaller than human-sized, three points for animals which are roughly human-sized, and five points for animals significantly larger than human-sized. A black bear is the largest animal known to have been used for this ritual.
System: Each success means that the artifact will last for one week before degrading. It can be maintained for another equivalent duration by smearing it with a quantity of the ritualist’s blood equal to that used in the ritual that created it.
After the ritual is complete, the player of the ritualist must roll Intelligence + Craft to fashion the pelt into a wearable item of clothing. A failure can be rerolled, but a botch destroys the pelt. However, only one success is needed to complete the process. More successes simply mean that the artifact is more aesthetically pleasing. To use the Skinwalker’s Belt, the ritualist must remove all other clothing (including jewelry) before donning the artifact and mutter a brief incantation, whereupon he instantly transforms into a perfect copy of the animal used in the ritual. He cannot use Disciplines in this form (not even physical Disciplines such as Potence or Fortitude), and he cannot speak except to those who have the supernatural ability to speak to animals. He retains his human intelligence and is still subject to frenzy.
The effects of the magic last until he wills it to end or until daybreak. In either case, he instantly reverts to his true form, which can be very bad if he was in a small space wearing the size of a mouse or he is out in the open when he reverts back to a nude male who takes aggravated damage from sunlight. The artifact counts as the equivalent of a lock of hair or a fingernail if it falls into the hands of another blood magician (see Principle of Sympathy on pp. 133-135).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Stone Slumber"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 310


5. Stone Slumber


This ritual protects the caster by turning him into solid stone. The caster must begin this ritual exactly one hour before sunrise and swallow a pint of small rocks while remaining completely still in an open area facing east. When the first rays of the rising sun strike him, the caster’s body turns to unbreakable magical stone. If successful, the caster is completely protected from all physical damage, including flame and heat. While in this form, the caster’s mind is dormant; he is completely oblivious to his surroundings and cannot wake up – Telepathy and other mental Disciplines are useless. The ritual lasts until 10 minutes after the following sunset, and waking the following evening costs the caster an additional blood point.
This is a Gargoyle Ritual (see Enchant Talisman on p. 309).
Gargoyle Rituals (p. 309): Tremere thaumaturges may cast Enchant Talisman onto a Gargoyle to permanently enchant it with a specific ritual she knows. To accomplish this feat requires six hours per night, and one week per level of the ritual. Once successfully cast, a ritual permanently enchanted onto a Gargoyle becomes inherent to him, like a Discipline, and may be activated, deactivated, and reactivated at will by the Gargoyle spending one blood point. If the ritual is tied to a specific item, it is instead tied to the Gargoyle itself. Rituals activated by a Gargoyle require no roll to cast and last a scene or until dismissed.
Thaumaturgical ritual casting (p. 302): Unless otherwise noted, casting rituals requires the expenditure of one blood point, five minutes per level to cast, and a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Rituals sometimes require special ingredients or reagents to work, which are stated in each ritual’s description. Only a single success is required for a ritual to work, though certain spells may require further successes or have variable effects based on the caster’s roll.]==],
				},
				["5. Stone of the True Form"] = {
					en = [==[Rites of Blood, p. 156


5. Stone of the True Form


Stone of the True Form requires a small stone that is perfectly spherical. The caster must carefully coat it with a mixture made from a point of her blood and other eldritch compounds. Once the ritual is completed, the stone serves as an anchor to metaphorically connect the material world with Plato’s world of idealized forms. If the thaumaturge has the will, she can force others to assume their natural shape.
With a single touch of the stone, the caster may engage the target into a contest of will to force them to assume their natural form. A thaumaturge might use a Stone of the True Form on an Obfuscated Nosferatu, force a grotesque Tzimisce into a humanoid form, or even trap an enraged werewolf in its mortal form.
System: Over the course of one night, the thaumaturge must cast this ritual on a small round stone such as a marble. Afterwards, the cast may use this stone as a trigger to engage her target in a contested Willpower roll (difficulty of each other’s Stamina). If the caster wins by even one success, the subject will immediately shift to her natural form for a single turn. Every success above and beyond the first success extends the number of turns a target is unable to assume a shape other than her original form. If the stone is shattered, the victim is now free to change shape no matter how many turns left remain on her term in her original form.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. The Ferryman’s Recall"] = {
					en = [==[Lore of the Clans, p. 109


5. The Ferryman’s Recall


This obscure ritual is for the rare instance when a prospective convert has been killed before they could be Embraced, and they are determined to be too valuable to lose. Knowledge of this ritual is jealously, if not entirely successfully, guarded by certain Premascine Giovanni.
System: The caster must have access to the corpse as well as one of the subject’s fetters, perhaps obtained using Ritual of the Unearthed Fetter (V20, p. 181). The Ferryman’s Recall takes 8 hours (reduced by one hour per success on the casting roll) to perform.
The corpse must be relatively intact for the ritual to work, and the subject must have been a ghoul before death. If the necromancer performing the ritual was not the domitor, they must have a blood point worth of the domitor’s Vitae. The Generation of the Kindred giving the Embrace (usually, but not always, the necromancer performing the ritual) determines how much time may have passed since the subject’s death, as more powerful vitae has a more potent effect.
Thirteenth Generation — 12 hours dead
Twelfth Generation — 1 day dead
Eleventh Generation — 2 days dead
Tenth Generation — 3 days dead
Ninth Generation — 4 days dead
Eighth Generation — 5 days dead
Seventh Generation — 1 week dead
Sixth Generation — 2 weeks dead
First, the subject’s body must be cleaned and prepared, drained entirely of blood or embalming fluid. Then the necromancer paints a series of sigils onto the body, intended as place markers for the subject’s spirit to relearn how to use his body. At the climax of the ritual, the Kindred performing the Embrace pours her vitae into the subject’s mouth, and the Embrace continues as normal. Any wounds suffered before the ritual (including the cause of the subject’s death and any decomposition) close, but do not entirely heal, leaving scars on the newly Embraced Kindred’s body. In addition, the subject’s time across the sudario leaves its mark on him; giving him the ashen complexion of the Harbingers of Skulls, as well as endowing him with an improved facility for necromantic magic (see the Mortuario Merit on p. 106 for more information).
Necromantic ritual casting (V20, p. 177): Casting times for necromantic rituals vary widely; see the description for particulars. The player rolls Intelligence + Occult (difficulty 3 + the level of the ritual, maximum 9). Success indicates the ritual proceeds smoothly, failure produces no effect, and a botch indicates something has gone horribly wrong.]==],
				},
				["5. The Inmost Tug"] = {
					en = [==[Rites of Blood, p. 158


5. The Inmost Tug


The koldun may alter the emotional characteristics of any blood bond he holds over a thrall. In place of the normal feelings of love and devotion, he can cause the thrall to feel a debased lust, a terrified obedience, a fraternal devotion, or any other emotional context he chooses. The koldun need only speak a word in the presence of the thrall to invoke the ritual’s power.
System: Each success represents one scene in which the thrall is compelled to feel an emotion of the koldun’s choice toward him.
Koldunic Sorcery dice mechanics (p. 156): the roll to activate a Koldunic Sorcery ritual is Intelligence + Occult with a difficulty equal to 3 + the ritual rating. The school’s metaphysical connections to Kupala and to the lands permeated by that spirit increase the difficulty by +1 on all Koldunic Sorcery rolls made on behalf of kolduns who work their magic outside the territories of Eastern Europe.]==],
				},
				["5. The Pursuit of Apotheosis"] = {
					en = [==[Rites of Blood, p. 64


5. The Pursuit of Apotheosis


Few New Age Anarchs know this ritual. Fewer still would ever be so ruthless as to try it. Nevertheless, its existence is a temptation to all who have heard tales of its power — tales that the New Age Anarchs conceal from the other schools and from the greater Anarch community, lest the Movement turn on the New Agers en masse. The ritual begins just like Enfolding the Believers. Indeed, there is only one material difference between that ritual and this one — to the liquid-vitae mixture that must be consumed by the cultists, the sorcerer adds a quantity of poison, most commonly cyanide. To even attempt this ritual automatically costs the sorcerer one point of Humanity. Such is the price for sacrificing one’s own followers in the question for knowledge... or power.
System: The ritual either works or it does not — additional successes do not provide any further reward. For every mortal worshiper who dies as part of the ritual, the player must roll one die against a difficulty of 7. Every success gives the player one experience point that can be used to purchase new or improved traits as per normal experience costs. From the character’s perspective, these new Attributes, Abilities, and Disciplines are the result of a momentary glimpse of godhood paid for by the deaths of loyal followers. According to some rumors, a sufficient number of successful sacrifices can also be expended to permanently reduce a vampire’s Generation. The truth of those rumors and the number of successes needed to achieve such a feat are left to the Storyteller’s discretion. Regardless, however, any sorcerer who uses this ritual finds that her aura becomes streaked with black marks that are indistinguishable from those resulting from diablerie.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Treasures of Hades"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 296


5. Treasures of Hades


This complex and lengthy ritual allows a necromancer to retrieve Relics from the Underworld. The ritual requires that the necromancer chant for six hours while burning a replica of the Relic (which needn’t be well-crafted or convincing). At the conclusion of the ritual, the Relic will appear in the ashes of the replica. In order to summon a Relic, the celebrant must have seen it before. This ritual cannot be used to retrieve non-relic objects in the Underworld, such as the soul-cutting blades of the ghost kings.
It is unlikely that a useful Relic can be taken away without anyone noticing, however. Relics are precious, jealously guarded commodities in the Underworld, and ghosts have an uncanny way of tracking down meddling necromancers who plunder their treasuries.
Objects taken from the Underworld will remain in the living world until All Hallows’ Eve, at which point they return to the sunless lands. A necromancer can only summon a particular Relic once every one hundred years.
Necromantic ritual casting (p. 292): To perform a ritual correctly, a player must succeed at an Intelligence + Occult roll with a difficulty equal to 3 + the level of the ritual, maximum 9. Failure produces no effect, but a botch may produce disastrous results.]==],
				},
				["5. Ward versus Spirits"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 240


5. Ward versus Spirits


This warding ritual functions exactly as Ward versus Ghouls, but it inflicts injury upon spirits. Several other versions of this ward exist, each geared toward a particular type of non-physical being.
System: Ward versus Spirits behaves exactly as does Ward versus Ghouls, but it affects spirits (including those summoned or given physical form by Thaumaturgy Paths such as Elemental Mastery). The material component for Ward versus Spirits is a handful of pure sea salt.
The other versions of this ward, also Level Five rituals, are Ward versus Ghosts and Ward versus Demons. Each of these three Level Five wards affects its respective target on both the physical and spiritual planes. Ward versus Ghosts requires a handful of powdered marble from a tombstone, while Ward versus Demons requires a vial of holy water.
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Warding Circle versus Technology"] = {
					en = [==[Rites of Blood, p. 102


5. Warding Circle versus Technology


Although they have a great mastery of lore and Kindred physiology, most Inconnu are not modernists. This ritual was designed by William Howard Lexington III to protect himself and his fellow Inconnu from recently-Embraced neonates and hunters using technological weapons. This ritual creates a circle of magic centered on the caster, into which technology (i.e. any machine more complex or advanced than a crossbow) cannot pass without shattering or becoming defunct. This circle can be made as large and as permanent as the caster desires, as long as she is willing to pay the necessary price.
System: The ritual requires three points of mortal blood from individuals with at least an intelligence of 3. The caster determines the size of the warding circle when it is cast; the default radius is 10 feet/3 meters, and every 10-foot/3-meter increase raises the difficulty by one (one additional success is required for every increase past the number necessary to raise the difficulty to 9). The player spends one blood point for every 10 feet/3 meters of radius, and rolls. The ritual takes the normal casting time if it is to be short-term (lasting for the rest of the night) or one night if it is to be long-term (lasting a year and a day).
Once the warding circle is established, it glows a faint coppery-orange, too faint to be seen in normal light, but notable in dim lighting conditions or natural darkness. A successful Intelligence + Occult roll (difficulty 8) identifies this as a warding circle. If technology crosses into the circle, the possessor of that technology must roll more successes on a Willpower roll (difficulty equal to the caster’s Thaumaturgy rating + 3) than the caster rolled when establishing the ward. Failure indicates that the ward causes all such technology on the individual to be irrevocably destroyed; data cannot be retrieved at a later date, and all parts of the item shatter. If the technology leaves the circle and later enters it again, the possessor must repeat this roll.
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Warding Circles versus Spirits, Ghosts, and Demons"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 234


5. Warding Circles versus Spirits, Ghosts, and Demons


The Tremere have access to several other Warding Circle rituals: Warding Circle versus Lupines (Level Three), Warding Circle versus Kindred (Level Four), and Warding Circles versus Spirits, Ghosts, and Demons (Level Five). Each Warding Circle ritual must be learned separately. The material components required for each warding circle are the same as those needed for the corresponding ward, but in larger amounts. The effects against the targeted beings are the same as for Warding Circle versus Ghouls.
System: As Warding Circle versus Ghouls (p. 234), but the circle affects spirits, ghosts or demons, according to which of the three circles is cast. The material components are those of the corresponding Level Five ward, in larger amounts: pure sea salt for spirits, powdered marble from a tombstone for ghosts, and holy water for demons. The caster determines the size of the warding circle when it is cast; the default radius is 10 feet/3 meters, and every 10-foot/3-meter increase raises the difficulty by one, to a maximum of 9. The ritual takes the normal casting time if it is to be short-term (lasting for the rest of the night) or one night if it is to be long-term (lasting a year and a day).
Thaumaturgical ritual casting (p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Way of the Wendigo"] = {
					en = [==[Rites of Blood, p. 30


5. Way of the Wendigo


The Wendigo is a malevolent flesh-eating spirit believed to possess humans that violate the taboo against cannibalism. Once tethered to a human form, the spirit is believed to corrupt the soul until its victim is little more than a beast.
This forbidden ritual was developed by an apprentice Tremere that survived an assault on her chantry shortly before the American Revolution. Badly wounded and depleted to the point of exhaustion, she slipped away to the Great Lakes where she drank from the people that fished and lived there until she began to ritually consume the flesh of her victims. The unknown apprentice noticed that the practice healed her wounds and soothed her will.
The Way of the Wendigo encourages the thaumaturge to sacrifice not only her own blood, but living flesh to recharge herself from the life essence of her victim. Dark magic such as this always comes at a price to the soul. The Beast grows stronger when fed, and those that follow the Way of the Wendigo are no exception. It is said that the original Tremere that created this ritual fell to her Beast.
System: The thaumaturge seeks out a victim that she believes is an example of a virtue that she admires, such as intelligence, purity, or reverence. She must anoint the sacrifice with oil, sage, and ash during an hour long ritual. At the climax of the ritual, the caster murders the victim with the thigh bone of a hanged man and then consumes his flesh.
Consumption of the flesh allows the thaumaturge to absorb the victim’s essence to replenish the needs of her undead body and will. She will feel a rush of drowsiness and will be at -1 to all dice pools for the next hour. However, every ten minutes that the thaumaturge rests, she will regain a point of Willpower and one health level. At the end of the night, if the thaumaturge does not possess the merit Eat Food (V20, p. 480), she is forced to vomit up the excess flesh.
This is a horrific ritual where the sacrifice must knowingly endure the knowledge that he is going to die and then be consumed. Such a heinous action takes a toll on the humanity of the thaumaturge, as her mind is flooded with flashes of the victim’s life and experiences the agony of her death. The use of this ritual automatically strips a minimum of one Humanity dot from the character’s Humanity rating (to a minimum of 2). Additionally, the Storyteller might require a Conscience roll (difficulty 8). Failure means the loss of an additional Humanity point (which can fall below 2), while a botch could well mean the loss of even more.
The use of this ritual requires a Self-Control roll (difficulty 8). Failure means that the thaumaturge has gained the permanent Flaw Addiction: Human Flesh (V20, p. 482).
Thaumaturgical ritual casting (V20, p. 228): Unless stated otherwise, a ritual requires five minutes per level to cast. Casting rituals requires a successful Intelligence + Occult roll, for which the difficulty equals 3 + the level of the ritual (maximum 9). Only one success is required for a ritual to work, though certain spells may require more successes or have variable effects based on how well the caster’s roll goes.]==],
				},
				["5. Whispers in the Dark"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 273


5. Whispers in the Dark


The Abyss existed before creation and will persist after its destruction. Its memory encompasses everything that is known or ever has been known as well as mysteries too dense for human minds to fathom. By sending one’s thoughts into the Abyss, one may seek answers to her deepest questions.
System: The caster summons and contracts a Nocturne, as with Reflections of Hollow Revelation, until it can fit in the palm of her hand. The caster focuses her thoughts on a single question, which the Storyteller assigns a rating from 1 to 10 based on the importance or complexity of the answer, with 1 as trivial knowledge and 10 as truly revelatory.
When ready, the caster swallows the Nocturne. Once this is done, the vampire falls into torpor as her consciousness is catapulted into the Abyss. For each night spent in torpor, the player rolls Intelligence + Occult with a difficulty of 8. Successes are accumulated over successive nights until the player has successes equal to the question’s rating.
Of course, attempting to commune with the alien thoughts of the Abyss can be dangerous. If the Mystic accumulates no successes on her roll for one night, the interval between rolls increases from one night to several nights to weeks, and so on. Even successful use of this ritual leaves the mystic forever altered as she can never entirely dislodge the alien hunger of the Abyss from her soul. After using this ritual, when dealing with non-mystics vampires permanently reduce the difficulty of all Intimidate rolls by one, and increase the difficulty of all Social rolls by one (two when dealing with humans). This drawback is not cumulative.
Legend has it that the reason for Lasombra’s carefully guarded slumber in the Castle of Shadows is that he lies dreaming of a way to destroy creation itself.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["6. Into the Chasm"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 273


6. Into the Chasm


With this ritual, the Mystic willingly enters the Abyss, traveling through the infinite realm of nothingness to journey to any location she has been previously.
System: In preparation, the Mystic spends one hour and three points of her own blood painting a doorway with glyphs of the Abyss. When finished, they roll Intelligence + Occult, difficulty 7. On a botch, a portal to the Abyss opens in the doorway, but only long enough to discharge a number of Hungry Shades equal to the number of 1s rolled. A failure causes the glyphs to flare and disappear with no result. Success results in an open and stable portal with no backlash that remains open for as many turns as successes rolled.
Once a character steps through the portal, she speaks her destination to the Abyss and roll Wits + Obtenebration to open a portal out of the Abyss, difficulty 6. Each failed attempt increases the difficulty, to maximum of 10. Additionally, the Mystic takes a level of lethal damage that cannot be healed while within the portal. Botched attempts additionally attract a Hungry Shade.
Non-Mystics may enter an open portal into the Abyss by spending Willpower. The Mystic may choose to guide them by remaining in physical contact. Otherwise, her difficulty to exit the Abyss is 8. Non-Mystics cannot understand the formless chaos of the Abyss and see only total blackness. A Non-Mystic who attempts to use supernatural means of enhancing her senses while in the Abyss must make a Willpower roll or immediately gain a Derangement, as the horrible nothingness of the Abyss is often too much for non-Mystics to deal with.
Each time a vampire traverses the Abyss, they risk permanent contamination. Upon leaving the Abyss, each character must roll her Willpower against a difficulty equal to the number of rolls needed to exit the Abyss. A failure causes them to gain the Flaw Animate Shadow (see p. 427).
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["7. Evocation of the Oubliette"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 274


7. Evocation of the Oubliette


With this ability, the Mystic causes nearby shadows to erupt and devour a victim, sending them into the Abyss.
Abyss: The Mystic spends a full turn in concentration before spending three blood points and rolling Perception + Occult (difficulty 6) against a target that must be within line of sight. This attack may not be parried, but may be dodged. A successful attack results in the victim being dragged into the Abyss, where they remain for a number of nights equal to the caster’s Obtenebration rating - though the Mystic may spend a blood point to summon them back sooner.
The Abyss is a harrowing experience for those not initiated in its mysteries. Any character without levels of Abyss Mysticism gains a Derangement after her experience that can only be cured through repeated use of Willpower. A botched casting of this ritual results in the ritual backfiring and dragging the caster herself into the Abyss for a number of hours equal to her rating in Obtenebration. If the caster’s Willpower is lower than her rating in Obtenebration, she gains a Derangement as if she was a non-Mystic subject to this power.
A level 8 version of this ritual exists, known as Summoning of the Abyss. With this ritual, the Mystic speaks the name of a person they wish brought to them. That person is pulled into the Abyss, as above, and is immediately disgorged in the Mystic’s location, suffering all effects as above for traveling through the Abyss.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["8. Cry That Slays the Light"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 274


8. Cry That Slays the Light


This ability allows the vampire to tear a hole in the fabric of reality itself, causing the Abyss to cover the sky, blocking out the moon, stars, and even sunlight. The caster undertakes this ritual at peril of her very existence. This ritual is rare, even among Abyss Mystics, and has only been performed once in living memory.
System: In order to learn the Cry That Slays the Light, the vampire spends a week of nights in complete and utter silence, devoting every waking moment to meditation on her hatred of light and material existence. If at any point her silence is broken, they must begin again. Once the week has passed, roll Intelligence + Occult, difficulty 8. On a botch, the character is pulled into the Abyss for a period of one century per every 1 rolled. She remains alert and aware, never falling into torpor from blood starvation, and gains a number of Derangements equal to the number of 1s rolled.
On a success, the Mystic divines the shape of the word that encapsulates the Abyss. This word becomes part of the Mystic and cannot be discerned by another character through Telepathy or any other supernatural means. The Mystic may hold back this word as long as she chooses — days, years, decades - before she releases it and the Abyss darkens the sky for one hour. During this hour, all vampires are immune to Rötschreck and need not worry about sunlight, even at midday. Once the hour is over, the word fades from the Mystic’s mind and must be re-learned.
Even when successful, allowing oneself to be a direct conduit for the Abyss comes with dire risk. After using this power, roll a number of dice equal to the Mystic’s Road rating, difficulty 4. Each success allows the Mystic to retain two dots of her Road rating for Mystics on the Road of the Abyss, one dot for Mystics not on the Road of the Abyss. If the Mystic’s Road is reduced to 0 in this fashion, the Abyss utterly annihilates her existence.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["8. Lord Aludian’s Claim"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 274


8. Lord Aludian’s Claim


With most Abyss Mysticism rituals, a vampire pokes a subtle hole through reality, temporarily letting a primal, dark unknown through that portal. This phenomenal expression of tenebrous mastery tears down the boundaries between the realms of flesh and shadow on an almost permanent basis. This curses an area to become a hub of shadowy nightmares indefinitely.
This ritual requires an extended Manipulation + Occult roll, difficulty 8. Each roll represents one hour, and you can make rolls equal to your character’s Willpower dots. Five successes are required to claim a five meter diameter, and which can allow through one shade (see p. 272). Additional successes can be spent to add an additional five meters to the diameter, or allow one additional shade to cross. These shades can leave the portal’s vicinity. However, the portal can only support a total number of intruders as determined by the initial roll. Whenever a shade dies, it returns at dusk. The shades are completely subservient to the caster.
The portal only closes when voluntarily closed, exposed to sunlight, or to True Faith. A character may only have one such portal open at a time.
Abyss Mysticism ritual learning (p. 271): Abyss Mystic rituals are different from other forms of blood sorcery rituals, as they are based on use of a Discipline and not magic. Characters looking to learn Abyss Mysticism rituals must possess an Occult rating of 3. Characters may not learn a ritual with a level higher than her Obenebration or Occult rating. Furthermore, characters must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn. Many Abyss Mystic rituals have side effects that confer Flaws; characters can never receive experience or bonus points for Flaws gained as a side effect of Abyss Mystic rituals.]==],
				},
				["9. Boukephos’ Chosen Oubliette"] = {
					en = [==[Dark Ages Tome of Secrets, p. 38


9. Boukephos’ Chosen Oubliette


Underground is where you will find the Mystics’ Oubliettes, in winding caverns and blood-streaked dungeons. Boukephos of Clan Lasombra refutes this need to hide from the stars. Whatever entity of the Abyss long ago possessed Boukephos, it made him form an Oubliette on the surface of the world, consuming the entire town of Latava and all occupants within. This Oubliette remained until the sun rose, at which point it dissipated, leaving only a scarred wasteland where a town once stood, and a lone survivor. Mystics have long attempted to recreate Boukephos’ Oubliette, but few succeed.
System: The Abyss Mystic must paint a circle of pitch around the perimeter of an aboveground community — whether a hamlet, village, town, or city. This circle is broken if crossed by a child, or a believer with True Faith. Once the circle is in place, the Abyss Mystic must draw her own blood in its center, under the night’s sky, spending three blood points as she pools her vitae on the earth. The vampire must then spend one Willpower point, and succeed on an extended test of Intelligence + Occult (difficulty 8) with a target number of 8 successes for a small community, 15 for a large community, and 22 for a huge population center. These successes must be accumulated in the course of one night, and the practitioner cannot be disturbed, otherwise the ritual will fail. Upon the final success, the pitch circle surrounding the community ripples, and forms tall waves that crash into whatever lies within it. An aboveground Oubliette forms, and everything within it shifts to the Abyss. Once the night has passed and the Oubliette dissipates, only those within the Oubliette who achieved successes on a Willpower test (difficulty 9) remain, with a Derangement. Everyone else is taken to the Abyss, and will remain there for a number of nights equal to the Abyss Mystic’s Obtenebration rating, suffering the effects listed under the Oubliette Background. Botching the ritual results in the Abyss Mystic disappearing into the heart of the Abyss forever. The practitioner is not recoverable.
Abyss Mysticism rituals (p. 35): Abyss Mystics hoard their secrets. Members of other groups may not access their Rituals without first dedicating their existences to the Abyss.
Abyss Mysticism ritual learning (V20 Dark Ages, p. 271): Abyss Mystic rituals are based on the use of a Discipline and not magic, and each ritual states the roll of its own. Characters must possess an Occult rating of 3, may not learn a ritual with a level higher than their Obtenebration or Occult rating, and must have an Occult specialization in Abyss Mysticism or add 1 to the difficulty of each ritual. Each ritual costs 3 experience points per level to learn.]==],
				},
				-- <<< RITUAL_DESC_END
};
