extends Node

var check_parent = {}

var Graph_Node = load("res://Node/GraphNode.tscn")
var node_instance = Graph_Node.instantiate()
var input_scene = preload("res://Node/User_Input/Input.tscn")
var input_instance = input_scene.instantiate()

var grand_mother_less_unix = null


func _ready() -> void:
	GlobalSignal.input_triggered.connect(
		func(_on_InputClosed): 
			Node_Tools._insert_value($".", %GraphEdit, Node_Tools.menu_parent_node, _on_InputClosed, Node_Tools.menu_parent_node.name))

	GlobalSignal.json_output.connect(
		func(json_output):
			get_value_key(json_output))



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

	Node_Tools.grand_mother = str(mother,Node_Tools.unix_time)
	grand_mother_less_unix = mother




func create_or_add(mother, value, key):
	Node_Tools.a += 1
	var mother_less_unix = mother
	mother = str(mother,Node_Tools.unix_time)

	# Verify if NOT a Node with the same name exist
	if not %GraphEdit.has_node(str(Sanitize._for_name(mother))):
		var node_instance = Graph_Node.instantiate()
		node_instance.set_meta("new", true)
		node_instance.name = str(mother)
		node_instance.title = Node_Tools.search_point + " : " + str(mother_less_unix)
		%GraphEdit.add_child(node_instance)
		node_instance.set_meta("mother", str(mother,Node_Tools.unix_time))

		var Separator = HSeparator.new()
		var title = MenuButton.new()

		Node_Tools.option_button(node_instance)

		if Node_Tools.grand_mother == "Master":
			title.text = Node_Tools.grand_mother
			Node_Tools.master = Node_Tools.grand_mother
		else:
			title.text = str("Child of : ") + str(grand_mother_less_unix)

		title.modulate = Color(0.8, 0.8, 0.8)

		node_instance.add_child(title)
		node_instance.add_child(Separator)

		# Create Label for your key
		if Node_Tools.check_label_key != key:
			# Verify if key's name don't already exist
			Node_Tools._insert_key($".", %GraphEdit, node_instance, key, mother)

		# Create Label for your value
		var menu_value = MenuButton.new()
		

		if Node_Tools.grand_mother_verif == Node_Tools.grand_mother:
			%GraphEdit.connect_node(Sanitize._for_name(Node_Tools.grand_mother), 0, Sanitize._for_name(mother), 0)
		else:
			%GraphEdit.connect_node(Node_Tools.search_node_name, Node_Tools.search_node_index-1, Sanitize._for_name(mother), 0)

		Node_Tools.grand_mother_verif = mother
		# Connect the nodes
		await get_tree().create_timer(0.1).timeout
		await Node_Tools.clean_arrange_node(%GraphEdit)

	else:
		# If a Node with the same name exist, it's add label on it
		var node_instance = %GraphEdit.get_node(str(Sanitize._for_name(mother)))
		# Create Label for your key
		if Node_Tools.check_label_key != key:
			# Verify if key's name don't already exist
			Node_Tools._insert_key($".", %GraphEdit, node_instance, key, mother)

		# Create Label for your value
		Node_Tools._insert_value($".", %GraphEdit,node_instance, value, mother)
