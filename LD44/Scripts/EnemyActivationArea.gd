extends Area2D
signal activate_enemies

func _ready():
	for enemy in get_parent().get_children():
		if enemy != self:
			connect("activate_enemies",enemy,"_on_enemy_activated")



func _on_EnemyActivationArea_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("activate_enemies")
