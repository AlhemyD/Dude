extends Area2D

@onready var sprite = get_node("Sprite2D")
@onready var animation_player = get_node("AnimationPlayer")
@onready var particles = get_node("CPUParticles2D")

var animation_finished = true
var player_in = false
var player_body

func _ready():
	particles.visible = false

func _process(_delta: float) -> void:
	if player_in:
		particles.visible = true
		animation_player.play("trapped")
		if sprite.frame >=5:
			apply_force()

func apply_force():
	var direction = player_body.position.direction_to(global_position)
	player_body.velocity += direction.normalized() * -10

func _on_body_entered(_body: CharacterBody2D) -> void:
	player_body = _body
	player_in = true

func _on_body_exited(_body: CharacterBody2D) -> void:
	player_in = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "trapped":
		if not player_in:
			particles.visible = false
