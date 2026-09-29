class_name HitBox
extends Area2D

# signal hit_registered

@export var owner_entity: Node2D
@export var hit_box_type: HitBoxType = HitBoxType.HIT_PLAYER
@export var damage: int = 1
@export var sprite : Sprite2D
# @export var hitstop : HitStop

@export var start_active: bool = false
@export var knockback_right : bool = true
var is_active: bool = false

enum HitBoxType {
	HIT_PLAYER,
	HIT_ENEMY
}

func _ready() -> void:
	set_active(start_active)
	set_collision_masks()
	area_entered.connect(_on_area_entered)
	# if sprite3D:
		# sprite3D.visible = false

func set_damage(damage_amount: int) -> void:
	damage = damage_amount

func set_owner_entity(_owner : Node2D) -> void:
	self.owner_entity = _owner

func set_active(active: bool) -> void:
	print("Hitbox Setting active: ", active)
	self.set_deferred("monitoring", active)
	## show visible
	# if sprite3D:
	# 	sprite3D.visible = active
	if sprite:
		sprite.visible = active
	is_active = active


func _on_area_entered(area: Area2D) -> void:
	print("Area entered: ", area)
	if not is_active:
		return
	if area is HurtBox:
		var collision := Collision.create_collision(self, area as HurtBox)
		collision.resolve()
		
# func hitbox_on_hit() -> void:
# 	if owner_entity and owner_entity.has_method("on_hitbox_hit"):
# 		owner_entity.on_hitbox_hit()

	# if hitstop:
	# 	hitstop.start_hitstop(0.1)

func get_owner_entity() -> Node2D:
	return owner_entity

func get_damage() -> int:
	return damage

func set_collision_masks() -> void:
	match hit_box_type:
		HitBoxType.HIT_PLAYER:
			# collision_layer = 1
			collision_mask = 1
		HitBoxType.HIT_ENEMY:
			# collision_layer = 2
			collision_mask = 2
