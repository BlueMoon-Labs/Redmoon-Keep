/mob/living/carbon/human/species/avian
	race = /datum/species/avian

/datum/species/avian
	name = "Avian"
	ru_name = "Авиан"
	id = "avian"
	desc = "<b>Avian</b><br>\
	Avians are the sons and daughters of Scree'Auk, which some other peoples and Gods were able to adopt. \
	They are bird-like creatures with feathers, beak and often wings, as additional limbs or embedded in theirs arms. \
	They are attentive, dexterous, cunning and very intelligent, at the same time more fragile, than other animals around them. \
	The history of avian nests is rooted very deeply through the birth of this world, although their history has been \
	preserved by very few, who live outside the flocks - many do not even know the true history of their origin, often \
	being perceived as wild-kin. These birds differ in their cultures, often more radically to each other than to \
	other races, but even so, many try to maintain community, migrating in large and small groups, trying to find a \
	new home where they can build a new nest for all their kind."
	expanded_desc = ""
	ru_desc = "<b>Авиан</b><br>\
	Авиане это сыны и дочери Скри'Ок, кто были приняты другими народами и Богами. \
	Они птицеподобные существа, имеющие перья, клюв и не редко крылья, как дополнительные конечности или встроенные в их руки. \
	Они внимательные, ловкие, хитрые и очень умные, в то же время более хрупкие, чем другие звери вокруг них. \
	История гнёзд авиан прорастает корнями очень глубоко в историю зарождения этого мира, хотя их история сохранилась \
	очень не многими, кто живёт вне стай - многие даже не знают подлинной истории своего происхождения, \
	не редко воспринимаясь как wild-kin. Эти птицы разнятся в своих культурах, не редко более радикально друг к другу, \
	нежели к другим расам, но даже так, многие стараются сохранять общность, мигрируя большими и малыми группами, стараясь \
	найти себе новый дом, где смогут построить новое гнездо для всех им подобных. "
	ru_expanded_desc = ""
	skin_tone_wording = "Nest"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
	)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	attack_verb = "slash"
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/met.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	use_f = TRUE
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list(
		"strength" = -1,
		"perception" = 1,
		"intelligence" = 2,
		"constitution" = -2,
		"endurance" = -2,
		"speed" = 3,
		"fortune" = 0
		)
	specstats_m = list() // Половой деморфизм отсутствует
	specstats_f = list() // Половой деморфизм отсутствует
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/avian,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/avian,
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/snout/avian,
		/datum/customizer/organ/ears/anthro,
		/datum/customizer/organ/horns/humanoid,
		/datum/customizer/organ/neck_feature/avian,
		/datum/customizer/organ/tail/anthro,
		/datum/customizer/organ/wings/avian,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/human_anthro,
		/datum/customizer/organ/butt/animal,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)
	body_markings = list(
		/datum/body_marking/backspots,
		/datum/body_marking/belly,
		/datum/body_marking/bellyslim,
		/datum/body_marking/butt,
		/datum/body_marking/drake_eyes,
		/datum/body_marking/eyeliner,
		/datum/body_marking/fox,
		/datum/body_marking/front,
		/datum/body_marking/harlequin,
		/datum/body_marking/harlequinreversed,
		/datum/body_marking/plain,
		/datum/body_marking/sock,
		/datum/body_marking/sock/tertiary,
		/datum/body_marking/socklonger,
		/datum/body_marking/spotted,
		/datum/body_marking/tie,
		/datum/body_marking/tiesmall,
		/datum/body_marking/tiger,
		/datum/body_marking/tiger/dark,
		/datum/body_marking/tips,
		/datum/body_marking/tonage,
		/datum/body_marking/wolf
	)
	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/feathers,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one,
		/datum/descriptor_choice/prominent_two,
		/datum/descriptor_choice/prominent_three,
		/datum/descriptor_choice/prominent_four,
	)
	languages = list(
		/datum/language/common,
		/datum/language/avian
	)

/datum/species/avian/check_roundstart_eligible()
	return TRUE

/datum/species/avian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/avian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/avian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/avian/get_skin_list()
	return list(
		"Vakran" = "271f1b",
		"Lanarain" = "271f1c",
		"Frostfell" = "271f1d",
		"Varghelm" = "271f1e",
		"Dawnbreak" = "271f1f",
		"Bloodmoon" = "271f2a",
		"Felsaad" = "271f2b",
		"Hizmut" = "271f2c",
		"Langqan" = "271f2d",
		"a tangled lineage" = "271f2e",
		"disputed" = "271f2f",
		"bastardized" = "271f3a"
	) // This is a dirty hack that stops me using mob defines, the colors do not do anything, it just a var that relates to their pack name on examine

/datum/species/avian/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly dark, wolfish colors
	switch(random)
		if(1)
			main_color = "f3efe6"
			second_color = "dcd8ce"
		if(2)
			main_color = "948e86"
			second_color = "cdcccc"
		if(3)
			main_color = "4d4c4c"
			second_color = "706c69"
		if(4)
			main_color = "32312c"
			second_color = "8D7F69"
		if(5)
			main_color = "282421"
			second_color = "645b54"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = "373330"
	return returned

/datum/species/avian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.verbs += list(
		/mob/living/carbon/human/verb/emote_chirp,
		/mob/living/carbon/human/verb/emote_caw,
		/mob/living/carbon/human/verb/emote_hoot,
		/mob/living/carbon/human/verb/emote_bawk,
		/mob/living/carbon/human/verb/emote_bird_trill,
		/mob/living/carbon/human/verb/emote_chirp_squeaky,
		/mob/living/carbon/human/verb/emote_pip,
	)

/datum/species/avian/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.verbs -= list(
		/mob/living/carbon/human/verb/emote_chirp,
		/mob/living/carbon/human/verb/emote_caw,
		/mob/living/carbon/human/verb/emote_hoot,
		/mob/living/carbon/human/verb/emote_bawk,
		/mob/living/carbon/human/verb/emote_bird_trill,
		/mob/living/carbon/human/verb/emote_chirp_squeaky,
		/mob/living/carbon/human/verb/emote_pip
	)
