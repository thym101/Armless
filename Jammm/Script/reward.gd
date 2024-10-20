extends Control

var player_stats = CharactorStat.get_stats()

func _ready():
	$Control/Highest.text = str(Global.highest_target_name) + ": " + str(Global.highest_target_value)
	$Control/Second.text = str(Global.second_target_name) + ": " + str(Global.second_target_value)
	

func _on_forgive_pressed():
	Global.additionalPoint = 15
	if Global.streak == 2:
		Global.streak
		get_tree().change_scene_to_file("res://Scene/stat_increase.tscn")
	else: 
		Global.streak += 1
		get_tree().change_scene_to_file("res://Scene/level_select.tscn")

func _on_kill_pressed():
	var highest_stat = Global.highest_target_name.to_lower()
	var second_stat = Global.second_target_name.to_lower()
	
	EnemyStats.increase_all_base_stats(0.3)
	
	CharactorStat.update_stats(highest_stat, Global.highest_target_value * 0.7)
	CharactorStat.update_stats(second_stat, Global.second_target_value * 0.7)
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")
