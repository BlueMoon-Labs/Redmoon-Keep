// Для поиска связанного, использовать "rumors_addition"

/datum/preferences
	var/use_rumors = FALSE

	var/rumors_prefered_behavior_with_problems = null
	var/rumors_prefered_behavior_in_combat = null
	var/rumors_prefered_behavior_in_work = null

	var/list/rumors_secret = list()
	var/list/rumors_prefered_beginnings = list()
	var/list/rumors_prefered_races = list() // добавить оборотней
	var/list/rumors_prefered_behavior_in_bed = list()
	var/list/rumors_prefered_ways_to_relax = list()

/mob/living/carbon/human
	var/use_rumors = FALSE

	var/rumors_prefered_behavior_with_problems = null
	var/rumors_prefered_behavior_in_combat = null
	var/rumors_prefered_behavior_in_work = null

	var/list/rumors_secret = list()
	var/list/rumors_prefered_beginnings = list()
	var/list/rumors_prefered_races = list() // добавить оборотней
	var/list/rumors_prefered_behavior_in_bed = list()
	var/list/rumors_prefered_ways_to_relax = list()

GLOBAL_LIST_INIT(rumors_prefered_behavior_in_bed_choices, list(
	"быть грубым с партнёром",
	"чтобы партнёр был груб",
	"нежность с партнёром",
	"нежность от партнёра"))

GLOBAL_LIST_INIT(rumors_prefered_behavior_with_problems_choices, list( //todo
	"долго думая перед тем, как действовать",
	"сначала думая, потом действуя",
	"чаще действуя, чем думая",
	"самым быстрым и простым путём"))

GLOBAL_LIST_INIT(rumors_prefered_behavior_in_combat_choices, list( //
	"сдастся, если не будет помощи",
	"не сдастся, пока есть перевес в силе",
	"будет драться, если есть хороший шанс на победу",
	"будет драться, пока руки держат меч",
	"неистово сражается до встречи с Нок"))

GLOBAL_LIST_INIT(rumors_prefered_behavior_in_work_choices, list( //
	"погружается с головой",
	"чаще работает, чем отдыхать",
	"заканчивает важную работу перед отдыхом",
	"стремится поровну отдыхать и работать",
	"сначала отдыхает и лишь потом работает",
	"замечается редко, за то, часто отдыхает",
	"отвлекается, отдыхает, уклоняется и ненадёжен"))

GLOBAL_LIST_INIT(rumors_secret_choices, list( //todo
	"bed",
	"fencing",
	"species",
	"work",
	"combat",
	"problems",
	"relax"))

GLOBAL_LIST_INIT(rumors_prefered_ways_to_relax_choices, list(
	"проводить время в таверне",
	"заниматься охотой",
	"собирать травы",
	"молиться",
	"работать",
	"заниматься подработкой",
	"за рыбалкой",
	"болтать о мелочах",
	"общаться о сложном",
	"филосовствовать",
	"витать в собственных мыслях",
	"читать книги",
	"изобретать или заниматься наукой",
	"проводить ночь в борделе",
	"читать в библиотеке",
	"слушать лекции",
	"вышивать",
	"плавать",
	"сплетничать",
	"бить бездомных",
	"заниматься развитием тела",
	"истязать свою плоть",
	"заниматься благотворительностью",
	"принимать участие в приключениях",
	"проводить время на природе",
	"провоцировать другие расы"))
