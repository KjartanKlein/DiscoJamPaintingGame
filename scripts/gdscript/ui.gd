extends CanvasLayer

@onready var dialog_manager=$dialog_manager
@onready var coffee=$inventory/Item2/coffee
@onready var tissue=$inventory/Item1/tissue
@onready var crybox=$inventory/Item3/crybox
@onready var anime=$inventory/Item4/anime_boy
@onready var soundfx : AudioStreamPlayer2D = $"ItemGet"
@export var def_on = false

@onready var sad_boy = $"dialog_manager/sad_boy"
@onready var bad_boy = $"dialog_manager/bad_boy"
@onready var coffee_lady = $"dialog_manager/coffee_lady"

signal LockMovement(lock:bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sad_boy.visible =false
	bad_boy.visible =false
	coffee_lady.visible = false
	dialog_manager.visible = def_on
	coffee.visible = def_on
	tissue.visible = def_on
	crybox.visible = def_on
	anime.visible = def_on
	dialog_manager.is_active = false

func display_box(set_to : bool):
	dialog_manager.visible = true
		
func changeItem(item_added:String, set_to:bool):
	print("trying to add item ", item_added)
	match item_added:
		"coffee":
			coffee.visible = set_to
			dialog_manager.addItem("coffee")
		"tissue":
			tissue.visible = set_to
			dialog_manager.addItem("tissues")
		"crybox":
			crybox.visible = set_to
			dialog_manager.addItem("crybox")
		"anime":
			anime.visible = set_to
			dialog_manager.addItem("anime")
		_: #RUST???
			print("item attempted to be added but could not, in ui.gd : ", item_added,"->", set_to)
	

func _on_tissues_tissue_got() -> void:
	changeItem("tissue", true)
	soundfx.pitch_scale = 1.0 
	soundfx.play()
	


func _on_coffe_machine_coffe_is_done() -> void:
	changeItem("coffee",true)
	soundfx.pitch_scale = 1.2 
	soundfx.play()

var crybox_played = false
var anime_played = false

func _on_dialog_manager_dialog_finished() -> void:
	print("stopping dialog")
	dialog_manager.visible=false
	dialog_manager.is_active = false
	dialog_manager.setActive(false)
	LockMovement.emit(false)
	get_tree().paused = false
	InteractionManager.untregister_closest()
	tissue.visible = dialog_manager.getItem("item_tissues")
	coffee.visible = dialog_manager.getItem("item_coffee")
	crybox.visible = dialog_manager.getItem("item_crybox")
	anime.visible = dialog_manager.getItem("item_anime")
	if crybox.visible && !crybox_played:
		crybox_played = true
		soundfx.pitch_scale = 1.4 
		soundfx.play()
	if anime.visible && !anime_played:
		anime_played = true
		soundfx.pitch_scale = 0.75 
		soundfx.play()
	
	sad_boy.visible =false
	bad_boy.visible =false
	coffee_lady.visible = false
	InteractionManager.can_interact = true
	

		
func _on_dialog_start(dialog_name: String) -> void:
	print("got dialog ->", dialog_name)
	if not dialog_manager.IsActive():
		dialog_manager.setItem("coffee", coffee.visible)
		dialog_manager.setItem("tissues", tissue.visible)
		dialog_manager.setItem("anime", anime.visible)
		dialog_manager.setItem("crybox", crybox.visible)
		dialog_manager.visible = true
		dialog_manager.goTo_knot(dialog_name)
		dialog_manager.getNext()
		dialog_manager.setActive(true)
		LockMovement.emit(true)
		InteractionManager.untregister_closest()
		InteractionManager.can_interact = false
		if victory:
			get_tree().change_scene_to_file("res://scenes/victory.tscn")
		
		
		
func changeChar(name: String, active: bool):
	print("changing to  ", name)
	if name == "bad_boy":
		print("bad_boy enabmled")
		bad_boy.visible = active
	if name == "sad_boy":
		sad_boy.visible = active
		print("sad_boy enabmled")
	if name == "coffee_lady":
		coffee_lady.visible = active
		print("coffee enabmled")
		

var victory = false
func _on_main_painting_victory() -> void:
	victory = true
