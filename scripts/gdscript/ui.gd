extends CanvasLayer

@onready var dialog_manager=$dialog_manager
@onready var coffee=$coffee
@onready var tissue=$tissue
@onready var crybox=$crybox
@onready var anime=$animeboy
@export var def_on = false

signal LockMovement()
signal unlockMovement()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	dialog_manager.visible = def_on
	coffee.visible = def_on
	tissue.visible = def_on
	crybox.visible = def_on
	anime.visible = def_on
	dialog_manager.is_active = false

func display_box(set_to : bool):
	dialog_manager.visible = true
		
func changeItem(item_added:String, set_to:bool):
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


func _on_coffe_machine_coffe_is_done() -> void:
	changeItem("coffee",true)

func _on_dialog_manager_dialog_finished() -> void:
	print("stopping dialog")
	dialog_manager.visible=false
	dialog_manager.is_active = false
	dialog_manager.setActive(false)
	unlockMovement.emit()
	get_tree().paused = false
	InteractionManager.untregister_closest()
	tissue.visible = dialog_manager.getItem("item_tissues")
	coffee.visible = dialog_manager.getItem("coffee_tissues")
	crybox.visible = dialog_manager.getItem("crybox_tissues")
	anime.visible = dialog_manager.getItem("anime_tissues")

func _on_dialog_start(dialog_name: String) -> void:
	if not dialog_manager.IsActive():
		dialog_manager.addItem("")
		dialog_manager.visible = true
		dialog_manager.goTo_knot(dialog_name)
		dialog_manager.getNext()
		dialog_manager.setActive(true)
		get_tree().paused = true
		
