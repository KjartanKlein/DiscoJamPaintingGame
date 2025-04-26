extends Area2D
class_name InteractionArea

@export var hint_text: String = "press E to interact"
@onready var collision_shape: CollisionShape2D = $Collider
@export var shape: Shape2D

var interact: Callable = func():
	pass
	
func _ready() -> void:
	collision_shape.shape = shape
	
func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
