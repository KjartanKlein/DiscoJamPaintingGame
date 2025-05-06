extends StaticBody2D

@onready var interaction_area :InteractionArea = $interaction
@onready var player = %player
@export var z_selector = z_index

signal hide(value: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "hide_player")
	
	
		
func hide_player():
	print("sending",z_selector)
	hide.emit(z_selector)
	player.go_hide(z_selector)
	
