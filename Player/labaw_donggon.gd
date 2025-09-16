extends CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

var reset_position: Vector2
var is_attacking: bool
var push_force = 50.0

signal healthChanged

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	$PlayerMovementComponent.Apply_Gravity(delta)
	$PlayerMovementComponent.Handle_Jump()
	$PlayerMovementComponent.Handle_Acceleration(direction, delta)
	$PlayerMovementComponent.Handle_Air_Acceleration(direction, delta)
	$PlayerMovementComponent.Apply_Friction(direction, delta)
	$PlayerMovementComponent.Apply_Air_Resistance(delta)
	$AttackComponent.Handle_Attack()
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	Handle_Animation()
	
func Handle_Animation():
	if velocity.x != 0 && is_attacking == false: 
		animated_sprite.play("run")
		if velocity.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		if is_attacking == false:
			animated_sprite.play("idle")
	if velocity.y < 0 and not is_on_floor() && is_attacking == false:
		animated_sprite.play("jump")
	elif velocity.y > 0 and not is_on_floor() && is_attacking == false:
		animated_sprite.play("fall")
	if Input.is_action_just_pressed('attack'):
		animated_sprite.play('attack')
		is_attacking = true

func on_enter():
	# Position for kill system. Assigned when entering new room (see Game.gd).
	reset_position = position

func _on_sprite_2d_animation_finished():
	if animated_sprite.animation == 'attack':
		is_attacking = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	$AttackComponent.Hits(area)

func _on_health_health_damaged():
	healthChanged.emit()
	
