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
	
	setup_idle_animation()
	
	$AnimatedSprite2D.play("idle")
	
func setup_idle_animation():
	var sprite_frames = SpriteFrames.new()
	var texture = load(player_stats.sprite_path)
	var frame_width = texture.get_width() / player_stats.frame_count
	var frame_height = texture.get_height()
	
	# Create the idle animation
	sprite_frames.add_animation("idle")
	sprite_frames.set_animation_speed("idle", 4)  # 8 FPS for idle
	sprite_frames.set_animation_loop("idle", true)
	
	# Add frames from spritesheet
	for i in range(player_stats.frame_count):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * frame_width, 0, frame_width, frame_height)
		sprite_frames.add_frame("idle", atlas)
	
	# Apply the frames to the AnimatedSprite2D
	$AnimatedSprite2D.sprite_frames = sprite_frames

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
