extends Node2D
var BPM = G.SongDetails[0]
var Offset = ((G.TotalNotation+(G.BarOn*(G.SongDetails[2][0]/G.SongDetails[2][1])))*720)+480
var TimeChange = 0
func _ready():
	
	global_position = Vector2(810,801)
func _process(delta):
	global_position.x = Offset + G.Offset
	if global_position.x < -200:
		queue_free()
	if (G.Start > 0 and Input.is_action_just_pressed("Start")) or (Input.is_action_just_pressed("MenuLeft") and G.Playing == false) or (Input.is_action_just_pressed("MenuRight") and G.Playing == false) or E.Reload == true:
		queue_free()
