extends ControlNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	var children = get_children()
	while last_child_id < children.size():
		var child = children[last_child_id]
		child.tick(root_entity) #this is non-blocking even if the child tick 'await' triggers
		var child_status: NODE_STATUS = child.get_node_status()
		if child_status == NODE_STATUS.SUCCESS:
			last_child_id += 1
		else:
			if child_status == NODE_STATUS.FAILURE:
				last_child_id = 0 #reset for next
			return child_status
	last_child_id = 0 #reset for next
	return NODE_STATUS.SUCCESS
	
	
