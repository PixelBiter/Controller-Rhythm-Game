extends Sprite2D

func _ready():
	if S.Medals[S.SongList[S.SongSelected]] == 2:
		texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/GoldSquid.png")
	else:
		texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/SilverSquid.png")

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _process(delta):
	scale -= Vector2(0.005,0.005)
	if scale.x < 1:
		queue_free()
