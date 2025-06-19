class_name Search_Input


static func save_api_search(name, description, url, headers, body, method) -> bool:
	print("[*] Save search process")

	var json_data = {
		"name": str(name),
		"description": str(description),
		"url": str(url),
		"method": str(method),
		"headers": headers,
		"body": body
		}

	if headers is not Array:
		print("Not a Array in Headers")
		return false

	if str_to_var(body) is not Dictionary:
		print("Not a Dictionary in Body")
		return false

	var json_string = JSON.stringify(json_data, "\t")

	var save_path = str(OS.get_executable_path().get_base_dir(),"/Input Saved/",name,".json")

	if not DirAccess.dir_exists_absolute(str(OS.get_executable_path().get_base_dir(),"/Input Saved")):
		DirAccess.make_dir_recursive_absolute(str(OS.get_executable_path().get_base_dir(),"/Input Saved"))

	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if not file:
		push_error("Erreur d'ouverture du fichier: %s (Code: %d)" % [
			FileAccess.get_open_error(),
			FileAccess.get_open_error()
		])
		return false

	file.store_string(json_string)
	file.close()

	print("Saved on ", save_path)
	return true
