extends Popup

func _ready():
	$VBoxContainer/MasterVolumeSlider.value = SaveGame.save_data["master_volume"]
	$VBoxContainer/SoundVolumeSlider.value = SaveGame.save_data["sfx_volume"]
	$VBoxContainer/MusicVolumeSlider.value = SaveGame.save_data["music_volume"]

func _on_DoneButton_pressed():
	hide()


func _on_MasterVolumeSlider_value_changed(value):
	VolumeControl.update_master_volume(value)


func _on_SoundVolumeSlider2_value_changed(value):
	VolumeControl.update_sfx_volume(value)


func _on_MusicVolumeSlider3_value_changed(value):
	VolumeControl.update_music_volume(value)
