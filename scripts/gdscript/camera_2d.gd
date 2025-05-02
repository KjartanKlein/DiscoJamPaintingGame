extends Camera2D
@onready var player = get_parent()
var waitingForMovement = false
signal cameraMoved
var lastCameraPosition = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if waitingForMovement:	
		if get_screen_center_position() == lastCameraPosition:
			print("aligned")
			cameraMoved.emit()
			waitingForMovement=false
	lastCameraPosition = get_screen_center_position()

func _on_player_player_moved() -> void:
	align()
	waitingForMovement=true
