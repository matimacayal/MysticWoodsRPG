extends CharacterBody2D

const speed = 100
var current_direction = "none"
@onready var animated_sprite = $AnimatedSprite2D

var last_key_pressed = Vector2.ZERO

func _ready():
	animated_sprite.play("front_idle")

func _physics_process(delta):
	var direction = get_movement_direction()
	if direction == Vector2(0,0):
		play_animation(false)
		velocity.x = 0
		velocity.y = 0
	elif abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			current_direction = "right"
			play_animation(true)
			velocity.x = speed
			velocity.y = 0
		elif direction.x < 0:
			current_direction = "left"
			play_animation(true)
			velocity.x = -speed
			velocity.y = 0
	else:
		if direction.y > 0:
			current_direction = "down"
			play_animation(true)
			velocity.x = 0
			velocity.y = speed
		elif direction.y < 0:
			current_direction = "up"
			play_animation(true)
			velocity.x = 0
			velocity.y = -speed
	
	move_and_slide()

func get_movement_direction():
	var direction = Vector2()
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if abs(direction.x) >= abs(direction.y):
		direction.y = 0
	else:
		direction.x = 0
	
	return direction.normalized()

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
