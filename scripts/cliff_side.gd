extends Node2D

@onready var player = $Player2

var from_world_scene_position = Vector2(87, 140)

func _ready():
	if Global.current_scene == "world":
		player.position = from_world_scene_position
	
	Global.current_scene = "cliff-side"
	print("Global.current_scene = " + Global.current_scene)

func _on_mainscene_transition_area_body_entered(body):
	print("Player wants to change to world scene")
	get_tree().change_scene_to_file("res://scenes/world.tscn")
