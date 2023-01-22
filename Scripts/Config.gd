extends Node2D


func _ready():
	var doFileExists = File.new().file_exists("res://config.ini")
	if !doFileExists:
		clearScoreTable()
	


func clearScoreTable():
	var name = "---"
	var score = 0
	
	var ini = ConfigFile.new()
	
	for i in range(10):
		var number = "number" + str(i+1)
		ini.set_value(number, "name", name)
		ini.set_value(number, "score", score)
		
		ini.save("res://config.ini")


func loadScoreTable():
	var ini = ConfigFile.new()
	ini.load("res://config.ini")
	
	var sections = ini.get_sections()
	var name = []
	var score = []
	
	for i in sections:
		name.append(ini.get_value(i, "name"))
		score.append(ini.get_value(i, "score"))
	
	var result = [name, score]
	
	return result


func saveResult(player_name, player_result):
	var res = loadScoreTable()
	var name = res[0]
	var score = res[1]
	
	var ini = ConfigFile.new()
	
	var all_column_fill = false
	for i in range(10):
		if name[i] == '---':
			name[i] = player_name
			score[i] = player_result
			all_column_fill = true
			break
		else:
			if player_result > score[i]:
				if i == 9:
					score[i] = player_result
					name[i] = player_name
				else:
					for j in range(i, 9):
						var temp_name = name[j]
						var temp_score = score[j]
						name[j] = player_name
						score[j] = player_result
						player_name = temp_name
						player_result = temp_score
						
						
	for i in range(10):
		var number = "number" + str(i+1)
		ini.set_value(number, "name", name[i])
		ini.set_value(number, "score", score[i])
		
		ini.save("res://config.ini")
