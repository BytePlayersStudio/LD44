extends Node2D

class_name Gun

export (PackedScene) var Bullet
export var cooldown : float = .5

onready var bullet_spawn : Position2D = get_node("BulletSpawn")
onready var cooldown_timer : Timer= get_node('CooldownTimer')

var can_shoot : bool = true

func _ready() -> void:
	cooldown_timer.wait_time = cooldown
	if Bullet == null:
		print("Please add a Bullet scene to the Gun")

func shoot() -> void:
	if can_shoot:
		can_shoot = false
		cooldown_timer.start()
		var b = Bullet.instance()
		b.start(bullet_spawn.global_position, bullet_spawn.global_rotation)
		get_tree().get_root().add_child(b)


func _on_CooldownTimer_timeout():
	can_shoot = true
