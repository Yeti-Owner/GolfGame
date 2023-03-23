extends Control

@onready var Info := $InfoPopup

func _ready():
	Info.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_info_pressed():
	Info.visible = true

func _on_singleplayer_pressed():
	SceneManager._change_scene("res://scenes/world.tscn")
	SceneManager._swap_hud("res://scenes/ui/gui.tscn")

func _on_multiplayer_pressed():
	SceneManager._change_scene("res://scenes/multiplayer_world.tscn")
	SceneManager._swap_hud("res://scenes/ui/gui.tscn")
	SceneManager.HUD.hide()

func _on_quit_pressed():
	get_tree().quit()

func _on_close_btn_pressed():
	Info.visible = false
