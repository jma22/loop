extends State

class_name HurtState
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
	entity.velocity = Vector2.ZERO

func run(_delta: float) -> void:
	if get_elapsed_time() > stun_duration:
		is_complete = true
