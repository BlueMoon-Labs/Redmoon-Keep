/mob/living/carbon/human/species/vurdalak
	race = /datum/species/vurdalak

/mob/living/carbon/human/species/vurdalak/male
	gender = MALE

/mob/living/carbon/human/species/vurdalak/female
	gender = FEMALE

/datum/species/vurdalak
	name = "vurdalak"
	id = "vurdalak"
	species_traits = list(NO_UNDERWEAR, NO_ORGAN_FEATURES, NO_BODYPART_FEATURES)
	inherent_traits = list(
		TRAIT_STRONGBITE,
		TRAIT_ZJUMP,
		TRAIT_NOFALLDAMAGE1,
		TRAIT_STEELHEARTED,
		TRAIT_TOXIMMUNE,
		TRAIT_ORGAN_EATER,
		TRAIT_NASTY_EATER,
		TRAIT_NOSTINK,
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_HARDDISMEMBER, //Decapping Volfs causes them to bug out, badly, and need admin intervention to fix. Bandaid fix.
//		TRAIT_PIERCEIMMUNE, //Prevents weapon dusting and caltrop effects due to them transforming when killed/stepping on shards.
		TRAIT_BOG_TREKKING,
		TRAIT_IGNORESLOWDOWN,
		TRAIT_NOPAINSTUN, 
		TRAIT_LIMPDICK,
		TRAIT_NOMOOD,
		TRAIT_NOSLEEP,
		TRAIT_ZOMBIE_IMMUNE,
		TRAIT_DODGEEXPERT,
		TRAIT_GROUNDSLEEPER,
		TRAIT_NORUN
	)
	inherent_biotypes = MOB_HUMANOID
	armor = 30
	no_equip = list(SLOT_SHIRT, SLOT_HEAD, SLOT_WEAR_MASK, SLOT_ARMOR, SLOT_GLOVES, SLOT_SHOES, SLOT_PANTS, SLOT_CLOAK, SLOT_BELT, SLOT_BACK_R, SLOT_BACK_L, SLOT_S_STORE)
	nojumpsuit = 1
	sexes = 0
	offset_features = list(OFFSET_HANDS = list(0,2), OFFSET_HANDS_F = list(0,2))
	soundpack_m = /datum/voicepack/werewolf
	soundpack_f = /datum/voicepack/werewolf
	specstats = list(
		"strength" = 5, 
		"perception" = -2, 
		"intelligence" = -2, 
		"constitution" = 6, 
		"endurance" = 6, 
		"speed" = 2, 
		"fortune" = 0
		)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/night_vision/zombie,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		)
	languages = list(
		/datum/language/hellspeak,
	)

/datum/species/vurdalak/send_voice(mob/living/carbon/human/H)
	playsound(get_turf(H), pick('sound/vo/mobs/wwolf/wolftalk1.ogg','sound/vo/mobs/wwolf/wolftalk2.ogg'), 100, TRUE, -1)

/datum/species/vurdalak/regenerate_icons(mob/living/carbon/human/H)
	H.icon = 'modular_redmoon/icons/mobs/vurdalak.dmi'
	H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	H.icon_state = "vurdalack"
	H.update_damage_overlays()
	return TRUE

/datum/species/vurdalak/spec_life(mob/living/carbon/human/H)
	..()
	H.blood_volume = min(H.blood_volume + 5, BLOOD_VOLUME_NORMAL)
	H.heal_wounds(2)
	H.adjustBruteLoss(-2, 0)
	H.adjustFireLoss(-2, 0)
	H.adjustOxyLoss(-0.5, 0)
	H.adjustCloneLoss(-0.5, 0) //heals as half as health
	H.update_damage_overlays()

/datum/species/vurdalak/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/vurdalak/update_damage_overlays(mob/living/carbon/human/H)
	return TRUE // Временно отключено, до спрайтов дамага
	H.remove_overlay(DAMAGE_LAYER)
	var/list/hands = list()
	var/mutable_appearance/inhand_overlay = mutable_appearance("[H.icon_state]-dam", layer=-DAMAGE_LAYER)
	var/burnhead = 0
	var/brutehead = 0
	var/burnch = 0
	var/brutech = 0
	var/obj/item/bodypart/affecting = H.get_bodypart(BODY_ZONE_HEAD)
	if(affecting)
		burnhead = (affecting.burn_dam / affecting.max_damage)
		brutehead = (affecting.brute_dam / affecting.max_damage)
	affecting = H.get_bodypart(BODY_ZONE_CHEST)
	if(affecting)
		burnch = (affecting.burn_dam / affecting.max_damage)
		brutech = (affecting.brute_dam / affecting.max_damage)
	var/usedloss = 0
	if(burnhead > usedloss)
		usedloss = burnhead
	if(brutehead > usedloss)
		usedloss = brutehead
	if(burnch > usedloss)
		usedloss = burnch
	if(brutech > usedloss)
		usedloss = brutech
	inhand_overlay.alpha = 255 * usedloss
	testing("damalpha [inhand_overlay.alpha]")
	hands += inhand_overlay
	H.overlays_standing[DAMAGE_LAYER] = hands
	H.apply_overlay(DAMAGE_LAYER)
	return TRUE

/datum/species/vurdalak/random_name(gender,unique,lastname)
	return pick("Vurdalak", "Nightcurse", "Night Creature", "Abomination", "Creature", "Monster", "Beast", "Terrorbog Beast", "Rockhill Beast", "Nighthunter", "Nightshade", "Dreadclaw", "Nightstalker")
