extends Control

#@export var enemy: Resource = null
var current_player_health = 0
var curent_player_armor = 0
var curent_player_speed = 0
var curent_player_dodge = 0
var curent_player_damage = 0
var current_enemy_health = 0
var current_enemy_armor = 0
var current_enemy_speed = 0
var current_enemy_dodge = 0
var current_enemy_damage = 0
var is_enemy_attack = false
var player_stats
var enemy_stats

func _ready():
	player_stats = CharactorStat.get_stats()
	enemy_stats = EnemyStats.get_stats()
	#var p_name = player_stats.name
	var p_arm = player_stats.arm
	var p_leg = player_stats.leg
	var p_chest = player_stats.chest
	var p_appendages = player_stats.appendages
	
	var e_name = enemy_stats.name
	var e_arm = enemy_stats.arm
	var e_leg = enemy_stats.leg
	var e_chest = enemy_stats.chest
	var e_appendages = enemy_stats.appendages
	
	setup_enemy_animation()
	setup_idle_animation()

	current_player_health = (p_arm + p_leg + p_chest + p_appendages) * 10
	curent_player_armor = (p_chest * 2) + p_arm + p_leg + (p_appendages * 2)
	curent_player_speed = (p_leg * 3) + (p_appendages * 2)
	curent_player_dodge = (p_leg * 2) + p_arm
	curent_player_damage = (p_arm * 3) + p_appendages
	
	current_enemy_health = (e_arm + e_leg + e_chest + e_appendages) * 10
	current_enemy_armor = (e_chest * 2) + e_arm + e_leg + (e_appendages * 2)
	current_enemy_speed = (e_leg * 3) + (e_appendages * 2)
	current_enemy_dodge = (e_leg * 2) + e_arm
	current_enemy_damage = (e_arm * 3) + e_appendages
	
	set_health($Player/Panel2/ProgressBar, Health.current_health, Health.max_health)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	#$Monster/Dragon/DragonPoke.texture = enemy.texture
	#$Action.hide()
	$Action/textbox.hide()
	
	#$Player/Panel2/Label.text = p_name
	$Monster/Panel/Label.text = e_name
	
	$Player/player.play("idle")
	$Monster/monster.play("idle")
	
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

## Called every frame. 'delta' is the elapsed time since the previous frame.
func player_attack(damage):
	var effective_damage = max(0, damage - current_enemy_armor)
	current_enemy_health = max(0, current_enemy_health - effective_damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	$AnimationPlayer.play("enemy_damage")
	
	if current_enemy_health <= 0:
		display_text("Enemy defeated!")
	else:
		enemy_turn()

# Handle enemy attack on player
func enemy_attack():
	# Check if the player dodges the attack
	if randf() * 100 < curent_player_dodge:
		display_text("Player dodges the attack!")
		return
	
	var effective_damage = max(0, current_enemy_damage - curent_player_armor)
	current_player_health = max(0, current_player_health - effective_damage)
	set_health($Player/Panel2/ProgressBar, current_player_health, current_player_health)
	
	$AnimationPlayer.play("player_damaged")
	
	if current_player_health <= 0:
		display_text("Player defeated!")
	else:
		$Action/action_button.visible = true

# Arm attack
func _on_arm_pressed():
	$Action/action_button.visible = false
	display_text("Attacking enemy's arm")
	await get_tree().create_timer(0.7).timeout
	player_attack(curent_player_damage)

# Leg attack
func _on_leg_pressed():
	$Action/action_button.visible = false
	display_text("Attacking enemy's leg")
	await get_tree().create_timer(0.7).timeout
	player_attack(curent_player_damage)

# Chest attack
func _on_chest_pressed():
	$Action/action_button.visible = false
	display_text("Attacking enemy's chest")
	await get_tree().create_timer(0.7).timeout
	player_attack(curent_player_damage)

# Appendages attack
func _on_appendages_pressed():
	$Action/action_button.visible = false
	display_text("Attacking enemy's appendages")
	await get_tree().create_timer(0.7).timeout
	player_attack(curent_player_damage)

# Called each time the enemy takes a turn
func enemy_turn():
	await get_tree().create_timer(1).timeout
	enemy_attack()

# Update health bar UI
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health

# Display text in the action box
func display_text(text):
	$Action/textbox.show()
	$Action/textbox.text = text

func close_textbox():
	$Action/textbox.visible = false


#func _process(delta):
	#pass
#
#func display_text(text):
	#$Action/textbox.show()
	#$Action/textbox.text = text
	#
#func set_health(progress_bar, health, max_health):
	#progress_bar.value = health
	#progress_bar.max_value = max_health
##
#func enemy_turn():
	#current_player_health = max(0, current_player_health - current_enemy_damage)
	#set_health($Player/Panel2/ProgressBar, current_player_health, Health.max_health)
	#
	#$AnimationPlayer.play("player_damaged")
	#display_text("Player attacked")
	#
	#await get_tree().create_timer(1).timeout
	#close_textbox()
	#
	#await get_tree().create_timer(0.2).timeout
	#$Action/action_button.visible = true
	#
#func _on_arm_pressed():
	#$Action/action_button.visible = false
	#
	#display_text("Give it a nice hand cut")
	#
	#await get_tree().create_timer(0.7).timeout
	#current_enemy_health = max(0, current_enemy_health - Health.damage)
	#set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	#$AnimationPlayer.play("enemy_damage")
	#
	##wait for 1 second and then close textbox
	#await get_tree().create_timer(1).timeout
	#close_textbox()
	#
	#await get_tree().create_timer(1).timeout
	#enemy_turn()
#
#func _on_leg_pressed():
	#$Action/action_button.visible = false
	#
	#display_text("Leg has a cut")
	#
	#await get_tree().create_timer(0.7).timeout
	#current_enemy_health = max(0, current_enemy_health - Health.damage)
	#set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	#$AnimationPlayer.play("enemy_damage")
#
	#await get_tree().create_timer(1).timeout
	#close_textbox()
	#
	#await get_tree().create_timer(1).timeout
	#enemy_turn()
	#
	#
#func _on_chest_pressed():
	#$Action/action_button.visible = false
	#
	##display text
	#display_text("Chest cut")
	#
	##health bar decreasing
	#await get_tree().create_timer(0.7).timeout
	#current_enemy_health = max(0, current_enemy_health - Health.damage)
	#set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	#
	##animation while being attacked
	#$AnimationPlayer.play("enemy_damage")
#
	#await get_tree().create_timer(1).timeout
	#close_textbox()
	#
	#await get_tree().create_timer(1).timeout
	#enemy_turn()
	#
#
#func _on_appendages_pressed():
	#$Action/action_button.visible = false
	#
	#display_text("No more wing")
	#
	#await get_tree().create_timer(0.7).timeout
	#current_enemy_health = max(0, current_enemy_health - Health.damage)
	#set_health($Monster/Panel/ProgressBar, current_enemy_health, current_enemy_health)
	#$AnimationPlayer.play("enemy_damage")
	#
	#await get_tree().create_timer(1).timeout
	#close_textbox()
	#
	#await get_tree().create_timer(1).timeout
	#enemy_turn()
	#
#func close_textbox():
	#$Action/textbox.visible = false

