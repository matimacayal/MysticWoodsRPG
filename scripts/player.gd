extends CharacterBody2D

const speed = 100
var current_direction = "none"
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(true)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(true)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(true)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(true)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(false)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_animation(movement):
	var direction = current_direction
	
	if direction == "right":
		animated_sprite.flip_h = false
		if movement == true:
			animated_sprite.play("side_walk")
		else:
			animated_sprite.play("side_idle")
	if direction == "left":
		animated_sprite.flip_h = true
		if movement == true:
			animated_sprite.play("side_walk")
		else:
			animated_sprite.play("side_idle")
	if direction == "down":
		animated_sprite.flip_h = false
		if movement == true:
			animated_sprite.play("front_walk")
		else:
			animated_sprite.play("front_idle")
	if direction == "up":
		animated_sprite.flip_h = false
		if movement == true:
			animated_sprite.play("back_walk")
		else:
			animated_sprite.play("back_idle")
