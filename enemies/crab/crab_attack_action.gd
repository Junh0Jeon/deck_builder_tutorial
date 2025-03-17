extends EnemyAction

@export var damage := 7


func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start_pos := enemy.global_position
	var end_pos := target.global_position + Vector2.RIGHT * 32 # TODO: magicNumber
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target] # this 'target' would be 'player'
	damage_effect.amount = damage
	
	tween.tween_property(enemy, "global_position", end_pos, 0.4) # TODO : magicNumber
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25) # TODO: magicNumber
	tween.tween_property(enemy, "global_position", start_pos, 0.4) # TODO: magicNumber
	
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
