extends Node

signal Shooting
signal AddedPlayer

var Power:float = 0
var PlayerEntries:Dictionary = {}

@onready var https := $HTTPRequest
const database_post := ""
const database_delete := ""
const database_ask := ""

var uid:int
var Mode:int = 0

func _ready():
	randomize()
	uid = randi_range(100, 999999)
	print(uid)
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_delete_data()

func _send_data(location: String):
	var data = {
		"id": uid,
		"location": location
	}
	var headers := ["Content-Type: application/json"]
	https.request(database_post, headers, HTTPClient.METHOD_POST, str(data))

func _ask_data(value):
	var data = {
		"id": value
	}
	var headers := ["Content-Type: application/json"]
	https.request(database_ask, headers, HTTPClient.METHOD_POST, str(data))
	Mode = 2

func _delete_data():
	var data = {
		"id": uid
	}
	var headers := ["Content-Type: application/json"]
	https.request(database_delete, headers, HTTPClient.METHOD_POST, str(data))
	Mode = 1

func _on_http_request_request_completed(result, _response_code, _headers, body) -> void:
	if result == HTTPRequest.RESULT_SUCCESS:
#		print("Request succeeded")
		if Mode == 1:
			get_tree().quit()
		if Mode == 2:
			print(body)
	else:
		print("Request failed")
