extends Node2D
class_name InvulnerableComponent
var is_invulnerable : bool = false
var invulnerability_timer : float = 0.0
var entity : Node2D = null

func setup(entity: Node2D) -> void:
	self.entity = entity


func set_invulnerable(value: bool, duration: float = 0.0) -> void:
	is_invulnerable = value
	invulnerability_timer = duration
	## 1 and 16 on 
	if value:
		entity.set_collision_layer_value(0, false)
	else:
		entity.set_collision_layer_value(0, true)
	print("Invulnerable: ", is_invulnerable, " Duration: ", invulnerability_timer)

func _process(delta: float) -> void:
	if is_invulnerable and invulnerability_timer > 0.0:
		invulnerability_timer -= delta
		if invulnerability_timer <= 0.0:
			is_invulnerable = false
			entity.set_collision_layer_value(0, true)


func is_currently_invulnerable() -> bool:
	return is_invulnerable