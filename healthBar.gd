extends TextureProgressBar

@export var player : CharacterBody2D

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	value = (player.get_child(6).health.current_health_points*100)/player.get_child(6).health.max_health_points
	print(value)
