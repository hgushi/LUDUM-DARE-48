extends KinematicBody2D
class_name EnemyBase

var speed : = Vector2(1000,1000)
var velocity: = Vector2(0,0)
var gravity: = 300.0

func _physics_processs(delta):
	velocity.y += gravity*delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity,Vector2(0,-1)).y

func _ready():
	set_physics_process(false)
	velocity.x = - speed.x

func _on_PlayerDetector_body_entered(body):
	if body.global_position.y > get_node("PlayerDetector").global_position.y:
		$CollisionShape2D.disabled = true
		queue_free()
