extends "res://Scenes/entities/enemies/enemy_entity.gd"

var direction_postfix = "_h"

func animate():
	#print("skelly animate, ", velocity)
	if velocity.x == 0 and velocity.y == 0:
		animation_player.play("idle"+direction_postfix)
		return
		
	if abs(velocity.x) > abs(velocity.y):
		direction_postfix = "_h"
	else:
		if velocity.y < 0:
			direction_postfix = "_up"
		else:
			direction_postfix = "_down"
	
	if velocity.x > 0:
		sprite.scale.x = 1.0
	elif velocity.x < 0:
		sprite.scale.x = -1.0
				
	animation_player.play("walk"+direction_postfix)
	return
		
		
		
