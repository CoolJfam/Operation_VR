extends Popup



func _on_QuitButton_pressed():
	get_tree().quit()


func _on_VideoButton_pressed():
	$VisualMenu.popup_centered()


func _on_AudioButton_pressed():
	$AudioMenu.popup_centered()


func _on_DoneButton_pressed():
	hide()
