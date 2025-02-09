extends Node2D

const SPEED = -100

func _process(delta):
	move_local_x(delta * SPEED)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
