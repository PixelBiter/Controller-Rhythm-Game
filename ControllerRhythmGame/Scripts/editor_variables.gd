extends Node

var EditorDetails = [0.0,[],[],"","",""]
var EditorOn = false

var SaveDict
var Reload = false

var Music = EditorDetails[3]
var Name = EditorDetails[4]
var Dance = 1

var BPM = EditorDetails[0]
var Sig = EditorDetails[2]
var Chart = EditorDetails[1]

var TotalBars = len(Chart)
var HoldBarsTotal = TotalBars
var TargetedDeletion = 0

var CurrentBar = 0 
var CurrentNoteType = 1
var CurrentPlacement = [1,2]
var CurrentBPM = 100
var CurrentSig = [4,4,0]

var EditorExtraNote = ["",0]
var EditorDisplayNotation = [4,4,0]

var songsfile
var SaveStringed

var DanceList = []

