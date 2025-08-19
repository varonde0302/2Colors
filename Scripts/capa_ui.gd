extends Control



func _on_character_s_dash_cooldown() -> void:
	$"Dash Rect".modulate.a = 0.65

func _on_character_e_dash_cooldown() -> void:
	$"Dash Rect".modulate.a = 1
