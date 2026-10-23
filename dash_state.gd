extends State

class_name DashState
@export var frame_numbers : Array[int]
@export var dash_speed : float = 300.0
@export var dash_duration : float = 0.18
@export var afterimage_interval : float = 0.03
var _afterimage_timer : float = 0.0
var direction : Vector2 = Vector2.RIGHT

func set_direction(dir: Vector2) -> void:
	direction = dir

func enter() -> void:
	entity.sprite_manager.play_frames(frame_numbers)
	_afterimage_timer = 0.0
	if not entity.is_on_floor():
		entity.air_dash_available = false
	entity.gravity_enabled = false
	Afterimage.spawn(entity.sprite_manager)

func exit() -> void:
	entity.gravity_enabled = true

func run(delta: float) -> void:
	_afterimage_timer += delta
	if _afterimage_timer >= afterimage_interval:
		_afterimage_timer = 0.0
		Afterimage.spawn(entity.sprite_manager)
	if get_elapsed_time() >= dash_duration:
		is_complete = true

func fixed_run(_delta: float) -> void:
	var dir_x : float = sign(direction.x) if direction.x != 0.0 else 1.0
	entity.sprite_manager.set_flip(dir_x < 0)
	entity.move_velocity.x = dir_x * dash_speed
	entity.move_velocity.y = 0.0

# func check_state() -> void:
# 	if entity.is_on_floor():
# 		entity.state_machine.set_state(entity.idle_state)
# 	else:
# 		entity.state_machine.set_state(entity.air_state)
