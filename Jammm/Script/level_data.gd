# level_data.gd
extends Node

# Define monsters for each level
const LEVEL_DATA = {
	"1": {
		"monster_type": "fenrir",
		"monster_level": 1,
		"battle_scene": "res://scenes/battle.tscn",
		"background": "res://assets/backgrounds/forest.png",
		"monster_stats": {
			"name": "Fenrir",
			"arm": 5,
			"leg": 6,
			"chest": 4,
			"appendages": 5,
			"base_health": 60,
			"base_damage": 12,
			"sprite_path": "res://Monster/Hắc Lang - Black Wolf/TimberWolf.png",
			"frame_count": 4,
			"level_scaling": 1.1,
			"exp_reward": 40
		}
	},
	"2": {
		"monster_type": "placidusax",
		"monster_level": 2,
		"battle_scene": "res://scenes/battle.tscn",
		"background": "res://assets/backgrounds/mountain.png",
		"monster_stats": {
			"name": "Placidusax",
			"arm": 7,
			"leg": 6,
			"chest": 8,
			"appendages": 7,
			"base_health": 100,
			"base_damage": 18,
			"sprite_path": "res://Monster/Rồng Đồng - Bronze Dragon/Mature Bronze Dragon/MatureBronzeDragon.png",
			"frame_count": 4,
			"level_scaling": 1.2,
			"exp_reward": 60
		}
	},
	# Add more levels as needed
}

# Get level data or return null if level doesn't exist
func get_level_data(level_name: String) -> Dictionary:
	if LEVEL_DATA.has(level_name):
		return LEVEL_DATA[level_name]
	return {}

# Register the monster type if it doesn't exist
func register_level_monster(level_data: Dictionary):
	if not MonsterData.MONSTER_TEMPLATES.has(level_data.monster_type):
		MonsterData.MONSTER_TEMPLATES[level_data.monster_type] = level_data.monster_stats
