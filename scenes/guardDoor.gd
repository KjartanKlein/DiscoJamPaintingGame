extends Sprite2D


# Called when the node enters the scene tree for the first time.
var org_index = 0
func _ready() -> void:
	org_index = z_index

func _on_map_swaproom(on: bool) -> void:
	if on:
		z_index = 4
	else:
		z_index = org_index
