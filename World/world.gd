extends Node2D

@onready var NPCArray: Array[CharacterBody2D] = [
	$"Waypoint NPC",$"Waypoint NPC2",$"Waypoint NPC3",$"Waypoint NPC4"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if NPCArray[0] == null and NPCArray[1] == null and NPCArray[2] == null and NPCArray[3] == null:
		get_tree().change_scene_to_file("res://World/win_screen.tscn")
	
