extends State
class_name CirclePursuitState

@export var frame_numbers : Array[int]
var pursue_duration : float = 1.0
var pursue_speed : float = 20.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	# entity.sprite_manager.play_frames(frame_numbers)

		
func fixed_run(_delta: float) -> void:
	var direction : Vector2 = (Globals.player.global_position - entity.global_position).normalized()
	direction = Vector2(-1,0) if direction.x < 0 else Vector2(1,0)
	# entity.global_position += direction * 1.0 * _delta
	entity.velocity = direction * pursue_speed


func run(_delta: float) -> void:
	if get_elapsed_time() >= pursue_duration:
		is_complete = true
	
