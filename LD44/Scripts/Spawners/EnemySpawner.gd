extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_EnemySpawner_body_entered(body):
#	if body.get_name() == 'Player':
#		print(body.get_name())
#	if get_parent().has_method('close_door'):
#		get_parent().close_door()
	spawn()
	
func spawn():
	pass