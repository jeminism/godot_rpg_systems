extends MovementNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	var player_position = root_entity.get_parent().find_child("player_entity").position
	var direction = root_entity.position.direction_to(player_position)
	root_entity.velocity = direction*speed
	return NODE_STATUS.SUCCESS
