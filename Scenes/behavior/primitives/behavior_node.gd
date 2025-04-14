extends Node

class_name BehaviorNode

enum NODE_STATUS {IDLE, RUNNING, SUCCESS, FAILURE}

var status: NODE_STATUS

func get_node_status() -> NODE_STATUS:
	return status

# tick takes in the root CharacterBody2D so that it can exercise behaviors onto it
# it should return void because this has the option to await for RUNNING actions
func tick(root_character: CharacterBody2D) -> void:
	if (status == NODE_STATUS.RUNNING):
		pass #so that we dont call multiple awaited _on_ticks
	else:
		status = NODE_STATUS.RUNNING #always set this to be running first so that it can be captured by the parent behavior node
		status = await _on_tick(root_character)

func reset():
	_on_reset()
	if status != NODE_STATUS.RUNNING:
		status = NODE_STATUS.IDLE
	
#functions to override below
func _on_tick(root_character: CharacterBody2D) -> NODE_STATUS:
	return NODE_STATUS.IDLE

func _on_reset():
	pass
