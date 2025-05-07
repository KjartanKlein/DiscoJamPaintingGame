extends StaticBody2D

@export var visible_on = false

func _ready():
	visible = visible_on

func _on_map_swaproom(on: bool) -> void:
	if visible_on == on:
		visible = false
	else:
		visible = true
