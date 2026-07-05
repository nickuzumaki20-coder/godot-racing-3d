extends Spatial

var player_car: Node
var ai_cars: Array = []
var checkpoints: Array = []
var current_lap: int = 1
var total_laps: int = 1
var race_started: bool = false
var race_finished: bool = false
var start_countdown: int = 3

func _ready():
	setup_race()
	start_race_countdown()

func _process(delta):
	if not race_started or race_finished:
		return
	
	update_race_status(delta)

func setup_race():
	var game_manager = GameManagerInstance
	var mission_manager = MissionManagerInstance
	
	total_laps = mission_manager.get_lap_count()
	
	player_car = $PlayerCar
	if not player_car:
		return
	
	for child in get_children():
		if child.is_in_group("ai_car"):
			ai_cars.append(child)
			child.set_difficulty(game_manager.difficulty)

func start_race_countdown():
	yield(get_tree().create_timer(1.0), "timeout")
	start_countdown -= 1
	
	if start_countdown > 0:
		start_race_countdown()
	else:
		race_started = true
		MissionManagerInstance.start_mission(GameManagerInstance.current_mission_id)

func update_race_status(delta):
	var mission_time = MissionManagerInstance.get_mission_time()
	var time_limit = MissionManagerInstance.get_time_limit()
	
	if mission_time > time_limit and MissionManagerInstance.get_mission_type() == "trial":
		end_race(false)

func end_race(won: bool):
	if race_finished:
		return
	
	race_finished = true
	var mission_result = MissionManagerInstance.end_mission(won)
	
	if won:
		GameManagerInstance.end_race(true, mission_result["time"], mission_result["position"])
	else:
		GameManagerInstance.end_race(false)

func get_player_position() -> int:
	var position = 1
	var player_progress = 0.0
	
	for ai_car in ai_cars:
		var ai_progress = 0.0
		if ai_progress > player_progress:
			position += 1
	
	return position
