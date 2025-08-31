extends Node2D
class_name Health

@export var health: HealthPointComponent
var taking_damage = false

func damage(attack:Attack):
	health.current_health_points-=attack.attack_damage
	
	if health.current_health_points <= 0:
		queue_free()
	
	taking_damage = true
	
