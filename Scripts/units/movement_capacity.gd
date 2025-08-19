extends Node

func death_zone_move(entity:Node3D, spd:float, delta:float) -> void:
	entity.position.x += spd * delta
