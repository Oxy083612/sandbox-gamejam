extends CharacterBody2D

@export var target: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_intake: Timer = $damage_intake

var speed = 80
var health = 25
var player_in_attack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	if target == null:
		return

	deal_with_damage()

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

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = false
		
func deal_with_damage():
	if player_in_attack_zone and Combat.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			damage_intake.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()


func _on_damage_intake_timeout() -> void:
	can_take_damage = true
