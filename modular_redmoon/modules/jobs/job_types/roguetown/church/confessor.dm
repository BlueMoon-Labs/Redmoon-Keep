/datum/job/roguetown/shepherd
	ru_title = "Исповедник"
	ru_f_title = "Исповедница"
	ru_tutorial = "Теневые агенты церкви, нанятые для шпионажа за населением и поддержания его морали. \
	Как самые фанатичные представители духовенства, они в первую очередь помогают местному инквизитору в его работе. \
	Будь то выбивание признаний в грехах или охота на ночных зверей и культистов, которые прячутся у всех на виду."

/datum/outfit/job/roguetown/shepherd/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		ADD_TRAIT(H, TRAIT_INQUISITION, TRAIT_GENERIC)
