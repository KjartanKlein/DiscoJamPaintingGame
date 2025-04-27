extends Node2D
@onready var interaction_area = $interaction
@onready var player = %player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "check_lock")

func check_lock()-> void:
	player.global_position.x -= 2000
	pass
