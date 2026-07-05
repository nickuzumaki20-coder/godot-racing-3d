extends Node

class_name GameManager

var current_scene: String = ""
var current_player_car: int = 0
var player_money: int = 50000
var is_in_race: bool = false
var current_mission_id: int = -1
var game_paused: bool = false
var difficulty: int = 1

var car_models = []
var missions_data = {}

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")
	load_initial_data()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func load_initial_data():
	car_models = [
		{"name": "Speedster", "speed": 180, "acceleration": 12, "handling": 8, "price": 0, "owned": true},
		{"name": "Thunder", "speed": 200, "acceleration": 14, "handling": 6, "price": 15000, "owned": false},
		{"name": "Ghost", "speed": 210, "acceleration": 15, "handling": 7, "price": 25000, "owned": false},
		{"name": "Phantom", "speed": 220, "acceleration": 16, "handling": 8, "price": 40000, "owned": false},
		{"name": "Legend", "speed": 230, "acceleration": 17, "handling": 9, "price": 60000, "owned": false},
	]
	
	missions_data = {
		0: {"name": "Rookie Race", "type": "race", "laps": 1, "reward": 2000, "unlocked": true},
		1: {"name": "Two Rivals", "type": "race", "laps": 2, "reward": 3500, "unlocked": true},
		2: {"name": "Time Trial", "type": "trial", "time_limit": 180, "reward": 2500, "unlocked": true},
		3: {"name": "Night Race", "type": "race", "laps": 2, "reward": 5000, "unlocked": false},
		4: {"name": "Traffic Race", "type": "race", "laps": 1, "reward": 4000, "unlocked": false},
		5: {"name": "Police Chase", "type": "chase", "time_limit": 120, "reward": 6000, "unlocked": false},
		6: {"name": "Drift Challenge", "type": "drift", "target_points": 50000, "reward": 3500, "unlocked": false},
		7: {"name": "Delivery", "type": "delivery", "checkpoints": 5, "reward": 4500, "unlocked": false},
		8: {"name": "Boss Race", "type": "race", "laps": 3, "reward": 8000, "unlocked": false},
		9: {"name": "Championship", "type": "race", "laps": 5, "reward": 15000, "unlocked": false},
	}

func change_scene(scene_path: String):
	current_scene = scene_path
	var err = get_tree().change_scene(scene_path)
	if err != OK:
		push_error("Failed to load scene: ", scene_path)

func start_mission(mission_id: int):
	if mission_id < 0 or mission_id >= missions_data.size():
		return
	
	current_mission_id = mission_id
	is_in_race = true
	game_paused = false
	change_scene("res://Scenes/Race/RaceScene.tscn")

func end_race(won: bool, time: float = 0.0, position: int = 1):
	is_in_race = false
	
	if won:
		var reward = missions_data[current_mission_id].get("reward", 1000)
		add_money(reward)
		unlock_next_mission()
	
	change_scene("res://Scenes/Menu/MainMenu.tscn")

func buy_car(car_id: int) -> bool:
	if car_id < 0 or car_id >= car_models.size():
		return false
	
	var car = car_models[car_id]
	if car["owned"]:
		return false
	
	if player_money >= car["price"]:
		player_money -= car["price"]
		car["owned"] = true
		return true
	
	return false

func add_money(amount: int):
	player_money += amount

func get_player_money() -> int:
	return player_money

func set_difficulty(level: int):
	difficulty = clamp(level, 0, 2)

func toggle_pause():
	game_paused = !game_paused
	get_tree().paused = game_paused

func unlock_next_mission():
	if current_mission_id + 1 < missions_data.size():
		missions_data[current_mission_id + 1]["unlocked"] = true

func get_unlocked_missions() -> Array:
	var unlocked = []
	for mission_id in missions_data.keys():
		if missions_data[mission_id]["unlocked"]:
			unlocked.append(mission_id)
	return unlocked

func get_current_car() -> Dictionary:
	if current_player_car >= 0 and current_player_car < car_models.size():
		return car_models[current_player_car]
	return car_models[0]

func set_current_car(car_id: int):
	if car_id >= 0 and car_id < car_models.size():
		if car_models[car_id]["owned"]:
			current_player_car = car_id

func get_all_cars() -> Array:
	return car_models

func get_owned_cars() -> Array:
	var owned = []
	for car in car_models:
		if car["owned"]:
			owned.append(car)
	return owned
