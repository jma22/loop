extends State
class_name ComboParentState

# @export var charge_state : EnemyChargeStateBase
@export var attack_states : Array[State] = []
var current_state_idx : int = 0
var direction : Vector2 = Vector2.ZERO
var combo_window: float = 0.3
var combo_timer: float = 0.0

func enter() -> void:
	# charge_state.attack_state = attack_state
	current_state_idx = 0
	state_machine.set_state(attack_states[current_state_idx], true)

# func fixed_run(_delta: float) -> void:
# 	entity.velocity = Vector2.ZERO


# func exit() -> void:
# 	state_machine.set_state(charge_state, true)

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	for attack_state in attack_states:
		attack_state.set_direction(direction)

func run(_delta: float) -> void:
	check_state()
	if combo_timer > 0.0:
		combo_timer -= _delta


func check_state() -> void:
	var child_state : State = get_child_state()
	if child_state.is_complete:
		if combo_timer == 0.0:
			combo_timer = combo_window
		if entity.input_buffer.consume_buffer(&"atk"):
			current_state_idx += 1
			if current_state_idx < attack_states.size():
				state_machine.set_state(attack_states[current_state_idx], true)
			else:
				if combo_timer <= 0.0:
					combo_timer = 0.0
					is_complete = true
		else:
			if combo_timer <= 0.0:
				combo_timer = 0.0
				is_complete = true
