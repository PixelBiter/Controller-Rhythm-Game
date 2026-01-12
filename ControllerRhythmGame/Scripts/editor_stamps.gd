extends Sprite2D
var Offset = G.Offset
func _process(delta):
	global_position.x = Offset + G.Offset
