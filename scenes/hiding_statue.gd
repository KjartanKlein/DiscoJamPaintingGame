extends StaticBody2D

@onready var interaction_area :InteractionArea = $interaction
@onready var player = %player
@export var z_selector = z_index-1

@export var  do_rotate: bool = false
@export var off_x = 0.0
@export var off_y = 0.0
signal hide(value: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact  = Callable(self, "hide_player")
	
	
		
func hide_player():
	print("sending",z_selector)
	if ! player.hiding && player.hiding_timer == 0.0:
		hide.emit(z_selector)
		player.go_hide(z_selector)
		player.global_position = global_position+ Vector2(off_x, off_y)
		if do_rotate:
			player.rotation=0.0
			player.rotate(3.14156/2)	
