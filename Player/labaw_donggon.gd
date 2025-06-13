extends CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	$MovementComponent.Apply_Gravity(delta)
	$MovementComponent.Handle_Jump()
	$MovementComponent.Handle_Acceleration(direction, delta)
	$MovementComponent.Handle_Air_Acceleration(direction, delta)
	$MovementComponent.Apply_Friction(direction, delta)
	$MovementComponent.Apply_Air_Resistance(delta)
	move_and_slide()
	Handle_Animation()
	
func Handle_Animation():
	if velocity.x != 0: 
		animated_sprite.play("run")
		if velocity.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		animated_sprite.play("idle")
	if velocity.y < 0 and not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.y > 0 and not is_on_floor():
		animated_sprite.play("fall")
