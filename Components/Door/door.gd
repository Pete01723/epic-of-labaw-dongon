extends Node

class_name DoorComponent

@export var target_scene: String
@export var door: Area2D

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if (body.name == "Player"):
		Main.door_target = door.name
		Main.goto_scene(target_scene)
