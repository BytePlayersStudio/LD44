extends Node2D

func _on_Player_kill_player():
	get_tree().reload_current_scene()
