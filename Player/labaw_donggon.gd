extends CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

var reset_position: Vector2
var is_attacking: bool

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	$PlayerMovementComponent.Apply_Gravity(delta)
	$PlayerMovementComponent.Handle_Jump()
	$PlayerMovementComponent.Handle_Acceleration(direction, delta)
	$PlayerMovementComponent.Handle_Air_Acceleration(direction, delta)
	$PlayerMovementComponent.Apply_Friction(direction, delta)
	$PlayerMovementComponent.Apply_Air_Resistance(delta)
	move_and_slide()
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
