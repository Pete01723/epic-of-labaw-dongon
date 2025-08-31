extends Control

@onready var music = $AudioStreamPlayer

func _on_new_game_pressed():
	music.stop()
	Main.goto_scene("res://Game.tscn")
	
func _on_continue_pressed():
	pass

func _on_quit_pressed():
	get_tree().quit()
