extends Node

var SongList = []
var SongSelected = 0
var Medals = {}
var DanceList = {}

func _ready():
	var SongRead = FileAccess.open("user://ChartList.txt", FileAccess.READ)
	SongList = JSON.parse_string(SongRead.get_as_text())
	var DanceRead = FileAccess.open("user://Cosmetics/BaseStyle/Sprites/Dances/DanceDict.txt", FileAccess.READ)
	DanceList = JSON.parse_string(DanceRead.get_as_text())
	var MedalRead = FileAccess.open("user://Medals.txt", FileAccess.READ)
	Medals = JSON.parse_string(MedalRead.get_as_text())
