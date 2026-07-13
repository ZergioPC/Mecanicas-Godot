extends Node2D

@export var piece_sprite : Texture2D
@export var piece_scale : float = 1.0
@export var hitbox_radio : int = 1
@export var selection_radio : int = 10

@onready var sprite = $Sprite2D
@onready var hitbox_shape = $Sprite2D/PiezeHitbox/CollisionShape2D
@onready var holebox_shape = $PiezeHoleBox/CollisionShape2D

var is_hovered : bool = false
var is_correct : bool = false
var is_moving : bool = false
var can_move : bool = true

signal balance_puzle_correct

func _ready() -> void:
	hitbox_shape.scale *= selection_radio
	holebox_shape.scale *= hitbox_radio
	sprite.texture = piece_sprite
	
	# EN CASO DE QUE EL TABLERO TENGA OTRO TAMAÑO
	self.scale *= piece_scale

func _process(delta: float) -> void:
	if !can_move :
		return
	
	var mouse_pos = get_global_mouse_position()
	if Input.is_action_pressed("ACTION") and is_hovered:
		is_moving = true
		sprite.global_position = mouse_pos
	else:
		is_moving = false
	
	if Input.is_action_just_released("ACTION") and is_correct:
		sprite.position = Vector2.ZERO
		balance_puzle_correct.emit()
		can_move = false

# SIGNALS

func _on_pieze_hitbox_mouse_entered() -> void:
	is_hovered = true

func _on_pieze_hitbox_mouse_exited() -> void:
	if !is_moving :
		is_hovered = false

func _on_pieze_hole_box_mouse_entered() -> void:
	is_correct = true

func _on_pieze_hole_box_mouse_exited() -> void:
	is_correct = false
