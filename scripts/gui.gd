extends CanvasLayer

@onready var Bar := $Control/ProgressBar

func _ready():
	Bar.visible = false
	EventBus.Shooting.connect(_shooting)

func _shooting():
	Bar.visible = !Bar.visible

func _process(delta):
	Bar.value = EventBus.Power
