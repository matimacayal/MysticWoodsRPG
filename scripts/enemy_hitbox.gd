extends Area2D

@onready var enemy_hitbox = $CollisionShape2D
@onready var timer = $Timer

var entered_body = null
var damage = 10

func _on_body_entered(body):
	print(body)

	entered_body = body
	entered_body.take_hit(damage)
	
	timer.start()

func _on_timer_timeout():
	print("timer timeout")
	entered_body.take_hit(damage)


func _on_body_exited(body):
	entered_body = null
	timer.stop()
