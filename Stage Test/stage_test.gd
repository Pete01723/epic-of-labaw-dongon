extends Node2D

func _ready() -> void:
	$"Puzzle Door Test".spawnlocation = $"Puzzle Door Test".position
	$"Puzzle Door Test".movetolocation = $"Solved Puzzled Door".position
	$"Puzzle Button Test".door = $"Puzzle Door Test"
