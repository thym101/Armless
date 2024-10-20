extends Control

@onready var highest_label = $Control/Highest
@onready var second_label = $Control/Second

func _ready():
	#$TextureRect.hide()
	
	$Control/Highest.text = str(Global.highest_target_name) + ": " + str(Global.highest_target_value)
	$Control/Second.text = str(Global.second_target_name) + ": " + str(Global.second_target_value)

