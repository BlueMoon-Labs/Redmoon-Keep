/datum/job/roguetown/goblinrabble/New()
	. = ..()
	if(usr?.client?.prefs?.be_russian)
		title = "Гоблин"
		tutorial = "Вы - самый низкий из низких. Гоблин среди многих других гоблинов. \
		Вам нечего сказать о себе, кроме того, что ваш Главный считает вас непригодным для службы."