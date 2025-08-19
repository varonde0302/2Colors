extends Control

var item_shop_list = []
			
func init_display(list:Array):
	var button:Button
	for i in range(1,4):
		button = get_child(i)
		button.get_child(0).texture = load("res://Assests/sprits/"+str(list[i-1])+".png")
		button.get_child(1).text = ItemManager.itemArray[list[i-1]]["Types"]
		button.get_child(2).text = str(ItemManager.itemArray[list[i-1]]["Nb packs sold"])+"/"+str(ItemManager.itemArray[list[i-1]]["Nb packs sold"])
		button.get_child(3).text = str(ItemManager.itemArray[list[i-1]]["Begining price"])
		button.get_child(4).text = ItemManager.itemArray[list[i-1]]["Name"]
		button.get_child(5).text = ItemManager.itemArray[list[i-1]]["Description"]

func _on_saller_open() -> void:
	if not GeneralVariables.shop_open:
		visible = true
		GeneralVariables.shop_open = true
		item_shop_list = ItemManager.shop_items_sold(1,4,8)
		init_display(item_shop_list)
	else:
		visible = false
		GeneralVariables.shop_open = false
		
func _on_button_pressed() -> void:
	ItemManager.apply_item_effect(item_shop_list[0],get_node(GeneralVariables.PLAYER_PATH))

func _on_button_2_pressed() -> void:
	ItemManager.apply_item_effect(item_shop_list[1],get_node(GeneralVariables.PLAYER_PATH))

func _on_button_3_pressed() -> void:
	ItemManager.apply_item_effect(item_shop_list[2],get_node(GeneralVariables.PLAYER_PATH))
