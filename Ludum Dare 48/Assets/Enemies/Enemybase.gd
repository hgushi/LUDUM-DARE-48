extends KinematicBody2D

var speed : = Vector2(1000,1000)
var velocity: = Vector2(0,0)
var gravity: = 300.0


func _ready():
	set_physics_process(false)
	velocity.x = -speed.x

func _physics_process(delta):
	velocity.y += gravity*delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
