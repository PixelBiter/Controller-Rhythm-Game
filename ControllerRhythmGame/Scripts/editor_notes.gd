extends Sprite2D
var CurrentBar = E.CurrentBar
var CurrentBPM = E.CurrentBPM
func _ready():
	texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/NoteDisplay.png")
	if E.EditorExtraNote[0] == "NOTE":
		frame = E.EditorDetails[1][E.CurrentBar][E.EditorExtraNote[1]][0]-1
		position.x = E.EditorDetails[1][E.CurrentBar][E.EditorExtraNote[1]][1] * 600
		if frame == 8:
			$Label.text = str(E.EditorDetails[1][E.CurrentBar][E.EditorExtraNote[1]][2])
	else:
		if E.EditorExtraNote[1] == 0:
			queue_free()
		else:
			texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarSmallBeat.png")
			position.x = E.EditorExtraNote[1] * 600

func _process(delta):
	if E.CurrentBar != CurrentBar:
		queue_free()
	if E.Reload == true or (Input.is_action_just_pressed("MenuLeft") and G.Playing == false) or (Input.is_action_just_pressed("MenuRight") and G.Playing == false):
		queue_free()

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture
