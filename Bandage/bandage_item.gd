extends Node2D

@export var is_active: bool = false

@onready var bone_start = $Skeleton2D/Start
@onready var bone_end = $Skeleton2D/Start/End

@onready var sprite = $Polygon2D
@onready var area = $Area2D

signal bandage_mouse_hover(next_bandage)

func _ready() -> void:
	sprite.visible = false

func _process(_delta: float) -> void:
	if is_active:
		var mouse_pos = get_global_mouse_position()
		if Input.is_action_pressed("ACTION"):
			bone_end.global_position = mouse_pos
	else:
		pass

func show_bandage():
	is_active = true
	sprite.visible = true
	area.queue_free()

func free_bandage():
	is_active = false

func _on_area_2d_mouse_entered() -> void:
	if not is_active:
		bandage_mouse_hover.emit(self, true)

func _on_area_2d_mouse_exited() -> void:
	if not is_active:
		bandage_mouse_hover.emit(self, false)
