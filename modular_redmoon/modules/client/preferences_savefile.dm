/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["be_russian"]										>> be_russian
	S["donator_bonus_received"]    						>> donator_bonus_received

	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance

	// memory_for_family_members
	S["spouse_ckey"]									>> spouse_ckey
	S["spouse_name"]									>> spouse_name
	S["family_surname"]									>> family_surname
	S["allow_alt_genitals_for_spouse"]					>> allow_alt_genitals_for_spouse

	_load_loadout(S)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"]							, be_russian)
	WRITE_FILE(S["donator_bonus_received"]				, donator_bonus_received)

	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)

	if(loadout)
		WRITE_FILE(S["loadout"] 						, loadout.type)
	else
		WRITE_FILE(S["loadout"] 						, null)

	WRITE_FILE(S["spouse_ckey"] 						, spouse_ckey) // memory_for_family_members - ckey второй половинки
	WRITE_FILE(S["spouse_name"] 						, spouse_name) // memory_for_family_members - имя второй половинки
	WRITE_FILE(S["family_surname"] 						, family_surname) // memory_for_family_members - фамилия семьи
	WRITE_FILE(S["allow_alt_genitals_for_spouse"] 		, allow_alt_genitals_for_spouse) // memory_for_family_members - позволяет использовать альтернативные гениталии

/datum/preferences/proc/redmoon_copy_character(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	character.allow_alt_genitals_for_spouse = allow_alt_genitals_for_spouse // memory_for_family_members
	character.spouse_ckey = spouse_ckey // memory_for_family_members
	character.spouse_name = spouse_name // memory_for_family_members
	character.family_surname = family_surname // memory_for_family_members

/datum/preferences/proc/_load_loadout(S)
	var/loadout_type
	S["loadout"] >> loadout_type
	if (loadout_type)
		loadout = new loadout_type()
