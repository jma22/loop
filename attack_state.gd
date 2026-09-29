extends State

class_name AttackState

@export var frame_numbers: Array[int]
@export var hitboxL: HitBox
@export var hitboxR: HitBox
@export var audio_player: AudioStreamPlayer

var attack_direction: Vector2 = Vector2.ZERO
var hitbox_frame: int = 1
var hitbox_duration: float = 0.1
var hitbox_timer: float = 0.0

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


func run(_delta: float) -> void:
	if entity.sprite_manager.check_is_done():
		entity.move_velocity = Vector2.ZERO
		# entity.position.y = 0
		is_complete = true

func fixed_run(delta: float) -> void:
	entity.move_velocity = Vector2.ZERO
	var hitbox: HitBox
	if attack_direction.x < 0:
		hitbox = hitboxL
	else:
		hitbox = hitboxR
	# apply arc velocity to entity
	# arc_component.tick(delta)
	# entity.velocity = arc_component.velocity

	if entity.sprite_manager.current_idx == hitbox_frame and not hitbox.is_active:
		hitbox.set_active(true)
		# entity.camera_ref.camera_shake(0.1,0.15)
	
	if hitbox.is_active:
		hitbox_timer += delta
		if hitbox_timer >= hitbox_duration:
			hitbox.set_active(false)
			hitbox_timer = 0.0


	# entity.velocity *= (1.0 - dampening)
	# if entity.velocity.length() < cutoff_velocity:
	# 	entity.velocity = Vector2.ZERO

func exit() -> void:
	pass
	# entity.sprite_manager.frames_per_second = 12
	# hitbox.set_active(false)

func set_direction(direction: Vector2) -> void:
	attack_direction = direction
