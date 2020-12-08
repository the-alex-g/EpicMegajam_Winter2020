extends Node2D

#constants
#exported variables
#onready variables
onready var enemies := $Map/Enemies
onready var player_camera := $Map/Player/Camera2D
#variables
var _ignore
var _enemy_currently_fighting:KinematicBody2D = null
var _current_terrain := "Island"
var _current_camera := player_camera
#signals
signal combat_instigated(combat_enemy, quantity)

func _ready():
	randomize()
	for enemy in enemies.get_children():
		_ignore = enemy.connect("collided_with_player", self, "combat_instigated")

func _process(_delta:float):
	pass

func combat_instigated(map_enemy:KinematicBody2D, combat_enemy:Node2D, quantity:int):
	_current_camera = get_node("Battle/Cameras/"+_current_terrain+"_Camera")
	_current_camera.current = true
	_enemy_currently_fighting = map_enemy
	emit_signal("combat_instigated", combat_enemy, quantity)

func _on_Battle_enemy_defeated():
	_enemy_currently_fighting.queue_free()
	_current_camera.current = false
	player_camera.current = true
	_current_camera = player_camera
