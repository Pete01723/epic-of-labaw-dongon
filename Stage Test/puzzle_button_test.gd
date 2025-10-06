extends Area2D

var tween
var door

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(door, "position", door.movetolocation, 1)
	print(body)
	
func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(door, "position", door.spawnlocation, 1)
	
