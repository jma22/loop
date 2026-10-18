extends State
class_name IdleState

@export var frame_numbers : Array[int]
var idle_duration : float = 3.0

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.sprite_manager.play_frames(frame_numbers)
	entity.move_velocity.x = 0


		
func fixed_run(_delta: float) -> void:
	pass
	
func set_idle_duration(duration: float) -> void:
	idle_duration = duration

func run(_delta: float) -> void:
	if get_elapsed_time() >= idle_duration:
		is_complete = true


func check_state() -> void:
	if not entity.is_on_floor():
		entity.state_machine.set_state(entity.air_state)
		return
	var input_vector : Vector2 = entity.get_input()
	# var did_dash : bool = input_buffer.consume_buffer(&"dash")
	var did_attack : bool = entity.input_buffer.consume_buffer(&"atk")
	var did_jump : bool = entity.input_buffer.consume_buffer(&"jump")
	print("jump " + str(did_jump))
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
