class_name InputBuffer

const BUFFER_WINDOW : float = 0.3
var _buffered_action : StringName = &""
var _buffer_timer : float = 0.0




func tick_buffer(delta : float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        _buffered_action = &"atk"
        _buffer_timer = BUFFER_WINDOW

        
    if _buffer_timer > 0.0:
        _buffer_timer -= delta
        if _buffer_timer <= 0.0:
            _buffered_action = &""


func consume_buffer(action: StringName) -> bool:
    if _buffered_action == action:
        _buffered_action = &""
        _buffer_timer = 0.0
        return true
    return false