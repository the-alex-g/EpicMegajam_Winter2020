class_name Map_Enemy
extends KinematicBody2D

#constants
#exported variables
export var color := Color.white
export var number := 1
export var battle_self:PackedScene
#onready variables
onready var collision := $CollisionShape2D
#normal variables
var _ignore
#signals
signal collided_with_player(map_enemy, combat_enemy, quantity)

func _ready():
	pass

func _process(_delta:float):
	pass

func _draw():
	if collision != null:
		#draw shape based on collisionshape
		var shape = collision.get_shape()
		if shape is CircleShape2D:
			var radius:float = shape.radius
			draw_circle(-Vector2(radius,radius), radius, color)
		elif shape is RectangleShape2D:
			var extents : Vector2 = shape.extents
			draw_rect(Rect2(-extents, extents*2), color)
		elif shape is CapsuleShape2D:
			var radius = shape.radius
			var height = shape.height
			draw_circle(Vector2(0,height/2), radius, color)
			draw_circle(-Vector2(0,height/2), radius, color)
			draw_rect(Rect2(-Vector2(radius*2,height)/2, Vector2(radius*2,height)), color)

func _on_Fight_Radius_body_entered(body):
	if body is Map_Player:
		emit_signal("collided_with_player", self, battle_self, number)
