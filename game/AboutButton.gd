extends Button

func open_url(url):
	var command = ""
	if OS.get_name() == "Windows":
		command = "start " + url
	elif OS.get_name() == "OSX":
		command = "open " + url
	elif OS.get_name() == "X11":
		command = "xdg-open " + url
	else:
		print("Platform not supported.")
		return

	var result = OS.execute(command, [])
	if result != OK:
		print("Failed to open URL.")


func _on_button_down():
	var url = "http://example.com"
	open_url(url)
