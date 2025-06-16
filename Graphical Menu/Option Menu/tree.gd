extends Tree

var dir_path = str(OS.get_executable_path().get_base_dir(),"/Input Saved/")
var item_path = null
var dir = DirAccess.open(dir_path)

func _ready():
	create_item().set_text(0, "Your saved inputs:")
	if dir:
		for file_name in dir.get_files():
			create_item().set_text(0, file_name)

func load_data(file):
	var data = JSON.parse_string(FileAccess.get_file_as_string(file))
	return data

func _on_item_selected() -> void:
	var item = get_selected()
	item_path = (str(dir_path,item.get_text(0)))
	$"../TextEdit".text = load_data(item_path)["description"]

func _load_data(data):
	load_data(item_path)[data]

func _on_use_selected_pressed() -> void:
	var data = load_data(item_path)
	GlobalSignal.emit_signal("api_request", data)
	print(load_data(item_path)["url"],load_data(item_path)["headers"])
	$"../..".queue_free()
