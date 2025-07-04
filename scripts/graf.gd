extends Node3D
@onready var graph = $Screen/SubViewport/GraphInfo/Graph2D
var InputValue1 : Node3D
var InputValue2 : Node3D
var InputValue3 : Node3D

var x = 0.0
var plot1 : PlotItem
var plot2 : PlotItem
var plot3 : PlotItem

func _ready() -> void:
	plot1 = graph.add_plot_item("null",Color.BLUE,0.5)
	plot2 = graph.add_plot_item("null",Color.GREEN,0.5)
	plot3 = graph.add_plot_item("null",Color.YELLOW,0.5)
	pass

func _process(delta: float) -> void:
	x += delta
	if x > graph.x_max:
		plot1.remove_all()
		plot2.remove_all()
		plot3.remove_all()
		x = 0.0
	if (InputValue1 != null):
		var y1: float = float(InputValue1.output)
		plot1.add_point(Vector2(x,y1))
	if (InputValue2 != null):
		var y2: float = float(InputValue2.output)
		plot2.add_point(Vector2(x,y2))
	if (InputValue3 != null):
		var y3: float = float(InputValue3.output)
		plot3.add_point(Vector2(x,y3))
	pass
	
func Connect(port : int,source : Node3D):
	if (port == 1):	
		graph.remove_plot_item(plot1)
		InputValue1 = source
		plot1 = graph.add_plot_item(InputValue1.output_name,Color.BLUE,0.5)
	elif (port == 2):	
		graph.remove_plot_item(plot2)
		InputValue2 = source
		plot2 = graph.add_plot_item(InputValue2.output_name,Color.GREEN,0.5)
	elif (port == 3):	
		graph.remove_plot_item(plot3)
		InputValue3 = source
		plot3 = graph.add_plot_item(InputValue3.output_name,Color.YELLOW,0.5)
	pass
	
