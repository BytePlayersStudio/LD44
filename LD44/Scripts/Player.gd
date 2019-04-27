extends KinematicBody2D

class_name player


onready var gunPivot : Position2D = get_node("GunPivot")
onready var player_gun : gun = get_node("GunPivot/GunPosition/Gun")
onready var absorbArea : Area2D =  get_node("AbsorbArea") 

export var speed = 500;
export var absorbed_life : float = 50


var move_direction = Vector2(0,0)
var overlapping_life_sources = []

func _ready():
	for life_source in get_tree().get_nodes_in_group('life_source'):
		life_source.connect("absorbed_life_updated",self,'_on_absorbed_life_updated')


func _process(delta) -> void:
	control_gun(delta)


func _physics_process(delta):
	move(delta)


func control_gun(delta) -> void:
	gunPivot.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		player_gun.shoot()
	if Input.is_action_just_pressed("absorb_life"):
		#Maybe use a timer to use the ability
		absorb_life()
		

func move(delta) -> void:
	move_and_slide(get_input_direction().normalized() * speed)

func absorb_life():
	overlapping_life_sources = absorbArea.get_overlapping_areas()
	for life_source in overlapping_life_sources:
		if life_source.has_method('kill_life_source'): 
			life_source.kill_life_source()
	print(overlapping_life_sources)
	print(absorbed_life)

func _on_absorbed_life_updated(life_source_life):
	#TODO: Send absorbed_life to the GUI every time it updates.
	absorbed_life += life_source_life

func get_input_direction() -> Vector2:
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction
