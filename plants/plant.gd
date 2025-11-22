class_name Plant  # <--- BEST PRACTICE: Gives your node a strict type
extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var area_2d = $Area2D

@export var growth_time_minutes: float = 0.05 
@export var max_growth_stage: int = 3 

var current_stage: int = 0
var growth_timer: Timer
var is_harvestable: bool = false

func _ready():
	# 1. Visual Setup
	if animated_sprite:
		animated_sprite.pause()
		animated_sprite.frame = current_stage
	
	# 2. Timer Setup
	growth_timer = Timer.new()
	add_child(growth_timer)
	growth_timer.wait_time = growth_time_minutes * 60.0
	growth_timer.one_shot = false
	growth_timer.timeout.connect(_on_growth_timer_timeout)
	growth_timer.start()
	
	# 3. Interaction Setup
	if area_2d:
		area_2d.body_entered.connect(_on_body_entered)

	# 4. SUBSCRIBE TO GLOBAL TIME (The Godot Way)
	# Connects the GlobalTime signal to our local function.
	# If this plant is deleted, Godot automatically removes this connection.
	GlobalTime.day_night_changed.connect(_on_day_night_changed)
	
	# 5. INSTANT SYNC
	# Manually call the update once so the plant knows the time *right now*
	_on_day_night_changed(GlobalTime.is_day)

func _on_day_night_changed(is_day_now: bool):
	# This runs whenever the GlobalTime signal emits
	if is_day_now:
		growth_timer.paused = false
		modulate = Color(1, 1, 1, 1) # Normal Color
		# Only print if you really need to debug, saves console spam
		# print("Plant: Waking up")
	else:
		growth_timer.paused = true
		modulate = Color(0.5, 0.5, 0.8, 1) # Night Tint
		# print("Plant: Sleeping")

func _on_growth_timer_timeout():
	if current_stage < max_growth_stage:
		grow_plant()
	else:
		growth_timer.stop()

func grow_plant():
	current_stage += 1
	if animated_sprite:
		animated_sprite.frame = current_stage
	
	if current_stage == max_growth_stage:
		_make_harvestable()

func _make_harvestable():
	is_harvestable = true

func _on_body_entered(body):
	# Best Practice: Check if the body is actually the player!
	# Assuming your player node is named "Player" or is in a group named "player"
	if is_harvestable: # and body.name == "Player":
		print("Harvested!")
		queue_free()
