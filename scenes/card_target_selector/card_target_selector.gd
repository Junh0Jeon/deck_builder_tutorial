extends Node2D

const ARC_PONITS := 8

@onready var area_2d: Area2D = $Area2D
@onready var card_arc: Line2D = $CanvasLayer/CardArc

var current_card: CardUI
var is_targeting := false


func _ready() -> void:
	Events.card_aim_started.connect(_on_card_aim_started)
	Events.card_aim_ended.connect(_on_card_aim_ended)


func _process(_delta: float) -> void:
	if not is_targeting:
		return
	
	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()


func _get_points() -> Array:
	var points := []
	var start_point := current_card.global_position
	start_point.x += (current_card.size.x / 2)
	var end_point := get_local_mouse_position()
	var distance_vector := (end_point - start_point)
	
	for i in range(ARC_PONITS):
		var t := (1.0 / ARC_PONITS) * i
		var x := start_point.x + (distance_vector.x / ARC_PONITS) * i
		var y := start_point.y + ease_out_cubic(t) * distance_vector.y
		points.append(Vector2(x, y))
	
	points.append(end_point)
	
	return points


func ease_out_cubic(number: float) -> float:
	return 1.0 - pow(1.0 - number, 3.0)


func _on_card_aim_started(card: CardUI) -> void:
	if not card.card.is_single_targeted():
		return
	
	is_targeting = true
	area_2d.monitoring = true
	area_2d.monitorable = true
	current_card = card


func _on_card_aim_ended(_card: CardUI) -> void:
	is_targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitoring = false
	area_2d.monitorable = false
	current_card = null


func _on_selector_enemy_entered(enemy: Area2D) -> void:
	if not current_card or not is_targeting:
		return
	
	if not current_card.targets.has(enemy):
		current_card.targets.append(enemy)
		print("enemy(%s) selected" % enemy)
		
		for target in current_card.targets:
			print("target : %s" % target)


func _on_selector_enemy_exited(enemy: Area2D) -> void:
	if not current_card or not is_targeting:
		return
	
	current_card.targets.erase(enemy)
	print("enemy(%s) deselected" % enemy)
