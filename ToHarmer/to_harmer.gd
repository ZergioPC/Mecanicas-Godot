extends Node2D

@onready var nails_node = $Nails

@export var markers : Array[Marker2D]
var completation : int = 0

func _ready() -> void:
	completation = markers.size()
	
	for nail in nails_node.get_children():
		var rand_index = randi_range(0, markers.size() -1)
		
		nail.global_position = markers.pop_at(rand_index).global_position
		nail.to_harmer_nailed.connect(nails_progres)

func nails_progres():
	completation -= 1
	if (completation <= 0) :
		print("ganamoh")
