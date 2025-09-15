extends TextureProgressBar

@export var player : CharacterBody2D

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	for i in player.get_child_count():
		if player.get_child(i).name == "Health":
			value = (player.get_child(i).health.current_health_points*100)/player.get_child(i).health.max_health_points