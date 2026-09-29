class_name Collision extends RefCounted

var hitbox: HitBox
var hurtbox: HurtBox

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

	print(hitbox.get_owner_entity())
	hitbox.get_owner_entity().knockback_component.receive_knockback(knockback_direction , 1.0)
	hurtbox.get_owner_entity().take_damage(damage)
	hurtbox.get_owner_entity().enter_hurt_state()
