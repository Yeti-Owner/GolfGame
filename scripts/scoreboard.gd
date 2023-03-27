extends Panel

@onready var Players := $Players

func _ready():
	self.hide()
	EventBus.AddedPlayer.connect(_set_player_list)

func _process(_delta):
	if Input.is_action_pressed("scoreboard"):
		self.show()
	else:
		self.hide()

func _set_player_list():
	# Clear Children
	for child in Players.get_children():
		child.queue_free()
	
	for entry in EventBus.PlayerEntries.size():
		var person = load("res://scenes/ui/player_0.tscn").instantiate()
		Players.add_child(person)
		person.TrackedPlayer = entry
		print(entry)
