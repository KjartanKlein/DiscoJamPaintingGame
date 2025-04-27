extends Node2D
@onready var interaction_area = $interaction

@export var unlocked = false
@onready var player = $"../../../player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "check_lock")

func check_lock()-> void:
	if unlocked:
		player.global_position.x += 2000
		print("teleport")
	else:
		print("I am locked")


func _on_cawfee_lady_has_key_code() -> void:
	unlocked = true
