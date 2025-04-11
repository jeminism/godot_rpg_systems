extends Control


@onready var option_1 = $PanelContainer/GridContainer/level_up_option
@onready var option_2 = $PanelContainer/GridContainer/level_up_option2
@onready var option_3 = $PanelContainer/GridContainer/level_up_option3
@onready var option_screen = $PanelContainer


signal level_up_selection_done
var options = ["Initialize option!","Initialize option!", "Initialize option!"]
var new_size : Vector2 = Vector2(-1,-1)

func _ready():
	_update_descriptions()

func set_options(text_1: String, text_2: String, text_3: String):
	options.clear()
	options.append(text_1)
	options.append(text_2)
	options.append(text_3)
	if option_1 and option_2 and option_3:
		_update_descriptions()


func _update_descriptions():
	option_1.set_text(options[0])
	option_2.set_text(options[1])
	option_3.set_text(options[2])
	
func _on_level_up_option_option_selected(selection_id: int) -> void:
	level_up_selection_done.emit(selection_id)
	queue_free()
