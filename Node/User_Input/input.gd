extends Window

# When "Done" Button is pressed, it's will send the input
func _on_button_pressed() -> void:
	GlobalSignal.emit_signal("input_triggered", $Panel/LineEdit.text)
	queue_free()

func _on_close_requested() -> void:
	queue_free()
