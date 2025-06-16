class_name Request

static var json_file = null
static var fson_path = null
static var response = "Failed"


static func POST(self_node, url, headers, body, value):
	if not url or not headers:
		return false

	var http_request = HTTPRequest.new()
	self_node.add_child(http_request)
	
	# Prepare and send request
	if value:
		body = body.replace("FUZZ", value)
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
		print(type_string(typeof(response_data)))
		Node_Tools.json_data = response_data
		return response_data
	else:
		push_error("Failed to parse JSON")
		return null
