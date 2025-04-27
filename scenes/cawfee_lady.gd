extends Node2D
@onready var interaction_area = $interaction
@onready var ui = %UI

var dialog_done = false

signal dialogStart(knot_name: String)
signal hasKeyCode()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "start_dialog")
	
func start_dialog():
	if not dialog_done:
		dialogStart.emit("coffee_lady")
		dialog_done = true
		return
	if ui.coffee.visible:
		dialogStart.emit("has_coffee")
		ui.changeItem("coffee",false)
		hasKeyCode.emit()
		return
	print("coffee lady no dialog")
	#TODO add something when interaction fails
	
