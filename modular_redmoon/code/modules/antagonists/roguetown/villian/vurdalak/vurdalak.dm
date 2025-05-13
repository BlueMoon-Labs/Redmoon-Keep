/mob/living/carbon/human/proc/vurdalak_transform()
	if(!mind)
		log_runtime("NO MIND ON [src.name] WHEN TRANSFORMING")
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		qdel(W)
	set_cmode(FALSE)
	if(client)
		SSdroning.play_area_sound(get_area(src), client)
//	stop_cmusic()

	var/ww_path
	if(gender == MALE)
		ww_path = /mob/living/carbon/human/species/vurdalak/male
	else
		ww_path = /mob/living/carbon/human/species/vurdalak/female

	var/mob/living/carbon/human/species/vurdalak/W = new ww_path(loc)

	W.set_patron(/datum/patron/godless)
	W.gender = gender
	W.regenerate_icons()
	W.limb_destroyer = TRUE

	W.ambushable = FALSE
	W.cmode_music = 'modular_redmoon/sounds/music/combat_vurdalak.ogg'
	W.skin_armor = new /obj/item/clothing/suit/roguetown/armor/skin_armor/vurdalak_skin(W)

	W.after_creation()
	mind.transfer_to(W)
	W.mind.known_skills = list()
	W.mind.skill_experience = list()
	W.real_name = W.dna.species.random_name()
	W.name =  W.real_name
	W.mob_biotypes |= MOB_UNDEAD
	W.faction = list("undead")

	W.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	W.update_a_intents()
	W.can_do_sex = FALSE
	W.grant_all_languages(omnitongue = FALSE)

	W.possible_rmb_intents = list(/datum/rmb_intent/feint,\
	/datum/rmb_intent/riposte,\
	/datum/rmb_intent/weak)

	W.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	W.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	W.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	W.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	W.mind.adjust_skillrank(/datum/skill/misc/swimming, 5, TRUE)

	W.mind.RemoveAllSpells()
	W.mind.AddSpell(new /obj/effect/proc_holder/spell/self/claws_vurdalak)
	W.mind.AddSpell(new /obj/effect/proc_holder/spell/self/vurdalak_targets_search)
	W.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/vurdalak_rejuv)
	W.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/vurdalak_feast)
	
	qdel(src)

/mob/living/carbon/human/proc/vurdalak_feed(mob/living/carbon/human/target)
	if(!istype(target))
		return

	to_chat(src, span_warning("I feed on succulent flesh. I feel reinvigorated."))
	adjust_hydration(50)
	adjust_nutrition(50)
	return src.reagents.add_reagent(/datum/reagent/medicine/healthpot, 2)

/obj/item/clothing/suit/roguetown/armor/skin_armor/vurdalak_skin
	slot_flags = null
	name = "vurdalak's skin"
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "bullet" = 150, "laser" = 0,"energy" = 0, "bomb" = 100, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = FALSE
	max_integrity = 200
	item_flags = DROPDEL

/datum/intent/simple/vurdalak
	name = "claw"
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("claws", "mauls", "eviscerates")
	animname = "chop"
	hitsound = "genslash"
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"
	item_d_type = "slash"

/obj/item/rogueweapon/vurdalak_claw
	name = "claws"
	desc = ""
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/32.dmi'
	max_blade_int = 999999
	max_integrity = 999999
	force = 20 // Penetration + strength
	block_chance = 0
	wdefense = 4
	armor_penetration = 30
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	possible_item_intents = list(/datum/intent/simple/vurdalak)
	parrysound = list('sound/combat/parry/parrygen.ogg')
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	item_flags = DROPDEL

/obj/item/rogueweapon/vurdalak_claw/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOEMBED, TRAIT_GENERIC)

/obj/item/rogueweapon/vurdalak_claw/right
	icon_state = "claw_r"

/obj/item/rogueweapon/vurdalak_claw/left
	icon_state = "claw_l"
