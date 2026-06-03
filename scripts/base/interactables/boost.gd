extends Area3D

@onready var col = $CollisionShape3D
@onready var circle = get_node_or_null("../Circle")
@onready var particles = get_node_or_null("../GPUParticles3D")

var collected := false
# 2GB device assume kar rahe hain
const LOW_END := true

func _ready():
	# physics cost kam
	monitoring = true
	collision_layer = 4   # sirf player layer
	collision_mask = 1
	
	if circle:
		circle.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		circle.visible = true
	
	if particles:
		if LOW_END:
			particles.amount = 12          # default 50-100 hota hai
			particles.lifetime = 0.35
			particles.preprocess = 0
			particles.speed_scale = 1.3
			particles.visibility_aabb = AABB(Vector3(-2,-2,-2), Vector3(4,4,4))
		particles.emitting = true

func _on_body_entered(body: Node3D) -> void:
	if collected or not body.has_method("apply_boost"):
		return
	
	collected = true
	# turant band, warna ball phas ke baar-baar trigger hoga
	set_deferred("monitoring", false)
	col.set_deferred("disabled", true)
	
	body.call_deferred("apply_boost")
	
	# material toggle mat karo — sirf hide, 0 cost
	if particles:
		particles.emitting = false
	if circle:
		circle.visible = false

func respawn_boost():
	collected = false
	col.disabled = false
	set_deferred("monitoring", true)
	
	if circle:
		circle.visible = true
	if particles:
		particles.restart()
		particles.emitting = true
