extends YSort

class_name Door

onready var animated_sprite = get_node("AnimatedSprite")
onready var closed_collision = get_node("StaticBody2D/ClosedCollision")
onready var opened_collision_1 = get_node("StaticBody2D/OpenedCollision1")
onready var opened_collision_2 = get_node("StaticBody2D/OpenedCollision2")
onready var audio_player = get_node("AudioStreamPlayer")


func close_door():
	animated_sprite.frame = 0
	closed_collision.call_deferred("set_disabled", false)
	opened_collision_1.call_deferred("set_disabled", true)
	opened_collision_2.call_deferred("set_disabled", true)
	

func open_door():
	animated_sprite.frame = 1
	closed_collision.call_deferred("set_disabled", true)
	opened_collision_1.call_deferred("set_disabled", false)
	opened_collision_2.call_deferred("set_disabled", false)

func is_opened():
	return closed_collision.disabled


func _on_OpenDoorTrigger_body_entered(body):
	if body.get_name() == 'Player' && !is_opened():
		open_door()

func _on_CloseDoorTrigger_body_entered(body):
	if body.get_name() == 'Player' && is_opened():
		close_door()
func _on_EnemiesInSector_all_enemies_alive():
	audio_player.play()
	open_door()