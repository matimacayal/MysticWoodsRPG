extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var health = 20
var dying = false
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if dying:
		return
	
	if player_chase:
		var chase_vector = (player.position - position).normalized()
		velocity = chase_vector # * speed
		# position += chase_vector * speed * delta
		#move_and_collide(Vector2(0,0))

		animated_sprite.play("walk")
		
		if chase_vector.x < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	else:
		# for a smooth stop we use lerp
		velocity = lerp(velocity, Vector2.ZERO, 0.22)
		animated_sprite.play("idle")
	
	move_and_collide(velocity)

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func take_hit(damage):
	health -= damage
	print("enemy took " + str(damage) + " of damage")
	print("enemy health: " + str(health))
	if health <= 0:
		dying = true
		animated_sprite.play("death")


func _on_animated_sprite_2d_animation_finished():
	if health <= 0:
		queue_free()
