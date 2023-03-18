extends Node3D

var MouseSens:float = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		$CamH.rotate_y(deg_to_rad(-event.relative.x * MouseSens))
		$CamH/CamV.rotate_x(deg_to_rad(-event.relative.y * MouseSens))
		$CamH/CamV.rotation.x = clamp($CamH/CamV.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(_delta):
	$CamH.position = $Ball.position
