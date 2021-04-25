extends KinematicBody2D

var velocity: = 500
var direction: = Vector2(0,1)
var alvo = weakref(null)

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	if not !alvo.get_ref():
		direction = (alvo.get_ref().global_position.x - global_position).normalized()
	if direction.y > 0: self.rotation = PI/4 + acos(direction.x)
	else: self.rotation = PI/4 - acos(direction.x)
	if is_on_wall():
		direction.x *= -1.0
	if is_on_ceiling() or is_on_floor():
		direction.y *= -1.0
	direction *= velocity
	direction = move_and_slide(direction,Vector2(0,-1))
