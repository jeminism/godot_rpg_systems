extends Control

@export var option_id: int = 0
@onready var description = $description

signal option_selected

func set_text(val: String):
	description.text = val

func _on_selection_button_pressed() -> void:
	option_selected.emit(option_id)
