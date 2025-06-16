extends MenuButton

# Note : Can be deleted

"""
func _ready():
	var popup = get_popup()
	popup.connect("id_pressed", _on_item_selected)

	var menu_option = MenuButton.new()
	menu_option.text = "Options"
	var popup_menu = menu_option.get_popup()
	popup_menu.add_item("ABC")
	popup_menu.add_item("DEF")
	popup_menu.add_item("Delete Link")

	var parent_node = $"."
	parent_node.add_child(menu_option)

func _on_item_selected(id):
	match id:
		0: # Add search
			var menu_option = MenuButton.new()
			$"..".add_child(menu_option)
			var popup_menu = menu_option.get_popup()
			menu_option.text = "Options"
			popup_menu.add_item("ABC")
			popup_menu.add_item("DEF")
			popup_menu.add_item("Delet Link")

		1: # Delet this node
			get_parent_control().queue_free()
"""
