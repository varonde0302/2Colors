extends Area3D

var in_zone = false
signal open

func _process(delta: float) -> void:
	if in_zone and Input.is_action_just_pressed("random"):
		open.emit()

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if not in_zone and type_convert(body.get_path(),TYPE_STRING) == GeneralVariables.PLAYER_PATH:
		in_zone = true

func _on_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if in_zone and type_convert(body.get_path(),TYPE_STRING) == GeneralVariables.PLAYER_PATH:
		in_zone = false
