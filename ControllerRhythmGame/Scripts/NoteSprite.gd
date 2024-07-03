extends Sprite2D

var Note
var Req
var ZOff = 0

func _ready():
	if G.SongDetails[1][G.BarRound][G.NoteToCheck][0] < 9:
		Note = G.Note
		G.Note += 1
		while 4095-Note+ZOff < 8:
			ZOff += 4000
		z_index = 4095-Note+ZOff
		if G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 1:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Face1.png")
			Req = [1,0]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 2:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Shoulder1.png")
			Req = [0,1]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 3:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Face2.png")
			Req = [2,0]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 4:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Shoulder2.png")
			Req = [0,2]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 5:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double11.png")
			Req = [1,1]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 6:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double21.png")
			Req = [1,2]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 7:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double12.png")
			Req = [2,1]
		elif G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 8:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double22.png")
			Req = [2,2]
		else:
			queue_free()
	else:
		if G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 9:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BPMIndicator.png")
			Req = ["BPM",G.SongDetails[1][G.BarRound][G.NoteToCheck][2]]
		if G.SongDetails[1][G.BarRound][G.NoteToCheck][0] == 10:
			G.SongDetails[2][0] = G.SongDetails[1][G.BarRound][G.NoteToCheck][1]
			G.SongDetails[2][1] = G.SongDetails[1][G.BarRound][G.NoteToCheck][2]
			G.SongDetails[2][2] = G.SongDetails[1][G.BarRound][G.NoteToCheck][3]
			queue_free()

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _process(delta):
	if Note != null:
		if Note == G.NoteToHit :
			if global_position.x < 300 + (G.SongDetails[0]*0.4) and global_position.x > 300 - (G.SongDetails[0]*0.3):
				if G.InputsAdded == Req:
					_effect()
					_ranking()
				elif Req[0] < G.InputsAdded[0] or Req[1] < G.InputsAdded[1]:
					_miss()
			if global_position.x < 300 - (G.SongDetails[0]*0.3):
				G.Combo = 0
				G.NoteToHit += 1
				G.Inputs = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
	else:
		if global_position.x < 300:
			if Req[0] == "BPM":
				G.SongDetails[0] = Req[1]
				queue_free()

func _ranking():
	if global_position.x < 300 + (G.SongDetails[0]*0.15) and global_position.x > 300 - (G.SongDetails[0]*0.15):
		G.Rating = "FRESH"
	elif global_position.x < 300 + (G.SongDetails[0]*0.3) and global_position.x > 300 - (G.SongDetails[0]*0.3):
		G.Rating = "GOOD"
	else:
		G.Rating = "BAD"
	_rating()

func _miss():
	G.Rating = "MISS"
	G.Combo = 0
	_rating()

func _effect():
	var SpawnEffect = load("res://Scenes/note_effects.tscn")
	var spawneffect = SpawnEffect.instantiate()
	var World = get_tree().current_scene
	World.add_child(spawneffect)
	
func _rating():
	var SpawnRating = load("res://Scenes/ratings.tscn")
	var spawnrating = SpawnRating.instantiate()
	var World = get_tree().current_scene
	World.add_child(spawnrating)
	G.Inputs = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
	G.InputsAdded = [0,0]
	G.NoteToHit += 1
	queue_free()
