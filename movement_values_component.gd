class_name MovementValuesComponent
extends Resource

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var ACCELERATION  = 800.0
@export var FRICTION = 2400.0
@export var AIR_RESISTANCE = 200.0 
@export var AIR_ACCELERATION = 400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
