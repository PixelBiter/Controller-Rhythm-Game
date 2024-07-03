extends Node2D

var NoteHit = 0
var CustoRate

func _ready():
	$FRESH/FRESH.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/FRESH.png")
	$FRESH/AllSprites.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/AllRatings.png")
	$FRESH/AllSprites2.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/AllRatings.png")
	$GOOD/GOOD.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/GOOD.png")
	$GOOD/AllSprites.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/AllRatings.png")
	$BAD/BAD.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/BAD.png")
	$BAD/AllSprites.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/AllRatings.png")
	$MISS/MISS.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/MISS.png")
	$MISS/AllSprites.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/AllRatings.png")
	position = Vector2(100,220)
	CustoRate = G.Rating
	if G.Rating == "FRESH":
		G.Combo += 1
		G.Score[1] += 1
		$FRESH.visible = true
		if G.Combo > 1:
			$FRESH/TextEnhancer/Combo.text = str(G.Combo)
		if G.PERFECT == true:
			$FRESH/TextEnhancer/Combo["theme_override_colors/font_color"]  = Color(1, 0.812, 0.251)
		$FRESH/AllSprites.frame -= G.SquidOctoShuffle
		$FRESH/AllSprites2.frame += G.SquidOctoShuffle
	elif G.Rating == "GOOD":
		G.Combo += 1
		G.PERFECT = false
		G.Score[0] += 1
		$GOOD.visible = true
		if G.Combo > 1:
			$GOOD/TextEnhancer/Combo.text = str(G.Combo)
		$GOOD/AllSprites.frame -= G.SquidOctoShuffle
	elif G.Rating == "BAD":
		G.Combo = 0
		G.PERFECT = false
		$BAD.visible = true
		$BAD/AllSprites.frame -= G.SquidOctoShuffle
	elif G.Rating == "MISS":
		G.Combo = 0
		G.PERFECT = false
		$MISS.visible = true
		$MISS/AllSprites.frame += G.SquidOctoShuffle
	G.Rating = ""
	G.SquidOctoShuffle += 1
	if G.SquidOctoShuffle == 2:
		G.SquidOctoShuffle = 0
	NoteHit = G.NoteToHit +1

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _physics_process(delta):
	if NoteHit != G.NoteToHit:
		queue_free()
	if G.Start > 0 and Input.is_action_just_pressed("Start"):
		queue_free()
	if CustoRate == "FRESH":
		position.y -= 0.3
	elif CustoRate == "GOOD" or CustoRate == "BAD":
		position.y -= 0.1
	elif CustoRate == "MISS":
		position.y += 0.1

func _on_timer_timeout():
	queue_free()
