extends CanvasLayer

signal on_transition_finished  

@onready var texture = $ColorRect
@onready var animation_player = $AnimationPlayer

#func _ready():
	#texture.hide()
	#animation_player.animation_finished.connect(_on_animation_finished)  # Corrected: Added underscore
#
#func _on_animation_finished(anim_name):  # Corrected: Added underscore
	#if anim_name == "transition":
		#on_transition_finished.emit()  # Corrected: Remove asterisks
		#animation_player.play("dark_to_fade")
	#elif anim_name == "dark_to_fade":
		#texture.hide()
#
#func transition():
	#texture.show()
	#animation_player.play("transition")
