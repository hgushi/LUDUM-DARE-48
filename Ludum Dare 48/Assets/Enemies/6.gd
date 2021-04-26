extends KinematicBody2D

var speed = 200
var velocity: = Vector2(0,0)
var gravity: = 10
var direction

func _ready():
#	set_physics_process(false)
	velocity = direction * speed
	$AnimatedSprite.animation = "explode"
	$AnimatedSprite.play()

func _physics_process(_delta):
#	velocity.y += gravity*delta
	velocity = move_and_slide(velocity,Vector2(0,-1))
	if is_on_wall(): explode()
	if is_on_ceiling() or is_on_floor(): explode()

func _on_Area2D_area_entered(_area):
	explode()

func _on_ExplosionCountdown_timeout():
	explode()

func explode():
	$AnimatedSprite.animation = "quicksplode"
	$AnimatedSprite.play()
#	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
	
