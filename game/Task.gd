extends Node3D

signal _player_picked_up_task


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		emit_signal("_player_picked_up_task")
