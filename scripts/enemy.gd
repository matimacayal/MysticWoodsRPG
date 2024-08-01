extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var health = 100
var dying = false
var initial_position = null
var returning = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $detection_area/Timer
@onready var healthbar = $Healthbar

func _ready():
	initial_position = position

func _physics_process(delta):
	if dying:
		return
	
	if player_chase && !returning:
		print("Chasing player")
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
	
	if !player_chase && returning:
		var return_distance = initial_position - position
		var chase_vector = return_distance.normalized()
		
		
		var distance = return_distance.length()
		#print("return_distance " + str(distance))
		if distance < 1:
			print("Enemy returned to initial position")
			position = initial_position
			chase_vector = Vector2.ZERO
			returning = false

		velocity = chase_vector  * speed
		move_and_slide()
		return
	
	move_and_collide(velocity)
	
	update_health()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	returning = false
	timer.stop()

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
	timer.start()
	
func _on_timer_timeout():
	returning = true

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


func update_health():
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

