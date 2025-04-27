extends Node2D
@onready var interaction_area = $interaction
@onready var ui = %UI

signal dialogStart(knot_name: String)
var dialog_done = false #inital burst
var requested_cry_box =false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "start_dialog")

func start_dialog():
	if not dialog_done:
		dialogStart.emit("inital")
		dialog_done = true
		return
	if ui.tissue.visible:
		dialogStart.emit("tissues")
		ui.changeItem("tissue", false)
		return
	if requested_cry_box:
		dialogStart.emit("crybox")
		ui.changeItem("crybox",true)
		requested_cry_box = false
		return
	if ui.anime.visible:
		dialogStart.emit("boyfriend")
		ui.changeItem("anime", false)
		print("game won")
		return		 
	print("main painting no dialog")
	
	#TODO add a boohoo or something when interaction fails
	


func _on_boyfriend_allow_tears() -> void:
	requested_cry_box = true
