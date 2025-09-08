extends CharacterBody2D

@export var animated_sprite: AnimatedSprite2D
var player: Node2D = null
var player_attack: Node2D = null
var is_attacking:bool

func _physics_process(delta: float) -> void:
	Handle_Animation()
	move_and_slide()
	
func Handle_Animation():
	if velocity.x != 0: 
		animated_sprite.play("charge")
		if velocity.x > 0:
			animated_sprite.flip_h = false
		else:
			animated_sprite.flip_h = true
	else:
		if is_attacking == false:
			animated_sprite.play("idle")
		
func _on_detection_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body

func _on_detection_box_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = null
