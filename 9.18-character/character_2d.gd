extends CharacterBody2D


const SPEED = 25
var topSpeed = 200

func _physics_process(delta: float) -> void:
	pass

	if self.velocity.x > 0 :
		if self.velocity.x > topSpeed:
			self.velocity.x = topSpeed
	if self.velocity.x < 0:
		if self.velocity.x < -topSpeed:
			self.velocity.x = -topSpeed

	if self.velocity.y > 0 :
		if self.velocity.y > topSpeed:
			self.velocity.y = topSpeed
	if self.velocity.y < 0:
		if self.velocity.y < -topSpeed:
			self.velocity.y = -topSpeed

	if Input.is_action_pressed("Up Button"):
		self.velocity.y -= SPEED
		$Sprite2D.frame = 1
		$Sprite2D.flip_v = false
	elif Input.is_action_just_released("Up Button"):
		stop()


	if Input.is_action_pressed("Down Button"):
		self.velocity.y += SPEED
		$Sprite2D.frame = 1
		$Sprite2D.flip_v = true
	elif Input.is_action_just_released("Down Button"):
		stop()

	if Input.is_action_pressed("Left button"):
		self.velocity.x -= SPEED
		$Sprite2D.frame = 0
		$Sprite2D.flip_h = true
	elif Input.is_action_just_released("Left button"):
		stop()

	if Input.is_action_pressed("Right button"):
		self.velocity.x += SPEED
		$Sprite2D.frame = 0
		$Sprite2D.flip_h = false
	elif Input.is_action_just_released("Right button"):
		stop()
	move_and_slide()

func stop():
	self.velocity = Vector2(0,0)
