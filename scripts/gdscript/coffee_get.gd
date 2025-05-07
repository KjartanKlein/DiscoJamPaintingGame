extends Node2D

@onready var sprite: Sprite2D = $sprite
@onready var interaction_area :InteractionArea = $interaction

signal CoffeIsDone

func _ready() -> void:
	interaction_area.interact  = Callable(self, "coffee_dispense")

func  coffee_dispense()-> void:
	CoffeIsDone.emit()	
