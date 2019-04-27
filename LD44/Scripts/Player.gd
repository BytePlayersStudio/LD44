extends KinematicBody2D

class_name Player


onready var gunPivot : Position2D = get_node("GunPivot")
onready var gun : Gun = get_node("GunPivot/GunPosition/Gun")
onready var absorbArea : Area2D =  get_node("AbsorbArea") 

export var speed = 500;
export var absorbed_life : float = 50
export var life_per_life_source : float = 20 #TODO: move this variable to the LifeSource script. CHAPUZA

var move_direction = Vector2(0,0)
var overlapping_life_sources = []



func _process(delta) -> void:
	control_gun(delta)


func _physics_process(delta):
	move(delta)


func control_gun(delta) -> void:
	gunPivot.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		gun.shoot()
	if Input.is_action_just_pressed("absorb_life"):
		#Maybe use a timer to use the ability
		absorb_life()
		

func move(delta) -> void:
	move_and_slide(get_input_direction().normalized() * speed)


func get_input_direction() -> Vector2:
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func absorb_life():
	#TODO: Be aware that we have to deactivate the life sources somehow, maybe sending a signal to all of the life_sources
	#in the overlapping_life_sources array.
	overlapping_life_sources = absorbArea.get_overlapping_areas()
	absorbed_life += life_per_life_source * overlapping_life_sources.size()
	#TODO: Send absorbed_life to the GUI every time it updates.
	print(absorbed_life)
