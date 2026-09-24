class_name Hitbox
extends Area3D

# signal hit_registered

@export var owner_entity: Node3D
@export var hit_box_type: HitBoxType = HitBoxType.HIT_PLAYER
@export var damage: int = 1
# @export var hitstop : HitStop

var is_active: bool = false

enum HitBoxType {
	HIT_PLAYER,
	HIT_ENEMY
}

func _ready() -> void:
	set_collision_masks()
	set_active(false)
	# if sprite3D:
		# sprite3D.visible = false

func set_damage(damage_amount: int) -> void:
	damage = damage_amount

func set_owner_entity(_owner : Node3D) -> void:
	self.owner_entity = _owner

func set_active(active: bool) -> void:
	self.set_deferred("monitoring", active)
	## show visible
	# if sprite3D:
	# 	sprite3D.visible = active
	is_active = active


func _on_area_entered(area: Area3D) -> void:
	if not is_active:
		return
	if area is Hitbox:
		var collision := Collision.create_collision(area as Hitbox, self)
		collision.resolve()
        
# func hitbox_on_hit() -> void:
# 	if owner_entity and owner_entity.has_method("on_hitbox_hit"):
# 		owner_entity.on_hitbox_hit()

	# if hitstop:
	# 	hitstop.start_hitstop(0.1)

func get_owner_entity() -> Node3D:
	return owner_entity

func set_collision_masks() -> void:
	match hit_box_type:
		HitBoxType.HIT_PLAYER:
			# collision_layer = 1
			collision_mask = 1
		HitBoxType.HIT_ENEMY:
			# collision_layer = 2
			collision_mask = 2

func activate_hitbox() -> void:
	set_active(true)

func deactivate_hitbox() -> void:
	set_active(false)