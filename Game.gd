extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"
class_name Game
const RoomInstance = preload("res://addons/MetroidvaniaSystem/Scripts/RoomInstance.gd")

var starting_coords: Vector2i

var custom_run: bool

var current_room: RoomInstance



@onready var music = $AudioStreamPlayer
var ForestTheme = preload("res://Assets/Music/Forest Theme.mp3")

func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	set_player($Player)
	room_loaded.connect(init_room, CONNECT_DEFERRED)
	load_room(^'Forest Stage/level_1.tscn')
	_music_check()
	
	var start := map.get_node_or_null(^"Spawn Player")
	if start and not custom_run:
		player.position = start.position
	await get_tree().physics_frame
	add_module("RoomTransitions.gd")

func _music_check():
	current_room = MetSys.get_current_room_instance()
	if current_room.room_name == 'Stage Test/stage_test.tscn' || current_room.room_name == 'Stage Test/stage_test2.tscn' || current_room.room_name == "Forest Stage/level_1.tscn":
		if !music.is_playing():
			ForestTheme.loop = true
			music.stream = ForestTheme
			music.play()
	
static func get_singleton() -> Game:
	return (Game as Script).get_meta(&"singleton") as Game
	
func reset_starting_coords():
	# Starting position for the delta vector.
	var coords := MetSys.get_current_flat_coords()
	starting_coords = Vector2i(coords.x, coords.y)
	
func init_room():
	MetSys.get_current_room_instance().adjust_camera_limits($Player/Camera2D)
	player.on_enter()
	# Initializes MetSys.get_current_coords(), so you can use it from the beginning.
	if MetSys.last_player_position.x == Vector2i.MAX.x:
		MetSys.set_player_position(player.position)
