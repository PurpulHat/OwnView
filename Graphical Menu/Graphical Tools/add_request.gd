extends Button

var OptionCreation_node = load("res://Graphical Menu/Option Menu/OptionCreation.tscn")
var OptionCreation: Window

func _on_pressed() -> void:
	if OptionCreation:
		OptionCreation.queue_free()
	var OptionCreation = OptionCreation_node.instantiate()
	add_child(OptionCreation)
	OptionCreation.popup_centered()
