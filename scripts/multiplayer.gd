extends Node3D

@onready var Menu := $CanvasLayer/Menu
@onready var Address := $CanvasLayer/Menu/VBoxContainer/Address

const Player := preload("res://scenes/golf_ball.tscn")
const PORT := 9999

var enet_peer = ENetMultiplayerPeer.new()

func _on_host_pressed():
	Menu.hide()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_add_player)
	
	_add_player(multiplayer.get_unique_id())

func _on_join_pressed():
	Menu.hide()
	
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func _on_back_pressed():
	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
	SceneManager.CurrentScene = null
	self.queue_free()

func _add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	
	SceneManager._swap_hud("res://scenes/ui/gui.tscn")
