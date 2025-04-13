extends CharacterEntity

class_name Player

@onready var exp_bar = $exp_bar
@onready var model = $Sprite2D

var item_db = preload("res://Resources/items/item_db.tres")

#var projectile = preload("res://Scenes/entities/projectiles/arrow_projectile.tscn")

var projectile = preload("res://Scenes/entities/effectors/arrow.tscn")

#movement
var can_attack = true
var can_move = true
var movement_post = "_h"
var attack_post = "_h"
var attack_cooldown = 0.4

#attack
var attack_target: Vector2
var damage = 0


#level up
var level = 1
var exp = 0
var exp_requirement = 5
signal level_up

#items
var equipped_armor = {
	ITEM_ENUMS.EQUIP_SLOTS.WEAPON: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.HEAD: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.SHOULDER: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.CHEST: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.LEGS: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.BOOTS: ITEM_ENUMS.ITEM_LIST.NONE,
	ITEM_ENUMS.EQUIP_SLOTS.GLOVES: ITEM_ENUMS.ITEM_LIST.NONE
}
var inventory: Array[ITEM_ENUMS.ITEM_LIST]= []

########################################
func _child_ready():
	add_skill(skill_library.skill_dictionary["AUTO_ATTACK"])
	var default_equip = {
		ITEM_ENUMS.EQUIP_SLOTS.WEAPON: ITEM_ENUMS.ITEM_LIST.DAGGER,
		ITEM_ENUMS.EQUIP_SLOTS.HEAD: ITEM_ENUMS.ITEM_LIST.NONE,
		ITEM_ENUMS.EQUIP_SLOTS.SHOULDER: ITEM_ENUMS.ITEM_LIST.NONE,
		ITEM_ENUMS.EQUIP_SLOTS.CHEST: ITEM_ENUMS.ITEM_LIST.NONE,
		ITEM_ENUMS.EQUIP_SLOTS.LEGS: ITEM_ENUMS.ITEM_LIST.NONE,
		ITEM_ENUMS.EQUIP_SLOTS.BOOTS: ITEM_ENUMS.ITEM_LIST.NONE,
		ITEM_ENUMS.EQUIP_SLOTS.GLOVES: ITEM_ENUMS.ITEM_LIST.NONE
	}
	for slot in default_equip:
		equip(default_equip[slot])
	#print("hp_max: ", stats.max_hp, " defence: ", stats.armor, " speed: ", stats.movement_speed, " damage: ", stats.damage)


func _input(event):
	if event.is_action_pressed("mouse_click") && can_attack:
		var target = get_global_mouse_position()	
		velocity=Vector2(0,0)
		do_attack(target)
	
	elif can_move:
		var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		do_movement(move_direction)

func get_direction_post(direction):
	if (abs(direction.x) > abs(direction.y)):
		return "_h"
	else:
		if direction.y > 0:
			return "_down"
		else:
			return "_up"

func do_attack(target):
	var weapon_post = ""
	var equipped_weapon_type = item_db.ITEM_DESCRIPTIONS[equipped_armor[ITEM_ENUMS.EQUIP_SLOTS.WEAPON]].weapon_type
	if equipped_weapon_type == ITEM_ENUMS.WEAPON_TYPE.NONE:
		return
	elif equipped_weapon_type == ITEM_ENUMS.WEAPON_TYPE.DAGGER:
		weapon_post = "_dagger"
	elif equipped_weapon_type == ITEM_ENUMS.WEAPON_TYPE.SPEAR:
		weapon_post = "_spear"
	elif equipped_weapon_type == ITEM_ENUMS.WEAPON_TYPE.BOW:
		weapon_post = "_bow"
		
	can_move = false
	can_attack = false
	var direction = position.direction_to(target)
	attack_post = get_direction_post(direction)	
	if (direction.x < 0):
		sprite.scale.x = -1.0
	elif (direction.x > 0):
		sprite.scale.x = 1.0
	
	animation_player.play("attack" + attack_post + weapon_post)	
	attack_target = target
	
	
func spawn_attack():
#print(direction)
	#print("spawn atk")
	#var projectile_instance = projectile.instantiate()
	#projectile_instance.position = position
	#projectile_instance.position.y -= 25 #spawn at bow height
	#projectile_instance.position += position.direction_to(attack_target)*5 #spawn slightly in front of player model
	#
	#var attack_direction = projectile_instance.position.direction_to(attack_target)
	#projectile_instance.look_at(projectile_instance.position+attack_direction)
	#var modded_damage = stats.get_modded_damage(base_damage)
	#print("base damage: ", base_damage.damage)
	#print("modded_damage: ", modded_damage.damage)
	#projectile_instance.set_damage(modded_damage)
	#if equipped_armor[ITEM_ENUMS.EQUIP_SLOTS.WEAPON] == ITEM_ENUMS.ITEM_LIST.SPEAR:
		#projectile_instance.max_pierce = 2
	#else:	
		#projectile_instance.max_pierce = 0	
	#get_parent().add_child(projectile_instance)
	var projectile_instance = projectile.instantiate()
	var projectile_position = position
	projectile_position.y -= 25 #spawn at bow height
	projectile_position += position.direction_to(attack_target)*5 #spawn slightly in front of player model
	
	var modded_damage = stats.get_modded_damage(base_damage)
	#print("base damage: ", base_damage.damage)
	#print("modded_damage: ", modded_damage.damage)
	#projectile_instance.effects.append(EffectSpawnDuplicate.new())
	#projectile_instance.add_skill(skill_library.skill_dictionary["ON_HIT_DUPLICATE"])
	projectile_instance.init_effector(self, projectile_position, attack_target, modded_damage, StatModification.new({ATTRIBUTE_ENUMS.TYPE.MAX_HP: 2, ATTRIBUTE_ENUMS.TYPE.MOVEMENT_SPEED: 600}))
	get_parent().add_child(projectile_instance)
	


func do_movement(direction):
	#print("move 1")
	if direction.x == 0 and direction.y == 0:
		velocity = Vector2(0,0)
		animation_player.play("idle" + movement_post)
		return
	
	movement_post = get_direction_post(direction)
	
	if (direction.x < 0):
		sprite.scale.x = -1.0
	elif (direction.x > 0):
		sprite.scale.x = 1.0
		
	animation_player.play("walk" + movement_post)	
	
	velocity = direction*stats.movement_speed


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	can_move = true
	can_attack = true
	animation_player.play("idle" + attack_post)

func _on_enemy_award_exp(exp_amt: int):
	update_exp(exp_amt)
	
func update_exp(exp_amt: int):
	exp += exp_amt
	if exp >= exp_requirement:
		level += 1
		exp -= exp_requirement
		exp_requirement *= 1.5
		level_up.emit()
	exp_bar.update(float(exp)/float(exp_requirement))
	
#func modify_property_delta(property: String, delta_change: int):
	#print("modifying property ", property, " by value: ", delta_change)
	#var current_val = get(property)
	#var new_val = max(current_val + delta_change, 0)
	#if property == "hp":
		#new_val = min(stats.hp_max, new_val)
	#print("was: ", current_val, " is now: ", new_val)
	#set(property, new_val)
	
func add_to_inventory(item: ITEM_ENUMS.ITEM_LIST):
	if item not in inventory:
		inventory.append(item)
		
func do_item_stat_modifications(item: ITEM_ENUMS.ITEM_LIST, equip: bool):
	var modifications = item_db.ITEM_DESCRIPTIONS[item].get_stat_modifications()
	print(item_db.ITEM_DESCRIPTIONS[item])
	if not equip:
		modifications = modifications.invert()
	_modify_stats(modifications)
	if item_db.ITEM_DESCRIPTIONS[item].equip_slot == ITEM_ENUMS.EQUIP_SLOTS.WEAPON:
		base_damage = item_db.ITEM_DESCRIPTIONS[item].damage_modifications
		#print("updating player damage: ", base_damage)
	#var mult = 1 if equip else -1
	#for property in modifications:
		#modify_property_delta(property, mult*modifications[property])
		
func equip(item: ITEM_ENUMS.ITEM_LIST):
	#print("equip for item ", item)
	add_to_inventory(item)
	var equip_slot = item_db.ITEM_DESCRIPTIONS[item].equip_slot
	if equip_slot == ITEM_ENUMS.EQUIP_SLOTS.NONE:
		return
	if equipped_armor[equip_slot] != ITEM_ENUMS.ITEM_LIST.NONE:
		do_item_stat_modifications(equipped_armor[equip_slot], false)
	equipped_armor[equip_slot] = item
	do_item_stat_modifications(equipped_armor[equip_slot], true)
	
	var equipped_weapon_type = item_db.ITEM_DESCRIPTIONS[equipped_armor[ITEM_ENUMS.EQUIP_SLOTS.WEAPON]].weapon_type
	var idle_sprite = item_db.ITEM_DESCRIPTIONS[item].idle_sprite
	var attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D] = item_db.ITEM_DESCRIPTIONS[item].attack_sprites
	model.set_sprites_for_item(equip_slot, equipped_weapon_type, idle_sprite, attack_sprites)

func has_item(item: ITEM_ENUMS.ITEM_LIST):
	var item_equip_slot = item_db.ITEM_DESCRIPTIONS[item].equip_slot
	if item_equip_slot != ITEM_ENUMS.EQUIP_SLOTS.NONE:
		return equipped_armor[item_equip_slot] == item
	else:
		return true

func get_equipped_in_slot(slot: ITEM_ENUMS.EQUIP_SLOTS):
	if slot != ITEM_ENUMS.EQUIP_SLOTS.NONE:
		return equipped_armor[slot]
	else:
		return ITEM_ENUMS.ITEM_LIST.NONE
