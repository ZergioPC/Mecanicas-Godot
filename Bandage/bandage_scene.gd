extends Node2D

@export var markers: Array[Marker2D]
var markers_index := 0

@onready var bandage_scene := preload("res://Bandage/bandage_item.tscn")

@onready var layer_fixed_bands := $FixedBandage
@onready var layer_active_bands := $MoveBandage

var band_current: Node2D = null
var band_marker: Node2D = null

var hovering_marker: bool = false

func _ready() -> void:
	spawn_bandage()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ACTION") and hovering_marker:
		spawn_bandage()

func on_hover_marker(next: Node2D, value: bool):
	hovering_marker = value

func spawn_bandage() -> void:
	if band_current :
		band_current.reparent(layer_fixed_bands)
	
	if markers_index + 1 >= markers.size():
		band_current.free_bandage()
		band_marker.queue_free()
		print("terminao")
		return
	
	#Spawn Start
	if markers_index == 0:
		band_current = bandage_scene.instantiate()
		band_current.global_position = markers[markers_index].global_position
		layer_active_bands.add_child(band_current)
		band_current.show_bandage()
	else:
		band_marker.bandage_mouse_hover.disconnect(on_hover_marker)
		band_current.free_bandage()
		band_current = band_marker
		band_current.show_bandage()
	
	#Spawn End
	band_marker = bandage_scene.instantiate()
	band_marker.global_position = markers[markers_index +1].global_position
	layer_active_bands.add_child(band_marker)
	band_marker.bandage_mouse_hover.connect(on_hover_marker)
	
	markers_index += 1
