extends Node2D

export(PackedScene) var bullet_scene
export(PackedScene) var meteor_scene

var score = 0
var can_shot = true
var playerShow = false

func _ready():
	randomize()
	var timer = get_node("Player/ResetShotTimer")
	timer.connect("timeout", self, "_on_ResetShotTimer_timeout")


func get_input():
	if Input.is_action_just_pressed("shot") and $Player and playerShow and can_shot:
		var bullet = bullet_scene.instance()  
		bullet.position = $Player.position
		bullet.rotation = $Player.rotation
		bullet.set_damage($Player.damage)
		add_child(bullet)
		can_shot = false

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


func _on_ResetShotTimer_timeout():
	can_shot = true

	
func _on_Player_death():
	$MeteorTimer.stop()
	$HUD.show_game_over()
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().reload_current_scene()


func _on_Player_hit(life):
	$HUD.update_life(life)
	

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.update_life(3)
	$HUD/Life.show()
	$HUD/Score.show()
	$HUD.show_message("GET READY")
	
	$StartTimer.start()
	yield($StartTimer, "timeout")
	
	$Player.show()
	playerShow = true
	$MeteorTimer.start()


func update_score(value):
	if $Player:
		score += value
	$HUD.update_score(score)
