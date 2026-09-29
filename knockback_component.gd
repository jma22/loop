extends Node2D
class_name KnockbackComponent

@export var knockback_mult : float = 200.0
@export var knockback_dampening : float = log(2)/0.05
@export var is_knockbackable : bool = true
var knockback_velocity: Vector2 = Vector2.ZERO
var entity: Node2D


func setup(entity_: Node2D) -> void:
	entity = entity_

func handle_knockback(delta: float) -> void: 
	if not is_knockbackable:
		return
	if knockback_velocity.length() > 5.0:
		knockback_velocity *= exp(-knockback_dampening * delta)
		# entity.position += knockback_velocity
	else:
		knockback_velocity = Vector2.ZERO

func set_knockbackable(value: bool) -> void:
	is_knockbackable = value

func receive_knockback(direction: Vector2, force: float) -> void:
	knockback_velocity = direction.normalized() * force * knockback_mult