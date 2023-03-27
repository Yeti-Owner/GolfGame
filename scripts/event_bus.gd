extends Node

signal Shooting
signal AddedPlayer

var Power:float = 0
var PlayerEntries:Dictionary = {}

func _ready():
	randomize()

