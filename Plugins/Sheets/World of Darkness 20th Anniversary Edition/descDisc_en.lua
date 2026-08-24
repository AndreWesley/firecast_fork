-- Discipline descriptions, the [en] half (SPEC T495, V210).
--
-- descDisc.lua used to hold en and pt side by side, and require pulled BOTH in to read one:
-- half of every parse was the language the session never opens (SPEC R92f). T495 split it
-- in two. This file holds [en] only, descDisc_pt.lua holds the other, the two carry the SAME
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
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 189


Abombwe


The Bonsam claim heritage from a hunter possessed by a darkness from a time before the light. It is impossible to trace the veracity of this statement, but the Discipline of Abombwe certainly taps into both primal darkness and predatory prowess.

• Predator’s Communion
The Laibon is the greatest predator in his territory and senses whenever a potential ally or rival is nearby.
System: Spend a blood point. For the rest of the scene, the Laibon can sense predators in the area, including vampires, shapeshifters, ghosts, predatory animals, mortals, and ghouls with a Road rating of 4 or less. To pinpoint the location or find a hidden creature, the player rolls Perception + Survival (difficulty 6, modified by the strength of the predator as determined by the Storyteller; stronger predators are generally easier to detect).

•• Invoking the Predator
Sculpting the malleable darkness inside him and pushing it outward, the Laibon can copy aspects of predatory animals.
System: This transformation takes one turn and requires one blood point. The character might grow claws that inflict Strength +1 lethal damage or a tail for balance. Most transformations are automatic, but particularly exotic ones such as poison glands require an Intelligence + Survival roll (difficulty 7). A botch results in a successful transformation, but adds cosmetic changes such as scales or stripes. This power does not suspend the laws of physics; the Laibon cannot create wings or spider webbing strong enough to carry his weight.

••• Unseen Hibernation
The Laibon makes his lair inside natural formations, plants, or earth by melting into the darkness hidden under their surface. A natural object significantly altered or sculpted by man is not suitable for this power; a wooden hut cannot be used, but a tree with carvings on it might do.
System: The player spends a blood point. Unseen Hibernation is automatic and takes a turn to complete. The character falls into a consciousness one step above torpor during this time and his player must make a Road roll (difficulty 6) for the character to rouse prematurely.
The difficulty of rolls to locate the character increase by two. Astral individuals cannot affect him directly, instead meeting with writhing darkness as their hands pass through him.
Violence upon the submerged vampire expels him from the object in a blinding spray (everyone near the vampire, and the vampire are at +2 difficulty on Perception for the turn). The vampire subtracts two from his Initiative for the first turn upon expulsion, but may act normally after that.

•••• Power from Darkness
The Laibon lets darkness flow out and over him like black, clotted blood that clings to his body. This grants him power and special abilities even as the light repels it.
System: This power costs two blood points and is automatic. One transformation may be active at a time, lasting for a scene, during which resisting Rötschreck is at +1 difficulty.
Examples of use are listed below, but players and Storytellers are encouraged to come up with their own changes:
Hands – Punches inflict Strength +1 aggravated damage.
Head – Gain the ability to see perfectly in normal darkness and a -2 difficulty for seeing in supernatural darkness. Spit a toxin by rolling Dexterity + Athletics (difficulty 7) that paralyzes any enemy’s limbs it touches unless the target succeeds at a Stamina roll (difficulty 7).
Torso – Sprout four spider legs which allow for one additional attack as part of a multiple action in a turn. Climb actions automatically succeed, and attempts to escape by running are at -2 difficulty.
Legs – Kicks inflicts aggravated damage. Leap up to 10 times the normal jumping distance and receive -1 difficulty to landing safely after a fall or jump.
Throat – Emit a primordial roar. Mortals and ghouls must succeed at a Courage roll (difficulty 9) or flee, whilst supernatural beings must succeed at a Courage roll (difficulty 8) or become weak with terror (all dice pools reduced by half, rounded up).

••••• Predator’s Transformation
The Laibon slays a predator and consumes a part of it, be it heart, liver, flesh, or blood. He then becomes that creature as his vitae fully absorbs its essence.
System: The player spends one blood point and rolls Stamina + Survival (difficulty 7). If successful, the Laibon physically transforms into the creature. The creature must be predatory in nature and at least the size of a cat. Humans and supernatural beings may be duplicated, but this does not include powers. Predator’s Transformation lasts until sunrise or the Laibon ends the power.
A Laibon may duplicate a previous transformation without consuming another creature. This requires a Stamina + Survival roll (difficulty 10) with difficulty reduced by one for each time he has killed and transformed into a creature of that type, to a minimum difficulty of 6. With mortals, vampires, and other humanoids, the Laibon takes on an average appearance for his victim’s ethnic group.]==],
				},
				["Abyss Mysticism"] = {
					en = [==[Lore of the Clans, p. 125


Abyss Mysticism


As the Lasombra delved deeper into the secrets of Obtenebration, they discovered it drew power from a dark realm of shadows called the Abyss. Mystics within the Clan began to study this secret realm to unlock its secrets, and through this developed the art of Abyss Mysticism. The Lasombra keep this power secret from the rest of the Sabbat, as the creatures they summon and control with it are as dark as they are mysterious.

Abyss Mysticism is difficult and time consuming to learn, and comes at a cost. Its rituals often have side effects that create Flaws the character cannot remove that provide no bonus points. To learn the power, a vampire must have at least one dot in both Obtenebration and Occult. She may not learn any Abyss rituals higher than the lowest of her Obtenebration or Occult ratings, and each ritual costs a number of experience points equal to three times the ritual’s level.

Abyss rituals are cast using a Wits + Occult roll. The difficulty is 3 + the level of the ritual being cast. Only one success is required to cast the ritual, but the Storyteller is encouraged to make the penalties for failure especially horrifying.

(More detail on Abyss Mysticism can be found in Rites of Blood, pp. 37-39.)]==],
				},
				["Animalism"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 128


Animalism


The Beast resides within all creatures, from scuttling cockroaches to scabrous rats up through untamed wolves and even powerful Kindred elders. Animalism allows the vampire to amplify his intensely primordial nature. He can not only communicate with animals, but can also force his will upon them, directing such beasts to do as he commands. As the vampire grows in power, he can even control the Beast within mortals and other supernaturals.
Beasts grow distinctly agitated in the presence of a vampire who lacks this Discipline or the Skill of Animal Ken, often to the point of attacking or running from the vampire. In contrast, vampires possessing Animalism exude a dominant vibe to lower creatures, which attracts them.
Animalism is commonly found with vampires of the Gangrel and Nosferatu Clans. Manipulation and Charisma are important for the use of Animalism powers; the stronger the vampire’s personality, the more influence he has over animals.

• Feral Whispers
This power is the basis from which all other Animalism abilities grow. The vampire creates an empathic connection with a beast, thereby allowing him to communicate or issue simple commands. The Kindred locks eyes with the animal, transmitting his desires through sheer force of will. Although it isn’t necessary to actually "speak" in chirps, hisses, or barks, some vampires find that doing so helps strengthen the connection with the animal. Eye contact must be maintained the entire time; if it’s broken, the Kindred must re-establish contact to continue communication.
The simpler the creature, the more difficult it becomes to connect with the animal’s Beast. Mammals, predatory birds, and larger reptiles are relatively easy to communicate with. Insects, invertebrates, and most fish are just too simple to connect with.
Feral Whispers provides no guarantees that an animal will want to deal with the vampire, nor does it ensure that the animal will pursue any requests the vampire makes of it. Still, it does at least make the creature better disposed toward the Kindred. The manner in which the vampire presents his desires to the animal often depends on the type of creature. A Kindred can often bully smaller beasts into heeding commands, but he’s better off couching orders for large predators as requests.
If the vampire successfully uses the power, the animal performs the command to the best of its ability and intellect. Only the very brightest creatures understand truly complex directives (orders dealing with conditional situations or requiring abstract logic). Commands that the animal does understand remain deeply implanted, however, and guide its behavior for some time.
System: No roll is necessary to talk with an animal, but the character must establish eye contact (see p. 152) first. Issuing commands requires a Manipulation + Animal Ken roll. The difficulty depends on the creature: Predatory mammals (wolves, cats, vampire bats) are difficulty 6, other mammals and predatory birds (rats, owls) are difficulty 7, and other birds and reptiles (pigeons, snakes) are difficulty 8. This difficulty is reduced by one if the character speaks to the animal in its "native tongue," and can be adjusted further by circumstances and roleplaying skill (we highly recommend that all communication between characters and animals be roleplayed).
The number of successes the player achieves dictates how strongly the character’s command affects the animal. One success is sufficient to have a cat follow an individual and lead the character to the same location, three successes are enough to have a raven spy on a target for weeks, and five successes ensure that a grizzly ferociously guards the entrance to the character’s wilderness haven for some months.
The character’s Nature plays a large part in how he approaches these conversations. The character might try intimidating, teasing, cajoling, or rationalizing. The player should understand that he does not simply play his character in these situations, but the Beast Within as well.
Using this power cannot force an animal to do something against its nature, or to force a creature to risk its life. While the aforementioned grizzly would stand guard to the vampire’s haven and even fight for it, it would not do so against obviously superior numbers or something overwhelmingly supernatural. A predatory bird might be convinced to harry a target, but would definitely not hold ground. A docile dog or skittish cat would have no problem with reporting something it had seen, but it wouldn’t enter combat unless given no other option — though it would likely agree to stand and fight and then flee at the first opportunity, if a harsh Kindred demanded it.

•• Beckoning
The vampire’s connection to the Beast grows strong enough that he may call out in the voice of a specific type of animal — howling like a wolf, shrilling like a raven, etc. This call mystically summons creatures of the chosen type. Since each type of animal has a different call, Beckoning works for only a single species at a time.
All such animals within earshot are summoned, and some percentage of them will heed the Beckoning if it is successful. While the vampire has no further control over the beasts who answer, the animals who do are favorably disposed toward him and are at least willing to listen to the Kindred’s concerns. (The vampire can then use Feral Whispers on individual animals to command them, which may be at a decreased difficulty at Storyteller discretion.)
System: The player rolls Charisma + Survival (difficulty 6) to determine the response to the character’s call; consult the table below. Only animals that can hear the cry will respond. If the Storyteller decides no animals of that type are within earshot, the summons goes unanswered.
The call can be as specific as the player desires. A character could call for all bats in the area, for only the male bats nearby, or for only the albino bat with the notched ear he saw the other night.
1 success — A single animal responds.
2 successes — One-quarter of the animals within earshot respond.
3 successes — Half of the animals respond.
4 successes — Most of the animals respond.
5 successes — All of the animals respond.

••• Quell the Beast
As the supreme predators of the natural world, Kindred are highly attuned to the bestial nature that dwells within every mortal heart. A vampire who develops this power may assert his will over a mortal (animal or human) subject, subduing the Beast within her. This quenches all powerful, strong emotions — hope, fury, love, fear — within the target. The Kindred must either touch his subject or stare into her eyes to channel his will effectively.
Mortals who lack the fire of their inner Beasts are quite tractable, reacting to even stressful situations with indifference. Even the most courageous or maddened mortal becomes apathetic and listless, while an especially sensitive individual may suffer from a phobic derangement while under the power’s influence.
Different Clans evoke this power in different ways, though the effect itself is identical. Tzimisce call it Cowing the Beast, since they force the mortal’s weaker spirit to shrivel in fear before the Kindred’s own inner Beast. Nosferatu refer to it as Song of Serenity, since they soothe the subject’s Beast into a state of utter complacency, thus allowing them to feed freely. Gangrel know the power as Quell the Beast, and force the mortal spirit into a state of fear or apathy as befits the individual vampire’s nature.
System: The player rolls Manipulation + Intimidation if forcing down the Beast through fear, or Manipulation + Empathy if soothing it into complacency. The difficulty of the roll is 7 in either case. This is an extended action requiring as many total successes as the target has Willpower. Failure indicates that the player must start over from the beginning, while a botch indicates that the vampire may not affect that subject’s Beast for the remainder of the scene.
When a mortal’s Beast is cowed or soothed, she can no longer use or regain Willpower. She ceases all struggles, whether mental or physical. She doesn’t even defend herself if assaulted, though the Storyteller may allow a Willpower roll if the mortal believes her life is truly threatened. To recover from this power, the mortal’s player rolls Willpower (difficulty 6) once per day until she accumulates enough successes to equal the vampire’s Willpower. Kindred cannot be affected by this power.
Though a vampire’s Beast cannot be cowed with this ability, the Storyteller may allow characters to use the "soothing" variation of this power to pull a vampire out of frenzy. With three or more successes, the frenzying vampire may roll again to pull herself out of frenzy, using the same difficulty as the stimulus that caused the frenzy originally.

•••• Subsume the Spirit
By locking his gaze with that of an animal, the vampire may mentally possess the creature. Some elders believe that since animals don’t have souls but spirits, the vampire can move his own soul into the animal’s body. Many younger vampires think it a matter of transferring one’s consciousness into the animal’s mind. In either case, it’s agreed that the beast’s weaker spirit (or mind) is pushed aside by the Kindred’s own consciousness. The vampire’s body falls into a motionless state akin to torpor while his mind takes control of the animal’s actions, remaining this way until the Kindred’s consciousness returns.
Some haughty Tzimisce eschew this power, considering it debasing to enter the body of a lesser creature. When they do stoop to using it, they possess only predators. Conversely, Gangrel revel in connecting to the natural world in this way. They delight in sampling different animals’ natures.
System: The player rolls Manipulation + Animal Ken (difficulty 8) as the character looks into the animal’s eyes (see sidebar on p. 152). The number of successes allows the character to employ some mental Disciplines while possessing the animal, as noted below.
1 success — Cannot use Disciplines.
2 successes — Can use Auspex and other sensory powers.
3 successes — Can also use Presence and other powers of emotional manipulation.
4 successes — Can also use Dementation, Dominate, and other powers of mental manipulation.
5 successes — Can also use Chimerstry, Necromancy, Thaumaturgy, and other mystical powers.
This power entwines the character’s consciousness closely with the animal’s spirit, so much so that the character may continue to think and feel like that animal even after breaking the connection. This effect continues until the character spends a total of seven nights or three Willpower points to resist and finally overcome the animal nature. This should be roleplayed, though the character will be affected to a lesser degree if the player chooses to spend Willpower.
At the end of any particularly exciting incident during possession, the player rolls Wits + Empathy (difficulty 8) for the character to retain his own mind. Failure indicates that the character’s mind returns to his own body, but still thinks in purely animalistic terms. A botch returns the character to his body, and also sends him into frenzy.
The character may travel as far from his own physical body as he chooses while possessing the animal. The character retains no conscious connection with his vampire body during this time, though. The vampire may also venture out during the day, albeit in the animal’s body. However, the character’s own body must be awake to do so, requiring a successful roll to remain awake (see p. 262). If the character leaves the animal’s body (by choice, if his body falls asleep, or after sustaining significant injury), the vampire’s consciousness returns to his physical form instantaneously.
Although the vampire has no conscious link to his body while possessing the animal, he does form a sympathetic bond. Anything the animal feels, the vampire also experiences, from pleasure to pain. In fact, any damage the animal’s body sustains is also applied to the character’s body, though the Kindred body may soak as normal. If the animal dies before the vampire’s soul can flee from the body, the character’s body falls into torpor. Presumably this is in sympathetic response to the massive trauma of death, but some Kindred believe that the vampire’s soul is cast adrift during this time and must find its way back to the body.

••••• Drawing Out the Beast
At this level of Animalism, the Kindred has a keen understanding of the Beast Within, and is able to release his feral urges upon another mortal or vampire. The recipient of the vampire’s Beast is instantly overcome by frenzy. This is an unnatural frenzy, however, as the victim is channeling the Kindred’s own fury. As such, the vampire’s own behavior, expressions, and even speech patterns are evident in the subject’s savage actions.
Gangrel and Tzimisce are especially fond of unleashing their Beasts onto others. Gangrel do so to stir their ghouls into inspired heights of savagery during combat. Tzimisce care less about who receives their Beast than retaining their own composure.
System: The player must announce his preferred target (since it must be someone within sight, Drawing Out the Beast cannot be used if the vampire is alone), then roll Manipulation + Self-Control/Instinct (difficulty 8). Refer to the table below for the results:
1 success — The character transfers the Beast, but unleashes it upon a random individual.
2 successes — The character is stunned by the effort and may not act next turn, but transfers the Beast successfully. Alternatively, the character may act normally during the turn, but must spend a Willpower point or suffer a single level of lethal damage.
3+ successes — The character transfers the Beast successfully.
If the attempt fails, the character himself immediately enters frenzy. As the character relaxes in expectation of relieving his savage urges, the Beast takes that opportunity to dig deeper. In this case, the frenzy lasts twice as long as normal and is twice as difficult to shrug off; its severity also increases exponentially. Botching this roll is even more catastrophic; the heightened frenzy grows so extreme that not even expending Willpower curbs its duration or effects. The character is a hapless victim to the terrible fury of his Beast, and may well hurl herself into a savage, flesh-rending rampage that leaves the Masquerade (and unfortunate nearby onlookers) in tatters.
If the character leaves the target’s presence before the frenzy expends itself, the vampire loses his Beast, perhaps permanently. While no longer vulnerable to frenzy, the character cannot use or regain Willpower and becomes increasingly lethargic. To recover the Beast, he must find the person who now possesses it (who likely isn’t enjoying herself very much) and coax the Beast into its proper vessel. The most effective way to do so is to behave in ways that make the Beast want to return — however, this isn’t a guarantee that it will wish to do so. Alternatively, the character can simply kill the host (thus causing the Beast to return to the vampire immediately).]==],
				},
				["Assamite Sorcery"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 440


Assamite Sorcery


From a purely functional standpoint, the blood magic that the Assamite sorcerer caste practices differs little from that wielded by the Tremere. From a philosophical perspective, however, worlds of difference separate the two. The Tremere force every piece of knowledge they incorporate into the structured, rigid framework of high Hermetic invocation. By contrast, the sorcerer caste’s practices are the result of millennia of adaptation and melding, and are too disparate to be considered "structured" in any real sense. The modern body of knowledge that is Assamite Sorcery draws its content from a wide array of magical traditions, from the ecstatic rites of Kali and Shiva’s followers to the subtle precision of feng shui to the elegant symbolic and mathematical transformations of Islamic alchemists and astronomers.
Assamite Sorcery is mechanically identical to the more common Thaumaturgy that appears on pp. 212-240. However, though they work on similar principles (the use of vampiric vitae to fuel exertions of conscious will in order to effect change upon the physical or spiritual world), the two are not cross-compatible. A Tremere strives to perform his magic the same way, all the time, every time. An Assamite might never enact the same ritual the same exact way twice in a millennium.
As may be expected, students of Assamite Sorcery have great difficulty learning the practices of other blood magic traditions. All experience points costs to learn other blood magic paths and rituals are increased by half (round up) for Assamite sorcerers. In addition, even once the sorcerer has incorporated these lessons into her repertoire, they are still alien to her. All invocations of a "foreign" path require one extra blood point and all rituals take triple the normal time and require one extra success for any desired result.

The sorcerers have equivalent teachings for many common blood magic techniques in addition to their own unique lessons. The following list is not an exhaustive coverage of everything in the Great Library, but it is a starting point for players and Storytellers who wish to determine the capabilities of Assamite sorcerers. Names in parentheses are the names that the sorcerer caste prefers to use for each item, if the Assamite name differs from the commonly accepted one. Paths marked with an asterisk are usually options for an Assamite sorcerer to learn as his primary path, provided his instructor approves.
Paths: The Path of Blood, The Lure of Flames*, Movement of the Mind*, The Path of Conjuring, Hands of Destruction
Rituals: Defense of the Sacred Haven (Curtain of Will), Wake with Evening’s Freshness (Black Sunrise), Communicate with Kindred Sire (Speak with Sire), Deflection of Wooden Doom (Turn the Impaling Shaft), Ward versus Ghouls, Principal Focus of Vitae Infusion (Draught of the Pebble), Incorporeal Passage (Passage of the Ghul), Bone of Lies (Stain of Guilt)]==],
				},
				["Auspex"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 134


Auspex


Auspex gives the vampire uncanny sensory abilities. She starts with the capacity to heighten her natural senses significantly, but as she grows in power, she can perceive psychic auras and read the thoughts of another being. Auspex can also pierce through mental illusions such as those created by Obfuscate — see the sidebar "Seeing the Unseen" on p. 142 for more.
However, a vampire with Auspex needs to be careful. Her increased sensory sensitivity can cause her to be drawn in by beautiful things or stunned by loud noises or pungent smells. Sudden or dynamic events can disorient an Auspex-using character unless her player makes a Willpower roll to block them out (difficulty of at least 4, although the more potent the source of distraction, the higher the difficulty). Failure overwhelms the character’s senses, making her oblivious to her surroundings for a turn or two. While the Malkavians and Toreador are more prone to these kinds of distractions, the Tremere and Tzimisce aren’t immune.
Dots in Perception are very useful for using Auspex powers, as more successes help the character gain more sensory information.

• Heightened Senses
This power increases the acuity of all of the vampire’s senses, effectively doubling the clarity and range of sight, hearing, and smell. While her senses of taste and touch extend no farther than normal, they likewise become far more distinct; the vampire could taste the hint of liquor in a victim’s blood or feel the give of the board concealing a hollow space in the floor. The Kindred may magnify her senses at will, sustaining this heightened focus for as long as she desires. At the Storyteller’s option, this may make hunting easier.
Occasionally, this talent provides extrasensory or even precognitive insights. These brief, unfocused glimpses may be odd premonitions, flashes of empathy, or eerie feelings of foreboding. The vampire has no control over these perceptions, but with practice can learn to interpret them with a fair degree of accuracy.
Expanded senses come at a price, however. Bright lights, loud noises and strong smells present a hazard while the vampire uses this power. In addition to the possibility for distraction, an especially sudden or potent stimulus (like the glare of a spotlight or a clap of thunder) can blind or deafen the Kindred for an hour or more.
System: It takes a reflexive action to activate this ability, but no roll or other cost is required. In certain circumstances, dice rolls associated with using the character’s sense (such as Perception + Alertness) decrease in difficulty by a number equal to the character’s Auspex rating when the power is engaged.
The Storyteller may also use this power to see if the character perceives a threat. In this case, the Storyteller privately rolls the character’s unmodified Auspex rating, applying whatever difficulty he feels best suits the circumstances. For example, sensing that a pistol is pointed at the back of the character’s head may require a roll of difficulty 5, while the sudden realization that a rival for Primogen is planning her assassination may require a 9. Note that even this "precognition" comes only as a result of interpreting details the Kindred is able to notice. It’s not an all-purpose insight or miraculous revelation.
At the character’s discretion, she may selectively heighten one specific sense, rather than leaving them all on. In these cases, the difficulty to perceive stimuli using that sense drops by one, but the difficulty to avoid distraction or temporary bedazzlement increases by one.
This power does not let characters see in pitch darkness, as does Eyes of the Beast (p. 199), but it does reduce difficulty penalties to act in such darkness from +2 to +1, and the character may make ranged attacks in pitch darkness if she can hear, smell, or otherwise detect her foe.

•• Aura Perception
Using this power, the vampire can perceive the psychic "auras" that radiate from mortals and supernatural beings alike. These halos comprise a shifting series of colors that take practice to discern with clarity. Even the simplest individual has many shifting hues within his aura; strong emotions predominate, while momentary impressions or deep secrets flash through in streaks and swirls.
The colors change in sympathy with the subject’s emotional state, blending into new tones in a constantly dancing pattern. The stronger the emotions involved, the more intense the hues become. A skilled vampire can learn much from her subject by reading the nuances of color and brilliance in the aura’s flow.
Aside from perceiving emotional states, vampires use Aura Perception to detect supernatural beings. The colors in Kindred auras, while intense, are quite pale; mage halos often flare and crackle with arcane power; the race of shapeshifters has strikingly bright, almost frantic, auras; ghosts have weak auras that flicker fitfully like a dying flame; and faerie creatures’ radiance is shot through with capricious rainbow hues.
System: After the character stares at the subject for at least a few seconds, the player rolls Perception + Empathy (difficulty 8); each success indicates how much of the subject’s aura the character sees and understands (see the table below). A failure indicates that the play of colors and patterns yields no prevailing impression. A botch indicates a false or erroneous interpretation. The Storyteller may wish to make this roll, thus keeping the player in the dark as to the veracity of the character’s interpretation.
1 success — Can distinguish only the shade (pale or bright).
2 successes — Can distinguish the main color.
3 successes — Can recognize the color patterns.
4 successes — Can detect subtle shifts.
5 successes — Can identify mixtures of color and pattern.
The Aura Colors chart offers some example ideas of common colors and the emotions they reflect that Storytellers can use. Note that it is nearly impossible to determine with certainty if a particular character is lying or not with this power – vampires are inherently deceitful by nature, but even mortals might react with anxiety to questions while still being truthful. It is, however, helpful in determine the target’s emotional state, which might lead the vampire to decide that a particular target is suspicious.
A character may choose to perform a very cursory aura scan of a large area like a nightclub’s dance floor or the audience in a gallery. In this case, the player decides which characteristic of auras she’s looking for, and that’s the only information she’s able to glean if the roll is successful. (At the Storyteller’s discretion, on this general scan roll, more successes on the roll may more quickly yield what the character seeks.) For example, the player may specify, "Who’s the most nervous person in attendance?" or "Are there any vampirically pale auras among the CEO’s entourage?" Thereafter, the player may narrow down her scrutiny of a single individual, with an additional roll as normal.
The character may focus in on a particular subject’s aura only once per scene with any degree of clarity. Any subsequent attempts that result in failure should be considered botches. It is very easy for the character to imagine seeing what she wants to see when judging someone’s intentions. After 24 hours, the character may try again at no penalty.
It is possible, though difficult, to sense the aura of a being who is otherwise invisible to normal sight. Refer to "Seeing the Unseen," p. 142, for more information.
Aura Colors
Afraid — Orange
Aggressive — Purple
Angry — Red
Bitter — Brown
Calm — Light Blue
Compassionate — Pink
Conservative — Lavender
Depressed — Gray
Desirous or Lustful — Deep Red
Distrustful — Light Green
Envious — Dark Green
Excited — Violet
Generous — Rose
Happy — Vermilion
Hateful — Black
Idealistic — Yellow
Innocent — White
Lovestruck — Blue
Obsessed — Green
Sad — Silver
Spiritual — Gold
Suspicious — Dark Blue
Anxious — Auras appear scrambled like static or white noise
Confused — Mottled, shifting colors
Diablerist — Black veins in aura
Daydreaming — Sharp flickering colors
Frenzied — Rapidly rippling colors
Psychotic — Hypnotic, swirling colors
Vampire — Aura colors are pale
Ghoul — Pale blotches in the aura
Magic Use — Myriad sparkles in aura
Werebeast — Bright, vibrant aura
Ghost — Weak, intermittent aura
Faerie — Rainbow highlights in aura

••• The Spirit’s Touch
When someone handles an object for any length of time, he leaves a psychic impression on the item. A vampire with this level of Auspex can "read" these sensations, learning who handled the object, when he last held it, and what was done with it recently. (For these purposes, a corpse counts as an "object" and can be read accordingly.) These visions are seldom clear and detailed, registering more like a kind of "psychic snapshot." Still, the Kindred can learn much even from such a glimpse. Although most visions concern the last person to handle the item, a long-time owner leaves a stronger impression than someone who held the object briefly.
Gleaning information from the spiritual residue requires the vampire to hold the object and enter a shallow trance. She is only marginally aware of her surroundings while using The Spirit’s Touch, but a loud noise or jarring physical sensation breaks the trance instantly.
System: The player rolls Perception + Empathy. The difficulty is determined by the age of the impressions and the mental and spiritual strength of the person or event that left them. Sensing information from a pistol used for a murder hours ago may require a 4, while learning who owned a bloodstained puppet fashioned a century ago might be a 9.
The greater the individual’s emotional connection to the object, the stronger the impression he leaves on it — and the more information the Kindred can glean from it. Events involving strong emotions (a gift-giving, a torture, a long family history) likewise leave stronger impressions than short or casual contact do. Assume that each success offers one piece of information, as per the chart below.
Botch — The character is overwhelmed by psychic impressions for the next 30 minutes and unable to act.
Failure — No information of value.
1 success — Very basic information: the last owner’s gender or hair color, for instance.
2 successes — A second piece of basic information.
3 successes — More useful information about the last owner, such as age and state of mind the last time he used the item.
4 successes — The person’s name.
5+ successes — A wealth of information: nearly anything you want to know about the person’s relationship with that object is available.
At the Storyteller’s discretion, some impressions on objects may be so strong — a knife plunged into Caesar’s breast, the tip of the Spear of Destiny, a fang pulled from the maw of Dracula — that any use of this power may be deemed a success.

•••• Telepathy
The vampire projects a portion of her consciousness into a nearby mortal’s mind, creating a mental link through which she can communicate wordlessly or even read the target’s deepest thoughts. The Kindred "hears" in her own mind the thoughts plucked from a subject as if they were spoken to her.
This is one of the most potent vampiric abilities, since, given time, a Kindred can learn virtually anything from a subject without him ever knowing. The Tremere and Tzimisce in particular find this power especially useful in gleaning secrets from others, or for directing their mortal followers with silent precision.
System: The player rolls Intelligence + Subterfuge (difficulty of the subject’s current Willpower points). Projecting thoughts into the target’s mind requires one success. The subject recognizes that the thoughts come from somewhere other than his own consciousness, though he cannot discern their actual origin without a successful Perception + Awareness roll (difficulty equal to the vampire’s Manipulation + Subterfuge).
To read minds, one success must be rolled for each item of information plucked or each layer of thought pierced. Deep secrets or buried memories are harder to obtain than surface emotions or unspoken comments, requiring five or more successes to access.
Reading thoughts with Telepathy does not commonly work upon the undead mind. A character may expend a Willpower point to make the effort, making the roll normally afterward. Likewise, it is equally difficult to read the thoughts of other supernatural creatures. However, the character may project her thoughts without expending a Willpower point. These thoughts, however, are still obviously intrusions into the target’s mind, but the character may attempt to disguise her mental "voice" with a roll of Manipulation + Subterfuge (difficulty equals the target’s Perception + Awareness) so the target doesn’t recognize her as the "speaker."
Storytellers are encouraged to describe thoughts as flowing streams of impressions and images, rather than as a sequence of prose (powers such as Telepathic Communication are of more use for that). Instead of making flat statements like "He’s planning on killing his former lover’s new boyfriend," say "You see a fleeting series of visions: A couple kissing passionately in a doorway, then the man walking alone at night; you suddenly see your hands, knuckles white, wrapped around a steering wheel, with a figure crossing the street ahead; your heart, mortal now and hammering with panic as you hear the engine rev wildly; and above all, a blazing anger coupled with emotional agony and a panicked fear of loss." Such descriptions not only add to the story, but they also force the player to interpret for herself what her character gleans. After all, understanding minds — especially highly emotional or deranged minds — is a difficult and often puzzling task.

••••• Psychic Projection
The Kindred with this awesome ability projects her senses out of her physical shell, stepping from her body as an entity of pure thought. The vampire’s astral form is immune to physical damage or fatigue, and can "fly" with blinding speed anywhere across the earth — or even underground — so long as she remains below the moon’s orbit.
The Kindred’s material form lies in a torpid state while her astral self is active, and the vampire isn’t aware of anything that befalls her body until she returns to it. An ephemeral silver cord connects the Kindred’s psyche to her body. If this cord is severed, her consciousness becomes stranded in the astral plane (the realm of ghosts, spirits, and shades). Attempting to return to the vampire’s physical shell is a long and terrifying ordeal, especially since there is no guarantee that she will accomplish the journey successfully. This significant danger keeps many Kindred from leaving their bodies for long, but those who dare can learn much.
System: Journeying in astral form requires the player to expend a point of Willpower and make a Perception + Awareness roll. Difficulty varies depending on the distance and complexity of the intended trip; 5 is within sight, 7 is nearby or to a familiar location, and 9 reflects a trip far from familiar territory (a first journey from North America to the Far East; trying to shortcut through the earth). The greater the number of successes rolled, the more focused the character’s astral presence is, and the easier it is for her to reach her desired destination.
Failure means the character is unable to separate her consciousness from her body, while a botch can have nasty consequences — flinging her astral form to a random destination on Earth or in the spirit realm, arriving in a place where the sun is active (necessitating a frenzy roll, although the sunlight doesn’t do any damage), or hurtling toward the desired destination so forcefully that the silver cord snaps.
The player may spend a point of Willpower to activate this power, and an additional point of Willpower to gain the success necessary to perform the jaunt. This is an exception to the normal rule where a player may not spend more than a single point of Willpower per turn.
Each scene in Psychic Projection requires another point of Willpower and a new roll. Failure indicates that the vampire has lost her way and must retrace the path of her silver cord. A botch at this stage means the cord snaps, stranding the character’s psychic form in the mysterious astral plane.
An astral form may travel at great speeds (the Storyteller can use roughly 1000 miles per hour or 1500 kilometers per hour as a general guide) and carries no clothing or material objects of any kind. Some artifacts are said to exist in the spirit world, and the character can try to use one of these tools if she finds one. The character cannot bring such relics to the physical world when she returns to her body, however.
Interaction with the physical world is impossible while using Psychic Projection. At best, the character may spend a Willpower point to manifest as a ghostlike shape. This apparition lasts one turn before fading away; while she can’t affect anything physically during this time, the character can speak. Despite lacking physical substance, an astral character can use Auspex normally. At the Storyteller’s discretion, such a character may employ some or all Animalism, Dementation, Dominate, Necromancy, Obtenebration, Presence, Thaumaturgy, and similar non-corporeal powers she has, though this typically requires a minimum of three successes on the initial Psychic Projection roll.
If two astral shapes encounter one another, they interact as if they were solid. They may talk, touch, and even fight as if both were in the material world. Since they have no physical bodies, astral characters seeking to interact "physically" substitute Mental and Social Traits for Physical ones (Wits replaces Dexterity, Manipulation supplants Strength, and Intelligence replaces Stamina). Due to the lack of a material form, the only real way to damage another psychic entity is to cut its silver cord. When fighting this way, consider Willpower points to be health levels; when a combatant loses all of her Willpower, the cord is severed.
Although an astrally projected character remains in the reflection of the mortal world, she may venture further into the spirit realms, especially if she becomes lost. Other beings with particular sensitivity to psychic activity, such as ghosts, werewolves, and even some magi, travel the astral plane as well, and can interact with a vampire’s psychic presence normally (although the astrally projected character is not considered a "ghost" for powers such as Necromancy). The observing character notices the astrally projecting vampire with a Perception + Awareness roll (difficulty 8), requiring more successes than the Psychic Projection activation roll. Even those who do notice you won’t be able to identify you; you are merely an immaterial shade hovering in the general area. Storytellers are encouraged to make trips into the spirit world as bizarre, mysterious, and dreamlike as possible. The world beyond is a vivid and fantastic place, where the true nature of things is stronger and often strikingly different from their earthly appearances.

Seeing the Unseen (p. 142)
Auspex enables Kindred to perceive many things beyond the limits of lesser senses. Among its many uses, Auspex can detect the presence of a supernatural being who is hidden from normal sight (a vampire using Obfuscate, for example, or a ghost) or pierce illusions created by the Discipline of Chimerstry. Note: "Normal sight" includes regular, non-Auspex use of the Awareness skill.
• Obfuscate: When a vampire tries to use her heightened perceptions to notice a Kindred hidden with Obfuscate, she detects the subject’s presence if her Auspex rating is higher than his Obfuscate, and she succeeds at a Perception + Awareness roll (difficulty equals 7 minus the number of dots by which her Auspex exceeds his Obfuscate). Conversely, if the target’s Obfuscate outranks her Auspex, he remains undiscovered. If the two ratings are equal, both characters make a resisted roll of Perception + Awareness (Auspex user) against Manipulation + Subterfuge (Obfuscate user). The difficulty for both rolls is 7, and the character with the most successes wins.
• Chimerstry: Likewise, vampires with Auspex may seek to penetrate illusions created with Chimerstry. The Auspex-wielder must actively seek to pierce the illusion (i.e., the player must tell the Storyteller that his character is trying to detect an illusion). The Auspex-user and Chimerstry-wielder then compare relative ratings, per Obfuscate, above. The process is otherwise identical to piercing Obfuscate.
• Other Powers: Since the powers of beings like magi and wraiths function differently from vampiric Disciplines, a simple comparison of relative ratings isn’t applicable. To keep things simple, both characters make a resisted roll. The vampire rolls Perception + Awareness, while the subject rolls Manipulation + Subterfuge. Again, the difficulty is 7, and the character with the most successes wins.]==],
				},
				["Bardo"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 442


Bardo


This Discipline has been handed down since Osiris himself first discovered this path. It involves attainment of a constant state of mystical consciousness, only achieved by the rigid, ascetic unlife of the Children. This Discipline is not the same state as Golconda. Golconda is a realization and acceptance of the way things are, while the Children’s Disciplines are based on denial. They deny the Beast within them by intensely concentrating on their Humanity and their state of death. If a Child was to give up his meditations and discipline, he would be assailed by his Beast.
The Child must maintain Humanity equal to their highest level of ability, or else lose that ability. For example, a Child must have a Humanity of 9 to gain the ninth level of attainment. If the Child’s Humanity ever drops below the required level, then the ability of that level is lost and must be bought all over again with experience points. The Child can counteract this with Restore Humanitas (below).
A Child of Osiris cannot follow any type of moral code other than Humanity.

• Restore Humanitas
The first thing that the Children of Osiris are taught is that Humanity does not have to be an inexorable slide into depravity. Instead, it is more akin to a climb up an extremely steep hill. The vampire is going to lose some ground, but with perseverance and strength, he can regain it.
System: When the vampire loses a dot of Humanity, he can attempt to regain it without spending experience points by using this power. The Child must use this power within a week of losing the Humanity, and must not have lost any more Humanity since the initial loss (that is, if the character falls from Humanity 8 to Humanity 7, and then falls to Humanity 6 before using this power, Restore Humanitas can only be used to recover Humanity 7). The character meditates for several hours, and spends all of the blood points currently in his body. The player then rolls Conscience (difficulty equal to the level of Humanity being regained). If the roll succeeds, the character regains the dot of Humanity and (if applicable) the dot of Conscience lost to a botched degeneration roll. If the character gained a derangement, it fades within a week of using Restore Humanitas.

•• Banishing Sign of Thoth
The character gestures, turning aside any supernatural effect aimed at her. The source of the effect does not matter. She can thwart, or at least blunt, the strength of any mystical attack. This sign was supposedly taught to Osiris by Thoth, the Egyptian god of wisdom and magic. What Thoth actually was — vampire, mortal, or spellcaster — is lost to time.
System: The player spends a blood point and rolls Dexterity + Occult (difficulty 7). This power can be used to "dodge" any incoming attack of a mystical nature, including any Disciplines that target the character (whether or not they actually inflict damage). Any successes the player rolls are subtracted from the successes on the attacker’s roll. The sign does not serve to turn aside magically enhanced physical attacks; a punch from a vampire with the Potence Discipline still has the full effect.

••• Gift of Apis
All vampires must consume blood, no matter how good their intentions. While this basic fact of undeath cannot be circumvented, the Children of Osiris can at least avoid drinking human blood.
System: Animal blood is just as nourishing to the character as human blood. An animal is considered to have a blood pool equal to the number of health levels it has, rather than the lesser value usually assigned to represent the creature’s less-than-filling fluids (see p. 270 for more on drinking from animals). This ability is always active.

•••• Pillar of Osiris
In the center of every temple is a Pillar of Osiris, a place of meditation and power in which the Children’s magic is greatly increased. At this level of Bardo, the character learns to create such a Pillar, meaning that he can create his own temple.
System: Creating the Pillar of Osiris requires a night-long ritual, with the difficulty determined by the location. The more remote and free from violence the location is, the lower the difficulty. A cave far from human populations that has never seen violence might be difficulty 5, which the site of a grisly murder-suicide in a downtown area would be difficulty 9. The player spends a Willpower point and rolls Willpower. Success creates the Pillar, which does not require a physical pillar — the Pillar of Osiris is conceptual, not literal.
Once the Pillar is created, any vampire with at least one dot of Bardo receives a -3 to the difficulties of any Discipline or other mystical activity (including blood magic) performed at the Pillar. However, this requires regular trips to the Pillar. Once the vampire has created a Pillar, he must visit it at least once a month, or it ceases to function. In addition, for every week he is away from a Pillar (not necessarily the one he created), the difficulties of all rolls to avoid frenzy increase by one. The Beast, long denied by the Child’s ascetic practices, grows in strength while away from the Pillar, and eventually pushes the vampire to frenzy and (likely) Humanity loss. The Children of Osiris, for this and other reasons, do not leave their temples for long.

••••• Paradox
The Child utters a phrase or a riddle that lays bare the truth of the universe to a listener. That truth — the perspective of that one listener’s importance weighed against the whole of creation — is enough to immobilize the target for short while. Although this experience would seem to be disheartening, after the fact the targets are loath to harm the Child. Whether that’s because of a newfound appreciation for one’s place in the world, or out of fear that the vampire will reveal the paradox again, no one really knows.
System: The vampire speaks the phrase, and the player spends a point of Willpower and rolls Manipulation + Occult (difficulty equal to the listener’s current Willpower). If multiple listeners are present, the player rolls against the highest difficulty. If the roll is successful, the listener(s) is immobilized for the scene as he contemplates what he has heard. Striking the victim snaps him out of it. At the end of the scene, the paradox is gone, and the target can’t ever quite explain it. He does, however, suffer a permanent +1 difficulty to harm or act against the Child of Osiris.]==],
				},
				["Celerity"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 142


Celerity


Not all vampires are slow, meticulous creatures. When needed, some vampires can move fast — really fast. Celerity allows Assamites, Brujah, and Toreadors to move with astonishing swiftness, becoming practically a blur. The Assamites use their speed in conjunction with stealth to strike quickly and viciously from the shadows before they are noticed. Brujah, on the other hand, simply like the edge that the power gives them against overwhelming odds. The Toreador are more inclined to use Celerity to provide an air of unnatural grace to live performances or for an extra push to complete a masterpiece on time, but they can be as quick to draw blood as any assassin or punk when angered.
System: Each point of Celerity adds one die to every Dexterity-related dice roll. In addition, the player can spend one blood point to take an extra action up to the number of dots he has in Celerity at the beginning of the relevant turn; this expenditure can go beyond her normal Generation maximum. Any dots used for extra actions, however, are no longer available for Dexterity-related rolls during that turn. These additional actions must be physical (e.g., the vampire cannot use a mental Discipline like Dominate multiple times in one turn), and extra actions occur at the end of the turn (the vampire’s regular action still takes place per her initiative roll).
Normally, a character without Celerity must divide their dice if she wants to take multiple actions in a single turn, as per p. 248. A character using Celerity performs his extra actions (including full movement) without penalty, gaining a full dice pool for each separate action. Extra actions gained through Celerity may not in turn be split into multiple actions, however.]==],
				},
				["Chimerstry"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 144


Chimerstry


The Ravnos are known as masters of illusion, although the reason why is lost to history. Rumors abound of Ravnos ghûls, rakshasas, and shapeshifters, but whatever its origins, Chimerstry remains a potent and powerful weapon for the Deceivers. The Discipline is, fundamentally, an art of conjuration that converts the vampire’s will into phantoms that confound the senses and technology alike. Even vampires fall under the sway of the Ravnos’ illusory world, unless they have a strong enough grasp of Auspex (see p. 142). The Ravnos often use this power to swindle and seduce their victims into acts that work out badly for the victim (but great for the Ravnos).
Illusions created by Chimerstry can be seen for what they are by a victim who "proves" the illusion’s falsehood (e.g., a person who walks up to an illusory wall, expresses his disbelief in it, and puts his hand through it effectively banishes the illusion), and explicitly incredible illusions are seen as false immediately (e.g., dragons breathing fire or gravity working in reverse). Sometimes, frequent targets of Chimerstry end up attempting to disbelieve everything around them, leading to derangements (and, quite often, to the amusement of the Ravnos).

• Ignis Fatuus
The vampire may conjure a minor, static mirage that confounds one sense. For instance, he may evoke a sulfurous stench, the appearance of stigmata, or the shatter of broken glass. Note that though tactile illusions can be felt, they have no real substance; an invisible but tactile wall cannot confine anyone, and invisible razor-wire causes no real damage. Similarly, the vampire must know the characteristics of what he’s creating. While it’s easy enough to estimate what a knife wound might look like, falsifying a person’s voice or a photograph of a childhood home requires knowledge of the details.
System: The player spends a point of Willpower for the vampire to create this illusion. The volume of smells, ambient lighting, smoke clouds, and the like are limited to roughly 20 cubic feet (half a cubic meter) per dot the vampire has in Chimerstry. The illusion lasts until the vampire leaves its vicinity (such as stepping out of the room) or until another person sees through it somehow. The Cainite may also end the illusion at any time with no effort.

•• Fata Morgana
The Cainite can now create illusions that appeal to all the senses, though they remain static. For example, the vampire could make a filthy cellar appear as an opulent ballroom, though she could not create a glittering chandelier or a score of graceful dancers. Again, the illusion has no solid presence, though it’s easy enough to fool an enraptured visitor with suggestions of what she might expect. A bucket of brackish water is as cool as chilled champagne, after all.
System: The player spends a Willpower point and a blood point to create the illusion. These static images remain until dispelled, in much the same way that an Ignis Fatuus illusion does.

••• Apparition
Not really a power unto itself, Apparition allows a vampire to give motion to an illusion created with Ignis Fatuus or Fata Morgana. Thus, the Cainite could create the illusion of a living being, running water, fluttering drapes, or a roaring fire.
System: The creator spends one blood point to make the illusion move in one significant way, or in any number of subtle ways. For example, the vampire could create the illusion of a lurking mugger lurching at her victim, or she could create the illusion of a desolate street, down which a chill wind blows trash while a streetlamp flickers and hums. Taking complicated actions besides maintaining the illusion — that is, anything that would require a dice roll — first requires success on a Willpower roll, resulting in the dissolution of the false construct if the roll fails.
Once the creator stops concentrating on the illusion, it can continue in simple, repetitive motions – roughly speaking, anything that can be described in a simple sentence, such as a guard walking back and forth in front of a steel door. After that, the vampire cannot regain control over the illusion – she can either allow it to continue moving as ordered, or let it fade as described under Ignis Fatuus.

•••• Permanency
This power, also used in conjunction with Ignis Fatuus or Fata Morgana, allows a mirage to persist even when the vampire cannot see it. In this way, Ravnos often cloak their temporary havens in false trappings of luxury, or ward off trespassers with illusory guard dogs.
System: The vampire need only spend a blood point, and the illusion becomes permanent until dissolved (including "programmed" illusions like those created by Apparition).

••••• Horrid Reality
Rather than create simple illusions, the vampire can now project hallucinations directly into a victim’s mind. The target of these illusions believes completely that the images are real; a hallucinatory fire can burn him, an imaginary noose can strangle him, and an illusory wall can block him. This power affects only one person at a time; though others can see the illusion, it doesn’t impact them in the same way. Other people can try to convince the victim that his terrors are not real, but he won’t believe them. Note that targets with enough dots in Auspex can still attempt to roll for Seeing the Unseen (p. 142).
System: A Horrid Realty illusion costs two Willpower points to set in motion and lasts for an entire scene (though its effects may last longer; see below). If the vampire is trying to injure his victim, his player must roll Manipulation + Subterfuge (difficulty of the victim’s Perception + Self-Control/Instinct). Each success inflicts one health level of lethal damage on the victim that cannot be soaked — the Cainite assaults the victim’s mind and perceptions, not his body. If the player wishes to inflict less damage or change it to bashing, he may announce a maximum amount of damage before rolling the dice. Secondary effects (such as frenzy rolls for illusory fire) may also occur.
The victim heals all his damage instantaneously if he can be convinced that the damage he took was illusory, but convincing him may take some doing, such as with at least two successes on a Charisma + Empathy roll (difficulty equal to the Manipulation + Subterfuge of the Cainite using Horrid Reality). The target must be convinced of the attack’s illusory nature within 24 hours of its taking place, or it becomes too well established in his memory, and he will have to heal the damage using blood (if a vampire) or over time (if mortal).
This power cannot actually kill its victims (though a target with a heart condition may well die from fright). A victim "killed" by an illusory attack loses consciousness or enters torpor.]==],
				},
				["Daimonion"] = {
					en = [==[Vampire: The Dark Ages 20th Anniversary Edition, p. 208


Daimonion


Ripped from the whispers of those bound to the earth, a voice torn from the throat of the first sorcerers who called to the Abyss sings through Baali blood. Damionion is a cry across Creation, stretching from this world to a place forsaken, and power comes along the echo that returns. Someday, the Baali bloodline will scream, and that shout will shatter the world. For now, they use Daimonion to softly lull others to sleep and bid them dream of fire and darkness.
Characters with True Faith are more resistant to the Baali’s darkness. Subtract a victim’s True Faith rating from all rolls to activate Daimonion powers against her. This includes secondary targeting rolls, such as the roll to hit with Tormented Essence.

• Sense the Sin
Every jewel has a fault, and every man has a vice. The best way to shatter a jewel is to strike that fault, and the best way to shatter a man is to hammer his vice. This power allows the Baali to find a target’s particular vice and glean their secrets with a glance.
System: Roll Perception + Empathy against living or undead beings; the difficulty is equal to the subject’s Self-Control or Instinct +4. Success indicates the Baali has gleaned insight into the subject’s weakness. With one success, this is information like a low Virtue, weak Willpower, or recent actions that violated the subject’s Road. Two successes might yield a beloved vice or casual secret. Three or more yield a central Derangement or formative trauma from the subject’s past.

•• Fear of the Void
Once you know a subject’s vices, manipulating them is easy. Converting vices of pleasure into waves of existential terror is a greater trick. Speaking in soft tones of primeval horror, the Baali inflames her victim’s traumas.
System: The Baali must first successfully use Sense the Sin or another method to learn the target’s secrets or fears. She must then speak to the target, mocking his insecurities with her tone. A successful Wits + Intimidation roll (difficulty of the subject’s Courage +4) drives the victim into furious fits of terror. Two successes causes panicked flight similar to Rötschreck, while three causes an inflamed Derangement (Storyteller’s choice) and four or more causes catatonia. All effects last for the remainder of the scene. Mortals and supernatural creatures bound to strong emotions (such as fae or ghosts) may not contest this roll; other supernatural creatures may make a contested Courage roll (difficulty of the Baali’s Willpower).

••• Tormented Essence
The Baali know their place in the universe and within the hierarchy of their masters. Suffering trickles downward, and the Baali stand within that torrent. Calling on the torment in their blood, the Baali may hurl a blazing bolt of infernal pain at their enemies. Nerves cry out, wood turns to ash, stone melts, and flesh disintegrates utterly.
System: Spend a blood point. The character gathers infernal pain into their hands; most commonly this manifests as a bolt of black flame, but sickening-hued lightning or slick black tentacles are just as common. Regardless, the power creates a missile that inflicts one die of aggravated damage. More blood points may be spent to increase the size and damage of the missile, for one die per point. The player rolls Dexterity + Occult (difficulty 6) to hit the target, who may dodge as normal. As with any normal attack, successes add to the damage dice pool. Vampires confronted with this power make Rötschreck checks (at difficulty 8), regardless of the power’s form. Interestingly, this power is doubly effective against demons and other spirits, whose corporeal forms react poorly to the stuff of torment. Against such creatures, each blood point becomes two dice of damage instead of one.

•••• Psychomachia
Prudentius was a Roman poet who wrote the Psychomachia – "the Battle of Souls," describing the struggle of faith against idolatry and vice. Baali know this game, and they play to win. With this power, the vampire combines the ability to read a victim’s psyche with the ability to rend spiritual matter. Psychomachia breathes infernal life into the target’s vice, forcing the victim to act the hero and literally battle her inner demons.
System: After successfully using Sense the Sin, the vampire forces the target to roll his lowest Virtue (difficulty of the Baali’s Willpower). Failing this roll brings any Derangements the target possesses to the fore, pitting them against a personified apparition of the victim’s vice summoned from her darker self. A botch indicates the target has been overwhelmed and frenzies — or becomes possessed by his dark passenger. A failure results in a literal fight between the two, though this may take the form of any conflict, such as an abusive argument rather than a physical battle.
The assailant is a Storyteller character with traits equivalent or slightly inferior to the victim’s. Targets with a low Road score face significantly more powerful opposition (+1 to all traits for every level of Road less than 5). The wounds inflicted by the mind are illusory, though they can force a mortal into catatonia or a vampire into torpor upon a phantom "death." The phantasm vanishes on their defeat or the Baali’s loss of concentration.

••••• Condemnation
The Children of Baal relish the opportunity to importune dark energies into the waking world. With this power, the Baali levies a curse upon her victim, drawing upon the tormented might of their blood to work their will upon fate.
System: An Intelligence + Occult roll (difficulty equal to the subject’s Willpower) dictates the length and severity of the curse. Successes must be split between both these effects, as per the sidebar below.
Curses with zero successes allotted to duration last for one night. The Baali may choose to end the curse at any time, but they rarely do so. Storytellers should feel free to invent creative or story-appropriate curses. At five successes, a Baali may rip a demon out of a mortal host or relic and fling it back to Hell, but they only do so against the most recalcitrant.
Condemnation
1 success — Up to one week — "Your lightest footfalls are as childish stomps." — All Steath rolls are at +3 difficulty.
2 successes — One month — "Sicken and wither, and feel the weakness of your blood." — The difficulty of all Stamina rolls increases by two, or vampire loses four soak dice.
3 successes — One year — "Live forever in fear: those you respect seek your betrayal." — The vampire suffers increased Social roll difficulties, or the character cannot benefit from Allies or Contacts.
4 successes — Ten years — "Feel the godling in your veins crushed, and your future progeny vanished." — The character cannot Embrace childer or create ghouls.
5 successes — Permanent — "Doom will be upon you, and your missteps become fatal and final." — Simple failures are considered botches.]==],
				},
				["Dark Thaumaturgy"] = {
					en = [==[Rites of Blood, p. 112


Dark Thaumaturgy


Dark Thaumaturgy is expressly defined as "sorcery taught by demons." As such, Dark Thaumaturgy is absolutely, unashamedly, viciously evil. Other items also fall into this realm. The Baali Discipline of Daimoinon, which requires the user to call out demonic names and speak infernal blessings, is infernal and corrupts the user’s soul with each use. All of these powers require a point of morality loss when they are first used, and continuing tests against a character’s Conscience each time they are used after the first — unless the user of such powers has traded their morality for the Path of Evil Revelations. Some examples start on p. 167.]==],
				},
				["Dementation"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 147


Dementation


Dementation is the Discipline that allows a vampire to focus and channel madness into the minds of those around him. Though it’s the natural legacy of the Malkavians, practitioners of Dementation need not actually be mad to use the Discipline… but it helps.
Disturbingly, Dementation doesn’t actually make their victims mad, but rather it seems to break down the doors to the hidden darkness of the target’s mind, releasing into the open whatever is found there. The Malkavians claim that this is because insanity is the next logical step in mental evolution, a transhumanist advancement of what modern people consider consciousness. Other Kindred scoff that this reasoning is an outright justification for the chaos that Dementation brings. They don’t scoff too loudly, however, lest the Malkavian advance their consciousness next.

• Passion
The vampire stirs his victim’s emotions, either heightening them to a fevered pitch or blunting them until the target is completely desensitized. The Cainite may not choose which emotion is affected; she may only amplify or dull emotions already present in the target. In this way, a vampire can inflame mild irritation into quivering rage or atrophy true love into casual interest.
System: The character talks to her victim, and the vampire’s player rolls Charisma + Empathy (difficulty equals the victim’s Humanity or Path rating). The number of successes determines the duration of the altered state of feeling. Effects of this power might include one- or two-point additions or subtractions to difficulties of frenzy rolls, Virtue rolls, rolls to resist Presence powers, etc.
1 success — One turn
2 successes — One hour
3 successes — One night
4 successes — One week
5 successes — One month
6+ successes — Three months

•• The Haunting
The vampire manipulates the sensory centers of his victim’s brain, flooding the victim’s senses with visions, sounds, scents, or feelings that aren’t really there. The images, regardless of the sense to which they appeal, are only fleeting "glimpses," barely perceptible to the victim. The vampire using Dementation cannot control what the victim perceives, but may choose which sense is affected.
The "haunting" effects occur mainly when the victim is alone, and mostly at night. They may take the form of the subject’s repressed fears, guilty memories, or anything else that the Storyteller finds dramatically appropriate. The effects are never pleasant or unobtrusive, however. The Storyteller should let her imagination run wild when describing these sensory impressions; the victim may well feel as if she is going mad, or as if the world is.
System: After the vampire speaks to the victim, the player spends a blood point and rolls Manipulation + Subterfuge (difficulty of his victim’s Perception + Self-Control/Instinct). The number of successes determines the length of the sensory "visitations." The precise effects are up to the Storyteller, though particularly eerie or harrowing apparitions can certainly reduce dice pools for a turn or two after the manifestation.
1 success — One night
2 successes — Two nights
3 successes — One week
4 successes — One month
5 successes — Three months
6+ successes — One year

••• Eyes of Chaos
This peculiar power allows the vampire to take advantage of the fleeting clarity hidden in insanity. She may scrutinize the "patterns" of a person’s soul, the convolutions of a vampire’s inner nature, or even random events in nature itself. The Kindred with this power can discern the most well-hidden psychoses, or gain insight into a person’s true self. Malkavians with this power often have (or claim to have) knowledge of the moves and countermoves of the great Jyhad, or the patterns of fate.
System: This power allows a vampire to determine a person’s true Nature, among other things. The vampire concentrates for a turn, then her player rolls Perception + Occult. The difficulty depends on the intricacy of the pattern. Discerning the Nature of a stranger would be difficulty 9, a casual acquaintance would be an 8, and an established ally a 6. The vampire could also read the message locked in a coded missive (difficulty 7), or even see the doings of an invisible hand in such events as the pattern of falling leaves (difficulty 6). Almost anything might contain some hidden insight, no matter how trivial or meaningless. The patterns are present in most things, but are often so intricate they can keep a vampire spellbound for hours while she tries to understand their message.
This is a potent power, subject to adjudication. Storytellers, this power is an effective way to introduce plot threads for a chronicle, reveal an overlooked clue, foreshadow important events, or communicate critical information a player seeks. Important to its use, though, is delivering the information properly. Secrets revealed via Eyes of Chaos are never simple facts; they’re tantalizing symbols adrift in a sea of madness. Describe the results of this power in terms of allegory: "The man before you appears as a crude marionette, with garish features painted in bright stage makeup, and strings vanishing up into the night sky." Avoid stating plainly, "You learn that this ghoul is the minion of a powerful Methuselah."

•••• Voice of Madness
By merely addressing his victims aloud, the Kindred can drive targets into fits of blind rage or fear, forcing them to abandon reason and higher thought. Victims are plagued by hallucinations of their subconscious demons, and try to flee or destroy their hidden shames. Tragedy almost always follows in the wake of this power’s use, though offending Malkavians often claim that they were merely encouraging people to act "according to their natures." Unfortunately for the vampire concerned, he runs a very real risk of falling prey to his own voice’s power.
System: The player spends a blood point and makes a Manipulation + Empathy roll (difficulty 7). One target is affected per success, although all potential victims must be listening to the vampire’s voice.
Affected victims fly immediately into frenzy or a blind fear like Rötschreck. Kindred or other creatures capable of frenzy, such as Lupines, may make a frenzy check or Rötschreck test (Storyteller’s choice as to how they are affected) at +2 difficulty to resist the power. Mortals are automatically affected and don’t remember their actions while berserk. The frenzy or fear lasts for a scene, though vampires and Lupines may test as usual to snap out of it.
The vampire using Voice of Madness must also test for frenzy or Rötschreck upon invoking this power, though his difficulty to resist is one lower than normal. If the initial roll to invoke this power is a failure, however, the roll to resist the frenzy is one higher than normal. If the roll to invoke this power is a botch, the frenzy or Rötschreck response is automatic.

••••• Total Insanity
The vampire coaxes the madness from the deepest recesses of her target’s mind, focusing it into an overwhelming wave of insanity. This power has driven countless victims, vampire and mortal alike, to unfortunate ends.
System: The Kindred must gain her target’s undivided attention for at least one full turn to enact this power. The player spends a blood point and rolls Manipulation + Intimidation (difficulty of her victim’s current Willpower points). If the roll is successful, the victim is afflicted with five derangements of the Storyteller’s choice (see p. 290). The number of successes determines the duration.
1 success — One turn
2 successes — One night
3 successes — One week
4 successes — One month
5+ successes — One year
On a botch… well, the Storyteller can decide what a vampire inflicts upon herself by attempting to incite the primal hells lurking within the darkest recesses of a victim’s mind.
The victim (or the target of a botch) can spend a number of Willpower points equal to the successes rolled to end the duration prematurely. The Storyteller decides when such Willpower points can be spent (such as after a therapy session or after a friend has managed to prove a particular delusion to be false).]==],
				},
				["Dominate"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 151


Dominate


Dominate is one of the most dreaded of Disciplines. It is a vampire’s ability to influence another person’s thoughts and actions through her own force of will. Dominate requires that the vampire capture her victim’s gaze (see p. 152); as such, it may be used against only one subject at a time. Further, commands must be issued verbally, although simple orders may be made with signs — for example, a pointed finger and forceful expression to indicate "Go!" However, the subject won’t comply if he can’t understand the vampire, no matter how powerful the Kindred’s will is.
Perhaps unsurprisingly, vampires to which Dominate comes naturally tend to be from willful, domineering Clans. The Giovanni, Lasombra, Tremere, and Ventrue all consider an iron will to be a boon, and are eager to impose that iron will on any who would move against them.

• Command
The vampire locks eyes with the subject and speaks a one-word command, which the subject must be obey instantly. The order must be clear and straightforward: run, agree, fall, yawn, jump, laugh, surrender, stop, scream, follow. If the command is at all confusing or ambiguous, the subject may respond slowly or perform the task poorly. The subject cannot be ordered to do something directly harmful to herself, so a command like "die" is ineffective.
The command may be included in a sentence, thereby concealing the power’s use from others. This effort at subtlety still requires the Kindred to make eye contact at the proper moment and stress the key word slightly. An alert bystander — or even the victim — may notice the emphasis. Still, unless she’s conversant with supernatural powers, the individual is likely to attribute the utterance and the subsequent action to bizarre coincidence.
System: The player rolls Manipulation + Intimidation (difficulty equals the target’s current Willpower points). More successes force the subject to act with greater vigor or for a longer duration (continue running for a number of turns, go off on a laughing jag, scream uncontrollably).
Remember, too, that being commanded to against one’s Nature confounds the use of this power. Being told to "sleep!" in a dangerous situation or "attack!" in police custody may not have the desired effect, or indeed, any effect at all.

•• Mesmerize
With this power, a vampire can verbally implant a false thought or hypnotic suggestion in the subject’s subconscious mind. Both Kindred and target must be free from distraction, since Mesmerize requires intense concentration and precise wording to be effective. The vampire may activate the imposed thought immediately or establish a stimulus that will trigger it later. The victim must be able to understand the vampire, though the two need to maintain eye contact only as long as it takes to implant the idea.
Mesmerize allows for anything from simple, precise directives (handing over an item) to complex, highly involved ones (taking notes of someone’s habits and relaying that information at an appointed time). It is not useful for planting illusions or false memories (such as seeing a rabbit or believing yourself to be on fire). A subject can have only one suggestion implanted at any time.
System: The player rolls Manipulation + Leadership (difficulty equal to the target’s current Willpower points). The number of successes determines how well the suggestion takes hold in the victim’s subconscious. If the vampire scores one or two successes, the subject cannot be forced to do anything that seems strange to her (she might walk outside, but is unlikely to steal a car). At three or four successes, the command is effective unless following it endangers the subject. At five successes or greater, the vampire can implant nearly any sort of command.
No matter how strong the Kindred’s will, his command cannot force the subject to harm herself directly or defy her innate Nature. So, while a vampire who scored five successes could make a 98-pound weakling attack a 300-pound bouncer, he could not make the mortal shoot herself in the head.
If a vampire tries to Mesmerize a subject before the target fulfills a previously implanted directive, compare the successes rolled to those gained during the implanting of the first suggestion. Whichever roll had the greater number of successes is the command that now governs in the target’s behavior; the other suggestion is wiped clean. If the successes rolled are equal, the newer command supplants the old one.

••• The Forgetful Mind
After capturing the subject’s gaze, the vampire delves into the subject’s memories, stealing or re-creating them at his whim. The Forgetful Mind does not allow for telepathic contact; the Kindred operates much like a hypnotist, asking directed questions and drawing out answers from the subject. The degree of memory alteration depends on what the vampire desires. He may alter the subject’s mind only slightly (quite effective for eliminating memories of the victim meeting or even being fed upon by the vampire) or utterly undo the victim’s memories of her past.
The degree of detail used has a direct bearing on how strongly the new memories take hold, since the victim’s subconscious mind resists the alteration. A simplistic or incomplete false memory ("You went to the movies last night") crumbles much more quickly than does one with more attention to detail ("You thought about texting your girlfriend while you were in line at the new movie theater, but you knew you’d have to turn your phone off once you got inside. You liked the movie well enough, but the plot seemed weak. You were tired after it ended, so you went home, watched a little late-night television, and went to bed.").
Even in its simplest applications, The Forgetful Mind requires tremendous skill and finesse. It’s a relatively simple matter to rifle through a victim’s psyche and rip out the memories of the previous night without knowing what the subject did that evening. Doing so leaves a gap in the victim’s mind, however — a hole that can give rise to further problems down the road. The Kindred may describe new memories, but these recollections seldom have the same degree of realism that the subject’s original thoughts held.
As such, this power isn’t always completely effective. The victim may remember being bitten, but believe it to be an animal attack. Greater memories may return in pieces as dreams, or through sensory triggers like a familiar odor or spoken phrase. Even so, months or years may pass before the subject regains enough of her lost memories to make sense of the fragments.
A vampire can also sense when a subject’s memories were altered through use of this power, and even restore them, as a hypnotist draws forth suppressed thoughts.
System: The player states what sorts of alteration he wants to perform, then rolls Wits + Subterfuge (difficulty equal to the target’s current Willpower points). Any success pacifies the victim for the amount of time it takes the vampire to perform the verbal alteration, provided the vampire does not act aggressively toward her. The table below indicates the degree of modification possible to the subject’s memory. If the successes rolled don’t allow for the extent of change the character desired, the Storyteller reduces the resulting impact on the victim’s mind.
1 success — May remove a single memory; lasts one day.
2 successes — May remove, but not alter, memory permanently.
3 successes — May make slight changes to memory.
4 successes — May alter or remove entire scene from subject’s memory.
5 successes — May reconstruct entire periods of subject’s life.
To restore removed memories or sense false ones in a subject, the character’s Dominate rating must be equal to or higher than that of the vampire who made the alteration. In that situation, the player must make a Wits + Empathy roll (difficulty equal to the original vampire’s permanent Willpower rating) and score more successes than his predecessor did. However, the Kindred cannot use The Forgetful Mind to restore his own memories if they were stolen in such a way.

•••• Conditioning
Through sustained manipulation, the vampire can make a subject more pliant to the Kindred’s will. Over time, the victim becomes increasingly susceptible to the vampire’s influence while simultaneously growing more resistant to the corrupting efforts of other Kindred. Gaining complete control over a subject’s mind is no small task, taking weeks or even months to accomplish.
Kindred often fill their retainers’ heads with subtle whispers and veiled urges, thereby ensuring these mortals’ loyalty. Yet vampires must pay a high price for the minds they ensnare. Servants Dominated in this way lose much of their passion and individuality. They follow the vampire’s orders quite literally, seldom taking initiative or showing any imagination. In the end, such retainers become like automatons or the walking dead.
System: The player rolls Charisma + Leadership (difficulty equal to the target’s current Willpower points) once per scene. Conditioning is an extended action, for which the Storyteller secretly determines the number of successes required. It typically requires between five and 10 times the subject’s Self-Control/Instinct rating. Targets with more empathic Natures may require a lower number of successes, while those with willful Natures require a higher total. Only through roleplaying may a character discern whether his subject is conditioned successfully.
A target may become more tractable even before becoming fully conditioned. Once the vampire accumulates half the required number of successes, the Storyteller may apply a lower difficulty to the vampire’s subsequent uses of Dominate. After being conditioned, the target falls so far under the vampire’s influence that the Kindred need not make eye contact or even be present to retain absolute control. The subject does exactly as she is told (including taking actions that would injure herself), as long as her master can communicate with her verbally. No command roll is necessary unless the subject is totally isolated from the vampire’s presence (in a different room, over the phone). Even if a command roll fails, the target will still likely carry out part of the orders given, simply because her master wishes it.
After the subject is fully conditioned, other Kindred find her more difficult to Dominate. Such conditioning raises others’ difficulties by two (to a maximum of 10).
It is possible, though difficult, to shake Conditioning. The subject must be separated entirely from the vampire to whom she was in thrall. This period of separation varies depending on the individual, but the Storyteller may set it at six months, less a number of weeks equal to the subject’s permanent Willpower rating (so a person with 5 Willpower must stay away from the vampire for just under five months). The subject regains her personality slowly during this time, though she may still lapse into brief spells of listlessness, despair, or even anger. If the vampire encounters the target before that time passes, a single successful Charisma + Leadership roll (difficulty of the target’s current Willpower points) on the part of the vampire completely reasserts the dominance.
If the subject makes it through the time period without intervention by her master, the target regains her former individuality. Even so, the vampire may reestablish conditioning more easily than the first time, since the subject is now predisposed to falling under the Kindred’s mental control. New attempts require half the total number of successes than the last bout of conditioning did (which means the subject reaches the threshold for reduced difficulties sooner, as well).

••••• Possession
At this level of Dominate, the force of the Kindred’s psyche is such that it can utterly supplant the mind of a mortal subject. Speaking isn’t required, but the vampire must capture the victim’s gaze. During the psychic struggle, the contestants’ eyes are locked on one another.
Once the Kindred overwhelms the subject’s mind, the vampire moves his consciousness into the victim’s body and controls it as easily as he uses his own. The mortal falls into a mental fugue while under possession. She is aware of events only in a distorted, dreamlike fashion. In turn, the vampire’s mind focuses entirely on controlling his mortal subject. His own body lies in a torpid state, defenseless against any actions made toward it.
Vampires cannot possess one another in this fashion, as even the weakest Kindred’s mind is strong enough to resist such straightforward mental dominance. Only through a blood bond can one vampire control another to this degree. Supernatural creatures also cannot be possessed in this way, although ghouls that have drunk from the vampire using Possession can.
System: The vampire must completely strip away the target’s Willpower prior to possessing her. The player spends a Willpower point, then rolls Charisma + Intimidation, while the subject rolls his Willpower in a resisted action (difficulty 7 for each). For each success the vampire obtains over the victim’s total, the target loses a point of temporary Willpower. Only if the attacker botches can the subject escape her fate, since this makes the target immune to any further Dominate attempts by that vampire for the rest of the story.
Once the target loses all her temporary Willpower, her mind is open. The vampire rolls Manipulation + Intimidation (difficulty 7) to determine how fully he assumes control of the mortal shell. Similar to the Animalism power Subsume the Spirit, multiple successes allow the character to utilize some mental Disciplines, noted on the chart below. (Vampires possessing ghouls can use the physical Disciplines the ghoul possesses, but not the mental ones.)
1 success — Cannot use Disciplines
2 successes — Can use Auspex and other sensory powers
3 successes — Can also use Presence and other powers of emotional manipulation
4 successes — Can also use Dementation, Dominate, and other powers of mental manipulation
5 successes — Can also use Chimerstry, Necromancy, Thaumaturgy, and other mystical powers
The character may travel as far from his body as he is physically able while possessing the mortal. The vampire may also venture out during the day in the mortal form. However, the vampire’s own body must be awake to do so, requiring a successful roll to remain awake (see p. 262). If the vampire leaves the mortal shell (by choice, if his body falls asleep, through supernatural expulsion, after sustaining significant injury, etc.), his consciousness returns to his physical form in an instant.
Once freed from possession, the mortal regains mental control of herself. This can happen in an instant, or the victim may lie comatose for days while her psyche copes with the violation.
The vampire experiences everything the mortal body feels during possession, from pleasure to pain. In fact, any damage the victim’s body sustains is also applied to the character’s body (though the Kindred may soak as normal). If the mortal dies before the vampire’s soul can flee from the body, the character’s body falls into torpor. Presumably this is in sympathetic response to the massive trauma of death, though some Kindred believe that the vampire’s soul is cast adrift during this time and must find its way back to the body.
The Kindred can remain in the mortal’s body even if his own torpid form is destroyed, though such a pathetic creature is not likely to exist for long. At each sunrise, the vampire must roll Courage (difficulty 8) or be expelled from the body. If forced from the mortal body, the vampire tumbles into the astral plane, his soul permanently lost in the spirit world. A vampire trapped in a mortal body may not be "re-Embraced." If the Embrace occurs to such a creature, he simply meets Final Death.

Eye Contact (p. 152)
Many myths and stories exist about a vampire’s mystical ability to put people under her spell by looking deeply into her victim’s eyes. The persistence of such stories through the ages isn’t surprising, since a number of Kindred Disciplines powers (most notably Dominate) require eye contact in order to work. Other vampires, learning of this requirement, have attempted everything from wearing mirrored sunglasses to gouging out their own eyes in order to prevent an elder from exerting his will upon them.
But Kindred are not so easily thwarted.
The need for eye contact stems from the aggressor Kindred’s need to see his victim’s soul, and the eyes are the traditionally known as the windows to the soul. While the vampire needs to capture his target’s attention, the target’s eyes need not be present for such a power to work (although the arts of the Tzimisce make this somewhat challenging at times) — they only need to find the soul of his victim laid bare.
A target trying to avoid eye contact can make a Willpower roll against a difficulty equal to Dominate user’s Manipulation + Intimidation (or other appropriate combination for other Disciplines or specific situations, at the Storyteller’s discretion). The difficulty may be reduced for mitigating factors: -1 in the case of the target obscuring his eyes slightly (such as closing her eyes or wearing dark sunglasses) up to a -3 for the eyes being completely unseen (such as with a thick blindfold or having her eyes torn out). Ultimately, however, it is up to the Storyteller to decide whether eye contact is established in a particular case.]==],
				},
				["Flight"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 447


Flight


Gargoyles possess a fourth in-clan Discipline, called Flight. All Gargoyles start with a free dot, and it can be increased like any other Discipline. As the Gargoyle gains dots of Flight, he becomes capable of flying faster, as follows:

• The character cannot actually fly, but can soar like a hang-glider. He also cannot carry anything (he needs his hands to help steer). Maximum speed is equal to prevailing winds, or 15 miles/25 kilometers per hour in calm air.

•• The character can make a running takeoff and carry 20 pounds/10 kilograms while flying. Maximum speed is 30 miles/50 kilometers per hour.

••• The character can make a straight, vertical takeoff if unencumbered, or can make a running takeoff carrying up to 50 pounds/25 kg. Maximum air speed is 45 miles/70 kilometers per hour.

•••• The character can now make a vertical takeoff with up to 50 pounds/25 kg of baggage, but can carry up to 100 pounds/45 kg while flying. Maximum speed is 60 miles/95 kilometers per hour.

••••• The character can now carry up to 200 pounds/90 kg, easily enough to carry away an adult person (or vampire). Maximum speed is 75 miles/120 kilometers per hour.

Further dots in the Discipline add 100 pounds/45 kg of weight and 20 miles/30 kilometers per hour to the speed. Gargoyles don’t think of Flight as a Discipline. To them, it’s just flight, part and parcel to being a Gargoyle, and may be baffled by notions such as teaching it to other vampires.]==],
				},
				["Fortitude"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 158


Fortitude


Although all vampires have an unnatural constitution that make them much sturdier than mortals, Fortitude bestows a resilience that would make an action movie hero envious. Vampires with this Discipline can shrug off agonizing trauma and make the most bone-shattering impact look like a flesh wound. The power even offers protection against the traditional banes of vampires, such as sunlight and fire, and the Gangrel, Ravnos, and Ventrue all find that edge incredibly useful.
System: A character’s rating in Fortitude adds to his Stamina for the purposes of soaking normal damage (bashing and lethal). A character with this Discipline may also use his dots in Fortitude to soak aggravated damage, though Kindred cannot normally soak things like vampire bites, werewolf claws, magical effects, fire, sunlight, or massive physical trauma. See p. 272, for further details on soaking and damage.]==],
				},
				["Koldunic Sorcery"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 448


Koldunic Sorcery


The actual casting of Koldunic sorcery requires more than a clumsy exertion of will. Such magic demands perfection of form and mastery of the appropriate lore. The caster’s player spends one blood point and rolls (Attribute) + Occult against a difficulty of the power’s level + 3, with the specific Attribute listed for each path or "way." Vampires always use the base Attribute, ignoring any bonuses gained from blood expenditure or other Disciplines. All kolduns must select one of the ways listed below as their primary path.]==],
				},
				["Melpominee"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 453


Melpominee


Named for Melpomene, the Greek Muse of tragedy, the unique Discipline of the Daughters of Cacophony is one of speech and song. The powers of this Discipline explore the various uses of the voice for both benefit and harm. As is the case with mortal art, it is not always clear which of those directions these powers take. No character may have a rating in Melpominee higher than her Performance rating. Melpominee affects the subject’s soul as well as the ears; thus, it works perfectly well on deaf subjects, and has caused at least one known breach of the Masquerade due to this effect. Additionally, the powers of Melpominee work only on those who are present when it is used — Daughters of Cacophony cannot record Melpominee effects, send them across radio waves, or have them streamed over the Internet.
Daughters of Cacophony can use some of the powers of the Melpominee Discipline in concert, as it were. If more than one Siren uses the same level of this Discipline simultaneously, the difficulty for the roll falls by one for each Daughter involved beyond the first. The difficulty cannot fall lower than 3, however. The Discipline levels that can benefit from this rule are noted below.

• The Missing Voice
The character can "throw" her voice anywhere within her line of sight. This enables the Daughter to carry on surreptitious conversations, sing duets with herself, or cause any number of distractions. This power can also be combined with other Melpominee powers to disguise their source (and some Daughters use it to conceal the fact that Melpominee powers do not function through recorded media).
System: This power functions automatically as long as the character wills it. However, using The Missing Voice while performing any action other than speech or singing incurs a penalty of two dice on that action due to the disruption of the character’s concentration.

•• Phantom Speaker
The Daughter can project her voice to any individual she has personally met. Distance is no object, but it must be night wherever the target presently is. The vampire can sing, talk, or otherwise project her voice in any way she sees fit (including other uses of Melpominee), but she cannot hear what she is saying, and therefore suffers a +1 difficulty to any rolls accompanying her utterance. For instance, the vampire could project her voice to an enemy in an attempt to intimidate him, but would suffer a +1 to the difficulty of the Charisma + Intimidation roll.
System: The player rolls Wits + Performance (difficulty 7) and spends a blood point. Each success allows one turn of speech; three or more successes allow speech for an entire scene.

••• Madrigal
Music has the power to sway the listener, engendering specific emotions through artful lyrics, pounding crescendo, or haunting melody. The Daughters of Cacophony can tap into music’s power, forcing listeners to feel whatever they wish. The emotion becomes so powerful that the listener must act, though what a listener does isn’t something the Siren can directly control.
System: The player rolls Charisma + Performance (difficulty 7). Each success instills the chosen emotion in a fifth of the Kindred’s audience (more than five successes have no additional effect). The Storyteller decides precisely which members of the audience are affected. Characters may resist this power for the duration of the scene with the expenditure of a Willpower point, but only if they have reason to believe that they are being controlled by outside individuals. The song the vampire sings must also reflect the emotion she wishes to engender — no one’s going to mob the concert security no matter how well she sings "High Hopes," but they might if she performs "I Predict a Riot."
Affected individuals should act in accordance with their Natures — enraged Conformists would join a riot but not start one, aroused Bravos may force their attentions on the object of their desire, and jealous Directors may send cronies after their rivals.
Multiple Daughters may use this Discipline in concert.

•••• Siren’s Beckoning
The Daughters of Cacophony don’t spread madness as surely (or as visibly) as the Malkavians, but their songs are definitely detrimental to one’s sanity. With this power, the Daughter can drive any listener to madness. Most of the time, the victim is too fascinated to realize that he should leave the area and block out the music from his mind.
System: Siren’s Beckoning requires an extended, resisted roll. The player rolls Manipulation + Performance (difficulty equal to the target’s current Willpower); the victim resists with a Willpower roll (difficulty equal to the singer’s Appearance + Performance). If the singer accumulates five more successes than the victim at any point, the hapless soul acquires a new derangement or Psychological Flaw of the Storyteller’s choice. This derangement normally lasts for one night, with an additional night per success over five. With a total of 20 net successes, the Daughter can make it permanent.
Multiple Daughters may use this Discipline in concert.

••••• Virtuosa
Most of the low-level Melpominee powers can only be used on one target at a time. When the Daughter reaches this level of mastery in her Discipline, she can "entertain" a wider audience. Each member of the audience hears the same message.
System: The Daughter may use Phantom Speaker or Siren’s Beckoning on a number of targets equal to her Stamina + Performance. The player must spend one blood point for every five targets beyond the first.]==],
				},
				["Mytherceria"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 455


Mytherceria


Whatever odd commingling of blood which produced the Kiasyd has led to a number of weird effects, not least of which is the Mytherceria Discipline. This collection of powers mimics the abilities of faeries — or at least, that’s the best guess of the Kindred who are familiar with it. The Kiasyd use this power to alter and beguile the minds of their foes, as well as to force others to tell the truth. The Kiasyd do not, in general, teach this Discipline to those outside the bloodline, and supposedly it would require oaths sworn on the lifeblood of the student to learn.

• Folderol
The Kiasyd can cleave truth from lies. The exact effect varies from vampire to vampire. Some Kiasyd experience bleeding from the eyes or ears when they hear a lie, while some Weirdlings’ eyes glow when told a falsehood. Whatever the effect, this power detects lies, not mistakes, meaning that a target has to know he is lying in order for this power to work.
System: The character knows when a target is deliberately lying. No roll or expenditure is necessary for this power to work, but the character must deliberately activate it. Note that this power does not provide any insight into what the truth might be, nor does it enable the vampire to tell if a target is simply stating something false that he believes to be true.

•• Fae Sight
The Kiasyd’s knowledge of magic isn’t just theoretical. Their strangely-colored eyes are capable of detecting the arcane energies of the fae, as well as magic from other, more esoteric sources. They are not, however, capable of using this power to detect the residue of ghosts or vampiric magic.
System: The Kiasyd sees faeries and other fae-touched mortals for what they really are, with no roll required. Additionally, the player can detect any form of magic that does not stem from ghosts or the undead, including magic from mages, werewolves, and other such odd sources. The character can recognize these for what they truly are, provided he has seen similar effects before.

••• Aura Absorption
The Kiasyd is capable of seeing images of events and emotions past by touching an object or an area. However, unlike the Auspex Power The Spirit’s Touch, this power absorbs the images, making them harder for other beings with similar powers to access. Anyone attempting to use this power, Spirit’s Touch, or a similar ability to see what the Kiasyd has seen finds that the images are hard to hold, slipping through his mind’s eye like minnows through a stream.
System: The player must make a Perception + Empathy roll. The difficulty is determined by the Storyteller based on the age of the impressions and the mental and spiritual strength of the person who left them. The number of successes determines the amount of information gained, both in terms of images of the scene when the object was being held or touched, and the nature of the person who was holding the object. One scene-type image and one aspect of the person’s identity (Nature, Demeanor, aura, name, sex, or age) becomes clear for each success the player garners on the roll. Anyone attempting to use this power or The Spirit’s Touch on the same object subsequently must accumulate more successes than the Kiasyd did to get any impression at all. The first Kiasyd’s successes subtract from the number of successes scored by anyone trying to read the object thereafter.

•••• Chanjelin Ward
The vampire inscribes a ward on an object, a location, or a person. That ward disorients and befuddles anyone that sees it, meaning that even if an intruder can penetrate a Weirdling’s security and steal an object of value, he’s unlikely to be able to find his way to the exit. Spiteful Kiasyd use these wards as punishment — one story tells of a Weirdling that drew a ward on an enemy’s shirt as dawn approached, and then watched (from safety) as the unfortunate vampire burned in the sun, unable to remember which way to run.
System: The vampire creating the ward inscribes the symbol in a visible location — on a library door, bookshelf, or an individual’s clothing — and the player rolls Intelligence + Larceny (difficulty 7 for inanimate objects, or the subject’s current Willpower +2). Anyone entering the warded area or touching the warded object loses two dice from her Intelligence dice pools as long as she maintains contact with or proximity to the ward. Additionally, anyone seeing the ward becomes addled and lost unless she succeeds on a Wits + Investigation roll (difficulty 8). The Kiasyd is immune to his own wards. The glyphs last for a duration indicated by the number of successes on the Intelligence + Larceny roll:
1 success — One hour
2 successes — One night
3 successes — One week
4 successes — One month
5 successes — One year

••••• The Riddle Phantastique
The Kiasyd whispers a riddle to an opponent, and the riddle consumes his mind. The target can do nothing until he solves the riddle, and no one can help him — answers provided by others, even correct answers, fail to counteract this affliction.
System: The player rolls Manipulation + Occult (difficulty of the victim’s current Willpower). After a successful roll, the victim can do nothing but sit and ponder the Riddle until she accumulates three times the riddler’s successes. The subject rolls Wits + Occult (difficulty 8, plus or minus the number of derangements the victim has, at the Storyteller’s discretion). She makes this roll as soon as she is told the Riddle, and then once per hour until she has gathered enough successes. Should the victim botch on a roll to solve the Riddle, she takes one level of lethal damage as the mystical enigma racks her body, and she loses all successes from the accumulated total. This damage cannot be healed until the Riddle has been solved. The riddler can end this trance by telling the victim the answer, but no one else can.]==],
				},
				["Necromancy"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 159


Necromancy


Necromancy is both a Discipline and a school of blood magic devoted to the command of the souls of the dead. It’s similar to Thaumaturgy in that it has several "paths" and accompanying "rituals" rather than a strict linear progression of powers. The study of Necromancy is not widespread among the Kindred, and its practitioners — primarily the Giovanni — are shunned and despised for their foul practices (until those practices become useful, of course).
Over the centuries, the various schools of vampiric Necromancy have evolved and diversified from an earlier form of death magic, leaving several distinct paths of necromantic magic available to Cainites. Nearly all modern necromancers learn the Sepulchre Path first before extending their studies to other paths. The primary Necromancy path increases automatically as the character increases her overall Necromancy rating. Other paths must be bought separately, using the experience costs for secondary paths.
Like Thaumaturgy, Necromancy has also spawned a series of rituals. While not nearly so immediate in effect as the basic powers of Necromancy, Necromantic rituals can have impressive long-term effects. Unsurprisingly, the elements of Necromantic ritual are things like long-buried corpses and hands from the cadavers of hanged men, so obtaining suitable materials can be quite difficult.
System: A Cainite necromancer must learn at least three levels in his primary path before learning his first level in a secondary Necromancy path. He must then master the primary path (all five levels) before acquiring any knowledge of a third path.
As with Thaumaturgy, advancement in the primary path costs the normal experience amount, while study of additional Necromantic paths incurs an additional experience-point cost (see p. 124). Because Necromancy is not quite so rigid a study as Thaumaturgy is, the rolls required to use Necromantic powers can vary from path to path and even within individual paths. The commonly-learned Sepulchre Path is presented first, with the remaining paths presented in alphabetical order.
Statistics for ghosts may be found in Chapter Nine, p. 385.]==],
				},
				["Obeah"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 457


Obeah


The bloodline known in modern nights simply as the Salubri is actually descendant of one half of the ancient Clan. In bygone nights, one might have spoken of "healer" and "warrior" Salubri. In the modern nights, the last vestiges of the warrior Salubri are the antitribu of the Clan, and practice their Discipline of Valeren (see p. 474). The rest of the bloodline know the Discipline of Obeah. This Discipline allows the Salubri to judge and even improve a subject’s health. As the vampire grows more powerful, Obeah lets her heal a target’s soul directly. It is this power that forms the basis of the "soulsucker" charge that dogs the bloodline these nights.
This Discipline gives its practitioners a third eye in the center of the vampire’s forehead when the Kindred masters the second level of Obeah.

• Sense Vitality
With a touch, the Salubri can instantaneously read a target’s injuries. She may learn how much damage a target has incurred, and therefore make a guess at what must be done to save him. This power can also be used for diagnostic purposes — useful for a victim who can no longer speak.
System: The Salubri must touch the target to see how close to death she is. He must then make a Perception + Empathy roll (difficulty 7). One success on this roll identifies a subject as a mortal, vampire, ghoul, or other creature. Two successes reveal how many health levels of damage the subject has suffered. Three successes tell how full the subject’s blood pool is (if a vampire) or how many blood points she has left in her system (if a mortal or other blood-bearing form of life). Four successes reveal any diseases in the subject’s bloodstream. A player may opt to learn the information yielded by a lesser degree of success — for example, a player who accumulates three successes may learn whether or not a subject is a vampire as well as the contents of his blood pool.
Alternately, each success on this roll allows the player to ask the Storyteller one question about the subject’s health or health levels. "Was he drugged?" or "Are his wounds aggravated?" are valid questions, but "Did the Sabbat do this?" or "What did the Lupine who attacked him look like?" are not. The Salubri may use this power on herself if she has injuries but has somehow lost the memory of how the wounds were received.
Additionally, at the cost of one blood point, the Salubri may use Empathy for a roll instead of Medicine.

•• Anesthetic Touch
The vampire can ease a target’s pain or place him into a deep, soothing sleep with nothing but a touch. This power is intended to heal the pain or succor the mind of willing targets, but the character can, with some effort, employ the power against someone who does not wish it.
System: If the subject is willing to undergo this process, the player spends a blood point and makes a Willpower roll (difficulty 6) to block the subject’s pain. This allows the subject to ignore all wound penalties for one turn per success. A second application of this power may be made once the first one has expired, at the cost of another blood point and another Willpower roll. If the subject is unwilling for some reason, the player must make a contested Willpower roll against the subject (difficulty 8).
To put a mortal to sleep, the same system applies. The mortal sleeps for five to 10 hours — whatever his normal sleep cycle is — and regains one temporary Willpower point upon awakening. He sleeps peacefully and does not suffer nightmares or the effects of any derangements while asleep. He may be awakened normally (or violently).
Kindred, including the Salubri herself, are unaffected by this power — their corpselike bodies are too tied to death.

••• Corpore Sano
The Salubri can heal wounds with a laying-on of hands. The subject feels a warm, tingling sensation over the affected areas as pain leaves the body and flesh knits. The vampire’s third eye opens during this process.
System: This power works on any living or undead creature, but the character must touch the actual injury (or the closest part of the victim’s body, in the case of internal injuries). Each health level to be healed requires the expenditure of one blood point and one turn of contact. Aggravated wounds may also be healed in this manner, but the vampire must spend two blood points instead of one for each aggravated health level.

•••• Shepherd’s Watch
The Salubri with this level of mastery of Obeah can create an invisible barrier between those under his care and those who would do them harm. The Salubri himself must stand among his charges as he generates this barrier; he cannot defend them from afar. Enemies armed with guns or other ranged weapons can still attack, but none may approach closer than a few paces.
System: The player spends two Willpower points. Erecting this barrier is a standard action, but maintaining it from turn to turn or dropping it is a reflexive action. The invisible barrier extends to about a 3-yard/meter radius from the character, and no one outside that barrier may cross it while she maintains the power. Those within it at its creation may leave and return, however. The barrier moves with the Salubri. It cannot be maintained at a distance.
Those who wish to cross the barrier from the outside, whether friendly or hostile, must best the character in an extended, resisted Willpower roll (difficulty equals the opponent’s current Willpower for the Salubri, and the Salubri’s current Willpower for the opponent). The opponent may cross the barrier as soon as he accumulates three more net successes than the Salubri.

••••• Mens Sana
With this power, the Salubri can heal madness, quieting inner demons and bringing a soul to peace. Indeed, ancient stories of the Salubri state that Saulot used this power to bring sweet, if temporary, relief to his "brother" Malkav. Other, more recent stories claim that Saulot caused Malkav’s madness in the first place.
System: The player spends two blood points and rolls Intelligence + Empathy (difficulty 8). The use of Mens Sana takes at least 10 minutes of relatively uninterrupted conversation. Success cures the subject of one derangement of the Salubri player’s choice. This power cannot cure a Malkavian of his core derangement, though it alleviates its effects for the rest of the scene. A botch inflicts the same derangement on the Salubri for the rest of the scene. This power may not be used by the Salubri to cure her own derangements.]==],
				},
				["Obfuscate"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 184


Obfuscate


Obfuscate is the uncanny ability for Kindred to conceal themselves from sight, sometimes even in full view of a crowd. An Obfuscated vampire doesn’t actually become invisible, however — rather, he is able to delude observers into believing that he has vanished. Obfuscate also allows Kindred to change their features and conceal other people or objects. Typically vampires using Obfuscate must be within a short range of their witnesses (approximately five yards or meters per dot of Wits + Stealth) for their power to be effective.
Unless the Kindred chooses to make herself seen, she can remain obscured for as long as she wills it. At higher levels, the vampire can actually fade from sight so subtly that those nearby can’t actually recall the moment at which she left.
Usually, few mortals or supernaturals (even those trained in Awareness) can pierce through the fog of Obfuscate. Animals, who rely more on their instincts than their normal senses, can sometime perceive (and be frightened by) the vampire’s presence. Children and those to whom deception is foreign may also be able to pierce the illusion, at the Storyteller’s discretion. Finally, the Auspex Discipline enables Kindred to see through Obfuscate. Even that is not guaranteed, however; refer to "Seeing the Unseen," p. 142, for more details. (Storytellers needing a die roll for animals or children can use this quick and dirty guideline: treat them as if they had Auspex 1 in terms of contesting Obfuscate. They do not have the Auspex 1 power, but are considered to have it when determining whether a vampire is noticed.)
Since Obfuscate clouds the mind of the viewer, vampires can’t use it to hide their presence from electronic or mechanical devices. Video and photo cameras, for example, capture the vampire’s image accurately. Even so, the person using, say, her cell phone to record an Obfuscated vampire will still have her mind impacted by the power, and she won’t see the Kindred’s image until she views the video at a later date (if even then).
Several Clans cultivate this power — the Assamites, Followers of Set, and Malkavians, for example — but the Nosferatu are particularly known for this Discipline. Some elder Kindred believe that Caine, or perhaps Lilith, bestowed the Clan with this Discipline to compensate for the hideous physical deformities its members suffer.
Most Obfuscate powers last for a scene, or until the vampire ceases maintaining them. Once evoked, they require very little mental effort to keep in place.

• Cloak of Shadows
At this level, the vampire must rely on nearby shadows and cover to assist in hiding his presence. He steps into an out-of-the-way, shadowed place and eases himself from normal sight. The vampire remains unnoticed as long as he stays silent, still, under some degree of cover (such as a curtain, bush, door frame, lamppost, or alley), and out of direct lighting. The immortal’s concealment vanishes if he moves, attacks, or falls under direct light. Furthermore, the vampire’s deception cannot stand up to concentrated observation without fading.
System: No roll is required as long as the character fulfills the criteria described above. So long as he remains quiet and motionless, virtually no one but another Kindred with a high enough Auspex rating will see him.

•• Unseen Presence
With experience, the vampire can move around without being seen. Shadows seem to shift to cover him, and people automatically avert their gazes as he passes by. Others move unconsciously to avoid contact with the cloaked creature; those with weak wills may even scurry away from the area in unacknowledged fear. The vampire remains ignored indefinitely unless someone deliberately seeks him out or he inadvertently reveals himself.
Since the vampire fully retains his physical substance, he must be careful to avoid contact with anything that may disclose his presence (knocking over a vase, bumping into someone). Even a whispered word or the scuffing of a shoe against the floor can be enough to disrupt the power.
System: No roll is necessary to use this power unless the character speaks, attacks, or otherwise draws attention to himself. The Storyteller should call for a Wits + Stealth roll under any circumstances that might cause the character to reveal himself. The difficulty of the roll depends on the situation; stepping on a squeaky floorboard might be a 5, while walking through a pool of water may require a 9. Other acts may require a certain number of successes; speaking quietly without giving away one’s position, for instance, demands at least three successes. Upon success, the vampire, all her clothing, and objects that could fit into a pocket are concealed.
Some things are beyond the power of Unseen Presence to conceal. Although the character is cloaked from view while he smashes through a window, yells out, or throws someone across the room, the vampire becomes visible to all in the aftermath. Bystanders snap out of the subtle fugue in which Obfuscate put them. Worse still, each viewer can make a Wits + Awareness roll (difficulty 7); if successful, the mental haze clears completely, so those individuals recall every move the character made up until then as if he had been visible the entire time.

••• Mask of a Thousand Faces
The vampire can influence the perception of others, causing them to see a face different from his. Although the Kindred’s physical form does not change, any observer who cannot sense the truth sees whomever the vampire wishes her to see.
The vampire must have a firm idea of the visage he wishes to project. The primary decision is whether to create an imaginary face or to superimpose the features of another person. Manufactured features are often more difficult to compose in believable proportions, but such a disguise is easier to maintain than having to impersonate someone else. Of course, things get simpler if the Kindred borrows the face but doesn’t bother with the personality.
System: The player rolls Manipulation + Performance (difficulty 7) to determine how well the disguise works. If the character tries to impersonate someone, he must get a good look at the subject before putting on the mask. The Storyteller may raise the difficulty if the character catches only a glimpse. The chart below lists the degrees of success in manufacturing another appearance. Vampires wishing to mask themselves as a person more attractive than they are must pay additional blood points equal to the difference between the vampire’s Appearance rating and the Appearance of the mask (which means that younger vampires may need to take longer in order to spend the blood necessary).
1 success — The vampire retains the same height and build, with a few slight alterations to his basic features. Nosferatu can appear as normal, albeit ugly, mortals.
2 successes — He looks unlike himself; people don’t easily recognize him or agree about his appearance.
3 successes — He looks the way he wants to appear.
4 successes — Complete transformation, including gestures, mannerisms, appearance, and voice.
5 successes — Profound alteration (appear as the opposite sex, a vastly different age, or an extreme change of size).
Actually posing as someone else carries its own problems. The character should know at least basic information about the individual; especially difficult deceptions (fooling a lover or close friend) require at least some familiarity with the target in order to succeed.

•••• Vanish from the Mind’s Eye
This potent expression of Obfuscate enables the vampire to disappear from plain view. So profound is this vanishing that the immortal can fade away even if he stands directly in front of someone.
While the disappearance itself is quietly subtle, its impact on those who see it is anything but. Most kine panic and flee in the aftermath. Especially weak-willed individuals wipe the memory of the Kindred from their minds. Although vampires are not shaken so easily, even Kindred may be momentarily surprised by a sudden vanishing.
System: The player rolls Charisma + Stealth; the difficulty equals the target’s Wits + Alertness (use the highest total in the group if the character disappears in front of a crowd). With three or fewer successes, the character fades but does not vanish, becoming an indistinct, ghostlike figure. With more than three, he disappears completely. If the player scores more successes than an observer’s Willpower rating, that person forgets that the vampire was there in the first place.
Tracking the character accurately while he appears ghostlike requires a Perception + Alertness roll (difficulty 8). A successful roll means the individual can interact normally with the vampire (although the Kindred looks like a profoundly disturbing ghostly shape). A failed roll results in a +2 difficulty modifier (maximum 10) when attempting to act upon, or interact with, the vampire. The Storyteller may call for new observation checks if the vampire moves to an environment in which he’s difficult to see (heads into shadows, crosses behind an obstacle, proceeds through a crowd). When fully invisible, the vampire is handled as described under Unseen Presence, above.
A person subject to the vanishing makes a Wits + Courage roll (mortals at difficulty 9, vampires at difficulty 5). A successful roll means the individual reacts immediately (although after the vampire performs his action for that turn); failure means the person stands uncomprehending for two turns while her mind tries to make sense of what she just experienced.

••••• Cloak the Gathering
At this degree of power, the vampire may extend his concealing abilities to cover an area. The immortal may use any Obfuscate power upon those nearby as well as upon himself, if he wishes.
Any protected person who compromises the cloak exposes himself to view. Further, if the one who invokes the power gives himself away, the cloak falls from everyone. This power is particularly useful if the vampire needs to bring his retinue through a secure location without drawing the notice of others.
System: The character may conceal one extra individual for each dot of Stealth he possesses. He may bestow any single Obfuscate power at a given time to the group. While the power applies to everyone under the character’s cloak, his player need only make a single roll. Each individual must follow the requirements described under the relevant Obfuscate power to remain under its effect; any person who fails to do so loses the cloak’s protection, but doesn’t expose the others. Only if the vampire himself errs does the power drop for everyone.]==],
				},
				["Obtenebration"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 188


Obtenebration


The signature power of the Lasombra, Obtenebration grants the vampire power over darkness itself. The nature of the darkness invoked by Obtenebration is a matter of intense debate among Kindred. Some believe it to be merely shadows, while others feel that the power gives control over the stuff of the vampire’s soul, coaxing it tangibly outward.
Regardless, the effects of Obtenebration are terrifying, as waves of darkness roil out from the Cainite, enveloping those in their path like an infernal wave. As Obtenebration is mostly known as a Sabbat Discipline, any Camarilla vampire caught using the power had better have a damned good explanation.
Note: Vampires using Obtenebration can see through the darkness they control, though other vampires (even those that also have Obtenebration) cannot. Dreadful tales of rival Lasombra struggling to blind and smother each other with the same wisps of darkness circulate among young members of the Clan, though no elders have come forth to substantiate these claims.

• Shadow Play
This power grants the vampire limited control over shadows and other ambient darkness. Though the vampire cannot truly "create" darkness, she can overlap and stretch existing shadows, creating patches of gloom. This power also allows Kindred to separate shadows from their casting bodies and even shape darkness into the shadows of things that are not there.
Once a Kindred takes control of darkness or shadow, it gains a mystical tangibility. By varying accounts cold or hellishly hot and cloying, the darkness may be used to aggravate or even smother victims. Certain callous Lasombra claim to have choked mortals to death with their own shadows.
System: This power requires no roll, but a blood point must be spent to activate it. Shadow Play lasts for one scene and requires no active concentration. Kindred cloaking themselves in shadow gain an extra die in their Stealth dice pools and add one to the difficulties of ranged weapon attacks against them. Vampires who use the darkness to make themselves more terrifying add one die to Intimidation dice pools. Opponents plagued by flapping shadows and strangling darkness subtract one die from all Stamina dice pools (including soak). Mortals, ghouls, and other air-breathers reduced to zero Stamina by strangling shadows begin to asphyxiate; vampires lose all appropriate dice but are otherwise unaffected. Only one target or subject may be affected by this power at any given time, though some modicum of concealment is offered to a relatively motionless group.
The unnatural appearance of this power proves extremely disconcerting to mortals and animals (and, at the Storyteller’s discretion, Kindred who have never seen it before). Whenever this power is invoked within a mortal’s vicinity, that individual must make a Courage roll (difficulty 8) or suffer a one-die penalty to all dice pools for the remainder of the scene, due to fear of the monstrous shadows.

•• Shroud of Night
The vampire can create a cloud of inky blackness. The cloud completely obscures light and even sound to some extent. Those who have been trapped within it (and survived) describe the cloud as viscous and unnerving. This physical manifestation lends credence to those Lasombra who claim that their darkness is something other than mere shadow.
The tenebrous cloud may even move, if the creating Kindred wishes, though this requires complete concentration.
System: The player rolls Manipulation + Occult (difficulty 7). Success on the roll generates darkness roughly 10 feet (three meters) in diameter, though the amorphous cloud constantly shifts and undulates, sometimes even extending shadowy tendrils. Each additional success doubles the diameter of the cloud (though the vampire may voluntarily reduce the area she wishes to cover). The cloud may be invoked at a distance of up to 50 yards/meters, though creating darkness outside the vampire’s line of sight adds two to the difficulty of the roll and requires a blood point’s expenditure.
The tarry mass actually extinguishes light sources it engulfs (with the exception of fire), and muffles sounds until they are indistinguishable. Those within the cloud lose all sense of sight and feel as though they’ve been immersed in pitch. Sound also warps and distorts within the cloud, making it nearly impossible to accomplish anything (+2 difficulty, as per Blind Fighting on p. 274). Even those possessed of Heightened Senses, Eyes of the Beast, Tongue of the Asp, and similar powers suffer the penalty for blindness due to the unnatural darkness. Additionally, being surrounded by the Shroud of Night reduces Stamina-based dice pools by two dice, as the murk smothers and agitates the victims. This effect is not cumulative with Shadow Play, although targets asphyxiate as per Shadow Play if they reach 0 Stamina; more than one unfortunate mortal has "drowned" in darkness.
Mortals and animals surrounded by the Shroud of Night must make Courage rolls per Shadow Play, above, or panic and flee.

••• Arms of the Abyss
Refining his control over darkness, the Kindred can create prehensile tentacles that emerge from patches of dim lighting. These tentacles may grasp, restrain, and constrict foes.
System: The player spends a blood point and makes a simple (never extended) Manipulation + Occult roll (difficulty 7); each success enables the creation of a single tentacle. Each tentacle is six feet (two meters) long and possesses Strength and Dexterity ratings equal to the invoking vampire’s Obtenebration Trait — Potence and Celerity dots are added to these Strength and Dexterity ratings, respectively. If the vampire chooses, she may spend a blood point either to increase a single tentacle’s Strength or Dexterity by one or to extend its length by another six feet or two meters. Each tentacle has four health levels, is affected by fire and sunlight as if it were a vampire, and soaks bashing and lethal damage using the vampire’s Stamina + Fortitude. Aggravated damage may not be soaked.
Tentacles may constrict foes, inflicting (Strength +1) lethal damage per turn. Breaking the grasp of a tentacle requires the victim to win a resisted Strength roll against the tentacle (difficulty 6 for each). However, tentacles cannot be used for any kind of manipulation, such as typing or driving.
All tentacles need not emanate from the same source — so long as there are multiple patches of suitable darkness, there are sources for the Arms of the Abyss. Controlling the tentacles does not require complete concentration; if the Kindred is not incapacitated or in torpor, she may control tentacles while carrying out other actions.

•••• Black Metamorphosis
The Cainite calls upon his inner darkness and infuses himself with it, becoming a monstrous hybrid of matter and shadow. His body becomes mottled with spots of tenebrous shade, and wispy tentacles extrude from his torso and abdomen. Though still humanoid, the vampire takes on an almost demonic appearance, as the darkness within him bubbles to the surface.
System: The player spends two blood points and makes a Manipulation + Courage roll (difficulty 7) — vampires of lower Generation may have to take two turns to make the transition. Failure indicates the vampire cannot undergo the Black Metamorphosis (though he spends the blood points nonetheless). A botch inflicts two unsoakable health levels of lethal damage on the vampire as darkness ravages his undead body.
While under the effects of the Black Metamorphosis, the vampire possesses four tentacles similar to those evoked via Arms of the Abyss (though their Strength and Dexterity ratings are equal to the vampire’s own Attributes, including dice from Celerity and Potence). These tentacles, combined with the bands of darkness all over the Kindred’s body, subtract two dice from the Stamina and soak dice pools of opponents physically touched in combat, for as long as the vampire remains in contact with the victim. This is not cumulative with other powers in Obtenebration, although targets can asphyxiate at Stamina 0, as per Shadow Play. The vampire may make an additional attack without penalty by using the tentacles (for a total of two attacks, not one additional attack per tentacle). Additionally, the vampire can sense his surroundings fully even in pitch darkness.
The vampire’s head and extremities sometimes appear to fade away into nothingness, while at other times they seem swathed in otherworldly darkness. This, combined with the wriggling tentacles writhing from his body, creates an unsettling sight. Mortals, animals, and other creatures not accustomed to this sort of display must make Courage rolls (difficulty 8) or succumb to a panic that amounts to Rötschreck (though it is inspired by the darkness rather than fire). Many Kindred cultivate this devilish aspect, and the Black Metamorphosis adds three dice to the invoking Kindred’s Intimidation dice pools.

••••• Tenebrous Form
At this level, the Kindred’s mastery of darkness is so extensive that she may physically become it. Upon activation of this power, the vampire becomes an inky, amoeboid patch of shadow. Vampires in this form are practically invulnerable and may slither through cracks and crevices. In addition, the shadow-vampire gains the ability to see in natural darkness.
System: The transformation costs three blood points (which may need to occur over three turns, depending on the vampire’s Generation). The vampire is immune to physical attacks while in the tenebrous form (though she still takes aggravated damage from fire and sunlight), but may not herself physically attack. She may, however, envelop and ooze over others, affecting them in the same manner as a Shroud of Night, in addition to using mental Disciplines. Vampires in Tenebrous Form may even slither up walls and across ceilings or "drip" darkness upward — they have no mass and are thus unaffected by gravity. Rötschreck difficulties from fire and sunlight do increase by one for vampires in this form, as the light is even more painful to their shadowy bodies.
Mortals (and others not used to such displays) who witness the vampire transform into unholy shadow require Courage rolls (difficulty 8) in order to avoid the debilitating terror described under Black Metamorphosis.]==],
				},
				["Ogham"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 461


Ogham


The Ogham Discipline is only found among the Lhiannan bloodline; they do not (some say cannot) share its secrets with those who do not suffer from their line’s curse. All Lhiannan share a splinter of a dark, once-vast, and powerful forest spirit. Ogham allows them to tap into that spirit’s power, and into its communion with free spirits of its ilk.
Ogham is a limited form of blood magic; it is neither as flexible nor as powerful as Tremere Thaumaturgy, nor other Clans’ blood sorcery, but within the bounds set by the Lhiannan’s territorial nature it is quite powerful. Ogham is strongest within a Lhiannan’s home territory. More than 50 miles (80 km) from her home territory, the difficulty of using Ogham increases by one across the board, as the Lhiannan’s own spirit-shard comes into conflict with unfamiliar local spirit life.

• Consecrate the Grove
The Lhiannan with this ability can use the power of her blood to awaken the spirits of plant life in her territory; they will act in her defense against any unwelcome intruder. Roots tangle feet, grass grasps at boots, trees sway unnaturally in foes’ way, and so on. Typically the Lhiannan slits a wrist and whirls in place, or stabs a palm and walks a spiral pattern through the foliage that she wishes to awaken.
System: The player spends from one to three blood points, and the character must undertake the process described above. One blood point rouses the plant life in a 10-foot (3-meter) diameter; two blood points doubles that to 20 feet (6 meters); three makes it 40 feet (12 meters). Tracing the desired area takes one turn per blood point spent.
When the blood has been sown, the player rolls Charisma + Survival (difficulty 6). If the roll garners even one success, the plant life animates as the local spirit world is roused to action. Enemies in the area suffer a -2 to all dice pools from distraction and physical interference. Additionally, interlopers must make a Stamina + Athletics roll to avoid three dice of bashing damage from the local flora (provided the local plant life is capable of such damage; trees and brambles probably are, but a grassy meadow doesn’t contain the kind of flora necessary for such an assault). Botching this roll causes the plants to turn on the Lhiannan instead.
This power lasts for one scene.

•• Crimson Woad
The Lhiannan traces mystical runes or script on her own body in vitae, inviting spirits of war to infuse her and gird her for battle. While so imbued, she ignores many wounds and retains greater control of her mind as the spirits direct her Beast. The Lhiannan can also lash out at her enemies with a fierce, blood-borne attack.
System: The character spends one scene tracing the woad on her body; this costs one blood point. The player then rolls Intelligence + Occult (difficulty 7). Each success enables the character to ignore one die of wound penalties from injury. It also subtracts one from the difficulty to avoid frenzy or Rötschreck. This ability lasts through one scene. Additionally, if the character receives more than four health levels of damage, the mystic inscriptions are ruined, and the spirits flee her body.
The Lhiannan may also lash out at her enemies, adding the fury of the woad to her attack. The player may add the number of successes achieved on the above roll to the number of dice rolled for damage for a single close-combat attack (this ability can only be used once per application of Crimson Woad).

••• Inscribe the Curse
The Lhiannan inscribes the name of an enemy on her body in vitae, in whatever language or set of symbols she likes. When the name is so inscribed and the Lhiannan’s enemy can see it, baleful spirits become bound to the name and enact a curse upon that enemy. The curse takes effect the moment the victim sees his name scrawled in blood.
System: The player spends three blood points. The Lhiannan must write the foe’s name in blood, and it must be displayed on a part of her body visible to intended target in order for Inscribe the Curse to take effect. The player chooses which curse to enact on the target from the list below; the curse takes effect as soon as the target sees his name. He does not need to understand the language used, but if he can comprehend it, he may resist the curse with a Wits + Occult roll (difficulty 8).
The curses described below expire when the glyph is erased, worn off, or defaced by the Lhiannan’s taking four or more health levels of damage. The curse works differently depending on where the Lhiannan inscribes the target’s name.
Body: Inscribe the name on arms, legs, or belly. The victim’s body becomes ill and weak (+2 to all difficulties on Physical rolls, and all wound penalties are increased by one die) or, in the case of Cainites, the victim cannot use blood other than the one point per day necessary to remain active.
Mind: Inscribe the name across the forehead. The foe becomes confused as parts of his mind become disconnected from one another; he must spend one Willpower point in order to attempt any Knowledge roll or use any magical ability or Discipline (other than Celerity, Fortitude, or Potence). This Willpower doesn’t buy him a success on that roll; it simply allows him to make it.
Voice: Inscribe the name on the throat. The victim loses the power of speech; he can grunt or moan, but cannot say any words.
Soul: Inscribe the name down the sternum and over the heart. The subject loses his will to resist the Beast: difficulties to avoid frenzy are increased by two. Non-vampires are overcome by fear. The target must flee the Lhiannan’s territory unless he succeeds in a Courage roll (difficulty 8).

•••• Moon and Sun
The life of a Cainite is dominated by two celestial bodies: the sun, which she must fear and hate; and the moon, her only safe source of light. A Lhiannan can trace ancient sigils of those two orbs on her body to gain gifts – the spirit of the moon, ever the vampire’s friend, blesses her by its current phase, while the sun’s spirit wards off some of that orb’s fiery curse.
System: The player spends three blood points. The Lhiannan inscribes the desired sigil on her body over the course of 15 minutes. The sigil can be inscribed anywhere, but must be exposed. The character may choose to inscribe both the moon and the sun, but each symbol requires the blood expenditure and 15 minutes to trace it. She can also inscribe these sigils on any voluntary subject.
The sun emblem protects a vampire from the worst effects of fire and sunlight. So long as the symbol remains on the character’s body, the player makes a Stamina roll (difficulty 8) when afflicted by fire or sunlight. If the roll is successful, the damage is considered lethal and the player may roll to soak it normally. This roll must be made every time the character faces such damage.
The moon emblem adds one to the difficulties of Self-Control/Instinct rolls to avoid frenzy (but not Courage rolls to avoid Rötschreck). Other effects of the moon emblem depend on the current phase of the moon:
New Moon: Add one die to Dexterity and Stealth dice pools.
Crescent Moon: Add one die to Wits and Occult dice pools.
Half Moon: Add one die to Perception and Subterfuge dice pools.
Gibbous Moon: Add one die to Charisma and Expression dice pools.
Full Moon: Add one die to Strength and Brawl dice pools.

••••• Drink Dry the Earth
The spirit within every Lhiannan is drawn to sites of mystical energy, whether ancient stone circles, faerie rings, or dragon tracks. That spirit-shard can wrest spiritual energy out of those places of power and use it to aid the Lhiannan. A word of caution, however: stealing too much power from any mystical site renders it barren and lifeless, much as if the Cainite had consumed the very blood of the Earth. Also, wizards and werewolves frequent these same sites, and destroying these places can rouse their ire.
System: The player rolls Perception + Occult (difficulty 8). One success determines if a given location is a suitable site (a decision generally left in the Storyteller’s hands, though a Lhiannan with a high Domain Background may have such a site within her holdings). Two or more successes on this roll grants a rough idea of the site’s power on a scale of 1 to 5. If the character wishes to tap the power of that location, she must spend a scene and one blood point marking various parts of the site with sigils of power, keys for her spirit-shard to unlock the location’s energies.
Once the site is prepared, the player makes a second, reflexive Perception + Occult roll (difficulty 7). Any successes beyond the site’s power rating are ignored. For each success, the player gains two dice, which she may add to any dice pools (except those to avoid frenzy or Rötschreck) for the remainder of the scene. These dice are gone when used, but the character may tap the same location again from turn to turn. The player must make the Perception + Occult roll each time. Each "drink" of the site’s energies depletes it, however, as described below.
The Lhiannan’s spirit-shard is a greedy thing, wearing as it does the garb of a Cainite’s Beast, and drinks the site’s energies recklessly. A Lhiannan can only garner a number of successes equal to 10 times the site’s power rating, after which point the area turns into a barren wasteland, incapable of sustaining life. This sort of activity in particular is certain to attract the attention of Lupines or wizards. A site may replenish itself over a period of years. However, a site that is tapped with Drink Dry the Earth at any point during the year is unable to replenish lost dice at all that year, and if the site is completely drained, it is irrevocably dead.]==],
				},
				["Potence"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 192


Potence


Kindred endowed with Potence possess unnatural strength. This Discipline enables vampire to leap massive distances, lift tremendous weights, and strike opponents with brutal force. Even low ranks of this power can give Kindred physical power beyond mortal bounds. More powerful Kindred can leap so far that they appear to be flying, toss cars like soda cans, and punch through walls like cardboard. While the more subtle mental Disciplines can be awe-inspiring, the brutal effectiveness of Potence is formidable in its own right.
The Brujah, Giovanni, Lasombra, and Nosferatu are naturally gifted with this Discipline, but members of other Clans often make a point to find someone who can teach them the awesome power of Potence.
System: Each dot that the vampire has in Potence adds one die to all Strength-related dice rolls. Further, the player can spend one blood point and change his Potence dice into an equal number of automatic successes to all Strength-related rolls for the turn. In melee and brawling combat, successes from Potence (either rolled or automatic) are applied to the damage roll results.]==],
				},
				["Presence"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 193


Presence


Presence is the Discipline of emotional manipulation. Vampires with this power can inspire passionate fervor or unreasoning terror in mortals and Kindred alike. In addition, unlike most Disciplines, some of Presence’s powers can be used on entire crowds at one time. Presence can transcend race, religion, gender, class, and (most importantly) supernatural nature. As such, this subtle power is one of the most useful Disciplines a vampire can possess.
Anyone can resist Presence for one scene by spending a Willpower point and succeeding on a Willpower roll (difficulty 8), but the affected individual must keep spending points until he is no longer in the presence of the vampire (or, in the case of Summon, until the effect wears off). Vampires three or more Generations lower than the wielder need only spend a single Willpower to ignore the Presence for an entire night and need not roll Willpower to do so.
The major drawback of Presence is that it controls only the emotions. It causes others to feel a certain way toward the vampire, but does not give her outright control over them. While people weigh strongly the orders that the vampire declares, their minds are still their own. Suicidal or ridiculous directives don’t sound any more sensible just because the person giving them is unusually fascinating. Still, inspired eloquence or significant wealth used in combination with this Discipline can enable the vampire to urge others along a desired course.
The Brujah, Followers of Set, Toreador, and Ventrue Clans are all adept in this Discipline. The Ventrue are arguably the most skilled with its application, however, due to their ability to use Presence and Dominate in efficient combination.

• Awe
Those near the vampire suddenly desire to be closer to her and become receptive to her point of view. Awe is extremely useful for mass communication. It matters little what is said — the hearts of those affected lean toward the vampire’s opinion. The weak want to agree with her; even if the strong-willed resist, they soon find themselves outnumbered. Awe can turn a chancy deliberation into a certain resolution in the vampire’s favor almost before her opponents know that the tide has turned.
Despite the intensity of this attraction, those so smitten do not lose their sense of self-preservation. Danger breaks the spell of fascination, as does leaving the area. Those subject to Awe will remember how they felt in the vampire’s presence, however. This will influence their reactions should they ever encounter her again.
System: The player spends a blood point and rolls Charisma + Performance (difficulty 7). The number of successes rolled determines how many people are affected, as noted on the chart below. If there are more people present than the character can influence, Awe affects those with lower Willpower ratings first. The power stays in effect for the remainder of the scene or until the character chooses to drop it.
1 success — One person
2 successes — Two people
3 successes — Six people
4 successes — 20 people
5 successes — Everyone in the vampire’s immediate vicinity (an entire auditorium, a mob)
Those affected can use Willpower points to overcome the effect, but must continue spending Willpower every scene for as long as they remain in the same area as the vampire. As soon as an individual spends a number of Willpower points equal to the successes rolled, he shakes off the Awe completely and remains unaffected for the rest of the night.

•• Dread Gaze
While all Kindred can frighten others by physically revealing their true vampiric natures — baring claws and fangs, glaring with malevolence, hissing loudly with malice — this power focuses these elements to insanely terrifying levels. Dread Gaze engenders unbearable terror in its victim, stupefying him into madness, immobility, or reckless flight. Even the most stalwart individual will fall back from the vampire’s horrific visage.
System: The player rolls Charisma + Intimidation (difficulty equal to the victim’s Wits + Courage). Success indicates the victim is cowed, while failure means the target is startled but not terrified by the sight. Three or more successes means he runs away in abject fear; victims who have nowhere to run claw at the walls, hoping to dig a way out rather than face the vampire. Moreover, each success subtracts one from the target’s action dice pools next turn.
The character may attempt Dread Gaze once per turn against a single target, though she may also perform it as an extended action, adding her successes in order to subjugate the target completely. Once the target loses enough dice that he cannot perform any action, he’s so shaken and terrified that he curls up on the ground and weeps. Failure during the extended action means the attempt falters. The character loses all her collected successes and can start over next turn, while the victim may act normally again.
A botch at any time indicates the target is not at all impressed — perhaps even finding the vampire’s antics comical — and remains immune to any further uses of Presence by the character for the rest of the story.

••• Entrancement
This power bends others’ emotions, making them the vampire’s willing servants. Due to what these individuals see as true and enduring devotion, they heed the vampire’s every desire. Since this is done willingly, instead of having their wills sapped, these servants retain their creativity and individuality.
While these obedient minions are more personable and spirited than the mind-slaves created by Dominate, they’re also somewhat unpredictable. Further, since Entrancement is of a temporary duration, dealing with a lapsed servant can be troublesome. A wise Kindred either disposes of those she Entrances after they serve their usefulness, or binds them more securely by a blood bond (made much easier by the minion’s willingness to serve).
System: The player spends a blood point and rolls Appearance + Empathy (difficulty equal to the target’s current Willpower points); the number of successes determines how long the subject is Entranced, as per the chart below. (Subjects can still spend Willpower to temporarily resist, like any other Presence power.) The Storyteller may wish to make the roll instead, since the character is never certain of the strength of her hold on the victim. The vampire may try to keep the subject under her thrall, but can do so only after the initial Entrancement wears off. Attempting this power while Entrancement is already in operation has no effect.
Botch — Subject cannot be entranced for the rest of the story.
Failure — Subject cannot be entranced for the rest of the night.
1 success — One hour
2 successes — One day
3 successes — One week
4 successes — One month
5 successes — One year

•••• Summon
This impressive power enables the vampire to call to herself any person whom she has ever met. This call can go to anyone, mortal or supernatural, across any distance within the physical world. The subject of the Summons comes as fast as he is able, possibly without even knowing why. He knows intuitively how to find his Summoner — even if the vampire moves to a new location, the subject redirects his own course as soon as he can. After all, he’s coming to the vampire herself, not to some predetermined site.
Although this power allows the vampire to call someone across a staggering distance, it is most useful when used locally. Even if the desired person books the next available flight, getting to Kyoto from Milwaukee can still take far longer than the vampire needs. Obviously, the individual’s financial resources are a factor; if he doesn’t have the money to travel quickly, it will take him a far greater time to get there.
The subject thinks mainly of reaching the vampire, but does not neglect his own well-being. This is less of a consideration if he only has to cross a room, unless he must get through a gang of gun-wielding punks to do so. The individual retains his survival instincts, and while he won’t shirk physical violence to reach the vampire’s side, he won’t subject himself to suicidal situations.
The Summoning dissipates at dawn. Unless the subject is trained to continue toward the vampire after the first call, the immortal must Summon each night until the target arrives. Still, as long as the vampire is willing and able, she is assured to greet her desired subject some night — as long as nothing happens to him along the way, of course.
System: The player spends a blood point and rolls Charisma + Subterfuge. The base difficulty is 5; this increases to difficulty 7 if the subject was met only briefly. If the character used Presence successfully on the target in the past, this difficulty drops to 4, but if the attempt was unsuccessful, the difficulty rises to 8.
The number of successes indicates the subject’s speed and attitude in responding:
Botch — Subject cannot be Summoned by that vampire for the rest of the story.
Failure — Subject cannot be Summoned by that vampire for the rest of the night.
1 success — Subject approaches slowly and hesitantly.
2 successes — Subject approaches reluctantly and is easily thwarted by obstacles.
3 successes — Subject approaches with reasonable speed.
4 successes — Subject comes with haste, overcoming any obstacles in his way.
5 successes — Subject rushes to the vampire, doing anything to get to her.

••••• Majesty
At this stage, the vampire can augment her supernatural mien a thousandfold. The attractive become paralyzingly beautiful; the homely become hideously twisted. Majesty inspires universal respect, devotion, fear — or all those emotions at once — in those around the vampire. The weak scramble to obey her every whim, and even the most dauntless find it almost impossible to deny her.
People affected find the vampire so formidable that they dare not risk her displeasure. Raising their voices to her is difficult; raising a hand against her is unthinkable. Those few who shake off the vampire’s potent mystique enough to oppose her are shouted down by the many under her thrall, before the immortal need even respond.
Under Majesty’s influence, hearts break, power trembles, and the bold shake. Wise Kindred use this power with caution against mortal and immortal alike. While Majesty can cow influential politicians and venerable Primogen, the vampire must be careful that doing so doesn’t come back to haunt her. After all, a dignitary brought low before others loses his usefulness quickly, while a humiliated Kindred has centuries to plan revenge.
System: No roll is required on the part of the vampire, but she must spend a Willpower point. A subject must make a Courage roll (difficulty equal to the vampire’s Charisma + Intimidation, to a maximum of 10) if he wishes to be rude or simply contrary to the vampire. Success allows the individual to act normally for the moment, although he feels the weight of the vampire’s displeasure crushing down on him. A subject who fails the roll aborts his intended action and even goes to absurd lengths to humble himself before the vampire, no matter who else is watching. The effects of Majesty last for one scene.]==],
				},
				["Protean"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 199


Protean


Protean allows the Kindred the mystical ability to manipulate his physical form. Some vampires believe the power stems from a heightened connection to the natural world, while others consider it to be a magnification of the mark of Caine. Whatever its basis may be, those that develop this Discipline can grow bestial claws, take on the forms of bats and wolves, turn themselves into mist, and even meld into the very earth itself.
Transformed Kindred can generally use other Disciplines — vampires in wolf form can still read auras and communicate with other animals, for example. However, the Storyteller may rule that certain Disciplines may not be used in specific situations. The Kindred’s clothes and personal possessions also change when he transforms (presumably absorbed within his very substance), although armor and the like do not provide any benefit while transformed.
Vampires cannot change or transform large objects or other beings; Protean is a personal expression of power. A Kindred who has been staked (thereby trapping his soul within his body) cannot transform. Some vampires believe that those who have mastered the highest levels of Protean can deny this limitation, however.
The Gangrel Clan is well known for their mastery of Protean, although other Kindred have learned some of this Discipline’s secrets from these bestial Cainites.

• Eyes of the Beast
The vampire sees perfectly well in pitch darkness, not requiring a light source to notice details in even the darkest basement or cave. The vampire’s Beast is evident in his red glowing eyes, a sight sure to disturb most mortals.
System: The character must declare his desire to call forth the Eyes. No roll is necessary, but the change requires a full turn to complete. While manifesting the Eyes, the character suffers a +1 difficulty to all Social rolls with mortals unless he takes steps to shield his eyes (sunglasses are the simplest solution). (A vampire without this power who is immersed in total darkness suffers blind-fighting penalties as per p. 274.)

•• Feral Claws
The vampire’s nails transform into long, bestial claws. These talons are wickedly sharp, able to rend flesh with ease and even carve stone and metal with little trouble. The Beast is prominent in the claws as well, making them fearsome weapons against other immortals. It’s rumored that some Gangrel have modified this power to change their vampiric fangs into vicious tusks.
System: The claws grow automatically in response to the character’s desire, and can grow from both hands and feet. The transformation requires the expenditure of a blood point, takes a single turn to complete, and lasts for a scene.
The character attacks normally in combat, but the claws inflict Strength + 1 aggravated damage. Other supernaturals cannot normally soak this damage, although a power such as Fortitude may be used. Additionally, the difficulties of all climbing rolls are reduced by two.

••• Earth Meld
One of the most prized powers within Protean, Earth Meld enables the vampire to become one with the earth. The immortal literally sinks into the bare ground, transmuting his substance to bond with the earth.
Though a vampire can immerse himself fully into the ground, he cannot move around within it. Further, it is impossible to meld into earth through another substance. Wood slats, blacktop, even artificial turf blocks Earth Meld’s effectiveness — then again, it’s a relatively simple matter for a vampire at this level of power to grow claws and rip apart enough of the flooring to expose the raw soil beneath.
By interring himself in the ground, the vampire gains full protection from daylight when outdoors. It is also the method of choice for those Kindred who wish to sleep away the centuries; these vampires lock themselves in the earth’s embrace, gaining strength and power as they rest. Superstitious and paranoid Kindred whisper that thousands of Ancients sleep within the ground and will awaken when Gehenna arrives.
While so interred, the vampire is in a transitional state between flesh and earth. His physical presence exists between the physical world and the astral plane. As such, the vampire is difficult to sense, even through supernatural means. However, a disruption to the soil that the immortal occupies, or to his presence on the astral realm, returns him immediately to the physical world (and to full wakefulness), showering dirt outward as his body displaces the soil.
System: No roll is necessary, although the character must spend a blood point. Sinking into the earth is automatic and takes a turn to complete. The character falls into a state one step above torpor during this time, sensing his surroundings only distantly. The player must make a Humanity or Path roll (difficulty 6) for the character to rouse himself in response to danger prior to his desired time of emergence.
Since the character is in an in-between state, any attempts to locate him (catching his scent, scanning for his aura, traveling astrally, and so on) are made at +2 difficulty. Astral individuals cannot affect the vampire directly, instead meeting with a kind of spongy resistance as their hands pass through him. Similarly, digging in the material world encounters incredibly hard-packed earth, virtually as dense as stone.
Attempts at violence upon the submerged vampire from either side return him to his physical nature, expelling the soil with which he bonded in a blinding spray (all Perception-based rolls are at +2 difficulty for the turn). The character himself subtracts two from his initiative for the first turn after his restoration, due to momentary disorientation. Once expelled from the earth, the vampire may act normally.

•••• Shape of the Beast
This endows the vampire with the legendary ability to transform into a wolf or bat. A Kindred changed in this way is a particularly imposing representative of the animal kingdom. Indeed, he is far superior to normal animals, even ones possessed by Subsume the Spirit. He retains his own psyche and temperament, but can still call upon the abilities of the beast form — increased senses for the wolf and flight for the bat. Gangrel are reputed to change to other animal forms better suited to their environment — jackals in Africa, dholes in Asia, and even enormous rats in urban environments — a feat that other Clans learning Protean cannot seem to duplicate.
System: The character spends one blood point to assume the desired shape. The transformation requires three turns to complete (spending additional blood points reduces the time of transformation by one turn per point spent, to a minimum of one). The vampire remains in his beast form until the next dawn, unless he wishes to change back sooner.
While in the animal’s shape, the vampire can use any Discipline he possesses except Necromancy, Serpentis, Thaumaturgy, or Vicissitude (as well as any others the Storyteller deems unavailable). Furthermore, each form gives the character the abilities of that creature. In wolf form, the vampire’s teeth and claws inflict Strength + 1 aggravated damage, he can run at double speed, and the difficulties of all Perception rolls are reduced by two. In bat form, the vampire’s Strength is reduced to 1, but he can fly at speeds of up to 20 miles per hour, difficulties for all hearing-based Perception rolls are reduced by three, and attacks made against him are at +2 difficulty due to his small size.
The Storyteller may allow Gangrel to assume a different animal shape, but should establish the natural abilities it grants the character.

••••• Mist Form
This truly unsettling power enables the vampire to turn into mist. His physical shape disperses into a hazy cloud, but one still subject entirely to the immortal’s will. He floats at a brisk pace and may slip under doors, through screens, down pipes, and through other tiny openings. Although strong winds can blow the vampire from his chosen course, even hurricane-force winds cannot disperse his mist shape.
Some Kindred feel that this power is an expression of the vampire’s ultimate control over the material world, while others believe that it is the immortal’s soul made manifest (damned though it may be).
System: No roll is required, although a blood point must be spent. The transformation takes three turns to complete, although the character may reduce this time by one turn for each additional blood point spent (to a minimum of one turn). Strong winds may buffet the character, although Disciplines such as Potence may be used to resist them. Vampires in Mist Form can perceive their surroundings normally, although they cannot use powers that require eye contact.
The vampire is immune to all mundane physical attacks while in mist form, although supernatural attacks affect him normally. Also, the vampire takes one fewer die of damage from fire and sunlight. The character may not attack others physically while in this state — this includes encountering another vampire in mist form. He may use Disciplines that do not require physical substance, however.]==],
				},
				["Quietus"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 203


Quietus


The Discipline of silent death, Quietus is practiced by those of Clan Assamite. Based on elements of blood, poison, vitae control, and pestilence, Quietus focuses on the destruction of a target through a variety of means. This Discipline doesn’t always cause a quick death, but the Assamites rely on its lethality to hide their involvement with their victims.

• Silence of Death
Many Assamites claim never to have heard their targets’ death screams. Silence of Death imbues the vampire with a mystical silence that radiates from her body, muting all noise within a certain vicinity. No sound occurs inside this zone, though sounds originating outside the area of effect may be heard by anyone in it. Rumors abound of certain skilled Assamite viziers who have the ability to silence a location rather than a circumference that follows them, but no proof of this has been forthcoming.
System: This power (which costs one blood point to activate) maintains a 20-foot (6-meter) radius of utter stillness around the Kindred for one hour.

•• Scorpion’s Touch
By changing the properties of her blood, a vampire may create powerful venom that strips her prey of his resilience. This power is greatly feared by other Kindred, and all manner of hideous tales concerning methods of delivery circulate among trembling coteries. Kindred with Quietus are known to deliver the poison by coating their weapons with it, blighting their opponents with a touch, or spitting it like a cobra. An apocryphal account speaks of a proud Prince who discovered an Assamite plotting her exsanguination and began to diablerize her would-be assassin. Halfway through the act, she learned that she had ingested a dire quantity of tainted blood and was then unable to resist the weakened hashashiyyin’s renewed attack.
System: To convert a bit of her blood to poison, the Kindred’s player spends at least one blood point and rolls Willpower (difficulty 6). If this roll is successful, and the vampire successfully hits (but not necessarily damages) her opponent, the target loses a number of Stamina points equal to the number of blood points converted into poison — vampires attempting to drink the blood of the Kindred with Scorpion’s Touch are automatically considered to be "successfully hit."
The victim may resist the poison with a Stamina + Fortitude roll (difficulty 6); successes achieved on the resistance roll subtract from the vampire’s successes. The maximum number of blood points a Kindred may convert at any one time is equal to her Stamina. The number of successes scored indicates the duration of the Stamina loss.
1 success — One turn
2 successes — One hour
3 successes — One day
4 successes — One month
5 successes — Permanently (though Stamina may be bought back up with experience)
If a mortal’s Stamina falls to zero through use of Scorpion’s Touch, she becomes terminally ill and loses any immunity to diseases, her body succumbing to sickness within the year unless she somehow manages to increase her Stamina again. If a Kindred’s Stamina falls to zero, the vampire enters torpor and remains that way until one of her Stamina points returns. If a Kindred is permanently reduced to zero Stamina, she may recover from torpor only through mystical means.
To afflict someone with the poison, the Cainite must touch her target’s flesh or hit him with something that carries the venom. Many Assamites lubricate their weapons with the excretion, while others pool the toxin in their hands (or fleck their lips with the poison, for a "kiss of death") and press it to their opponents. Weapons so envenomed must be of the melee variety — arrows, sling stones, bullets, thrown weapons, and the like cannot carry enough of the stuff to do damage, or it drips off in flight. Players whose vampires wish to spit at their targets must make a Stamina + Athletics roll (difficulty 6). No more than two blood points’ worth of poison may be expectorated, and a Kindred may spit a distance of 10 feet (3 meters) for each point of Strength (and Potence) the character possesses. Vampires with Quietus are immune to their own poison, but not the blood-venom of other Kindred with this power.

••• Dagon’s Call
This terrible power allows a vampire to drown her target in his own blood. By concentrating, the Kindred bursts her target’s blood vessels and fills his lungs with vitae that strangles him from within. The blood actually constricts the target’s body from the inside as it floods through his system; thus, it works even on unbreathing Kindred. Until the target collapses in agony or death throes, this power has no visible effect, and many Kindred like it because it leaves no trace of their presence.
System: The vampire must touch her target prior to using Dagon’s Call. Within an hour thereafter, the vampire may issue the call, though she need not be in the presence or even in the line of sight of her target.
Invoking the power costs one Willpower point. The Kindred’s player makes a contested Stamina roll against the target’s Stamina; the difficulty of each roll is equal to the opponent’s permanent Willpower rating. The number of successes the vampire using Dagon’s Call achieves is the amount of lethal damage, in health levels, the victim suffers. For an additional point of Willpower spent in the next turn, the vampire may continue using Dagon’s Call by engaging in another contested Stamina roll. So long as the Kindred’s player continues to spend Willpower, the character may continue rending her opponent from within.

•••• Baal’s Caress
The penultimate use of blood as a weapon (short of diablerie itself), Baal’s Caress allows the Kindred to transmute her blood into a virulent ichor that destroys any living or undead flesh it touches. In nights of yore, when Assamites led the charges of Saracen legions, the Assassins were often seen licking their blades, slicing open their tongues and lubricating their weapons with this foul secretion.
Baal’s Caress may be used to augment any bladed weapon; everything from poisoned knives and swords to tainted fingernails and claws has been reported.
System: Baal’s Caress does not increase the damage done by a given weapon, but that weapon inflicts aggravated damage rather than normal. No roll is necessary to activate this power, but one blood point is consumed per hit. For example, if a Cainite poisons his knife and strikes his opponent (even if he inflicts no damage), one blood point’s worth of lubrication disappears. For this reason, many vampires choose to coat their weapons with a significant quantity of blood. If the vampire misses, no tainted blood is consumed.

••••• Taste of Death
A refinement of Baal’s Caress, Taste of Death allows the Cainite to spit caustic blood at her target. The blood coughed forth with this power burns flesh and corrodes bone; some vampires have been reported to vomit voluminous streams of vitae that reduce their targets to heaps of sludge.
System: The vampire may spit up to 10 feet (3 meters) for each dot of Strength and Potence he possesses. Hitting the target requires a Stamina + Athletics roll (difficulty 6). Each blood point spewed at the target inflicts two dice of aggravated damage, and there is no limit (other than the vampire’s capacity and per-turn expenditure maximum) to the quantity of blood with which a target may be deluged.]==],
				},
				["Sanguinus"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 463


Sanguinus


Sanguinus is the unwholesome Discipline granted to the Blood Brothers by the Tzimisce who created them. A curious relative of Vicissitude, Sanguinus allows vampires who practice it to combine parts of their bodies, loan them out to others, and coordinate their minds and appendages. Even low levels of it are unsettling to watch. Use of the higher levels is disgusting, indeed, as flesh parts and exposed organs, atrophied by the Blood Brothers’ state of undeath, merge and pulse. Mortals observing the spectacle of this Discipline’s more obvious powers must make Courage rolls (difficulty 4), spend a point of Willpower, or flee the area in nausea.

• Brother’s Blood
A circle of Blood Brothers is closer than any Sabbat pack, any blood-bound pair of vampiric lovers, any ghoul family. The circle shares flesh, mind, and, of course, blood. The members of the circle can spend blood to heal each other’s bodies, no matter how far apart they are.
System: The player spends a blood point, which may be used to heal any member of the circle, regardless of distance from the character. The Blood Brother may also "bank" blood, spending five points to heal another’s aggravated wound over the course of several turns. This power takes effect automatically; no roll is necessary. Blood spent by another Frankenstein does not count against the maximum amount of vitae the target character can spend per turn.

•• Octopod
The Blood Brother circle can donate limbs and organs to one another. This isn’t meant for healing after the battle, but for use during the battle. An opponent facing down the Blood Brothers might see one of his opponents grow a second set of legs (making him nearly impossible to knock down), another pair of arms (meaning he can block or parry almost any incoming attack), extra eyes for 360 degree vision, or an extra mouth for an greater blood consumption. Of course, the Frankenstein that gives up the organ might be left a limbless, eyeless, mouthless lump of flesh on the side of the battlefield, but the Blood Brothers never seem to mind that.
System: The "donor" player spends a blood point for each limb or organ he wishes to loan to the other circle member. (Only the donor needs to have this level of mastery of Sanguinus; the recipient may be any other member of the donor’s circle.) The loaned organs appear at the end of that turn, in whatever location the recipient wishes — eyes on the back of heads or on the ends of hands have been seen, as have entire heads located between a Blood Brother’s legs. Use of this power does not impart any extra attacks, but it may allow for additional sensory input, more blood to be consumed in a single turn, or extra hands to hold weapons or pin down foes. Only external organs may be loaned in this manner — hearts, stomachs, and brains cannot.

••• Gestalt
Blood Brothers share a hive-mind; this ability was one of the guiding principles behind their creation. The Gestalt power is that hive-mind, the ability of the Frankensteins to coordinate silently and perfectly in battle, to avoid mind-controlling powers, and to act in unison.
System: This power confers several benefits on the Blood Brothers. For this power to work, however, every Blood Brother in the circle must spend a blood point. If even one member cannot or will not spend a blood point, this power fails. Once a Blood Brother has met the Final Death, he is no longer a part of the circle, so the power continues to function among the still-undead members of the group. Gestalt lasts for one scene. While this power is active:
• Dominate, Presence, and the like take effect against the highest Willpower rating in the circle. For example, if a vampire attempts to Dominate a Blood Brother under the influence of Gestalt, she must roll against the highest Willpower rating any of the vampires in the circle possesses, even if her subject has the lowest Willpower rating in the circle. Additionally, a Blood Brother affected by powers in this manner drops out of the Gestalt, though Gestalt remains active for others. This mental "fuse" was supposedly created to prevent the entire circle from being Dominated by a vampire looking into the eyes of one Blood Brother.
• Perception difficulties for all Blood Brothers in the circle decrease by three, as they share the sensory input of other vampires in the circle.
• By taking no action other than concentrating, a Blood Brother may "loan" an Ability to another brother. For example, a wounded vampire with Melee 4 may step out of combat and loan a circle-mate with Melee 2 his mastery of that Skill. The "borrowing" vampire makes Ability checks against the loaned Trait as if it were his own.
• The Blood Brothers in the Gestalt may communicate through telepathy, allowing them to coordinate actions. In game terms, only one initiative roll is made for the circle, based on the character with the highest initiative rating (see p. 271).
Not all Blood Brothers in the circle need to have this level of Sanguinus to benefit from the Gestalt. If a given character does not know this power, though, the player rolls Wits + Occult (difficulty 7) when the power is enacted. If this roll fails, the character can still receive loaned Abilities, but gains no other benefits from the Gestalt.

•••• Walk of Caine
The sorcerous theory behind the Blood Brothers reads like a philosophical treatise on the nature of individuality, free will, and hematology. The Frankensteins are not a group of vampires but are one vampire in several bodies, or so goes the theory. As such, any of their characteristics must be viewed as a continuum — they are not individually Twelfth, Eleventh, and Thirteenth Generation, for example, but they are collectively Ninth Generation at any given time. While the metaphysics of this kind of thinking makes most vampires’ heads ache, there seems to be something to it. A Blood Brother can draw strength from his circle, lowering his Generation to allow for greater feats of vitae expenditure.
System: Each member of the circle can "donate" one step in Generation. In the example listed above, the vampire of Eleventh Generation could take one step from his two circle-mates and drop to Ninth, but the vampire of Thirteenth Generation couldn’t drop lower than Eleventh. No matter how big the circle, no Blood Brother can drop to an effective Generation lower than Fourth. Likewise, a Thirteenth Generation Blood Brother can drop to an effective Generation of Fourteenth, which carries with it the penalties listed for the Fourteenth Generation Flaw (p. 481). (He cannot go to Fifteenth Generation, however.)
As with Gestalt, only one Blood Brother needs to know this power in order to begin the process. Any that don’t have Walk of Caine need to make a Stamina + Awareness roll (difficulty 7). If this roll fails, they may not participate in the action.

••••• Coagulated Entity
The Blood Brothers merge into a fleshy, bleeding mound of horror. This juggernaut surges forward, crushing and consuming anything in its path. The Sabbat has learned to its chagrin that if the Blood Brothers are not explicitly told to separate after using this power, they won’t. This merger is, apparently, what the Blood Brothers truly want.
System: Every vampire in the circle who wishes to become part of the Coagulated Entity spends three blood points. Three turns after the process begins, the monster is complete and able to act. The vampire of the lowest Generation who is part of the construct guides the creature’s actions. The actual Generation of the creature itself, however, is the highest Generation of any vampire present in the construct, less one for each additional vampire present in the construct. (Using the previous example, the Eleventh-Generation vampire would be the guide but the highest Generation is 13, so the overall Entity would be 13 minus 2, or Eleventh Generation.)
The creature’s Strength, Stamina, and Perception are equal to the guide’s, with a +1 for every additional vampire contained within. (Generational limits do not apply to this creature — through sheer size, a Coagulated Entity may have a Strength of 7 or more.) All physical actions undertaken by the monstrosity gain one extra die to the pool for each vampire beyond the first present in the construct (before splitting dice pools).
Only one vampire in the circle needs to possess Sanguinus at Level Five for this power to work. Body parts tend to shift during the creation of a Coagulated Entity — fanged maws at the ends of hands and eyes atop fleshy stalks have been reported by terrified survivors. Storytellers should feel free to give any bonuses (or penalties) to the construct as they see fit.
A Coagulated Entity may not be staked, as it has too many hearts in unconventional places for any but the blindest luck to impale. It has a vampire’s normal seven health levels, plus two for each additional vampire who becomes part of the entity (treat these extra health levels as Bruised). The entity remains congealed for one scene, unless the Storyteller wishes to rule that no one told the Blood Brothers to separate.]==],
				},
				["Serpentis"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 209


Serpentis


Serpentis is believed to be the legacy of Set himself, a gift to his children. The Followers of Set are very careful to guard this Discipline’s secrets, only teaching the art to those who they deem worthy. Most vampires fear the Setites because of the powers of Serpentis and its connection to snakes and reptiles; this Discipline can evoke a primordial fear in others, particularly those who recall the tale of Eden.

• The Eyes of the Serpent
This power grants the vampire the legendary hypnotic gaze of the serpent. The Kindred’s eyes become gold with large black irises, and mortals in the character’s vicinity find themselves strangely attracted to him. A mortal who meets the vampire’s beguiling gaze is immobilized. Until the character takes his eyes off his victim, the person is frozen in place.
System: No roll is required, but this power can be avoided if the mortal takes care not to look into the vampire’s eyes. Vampires and other supernatural creatures can also be affected by this power if the Cainite’s player succeeds on a Willpower roll (difficulty 9). If attacked or otherwise harmed, supernatural creatures can spend a point of Willpower to break the spell.
Note: This is different than normal eye contact detailed on p. 152. The target must be able to see the vampire’s eyes for Eyes of the Serpent to work.

•• The Tongue of the Asp
The vampire may lengthen her tongue at will, splitting it into a fork like that of a serpent. The tongue may reach 18 inches or half a meter, and makes a terrifyingly effective weapon in close combat.
System: The lash of the tongue’s razor fork causes aggravated wounds (difficulty 6, Strength damage). If the Kindred wounds her enemy, she may drink blood from the target on the next turn as though she had sunk her fangs into the victim’s neck. Horrifying though it is, the tongue’s caress is very like the Kiss, and strikes mortal victims helpless with fear and ecstasy. Additionally, the tongue is highly sensitive to vibrations, enabling the vampire to function effectively in the darkness the Clan prefers. By flicking his tongue in and out of his mouth, the vampire can halve any penalties relating to darkness (p. 274).

••• The Skin of the Adder
By calling upon her Blood, the vampire may transform her skin into a mottled, scaly hide. A vampire in this form becomes more supple and flexible.
System: The vampire spends one blood point and one Willpower point. Her skin becomes scaly and mottled; this, combined with the character’s increased flexibility, reduces soak difficulties to 5. The vampire may use her Stamina to soak aggravated damage from claws and fangs, but not from fire, sunlight, or other supernatural energies. The vampire’s mouth widens and fangs lengthen, enabling her bite to inflict an extra die of damage. Finally, the vampire may slip through any opening wide enough to fit her head through.
The vampire’s Appearance drops to 1, and she is obviously inhuman if observed with any degree of care, though casual passersby might not notice, if the vampire is in darkness or wearing heavy clothing.

•••• The Form of the Cobra
The Cainite may change his form into that of a huge black cobra. The serpent weighs as much as the vampire’s human form, stretches over 10 feet or three meters long, and is about 20 inches (50 cm) around. The Form of the Cobra grants several advantages, including a venomous bite, the ability to slither through small spaces, and a greatly enhanced sense of smell. The character may use any Disciplines while in this form save those that require hands (such as Feral Claws).
System: The vampire spends one blood point; the change is automatic, but takes three turns. Clothing and small personal possessions transform with the vampire. The vampire remains in serpent form until the next dawn, unless he desires to change back sooner. The Storyteller may allow the Setite bonus dice on all Perception rolls related to smell, but the difficulties for all hearing rolls are increased by two. The cobra’s bite inflicts damage equal to the vampire’s, but the vampire does not need to grapple his victim; furthermore, the poison delivered is fatal to mortals.

••••• The Heart of Darkness
A Kindred with mastery of Serpentis may pull her heart from her body. She can even use this ability on other Cainites, although this requires several hours of gruesome surgery. This power can only be invoked during a new moon. If performed under any other moon, the rite fails. Upon removing her heart, the vampire places it in a small clay urn, and then carefully hides or buries the urn. While her heart is hidden, she cannot be staked by any wood that pierces her breast. Moreover, because the heart is the seat of emotion, the difficulties of all her rolls to resist frenzy are two lower while this power is in effect.
Cainites are careful to keep their hearts safe from danger. If someone seizes her heart, the vampire is completely at that person’s mercy. The heart can be destroyed only by casting it into a fire or exposing it to sunlight. If this happens, the Kindred dies where she stands, boiling away into a blistering heap of ash and blackened bone. Plunging a wooden stake into an exposed heart drives the vampire into instant torpor.
A vampire may carry her heart with her, or have several false hearts buried in different places. A smart Kindred often avoids her heart’s hiding place, to deter discovery. Those wise in Setite lore whisper that the corrupt elders of the Clan often hold their underlings’ hearts as yet another method of control.
System: This power requires no roll. Those who witness a vampire pull his heart from his breast (or cut the heart from another vampire) must make Courage rolls. Failure indicates anything from strong uneasiness to complete revulsion, possibly even Rötschreck.]==],
				},
				["Setite Sorcery"] = {
					en = [==[Rites of Blood, p. 36


Setite Sorcery


There are many different types of Setite sorcery, from voudoun-like wanga to the Egyptian-based akhu. The Serpents of the Light, and their parent Clan, the Followers of Set, have put a great deal of energy into the practice of magic, creating a number of radically different theosophies concerning conjuration and enchantment.
The Serpents of the Light reject Theophidian (Set-based) doctrine in all forms. They accept Caine’s place as the first vampire, rather than adhering to their parent Clan’s beliefs that Set did not descend from the Dark Father. Serpents of the Light believe that through death, one can become a god. If they grow powerful enough, they believe, they can rise to seize rulership of the earth, and control of the spirit-world as well. When a group of militant Egyptian Setites (more than half of whom were Warrior Setites) tried to force New World serpents into accepting their Orthodoxy, they drove a great number of Afro-Caribbean Setites into the Sword of Caine. Because of this schism in doctrine (both magical and theosophical), the Serpents of the Light have a great bitterness toward the Followers of Set, and often seek their parent Clan’s destruction.
The sorcery of the Serpents of the Light requires many levels of initiation. A seeker passes through circles of mystery and learns more with each step along the path. The four Serpents of the Light who hold the highest initiation are called the empereurs, and these vampires are receptacles of a majority of Cobra wisdom and knowledge. Because of the nature of their initiatory tutelage, Cobras are even more jealous of their magical secrets than most other thaumaturges within the Sect, refusing to share knowledge of their ritual practices even with other Cobras – unless those adherents have passed the proper initiation rites.]==],
				},
				["Spiritus"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 465


Spiritus


The Discipline of Spiritus opens the vampire up to worlds and vistas — and methods of feeding — that most Kindred can never touch. Vampires are spiritually dead, unable to create life. The shamanic ritual that created the Ahrimanes, though, allowed a spiritual connection between the undead and the vast, living world all around them. While the vampire can barely scratch the surface of what living shamans can accomplish, the Discipline of Spiritus is still formidable.

• Aid from Spirits
Spirits are everywhere, but invisible to most living (and unliving) beings. This power allows the vampire to briefly rouse the spirit of an object, making that object perform its intended function better and more efficiently. It in no way makes the spirit well-disposed toward the vampire — not that this usually matters to the Ahrimane.
System: The character touches the object, and the player spends a blood point and rolls Manipulation + Occult (difficulty 6). If the roll succeeds, the player receives a bonus to her dice pool using that item, equal to the number of successes rolled. For example, if the character uses this power on a gun and the player rolls three successes, she then receives a +3 to her next Firearms roll made with that gun. Unused bonuses fade at the end of the scene, and multiple uses of this power do not combine (the most recent use trumps any previous uses). The character can, however, use the power on multiple objects she uses in the same scene, so long as she has the blood for it.

•• Summon Spirit Beasts
The vampire might not fully understand the link between "animal" and "animal-spirit," but spirits of aggressive animals are usually more than willing to take on a physical body and fight for the vampire. Spirits of curious animals, meanwhile, seem to enjoy unlocking doors or following people. With this power, the Ahrimane can summon up the spirit of an animal indigenous to the area and send it to do what comes naturally.
The spirit assumes the corporeal form of the appropriate animal, and is capable of whatever the animal would normally be able to do. The animal can follow simple telepathic commands, and is slightly more intelligent than a normal animal would be (but still not as intelligent as a person).
System: The animal summoned must be native to the area — just because the local zoo hosts a tiger doesn’t mean there are tiger-spirits running about. The player must spend one blood point and roll Charisma + Animal Ken (difficulty 7). The number of successes indicates how long the spirit remains material. The spirits have the same number of health levels their physical counterparts would normally have (see p. 388 for some sample animals traits). If they are reduced to Incapacitated, they discorporate.
1 success — One turn
2 successes — Five turns
3 successes — One hour
4 successes — One night
5 successes — One week

••• Aspect of the Beast
Instead of calling up animal spirits, the vampire learns to emulate aspects of those spirits herself. In this way, she can become faster, stronger, tougher, or gain the special powers of nearly any animal, provided that the spirit is local to the area.
System: The player spends a blood point and rolls Manipulation + Occult (difficulty 7). The power lasts for one turn per success, unless otherwise noted. Some examples of aspects are given below, though the player and Storyteller are welcome to make up others:
Beaver’s Bite — This makes the Ahrimane’s bite strong and sharp enough to cut through almost any substance (though it does no additional damage to living or unliving targets).
Chameleon’s Colors — The Ahrimane becomes capable of changing color to suit the environment (-2 difficulties to all Stealth rolls involving hiding).
Ears of the Hare — The Ahrimane can hear as well as a rabbit, reducing the difficulty of Perception rolls involving hearing by two.
Falcon’s Eye — The Ahrimane can see great distances as if she had the eyes of a falcon (-3 to all Perception rolls involving vision).
Ferocity of the Cougar — All Courage rolls are made at -2 difficulty.
Leapfrog — This grants the Ahrimane the ability to leap three times the normal height and distance. (See p. 260 for jumping rules.)
Nose of the Hound — The Ahrimane’s sense of smell is far greater than that of a mortal. She can even track by scent with on a Perception + Survival roll (difficulty set by Storyteller).
Serpent’s Venom — The Ahrimane’s bite transmits a venomous toxin that causes two health levels of damage in living victims per turn (see "Poisons and Drugs," p. 301). The damage continues until the toxin is removed or nullified, or until the Ahrimane’s spirit power ends.
Sound of the Cricket — This grants the power to produce an annoying, grating sound loud enough to deafen those nearby. The target suffers a +4 to all Perception rolls related to hearing for the next scene unless he succeeds on a Willpower roll (difficulty 7).
Squirrel’s Balance — The Ahrimane can move about in the branches and limbs of trees or across tightropes with little fear of falling. All such Athletics rolls have their difficulties decreased by two.
Strength of the Bear — This gives the Ahrimane two extra dots of Strength.
Swiftness of the Stag — The Ahrimane can move at twice her normal running speed.

•••• Engling Fury
Spirits abound — supposedly everything, from one’s shirt to the very air, has one. The Ahrimane can take those spirits into herself, break them down, and refresh her own mental reserves. This destroys the spirit, but no repercussions have been reported.
System: The player rolls Manipulation + Intimidation (difficulty 8). Every success allows her to regain a point of Willpower, but each use of this power destroys another spirit.

••••• The Wild Beast
The Ahrimane grows leaner, lithe, and strong. She hunches over slightly, her eyes become slitted and catlike, and she grows vicious claws on her hands. Her features become slightly feline, and in this form she is an even more formidable predator than usual. Animals react with fear to the Wild Beast, and mortals see her as a monster — if they see her at all.
System: The change does not require a roll, but the player must spend two blood points. The change raises the vampire’s Strength by three, and Dexterity and Stamina each by two. Appearance falls to 0 and Manipulation is reduced by three. The vampire’s fangs inflict an extra die of damage, and she grows claws that inflict aggravated damage. The character can see in the dark, and all difficulties involving scent, hearing, and vision fall by two. The character can retain the Wild Beast form for a number of hours every night equal to her Willpower rating.]==],
				},
				["Temporis"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 467


Temporis


The True Brujah bloodline claims a peculiar Discipline that allows them some control over the flow of time. Masters of Temporis often grow ever more detached from the passage of ages. This, combined with the natural tendency for Sages to grow emotionally and spiritually distant, makes True Brujah elders exceptionally dangerous. They know that all life is finite, and so they feel no compunction about ending it.

• Hourglass of the Mind
Masters of Temporis value patience and clarity. Time is too complex and dangerous to manipulate incautiously or on a whim. Thus, the first power of Temporis focuses entirely on perception and serves as a permanent alteration of a vampire’s senses.
System: Once purchased, this Discipline gives a vampire a perfect sense of time. The vampire knows events to the nearest second or better. Moreover, the Cainite knows whenever the flow of time is mystically disturbed by use of Celerity, greater levels of Temporis, mortal wizardry, or stranger things. Sensing disturbances is instinctive and reflexive, though it requires a successful Perception + Awareness roll (difficulty 6 for most phenomena, as modified by the Storyteller for distance and intensity).

•• Recurring Contemplation
A vampire with this power may trap a target’s mind into reviewing a set of events over and over until interrupted. This power is extremely subtle and ill-suited to combat or other situations rich in sensory stimuli. However, a cunning vampire can trick a sentry into reliving the tedium of his uneventful watch even as the Cainite draws close enough to strike or slip past. Other uses include the maddening infliction of déjà vu to induce paranoia or make a victim question her senses and her sanity.
System: The vampire concentrates on a single victim in his line of sight. The player rolls Manipulation + Occult (difficulty equal to the victim’s current Willpower). With any successes, the victim falls into a light trance and relives the most recent experiences that preceded her fugue. Alternately, the vampire may evoke another set of specific memories and circumstances from the victim’s past, provided that he has some means of telepathically drawing them forth. The recurring events must be relatively benign, insofar as nothing noteworthy happens or nothing happens that would demand the victim’s immediate action. Thus, in the example of the sentry, the vampire could entrance him and walk past unobserved, but not if the sentry spotted him before invoking the power. Ordinarily, the fugue lasts one minute per success. If the vampire’s player spends a blood point to fuel this power, determine the trance’s duration according to the following chart:
1 success — one minute
2 successes — 10 minutes
3 successes — one hour
4 successes — six hours
5+ successes — one day
Entranced victims are oblivious to their surroundings and the actual flow of time around them. However, the fugue ends immediately if the victim suffers any damage or experiences a sudden jolt to her senses, such as a thunderclap or even a gentle nudge. Normal conversation does not break the trance, although shouting does.

••• Leaden Moment
With this power, a vampire may begin to alter the flow of time itself rather than mere perception of events. The vampire gestures and slows the desired object almost to a dead stop. This power can slow incoming bullets to the pace of drifting clouds, or cause an enemy warrior to see the battlefield quicken to a blur of dizzying carnage even as his every motion slows to a crawl.
System: The player spends one blood point and rolls Intelligence + Occult. The difficulty depends on the size and nature of the target: a single thrown brick is only difficulty 4, while a crazed ghoul has a difficulty of 9. Targets larger than an adult human cannot be affected with Leaden Moment. It is possible to affect small, closely grouped inanimate objects of the same nature as a single object, though this increases the difficulty by two or more at the Storyteller’s discretion (a hail of bullets might be difficulty 9). This power may be activated reflexively as a defensive action against projectiles, but otherwise requires a full action on the vampire’s initiative. Though failure carries no special penalty apart from wasting blood, a botch means the vampire mistakenly slows himself rather than the target, counting every 1 as a success for that purpose.
If the vampire succeeds, the object slows to one-half its true speed. Every two successes beyond the first reduce this speed by one additional factor, so three successes slows the target to one third its speed, five successes yields quarter speed, etc. The actual mechanics of such slowing depend on the situation. For projectiles, multiply any successes to hit and final damage by the speed factor, rounded down. Similarly apply the speed modifier to the successes of other actions involving Dexterity, Wits, or Strength for slowed characters. Characters with Celerity may spend one blood point to negate one factor of speed reduction at the expense of the usual extra action provided – for example, one blood point cancels a reduction to one half speed, two blood points cancel one third, etc. Leaden Moment lasts one turn for every two successes rolled, rounded up.

•••• Patience of the Norns
The vampire can now suspend an inanimate object in time, keeping it frozen in perfect stasis as time passes at normal speed around it. As with lesser Temporis powers, this stasis has both combat and non-combat applications. True Brujah warriors may halt bullets outright rather than merely slowing their approach or casually sidestep a collapsing building. Higher-level variations on this power preserve precious scrolls and artifacts without risk of mold or decay. If any solid object or nontrivial volume of liquid touches a frozen object that did not touch it at the moment of suspension, the item re-enters time with the same properties and velocity as when it stopped. Thus, touching a suspended object with anything more substantial than a raindrop releases it exactly as it was before it stopped.
System: The player spends two blood points and rolls Intelligence + Occult (difficulty 6). The vampire must be able to perceive the object that he’s suspending, so the player may need to make a Perception + Alertness roll at a difficulty determined by the Storyteller in order to freeze fast-moving objects. If an object exceeds the speed of mortal perception, superhuman perception such as Auspex is required in order to see and stop it (as such, bullets can be stopped with this power, but only if the vampire has at least a dot of Auspex). Objects frozen by this power remain halted according to the number of successes rolled:
1 success — one turn
2 successes — one minute
3 successes — 10 minutes
4 successes — one hour
5 successes — one day
6+ successes — one week per success over 5
Suspended objects retain all energy in their suspension, releasing none to the outside universe. A suspended knife has no kinetic energy as far as the rest of the world is concerned and hangs suspended in mid-air until the power is interrupted or the duration expires. Suspended alchemical or chemical processes also halt, including fire. However, any physical contact more substantial than a falling raindrop breaks the suspension.

••••• Clotho’s Gift
With this power, a vampire momentarily accelerates time through himself. In this brief instant, he moves with the preternatural speed of Celerity. Unlike that Discipline, however, the time dilation of Clotho’s Gift permits any type of action. A vampire may still move or strike faster than the eye can see, but also think, plan, and even invoke other Disciplines that require full concentration. Only the last presents a danger, as it overtaxes the vampire’s unliving stasis.
System: The player spends three blood points and rolls Intelligence + Occult (difficulty 7). For a number of turns equal to half the vampire’s Temporis rating, rounded up, the character may take a number of extra actions at her full dice pool equal to the number of successes rolled. These actions follow the timing rules associated with Celerity, but may be used to take any action. A vampire may use the actions granted by Clotho’s Gift to activate Disciplines multiple times, even Disciplines that cannot be used more than once in a turn (such as Dominate or Thaumaturgy). However, for every action spent activating a Discipline, the vampire suffers one level of unsoakable lethal damage. Only one important exception exists: Any attempt to stack extra actions through Celerity, subsequent applications of Clotho’s Gift or other powers results in immediate Final Death, as the vampire collapses into ash as though burned by the sun.]==],
				},
				["Thanatosis"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 471


Thanatosis


This Discipline is an exclusive development of the Samedi bloodline, and it is tied intrinsically to the Stiffs’ identity and history. Although Thanatosis appears to deal closely with death and the energies of decay, no Giovanni have ever claimed mastery of this power. Outsiders assume the Giovanni must be interested in learning this Discipline. However, the Giovanni view the Samedi with distrust and loathing, while the Samedi take on the Giovanni is usually expressed by muttering a curse on the Clan and spitting blood. Thus, the possibility of an exchange of information approaches nil.

• Hag’s Wrinkles
Perpetual rot makes the character’s flesh malleable. The Samedi can open large folds in her flesh, storing objects in them like a kangaroo’s pouch. She can also massage the slimy flaps of fatty tissue to alter her appearance slightly (though this does nothing for the smell). Other Kindred can learn this Discipline, of course, but if they do not possess the "advantage" of having skin that already falls in droops and folds, large wrinkles and bulges may be visible.
System: This power requires one turn to shape the wrinkles and the expenditure of a blood point. If the power is used to distort a character’s features, the Samedi player must roll Stamina + Subterfuge (difficulty 8). Success raises the difficulty to visually identify the character by one and lasts for one hour per success rolled. If the character is attempting to hide a small object (a wallet, a letter, a small pistol), the roll and duration are the same, but all rolls made to see if the object is detected (for example, a pat-down search or a security guard’s visual inspection) are at +2 difficulty.

•• Putrefaction
The character can, with a touch, inflict decay upon a target. Hair falls out, teeth loosen, flesh rots and fungus grows on the skin. This power works on targets living and undead, and is obviously quite unsettling both physically and psychologically.
System: This power first requires that the character touch his intended target. The player then rolls Dexterity + Medicine (difficulty of the target’s Stamina + Fortitude) and spends a blood point. Success inflicts one health level of lethal damage on the target and removes one point of the victim’s Appearance. This Appearance loss returns to vampires at the rate of one point per night, but is permanent for mortals (though plastic surgery can correct mortals’ physical disfigurement). If a mortal suffers three or more health levels of damage from repeated uses of this power in one scene, gangrene or other ailments may occur.
Putrefaction can also be used on plants, in which case the target becomes blighted and withered. It cannot, however, be used on inanimate objects such as cars or wooden stakes.

••• Ashes to Ashes
The character collapses into a thick, sticky white powder. While in this form, the character cannot move and is only dimly aware of her surroundings, but is immune to fire and sunlight (meaning that this power is an effective escape in some situations). The character must take care, though — if the ashes are scattered, she might never be able to reform.
System: The transformation to ashes requires one turn and the expenditure of two blood points. While the character is in ash form, the player must make a Perception + Alertness roll (difficulty 9) for any scene in which she wishes her character to be aware of her surroundings. Reforming from the heap of ashes takes one turn. If the character is in a confined space (such as an urn), she explodes from it in a suitably dramatic manner as she brings herself back to full size. If a Samedi is scattered while in this form, one health level and one blood point are lost for each tenth (roughly) of the character that has been dissipated. Five blood points are required to heal each health level lost in this manner. At the Storyteller’s discretion, the Samedi may be missing limbs or vital organs (though never the head or the heart) until the missing health levels are healed.

•••• Withering
The Stiff can shrivel and render useless an opponent’s limb. This power works on Kindred as well as mortals. Kindred, of course, are horrified by the power, as they tend to think of their bodies as immortal and invulnerable to such ravages.
System: The Samedi must touch the limb he intends to shrivel. The player spends a Willpower point and rolls Manipulation + Medicine (difficulty equal to the victim’s Stamina + Fortitude). Three successes are required for this power to shrink a limb. With one or two successes, the victim takes one health level of bashing damage, which may be soaked normally, but is otherwise unaffected. (If the Withering attempt is successful, the subject suffers no health level of damage, but rather the withering of the limb itself.)
The effects of Withering fade after one night if a vampire or other supernatural creature is the victim, but mortals (including mages) are permanently afflicted unless some type of supernatural healing is used. If this power is used on an arm or leg, the limb instantly becomes useless. If this power is used on an opponent’s head, mortal victims die instantly. Kindred lose two points from all Mental Attributes while their heads are shrunken and are unable to use any Disciplines except Celerity, Fortitude, and Potence. Multiple uses of this power on the same appendage have no additional effect.

••••• Necrosis
A more horrific and potent form of Putrefaction, this power causes flesh to decay and slough off, exposing the bone beneath. Use of this power can render an opponent unable to move from lack of muscle tissue.
System: The Samedi must make contact with the victim. The player spends two blood points and rolls Dexterity + Medicine (difficulty of the target’s Stamina + Fortitude). The victim takes a number of health levels of lethal damage equal to the number of successes rolled and suffers additional effects as listed below.
1 success — No additional effects
2 successes — Lose one point of Appearance
3 successes — Lose a point each of Appearance and Dexterity
4 successes — Lose a point each of Appearance, Dexterity, and Strength
5+ successes — Lose two points of Appearance and one each of Dexterity and Strength
Attributes lost in this manner are regained when all damage from the Necrosis attack is healed. If a victim is reduced to zero Strength or Dexterity, he is unable to move except for weak flailing and crawling but may still use Disciplines and spend blood points normally.]==],
				},
				["Thaumaturgy"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 212


Thaumaturgy


Thaumaturgy encompasses blood magic and other sorcerous arts available to Kindred. The Tremere Clan is best known for their possession (and jealous hoarding) of this Discipline. The Tremere created Thaumaturgy by combining mortal wizardry with the power of vampiric vitae, and as a result it is a versatile and powerful Discipline. Although there are whispers of the existence of Tremere antitribu in the Sabbat, other Clans in the Sword of Caine have also researched and developed access to such mystical might. Nevertheless, the Tremere of the Camarilla remain this Discipline’s masters.
Like Necromancy, the practice of Thaumaturgy is divided into paths and rituals. Thaumaturgical paths are applications of the vampire’s knowledge of blood magic, allowing her to create effects on a whim. Rituals are more formulaic in nature, most akin to ancient magical "spells." Because so many different paths and rituals are available to the arcane Tremere, one never knows what to expect when confronted with a practitioner of this Discipline.
When a character first learns Thaumaturgy, the player selects a path for the character. That path is considered the character’s primary path, and she automatically receives one dot in it, as well as one Level One ritual. Thereafter, whenever the character increases her level in Thaumaturgy, her rating in the primary path increases by one as well. Additional rituals are learned separately, as part of a story; players need not pay experience points for their characters to learn rituals up to the level equal to their overall rating in Thaumaturgy, though they must find someone to teach the rituals in question. Path ratings never exceed 5, though the overall Thaumaturgy score may. If a character reaches a rating of 5 in her primary path and increases her Thaumaturgy score afterward, she may allocate her "free" path dot to a different path. (Experience costs are covered on p. 124.)
Many Kindred fear crossing the practitioners of Thaumaturgy. It is a very potent and mutable Discipline, and almost anything the Kindred wishes may be accomplished through its magic.

Thaumaturgical Paths
Paths define the types of magic a vampire can perform. A vampire typically learns his primary path from his sire, though it is not unknown for some vampires to study under many different tutors.
As mentioned before, the first path a character learns is considered her primary path and increases automatically as the character advances in the Discipline itself. Secondary paths may be learned once the character has acquired two or more dots in her primary path, and they must be raised separately with experience points. Furthermore, a character’s rating in her primary path must always be at least one dot higher than any of her secondary paths until she has mastered her primary path. Once the character has achieved the fifth level of her primary path, secondary paths may be increased to that level.
Each time the character invokes one of the powers of a Thaumaturgical path, the thaumaturge’s player must spend a blood point and make a Willpower roll against a difficulty equal to the power’s level +3. Only one success is required to invoke a path’s effect — path levels, not successes, govern the power of blood magic. Failure on this roll indicates that the magic fails. A botch causes some kind of loss or catastrophic backfire, such as losing a Willpower point (or dot!), spontaneous combustion, or accidentally letting a living statue run rampant. Thaumaturgy is an unforgiving art.
Various Sects and Clans have different access to each path, but unless the Storyteller decides otherwise, it is assumed the Tremere have some access to all of them. ("Having access" does not mean the same thing as "easily gained," especially within the Tremere power structure.) The paths start with one of the most common (The Path of Blood), and thereafter are presented in alphabetical order. (The unusual "path" of Thaumaturgical Countermagic is also presented, although it is considered a separate Discipline – see p. 228 for details.)]==],
				},
				["Valeren"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 474


Valeren


Valeren is a warrior’s Discipline, a holdover from the nights when warrior Salubri acted as noble fighters and Kindred knights. The Discipline is still applicable to the modern nights, but the Salubri antitribu put it to decidedly more vicious ends.
Like Obeah, Valeren imparts its practitioners with the fabled third eye of Saulot. The third eye appears at the time the vampire masters the second level of Valeren. The precise nature and purpose of the eye are all but unknown to vampires outside the Salubri antitribu. Some suspect the eye grants them sight beyond sight, while others venture that the eye allows them to see the infernal taint in the non-Sabbat Salubri themselves.

• Sense Vitality
A healer learns a subject’s illnesses to cure them. The Salubri antitribu, however, learn how close to death a target is so that they may hasten the process.
System: This power works identically to the Obeah power of the same name (p. 457).

•• Anesthetic Touch
The Salubri antitribu can ameliorate a subject’s pain, allowing him to bolster a ghoul’s effectiveness in combat. This power can also put a mortal to sleep, which has obvious applications for escaping human scrutiny (though the Fury is probably just as likely to kill the mortal in question).
System: This power works identically to the Obeah power of the same name (p. 458).

••• Burning Touch
The character’s hands bring searing pain, as though the target is being burnt with red-hot metal. Although the power does not inflict actual damage, prolonged or repeated exposure can be enough to traumatize a victim. This power works extremely well as a torture method.
System: The vampire must touch his subject for this power to take effect, and the effects diminish rapidly after he removes his hand. The player spends at least one blood point to activate this power, and each blood point spent reduces the victim’s dice pools by two while the Fury is in contact with the victim. This power is often used for interrogation or torture, wearing down the subject’s resistance and rendering him much more tractable.

•••• Armor of Caine’s Fury
The Salubri antitribu is surrounded by a shining, crimson halo. This phantom armor protects the vampire against most physical injury, as well as against Rötschreck.
System: The player spends one blood point and rolls Stamina + Melee (difficulty 7). For each success, the character gains one point of armor protection against bashing and lethal damage, to a maximum of five points of protection. Additionally, for every two successes rolled, she gains an additional die to resist Rötschreck from the effects of battle (but not fire or sunlight). This power works for one scene.

••••• Vengeance of Samiel
The Salubri antitribu strikes his foe with superhuman accuracy and strength, as his third eye opens and changes to a furious, icy blue. Some Furies invoke the names of ancient Salubri warriors, while others simply close their normal eyes and let Samiel guide their hands.
System: This power costs three blood points. Any single attack made by the vampire automatically hits the target as mystic forces guide the blow. Attacks made in this manner may not be dodged, though they may be blocked, parried, and soaked as normal. The blow strikes as if the Salubri antitribu had succeeded with all of his Dexterity + Melee or Brawling dice pool (which makes for significant damage). This power may be used only once per turn, and only then the Salubri antitribu’s sole action is the attack. Additionally, this power does not work for ranged weapons; only bare hands or melee weapons.]==],
				},
				["Vicissitude"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 241


Vicissitude


Vicissitude is the signature power of the Tzimisce, and is rarely shared outside the Clan (though it is known to some other Cainites of the Sabbat). Similar to Protean in some ways, Vicissitude allows vampires to shape and sculpt flesh and bone. When a Kindred uses Vicissitude to alter mortals, ghouls, and vampires of higher Generation, the effects of the power are permanent; vampires of equal or lower Generation can choose to heal the effects of Vicissitude as though they were aggravated wounds. A wielder of Vicissitude can always reshape her own flesh.
The wielder must establish skin-to-skin contact and must often manually sculpt the desired result for these powers to take effect. This also applies to the use of the power on oneself. Tzimisce skilled in Vicissitude are often inhumanly beautiful; those less skilled are simply inhuman.
There are rumors that Vicissitude is a disease rather than a "normal" Discipline, but only the Fiends know for sure, and they aren’t talking.
Note: Nosferatu always "heal" Vicissitude alterations, at least the ones that make them better-looking. The ancient curse of the Clan may not be circumvented through Vicissitude. The same applies to physical deformities from the Gangrel Clan weakness.
Body Crafts: Vampires who wish to use Vicissitude well often specialize their knowledge of Medicine in an art known as Body Crafts. This specialization enables its possessor to make all manner of alterations to living and dead flesh and bone. It also gives insight into more mundane techniques; many Tzimisce are skilled at flaying, bone-carving, embalming, taxidermy, tattooing, and piercing.

• Malleable Visage
A vampire with this power may alter her own bodily parameters: height, build, voice, facial features, and skin tone, among other things. Such changes are cosmetic and minor in scope — no more than a foot (30 cm) of height gained or lost, for example. She must physically mold the alteration, literally shaping her flesh into the desired result.
System: The player must spend a blood point for each body part to be changed, then roll Intelligence + Medicine (difficulty 6). To duplicate another person or voice requires a Perception + Medicine roll (difficulty 8), and five successes are required for a flawless copy; fewer successes leave minute (or not-so-minute) flaws. Increasing one’s Appearance Trait has a difficulty of 9, and the vampire must spend an additional blood point for each dot of Appearance increased beyond their natural total. A botch permanently reduces the Attribute by one.

•• Fleshcraft
This power is similar to Malleable Visage, above, but allows the vampire to perform drastic, grotesque alterations on other creatures. Tzimisce often use this power to transform their servitors into monstrous guards, the better to frighten foes. Only flesh (skin, muscle, fat, and cartilage, but not bone) may be transformed.
System: After spending a blood point, the vampire must grapple the intended victim. The player of the Flescrafting vampire makes a successful Dexterity + Medicine roll (difficulty variable: 5 for a crude yank-and-tuck, up to 9 for precise transformations). A vampire who wishes to increase another’s Appearance Trait does so as described under Malleable Visage; reducing the Attribute is considerably easier (difficulty 5), though truly inspired disfigurement may dictate a higher difficulty. In either case, each success increases or reduces the Attribute by one.
A vampire may use this power to move clumps of skin, fat, and muscle tissue, thus providing additional padding where needed. For each success scored on a Dexterity + Medicine roll (difficulty 8), the vampire may increase the subject’s soak dice pool by one, at the expense of either a point of Strength or a health level (vampire’s choice).

••• Bonecraft
This terrible power allows a vampire to manipulate bone in the same manner that flesh is shaped. In conjunction with Fleshcraft, above, this power enables a Vicissitude practitioner to deform a victim (or herself) beyond recognition. This power should be used in conjunction with the flesh-shaping arts, unless the vampire wants to inflict injury on the victim (see below).
System: The vampire’s player must spend a blood point and make a Strength + Medicine roll (difficulties as above). Bonecraft may be used without the flesh-shaping arts, as an offensive weapon. Each success scored on the Strength + Medicine roll (difficulty 7) inflicts one health level of lethal damage on the victim, as his bones rip, puncture, and slice their way out of his skin.
The vampire may utilize this power (on herself or others) to form spikes or talons of bone, either on the knuckles as an offensive weapon or all over the body as defensive "quills." If bone spikes are used, the vampire or victim takes one health level of lethal damage (the vampire’s comes from having the very sharp bone pierce through his skin — this weaponry doesn’t come cheaply). In the case of quills, the subject takes a number of health levels equal to five minus the number of successes (a botch kills the subject or sends the vampire into torpor). These health levels may be healed normally. Knuckle spikes inflict Strength +1 lethal damage. Defensive quills inflict a hand-to-hand attacker’s Strength in lethal damage unless the attacker scores three or more successes on the attack roll (in which case the attacker takes no damage); the defender still takes damage normally. Quills also enable the vampire or altered subject to add two to all damage inflicted via holds, clinches, or tackles.
A vampire who scores five or more successes on the Strength + Medicine roll may cause a rival vampire’s rib cage to curve inward and pierce the heart. While this does not send a vampire into torpor, it does cause the affected vampire to lose half his blood points, as the seat of his vitae ruptures in a shower of gore.

•••• Horrid Form
Kindred use this power to become hideous and deadly monsters. The vampire’s stature increases to a full eight feet (two and a half meters), the skin becomes a sickly greenish-gray or grayish-black chitin, the arms become apelike and ropy with ragged black nails, and the face warps into something out of a nightmare. A row of spines sprouts from the vertebrae, and the external carapace exudes a foul-smelling grease.
System: The Horrid Form costs two blood points to awaken. All Physical Attributes increase by three, but all Social Attributes drop to zero, except when dealing with others also in Horrid Form. However, a vampire in Horrid Form who is trying to intimidate someone may substitute Strength for a Social Attribute. Damage inflicted in brawling combat increases by one due to the jagged ridges and bony knobs creasing the creature’s hands.

••••• Bloodform
A vampire with this power can physically transform all or part of her body into sentient vitae. This blood is in all respects identical to the vampire’s normal vitae; she can use it to nourish herself or others, create ghouls, or establish blood bonds. If all this blood is imbibed or otherwise destroyed, the vampire meets Final Death.
System: The vampire may transform all or part of herself as she deems fit. Each leg can turn into two blood points worth of vitae, as can the torso; each arm, the head, and the abdomen convert to one blood point each. The blood can be reconverted to the body part, provided it is in contact with the vampire. If the blood has been utilized or destroyed, the vampire must spend a number of blood points equal to what was originally created to regrow the missing body part.
A vampire entirely in this form may not be staked, cut, bludgeoned, or pierced, but can be burned or exposed to the sun. The vampire may ooze along, drip up walls, and flow through the narrowest cracks, as though she were in Tenebrous Form (p. 190).
Mental Disciplines may be used, provided no eye contact or vocal utterance is necessary, although the vampire can perceive her surroundings just fine (but the perceptions are always centered on the largest pool of blood). If a vampire in this form "washes" over a mortal or animal, that mortal must make a Courage roll (difficulty 8) or fly into a panic.]==],
				},
				["Visceratika"] = {
					en = [==[Vampire: The Masquerade 20th Anniversary Edition, p. 475


Visceratika


Visceratika is an extension of the Gargoyles’ natural affinity for stone and earth. Certain Visceratika powers closely resemble some aspects of Protean and, to a lesser extent, Vicissitude. Tremere in a position to know insist that this is pure coincidence, but the few among the Gargoyles who retain scholarly aspirations insist that the Gangrel and Tzimisce blood used to create the bloodline still maintains a certain hold over its members.
For many years, Visceratika was regarded as endemic to the Gargoyle condition, just like the repulsive visage and the wings with which other Kindred associate the bloodline. That is, vampires — including the Tremere — believed that they couldn’t have the one without the others. Supposedly this isn’t true, and provided one can find a Gargoyle tutor, any vampire can learn the Discipline. Of course, that assumes one can find a willing tutor — the Gargoyles aren’t eager to reveal these secrets. Furthermore, few Kindred want to bet that the Tremere are wrong and risk waking up with wings and horns.

• Skin of the Chameleon
This basic power has saved countless Gargoyles breaching the Masquerade — and has allowed just as many to ambush unsuspecting intruders. When Skin of the Chameleon is in effect, the Gargoyle’s skin takes on the color and texture of the surrounding environment. This coloration changes reflexively as long as the Gargoyle maintains a walking pace or slower. More rapid movement causes the Gargoyle’s appearance to blur, negating the camouflaging effect. If this power is used while the Gargoyle is in flight, his skin becomes a reasonable facsimile of the night sky (though it will not shift to mimic nearby skyscrapers or star patterns, and a black silhouette against a brightly lit skyline is likely to be noticed).
System: The player spends one blood point. For the rest of the scene, the Gargoyle’s Stealth dice pool is increased by five. This power is subject to the limitations described above. Any ground movement faster than a walk negates this power’s effect, as does flight (at the Storyteller’s discretion).

•• Scry the Hearthstone
The Gargoyles’ first function for the Tremere was that of guardian and watchdog. This power allows them to know instinctively where anyone is inside a given structure. It even allows the Gargoyle to detect characters concealed by magical means, if the Slave is perceptive enough.
System: The player spends a Willpower point to activate this power, which remains in effect as long as the Gargoyle is within or in contact with the target structure, or until the next sunset. Scry the Hearthstone may be used on anything up to the size of a cave complex, a large theatre, a parking garage, or a mansion. The character gains an innate sense of the location and approximate size and physical condition of all living (or unliving) beings within the structure. To pinpoint a specific individual’s location with this power, the player must succeed in a Perception + Awareness roll (difficulty 6). If the subject is attempting to hide, he may oppose this roll with a roll of Wits + Stealth (difficulty 6).
Scry the Hearthstone may be used to detect the presence of characters who are under Obfuscate or similar powers. In this case, the Gargoyle only knows that there is someone present — she cannot actually see the individual in question. To determine the Gargoyle’s ability to detect Obfuscated characters, compare the relative levels of the Gargoyle’s Visceratika minus one and the intruder’s Obfuscate as per the "Seeing the Unseen" sidebar on p. 142.

••• Bond with the Mountain
The Gargoyle sinks into a stone surface, disappearing into the rock until he wishes to reappear. This power allowed Gargoyles to invade their masters’ enemies’ strongholds, fight until sunrise, then meld with the rocks or stone walls and reappear the next evening. In modern nights, it can take the place of a haven for itinerant Runaways. Unlike the Earth Meld power (p. 199) which it resembles, Bond with the Mountain does not conceal the Gargoyle completely. A faint outline of his body can be seen in the rock where he hides.
System: The player spends two blood points, and the merge takes four turns to complete. This power functions in a fashion similar to the Protean 3 power of Earth Meld, and may only be performed upon bare rock or a similar substance. However, the Gargoyle does not sink fully into the substance with which he merges, and his outline can be detected within the stone with a successful Perception + Alertness roll (difficulty 9). A Gargoyle attacked while Bonded with the Mountain has triple his normal soak dice pool against all forms of attack. However, if he sustains three or more lethal health levels of damage from a single attack, he is forced out of his bond and suffers disorientation similar to that experienced by an Earth Melded character whose slumber is interrupted.

•••• Armor of Terra
At this level of Visceratika, the Gargoyle’s skin hardens and becomes truly rock-like to the touch. The Slave becomes harder to harm, even with fire, and grows inured to injury. A non-Gargoyle learning this level of Visceratika would find her skin becoming gray and rock-like, putting lie to the claim that the Discipline doesn’t carry the risk of the Gargoyle’s curse.
System: This power is automatic and requires no roll; it is always in effect. A vampire with Armor of Terra has one extra soak die for all aggravated and lethal attacks and two for all bashing attacks, reduces all wound penalties by one, and halves the damage dice pool of any fire-based source of injury (this Discipline does not change the rules for Rötschreck, however). The difficulty of all touch-based Perception rolls is increased by two, due to the desensitization of the character’s skin.

••••• Flow Within the Mountain
The Gargoyle is no longer restricted to hiding within stone. Now, he can flow through stone like lava working its way down a mountainside, emerging from the hiding place at any point he wishes. Since this power works on cement or concrete as well as rock, the streets of a modern metropolis afford a Gargoyle some very interesting assassination tools.
System: Once the character has used Bond with the Mountain, the player spends two more blood points to activate Flow Within the Mountain for the duration of the scene. The Gargoyle can move within stone and cement (otherwise using the same rules as the Protean power Earth Control, p. 200). The character can also use this power to walk through a stone wall and emerge on the other side without first using Bond with the Mountain. In this case, the player spends one blood point and rolls Strength (difficulty 8; Potence adds dice or successes normally). The Gargoyle may flow through a maximum thickness in feet equal to the number of successes rolled, or 30 times the number of successes rolled in centimeters. If the wall or barrier is thicker than this, the character is trapped within it until he is chiseled out or uses Flow Within the Mountain to escape.]==],
				},
				-- <<< DISC_DESC_END
};
