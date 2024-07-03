# Controller-Rhythm-Game
A base for a rhythm game to be played with a controller's shoulder and face buttons. Includes an editor for songs and easy sprite changes.

How to set-up:
Download the ControllerRhythmGame and GameComponents
Set-up the ControllerRhythmGame normally and then launch it.
Close it then go to %appdata% and then go to Godot/app_userdata/ControllerRhythmGame and then put everything in GameComponents into that folder (Note: not the GameComponents folder itself, just what's inside)
After that, it should be set-up.

To add new charts, put the chart in the chartfiles folder and then add the directory for it in the ChartList text file, making sure to add a comma and then the location.
e.g:    ["New.txt"]   ->    ["New.txt","NewChartHere.txt"]
Then put the song and any additional specified items in the correct locations specified in the chart file (Usually music in one of the music folders and dances in the dance folder)

The sprites and sfx can be edited as wanted just by replacing their files in the appdata

To edit a chart in the editor you have to follow the add new chart and then just enter the editor and move to that song to begin editing.


To note, this program is most likely very buggy as this is practically my first proper project and was started as a way for me to better learn coding.
I will try to address any bugs found although I can't guarantee that I will fix it.
