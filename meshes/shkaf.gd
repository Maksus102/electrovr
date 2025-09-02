extends Node3D
var id = "Shkaf"
@onready var red_light : OmniLight3D = $LightIndicatorRed/RedLight
@onready var red_emi : Material = $LightIndicatorRed.mesh.surface_get_material(0)
@onready var alarm : AudioStreamPlayer3D = $Alarm
var alarm_light_state : bool = false

@onready var green_light : OmniLight3D = $LightIndicatorGreen/GreenLight
@onready var green_emi : Material = $LightIndicatorGreen.mesh.surface_get_material(0)

@onready var maxLabel : Label3D = $MaxLimiter/MaxLabel
@onready var minLabel : Label3D = $MinLimiter/MinLabel
var maxLimiter_state : bool = false
var minLimiter_state : bool = false
var maxLimiter_val : int = 0
var minLimiter_val : int = 0

@onready var graph = $GraphScreen/SubViewport/GraphInfo/Graph2D
var InputValue1 : Node3D
var InputValue2 : Node3D
var InputValue3 : Node3D

var x = 0.0
var plot1 : PlotItem
var plot2 : PlotItem
var plot3 : PlotItem
var maxLine : PlotItem
var minLine : PlotItem

func _ready() -> void:
	GreenLight(true)
	plot1 = graph.add_plot_item("null",Color.BLUE,0.5)
	plot2 = graph.add_plot_item("null",Color.GREEN,0.5)
	plot3 = graph.add_plot_item("null",Color.YELLOW,0.5)
	maxLine = graph.add_plot_item("Max", Color.RED,2)
	minLine = graph.add_plot_item("Min", Color.RED,2)
	Global.graphs.append(self)
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
		if (y1 >= maxLimiter_val and maxLimiter_state == true) or (y1 <= minLimiter_val and minLimiter_state == true):
			RedLightAlarm(true)
		else:
			RedLightAlarm(false)
	if (InputValue2 != null):
		var y2: float = float(InputValue2.output)
		plot2.add_point(Vector2(x,y2))
	if (InputValue3 != null):
		var y3: float = float(InputValue3.output)
		plot3.add_point(Vector2(x,y3))
	if (maxLimiter_state != false):
		for limitXmax in range(0,100,99):
			maxLine.add_point(Vector2(limitXmax,maxLimiter_val))
	if (minLimiter_state != false):
		for limitXmin in range(0,100,99):
			minLine.add_point(Vector2(limitXmin,minLimiter_val))
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
	
func Disconnect(port : int):
	if (port == 1):	
		graph.remove_plot_item(plot1)
		plot1 = graph.add_plot_item("null",Color.YELLOW,0.5)
		InputValue1 = null
	elif (port == 2):	
		graph.remove_plot_item(plot2)
		plot2 = graph.add_plot_item("null",Color.YELLOW,0.5)
		InputValue2 = null
	elif (port == 3):	
		graph.remove_plot_item(plot3)
		plot3 = graph.add_plot_item("null",Color.YELLOW,0.5)
		InputValue3 = null
	pass
	
func GreenLight(state : bool):
	if state == true:
		green_emi.emission_enabled = true
		green_light.show()
	else:
		green_emi.emission_enabled = false
		green_light.hide()
		
func RedLightAlarm(state : bool):
	if state == true:
		$AlarmTimer.start()
		alarm.play()
		red_emi.emission_enabled = true
		red_light.show()
		GreenLight(false)
	else:
		$AlarmTimer.stop()
		alarm.stop()
		red_emi.emission_enabled = false
		red_light.hide()
		alarm_light_state = false
		GreenLight(true)


func _on_alarm_timer_timeout() -> void:
	if alarm_light_state == true:
		red_emi.emission_enabled = false
		red_light.hide()
		alarm_light_state = false
	else:
		red_emi.emission_enabled = true
		red_light.show()
		alarm_light_state = true
	pass
	
func save():
	var stats = {"id" : id, "alarm_light_state" : alarm_light_state, "maxLimiter_state" : maxLimiter_state, "minLimiter_state" : minLimiter_state}
	Global.savesys.saved_nodes.append(stats)
