class_name Enemy
extends Area2D

const ARROW_OFFSET := 5

@export var enemy_stats: EnemyStats: set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var stats_ui: StatsUI = $StatsUI

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction: set = set_current_action


func set_enemy_stats(value: EnemyStats) -> void:
	enemy_stats = value.create_instance()
	
	if not enemy_stats.stats_changed.is_connected(update_stats):
		enemy_stats.stats_changed.connect(update_stats)
		enemy_stats.stats_changed.connect(update_action)
	
	update_enemy()


func set_current_action(value: EnemyAction) -> void:
	current_action = value


func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
	
	var new_action_picker: EnemyActionPicker = enemy_stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.actor_enemy = self


func update_action() -> void:
	if not enemy_action_picker:
		return
	
	# action이 할당된게 없다면, action 할당.
	if not current_action:
		current_action = enemy_action_picker.get_action()
		return
	
	# 현재 action이 할당된 상태에서, stats_changed의 emit으로 인해 다시 reload될 경우 여기 도착.
	# 외부 자극이 mob의 act에 영향을 주는 mechanism으로 구성된 mob action 기작임.
	# StS의 경우 mob의 action이 외부 자극에 영향을 받는게 아니라 이런 mechanism은 아닐것임.
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action
	


func update_stats() -> void:
	stats_ui.update_stats(enemy_stats)


func update_enemy() -> void:
	if not enemy_stats is Stats:
		return
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = enemy_stats.art
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET)
	setup_ai()
	update_stats()


func do_turn() -> void:
	enemy_stats.block = 0
	
	if not current_action:
		return
	
	current_action.perform_action()


func take_damage(damage: int) -> void:
	if enemy_stats.health <= 0:
		return
	
	enemy_stats.take_damage(damage)
	
	if enemy_stats.health <= 0: # enemy die process
		queue_free()


func _on_area_entered(_area: Area2D) -> void:
	arrow.show()


func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
