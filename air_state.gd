extends State

class_name AirState
@export var frame_numbers: Array[int]
@export var stun_duration: float = 0.4
@export var invulnerability_duration: float = 0.6

func enter() -> void:
	# player.sprite_manager.frames_per_second = fps
	entity.sprite_manager.play_frames(frame_numbers)
	entity.invulnerable_component.set_invulnerable(true, invulnerability_duration)


# func exit() -> void:
# 	entity.set_invulnerable(false)

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
	entity.move_velocity.x = input_vector.x * 50

func run(_delta: float) -> void:
	if get_elapsed_time() > stun_duration:
		is_complete = true


func check_state() -> void:
	if entity.is_on_floor():
		entity.state_machine.set_state(entity.idle_state)
		return

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


