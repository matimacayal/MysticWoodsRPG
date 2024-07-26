extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if player_chase:
		var chase_vector = (player.position - position).normalized()
		velocity = chase_vector * speed
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
	
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
