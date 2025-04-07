extends EnemyAction

@export var block := 6


func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	block_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect( # 0.6 <- wait to not so fast def between enemy1 and enemy2 TODO: magicNumber
		func():
			Events.enemy_action_completed.emit(enemy)
	)
