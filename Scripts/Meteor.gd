extends KinematicBody2D

export (float) var speed = 1

var health = 50
var score = 10
var velocity = Vector2()


func _ready():
	randomize()
	var coefficient = int(rand_range(1, 7))
	health *= coefficient
	score *= coefficient


func _process(delta):
	if health == 250 or health == 300:
		$AnimatedSprite.play("big_meteor")
		speed = 1
		$CollisionShape2D.scale = Vector2(2, 2)
	if health == 150 or health == 200:
		$AnimatedSprite.play("middle_meteor")
		speed = 1.5
		$CollisionShape2D.scale = Vector2(1.5, 1.5)
	if health == 50 or health == 100:
		$AnimatedSprite.play("small_meteor")
		speed = 2
		$CollisionShape2D.scale = Vector2(1, 1)

func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(rotation)
	velocity = move_and_collide(velocity)
	
	if velocity:
		if velocity.collider.name == "Player":
			velocity.collider.take_damage()
			health = -1
			queue_free()
	
	if health <= 0 and health != -1:
		get_parent().update_score(score)
		queue_free()
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func take_damage(damage):
	health -= damage
