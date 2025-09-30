extends Node2D

@export var node_detector: Area2D

@export var rest_length = .25
@export var stiffness = 1
@export var damping = 1.0

@onready var ray := $RayCast2D
@onready var player := get_parent()
@onready var rope := $Line2D

var launched = false
var target : Vector2
var nodes: Array

#launches the grappling rope
func Launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()

#retracts the grappling rope
func Retract():
	launched = false
	rope.hide()

#handles the grappling mechanic
func Handle_Grapple(delta):
	var target_direction = player.global_position.direction_to(target)
	var target_distance = player.global_position.distance_to(target)
	var displacement = target_distance - rest_length
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_direction * spring_force_magnitude
		var velocity_dot = player.velocity.dot(target_direction)
		var damping = -damping * velocity_dot * target_direction
		
		force = spring_force + damping
	player.velocity += force * delta
	print('Velocity: ' + str(player.velocity))
	print('Local Target: ' + str(to_local(target)))
	Update_Rope()
	
#draws the rope between the player and the target point
func Update_Rope():
	rope.set_point_position(1, to_local(target))
	
func Check_Grapple_Nodes():
	nodes = node_detector.get_overlapping_bodies()

func _process(delta):
	Check_Grapple_Nodes()
	if len(nodes)>0:
		ray.look_at(nodes[0].global_position)
	
	if Input.is_action_just_pressed("special"):
		Launch()
		
	if Input.is_action_just_released("special"):
		Retract()
		
	if launched:
		Handle_Grapple(delta)
