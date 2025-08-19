extends Node3D


func _on_out_body_exited(body: Node3D) -> void:
	if type_convert(body.get_path(),TYPE_STRING) == GeneralVariables.PLAYER_PATH:
		GeneralVariables.can_switch_zone = true
		GeneralVariables.id_lzone = GeneralVariables.id_zone
		GeneralVariables.id_zone = randi_range(1,3)
