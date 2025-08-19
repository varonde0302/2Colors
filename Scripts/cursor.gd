extends Sprite3D

var last_mouse_position = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position.x = last_mouse_position.x - event.position.x 
		position.y = last_mouse_position.y - event.position.y
		print(position, event.screen_relative, event.screen_velocity)
		last_mouse_position = event.position 
