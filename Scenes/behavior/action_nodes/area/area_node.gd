extends ActionNode

class_name AreaNode

@export var offset: Vector2
@onready var area = $Area2D
@onready var shape = $Area2D/CollisionShape2D

func _init():
	offset = Vector2(0,0)

func _ready():
	#set_shape_position()
	set_shape_geometry()
	
	
func set_shape_geometry():
	#to be defined by child classes
	pass

func set_shape_position():
	area.position = offset
	
