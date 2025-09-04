extends Node2D
class_name Health

@export var health: HealthPointComponent
var taking_damage = false

signal healthDamaged

func damage(attack:AttackValuesComponent):
	print(health.current_health_points)
	health.current_health_points-=attack.attack_damage
	
	if health.current_health_points <= 0:
		get_parent().queue_free()
	
	healthDamaged.emit()
	
	taking_damage = true
	
