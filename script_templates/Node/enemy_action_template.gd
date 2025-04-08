# meta-name: EnemyAction
# meta-description: 적의 행동 방식을 설계. enemy action ai의 하위노드에 부착됨.
extends EnemyAction


func perform_action() -> void:
	if not enemy or not target:
		push_error("not enemy or not target")
		return
	
	var tween:= create_tween().set_trans(Tween.TRANS_QUINT)
	var start_pos = enemy.global_position
	var end_pos := target.global_position + Vector2.RIGHT * 32 # magic number
	
	SFXPlayer.play(sound)
	
	tween.finished.connect(
		func() -> void:
			Events.enemy_action_completed.emit(enemy)
	)
