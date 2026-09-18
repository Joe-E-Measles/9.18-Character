extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Move up"):
		self.position.y -=10
	if Input.is_action_pressed("Move down"):
		self.position.y +=10
	if Input.is_action_pressed("Move left"):
		self.position.x +=-10
	if Input.is_action_pressed("Move Right"):
		self.position.x +=-10
