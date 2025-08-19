extends CharacterBody3D

var speed = 0
var other_speed = 85                                                                                    
@export var walk_speed:float=400
@export var dash_speed:float=1500
@export var expl_speed:float=1500

var direction:Vector3

@export var dash_distance = 7.5
var b_d_dist = 7.5
@export var expl_distance = 1
var b_e_dist = 1
var begin_dash_position: Vector3
var begin_expl_position:Vector3


var walk = true
var dash = false
var explosion = false

var  nb_dash_done = 0
var look_dir:Vector2

const JUMP_VELOCITY = 570

var nb_life:int=1
var gameover:bool=false

var array_mouse_position: Array

@onready var last_position = position

signal u_score
signal s_dash
signal e_dash
signal s_expl
signal e_expl
signal s_dash_cooldown
signal e_dash_cooldown

func _physics_process(delta: float) -> void:
	if not gameover and not GeneralVariables.shop_open:

		# Add the gravity.
		if not is_on_floor():
			velocity.y += -20*delta
			speed = other_speed
		else:
			speed= walk_speed
		# Handle jump.
		jump(delta)

		#DIFFERENT MOVEMENT
		start_dash()
		start_explosion()

		
		if walk:
			done_walk(delta)
		if dash:
			done_dash(delta)
		if explosion:
			done_explosion(delta)
	
		
		end_dash()
		end_explosion()

		move_and_slide()
		
		if walk:
			update_score()

func _input(event: InputEvent) -> void:
	move_look(event)
#MOVEMENT SYSTEM
func done_walk(delta):
	if not is_on_wall():
		direction = Vector3(1,0,0)
		velocity.x = direction.x * speed * delta

func jump(delta):
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY*delta

func start_dash():
	if Input.is_action_just_pressed("dash") and not explosion and not dash and $"Timers/Dash Cooldown".is_stopped() and not is_on_wall() and is_on_floor():
		nb_dash_done += 1
		if nb_dash_done == 2:
			nb_dash_done = 0
			$"Timers/Dash Cooldown".start()
			s_dash_cooldown.emit()
			
		direction = DataManagment.calcul_dir_vector($Pivot,$Pivot/Curseur)
		dash = true
		walk = false
		begin_dash_position = position
		s_dash.emit()

func done_dash(delta):
	if not is_on_wall():
		velocity.x = direction.x * dash_speed * delta
		velocity.y = direction.y * dash_speed * delta
		GeneralVariables.coef_mult = position.distance_to(begin_dash_position)/b_d_dist

func end_dash():
	if dash and (position.distance_to(begin_dash_position) > dash_distance or (is_on_wall() and not is_on_floor()) or is_on_ceiling()):
		dash = false
		walk = true
		velocity.x = 0
		velocity.y = -5
		e_dash.emit()

func start_explosion():
	if Input.is_action_just_pressed("explosion") and is_on_floor() and not explosion:
		direction = DataManagment.calcul_dir_vector($Pivot,$Pivot/Curseur)
		if dash:
			dash = false
			e_dash.emit()
		explosion = true
		walk = false
		begin_expl_position = position
		s_expl.emit()
		
		
func done_explosion(delta):
	velocity.x = direction.x * expl_speed * delta
	velocity.y = direction.y * expl_speed * delta
	GeneralVariables.coef_mult = position.distance_to(begin_expl_position)/b_e_dist

func end_explosion():
	if explosion and position.distance_to(begin_expl_position) > expl_distance:
		explosion = false
		walk = false
		e_expl.emit()
#LIFE SYSTEM
func lose_life(nb_l:int) -> int:
	if nb_l > 0:
		nb_l -= 1
	return nb_l

func death(nb_l:int) -> bool:
	return nb_l == 0

func _on_area_3d_area_entered(area: Area3D) -> void:
	if type_convert(area.get_path(),TYPE_STRING) == GeneralVariables.DEATH_ZONE_PATH:
		print("done")
		nb_life = lose_life(nb_life)
		if death(nb_life):
			print('ok')
			gameover=true
		else:
			position.x += 5

#CHOOSE DIR SYSTEM
func move_look_w_mouse(event:InputEventMouseMotion, array:Array):
	if len(array) == 2:
		if array[1].y - array[0].y < 0 and $Pivot.rotation.z < deg_to_rad(75):
			$Pivot.rotate_z(deg_to_rad(10))
		elif array[1].y - array[0].y > 0 and $Pivot.rotation.z > deg_to_rad(-75):
			$Pivot.rotate_z(deg_to_rad(-10))

func move_look_w_joystick(event:InputEvent):
	$Pivot.rotation.z = -asin(Input.get_axis("ui_up","ui_down"))

func move_look(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		array_mouse_position = DataManagment.fill_array_of_position(array_mouse_position,event.position)
		move_look_w_mouse(event,array_mouse_position)

	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		move_look_w_joystick(event)
	if Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_up"):
		$Pivot.rotation.z = 0

func update_score():
	if position.x >= last_position.x + 1:
		GeneralVariables.score += 100
		u_score.emit()
		last_position = position

func _on_dash_cooldown_timeout() -> void:
	e_dash_cooldown.emit()
