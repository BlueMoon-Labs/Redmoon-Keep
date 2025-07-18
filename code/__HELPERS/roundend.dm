#define POPCOUNT_SURVIVORS "survivors"					//Not dead at roundend
#define POPCOUNT_ESCAPEES "escapees"					//Not dead and on centcom/shuttles marked as escaped

/datum/controller/subsystem/ticker/proc/gather_antag_data()
	var/team_gid = 1
	var/list/team_ids = list()

	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!A.owner)
			continue

		var/list/antag_info = list()
		antag_info["key"] = A.owner.key
		antag_info["name"] = A.owner.name
		antag_info["antagonist_type"] = A.type
		antag_info["antagonist_name"] = A.name //For auto and custom roles
		antag_info["objectives"] = list()
		antag_info["team"] = list()
		var/datum/team/T = A.get_team()
		if(T)
			antag_info["team"]["type"] = T.type
			antag_info["team"]["name"] = T.name
			if(!team_ids[T])
				team_ids[T] = team_gid++
			antag_info["team"]["id"] = team_ids[T]

		if(A.objectives.len)
			for(var/datum/objective/O in A.objectives)
				var/result = O.check_completion() ? "SUCCESS" : "FAIL"
				antag_info["objectives"] += list(list("objective_type"=O.type,"text"=O.explanation_text,"result"=result))
		SSblackbox.record_feedback("associative", "antagonists", 1, antag_info)

/mob/proc/do_game_over()
	if(SSticker.current_state != GAME_STATE_FINISHED)
		return
	if(client)
		client.show_game_over()

/mob/living/do_game_over()
	..()
	adjustEarDamage(0, 6000)
	Stun(6000, 1, 1)
	ADD_TRAIT(src, TRAIT_MUTE, TRAIT_GENERIC)
	walk(src, 0) //stops them mid pathing even if they're stunimmune
	if(isanimal(src))
		var/mob/living/simple_animal/S = src
		S.toggle_ai(AI_OFF)
	if(ishostile(src))
		var/mob/living/simple_animal/hostile/H = src
		H.LoseTarget()
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.mode = NPC_AI_OFF
	if(client)
		client.verbs += /client/proc/lobbyooc

/client/proc/show_game_over()
	var/atom/movable/screen/splash/credits/S = new(src, FALSE)
	S.Fade(FALSE,FALSE, 8 SECONDS)
	RollCredits()
	if(GLOB.credits_icons.len)
		for(var/i=0, i<=GLOB.credits_icons.len, i++)
			var/atom/movable/screen/P = new()
			P.layer = SPLASHSCREEN_LAYER+1
			P.appearance = GLOB.credits_icons
			screen += P

/datum/controller/subsystem/ticker/proc/declare_completion()
	set waitfor = FALSE

	log_game("The round has ended.")

	if(usr?.client?.prefs?.be_russian)
		to_chat(world, "<BR><BR><BR><span class='reallybig'>Вот и закончилась еще одна неделя на территории Королевства Redmoon Keep.</span>")
	else
		to_chat(world, "<BR><BR><BR><span class='reallybig'>So ends another week in Redmoon Keep.</span>")

	get_end_reason()

	var/list/key_list = list()
	for(var/client/C in GLOB.clients)
		if(C.mob)
			SSdroning.kill_droning(C)
			C.mob.playsound_local(C.mob, 'sound/music/credits.ogg', 100, FALSE)
		if(isliving(C.mob) && C.ckey)
			key_list += C.ckey
//	if(key_list.len)
//		add_roundplayed(key_list)
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat != DEAD)
			if(H.get_triumphs() < 0)
				H.adjust_triumphs(1)
	add_roundplayed(key_list)
//	SEND_SOUND(world, sound(pick('sound/misc/roundend1.ogg','sound/misc/roundend2.ogg')))
//	SEND_SOUND(world, sound('sound/misc/roundend.ogg'))

	for(var/mob/M in GLOB.mob_list)
		M.do_game_over()

	for(var/I in round_end_events)
		var/datum/callback/cb = I
		cb.InvokeAsync()
	LAZYCLEARLIST(round_end_events)

	to_chat(world, "Round ID: [GLOB.rogue_round_id]")

	sleep(5 SECONDS)

	gamemode_report()

	sleep(10 SECONDS)

	players_report()

	stats_report()

//	for(var/client/C in GLOB.clients)
//		if(!C.credits)
//			C.RollCredits()
//		C.playtitlemusic(40)

//	var/popcount = gather_roundend_feedback()
//	display_report(popcount)

	CHECK_TICK

//	// Add AntagHUD to everyone, see who was really evil the whole time!
//	for(var/datum/atom_hud/antag/H in GLOB.huds)
//		for(var/m in GLOB.player_list)
//			var/mob/M = m
//			H.add_hud_to(M)

	CHECK_TICK

	//Set news report and mode result
//	mode.set_round_result()

//	send2irc("Server", "Round just ended.")

//	if(length(CONFIG_GET(keyed_list/cross_server)))
//		send_news_report()

	CHECK_TICK

	//These need update to actually reflect the real antagonists
	//Print a list of antagonists to the server log
	var/list/total_antagonists = list()
	//Look into all mobs in world, dead or alive
	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!A.owner)
			continue
		if(!(A.name in total_antagonists))
			total_antagonists[A.name] = list()
		total_antagonists[A.name] += "[key_name(A.owner)]"

	CHECK_TICK

	//Now print them all into the log!
	log_game("Antagonists at round end were...")
	for(var/antag_name in total_antagonists)
		var/list/L = total_antagonists[antag_name]
		log_game("[antag_name]s :[L.Join(", ")].")

	CHECK_TICK
	SSdbcore.SetRoundEnd()
	//Collects persistence features
	if(mode.allow_persistence_save)
		SSpersistence.CollectData()

	//stop collecting feedback during grifftime
	SSblackbox.Seal()

	sleep(10 SECONDS)
	SSvote.initiate_vote("map", "Ratwood players")
	ready_for_reboot = TRUE
	world.SendTGSRoundEnd()
	standard_reboot()

/datum/controller/subsystem/ticker/proc/get_end_reason()
	var/end_reason

	if(istype(SSticker.mode, /datum/game_mode/chaosmode))
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.check_for_lord)
			if(!C.check_for_lord(forced = TRUE))
				end_reason = pick("Without a Monarch, they were doomed to become slaves of Zizo.",
								"Without a Monarch, they were doomed to be eaten by nite creachers.",
								"Without a Monarch, they were doomed to become victims of Gehenna.",
								"Without a Monarch, they were doomed to enjoy a mass-suicide.",
								"Without a Monarch, the Lich made them his playthings.",
								"Without a Monarch, some jealous rival reigned in tyranny.",
								"Without a Monarch, the town was abandoned.")
//		if(C.not_enough_players)
//			end_reason = "The town was abandoned."

		if(C.vampire_werewolf() == "vampire")
			end_reason = "When the Vampires finished sucking the town dry, they moved on to the next one."
		if(C.vampire_werewolf() == "werewolf")
			end_reason = "The Werevolves formed an unholy clan, marauding Rockhill until the end of its daes."

		if(C.cultascended)
			end_reason = "ZIZOZIZOZIZOZIZO"

		if(C.headrebdecree)
			end_reason = "The peasant rebels took control of the throne, hail the new community!"


	if(end_reason)
		to_chat(world, span_bigbold("[end_reason]."))
	else
		to_chat(world, span_bigbold("The town has managed to survive another week."))

/datum/controller/subsystem/ticker/proc/gamemode_report()
	var/list/all_teams = list()
	var/list/all_antagonists = list()

	for(var/datum/team/A in GLOB.antagonist_teams)
		if(!A.members)
			continue
		all_teams |= A

	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!A.owner)
			continue
		all_antagonists |= A

	for(var/datum/team/T in all_teams)
		T.roundend_report()
		for(var/datum/antagonist/X in all_antagonists)
			if(X.get_team() == T)
				all_antagonists -= X
		CHECK_TICK

	var/currrent_category
	var/datum/antagonist/previous_category

	sortTim(all_antagonists, GLOBAL_PROC_REF(cmp_antag_category))

	for(var/datum/antagonist/A in all_antagonists)
		if(!A.show_in_roundend)
			continue
		if(A.roundend_category != currrent_category)
			if(previous_category)
				previous_category.roundend_report_footer()
			A.roundend_report_header()
			currrent_category = A.roundend_category
			previous_category = A
		A.roundend_report()

		CHECK_TICK

	if(all_antagonists.len)
		var/datum/antagonist/last = all_antagonists[all_antagonists.len]
		if(last.show_in_roundend)
			last.roundend_report_footer()


	return

/datum/controller/subsystem/ticker/proc/stats_report()
	var/list/shit = list()
	shit += "<br><span class='bold'>Δ--------------------Δ</span><br>"
	shit += "<br><font color='#9b6937'><span class='bold'>Погибло:</span></font> [deaths]"
	shit += "<br><font color='#af2323'><span class='bold'>Крови пролито:</span></font> [round(blood_lost / 100, 1)]L"
	shit += "<br><font color='#36959c'><span class='bold'>Триумфов Получено:</span></font> [tri_gained]"
	shit += "<br><font color='#a02fa4'><span class='bold'>Триумфов Украдено:</span></font> [tri_lost * -1]"
	shit += "<br><font color='#ffd4fd'><span class='bold'>Удовольствий:</span></font> [cums]"
	if(GLOB.cuckolds.len)
		shit += "<br><font color='#a02fa4'><span class='bold'>Получили рога:</span></font> "
		for(var/i in 1 to GLOB.cuckolds.len)
			shit += GLOB.cuckolds[i]
			if(i != GLOB.cuckolds.len)
				shit += ","
	if(GLOB.confessors.len)
		shit += "<br><font color='#93cac7'><span class='bold'>Покаявшиеся инквизитору:</span></font> "
		for(var/x in GLOB.confessors)
			shit += "[x]"
	// REDMOON ADD START
	// вывод статистики в конце раунда о количестве семей и осквернённых Баотой
	shit += "<br><font color='#115726'><span class='bold'>Пытались создать семью: </span></font> [length(SSfamily.family_candidates)]"
	shit += "<br><font color='#22833f'><span class='bold'>Семей проживало в Рокхилле:</span></font> [SSfamily.families.len]" // family_changes
	shit += "<br><font color='#a1489d'><span class='bold'>Осквернено Баотой:</span></font> [SSround_end_statistics.violated_by_baotha.len]" // baotha_steals_triumphs
	// start_reports_with_gender_lists - вывод статистики в конце раунда о половой принадлежности
	var/count_of_joined_characters = SSround_end_statistics.males + SSround_end_statistics.females + SSround_end_statistics.males_with_vagina + SSround_end_statistics.females_with_penis
	var/percent_of_males = PERCENT(SSround_end_statistics.males/count_of_joined_characters)
	var/percent_of_males_with_vagina = PERCENT(SSround_end_statistics.males_with_vagina/count_of_joined_characters)
	var/percent_of_females = PERCENT(SSround_end_statistics.females/count_of_joined_characters)
	var/percent_of_females_with_penis = PERCENT(SSround_end_statistics.females_with_penis/count_of_joined_characters)
	shit += "<br><span class='bold'>⇕--------------------⇕</span>"
	shit += "<br><font color='#a78fa8'><span class='bold'>Эора подарила Рокхиллу... </span></font> "
	shit += "<br><font color='#4183c0'><span class='italics'>Мужчин:</span></font> [SSround_end_statistics.males] ([percent_of_males]%)"
	shit += "<br><font color='#c74ec1'><span class='italics'>Женщин:</span></font> [SSround_end_statistics.females] ([percent_of_females]%)"
	shit += "<br><font color='#d19445'><span class='italics'>Мужчин с иным началом:</span></font> [SSround_end_statistics.males_with_vagina] ([percent_of_males_with_vagina]%)"
	shit += "<br><font color='#80097a'><span class='italics'>Женщин с иным началом:</span></font> [SSround_end_statistics.females_with_penis] ([percent_of_females_with_penis]%)"
	// species_statistics
	shit += "<br><span class='bold'>⇕--------------------⇕</span>"
	shit += "<br><font color='#489b53'><span class='bold'>Под солнцем Астраты были...</span></font> "
	if(SSround_end_statistics.species_aasimar)			shit += "<br><font color='#36693c'><span class='italics'>Аасимары: </span></font>[SSround_end_statistics.species_aasimar]"
	if(SSround_end_statistics.species_axian)			shit += "<br><font color='#36693c'><span class='italics'>Аксиане: </span></font>[SSround_end_statistics.species_axian]"
	if(SSround_end_statistics.species_anthromorphsmall) shit += "<br><font color='#36693c'><span class='italics'>Верминволки: </span></font>[SSround_end_statistics.species_anthromorphsmall]"
	if(SSround_end_statistics.species_vulpkanin)		shit += "<br><font color='#36693c'><span class='italics'>Вульпканин: </span></font>[SSround_end_statistics.species_vulpkanin]"
	if(SSround_end_statistics.species_goblinp)			shit += "<br><font color='#36693c'><span class='italics'>Гоблины: </span></font>[SSround_end_statistics.species_goblinp]"
	if(SSround_end_statistics.species_dwarf)			shit += "<br><font color='#36693c'><span class='italics'>Дварфы: </span></font>[SSround_end_statistics.species_dwarf]"
	if(SSround_end_statistics.species_anthromorph) 		shit += "<br><font color='#36693c'><span class='italics'>Дикари: </span></font>[SSround_end_statistics.species_anthromorph]"
	if(SSround_end_statistics.species_dracon)			shit += "<br><font color='#36693c'><span class='italics'>Дракониды: </span></font>[SSround_end_statistics.species_dracon]"
	if(SSround_end_statistics.species_drow)				shit += "<br><font color='#36693c'><span class='italics'>Дроу: </span></font>[SSround_end_statistics.species_drow]"
	if(SSround_end_statistics.species_kobold)			shit += "<br><font color='#36693c'><span class='italics'>Кобольды: </span></font>[SSround_end_statistics.species_kobold]"
	if(SSround_end_statistics.species_kraukalee)		shit += "<br><font color='#36693c'><span class='italics'>Краукали: </span></font>[SSround_end_statistics.species_kraukalee]"
	if(SSround_end_statistics.species_lupian)			shit += "<br><font color='#36693c'><span class='italics'>Люпины: </span></font>[SSround_end_statistics.species_lupian]"
	if(SSround_end_statistics.species_humen)			shit += "<br><font color='#36693c'><span class='italics'>Люди: </span></font>[SSround_end_statistics.species_humen]"
	if(SSround_end_statistics.species_moth)				shit += "<br><font color='#36693c'><span class='italics'>Моли: </span></font>[SSround_end_statistics.species_moth]"
	if(SSround_end_statistics.species_demihuman)		shit += "<br><font color='#36693c'><span class='italics'>Полукровки: </span></font>[SSround_end_statistics.species_demihuman]"
	if(SSround_end_statistics.species_halforc)			shit += "<br><font color='#36693c'><span class='italics'>Полуорки: </span></font>[SSround_end_statistics.species_halforc]"
	if(SSround_end_statistics.species_halfelf)			shit += "<br><font color='#36693c'><span class='italics'>Полуэльфы: </span></font>[SSround_end_statistics.species_halfelf]"
	if(SSround_end_statistics.species_lizardfolk)		shit += "<br><font color='#36693c'><span class='italics'>Сиссеане: </span></font>[SSround_end_statistics.species_lizardfolk]"
	if(SSround_end_statistics.species_tabaxi)			shit += "<br><font color='#36693c'><span class='italics'>Табакси: </span></font>[SSround_end_statistics.species_tabaxi]"
	if(SSround_end_statistics.species_tiefling)			shit += "<br><font color='#36693c'><span class='italics'>Тифлинги: </span></font>[SSround_end_statistics.species_tiefling]"
	if(SSround_end_statistics.species_seelie)			shit += "<br><font color='#36693c'><span class='italics'>Феи: </span></font>[SSround_end_statistics.species_seelie]"
	if(SSround_end_statistics.species_elf)				shit += "<br><font color='#36693c'><span class='italics'>Эльфы: </span></font>[SSround_end_statistics.species_elf]"
	// jobs_statistics
	shit += "<br><span class='bold'>⇕--------------------⇕</span>"
	shit += "<br><font color='#9b6937'><span class='bold'>Псайдон распорядился, чтоб был у каждого свой удел:</span></font> "
	var/round_occupations = "<br>"
	for(var/datum/job/roguetown/target_job in SSjob.occupations)
		if(target_job.current_positions > 0)
			round_occupations += "<font color='#b18254'><span class='italics'>[target_job.title]</span></font> - [target_job.current_positions]<br>"
	shit += round_occupations
	// REDMOON ADD END
	shit += "<br><span class='bold'>∇--------------------∇</span>"
	to_chat(world, "[shit.Join()]")
	return

/datum/controller/subsystem/ticker/proc/standard_reboot()
	if(ready_for_reboot)
		if(mode.station_was_nuked)
			Reboot("Station destroyed by Nuclear Device.", "nuke")
		else
			Reboot("Round ended.", "proper completion")
	else
		CRASH("Attempted standard reboot without ticker roundend completion")

//Common part of the report
/datum/controller/subsystem/ticker/proc/build_roundend_report()
	var/list/parts = list()

	//Gamemode specific things. Should be empty most of the time.
	parts += mode.special_report()

	CHECK_TICK

	//Antagonists
	parts += antag_report()

	CHECK_TICK
	//Medals
	parts += medal_report()

	listclearnulls(parts)

	return parts.Join()

/client/proc/roundend_report_file()
	return "data/roundend_reports/[ckey].html"

/datum/controller/subsystem/ticker/proc/show_roundend_report(client/C, previous = FALSE)
	var/datum/browser/roundend_report = new(C, "roundend")
	roundend_report.width = 800
	roundend_report.height = 600
	var/content
	var/filename = C.roundend_report_file()
	if(!previous)
		var/list/report_parts = GLOB.common_report
		content = report_parts.Join()
		C.verbs -= /client/proc/show_previous_roundend_report
		fdel(filename)
		text2file(content, filename)
	else
		content = file2text(filename)
	roundend_report.set_content(content)
	roundend_report.stylesheets = list()
//	roundend_report.add_stylesheet("roundend", 'html/browser/roundend.css')
//	roundend_report.add_stylesheet("font-awesome", 'html/font-awesome/css/all.min.css')
	roundend_report.open(FALSE)

/datum/controller/subsystem/ticker/proc/players_report()
	for(var/client/C in GLOB.clients)
		give_show_playerlist_button(C)

/datum/controller/subsystem/ticker/proc/display_report(popcount)
	GLOB.common_report = build_roundend_report()
	for(var/client/C in GLOB.clients)
		show_roundend_report(C, FALSE)
		give_show_report_button(C)
		CHECK_TICK

/datum/controller/subsystem/ticker/proc/medal_report()
	if(GLOB.commendations.len)
		var/list/parts = list()
		parts += span_header("Medal Commendations:")
		for (var/com in GLOB.commendations)
			parts += com
		return "<div class='panel stationborder'>[parts.Join("<br>")]</div>"
	return ""

/datum/controller/subsystem/ticker/proc/antag_report()
	var/list/result = list()
	var/list/all_teams = list()
	var/list/all_antagonists = list()

	for(var/datum/team/A in GLOB.antagonist_teams)
		if(!A.members)
			continue
		all_teams |= A

	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!A.owner)
			continue
		all_antagonists |= A

	for(var/datum/team/T in all_teams)
		result += T.roundend_report()
		for(var/datum/antagonist/X in all_antagonists)
			if(X.get_team() == T)
				all_antagonists -= X
		result += " "//newline between teams
		CHECK_TICK

	var/currrent_category
	var/datum/antagonist/previous_category

	sortTim(all_antagonists, GLOBAL_PROC_REF(cmp_antag_category))

	for(var/datum/antagonist/A in all_antagonists)
		if(!A.show_in_roundend)
			continue
		if(A.roundend_category != currrent_category)
			if(previous_category)
				result += previous_category.roundend_report_footer()
				result += "</div>"
			result += "<div class='panel redborder'>"
			result += A.roundend_report_header()
			currrent_category = A.roundend_category
			previous_category = A
		result += A.roundend_report()
		result += "<br><br>"
		CHECK_TICK

	if(all_antagonists.len)
		var/datum/antagonist/last = all_antagonists[all_antagonists.len]
		result += last.roundend_report_footer()
		result += "</div>"

	return result.Join()

/proc/cmp_antag_category(datum/antagonist/A,datum/antagonist/B)
	return sorttext(B.roundend_category,A.roundend_category)

/datum/controller/subsystem/ticker/proc/give_show_report_button(client/C)
	var/datum/action/report/R = new
	C.player_details.player_actions += R
	R.Grant(C.mob)
	to_chat(C,"<a href='?src=[REF(R)];report=1'>Show roundend report again</a>")

/datum/controller/subsystem/ticker/proc/give_show_playerlist_button(client/C)
	set waitfor = 0
	to_chat(C,"<a href='?src=[C];playerlistrogue=1'>* SHOW PLAYER LIST *</a>")
	C.commendsomeone(forced = TRUE)

/datum/action/report
	name = "Show roundend report"
	button_icon_state = "round_end"

/datum/action/report/Trigger()
	if(owner && GLOB.common_report && SSticker.current_state == GAME_STATE_FINISHED)
		SSticker.show_roundend_report(owner.client, FALSE)

/datum/action/report/IsAvailable()
	return 1

/datum/action/report/Topic(href,href_list)
	if(usr != owner)
		return
	if(href_list["report"])
		Trigger()
		return

/proc/printplayer(datum/mind/ply, fleecheck)
	var/jobtext = ""
	if(ply.assigned_role)
		jobtext = " the <b>[ply.assigned_role]</b>"
	var/usede = ply.key
	if(ply.key)
		usede = ckey(ply.key)
		if(ckey(ply.key) in GLOB.anonymize)
//			if(check_whitelist(ckey(ply.key)))
			usede = get_fake_key(ckey(ply.key))
	var/text = "<b>[usede]</b> was <b>[ply.name]</b>[jobtext] and"
	if(ply.current)
		if(ply.current.real_name != ply.name)
			text += " <span class='redtext'>died</span>"
		else
			if(ply.current.stat == DEAD)
				text += " <span class='redtext'>died</span>"
			else
				text += " <span class='greentext'>survived</span>"
//		if(fleecheck)
//			var/turf/T = get_turf(ply.current)
//			if(!T || !is_station_level(T.z))
//				text += " while <span class='redtext'>fleeing the station</span>"
//		if(ply.current.real_name != ply.name)
//			text += " as <b>[ply.current.real_name]</b>"
	to_chat(world, "[text]")

/proc/printplayerlist(list/players,fleecheck)
	var/list/parts = list()

	parts += "<ul class='playerlist'>"
	for(var/datum/mind/M in players)
		parts += "<li>[printplayer(M,fleecheck)]</li>"
	parts += "</ul>"
	return parts.Join()


/proc/printobjectives(list/objectives)
	if(!objectives || !objectives.len)
		return
	var/list/objective_parts = list()
	var/count = 1
	for(var/datum/objective/objective in objectives)
		if(objective.check_completion())
			objective_parts += "<b>[objective.flavor] #[count]</b>: [objective.explanation_text] <span class='greentext'>Success!</span>"
		else
			objective_parts += "<b>[objective.flavor] #[count]</b>: [objective.explanation_text] <span class='redtext'>Fail.</span>"
		count++
	return objective_parts.Join("<br>")

/datum/controller/subsystem/ticker/proc/save_admin_data()
	if(IsAdminAdvancedProcCall())
		to_chat(usr, span_adminprefix("Admin rank DB Sync blocked: Advanced ProcCall detected."))
		return
	if(CONFIG_GET(flag/admin_legacy_system)) //we're already using legacy system so there's nothing to save
		return
	else if(load_admins(TRUE)) //returns true if there was a database failure and the backup was loaded from
		return
	sync_ranks_with_db()
	var/list/sql_admins = list()
	for(var/i in GLOB.protected_admins)
		var/datum/admins/A = GLOB.protected_admins[i]
		sql_admins += list(list("ckey" = A.target, "rank" = A.rank.name))
	SSdbcore.MassInsert(format_table_name("admin"), sql_admins, duplicate_key = TRUE)
	var/datum/DBQuery/query_admin_rank_update = SSdbcore.NewQuery("UPDATE [format_table_name("player")] p INNER JOIN [format_table_name("admin")] a ON p.ckey = a.ckey SET p.lastadminrank = a.rank")
	query_admin_rank_update.Execute()
	qdel(query_admin_rank_update)

	//json format backup file generation stored per server
	var/json_file = file("data/admins_backup.json")
	var/list/file_data = list("ranks" = list(), "admins" = list())
	for(var/datum/admin_rank/R in GLOB.admin_ranks)
		file_data["ranks"]["[R.name]"] = list()
		file_data["ranks"]["[R.name]"]["include rights"] = R.include_rights
		file_data["ranks"]["[R.name]"]["exclude rights"] = R.exclude_rights
		file_data["ranks"]["[R.name]"]["can edit rights"] = R.can_edit_rights
	for(var/i in GLOB.admin_datums+GLOB.deadmins)
		var/datum/admins/A = GLOB.admin_datums[i]
		if(!A)
			A = GLOB.deadmins[i]
			if (!A)
				continue
		file_data["admins"]["[i]"] = A.rank.name
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))

/datum/controller/subsystem/ticker/proc/update_everything_flag_in_db()
	for(var/datum/admin_rank/R in GLOB.admin_ranks)
		var/list/flags = list()
		if(R.include_rights == R_EVERYTHING)
			flags += "flags"
		if(R.exclude_rights == R_EVERYTHING)
			flags += "exclude_flags"
		if(R.can_edit_rights == R_EVERYTHING)
			flags += "can_edit_flags"
		if(!flags.len)
			continue
		var/flags_to_check = flags.Join(" != [R_EVERYTHING] AND ") + " != [R_EVERYTHING]"
		var/datum/DBQuery/query_check_everything_ranks = SSdbcore.NewQuery(
			"SELECT flags, exclude_flags, can_edit_flags FROM [format_table_name("admin_ranks")] WHERE rank = :rank AND ([flags_to_check])",
			list("rank" = R.name)
		)
		if(!query_check_everything_ranks.Execute())
			qdel(query_check_everything_ranks)
			return
		if(query_check_everything_ranks.NextRow()) //no row is returned if the rank already has the correct flag value
			var/flags_to_update = flags.Join(" = [R_EVERYTHING], ") + " = [R_EVERYTHING]"
			var/datum/DBQuery/query_update_everything_ranks = SSdbcore.NewQuery(
				"UPDATE [format_table_name("admin_ranks")] SET [flags_to_update] WHERE rank = :rank",
				list("rank" = R.name)
			)
			if(!query_update_everything_ranks.Execute())
				qdel(query_update_everything_ranks)
				return
			qdel(query_update_everything_ranks)
		qdel(query_check_everything_ranks)
