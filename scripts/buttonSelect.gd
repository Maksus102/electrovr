extends StaticBody3D

@export var COM_name : String
		
func use():
	print(COM_name)
	$"../..".CloseCOM()
	$"../..".OpenCOM(COM_name)
