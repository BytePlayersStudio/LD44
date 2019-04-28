extends Area2D

signal absorbed_life_updated(life_source_life)

class_name life_source

onready var collision_shape = get_node("CollisionShape2D")
onready var life_source_sprite = get_node("LifeSourceSprite")
onready var anim_player = get_node("AnimationPlayer")

export var life_source_life : float = 20 
func _ready():
	anim_player.play("Idle_Alive")
	
	

func kill_life_source():
	anim_player.play("Idle_Dead")

	emit_signal("absorbed_life_updated",life_source_life)
	collision_shape.disabled = true