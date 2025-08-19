extends Node

var itemArray = []

func _ready() -> void:
	itemArray = Loader.load_file(Loader.ITEM_DATAS_FILE_PATH)
	
func apply_item_effect(id:int, body:Node3D) -> void:
	body.speed = body.speed * (1+itemArray[id]["Speed boost"]/100)
	body.nb_life += itemArray[id]["Nb lifes added"]
	print("aplly")

func shop_items_sold(c_rate:int,r_rate:int,ur_rate:int) -> Array:
	var common_items = []
	var rare_items = []
	var ultrarare_items = []
	var item_list = []
	
	for i in range(len(itemArray)):
		if itemArray[i]["Types"] == "commun":
			common_items.append(i)
		elif itemArray[i]["Types"] == "rare":
			rare_items.append(i)
		elif itemArray[i]["Types"] == "ultra rare":
			ultrarare_items.append(i)
			
	for j in range(3):
		var rand = common_items.pick_random()
		while rand in item_list:
			rand = common_items.pick_random()
		item_list.append(rand)
	
	#pick Rare
	if randi_range(1,r_rate) == 1:
		item_list[1] = rare_items.pick_random()
	elif randi_range(1,ur_rate) == 1:
		item_list[2] = ultrarare_items.pick_random()
			
	return item_list
