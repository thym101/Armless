 ##enemy_stat.gd
#extends Node
#
#var enemy_stats = {
	#"name": "",
	#"arm": 0,
	#"leg": 0,
	#"chest": 0,
	#"appendages": 0,
	#"sprite_path": "",
	#"frame_count": 0
#}
#
## Wolf enemy stats
#func set_wolf_stats():
	#enemy_stats = {
		#"name": "Dark Wolf",
		#"arm": 5,      
		#"leg": 8,       
		#"chest": 6,    
		#"appendages": 7, 
		#"sprite_path": "res://Monster/Hắc Lang - Black Wolf/TimberWolf.png",
		#"frame_count": 4
	#}
#
## Cyclops enemy stats
#func set_cyclops_stats():
	#enemy_stats = {
		#"name": "Crushing Cyclops",
		#"arm": 9,       
		#"leg": 6,      
		#"chest": 5,     
		#"appendages": 4, 
		#"sprite_path": "res://Monster/Khổng Lồ Một Mắt - Crushing Cyclops/Crushing Cyclops/CrushingCyclops.png",
		#"frame_count": 4
	#}
#
## Dragon enemy stats
#func set_dragon_stats():
	#enemy_stats = {
		#"name": "Bronze Dragon",
		#"arm": 7,      
		#"leg": 5,       
		#"chest": 9,     
		#"appendages": 4, 
		#"sprite_path": "res://Monster/Rồng Đồng - Bronze Dragon/Mature Bronze Dragon/MatureBronzeDragon.png",
		#"frame_count": 4
	#}
	#
#func set_cat_stats():
	#enemy_stats = {
		#"name": "Cruel Abominable Tyrant",
		#"arm": 4,      
		#"leg": 8,       
		#"chest": 5,     
		#"appendages": 7, 
		#"sprite_path": "res://Monster/Mèo - Cruel Abominable Tyrant (CAT)/Meowing Cat/MeowingCat.png",
		#"frame_count": 4
	#}
	#
#func set_wyrm_stats():
	#enemy_stats = {
		#"name": "Moss Wyrm",
		#"arm": 6,      
		#"leg": 4,       
		#"chest": 6,     
		#"appendages": 8, 
		#"sprite_path": "res://Monster/Rồng Rêu - Moss Wyrm/Adult Green Dragon/AdultGreenDragon.png",
		#"frame_count": 4
	#}
	#
#func set_gremlin_stats():
	#enemy_stats = {
		#"name": "Grinning Gremlin",
		#"arm": 4,      
		#"leg": 6,       
		#"chest": 5,     
		#"appendages": 9, 
		#"sprite_path": "res://Monster/Yêu Tinh Bay - Grinning Gremlin/grinning gremlin/GrinningGremlin.png",
		#"frame_count": 4
	#}
	#
#func set_serpant_stats():
	#enemy_stats = {
		#"name": "Swamp Serpant",
		#"arm": 5,      
		#"leg": 4,       
		#"chest": 5,     
		#"appendages": 8, 
		#"sprite_path": "res://Monster/Thủy Xà - Sea Serpent/Merfolk Aquamancer/MerfolkAquamancerIdleSide.png",
		#"frame_count": 4
	#}
	#
#func set_planetar_stats():
	#enemy_stats = {
		#"name": "Divine Planetar",
		#"arm": 6,      
		#"leg": 5,       
		#"chest": 7,     
		#"appendages": 6, 
		#"sprite_path": "res://Monster/Thần Tinh Tú - Divine Planetar/Divine Planetar/DivinePlanetar.png",
		#"frame_count": 4
	#}
	#
#func set_goblin_stats():
	#enemy_stats = {
		#"name": "Goblin Wolf Rider",
		#"arm": 6,      
		#"leg": 9,       
		#"chest": 4,     
		#"appendages": 6, 
		#"sprite_path": "res://Monster/Yêu Tinh Trinh Sát - Goblin Wolf Rider/goblin wolf rider/GoblinWolfRider.png",
		#"frame_count": 4
	#}
#
#
#func get_stats():
	#return enemy_stats
	#
#func increase_all_stats(percentage: float):
	#enemy_stats["arm"] = int(enemy_stats["arm"] * (1 + percentage))
	#enemy_stats["leg"] = int(enemy_stats["leg"] * (1 + percentage))
	#enemy_stats["chest"] = int(enemy_stats["chest"] * (1 + percentage))
	#enemy_stats["appendages"] = int(enemy_stats["appendages"] * (1 + percentage))


extends Node

# Base stats that will be modified permanently
var base_stats = {
	"wolf": {"arm": 5, "leg": 8, "chest": 6, "appendages": 7},
	"cyclops": {"arm": 9, "leg": 6, "chest": 5, "appendages": 4},
	"dragon": {"arm": 7, "leg": 5, "chest": 9, "appendages": 4},
	"cat": {"arm": 4, "leg": 8, "chest": 5, "appendages": 7},
	"wyrm": {"arm": 6, "leg": 4, "chest": 6, "appendages": 8},
	"gremlin": {"arm": 4, "leg": 6, "chest": 5, "appendages": 9},
	"serpant": {"arm": 5, "leg": 4, "chest": 5, "appendages": 8},
	"planetar": {"arm": 6, "leg": 5, "chest": 7, "appendages": 6},
	"goblin": {"arm": 6, "leg": 9, "chest": 4, "appendages": 6}
}

var enemy_stats = {
	"name": "",
	"arm": 0,
	"leg": 0,
	"chest": 0,
	"appendages": 0,
	"sprite_path": "",
	"frame_count": 0
}

# Function to increase all base stats permanently
func increase_all_base_stats(percentage: float):
	for enemy in base_stats.keys():
		for stat in base_stats[enemy].keys():
			base_stats[enemy][stat] = int(base_stats[enemy][stat] * (1 + percentage))

# Modified set functions to use base_stats
func set_wolf_stats():
	enemy_stats = {
		"name": "Dark  Wolf",
		"arm": base_stats["wolf"]["arm"],
		"leg": base_stats["wolf"]["leg"],
		"chest": base_stats["wolf"]["chest"],
		"appendages": base_stats["wolf"]["appendages"],
		"sprite_path": "res://Monster/Hắc Lang - Black Wolf/TimberWolf.png",
		"frame_count": 4
	}

func set_cyclops_stats():
	enemy_stats = {
		"name": "Crushing  Cyclops",
		"arm": base_stats["cyclops"]["arm"],
		"leg": base_stats["cyclops"]["leg"],
		"chest": base_stats["cyclops"]["chest"],
		"appendages": base_stats["cyclops"]["appendages"],
		"sprite_path": "res://Monster/Khổng Lồ Một Mắt - Crushing Cyclops/Crushing Cyclops/CrushingCyclops.png",
		"frame_count": 4
	}

func set_dragon_stats():
	enemy_stats = {
		"name": "Bronze  Dragon",
		"arm": base_stats["dragon"]["arm"],
		"leg": base_stats["dragon"]["leg"],
		"chest": base_stats["dragon"]["chest"],
		"appendages": base_stats["dragon"]["appendages"],
		"sprite_path": "res://Monster/Rồng Đồng - Bronze Dragon/Mature Bronze Dragon/MatureBronzeDragon.png",
		"frame_count": 4
	}
	
func set_cat_stats():
	enemy_stats = {
		"name": "Cruel  Abominable  Tyrant",
		"arm": base_stats["cat"]["arm"],
		"leg": base_stats["cat"]["leg"],
		"chest": base_stats["cat"]["chest"],
		"appendages": base_stats["cat"]["appendages"],
		"sprite_path": "res://Monster/Mèo - Cruel Abominable Tyrant (CAT)/Meowing Cat/MeowingCat.png",
		"frame_count": 4
	}
	
func set_wyrm_stats():
	enemy_stats = {
		"name": "Moss  Wyrm",
		"arm": base_stats["wyrm"]["arm"],
		"leg": base_stats["wyrm"]["leg"],
		"chest": base_stats["wyrm"]["chest"],
		"appendages": base_stats["wyrm"]["appendages"],
		"sprite_path": "res://Monster/Rồng Rêu - Moss Wyrm/Adult Green Dragon/AdultGreenDragon.png",
		"frame_count": 4
	}
	
func set_gremlin_stats():
	enemy_stats = {
		"name": "Grinning  Gremlin",
		"arm": base_stats["gremlin"]["arm"],
		"leg": base_stats["gremlin"]["leg"],
		"chest": base_stats["gremlin"]["chest"],
		"appendages": base_stats["gremlin"]["appendages"],
		"sprite_path": "res://Monster/Yêu Tinh Bay - Grinning Gremlin/grinning gremlin/GrinningGremlin.png",
		"frame_count": 4
	}
	
func set_serpant_stats():
	enemy_stats = {
		"name": "Swamp  Serpent",
		"arm": base_stats["serpant"]["arm"],
		"leg": base_stats["serpant"]["leg"],
		"chest": base_stats["serpant"]["chest"],
		"appendages": base_stats["serpant"]["appendages"],
		"sprite_path": "res://Monster/Thủy Xà - Sea Serpent/Merfolk Aquamancer/MerfolkAquamancerIdleSide.png",
		"frame_count": 4
	}
	
func set_planetar_stats():
	enemy_stats = {
		"name": "Divine  Planetar",
		"arm": base_stats["planetar"]["arm"],
		"leg": base_stats["planetar"]["leg"],
		"chest": base_stats["planetar"]["chest"],
		"appendages": base_stats["planetar"]["appendages"],
		"sprite_path": "res://Monster/Thần Tinh Tú - Divine Planetar/Divine Planetar/DivinePlanetar.png",
		"frame_count": 4
	}
	
func set_goblin_stats():
	enemy_stats = {
		"name": "Goblin  Wolf  Rider",
		"arm": base_stats["goblin"]["arm"],
		"leg": base_stats["goblin"]["leg"],
		"chest": base_stats["goblin"]["chest"],
		"appendages": base_stats["goblin"]["appendages"],
		"sprite_path": "res://Monster/Yêu Tinh Trinh Sát - Goblin Wolf Rider/goblin wolf rider/GoblinWolfRider.png",
		"frame_count": 4
	}

func set_witch_stats():
	enemy_stats = {
		"name": "The  Witch",
		"arm": 100,
		"leg": 100,
		"chest": 100,
		"appendages": 100,
		"sprite_path": "res://witch_flip_edit.png",
		"frame_count": 4
	}

# Do the same for other set_*_stats functions...

func get_stats():
	return enemy_stats
