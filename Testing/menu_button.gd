extends MenuButton

func _ready():
	# Créer un menu popup avec des items
	var menu = get_popup()
	menu.clear()
	menu.add_item("Premier bouton", 1)
	menu.add_item("Deuxième bouton", 2)
	menu.add_item("Troisième bouton", 3)
	
	# Connecter le signal 'id_pressed' du menu
	menu.id_pressed.connect(_on_menu_item_selected)


func _on_menu_item_selected(id):
	if id == 2:  # L'ID du deuxième bouton
		print("Vous avez cliqué sur le deuxième bouton!")
