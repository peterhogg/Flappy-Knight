extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0

var isJumping = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animator = $AnimatedSprite2D;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") && !isJumping:
		isJumping = true
		animator.play("jump")
		velocity.y = JUMP_VELOCITY
	

	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	isJumping = false
	animator.play("falling")
