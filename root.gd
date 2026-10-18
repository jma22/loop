extends Node

const GAME_SIZE := Vector2i(320, 180)
const SCALE := 4                      # window is 1280×720

@export var target: Node2D            # the player, inside the SubViewport
@export var smoothing := 2.0

@onready var viewport: SubViewport = $SubViewport
@onready var camera: Camera2D = $SubViewport/Camera2D
@onready var display: Sprite2D = $Display

var smooth_pos := Vector2.ZERO

func _ready():
	viewport.size = GAME_SIZE + Vector2i(2, 2)   # 1px margin each side
	display.texture = viewport.get_texture()
	display.centered = false
	display.scale = Vector2(SCALE, SCALE)
	# display.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	target = get_tree().get_first_node_in_group("player")
	smooth_pos = target.get_look_ahead_point()


func _process(delta):
	# pass
	# 1. smooth follow in floating point (the exp formula from before)
	var target_pos : Vector2 = target.get_look_ahead_point() + target.velocity / smoothing
	smooth_pos = smooth_pos.lerp(target_pos, 1.0 - exp(-smoothing * delta))
	# smooth_pos = target.global_position
	# 2. camera inside the low-res world sits on whole pixels
	var snapped := smooth_pos.round()
	camera.global_position = snapped
	# print(camera.global_position)

	# # 3. slide the upscaled image by the leftover fraction
	var frac := smooth_pos - snapped               # always in -0.5..0.5
	display.position = (-Vector2.ONE - frac) * SCALE
