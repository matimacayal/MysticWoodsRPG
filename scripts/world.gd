extends Node2D

@onready var player = $Player2

var from_cliff_side_scene_position = Vector2(194,10)

func _ready():
	if Global.current_scene == "cliff-side":
		player.position = from_cliff_side_scene_position;
	
	Global.current_scene = "world"
	print("Global.current_scene: " + Global.current_scene)
	

func _on_cliffside_transition_area_body_entered(body):
	print("Player wants to change to cliff-side scene")
	get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
