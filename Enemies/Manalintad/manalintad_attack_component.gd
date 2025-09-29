extends Node
class_name ManalintadAttackComponent

@export var character : CharacterBody2D
@export var hitbox: CollisionPolygon2D
@export var attackbox: CollisionPolygon2D
@export var attack_values: AttackValuesComponent

func Hits(area):
	if area.has_method('damage'):
		area.damage(attack_values)
