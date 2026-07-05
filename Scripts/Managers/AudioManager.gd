extends Node

class_name AudioManager

var music_volume: float = 0.5
var sfx_volume: float = 0.7
var master_volume: float = 1.0

var audio_players: Dictionary = {}
var current_music: String = ""

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")
	
	for i in range(5):
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_players["effect_%d" % i] = player

func play_effect(effect_name: String, volume: float = 1.0):
	var player = get_available_audio_player()
	if player:
		var stream = load("res://Assets/Sounds/Effects/%s.ogg" % effect_name)
		if stream:
			player.stream = stream
			player.volume_db = linear2db(sfx_volume * master_volume * volume)
			player.play()

func play_music(music_name: String, loop: bool = true):
	if current_music == music_name:
		return
	
	current_music = music_name
	var stream = load("res://Assets/Sounds/Music/%s.ogg" % music_name)
	
	if stream:
		if not audio_players.has("music"):
			var player = AudioStreamPlayer.new()
			add_child(player)
			audio_players["music"] = player
		
		var player = audio_players["music"]
		player.stream = stream
		player.volume_db = linear2db(music_volume * master_volume)
		player.play()

func stop_music():
	if audio_players.has("music"):
		audio_players["music"].stop()
		current_music = ""

func set_master_volume(volume: float):
	master_volume = clamp(volume, 0.0, 1.0)
	update_volumes()

func set_music_volume(volume: float):
	music_volume = clamp(volume, 0.0, 1.0)
	update_volumes()

func set_sfx_volume(volume: float):
	sfx_volume = clamp(volume, 0.0, 1.0)
	update_volumes()

func update_volumes():
	if audio_players.has("music"):
		audio_players["music"].volume_db = linear2db(music_volume * master_volume)
	
	for i in range(5):
		if audio_players.has("effect_%d" % i):
			audio_players["effect_%d" % i].volume_db = linear2db(sfx_volume * master_volume)

func get_available_audio_player() -> AudioStreamPlayer:
	for i in range(5):
		var player = audio_players["effect_%d" % i]
		if not player.playing:
			return player
	return audio_players["effect_0"]
