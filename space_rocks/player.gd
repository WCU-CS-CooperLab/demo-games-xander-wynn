extends RigidBody2D

@export var engine_power = 500
@export var spin_power = 8000
var thrust = Vector2.ZERO
var rotation_dir = 0

enum player_state {INIT, ALIVE, INVULNERABLE, DEAD}
var state = INIT
const INIT = 0
const ALIVE = 1
const INVULNERABLE = 2
const DEAD = 3

func _ready():
	change_state(ALIVE)
	
func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled",
				true)
		ALIVE:
			$CollisionShape2D.set_deferred("disabled",
				false)
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled",
				true)
		DEAD:
			$CollisionShape2D.set_deferred("disabled",
				true)
	state = new_state
			
func _process(delta):
		get_input()
		
func get_input():
		thrust = Vector2.ZERO
		if state in [DEAD, INIT]:
				return
		if Input.is_action_pressed("thrust"):
			thrust = transform.x * engine_power
		rotation_dir = Input.get_axis("rotate_left",
		"rotate_right")
		
func _physics_process(delta):
	constant_force = thrust
	constant_torque = rotation_dir * spin_power
		