extends GraphEdit

const Menu_Right_Click = preload("res://right_click.tscn")
var Graph_Node = load("res://Node/GraphNode.tscn")
var node_instance = Graph_Node.instantiate()


func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	connect_node(from_node, from_port, to_node, to_port)

const SAVE_FILE_PATH = "user://graph_save.json"




func save_graph_to_json():
	var graph_data = {
		"nodes": []
	}
	
	# Parcourir tous les enfants qui sont des GraphNodes
	for child in get_children():
		if child is GraphNode:
			var node_data = {
				"name": child.name,
				"title": child.title,
				"position": {
					"x": child.position_offset.x,
					"y": child.position_offset.y
				},
				"content": {}
			}
			
			for content_child in child.get_children():
				if content_child is MenuButton:
					print(content_child.text)
					if content_child.text != "Options":
						node_data["content"][content_child.text] = {}
						node_data["content"][content_child.text]["aligment"] = content_child.alignment
						node_data["content"][content_child.text]["modulate"] = content_child.modulate
		
			graph_data["nodes"].append(node_data)


	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify(graph_data))
		print("[-] Graph Saved ")
		file.close()
		print
	else:
		printerr("File Access Error : ", FileAccess.get_open_error())




func load_graph_from_json():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)

	if file != null:  
		var graph_saved = JSON.parse_string(file.get_as_text())  
		file.close()

		for child in get_children():
			if child is GraphNode:
				child.queue_free()

		for node_data in graph_saved["nodes"]:
			var node = Graph_Node.instantiate()
			node.name = node_data["name"]
			node.title = node_data["title"]
			node.position_offset = Vector2(node_data["position"]["x"], node_data["position"]["y"])

			if node_data["content"].has("value"):
				var value = MenuButton.new()
				value.text = node_data["content"]["value"]
				node.add_child(value)
			add_child(node)

		print("Graph chargé avec succès depuis ", SAVE_FILE_PATH)
	else:
		printerr("Erreur lors de l'ouverture du fichier pour chargement")


#func _input(event):
#	# Detect where and click mouse and spawn Right Click Menu where mouse is 
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
#			Right_Click._Click_On_Graphical()
#			print("Test")


func _on_save_pressed() -> void:
	save_graph_to_json()


func _on_load_pressed() -> void:
	load_graph_from_json()
