extends StaticBody3D

@export var Source : Node3D

func use():
	Global.FindPlayer().OutputSelect = Source
	print(Global.FindPlayer().OutputSelect)
	pass
