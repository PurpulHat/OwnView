extends Button

# Note : For OptionCreation : Create a new entry in .Self for add a header

func _on_pressed() -> void:
	# Duplicate Header Node
	$"..".add_child($"../Header_HBoxContainer".duplicate())
	# Move [+ Add Header]
	$"..".move_child($".", -1)
