extends Control

var player_stats = CharactorStat.get_stats()
var enemy_stats
var count = 0

func _ready():
	$Control/Highest.text = str(Global.highest_target_name) + ": " + str(Global.highest_target_value)
	$Control/Second.text = str(Global.second_target_name) + ": " + str(Global.second_target_value)
	
	enemy_stats = EnemyStats.get_stats()
	setup_enemy_animation()
	$Control/Monster/AnimatedSprite2D.play("idle")
	
func _on_forgive_pressed():
	Global.additionalPoint = 15
	Global.streak += 1
	count += 1
	
	if count == 3:
		Global.hearth += 1
		count = 0
		
	if Global.streak == 2:
		Global.streak = 0
		get_tree().change_scene_to_file("res://Scene/stat_increase.tscn")
	else: 
		get_tree().change_scene_to_file("res://Scene/level_select.tscn")

func _on_kill_pressed():
	var highest_stat = Global.highest_target_name.to_lower()
	var second_stat = Global.second_target_name.to_lower()
	
	EnemyStats.increase_all_base_stats(0.3)
	
	CharactorStat.update_stats(highest_stat, Global.highest_target_value * 0.7)
	CharactorStat.update_stats(second_stat, Global.second_target_value * 0.7)
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")

func setup_enemy_animation():
	var sprite_frames = SpriteFrames.new()
	var texture = load(Global.sprite_path)
	var frame_width = texture.get_width() / Global.frame_count
	var frame_height = texture.get_height()
	
	sprite_frames.add_animation("idle")
	sprite_frames.set_animation_speed("idle", 4)
	sprite_frames.set_animation_loop("idle", true)
	
	for i in range(Global.frame_count):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * frame_width, 0, frame_width, frame_height)
		sprite_frames.add_frame("idle", atlas)
	
	$Control/Monster/AnimatedSprite2D.sprite_frames = sprite_frames
