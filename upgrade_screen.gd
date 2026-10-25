extends CanvasLayer

signal upgrade_selected(index: int)

const HOVER_SCALE := 1.05

@onready var buttons: Array[Button] = [
	$Control/Margin/VBox/Option1,
	$Control/Margin/VBox/Option2,
	$Control/Margin/VBox/Option3,
]


func _ready() -> void:
	for i in buttons.size():
		var b := buttons[i]
		b.pressed.connect(_on_pressed.bind(i))
		b.resized.connect(func(): b.pivot_offset = b.size / 2)
		b.mouse_entered.connect(_scale_to.bind(b, HOVER_SCALE))
		b.mouse_exited.connect(_scale_to.bind(b, 1.0))
		b.focus_entered.connect(_scale_to.bind(b, HOVER_SCALE))
		b.focus_exited.connect(_scale_to.bind(b, 1.0))
	buttons[0].grab_focus()


func _scale_to(b: Button, s: float) -> void:
	var t := create_tween()
	t.tween_property(b, "scale", Vector2.ONE * s, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


# Set button labels, e.g. set_options(["Speed +10%", "Dash cooldown -1s", "Bigger pickup radius"])
func set_options(names: Array) -> void:
	for i in mini(names.size(), buttons.size()):
		buttons[i].text = str(names[i])


func _on_pressed(index: int) -> void:
	upgrade_selected.emit(index)
	queue_free()
