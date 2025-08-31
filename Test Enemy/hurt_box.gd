extends Area2D

@export var health: Health

func damage(attack: Attack):
	if health:
		health.damage(attack)
