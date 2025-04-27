extends Node2D

 
@onready var interaction_area :InteractionArea = $Interaction

signal boys_kissing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"on_interact")
	pass # Replace with function body.
	
func on_interact():
	boys_kissing.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tissues_tissue_got() -> void:
	pass # Replace with function body.
