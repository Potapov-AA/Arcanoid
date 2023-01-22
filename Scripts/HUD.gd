extends CanvasLayer


signal start_game

var player_score

func _ready():
	fillTableScore()

func fillTableScore():
	var res = Config.loadScoreTable()
	var name = res[0]
	var score = res[1]
	
	$ScoreTable/Result1/Name.text = name[0]
	$ScoreTable/Result2/Name.text = name[1]
	$ScoreTable/Result3/Name.text = name[2]
	$ScoreTable/Result4/Name.text = name[3]
	$ScoreTable/Result5/Name.text = name[4]
	$ScoreTable/Result6/Name.text = name[5]
	$ScoreTable/Result7/Name.text = name[6]
	$ScoreTable/Result8/Name.text = name[7]
	$ScoreTable/Result9/Name.text = name[8]
	$ScoreTable/Result10/Name.text = name[9]
	
	$ScoreTable/Result1/Score.text = str(score[0])
	$ScoreTable/Result2/Score.text = str(score[1])
	$ScoreTable/Result3/Score.text = str(score[2])
	$ScoreTable/Result4/Score.text = str(score[3])
	$ScoreTable/Result5/Score.text = str(score[4])
	$ScoreTable/Result6/Score.text = str(score[5])
	$ScoreTable/Result7/Score.text = str(score[6])
	$ScoreTable/Result8/Score.text = str(score[7])
	$ScoreTable/Result9/Score.text = str(score[8])
	$ScoreTable/Result10/Score.text = str(score[9])


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	$GameOver.show()
	
	
func update_score(score):
	$Score.text = str(score)


func update_life(life):
	$Life.text = str(life)


func _on_StartButton_pressed():
	$StartButton.hide()
	$ScoreTable.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Restart_pressed():
	var player_name = $GameOver/PlayerName.text
	if player_name.empty():
		$GameOver/PlayerName.placeholder_text = "Please enter your name"
	elif player_name == "---":
		$GameOver/PlayerName.text = ""
		$GameOver/PlayerName.placeholder_text = "Please dont use '---'"
	elif len(player_name) > 10:
		$GameOver/PlayerName.text = ""
		$GameOver/PlayerName.placeholder_text = "Name lenght must be < 10"
	else:
		Config.saveResult(player_name, player_score)
		get_tree().reload_current_scene()
