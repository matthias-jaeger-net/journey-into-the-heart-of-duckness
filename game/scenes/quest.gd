extends Node3D

signal quest_started
signal quest_finished

func _on_area_3d_body_entered(body):
	var has_cookie = get_tree().root.get_child(0).has_cookie
	
	if body.is_in_group("player"):
		if has_cookie == true:
			emit_signal("quest_finished")
		else:
			emit_signal("quest_started")

