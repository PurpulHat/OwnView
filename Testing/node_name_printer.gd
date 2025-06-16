class_name NodeNamePrinter  # Définit un nom global

# Émetteur
signal function_requested(func_to_call: Callable, callback: Callable)

func send_function():
	var my_function = func():
		return "Hey"
	
	function_requested.emit(my_function, _on_result_received)

func _on_result_received(result):
	print("Résultat reçu: ", result)
