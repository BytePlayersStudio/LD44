extends KinematicBody2D

class_name bullet

var velocity
export var speed = 100

func start(pos, dir) -> void:
	rotation = dir
	position = pos
	velocity = Vector2(speed,0).rotated(rotation)

func _physics_process(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	
func on_hit():
	queue_free()
	
func _on_DestroyTimer_timeout():
	queue_free()
