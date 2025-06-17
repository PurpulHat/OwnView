class_name Node_Tools


static var check_list = []
static var check_number = {}
static var menu_parent_node = null
static var json_data = null

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
