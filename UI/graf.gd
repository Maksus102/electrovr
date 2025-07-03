extends Control
@onready var graph = $Graph2D
@export var InputValue : Node3D

var x = 0.0
var plot1 : PlotItem

func _ready() -> void:
	plot1 = graph.add_plot_item("null",Color.RED,0.5)
	pass

func _process(delta: float) -> void:
	if (InputValue != null):
		var y: float = float(InputValue.output)
		plot1.add_point(Vector2(x,y))
		x += delta
		if x > graph.x_max:
			plot1.remove_all()
			x = 0.0
	pass
	
func Connect(source : Node3D):
	graph.remove_plot_item(plot1)
	InputValue = source
	plot1 = graph.add_plot_item(InputValue.output_name,Color.GREEN,0.5)
	pass
	
