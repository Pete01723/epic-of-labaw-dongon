extends Node
class_name EnemyMovementComponent

@export var movement_values: MovementValuesComponent
@export var current_character: CharacterBody2D
@export var nav_agent: NavigationAgent2D
var next_path_pos: Vector2
var direction: Vector2

func _init() -> void:
	movement_values = movement_values
	current_character = current_character
	nav_agent = nav_agent
	next_path_pos = next_path_pos
	direction = direction

func Apply_Gravity(delta):
	if not self.current_character.is_on_floor():
		self.current_character.velocity.y += self.movement_values.gravity * delta
		
#func Handle_Jump():
#	if current_character.is_on_floor():
#		if Input.is_action_just_pressed("ui_accept"):
#			current_character.velocity.y = movement_values.JUMP_VELOCITY
			
func Apply_Friction(delta):
	if self.direction.x == 0 and self.current_character.is_on_floor():
		self.current_character.velocity.x = move_toward(self.current_character.velocity.x, 0.0, self.movement_values.FRICTION * delta)
		self.nav_agent.velocity.x = self.current_character.velocity.x
		
#func Apply_Air_Resistance(delta):
#	if current_character.velocity.x != 0 and not current_character.is_on_floor():
#		current_character.velocity.x = move_toward(current_character.velocity.x, 0.0, movement_values.AIR_RESISTANCE * delta)

func Handle_Acceleration(delta):
	if not self.current_character.is_on_floor(): 
		return
	if self.direction.x != 0:
		self.current_character.velocity.x = move_toward(self.current_character.velocity.x, self.direction.x * self.movement_values.SPEED, self.movement_values.ACCELERATION * delta)		
		self.nav_agent.velocity.x = self.current_character.velocity.x
	print(self.direction)
	
#func Handle_Air_Acceleration(direction, delta):
#	if current_character.is_on_floor(): 
#		return
#	if direction != 0:
#		current_character.velocity.x = move_toward(current_character.velocity.x, movement_values.SPEED * direction, movement_values.AIR_ACCELERATION * delta)

func Handle_Navigation(player:Node2D):
	if not player:
		direction = Vector2(0, 0)
		return
	next_path_pos = self.nav_agent.get_next_path_position()
	direction = self.current_character.position.direction_to(next_path_pos)
	self.nav_agent.target_position = player.position
