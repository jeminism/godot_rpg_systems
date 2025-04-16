extends AreaNode

class_name CircleNode

@export var radius: int

func set_radius(new_value: int):
	radius = new_value
	set_shape_geometry()

func set_shape_geometry():
	print("circle area set geometry: ", radius)
	var circle_shape2d = CircleShape2D.new()
	circle_shape2d.set_radius(radius)
	shape.shape = circle_shape2d
