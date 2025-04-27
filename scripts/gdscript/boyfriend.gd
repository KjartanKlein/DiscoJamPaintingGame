extends Node2D

@onready var interaction_area = $interaction
@onready var ui = %UI

var dialog_done = false
signal dialogStart(knot_name: String)
signal allowTears()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "start_dialog")
	
func start_dialog():
	if not dialog_done:
		dialogStart.emit("rooftop_boyfriend")
		dialog_done = true
		allowTears.emit()
		return
	if ui.crybox.visible:
		dialogStart.emit("has_crybox")
		ui.changeItem("crybox",false)
		ui.changeItem("anime", true)
		return
	print("boyfriend has no dialog")
	#TODO add something when interaction fails
	
