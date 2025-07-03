extends StaticBody3D

@export var Source : Node3D
@export var Graph : Control

func use():
	Graph.Connect(Source)
	pass
