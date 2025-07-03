extends StaticBody3D
@onready var text = $Label3D
@export var curve : Curve
@export var output = 0.0
@onready var timer = $Timer
@export var graph_exp : Control

var state = false
var updtime : Timer
var output_name = "NukeEnergy"

func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	output = snappedf(randf_range(15,500),0.01)
	text.text = str(output)
	pass # Replace with function body.
	
func use():
	if state == true:
		timer.stop()
		output = 0.0
		text.text = "OFF"
		state = false
	else:
		timer.start()
		state = true
