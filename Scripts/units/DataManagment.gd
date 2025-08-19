extends Node

func fill_array_of_position(array:Array, value:Vector2i) -> Array:
	if len(array) < 2:
		array.append(value)
	else:
		array.pop_at(0)
		array.append(value)
	return array
	
func calcul_dir_vector(start,end:Node3D) -> Vector3:
	var h = sqrt((end.position.x - start.position.x)**2+(end.position.y - start.position.y)**2)
	var dir:Vector3
	
	dir.x = cos(start.rotation.z)*h
	dir.y = sin(start.rotation.z)*h
	dir = dir/max(abs(dir.x),abs(dir.y))
	
	return dir
