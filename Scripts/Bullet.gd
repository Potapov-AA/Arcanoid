extends KinematicBody2D


export (int) var speed = 5

var velocity = Vector2()
var damage


func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(rotation)
	velocity = move_and_collide(velocity)
	
	if velocity:
		velocity.collider.take_damage(damage)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func set_damage(damage_value):
	damage = damage_value
