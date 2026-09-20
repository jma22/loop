extends State
class_name IdleState

@export var frame_numbers : Array[int]
var idle_duration : float = 3.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.sprite_manager.play_frames(frame_numbers)

		
func fixed_run(_delta: float) -> void:
	entity.velocity = Vector2.ZERO
	var gravity : float = 10.0
	entity.velocity += gravity * Vector2.DOWN
	
func set_idle_duration(duration: float) -> void:
	idle_duration = duration

func run(_delta: float) -> void:
	if get_elapsed_time() >= idle_duration:
		is_complete = true
