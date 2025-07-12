/datum/job/roguetown/sheriff
	ru_title = "Городской Шериф"
	ru_tutorial = "Вы – городской стражник, что поднялся по служебной лестницы и теперь имеет хоть какие-то полномочия. \
	Повышение вы заслужили уважительным отношением к правосудию и слежкой за тем, чтобы все соблюдали законы Рокхилла. \
	У вас есть власть над городскими стражниками и Маршал исполняет свою волю через вас."
	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	min_pq = 0

/datum/job/roguetown/sheriff/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			index = "Sheriff [index]"
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
