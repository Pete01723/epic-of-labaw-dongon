@tool
extends BTAction

var left_target_pos:Vector2i = Vector2i(129,627)
var right_target_pos:Vector2i = Vector2i(1136,627)

func _generate_name() -> String:
	return 'Charge'

func _tick(delta):
	if agent.get_child(3).flip_h == false :
		var dist: float = absf(agent.global_position.x - left_target_pos.x)
		var dir: Vector2 = agent.global_position.direction_to(left_target_pos)
		var desired_velocity: Vector2 = dir.normalized() * 150
		agent.move(desired_velocity)
		if agent.position.x <= 140:
			agent.get_child(3).flip_h = true
			return SUCCESS
	else:
		var dist: float = absf(agent.global_position.x - right_target_pos.x)
		var dir: Vector2 = agent.global_position.direction_to(right_target_pos)
		var desired_velocity: Vector2 = dir.normalized() * 150
		print(agent.global_position.x)
		agent.move(desired_velocity)
		if agent.position.x >= 1130:
			agent.get_child(3).flip_h = false
			return SUCCESS
	return RUNNING
