/datum/job/roguetown/marshal
	ru_title = "Маршал"
	ru_tutorial = "Вы и ваши Советники являетесь судьей и присяжными, подчиняясь только Его Величеству. \
	Планируйте с Советниками все вопросы, законы, решения и строительство, необходимые для адаптации к новому миру. \
	Ваши два помощника-Советника служат вам, чтобы подпитывать ваши замечательные идеи, приподнимая с ваших плеч бремя ответственности. \
	Делегируйте задачи, вершите правосудие над непокорными. Поддерживайте работу города и обогащайте его новой архитектурой. \
	В конце концов, Герцог доверил вам руководство и поддержание его военной мощи. \
	Это может быть земля Герцога, но именно вы дергаете за ниточки в этом городе. \
	Всё во имя исполнения вашего долга перед Герцогом."
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/job/roguetown/marshal/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			index = "Marshall [index]"
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
