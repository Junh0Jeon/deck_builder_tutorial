extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer


func _ready() -> void:
	color_rect.color.a = 0.0
	Events.player_hit.connect(_on_player_hit)
	timer.timeout.connect(_on_timer_timeout)


func _on_player_hit() -> void:
	Debug.debug("on player hit fn etd")
	color_rect.color.a = 0.5
	timer.start()


func _on_timer_timeout() -> void:
	Debug.debug("on timer timeout fn etd")
	color_rect.color.a = 0.0
