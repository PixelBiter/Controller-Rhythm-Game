extends Node2D

var SongFile
var SongFileMore
var SaveFile
var SaveFileMore
var ChartBar
var DanceSpeed = 4

func _ready():
	_StyleHolder()
	_FileReader(E.EditorOn)
	_resetter()

func _input(event):
	if G.GameReady == true:
		if G.Playing == true:
			if Input.is_action_just_pressed("FaceA1"):
				if G.HeldInputs[0] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[0] = 1
					$AudioPlayers/FaceA.playing = false
					$AudioPlayers/FaceA.playing = true
			if Input.is_action_just_pressed("FaceA2"):
				if G.HeldInputs[1] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[1] = 1
					$AudioPlayers/FaceA.playing = false
					$AudioPlayers/FaceA.playing = true
			if Input.is_action_just_pressed("FaceA3"):
				if G.HeldInputs[2] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[2] = 1
					$AudioPlayers/FaceA.playing = false
					$AudioPlayers/FaceA.playing = true
			if Input.is_action_just_pressed("FaceA4"):
				if G.HeldInputs[3] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[3] = 1
					$AudioPlayers/FaceA.playing = false
					$AudioPlayers/FaceA.playing = true
			if Input.is_action_just_pressed("FaceB1"):
				if G.HeldInputs[4] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[4] = 1
					$AudioPlayers/FaceB.playing = false
					$AudioPlayers/FaceB.playing = true
			if Input.is_action_just_pressed("FaceB2"):
				if G.HeldInputs[5] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[5] = 1
					$AudioPlayers/FaceB.playing = false
					$AudioPlayers/FaceB.playing = true
			if Input.is_action_just_pressed("FaceB3"):
				if G.HeldInputs[6] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[6] = 1
					$AudioPlayers/FaceB.playing = false
					$AudioPlayers/FaceB.playing = true
			if Input.is_action_just_pressed("FaceB4"):
				if G.HeldInputs[7] == 0:
					G.Inputs[0][0] += 1
					G.HeldInputs[7] = 1
					$AudioPlayers/FaceB.playing = false
					$AudioPlayers/FaceB.playing = true
			if Input.is_action_just_pressed("ShoulderA1"):
				if G.HeldInputs[8] == 0:
					G.Inputs[0][1] += 1
					G.HeldInputs[8] = 1
					$AudioPlayers/ShoulderA.playing = false
					$AudioPlayers/ShoulderA.playing = true
			if Input.is_action_just_pressed("ShoulderA2"):
				if G.HeldInputs[9] == 0:
					G.Inputs[0][1] += 1
					G.HeldInputs[9] = 1
					$AudioPlayers/ShoulderA.playing = false
					$AudioPlayers/ShoulderA.playing = true
			if Input.is_action_just_pressed("ShoulderB1"):
				if G.HeldInputs[10] == 0:
					G.Inputs[0][1] += 1
					G.HeldInputs[10] = 1
					$AudioPlayers/ShoulderB.playing = false
					$AudioPlayers/ShoulderB.playing = true
			if Input.is_action_just_pressed("ShoulderB2"):
				if G.HeldInputs[11] == 0:
					G.Inputs[0][1] += 1
					G.HeldInputs[11] = 1
					$AudioPlayers/ShoulderB.playing = false
					$AudioPlayers/ShoulderB.playing = true
		
		if G.Playing == false:
			if Input.is_action_just_pressed("MenuRight"):
				S.SongSelected += 1
				if S.SongSelected > len(S.SongList)-1:
					S.SongSelected = 0
				$TheFuckMeTimer.start()
			if Input.is_action_just_pressed("MenuLeft"):
				S.SongSelected -= 1
				if S.SongSelected < 0:
					S.SongSelected = len(S.SongList)-1
				$TheFuckMeTimer.start()

		if Input.is_action_just_pressed("Start"):
			G.Start = G.Bar
			if G.Playing == false:
				$AudioPlayers/Music.playing = true
				$ButtonInputs.frame = 1
				G.Playing = true
			else:
				$AudioPlayers/Music.playing = false
				$ButtonInputs.frame = 0
				G.Playing = false
				$TheFuckMeTimer.start()
		
		if Input.is_action_just_pressed("Select") and G.Playing == false:
			get_tree().quit()

func _physics_process(delta):
	_ScoreKeeper()
	_visualiser()
	if G.GameReady == true:
		if G.Playing == true:
			for a in range(5):
				G.Inputs[5-a] = G.Inputs[4-a]
			G.Inputs[0] = [0,0]
			_SongTime()
			if G.TimeIntoSong > 0:
				_ChartReader()

func _ScoreKeeper():
	$Style/TitleMedal/TextEnhancer/SilverLabel.text = str(G.Score[0])
	$Style/TitleMedal/TextEnhancer/GoldLabel.text = str(G.Score[1])
	
	if E.EditorOn == false and G.Playing == true:
		if G.Amount == G.Score[1] and S.Medals[S.SongList[S.SongSelected]] < 2:
			S.Medals[S.SongList[S.SongSelected]] = 2
			$Style/TitleMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/GoldSquid.png")
			var MedalWrite = FileAccess.open("user://Medals.txt", FileAccess.WRITE)
			var MedalString = JSON.stringify(S.Medals)
			MedalWrite.store_line(MedalString)
			MedalWrite.close()
			_MedalWin()
		elif G.Amount == G.Score[0]+G.Score[1] and S.Medals[S.SongList[S.SongSelected]] < 1:
			S.Medals[S.SongList[S.SongSelected]] = 1 
			$Style/TitleMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/SilverSquid.png")
			var MedalWrite = FileAccess.open("user://Medals.txt", FileAccess.WRITE)
			var MedalString = JSON.stringify(S.Medals)
			MedalWrite.store_line(MedalString)
			MedalWrite.close()
			_MedalWin()

func _MedalWin():
	var MedalEffect = load("res://Scenes/medal_anim.tscn")
	var medaleffect = MedalEffect.instantiate()
	$Style/TitleMedal.add_child(medaleffect)

func _StyleHolder():
	$Style/Background.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/Background.png")
	$Style/NoteBar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/HorizontalBar.png")
	$Style/Instructions.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/Instructions.png")
	$Style/BarHitterFace.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/BarHitterFace.png")
	$Style/BarHitterShoulder.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/BarHitterShoulder.png")
	$Style/SilverMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/SilverSquidSmall.png")
	$Style/GoldMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/GoldSquidSmall.png")
	$BackgroundUpgrade.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Background/BackgroundUpgrade.png")
	$Bars.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars2.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars3.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars4.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars5.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars6.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars7.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars8.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars9.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars10.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars11.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars12.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars13.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars14.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars15.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$Bars16.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/Bars.png")
	$ButtonInputs.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Menus/ButtonInputs.png")
	
	$AudioPlayers/FaceA.stream = load_mp3("user://Cosmetics/BaseStyle/Audio/A.mp3")
	$AudioPlayers/FaceB.stream = load_mp3("user://Cosmetics/BaseStyle/Audio/B.mp3")
	$AudioPlayers/ShoulderA.stream = load_mp3("user://Cosmetics/BaseStyle/Audio/C.mp3")
	$AudioPlayers/ShoulderB.stream = load_mp3("user://Cosmetics/BaseStyle/Audio/D.mp3")

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _FileReader(EditorThing):
	if EditorThing == false:
		SongFile = FileAccess.open(S.SongList[S.SongSelected], FileAccess.READ)
		SongFileMore = JSON.parse_string(SongFile.get_as_text())
		G.SongDetails[0] = SongFileMore.BPM
		G.SongDetails[1] = SongFileMore.Chart
		G.SongDetails[2] = [SongFileMore.NotationU, SongFileMore.NotationD, SongFileMore.NotationType]
		G.SongDetails[3] = SongFileMore.MusicLocation
		G.SongDetails[4] = SongFileMore.SongName
		$AudioPlayers/Music.stream = load_mp3(G.SongDetails[3])
		$Style/TitleMedal/TextEnhancer/Title.text = G.SongDetails[4]
		if loadimage(SongFileMore.Dance) != null:
			$Style/DANCING.texture = loadimage(SongFileMore.Dance)
			$Style/DANCING.hframes = S.DanceList[SongFileMore.Dance][0]
			$Style/DANCING.vframes = S.DanceList[SongFileMore.Dance][1]
			DanceSpeed = S.DanceList[SongFileMore.Dance][2]
		else:
			$Style/DANCING.texture = null
		SongFile.close()
		
	else:
		G.SongDetails[0] = E.BPM
		G.SongDetails[1] = E.EditorDetails[1]
		G.SongDetails[2] = [float(E.Sig[0]), float(E.Sig[1]), 0]
		G.SongDetails[3] = E.Music
		G.SongDetails[4] = E.Name
		$AudioPlayers/Music.stream = load_mp3(G.SongDetails[3])
		$Style/TitleMedal/TextEnhancer/Title.text = G.SongDetails[4]

func _SongTime():
	G.TimeIntoSong = $AudioPlayers/Music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	if G.Bar > 1:
		G.BarRound += 1
		G.TimeLastRead = G.TimeIntoSong
	if (G.TimeIntoSong-G.TimeLastRead)/(60/(G.SongDetails[0]))/G.SongDetails[2][0] < 0:
		G.Bar = 0
	else:
		G.Bar = ((G.TimeIntoSong-G.TimeLastRead)/(60/(G.SongDetails[0])))/((G.SongDetails[2][0]/G.SongDetails[2][1])*4)

func _resetter():
	G.Note = 0
	G.NoteToHit = 0
	G.TimeIntoSong = 0.0
	G.Bar = 0
	G.BarRound = 0
	G.NoteToCheck = 0
	G.Combo = 0
	G.Score = [0,0]
	G.Rating = ""
	G.TimeLastRead = 0
	G.Offset = (G.TimeIntoSong * G.BPM * 3)
	G.Offset2 = 0
	G.TotalNotation = 0
	G.Amount = 0
	G.PERFECT = true
	ChartBar = G.BarRound
	_MedalStuff()
	if E.Save == false:
		_FileReader(E.EditorOn)
	else:
		_FileReader(false)
	_AmountCounter()
	_PreStartReader()

func _AmountCounter():
	for i in range(len(G.SongDetails[1])):
		for j in range(len(G.SongDetails[1][i])):
			if G.SongDetails[1][i][j][0] < 9:
				G.Amount += 1
	$Style/TitleMedal/TextEnhancer/TotalLabel.text = "/"+str(G.Amount)

func _MedalStuff():
	if S.Medals.get(S.SongList[S.SongSelected]) == null:
		S.Medals[S.SongList[S.SongSelected]] = 0
		var MedalWrite = FileAccess.open("user://Medals.txt", FileAccess.WRITE)
		var MedalString = JSON.stringify(S.Medals)
		MedalWrite.store_line(MedalString)
		MedalWrite.close()
	if S.Medals[S.SongList[S.SongSelected]] == 0:
		$Style/TitleMedal.texture = null
	elif S.Medals[S.SongList[S.SongSelected]] == 1:
		$Style/TitleMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/SilverSquid.png")
	elif S.Medals[S.SongList[S.SongSelected]] == 2:
		$Style/TitleMedal.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Ratings/GoldSquid.png")

func _PreStartReader():
	for i in range(5):
		for NoteToCheck in range(len(G.SongDetails[1][G.BarRound])):
			G.NoteToCheck = NoteToCheck
			var Note = load("res://Scenes/notes.tscn")
			var note = Note.instantiate()
			add_child(note)
		G.BarRound += 1
		ChartBar = G.BarRound + 1
		_bars()
		G.TotalNotation += G.SongDetails[2][0]/G.SongDetails[2][1]
	G.BarRound -= 1
	ChartBar = G.BarRound + 1

func _ChartReader():
	if ChartBar == G.BarRound and G.BarRound < len(G.SongDetails[1]):
		for NoteToCheck in range(len(G.SongDetails[1][G.BarRound])):
			G.NoteToCheck = NoteToCheck
			var Note = load("res://Scenes/notes.tscn")
			var note = Note.instantiate()
			add_child(note)
		ChartBar = G.BarRound + 1
		_bars()
		G.TotalNotation += G.SongDetails[2][0]/G.SongDetails[2][1]

func _bars():
	for b in range(round(G.SongDetails[2][0])):
		G.BarOn = (1/(round(G.SongDetails[2][0])))*b
		var Bar = load("res://Scenes/bars.tscn")
		var bar = Bar.instantiate()
		add_child(bar)

func _visualiser():
	if G.Playing == true:
		$Style/ShmoveTimer.wait_time = 60/(G.SongDetails[0]*DanceSpeed)
		$Bars.frame = G.VisualiserBars[0]
		$Bars2.frame = G.VisualiserBars[1]
		$Bars3.frame = G.VisualiserBars[2]
		$Bars4.frame = G.VisualiserBars[3]
		$Bars5.frame = G.VisualiserBars[4]
		$Bars6.frame = G.VisualiserBars[5]
		$Bars7.frame = G.VisualiserBars[6]
		$Bars8.frame = G.VisualiserBars[7]
		$Bars9.frame = G.VisualiserBars[8]
		$Bars10.frame = G.VisualiserBars[9]
		$Bars11.frame = G.VisualiserBars[10]
		$Bars12.frame = G.VisualiserBars[11]
		$Bars13.frame = G.VisualiserBars[12]
		$Bars14.frame = G.VisualiserBars[13]
		$Bars15.frame = G.VisualiserBars[14]
		$Bars16.frame = G.VisualiserBars[15]
	else:
		$Style/ShmoveTimer.stop()
		$Style/DANCING.frame = 0
		$Style/ShmoveTimer.wait_time = 60/(G.SongDetails[0]*4)
		$Style/ShmoveTimer.start()
		$Bars.frame = 0
		$Bars2.frame = 0
		$Bars3.frame = 0
		$Bars4.frame = 0
		$Bars5.frame = 0
		$Bars6.frame = 0
		$Bars7.frame = 0
		$Bars8.frame = 0
		$Bars9.frame = 0
		$Bars10.frame = 0
		$Bars11.frame = 0
		$Bars12.frame = 0
		$Bars13.frame = 0
		$Bars14.frame = 0
		$Bars15.frame = 0
		$Bars16.frame = 0

func _on_the_fuck_me_timer_timeout():
	_resetter()

func _on_shmove_timer_timeout():
	if $Style/DANCING.hframes*$Style/DANCING.vframes > $Style/DANCING.frame+1:
		$Style/DANCING.frame += 1
	else:
		$Style/DANCING.frame = 0

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
