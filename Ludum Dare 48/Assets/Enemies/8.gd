extends KinematicBody2D

func _on_AttackTimer_timeout():
	$CollisionShape2D.shape.extents.y *= 2
	$CollisionShape2D.position.y -= 32
	$Sprite.scale.y *= 2
	$Sprite.position.y -= 32
	yield(get_tree().create_timer(1), "timeout")
	$CollisionShape2D.shape.extents.y /= 2
	$CollisionShape2D.position.y += 32
	$Sprite.scale.y /= 2
	$Sprite.position.y += 32
	
#var speed : = Vector2(500,1000)
#var velocity: = Vector2(0,0)
#var gravity: = 300.0

#func _ready():
#	set_physics_process(false)
#	velocity.x = - speed.x
#
#func _physics_process(delta):
#	velocity.y += gravity*delta
#	if is_on_wall():
#		velocity.x *= -1.0
#	velocity.y = move_and_slide(velocity,Vector2(0,-1)).y
