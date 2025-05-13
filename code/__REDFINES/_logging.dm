
/proc/log_looc(text) // looc_addition
	if (CONFIG_GET(flag/log_looc))
		WRITE_LOG(GLOB.world_game_log, "\[[logtime]] LOOC: [text]")
