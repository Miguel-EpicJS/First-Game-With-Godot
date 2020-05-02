extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		
		var GrassEffect = load("res://Scenes/GrassEffect.tscn")
		
		var grassEffect = GrassEffect.instance()
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position
		
		queue_free()
