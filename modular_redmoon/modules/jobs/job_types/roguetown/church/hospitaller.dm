/datum/job/roguetown/hospitaller
	ru_title = "Госпитальер"
	ru_f_title = "Госпитальер"
	ru_tutorial = "As an follower of Pestra, you have joined the Hospitallers, an order dedicated to counter the \
	rot plague and treating the living. Your patron claims dominion over Decay, Disease and Medicine. With the Rot \
	plague growing its up to you to help those stricken."
	min_pq = 0

/datum/job/roguetown/hospitaller/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
