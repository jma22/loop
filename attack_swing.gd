extends Node2D
class_name AttackSwing

@export var sprite_manager : SpriteManager
@export var hitbox: HitBox
@export var frame_numbers : Array[int] = []

var hitbox_frame : int = 2


# func _ready() -> void:
	# for frame_number in range(len(sprite_manager.frames)):
	# 	frame_numbers.append(frame_number)

func _process(_delta: float) -> void:
	if hitbox_frame == sprite_manager.frame:
		hitbox.set_active(true)
	else:
		hitbox.set_active(false)
	if sprite_manager.check_is_playing() == false:
		sprite_manager.hide()

func start() -> void:
	sprite_manager.show()
	sprite_manager.play_frames(frame_numbers, false)

func stop() -> void:
	sprite_manager.stop()
	sprite_manager.hide()
	hitbox.set_active(false)

func swing_is_active() -> bool:
	return sprite_manager.check_is_playing()
