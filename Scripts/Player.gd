extends KinematicBody2D


export (int) var speed = 285
export (float) var rotation_speed = 4

var velocity = Vector2()
var rotaion_direction = 0

var screen_size
var damage = 50
var health = 3

var shoot = false

signal death
signal hit(value)


func _ready():
	screen_size = get_viewport_rect().size


func get_input():
	rotaion_direction = 0
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity = Vector2(0, -speed).rotated(rotation)
	if Input.is_action_pressed("rotate_left"):
		rotaion_direction -= 1
	if Input.is_action_pressed("rotate_right"):
		rotaion_direction += 1
	if Input.is_action_just_pressed("shot") and shoot == false:
		$ResetShotTimer.start()


func _physics_process(delta):
	get_input()
	rotation += rotaion_direction * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	if velocity and Input.is_action_just_pressed("shot"):
		$AnimatedSprite.play("move and shot")
		shoot = true
		yield($ResetShotTimer, "timeout")
		shoot = false
	elif velocity and shoot==false:
		$AnimatedSprite.play("move")
	elif !velocity and Input.is_action_just_pressed("shot"):
		$AnimatedSprite.play("shot")
		shoot = true
		yield($ResetShotTimer, "timeout")
		shoot = false
	elif !velocity and shoot==false:
		$AnimatedSprite.play("staid")
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if health <= 0:
		emit_signal("death")
		queue_free()
	

func take_damage():
	health -= 1
	emit_signal("hit", health)
	
	
