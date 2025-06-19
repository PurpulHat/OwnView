extends Button


func _on_pressed() -> void:
	match $"../../../../../GraphEdit".snapping_enabled:
		true:
			$"../SappingSpinBox".editable = false
			$"../../../../../GraphEdit".snapping_enabled = false
		false:
			$"../SappingSpinBox".editable = true
			$"../../../../../GraphEdit".snapping_enabled = true
