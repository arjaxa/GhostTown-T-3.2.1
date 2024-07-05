extends "ScrollMovement.gd"

func _physics_process(delta):
	move()


func _on_EffectDamage_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("killplayer")
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #to free up space after exiting scene
