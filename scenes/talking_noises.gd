extends AudioStreamPlayer
@onready var dialog :RichTextLabel = $"../dialog"

var old_count = 0

var base_pitch = 2.5
var rng = RandomNumberGenerator.new()
var delay = 0.5
func _process(delta):
	if delay > 0.0:
		delay -= delta
		if delay <= 0.0:
			delay =0.0 
			old_count = dialog.visible_characters
		return
	if dialog.visible_characters != old_count:
		play()
		old_count = dialog.visible_characters
		pitch_scale = base_pitch + rng.randf_range(-0.5, 0.5)
		delay = 0.05
	
