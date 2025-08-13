extends Tree

var dir_path = str(OS.get_executable_path().get_base_dir(),"/Input Saved/")
var item_path = null
var dir = DirAccess.open(dir_path)

func _ready():
	var item = create_item()
	item.set_text(0, "Your saved inputs:")
	item.set_meta("folder", true)
	add_tree(null, dir_path)

func add_tree(parent: TreeItem, path: String) -> void:
	var dir = DirAccess.open(path)
	if not dir:
		printerr("Failed to open directory: ", path)
		return
	
	# Add files first
	for file_name in dir.get_files():
		var item = create_item(parent)
		item.set_meta("path", path.path_join(file_name))
		item.set_text(0, file_name)
	
	# Then add directories (with recursion)
	for dir_name in dir.get_directories():
		var item = create_item(parent)
		item.set_meta("path", path.path_join(dir_name))
		item.set_meta("folder", true)
		item.set_text(0, dir_name)
		
		var new_path = path.path_join(dir_name)
		add_tree(item, new_path)


func load_data(file):
	var data = JSON.parse_string(FileAccess.get_file_as_string(file))
	return data

func _on_item_selected() -> void:
	$"../Use selected".disabled = false
	var item = get_selected()
	item_path = (str(dir_path,item.get_text(0)))

	if item.get_meta("folder") == true:
		$"../Use selected".disabled = true
		$"../TextEdit".text = "Is a folder, cannot be used"
		return

	$"../TextEdit".text = load_data(item.get_meta("path"))["description"]

func _load_data(data):
	load_data(item_path)[data]

func _on_use_selected_pressed() -> void:
	var data = load_data(item_path)
	GlobalSignal.emit_signal("api_request", data)
	$"../..".queue_free()
