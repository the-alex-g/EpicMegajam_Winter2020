extends Node2D

#constants
#exported variables
#onready variables
onready var enemies := $Map/Enemies
onready var player_camera := $Map/Player/Camera2D
onready var Thingie := $Battle/Cameras/Island_Camera
#variables
var _ignore
var _enemy_currently_fighting:KinematicBody2D = null
var _current_terrain := "Island"
#signals
signal combat_instigated(combat_enemy, quantity)

func _ready():
	for enemy in enemies.get_children():
		_ignore = enemy.connect("collided_with_player", self, "combat_instigated")

func _process(_delta:float):
	pass

func combat_instigated(map_enemy:KinematicBody2D, combat_enemy:Node2D, quantity:int):
	Thingie.current = true
	_enemy_currently_fighting = map_enemy
	emit_signal("combat_instigated", combat_enemy, quantity)
