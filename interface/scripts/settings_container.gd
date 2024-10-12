extends ColorRect
class_name SettingsContainer

var _world_enviroment: WorldEnvironment = null

@export_category("Objects")
@export var _fps: ColorRect = null

func _ready() -> void:
	_world_enviroment = get_tree().get_nodes_in_group("enviroment")[0]
	
	for _bttn in get_tree().get_nodes_in_group("options_button"):
		if _bttn is CheckBox:
			_bttn.pressed.connect(_on_button_pressed.bind(_bttn))
		
		if _bttn is OptionButton:
			_bttn.item_selected.connect(_on_button_selected.bind(_bttn))
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		visible = not visible
		get_tree().paused = not get_tree().paused
		
		if visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			return
		
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_button_pressed(_button: CheckBox) -> void:
	var _parent: HBoxContainer = _button.get_parent().get_parent()
	var _text_property: String = _parent.name.to_snake_case()
	
	match _text_property:
		"use_taa":
			get_viewport().use_taa = _button.button_pressed
		"display_fps":
			_fps.visible = _button.button_pressed
		"ssr_enabled":
			_world_enviroment.environment.ssr_enabled = _button.button_pressed
		"ssao_enabled":
			_world_enviroment.environment.ssao_enabled = _button.button_pressed
		"ssil_enabled":
			_world_enviroment.environment.ssil_enabled = _button.button_pressed
		"sdfgi_enabled":
			_world_enviroment.environment.sdfgi_enabled = _button.button_pressed
	
	_button.release_focus()

func _on_button_selected(_button_index: int, _button: OptionButton) -> void:
	var _parent: HBoxContainer = _button.get_parent().get_parent()
	var _text_property: String = _parent.name.to_snake_case()
	
	match _text_property:
		"msaa_3d":
			_update_msaa_3d(_button_index)
		
		"screen_space_aa":
			_update_screen_space_aa(_button_index)
			
	_button.release_focus()
	
func _update_msaa_3d(_index: int) -> void:
	var _viewport: Viewport = get_viewport()
	
	match _index:
		0:
			_viewport.msaa_3d = Viewport.MSAA_DISABLED
		1:
			_viewport.msaa_3d = Viewport.MSAA_2X
		2:
			_viewport.msaa_3d = Viewport.MSAA_4X
		3:
			_viewport.msaa_3d = Viewport.MSAA_8X


func _update_screen_space_aa(_index: int) -> void:
	var _viewport: Viewport = get_viewport()
	
	match _index:
		0:
			_viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		1:
			_viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
