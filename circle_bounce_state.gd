extends State
class_name CircleBounceState

@export var frame_numbers : Array[int]
var idle_duration : float = 3.0

var jump_duration : float = 1.0
var direction : Vector2 = Vector2.ZERO
var height : float = 50.0

var initial_y_velocity : float = 0.0
var gravity : float = 10.0
var starting_y : float = 0.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	# entity.sprite_manager.play_frames(frame_numbers)
	var jump_right : bool = randf()	> 0.5
	direction = Vector2(-1, 0 ) if !jump_right else Vector2(1, 0 )
	var peak_time = jump_duration / 2.0
	initial_y_velocity = 2 * height / peak_time
	gravity = 2 * height / (peak_time * peak_time)
	
	starting_y = entity.global_position.y
	entity.velocity = direction * 40.0 + Vector2.UP * initial_y_velocity
		
func fixed_run(_delta: float) -> void:
	# var x_speed = direction.x * 40.0
	# var y_speed = Vector2.ZERO
	# print(entity.velocity)
	# if abs(entity.velocity.y) < 10.0:
	# 	print("Near peak: ", starting_y - entity.global_position.y)
	# 	y_speed = Vector2.UP * (initial_y_velocity - gravity /  5* get_elapsed_time())
	# else:
	# 	print("Far from peak: ", starting_y- entity.global_position.y)
	# 	y_speed = Vector2.UP * (initial_y_velocity - gravity* get_elapsed_time())
	if abs(entity.velocity.y) < 10.0:
		entity.velocity += gravity * 0.2 * Vector2.DOWN * _delta
	else:
		entity.velocity += gravity * Vector2.DOWN * _delta

	if entity.velocity.y > 0.0 and entity.global_position.y >= starting_y:
		entity.global_position.y = starting_y
		entity.velocity = Vector2.ZERO
		is_complete = true
		
	# entity.global_position += direction * 1.0 * _delta
	# entity.velocity = Vector2(x_speed, y_speed.y)

	
func set_idle_duration(duration: float) -> void:
	idle_duration = duration

# func run(_delta: float) -> void:
	# if get_elapsed_time() >= jump_duration:
	# 	entity.global_position.y = starting_y
	# 	is_complete = true


func check_state() -> void:
	pass
