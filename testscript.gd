extends Node

var child_count := 0
var elapsed_time := 0.0

func _ready():
	print("===== TEST STARTED =====")

func _process(delta):
	elapsed_time += delta
	if child_count < 5 and elapsed_time >= 2.0:
		func1()
		func2()
		elapsed_time = 0.0

func func1():
	var new_child = Node.new()
	new_child.name = "Child" + str(child_count + 1)  # Child1, Child2, ...
	add_child.call_deferred(new_child)
	print("func1 실행: 추가된 노드는 %s (총 %d번째 자식)" % [new_child.name, child_count + 1])
	child_count += 1

func func2():
	print("func2 실행: 현재 총 자식 수 = %d" % get_child_count())
