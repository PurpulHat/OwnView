extends FileDialog


func _on_file_selected(path: String) -> void:
	print("[+] Saved on : ",path)
	GlobalSignal.saved.emit(path)
