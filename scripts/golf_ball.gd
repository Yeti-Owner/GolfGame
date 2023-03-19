extends Node3D

# References
@onready var Ball = $Ball

var MouseSens:float = 0.2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		$CamH.rotate_y(deg_to_rad(-event.relative.x * MouseSens))
		$CamH/CamV.rotate_x(deg_to_rad(-event.relative.y * MouseSens))
		$CamH/CamV.rotation.x = clamp($CamH/CamV.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	

func _physics_process(_delta):
	$CamH.position = Ball.position
	
	if Ball.is_sleeping() == true:
		if Input.is_action_just_pressed("shoot"):
			Ball.apply_impulse((-$CamH.global_transform.basis.z)/2.5, Vector3.ZERO)
