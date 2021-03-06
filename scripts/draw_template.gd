extends %BASE%

#constants
#exported variables
export var color := Color.white
#onready variables
onready var collision := $CollisionShape2D
#normal variables
var _ignore
#signals

func _ready()%VOID_RETURN%:
	pass

func _process(delta:float)%VOID_RETURN%:
	pass

func _draw()%VOID_RETURN%:
	if collision != null:
		var shape = collision.get_shape()
		if shape is CircleShape2D:
			var radius = shape.radius
			draw_circle(Vector2.ZERO, radius, color)
		elif shape is RectangleShape2D:
			var extents : Vector2 = shape.extents
			draw_rect(Rect2(-extents, extents*2), color)
		elif shape is CapsuleShape2D:
			var radius = shape.radius
			var height = shape.height
			draw_circle(Vector2(0,height/2), radius, color)
			draw_circle(-Vector2(0,height/2), radius, color)
			draw_rect(Rect2(-Vector2(radius*2,height)/2, Vector2(radius*2,height)), color)