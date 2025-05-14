extends Node

var xr_interface : XRInterface

func _ready():
	var spawnp = get_tree().get_first_node_in_group("SpawnPoint")
	xr_interface = XRServer.find_interface("OpenXR")
	
	if xr_interface and xr_interface.is_initialized():
		print("VR Loaded")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		var vrplayascene = preload("res://vr_player.tscn")
		var vrins = vrplayascene.instantiate()
		add_child(vrins)
		vrins.global_position = spawnp.global_position
		
	else:
		print("VR Not loaded")
		var nonvrplayascene = preload("res://NonVRplayer.tscn")
		var nonvrins = nonvrplayascene.instantiate()
		add_child(nonvrins)
		nonvrins.global_position = spawnp.global_position
