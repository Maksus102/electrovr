class_name SaveFile
extends Resource

const SAVE_PATH = "user://save1.tres"

@export var level_name = ""

static var temp_level_name : String

@export var player_transform = Vector3.ZERO

func write_save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	pass
	
static func save_exists():
	return ResourceLoader.exists(SAVE_PATH)

static func load_save() -> Resource:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	else:
		return null
