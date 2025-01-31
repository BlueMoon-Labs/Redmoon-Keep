// Check comments with "memory_for_family_members" for all related code.

/mob/living/carbon/human
	var/allow_alt_genitals_for_spouse = FALSE // Разрешает партнёрше/партнёру иметь альтернативные гениталии
	var/spouse_ckey = null // Ckey второго члена семьи (жены или мужа)
	var/spouse_name = null // Имя второго члена семьи (жены или мужа)
	var/family_surname = null // Фамилия семьи

/datum/preferences
	var/spouse_ckey = null
	var/spouse_name = null
	var/family_surname = null
	var/allow_alt_genitals_for_spouse = FALSE

