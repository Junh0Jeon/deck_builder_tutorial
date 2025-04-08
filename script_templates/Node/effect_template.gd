# meta-name: Effect
# meta-description: 새로운 Effect 계열 설계
class_name _CLASS_
extends Effect

var member_var := 0


func execute(targets: Array[Node]) -> void:
	Debug.debug("Effect targets [%s]" % targets)
