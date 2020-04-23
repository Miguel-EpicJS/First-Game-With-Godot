extends KinematicBody2D

var motion = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		
		motion.x = 100
		move_and_slide(motion)
	if Input.is_action_pressed("ui_left"):

		motion.x = -100
		move_and_slide(motion)
	if Input.is_action_pressed("ui_down"):

		motion.y = 100
		move_and_slide(motion)
	if Input.is_action_pressed("ui_up"):
		
		motion.y = -100
		move_and_slide(motion)
	motion.y = 0
	motion.x = 0
