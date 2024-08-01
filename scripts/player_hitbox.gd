extends Area2D

var damage = 40


func _on_body_entered(body):
	#print("body entered:")
	#print(body)
	
	body.take_hit(damage)
