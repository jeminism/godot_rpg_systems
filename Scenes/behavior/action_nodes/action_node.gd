extends BehaviorNode

class_name ActionNode

#action nodes should await their completion
func tick(root_entity: EntityBase) -> void:
	if (status == NODE_STATUS.RUNNING):
		pass #so that we dont call multiple awaited _on_ticks
	else:
		status = NODE_STATUS.RUNNING #always set this to be running first so that it can be captured by the parent behavior node
		status = await _on_tick(root_entity)
		#print("node ", name, " completed with state: ", status)
