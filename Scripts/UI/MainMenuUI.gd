extends Control

func _ready():
	pass

func _on_NewGame_pressed():
	SaveManagerInstance.clear_save()
	GameManagerInstance.player_money = 50000
	GameManagerInstance.current_mission_id = 0
	GameManagerInstance.change_scene("res://Scenes/World/OpenWorld.tscn")

func _on_Continue_pressed():
	SaveManagerInstance.load_game()
	GameManagerInstance.change_scene("res://Scenes/World/OpenWorld.tscn")

func _on_Settings_pressed():
	GameManagerInstance.change_scene("res://Scenes/Menu/SettingsMenu.tscn")

func _on_Exit_pressed():
	get_tree().quit()
