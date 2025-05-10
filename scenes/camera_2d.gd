extends Camera2D

@onready var follow : CharacterBody2D = %player

@export var marker :  Marker2D
var following = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_smoothing_enabled = false
	global_position = follow.global_position
	position_smoothing_enabled = true

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if following:
		global_position = follow.global_position
	else:
		global_position = marker.global_position


func go_to_marker() -> void:
	following = false
	pass # Replace with function body.


func follow_player() -> void:
	following = true
	pass # Replace with function body.
