GLOBAL_LIST_EMPTY(backgrounds)

/datum/background
	/// Name of the background
	var/name 
	var/ru_name 
	/// Flavor description of the background (don't include stat totals in this, we'll render them automatically)
	var/desc
	var/ru_desc
	/// An associative list of only the stats we're altering. The value can also be a list to signify a range of values - maximum length of 2 for these.
	var/stat_array = list()

/datum/background/proc/apply_to_human(mob/living/carbon/human/recipient)
	if (recipient && recipient.mind)
		for (var/stat in stat_array)
			if (!islist(stat_array[stat]))
				var/value = stat_array[stat]
				recipient.change_stat(stat, value)
			else
				var/list/stat_range = stat_array[stat]
				recipient.change_stat(stat, rand(stat_range[1], stat_range[2]))
		return TRUE
	return FALSE

/datum/background/proc/description_string()
	return "[desc]<br> <i>[generate_modifier_string()]</i>"

/datum/background/proc/ru_description_string()
	return "[ru_desc]<br> <i>[generate_modifier_string()]</i>"

/datum/background/proc/generate_modifier_string()
	/// Generates a blurb string for use in preferences, programatically, based on our desc and stat alterations.
	var/result
	var/list/concat = list()
	for (var/stat in stat_array)
		if (!islist(stat_array[stat]))
			var/value = stat_array[stat]
			var/modifier = ""

			if (value >= 1)
				modifier = "+"

			var/statlabel = uppertext(copytext(stat, 1, 4))
			var/blockstring = "[modifier][value] [statlabel]"
			concat += blockstring
		else
			var/list/stat_range = stat_array[stat]
			var/list/chunk_string = list()
			for (var/sub_range in stat_range)
				var/modifier = ""
				if (sub_range >= 1)
					modifier = "+"

				chunk_string += "<b>[modifier][sub_range]</b>"

			var/statlabel = uppertext(copytext(stat, 1, 4))
			concat += "[chunk_string.Join(" to ")] [statlabel]"

	result = "([concat.Join(", ")])"
	return result
