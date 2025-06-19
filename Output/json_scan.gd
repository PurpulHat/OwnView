###
## Description :
## Information : Ugly as fuck, I really need to clean this mess.
###
extends Node

var check_parent = {}
var a = -1
var grand_mother_count = 0
var grand_mother = "Master"
var Graph_Node = load("res://Node/GraphNode.tscn")
var Option_Choice_Node = load("res://Graphical Menu/Option Menu/OptionChoice.tscn")
var node_instance = Graph_Node.instantiate()
var input_scene = preload("res://Node/User_Input/Input.tscn")
var input_instance = input_scene.instantiate()

var master = null
var check_label_key = null 
var grand_mother_verif = null
var search_node_index = null
var search_node_name = null
var search_point = null


func _ready() -> void:
	GlobalSignal.input_triggered.connect(
		func(_on_InputClosed): 
			_insert_value(Node_Tools.menu_parent_node, _on_InputClosed, Node_Tools.menu_parent_node.name))




# When "Add node from JSON" is pressed
func _on_pressed() -> void:
	get_value_key(Node_Tools.json_data)
	
	a += 1
	node_instance.name = str(a)
	node_instance.title = str(a)
	%GraphEdit.add_child(node_instance)




# Get Value and Key from JSON result
func get_value_key(json = Node_Tools.json_data, mother = "Master"):
	await get_tree().create_timer(0.1).timeout

	for get_key in json:
		var inside_key = json[get_key]

		if inside_key is Dictionary:
			Node_Tools.check_list.append(get_key)
			get_value_key(inside_key, Node_Tools.check_same_name(get_key, Node_Tools.check_list))

		elif inside_key is Array:
			for value in inside_key:
				if value is not String:
					Node_Tools.check_list.append(get_key)
					get_value_key(value, Node_Tools.check_same_name(get_key, Node_Tools.check_list))

				else:
					Node_Tools.check_list.append(get_key)
					create_or_add(mother, value, Node_Tools.check_same_name(get_key, Node_Tools.check_list))

		else:
			Node_Tools.check_list.append(get_key)
			create_or_add(mother, Node_Tools.check_same_name(inside_key, Node_Tools.check_list), get_key)

	grand_mother = mother




# Insert option choice on Key and Value menu button
func _insert_option(button, value, mother):
	var menu_option = button.get_popup()
	var child_mother_node = %GraphEdit.get_node(str(mother))
	var child_node = child_mother_node.get_node(str(Sanitize._for_name(value)))
	
	if child_node:
		menu_option.add_item(str("New node from \"",value,"\""))
		menu_option.add_item(str("New search from \"",value,"\""))
		menu_option.add_item("Delet Link")
	
	menu_option.id_pressed.connect(func(id): 
		match id:
			0: # New node
				create_new_input(mother, value, child_node.get_index())

			1: # New search
				grand_mother = "Master"
				search_node_name = child_mother_node.name
				search_point = child_node.text
				search_node_index = child_node.get_index()

				var OptionChoice = Option_Choice_Node.instantiate()
				add_child(OptionChoice)
				OptionChoice.popup_centered()

				GlobalSignal.api_request.connect(func(api):
					await Request._REQUEST_METHOD(self, api["url"], api["headers"], api["body"], api["method"], value)
					await get_value_key(Node_Tools.json_data, Node_Tools.check_same_name(child_node.name, Node_Tools.check_list))
					%GraphEdit.connect_node(Sanitize._for_name(mother), child_node.get_index()-1, Sanitize._for_name(child_node.name) ,0)
				)
			2: #Delet Link
				pass
	)




func _insert_value(node_instance, value, mother):
	var menu_value = MenuButton.new()
	menu_value.text = str(value)
	menu_value.name = str(value)
	menu_value.alignment = HORIZONTAL_ALIGNMENT_LEFT
	node_instance.add_child(menu_value)
	menu_value.set_meta("slot_number", a)
	
	_insert_option(menu_value, value, mother)




func _insert_key(node_instance, key, mother):
	var menu_key = MenuButton.new()
	menu_key.text = str(key) + str(":")
	menu_key.name = str(key)
	menu_key.modulate = Color(0.8, 0.8, 0.8)
	node_instance.add_child(menu_key)
	check_label_key = key
	menu_key.set_meta("slot_number", a)
	
	_insert_option(menu_key, key, mother)




func create_new_input(mother, value, index):
	var node_instance = Graph_Node.instantiate()
	Node_Tools.option_button(node_instance)
	node_instance.name = str("Input From: ", mother)
	node_instance.title = str("Input From: ", mother)
	%GraphEdit.add_child(node_instance)
	
	var VSplit = VSplitContainer.new()
	var Separator = HSeparator.new()
	var title = MenuButton.new()
	title.text = str("User input")
	title.modulate = Color(0.8, 0.8, 0.8)
	node_instance.add_child(VSplit)
	VSplit.add_child(title)
	VSplit.add_child(Separator)
	
	%GraphEdit.connect_node(mother, int(index-2), node_instance.get_name(),0)
	
	_insert_value(node_instance, value, mother)
	%GraphEdit.arrange_nodes()




func create_or_add(mother, value, key):
	a += 1
	# Verify if NOT a Node with the same name exist
	if not %GraphEdit.has_node(str(Sanitize._for_name(mother))):
		var node_instance = Graph_Node.instantiate()
		node_instance.name = str(mother)
		node_instance.title = search_point + " : " + str(mother)
		%GraphEdit.add_child(node_instance)

		var VSplit = VSplitContainer.new()
		var Separator = HSeparator.new()
		var title = MenuButton.new()

		Node_Tools.option_button(node_instance)

		if grand_mother == "Master":
			title.text = grand_mother
			grand_mother_count += 1
			grand_mother = grand_mother + "(" + str(grand_mother_count) + ")"
			master = grand_mother
		else:
			title.text = str("Child of : ") + str(grand_mother)

		title.modulate = Color(0.8, 0.8, 0.8)

		node_instance.add_child(VSplit)

		VSplit.add_child(title)
		VSplit.add_child(Separator)

		# Create Label for your key
		if check_label_key != key:
			# Verify if key's name don't already exist
			_insert_key(node_instance, key, mother)

		# Create Label for your value
		var menu_value = MenuButton.new()
		
		if grand_mother_verif == grand_mother:
			%GraphEdit.connect_node(Sanitize._for_name(grand_mother), 0, Sanitize._for_name(mother), 0)
		else:
			%GraphEdit.connect_node(search_node_name, search_node_index-1, Sanitize._for_name(mother), 0)

		grand_mother_verif = mother
		# Connect the nodes
		#$"../GraphEdit".connect_node(Sanitize._for_name(grand_mother), 0, Sanitize._for_name(mother), 0)
		await get_tree().create_timer(0.1).timeout
		%GraphEdit.arrange_nodes()

	else:
		# If a Node with the same name exist, it's add label on it
		var node_instance = %GraphEdit.get_node(str(Sanitize._for_name(mother)))

		# Create Label for your key
		if check_label_key != key:
			# Verify if key's name don't already exist
			_insert_key(node_instance, key, mother)

		# Create Label for your value
		_insert_value(node_instance, value, mother)
