extends Node

const ITEM_DATAS_FILE_PATH = "res://Assests/datas/item_datas.json"

func load_file(f:String):
	var dataFile = FileAccess.open(f,FileAccess.READ)
	var parseResult = JSON.parse_string(dataFile.get_as_text())
	
	if parseResult is Array:
		return parseResult
	else:
		print('Error, not a dictionary')
