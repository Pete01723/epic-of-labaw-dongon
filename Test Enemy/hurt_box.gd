extends Area2D

@export var health: Health

func damage(attack: AttackValuesComponent):
	if health:
		health.damage(attack)
