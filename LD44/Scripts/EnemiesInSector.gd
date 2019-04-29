extends YSort

signal all_enemies_alive

# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in get_children():
		if enemy != get_node("EnemyActivationArea"):
			enemy.connect("send_enemy_alive", self, "_on_new_enemy_alive")

func _on_new_enemy_alive():
	print("new enemy alive")
	for enemy in get_children():
		if enemy != get_node("EnemyActivationArea"):
			if enemy.is_alive == false:
				return;
	print("All enemies alive")
	emit_signal("all_enemies_alive")
