extends Sprite2D

func _ready():
	texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarSmallBeat.png")
	if G.BarOn == 0 and G.SongDetails[2][2] == 0:
		texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarBigBeat.png")

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture
