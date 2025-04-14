extends BehaviorNode

class_name ControlNode

var last_child_id: int = 0

#control nodes CANNOT use await inside their _on_tick functions. 
#if await is used, this breaks reactivity if a child node returns RUNNING
func tick(root_character: CharacterBody2D) -> void:
	status = NODE_STATUS.RUNNING #always set this to be running first so that it can be captured by the parent behavior node
	#removal of the await here is purposeful, because it will cause an error if the _on_tick behaves as a coroutine - which is not allowed!
	status = _on_tick(root_character) 


func _on_reset():
	last_child_id = 0
	for child in get_children():
		child.reset()
