extends KinematicBody2D

var speed : = Vector2(1000,1000)
var velocity: = Vector2(0,0)


func _physics_processs(delta):
	if is_on_wall():
		velocity.x *= -1.0

func _ready():
	set_physics_process(false)
	velocity.x = - speed.x

