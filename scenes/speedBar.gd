# этот скрипт контроллирует спидометр и его поведение, наверное вид спидометра еще поменяется (на более реалистичный),
# но в целом пока для вида так сделан
extends ProgressBar

class_name speedBar

var playerData: Player
var progressBar: ProgressBar
var halfV: float 
var styleBox_fill

func _ready() -> void:
	playerData = $"../../CanvasGroup/player_car"
	progressBar = $"."
	# максимальное значение спидометра
	progressBar.max_value = 500
	# тут скрипт берет стиль ПрогрессБара, чтоб менять цвета
	styleBox_fill = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", styleBox_fill)
	# половина от максимальной скорости машины
	halfV = lerpf(0, playerData.maxSpeed, 0.5 )

func _process(delta: float) -> void:
	# значение прогрессбара меняется в зависимости от скорости машины (пока она по оси Х смотрит,
	# я потом посмотрю как в целом значение передать)
	progressBar.value = playerData.velocity.x
	# тут подбор цвета в зависимости от значения скорости (если можно как-то получше оптимизировать,
	# то будет хорошо, чтоб помогли)
	if progressBar.value < halfV:
		changeBarColor(0)
	else:
		if progressBar.value != playerData.maxSpeed:
			changeBarColor(1)
		else:
			changeBarColor(2)
		

# функция смены цвета по значению скорости
func changeBarColor(val: int) -> void:
	match val:
		# значение меньше половины максимальной скорости
		0:
			styleBox_fill.bg_color = Color("#00ff5d")
		# значение ровно половины максимальной скорости
		1:
			styleBox_fill.bg_color = Color("#ffcd00")
		# значение ровно максимальной скорости
		2:
			styleBox_fill.bg_color = Color("#ff1d00")
			
