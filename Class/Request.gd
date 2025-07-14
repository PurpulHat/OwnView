class_name Request

static var json_file = null
static var fson_path = null
static var response = "Failed"


static func _REQUEST_METHOD(self_node, url, headers, body, method, value):
	for child in self_node.get_children():
		if child is HTTPRequest:
			child.queue_free()
	
	Node_Tools.unix_time = Time.get_unix_time_from_system()
	Node_Tools.reset_state()
	
	match method:
		"POST":
			return await POST(self_node, url, headers, body, value)
		"GET":
			return await GET(self_node, url, headers, value)
		_:
			return "Error : Method not supported or missing"

static func POST(self_node, url, headers, body, value):
	if not url or not headers:
		return false

	var http_request = HTTPRequest.new()
	self_node.add_child(http_request)
	
	# Prepare and send request
	if value and "FUZZ" in body: body = body.replace("FUZZ", value)
	if value and "FUZZ" in url: url = url.replace("FUZZ", value)
	if value and "FUZZ" in headers: headers = headers.replace("FUZZ", value)
		
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		return null
	
	# Wait for the request to complete
	var result = await http_request.request_completed
	
	# Process the response
	var response_code = result[1]
	var response_headers = result[2]
	var response_body = result[3]
	
	var json = JSON.new()
	var parse_result = json.parse(response_body.get_string_from_utf8())
	
	if parse_result == OK:
		var response_data = json.get_data()
		Node_Tools.json_data = response
		Node_Tools.json_data = response_data
		return response_data
	else:
		push_error("Failed to parse JSON")
		return null




static func GET(self_node, url, headers, value):
	if not url or not headers:
		return false

	var http_request = HTTPRequest.new()
	self_node.add_child(http_request)
	
	# Prepare URL with query parameters if value is provided
	var request_url = url
	if value and "FUZZ" in request_url: request_url = request_url.replace("FUZZ", value)
	if value and "FUZZ" in headers: headers = headers.replace("FUZZ", value)
	if headers == [""]: headers = ["accept: application/json"]
	
	# Send GET request
	var error = http_request.request(request_url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		return null
	# Wait for the request to complete
	var result = await http_request.request_completed

	# Process the response
	var response_code = result[1]
	var response_headers = result[2]
	var response_body = result[3]
	
	var json = JSON.new()
	var parse_result = json.parse(response_body.get_string_from_utf8())


	if parse_result == OK:
		var response_data = json.get_data()
		Node_Tools.json_data = response
		Node_Tools.json_data = response_data
		return response_data

	else:
		push_error("Failed to parse JSON")
		return null
