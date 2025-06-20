class_name Node_Tools


static var check_list = []
static var check_number = {}
static var menu_parent_node = null
static var json_data = null
static var Graph_Node = load("res://Node/GraphNode.tscn")
static var Option_Choice_Node = load("res://Graphical Menu/Option Menu/OptionChoice.tscn")
static var grand_mother_count = 0
static var grand_mother = "Master"

static var master = null
static var check_label_key = null 
static var grand_mother_verif = null
static var search_node_index = null
static var search_node_name = null
static var search_point = null
static var a = -1

static func check_same_name(check, check_list = check_list):
	if not check in check_number:
		check_number[check] = 0

	# If name key is in a dict = key's name already exist
	if check in check_list:
		check_number[check] += 1
		check = str(check) + str("(") + str(check_number[check]) +str(")")

	return check 



# Add "Option" button when, used when a new node need to be created.
static func option_button(node):
		var menu_option = MenuButton.new()
		menu_option.text = "Options"
		var popup_menu = menu_option.get_popup()
		popup_menu.add_item("+ Add Input")
		popup_menu.add_item("- Delete Node")

		node.add_child(menu_option)
		popup_menu.id_pressed.connect(func(id): 
			match id:
				0: # New node
					var input_scene = preload("res://Node/User_Input/Input.tscn")
					var input_instance = input_scene.instantiate()
					GlobalSignal.emit_signal("editor_state_changed", menu_option.get_parent())
					node.add_child(input_instance)
					menu_parent_node = menu_option.get_parent()

				1: # Delete Node
					menu_option.get_parent().queue_free()
		)



# Insert option choice on Key and Value menu button
static func _insert_option(node, graph_node, button, value, mother):
	var menu_option = button.get_popup()
	var child_mother_node = graph_node.get_node(str(mother))
	var child_node = child_mother_node.get_node(str(Sanitize._for_name(value)))
	
	if child_node:
		menu_option.add_item(str("New node from \"",value,"\""))
		menu_option.add_item(str("New search from \"",value,"\""))
		menu_option.add_item("Delet Link")
	
	menu_option.id_pressed.connect(func(id): 
		match id:
			0: # New node
				Node_Tools.create_new_input(node, graph_node, mother, value, child_node.get_index())

			1: # New search
				grand_mother = "Master"
				search_node_name = child_mother_node.name
				search_point = child_node.text
				search_node_index = child_node.get_index()

				var OptionChoice = Option_Choice_Node.instantiate()
				node.add_child(OptionChoice)
				OptionChoice.popup_centered()

				GlobalSignal.api_request.connect(func(api):
					await Request._REQUEST_METHOD(node, api["url"], api["headers"], api["body"], api["method"], value)
					#await get_value_key(Node_Tools.json_data, Node_Tools.check_same_name(child_node.name, Node_Tools.check_list))
					graph_node.connect_node(Sanitize._for_name(mother), child_node.get_index()-1, Sanitize._for_name(child_node.name) ,0)
				)
			2: #Delet Link
				pass
	)




static func _insert_value(node, graph_node, node_instance, value, mother):
	var menu_value = MenuButton.new()
	menu_value.text = str(value)
	menu_value.name = str(value)
	menu_value.alignment = HORIZONTAL_ALIGNMENT_LEFT
	node_instance.add_child(menu_value)
	menu_value.set_meta("slot_number", Node_Tools.a)
	
	_insert_option(node, graph_node, menu_value, value, mother)




static func _insert_key(node, graph_node,node_instance, key, mother):
	var menu_key = MenuButton.new()
	menu_key.text = str(key) + str(":")
	menu_key.name = str(key)
	menu_key.modulate = Color(0.8, 0.8, 0.8)
	node_instance.add_child(menu_key)
	check_label_key = key
	menu_key.set_meta("slot_number", a)
	
	_insert_option(node, graph_node, menu_key, key, mother)



static func create_new_input(node, graph_node, mother, value, index):
	var node_instance = Graph_Node.instantiate()
	Node_Tools.option_button(node_instance)
	node_instance.name = str("Input From: ", mother)
	node_instance.title = str("Input From: ", mother)
	graph_node.add_child(node_instance)
	
	var VSplit = VSplitContainer.new()
	var Separator = HSeparator.new()
	var title = MenuButton.new()
	title.text = str("User input")
	title.modulate = Color(0.8, 0.8, 0.8)
	node_instance.add_child(VSplit)
	VSplit.add_child(title)
	VSplit.add_child(Separator)
	
	graph_node.connect_node(mother, int(index-2), node_instance.get_name(),0)
	
	_insert_value(node, graph_node, node_instance, value, mother)
	graph_node.arrange_nodes()
