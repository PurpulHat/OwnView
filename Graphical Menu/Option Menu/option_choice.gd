extends Window

var OptionCreation_node = load("res://Graphical Menu/Option Menu/OptionCreation.tscn")
var OptionCreation: Window

func _ready() -> void:
	self.popup_centered()

func _on_close_requested() -> void:
	queue_free()

func _on_new_request_pressed() -> void:
	if OptionCreation:
		OptionCreation.queue_free()
	var OptionCreation = OptionCreation_node.instantiate()
	add_child(OptionCreation)
	OptionCreation.popup_centered()
