extends Node2D
class_name AttackComponent

@export var player : CharacterBody2D

func _process(delta):
	Handle_Attack()
	
func Handle_Attack():
	if player.velocity.x < 0 && $HurtBox/CollisionShape2D.position.x > 0:
		$HurtBox/CollisionShape2D.position.x *= -1
	elif player.velocity.x > 0 && $HurtBox/CollisionShape2D.position.x < 0:
		$HurtBox/CollisionShape2D.position.x *= -1
	if player.is_attacking == false:
		$HurtBox/CollisionShape2D.disabled = true
	else:
		$HurtBox/CollisionShape2D.disabled = false
	

func _on_hurt_box_area_entered(area):
	if area.has_method('damage'):
		var attack = AttackValuesComponent.new()
		attack.attack_damage = 1
		
		area.damage(attack)
