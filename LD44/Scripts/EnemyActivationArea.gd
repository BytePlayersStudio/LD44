extends Area2D
signal activate_enemies

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in get_parent().get_children():
		if enemy != self:
			connect("activate_enemies",enemy,"_on_enemy_activated")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EnemyActivationArea_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("activate_enemies")
