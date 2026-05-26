extends RigidBody3D


@onready var ground_ray: RayCast3D = $RayCast3D
@onready var ground_ray2: RayCast3D = $RayCast3D2
@onready var water_ripple: GPUParticles3D = $RayCast3D2/WaterRipple
@onready var water_droplets: GPUParticles3D = $WaterDroplets
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var trail: GPUTrail3D = $RayCast3D/GPUTrail3D

var spawn_position
var respawn_cooldown : float = 1.5
var rotate_speed : float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_position = global_position
	
	apply_equipped_skin()
	apply_equipped_trail()


func apply_equipped_skin():
	var ball_skin = CosmeticsManager.get_equipped_skin()
	var ball_matr = mesh.get_active_material(0) as StandardMaterial3D
	
	if ball_matr:
		ball_matr.albedo_texture = ball_skin["texture"]


func apply_equipped_trail():
	var trail_data = CosmeticsManager.get_equipped_trail()

	trail.texture = trail_data.texture
	trail.color_ramp = trail_data.color_ramp


func respawn():
	global_position = spawn_position


func _physics_process(delta: float) -> void:
	mesh.rotate_x(-deg_to_rad(rotate_speed) * delta)
	
	ground_ray2.global_rotation = Vector3.ZERO
	
	if position.y < 0.0:
		water_droplets.emitting = true
		water_ripple.emitting = true
			
		await get_tree().create_timer(respawn_cooldown).timeout
		respawn()
