extends CanvasLayer

@onready var Bar := $Control/ProgressBar


func _ready():
	Bar.visible = false
	EventBus.Shooting.connect(_shooting)
	$PauseMenu.visible = false

func _shooting():
	Bar.visible = !Bar.visible

func _process(_delta):
	Bar.value = EventBus.Power

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause") and get_tree().is_paused() == false:
		get_tree().set_pause(true)
		$PauseMenu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("pause") and get_tree().is_paused() == true:
		get_tree().set_pause(false)
		$PauseMenu.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_resume_pressed():
	get_tree().set_pause(false)
	$PauseMenu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_exit_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

