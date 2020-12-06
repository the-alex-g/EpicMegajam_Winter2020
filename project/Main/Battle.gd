extends Node2D

#constants
#exported variables
export var color := Color.white
#onready variables
onready var _enemy_position := $EnemyPosition
onready var _enemy_paths := $EnemyPaths
onready var _player_paths := $PlayerPaths
onready var _player := $Player
onready var _enemy_timer := $EnemyTimer
#normal variables
var _ignore
var _enemy:Node2D
var _current_enemy_path:PathFollow2D = null
var _enemy_backup:Node = null
#signals

func _process(_delta:float):
	if _current_enemy_path != null:
		var time_left:float = 1.0-_enemy_timer.time_left
		_current_enemy_path.offset = lerp(0,1,time_left)
	if _enemy_backup != null:
		_current_enemy_path.add_child(_enemy_backup)
		_enemy_backup = null
		

func _on_Main_combat_instigated(combat_enemy:Node2D, _quantity:int):
	combat_enemy.position = _enemy_position.get_global_transform().origin
	_ignore = combat_enemy.connect("enemy_attacked", self, "_enemy_attacked")
	_enemy = combat_enemy
	call_deferred("add_child", combat_enemy)

func _enemy_attacked():
	var path = get_node("EnemyPaths/Path2D"+str(randi()%_enemy_paths.get_child_count())+"/PathFollow2D")
	_current_enemy_path = path
	_reparent(_enemy)

func _reparent(node:Node):
	_enemy_backup = node #Dosn't work because it's referencing the node itself, which is deleted
	node.queue_free()
	
