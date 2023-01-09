extends KinematicBody2D

export (int) var speed = 2

var velocity = Vector2()


func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(rotation)
	velocity = move_and_collide(velocity)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
