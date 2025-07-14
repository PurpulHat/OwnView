extends FileDialog


func _on_file_selected(path: String) -> void:
	print("[+] File Load : ",path)
	GlobalSignal.loaded.emit(path)
