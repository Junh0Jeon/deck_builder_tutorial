class_name Player
extends Node2D

const WHITE_SPRITE_MATERIAL := preload("res://art/white_sprite_material.tres")

@export var character_stats: CharacterStats: set = set_character_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI


func set_character_stats(value: CharacterStats) -> void:
	character_stats = value
	
	if not character_stats.stats_changed.is_connected(update_stats):
		character_stats.stats_changed.connect(update_stats)
		
	update_player()


func update_player() -> void:
	if not character_stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = character_stats.art
	update_stats()


func update_stats() -> void:
	stats_ui.update_stats(character_stats)


func take_damage(damage: int) -> void:
	if character_stats.health <= 0:
		return
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween := ObjectShaker.shake(self, 16, 0.15) # magic number
	character_stats.take_damage(damage)
	
	tween.finished.connect(
		func():
			sprite_2d.material = null
			
			if character_stats.health <= 0:
				Events.player_died.emit()
				queue_free()
	)
