extends Camera

const MAX_CAMERA_ANGLE = 90


var East_West_line
var North_South_line

export (NodePath) var follow_this_path = null

export var target_distance = 10.0
export var target_hieght = 1.0

var follow_this = null
var last_lookat

func _ready():
	make_neighboorhoods()
	set_as_toplevel(true)
	environment = load(Network.enviroment)
	follow_this = get_node(follow_this_path)
	last_lookat = follow_this.global_transform.origin
	check_saved_settings()


func _physics_process(delta):
	if East_West_line != null:
		manage_Bus_levels()
	
	var delta_v = global_transform.origin - follow_this.global_transform.origin
	var target_pos = global_transform.origin
	
	delta_v.y = 0
	
	if delta_v.length() > target_distance:
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_hieght
		target_pos = follow_this.global_transform.origin + delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_hieght
	
	global_transform.origin = global_transform.origin.linear_interpolate(target_pos, 1)
	last_lookat = last_lookat.linear_interpolate(follow_this.global_transform.origin, 1)
	
	look_at(last_lookat, Vector3(0,1,0))


func make_neighboorhoods():
	East_West_line = (Network.city_size.x*20) / 2
	North_South_line = (Network.city_size.y*20) / 2


func manage_Bus_levels():
	var n1 = global_transform.origin.x < East_West_line and global_transform.origin.z < North_South_line
	var n2 = global_transform.origin.x < East_West_line and global_transform.origin.z > North_South_line
	var n3 = global_transform.origin.x > East_West_line and global_transform.origin.z < North_South_line
	var n4 = global_transform.origin.x > East_West_line and global_transform.origin.z > North_South_line
	var neighboorhood = {3:n1, 4:n2, 5:n3, 6:n4}
	
	for i in range(3,7):
		AudioServer.set_bus_mute(i, !neighboorhood[i])


func update_speed(speed):
	fov = 70 + speed
	fov = min(fov, MAX_CAMERA_ANGLE)


func check_saved_settings():
	if SaveGame.save_data["far_sight"]:
		far = 750
	else:
		far = 250
	environment.dof_blur_far_enabled = SaveGame.save_data["dof"]
	environment.ss_reflections_enabled = SaveGame.save_data["reflections"]
	environment.fog_enabled = SaveGame.save_data["fog"]


func far_sight(value):
	if value:
		far = 750
	else:
		far = 250
	SaveGame.save_data["far_sight"] = value
	SaveGame.save_game()


func dof(value):
	environment.dof_blur_far_enabled = value
	SaveGame.save_data["dof"] = value
	SaveGame.save_game()


func reflections(value):
	environment.ss_reflections_enabled = value
	SaveGame.save_data["reflections"] = value
	SaveGame.save_game()


func fog(value):
	environment.fog_enabled = value
	SaveGame.save_data["fog"] = value
	SaveGame.save_game()









