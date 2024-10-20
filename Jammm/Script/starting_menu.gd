extends Node



func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/choosecharactor.tscn")


func _on_button_2_pressed():
	get_tree().quit()
