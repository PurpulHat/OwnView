extends Panel

var a = 0

var Menu_Right_Click_exist = false
const Graph_Node = preload("res://Node/GraphNode.tscn")
const Menu_Right_Click = preload("res://right_click.tscn")
var Menu_Right_Click_instance = null

# Get script from json_scan
var json_get = preload("res://Output/json_scan.gd")

func _on_button_pressed() -> void:
	var node_instance = Graph_Node.instantiate()
	a += 1
	node_instance.name = str(a)
	node_instance.title = "Input("+str(a)+")"
	node_instance.set_meta("mother", str(a))
	$GraphEdit.add_child(node_instance)
	Node_Tools.option_button(node_instance)
	


func _on_graph_edit_connection_to_empty(from_node: StringName, from_port: int, release_position: Vector2) -> void:
	print ("Hey")
