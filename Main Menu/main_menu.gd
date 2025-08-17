extends Control

func _on_new_game_pressed():
	Main.goto_scene("res://Stage Test/stage_test.tscn")
	
func _on_continue_pressed():
	pass

func _on_quit_pressed():
	get_tree().quit()
