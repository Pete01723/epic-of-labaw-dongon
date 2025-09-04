extends Node


@export var character : CharacterBody2D
@export var hitbox: CollisionShape2D
@export var attack_values: AttackValuesComponent

func Handle_Attack():
	if character.velocity.x < 0 && hitbox.position.x > 0:
		hitbox.position.x *= -1
	elif character.velocity.x > 0 && hitbox.position.x < 0:
		hitbox.position.x *= -1
	if character.is_attacking == false:
		hitbox.disabled = true
	else:
		hitbox.disabled = false

func Hits(area):
	if area.has_method('damage'):
		area.damage(attack_values)
