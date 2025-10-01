extends CharacterBody2D

var accelRate = 100
var brakeRate = -100
var maxSpeed = 7.0
var maxSteer = 15

var acceleration: Vector2 = Vector2.ZERO
var steeringDirection
 
func _physics_process(delta: float) -> void:
	velocity += acceleration * delta
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	var turn = Input.get_axis("ui_left", "ui_right")
	steeringDirection = turn * deg_to_rad(maxSteer)
	
	if Input.is_action_pressed("ui_up"):
		acceleration = transform.x * accelRate
		
	if Input.is_action_pressed("ui_accept"):
		if acceleration < Vector2.ZERO:
			acceleration = Vector2.ZERO
			
	if Input.is_action_pressed("ui_down"):
		acceleration = transform.x * brakeRate
		
	
