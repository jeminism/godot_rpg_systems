extends BehaviorNode

class_name RootNode

func tick(root_entity: EntityBase) -> void:
	var children = get_children()
	assert(children.size() <= 1)
	if children:
		children[0].tick(root_entity)
	


func _on_reset():
	var children = get_children()
	children[0].reset()
