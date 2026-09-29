extends State
class_name CircleIdleState

@export var frame_numbers : Array[int]
var idle_duration : float = 3.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	# entity.sprite_manager.play_frames(frame_numbers)

		
func fixed_run(_delta: float) -> void:
	var direction : Vector2 = Vector2(-1, 0 )
	# entity.global_position += direction * 1.0 * _delta
	entity.velocity = direction * 5.0

	
func set_idle_duration(duration: float) -> void:
	idle_duration = duration

func run(_delta: float) -> void:
	if get_elapsed_time() >= idle_duration:
		is_complete = true


func check_state() -> void:
	pass
