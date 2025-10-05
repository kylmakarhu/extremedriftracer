# скрипт движения машины
# сделано:
# движение вперед/назад и расчет скорости
# остановка машины, когда игрок не нажимает на кнопку газа
# сделать:
# повороты и движение по оси Y
# дрифт
# разница между моделями (в целом, можно просто сделать объект для каждой машины и подгружать характеристики с них)
extends CharacterBody2D

class_name Player

var accelRate = 100
var brakeRate = -100
var maxSpeed = 250
var maxSteer = 15
var deccelRate = 25
var isAutoAccelOn = false

var acceleration: Vector2 = Vector2.ZERO
var steeringDirection
 
func _physics_process(delta: float) -> void:
	# расчет скорости (когда ускорение равно нулю -> остановка)
	if acceleration != Vector2.ZERO or acceleration < Vector2.ZERO:
		velocity = velocity.move_toward(Vector2(maxSpeed, 0), acceleration.x * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deccelRate)
	# встроенная в годот функция движения CharacterBody2D
	move_and_slide()

func _process(delta: float) -> void:
	pass
	# для автогаза (макс пока сказал не надо)
	#match isAutoAccelOn:
		#true:
			#if !Input.is_action_pressed("ui_down"):
				#acceleration = transform.x * accelRate
	
func _input(event: InputEvent) -> void:
	# расчет поворота (тут нужна будет помощь, потому что я не умею немного в физику)
	var turn = Input.get_axis("ui_left", "ui_right")
	steeringDirection = turn * deg_to_rad(maxSteer)
	
	# расчет ускорения вперед (матч/свитч кейс тут на случай автогаза)
	match isAutoAccelOn:
		false:
			if Input.is_action_pressed("ui_accept") and !Input.is_action_pressed("ui_down"):
				acceleration = transform.x * accelRate
	
	# расчет ускорения назад
	if Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_accept"):
				acceleration = transform.x * brakeRate
	
	# обнуление ускорения, когда игрок отпускает кнопку газа/тормоза
	if acceleration != Vector2.ZERO and !Input.is_anything_pressed():
		acceleration = acceleration.move_toward(Vector2.ZERO, 100)
	


# это для кнопки включения автогаза
#func _on_check_button_toggled(toggled_on: bool) -> void:
	#isAutoAccelOn = toggled_on
	#print(isAutoAccelOn)
