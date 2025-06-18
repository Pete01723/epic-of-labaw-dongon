class_name MovementValuesComponent
extends Resource

@export var SPEED: float
@export var JUMP_VELOCITY: float
@export var ACCELERATION: float
@export var FRICTION: float
@export var AIR_RESISTANCE: float 
@export var AIR_ACCELERATION: float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
