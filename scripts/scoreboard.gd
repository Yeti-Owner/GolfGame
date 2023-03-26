extends Panel

func _ready():
	self.hide()

func _process(delta):
	if Input.is_action_pressed("scoreboard"):
		self.show()
	else:
		self.hide()
	
	
