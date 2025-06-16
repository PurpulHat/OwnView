extends Button

# Note : For OptionCreation : Create a new entry in .Self for add a body

func _on_pressed() -> void:
	# Duplicate Body Node
	$"..".add_child($"../Body_HBoxContainer".duplicate())
	# Move [+ Add Body]
	$"..".move_child($".", -1)
