extends Control

@onready var continue_button: Button = %Continue

func _ready() -> void:
	get_tree().paused = false # return battle_over_panel


func _on_continue_pressed() -> void:
	print("ctn run")


func _on_new_run_pressed() -> void:
	print("new run")


func _on_exit_pressed() -> void:
	get_tree().quit()
