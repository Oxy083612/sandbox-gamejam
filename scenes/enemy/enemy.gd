extends CharacterBody2D

@export var target: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 80

func _physics_process(delta: float) -> void:
	if target == null:
		return

	var distance = global_position.distance_to(target.global_position)
	
	if distance < 300:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed

		if velocity.x > 0:
			sprite.flip_h = true
			sprite.play("walk")
		else:
			sprite.flip_h = false
			sprite.play("walk")
			

	move_and_slide()
