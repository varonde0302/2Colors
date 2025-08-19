extends Control

var array_score = []
var array_add_score_label = []

var dash = false
var explosion = false

func _process(delta: float) -> void:
	if dash or explosion:
		$"bonus coef".text = " x "+str( roundf(GeneralVariables.coef_mult))
		$"bonus coef".modulate = Color(randf(),randf(),randf())

func _on_character_u_score() -> void:
	array_score.append(GeneralVariables.score)
	init_add_score()
	init_timer()

func init_add_score():
	var label = Label.new()

	add_child(label)
	label.label_settings = load("res://Assests/add_score.tres")
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT

	label.text = "+100"
	label.position.x = randi_range(15,65)
	label.position.y = randi_range(85,100)
	label.modulate = Color(randf(),randf(),randf())
	label.rotation_degrees = randf_range(-20,20)
	label.label_settings.font_size = 70

func init_timer():
	var timer = Timer.new()

	timer.wait_time = 0.25
	timer.one_shot = true

	timer.timeout.connect(_on_timer_timeout)

	$Timers.add_child(timer)
	timer.start()

func _on_timer_timeout() -> void:
	$"Score label".text = str(array_score[0])
	remove_child(get_child(4))
	$Timers.remove_child($Timers.get_child(0))
	array_score.remove_at(0)


func _on_character_s_dash() -> void:
	dash = true
	$"score add".text = "+300"
	$"bonus coef".visible = true
	$"score add".visible = true
	if array_score != []:
		array_score = []
		array_add_score_label = []
		for i in range($Timers.get_child_count()):
			$Timers.remove_child($Timers.get_child(0))
			remove_child(get_child(4))


func _on_character_e_dash() -> void:
	GeneralVariables.score += 300*GeneralVariables.coef_mult
	GeneralVariables.score = int(GeneralVariables.score)
	dash = false
	$"Score label".text = str(GeneralVariables.score)
	$"bonus coef".visible = false
	$"score add".visible = false
	GeneralVariables.coef_mult = 0


func _on_character_e_expl() -> void:
	GeneralVariables.score += 500*GeneralVariables.coef_mult
	GeneralVariables.score = int(GeneralVariables.score)
	explosion = false
	$"Score label".text = str(GeneralVariables.score)
	$"bonus coef".visible = false
	$"score add".visible = false
	GeneralVariables.coef_mult = 0


func _on_character_s_expl() -> void:
	explosion = true
	$"score add".text = "+500"
	$"bonus coef".visible = true
	$"score add".visible = true
	if array_score != []:
		array_score = []
		array_add_score_label = []
		for i in range($Timers.get_child_count()):
			$Timers.remove_child($Timers.get_child(0))
			remove_child(get_child(4))
