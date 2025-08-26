extends Node

var current_scene = null
var player: CharacterBody2D = null
var spawn_player = null
var door_target = null
var collectables: Dictionary


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	# Instantiates the player if the player does not exist yet. Otherwise, it moves the player's position to the destination of the stage's door.
	if (get_tree().current_scene.name.begins_with("Stage")):
		if (!player):
			s = ResourceLoader.load("res://Player/labaw_donggon.tscn")
			player = s.instantiate()
			get_tree().root.add_child(player)
			spawn_player = get_tree().current_scene.get_node("Spawn Player")
			player.position = spawn_player.position
		else:
			spawn_player = get_tree().current_scene.get_node(NodePath(door_target))
			player.position = spawn_player.position
			if (!player.animated_sprite.flip_h):
				player.position.x += 30
			else:
				player.position.x -= 30
