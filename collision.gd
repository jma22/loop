class_name Collision extends RefCounted

var hitbox: Hitbox
var hurtbox: Hurtbox

static func create_collision(hitbox_: Hitbox, hurtbox_: Hurtbox) -> Collision:
	var collision := Collision.new()
	collision.hitbox = hitbox_
	collision.hurtbox = hurtbox_
	return collision


func resolve() -> void:
	hitbox.get_owner_entity().on_hitbox_hit()
	hurtbox.get_owner_entity().on_hurtbox_hit()



