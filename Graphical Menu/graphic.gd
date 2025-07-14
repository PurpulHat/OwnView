extends GraphEdit

const Menu_Right_Click = preload("res://right_click.tscn")
var Graph_Node = load("res://Node/GraphNode.tscn")
var node_instance = Graph_Node.instantiate()
var save_instance = load("res://Graphical Menu/Option Menu/OptionSave.tscn").instantiate() 
var load_instance = load("res://Graphical Menu/Option Menu/OptionLoad.tscn").instantiate() 


func _ready() -> void:
	GlobalSignal.saved.connect(
		func(path):
			save_graph_to_json(path))
	
	GlobalSignal.loaded.connect(
		func(path):
			load_graph_from_json(path))


func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	connect_node(from_node, from_port, to_node, to_port)


func save_graph_to_json(path):
	var graph_data = {
		"nodes": [],
		"connections": []
	}
	

	for child in get_children():
		if child is GraphNode:
			var node_data = {
				"name": child.name,
				"title": child.title,
				"mother": child.get_meta("mother"),
				"position": {
					"x": child.position_offset.x,
					"y": child.position_offset.y
				},
				"content": []
			}
			
			for conn in get_connection_list():
				var content_data = {
					"from_node": conn["from_node"],
					"from_port": conn["from_port"],
					"to_node": conn["to_node"],
					"to_port": conn["to_port"],
					}
			
				graph_data["connections"].append(content_data)

			for content_child in child.get_children():
				if content_child is MenuButton:
					if content_child.text != "Options":
						var content_data = {
						"text": content_child.text,
						"alignment": content_child.alignment,
						"visible": content_child.visible,
						"highlight": content_child.get_meta("highlight"),
						"modulate": [
							content_child.modulate.r,
							content_child.modulate.g,
							content_child.modulate.b,
							content_child.modulate.a
						]
					}
						node_data["content"].append(content_data)
						
				if content_child is HSeparator:
					var content_data = {
						"separator": true
						}
						
					node_data["content"].append(content_data)

			graph_data["nodes"].append(node_data)

	var file = FileAccess.open(path, FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify(graph_data))
		file.close()
	else:
		printerr("File Access Error : ", FileAccess.get_open_error())




func load_graph_from_json(path):
	var file = FileAccess.open(path, FileAccess.READ)

	if file != null:  
		var graph_saved = JSON.parse_string(file.get_as_text())  
		file.close()

		for child in %GraphEdit.get_children():
			if child is GraphNode:
				child.queue_free()

		for node_data in graph_saved["nodes"]:
			var node = Graph_Node.instantiate()
			node.name = node_data["name"]
			node.title = node_data["title"]
			if node_data["mother"]:
				node.set_meta("mother", node_data["mother"])
			else:
				node.set_meta("mother", node_data["name"])
			node.position_offset = Vector2(node_data["position"]["x"], node_data["position"]["y"])
			add_child(node)

			Node_Tools.option_button(node)

			if node_data["content"]:
				for content_data in node_data["content"]: 
					if content_data.has("separator") and content_data["separator"]:
						node.add_child(HSeparator.new())
					
					else:
						var button = MenuButton.new()
						button.text = content_data["text"]
						button.name = Sanitize._for_name(content_data["text"]) 
						button.alignment = content_data["alignment"]
						button.visible = content_data["visible"]
						if content_data["highlight"] == true:
							button.add_theme_color_override("font_color", Color(1, 1, 0))
							button.add_theme_color_override("font_hover_color", Color(0.8, 0.8, 0))
							button.set_meta("highlight", true)
							
						var mod = content_data["modulate"]
						button.modulate = Color(mod[0], mod[1], mod[2], mod[3])
						node.add_child(button)
						Node_Tools._insert_option(node, %GraphEdit, button, button.text, node_data["mother"])
				
				for content_data in graph_saved["connections"]:
					connect_node(content_data["from_node"], content_data["from_port"], content_data["to_node"], content_data["to_port"])
			
			add_child(node)

	else:
		printerr("Loading Error")




func _on_save_pressed() -> void:
	if get_node_or_null("res://Graphical Menu/Option Menu/OptionSave.tscn"):
		save_instance.queue_free()
	save_instance = load("res://Graphical Menu/Option Menu/OptionSave.tscn").instantiate() 
	add_child(save_instance)


func _on_load_pressed() -> void:
	if get_node_or_null("res://Graphical Menu/Option Menu/OptionLoad.tscn"):
		load_instance.queue_free()
	load_instance = load("res://Graphical Menu/Option Menu/OptionLoad.tscn").instantiate() 
	add_child(load_instance)
