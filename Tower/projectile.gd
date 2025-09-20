extends Area3D

## Relative projectile direction
@export var direction := Vector3.FORWARD
## Speed of projectile
@export var speed := 30.0
## Damage per induvidual projectile
@export var damage := 30

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group('enemy_area'):
		area.get_parent().current_health -= damage
		queue_free()
