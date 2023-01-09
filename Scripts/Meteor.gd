extends KinematicBody2D

export (int) var speed = 2

var health = 100
var velocity = Vector2()


func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(rotation)
	velocity = move_and_collide(velocity)
	
	if velocity:
		if velocity.collider.name == "Player":
			velocity.collider.take_damage()
			queue_free()
	
	if health <= 0:
		queue_free()
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func take_damage(damage):
	health -= damage
