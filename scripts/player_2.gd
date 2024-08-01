extends CharacterBody2D

var speed = 100

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var hitbox = $player_hitbox/CollisionShape2D
@onready var healthbar = $Healthbar


var last_direction = "down" # (default to down or "front")
var attacking = false
var health = 100
var dying = false

func _physics_process(delta):
	if dying:
		return
	
	# Stop animations and movement if attacking
	if attacking:
		return

	var direction = get_movement_direction()
	velocity = direction * speed
	move_and_slide()
	
	play_movement_animations()
	
	attack_animations()
	
	update_health()

func get_movement_direction():
	var direction = Vector2()
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if abs(direction.x) >= abs(direction.y):
		direction.y = 0
		if direction.x > 0:
			last_direction = "right"
		elif direction.x < 0:
			last_direction = "left"
	else:
		direction.x = 0
		if direction.y > 0:
			last_direction = "down"
		elif direction.y <0:
			last_direction = "up"
	
	return direction.normalized()

func play_movement_animations():
	if velocity != Vector2.ZERO:
		if last_direction == "up":
			animation.play("back_walk")
		elif last_direction == "down":
			animation.play("front_walk")
		elif last_direction == "left":
			sprite.flip_h = true
			hitbox.position = Vector2(-8,0)
			animation.play("side_walk")
		elif last_direction == "right":
			hitbox.position = Vector2(8,0)
			sprite.flip_h = false
			animation.play("side_walk")
	else:
		if last_direction == "up":
			animation.play("back_idle")
		elif last_direction == "down":
			animation.play("front_idle")
		elif last_direction == "left":
			hitbox.position = Vector2(-8,0)
			sprite.flip_h = true
			animation.play("side_idle")
		elif last_direction == "right":
			hitbox.position = Vector2(8,0)
			sprite.flip_h = false
			animation.play("side_idle")

func attack_animations():
	if Input.is_action_just_pressed("attack"):
		attacking = true
		if last_direction == "up":
			animation.play("back_attack")
		elif last_direction == "down":
			animation.play("front_attack")
		elif last_direction == "left":
			sprite.flip_h = true
			animation.play("side_attack")
		elif last_direction == "right":
			sprite.flip_h = false
			animation.play("side_attack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name in ["back_attack", "front_attack", "side_attack"]:
		attacking = false

func take_hit(damage):
	health -= damage
	print("player took " + str(damage) + " of damage")
	print("player health: " + str(health))
	if health <= 0:
		dying = true
		animation.play("death")

func update_health():
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regeneration_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health




