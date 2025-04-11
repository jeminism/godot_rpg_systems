extends Area2D

@onready var sprite = $AnimatedSprite2D

const SPEED = 30.0

var health = 100
var movement_post="_h"

var can_take_damage: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_position = get_parent().find_child("player_entity").position
	var direction = position.direction_to(player_position)
	var distance = position.distance_to(player_position)
	
	do_movement(direction, distance, delta)

func do_movement(direction, distance, delta):
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
	position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	
	if area.is_class("PlayerProjectile"):
		health -= 20
		print(health)
		if health <= 0:
			queue_free()
