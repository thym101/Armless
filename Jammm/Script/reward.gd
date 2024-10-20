extends Control

func _ready():
	$Highest.text = str(Global.highest_target_name) + ": " + str(Global.highest_target_value)
	$Second.text = str(Global.second_target_name) + ": " + str(Global.second_target_value)
