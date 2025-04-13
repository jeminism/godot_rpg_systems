extends SkillBase

class_name SkillTimerTrigger

@export var duration: float
var ok: bool

func _init():
	duration = 1.0
	ok = true
	
func condition(parent_entity: EntityBase) -> bool:
	if ok:
		parent_entity.get_tree().create_timer(duration).timeout.connect(on_timer)
		ok = false
		return true
	return false
	
func on_timer():
	ok = true
