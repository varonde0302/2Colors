extends Area3D

var player_in = false
@export var id:int

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if not player_in and type_convert(body.get_path(),TYPE_STRING) == GeneralVariables.PLAYER_PATH:
		print(body.speed)
		print(body.nb_life)
		player_in = true
		ItemManager.apply_item_effect(id,body)
		print(body.speed)
		print(body.nb_life)
