extends Node2D

@export var pickup_radius : float = 8.0
@export var juice_amount : int = 1

var rigid_body : RigidBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rigid_body = $RigidBody2D
	rigid_body.set_collision_layer_value(1, false)
	rigid_body.set_collision_layer_value(16, false)
	rigid_body.set_collision_layer_value(15, true)


func _physics_process(_delta: float) -> void:
	var player : Node2D = Globals.player
	if not player:
		return
	# print(rigid_body.global_position.distance_to(player.global_position))
	if rigid_body.global_position.distance_to(player.global_position) <= pickup_radius:
		player.juice_component.gain_health(juice_amount)
		queue_free()


func launch(velocity: Vector2) -> void:
	rigid_body.linear_velocity = velocity
