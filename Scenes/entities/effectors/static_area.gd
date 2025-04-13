extends "res://Scenes/entities/effectors/effector_entity.gd"

@export var max_targets: int = -1 #negative number is infinite
var selected_targets: Array[EntityBase]

func _process(delta: float):
	for target in selected_targets:
		skill_handler.trigger_on_hurts(self, target)
		
	stats.take_stat_damage(StatModification.new({ATTRIBUTE_ENUMS.TYPE.MAX_HP: -1}))
	#MAX_HP here counts the lifetime of this object in process frames 
	if stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_HP) <= 0:
		queue_free()

func child_ready():
	#print("circular effector init")
	var collision_shape = $hurtbox/CollisionShape2D
	var circle_shape2d = CircleShape2D.new()
	circle_shape2d.set_radius(stats.get_stat(ATTRIBUTE_ENUMS.TYPE.MAX_MP))
	collision_shape.shape = circle_shape2d

func _child_on_hurt() -> void:
	queue_free()

func on_hurt(source_entity: EntityBase):
	if max_targets < 0 or selected_targets.size() < max_targets:
		selected_targets.append(source_entity)
	else:
		for i in range(selected_targets.size()):
			var distance = get_distance
			if get_distance(global_position, source_entity.global_position) < get_distance(global_position, selected_targets[i].global_position):
				selected_targets[i] = source_entity
				break

func get_distance(p1: Vector2, p2: Vector2):
	return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
