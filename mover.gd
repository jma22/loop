extends Node2D


var parent : Node2D

func _ready() -> void:
	parent = get_parent() as Node2D

func _physics_process(delta: float) -> void:
	# if parent:
	parent.position += Vector2.LEFT * 100 * delta
	# parent.velocity = Vector2.LEFT * 100 * delta
	
