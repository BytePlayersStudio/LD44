extends Control

signal on_game_beaten

onready var lives_label : Label = get_node("MarginContainer/HBoxContainer/LivesLabel")
onready var win_container : MarginContainer = get_node("WinContainer")
onready var timer : Timer = get_node("Timer")

func _ready():
	Global.UI = self

func update_lives_label(absorbed_lives):
	lives_label.set_text(str(absorbed_lives))

func _on_all_enemies_alive():
	win_container.set_visible(true)
	timer.start()

func _on_Timer_timeout():
	emit_signal("on_game_beaten")
