extends Control


@onready var exp_display = $exp_display

func _ready() -> void:
	var value = get_parent().exp / get_parent().exp_requirement
	_update_exp(value)

func update(val : float):
	_update_exp(val)
	
func _update_exp(val : float):
	exp_display.value = val
