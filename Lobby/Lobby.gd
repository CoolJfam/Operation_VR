extends CanvasLayer

onready var NameTextbox = $VBoxContainer/CenterContainer/GridContainer/NameTextbox
onready var port = $VBoxContainer/CenterContainer/GridContainer/PortTextbox
onready var selected_IP = $VBoxContainer/CenterContainer/GridContainer/IPTextbox

var is_cop = false
var city_size
var enviromennt = "res://Enviroments/Night.tres"

func _ready():
	NameTextbox.text = SaveGame.save_data["Player_name"]
	selected_IP.text = Network.DEFAULT_IP
	port.text = str(Network.DEFAULT_PORT)
	_on_CitySizePicker_item_selected(1)
	$VBoxContainer/CenterContainer/GridContainer/ColorPickerButton.color = SaveGame.save_data["local_paint_color"]


func _on_HostButton_pressed():
	Network.selected_port = int(port.text)
	Network.is_cop = is_cop
	Network.create_server()
	Network.city_size = city_size
	Network.enviroment = enviromennt
	generate_city_seed()
	get_tree().call_group("HostOnly", "show")
	create_waiting_room()


func _on_JoinButton_pressed():
	Network.selected_port = int(port.text)
	Network.selected_IP = selected_IP.text
	Network.is_cop = is_cop
	Network.connect_to_server()
	create_waiting_room()


func generate_city_seed():
	var world_seed = $VBoxContainer/CenterContainer/GridContainer/CitySeed.text
	if world_seed == "":
		randomize()
		Network.world_seed = randi()
	else:
		Network.world_seed = hash(world_seed)


func _on_NameTextbox_text_changed(new_text):
	SaveGame.save_data["Player_name"] = NameTextbox.text
	SaveGame.save_game()


func create_waiting_room():
	$WaitingRoom.popup_centered()
	$WaitingRoom.refresh_players(Network.players)


func _on_ReadyButton_pressed():
	Network.start_game()


func _on_TeamCheck_toggled(button_pressed):
	is_cop = button_pressed


func _on_TeamCheck_item_selected(index):
	if not int(is_cop) == index:
		var button = $VBoxContainer/CenterContainer/GridContainer/TeamCheck
		button.set_item_disabled(0, true)
		button.set_item_disabled(1, true)
		is_cop = index
		$LobbyBackground.pivot()


func _on_Tween_tween_completed(object, key):
	var button = $VBoxContainer/CenterContainer/GridContainer/TeamCheck
	button.set_item_disabled(0, false)
	button.set_item_disabled(1, false)


func _on_ColorPickerButton_color_changed(color):
	$LobbyBackground.new_color(color)
	SaveGame.save_data["local_paint_color"] = color.to_html()
	SaveGame.save_game()


func _on_CitySizePicker_item_selected(index):
	match index:
		0:
			city_size = Vector2(15,15)
			Network.prop_multiplier = 0.5
		1:
			city_size = Vector2(20,20)
			Network.prop_multiplier = 1
		2:
			city_size = Vector2(40,40)
			Network.prop_multiplier = 2
		3:
			city_size = Vector2(100,100)
			Network.prop_multiplier = 5


func _on_AudioButton_pressed():
	$AudioMenu.popup_centered()


func _on_TimeCheck_item_selected(index):
	match index:
		0:
			enviromennt = "res://Enviroments/Night.tres"
		1:
			enviromennt = "res://Enviroments/Day.tres"




















