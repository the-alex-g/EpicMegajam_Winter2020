class_name Battle_Enemy
extends Node2D

#constants
#exported variables
export var damage := 0
export var health := 0
export var color := Color.white
#onready variables
onready var collision := $Area2D/CollisionShape2D
#normal variables
var _ignore
var attacking := false
#signals
signal enemy_attacked

func _draw():
	if collision != null:
		var shape = collision.get_shape()
		if shape is CircleShape2D:
			var radius = shape.radius
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

func _on_Area2D_area_entered(area):
	if area is Battle_Player and attacking:
		var damage_mod := 0
		match randi()%3:
			0:
				damage_mod = -10
			1:
				damage_mod = 0
			2:
				damage_mod = 10
		var actual_damage := damage + damage_mod
		area.hit(actual_damage)

func _on_Timer_timeout():
	attacking = false
	if Beat_tracker.enemy_hit:
		emit_signal("enemy_attacked")
		attacking = true
