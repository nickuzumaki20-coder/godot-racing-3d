extends Spatial

var player_car: Node
var mission_start_points: Array = []
var npc_cars: Array = []

func _ready():
	setup_world()
	spawn_npc_vehicles()

func setup_world():
	player_car = $PlayerCar
	if player_car:
		player_car.global_transform.origin = Vector3(0, 2, 0)

func spawn_npc_vehicles():
	pass

func _process(delta):
	update_hud()

func update_hud():
	if player_car:
		var current_speed = player_car.get_current_speed()
		var money = GameManagerInstance.player_money
		UIManagerInstance.update_hud({
			"speed": int(current_speed),
			"money": money,
			"mission": "Open World"
		})
