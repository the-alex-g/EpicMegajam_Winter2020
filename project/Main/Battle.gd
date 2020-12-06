extends Node2D

#constants
#exported variables
export var color := Color.white
#onready variables
onready var _enemy_position := $EnemyPosition
#normal variables
var _ignore
var _enemy
#signals

func _on_Main_combat_instigated(combat_enemy:Node2D, quantity:int):
	combat_enemy.position = _enemy_position.get_global_transform().origin
	_ignore = combat_enemy.connect("enemy_attacked", self, "_enemy_attacked")
	_enemy = combat_enemy
	add_child(combat_enemy)

func _enemy_attacked():
	pass
