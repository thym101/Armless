extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuScreen/Control/Speed.pressed.connect(_on_speed_pressed)
	$MenuScreen/Control2/Attack.pressed.connect(_on_attack_pressed)
	$MenuScreen/Panel/Health.pressed.connect(_on_health_pressed)

func _on_speed_pressed():
	CharactorStat.set_speed_stats()
	print("Speed stats set: ", CharactorStat.get_stats())
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")

func _on_attack_pressed():
	CharactorStat.set_attack_stats()
	print("Attack stats set: ", CharactorStat.get_stats())
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")

func _on_health_pressed():
	CharactorStat.set_health_stats()
	print("Health stats set: ", CharactorStat.get_stats())
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")
