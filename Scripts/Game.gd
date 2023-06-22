extends Node2D

var points=0

func _ready():
	pass

func _physics_process(delta):
	$Score.text=str(points)
	
func _on_Timer_timeout():
	get_tree().reload_current_scene()
