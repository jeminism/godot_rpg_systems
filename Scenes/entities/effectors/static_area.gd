extends "res://Scenes/entities/effectors/effector_entity.gd"



func child_ready():
	print("circular effector init")
	var collision_shape = $hurtbox/CollisionShape2D
	var circle_shape2d = CircleShape2D.new()
	circle_shape2d.set_radius(stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_MP))
	collision_shape.shape = circle_shape2d

func _child_on_hurt() -> void:
	queue_free()
