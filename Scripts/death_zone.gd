extends Area3D

class_name DeathZone
 
@export var able = false
@export var speed:float = 5
const TIME_MAX_SPD_MSEC = 600000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if able and not GeneralVariables.shop_open:
		position.x += speed * delta
		speed = update_speed(speed,GeneralVariables.game_time)

func update_speed(spd:float, gt:int) -> float:
	var n_spd:float
	
	n_spd = spd
	if (Time.get_ticks_msec() - gt) < TIME_MAX_SPD_MSEC:
		n_spd += spd*((Time.get_ticks_msec()-gt) / TIME_MAX_SPD_MSEC)
	return n_spd
