extends Button

func _on_pressed() -> void:
	match Node_Tools.check_bool:
		true:
			Node_Tools.check_bool = false
			icon = load("res://Img/duplicate-false.svg") as Texture2D
			text = "Deny Duplicate"

		false:
			Node_Tools.check_bool = true
			icon = load("res://Img/duplicate-true.svg") as Texture2D
			text = "Allow Duplicate"
