/*
 	Miauw's big Say() rewrite.
	This file has the basic atom/movable level speech procs.
	And the base of the send_speech() proc, which is the core of saycode.
*/
GLOBAL_LIST_INIT(freqtospan, list(
	"[FREQ_SCIENCE]" = "sciradio",
	"[FREQ_MEDICAL]" = "medradio",
	"[FREQ_ENGINEERING]" = "engradio",
	"[FREQ_SUPPLY]" = "suppradio",
	"[FREQ_SERVICE]" = "servradio",
	"[FREQ_SECURITY]" = "secradio",
	"[FREQ_COMMAND]" = "comradio",
	"[FREQ_AI_PRIVATE]" = "aiprivradio",
	"[FREQ_SYNDICATE]" = "syndradio",
	"[FREQ_CENTCOM]" = "centcomradio",
	"[FREQ_CTF_RED]" = "redteamradio",
	"[FREQ_CTF_BLUE]" = "blueteamradio"
	))

/atom/movable/proc/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	send_speech(message, 7, src, , spans, message_language=language)

/atom/movable/proc/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)

/atom/movable/proc/can_speak()
	return TRUE

/atom/movable/proc/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language = null, message_mode, original_message)
	var/rendered = compose_message(src, message_language, message, , spans, message_mode)
	var/list/hearers = get_hearers_in_view(range, source)
	for(var/_AM in hearers)
		var/atom/movable/AM = _AM
		AM.Hear(rendered, src, message_language, message, , spans, message_mode, original_message)

	if(SEND_SIGNAL(src, COMSIG_MOVABLE_QUEUE_BARK, hearers, args) || vocal_bark || vocal_bark_id)
		for(var/mob/M in hearers)
			if(!M.client)
				continue
			// if(!(M.client.prefs.toggles & SOUND_BARK))
			// 	hearers -= M
		var/barks = min(round((LAZYLEN(message) / vocal_speed)) + 1, BARK_MAX_BARKS)
		var/total_delay
		vocal_current_bark = world.time //this is juuuuust random enough to reliably be unique every time send_speech() is called, in most scenarios
		for(var/i in 1 to barks)
			if(total_delay > BARK_MAX_TIME)
				break
			addtimer(CALLBACK(src, PROC_REF(bark), hearers, range, vocal_volume, BARK_DO_VARY(vocal_pitch, vocal_pitch_range), vocal_current_bark), total_delay)
			total_delay += rand(DS2TICKS(vocal_speed / BARK_SPEED_BASELINE), DS2TICKS(vocal_speed / BARK_SPEED_BASELINE) + DS2TICKS(vocal_speed / BARK_SPEED_BASELINE)) TICKS

/atom/movable/proc/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, face_name = FALSE)
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/spanpart1 = "<span class='[radio_freq ? get_radio_span(radio_freq) : "say"]'>"
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	//Speaker name
	var/namepart = "[speaker.GetVoice()]"
	if(speaker.get_alt_name())
		namepart = "[speaker.get_alt_name()]"
	var/colorpart = "<span style='text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	if(ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		if(face_name)
			namepart = "[H.get_face_name()]" //So "fake" speaking like in hallucinations does not give the speaker away if disguised
		if(H.voice_color)
			colorpart = "<span style='color:#[H.voice_color];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	if(speaker.voicecolor_override)
		colorpart = "<span style='color:#[speaker.voicecolor_override];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	//End name span.
	var/endspanpart = "</span></span>"

	var/message_colour = null
	if (ishuman(src) && ishuman(speaker))
		var/mob/living/carbon/human/recipient = src
		var/mob/living/carbon/human/sender = speaker
		if (recipient.mind)
			message_colour = recipient.mind.get_special_person_colour(sender)

	//Message
	var/messagepart = " <span class='message'>[lang_treat(speaker, message_language, raw_message, spans, message_mode, FALSE, message_colour)]</span></span>"

	var/arrowpart = ""

	if(istype(src,/mob/living))
		var/turf/speakturf = get_turf(speaker)
		var/turf/sourceturf = get_turf(src)
		if(istype(speakturf) && istype(sourceturf) && !(speakturf in get_hear(7, sourceturf)))
			switch(angle2dir(Get_Angle(src, speaker)))
				if(NORTH)
					arrowpart = " ⇑"
				if(SOUTH)
					arrowpart = " ⇓"
				if(EAST)
					arrowpart = " ⇒"
				if(WEST)
					arrowpart = " ⇐"
				if(NORTHWEST)
					arrowpart = " ⇖"
				if(NORTHEAST)
					arrowpart = " ⇗"
				if(SOUTHWEST)
					arrowpart = " ⇙"
				if(SOUTHEAST)
					arrowpart = " ⇘"
			// REDMOON ADD START - multi-Z_fix - портировано с Azure-Peak
			if(speakturf.z > sourceturf.z)
				arrowpart += " ⇈"
			if(speakturf.z < sourceturf.z)
				arrowpart += " ⇊"
			// REDMOON ADD END
			if(istype(speaker, /mob/living))
				var/mob/living/L = speaker
				namepart = "Unknown [(L.gender == FEMALE) ? "Woman" : "Man"]"
			else
				namepart = "Unknown"
			spanpart1 = "<span class='smallyell'>"

	var/languageicon = ""
	var/datum/language/D = GLOB.language_datum_instances[message_language]
	if(istype(D) && D.display_icon(src))
		// REDMOON ADD START - languages-in-chat-fix - исправляем отображение русских языков в чате
		var/image/r_icon = image(D.icon, icon_state = D.icon_state) 
		languageicon =  "\icon[r_icon]&nbsp;" // WAS: languageicon = "[D.get_icon()] "
		// REDMOON ADD END

	return "[spanpart1][spanpart2][colorpart][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][compose_job(speaker, message_language, raw_message, radio_freq)][arrowpart][endspanpart][messagepart]"

/atom/movable/proc/compose_track_href(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/say_mod(input, message_mode)
	var/ending = copytext_char(input, length_char(input))
	if(copytext_char(input, length_char(input) - 1) == "!!")
		return verb_yell
	else if(ending == "?")
		return verb_ask
	else if(ending == "!")
		return verb_exclaim
	else
		return verb_say

/atom/movable/proc/say_quote(input, list/spans=list(speech_span), message_mode, message_colour = null)
	if(!input)
		input = "..."

	if(copytext_char(input, length_char(input) - 1) == "!!")
		spans |= SPAN_YELL

	input = parsemarkdown_basic(input, limited = TRUE, barebones = TRUE)

	var/spanned = attach_spans(input, spans, message_colour)
	if(isliving(src))
		var/mob/living/L = src
		if(L.cmode)
			return "— \"[spanned]\""
	return "[say_mod(input, message_mode)], \"[spanned]\""

/atom/movable/proc/quoteless_say_quote(input, list/spans = list(speech_span), message_mode)
	input = parsemarkdown_basic(input, limited = TRUE, barebones = TRUE)
	var/pos = findtext_char(input, "*")
	return pos? copytext_char(input, pos + 1) : input

/atom/movable/proc/check_language_hear(language)
	return FALSE

/atom/movable/proc/lang_treat(atom/movable/speaker, datum/language/language, raw_message, list/spans, message_mode, no_quote = FALSE, message_colour = null)
	if(has_language(language) || check_language_hear(language))
		var/atom/movable/AM = speaker.GetSource()
		if(AM) //Basically means "if the speaker is virtual"
			return no_quote ? AM.quoteless_say_quote(raw_message, spans, message_mode) : AM.say_quote(raw_message, spans, message_mode, message_colour)
		else
			return no_quote ? speaker.quoteless_say_quote(raw_message, spans, message_mode) : speaker.say_quote(raw_message, spans, message_mode, message_colour)
	else if(language)
		var/atom/movable/AM = speaker.GetSource()
		var/datum/language/D = GLOB.language_datum_instances[language]
		raw_message = D.scramble(raw_message)
		if(AM)
			return no_quote ? AM.quoteless_say_quote(raw_message, spans, message_mode) : AM.say_quote(raw_message, spans, message_mode, message_colour)
		else
			return no_quote ? speaker.quoteless_say_quote(raw_message, spans, message_mode) : speaker.say_quote(raw_message, spans, message_mode, message_colour)
	else
		return "makes a strange sound."

/proc/get_radio_span(freq)
	var/returntext = GLOB.freqtospan["[freq]"]
	if(returntext)
		return returntext
	return "radio"

/proc/get_radio_name(freq)
	return freq
	var/returntext = GLOB.reverseradiochannels["[freq]"]
	if(returntext)
		return returntext
	return "[copytext_char("[freq]", 1, 4)].[copytext_char("[freq]", 4, 5)]"

/proc/attach_spans(input, list/spans)
	return "[message_spans_start(spans)][input]</span>"

/proc/message_spans_start(list/spans)
	var/output = "<span class='"
	for(var/S in spans)
		output = "[output][S] "
	output = "[output]'>"
	return output

/proc/say_test(text)
	var/ending = copytext_char(text, length_char(text))
	if (ending == "?")
		return "1"
	if (ending == "!")
		return "2"
	return "0"

/atom/movable/proc/GetVoice()
	return "[src]"	//Returns the atom's name, prepended with 'The' if it's not a proper noun

/atom/movable/proc/IsVocal()
	return 1

/atom/movable/proc/get_alt_name()

//HACKY VIRTUALSPEAKER STUFF BEYOND THIS POINT
//these exist mostly to deal with the AIs hrefs and job stuff.

/atom/movable/proc/GetJob() //Get a job, you lazy butte

/atom/movable/proc/GetSource()

/atom/movable/proc/GetRadio()

//VIRTUALSPEAKERS
/atom/movable/virtualspeaker
	var/job
	var/atom/movable/source
	var/obj/item/radio/radio

INITIALIZE_IMMEDIATE(/atom/movable/virtualspeaker)
/atom/movable/virtualspeaker/Initialize(mapload, atom/movable/M, radio)
	. = ..()
	radio = radio
	source = M
	if (istype(M))
		name = M.GetVoice()
		verb_say = M.verb_say
		verb_ask = M.verb_ask
		verb_exclaim = M.verb_exclaim
		verb_yell = M.verb_yell

	// The mob's job identity
	if(ishuman(M))
		// Humans use their job as seen on the crew manifest. This is so the AI
		// can know their job even if they don't carry an ID.
		var/datum/data/record/findjob = find_record("name", name, GLOB.data_core.general)
		if(findjob)
			job = findjob.fields["rank"]
		else
			job = "Unknown"
	else if(iscarbon(M))  // Carbon nonhuman
		job = "No ID"
	else if(isobj(M))  // Cold, emotionless machines
		job = "Machine"
	else  // Unidentifiable mob
		job = "Unknown"

/atom/movable/virtualspeaker/GetJob()
	return job

/atom/movable/virtualspeaker/GetSource()
	return source

