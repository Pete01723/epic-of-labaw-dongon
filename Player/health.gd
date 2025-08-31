extends Node2D
class_name Health

@export var health: HealthPointComponent
var taking_damage = false

func damage(attack:Attack):
	print(health.current_health_points)
	health.current_health_points-=attack.attack_damage
	
	if health.current_health_points <= 0:
		get_parent().queue_free()
	
	taking_damage = true
	
