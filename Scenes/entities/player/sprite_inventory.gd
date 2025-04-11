extends Sprite2D
@onready var head_equip = $head_equip
@onready var shoulder_equip = $shoulder_equip
@onready var chest_equip = $chest_equip
@onready var legs_equip = $legs_equip
@onready var boots_equip = $boots_equip
@onready var gloves_equip = $gloves_equip
@onready var weapon_equip = $weapon_equip

#var item_enums = preload("res://Scenes/items/item_enums.gd")
#var armor_sets = iterm_enums.ARMOR_SETS
#
#enum armor_sets {
	#NONE=0,
	#CLOTH=1,
	#LEATHER=2,
	#CHAINMAIL=3,
	#PLATE=4
#}
#
#enum weapon_sets {
	#NONE=0,
	#DAGGER=1,
	#SPEAR=2,
	#BOW=3
#}
#
#class StateSpriteRootPathCollection:
	#var idle: String
	#var attack: String
	#
	#func _init(_idle: String, _attack: String):
		#idle = _idle
		#attack = _attack
#
#class ArmorSpriteFileCollection:
	#var idle: String
	#var attack: String
	#
	#func _init(_idle: String, _attack: String):
		#idle = _idle
		#attack = _attack
		

## resource definition method
var equipped_weapon_type: ITEM_ENUMS.WEAPON_TYPE = ITEM_ENUMS.WEAPON_TYPE.NONE

class ItemSprites:
	var idle_sprite: Texture2D
	var attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]
	
	func get_idle_sprite():
		return idle_sprite
	
	func get_attack_sprite(weapon_type: ITEM_ENUMS.WEAPON_TYPE):
		if weapon_type in attack_sprites:	
			return attack_sprites[weapon_type]
		return null

var head_slot = ItemSprites.new()
var shoulder_slot = ItemSprites.new()
var chest_slot = ItemSprites.new()
var legs_slot = ItemSprites.new()
var boots_slot = ItemSprites.new()
var gloves_slot = ItemSprites.new()
var weapon_slot = ItemSprites.new()

func set_sprites_for_item(equip_slot: ITEM_ENUMS.EQUIP_SLOTS, new_weapon_type: ITEM_ENUMS.WEAPON_TYPE, idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	if equip_slot == ITEM_ENUMS.EQUIP_SLOTS.HEAD:
		_set_sprites_for_head(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.SHOULDER:
		_set_sprites_for_shoulder(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.CHEST:
		_set_sprites_for_chest(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.LEGS:
		_set_sprites_for_legs(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.BOOTS:
		_set_sprites_for_boots(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.GLOVES:
		_set_sprites_for_gloves(idle_sprite, attack_sprites)
	elif equip_slot == ITEM_ENUMS.EQUIP_SLOTS.WEAPON:
		equipped_weapon_type = new_weapon_type
		_set_sprites_for_weapon(idle_sprite, attack_sprites)
	else:
		pass

func _set_sprites_for_head(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	head_slot.idle_sprite = idle_sprite
	head_slot.attack_sprites = attack_sprites

func _set_sprites_for_shoulder(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	shoulder_slot.idle_sprite = idle_sprite
	shoulder_slot.attack_sprites = attack_sprites

func _set_sprites_for_chest(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	chest_slot.idle_sprite = idle_sprite
	chest_slot.attack_sprites = attack_sprites

func _set_sprites_for_legs(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	legs_slot.idle_sprite = idle_sprite
	legs_slot.attack_sprites = attack_sprites

func _set_sprites_for_boots(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	boots_slot.idle_sprite = idle_sprite
	boots_slot.attack_sprites = attack_sprites

func _set_sprites_for_gloves(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	gloves_slot.idle_sprite = idle_sprite
	gloves_slot.attack_sprites = attack_sprites

func _set_sprites_for_weapon(idle_sprite: Texture2D, attack_sprites: Dictionary[ITEM_ENUMS.WEAPON_TYPE, Texture2D]):
	weapon_slot.idle_sprite = idle_sprite
	weapon_slot.attack_sprites = attack_sprites

func _reload_idle_sprites(start_frame: int, hframe_size: int, vframe_size: int):
	_sprite_load_else_invis(head_equip, head_slot.get_idle_sprite())
	_sprite_load_else_invis(shoulder_equip, shoulder_slot.get_idle_sprite())
	_sprite_load_else_invis(chest_equip, chest_slot.get_idle_sprite())
	_sprite_load_else_invis(legs_equip, legs_slot.get_idle_sprite())
	_sprite_load_else_invis(boots_equip, boots_slot.get_idle_sprite())
	_sprite_load_else_invis(gloves_equip, gloves_slot.get_idle_sprite())
	_sprite_load_else_invis(weapon_equip, weapon_slot.get_idle_sprite())
	_set_hvframes(hframe_size, vframe_size)
	_set_frame(start_frame)

func _reload_attack_sprites(start_frame: int, hframe_size: int, vframe_size: int):
	_sprite_load_else_invis(head_equip, head_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(shoulder_equip, shoulder_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(chest_equip, chest_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(legs_equip, legs_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(boots_equip, boots_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(gloves_equip, gloves_slot.get_attack_sprite(equipped_weapon_type))
	_sprite_load_else_invis(weapon_equip, weapon_slot.get_attack_sprite(equipped_weapon_type))
	_set_hvframes(hframe_size, vframe_size)
	_set_frame(start_frame)
	
func _sprite_load_else_invis(sprite: Sprite2D, texture: Texture2D):
	if texture != null:
		sprite.texture = texture
		sprite.visible = true
	else:
		sprite.visible = false
		
func _set_frame(frame_id: int):
	frame = frame_id
	var children = get_children()
	for sprite in children:
		#print(" set frame " , frame_id, " for: ", sprite.name)
		sprite.frame = frame_id

func _set_hvframes(new_hframes: int, new_vframes: int):
	hframes = new_hframes
	vframes = new_vframes
	var children = get_children()
	for sprite in children:
		#print(" set hframes vframes " , new_hframes, " ", new_vframes, " for: ", sprite.name)
		sprite.hframes = new_hframes
		sprite.vframes = new_vframes

## string concantination method. file structure dependent.
#@export var idle_animation_root = "res://Assets/character_sprites/walkcycle/"
#
#class ItemSlot:
	#var item_db: Dictionary
	#var item_class: int
	#
	#func _init(_item_db, _item_class):
		#item_class = _item_class
		#item_db = _item_db
	#
	#func get_db_result():
		#if item_class in item_db:
			#return item_db[item_class]
		#else:
			#return item_db[0]
	#
	#func set_item_class(val: int):
		#item_class = val
		#
#var weapon_slot = ItemSlot.new({
											#ITEM_ENUMS.WEAPON_SETS.NONE: ["", ""],
											#ITEM_ENUMS.WEAPON_SETS.DAGGER: ["res://Assets/character_sprites/dagger/", "WEAPON_dagger.png"],
											#ITEM_ENUMS.WEAPON_SETS.SPEAR: ["res://Assets/character_sprites/spear/", "WEAPON_spear.png"],
											#ITEM_ENUMS.WEAPON_SETS.BOW: ["res://Assets/character_sprites/bow/", "WEAPON_bow.png"]
										#}, 
											#ITEM_ENUMS.WEAPON_SETS.NONE)
											#
#
#var head_slot = ItemSlot.new({
										#ITEM_ENUMS.ARMOR_SETS.NONE: "HEAD_hair_blonde.png",
										#ITEM_ENUMS.ARMOR_SETS.CLOTH: "HEAD_robe_hood.png",
										#ITEM_ENUMS.ARMOR_SETS.LEATHER: "HEAD_leather_armor_hat.png",
										#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "HEAD_chain_armor_helmet",
										#ITEM_ENUMS.ARMOR_SETS.PLATE: "HEAD_plate_armor_helmet.png"
									#},
									#ITEM_ENUMS.ARMOR_SETS.NONE)
									#
#
#var shoulder_slot = ItemSlot.new({
											#ITEM_ENUMS.ARMOR_SETS.NONE: "",
											#ITEM_ENUMS.ARMOR_SETS.CLOTH: "",
											#ITEM_ENUMS.ARMOR_SETS.LEATHER: "TORSO_leather_armor_shoulders.png",
											#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "",
											#ITEM_ENUMS.ARMOR_SETS.PLATE: "TORSO_plate_armor_arms_shoulders.png"
										#},
										#ITEM_ENUMS.ARMOR_SETS.NONE)
										#
#
#var chest_slot = ItemSlot.new({
										#ITEM_ENUMS.ARMOR_SETS.NONE: "",
										#ITEM_ENUMS.ARMOR_SETS.CLOTH: "TORSO_robe_shirt_brown.png",
										#ITEM_ENUMS.ARMOR_SETS.LEATHER: "TORSO_leather_armor_torso.png",
										#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "TORSO_chain_armor_torso.png",
										#ITEM_ENUMS.ARMOR_SETS.PLATE: "TORSO_plate_armor_torso.png"
									#},
									#ITEM_ENUMS.ARMOR_SETS.NONE)
#
#var legs_slot = ItemSlot.new({
										#ITEM_ENUMS.ARMOR_SETS.NONE: "",
										#ITEM_ENUMS.ARMOR_SETS.CLOTH: "LEGS_pants_greenish.png",
										#ITEM_ENUMS.ARMOR_SETS.LEATHER: "",
										#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "",
										#ITEM_ENUMS.ARMOR_SETS.PLATE: "LEGS_plate_armor_pants.png"
									#},
									#ITEM_ENUMS.ARMOR_SETS.NONE)
#
#var boots_slot = ItemSlot.new({
										#ITEM_ENUMS.ARMOR_SETS.NONE: "",
										#ITEM_ENUMS.ARMOR_SETS.CLOTH: "FEET_shoes_brown.png",
										#ITEM_ENUMS.ARMOR_SETS.LEATHER: "",
										#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "",
										#ITEM_ENUMS.ARMOR_SETS.PLATE: "FEET_plate_armor_shoes.png"
									#},
									#ITEM_ENUMS.ARMOR_SETS.NONE)
#
#var gloves_slot = ItemSlot.new({
										#ITEM_ENUMS.ARMOR_SETS.NONE: "",
										#ITEM_ENUMS.ARMOR_SETS.CLOTH: "",
										#ITEM_ENUMS.ARMOR_SETS.LEATHER: "",
										#ITEM_ENUMS.ARMOR_SETS.CHAINMAIL: "",
										#ITEM_ENUMS.ARMOR_SETS.PLATE: "HANDS_plate_armor_gloves.png"
									#},
									#ITEM_ENUMS.ARMOR_SETS.NONE)
#
#@onready var head_equip = $head_equip
#@onready var shoulder_equip = $shoulder_equip
#@onready var chest_equip = $chest_equip
#@onready var legs_equip = $legs_equip
#@onready var boots_equip = $boots_equip
#@onready var gloves_equip = $gloves_equip
#@onready var weapon_equip = $weapon_equip
##
##var armor_file: String = ""
##var idle_root: String = ""
##var attack_root: String = ""
#
##
##func _ready():
	##_reload_idle_sprites(0, 9, 4)
#
#func _sprite_load_else_invis(sprite: Sprite2D, string: String):
	#if string != "":
		#sprite.texture = load(string)
		#sprite.visible = true
	#else:
		#sprite.visible = false
		#
#func _reload_idle_sprites(start_frame: int, hframe_size: int, vframe_size: int):
	#_sprite_load_else_invis(head_equip, _resolve_sprite_path(idle_animation_root, head_slot.get_db_result()))
	#_sprite_load_else_invis(shoulder_equip, _resolve_sprite_path(idle_animation_root, shoulder_slot.get_db_result()))
	#_sprite_load_else_invis(chest_equip, _resolve_sprite_path(idle_animation_root, chest_slot.get_db_result()))
	#_sprite_load_else_invis(legs_equip, _resolve_sprite_path(idle_animation_root, legs_slot.get_db_result()))
	#_sprite_load_else_invis(boots_equip, _resolve_sprite_path(idle_animation_root, boots_slot.get_db_result()))
	#_sprite_load_else_invis(gloves_equip, _resolve_sprite_path(idle_animation_root, gloves_slot.get_db_result()))
	#_sprite_load_else_invis(weapon_equip, _resolve_sprite_path(idle_animation_root, weapon_slot.get_db_result()[1]))
	#_set_hvframes(hframe_size, vframe_size)
	#_set_frame(start_frame)
	#
	#
	##head_equip.texture = load(_resolve_sprite_path(idle_animation_root, head_slot.get_db_result()))
	##shoulder_equip.texture = load(_resolve_sprite_path(idle_animation_root, shoulder_slot.get_db_result()))
	##chest_equip.texture = load(_resolve_sprite_path(idle_animation_root, chest_slot.get_db_result()))
	##legs_equip.texture = load(_resolve_sprite_path(idle_animation_root, legs_slot.get_db_result()))
	##boots_equip.texture = load(_resolve_sprite_path(idle_animation_root, boots_slot.get_db_result()))
	##gloves_equip.texture = load(_resolve_sprite_path(idle_animation_root, gloves_slot.get_db_result()))
#
#func _reload_attack_sprites(start_frame: int, hframe_size: int, vframe_size: int):
	#_sprite_load_else_invis(head_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], head_slot.get_db_result()))
	#_sprite_load_else_invis(shoulder_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], shoulder_slot.get_db_result()))
	#_sprite_load_else_invis(chest_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], chest_slot.get_db_result()))
	#_sprite_load_else_invis(legs_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], legs_slot.get_db_result()))
	#_sprite_load_else_invis(boots_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], boots_slot.get_db_result()))
	#_sprite_load_else_invis(gloves_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], gloves_slot.get_db_result()))
	#_sprite_load_else_invis(weapon_equip, _resolve_sprite_path(weapon_slot.get_db_result()[0], weapon_slot.get_db_result()[1]))
	#_set_hvframes(hframe_size, vframe_size)
	#_set_frame(start_frame)
	#
	##head_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], head_slot.get_db_result()))
	##shoulder_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], shoulder_slot.get_db_result()))
	##chest_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], chest_slot.get_db_result()))
	##legs_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], legs_slot.get_db_result()))
	##boots_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], boots_slot.get_db_result()))
	##gloves_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], gloves_slot.get_db_result()))
	##weapon_equip.texture = load(_resolve_sprite_path(weapon_slot.get_db_result()[0], weapon_slot.get_db_result()[1]))
	#
#
#func _resolve_sprite_path(root: String, file: String):
	#if root == "" or file == "":
		#return ""
	#return root + file
#
#func _set_frame(frame_id: int):
	#frame = frame_id
	#var children = get_children()
	#for sprite in children:
		##print(" set frame " , frame_id, " for: ", sprite.name)
		#sprite.frame = frame_id
#
#func _set_hvframes(new_hframes: int, new_vframes: int):
	#hframes = new_hframes
	#vframes = new_vframes
	#var children = get_children()
	#for sprite in children:
		##print(" set hframes vframes " , new_hframes, " ", new_vframes, " for: ", sprite.name)
		#sprite.hframes = new_hframes
		#sprite.vframes = new_vframes
	#
	#
#
#func equip_weapon(weapon_id: ITEM_ENUMS.WEAPON_SETS):
	#weapon_slot.set_item_class(weapon_id)
#
#func equip_head(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#head_slot.set_item_class(armor_id)
#
#func equip_shoulder(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#shoulder_slot.set_item_class(armor_id)
#
#func equip_chest(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#chest_slot.set_item_class(armor_id)
#
#func equip_legs(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#legs_slot.set_item_class(armor_id)
#
#func equip_boots(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#boots_slot.set_item_class(armor_id)
#
#func equip_gloves(armor_id: ITEM_ENUMS.ARMOR_SETS):
	#gloves_slot.set_item_class(armor_id)
