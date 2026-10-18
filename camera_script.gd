extends Camera2D

@export var target: Node2D
@export var smoothing := 8.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		##smoothing
		global_position = global_position.lerp(target.global_position, 1.0 - exp(-smoothing * delta))