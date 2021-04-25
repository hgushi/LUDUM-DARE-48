extends KinematicBody2D

var speed : = Vector2(0,1000)
var velocity: = Vector2(0,0)
var gravity: = 300.0

	
func a():
	velocity = speed
	velocity.y += gravity*get_process_delta_time()
	return velocity

func _process(delta):
	position += velocity
