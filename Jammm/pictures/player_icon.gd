extends AnimatedSprite2D

@onready var path_follow = get_parent()
var speed = 100.0  # Adjust this to change movement speed

func _process(delta):
	# Move along the path
	path_follow.progress += speed * delta
	
	# Optional: Reset to the beginning when reaching the end
	if path_follow.progress_ratio >= 1.0:
		path_follow.progress_ratio = 0.0
	
	# Get the direction of movement
	var direction = path_follow.get_transform().x
	
	# Flip the sprite based on movement direction
	if direction.x < 0:
		flip_h = true
	else:
		flip_h = false
	
	# Play the appropriate animation
	if direction != Vector2.ZERO:
		play("walk")  # Assuming you have a "walk" animation
	else:
		play("idle")  # Assuming you have an "idle" animation
