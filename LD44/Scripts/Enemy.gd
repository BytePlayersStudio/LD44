extends KinematicBody2D

class_name enemy

enum states {
	SPAWN,
	IDLE,
	CHASE,
	ATTACK,
	DIE
}

export var navigation_stop_threshold = 5
export var speed = 450

onready var navigation = Global.navigation

var current_state = null
var destination : player
var path = []
var motion = Vector2()


func _ready():
	for p in get_tree().get_nodes_in_group('player'):
		destination = p
	current_state = states.SPAWN
	_make_path() 

#TODO FIXME: This works for now but we should make it more complex if we want to improve in thne future
func _physics_process(delta):
	match current_state:
		states.SPAWN:
			spawn()
		states.IDLE:
			idle()
		states.CHASE:
			chase()
		states.ATTACK:
			attack()
		states.DIE:
			die()
	#Add navigation once we have the tileset
	#_navigate()
	detect_collision(delta)

func spawn():
	pass

func chase():
	pass
	
func idle():
	pass
	
func attack():
	pass
	
func die():
	pass


func detect_collision(delta):
	motion = Vector2(speed,speed) * (destination.position - global_position).normalized()
	var collision = move_and_collide(motion * delta)
	if collision:
		if collision.collider.has_method('on_hit'):
			collision.collider.on_hit()
		on_hit()


func on_hit():
	queue_free()


func _navigate():
	var distance_to_path = position.distance_to(path[0])
	destination = path[0]
	if distance_to_path > navigation_stop_threshold:
		_move()
	else:
		_update_path()

func _move():
	motion = (destination.position - position).normalized() * speed
	
	
func _update_path():
	if path.size() >= 1:
		path.remove(0)
	else:
		_make_path()


func _make_path():
	var next_destination = destination.position
	path = navigation.get_simple_path(global_position, next_destination, false)








