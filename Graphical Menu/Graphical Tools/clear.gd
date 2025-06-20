extends Button


func _on_pressed() -> void:
	for child in %GraphEdit.get_children():
		if child is GraphNode:
			child.queue_free()
