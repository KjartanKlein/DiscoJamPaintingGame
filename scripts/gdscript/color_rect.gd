extends ColorRect
@export var max_fade_timer = 4.0
@export var fade_weight = 0.5
@onready var cam = %Camera2D

var fade_req =false
var timer = 0.0
var intro_sent = false
signal dialog_start(name :String)


func _ready():
	timer = 0.5
	fade_req =true
func _process(delta: float) -> void:
	if not fade_req and visible:
			cam.position_smoothing_enabled = true
	if fade_req:
		print("fade request recived")
		visible = true
		if timer == 0.0:
			timer = max_fade_timer
		cam.position_smoothing_enabled = false
		modulate = Color(1,1,1,1)
		fade_req = false
	if visible:
		timer -= delta 
		var weight =  fade_weight*(max_fade_timer-timer)/max_fade_timer
		weight = weight*weight ## more ooompf
		modulate = lerp(get_modulate(), Color(1,1,1,0),weight)
		if timer <=0:
			if !intro_sent:
				dialog_start.emit("intro")
				intro_sent = true
			timer = 0.0
			visible=false
			modulate = Color(1,1,1,0)	
			

func _on_fade_req() -> void:
	fade_req = true
