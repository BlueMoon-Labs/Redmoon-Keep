/datum/job/roguetown/nightmaiden
	ru_title = "Проститут"
	ru_f_title = "Проститутка"
	ru_tutorial = "Продавая свое тело, как кусок мяса в мясной лавке, лишая себя достоинства и обращаясь как с товаром, \
	вы остаетесь послушным своему сутенеру. Каждый день вы боретесь за выживание в мире, который не предлагает вам ничего, кроме презрения."
	min_pq = 0
	family_blacklisted = TRUE // family_changes - проститутка не должна образовывать случайные семьи

/datum/outfit/job/roguetown/nightmaiden/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
		ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
