extends Control

onready var NameTextbox = $VBoxContainer/CenterContainer/GridContainer/NameTextbox
onready var port = $VBoxContainer/CenterContainer/GridContainer/PortTextbox
onready var selected_IP = $VBoxContainer/CenterContainer/GridContainer/IPTextbox

var is_cop = false

func _ready():
	NameTextbox.text = SaveGame.save_data["Player_name"]
	selected_IP.text = Network.DEFAULT_IP
	port.text = str(Network.DEFAULT_PORT)


func _on_HostButton_pressed():
	Network.selected_port = int(port.text)
	Network.is_cop = is_cop
	Network.create_server()
	get_tree().call_group("HostOnly", "show")
	create_waiting_room()


func _on_JoinButton_pressed():
	Network.selected_port = int(port.text)
	Network.selected_IP = selected_IP.text
	Network.is_cop = is_cop
	Network.connect_to_server()
	create_waiting_room()


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
