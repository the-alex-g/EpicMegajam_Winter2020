extends Node2D

#constants
#exported variables
export var color := Color.white
#onready variables
onready var _player := $Player
onready var _enemy_timer := $EnemyTimer
onready var _enemy_base := $Enemy_Base
onready var _enemypaths := $EnemyAnimator
onready var _playerpaths := $PlayerAnimator
#normal variables
var _ignore
var _number_of_enemies := 0
var Enemy:Node2D
var _enemy:PackedScene
#signals
signal enemy_defeated

func _on_Main_combat_instigated(enemy:PackedScene, quantity:int):
	_number_of_enemies = quantity
	_enemy = enemy
	_add_enemy()

func _enemy_defeated():
	_number_of_enemies -= 1
	yield(get_tree().create_timer(0.5), "timeout")
	if _number_of_enemies <= 0:
		emit_signal("enemy_defeated")
	else:
		_add_enemy()

func _add_enemy():
	Enemy = _enemy.instance()
	Enemy.position = Vector2(0,0)
	_ignore = Enemy.connect("enemy_attacked", self, "_enemy_attacked")
	_ignore = Enemy.connect("defeated", self, "_enemy_defeated")
	_enemy_base.call_deferred("add_child", Enemy)

func _enemy_attacked():
	var path := randi()%2
	_enemypaths.play(str(path))

func _on_Player_player_attacked():
	var path := randi()%2
	_playerpaths.play(str(path))
