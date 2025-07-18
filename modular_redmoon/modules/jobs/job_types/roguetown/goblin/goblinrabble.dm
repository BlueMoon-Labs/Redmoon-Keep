/datum/job/roguetown/goblinrabble
	ru_title = "Племенной раб"
	ru_f_title = "Племенная рабыня"
	ru_tutorial = "Вы – самый низший из низших. Гоблин или не-гоблин среди многих других гоблинов. \
		О вас нечего особо рассказать, кроме того, что ваш Вождь не смотрит на вас как \
		пригодного для иной службы."
	announce_latejoin = FALSE
	allowed_races = ALL_RACES_TYPES
	min_pq = 0

/obj/effect/landmark/start/goblinrabble // Позволяет спавниться на этих точках гоблинам вместо обычных мест лейтжоина
	jobspawn_override = list("Goblin Chief", "Goblin Shaman", "Goblin Rabble", "Goblin Smith", "Goblin Guard", "Goblin Cook")

/datum/outfit/job/roguetown/goblinrabble/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE) // economy_fix - рабы гоблинов умеют копать
		H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
		ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
