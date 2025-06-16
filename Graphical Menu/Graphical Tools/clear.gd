extends Button

func _on_pressed() -> void:
	for child in $"../../GraphEdit".get_children():
		if child is GraphNode: 
			remove_child(child)
			child.queue_free()
