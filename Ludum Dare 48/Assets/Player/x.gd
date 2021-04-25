extends KinematicBody2D

var gravity: = 300
var velocity : = Vector2(0,0)

func _physics_process(delta):
	velocity.y  += gravity*delta
	move_and_slide(velocity)
