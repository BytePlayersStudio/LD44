extends Area2D

class_name life_source
onready var collision_shape = get_node("CollisionShape2D")
onready var lif_source_sprite = get_node("LifeSourceSprite")


func kill_life_source():
	lif_source_sprite.set_modulate(Color(1,0,0,1))
	collision_shape.disabled = true