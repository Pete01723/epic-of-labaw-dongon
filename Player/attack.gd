extends Node2D
class_name AttackComponent

@export var player : CharacterBody2D

func _process(delta):
	Handle_Attack()
	
func Handle_Attack():
	if player.velocity.x < 0 && $HitBox/CollisionShape2D.position.x > 0:
		$HitBox/CollisionShape2D.position.x *= -1
	elif player.velocity.x > 0 && $HitBox/CollisionShape2D.position.x < 0:
		$HitBox/CollisionShape2D.position.x *= -1
	if player.is_attacking == false:
		$HitBox/CollisionShape2D.disabled = true
	else:
		$HitBox/CollisionShape2D.disabled = false
	
