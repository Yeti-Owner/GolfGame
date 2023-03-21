extends Node3D

# References
@onready var Ball = $Ball

var MouseSens:float = 0.2
var Increasing:bool = true
var Enabled:bool = false

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
			Increasing = true
			EventBus.Power = 0
			EventBus.emit_signal("Shooting")
			Enabled = true
		if Input.is_action_pressed("shoot") and Enabled:
			if Increasing:
				EventBus.Power += 1
				if EventBus.Power >= 100:
					Increasing = false
			else:
				EventBus.Power -= 1
				if EventBus.Power <= 0:
					Increasing = true
		if Input.is_action_just_released("shoot") and Enabled:
			Enabled = false
			EventBus.emit_signal("Shooting")
			var Strength = ((-$CamH.global_transform.basis.z)*(float(EventBus.Power/100)))
			Ball.apply_impulse(Strength, Vector3.ZERO)
