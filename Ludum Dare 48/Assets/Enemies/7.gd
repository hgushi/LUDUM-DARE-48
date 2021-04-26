extends KinematicBody2D

var velocity: = Vector2(0,1)
var speed = 300
var direction: = Vector2(0,1)
var alvo

func _physics_process(_delta):
#	if direction.y > 0: self.rotation = PI/4 + acos(direction.x)
#	else: self.rotation = PI/4 - acos(direction.x)
	velocity = direction * speed
	
	if is_on_wall(): queue_free()
	if is_on_ceiling() or is_on_floor(): queue_free()
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	rotation -= PI/24
	
