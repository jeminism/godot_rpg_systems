extends CharacterEntity

class_name EnemyEntity

@export var exp_value : int
@onready var hurtbox = $hurtbox

var stats_multiplier = 1.0

signal award_exp

func _child_ready():
	#print("enemy init")
	#scale_core_stats.call_deferred()
	#_connect_damage_signal.call_deferred()
	#hurtbox.set_damage(stats.damage)
	hurtbox.set_damage(base_damage)
	#
#func _connect_damage_signal():
	#stats.damage_changed.connect(hurtbox.set_damage)
	
func _physics_process(delta: float) -> void:
	#var player_position = get_parent().find_child("player_entity").position
	#var direction = position.direction_to(player_position)
	#velocity = direction*stats.movement_speed
	animate()
	move()

func animate():
	pass

func on_death():
	award_exp.emit(exp_value)
	queue_free()

func scale_core_stats(multiplier: float = stats_multiplier):
	stats_multiplier = multiplier
	if stats:
		stats.scale_stats(multiplier)
