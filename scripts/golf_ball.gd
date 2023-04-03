extends Node3D

# References
@onready var Ball := $Ball
@onready var Cam := $CamH/CamV/SpringArm3D/Camera3D
@onready var CamH := $CamH
@onready var CamV := $CamH/CamV

var MouseSens:float = 0.2
var Increasing:bool = true
var Enabled:bool = false

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Cam.current = true

func _input(event):
	if not is_multiplayer_authority(): return
	if event is InputEventMouseMotion:
		CamH.rotate_y(deg_to_rad(-event.relative.x * MouseSens))
		CamV.rotate_x(deg_to_rad(-event.relative.y * MouseSens))
		CamV.rotation.x = clamp(CamV.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _process(_delta):
	if not is_multiplayer_authority(): return
	CamH.position = Ball.position
	
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
			var Strength = ((-CamH.global_transform.basis.z)*(float(EventBus.Power/7)))
			Ball.apply_impulse(Strength, Vector3.ZERO)
