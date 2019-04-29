extends "Door.gd"

class_name SouthDoor

func _on_OpenDoorTrigger_body_entered(body):
	if body.get_name() == 'Player' && is_opened():
		close_door()

func _on_CloseDoorTrigger_body_entered(body):
	if body.get_name() == 'Player' && !is_opened():
		open_door()



