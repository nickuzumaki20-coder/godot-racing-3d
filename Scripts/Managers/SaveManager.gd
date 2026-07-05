extends Node

class_name SaveManager

var save_path: String = "user://godot_racing/save.json"
var save_data: Dictionary = {}

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")
	
	var dir = Directory.new()
	if not dir.dir_exists(save_path.get_basename()):
		dir.make_absolute(save_path.get_basename())
	
	load_game()

func save_game():
	var game_manager = GameManagerInstance
	
	save_data = {
		"player_money": game_manager.player_money,
		"current_player_car": game_manager.current_player_car,
		"difficulty": game_manager.difficulty,
		"cars": game_manager.car_models,
		"missions": game_manager.missions_data,
		"last_save": OS.get_unix_time()
	}
	
	var json_string = JSON.print(save_data)
	var file = File.new()
	var err = file.open(save_path, File.WRITE)
	
	if err == OK:
		file.store_string(json_string)
		file.close()
		print("[SaveManager] Game saved successfully")
	else:
		push_error("[SaveManager] Failed to save game: ", err)

func load_game():
	var file = File.new()
	
	if not file.file_exists(save_path):
		print("[SaveManager] No save file found, creating new game")
		return
	
	var err = file.open(save_path, File.READ)
	if err == OK:
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_err = json.parse(json_string)
		
		if parse_err == OK:
			save_data = json.get_data()
			apply_save_data()
			print("[SaveManager] Game loaded successfully")
		else:
			push_error("[SaveManager] Failed to parse save file")
	else:
		push_error("[SaveManager] Failed to open save file: ", err)

func apply_save_data():
	var game_manager = GameManagerInstance
	
	if save_data.has("player_money"):
		game_manager.player_money = save_data["player_money"]
	
	if save_data.has("current_player_car"):
		game_manager.current_player_car = save_data["current_player_car"]
	
	if save_data.has("difficulty"):
		game_manager.difficulty = save_data["difficulty"]
	
	if save_data.has("cars"):
		game_manager.car_models = save_data["cars"]
	
	if save_data.has("missions"):
		game_manager.missions_data = save_data["missions"]

func clear_save():
	save_data.clear()
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_string(JSON.print({}))
	file.close()
	print("[SaveManager] Save data cleared")
