extends CanvasLayer

@onready var name_c= $name_container
@onready var name_tag=$name_container/name
@onready var text_container=$text_container
@onready var text=$text_container/text
@onready var coffee=$coffee
@onready var tissue=$tissue
@onready var anime=$animeboy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var def_on = false
	name_c.visible = def_on
	text_container.visible = def_on
	coffee.visible = def_on
	tissue.visible = def_on
	anime.visible = def_on

func display_box(set_to : bool):
	name_tag.visible = set_to
	text_container.visible = set_to
	
func changeItem(item_added:String, set_to:bool):
	match item_added:
		"coffee":
			coffee.visible = set_to
		"tissue":
			tissue.visible = set_to
		"anime":
			anime.visible = set_to
		_: #RUST???
			print("item attempted to be added but could not, in ui.gd : ", item_added,"->", set_to)
	
func change_name(set_to:String):
	name_tag.text = set_to	

func change_text(set_to:String):##bad pracrise, but this is fast in dev
	text.text = set_to


func _on_tissues_tissue_got() -> void:
	changeItem("tissue", true)
