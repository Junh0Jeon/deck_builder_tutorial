extends EnemyAction

@export var damage := 4


func perform_action() -> void:
	if not enemy or not target:
		push_error("not enemy or not target")
		return
	
	var tween:= create_tween().set_trans(Tween.TRANS_QUINT)
	var start_pos = enemy.global_position
	var end_pos := target.global_position + Vector2.RIGHT * 32 # magic number
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	damage_effect.sound = sound
	
	tween.tween_property(enemy, "global_position", end_pos, 0.4) # magic number
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.35) # magic number
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25) # magic number
	tween.tween_property(enemy, "global_position", start_pos, 0.4) # magic number
	
	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
