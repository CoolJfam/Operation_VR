extends Camera

var East_West_line
var North_South_line

func _ready():
	make_neighboorhoods()


func _physics_process(delta):
	if East_West_line != null:
		manage_Bus_levels()


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
