extends KinematicBody2D

const max_length = 5000.0
var speed : = Vector2(100,100)
var velocity: = Vector2(0,0)
var gravity: = 30.0
onready var beam = $Beam 
onready var end = $End
onready var RayCast2D = $RayCast2D
onready var AtaqueTimer = $AtaqueTimer
onready var PauseTimer = $PauseTimer

func _ready():
	set_physics_process(false)
	velocity.x = -speed.x
	PauseTimer.start()

func _physics_process(delta):
	var box = get_node("Beam").get_node("Area2D").get_node("CollisionShape2D")
	velocity.y += gravity*delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
	if AtaqueTimer.is_stopped():
		var player_position = get_node("Player").global_position - self.global_position
		var max_cast_to = player_position.normalized()*max_length
		RayCast2D.cast_to = max_cast_to
		if RayCast2D.is_colliding():
			end.global_position = RayCast2D.get_collision_point()
		else:
			end.global_position = RayCast2D.cast_to
		beam.rotation = RayCast2D.cast_to.angle()
		beam.region_rect.end.x = end.position.length()
		
		box.scale.x = end.position.length()
func _on_AtaqueTimer_timeout():
	PauseTimer.start()

func _on_PauseTimer_timeout():
	AtaqueTimer.start()
