extends Node2D
class_name MaterialController
var mat : ShaderMaterial

@export var flash_curve : Curve
var flash_timer : float = 0.0

func setup(sprite_manager : SpriteManager) -> void:
	mat = sprite_manager.get_material().duplicate()
	sprite_manager.set_material(mat)
	print(mat)

func _process(delta: float) -> void:
	flash_tick(delta)

		
func damage_flash() -> void:
	print("Damage flash triggered")
	flash_timer = 1.0

func flash_tick(delta: float) -> void:
	if flash_timer > 0.0:
		flash_timer -= delta
		var flash_value = flash_curve.sample(1.0 - flash_timer)
		mat.set_shader_parameter("flash_amount", flash_value)
	else:
		mat.set_shader_parameter("flash_amount", 0.0)
