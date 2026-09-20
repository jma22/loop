extends Sprite2D

class_name SpriteManager

@export var frames_per_second : float = 4
@export var layer_number : int = 1
# var hitstop : HitStop
var current_idx : int = 0
var time_accumulator : float = 0.0
var looping : bool = true
@export var frame_numbers : Array[int] = []
var is_done : bool = false


func _ready() -> void:
	await get_tree().process_frame


func reset() -> void:
	current_idx = 0
	time_accumulator = 0.0
	frame_numbers = []
	looping = true

func _process(delta: float) -> void:

	if frame_numbers.is_empty():
		return
	# if hitstop and hitstop.is_in_hitstop:
	# 	return
	
	time_accumulator += delta
	var frame_time : float = 1.0 / frames_per_second
	if time_accumulator >= frame_time:
		current_idx += 1
		if current_idx >= frame_numbers.size():
			if looping:
				current_idx = 0
			else:
				current_idx = frame_numbers.size() - 1
				frame_numbers = []
				is_done = true
		
		if not frame_numbers.is_empty():
			frame = min(hframes * vframes - 1, frame_numbers[current_idx])
		time_accumulator = 0.0


func play_frames(frames: Array[int], loop: bool = true) -> void:
	if frames == null or frames.is_empty():
		return
	is_done = false
	frame_numbers = frames
	current_idx = 0
	time_accumulator = 0.0
	looping = loop
	frame = min(hframes * vframes - 1, frame_numbers[current_idx])

func check_is_done() -> bool:
	return is_done

func set_flip(is_left: bool) -> void:
	self.flip_h = is_left

# func damage_flash() -> void:
# 	if tween != null and tween.is_valid():
# 		await tween.finished
# 	tween = get_tree().create_tween()
# 	#material_overlay.set_shader_parameter("flash_level)", 1)
# 	tween.tween_callback(Callable(self, "set_flash_level").bind(1))
# 	tween.tween_property(self,"material_overlay:shader_parameter/flash_level", 0, 0.2)
# 	tween.play()

# func set_flash_level(level : float) -> void:
# 	material_overlay.set_shader_parameter("flash_level", level)
# func set_charge_color(progress : float) -> void:
# 	material_overlay.set_shader_parameter("charge_level", progress)

# func die() -> Tween:
# 	if tween != null and tween.is_valid():
# 		await tween.finished

# 	var death_tween : Tween = create_tween()
# 	death_tween.tween_callback(Callable(self, "set_flash_level").bind(0))
# 	death_tween.tween_callback(Callable(self, "set_charge_color").bind(0))
# 	death_tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.2)
# 	return death_tween


# func set_render_priority(priority: int) -> void:
# 	render_priority = priority
# 	material_overlay.render_priority = priority + 1
