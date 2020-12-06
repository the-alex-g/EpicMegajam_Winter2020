extends KinematicBody2D

#constants
#exported variables
export var color := Color.white
export var speed := 200
#onready variables
onready var collision := $CollisionShape2D
#normal variables
var _ignore
#signals

func _ready():
	pass

func _physics_process(delta:float):
	#move the player
	var velocity := Vector2(0,0)
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	var direction := velocity.normalized()
	var final_speed := direction*speed*delta
	_ignore = move_and_collide(final_speed)

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
