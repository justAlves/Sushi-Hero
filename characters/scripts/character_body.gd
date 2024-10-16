extends Node3D

const _LERP_VELOCITY: float = 0.15

@export_category("Objects")
@export var _character: CharacterBody3D = null
@export var _animation: AnimationPlayer = null

func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp_angle(
		rotation.y, 
		atan2(-_velocity.x, -_velocity.z),
		_LERP_VELOCITY
	)


func animate(_velocity: Vector3) -> void:
	if _velocity:
		if _character.is_running():
			_animation.play("Run")
			return
			
		_animation.play("Walk")
		return
	
	_animation.play("Idle")
