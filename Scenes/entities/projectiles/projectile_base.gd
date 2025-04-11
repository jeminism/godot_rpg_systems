extends HurtBox

@export var speed: int = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	travel(delta)

func _on_area_entered(area: HitBox) -> void:
	on_collision(area)
	
#transform the position of the projectile
func travel(delta: float):
	return

#perform an action when interacting with another HitBox
func on_collision(area: HitBox):
	return
	
