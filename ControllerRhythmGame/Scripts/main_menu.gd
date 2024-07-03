extends Node2D

func _ready():
	$BackgroundNew.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/BackgroundNew.png")

func _on_splash_timer_timeout():
	$Splash/SplashScreen/FadeTimer.start()

func _on_fade_timer_timeout():
	if $Splash/SplashScreen.frame < 9:
		$Splash/SplashScreen.frame += 1
		$Splash/SplashScreen/FadeTimer.start()
	else:
		G.GameReady = true
		queue_free()

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture
