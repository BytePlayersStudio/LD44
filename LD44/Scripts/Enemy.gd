extends KinematicBody2D

class_name enemy

enum states {
	SPAWN,
	IDLE,
	CHASE,
	ATTACK,
	ALIVE #Patrol behaviour
}

export var navigation_stop_threshold = 5
export var speed = 90
export var alive_speed = 20

onready var available_destinations : Node2D = Global.destinations
onready var navigation = Global.navigation
onready var enemy_sprite = get_node("EnemySprite")
onready var collision_shape = get_node("CollisionShape2D")
onready var idle_timer = get_node("IdleTimer")
onready var anim_player = get_node('AnimationPlayer')


var current_state = null
var player : player
var destination
var path = []
var possible_destinations = []
var motion = Vector2()



func _ready():
	print('spawned')
	for p in get_tree().get_nodes_in_group('player'):
		player = p
	destination = player.global_position
	current_state = states.SPAWN
	possible_destinations = available_destinations.get_children()
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
		states.ALIVE:
			alive()
	

func spawn():
	#Play Spawn Animation
	change_state(states.CHASE)
	pass

func chase():
	_navigate()


func idle():
	pass
	#play idle animation


func alive():
	_navigate()


func on_hit():
	enemy_sprite.set_modulate(Color(1,1,1,1))
	collision_shape.disabled = true
	speed = alive_speed
	
	change_state(states.ALIVE)
	#queue_free()


func _navigate():
	var distance_to_destination = position.distance_to(path[0])
	destination = path[0]
	
	if distance_to_destination > navigation_stop_threshold:
		_move()
	else:
		_update_path()


func _move():
	motion = (destination - position).normalized() * speed
	
	if is_on_wall():
		_make_path()

	move_and_slide(motion)


func _update_path():
	if path.size() > 1:
		path.remove(0)
	else:
		_make_path()
		if current_state == states.ALIVE:
			idle_timer.start()
			change_state(states.IDLE)



func _make_path():
	if current_state != states.ALIVE:
		destination = player.global_position
	else:
		destination = possible_destinations[randi() % possible_destinations.size()].global_position

	path = navigation.get_simple_path(global_position, destination, false)

func change_state(new_state):
	if new_state == states.CHASE:
		anim_player.play("chase_undead")
	if new_state == states.ALIVE:
		anim_player.play("chase_alive")
	current_state = new_state



func _on_IdleTimer_timeout():
	change_state(states.ALIVE)
