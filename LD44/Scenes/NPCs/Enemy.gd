extends KinematicBody2D

class_name enemy

enum states {
	SPAWN,
	IDLE,
	CHASE,
	ATTACK,
	DIE
}
var current_state = null
var destination : player



func _ready():
	player = get_tree().find
	current_state = states.SPAWN
	pass 

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












