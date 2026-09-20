extends State

class_name WalkState
@export var frame_numbers : Array[int]
@export var speed: float = 5.0
@export var fps: float = 4.0

func enter() -> void:
	# player.sprite_manager.frames_per_second = fps
	entity.sprite_manager.play_frames(frame_numbers)

func fixed_run(_delta: float) -> void:
	var input_vector : Vector2 = entity.get_input()
	if input_vector.length() == 0:
		is_complete = true
		return
	input_vector = entity.get_input()

	var gravity : float = 10.0
	entity.velocity += gravity * Vector2.DOWN
	if input_vector.x < 0:
		entity.sprite_manager.set_flip(true)
	elif input_vector.x > 0:
		entity.sprite_manager.set_flip(false)
	entity.velocity.x = input_vector.x * get_speed()

func get_speed() -> float:
	return 100.0
