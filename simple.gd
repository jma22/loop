extends CharacterBody2D

@onready var juice_component : JuiceComponent = $JuiceComponent
@onready var state_machine : StateMachine = $StateMachine
@onready var core_components : CoreComponents = $CoreComponents
@onready var walk_state : WalkState = $StateMachine/WalkState
@onready var idle_state : IdleState = $StateMachine/IdleState
@onready var hurt_state : HurtState = $StateMachine/HurtState
@onready var air_state : AirState = $StateMachine/AirState
@onready var dash_state : DashState = $StateMachine/DashState
# @onready var attack_state : AttackState = $StateMachine/AttackState
@onready var combo_parent_state : ComboParentState = $StateMachine/ComboParentState
# Called when the node enters the scene tree for the first time.

@onready var health_component : HealthComponent = core_components.health_component
@onready var hurt_box : HurtBox = core_components.hurt_box
@onready var invulnerable_component : InvulnerableComponent = core_components.invulnerable_component
@onready var sprite_manager : SpriteManager = core_components.sprite_manager
@onready var knockback_component : KnockbackComponent = core_components.knockback_component
@onready var material_controller : MaterialController = core_components.material_controller


var input_buffer : InputBuffer  = InputBuffer.new()
var facing_direction : Vector2 = Vector2.ZERO
var move_velocity : Vector2 = Vector2.ZERO

var gravity_enabled : bool = true
var air_dash_available : bool = true
@export var gravity : float = 900.0
@export var max_fall_speed : float = 400.0
@export var jump_velocity : float = -290.0



func _ready() -> void:
	# hurtbox = $Area2D
	# hurtbox.area_entered.connect(_on_hurtbox_body_entered)
	setup()

func setup() -> void:
	core_components.setup(self)
	setup_states()
	juice_component.setup(get_initial_juice(), 0, self)
	state_machine.set_state(idle_state)
	Globals.player = self

func _exit_tree() -> void:
	if Globals.player == self:
		Globals.player = null

func setup_states() -> void:
	for state : Node in state_machine.find_children("*", "State", true, false):
		if state is State:
			state.set_entity(self)

func get_input() -> Vector2:
	var input_vector : Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	return input_vector

func _process(_delta: float) -> void:
	input_buffer.tick_buffer(_delta)
	if not state_machine.current_state:
		return


	# state_machine.current_state.check_state()
	# if state_machine.current_state.is_complete:
	# 	check_state()
	# else:
	# 	if state_machine.current_state == walk_state or state_machine.current_state == idle_state:
	# 		check_state()
	state_machine.current_state.check_state()
	state_machine.current_state.deep_run(_delta)
	if state_machine.current_state.is_complete:
		state_machine.set_state(idle_state)


func _physics_process(delta: float) -> void:
	# if hitstop.is_in_hitstop or not state_machine.current_state:
	# 	return
	state_machine.current_state.deep_fixed_run(delta)
	knockback_component.handle_knockback(delta)
	if gravity_enabled and not is_on_floor():
		move_velocity.y = min(move_velocity.y + gravity * delta, max_fall_speed)
	# if is_on_floor():
	# 	move_velocity.y = 0
	if knockback_component.knockback_velocity.length() > 0:
		move_velocity.x = 0
	velocity = move_velocity + knockback_component.knockback_velocity
	move_and_slide()
	if is_on_floor():
		move_velocity.y = 0
		air_dash_available = true


func take_damage(damage: int) -> void:
	health_component.take_damage(damage)

func enter_hurt_state() -> void:
	state_machine.set_state(hurt_state)
	material_controller.damage_flash()

func get_initial_health() -> int:
	return 5

func get_initial_juice() -> int:
	return 10

func get_look_ahead_point() -> Vector2:
	return global_position + facing_direction * 12
