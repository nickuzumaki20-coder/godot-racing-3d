extends Node

class_name MissionManager

var current_mission: Dictionary = {}
var mission_active: bool = false
var mission_timer: float = 0.0
var checkpoints_passed: int = 0
var current_position: int = 1
var players_ahead: int = 0

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")

func _process(delta):
	if mission_active:
		mission_timer += delta

func start_mission(mission_id: int):
	var game_manager = GameManagerInstance
	
	if mission_id < 0 or mission_id >= game_manager.missions_data.size():
		return
	
	current_mission = game_manager.missions_data[mission_id].duplicate()
	current_mission["id"] = mission_id
	mission_active = true
	mission_timer = 0.0
	checkpoints_passed = 0
	current_position = 1
	players_ahead = 0

func end_mission(won: bool) -> Dictionary:
	mission_active = false
	
	var result = {
		"won": won,
		"time": mission_timer,
		"position": current_position,
		"reward": 0
	}
	
	if won:
		var game_manager = GameManagerInstance
		var mission_id = current_mission.get("id", 0)
		var reward = game_manager.missions_data[mission_id].get("reward", 1000)
		result["reward"] = reward
	
	return result

func pass_checkpoint():
	checkpoints_passed += 1

func update_position(position: int, players_ahead_count: int):
	current_position = position
	players_ahead = players_ahead_count

func get_mission_time() -> float:
	return mission_timer

func is_mission_active() -> bool:
	return mission_active

func get_current_mission() -> Dictionary:
	return current_mission

func get_mission_type() -> String:
	return current_mission.get("type", "race")

func get_time_limit() -> float:
	return float(current_mission.get("time_limit", 300))

func get_lap_count() -> int:
	return current_mission.get("laps", 1)

func get_checkpoints_passed() -> int:
	return checkpoints_passed

func get_current_position() -> int:
	return current_position
