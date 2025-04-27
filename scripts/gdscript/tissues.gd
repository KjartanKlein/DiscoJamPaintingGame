extends Node2D

@onready var sprite: Sprite2D = $sprite
@onready var interaction_area :InteractionArea = $interaction

signal tissueGot
func _ready() -> void:
	interaction_area.interact  = Callable(self, "collect_tissue")
	
func collect_tissue():
	tissueGot.emit()
	sprite.visible= false
	interaction_area.global_position.x = 500000000000 #TODO, learn to kill
	
	
	
