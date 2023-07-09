extends Node


var currentlyPlaying: int = 3	# index in playlist array
@onready var playlist = [$Armory, $Cell, $Hallway, 
$Janitory, $Lockers, $Office, $Research]


# Called when the node enters the scene tree for the first time.
func _ready():
	playlist[currentlyPlaying].play()
	playlist[currentlyPlaying].volume_db = -5
	print("yes")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_trigger_hall_area_entered(_area):
	print("playing hall")
	play_song(2)


func _on_trigger_research_area_entered(_area):
	print("playing research")
	play_song(6)


func play_song(newSong: int):
	
	if newSong != currentlyPlaying:
		
		# start the song if not playing
		if playlist[newSong].playing == false:
			playlist[newSong].play(2.0)
		
		# create faders
		var fadeIn = get_tree().create_tween()
		var fadeOut = get_tree().create_tween()
		
		# fade the songs in and out
		fadeOut.tween_property(playlist[currentlyPlaying], "volume_db" , -40, 1)
		fadeIn.tween_property(playlist[newSong], "volume_db" , -10, 1)
		
		currentlyPlaying = newSong
	
	
