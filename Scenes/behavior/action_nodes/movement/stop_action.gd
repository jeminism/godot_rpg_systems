extends MovementNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	root_entity.velocity = Vector2(0,0)
	return NODE_STATUS.SUCCESS
