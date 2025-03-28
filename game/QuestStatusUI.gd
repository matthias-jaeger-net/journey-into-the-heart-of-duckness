extends CanvasLayer


@onready var label = $Label

func _ready():
	label.visible = false

func _on_node_3d_quest_started():
	label.visible = true
	label.text = "Find Johns Bar"
	
