extends Button

func _on_pressed() -> void:
	match $"../Panel".visible:
		true:
			$"../Panel".visible = false
			#$"../GraphEdit".show_menu = false
			$"../Panel/HBoxContainer/Add Node".visible = false
		false:
			$"../Panel".visible = true
			#$"../GraphEdit".show_menu = true
			$"../Panel/HBoxContainer/Add Node".visible = true
