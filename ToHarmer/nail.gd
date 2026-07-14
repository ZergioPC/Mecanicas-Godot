extends Node2D

var life : int = 3
var is_hovered : bool = false
var is_complete : bool = false

@onready var sprite = $Sprite2D

signal to_harmer_nailed

func _input(event: InputEvent) -> void:
	if is_complete :
		return
	
	if event.is_action_pressed("ACTION") and is_hovered:
		sprite.position.y += 5
		life -= 1
		if life <= 0 :
			is_complete = true
			to_harmer_nailed.emit()

func _on_area_2d_mouse_entered() -> void:
	if is_complete :
		return
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	if is_complete :
		return
	is_hovered = false
