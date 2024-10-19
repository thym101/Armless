extends Control

@export var enemy: Resource = null
var current_player_health = 0
var current_enemy_health = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_health($Player/ProgressBar, Health.current_health, Health.max_health)
	set_health($Monster/ProgressBar, enemy.health, enemy.health)
	$Monster/Dragon/DragonPoke.texture = enemy.texture
	#$Action.hide()
	
	current_player_health = Health.current_health
	current_enemy_health = enemy.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health

func enemy_turn():
	current_player_health = max(0, current_player_health - enemy.damage)
	set_health($Player/ProgressBar, current_player_health, Health.max_health)
	
	$AnimationPlayer.play("player_damaged")

func _on_arm_pressed():
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damage")

	enemy_turn()


func _on_leg_pressed():
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damage")

	enemy_turn()
	

func _on_chest_pressed():
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damage")

	enemy_turn()
	

func _on_appendages_pressed():
	current_enemy_health = max(0, current_enemy_health - Health.damage)
	set_health($Monster/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damage")

	enemy_turn()
	

