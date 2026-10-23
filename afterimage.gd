extends Sprite2D

class_name Afterimage

## Usage: Afterimage.spawn(sprite)
const SHADER : Shader = preload("res://afterimage.gdshader")

static var _material : ShaderMaterial  # shared base material
@export var lifetime : float = 0.3
@export var start_alpha : float = 0.6

static func spawn(source: Sprite2D, lifetime_override: float = -1.0) -> Afterimage:
	var ghost := Afterimage.new()
	ghost.texture = source.texture
	ghost.hframes = source.hframes
	ghost.vframes = source.vframes
	ghost.frame = source.frame
	ghost.flip_h = source.flip_h
	ghost.flip_v = source.flip_v
	ghost.centered = source.centered
	ghost.offset = source.offset
	ghost.scale = source.global_scale
	ghost.z_index = source.z_index - 1
	if lifetime_override > 0.0:
		ghost.lifetime = lifetime_override

	if _material == null:
		_material = ShaderMaterial.new()
		_material.shader = SHADER
	# per-ghost copy so each can fade independently
	ghost.material = _material.duplicate()

	source.get_viewport().add_child(ghost)  # same SubViewport as the player
	ghost.global_position = source.global_position
	ghost.global_rotation = source.global_rotation
	return ghost

func _ready() -> void:
	var mat := material as ShaderMaterial
	var tween := create_tween()
	tween.tween_method(func(a: float) -> void: mat.set_shader_parameter("alpha", a), start_alpha, 0.0, lifetime)
	tween.tween_callback(queue_free)
