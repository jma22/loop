class_name HPDisplay
extends ProgressBar


func process_change(health: HealthComponent.HealthDelta) -> void:
	self.max_value = health.max_health
	self.value = health.current_health

func init_health(health: HealthComponent.HealthDelta) -> void:
	self.max_value = health.max_health
	self.value = health.current_health