class_name Collision extends RefCounted

var hitbox: HitBox
var hurtbox: HurtBox
var particle_scene: PackedScene = preload("res://particle.tscn")


static func create_collision(hitbox_: HitBox, hurtbox_: HurtBox) -> Collision:
	var collision := Collision.new()
	collision.hitbox = hitbox_
	collision.hurtbox = hurtbox_
	return collision


func resolve() -> void:
	# hitbox.get_owner_entity().on_hitbox_hit()
	var damage : int = hitbox.get_damage()
	var knockback_right : bool = hitbox.knockback_right
	var knockback_direction : Vector2 = Vector2.RIGHT if knockback_right else Vector2.LEFT

	var midpoint : Vector2 = (hitbox.get_owner_entity().global_position + hurtbox.get_owner_entity().global_position) / 2
	var particle_instance : Node2D = particle_scene.instantiate() as Node2D
	particle_instance.global_position = midpoint
	hitbox.get_tree().current_scene.add_child(particle_instance)
	particle_instance.get_child(0).restart()
	

	print(hitbox.get_owner_entity())
	hitbox.get_owner_entity().knockback_component.receive_knockback(knockback_direction , 1.0)
	hurtbox.get_owner_entity().take_damage(damage)
	hurtbox.get_owner_entity().enter_hurt_state()

	await particle_instance.get_child(0).finished
	particle_instance.queue_free()
	

	
