/datum/job/roguetown/archivist/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		name = "Архивариус"
		tutorial = "Архивариусы тщательно сохраняют и организуют древние тексты, сохраняя коллективные знания рода для будущих поколений. \
		Нобли и крестьяне часто обращаются к архивариусам за помощью в вопросах истории и фактов. \
		Сделайте хорошее использование этого и управляйте маленькой академией в этом городе, зарабатывая деньги за продажу ваших знаний, а также зелий."
	