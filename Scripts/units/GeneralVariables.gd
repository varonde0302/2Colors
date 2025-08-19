extends Node

var game_time:int
@onready var death_zone_node = load("res://Scenes/death_zone.tscn").instantiate()
var default_speed = 5

var can_switch_zone = false
var id_zone = 0
var id_lzone = 0

const PLAYER_PATH = "/root/Main/Character"
const DEATH_ZONE_PATH = "/root/Main/Death zone"

var shop_open = false
var score = 0

var coef_mult = 0

func _ready() -> void:
	game_time = Time.get_ticks_msec()
