extends Node

#constants
#exported variables
export var _strike_period_time := 0.8
#onready variables
onready var _timer := $Timer
#variables
var _ignore
var _beats := {
	"1110":[1,1,1,0],
	"1010":[1,0,1,0],
	"1000":[1,0,0,0],
}
var current_beat := "1110"
var _current_bit := 1
var player_hit := true
var enemy_hit := false
#signals

func _ready():
	var timer_start_offset := (1-_strike_period_time)/2
	yield(get_tree().create_timer(timer_start_offset),"timeout")
	_timer.start(_strike_period_time)

func _on_Timer_timeout():
	#get the current number
	var this_beat:int = _beats[current_beat][_current_bit]
	#modify _current_bit
	_current_bit += 1
	_current_bit %= _beats[current_beat].size()
	#check who gets attack bonuses
	if this_beat == 1:
		player_hit = true
	else:
		player_hit = false
	enemy_hit = !player_hit
	#wait, then start timer
	var wait_time := (1-_strike_period_time)
	yield(get_tree().create_timer(wait_time),"timeout")
	player_hit = false
	enemy_hit = false
	_timer.start(_strike_period_time)
