extends Node2D

export(PackedScene) var bullet_scene
export(PackedScene) var meteor_scene


func _ready():
	randomize()


func get_input():
	if Input.is_action_just_pressed("shot"):
		var bullet = bullet_scene.instance()  
		bullet.position = $Player.position
		bullet.rotation = $Player.rotation
		add_child(bullet)


func _process(delta):
	get_input()


func _on_MeteorTimer_timeout():
	var meteor = meteor_scene.instance()
	
	var meteor_sapwn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_sapwn_location.offset = randi()
	
	meteor.position = meteor_sapwn_location.position
	
	var pre = meteor.position - $Player.position
	meteor.rotation = pre.angle() - PI/2
	
	add_child(meteor)
	
	
	
	
	
	
	
	
	
	
	
