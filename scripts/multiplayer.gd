extends Node3D

@onready var Menu := $CanvasLayer/Menu
@onready var Address := $CanvasLayer/Menu/VBoxContainer/Address

const Player := preload("res://scenes/golf_ball.tscn")
const PORT := 5618

var enet_peer := ENetMultiplayerPeer.new()


func _on_host_pressed():
	Menu.hide()
	SceneManager.HUD.show()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_add_player)
	multiplayer.peer_disconnected.connect(_remove_player)
	
	_add_player(multiplayer.get_unique_id())
	
	_upnp_setup()

func _on_join_pressed():
	Menu.hide()
	SceneManager.HUD.show()
	
	enet_peer.create_client(Address.text, PORT)
	multiplayer.multiplayer_peer = enet_peer

func _on_back_pressed():
	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
	SceneManager.CurrentScene = null
	self.queue_free()

func _add_player(peer_id):
	var player := Player.instantiate()
	player.name = str(peer_id)
	add_child(player)

func _remove_player(peer_id):
	var player := get_node_or_null(str(peer_id))
	if player: player.queue_free()


func _upnp_setup():
	var upnp := UPNP.new()
	var discover_result = upnp.discover()
	
	# Error testing/handling
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, "UPNP Discover Failed! Error %s" % discover_result)
	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), "UPNP Invalid Gateway!")
	
	var map_result = upnp.add_port_mapping(PORT)
	assert(map_result == UPNP.UPNP_RESULT_SUCCESS, "UPNP Port Mapping Failed! Error %s" % map_result)
	
	print("Join Address: %s" % upnp.query_external_address())
