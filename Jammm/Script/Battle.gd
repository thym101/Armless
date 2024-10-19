extends Control

@export var enemy: Resource = null
var current_player_health = 0
var curent_player_armor = 0
var curent_player_speed = 0
var curent_player_dodge = 0
var curent_player_dame = 0
var current_enemy_health = 0
var is_enemy_attack = false
var player_stats

func _ready():
	player_stats = CharactorStat.get_stats()
	var arm = player_stats.arm
	var leg = player_stats.leg
	var chest = player_stats.chest
	var appendages = player_stats.appendages
	
	setup_idle_animation()

	current_player_health = (arm + leg + chest + appendages) * 10
	curent_player_armor = (chest * 2) + arm + leg + (appendages * 2)
	curent_player_speed = (leg * 3) + (appendages * 2)
	curent_player_dodge = (leg * 2) + arm
	curent_player_dame = (arm * 3) + appendages
	
	set_health($Player/Panel2/ProgressBar, Health.current_health, Health.max_health)
	set_health($Monster/Panel/ProgressBar, enemy.health, enemy.health)
	#$Monster/Dragon/DragonPoke.texture = enemy.texture
	#$Action.hide()
	$Action/textbox.hide()
	
	$Player/player.play("idle")

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_text(text):
	$Action/textbox.show()
	$Action/textbox.text = text
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
#
func enemy_turn():
	current_player_health = max(0, current_player_health - enemy.damage)
	set_health($Player/Panel2/ProgressBar, current_player_health, Health.max_health)
	
	$AnimationPlayer.play("player_damaged")
	display_text("Player attacked")
	
	await get_tree().create_timer(1).timeout
	close_textbox()
	
	await get_tree().create_timer(0.2).timeout
	$Action/action_button.visible = true
	
func _on_arm_pressed():
	$Action/action_button.visible = false
	
	display_text("Give it a nice hand cut")
	
	await get_tree().create_timer(0.7).timeout
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, enemy.health)
	$AnimationPlayer.play("enemy_damage")
	
	#wait for 1 second and then close textbox
	await get_tree().create_timer(1).timeout
	close_textbox()
	
	await get_tree().create_timer(1).timeout
	enemy_turn()

func _on_leg_pressed():
	$Action/action_button.visible = false
	
	display_text("Leg has a cut")
	
	await get_tree().create_timer(0.7).timeout
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, enemy.health)
	$AnimationPlayer.play("enemy_damage")

	await get_tree().create_timer(1).timeout
	close_textbox()
	
	await get_tree().create_timer(1).timeout
	enemy_turn()
	
	
func _on_chest_pressed():
	$Action/action_button.visible = false
	
	#display text
	display_text("Chest cut")
	
	#health bar decreasing
	await get_tree().create_timer(0.7).timeout
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, enemy.health)
	
	#animation while being attacked
	$AnimationPlayer.play("enemy_damage")

	await get_tree().create_timer(1).timeout
	close_textbox()
	
	await get_tree().create_timer(1).timeout
	enemy_turn()
	

func _on_appendages_pressed():
	$Action/action_button.visible = false
	
	display_text("No more wing")
	
	await get_tree().create_timer(0.7).timeout
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/Panel/ProgressBar, current_enemy_health, enemy.health)
	$AnimationPlayer.play("enemy_damage")
	
	await get_tree().create_timer(1).timeout
	close_textbox()
	
	await get_tree().create_timer(1).timeout
	enemy_turn()
	
func close_textbox():
	$Action/textbox.visible = false

