extends Node2D

@export var markers : Array[Marker2D]

@onready var piezas_node = $PIEZAS

var completation : int = 0
var is_moving : bool = false

func _ready() -> void:
	completation = markers.size() 
	
	for pieza in piezas_node.get_children():
		var rand_index = randi_range(0, markers.size() -1)
		
		if "sprite" in pieza:
			pieza.sprite.global_position = markers.pop_at(rand_index).global_position
		
		if "balance_puzle_correct" in pieza:
			pieza.balance_puzle_correct.connect(puzzle_completation)
			

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ACTION"):
		for pieza in piezas_node.get_children():
			if "is_hovered" in pieza:
				if !pieza.is_hovered :
					pieza.can_move = false
	if event.is_action_released("ACTION"):
		for pieza in piezas_node.get_children():
			if ("can_move" in pieza) and ("is_correct" in pieza):
				if !pieza.is_correct:
					pieza.can_move = true

func puzzle_completation() -> void :
	completation -= 1
	if completation <= 0 :
		print("ganamoh")
