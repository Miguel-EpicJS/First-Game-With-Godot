extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 50
const FRICTION = 500

enum{
	MOVE,
	ROLL,
	ATTACK
}

var speed = Vector2.ZERO

var state = MOVE

onready var animationPlayer = $AnimationPlayer

onready var animationTree = $AnimationTree

onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)

func move_state(delta):
		
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		speed = speed.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		speed = speed.move_toward(Vector2.ZERO, FRICTION * delta)
	
	speed = move_and_slide(speed)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
