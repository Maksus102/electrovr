extends StaticBody3D

@onready var graph = $".."
@export var PortNum : int

func use():
	var menu : ItemList = load("res://UI/ProdSelect.tscn").instantiate()
	menu.item_selected.connect(doit)
	add_child(menu)
	for x in Global.producers:
		menu.add_item(x.name)
		pass 
	pass


func doit(index : int):
	graph.Connect(PortNum,Global.producers[index])
	remove_child($"ProdSelect")
	pass
