/proc/get_playerquality(key, text)
	if(!key)
		return
	var/the_pq = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/pq_num.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	if(json[ckey(key)])
		the_pq = json[ckey(key)]
	if(!the_pq)
		the_pq = 0
	if(!text)
		return the_pq
	else
		if(the_pq >= 100)
			return "<span style='color: #00ff00;'>Legendary</span>"
		if(the_pq >= 70)
			return "<span style='color: #74cde0;'>Exceptional</span>"
		if(the_pq >= 30)
			return "<span style='color: #47b899;'>Great</span>"
		if(the_pq >= 5)
			return "<span style='color: #58a762;'>Good</span>"
		if(the_pq >= -4)
			return "Normal"
		if(the_pq >= -30)
			return "<span style='color: #be6941;'>Poor</span>"
		if(the_pq >= -70)
			return "<span style='color: #cd4232;'>Terrible</span>"
		if(the_pq >= -99)
			return "<span style='color: #e2221d;'>Abysmal</span>"
		if(the_pq <= -100)
			return "<span style='color: #ff00ff;'>Shitter</span>"
		return "Normal"

/proc/adjust_playerquality(amt, key, admin, reason)
	var/curpq = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/pq_num.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[key])
		curpq = json[key]
	curpq += amt
	curpq = CLAMP(curpq, -100, 100)
	json[key] = curpq
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	if(reason || admin)
		var/thing = ""
		if(amt > 0)
			thing += "Спасибо за игру (+[amt])"
		if(amt < 0)
			thing += "Жалоба на игру ([amt])"
		if(admin)
			thing += " от <b>[admin]</b>"
		if(reason)
			thing += " за: <i>[reason]</i>"
		if(amt == 0)
			if(!reason && !admin)
				return
			if(admin)
				thing = "<u>ЗАМЕТКА от [admin]: [reason]</u>"
			else
				thing = "<u>ЗАМЕТКА: [reason]</u>"
		thing += " ([GLOB.rogue_round_id])"
		thing += "\n"
		text2file(thing,"data/player_saves/[copytext(key,1,2)]/[key]/playerquality.txt")

		var/msg
		if(!amt)
			msg = "[key] triggered event [msg]"
		else
			if(amt > 0)
				msg = "[key] ([amt])"
			else
				msg = "[key] ([amt])"
		if(admin)
			msg += " - GM: [admin]"
		if(reason)
			msg += " - RSN: [reason]"
		message_admins("[admin] [amt>0 ? "повысил" : "снял"] PQ [key][abs(amt) > 1 ? " на [amt]" : ""] за: \"<i>[reason]</i>\"") // REDMOON EDIT
		log_admin("[admin] adjusted [key]'s PQ by [amt] for reason: [reason]")
		if(abs(amt) > 1)
			send2irc("PQ", "[admin] [amt>0 ? "повысил" : "снял"] [key][abs(amt) > 1 ? " на [amt]" : ""] за: \"<i>[reason]</i>\"") // REDMOON ADD

/client/proc/check_pq()
	set category = "GameMaster"
	set name = "CheckPQ"
	if(!holder)
		return
	var/selection = alert(src, "Check VIA...", "Check PQ", "Character List", "Player List", "Player Name")
	if(!selection)
		return
	var/list/selections = list()
	var/theykey
	if(selection == "Character List")
		for(var/mob/living/H in GLOB.player_list)
			selections[H.real_name] = H.ckey
		if(!selections.len)
			to_chat(src, span_boldwarning("No characters found."))
			return
		selection = input("Which Character?") as null|anything in sortList(selections)
		if(!selection)
			return
		theykey = selections[selection]
	if(selection == "Player List")
		for(var/client/C in GLOB.clients)
			var/usedkey = C.ckey
//			if(!check_rights(R_ADMIN,0))
//				if(C.ckey in GLOB.anonymize)
//					usedkey = get_fake_key(C.ckey)
			selections[usedkey] = C.ckey
		selection = input("Which Player?") as null|anything in sortList(selections)
		if(!selection)
			return
		theykey = selections[selection]
	if(selection == "Player Name")
		selection = input("Which Player?", "CKEY", "") as text|null
		if(!selection)
			return
		theykey = selection
	check_pq_menu(theykey)

/proc/check_pq_menu(ckey)
	if(!fexists("data/player_saves/[copytext(ckey,1,2)]/[ckey]/preferences.sav"))
		to_chat(usr, span_boldwarning("User does not exist."))
		return
	var/popup_window_data = "<center>[ckey]</center>"
	popup_window_data += "<center>PQ: [get_playerquality(ckey, TRUE, TRUE)] ([get_playerquality(ckey, FALSE, TRUE)])</center>"

//	dat += "<table width=100%><tr><td width=33%><div style='text-align:left'><a href='?_src_=prefs;preference=playerquality;task=menu'><b>PQ:</b></a> [get_playerquality(user.ckey, text = TRUE)]</div></td><td width=34%><center><a href='?_src_=prefs;preference=triumphs;task=menu'><b>TRIUMPHS:</b></a> [user.get_triumphs() ? "\Roman [user.get_triumphs()]" : "None"]</center></td><td width=33%></td></tr></table>"
	popup_window_data += "<center><a href='?_src_=holder;[HrefToken()];cursemenu=[ckey]'>CURSES</a></center>"
	popup_window_data += "<table width=100%><tr><td width=33%><div style='text-align:left'>"
	popup_window_data += "Commends: <a href='?_src_=holder;[HrefToken()];readcommends=[ckey]'>[get_commends(ckey)]</a></div></td>"
	popup_window_data += "<td width=34%><center>ESL Points: [get_eslpoints(ckey)]</center></td>"
	popup_window_data += "<td width=33%><div style='text-align:right'>Rounds Survived: [get_roundsplayed(ckey)]</div></td></tr></table>"
	var/list/listy = world.file2list("data/player_saves/[copytext(ckey,1,2)]/[ckey]/playerquality.txt")
	if(!listy.len)
		popup_window_data += span_info("No data on record. Create some.")
	else
		for(var/i = listy.len to 1 step -1)
			var/ya = listy[i]
			if(ya)
				popup_window_data += "<span class='info'>[listy[i]]</span><br>"
	var/datum/browser/noclose/popup = new(usr, "playerquality", "", 390, 320)
	popup.set_content(popup_window_data)
	popup.open()

/client/proc/adjust_pq()
	set category = "GameMaster"
	set name = "AdjustPQ"
	if(!holder)
		return
	var/selection = alert(src, "Adjust VIA...", "MODIFY PQ", "Character List", "Player List", "Player Name")
	var/list/selections = list()
	var/theykey
	if(selection == "Character List")
		for(var/mob/living/H in GLOB.player_list)
			selections[H.real_name] = H.ckey
		if(!selections.len)
			to_chat(src, span_boldwarning("No characters found."))
			return
		selection = input("Which Character?") as null|anything in sortList(selections)
		if(!selection)
			return
		theykey = selections[selection]
	if(selection == "Player List")
		for(var/client/C in GLOB.clients)
			var/usedkey = C.ckey
//			if(!check_rights(R_ADMIN,0))
//				if(C.ckey in GLOB.anonymize)
//					usedkey = get_fake_key(C.ckey)
			selections[usedkey] = C.ckey
		selection = input("Which Player?") as null|anything in sortList(selections)
		if(!selection)
			return
		theykey = selections[selection]
	if(selection == "Player Name")
		selection = input("Which Player?", "CKEY", "") as text|null
		if(!selection)
			return
		theykey = selection
	if(theykey == ckey)
		to_chat(src, span_boldwarning("That's you!"))
		return
	if(!fexists("data/player_saves/[copytext(theykey,1,2)]/[theykey]/preferences.sav"))
		to_chat(src, span_boldwarning("User does not exist."))
		return
	var/amt2change = input("How much to modify the PQ by? (20 to -20, or 0 to just add a note)") as null|num
	if(!check_rights(R_ADMIN,0))
		amt2change = CLAMP(amt2change, -20, 20)
	var/raisin = stripped_input("State a short reason for this change", "Game Master", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("No reason given."))
		return
	adjust_playerquality(amt2change, theykey, src.ckey, raisin)
	for(var/client/C in GLOB.clients) // I hate this, but I'm not refactoring the cancer above this point.
		if(lowertext(C.key) == lowertext(theykey))
			to_chat(C, "<span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message linkify\">Your PQ has been adjusted by [amt2change] by [key] for reason: [raisin]</span></span>")
			return

/client/proc/add_commend(key, giver)
	if(!giver || !key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json[giver])
		curcomm = json[giver]
	// REDMOON REMOVAL - перенесено ниже - WAS: curcomm++
	json[giver] = curcomm
	// REDMOON REMOVAL - перенесено ниже - WAS: fdel(json_file)
	// REDMOON REMOVAL - перенесено ниже - WAS: WRITE_FILE(json_file, json_encode(json))

	// REDMOON ADD START - причина для изменения PQ
	var/fakekey = src.ckey
	if(src.ckey in GLOB.anonymize)
		fakekey = get_fake_key(src.ckey)

	var/raisin = stripped_input(src, "Укажите краткую причину этого изменения", "Будь крутым, а не гнилым", "", null)
	if(!raisin)
		to_chat(src, span_boldwarning("Причина не указана."))
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))
		return FALSE // REDMOON ADD - добавил FALSE
	// REDMOON ADD END

	if(curcomm <= 0) // REDMOON EDIT - если больше 1, то коммендить нельзя - WAS: if(curcomm == 1)
	//add the pq, only on the first commend
//	if(get_playerquality(key) < 29)

		adjust_playerquality(1, ckey(key), fakekey, raisin) // REDMOON EDIT - was adjust_playerquality(1, ckey(key))
		// REDMOON ADD START - похвала без PQ
		send2irc("PQ", "[fakekey == ckey ? "[ckey]" : "[fake_key] ([ckey])"] [mob ? "([mob.real_name])" : ""] повысил [key] за: \"<i>[raisin]</i>\"") // REDMOON ADD
		curcomm++
		json[giver] = curcomm
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))
		return TRUE
	else
		give_comment(1, ckey(key), fakekey, raisin)
		send2irc("Комментарий", "[fakekey == ckey ? "[ckey]" : "[fake_key] ([ckey])"] [mob ? "([mob.real_name])" : ""] оставил [key] комментарий: \"<i>[raisin]</i>\"")
		send2chat(new /datum/tgs_message_content("Комментарий | [fakekey == ckey ? "[ckey]" : "[fake_key]"] [mob ? "([mob.real_name])" : ""] оставил кому-то комментарий: \"<i>[raisin]</i>\""), CONFIG_GET(string/chat_announce_new_game))
		return TRUE

	// REDMOON ADD END

/proc/get_commends(key)
	if(!key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/commends.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	for(var/X in json)
		curcomm += json[X]
	if(!curcomm)
		curcomm = 0
	return curcomm

/proc/add_eslpoint(key)
	if(!key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/esl.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))
	if(json["ESL"])
		curcomm = json["ESL"]

	curcomm++
	json["ESL"] = curcomm
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	if(get_playerquality(key) > -5)
		adjust_playerquality(-1, ckey(key))

/proc/get_eslpoints(key)
	if(!key)
		return
	var/curcomm = 0
	var/json_file = file("data/player_saves/[copytext(key,1,2)]/[key]/esl.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	if(json["ESL"])
		curcomm = json["ESL"]
	if(!curcomm)
		curcomm = 0
	return curcomm

