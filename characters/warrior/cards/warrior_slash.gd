extends Card


func apply_effects(targets: Array[Node]) -> void:
	Debug.debug("Card [%s] has been played" % id)
	var damage_effect := DamageEffect.new()
	damage_effect.sound = sound
	damage_effect.amount = 4
	damage_effect.execute(targets)	
	Debug.debug("Target:[%s]" % targets)
	
