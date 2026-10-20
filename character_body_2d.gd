extends CharacterBody2D


const SPEED = 300.0 

# spped it constatnt means it 's value will not change



func _physics_process(_delta: float) -> void: #void id used that's mean it will return nothing.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
