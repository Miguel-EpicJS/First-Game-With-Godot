extends KinematicBody2D #impotando a casse KinematicBody2D

var motion = Vector2()#Variavel de movimento

func _physics_process(delta):#delta são os FPS
	if Input.is_action_pressed("ui_right"):#verificação da seta direita
		
		motion.x = 100#movimento
		move_and_slide(motion)
	if Input.is_action_pressed("ui_left"):#verificação da seta esquerda

		motion.x = -100#movimento
		move_and_slide(motion)
	if Input.is_action_pressed("ui_down"):#verificação da seta baixo

		motion.y = 100#movimento
		move_and_slide(motion)
	if Input.is_action_pressed("ui_up"):#verificação da seta cima
	
		
		motion.y = -100#movimento
		move_and_slide(motion)
	motion.y = 0
	motion.x = 0
