extends CharacterBody2D


const PROJECTILE = "res://Scenes/entities/projectiles/arrow_projectile.tscn"
const SPEED = 130.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $AnimatedSprite2D

var pressed: bool
var attack: bool
var can_attack = true
var can_move = true

var movement_post = "_h"
var attack_post = "_h"
var attack_cooldown = 0.4


func _input(event):
	if event.is_action_pressed("attack") && can_attack:
		attack = true
		
	if event.is_action_pressed("mouse_click"):
	# Use is_action_pressed to only accept sin
		pressed = true
	elif event.is_action_released("mouse_click"):
		pressed = false

func _physics_process(delta: float) -> void:
	# 8 direciton key input
	#var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# mouse click & drag
	var target = position
	if pressed or attack:
		target = get_global_mouse_position()	
	var direction = position.direction_to(target)
	var distance = position.distance_to(target)
	
	if attack:
		can_move = false
		attack = false
		can_attack = false
		do_attack(direction, distance)
	elif can_move:
		do_movement(direction, distance)
		
func do_attack(direction, distance):
	if (abs(direction.x) > abs(direction.y)):
		attack_post = "_h"
	else:
		if direction.y > 0:
			attack_post = "_down"
		else:
			attack_post = "_up"
			
	if (direction.x < 0):
		sprite.flip_h = true
	elif (direction.x > 0):
		sprite.flip_h = false
		
	sprite.play("attack" + attack_post)	
	await sprite.animation_finished
	
	#print(direction)
	var projectile_instance = load(PROJECTILE).instantiate()
	projectile_instance.position = position
	projectile_instance.position.y -= 25 #spawn at bow height
	projectile_instance.position += direction*5 #spawn slightly in front of player model
	
	projectile_instance.look_at(projectile_instance.position+direction)
	get_parent().add_child(projectile_instance)
	sprite.play("attack_recover" + attack_post)	
	
	await sprite.animation_finished
	can_move = true
	can_attack = true


func do_movement(direction, distance):
	if distance < 10:
		sprite.play("idle" + movement_post)
		return
		
	if (abs(direction.x) > abs(direction.y)):
		movement_post = "_h"
	else:
		if direction.y > 0:
			movement_post = "_down"
		else:
			movement_post = "_up"
	
	if (direction.x < 0):
		sprite.flip_h = true
	elif (direction.x > 0):
		sprite.flip_h = false
		
	sprite.play("walk" + movement_post)	
		
	if distance < 10:
		velocity = Vector2(0, 0)
	else:
		velocity = direction*SPEED
	
	move_and_slide()
