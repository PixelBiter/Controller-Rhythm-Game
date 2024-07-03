extends Node2D

func _ready():
	global_position.x = -60
	$Note.global_position = Vector2(300,801)
	if G.InputsAdded == [1,0]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Face1.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightFace.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
	if G.InputsAdded == [0,1]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Shoulder1.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightShoulder.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	if G.InputsAdded == [2,0]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Face2.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightFace.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
	if G.InputsAdded == [0,2]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Shoulder2.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightShoulder.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	if G.InputsAdded == [1,1]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double11.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightDouble.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	if G.InputsAdded == [1,2]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double21.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightDouble.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	if G.InputsAdded == [2,1]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double12.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightDouble.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	if G.InputsAdded == [2,2]:
		$Note.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/Double22.png")
		$Bar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/BarLightDouble.png")
		$Squid.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/FaceSquid.png")
		$Octo.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Effects/ShoulderOcto.png")
	$Bar/AnimationPlayer.play("FadeBar")
	$Squid/AnimationPlayer.play("Squid Fade")
	$Octo/AnimationPlayer.play("Squid Fade")

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _physics_process(delta):
	if $Note.global_position.y < -30:
		queue_free()
	if G.Playing != true:
		queue_free()
	$Note.global_position.y -= 90
	$Squid.global_position = Vector2(300,847.5)
	$Octo.global_position = Vector2(300,754.5)
	$Bar.global_position.x = 300
