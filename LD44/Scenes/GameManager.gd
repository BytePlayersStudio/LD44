extends Node2D

func reload():
	get_tree().reload_current_scene()

func _on_Player_kill_player():
	reload()

func _on_UI_on_game_beaten():
	reload()
