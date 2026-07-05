extends Control

func _on_MusicVolume_changed(value: float):
	AudioManagerInstance.set_music_volume(value / 100.0)

func _on_SFXVolume_changed(value: float):
	AudioManagerInstance.set_sfx_volume(value / 100.0)

func _on_Difficulty_Easy():
	GameManagerInstance.set_difficulty(0)
	$VBoxContainer/DifficultyLabel.text = "Difficulty: Easy"

func _on_Difficulty_Normal():
	GameManagerInstance.set_difficulty(1)
	$VBoxContainer/DifficultyLabel.text = "Difficulty: Normal"

func _on_Difficulty_Hard():
	GameManagerInstance.set_difficulty(2)
	$VBoxContainer/DifficultyLabel.text = "Difficulty: Hard"

func _on_Back_pressed():
	SaveManagerInstance.save_game()
	GameManagerInstance.change_scene("res://Scenes/Menu/MainMenu.tscn")
