extends ControlNode

func _on_tick(root_entity: EntityBase) -> NODE_STATUS:
	var children = get_children()
	assert(children.size() == 2 or children.size() == 3)

	children[last_child_id].tick(root_entity)
	var tick_status = children[last_child_id].get_node_status()
	
	if last_child_id == 0:
		if tick_status == NODE_STATUS.SUCCESS:
			last_child_id = 1
		elif tick_status == NODE_STATUS.FAILURE: 
			if children.size() == 3:
				last_child_id = 2
	
		if last_child_id == 0:
			return tick_status
		
		else:
			children[last_child_id].tick(root_entity)
			tick_status = children[last_child_id].get_node_status()
	
	if tick_status != NODE_STATUS.RUNNING:
		last_child_id = 0 #reset for next run
	return tick_status
	
	
