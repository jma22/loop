extends Node2D

class_name PickupSpawner
@export var pickup_scene: PackedScene


func spawn_pickup(position: Vector2) -> void:
	var pickup_instance = pickup_scene.instantiate()
	# Parent to the scene root, not the circle, so pickups don't follow its movement.
	(owner if owner else get_tree().current_scene).add_child(pickup_instance)
	pickup_instance.global_position = position
	pickup_instance.launch(Vector2(10,10))
