extends Node2D

@onready var sprite = $AnimSprite

func _ready() -> void:
	sprite.frame = 0

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ACTION") :
		sprite.frame = 1
	
	if event.is_action_released("ACTION") : 
		sprite.frame = 0
