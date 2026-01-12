extends Node2D
var BPM = G.SongDetails[0]
var Offset = ((G.TotalNotation + (G.SongDetails[1][G.BarRound][G.NoteToCheck][1] * (G.SongDetails[2][0]/G.SongDetails[2][1])))*720)+180
func _ready():
	global_position = Vector2(810,801)
func _process(_delta):
	global_position.x = 300+(Offset + G.Offset)*G.ScrollSpeed
	if global_position.x < -200:
		queue_free()
	if (G.Start > 0 and Input.is_action_just_pressed("Start")) or (Input.is_action_just_pressed("MenuLeft") and G.Playing == false) or (Input.is_action_just_pressed("MenuRight") and G.Playing == false) or E.Reload == true:
		queue_free()
	
