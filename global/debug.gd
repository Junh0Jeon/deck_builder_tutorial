extends Node

#var DEBUG_MODE := OS.is_debug_build()
const DEBUG_MODE := true

func debug(message: String) -> void:
	if not DEBUG_MODE:
		return
	print(message)
