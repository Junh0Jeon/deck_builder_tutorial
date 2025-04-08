# meta-name: Card
# meta-description: 카드 작동 방식, 사운드 등을 설계
extends Card

@export var optional_sound: AudioStream


func apply_effects(targets: Array[Node]) -> void:
	Debug.debug("Card [%s] has been played" % id)
	Debug.debug("Target:[%s]" % targets)
	
