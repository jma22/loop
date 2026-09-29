extends State
class_name IdleState

@export var frame_numbers : Array[int]
var idle_duration : float = 3.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.sprite_manager.play_frames(frame_numbers)

		
func fixed_run(_delta: float) -> void:
	entity.move_velocity = Vector2.ZERO
	var gravity : float = 10.0
	entity.move_velocity += gravity * Vector2.DOWN
	
func set_idle_duration(duration: float) -> void:
	idle_duration = duration

func run(_delta: float) -> void:
	if get_elapsed_time() >= idle_duration:
		is_complete = true


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
