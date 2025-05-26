extends Control
var 贴图
var 贴图_c
var UI文本#显示的文本贴图
var 位置
var 被选择效果
var 数据是否读取完成 = false
var 本体#物体
var 文本#显示的文本
var 父级
var 是否被选择 =false

func _process (delta: float) -> void:
	if 本体 == null :
		queue_free()
	else :

		if 本体.下拉栏状态 == "开" :
			self.position = 位置
			本体.下拉栏按钮.texture = 本体.下拉栏按钮贴图_c
		else :
			self.position = Vector2 ( (0 - self.size.x * 2) - 1280 , (0 - self.size.y * 2) - 720 )
			本体.下拉栏按钮.texture = 本体.下拉栏按钮贴图

		if 父级 == null :
			if 是否被选择 == true :
				self.texture = 贴图_c
			else :
				self.texture = 贴图
		else :
			if 父级.是否被选择 == true :
				self.texture = 贴图_c
			else :
				self.texture = 贴图

	if 数据是否读取完成 == true :
		call_deferred("设置UI")
		数据是否读取完成 = false

func 设置UI ():
	self.texture = 贴图
	mouse_entered.connect (鼠标悬停)
	mouse_exited.connect (鼠标移开)
	gui_input.connect(被左键点击)
	if UI文本 != null :
		文本 = TextureRect.new()
		文本.name = "文本"
		add_child (文本)
		文本.size = self.size
		文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		文本.texture = UI文本


func 鼠标悬停 ():
	是否被选择 = true
	# 可选：播放音效或动画
	# $AudioStreamPlayer.play()

func 鼠标移开 ():
	是否被选择 = false

func 被左键点击(event):
	# 检测鼠标左键点击
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		本体.下拉栏状态 = "关"
		本体.下拉栏选择框可选选项当前的选择 = 被选择效果
