extends CharacterBody2D
@export var speed:= 1000.0
@export var out_time:= 0.5
var direction = Vector2(0,0)
var hit_pos: Vector2
func cast(dir: int):
	match dir:
		0:
			direction = Vector2(0,-1)
			$Timer.start(out_time)
		1:
			direction = Vector2(0,1)
		2:
			direction = Vector2(-1,0)
		3:
			direction = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()
