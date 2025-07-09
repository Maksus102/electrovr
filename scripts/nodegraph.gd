extends GraphEdit

@onready var refresh_btn = $Refresh

func _on_refresh_pressed() -> void:
	for x in Global.producers:
		var new_node : GraphNode = load("res://UI/GraphNodes/ProducerNode.tscn").instantiate()
		new_node.title = x.name
		new_node.parent = x
		add_child(new_node)
	for x in Global.graphs:
		var new_node : GraphNode = load("res://UI/GraphNodes/GraphNode.tscn").instantiate()
		new_node.title = x.name
		new_node.parent = x
		add_child(new_node)
	pass # Replace with function body.
	
	
	


func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	connect_node(from_node,from_port,to_node,to_port)
	match to_port:
		0:
			get_node("{0}".format({"0" : to_node})).parent.Connect(1,get_node("{0}".format({"0" : from_node})).parent)
		1:
			get_node("{0}".format({"0" : to_node})).parent.Connect(2,get_node("{0}".format({"0" : from_node})).parent)
		2:
			get_node("{0}".format({"0" : to_node})).parent.Connect(3,get_node("{0}".format({"0" : from_node})).parent)
	pass # Replace with function body.
