extends KinematicBody2D

class_name Player


onready var gunPivot : Position2D = get_node("GunPivot")
onready var gun : Gun = get_node("GunPivot/GunPosition/Gun")
var move_direction = Vector2(0,0)
export var speed = 300;

	
func _process(delta) -> void:
	control_gun(delta)
	
func _physics_process(delta):
	move(delta)
	

func control_gun(delta) -> void:
	gunPivot.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot"):
		gun.shoot()

func move(delta) -> void:
	move_and_slide(get_input_direction().normalized() * speed)


func get_input_direction() -> Vector2:
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction
