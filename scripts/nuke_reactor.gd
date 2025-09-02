extends StaticBody3D
@onready var text = $Label3D
@export var curve : Curve
@export var output = 0.0
@onready var timer = $Timer
@onready var audio = $ButtonAudio

var state = false
var id : String = "NR"
var output_name = "NukeEnergy"

func _ready() -> void:
	Global.producers.append(self)
	pass

func _on_timer_timeout() -> void:
	output = snappedf(randf_range(15,500),0.01)
	text.text = str(output)
	pass # Replace with function body.
	
func use():
	audio.play()
	if state == true:
		timer.stop()
		output = 0.0
		text.text = "OFF"
		state = false
	else:
		timer.start()
		state = true

func save():
	var stats = {"position" = self.position, "id" = "NR", "output" = output, "state" = state, "text.text" = text.text}
	Global.savesys.saved_nodes.append(stats)
	
func dynset(prop : String, value : Variant):
	match prop:
		"text.text" : text.text = value
		"state" : if state == true: timer.start()
		else:
			timer.stop()
	pass
	
