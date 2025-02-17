/// Фикс для статов и навыков после смерти. Связанный код искать по "after_death_stats_fix"


/mob/living
	/// Используются для возврата к изначальным статам
	var/ROUNDSTART_STASTR = 10
	var/ROUNDSTART_STAPER = 10
	var/ROUNDSTART_STAINT = 10
	var/ROUNDSTART_STACON = 10
	var/ROUNDSTART_STAEND = 10
	var/ROUNDSTART_STASPD = 10
	var/ROUNDSTART_STALUC = 10

/datum/mind
/// У Зомби для навыков используется текущий Mind. Если игрок с mind не уходит в преисподнюю, генеря новый mind, то его навыки удаляются. Говнокод в плане статов.
/// Чтобы избваиться от этих списков, я не придумал ничего лучше, кроме как полностью переписывать поиск зомби в коде (что нужно делать на основу).
	var/list/backup_known_skills = list() 
	var/list/backup_skill_experience = list()

/mob/living/roll_stats()
	. = ..()
	ROUNDSTART_STASTR = STASTR
	ROUNDSTART_STAPER = STAPER
	ROUNDSTART_STAINT = STAINT
	ROUNDSTART_STACON = STACON
	ROUNDSTART_STAEND = STAEND
	ROUNDSTART_STASPD = STASPD
	ROUNDSTART_STALUC = STALUC

	BUFSTR = 0
	BUFPER = 0
	BUFINT = 0
	BUFCON = 0
	BUFEND = 0
	BUFSPE = 0
	BUFLUC = 0

/mob/living/proc/recalculate_stats()
/// Проклятое. Написано так, чтобы не нужно было переписывать код change_stat. 
/// Нужно добавлять везде, где фигурирует воскрешение, т.к. в противном случае, учитываются значения дебафов, которые были ПРИ смерти и ПОСЛЕ смерти.
	for(var/stat in MOBSTATS)
		change_stat(stat, 1)
		change_stat(stat, -1)
