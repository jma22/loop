class_name HPDisplay
extends ProgressBar


func process_change(health: Delta) -> void:
	self.max_value = health.max_health
	self.value = health.current_health

func init_health(health: Delta) -> void:
	self.max_value = health.max_health
	self.value = health.current_health