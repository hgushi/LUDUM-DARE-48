extends KinematicBody2D

var speed : = Vector2(1000,1000)
var velocity: = 500
var direction: = Vector2(0,1)
var alvo = weakref(null)

func _physics_processs(delta):
	if not !alvo.get_ref():
		direction = (alvo.get_ref().global_position.x - global_position).normalized()
	if direction.y > 0: self.rotation = PI/4 + acos(direction.x)
	else: self.rotation = PI/4 - acos(direction.x)
	translate(direction*velocity*delta)
	
	if is_on_wall():
		direction.x *= -1.0
	

func _ready():
	set_physics_process(false)

