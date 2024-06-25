extends KinematicBody2D


var movingup
var velocity = Vector2()
var moveSpeed = 850
onready var particles2d = $CPUParticles2D
onready var timer = $Timer
var score = 0
var time_passed = 0
var score_interval = 0.1 #increment score every 1 sec
var player_alive = true #assume player is alive

func _ready():
	
	movingup = true
	particles2d.visible = false
	Signals.connect("killplayer",self,"killplayer")
	#timer.connect("timeout",self,"_on_Timer_timeout")



func get_input():
	if Input.is_action_pressed("moveDOWN"):
		movingup = true
		velocity.y = moveSpeed
		
		
	elif Input.is_action_pressed("moveUP"):
		movingup = false
		velocity.y = -moveSpeed
	else:
		velocity.y = 0

func _on_PlayerQuit():
	player_alive = false

func _physics_process(delta):
	if player_alive:
		time_passed += delta
		if time_passed >= score_interval:
			score += 1
			Signals.emit_signal("updatescore",score)
			print("Score:",score)
			time_passed = 0
	get_input()
	move_and_slide(velocity)
	if Input.is_action_pressed("moveDOWN"):
		particles2d.visible = true
		timer.start(1) #turn off particles after 1 second
	elif Input.is_action_pressed("moveUP"):
		particles2d.visible = true
		timer.start(1)



func _on_Timer_timeout():
	particles2d.visible = false

func killplayer():
	queue_free()
	

