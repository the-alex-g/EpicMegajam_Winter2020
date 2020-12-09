class_name Battle_Player
extends Node2D

#constants
#exported variables
export var color := Color.white
#onready variables
onready var collision := $CollisionShape2D
#normal variables
var _ignore
var attacking := false
var extra_damage := 1
#signals
signal player_attacked

func _process(_delta:float):
	if Input.is_action_just_pressed("Attack") and not Beat_tracker.enemy_hit:
		emit_signal("player_attacked")
		attacking = true
		extra_damage = 1 if Beat_tracker.player_hit == true else 2
		$Timer.start()

func hit(damage:int):
	PlayerStats.health -= damage
	if PlayerStats.health <= 0:
		queue_free()

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

func _on_Area2D_area_entered(area):
	if area.name == "Guard" and attacking:
		var damage_mod := 0
		match randi()%3:
			0:
				damage_mod = -10
			1:
				damage_mod = 0
			2:
				damage_mod = 10
		var actual_damage:int = PlayerStats.damage + damage_mod
		actual_damage *= extra_damage
		area.hit(actual_damage)

func _on_Timer_timeout():
	extra_damage = 1
	attacking = false
