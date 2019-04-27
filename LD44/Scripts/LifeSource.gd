extends Area2D

signal absorbed_life_updated(life_source_life)

class_name life_source

onready var collision_shape = get_node("CollisionShape2D")
onready var lif_source_sprite = get_node("LifeSourceSprite")

export var life_source_life : float = 20 

func kill_life_source():
	lif_source_sprite.set_modulate(Color(1,0,0,1))
	emit_signal("absorbed_life_updated",life_source_life)
	collision_shape.disabled = true