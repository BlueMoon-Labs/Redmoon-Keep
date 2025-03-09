/datum/preferences/proc/redmoon_character_pref_load(savefile/S)
	S["be_russian"]										>> be_russian
	S["donator_bonus_received"]    						>> donator_bonus_received

	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance

	// family_changes
	S["spouse_ckey"]									>> spouse_ckey
	S["family_surname"]									>> family_surname
	S["family_genitals"] 								>> family_genitals

	S["prefer_old_chat"]								>> prefer_old_chat

	if(!islist(family_genitals))
		family_genitals = list()
		for(var/A in list("Male", "Female"))
			family_genitals += A

	// rumors_addition
	S["use_rumors"]										>> use_rumors


	S["rumors_secret"]									>> rumors_secret
	S["rumors_prefered_beginnings"]						>> rumors_prefered_beginnings
	S["rumors_prefered_races"]							>> rumors_prefered_races

	S["rumors_prefered_behavior_in_bed"]				>> rumors_prefered_behavior_in_bed
	S["rumors_prefered_behavior_with_problems"]			>> rumors_prefered_behavior_with_problems
	S["rumors_prefered_behavior_in_work"]				>> rumors_prefered_behavior_in_work
	S["rumors_prefered_ways_to_relax"]					>> rumors_prefered_ways_to_relax
	S["rumors_prefered_behavior_in_combat"]				>> rumors_prefered_behavior_in_combat

	if(!islist(rumors_secret))
		rumors_secret = list()
	if(!islist(rumors_prefered_beginnings))
		rumors_prefered_beginnings = list()
	if(!islist(rumors_prefered_races))
		rumors_prefered_races = list()
	if(!islist(rumors_prefered_behavior_in_bed))
		rumors_prefered_behavior_in_bed = list()
	if(!islist(rumors_prefered_ways_to_relax))
		rumors_prefered_ways_to_relax = list()

	_load_loadout(S)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["be_russian"]							, be_russian)
	WRITE_FILE(S["donator_bonus_received"]				, donator_bonus_received)

	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)

	WRITE_FILE(S["prefer_old_chat"]						, prefer_old_chat)

	if(loadout)
		WRITE_FILE(S["loadout"] 						, loadout.type)
	else
		WRITE_FILE(S["loadout"] 						, null)

	WRITE_FILE(S["spouse_ckey"] 						, spouse_ckey) // family_changes - ckey второй половинки
	WRITE_FILE(S["family_surname"] 						, family_surname) // family_changes - фамилия семьи
	WRITE_FILE(S["family_genitals"] 					, family_genitals) // family_changes - проверка на половые органы партнёра

	WRITE_FILE(S["use_rumors"]							, use_rumors)

	WRITE_FILE(S["rumors_secret"]						, rumors_secret) // rumors_addition
	WRITE_FILE(S["rumors_prefered_beginnings"]			, rumors_prefered_beginnings) // rumors_addition
	WRITE_FILE(S["rumors_prefered_races"]				, rumors_prefered_races) // rumors_addition

	WRITE_FILE(S["rumors_prefered_behavior_in_bed"]		, rumors_prefered_behavior_in_bed) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_with_problems"]	, rumors_prefered_behavior_with_problems) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_in_work"]	, rumors_prefered_behavior_in_work) // rumors_addition
	WRITE_FILE(S["rumors_prefered_ways_to_relax"]		, rumors_prefered_ways_to_relax) // rumors_addition
	WRITE_FILE(S["rumors_prefered_behavior_in_combat"]	, rumors_prefered_behavior_in_combat) // rumors_addition

/datum/preferences/proc/redmoon_copy_character(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	character.spouse_ckey = spouse_ckey // family_changes
	character.family_surname = family_surname // family_changes
	character.family_genitals = family_genitals

	character.use_rumors = use_rumors // rumors_addition

	character.rumors_secret = rumors_secret // rumors_addition
	character.rumors_prefered_beginnings= rumors_prefered_beginnings // rumors_addition
	character.rumors_prefered_races = rumors_prefered_races // rumors_addition

	character.rumors_prefered_behavior_in_bed = rumors_prefered_behavior_in_bed // rumors_addition
	character.rumors_prefered_behavior_with_problems = rumors_prefered_behavior_with_problems // rumors_addition
	character.rumors_prefered_behavior_in_work = rumors_prefered_behavior_in_work // rumors_addition
	character.rumors_prefered_ways_to_relax = rumors_prefered_ways_to_relax // rumors_addition
	character.rumors_prefered_behavior_in_combat = rumors_prefered_behavior_in_combat // rumors_addition

/datum/preferences/proc/_load_loadout(S)
	var/loadout_type
	S["loadout"] >> loadout_type
	if (loadout_type)
		loadout = new loadout_type()
