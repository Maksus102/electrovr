class_name SaveFile
extends Resource

const SAVE_PATH = "user://save1.res"

@export var saved_nodes : Array
	
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
