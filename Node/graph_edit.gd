extends GraphEdit

var Graph_Node = preload("res://Node/GraphNode.tscn")
var a = 1

func _on_button_pressed() -> void:
	var node_instance = Graph_Node.instantiate()
