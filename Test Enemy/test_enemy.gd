extends CharacterBody2D

var player: Node2D = null

func _physics_process(delta: float) -> void:
	var next_path_pos = $NavigationAgent2D.get_next_path_position()
	var direction = position.direction_to(next_path_pos)
	if player:
		$NavigationAgent2D.target_position = player.position
	
	$EnemyMovementComponent.Apply_Gravity(delta)
	$EnemyMovementComponent.Handle_Acceleration(direction.x, delta)
	$EnemyMovementComponent.Apply_Friction(direction.x, delta)
	move_and_slide()

func _on_detection_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body

func _on_detection_box_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = null
