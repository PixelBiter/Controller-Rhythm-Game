extends Node

var GameReady = false #Tells when the game is ready to do stuff
var Playing = false #Song/Level Playing
var Note = 0 #Value To Assign To Note
var NoteToHit = 0 #Value to Check To Hit
var BarOn = 0 #The Bar That Is Currently In Use
var Start = 0 #What time the song is stopped

var VisualiserBars = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]#Audoi Visualiser

var TimeIntoSong = 0.0 #Total Time
var TimeTaken = TimeIntoSong
var Bar = 0#What Bar The Song Is Currently @.   Use to figure out which bar to play
var BarRound = 0 #The Bar rounded 
var NoteToCheck = 0 #Reset Each Bar, When Going through each note, use this to count them up for their roles
var TimeLastRead = 0 #Updates when Bar increases
#60/BPM is how long each bar is

var SongDetails = [0.0,[],[],"","",""]#BPM,Notes,Notations,SongLocation,SongName,Dance
var TotalNotation = 0 #Counts up all used notations
var Amount = 0 #The amount of hittable notes, gets counted in program
var Chart = [] #Seperated Chart to make things more organised
var Combo = 0 #Notes Hit In A Row
var PERFECT = true #If perfect combo
var Score = [0,0]#Silver,Gold
var Rating = ""#FRESH,GOOD, etc.

var SquidOctoShuffle = 0 #Modifier for displaying octo or squid on the ratings

var Inputs = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]] #Face,Shoulder
var InputsAdded = [0,0]
var HeldInputs = [0,0,0,0,0,0,0,0,0,0,0,0]

var BPM = SongDetails[0]
var Offset = (TimeIntoSong * BPM * 3)
var Offset2 = 0

func _process(delta):
	InputsAdded = [Inputs[0][0] + Inputs[1][0] + Inputs[2][0] + Inputs[3][0] + Inputs[4][0] + Inputs[5][0],Inputs[0][1] + Inputs[1][1] + Inputs[2][1] + Inputs[3][1] + Inputs[4][1] + Inputs[5][1]]
	if SongDetails[0] != BPM:
		Offset2 += ((TimeIntoSong-TimeTaken) * BPM * 3)
		TimeTaken = TimeIntoSong
		BPM = G.SongDetails[0]
	Offset = -((TimeIntoSong- TimeTaken) * G.BPM * 3) - Offset2

func _input(event):
	if Input.is_action_just_released("FaceA1"):
		G.HeldInputs[0] = 0
	if Input.is_action_just_released("FaceA2"):
		G.HeldInputs[1] = 0
	if Input.is_action_just_released("FaceA3"):
		G.HeldInputs[2] = 0
	if Input.is_action_just_released("FaceA4"):
		G.HeldInputs[3] = 0
	if Input.is_action_just_released("FaceB1"):
		G.HeldInputs[4] = 0
	if Input.is_action_just_released("FaceB2"):
		G.HeldInputs[5] = 0
	if Input.is_action_just_released("FaceB3"):
		G.HeldInputs[6] = 0
	if Input.is_action_just_released("FaceB4"):
		G.HeldInputs[7] = 0
	if Input.is_action_just_released("ShoulderA1"):
		G.HeldInputs[8] = 0
	if Input.is_action_just_released("ShoulderA2"):
		G.HeldInputs[9] = 0
	if Input.is_action_just_released("ShoulderB1"):
		G.HeldInputs[10] = 0
	if Input.is_action_just_released("ShoulderB2"):
		G.HeldInputs[11] = 0
