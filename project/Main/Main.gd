extends Node2D

#constants
#exported variables
#onready variables
#variables
var _ignore
#signals

func _ready():
	pass

func _process(delta:float):
	$icon.visible = Beat_tracker.player_hit