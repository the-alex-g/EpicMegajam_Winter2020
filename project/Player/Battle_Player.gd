class_name Battle_Player
extends Node2D

#constants
#exported variables
export var color := Color.white
#onready variables
onready var collision := $Area2D/CollisionShape2D
#normal variables
var _ignore
#signals

func _ready():
	pass

func _process(_delta:float):
	pass

func _draw():
	if collision != null:
		var shape = collision.get_shape()
		if shape is CircleShape2D:
			var radius = shape.radius
			draw_circle(Vector2(0,0), radius, color)
		elif shape is RectangleShape2D:
			var extents : Vector2 = shape.extents
			draw_rect(Rect2(-extents, extents*2), color)
		elif shape is CapsuleShape2D:
			var radius = shape.radius
			var height = shape.height
			draw_circle(Vector2(0,height/2), radius, color)
			draw_circle(-Vector2(0,height/2), radius, color)
			draw_rect(Rect2(-Vector2(radius*2,height)/2, Vector2(radius*2,height)), color)
