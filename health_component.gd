extends Node2D
class_name HealthComponent

@export var hp_display: HPDisplay

class HealthDelta:
	var max_health: int
	var current_health: int
	var delta: int
	func _init(_max_health: int, _current_health: int, _delta: int) -> void:
		max_health = _max_health
		current_health = _current_health
		delta = _delta


var max_health: int
var current_health: int
var entity : Node2D

func setup(_max_health: int, entity: Node2D) -> void:
	self.max_health = _max_health
	self.entity = entity
	current_health = max_health
	reset()

# func link_player_health(hud: HUD) -> void:
# 	self.hp_display = hud.hp_display
# 	self.hp_display.refresh_hp(current_health)

	
func reset() -> void:
	current_health = max_health
	if hp_display:  
		hp_display.init_health(HealthDelta.new(max_health, current_health, 0))


func take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		current_health = 0
	if hp_display:
		hp_display.process_change(HealthDelta.new(max_health, current_health, -damage))

func gain_health(amount: int) -> void:
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	if hp_display:
		hp_display.process_change(HealthDelta.new(max_health, current_health, amount))

func set_max_health(new_max: int) -> void:
	max_health = new_max
	# if current_health > max_health:
	# 	current_health = max_health
	# if hp_display:
	# 	hp_display.set_max_hp(max_health)
	# 	hp_display.refresh_hp(current_health)

func is_dead() -> bool:
	return current_health <= 0
	
