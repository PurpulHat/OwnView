extends Button


func _on_pressed() -> void:
	match %GraphEdit.show_grid:
		true:
			%GraphEdit.show_grid = false
		false:
			%GraphEdit.show_grid = true
