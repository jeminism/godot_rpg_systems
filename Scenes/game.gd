extends Node2D

var attribute_helper = preload("res://Resources/Entities/attribute_helper.tres")
## level up UI
var item_db = preload("res://Resources/items/item_db.tres")
var level_screen = preload("res://Scenes/ui/level_up_screen.tscn")

# just a helper class to organize tooltip and value for each option
enum UPGRADE_TYPES {
	STAT,
	ITEM
}
class UpgradeBonus:
	var type : UPGRADE_TYPES
	var tooltip : String
	var property: String
	var property_value: int
	var item_id: ITEM_ENUMS.ITEM_LIST
	
	func _init(_type: UPGRADE_TYPES, _tooltip: String, _property, _property_value, _item_id=ITEM_ENUMS.ITEM_LIST.NONE):
		type = _type
		tooltip = _tooltip
		property = _property
		property_value = _property_value
		item_id = _item_id

var available_upgrades = [UpgradeBonus.new(UPGRADE_TYPES.STAT, "STAT BONUS\n\nRecover 40 health", "hp", 40),
						  UpgradeBonus.new(UPGRADE_TYPES.STAT, "STAT BONUS\n\nIncrease max health by 5", "hp_max", 5),
						  UpgradeBonus.new(UPGRADE_TYPES.STAT, "STAT BONUS\n\nReduce incoming damage by 1", "defence", 1),
						  UpgradeBonus.new(UPGRADE_TYPES.STAT, "STAT BONUS\n\nIncrease movement speed by 5", "speed", 5),
						  UpgradeBonus.new(UPGRADE_TYPES.STAT, "STAT BONUS\n\nIncrease damage by 5", "damage", 5)]
var chosen_upgrades:Array[UpgradeBonus] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_player_entity_level_up() -> void:
	toggle_pause_game(true)
	var level_screen_instance = level_screen.instantiate()
	chosen_upgrades = get_upgrade_options()
	level_screen_instance.set_options(chosen_upgrades[0].tooltip, 
									  chosen_upgrades[1].tooltip,
									  chosen_upgrades[2].tooltip)
	level_screen_instance.level_up_selection_done.connect(_on_level_screen_level_up_selection_done)
	#level_screen_instance._set("z_index", 999)
	level_screen_instance.position = %player_entity.global_position
	#level_screen_instance.resize(%player_entity/Camera2D.get("size"))
	add_child(level_screen_instance)

func _on_level_screen_level_up_selection_done(option_id: int):
	#if chosen_upgrades[option_id].type == UPGRADE_TYPES.STAT:
		#%player_entity.modify_property_delta(chosen_upgrades[option_id].property, chosen_upgrades[option_id].property_value)
	#elif chosen_upgrades[option_id].type == UPGRADE_TYPES.ITEM:
	%player_entity.equip(chosen_upgrades[option_id].item_id)
	toggle_pause_game(false)
	
func get_upgrade_options() -> Array[UpgradeBonus]:
	var rng = RandomNumberGenerator.new()
	var res: Array[UpgradeBonus] = []
	while res.size() < 3:
		#var upgrade_type = UPGRADE_TYPES.values().pick_random()
		#if upgrade_type == UPGRADE_TYPES.STAT:
			#var cand = available_upgrades.pick_random()
			#if cand not in res:
				#res.append(cand)
		#elif upgrade_type == UPGRADE_TYPES.ITEM:
		var it_cand = ITEM_ENUMS.ITEM_LIST.values().pick_random()
		if not %player_entity.has_item(it_cand) and it_cand != ITEM_ENUMS.ITEM_LIST.NONE:
			res.append(UpgradeBonus.new(UPGRADE_TYPES.ITEM, get_item_tooltip(it_cand), "", 0, it_cand))
	return res
			
func get_item_tooltip(item: ITEM_ENUMS.ITEM_LIST):
	var item_name = item_db.ITEM_DESCRIPTIONS[item].item_name
	var item_description = item_db.ITEM_DESCRIPTIONS[item].item_description
	var stat_mod = ""
	var current_equipped_item = %player_entity.get_equipped_in_slot(item_db.ITEM_DESCRIPTIONS[item].equip_slot)
	var stat_changes = item_db.ITEM_DESCRIPTIONS[item].get_stat_modifications()
	for property in stat_changes.stat_modification:
		var val = stat_changes.stat_modification[property]
		stat_mod += attribute_helper.VAR_NAMES[property] + ": " + str(val) + "\n"
		#stat_mod += property + ": " + ("+" if val>0 else "-") + str(val) + "\n"
	return "EQUIP ITEM: " + item_name + "\n\nStat Changes:\n" + stat_mod

func toggle_pause_game(val: bool):
	$Level.toggle_pause(val)
	#var process_setters = ["set_process",
	#"set_physics_process",
	#"set_process_input",
	#"set_process_unhandled_input",
	#"set_process_unhandled_key_input",
	#"set_process_shortcut_input",]
	#
	#for setter in process_setters:
		#root_node.propagate_call(setter, [!val], true)
