extends CharacterBody2D

@onready var state_machine : StateMachine = $StateMachine
@onready var core_components : CoreComponents = $CoreComponents
# @onready var walk_state : WalkState = $StateMachine/WalkState
@onready var circle_idle_state : CircleIdleState = $StateMachine/CircleIdleState
# @onready var hurt_state : HurtState = $StateMachine/HurtState
# @onready var attack_state : AttackState = $StateMachine/AttackState
# @onready var combo_parent_state : ComboParentState = $StateMachine/ComboParentState
# Called when the node enters the scene tree for the first time.

@onready var health_component : HealthComponent = core_components.health_component
@onready var hurt_box : HurtBox = core_components.hurt_box
@onready var knockback_component : KnockbackComponent = core_components.knockback_component
# @onready var invulnerable_component : InvulnerableComponent = core_components.invulnerable_component
@onready var sprite_manager : SpriteManager = core_components.sprite_manager

var input_buffer : InputBuffer  = InputBuffer.new()
var facing_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	# hurtbox = $Area2D
	# hurtbox.area_entered.connect(_on_hurtbox_body_entered)
	setup()

func setup() -> void:
	core_components.setup(self)
	setup_states()
	state_machine.set_state(circle_idle_state)

func setup_states() -> void:
	for state : Node in state_machine.find_children("*", "State", true, false):
		if state is State:
			state.set_entity(self)

func _process(_delta: float) -> void:
	if not state_machine.current_state:
		return

	state_machine.current_state.check_state()
	state_machine.current_state.deep_run(_delta)
	if state_machine.current_state.is_complete:
		state_machine.set_state(circle_idle_state)


func _physics_process(delta: float) -> void:
	# if hitstop.is_in_hitstop or not state_machine.current_state:
	# 	return
	state_machine.current_state.deep_fixed_run(delta)
	# knockback_component.handle_knockback()
	move_and_slide()


func take_damage(damage: int) -> void:
	health_component.take_damage(damage)

func enter_hurt_state() -> void:
	# state_machine.set_state(hurt_state)
	pass

func get_initial_health() -> int:
	return 10
