extends Camera2D

@export var playerTarget: CharacterBody2D

func _ready() -> void:
	playerTarget = $"../CanvasGroup/player_car"

func _process(delta: float) -> void:
	position = playerTarget.position
