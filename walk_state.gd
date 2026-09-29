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
	entity.move_velocity += gravity * Vector2.DOWN
	if input_vector.x < 0:
		entity.sprite_manager.set_flip(true)
	elif input_vector.x > 0:
		entity.sprite_manager.set_flip(false)
	entity.move_velocity.x = input_vector.x * get_speed()

func get_speed() -> float:
	return 100.0

func check_state() -> void:
	var input_vector : Vector2 = entity.get_input()
	# var did_dash : bool = input_buffer.consume_buffer(&"dash")
	var did_attack : bool = entity.input_buffer.consume_buffer(&"atk")

	if input_vector.length() > 0:
		entity.facing_direction = input_vector.normalized()
	# if did_dash and dash_component.can_dash():
	# 	roll_state.set_direction(last_direction)
	# 	state_machine.set_state(roll_state)
	# 	dash_component.set_dash_cooldown()
	# 	return

	if did_attack:
		entity.combo_parent_state.set_direction(entity.facing_direction)
		entity.state_machine.set_state(entity.combo_parent_state)
		return
	# if Input.is_action_just_pressed("ui_accept"):
	# 	state_machine.set_state(combo_parent_state)
	# 	return

	if input_vector.length() > 0:
		entity.state_machine.set_state(entity.walk_state)
	else:
		entity.state_machine.set_state(entity.idle_state)
