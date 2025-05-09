/datum/game_mode
	var/list/datum/mind/vurdalaks = list()
	var/list/datum/mind/pre_vurdalaks = list()

/datum/game_mode/chaosmode/proc/pick_vurdalaks()
	// Ideally we want Refugees/Towners to roll it
	restricted_jobs = list(
	"Duke",
	"Duke Consort",
	"Dungeoneer",
	"Inquisitor",
	"Confessor",
	"Watchman",
	"Man at Arms",
	"Priest",
	"Acolyte",
	"Cleric",
	"Retinue Captain",
	"Court Magos",
	"Templar",
	"Vanguard",
	"Warden",
	"Knight",
	"Mortician",
	"Mercenary",
	"Bandit",
	"Goblin Chief",
	"Goblin Cook",
	"Goblin Guard",
	"Goblin Rabble",
	"Goblin Smith",
	"Goblin Shaman"
	)

//	var/num_werewolves = rand(1)
	antag_candidates = get_players_for_role(ROLE_VURDALAK)
	antag_candidates = shuffle(antag_candidates)

	for(var/datum/mind/vurdalak in antag_candidates)
		var/blockme = FALSE
		if(!(vurdalak in allantags))
			blockme = TRUE
		if(vurdalak.assigned_role in GLOB.noble_positions)
			continue
		if(vurdalak.assigned_role in GLOB.youngfolk_positions)
			blockme = TRUE
		if(blockme)
			continue
		allantags -= vurdalak
		pre_vurdalaks += vurdalak
		vurdalak.special_role = ROLE_VURDALAK
		//vurdalak.assigned_role = ROLE_WEREWOLF
		vurdalak.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(vurdalak)] has been selected as a VURDALAK")
		log_game("[key_name(vurdalak)] has been selected as a [vurdalak.special_role]")
		antag_candidates.Remove(vurdalak)
		break
	for(var/antag in pre_vurdalaks)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()
