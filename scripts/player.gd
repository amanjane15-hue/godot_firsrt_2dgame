extends CharacterBody2D

const SPEED = 300.0
const BIRD_SCALE = Vector2(1.0, 1.0)

@onready var crash_sound: AudioStreamPlayer2D = $CrashSound
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var death_particles: CPUParticles2D = $DeathParticles

var is_dead: bool = false

@export var game_ui: Control


func _ready() -> void:
	# Keep the bird at its original scale.
	animated_sprite.scale = BIRD_SCALE
	animated_sprite.rotation_degrees = 0.0

	# Start the flying animation.
	animated_sprite.play("Fly")

	# Find the game UI if it wasn't assigned in the Inspector.
	if not game_ui:
		game_ui = get_node_or_null("/root/Main/UI/GameUI") as Control


func _physics_process(_delta: float) -> void:
	if is_dead:
		return

	# Read movement input.
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	# Move the bird in four directions.
	velocity = direction * SPEED
	move_and_slide()

	# Keep the flying animation playing.
	if not animated_sprite.is_playing():
		animated_sprite.play("Fly")

	# Flip the bird when moving horizontally.
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false

	# Detect collisions with cars.
	for i in range(get_slide_collision_count()):
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Object = collision.get_collider()

		if collider and collider.is_in_group("car"):
			die()
			break


func die() -> void:
	if is_dead:
		return

	is_dead = true

	# Stop the player's movement.
	velocity = Vector2.ZERO

	# Disable collisions.
	collision_shape.set_deferred("disabled", true)

	# Play the crash sound.
	crash_sound.play()

	# Hide the bird.
	animated_sprite.visible = false

	# Play death particles.
	death_particles.emitting = true

	# Wait for the sound to finish before restarting.
	if crash_sound.stream:
		await crash_sound.finished
	else:
		await get_tree().create_timer(1.0).timeout

	# Restart the current level.
	get_tree().reload_current_scene()
