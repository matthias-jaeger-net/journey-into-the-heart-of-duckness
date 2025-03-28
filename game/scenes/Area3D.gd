extends Area3D


func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area):
	# emit_signal("counter_updated", counter + 1)
	print("Area entered by")

