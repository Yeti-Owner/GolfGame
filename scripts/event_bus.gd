extends Node

signal Shooting
signal AddedPlayer

var Power:float = 0
var PlayerEntries:Dictionary = {}

@onready var https := $HTTPRequest
const database_post := ""
const database_delete := ""
var uid:int
var headers := ["Content-Type: application/json"]
var Close:bool = false

func _ready():
	randomize()
	uid = randi_range(100, 9999)
	print(uid)
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("noti")
		_delete_data()

func _send_data(location: String):
	var data = {
		"id": uid,
		"location": location
	}
	https.request(database_post, headers, HTTPClient.METHOD_POST, str(data))

func _delete_data():
	var data = {
		"id": uid
	}
	
	https.request(database_delete, headers, HTTPClient.METHOD_POST, str(data))
	print("del")
	Close = true

func _on_http_request_request_completed(result, _response_code, _headers, _body) -> void:
	print("req")
	if result == HTTPRequest.RESULT_SUCCESS:
		print("Request succeeded")
		if Close:
			print("close")
			get_tree().quit()
	else:
		print("Request failed")
