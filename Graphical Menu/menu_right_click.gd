extends GraphEdit

var Menu_Right_Click = preload("res://right_click.tscn")




func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	connect_node(from_node, from_port, to_node, to_port)


#func _input(event):
#	# Detect where and click mouse and spawn Right Click Menu where mouse is 
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
#			Right_Click._Click_On_Graphical()
#			print("Test")
