extends Window

func _ready() -> void:
	var the_node = get_node("../Testing/node_name_printer.gd")
	var http_post = $HTTPRequest

func _headers_as_list():
	var headers_list = []
	
	for header_hbox in $Panel/HeadersScrollContainer/VBoxContainer.get_children():
		for header_child in header_hbox.get_children():
			if header_child.name == "Headers":
				headers_list.append(header_child.text)
	
	return headers_list

func _body_as_dict():
	var body_dict = {}
	var body_key = null
	var body_value = null

	for body_hbox in $Panel/HeadersScrollContainer2/VBoxContainer.get_children():
		for body_child in body_hbox.get_children():
			if body_child.name == "Key":
				body_key = body_child.text 
			if body_child.name == "Value":
				body_value = body_child.text
	
		body_dict[body_key] = body_value 
		
	return str(body_dict)

func _handle_function_request(func_to_call: Callable, callback: Callable):
	var result = func_to_call.call()
	print(callback.call(result))

func _on_button_pressed() -> void:
	print($Panel/Url.text)
	$Panel/Result.placeholder_text = "Request is sending, please wait..."
	var result = await Request._REQUEST_METHOD($".", $Panel/Url.text, _headers_as_list(), _body_as_dict(), $Panel/HTTP_Method.text ,null)
	print(result)
	$Panel/Result.placeholder_text = str(result)


func _on_save_pressed() -> void:
	print("Saved button")
	Search_Input.save_api_search($Panel/Name.text, $Panel/Description.text, $Panel/Url.text, _headers_as_list(), _body_as_dict(), $Panel/HTTP_Method.text)


func _on_close_pressed() -> void:
	queue_free()


func _on_close_requested() -> void:
	queue_free()
