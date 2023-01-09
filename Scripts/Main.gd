extends Node2D


export (PackedScene) var bullet_scene


func get_input():
	if Input.is_action_just_pressed("shot"):
		var bullet = bullet_scene.instance()  
		bullet.position = $Player.position
		bullet.rotation = $Player.rotation
		add_child(bullet)


func _process(delta):
	get_input()
