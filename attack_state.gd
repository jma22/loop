extends State

class_name AttackState

@export var frame_numbers: Array[int]
@export var swing_L: AttackSwing
@export var swing_R: AttackSwing
@export var audio_player: AudioStreamPlayer

var attack_direction: Vector2 = Vector2.ZERO
var hitbox_frame: int = 1
var hitbox_duration: float = 0.1
var hitbox_timer: float = 0.0
var swing : AttackSwing

var speed: float = 0.0
# var initial_velocity: float = 400.0
# var dampening: float = 0.2
# var cutoff_velocity: float = 100.0


func enter() -> void:
	# entity.sprite_manager.frames_per_second = 12
	entity.sprite_manager.play_frames(frame_numbers, false)
	# entity.velocity = attack_direction * initial_velocity
	
	# convert 2D attack direction to world position for the arc
	# var dir3d := Vector3(attack_direction.x, 0, attack_direction.y * Constants.VERTICAL_PERSRPECTIVE_SCALE).normalized()
	# var target := entity.global_transform.origin + dir3d * horizontal_distance

	# entity.move_velocity = Vector2.ZERO
	speed = entity.walk_state.get_speed()
	if attack_direction.x < 0:
		swing = swing_L
	else:
		swing = swing_R
	swing.start()


func run(_delta: float) -> void:
	if not swing.swing_is_active():
		entity.move_velocity = Vector2.ZERO
		# entity.position.y = 0
		is_complete = true

func fixed_run(_delta: float) -> void:
	var input_vector : Vector2 = entity.get_input()
	# if input_vector.length() == 0:
		# is_complete = true
		# return
	input_vector = entity.get_input()

	var gravity : float = 10.0
	entity.move_velocity += gravity * Vector2.DOWN
	# if input_vector.x < 0:
	# 	entity.sprite_manager.set_flip(true)
	# elif input_vector.x > 0:
	# 	entity.sprite_manager.set_flip(false)
	entity.move_velocity.x = input_vector.x * speed
# func fixed_run(delta: float) -> void:
	
	# apply arc velocity to entity
	# arc_component.tick(delta)
	# entity.velocity = arc_component.velocity

	


	# entity.velocity *= (1.0 - dampening)
	# if entity.velocity.length() < cutoff_velocity:
	# 	entity.velocity = Vector2.ZERO

func exit() -> void:
	pass
	# entity.sprite_manager.frames_per_second = 12
	# hitbox.set_active(false)

func set_direction(direction: Vector2) -> void:
	attack_direction = direction
