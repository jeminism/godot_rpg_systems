extends Node2D

class_name PlayerProjectile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(position, rotation)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * 400 * delta


func _on_area_entered(area: Area2D) -> void:
	queue_free()
