extends Node2D
@onready var interaction_area = $interaction
@onready var player = %player
@export var location : InteractionArea; 
@export var player_offsett = -200
signal fadeBlack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "check_lock")

func check_lock()-> void:
	player.global_position = location.global_position + Vector2(player_offsett,0)
	#player.global_position = Vector2(3000,-100)# + Vector2(player_offsett,0)
	fadeBlack.emit()
	pass
