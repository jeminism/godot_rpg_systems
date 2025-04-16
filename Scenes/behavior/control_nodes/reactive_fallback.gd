extends ControlNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	last_child_id = 0 #reactive always tick from first child
	var children = get_children()
	while last_child_id < children.size():
		var child = children[last_child_id]
		child.tick(root_entity) #this is non-blocking even if the child tick 'await' triggers
		var child_status: NODE_STATUS = child.get_node_status()
		if child_status == NODE_STATUS.FAILURE:
			last_child_id += 1
		else:
			return child_status
	return NODE_STATUS.FAILURE
	
	
