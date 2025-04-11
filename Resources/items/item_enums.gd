class_name ITEM_ENUMS

enum ARMOR_SETS {
	NONE=0,
	CLOTH=1,
	LEATHER=2,
	CHAINMAIL=3,
	PLATE=4
}

enum WEAPON_SETS {
	NONE=0,
	DAGGER=1,
	SPEAR=2,
	BOW=3
}

enum EQUIP_SLOTS {
	NONE=0,
	HEAD=1,
	SHOULDER=2,
	CHEST=3,
	LEGS=4,
	BOOTS=5,
	GLOVES=6,
	WEAPON=7
}

#enum ITEM_TYPE {
	#INVALID=0,
	#WEAPON=1,
	#ARMOR=2
#}

enum WEAPON_TYPE {
	NONE=0,
	DAGGER=1,
	SPEAR=2,
	BOW=3
}

#enum ARMOR_TYPE {
	#NONE=0,
	#HEAD=1,
	#SHOULDER=2,
	#CHEST=3,
	#LEGS=4,
	#BOOTS=5,
	#GLOVES=6
#}

enum ITEM_LIST {
	NONE,
	#HEAD
	CLOTH_HEAD,
	LEATHER_HEAD,
	CHAINMAIL_HEAD,
	PLATE_HEAD,
	#SHOULDER
	LEATHER_SHOULDER,
	PLATE_SHOULDER,
	#CHEST
	CLOTH_CHEST,
	LEATHER_CHEST,
	CHAINMAIL_CHEST,
	PLATE_CHEST,
	#LEGS
	CLOTH_LEGS,
	PLATE_LEGS,
	#BOOTS
	CLOTH_BOOTS,
	PLATE_BOOTS,
	#GLOVES
	PLATE_GLOVES,
	#WEAPONS
	DAGGER,
	SPEAR,
	BOW
}
