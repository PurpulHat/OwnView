extends LineEdit



func _allow():
	$"../Save".disabled = false
	$".".add_theme_color_override("font_color", Color("#58ca40"))



func _on_focus_exited() -> void:
	$".".text = $".".text.to_upper()

	match $".".text:
		"GET":
			_allow()

			# Body Input
			$"../HeadersScrollContainer2".visible = false
	
		"POST":
			_allow()
			
			# Body Input
			$"../HeadersScrollContainer2".visible = true
			
		_:
			# Body Input
			$"../HeadersScrollContainer2".visible = true
			$".".add_theme_color_override("font_color", Color("#ca4040"))
			$"../Save".disabled = true
