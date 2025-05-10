extends Node2D

@onready var sprite: Sprite2D = $sprite
@onready var interaction_area :InteractionArea = $interaction
@onready var noise : AudioStreamPlayer2D = $AudioStreamPlayer2D

signal CoffeIsDone
signal dialogStart(name : String)

func _ready() -> void:
	interaction_area.interact  = Callable(self, "coffee_dispense")

func  coffee_dispense()-> void:
	noise.play()
	dialogStart.emit("coffee_machine")
	
