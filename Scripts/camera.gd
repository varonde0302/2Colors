extends Camera3D

@export var speed = 11.0
@export var target:CharacterBody3D

func _process(delta: float) -> void:

	if Vector2(position.x-5,position.y).distance_to(Vector2(target.position.x,target.position.y)) > 5:
		var direction = DataManagment.calcul_dir_vector(self,target)

		position.x += (speed+10)*delta*direction.x
		position.y += (speed+10)*delta*direction.y

	else:
			position.x += (speed)*delta


	print(position,'/',target.position)

func _on_cooldown_timeout() -> void:
	speed = target.speed
