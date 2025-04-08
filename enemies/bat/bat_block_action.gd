extends EnemyAction

@export var block_amount := 3

func perform_action() -> void:
	if not enemy or not target:
		push_error("not enemy or not target")
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block_amount
	block_effect.sound = sound
	block_effect.execute([enemy])
	await block_effect.block_effect_executed
	#block_effect.block_effect_executed.connect(
		#func() -> void:
			#Events.enemy_action_completed.emit(enemy)
	#)
	Events.enemy_action_completed.emit(enemy)
