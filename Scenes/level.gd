extends Node2D

var skeleton = preload("res://Scenes/entities/enemies/skeleton/skeleton.tscn")
var berserk_skeleton = preload("res://Scenes/entities/enemies/berserk_skeleton/berserk_skeleton.tscn")

@onready var follow = $player_entity/Path2D/PathFollow2D
@onready var follow_node = $player_entity/Path2D/PathFollow2D/Node2D
@onready var path = $player_entity/Path2D
@onready var timer = $Timer
var start_time : float
var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_unix_time_from_system()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	#print("spawning skelly!")
	var rng = RandomNumberGenerator.new()
	#print(follow.progress)
	var elapsed_time = Time.get_unix_time_from_system() - start_time
	var units = floor(elapsed_time/30.0)
	var enemy_chance = max(100 - units*10, 50)
	timer.start(max(3.0-units*0.2, 1.0))
	
	#print(follow.progress)
	#print(follow_node.global_position)
	var enemy_instance: EnemyEntity = choose_enemy(enemy_chance)
	enemy_instance.scale_core_stats(pow(1.05, %player_entity.level-1))
	#enemy_instance.scale_core_stats(pow(1.05, %player_entity.level-1))
	enemy_instance.exp_value*=pow(1.2, %player_entity.level-1)
	follow.progress=rng.randi_range(0, 3661)
	enemy_instance.global_position = follow_node.global_position
	enemy_instance.award_exp.connect(%player_entity._on_enemy_award_exp)
	add_child(enemy_instance)

func choose_enemy(chance) -> EnemyEntity:
	var rng = RandomNumberGenerator.new()
	var val = rng.randi_range(0, 100)
	
	#print(chance," ", val)
	if val < chance:
		return skeleton.instantiate()
	else:
		return berserk_skeleton.instantiate()
	
func toggle_pause(val: bool):
	var process_setters = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input",]
	
	for setter in process_setters:
		propagate_call(setter, [!val], true)
	
	timer.paused = val
