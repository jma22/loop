class_name AttackChargeStateBase extends State


@export var frame_numbers : Array[int]
@export var charge_time : float = 0.5
@export var set_target_time : float = 0.0

var target_set : bool = false
var attack_state : State



func enter() -> void:
	entity.sprite_manager.play_frames(frame_numbers)
	target_set = false

# func run(_delta: float) -> void:
	# entity.set_sprite_flip(facing_left)
	# set_charge_progress()
	# check_state()

func fixed_run(_delta: float) -> void:
	entity.position.y = 0
	entity.velocity = Vector2.ZERO

func exit() -> void:
	entity.position.y = 0
	entity.velocity.y = 0
	entity.sprite_manager.set_charge_color(0)


func check_state() -> void:
	if set_target_time <= get_elapsed_time() and not target_set:
		var facing_left : bool = entity.global_transform.origin.x > entity.player.global_transform.origin.x
		entity.set_sprite_flip(facing_left)
		if attack_state.has_method("set_target_position"):
			attack_state.set_target_position(Globals.player.global_transform.origin)
		target_set = true
	if charge_time  <= get_elapsed_time():
		entity.velocity = Vector2.ZERO
		# attack_state.set_target_position(entity.player.global_transform.origin)
		is_complete = true

# func on_hit(damage : int) -> void:
# 	stagger_stamina -= damage
# 	if stagger_stamina <= 0:
# 		entity.on_staggered()


# func choose_target() -> Vector3:
# 	return entity.player.global_transform.origin

# func set_charge_progress() -> void:
# 	var progress : float = get_elapsed_time() / charge_time
# 	progress =  -(cos(PI * progress) - 1) / 2;
# 	entity.sprite_manager.set_charge_color(progress)