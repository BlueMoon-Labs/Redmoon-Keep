GLOBAL_LIST_EMPTY(preferences_datums)

GLOBAL_LIST_EMPTY(chosen_names)

GLOBAL_LIST_INIT(name_adjustments, list())

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 20

	//non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#c43b23"
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	var/triumphs = 0
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds
	// Commend variable on prefs instead of client to prevent reconnect abuse (is persistant on prefs, opposed to not on client)
	var/commendedsomeone = FALSE

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	var/UI_style = null
	var/buttons_locked = TRUE
	var/hotkeys = TRUE

	var/chat_on_map = TRUE
	var/showrolls = TRUE
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	var/see_chat_non_mob = TRUE

	// Custom Keybindings
	var/list/key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = TRUE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null
	var/pda_style = MONO
	var/pda_color = "#808000"
	var/prefer_old_chat = FALSE

	var/uses_glasses_colour = 0

	//character preferences
	var/slot_randomized					//keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/real_name						//our character's name
	var/gender = MALE					//gender of character (well duh)
	var/age = AGE_ADULT						//age of character
	var/body_type = MALE
	var/voice_type = VOICE_TYPE_MASC // voice pack they use
	var/origin = "Default"
	var/underwear = "Nude"				//underwear type
	var/underwear_color = null			//underwear color
	var/undershirt = "Nude"				//undershirt type
	var/socks = "Nude"					//socks type
	var/backpack = DBACKPACK				//backpack type
	var/jumpsuit_style = PREF_SUIT		//suit/skirt
	var/hairstyle = "Bald"				//Hair type
	var/hair_color = "000"				//Hair color
	var/facial_hairstyle = "Shaved"	//Face hair type
	var/facial_hair_color = "000"		//Facial hair color
	var/skin_tone = "caucasian1"		//Skin color
	var/eye_color = "000"				//Eye color
	var/voice_color = "a0a0a0"
	var/voice_pitch = 1
	var/detail_color = "000"
	var/datum/species/pref_species = new /datum/species/human/northern()	//Mutant race
	var/static/datum/species/default_species = new /datum/species/human/northern()
	var/datum/patron/selected_patron
	var/static/datum/patron/default_patron = /datum/patron/divine/astrata
	var/list/features = MANDATORY_FEATURE_LIST
	var/list/randomise = list(RANDOM_UNDERWEAR = TRUE, RANDOM_UNDERWEAR_COLOR = TRUE, RANDOM_UNDERSHIRT = TRUE, RANDOM_SOCKS = TRUE, RANDOM_BACKPACK = TRUE, RANDOM_JUMPSUIT_STYLE = FALSE, RANDOM_SKIN_TONE = TRUE, RANDOM_EYE_COLOR = TRUE)
	var/list/friendlyGenders = list("Male" = "male", "Female" = "female")
	var/phobia = "spiders"

	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/prefered_security_department = SEC_DEPT_RANDOM

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

		// Want randomjob if preferences already filled - Donkie
	var/joblessrole = RETURNTOLOBBY  //defaults to 1 for fewer assistants

	// 0 = character settings, 1 = game preferences
	var/current_tab = 0

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 100//0 is sync

	var/parallax

	var/ambientocclusion = TRUE
	var/auto_fit_viewport = FALSE
	var/widescreenpref = TRUE

	var/musicvol = 50
	var/mastervol = 50

	var/anonymize = TRUE

	var/lastclass

	var/uplink_spawn_loc = UPLINK_PDA

	var/list/exp = list()
	var/list/menuoptions

	var/datum/migrant_pref/migrant
	var/next_special_trait = null

	var/action_buttons_screen_locs = list()

	var/domhand = 2
	var/datum/charflaw/charflaw

	var/family = FAMILY_NONE
	var/list/family_species = list()
	var/list/family_gender = list()

	var/crt = FALSE

	var/list/customizer_entries = list()
	var/list/list/body_markings = list()
	var/update_mutant_colors = TRUE

	var/headshot_link
	var/nudeshot_link

	var/list/violated = list()
	var/list/descriptor_entries = list()
	var/list/custom_descriptors = list()

	var/flavortext
	var/flavortext_display
	var/flavortext_nsfw
	var/flavortext_nsfw_display
	var/ooc_notes
	var/ooc_notes_display

	var/defiant = TRUE
	var/virginity = FALSE
	var/char_accent = "No accent"
	/// Tracker to whether the person has ever spawned into the round, for purposes of applying the respawn ban
	var/has_spawned = FALSE

	//Loadout slots, can be commented out if needed
	var/datum/loadout_item/loadout
	var/datum/loadout_item/loadout2
	var/datum/loadout_item/loadout3


/datum/preferences/New(client/C)
	parent = C
	migrant  = new /datum/migrant_pref(src)

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots = 30
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			if(check_nameban(C.ckey))
				real_name = pref_species.random_name(gender,1)
			return
	//Set the race to properly run race setter logic
	set_new_race(pref_species, null)

	// Enable all races and genders for family preferences by default
	family_species = list()
	var/list/available_species = get_selectable_species()
	for(var/species_name in available_species)
		var/datum/species/S = GLOB.species_list[species_name]
		family_species += S.id

	family_gender = list(MALE,FEMALE)

	if(!charflaw)
		charflaw = pick(GLOB.character_flaws)
		charflaw = GLOB.character_flaws[charflaw]
		charflaw = new charflaw()
	if(!selected_patron)
		selected_patron = GLOB.patronlist[default_patron]
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C.update_movement_keys()
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

/datum/preferences/proc/set_new_race(datum/species/new_race, mob/user)
	pref_species = new_race
	real_name = pref_species.random_name(gender,1)
	ResetJobs()
	if(user)
		if(usr?.client?.prefs?.be_russian)
			if(pref_species.ru_desc)
				to_chat(user, "[pref_species.ru_desc]")
			if(pref_species.ru_expanded_desc)
				to_chat(user, "<a href='?src=[REF(user)];view_species_info=[pref_species.ru_expanded_desc]'>Читать ещё</a>")
		else
			if(pref_species.desc)
				to_chat(user, "[pref_species.desc]")
			if(pref_species.expanded_desc)
				to_chat(user, "<a href='?src=[REF(user)];view_species_info=[pref_species.expanded_desc]'>Read More</a>")
		if(usr?.client?.prefs?.be_russian)
			to_chat(user, "<font color='red'>СБРОСИТЬ</font>")
		else
			to_chat(user, "<font color='red'>Classes reset.</font>")
	random_character(gender)

	headshot_link = null
	nudeshot_link = null

	customizer_entries = list()
	validate_customizer_entries()
	reset_all_customizer_accessory_colors()
	randomize_all_customizer_accessories()
	reset_descriptors()

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4

/datum/preferences/proc/ShowChoices(mob/user, tabchoice)
	if(!user || !user.client)
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	var/list/dat = list("<center>")
	if(tabchoice)
		current_tab = tabchoice
	if(tabchoice == 4)
		current_tab = 0

//	dat += "<a href='?_src_=prefs;preference=tab;tab=0' [current_tab == 0 ? "class='linkOn'" : ""]>Character Sheet</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=1' [current_tab == 1 ? "class='linkOn'" : ""]>Game Preferences</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=2' [current_tab == 2 ? "class='linkOn'" : ""]>OOC Preferences</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=3' [current_tab == 3 ? "class='linkOn'" : ""]>Keybinds</a>"

	dat += "</center>"

	var/used_title
	switch(current_tab)
		if (0) // Character Settings#
			if(usr?.client?.prefs?.be_russian)
				used_title = "Лист Персонажа"
			else
				used_title = "Character Sheet"

			// Top-level menu table
			dat += "<table style='width: 100%; line-height: 18px;'>"
			// NEXT ROW
			dat += "<tr>"
			dat += "<td style='width:33%;text-align:left'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;'>Сменить Персонажа</a>"
			else
				dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;'>Change Character</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:center'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a href='?_src_=prefs;preference=job;task=menu'>Выбрать Роль/Профессию</a>"
			else
				dat += "<a href='?_src_=prefs;preference=job;task=menu'>Class Selection</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:right'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a href='?_src_=prefs;preference=keybinds;task=menu'>Привязка Клавиш</a>"
			else
				dat += "<a href='?_src_=prefs;preference=keybinds;task=menu'>Keybinds</a>"
			dat += "</td>"
			dat += "</tr>"

			// ANOTHA ROW
			dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
			dat += "<td style='width:33%;text-align:left'>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:center'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a href='?_src_=prefs;preference=antag;task=menu'>Антагонисты</a>"
			else
				dat += "<a href='?_src_=prefs;preference=antag;task=menu'>Villain Selection</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a href='?_src_=prefs;preference=additional_settings;task=menu'>Дополнительные настройки</a>"
			else
				dat += "<a href='?_src_=prefs;preference=additional_settings;task=menu'>Additional Settings</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:right'>"
			dat += "</td>"
			dat += "</tr>"

			// ANOTHER ROW HOLY SHIT WE FINALLY A GOD DAMN GRID NOW! WHOA!
			dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
			dat += "<td style='width:33%; text-align:left'>"
			dat += "<a href='?_src_=prefs;preference=playerquality;task=menu'><b>PQ:</b></a> [get_playerquality(user.ckey, text = TRUE)]"
			dat += "</td>"

			dat += "<td style='width:45%;text-align:center'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<a href='?_src_=prefs;preference=triumphs;task=menu'><b>ТРИУМФЫ:</b></a> [user.get_triumphs() ? "\Roman [user.get_triumphs()]" : "Отсутствуют"]"
			else
				dat += "<a href='?_src_=prefs;preference=triumphs;task=menu'><b>TRIUMPHS:</b></a> [user.get_triumphs() ? "\Roman [user.get_triumphs()]" : "None"]"
			if(usr?.client?.prefs?.be_russian)
				if(SStriumphs.triumph_buys_enabled)
					dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=triumph_buy_menu'>МАГАЗИН</a>"
			else
				if(SStriumphs.triumph_buys_enabled)
					dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=triumph_buy_menu'>TRIUMPH BUY</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:right'>"
			dat += "</td>"

			dat += "</table>"

			// Encapsulating table
			dat += "<table width = '100%'>"
			// Only one Row
			dat += "<tr>"
			// Leftmost Column, 40% width
			dat += "<td width=40% valign='top'>"

// 			-----------START OF IDENT TABLE-----------
			if(usr?.client?.prefs?.be_russian)
				dat += "<h2>Личность</h2>"
			else
				dat += "<h2>Identity</h2>"
			dat += "<table width='100%'><tr><td width='75%' valign='top'>"
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME]'>Always Random Name: [(randomise[RANDOM_NAME]) ? "Yes" : "No"]</a>"
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME_ANTAG]'>When Antagonist: [(randomise[RANDOM_NAME_ANTAG]) ? "Yes" : "No"]</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Имя:</b> "
			else
				dat += "<b>Name:</b> "
			if(check_nameban(user.ckey))
				dat += "<a href='?_src_=prefs;preference=name;task=input'>NAMEBANNED</a><BR>"
			else
				dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a> <a href='?_src_=prefs;preference=name;task=random'>\[R\]</a>"

			dat += "<BR>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Раса:</b> <a href='?_src_=prefs;preference=species;task=input'>[pref_species.ru_name]</a>[spec_check(user) ? "" : " (!)"]<BR>"
			else
				dat += "<b>Race:</b> <a href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a>[spec_check(user) ? "" : " (!)"]<BR>"
//			dat += "<a href='?_src_=prefs;preference=species;task=random'>Random Species</A> "
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SPECIES]'>Always Random Species: [(randomise[RANDOM_SPECIES]) ? "Yes" : "No"]</A><br>"

			if(!(AGENDER in pref_species.species_traits))
				var/dispGender
				if(gender == MALE)
					if(usr?.client?.prefs?.be_russian)
						dispGender = "Мужчина"
					else
						dispGender = "Man"
				else if(gender == FEMALE)
					if(usr?.client?.prefs?.be_russian)
						dispGender = "Женщина"
					else
						dispGender = "Woman"
				else
					if(usr?.client?.prefs?.be_russian)
						dispGender = "Другое"
					else
						dispGender = "Other"
				if(usr?.client?.prefs?.be_russian)
					dat += "<b>Пол:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a><BR>"
				else
					dat += "<b>Sex:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a><BR>"
				if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER]'>Always Random Gender: [(randomise[RANDOM_GENDER]) ? "Yes" : "No"]</A>"
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER_ANTAG]'>When Antagonist: [(randomise[RANDOM_GENDER_ANTAG]) ? "Yes" : "No"]</A>"
			
			// Allows you to select vioce pack					
			dat += "<b>Voice Type</b>: <a href='?_src_=prefs;preference=voicetype;task=input'>[voice_type]</a><BR>"

			var/dispBodyType
			if(body_type == MALE)
				if(usr?.client?.prefs?.be_russian)
					dispBodyType = "Мужское Тело"
				else
					dispBodyType = "Masculine"
			else if(body_type == FEMALE)
				if(usr?.client?.prefs?.be_russian)
					dispBodyType = "Женское Тело"
				else
					dispBodyType = "Feminine"
			else
				dispBodyType = "Other"
			dat += "<b>Body Type</b>: <a href='?_src_=prefs;preference=bodytype;task=input'>[dispBodyType]</a><BR>"

			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Возраст:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"
			else
				dat += "<b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"

//			dat += "<br><b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a>"
//			if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
//				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE]'>Always Random Age: [(randomise[RANDOM_AGE]) ? "Yes" : "No"]</A>"
//				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE_ANTAG]'>When Antagonist: [(randomise[RANDOM_AGE_ANTAG]) ? "Yes" : "No"]</A>"

//			dat += "<b><a href='?_src_=prefs;preference=name;task=random'>Random Name</A></b><BR>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Изъян:</b> <a href='?_src_=prefs;preference=charflaw;task=input'>[charflaw]</a><BR>"
			else
				dat += "<b>Flaw:</b> <a href='?_src_=prefs;preference=charflaw;task=input'>[charflaw]</a><BR>"
			var/datum/faith/selected_faith = GLOB.faithlist[selected_patron?.associated_faith]
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Вера:</b> <a href='?_src_=prefs;preference=faith;task=input'>[selected_faith?.name || "FUCK!"]</a><BR>"
			else
				dat += "<b>Faith:</b> <a href='?_src_=prefs;preference=faith;task=input'>[selected_faith?.name || "FUCK!"]</a><BR>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Покровитель:</b> <a href='?_src_=prefs;preference=patron;task=input'>[selected_patron?.name || "FUCK!"]</a><BR>"
			else
				dat += "<b>Patron:</b> <a href='?_src_=prefs;preference=patron;task=input'>[selected_patron?.name || "FUCK!"]</a><BR>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Семья:</b> <a href='?_src_=prefs;preference=family'>[family ? "Yes!" : "No"]</a><BR>"
			else
				dat += "<b>Family:</b> <a href='?_src_=prefs;preference=family'>[family ? "Yes!" : "No"]</a><BR>" // Disabling until its working
			if(family != FAMILY_NONE)
				if(usr?.client?.prefs?.be_russian)
					dat += "<B>Предпочтения в семье:<br></B>"
				else
					dat += "<B>Family Preferences:<br></B>"
				if(gender == MALE)
					family_gender = list(FEMALE)
				else
					family_gender = list(MALE)
				dat += " <small><a href='?_src_=prefs;preference=familypref;res=race'><b>Race</b></a></small>"
				dat += "<BR>"
				// REDMOON ADD START - family_changes 
				if(usr?.client?.prefs?.be_russian)
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=ckey'><b>Душа второй половинки: [spouse_ckey ? spouse_ckey : "(Случайная)"]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=surname'><b>Фамилия семьи: [family_surname ? family_surname : "(Нет)"]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=genitals'><b>Начало партнёра</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=latejoin'><b>После начала: [allow_latejoin_family ? "Разрешено" : "Нет"]</b></a></small><BR>"
				else
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=ckey'><b>Spouse soul: [spouse_ckey ? spouse_ckey : "(Random)"]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=surname'><b>Family surname: [family_surname ? family_surname : "(None)"]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=genitals'><b>Partner's beginning</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=familypref;res=latejoin'><b>Latejoin: [allow_latejoin_family ? "Allowed" : "No"]</b></a></small><BR>"
			// rumors_addition
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Слухи: </b> <a href='?_src_=prefs;preference=rumors'>[use_rumors ? "Ходят" : "Не ходят"]</a><BR>"
			else
				dat += "<b>Rumors: </b> <a href='?_src_=prefs;preference=rumors'>[use_rumors ? "Yes!" : "No"]</a><BR>"
			if(use_rumors)
				if(usr?.client?.prefs?.be_russian)
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=gender'><b>Фехтование [rumors_prefered_beginnings.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=species'><b>Расы [rumors_prefered_races.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=bed'><b>Постель [rumors_prefered_behavior_in_bed.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=genitals'><b>Иное начало [rumors_genitals ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=problems'><b>Проблемы [rumors_prefered_behavior_with_problems ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=combat'><b>Бой [rumors_prefered_behavior_in_combat ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=relax'><b>Отдых [rumors_prefered_ways_to_relax ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=work'><b>Работа [rumors_prefered_behavior_in_work ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=family'><b>Семья [rumors_family ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=flaws'><b>Недостатки характера [rumors_overal.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=advantages'><b>Преимущества характера [rumors_overal_good.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=dangerous'><b>Опасные [rumors_dangerous.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=secret'><b>Скрытые слухи [rumors_secret ? "(&)" : ""]</b></a></small><BR>"
				else
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=gender'><b>Fencing [rumors_prefered_beginnings.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=species'><b>Races [rumors_prefered_races.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=bed'><b>Bed [rumors_prefered_behavior_in_bed.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=genitals'><b>Other beginning [rumors_genitals ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=problems'><b>Problems [rumors_prefered_behavior_with_problems ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=combat'><b>Combat [rumors_prefered_behavior_in_combat ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=relax'><b>Relax [rumors_prefered_ways_to_relax ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=work'><b>Work [rumors_prefered_behavior_in_work ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=family'><b>Family [rumors_family ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=flaws'><b>Character's Flaws  [rumors_overal.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=advantages'><b>Character's Advantages [rumors_overal_good.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=dangerous'><b>Dangerous [rumors_dangerous.len ? "(&)" : ""]</b></a></small><BR>"
					dat += " <small><a href='?_src_=prefs;preference=rumors_prefs;res=secret'><b>Hidden rumors [rumors_secret ? "(&)" : ""]</b></a></small><BR>"
			// REDMOON ADD END
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Основная Рука:</b> <a href='?_src_=prefs;preference=domhand'>[domhand == 1 ? "Left-handed" : "Right-handed"]</a>"
			else
				dat += "<b>Dominance:</b> <a href='?_src_=prefs;preference=domhand'>[domhand == 1 ? "Left-handed" : "Right-handed"]</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Цвет Голоса: </b><a href='?_src_=prefs;preference=voice;task=input'>Изменить</a>"
			else
				dat += "<br><b>Voice Color: </b><a href='?_src_=prefs;preference=voice;task=input'>Change</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Тон Голоса: </b><a href='?_src_=prefs;preference=voice_pitch;task=input'>[voice_pitch]</a>"
			else
				dat += "<br><b>Voice Pitch: </b><a href='?_src_=prefs;preference=voice_pitch;task=input'>[voice_pitch]</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Headshot(1:1):</b> <a href='?_src_=prefs;preference=headshot;task=input'>Изменить</a>"
			else
				dat += "<br><b>Headshot(1:1):</b> <a href='?_src_=prefs;preference=headshot;task=input'>Change</a>"
			if(headshot_link != null)
				if(usr?.client?.prefs?.be_russian)
					dat += "<a href='?_src_=prefs;preference=view_headshot;task=input'>Показать</a>"
				else
					dat += "<a href='?_src_=prefs;preference=view_headshot;task=input'>View</a>"
			if(user.client.prefs.be_russian)
				dat += "<br><b>Nudeshot(3:4):</b> <a href='?_src_=prefs;preference=nudeshot;task=input'>Изменить</a>"
			else
				dat += "<br><b>Nudeshot(3:4):</b> <a href='?_src_=prefs;preference=nudeshot;task=input'>Change</a>"
			if(nudeshot_link != null)
				if(user.client.prefs.be_russian)
					dat += "<a href='?_src_=prefs;preference=view_nudeshot;task=input'>Показать</a>"
				else
					dat += "<a href='?_src_=prefs;preference=view_nudeshot;task=input'>View</a>"

			dat += "<br><b>Loadout Item I:</b> <a href='?_src_=prefs;preference=loadout_item;task=input'>[loadout ? loadout.name : "None"]</a>"

			dat += "<br><b>Loadout Item II:</b> <a href='?_src_=prefs;preference=loadout_item2;task=input'>[loadout2 ? loadout2.name : "None"]</a>"

			dat += "<br><b>Loadout Item III:</b> <a href='?_src_=prefs;preference=loadout_item3;task=input'>[loadout3 ? loadout3.name : "None"]</a>"
			dat += "</td>"


/*
			dat += "<br><br><b>Special Names:</b><BR>"
			var/old_group
			for(var/custom_name_id in GLOB.preferences_custom_names)
				var/namedata = GLOB.preferences_custom_names[custom_name_id]
				if(!old_group)
					old_group = namedata["group"]
				else if(old_group != namedata["group"])
					old_group = namedata["group"]
					dat += "<br>"
				dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
			dat += "<br><br>"

			dat += "<b>Custom Job Preferences:</b><BR>"
			dat += "<a href='?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"
			dat += "<a href='?_src_=prefs;preference=sec_dept;task=input'><b>Preferred Security Department:</b> [prefered_security_department]</a><BR></td>"
*/
			dat += "</tr></table>"
// 			-----------END OF IDENT TABLE-----------


			// Middle dummy Column, 20% width
			dat += "</td>"
			dat += "<td width=20% valign='top'>"
			// Rightmost column, 40% width
			dat += "<td width=40% valign='top'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<h2>Тело</h2>"
			else
				dat += "<h2>Body</h2>"

//			-----------START OF BODY TABLE-----------
			dat += "<table width='100%'><tr><td width='1%' valign='top'>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Авто-обновновление цвета:</b> <a href='?_src_=prefs;preference=update_mutant_colors;task=input'>[update_mutant_colors ? "Yes" : "No"]</a><BR>"
			else
				dat += "<b>Update feature colors with change:</b> <a href='?_src_=prefs;preference=update_mutant_colors;task=input'>[update_mutant_colors ? "Yes" : "No"]</a><BR>"
			var/use_skintones = pref_species.use_skintones
			if(use_skintones)

				var/skin_tone_wording = pref_species.skin_tone_wording // Both the skintone names and the word swap here is useless fluff
				var/list/skin_tones = pref_species.get_skin_list()
				var/heldtone
				if(skin_tone)
					for(var/tone in skin_tones)
						if(skin_tone == skin_tones[tone])
							heldtone = tone //your fault if this isn't uppercase.
							break
				//Second comment on how stupid this is. TODO: REFACTOR THIS SHITTY FUCKING SYSTEM. We shouldn't be using associative lists like this.

				if(usr?.client?.prefs?.be_russian)
					dat += "<b>Цвет Кожи: [skin_tone_wording] </b><span style='font-size:104%'>[heldtone]</span><a href='?_src_=prefs;preference=s_tone;task=input'>	Change </a>"
				else
					dat += "<b>Skin Tone: [skin_tone_wording] </b><span style='font-size:104%'>[heldtone]</span><a href='?_src_=prefs;preference=s_tone;task=input'>	Change </a>"
				dat += "<br>"

			if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))

				if(usr?.client?.prefs?.be_russian)
					dat += "<b>Цвет Тела #1:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Изменить</a><BR>"
					dat += "<b>Цвет Тела #2:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color2;task=input'>Изменить</a><BR>"
					dat += "<b>Цвет Тела #3:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color3;task=input'>Изменить</a><BR>"
				else
					dat += "<b>Mutant Color #1:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"
					dat += "<b>Mutant Color #2:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color2;task=input'>Change</a><BR>"
					dat += "<b>Mutant Color #3:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color3;task=input'>Change</a><BR>"

			var/datum/bark/B = GLOB.bark_list[bark_id]
			if(usr?.client?.prefs?.be_russian)
				dat += "<b>Звук Барка:</b> <a href='?_src_=prefs;preference=barksound;task=input'>[B ? initial(B.name) : "INVALID"]</a>"
				dat += "<br><b>Скорость Барка:</b> <a href='?_src_=prefs;preference=barkspeed;task=input'>[bark_speed]</a>"
				dat += "<br><b>Тон Барка:</b> <a href='?_src_=prefs;preference=barkpitch;task=input'>[bark_pitch]</a>"
				dat += "<br><b>Отклонение Барка:</b> <a href='?_src_=prefs;preference=barkvary;task=input'>[bark_variance]</a>"
				dat += "<br><a href='?_src_=prefs;preference=barkpreview'>Прослушать Барк</a>"
			else
				dat += "<b>Vocal Bark Sound: </b><a href='?_src_=prefs;preference=barksound;task=input'>[B ? initial(B.name) : "INVALID"]</a>"
				dat += "<br><b>Vocal Bark Speed: </b><a href='?_src_=prefs;preference=barkspeed;task=input'>[bark_speed]</a>"
				dat += "<br><b>Vocal Bark Pitch: </b><a href='?_src_=prefs;preference=barkpitch;task=input'>[bark_pitch]</a>"
				dat += "<br><b>Vocal Bark Variance: </b><a href='?_src_=prefs;preference=barkvary;task=input'>[bark_variance]</a>"
				dat += "<br><a href='?_src_=prefs;preference=barkpreview'>Preview Bark</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Акцент:</b> <a href='?_src_=prefs;preference=char_accent;task=input'>[char_accent]</a>"
			else
				dat += "<br><b>Accent:</b> <a href='?_src_=prefs;preference=char_accent;task=input'>[char_accent]</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Особенности:</b> <a href='?_src_=prefs;preference=customizers;task=menu'>Изменить</a>"
			else
				dat += "<br><b>Features:</b> <a href='?_src_=prefs;preference=customizers;task=menu'>Change</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Нательные Рисунки:</b> <a href='?_src_=prefs;preference=markings;task=menu'>Изменить</a>"
			else
				dat += "<br><b>Markings:</b> <a href='?_src_=prefs;preference=markings;task=menu'>Change</a>"
			if(usr?.client?.prefs?.be_russian)
				dat += "<br><b>Дополнительное Описание:</b> <a href='?_src_=prefs;preference=descriptors;task=menu'>Изменить</a>"
			else
				dat += "<br><b>Descriptors:</b> <a href='?_src_=prefs;preference=descriptors;task=menu'>Change</a>"

			dat += "<br><b>[(length(flavortext) > MAXIMUM_FLAVOR_TEXT) ? "<font color = '#802929'>" : ""]Flavortext:[(length(flavortext) > MAXIMUM_FLAVOR_TEXT) ? "</font>" : ""]</b><a href='?_src_=prefs;preference=formathelp;task=input'>(?)</a><a href='?_src_=prefs;preference=flavortext;task=input'>Change</a>"
			dat += "<br><b>[(length(flavortext_nsfw) > MAXIMUM_NSFW_FLAVOR_TEXT) ? "<font color = '#802929'>" : ""]Flavortext (nsfw):[(length(flavortext_nsfw) > MAXIMUM_NSFW_FLAVOR_TEXT) ? "</font>" : ""]</b><a href='?_src_=prefs;preference=flavortext_nsfw;task=input'>Change</a>"
			dat += "<br><b>[(length(ooc_notes) > MAXIMUM_OOC_NOTES) ? "<font color = '#802929'>" : ""]OOC Notes:[(length(ooc_notes) > MAXIMUM_OOC_NOTES) ? "</font>" : ""]</b><a href='?_src_=prefs;preference=ooc_notes;task=input'>Change</a>"
			dat += "<br><a href='?_src_=prefs;preference=flavortext_preview;task=input'><b>Preview Examine</b></a>"
			dat += "</td>"

			dat += "</tr></table>"
//			-----------END OF BODY TABLE-----------
			dat += "</td>"
			dat += "</tr>"
			dat += "</table>"

		if (1) // Game Preferences
			used_title = "Options"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>General Settings</h2>"
//			dat += "<b>UI Style:</b> <a href='?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
//			dat += "<b>tgui Monitors:</b> <a href='?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary" : "All"]</a><br>"
//			dat += "<b>tgui Style:</b> <a href='?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy" : "No Frills"]</a><br>"
//			dat += "<b>Show Runechat Chat Bubbles:</b> <a href='?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<b>Runechat message char limit:</b> <a href='?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
//			dat += "<b>See Runechat for non-mobs:</b> <a href='?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<br>"
//			dat += "<b>Action Buttons:</b> <a href='?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
//			dat += "<b>Hotkey mode:</b> <a href='?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Default"]</a><br>"
//			dat += "<br>"
//			dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
//			dat += "<b>PDA Style:</b> <a href='?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
//			dat += "<br>"
//			dat += "<b>Ghost Ears:</b> <a href='?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost Radio:</b> <a href='?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
//			dat += "<b>Ghost Sight:</b> <a href='?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost Whispers:</b> <a href='?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost PDA:</b> <a href='?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"

/*			if(unlock_content)
				dat += "<b>Ghost Form:</b> <a href='?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
				dat += "<B>Ghost Orbit: </B> <a href='?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"

			var/button_name = "If you see this something went wrong."
			switch(ghost_accs)
				if(GHOST_ACCS_FULL)
					button_name = GHOST_ACCS_FULL_NAME
				if(GHOST_ACCS_DIR)
					button_name = GHOST_ACCS_DIR_NAME
				if(GHOST_ACCS_NONE)
					button_name = GHOST_ACCS_NONE_NAME

			dat += "<b>Ghost Accessories:</b> <a href='?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"

			switch(ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING)
					button_name = GHOST_OTHERS_THEIR_SETTING_NAME
				if(GHOST_OTHERS_DEFAULT_SPRITE)
					button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
				if(GHOST_OTHERS_SIMPLE)
					button_name = GHOST_OTHERS_SIMPLE_NAME

			dat += "<b>Ghosts of Others:</b> <a href='?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
			dat += "<br>"

			dat += "<b>Income Updates:</b> <a href='?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"
*/
			dat += "<b>FPS:</b> <a href='?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"
/*
			dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
			switch (parallax)
				if (PARALLAX_LOW)
					dat += "Low"
				if (PARALLAX_MED)
					dat += "Medium"
				if (PARALLAX_INSANE)
					dat += "Insane"
				if (PARALLAX_DISABLE)
					dat += "Disabled"
				else
					dat += "High"
			dat += "</a><br>"
*/
//			dat += "<b>Ambient Occlusion:</b> <a href='?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<b>Fit Viewport:</b> <a href='?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
//			if (CONFIG_GET(string/default_view) != CONFIG_GET(string/default_view_square))
//				dat += "<b>Widescreen:</b> <a href='?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled ([CONFIG_GET(string/default_view_square)])"]</a><br>"

/*			if (CONFIG_GET(flag/maprotation))
				var/p_map = preferred_map
				if (!p_map)
					p_map = "Default"
					if (config.defaultmap)
						p_map += " ([config.defaultmap.map_name])"
				else
					if (p_map in config.maplist)
						var/datum/map_config/VM = config.maplist[p_map]
						if (!VM)
							p_map += " (No longer exists)"
						else
							p_map = VM.map_name
					else
						p_map += " (No longer exists)"
				if(CONFIG_GET(flag/preference_map_voting))
					dat += "<b>Preferred Map:</b> <a href='?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"
*/

//			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"


			dat += "</td><td width='300px' height='300px' valign='top'>"

			dat += "<h2>Special Role Settings</h2>"

			if(is_total_antag_banned(user.ckey))
				dat += "<font color=red><b>I am banned from antagonist roles.</b></font><br>"
				src.be_special = list()


			for (var/i in GLOB.special_roles_rogue)
				if(is_antag_banned(user.ckey, i))
					dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>BANNED</a><br>"
				else
					var/days_remaining = null
					if(ispath(GLOB.special_roles[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
						var/mode_path = GLOB.special_roles[i]
						var/datum/game_mode/temp_mode = new mode_path
						days_remaining = temp_mode.get_remaining_days(user.client)

					if(days_remaining)
						dat += "<b>[capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
					else
						dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<br>"
//			dat += "<b>Midround Antagonist:</b> <a href='?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"
			dat += "</td></tr></table>"

		if(2) //OOC Preferences
			used_title = "ooc"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>OOC Settings</h2>"
			dat += "<b>Window Flashing:</b> <a href='?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Play Admin MIDIs:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>See Pull Requests:</b> <a href='?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"


			if(user.client)
				if(unlock_content)
					dat += "<b>BYOND Membership Publicity:</b> <a href='?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"

				if(unlock_content || check_rights_for(user.client, R_ADMIN))
					dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"

			dat += "</td>"

			if(user.client.holder)
				dat +="<td width='300px' height='300px' valign='top'>"

				dat += "<h2>Admin Settings</h2>"

				dat += "<b>Adminhelp Sounds:</b> <a href='?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Prayer Sounds:</b> <a href = '?_src_=prefs;preference=hear_prayers'>[(toggles & SOUND_PRAYERS)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Announce Login:</b> <a href='?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
				dat += "<br>"
				dat += "<b>Combo HUD Lighting:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
				dat += "<br>"
				dat += "<b>Hide Dead Chat:</b> <a href = '?_src_=prefs;preference=toggle_dead_chat'>[(chat_toggles & CHAT_DEAD)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Radio Messages:</b> <a href = '?_src_=prefs;preference=toggle_radio_chatter'>[(chat_toggles & CHAT_RADIO)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Prayers:</b> <a href = '?_src_=prefs;preference=toggle_prayers'>[(chat_toggles & CHAT_PRAYER)?"Shown":"Hidden"]</a><br>"
				if(CONFIG_GET(flag/allow_admin_asaycolor))
					dat += "<br>"
					dat += "<b>ASAY Color:</b> <span style='border: 1px solid #161616; background-color: [asaycolor ? asaycolor : "#FF4500"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=asaycolor;task=input'>Change</a><br>"

				//deadmin
				dat += "<h2>Deadmin While Playing</h2>"
				if(CONFIG_GET(flag/auto_deadmin_players))
					dat += "<b>Always Deadmin:</b> FORCED</a><br>"
				else
					dat += "<b>Always Deadmin:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_always'>[(toggles & DEADMIN_ALWAYS)?"Enabled":"Disabled"]</a><br>"
					if(!(toggles & DEADMIN_ALWAYS))
						dat += "<br>"
						if(!CONFIG_GET(flag/auto_deadmin_antagonists))
							dat += "<b>As Antag:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_antag'>[(toggles & DEADMIN_ANTAGONIST)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Antag:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_heads))
							dat += "<b>As Command:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_head'>[(toggles & DEADMIN_POSITION_HEAD)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Command:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_security))
							dat += "<b>As Security:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_security'>[(toggles & DEADMIN_POSITION_SECURITY)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Security:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_silicons))
							dat += "<b>As Silicon:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_silicon'>[(toggles & DEADMIN_POSITION_SILICON)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Silicon:</b> FORCED<br>"

				dat += "</td>"
			dat += "</tr></table>"

		if(3) // Custom keybindings
			if(usr?.client?.prefs?.be_russian)
				used_title = "Привязка Клавиш"
			else
				used_title = "Keybinds"
			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

			for (var/category in kb_categories)
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					if(!length(user_binds[kb.name]))
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
//						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
//						if(LAZYLEN(default_keys))
//							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybinds;task=keybindings_set'>\[Reset to default\]</a>"
			dat += "</body>"


	if(!IsGuestKey(user.key))
		if(usr?.client?.prefs?.be_russian)
			dat += "<a href='?_src_=prefs;preference=save'>Сохранить</a><br>"
			dat += "<a href='?_src_=prefs;preference=load'>Откатить</a><br>"
		else
			dat += "<a href='?_src_=prefs;preference=save'>Save</a><br>"
			dat += "<a href='?_src_=prefs;preference=load'>Undo</a><br>"

	var/mob/dead/new_player/N = user
	// well.... one empty slot here for something I suppose lol
	dat += "<table width='100%'>"
	dat += "<tr>"
	dat += "<td width='33%' align='left'>"
	if(usr?.client?.prefs?.be_russian)
		dat += "<a class='animationcolor' href='byond://?src=[REF(N)];rpprompt=1'>Краткая Сводка Мира</a><br>"
	else
		dat += "<a class='animationcolor' href='byond://?src=[REF(N)];rpprompt=1'>Lore Primer</a><br>"
//	dat += "<a href='byond://?src=[REF(N)];rgprompt=1'>Religion Primer</a><br>"
	dat += 	"</td>"
	dat += "<td width='33%' align='center'>"
	if(usr?.client?.prefs?.be_russian)
		dat += "<br><b>Доп. Предмет:</b> <a href='?_src_=prefs;preference=loadout_item;task=input'>[loadout ? loadout.name : "None"]</a><BR>"
	else
		dat += "<br><b>Loadout Item:</b> <a href='?_src_=prefs;preference=loadout_item;task=input'>[loadout ? loadout.name : "None"]</a><BR>"
	if(usr?.client?.prefs?.be_russian)
		dat += "<a href='?_src_=prefs;preference=bespecial'><b>[next_special_trait ? "<font color='red'>ОСОБЕННЫЙ</font>" : "Быть Особенным"]</b></a><BR>"
	else
		dat += "<a href='?_src_=prefs;preference=bespecial'><b>[next_special_trait ? "<font color='red'>SPECIAL</font>" : "Be Special"]</b></a><BR>"
	if(istype(N))
		if(SSticker.current_state <= GAME_STATE_PREGAME)
			switch(N.ready)
				if(PLAYER_NOT_READY)
					if(usr?.client?.prefs?.be_russian)
						dat += "<b>НЕ ГОТОВ</b> <a href='byond://?src=[REF(N)];ready=[PLAYER_READY_TO_PLAY]'>ГОТОВ</a>"
					else
						dat += "<b>UNREADY</b> <a href='byond://?src=[REF(N)];ready=[PLAYER_READY_TO_PLAY]'>READY</a>"
				if(PLAYER_READY_TO_PLAY)
					if(usr?.client?.prefs?.be_russian)
						dat += "<a href='byond://?src=[REF(N)];ready=[PLAYER_NOT_READY]'>НЕ ГОТОВ</a> <b>ГОТОВ</b>"
					else
						dat += "<a href='byond://?src=[REF(N)];ready=[PLAYER_NOT_READY]'>UNREADY</a> <b>READY</b>"
		else
			if(!is_active_migrant())
				dat += "<a href='byond://?src=[REF(N)];late_join=1'>JOINLATE</a>"
			else
				dat += "<a class='linkOff' href='byond://?src=[REF(N)];late_join=1'>JOINLATE</a>"
			dat += " - <a href='?_src_=prefs;preference=migrants'>MIGRATION</a>"
			dat += "<br><a href='?_src_=prefs;preference=manifest'>ACTORS</a>"
	else
		dat += "<a href='?_src_=prefs;preference=finished'>DONE</a>"

	dat += "</td>"
	dat += "<td width='33%' align='right'>"
	if(usr?.client?.prefs?.be_russian)
		dat += "<b>Детальная Семья:</b> <a href='?_src_=prefs;preference=detailed_family'>[(detailed_family_loging) ? "Yes":"No"]</a><br>" // REDMOON ADD - family_changes
		dat += "<b>Русскоязычность:</b> <a href='?_src_=prefs;preference=be_russian'>[(be_russian) ? "Yes":"No"]</a><br>"
		dat += "<b>Давать отпор:</b> <a href='?_src_=prefs;preference=be_defiant'>[(defiant) ? "Yes":"No"]</a><br>"
		dat += "<b>Девственность:</b> <a href='?_src_=prefs;preference=be_virgin'>[(virginity) ? "Yes":"No"]</a><br>"
		dat += "<b>Быть Голосом:</b> <a href='?_src_=prefs;preference=schizo_voice'>[(toggles & SCHIZO_VOICE) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>Эффекты стресса:</b> <a href='?_src_=prefs;preference=stress_indicator'>[(redmoon_toggles & STRESS_EFFECTS) ? "Disabled":"Enabled"]</a>"
	else
		dat += "<b>Detailed Family:</b> <a href='?_src_=prefs;preference=detailed_family'>[(detailed_family_loging) ? "Yes":"No"]</a><br>" // REDMOON ADD - family_changes
		dat += "<b>Be Russian:</b> <a href='?_src_=prefs;preference=be_russian'>[(be_russian) ? "Yes":"No"]</a><br>"
		dat += "<b>Be defiant:</b> <a href='?_src_=prefs;preference=be_defiant'>[(defiant) ? "Yes":"No"]</a><br>"
		dat += "<b>Be a virgin:</b> <a href='?_src_=prefs;preference=be_virgin'>[(virginity) ? "Yes":"No"]</a><br>"
		dat += "<b>Be voice:</b> <a href='?_src_=prefs;preference=schizo_voice'>[(toggles & SCHIZO_VOICE) ? "Enabled":"Disabled"]</a><br>"
		dat += "<b>Stress effects:</b> <a href='?_src_=prefs;preference=stress_indicator'>[(redmoon_toggles & STRESS_EFFECTS) ? "Disabled":"Enabled"]</a>"
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
//	dat += "<a href='?_src_=prefs;preference=reset_all'>Reset Setup</a>"


	if(user.client.is_new_player())
		dat = list("<center>REGISTER!</center>")

	winshow(user, "preferencess_window", TRUE)
	var/datum/browser/noclose/popup = new(user, "preferences_browser", "<div align='center'>[used_title]</div>")
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
	update_preview_icon()
//	onclose(user, "preferencess_window", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybinds;task=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/noclose/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/get_allowed_patrons(datum/outfit/job/roguetown/J)
	if(J == null)
		return ""
	var/data = "("
	var/datum/outfit/job/roguetown/U = new J
	if(!U.allowed_patrons)
		return ""
	if(!U.allowed_patrons.len)
		return ""
	for(var/I = 1, I <= U.allowed_patrons.len, I++)
		var/datum/patron/divine/E = U.allowed_patrons[I]
		data += "[E.name]"
		if(I != U.allowed_patrons.len)
			data += ", "
	data += " only)"
	return data

/datum/preferences/proc/SetChoices(mob/user, limit = 15, list/splitJobs = list("Court Magos", "Retinue Captain", "Priest", "Merchant", "Archivist", "Towner", "Grenzelhoft Mercenary", "Beggar", "Prisoner", "Goblin King"), widthPerColumn = 295, height = 670) //295 620
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(SSjob.occupations.len <= 0)
//		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.

	else
//		HTML += "<b>Choose class preferences</b><br>"
//		HTML += "<div align='center'>Left-click to raise a class preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
		if(joblessrole != RETURNTOLOBBY && joblessrole != BERANDOMJOB) // this is to catch those that used the previous definition and reset.
			joblessrole = RETURNTOLOBBY
		HTML += "<b>If Role Unavailable:</b><font color='purple'><a href='?_src_=prefs;preference=job;task=nojob'>[joblessrole]</a></font><BR>"
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob
		for(var/datum/job/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			if(!job.spawn_positions)
				continue
			if(!job.map_check())
				continue
			index += 1
//			if((index >= limit) || (job.title in splitJobs))
			if(index >= limit)
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			if(job.title in splitJobs)
				HTML += "<tr bgcolor='#000000'><td width='60%' align='right'><hr></td></tr>"

			HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>"
			var/rank = job.title
			var/used_name = "[job.title]"
			var/used_tutorial = job.tutorial
			if(user.client.prefs.be_russian && job.ru_title)
				used_name = job.ru_title
				used_tutorial = job.ru_tutorial
			if(gender == FEMALE && job.f_title)
				if(usr?.client?.prefs?.be_russian)
					used_name = "[job.ru_f_title]"
				else
					used_name = "[job.f_title]"
			lastJob = job
			if(is_role_banned(user.ckey, job.title))
				HTML += "[used_name]</td> <td><a href='?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining)
				HTML += "[used_name]</td> <td><font color=red> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \] </font></td></tr>"
				continue
			if(!job.player_old_enough(user.client))
				var/available_in_days = job.available_in_days(user.client)
				HTML += "[used_name]</td> <td><font color=red> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			if(!job.required && !isnull(job.min_pq) && (get_playerquality(user.ckey) < job.min_pq))
				HTML += "<font color=#a59461>[used_name] (Min PQ: [job.min_pq])</font></td> <td> </td></tr>"
				continue
			if(!job.required && !isnull(job.max_pq) && (get_playerquality(user.ckey) > job.max_pq) && !is_misc_banned(parent.ckey, BAN_MISC_LUNATIC))
				HTML += "<font color=#a59461>[used_name] (Max PQ: [job.max_pq])</font></td> <td> </td></tr>"
				continue
			if(length(job.allowed_races) && !(user.client.prefs.pref_species.type in job.allowed_races))
				if(!(user.client.triumph_ids.Find("race_all")))
					HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
					continue
			var/job_unavailable = JOB_AVAILABLE
			if(isnewplayer(parent?.mob))
				var/mob/dead/new_player/new_player = parent.mob
				job_unavailable = new_player.IsJobUnavailable(job.title, latejoin = FALSE)
			var/static/list/acceptable_unavailables = list(
				JOB_AVAILABLE,
				JOB_UNAVAILABLE_SLOTFULL,
			)
			if(!(job_unavailable in acceptable_unavailables))
				HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
				continue
//			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
//				HTML += "<font color=orange>[rank]</font></td><td></td></tr>"
//				continue
/*			if((rank in GLOB.command_positions) || (rank == "AI"))//Bold head jobs
				HTML += "<b><span class='dark'><a href='?_src_=prefs;preference=job;task=tutorial;tut='[job.tutorial]''>[used_name]</a></span></b>"
			else
				HTML += span_dark("<a href='?_src_=prefs;preference=job;task=tutorial;tut='[job.tutorial]''>[used_name]</a>")*/
			var/limitations = ""
			limitations = get_allowed_patrons(job.outfit)

			HTML += {"

<style>


.tutorialhover {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
}

.tutorialhover .tutorial {

	visibility: hidden;
	width: 280px;
	background-color: black;
	color: #e3c06f;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;

	position: absolute;
	z-index: 1;
	top: 100%;
	left: 50%;
	margin-left: -140px;
}

.tutorialhover:hover .tutorial{
	visibility: visible;
}

</style>

<div class="tutorialhover"><font>[used_name]</font>
<span class="tutorial"><font color='red'>[limitations]</font> [used_tutorial]<br>
Slots: [job.spawn_positions]</span>
</div>

			"}

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
					var/mob/dead/new_player/P = user
					if(istype(P))
						P.topjob = job.title
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

//			if(rank == SSjob.overflow_role)//Overflow is special
//				if(job_preferences[SSjob.overflow_role] == JP_LOW)
//					HTML += "<font color=green>Yes</font>"
//				else
//					HTML += "<font color=red>No</font>"
//				HTML += "</a></td></tr>"
//				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table><br>"

//		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
//		if(joblessrole == BERANDOMJOB)
//			message = "Get random job if preferences unavailable"
//		else if(joblessrole == RETURNTOLOBBY)
//			message = "Return to lobby if preferences unavailable"
//		HTML += "<center><br><a href='?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		if(user.client.prefs.lastclass)
			HTML += "<center><a href='?_src_=prefs;preference=job;task=triumphthing'>PLAY AS [user.client.prefs.lastclass] AGAIN</a></center>"
		else
			HTML += "<br>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=reset'>Reset</a></center>"

	var/datum/browser/noclose/popup = new(user, "mob_occupation", "<div align='center'>Class Selection</div>", width, height)
	popup.set_window_options("can_close=0")
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		ShowChoices(user,4)
		return

	if (!isnum(desiredLvl))
		to_chat(user, span_danger("UpdateJobPreference - desired level was not a number. Please notify coders!"))
		ShowChoices(user,4)
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(job.required && !isnull(job.min_pq) && (get_playerquality(user.ckey) < job.min_pq))
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			var/used_name = "[job.title]"
			if(gender == FEMALE && job.f_title)
				used_name = "[job.f_title]"
			to_chat(user, "<font color='red'>You have too low PQ for [used_name] (Min PQ: [job.min_pq]), you may only set it to low.</font>")
			jpval = JP_LOW

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs()
	job_preferences = list()

/datum/preferences/proc/ResetLastClass(mob/user)
	if(user.client?.prefs)
		if(!user.client.prefs.lastclass)
			return
	var/choice = tgalert(user, "Use 2 Triumphs to play as this class again?", "Reset LastPlayed", "Do It", "Cancel")
	if(choice == "Cancel")
		return
	if(!choice)
		return
	if(user.client?.prefs)
		if(user.client.prefs.lastclass)
			if(user.get_triumphs() < 2)
				to_chat(user, span_warning("I haven't TRIUMPHED enough."))
				return
			user.adjust_triumphs(-2)
			user.client.prefs.lastclass = null
			user.client.prefs.save_preferences()

/datum/preferences/proc/SetKeybinds(mob/user)
	var/list/dat = list()
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)

	var/list/kb_categories = list()
	// Group keybinds by category
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		kb_categories[kb.category] += list(kb)

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=keybinds;task=close'>Done</a></center><br>"
	for (var/category in kb_categories)
		for (var/i in kb_categories[category])
			var/datum/keybinding/kb = i
			if(!length(user_binds[kb.name]))
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
//						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
//						if(LAZYLEN(default_keys))
//							dat += "| Default: [default_keys.Join(", ")]"
				dat += "<br>"
			else
				var/bound_key = user_binds[kb.name][1]
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				for(var/bound_key_index in 2 to length(user_binds[kb.name]))
					bound_key = user_binds[kb.name][bound_key_index]
					dat += " | <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
					dat += "| <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
				dat += "<br>"

	dat += "<br><br>"
	dat += "<a href ='?_src_=prefs;preference=keybinds;task=keybindings_reset'>\[Reset to default\]</a>"
	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "keybind_setup", "<div align='center'>Keybinds</div>", 600, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/SetAntag(mob/user)
	var/list/dat = list()

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=antag;task=close'>Done</a></center><br>"


	if(is_total_antag_banned(user.ckey))
		dat += "<font color=red><b>I am banned from antagonist roles.</b></font><br>"
		src.be_special = list()


	for (var/i in GLOB.special_roles_rogue)
		if(is_antag_banned(user.ckey, i))
			dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>BANNED</a><br>"
		else
			var/days_remaining = null
			if(ispath(GLOB.special_roles[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
				var/mode_path = GLOB.special_roles[i]
				var/datum/game_mode/temp_mode = new mode_path
				days_remaining = temp_mode.get_remaining_days(user.client)

			if(days_remaining)
				dat += "<b>[capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
			else
				dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"


	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "antag_setup", "<div align='center'>Special Role</div>", 250, 300) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)


/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details && ban_details.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, span_danger("You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]"))
			return
	if(href_list["preference"] == "job")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user,4)
			if("reset")
				ResetJobs()
				SetChoices(user)
			if("triumphthing")
				ResetLastClass(user)
			if("nojob")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = RETURNTOLOBBY
				SetChoices(user)
			if("tutorial")
				if(href_list["tut"])
					testing("[href_list["tut"]]")
					to_chat(user, span_info("* ----------------------- *"))
					to_chat(user, href_list["tut"])
					to_chat(user, span_info("* ----------------------- *"))
			if("random")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						joblessrole = BERANDOMJOB
					if(BEOVERFLOW)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = BERANDOMJOB
				SetChoices(user)
			if("setJobLevel")
				if(SSticker.job_change_locked)
					return 1
				UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
			else
				SetChoices(user)
		return 1

	else if(href_list["preference"] == "antag")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=antag_setup")
				ShowChoices(user)
			if("be_special")
				var/be_special_type = href_list["be_special_type"]
				if(be_special_type in be_special)
					be_special -= be_special_type
				else
					be_special += be_special_type
				SetAntag(user)
			if("update")
				SetAntag(user)
			else
				SetAntag(user)
	else if(href_list["preference"] == "additional_settings")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=additional_settings")
				ShowChoices(user)
			if("set_hand")
				var/potential_hand_ckey = input(usr, "Введите Byond Login (CKEY) игрока, которого вы хотели бы видеть в качестве десницы (эту настройку можно изменять посреди раунда) Те, кто не выставлен в качестве десницы, не смогут зайти за неё ни в начале, ни в процессе раунда..", "Bloodbinding", hand_ckey) as text
				if(!potential_hand_ckey)
					hand_ckey = ""
				hand_ckey = potential_hand_ckey
				AdditionalSettings(user)
			else
				AdditionalSettings(user)
	else if(href_list["preference"] == "triumphs")
		user.show_triumphs_list()

	else if(href_list["preference"] == "playerquality")
		check_pq_menu(user.ckey)

	else if(href_list["preference"] == "markings")
		ShowMarkings(user)
		return
	else if(href_list["preference"] == "descriptors")
		show_descriptors_ui(user)
		return

	else if(href_list["preference"] == "customizers")
		ShowCustomizers(user)
		return
	else if(href_list["preference"] == "triumph_buy_menu")
		SStriumphs.startup_triumphs_menu(user.client)

	else if(href_list["preference"] == "familypref")
		switch(href_list["res"])
			if("race")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.roundstart_races)
						var/datum/species/S = GLOB.species_list[A]
						var/index = "[(S.id in family_species) ? "(+)" : ""][S.name]"
						choices[index] = S.id
					choices += "(DONE)"
					choice = input(usr,"Out of all the many races, none catch my fancy quite like... (+) = ON","RACE") as anything in choices
					if(choice != "(CANCEL)")
						if(choices[choice] in family_species)
							family_species -= choices[choice]
						else
							family_species += choices[choice]
			// REDMOON ADD START
			// family_changes - возможность выставить CKEY игрока, с которым хочется создать семью
			if("ckey")
				var/msg = "Add PLAYER CKEY of your spouse! Check it twice! Leave the field clear to have random spouse with other parameters."
				if(usr?.client?.prefs?.be_russian)
					msg = "Введите CKEY ИГРОКА вашей второй половинки! Вы и второй игрок должны правильно записать CKEY друг друга, чтобы это работало! Оставьте поле пустым, чтобы была случайная пара (в соответствии с остальными требованиями)."
				var/potential_spouse_ckey = input(usr, msg, "Bloodbinding", null) as text
				if(!potential_spouse_ckey)
					spouse_ckey = null
				spouse_ckey = potential_spouse_ckey
			// family_changes - возможность выставить название семьи
			if("surname")
				var/msg = "Add surname your family will be known as. You can join after roundstart to form a family if you set up your spouse soul."
				if(usr?.client?.prefs?.be_russian)
					msg = "Введите фамилию, под которой будет известна ваша семья. Вы можете зайти после начала раунда за членов одной семьи, если выставите душу второй половинки."
				var/potential_family_surname = input(usr, msg, "Family History", null) as text
				if(!potential_family_surname)
					family_surname = null
				family_surname = potential_family_surname
			// family_changes - выставление допустимых гениталий у партнёра
			if("genitals")
				if(usr?.client?.prefs?.be_russian)
					to_chat(usr, span_warning("<hr>\
					Эора не благословит помолвку, если семья не способна породить жизнь."))
				else
					to_chat(usr, span_warning("<hr>\
					The marriage shall not supported by Eora if the mates cannot produce a new life."))
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in list("Male", "Female", "Futa", "Cuntboy"))
						var/index = "[(A in family_genitals) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					var/msg = usr.client.prefs.be_russian ? "Я предпочитаю... (+) = СОГЛАСИЕ" : "I would prefer... (+) = CONSENT"
					choice = input(usr, msg, "In the church...") as anything in choices
					if(choice != "(CANCEL)")
						if(choices[choice] in family_genitals)
							family_genitals -= choices[choice]
						else
							family_genitals += choices[choice]
			// family_changes - возможнось формирования семьи после начала раунда
			if("latejoin")
				if(usr?.client?.prefs?.be_russian)
					to_chat(usr, span_warning("<hr>\
					Если выставлено \"Разрешено\", то заходя не с начала раунда, вы всё ещё можете в момент появления быть приписаны к тому, кто ищет семью. Иначе, только с начала недели."))
				else
					to_chat(usr, span_warning("<hr>\
					If set as \"Allowed\", then in case of joining after start of the week you will try to form up a family with anyone who seeks for it. Otherwise, you will seek only at the start of week."))	
				allow_latejoin_family = !allow_latejoin_family
	// rumors_addition - выставление слухов
	else if(href_list["preference"] == "rumors_prefs")
		switch(href_list["res"])

			if("species")
				var/choice
				var/additional_races = list("Werewolf", "Minotaur", "Demon", "Magic Beings", "Wildlife", "Literally Everyone")
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.roundstart_races)
						var/datum/species/S = GLOB.species_list[A]
						var/index = "[(S.id in rumors_prefered_races) ? "(+)" : ""][S.name]"
						choices[index] = S.id
					for(var/B in additional_races)
						var/index = "[(B in rumors_prefered_races) ? "(+)" : ""][B]"
						choices[index] = B
					choices += "(DONE)"
					choice = input(usr, "Ходит слух, что я предпочитаю такие расы, как...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_prefered_races)
							rumors_prefered_races -= choices[choice]
						else
							rumors_prefered_races += choices[choice]
				if(LAZYLEN(rumors_prefered_races) > 7)
					to_chat(user, span_danger("Не растекайтесь мыслью по древу. Сделайте своего персонажа более структурированным (количество доступных слухов о расах - 7). Слух отчищен."))
					rumors_prefered_races = list()

			if("gender")
				var/choice
				var/beginnings = list("мужчинами", "женщинами", "женщинами с мужским началом", "мужчинами с женским началом")
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in beginnings)
						var/index = "[(A in rumors_prefered_beginnings) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Ходит слух, что я люблю фехтовать с...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_prefered_beginnings)
							rumors_prefered_beginnings -= choices[choice]
						else
							rumors_prefered_beginnings += choices[choice]
				for(var/A in rumors_prefered_beginnings)
					if(!(A in beginnings))
						rumors_prefered_beginnings -= A

			if("bed")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_prefered_behavior_in_bed_choices)
						var/index = "[(A in rumors_prefered_behavior_in_bed) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Ходит слух, что в постели я предпочитаю...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_prefered_behavior_in_bed)
							rumors_prefered_behavior_in_bed -= choices[choice]
						else
							rumors_prefered_behavior_in_bed += choices[choice]
				for(var/A in rumors_prefered_behavior_in_bed)
					if(!(A in GLOB.rumors_prefered_behavior_in_bed_choices))
						rumors_prefered_behavior_in_bed -= A

			if("genitals")
				rumors_genitals = input(usr, "Ходит ли слух, что у меня начало иного пола? (Сейчас - [rumors_genitals ? "Ходит" : "Нет"]).") as anything in list("Да", "Нет")
				if(rumors_genitals == "Нет")
					rumors_genitals = null

			if("family")
				rumors_family = input(usr, "[rumors_family ? "([rumors_family])." : "..."]") as anything in GLOB.rumors_family_choices
				if(rumors_family == "(Нет слухов)")
					rumors_family = null

			if("problems")
				rumors_prefered_behavior_with_problems = input(usr, "Ходит слух, что проблемы решаю [rumors_prefered_behavior_with_problems ? "([rumors_prefered_behavior_with_problems])." : "..."]") as anything in GLOB.rumors_prefered_behavior_with_problems_choices
				if(rumors_prefered_behavior_with_problems == "(Нет слухов)")
					rumors_prefered_behavior_with_problems = null

			if("combat")
				rumors_prefered_behavior_in_combat = input(usr, "Ходит слух, что в бою [rumors_prefered_behavior_in_combat ? "([rumors_prefered_behavior_in_combat])." : "..."]") as anything in GLOB.rumors_prefered_behavior_in_combat_choices
				if(rumors_prefered_behavior_in_combat == "(Нет слухов)")
					rumors_prefered_behavior_in_combat = null

			if("work")
				rumors_prefered_behavior_in_work = input(usr, "Ходит слух, что в труде [rumors_prefered_behavior_in_work ? "([rumors_prefered_behavior_in_work])." : "..."]") as anything in GLOB.rumors_prefered_behavior_in_work_choices
				if(rumors_prefered_behavior_in_work == "(Нет слухов)")
					rumors_prefered_behavior_in_work = null

			if("secret")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_secret_choices)
						var/index = "[(A in rumors_secret) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Слухи о которых никто не знает. Это ООС информация для других игроков.") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_secret)
							rumors_secret -= choices[choice]
						else
							rumors_secret += choices[choice]
				for(var/A in rumors_secret)
					if(!(A in GLOB.rumors_secret_choices))
						rumors_secret -= A

			if("relax")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_prefered_ways_to_relax_choices)
						var/index = "[(A in rumors_prefered_ways_to_relax) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Ходит слух, что я люблю...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_prefered_ways_to_relax)
							rumors_prefered_ways_to_relax -= choices[choice]
						else
							rumors_prefered_ways_to_relax += choices[choice]
				for(var/A in rumors_prefered_ways_to_relax)
					if(!(A in GLOB.rumors_prefered_ways_to_relax_choices))
						rumors_prefered_ways_to_relax -= A
				if(LAZYLEN(rumors_prefered_ways_to_relax) > 7)
					to_chat(user, span_danger("Не растекайтесь мыслью по древу. Сделайте своего персонажа более структурированным (количество доступных слухов об отдыха - 7). Слух отчищен."))
					rumors_prefered_ways_to_relax = list()

			if("flaws")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_overal_choices)
						var/index = "[(A in rumors_overal) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Ходят НЕПРАВДИВЕЙШИЕ слухи, что мне причесляют...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_overal)
							rumors_overal -= choices[choice]
						else
							rumors_overal += choices[choice]
				for(var/A in rumors_overal)
					if(!(A in GLOB.rumors_overal_choices))
						rumors_overal -= A
				if(LAZYLEN(rumors_overal) > 4)
					to_chat(user, span_danger("Не растекайтесь мыслью по древу. Сделайте своего персонажа более структурированным (количество доступных негативных черт характера - 4). Слух отчищен."))
					rumors_overal = list()

			if("advantages")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_overal_good_choices)
						var/index = "[(A in rumors_overal_good) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Некоторые мне причесляют...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_overal_good)
							rumors_overal_good -= choices[choice]
						else
							rumors_overal_good += choices[choice]
				for(var/A in rumors_overal_good)
					if(!(A in GLOB.rumors_overal_good_choices))
						rumors_overal_good -= A
				if(LAZYLEN(rumors_overal) < 2)
					to_chat(user, span_danger("Если о вашем персонаже будут добрые слухи, то следовательно, должны быть и негативные (минимум 2). Слух отчищен."))
					rumors_overal_good = list()
				if(LAZYLEN(rumors_overal_good) > 4)
					to_chat(user, span_danger("Не растекайтесь мыслью по древу. Сделайте своего персонажа более структурированным (количество доступных негативных черт характера - 4). Слух отчищен."))
					rumors_overal_good = list()

			if("dangerous")
				var/choice
				while(choice != "(DONE)")
					var/list/choices = list()
					for(var/A in GLOB.rumors_dangerous_choice)
						var/index = "[(A in rumors_dangerous) ? "(+)" : ""][A]"
						choices[index] = A
					choices += "(DONE)"
					choice = input(usr, "Меня подозревают в...") as anything in choices
					if(choice != "(DONE)")
						if(choices[choice] in rumors_dangerous)
							rumors_dangerous -= choices[choice]
						else
							rumors_dangerous += choices[choice]
				for(var/A in rumors_dangerous)
					if(!(A in GLOB.rumors_dangerous_choice))
						rumors_dangerous -= A
				if(LAZYLEN(rumors_dangerous) > 2)
					to_chat(user, span_danger("Не растекайтесь мыслью по древу. Сделайте своего персонажа более структурированным (количество доступных опасных слухов - 2). Слух отчищен."))
					rumors_dangerous = list()
			// REDMOON ADD END

	else if(href_list["preference"] == "keybinds")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=keybind_setup")
				ShowChoices(user)
			if("update")
				SetKeybinds(user)
			if("keybindings_capture")
				var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
				var/old_key = href_list["old_key"]
				CaptureKeybinding(user, kb, old_key)
				return

			if("keybindings_set")
				var/kb_name = href_list["keybinding"]
				if(!kb_name)
					user << browse(null, "window=capturekeypress")
					SetKeybinds(user)
					return

				var/clear_key = text2num(href_list["clear_key"])
				var/old_key = href_list["old_key"]
				if(clear_key)
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					user << browse(null, "window=capturekeypress")
					save_preferences()
					SetKeybinds(user)
					return

				var/new_key = uppertext(href_list["key"])
				var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
				var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
				var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
				var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
				// var/key_code = text2num(href_list["key_code"])

				if(GLOB._kbMap[new_key])
					new_key = GLOB._kbMap[new_key]

				var/full_key
				switch(new_key)
					if("Alt")
						full_key = "[new_key][CtrlMod][ShiftMod]"
					if("Ctrl")
						full_key = "[AltMod][new_key][ShiftMod]"
					if("Shift")
						full_key = "[AltMod][CtrlMod][new_key]"
					else
						full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
				if(key_bindings[old_key])
					key_bindings[old_key] -= kb_name
					if(!length(key_bindings[old_key]))
						key_bindings -= old_key
				key_bindings[full_key] += list(kb_name)
				key_bindings[full_key] = sortList(key_bindings[full_key])

				user << browse(null, "window=capturekeypress")
				user.client.update_movement_keys()
				save_preferences()
				SetKeybinds(user)

			if("keybindings_reset")
				var/choice = tgalert(user, "Do you really want to reset your keybindings?", "Setup keybindings", "Do It", "Cancel")
				if(choice == "Cancel")
					ShowChoices(user,3)
					return
				hotkeys = (choice == "Do It")
				key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
				user.client.update_movement_keys()
				SetKeybinds(user)
			else
				SetKeybinds(user)
		return TRUE

	if(href_list["preference"] == "loadout_item")
		var/list/loadouts_available = list("None")
		for (var/path as anything in GLOB.loadout_items)
			var/datum/loadout_item/loadout = GLOB.loadout_items[path]
			var/donoritem = loadout.donoritem
			if(donoritem && !loadout.donator_ckey_check(user.ckey))
				continue
			if (!loadout.name)
				continue
			loadouts_available[loadout.name] = loadout

		var/loadout_input = input(user, "Choose your character's loadout item. RMB a tree, statue or clock to collect. I cannot stress this enough. YOU DON'T SPAWN WITH THESE. YOU HAVE TO MANUALLY PICK THEM UP!!", "LOADOUT THAT YOU GET FROM A TREE OR STATUE OR CLOCK") as null|anything in loadouts_available
		if(loadout_input)
			if(loadout_input == "None")
				loadout = null
				to_chat(user, "Who needs stuff anyway?")
			else
				loadout = loadouts_available[loadout_input]
				to_chat(user, "<font color='yellow'><b>[loadout.name]</b></font>")
				if(loadout.desc)
					to_chat(user, "[loadout.desc]")

	if(href_list["preference"] == "loadout_item2")
		var/list/loadouts_available = list("None")
		for (var/path as anything in GLOB.loadout_items)
			var/datum/loadout_item/loadout2 = GLOB.loadout_items[path]
			var/donoritem = loadout2.donoritem
			if(donoritem && !loadout2.donator_ckey_check(user.ckey))
				continue
			if (!loadout2.name)
				continue
			loadouts_available[loadout2.name] = loadout2

		var/loadout_input2 = input(user, "Choose your character's loadout item. RMB a tree, statue or clock to collect. I cannot stress this enough. YOU DON'T SPAWN WITH THESE. YOU HAVE TO MANUALLY PICK THEM UP!!", "LOADOUT THAT YOU GET FROM A TREE OR STATUE OR CLOCK") as null|anything in loadouts_available
		if(loadout_input2)
			if(loadout_input2 == "None")
				loadout2 = null
				to_chat(user, "Who needs stuff anyway?")
			else
				loadout2 = loadouts_available[loadout_input2]
				to_chat(user, "<font color='yellow'><b>[loadout2.name]</b></font>")
				if(loadout2.desc)
					to_chat(user, "[loadout2.desc]")

	if(href_list["preference"] == "loadout_item3")
		var/list/loadouts_available = list("None")
		for (var/path as anything in GLOB.loadout_items)
			var/datum/loadout_item/loadout3 = GLOB.loadout_items[path]
			var/donoritem = loadout3.donoritem
			if(donoritem && !loadout3.donator_ckey_check(user.ckey))
				continue
			if (!loadout3.name)
				continue
			loadouts_available[loadout3.name] = loadout3

		var/loadout_input3 = input(user, "Choose your character's loadout item. RMB a tree, statue or clock to collect. I cannot stress this enough. YOU DON'T SPAWN WITH THESE. YOU HAVE TO MANUALLY PICK THEM UP!!", "LOADOUT THAT YOU GET FROM A TREE OR STATUE OR CLOCK") as null|anything in loadouts_available
		if(loadout_input3)
			if(loadout_input3 == "None")
				loadout3 = null
				to_chat(user, "Who needs stuff anyway?")
			else
				loadout3 = loadouts_available[loadout_input3]
				to_chat(user, "<font color='yellow'><b>[loadout3.name]</b></font>")
				if(loadout3.desc)
					to_chat(user, "[loadout3.desc]")
	switch(href_list["task"])
		if("change_customizer")
			handle_customizer_topic(user, href_list)
			ShowChoices(user)
			ShowCustomizers(user)
			return
		if("change_marking")
			handle_body_markings_topic(user, href_list)
			ShowChoices(user)
			ShowMarkings(user)
			return
		if("change_descriptor")
			handle_descriptors_topic(user, href_list)
			show_descriptors_ui(user)
			return
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = pick(pref_species.possible_ages)
				if("eyes")
					eye_color = random_eye_color()
				if("s_tone")
					var/list/skins = pref_species.get_skin_list()
					skin_tone = skins[pick(skins)]
				if("species")
					random_species()
				if("bag")
					backpack = pick(GLOB.backpacklist)
				if("suit")
					jumpsuit_style = PREF_SUIT
				if("all")
					random_character(gender)

		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])

			switch(href_list["preference"])
				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("name")
					var/new_name = input(user, "Choose your character's name:", "Identity")  as text|null
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
					GLOB.name_adjustments |= "[parent] changed their characters name to [new_name]."
					log_character("[parent] changed their characters name to [new_name].")

//				if("age")
//					var/new_age = input(user, "Choose your character's age:\n([AGE_MIN]-[AGE_MAX])", "Years Dead") as num|null
//					if(new_age)
//						age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)

				if("age")
					var/new_age = input(user, "Choose your character's age:", "Yils Dead") as null|anything in pref_species.possible_ages
					if(new_age)
						age = new_age
						var/list/hairs
						if((age == AGE_OLD) && (OLDGREY in pref_species.species_traits))
							hairs = pref_species.get_oldhc_list()
						else
							hairs = pref_species.get_hairc_list()
						hair_color = hairs[pick(hairs)]
						facial_hair_color = hair_color
						ResetJobs()
						to_chat(user, "<font color='red'>Classes reset.</font>")


				if ("voicetype")
					var voicetype_input = input(user, "Choose your character's voice type", "Voice Type") as null|anything in GLOB.voice_types_list
					if(voicetype_input)
						voice_type = voicetype_input
						to_chat(user, "<font color='red'>Your character will now vocalize with a [lowertext(voice_type)] affect.</font>")

				if ("bodytype")
					var bodytype_input = input(user, "Choose your character's body type", "Body Type") as null|anything in list("Masculine", "Feminine")
					if(bodytype_input)
						body_type = MALE
						if(bodytype_input == "Feminine")
							body_type = FEMALE
						to_chat(user, "<font color='red'>Your character's body is [lowertext(bodytype_input)].</font>")
						update_preview_icon()

				if("faith")
					var/list/faiths_named = list()
					for(var/path as anything in GLOB.preference_faiths)
						var/datum/faith/faith = GLOB.faithlist[path]
						if(usr?.client?.prefs?.be_russian)
							if(!faith.ru_name)
								continue
							faiths_named[faith.ru_name] = faith
						else
							if(!faith.name)
								continue
							faiths_named[faith.name] = faith
					var/faith_input = input(user, "Choose your character's faith", "Faith") as null|anything in faiths_named
					if(faith_input)
						var/datum/faith/faith = faiths_named[faith_input]
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, "<font color='purple'>Вера: [faith.ru_name]</font>")
							to_chat(user, "<font color='purple'>История: [faith.ru_desc]</font>")
							to_chat(user, "<font color='purple'>Верователи: [faith.ru_worshippers]</font>")
						else
							to_chat(user, "<font color='purple'>Faith: [faith.name]</font>")
							to_chat(user, "<font color='purple'>Background: [faith.desc]</font>")
							to_chat(user, "<font color='purple'>Likely Worshippers: [faith.worshippers]</font>")
						selected_patron = GLOB.patronlist[faith.godhead] || GLOB.patronlist[pick(GLOB.patrons_by_faith[faith_input])]

				if("patron")
					var/list/patrons_named = list()
					for(var/path as anything in GLOB.patrons_by_faith[selected_patron?.associated_faith || initial(default_patron.associated_faith)])
						var/datum/patron/patron = GLOB.patronlist[path]
						if(!patron.name)
							continue
						patrons_named[patron.name] = patron
					var/datum/faith/current_faith = GLOB.faithlist[selected_patron?.associated_faith] || GLOB.faithlist[initial(default_patron.associated_faith)]
					var/god_input = input(user, "Choose your character's patron god", "[current_faith.name]") as null|anything in patrons_named
					if(god_input)
						selected_patron = patrons_named[god_input]
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, "<font color='purple'>Бог-Покровитель: [selected_patron.ru_name]</font>")
							to_chat(user, "<font color='purple'>Домен: [selected_patron.ru_domain]</font>")
							to_chat(user, "<font color='purple'>История: [selected_patron.ru_desc]</font>")
							to_chat(user, "<font color='purple'>Верователи: [selected_patron.ru_worshippers]</font>")
						else
							to_chat(user, "<font color='purple'>Patron: [selected_patron]</font>")
							to_chat(user, "<font color='purple'>Domain: [selected_patron.domain]</font>")
							to_chat(user, "<font color='purple'>Background: [selected_patron.desc]</font>")
							to_chat(user, "<font color='purple'>Likely Worshippers: [selected_patron.worshippers]</font>")

				if("bdetail")
					var/list/loly = list("Not yet.","Work in progress.","Don't click me.","Stop clicking this.","Nope.","Be patient.","Sooner or later.")
					to_chat(user, "<font color='red'>[pick(loly)]</font>")
					return

				if("voice")
					var/new_voice = input(user, "Choose your character's voice color:", "Character Preference","#"+voice_color) as color|null
					if(new_voice)
						if(color_hex2num(new_voice) < 230)
							to_chat(user, "<font color='red'>This voice color is too dark for mortals.</font>")
							return
						voice_color = sanitize_hexcolor(new_voice)

				if("barksound")
					var/list/woof_woof = list()
					for(var/path in GLOB.bark_list)
						var/datum/bark/B = GLOB.bark_list[path]
						if(initial(B.ignore))
							continue
						if(initial(B.ckeys_allowed))
							var/list/allowed = initial(B.ckeys_allowed)
							if(!allowed.Find(user.client.ckey))
								continue
						woof_woof[initial(B.name)] = initial(B.id)
					var/new_bork = input(user, "Choose your desired vocal bark", "Character Preference") as null|anything in woof_woof
					if(new_bork)
						bark_id = woof_woof[new_bork]
						var/datum/bark/B = GLOB.bark_list[bark_id] //Now we need sanitization to take into account bark-specific min/max values
						bark_speed = round(clamp(bark_speed, initial(B.minspeed), initial(B.maxspeed)), 1)
						bark_pitch = clamp(bark_pitch, initial(B.minpitch), initial(B.maxpitch))
						bark_variance = clamp(bark_variance, initial(B.minvariance), initial(B.maxvariance))

				if("barkspeed")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Choose your desired bark speed (Higher is slower, lower is faster). Min: [initial(B.minspeed)]. Max: [initial(B.maxspeed)]", "Character Preference") as null|num
					if(!isnull(borkset))
						bark_speed = round(clamp(borkset, initial(B.minspeed), initial(B.maxspeed)), 1)

				if("barkpitch")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Choose your desired baseline bark pitch. Min: [initial(B.minpitch)]. Max: [initial(B.maxpitch)]", "Character Preference") as null|num
					if(!isnull(borkset))
						bark_pitch = clamp(borkset, initial(B.minpitch), initial(B.maxpitch))

				if("barkvary")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Choose your desired baseline bark pitch. Min: [initial(B.minvariance)]. Max: [initial(B.maxvariance)]", "Character Preference") as null|num
					if(!isnull(borkset))
						bark_variance = clamp(borkset, initial(B.minvariance), initial(B.maxvariance))

				if("view_headshot")
					var/list/dat = list("<img src='[headshot_link]' width='250px' height='250px'>")
					var/datum/browser/popup = new(user, "headshot", "<div align='center'>Headshot</div>", 310, 320)
					popup.set_content(dat.Join())
					popup.open(FALSE)
					return

				if("view_nudeshot")
					var/list/dat = list("<img src='[nudeshot_link]' width='360px' height='480px'>")
					var/datum/browser/popup = new(user, "nudeshot", "<div align='center'>Nudeshot</div>", 400, 525)
					popup.set_content(dat.Join())
					popup.open(FALSE)
					return

				if("voice_pitch")
					var/new_voice_pitch = input(user, "Choose your character's voice pitch ([MIN_VOICE_PITCH] to [MAX_VOICE_PITCH], lower is deeper):", "Voice Pitch") as null|num
					if(new_voice_pitch)
						if(new_voice_pitch < MIN_VOICE_PITCH || new_voice_pitch > MAX_VOICE_PITCH)
							to_chat(user, "<font color='red'>Value must be between [MIN_VOICE_PITCH] and [MAX_VOICE_PITCH].</font>")
							return
						voice_pitch = new_voice_pitch

				if("formathelp")
					var/list/dat = list()
					dat +="You can use backslash (\\) to escape special characters.<br>"
					dat += "<br>"
					dat += "# text : Defines a header.<br>"
					dat += "|text| : Centers the text.<br>"
					dat += "**text** : Makes the text <b>bold</b>.<br>"
					dat += "*text* : Makes the text <i>italic</i>.<br>"
					dat += "^text^ : Increases the <font size = \"4\">size</font> of the text.<br>"
					dat += "((text)) : Decreases the <font size = \"1\">size</font> of the text.<br>"
					dat += "* item : An unordered list item.<br>"
					dat += "--- : Adds a horizontal rule.<br>"
					dat += "-=FFFFFFtext=- : Adds a specific <font color = '#FFFFFF'>colour</font> to text.<br><br>"
					dat += "Maximum Flavortext: <b>[MAXIMUM_FLAVOR_TEXT]</b> characters.<br>"
					var/datum/browser/popup = new(user, "Formatting Help", nwidth = 400, nheight = 350)
					popup.set_content(dat.Join())
					popup.open(FALSE)
				if("flavortext")
					to_chat(user, "<span class='notice'>["<span class='bold'>Flavortext should not include nonphysical nonsensory attributes such as backstory, the character's internal thoughts or your OOC preferences.</span>"]</span>")
					var/new_flavortext = input(user, "Input your character description:", "Flavortext (max [MAXIMUM_FLAVOR_TEXT] characters)", flavortext) as message|null
					if(new_flavortext == null)
						return
					if(new_flavortext == "")
						flavortext = null
						flavortext_display = null
						ShowChoices(user)
						return
					flavortext = new_flavortext
					var/ft = copytext(flavortext, 1, MAXIMUM_FLAVOR_TEXT + 1)
					ft = html_encode(ft)
					ft = replacetext(parsemarkdown_basic(ft), "\n", "<BR>")
					flavortext_display = ft
					to_chat(user, "<span class='notice'>Successfully updated flavortext</span>")
					if(length(flavortext) > MAXIMUM_FLAVOR_TEXT)
						to_chat(user, "<span class='warning'>Your flavourtext is too long (max [MAXIMUM_FLAVOR_TEXT] characters) and will be truncated.</span>")
					log_game("[user] has set their flavortext.")
				if("flavortext_nsfw")
					to_chat(user, "<span class='notice'>["<span class='bold'>This flavortext is visible when your character is nude. Flavortext should not include nonphysical nonsensory attributes such as backstory, the character's internal thoughts or your OOC preferences.</span>"]</span>")
					var/new_nsfw_flavortext = input(user, "Input your character description (nsfw):", "Flavortext (max [MAXIMUM_NSFW_FLAVOR_TEXT] characters)", flavortext_nsfw) as message|null
					if(new_nsfw_flavortext == null)
						return
					if(new_nsfw_flavortext == "")
						flavortext_nsfw = null
						flavortext_nsfw_display = null
						ShowChoices(user)
						return
					flavortext_nsfw = new_nsfw_flavortext
					var/ft = copytext(flavortext_nsfw, 1, MAXIMUM_NSFW_FLAVOR_TEXT + 1)
					ft = html_encode(ft)
					ft = replacetext(parsemarkdown_basic(ft), "\n", "<BR>")
					flavortext_nsfw_display = ft
					to_chat(user, "<span class='notice'>Successfully updated nsfw flavortext</span>")
					if(length(flavortext_nsfw) > MAXIMUM_NSFW_FLAVOR_TEXT)
						to_chat(user, "<span class='warning'>Your flavourtext is too long (max [MAXIMUM_NSFW_FLAVOR_TEXT] characters) and will be truncated.</span>")
					log_game("[user] has set their nsfw flavortext.")
				if("ooc_notes")
					to_chat(user, "<span class='notice'>["<span class='bold'>If you put 'anything goes' or 'no limits' here, do not be surprised if people take you up on it.</span>"]</span>")
					var/new_ooc_notes = input(user, "Input your OOC preferences:", "OOC notes", ooc_notes) as message|null
					if(new_ooc_notes == null)
						return
					if(new_ooc_notes == "")
						ooc_notes = null
						ooc_notes_display = null
						ShowChoices(user)
						return
					ooc_notes = new_ooc_notes

					var/ooc = copytext(ooc_notes, 1, MAXIMUM_OOC_NOTES + 1)
					ooc = html_encode(ooc)
					ooc = replacetext(parsemarkdown_basic(ooc), "\n", "<BR>")
					ooc_notes_display = ooc
					if(length(ooc_notes) > MAXIMUM_OOC_NOTES)
						to_chat(user, "<span class='warning'>Your OOC notes are too long (max [MAXIMUM_OOC_NOTES] characters) and will be truncated.</span>")
					to_chat(user, "<span class='notice'>Successfully updated OOC notes.</span>")
					log_game("[user] has set their OOC notes'.")
				if("headshot")
					if(usr?.client?.prefs?.be_russian)
						to_chat(user, "<span class='notice'>Пожалуйста, используйте Safe For Working изображение головы и плеч, чтобы сохранить уровень погружения. И последнее, ["<span class='bold'>не используйте фотографии из реальной жизни или любые несерьезные, мемные изображения.</span>"]</span>")
						to_chat(user, "<span class='notice'>Если фотокарточка не отображается в игре, убедитесь, что это прямая ссылка на изображение, которая правильно открывается в браузере.</span>")
						to_chat(user, "<span class='notice'>Разрешение: 250x250 pixels.</span>")
					else
						to_chat(user, "<span class='notice'>Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Lastly, ["<span class='bold'>do not use a real life photo or use any image that is less than serious.</span>"]</span>")
						to_chat(user, "<span class='notice'>If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser.</span>")
						to_chat(user, "<span class='notice'>Resolution: 250x250 pixels.</span>")
					var/new_headshot_link = input(user, "Input the headshot link (https, hosts: gyazo, discord, lensdump, imgbox, catbox):", "Headshot", headshot_link) as text|null
					if(new_headshot_link == null)
						return
					if(new_headshot_link == "")
						headshot_link = null
						ShowChoices(user)
						return
					if(!valid_headshot_link(user, new_headshot_link))
						headshot_link = null
						ShowChoices(user)
						return
					headshot_link = new_headshot_link
					to_chat(user, "<span class='notice'>Successfully updated headshot picture</span>")
					log_game("[user] has set their Headshot image to '[headshot_link]'.")
				if("nudeshot")
					if(usr?.client?.prefs?.be_russian)
						to_chat(user, "<span class='notice'>["<span class='bold'>Не используйте фотографии из реальной жизни или любые несерьезные, мемные изображения.</span>"]</span>")
						to_chat(user, "<span class='notice'>Если фотокарточка не отображается в игре, убедитесь, что это прямая ссылка на изображение, которая правильно открывается в браузере.</span>")
						to_chat(user, "<span class='notice'>Разрешение: 360x480 pixels.</span>")
					else
						to_chat(user, "<span class='notice'>["<span class='bold'>do not use a real life photo or use any image that is less than serious.</span>"]</span>")
						to_chat(user, "<span class='notice'>If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser.</span>")
						to_chat(user, "<span class='notice'>Resolution: 360x480 pixels.</span>")
					var/new_nudeshot_link = input(user, "Input the nudeshot link (https, hosts: gyazo, discord, lensdump, imgbox, catbox):", "Nudeshot", nudeshot_link) as text|null
					if(new_nudeshot_link == null)
						return
					if(new_nudeshot_link == "")
						nudeshot_link = null
						ShowChoices(user)
						return
					if(!valid_headshot_link(user, new_nudeshot_link))
						nudeshot_link = null
						ShowChoices(user)
						return
					nudeshot_link = new_nudeshot_link
					to_chat(user, "<span class='notice'>Successfully updated nudeshot picture</span>")
					log_game("[user] has set their Nudeshot image to '[nudeshot_link]'.")

				if("flavortext_preview")
					var/list/dat = list()
					dat += "<div align='center'><font size = 5; font color = '#dddddd'><b>[real_name]</b></font></div><br>"
					if(valid_headshot_link(null, headshot_link, TRUE))
						dat += ("<div align='center'><img src='[headshot_link]' width='325px' height='325px'></div><br>")
					if(flavortext && flavortext_display)
						dat += "<div align='left'>[flavortext_display]</div><br>"
					if(flavortext_nsfw && flavortext_nsfw_display)
						dat += "<div align='left'>[flavortext_nsfw_display]</div><br>"
					if(ooc_notes && ooc_notes_display)
						dat += "<div align='center'><b>OOC notes</b></div>"
						dat += "<div align='left'>[ooc_notes_display]</div>"
					if(nudeshot_link)
						dat += "<br><div align='center'><b>NSFW</b></div>"
						dat += ("<br><div align='center'><img src='[nudeshot_link]' width='600px' height='725px'></div>")
					var/datum/browser/popup = new(user, "[real_name]", nwidth = 600, nheight = 800)
					popup.set_content(dat.Join())
					popup.open(FALSE)

				if("species")
					var/list/crap = list()
					for(var/A in GLOB.roundstart_races)
						var/datum/species/bla = GLOB.species_list[A]
						bla = new bla()
						if(user.client)
							if(bla.patreon_req > user.client.patreonlevel())
								continue
						else
							continue
						var/display_name = bla.name
						if(usr.client.prefs.be_russian && bla.ru_name)
							display_name = bla.ru_name
						crap[display_name] = bla

					var/result = input(user, "Select a race", "Roguetown") as null|anything in crap

					if(result)
						var/datum/species/selected_species = crap[result]
						set_new_race(selected_species, user)

				if("update_mutant_colors")
					update_mutant_colors = !update_mutant_colors

				if("charflaw")
					var/list/coom = GLOB.character_flaws.Copy()
					var/result = input(user, "Select a flaw", "Roguetown") as null|anything in coom
					if(result)
						result = coom[result]
						var/datum/charflaw/C = new result()
						charflaw = C
						if(charflaw.desc)
							to_chat(user, "<span class='info'>[charflaw.desc]</span>")



				if("mutant_color")
					var/new_mutantcolor = color_pick_sanitized_lumi(user, "Choose your character's mutant #1 color:", "Character Preference","#"+features["mcolor"])
					if(new_mutantcolor)

						features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()

				if("mutant_color2")
					var/new_mutantcolor = color_pick_sanitized_lumi(user, "Choose your character's mutant #2 color:", "Character Preference","#"+features["mcolor2"])
					if(new_mutantcolor)
						features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()

				if("mutant_color3")
					var/new_mutantcolor = color_pick_sanitized_lumi(user, "Choose your character's mutant #3 color:", "Character Preference","#"+features["mcolor3"])
					if(new_mutantcolor)
						features["mcolor3"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()
				
				if("char_accent")
					var/selectedaccent = input(user, "Choose your character's accent:", "Character Preference") as null|anything in GLOB.character_accents
					if(selectedaccent)
						char_accent = selectedaccent

/*
				if("color_ethereal")
					var/new_etherealcolor = input(user, "Choose your ethereal color", "Character Preference") as null|anything in GLOB.color_list_ethereal
					if(new_etherealcolor)
						features["ethcolor"] = GLOB.color_list_ethereal[new_etherealcolor]

				if("legs")
					var/new_legs
					new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs
*/
				if("s_tone")
					var/listy = pref_species.get_skin_list()
					var/new_s_tone = input(user, "Choose your character's skin tone:", "Sun")  as null|anything in listy
					if(new_s_tone)
						skin_tone = listy[new_s_tone]
						try_update_mutant_colors()

				if("charflaw")
					var/selectedflaw
					selectedflaw = input(user, "Choose your character's flaw:", "Character Preference") as null|anything in GLOB.character_flaws
					if(selectedflaw)
						charflaw = GLOB.character_flaws[selectedflaw]
						charflaw = new charflaw()
						if(charflaw.desc)
							to_chat(user, span_info("[charflaw.desc]"))

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = new_ooccolor

				if("asaycolor")
					var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
					if(new_asaycolor)
						asaycolor = new_asaycolor

				if("bag")
					var/new_backpack = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack

				if("suit")
					if(jumpsuit_style == PREF_SUIT)
						jumpsuit_style = PREF_SUIT
					else
						jumpsuit_style = PREF_SUIT

				if("uplink_loc")
					var/new_loc = input(user, "Choose your character's traitor uplink spawn location:", "Character Preference") as null|anything in GLOB.uplink_spawn_loc_list
					if(new_loc)
						uplink_spawn_loc = new_loc

				if("ai_core_icon")
					var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens
					if(ai_core_icon)
						preferred_ai_core_display = ai_core_icon

				if("sec_dept")
					var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
					if(department)
						prefered_security_department = department

				if ("preferred_map")
					var/maplist = list()
					var/default = "Default"
					if (config.defaultmap)
						default += " ([config.defaultmap.map_name])"
					for (var/M in config.maplist)
						var/datum/map_config/VM = config.maplist[M]
						if(!VM.votable)
							continue
						var/friendlyname = "[VM.map_name] "
						if (VM.voteweight <= 0)
							friendlyname += " (disabled)"
						maplist[friendlyname] = VM.map_name
					maplist[default] = null
					var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
					if (pickedmap)
						preferred_map = maplist[pickedmap]

				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = synced with server tick rate (currently:[world.fps]))", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = desiredfps
						parent.fps = desiredfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = "Rogue"
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor

				if("phobia")
					var/phobiaType = input(user, "What are you scared of?", "Character Preference", phobia) as null|anything in SStraumas.phobia_types
					if(phobiaType)
						phobia = phobiaType

		else
			switch(href_list["preference"])
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)
				if("gender")
					var/pickedGender = "male"
					if(gender == "male")
						pickedGender = "female"
					if(pickedGender && pickedGender != gender)
						gender = pickedGender
						ResetJobs()
						to_chat(user, "<font color='red'>Classes reset.</font>")
						random_character(gender)
				if("domhand")
					if(domhand == 1)
						domhand = 2
					else
						domhand = 1
				if("bespecial")
					if(next_special_trait)
						print_special_text(user, next_special_trait)
						return
					to_chat(user, span_boldwarning("You will become special for one round, this could be something negative, positive or neutral and could have a high impact on your character and your experience."))
					var/result = alert(user, "You'll receive a unique trait for one round\nDo I really want become special?", "Be Special", "Yes", "No")
					if(result != "Yes")
						return
					if(next_special_trait)
						return
					next_special_trait = roll_random_special(user.client)
					if(next_special_trait)
						log_game("SPECIALS: Rolled [next_special_trait] for ckey: [user.ckey]")
						print_special_text(user, next_special_trait)
						user.playsound_local(user, 'sound/misc/alert.ogg', 100)
						to_chat(user, span_warning("This will be applied on your next game join. You cannot reroll this, and it will not carry over to other rounds"))
						to_chat(user, span_warning("You may switch your character and choose any role, if you don't meet the requirements (if any are specified) it won't be applied"))

				if("family")
					// REDMOON ADD START - family_changes - оповещение о правилах семей
					if(usr?.client?.prefs?.be_russian)
						to_chat(usr, span_warning("<hr>\
						<b>Обязательные условия для семей:</b>\
						<br>● Герцог, консорт и наследники - одна семья. \
						<br>● Дворяне не могут иметь пару из нижнего сословья и наоборот. \
						<br><b>Если не выставлена душа второй половинки, то:</b> \
						<br>● Бандиты, проститутки, заключенные, рабы, гоблины, бездомные и лунатики не могут сформировать семью. \
						<br>● Молодой и старый персонажи не могут быть парой."))
					else
						to_chat(usr, span_warning("<hr>\
						<b>Mandatory rules for families:</b>\
						<br>● Baron, Consort and heirs are in one family. \
						<br>● You cannot be noble and have your spouse in lower class. \
						<br><b>If you will not setup Spouse Soul, then:</b> \
						<br>● Bandits, whores, prisoners, slaves, goblins, beggers and lunatics cannot form up families. \
						<br>● You cannot have too much of age difference (adult with old)."))
					// REDMOON ADD END
					if(family == FAMILY_NONE)
						family = FAMILY_FULL
					else
						family = FAMILY_NONE
				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_ENABLED]  input.text-color = #EEEEEE")
					else
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_DISABLED]  input.text-color = #ad9eb4")

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					var/old_key = href_list["old_key"]
					CaptureKeybinding(user, kb, old_key)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user, 3)
						return

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						save_preferences()
						ShowChoices(user, 3)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					key_bindings[full_key] += list(kb_name)
					key_bindings[full_key] = sortList(key_bindings[full_key])

					user << browse(null, "window=capturekeypress")
					user.client.update_movement_keys()
					save_preferences()

				if("keybindings_reset")
					var/choice = tgalert(user, "Do you really want to reset your keybindings?", "Setup keybindings", "Do It", "Cancel")
					if(choice == "Cancel")
						ShowChoices(user,3)
						return
					hotkeys = (choice == "Do It")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					user.client.update_movement_keys()
				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_dead_chat")
					user.client.deadchat()
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD
				if("toggle_deadmin_security")
					toggles ^= DEADMIN_POSITION_SECURITY
				if("toggle_deadmin_silicon")
					toggles ^= DEADMIN_POSITION_SILICON


				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent && parent.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_above) in parent.screen
						PM.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.change_view(CONFIG_GET(string/default_view))

				if("be_defiant")
					defiant = !defiant
					if(defiant)
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Теперь вы будете сопротивляться людям, нарушающим ваши права, но будете наказаны за попытку нарушить права других." + " " + span_boldwarning("(Режим COMBAT отключит ERP-взаимодействие. Обход этого режима является нарушением. Используйте AHELP, если необходимо.)")))
						else
							to_chat(user, span_notice("You will now have resistance from people violating you, but be punished for trying to violate others." + " " + span_boldwarning("(COMBAT Mode will disable ERP interactions. Bypassing this is a bannable offense, AHELP if necessary.)")))
					else
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_boldwarning("Вы полностью погружаетесь в мрачное сосуществование с миром, отказываясь от сопротивления людей, насилующих вас, но позволяя делать то же самое с другими людьми, не являющимися девиантами."))
						else
							to_chat(user, span_boldwarning("You fully immerse yourself in the dark coexistence with the world, refusing to resist people who abuse you, but allowing them to do the same to others who are not deviants."))

				if("be_russian")
					be_russian = !be_russian
					if(be_russian)
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Вы Русский. Поздравляю."))
						else
							to_chat(user, span_notice("You have enabled Russian and it is under development."))
					else
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Выписан из Русских. Не поздравляю."))
						else
							to_chat(user, span_boldwarning("You have disable Russian and it is still under development."))

				// REDMOON ADD START - family_changes
				if("detailed_family")
					detailed_family_loging = !detailed_family_loging
					if(detailed_family_loging)
						to_chat(user, user.client.prefs?.be_russian ? span_notice("Детальная Семья включена. Вы будете получать подробные сообщения при попытке формирования семьи. Эта функция нужна для демонстрации работы подбора партнёра.") : span_notice("Detailed family log turned on."))

				// disable_stress_indicator
				if("stress_indicator")
					redmoon_toggles ^= STRESS_EFFECTS
					if(redmoon_toggles & STRESS_EFFECTS)
						to_chat(user, span_notice("Индикатор стресса отключён. Вы не будете получать звуковое оповещение и иконку над персонажем, когда у него портится настроение (кроме критического падения морали)."))
				// REDMOON ADD END

				if("be_virgin")
					virginity = !virginity
					if(virginity)
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Вы ни разу не поддавались искушениям плоти.")) 
						else
							to_chat(user, span_notice("You have not once indulged in the temptations of the flesh."))
					else
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Вы не девственны. Одним словом - трахались до этого моментума."))
						else
							to_chat(user, span_notice("You have. In a word. Fucked before.")) //Someone word this better please kitty is high and words are hard

				if("schizo_voice")
					toggles ^= SCHIZO_VOICE
					if(toggles & SCHIZO_VOICE)
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, "<span class='warning'>Вы теперь Голос.\n\
										Как голос, вы будете получать размышления от игроков, спрашивающих об игровых механиках!\n\
										Хорошие голоса будут вознаграждены PQ за ответы на медитации, а плохие - наказаны по усмотрению Карен.</span>")
						else
							to_chat(user, "<span class='warning'>You are now a voice.\n\
										As a voice, you will receive meditations from players asking about game mechanics!\n\
										Good voices will be rewarded with PQ for answering meditations, while bad ones are punished at the discretion of jannies.</span>")
					else
						if(usr?.client?.prefs?.be_russian)
							to_chat(user, span_notice("Вы больше не являетесь голосом."))
						else
							to_chat(user, span_warning("You are no longer a voice."))

				if("migrants")
					migrant.show_ui()
					return
				
				if("manifest")
					parent.view_actors_manifest()
					return

				if("finished")
					user << browse(null, "window=latechoices") //closes late choices window
					user << browse(null, "window=playersetup") //closes the player setup window
					user << browse(null, "window=preferences") //closes job selection
					user << browse(null, "window=mob_occupation")
					user << browse(null, "window=latechoices") //closes late job selection
					user << browse(null, "window=migration") // Closes migrant menu

					SStriumphs.remove_triumph_buy_menu(user.client)

					winshow(user, "preferencess_window", FALSE)
					user << browse(null, "window=preferences_browser")
					user << browse(null, "window=lobby_window")
					return

				if("barkpreview")
					if(SSticker.current_state == GAME_STATE_STARTUP) //Timers don't tick at all during game startup, so let's just give an error message
						to_chat(user, "<span class='warning'>Bark previews can't play during initialization!</span>")
						return
					if(!COOLDOWN_FINISHED(src, bark_previewing))
						return
					if(!parent || !parent.mob)
						return
					COOLDOWN_START(src, bark_previewing, (5 SECONDS))
					var/atom/movable/barkbox = new(get_turf(parent.mob))
					barkbox.set_bark(bark_id)
					var/total_delay
					for(var/i in 1 to (round((32 / bark_speed)) + 1))
						addtimer(CALLBACK(barkbox, TYPE_PROC_REF(/atom/movable, bark), list(parent.mob), 7, 70, BARK_DO_VARY(bark_pitch, bark_variance)), total_delay)
						total_delay += rand(DS2TICKS(bark_speed/4), DS2TICKS(bark_speed/4) + DS2TICKS(bark_speed/4)) TICKS
					QDEL_IN(barkbox, total_delay)

				if("save")
					save_preferences()
					save_character()

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					var/list/choices = list()
					if(path)
						var/savefile/S = new /savefile(path)
						if(S)
							for(var/i=1, i<=max_save_slots, i++)
								var/name
								S.cd = "/character[i]"
								S["real_name"] >> name
								if(!name)
									name = "Slot[i]"
								choices[name] = i
					var/choice = input(user, "CHOOSE A HERO","ROGUETOWN") as null|anything in choices
					if(choice)
						choice = choices[choice]
						if(!load_character(choice))
							random_character()
							save_character()

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])

				// REDMOON ADD START - family_changes - оповещение о правилах семей
				if("rumors")
					if(usr?.client?.prefs?.be_russian)
						to_chat(user, span_warning("<hr>Слухи не имеют механического влияния на персонажа."))
					else
						to_chat(user, span_warning("<hr>Rumors have no mechanical power over the character."))	
					use_rumors = !use_rumors
				// REDMOON ADD END
	ShowChoices(user)
	return 1



/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	if(randomise[RANDOM_SPECIES] && !character_setup)
		random_species()

	if((randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	// Bandaid to undo no arm flaw prosthesis
	if(charflaw)
		var/obj/item/bodypart/O = character.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = character.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		character.regenerate_limb(BODY_ZONE_R_ARM)
		character.regenerate_limb(BODY_ZONE_L_ARM)

	if(roundstart_checks)
		if(!(pref_species.name in GLOB.roundstart_races))
			set_new_race(new /datum/species/human/northern)
		else if(parent && pref_species.patreon_req > parent.patreonlevel())
			set_new_race(new /datum/species/human/northern)

	character.age = age
	character.dna.features = features.Copy()
	character.gender = gender
	character.body_type = body_type
	character.set_species(pref_species.type, icon_update = FALSE, pref_load = src)

	if((randomise[RANDOM_NAME] || randomise[RANDOM_NAME_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && ((pref_species.id == "human") || (pref_species.id == "humen")))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	if(real_name in GLOB.chosen_names)
		character.real_name = pref_species.random_name(gender)
	else
		character.real_name = real_name
	character.name = character.real_name

	character.domhand = domhand

	character.eye_color = eye_color
	character.voice_color = voice_color
	character.voice_pitch = voice_pitch
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color
	character.skin_tone = skin_tone
	character.hairstyle = hairstyle
	character.facial_hairstyle = facial_hairstyle
	//character.underwear = underwear
//	character.underwear_color = underwear_color
	character.undershirt = undershirt
	character.socks = socks
	character.set_patron(selected_patron)
	character.backpack = backpack
	character.defiant = defiant
	character.voice_type = voice_type
	character.virginity = virginity

	character.jumpsuit_style = jumpsuit_style

	if(charflaw)

		character.charflaw = new charflaw.type()
		character.charflaw.on_mob_creation(character)

	character.dna.real_name = character.real_name

	character.headshot_link = headshot_link
	character.nudeshot_link = nudeshot_link
	
	character.flavortext = flavortext
	character.flavortext_display = flavortext_display
	character.flavortext_nsfw = flavortext_nsfw_display
	character.flavortext_nsfw_display = flavortext_nsfw_display
	character.ooc_notes = ooc_notes
	character.ooc_notes_display = ooc_notes_display

	character.set_bark(bark_id)
	character.vocal_speed = bark_speed
	character.vocal_pitch = bark_pitch
	character.vocal_pitch_range = bark_variance

	if(parent)
		var/list/L = get_player_curses(parent.ckey)
		if(L)
			for(var/X in L)
				ADD_TRAIT(character, curse2trait(X), TRAIT_GENERIC)

		apply_trait_bans(character, parent.ckey)
		if(is_misc_banned(parent.ckey, BAN_MISC_LEPROSY))
			ADD_TRAIT(character, TRAIT_LEPROSY, TRAIT_BAN_PUNISHMENT)
		if(is_misc_banned(parent.ckey, BAN_MISC_PUNISHMENT_CURSE))
			ADD_TRAIT(character, TRAIT_PUNISHMENT_CURSE, TRAIT_BAN_PUNISHMENT)

	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts(redraw = TRUE)
	
	character.char_accent = char_accent

	redmoon_copy_character(character, icon_updates, roundstart_checks, character_setup, antagonist) // REDMOON ADD - family_changes - наши функции внутри

/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("human")
			return random_unique_name()
		if("ai")
			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
		if("clown")
			return pick(GLOB.clown_names)
		if("mime")
			return pick(GLOB.mime_names)
		if("religion")
			return DEFAULT_RELIGION
		if("deity")
			return DEFAULT_DEITY
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z,[namedata["allow_numbers"] ? ",0-9," : ""] -, ' and .</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/datum/preferences/proc/try_update_mutant_colors()
	if(update_mutant_colors)
		reset_body_marking_colors()
		reset_all_customizer_accessory_colors()

/proc/valid_headshot_link(mob/user, value, silent = FALSE)
	var/static/link_regex = regex("i.gyazo.com|a.l3n.co|b.l3n.co|c.l3n.co|images2.imgbox.com|thumbs2.imgbox.com|files.catbox.moe") //gyazo, discord, lensdump, imgbox, catbox
	var/static/list/valid_extensions = list("jpg", "png", "jpeg") // Regex works fine, if you know how it works

	if(!length(value))
		return FALSE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		if(!silent)
			to_chat(user, "<span class='warning'>Your link must be https!</span>")
		return FALSE

	if(!findtext(value, "."))
		if(!silent)
			to_chat(user, "<span class='warning'>Invalid link!</span>")
		return FALSE
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		if(!silent)
			to_chat(usr, "<span class='warning'>The image must be one of the following extensions: '[english_list(valid_extensions)]'</span>")
		return FALSE

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		if(!silent)
			to_chat(usr, "<span class='warning'>The image must be hosted on one of the following sites: 'Gyazo, Lensdump, Imgbox, Catbox'</span>")
		return FALSE
	return TRUE

/datum/preferences/proc/is_active_migrant()
	if(!migrant)
		return FALSE
	if(!migrant.active)
		return FALSE
	return TRUE

/datum/preferences/proc/allowed_respawn()
	if(!has_spawned)
		return TRUE
	if(is_misc_banned(parent.ckey, BAN_MISC_RESPAWN))
		return FALSE
	return TRUE

/datum/preferences/proc/AdditionalSettings(mob/user)
	var/list/dat = list()

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=additional_settings;task=close'>Done</a></center><br>"

	dat += "<b>Set Hand: <a href='?_src_=prefs;preference=additional_settings;task=set_hand'>[hand_ckey ? hand_ckey : "(Anyone)"]</a></b>"

	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "additional_settings", "<div align='center'>Additional Settings</div>", 250, 300) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
