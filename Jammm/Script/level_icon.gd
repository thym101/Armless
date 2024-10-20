@tool
extends Control
class_name LevelIcon
@export var level_name = "1"
@export var next_level_up: LevelIcon
@export var next_level_down: LevelIcon
@export var next_level_left: LevelIcon
@export var next_level_right: LevelIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Level " + str(level_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(level_name)
