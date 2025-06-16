class_name Sanitize

static func _for_name(raw_name):
	if raw_name is not String:
		return raw_name
	var regex = RegEx.new()
	regex.compile("[@:\\\"\\\\/?*`|<>.:]")
	return regex.sub(raw_name, "_", true)
