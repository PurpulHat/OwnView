extends Button


func _on_pressed() -> void:
	match %GraphEdit.minimap_enabled:
		true:
			%GraphEdit.minimap_enabled = false
		false:
			%GraphEdit.minimap_enabled = true
