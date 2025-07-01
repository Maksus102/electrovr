extends FPSController3D
class_name Player

## Example script that extends [CharacterController3D] through 
## [FPSController3D].
## 
## This is just an example, and should be used as a basis for creating your 
## own version using the controller's [b]move()[/b] function.
## 
## This player contains the inputs that will be used in the function 
## [b]move()[/b] in [b]_physics_process()[/b].
## The input process only happens when mouse is in capture mode.
## This script also adds submerged and emerged signals to change the 
## [Environment] when we are in the water.

@export var input_back_action_name := "move_backward"
@export var input_forward_action_name := "move_forward"
@export var input_left_action_name := "move_left"
@export var input_right_action_name := "move_right"
@export var input_sprint_action_name := "move_sprint"
@export var input_jump_action_name := "move_jump"
@export var input_crouch_action_name := "move_crouch"
@export var input_fly_mode_action_name := "move_fly_mode"

@export_file var Hit_Sprite

@export var underwater_env: Environment
@onready var interactor = $"Head/Interact"
@onready var holder = $"Head/HoldPos"
@onready var GloSig = get_node("/root/Global")

var cursstate = false


var inv_state = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	setup()
	emerged.connect(_on_controller_emerged.bind())
	submerged.connect(_on_controller_subemerged.bind())


		
func _physics_process(delta):
	var is_valid_input := Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED

	
	if is_valid_input:
		if Input.is_action_just_pressed(input_fly_mode_action_name):
			fly_ability.set_active(not fly_ability.is_actived())
		var input_axis = Input.get_vector(input_back_action_name, input_forward_action_name, input_left_action_name, input_right_action_name)
		var input_sprint = Input.is_action_pressed(input_sprint_action_name)
		var input_jump = Input.is_action_just_pressed(input_jump_action_name)
		var input_crouch = Input.is_action_pressed(input_crouch_action_name)
		var input_swim_down = Input.is_action_pressed(input_crouch_action_name)
		var input_swim_up = Input.is_action_pressed(input_jump_action_name)
		move(delta, input_axis, input_jump, input_crouch, input_sprint, input_swim_down, input_swim_up)
	else:
		# NOTE: It is important to always call move() even if we have no inputs 
		## to process, as we still need to calculate gravity and collisions.
		move(delta)
		


func _input(event: InputEvent) -> void:
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_head(event.relative)
			
	if Input.is_action_just_released("Interact"):
		interact()
		
	if Input.is_action_just_pressed("freecursor") and cursstate == false:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		cursstate = true
	elif Input.is_action_just_pressed("freecursor") and cursstate == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		cursstate = false
		interactor.look_at(interactor.global_position + camera.project_ray_normal(get_viewport().get_mouse_position()))

func _on_controller_emerged():
	camera.environment = null

func _on_controller_subemerged():
	camera.environment = underwater_env

	
func save():
	var save_dict = {		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"pos_z" : position.z,
		"basis.x" : basis.x,
		"basis.y" : basis.y,
		"basis.z" : basis.z,
		"health:hp": $HealthComp.hp,
		"global_rotation" : global_rotation}
	return save_dict
	
func interact():
	var detectedint = interactor.get_collider()
	if detectedint != null:
		if detectedint.has_method("use"):
			if detectedint.script != null:
				detectedint.use()
