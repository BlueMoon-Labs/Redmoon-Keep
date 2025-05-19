/datum/outfit/job/roguetown/refugee/ecclesiast/post_equip(mob/living/carbon/human/H, visualsOnly)
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
