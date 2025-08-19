extends Node3D

var zone : Node3D
@export var player : CharacterBody3D

const MAX_ID = 3
const NB_FIELD = 5
func _ready() -> void:
	init_playfield()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if GeneralVariables.can_switch_zone:
		GeneralVariables.can_switch_zone = false
		
		add_child(load("res://Scenes/field/zone"+str(GeneralVariables.id_zone)+".tscn").instantiate())
		remove_child(get_child(0))
		zone = get_child(NB_FIELD-1)
		zone.position.x = get_child(NB_FIELD-2).position.x + 25
		zone.position.y -= 2

func init_playfield() -> void:
	var id = 0
	var rand_id = 0
	
	for i in range(0,5):  
		rand_id = randi_range(1,MAX_ID)
		while id == rand_id:
			rand_id = randi_range(1,MAX_ID)	
		id = rand_id
		add_child(load("res://Scenes/field/zone"+str(id)+".tscn").instantiate())
		get_child(i).position.x = player.position.x + 25*(i+1) - 1
		get_child(i).position.y -= 2
		if i == 0:
			GeneralVariables.id_zone = id
			
