extends Control

#signal text_completed

#@export var enemy: Resource = null
var max_player_healh = 0
var current_player_health = 0
var curent_player_armor = 0
var curent_player_speed = 0
var curent_player_dodge = 0
var curent_player_damage = 0
var max_enemy_health = 0
var current_enemy_health = 0
var current_enemy_armor = 0
var current_enemy_speed = 0
var current_enemy_dodge = 0
var current_enemy_damage = 0
var is_enemy_attack = false
var arm_tagget = 0
var leg_tagget = 0
var chest_tagget = 0
var appendages_tagget = 0
var player_stats
var enemy_stats

# Store body part stats for easy access
var player_body_parts = {}
var enemy_body_parts = {}


func _ready():
	player_stats = CharactorStat.get_stats()
	enemy_stats = EnemyStats.get_stats()
	
	arm_tagget = 0
	leg_tagget = 0
	chest_tagget = 0
	appendages_tagget = 0
	
	# Store body part stats in dictionaries
	player_body_parts = {
		#"name": player_stats.name,
		"arm": player_stats.arm,
		"leg": player_stats.leg,
		"chest": player_stats.chest,
		"appendages": player_stats.appendages
	}
	
	enemy_body_parts = {
		#"name": enemy_stats.name,
		"arm": enemy_stats.arm,
		"leg": enemy_stats.leg,
		"chest": enemy_stats.chest,
		"appendages": enemy_stats.appendages
	}
	
	print(enemy_body_parts)
	
	setup_enemy_animation()
	setup_idle_animation()

	# Stats calculation
	current_player_health = (player_stats.arm + player_stats.leg + player_stats.chest + player_stats.appendages) * 10
	max_player_healh = current_player_health
	curent_player_armor = (player_stats.chest * 2) + player_stats.arm + player_stats.leg + (player_stats.appendages * 2)
	curent_player_speed = (player_stats.leg * 3) + (player_stats.appendages * 2)
	curent_player_dodge = (player_stats.leg * 2) + player_stats.arm
	curent_player_damage = (player_stats.arm * 3) + player_stats.appendages
	
	current_enemy_health = (enemy_stats.arm + enemy_stats.leg + enemy_stats.chest + enemy_stats.appendages) * 10
	max_enemy_health = current_enemy_health
	current_enemy_armor = (enemy_stats.chest * 2) + enemy_stats.arm + enemy_stats.leg + (enemy_stats.appendages * 2)
	current_enemy_speed = (enemy_stats.leg * 3) + (enemy_stats.appendages * 2)
	current_enemy_dodge = (enemy_stats.leg * 2) + enemy_stats.arm
	current_enemy_damage = (enemy_stats.arm * 3) + enemy_stats.appendages
	
	set_health($Player/Panel2/ProgressBar, current_player_health, max_player_healh)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, max_enemy_health)
	
	$Action/textbox.hide()
	#$Action/textbox.gui_input.connect(_on_textbox_input)
	$Player/Panel2/Label.text = player_stats.name
	$Monster/Panel/Label.text = enemy_stats.name
	
	$Player/player.play("idle")
	$Monster/monster.play("idle")
	
	# Check who goes first based on speed
	if current_enemy_speed > curent_player_speed:
		await get_tree().create_timer(1.5).timeout
		enemy_turn()
	else:
		$Action/action_button.visible = true

func set_health(progress_bar: ProgressBar, current: int, maximum: int):
	progress_bar.max_value = maximum
	progress_bar.value = current
	
	var health_percent = float(current) / maximum
	if health_percent > 0.7:
		progress_bar.modulate = Color(0, 1, 0)  # Green
	elif health_percent > 0.3:
		progress_bar.modulate = Color(1, 1, 0)  # Yellow
	else:
		progress_bar.modulate = Color(1, 0, 0)  # Red
		
func setup_enemy_animation():
	var sprite_frames = SpriteFrames.new()
	var texture = load(enemy_stats.sprite_path)
	var frame_width = texture.get_width() / enemy_stats.frame_count
	var frame_height = texture.get_height()
	
	sprite_frames.add_animation("idle")
	sprite_frames.set_animation_speed("idle", 4)
	sprite_frames.set_animation_loop("idle", true)
	
	for i in range(enemy_stats.frame_count):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * frame_width, 0, frame_width, frame_height)
		sprite_frames.add_frame("idle", atlas)
	
	$Monster/monster.sprite_frames = sprite_frames

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
	$Player/player.sprite_frames = sprite_frames
	

func calculate_damage(attacker_damage: int, defender_armor: int, body_part_points: int) -> int:
	# Calculate damage reduction from armor
	var actual_damage = attacker_damage / (1 + (defender_armor / 100.0))
	
	# Calculate final damage based on body part points
	var final_damage = (actual_damage / (body_part_points / 5.0)) * 5
	
	return int(max(1, final_damage))  # Ensure minimum damage of 1

func calculate_dodge_chance(dodge_points: int, speed: int) -> float:
	# Dodge % = Dodge points + (Speed / 10)
	var dodge_chance = dodge_points + (speed / 10.0)
	return min(dodge_chance / 100.0, 0.6)  # Cap at 90% dodge chance

func try_dodge(dodge_points: int, speed: int) -> bool:
	var dodge_chance = calculate_dodge_chance(dodge_points, speed)
	return randf() < dodge_chance

func enemy_turn():
	# Random target selection for enemy
	var target_parts = ["arm", "leg", "chest", "appendages"]
	var target_part = target_parts[randi() % target_parts.size()]
	
	if try_dodge(curent_player_dodge, curent_player_speed):
		display_text("Player dodged the attack!")
		await get_tree().create_timer(1.5).timeout
		close_textbox()
		$Action/action_button.visible = true
		return
	
	var final_damage = calculate_damage(
		current_enemy_damage,
		curent_player_armor,
		player_body_parts[target_part]
	)
	
	current_player_health = max(0, current_player_health - final_damage)
	set_health($Player/Panel2/ProgressBar, current_player_health, max_player_healh)
	
	$AnimationPlayer.play("player_damaged")
	display_text("Enemy attacked your " + target_part + " for " + str(final_damage) + " damage!")
	#await display_text("Enemy attacked your " + target_part + " for " + str(final_damage) + " damage!")
	#close_textbox()
	#
	await get_tree().create_timer(1.5).timeout
	close_textbox()
	
	if current_player_health <= 0:
		handle_player_defeat()
		return
		
	await get_tree().create_timer(0.2).timeout
	$Action/action_button.visible = true

func handle_attack(attack_type: String):
	$Action/action_button.visible = false
	
	if try_dodge(current_enemy_dodge, current_enemy_speed):
		display_text("Enemy dodged the attack! (Dodge: " + str(current_enemy_dodge) + "%, Speed bonus: " + str(current_enemy_speed/10) + "%)")
		await get_tree().create_timer(1.5).timeout
		close_textbox()
		#await display_text("Enemy dodged the attack! (Dodge: " + str(current_enemy_dodge) + "%, Speed bonus: " + str(current_enemy_speed/10) + "%)")
		#close_textbox()
		await get_tree().create_timer(0.5).timeout
		enemy_turn()
		return
	
	var final_damage = calculate_damage(
		curent_player_damage,
		current_enemy_armor,
		enemy_body_parts[attack_type]
	)
	
	var attack_message = ""
	match attack_type:
		"arm": attack_message = "Slashed the arm"
		"leg": attack_message = "Cut the leg"
		"chest": attack_message = "Struck the chest"
		"appendages": attack_message = "Hit the wings"
	
	display_text(attack_message + " for " + str(final_damage) + " damage!")
	#await display_text(attack_message + " for " + str(final_damage) + " damage!")
	#close_textbox()
	
	await get_tree().create_timer(1.5).timeout
	current_enemy_health = max(0, current_enemy_health - final_damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, max_enemy_health)
	$AnimationPlayer.play("enemy_damage")
	
	await get_tree().create_timer(1).timeout
	close_textbox()
	
	if current_enemy_health <= 0:
		handle_enemy_defeat()
		return
		
	await get_tree().create_timer(0.5).timeout
	enemy_turn()

func handle_player_defeat():
	Global.streak = 0
	Global.hearth -= 1
	if Global.hearth <= 0:
		display_text("You Died!")
		await get_tree().create_timer(3).timeout
		close_textbox()
		get_tree().change_scene_to_file("res://Scene/starting_menu.tscn")
		
	display_text("You have been defeated!")
	await get_tree().create_timer(2).timeout
	close_textbox()
	
	get_tree().change_scene_to_file("res://Scene/level_select.tscn")
	# Add your game over logic here

func handle_enemy_defeat():
	if enemy_stats.name == "The Witch":
		display_text("Victory!  YOU  WIN  THE  GAME!!!")
		await get_tree().create_timer(2).timeout
		close_textbox()
		get_tree().change_scene_to_file("res://Scene/end.tscn")
	
	var targets = {
		"arm": arm_tagget,
		"leg": leg_tagget,
		"chest": chest_tagget,
		"appendages": appendages_tagget
	}
	
	var highest = {"name": "", "value": -1}
	var second = {"name": "", "value": -1}
	
	# Find highest
	for target_name in targets:
		if targets[target_name] > highest.value:
			# Move current highest to second
			second.name = highest.name
			second.value = highest.value
			# Set new highest
			highest.name = target_name
			highest.value = targets[target_name]
		elif targets[target_name] > second.value:
			# Update second highest
			second.name = target_name
			second.value = targets[target_name]
	
	print("%s target is the highest and %s target is the second" % [highest.name, second.name])
	
	if highest.name == "arm":
		Global.highest_target_name = highest.name
		Global.highest_target_value = enemy_stats.arm
		Global.sprite_path = enemy_stats.sprite_path
		Global.frame_count = enemy_stats.frame_count
	if highest.name == "leg":
		Global.highest_target_name = highest.name
		Global.highest_target_value = enemy_stats.leg
		Global.sprite_path = enemy_stats.sprite_path
		Global.frame_count = enemy_stats.frame_count
	if highest.name == "chest":
		Global.highest_target_name = highest.name
		Global.highest_target_value = enemy_stats.chest
		Global.sprite_path = enemy_stats.sprite_path
		Global.frame_count = enemy_stats.frame_count
	if highest.name == "appendages":
		Global.highest_target_name = highest.name
		Global.highest_target_value = enemy_stats.appendages
		Global.sprite_path = enemy_stats.sprite_path
		Global.frame_count = enemy_stats.frame_count
	if second.name == "arm":
		Global.second_target_name = second.name
		Global.second_target_value = enemy_stats.arm
	if second.name == "leg":
		Global.second_target_name = second.name
		Global.second_target_value = enemy_stats.leg
	if second.name == "chest":
		Global.second_target_name = second.name
		Global.second_target_value = enemy_stats.chest
	if second.name == "appendages":
		Global.second_target_name = second.name
		Global.second_target_value = enemy_stats.appendages
	
	display_text("Victory! Enemy defeated!")
	await get_tree().create_timer(2).timeout
	close_textbox()
	get_tree().change_scene_to_file("res://Scene/reward.tscn")
	# Add your victory logic here

func _on_arm_pressed():
	arm_tagget += 1
	handle_attack("arm")

func _on_leg_pressed():
	leg_tagget += 1
	handle_attack("leg")

func _on_chest_pressed():
	chest_tagget += 1
	handle_attack("chest")

func _on_appendages_pressed():
	appendages_tagget += 1
	handle_attack("appendages")

func close_textbox():
	$Action/textbox.visible = false

#func display_text(text: String):
	#$Action/textbox.show()
	#$Action/textbox.text = text

func display_text(text: String):
	$Action/textbox.show()
	$Action/textbox.text = text

