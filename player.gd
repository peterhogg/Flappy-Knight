extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0

var isJumping = false
var isDead = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var deadgravity = gravity * 1.5
@onready var animator = $AnimatedSprite2D;

signal died

func _physics_process(delta):
	# Add the gravity.
	if(isDead):
		velocity.y += deadgravity * delta
	else:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") && !isJumping && !isDead:
		isJumping = true
		animator.play("jump")
		velocity.y = JUMP_VELOCITY
	

	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	isJumping = false
	animator.play("falling")


func _on_visible_on_screen_enabler_2d_screen_exited():
	died.emit()
	pass # Replace with function body.
