extends Node2D

class_name Gun

export (PackedScene) var Bullet

onready var bullet_spawn = get_node("BulletSpawn")

func _ready():
	if Bullet == null:
		print("Please add a Bullet scene to the Gun")

func shoot():
	var b = Bullet.instance()
	b.start(bullet_spawn.global_position, bullet_spawn.global_rotation)
	get_tree().get_root().add_child(b)