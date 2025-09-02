extends Node

var xr_interface : XRInterface
var producers : Array[Node3D]
var graphs : Array[Node3D]
static var savesys : SaveFile
static var player : Player

func _ready():
	var spawnp = get_tree().get_first_node_in_group("SpawnPoint")
	xr_interface = XRServer.find_interface("OpenXR")
	self.add_to_group("Global")
	create_save()
	
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
		
func FindPlayer() -> Player:
	return get_tree().get_first_node_in_group("Player")
	
func create_save():
	savesys = SaveFile.new()
	
func SeeSharpProducerAppend(producer : Node3D):
	producers.append(producer)
	
func save_game():
	var save_nodes = get_tree().get_nodes_in_group("Saveable")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		node.call("save")
	savesys.write_save()
	
func load_game():
	if SaveFile.save_exists():
		savesys = SaveFile.load_save()
		player = get_tree().get_first_node_in_group("Player")
		var load_nodes = get_tree().get_nodes_in_group("Saveable")
		for current in load_nodes:
			for loaded in savesys.saved_nodes:
				if current.id == loaded["id"]:
					for vars in loaded:
						current.set(vars,loaded[vars])
						if current.has_method("dynset") == true:
							current.dynset(vars,loaded[vars])
	else:
		print("No Save File")
