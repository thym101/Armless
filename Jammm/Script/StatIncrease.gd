extends Control

var player_stats = CharactorStat.get_stats()

var add_point_arm = 0
var add_point_leg = 0
var add_point_chest = 0
var add_point_appendages = 0

func _process(delta):
	$Point.text = "Point: " + str(Global.additionalPoint)
	$Arm/Arm.text = "Arm: " + str(player_stats["arm"])
	$Leg/Leg.text = "Leg: " + str(player_stats["leg"])
	$Chest/Chest.text = "Chest: " + str(player_stats["chest"])
	$Appendages/Appendages.text = "Appendages: " + str(player_stats["appendages"])

func _on_arm_left_pressed():
	if add_point_arm > 0:
		CharactorStat.update_stats("arm", -1)
		Global.additionalPoint += 1
		add_point_arm -= 1

func _on_arm_right_pressed():
	if Global.additionalPoint > 0:
		CharactorStat.update_stats("arm", 1)
		Global.additionalPoint -= 1
		add_point_arm += 1


func _on_leg_left_pressed():
	if add_point_leg > 0:
		CharactorStat.update_stats("leg", -1)
		Global.additionalPoint += 1
		add_point_leg -= 1


func _on_leg_right_pressed():
	if Global.additionalPoint > 0:
		CharactorStat.update_stats("leg", 1)
		Global.additionalPoint -= 1
		add_point_leg += 1


func _on_chest_left_pressed():
	if add_point_chest > 0:
		CharactorStat.update_stats("chest", -1)
		Global.additionalPoint += 1
		add_point_chest -= 1


func _on_chest_right_pressed():
	if Global.additionalPoint > 0:
		CharactorStat.update_stats("chest", 1)
		Global.additionalPoint -= 1
		add_point_chest += 1


func _on_appendages_left_pressed():
	if add_point_appendages > 0:
		CharactorStat.update_stats("appendages", -1)
		Global.additionalPoint += 1
		add_point_appendages -= 1


func _on_appendages_right_pressed():
	if Global.additionalPoint > 0:
		CharactorStat.update_stats("appendages", 1)
		Global.additionalPoint -= 1
		add_point_appendages += 1


func _on_quit_pressed():
	if Global.additionalPoint <= 0:
		get_tree().change_scene_to_file("res://Scene/level_select.tscn")
