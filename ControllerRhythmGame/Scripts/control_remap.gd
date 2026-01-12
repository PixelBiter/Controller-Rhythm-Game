extends Control

var remapping = false;
var target_map = null;
var mappings = {
	"FaceA1":null,
	"FaceA2":null,
	"FaceA3":null,
	"FaceA4":null,
	"FaceB1":null,
	"FaceB2":null,
	"FaceB3":null,
	"FaceB4":null,
	"ShoulderA1":null,
	"ShoulderA2":null,
	"ShoulderB1":null,
	"ShoulderB2":null,
	"Start":null,
	"Select":null,
	"MenuLeft":null,
	"MenuRight":null
}

func _input(event):
	if remapping:
		if ( (event is InputEventKey and event.keycode != 4194305) or (event is InputEventMouseButton and event.pressed)):
			
			InputMap.action_add_event(target_map,event)
			mappings[target_map] = event;
			if event is InputEventKey:
				get_node("buttons/"+target_map).text = str(OS.get_keycode_string(event.keycode));
			else:
				get_node("buttons/"+target_map).text = "Mouse Button "+str(event.button_index)
			remapping = false;
		
		
		
		elif (event is InputEventKey and event.keycode == 4194305):
			get_node("buttons/"+target_map).text = target_map+" (Unset)";
			remapping = false;
	
	
	
	elif (event is InputEventKey and event.keycode == 4194305 and event.is_pressed()):
		visible = !visible;


func _remap_button(remap_value):
	target_map = remap_value;
	if mappings[remap_value] != null:
		InputMap.action_erase_event(remap_value,mappings[remap_value])
		mappings[remap_value] = null;
	get_node("buttons/"+remap_value).text = "AWAITING REMAP"
	remapping = true;
