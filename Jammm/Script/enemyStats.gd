 #enemy_stat.gd
extends Node

var enemy_stats = {
	"name": "",
	"arm": 0,
	"leg": 0,
	"chest": 0,
	"appendages": 0,
	"sprite_path": "",
	"frame_count": 0
}

# Wolf enemy stats
func set_wolf_stats():
	enemy_stats = {
		"name": "Dark Wolf",
		"arm": 5,      
		"leg": 8,       
		"chest": 6,    
		"appendages": 7, 
		"sprite_path": "res://Monster/Hắc Lang - Black Wolf/TimberWolf.png",
		"frame_count": 4
	}

# Cyclops enemy stats
func set_cyclops_stats():
	enemy_stats = {
		"name": "Crushing Cyclops",
		"arm": 9,       
		"leg": 6,      
		"chest": 5,     
		"appendages": 4, 
		"sprite_path": "res://Monster/Khổng Lồ Một Mắt - Crushing Cyclops/Crushing Cyclops/CrushingCyclops.png",
		"frame_count": 4
	}

# Dragon enemy stats
func set_dragon_stats():
	enemy_stats = {
		"name": "Bronze Dragon",
		"arm": 7,      
		"leg": 5,       
		"chest": 9,     
		"appendages": 4, 
		"sprite_path": "res://Monster/Rồng Đồng - Bronze Dragon/Mature Bronze Dragon/MatureBronzeDragon.png",
		"frame_count": 4
	}
	
func set_cat_stats():
	enemy_stats = {
		"name": "Cruel Abominable Tyrant",
		"arm": 4,      
		"leg": 8,       
		"chest": 5,     
		"appendages": 7, 
		"sprite_path": "res://Monster/Mèo - Cruel Abominable Tyrant (CAT)/Meowing Cat/MeowingCat.png",
		"frame_count": 4
	}
	
func set_wyrm_stats():
	enemy_stats = {
		"name": "Moss Wyrm",
		"arm": 6,      
		"leg": 4,       
		"chest": 6,     
		"appendages": 8, 
		"sprite_path": "res://Monster/Rồng Rêu - Moss Wyrm/Adult Green Dragon/AdultGreenDragon.png",
		"frame_count": 4
	}
	
func set_gremlin_stats():
	enemy_stats = {
		"name": "Grinning Gremlin",
		"arm": 4,      
		"leg": 6,       
		"chest": 5,     
		"appendages": 9, 
		"sprite_path": "res://Monster/Yêu Tinh Bay - Grinning Gremlin/grinning gremlin/GrinningGremlin.png",
		"frame_count": 4
	}
	
func set_serpant_stats():
	enemy_stats = {
		"name": "Swamp Serpant",
		"arm": 5,      
		"leg": 4,       
		"chest": 5,     
		"appendages": 8, 
		"sprite_path": "res://Monster/Thủy Xà - Sea Serpent/Merfolk Aquamancer/MerfolkAquamancerIdleSide.png",
		"frame_count": 4
	}
	
func set_planetar_stats():
	enemy_stats = {
		"name": "Divine Planetar",
		"arm": 6,      
		"leg": 5,       
		"chest": 7,     
		"appendages": 6, 
		"sprite_path": "res://Monster/Thần Tinh Tú - Divine Planetar/Divine Planetar/DivinePlanetar.png",
		"frame_count": 4
	}
	
func set_goblin_stats():
	enemy_stats = {
		"name": "Goblin Wolf Rider",
		"arm": 6,      
		"leg": 9,       
		"chest": 4,     
		"appendages": 6, 
		"sprite_path": "res://Monster/Yêu Tinh Trinh Sát - Goblin Wolf Rider/goblin wolf rider/GoblinWolfRider.png",
		"frame_count": 4
	}


func get_stats():
	return enemy_stats
