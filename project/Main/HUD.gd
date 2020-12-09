extends CanvasLayer

#constants
#exported variables
#onready variables
onready var _healthbar := $ProgressBar
#variables
var _ignore
#signals

func _ready():
	_healthbar.max_value = PlayerStats.health
	_healthbar.value = PlayerStats.health

func _process(_delta:float):
	_healthbar.value = PlayerStats.health
