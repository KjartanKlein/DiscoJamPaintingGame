extends StaticBody2D

@onready var interaction_area :InteractionArea = $interaction

signal hide(value: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "hide_player")
	
		
func hide_player():
	print("sending",z_index)
	hide.emit(z_index)
	
