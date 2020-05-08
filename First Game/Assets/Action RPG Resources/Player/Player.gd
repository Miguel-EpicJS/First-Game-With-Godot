extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 50
export var FRICTION = 500
export var ROLL_SPEED = 110
enum{
	MOVE,
	ROLL,
	ATTACK
}

var speed = Vector2.ZERO

var roll_vector = Vector2.UP

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox

func _ready():
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
		
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		
		roll_vector = input_vector
		
		swordHitbox.knockback_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		speed = speed.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationState.travel("Idle")
		speed = speed.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func attack_state(delta):
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

func roll_state(delta):
	speed = roll_vector  * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func roll_animation_finished():
	speed = speed * 0.8
	state = MOVE
	
func move():
	speed = move_and_slide(speed)
