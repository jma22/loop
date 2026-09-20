extends CharacterBody2D



@onready var sprite_manager : SpriteManager = $SpriteManager
@onready var state_machine : StateMachine = $StateMachine
@onready var walk_state : WalkState = $StateMachine/WalkState
@onready var idle_state : IdleState = $StateMachine/IdleState
# Called when the node enters the scene tree for the first time.

var hurtbox: Area2D

func _ready() -> void:
	hurtbox = $Area2D
	hurtbox.area_entered.connect(_on_hurtbox_body_entered)
	setup_states()
	state_machine.set_state(idle_state)

func setup_states() -> void:
	for state : Node in state_machine.get_children():
		if state is State:
			state.set_entity(self)
	
func _on_hurtbox_body_entered(area: Area2D) -> void:
	print("Body entered hurtbox: ", area)

func get_input() -> Vector2:
	var input_vector : Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	return input_vector

func _process(_delta: float) -> void:
	if state_machine.current_state:
		check_state()
		state_machine.current_state.deep_run(_delta)

func check_state() -> void:
	var input_vector : Vector2 = get_input()
	# var did_dash : bool = _consume_buffered(&"dash")
	# var did_attack : bool = _consume_buffered(&"atk")
	# if input_vector.length() > 0:
	# 	last_direction = input_vector
	# if did_dash and dash_component.can_dash():
	# 	roll_state.set_direction(last_direction)
	# 	state_machine.set_state(roll_state)
	# 	dash_component.set_dash_cooldown()
	# 	return

	# if did_attack:
	# 	attack_state.set_direction(last_direction)
	# 	state_machine.set_state(attack_state)
	# 	return

	if input_vector.length() > 0:
		state_machine.set_state(walk_state)
	else:
		state_machine.set_state(idle_state)

func _physics_process(delta: float) -> void:
	# if hitstop.is_in_hitstop or not state_machine.current_state:
	# 	return
	state_machine.current_state.deep_fixed_run(delta)
	# knockback_component.handle_knockback()
	move_and_slide()
