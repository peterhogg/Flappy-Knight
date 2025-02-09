extends Node2D

const SPEED = -100

signal passed

signal died

func _process(delta):
	move_local_x(delta * SPEED)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_area_2d_body_exited(body):
	passed.emit()


func _on_area_2d_body_entered(body):
	died.emit()
	pass # Replace with function body.
