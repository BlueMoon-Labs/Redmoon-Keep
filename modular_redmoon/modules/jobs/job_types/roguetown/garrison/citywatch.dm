/datum/job/roguetown/citywatch
	ru_title = "Городской стражник"
	ru_f_title = "Городская стражница"
	ru_tutorial = "Призывные граждане, набранные из рядов разного сорта жителей острова. Вы могли откупиться от службы, \
	но не сделали этого. У вас хорошая плата, хоть и посредственное жилье, удовлетворительная лояльность, и вы сражаетесь за свой дом, \
	город. В вашу сторону постоянно сыплются обвиняются в угнетении и обложении налогами тех, кого считаете ниже себя."
	min_pq = 0
	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/job/roguetown/citywatch/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			index = "Watchman [index]"
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
