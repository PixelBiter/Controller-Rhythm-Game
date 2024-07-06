extends Node2D

var HeldNote = 0
var ExchangeNote = 0

func _ready():
	E.EditorOn = true
	var DanceRead = FileAccess.open("user://Cosmetics/BaseStyle/Sprites/Dances/DanceListEditor.txt", FileAccess.READ)
	var DanceRead2 = JSON.parse_string(DanceRead.get_as_text())
	for i in range(len(DanceRead2)):
		$Visual/LayoutB/Dance/Dances.add_item(DanceRead2[i],i)
	
	var Songs1 = DirAccess.get_files_at("user://Music/BaseGame/")
	var Songs2 = DirAccess.get_files_at("user://Music/Custom/")
	var Songs3 = DirAccess.get_files_at("user://Music/")
	for i in range(len(Songs1)):
		if Songs1[i].right(4) == ".mp3":
			$Visual/LayoutB/Location/SongLocation.add_item("user://Music/BaseGame/"+Songs1[i])
	for i in range(len(Songs2)):
		if Songs2[i].right(4) == ".mp3":
			$Visual/LayoutB/Location/SongLocation.add_item("user://Music/Custom/"+Songs2[i])
	for i in range(len(Songs3)):
		if Songs3[i].right(4) == ".mp3":
			$Visual/LayoutB/Location/SongLocation.add_item("user://Music/"+Songs3[i])
	_SpriteVisuals()
	_loading()

func _process(delta):
	_NoteType()
	_VariableTransfers()
	_Visuals()
	_LoadAnother()

func _LoadAnother():
	if Input.is_action_just_pressed("MenuLeft") or Input.is_action_just_pressed("MenuRight"):
		_loading()

func _SpriteVisuals():
	$Visual/NoteSelect.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/NoteSelect.png")
	$Visual/NoteSelectHighlight.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/NoteSelectHighlight.png")
	$Visual/LayoutA.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/LayoutA.png")
	$Visual/LayoutA/SigCurrent/ToggleBar.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/ToggleBar.png")
	$Visual/LayoutB.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/LayoutB.png")
	$Visual/LayoutB/BarsTotal/Yes.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/YES.png")
	$Visual/LayoutC.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/DeletionMenu.png")
	$ButtonsA/AddButton.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/AddButton.png")
	$ButtonsA/SaveButton.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/SaveButton.png")
	$ButtonsA/LeftArrow.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/Arrow.png")
	$ButtonsA/RightArrow.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/Arrow.png")
	$ButtonsA/RemoveButton.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Editor/RemoveButton.png")
	$BarHolding/BarBigBeat.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarBigBeat.png")
	$BarHolding/BarBigBeat2.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarBigBeat.png")

func loadimage(path):
	var loadimage = Image.load_from_file(path)
	var loadtexture = ImageTexture.create_from_image(loadimage)
	return loadtexture

func _loading():
	var SongFile = FileAccess.open(S.SongList[S.SongSelected], FileAccess.READ)
	var SongFileMore = JSON.parse_string(SongFile.get_as_text())
	E.EditorDetails[0] = SongFileMore.BPM
	E.EditorDetails[1] = SongFileMore.Chart
	E.EditorDetails[2] = [SongFileMore.NotationU, SongFileMore.NotationD, SongFileMore.NotationType]
	E.EditorDetails[3] = SongFileMore.MusicLocation
	E.EditorDetails[4] = SongFileMore.SongName
	E.EditorDetails[5] = SongFileMore.Dance
	E.Music = E.EditorDetails[3]
	E.Name = E.EditorDetails[4]
	E.BPM = E.EditorDetails[0]
	E.Sig = E.EditorDetails[2]
	E.Chart = E.EditorDetails[1]
	E.TotalBars = len(E.Chart)
	E.Dance = E.EditorDetails[5]
	E.HoldBarsTotal = E.TotalBars
	$Visual/LayoutB/Name/TextEdit.text = E.Name
	$Visual/LayoutB/BPMInital/TextEdit.text = str(E.BPM)
	$Visual/LayoutB/SigInital/TextEdit.text = str(E.Sig[0])
	$Visual/LayoutB/SigInital/TextEdit2.text = str(E.Sig[1])
	$Visual/LayoutB/BarsTotal/BarTotal.text = str(E.TotalBars)
	_PlaceFakeNotes()
	SongFile.close()
	

func _Visuals():
	$Visual/LayoutB/BarsTotal/Bars.text = str(E.TotalBars)
	$Visual/NoteSelectHighlight.frame = E.CurrentNoteType-1
	$Visual/BarNumber.text = str(E.CurrentBar+1)
	$Visual/LayoutC/Deletion/NoteInBar.text = "/"+str(len(E.EditorDetails[1][E.CurrentBar])-1)
	if len(E.EditorDetails[1][E.CurrentBar]) > 0:
		$Visual/LayoutC/Deletion/BarNumber.text = "Type: "+str(E.EditorDetails[1][E.CurrentBar][E.TargetedDeletion][0])+"\nPosition: "+str(E.EditorDetails[1][E.CurrentBar][E.TargetedDeletion][1])+"\nFull Stats: "+ str(E.EditorDetails[1][E.CurrentBar][E.TargetedDeletion])
	else:
		$Visual/LayoutC/Deletion/BarNumber.text = "Empty Bar :/"

func _VariableTransfers():
	E.Name = $Visual/LayoutB/Name/TextEdit.text
	E.CurrentPlacement = float($Visual/LayoutA/PlacementCurrent/TextEdit.text)
	E.BPM = float($Visual/LayoutB/BPMInital/TextEdit.text)
	E.Sig = [int($Visual/LayoutB/SigInital/TextEdit.text), int($Visual/LayoutB/SigInital/TextEdit2.text), 0]
	E.CurrentBPM = float($Visual/LayoutA/BPMCurrent/TextEdit.text)
	E.CurrentSig = [int($Visual/LayoutA/SigCurrent/TextEdit.text),int($Visual/LayoutA/SigCurrent/TextEdit2.text), $Visual/LayoutA/SigCurrent/ToggleBar.frame]
	if $Visual/LayoutB/Dance/Dances.selected != 0:
		E.Dance = $Visual/LayoutB/Dance/Dances.get_item_text($Visual/LayoutB/Dance/Dances.selected)
	else:
		E.Dance = "user://Cosmetics/BaseStyle/Sprites/Dances/None.png"
	E.HoldBarsTotal = int($Visual/LayoutB/BarsTotal/BarTotal.text)
	E.Music = $Visual/LayoutB/Location/SongLocation.get_item_text($Visual/LayoutB/Location/SongLocation.selected)
	if int($Visual/LayoutC/Deletion/SelectedDelete.text) <= len(E.EditorDetails[1][E.CurrentBar])-1 and int($Visual/LayoutC/Deletion/SelectedDelete.text) > -2:
		E.TargetedDeletion = int($Visual/LayoutC/Deletion/SelectedDelete.text)
	else:
		E.TargetedDeletion = len(E.EditorDetails[1][E.CurrentBar])-1
		$Visual/LayoutC/Deletion/SelectedDelete.text = str(len(E.EditorDetails[1][E.CurrentBar])-1)

func _NoteType():
	if $Visual/NoteSelect/Button.button_pressed == true:
		if Input.is_action_just_pressed("0"):
			E.CurrentNoteType = 10
		if Input.is_action_just_pressed("1"):
			E.CurrentNoteType = 1
		if Input.is_action_just_pressed("2"):
			E.CurrentNoteType = 2
		if Input.is_action_just_pressed("3"):
			E.CurrentNoteType = 3
		if Input.is_action_just_pressed("4"):
			E.CurrentNoteType = 4
		if Input.is_action_just_pressed("5"):
			E.CurrentNoteType = 5
		if Input.is_action_just_pressed("6"):
			E.CurrentNoteType = 6
		if Input.is_action_just_pressed("7"):
			E.CurrentNoteType = 7
		if Input.is_action_just_pressed("8"):
			E.CurrentNoteType = 8
		if Input.is_action_just_pressed("9"):
			E.CurrentNoteType = 9

func _PlaceFakeNotes():
	for EditorNoteA in range(len(E.EditorDetails[1][E.CurrentBar])):
		E.EditorExtraNote = ["NOTE",EditorNoteA]
		var Note = load("res://Scenes/editor_notes.tscn")
		var note = Note.instantiate()
		$BarHolding/NoteHolding.add_child(note)
	_PlaceFakeBars()

func _PlaceFakeBars():
	E.EditorDisplayNotation = E.EditorDetails[2]
	for i in range(E.CurrentBar+1):
		for j in range(len(E.EditorDetails[1][i])):
			if E.EditorDetails[1][i][j][0] == 10:
				E.EditorDisplayNotation = [E.EditorDetails[1][i][j][1],E.EditorDetails[1][i][j][2],E.EditorDetails[1][i][j][3]]
	if E.EditorDisplayNotation[2] == 0:
		$BarHolding/BarBigBeat.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarBigBeat.png")
		$BarHolding/BarBigBeat2.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarBigBeat.png")
	else:
		$BarHolding/BarBigBeat.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarSmallBeat.png")
		$BarHolding/BarBigBeat2.texture = loadimage("user://Cosmetics/BaseStyle/Sprites/Notes/BarSmallBeat.png")
	for b in range(round(E.EditorDisplayNotation[0])):
		E.EditorExtraNote = ["BAR",(1.0/(round(E.EditorDisplayNotation[0])))*b]
		var Bar = load("res://Scenes/editor_notes.tscn")
		var bar = Bar.instantiate()
		$BarHolding.add_child(bar)

func _on_reload_timer_timeout():
	E.Reload = false
	_PlaceFakeNotes()
	if G.Playing != true:
		$main_scene._resetter()

func _on_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		E.TargetedDeletion = 0
		if E.CurrentBar != 0:
			E.CurrentBar -= 1
		else:
			E.CurrentBar = len(E.EditorDetails[1])-1
		_PlaceFakeNotes()

func _on_area_2_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		E.TargetedDeletion = 0
		if E.CurrentBar != len(E.EditorDetails[1])-1:
			E.CurrentBar += 1
		else:
			E.CurrentBar = 0
		_PlaceFakeNotes()

func _on_save_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		E.SaveDict = {
		"Chart":E.EditorDetails[1],
		"BPM":E.BPM,
		"MusicLocation":E.Music,
		"SongName":E.Name,
		"NotationU":E.Sig[0],
		"NotationD":E.Sig[1],
		"Dance":E.Dance,
		"NotationType":E.Sig[2]
		}
		E.songsfile = FileAccess.open(S.SongList[S.SongSelected], FileAccess.WRITE)
		E.SaveStringed = JSON.stringify(E.SaveDict)
		E.songsfile.store_line(E.SaveStringed)
		E.songsfile.close()
		E.Reload = true
		E.Save = true
		$ReloadTimer.start()

func _on_add_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		if $ButtonsA/AddButton.frame == 0:
			if E.CurrentNoteType == 10:
				HeldNote = [10,E.CurrentSig[0],E.CurrentSig[1],E.CurrentSig[2]]
			elif E.CurrentNoteType == 9:
				HeldNote = [9,E.CurrentPlacement,E.CurrentBPM]
			else:
				HeldNote = [E.CurrentNoteType,E.CurrentPlacement]
			
			
			if len(E.EditorDetails[1][E.CurrentBar]) == 0:
				E.EditorDetails[1][E.CurrentBar] += [HeldNote]
			else:
				if E.CurrentNoteType == 10:
					if E.EditorDetails[1][E.CurrentBar][0][0] == 10:
						E.EditorDetails[1][E.CurrentBar][0] = HeldNote
					else:
						ExchangeNote = E.EditorDetails[1][E.CurrentBar][0]
						E.EditorDetails[1][E.CurrentBar][0] = HeldNote
						HeldNote = ExchangeNote
						for i in range(len(E.EditorDetails[1][E.CurrentBar])-1):
							if HeldNote[1] <= E.EditorDetails[1][E.CurrentBar][i+1][1]:
								ExchangeNote = E.EditorDetails[1][E.CurrentBar][i+1]
								E.EditorDetails[1][E.CurrentBar][i+1] = HeldNote
								HeldNote = ExchangeNote
						E.EditorDetails[1][E.CurrentBar] += [HeldNote]
				else:
					if E.EditorDetails[1][E.CurrentBar][0][0] == 10:
						for i in range(len(E.EditorDetails[1][E.CurrentBar])-1):
							if HeldNote[1] == E.EditorDetails[1][E.CurrentBar][i+1][1]:
								E.EditorDetails[1][E.CurrentBar][i+1] = HeldNote
								HeldNote = [0,0]
								break
							elif HeldNote[1] < E.EditorDetails[1][E.CurrentBar][i+1][1] and HeldNote != [0,0]:
								ExchangeNote = E.EditorDetails[1][E.CurrentBar][i+1]
								E.EditorDetails[1][E.CurrentBar][i+1] = HeldNote
								HeldNote = ExchangeNote
					else:
						for i in range(len(E.EditorDetails[1][E.CurrentBar])):
							if HeldNote[1] == E.EditorDetails[1][E.CurrentBar][i][1]:
								E.EditorDetails[1][E.CurrentBar][i] = HeldNote
								HeldNote = [0,0]
								break
							elif HeldNote[1] <= E.EditorDetails[1][E.CurrentBar][i][1] and HeldNote != [0,0]:
								ExchangeNote = E.EditorDetails[1][E.CurrentBar][i]
								E.EditorDetails[1][E.CurrentBar][i] = HeldNote
								HeldNote = ExchangeNote
					if HeldNote != [0,0]:
						E.EditorDetails[1][E.CurrentBar] += [HeldNote]
		else:
			if len(E.EditorDetails[1][E.CurrentBar]) > 0:
				E.EditorDetails[1][E.CurrentBar].remove_at(E.TargetedDeletion)
			if len(E.EditorDetails[1][E.CurrentBar]) > 1:
				E.TargetedDeletion -= 1
			else:
				E.TargetedDeletion = 0
		E.Reload = true
		$ReloadTimer.start()

func _on_bar_c_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		if $Visual/LayoutA/SigCurrent/ToggleBar.frame == 0:
			$Visual/LayoutA/SigCurrent/ToggleBar.frame = 1
		else:
			$Visual/LayoutA/SigCurrent/ToggleBar.frame = 0

func _on_delete_switch_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		if $ButtonsA/RemoveButton.frame == 0:
			$ButtonsA/RemoveButton.frame = 1
			$ButtonsA/AddButton.frame = 1
			$Visual/LayoutA.visible = false
			$Visual/LayoutC.visible = true
		else:
			$ButtonsA/RemoveButton.frame = 0
			$ButtonsA/AddButton.frame = 0
			$Visual/LayoutA.visible = true
			$Visual/LayoutC.visible = false

func _on_bars_total_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		if E.TotalBars < E.HoldBarsTotal:
			print(E.HoldBarsTotal-E.TotalBars)
			for i in range(E.HoldBarsTotal-E.TotalBars):
				E.EditorDetails[1] += [[]]
		elif E.TotalBars > E.HoldBarsTotal:
			E.CurrentBar = 0
			for i in range(E.TotalBars-E.HoldBarsTotal):
				E.EditorDetails[1].remove_at(len(E.EditorDetails[1])-1)
		E.TotalBars = E.HoldBarsTotal
		E.Reload = true
		$ReloadTimer.start()
