extends Node2D
@onready var interaction_area = $interaction
@onready var ui = %UI

signal dialogStart(knot_name: String)
signal victory()
signal guard_start()

var dialog_done = false #inital burst
var requested_cry_box =false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "start_dialog")

func start_dialog():
	print("main painting interaction")
	if not dialog_done:
		print("intial dialog")
		dialogStart.emit("seeing_painting_1")
		dialog_done = true
		guard_start.emit()
		return
	if ui.tissue.visible:
		print("tissues")
		dialogStart.emit("give_tissues")		
		return
	if requested_cry_box:
		print("crybox")
		dialogStart.emit("ask_for_tissues")
		requested_cry_box = false
		return
	if ui.anime.visible:
		print("anime")
		dialogStart.emit("reunited")
		victory.emit()
		return		 
	print("main painting no dialog")
	$textbox.visible = true
	$boohootimer.start()
	#TODO add a boohoo or something when interaction fails
	


func _on_boyfriend_allow_tears() -> void:
	requested_cry_box = true


func _on_boohootimer_timeout() -> void:
	$textbox.visible = not 	$textbox.visible
