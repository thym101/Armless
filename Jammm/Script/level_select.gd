extends Control

class_name LevelSelect

@onready var current_level: LevelIcon = $LevelIcon
var current_world: int = 0
var player_stats = CharactorStat.get_stats()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Path2D/PathFollow2D/PlayerIcon.global_position = current_level.global_position
	$PlayerStats.text = "Arm: " + str(player_stats.arm) + "\n" + "Leg: " + str(player_stats.leg) + "\n" + "Chest: " + str(player_stats.chest) + "\n" + "Appendages: " + str(player_stats.appendages)  

func _input(event):
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		current_level = current_level.next_level_left
		$Path2D/PathFollow2D/PlayerIcon.global_position = current_level.global_position
	
	if event.is_action_pressed("ui_right") and current_level.next_level_right:
		current_level = current_level.next_level_right
		$Path2D/PathFollow2D/PlayerIcon.global_position = current_level.global_position
	
	if event.is_action_pressed("ui_down") and current_level.next_level_down:
		current_level = current_level.next_level_down
		$Path2D/PathFollow2D/PlayerIcon.global_position = current_level.global_position
	
	if event.is_action_pressed("ui_up") and current_level.next_level_up:
		current_level = current_level.next_level_up
		$Path2D/PathFollow2D/PlayerIcon.global_position = current_level.global_position
		
	if event.is_action_pressed("ui_accept"):  # Enter key
		set_enemy_for_level()
		get_tree().change_scene_to_file("res://Scene/background.tscn")

func set_enemy_for_level():
	# Set enemy based on level
	match current_level.level_name:
		"1":
			EnemyStats.set_wolf_stats()
		"2":
			EnemyStats.set_cyclops_stats()
		"3":
			EnemyStats.set_dragon_stats()
		"4":
			EnemyStats.set_cat_stats()
		"5":
			EnemyStats.set_wyrm_stats()
		"6":
			EnemyStats.set_gremlin_stats()
		"7":
			EnemyStats.set_serpant_stats()
		"8":
			EnemyStats.set_planetar_stats()
		"9":
			EnemyStats.set_goblin_stats()
			
