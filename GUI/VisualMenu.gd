extends Popup


func _ready():
	var dof = $VBoxContainer/CenterContainer/GridContainer/DOF_Check
	var reflections = $VBoxContainer/CenterContainer/GridContainer/ReflectionsCheck
	var fog = $VBoxContainer/CenterContainer/GridContainer/FogCheck
	var particles = $VBoxContainer/CenterContainer/GridContainer/ParticlesCheck
	var far_sight = $VBoxContainer/CenterContainer/GridContainer/FarSightCheck
	
	dof.pressed = SaveGame.save_data["dof"]
	reflections.pressed = SaveGame.save_data["reflections"]
	fog.pressed = SaveGame.save_data["fog"]
	particles.pressed = SaveGame.save_data["particles"]
	far_sight.pressed = SaveGame.save_data["far_sight"]


func _on_DOF_Check_toggled(button_pressed):
	get_tree().call_group("Cameras", "dof", button_pressed)


func _on_ReflectionsCheck_toggled(button_pressed):
	get_tree().call_group("Cameras", "reflections", button_pressed)


func _on_FogCheck_toggled(button_pressed):
	get_tree().call_group("Cameras", "fog", button_pressed)


func _on_ParticlesCheck_toggled(button_pressed):
	get_tree().call_group("Particles", "manage_particles", button_pressed)


func _on_FarSightCheck_toggled(button_pressed):
	get_tree().call_group("Cameras", "far_sight", button_pressed)


func _on_DoneButton_pressed():
	hide()










