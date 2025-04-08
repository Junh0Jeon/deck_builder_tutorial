class_name BlockEffect
extends Effect

signal block_effect_executed

var amount := 0


func execute(targets: Array[Node]) -> void:
	print("execute 실행됨")
	for target in targets:
		if not target:
			continue
		if target is Player:
			target.character_stats.block += amount
			SFXPlayer.play(sound)
		if target is Enemy:
			target.enemy_stats.block += amount
			SFXPlayer.play(sound)
	
	block_effect_executed.emit()
