extends Control

func _ready():
	Engine.set_max_fps(120)

	SceneManager._swap_hud("res://scenes/UI/menu.tscn")
	queue_free()
