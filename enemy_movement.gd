extends Node
class_name EnemyMovementComponent

@export var movement_values: MovementValuesComponent
@export var current_character: CharacterBody2D
@export var nav_agent: NavigationAgent2D

func Apply_Gravity(delta):
	if not current_character.is_on_floor():
		current_character.velocity.y += movement_values.gravity * delta
		
#func Handle_Jump():
#	if current_character.is_on_floor():
#		if Input.is_action_just_pressed("ui_accept"):
#			current_character.velocity.y = movement_values.JUMP_VELOCITY
			
func Apply_Friction(direction, delta):
	if direction == 0 and current_character.is_on_floor():
		current_character.velocity.x = move_toward(current_character.velocity.x, 0.0, movement_values.FRICTION * delta)

func Apply_Air_Resistance(delta):
	if current_character.velocity.x != 0 and not current_character.is_on_floor():
		current_character.velocity.x = move_toward(current_character.velocity.x, 0.0, movement_values.AIR_RESISTANCE * delta)

func Handle_Acceleration(direction, delta):
	if not current_character.is_on_floor(): 
		return
	if direction != 0:
		current_character.velocity.x = move_toward(current_character.velocity.x, direction * movement_values.SPEED, movement_values.ACCELERATION * delta)		
		nav_agent.velocity.x = current_character.velocity.x
		
func Handle_Air_Acceleration(direction, delta):
	if current_character.is_on_floor(): 
		return
	if direction != 0:
		current_character.velocity.x = move_toward(current_character.velocity.x, movement_values.SPEED * direction, movement_values.AIR_ACCELERATION * delta)
