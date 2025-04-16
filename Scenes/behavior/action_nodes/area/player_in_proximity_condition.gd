extends CircleNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	#print("player proximity check: ", area.has_overlapping_areas())
	return NODE_STATUS.SUCCESS if area.has_overlapping_areas() else NODE_STATUS.FAILURE
