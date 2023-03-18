extends Control

func _ready():
	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
	queue_free()
