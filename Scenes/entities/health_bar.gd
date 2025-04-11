extends Control

@onready var health_display = $health_display
@onready var damage_display = $damage_display
@onready var timer = $Timer

func _ready() -> void:
	var value = 1.0
	if get_parent().stats:
		value = float(get_parent().stats.hp) / float(get_parent().stats.max_hp)
	_update_health(value)
	_update_damage(value)

func update(val : float):
	#print("updating health: ", val)
	_update_health(val)
	_start_timer()
	
func _update_health(val : float):
	health_display.value = val

func _update_damage(val : float):
	damage_display.value = val

func _start_timer():
	timer.start(0.5)

func _on_timer_timeout() -> void:
	_update_damage(health_display.value)
