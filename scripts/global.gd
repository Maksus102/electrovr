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
	
func SeeSharpProducerAppend(producer : Node3D):
	producers.append(producer)
	
static func save_game():
	savesys.player_transform = player.global_position
	savesys.level_name = SaveFile.temp_level_name
	savesys.write_save()
	
func create_save():
	if SaveFile.save_exists():
		savesys = SaveFile.load_save() as SaveFile
	else:
		savesys = SaveFile.new()
	pass
	
func load_game():
	savesys.load_save()
	player.global_position = savesys.player_transform
