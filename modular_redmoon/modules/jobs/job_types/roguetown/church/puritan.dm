/datum/job/roguetown/puritan
	ru_title = "Инквизитор"
	ru_tutorial = "Вы – присланный от ордена Инквизиции священный судия. \
	Вашей волей определяются неверные пантеону Десяти и вы опредяете подходящую им божественную кару. \
	Среди всей черни, что населяет Рокхилл, лишь на храмовников вы можете положиться как самых верных \
	Храму и вере воинов... Хоть и не приходитесь им командиром."
	min_pq = 0

/datum/outfit/job/roguetown/puritan/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backpack_contents = list(/obj/item/storage/keyring/puritan = 1, /obj/item/rogueweapon/huntingknife/idagger/silver, /obj/item/lockpick = 1, /obj/item/storage/belt/rogue/pouch/coins/rich)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)

/datum/job/roguetown/puritan/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak))
			var/obj/item/clothing/cloak/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			index = "Inquisitor [index]"
			S.name += " ([index])"
			S.visual_name = index // REDMOON ADD - tabard_fix
	..()
