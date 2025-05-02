extends ColorRect
var fadeIn = false
var fadeOut = false
var isCameraMoved = false
var lastModulate = Color(1,1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadeOut:
		if isCameraMoved:
			modulate = lerp(get_modulate(), Color(1,1,1,0),delta)
			if get_modulate().a<0.01:
				print("modulated")
				modulate = Color(1,1,1,0)
				fadeOut = false
				isCameraMoved = false
			lastModulate = get_modulate()

func _on_thedoor_fade_black() -> void:
	print("Door fade called")
	modulate = Color(1,1,1,1)
	visible = true
	fadeOut = true

func _on_camera_2d_camera_moved() -> void:
	isCameraMoved = true
