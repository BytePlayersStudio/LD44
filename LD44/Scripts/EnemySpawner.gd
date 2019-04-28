extends Node2D

export (PackedScene) var enemy_res
var spawn_positions = []

func _ready():
	if get_child_count() != 0:
		spawn_positions = get_children()
	
	print(spawn_positions)
	for sp in spawn_positions:
		spawn_enemy(sp)

func spawn_enemy(spawn_position):

	var enemy_to_spawn = enemy_res.instance()
	enemy_to_spawn.set_position(spawn_position.get_position())
	enemy_to_spawn.set_rotation(spawn_position.get_rotation())
	get_tree().get_root().add_child(enemy_to_spawn)
