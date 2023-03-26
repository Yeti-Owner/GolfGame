extends Node

signal Shooting

var Power:float = 0
var PlayerEntries:Dictionary = {}

func _ready():
	randomize()
	
