extends Node


## Return Tween.
## You can use return value to synchronize Tween animation and code.
func shake(thing: Node2D, strength: float, duration: float = .2) -> Tween:
	if not thing:
		return null
	
	var original_pos := thing.position
	var shake_count := 10
	var tween := create_tween()
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) # magic number
		var target := original_pos + strength * shake_offset
		if i % 2 == 0:
			target = original_pos
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75 # magic number
	
	tween.finished.connect(func():
		thing.position = original_pos
		)
	return tween
