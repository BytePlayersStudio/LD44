extends Control

onready var lives_label : Label = get_node("MarginContainer/LivesLabel")

func _ready():
	print(self)
	Global.UI = self
	print(Global.UI)

func update_lives_label(absorbed_lives):
	lives_label.set_text(str(absorbed_lives))
