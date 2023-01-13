extends CanvasLayer


signal start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	$StartButton.show()


func update_score(score):
	$Score.text = str(score)


func update_life(life):
	$Life.text = str(life)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()
