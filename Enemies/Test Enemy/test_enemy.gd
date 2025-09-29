extends CharacterBody2D

@export var animated_sprite: AnimatedSprite2D
var player: Node2D = null
var player_attack: Node2D = null
var is_attacking:bool

func _physics_process(delta: float) -> void:
	$EnemyMovementComponent.Handle_Navigation(player)
	$EnemyMovementComponent.Apply_Gravity(delta)
	$EnemyMovementComponent.Handle_Acceleration(delta)
	$EnemyMovementComponent.Apply_Friction(delta)
	$AttackComponent.Handle_Attack()
	Handle_Animation()
	move_and_slide()
	
	
func Handle_Animation():
	if velocity.x != 0 && is_attacking == false: 
		animated_sprite.play("walk")
		if velocity.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		if is_attacking == false:
			animated_sprite.play("idle")
	if is_attacking:
		velocity.x = 0
		animated_sprite.play("attack")
		
func _on_detection_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body

func _on_detection_box_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = null

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'attack':
		is_attacking = false
		$AttackTimer.start()
		
func _on_attack_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if player == body:
		player_attack = body
		is_attacking = true

func _on_attack_box_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player_attack = null

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtbox":
		$AttackComponent.Hits(area)

func _on_timer_timeout() -> void:
	if player_attack:
		is_attacking = true
		$HitBox.emit_signal("area_entered")

func _on_enemy_hurtbox_area_entered(area: Area2D) -> void:
	if $CollisitionTimer.is_stopped():
		if area.name == "PlayerHurtbox":
			$AttackComponent.Hits(area)
			$CollisitionTimer.start()
