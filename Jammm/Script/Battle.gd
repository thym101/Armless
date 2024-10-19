extends Control

@export var enemy: Resource = null
var current_player_health = 0
var current_enemy_health = 0
var is_enemy_attack = false

func _ready():
	set_health($Player/Panel2/ProgressBar, Health.current_health, Health.max_health)
	set_health($Monster/Panel/ProgressBar, enemy.health, enemy.health)
	#$Monster/Dragon/DragonPoke.texture = enemy.texture
	#$Action.hide()
	$Action/textbox.hide()
	
	current_player_health = Health.current_health
	current_enemy_health = enemy.health

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

