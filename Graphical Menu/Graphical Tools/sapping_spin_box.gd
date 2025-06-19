extends SpinBox

func _on_value_changed(value: float) -> void:
	$"../../../../../GraphEdit".snapping_distance = $".".value
