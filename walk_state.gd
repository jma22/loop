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
	input_vector = entity.get_input().normalized()

	if input_vector.x < 0:
		entity.sprite_manager.set_flip(true)
	elif input_vector.x > 0:
		entity.sprite_manager.set_flip(false)
	entity.move_velocity.x = input_vector.x * get_speed()

func get_speed() -> float:
	return speed * 10

func check_state() -> void:
	if not entity.is_on_floor():
		entity.state_machine.set_state(entity.air_state)
		return
		
	var input_vector : Vector2 = entity.get_input()
	# var did_dash : bool = input_buffer.consume_buffer(&"dash")
	var did_attack : bool = entity.input_buffer.consume_buffer(&"atk")
	var did_jump : bool = entity.input_buffer.consume_buffer(&"jump")

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
	if did_jump:
		entity.move_velocity.y +=  entity.jump_velocity
		return
	# if Input.is_action_just_pressed("ui_accept"):
	# 	state_machine.set_state(combo_parent_state)
	# 	return

	if input_vector.length() > 0:
		entity.state_machine.set_state(entity.walk_state)
	else:
		entity.state_machine.set_state(entity.idle_state)
