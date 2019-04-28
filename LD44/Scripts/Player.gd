extends KinematicBody2D

signal update_UI_lives_label(absorbed_life)
signal kill_player

enum states {
	ALIVE,
	DEAD
}

class_name player


onready var UI = Global.UI
onready var gun_pivot : Position2D = get_node("GunPivot")
onready var player_gun : gun = get_node("GunPivot/GunPosition/Gun")
onready var absorbArea : Area2D =  get_node("AbsorbArea") 
onready var anim_player : AnimationPlayer = get_node("AnimationPlayer")
onready var effects_player : AnimationPlayer = get_node("EffectsPlayer")
onready var player_sprite : Sprite = get_node("PlayerSprite")
onready var hand_sprite : Sprite = get_node("GunPivot/Hand")


export var speed = 200;
export var absorbed_life : float = 50
export var lives_per_bullet : float = 1

var current_state = null
var move_direction = Vector2(0,0)
var overlapping_life_sources = []

func _ready():
	current_state = states.ALIVE
	self.connect("update_UI_lives_label", UI, 'update_lives_label')
	emit_signal("update_UI_lives_label", absorbed_life)
	player_gun.connect('gun_shot', self, '_on_gun_shot')
	for life_source in get_tree().get_nodes_in_group('life_source'):
		life_source.connect("absorbed_life_updated",self,'_on_absorbed_life_updated')


func _process(delta) -> void:
	if current_state == states.ALIVE:
		control_gun(delta)
	if current_state == states.DEAD:
		#Play Death animation
		#Wait till the animation dinishes
		emit_signal("kill_player")
		


func _physics_process(delta):
	if current_state == states.ALIVE:
		move(delta)


func control_gun(delta) -> void:
	gun_pivot.look_at(get_global_mouse_position())
	control_animations(gun_pivot)
	if Input.is_action_pressed("shoot") and absorbed_life > 0:
		player_gun.shoot()
	if Input.is_action_just_pressed("absorb_life"):
		#Maybe use a timer to use the ability
		absorb_life()


func control_animations(pivot : Position2D):
	var current_rotation = fmod(pivot.rotation_degrees, 360)
	if current_rotation < 0:
		current_rotation += 360
	
	if current_rotation <= 270 and current_rotation >= 90:
		player_sprite.set_flip_h(true)
		
	else:
		player_sprite.set_flip_h(false)
	
	if current_rotation >= 0 and current_rotation <= 180:
		hand_sprite.z_index = self.z_index + 1
		gun_pivot.z_index = self.z_index + 1
		if get_input_direction():
			anim_player.play("run")
		else:
			anim_player.play("idle")
	else:
		hand_sprite.z_index = self.z_index
		gun_pivot.z_index = self.z_index
		if get_input_direction():
			anim_player.play("run_back")
		else:
			anim_player.play("idle_back")


func move(delta) -> void:
	move_and_slide(get_input_direction().normalized() * speed)
	for i in range(get_slide_count() - 1):
		var collision = get_slide_collision(i)
		if collision.collider.get_script() != null:
			var script_name : String = collision.collider.get_script().get_name()
			if script_name.find("Enemy"):
				kill()
		
func kill():
	#current_state = states.DEAD
	#Play death animation
	#wait till animation finishes
	#emit_signal('kill_player')
	pass

func absorb_life():
	var didAbsorb = false
	if !effects_player.is_playing():
		overlapping_life_sources = absorbArea.get_overlapping_areas()
		for life_source in overlapping_life_sources:
			if life_source.has_method('kill_life_source'): 
				didAbsorb = true
				life_source.kill_life_source()
	
		if didAbsorb:
			effects_player.play("absorb")
		else:
			effects_player.play("try_absorb")
	#	print(overlapping_life_sources)
	#	print(absorbed_life)


func _on_absorbed_life_updated(life_source_life):
	absorbed_life += life_source_life
	emit_signal("update_UI_lives_label", absorbed_life)


func _on_gun_shot():
	absorbed_life -= lives_per_bullet
	emit_signal("update_UI_lives_label", absorbed_life)


func get_input_direction() -> Vector2:
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction
