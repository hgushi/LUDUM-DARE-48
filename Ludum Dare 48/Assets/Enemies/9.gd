extends KinematicBody2D

var speed = 20
var velocity: = Vector2(0,0)
var slide_range = 60
var distance_walked = 0
var gravity = 400.0

func _physics_process(delta):
	velocity.y += gravity * delta
	if distance_walked < slide_range:
		if is_on_wall():
			velocity.x *= -1.0
			distance_walked += velocity.y
		else:
			velocity = move_and_slide(velocity,Vector2(0,0))
			distance_walked += velocity.x
		velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
	else:
		velocity = - velocity
		distance_walked = 0

func _ready():
	set_physics_process(false)
	velocity.x = -speed


