extends CharacterBody2D


const SPEED = 25
@export var hook_speed:= 1000.0
var topSpeed = 200
var pulling:= false
var direction:= 3
var casted:= false
var pulling_pos: Vector2

func _physics_process(delta: float) -> void:
	$Trail.set_point_position(0, Vector2(0,0))
	if not pulling:
		$Trail.set_point_position(1, $hookshot.position)
	#print($hookshot/Trail.points[0])
	if pulling:
		match direction:
			0:
				velocity.y = -hook_speed
			1:
				velocity.y = hook_speed
			2:
				velocity.x = -hook_speed
			3:
				velocity.x = hook_speed
	
	if self.velocity.x > 0  and not pulling:
		if self.velocity.x > topSpeed:
			self.velocity.x = topSpeed
	if self.velocity.x < 0 and not pulling:
		if self.velocity.x < -topSpeed:
			self.velocity.x = -topSpeed

	if self.velocity.y > 0  and not pulling:
		if self.velocity.y > topSpeed:
			self.velocity.y = topSpeed
	if self.velocity.y < 0 and not pulling:
		if self.velocity.y < -topSpeed:
			self.velocity.y = -topSpeed

	if Input.is_action_pressed("Up Button") and not casted and not pulling:
		self.velocity.y -= SPEED
		$Sprite2D.frame = 1
		$Sprite2D.flip_v = false
		direction = 0
	elif Input.is_action_just_released("Up Button"):
		stop()


	if Input.is_action_pressed("Down Button") and not casted and not pulling:
		self.velocity.y += SPEED
		$Sprite2D.frame = 1
		$Sprite2D.flip_v = true
		direction = 1
	elif Input.is_action_just_released("Down Button"):
		stop()

	if Input.is_action_pressed("Left button") and not casted and not pulling:
		self.velocity.x -= SPEED
		$Sprite2D.frame = 0
		$Sprite2D.flip_h = true
		direction = 2
	elif Input.is_action_just_released("Left button"):
		stop()

	if Input.is_action_pressed("Right button") and not casted and not pulling:
		self.velocity.x += SPEED
		$Sprite2D.frame = 0
		$Sprite2D.flip_h = false
		direction = 3
	elif Input.is_action_just_released("Right button"):
		stop()
	
	if Input.is_action_just_pressed("hookshot") and not casted and not pulling:
		casted = true
		hookshot()
	move_and_slide()

func stop():
	self.velocity = Vector2(0,0)

func hookshot():
	#$hookshot/Hand.visible = true
	$Trail.visible = true
	$hookshot/Timer.start()
	$cast.play()
	match direction:
		0: #Up
			$hookshot.cast(direction)
		1: # Down
			$hookshot.cast(direction)
		2: # Left
			$hookshot.cast(direction)
		3: # Right
			$hookshot.cast(direction)


func _on_hit_detection_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		$hit.play()
		pull(body.global_position)
		$hookshot.direction = Vector2(0,0)
		$Trail.set_point_position(1, body.global_position)
		$hookshot.global_position = global_position
	
func pull(pos: Vector2):
	$pull.play()
	pulling = true
	casted = false
	pulling_pos = pos

	

func _on_timer_timeout() -> void:
	$hookshot.direction = Vector2(0,0)
	$hookshot.global_position = global_position
	casted = false


func _on_wall_detection_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		pulling = false
		#$hookshot/Hand.visible = false
		$Trail.visible = false
