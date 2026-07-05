extends Node

class_name CarManager

var cars: Array = []
var upgrades: Dictionary = {}

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")
	load_cars()

func load_cars():
	cars = GameManagerInstance.car_models

func get_car(car_id: int) -> Dictionary:
	if car_id >= 0 and car_id < cars.size():
		return cars[car_id]
	return {}

func get_all_cars() -> Array:
	return cars

func get_owned_cars() -> Array:
	var owned = []
	for car in cars:
		if car.get("owned", false):
			owned.append(car)
	return owned

func buy_car(car_id: int) -> bool:
	if car_id >= 0 and car_id < cars.size():
		return GameManagerInstance.buy_car(car_id)
	return false

func upgrade_car(car_id: int, upgrade_type: String, level: int) -> bool:
	if car_id < 0 or car_id >= cars.size():
		return false
	
	var key = "car_%d_%s" % [car_id, upgrade_type]
	var upgrade_cost = 1000 * level
	
	if GameManagerInstance.player_money >= upgrade_cost:
		GameManagerInstance.add_money(-upgrade_cost)
		upgrades[key] = level
		updated_car_stats(car_id)
		return true
	
	return false

func updated_car_stats(car_id: int):
	if car_id < 0 or car_id >= cars.size():
		return
	
	var car = cars[car_id]
	var speed_upgrade = upgrades.get("car_%d_speed" % car_id, 0)
	var accel_upgrade = upgrades.get("car_%d_acceleration" % car_id, 0)
	var handling_upgrade = upgrades.get("car_%d_handling" % car_id, 0)
	
	car["speed"] = car.get("speed", 180) + (speed_upgrade * 10)
	car["acceleration"] = car.get("acceleration", 10) + (accel_upgrade * 1)
	car["handling"] = car.get("handling", 8) + (handling_upgrade * 1)

func get_upgrade_level(car_id: int, upgrade_type: String) -> int:
	var key = "car_%d_%s" % [car_id, upgrade_type]
	return upgrades.get(key, 0)
