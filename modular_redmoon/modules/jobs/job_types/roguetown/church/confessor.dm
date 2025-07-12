/datum/job/roguetown/shepherd
	ru_title = "Исповедник"
	ru_f_title = "Исповедница"
	ru_tutorial = "Теневые агенты церкви, нанятые для шпионажа за населением и поддержания его морали. \
	Как самые фанатичные представители духовенства, они в первую очередь помогают местному инквизитору в его работе. \
	Будь то выбивание признаний в грехах или охота на ночных зверей и культистов, которые прячутся у всех на виду."
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
	min_pq = 0

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)

/datum/job/roguetown/shepherd/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			index = "Confessor [index]"
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
