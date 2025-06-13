extends Control

#————————————————————————————————#————————————————————————————————#—————————————#
var ini数据 = []
var 被点击效果 = []
#————————————————————————————————#————————————————————————————————#—————————————#
var UI贴图_原本的贴图
var UI贴图_被触碰的贴图
var UI贴图_文本_原本的贴图
var UI贴图_文本_被触碰的贴图
#————————————————————————————————#————————————————————————————————#—————————————#
var 数据是否读取完成 = false
var UI类型_string
var 布尔按钮状态_bool = true														#请只给下拉选择栏等UI使用
																				#(下拉选择栏按钮，点击开关按钮)
var 物体编号_int = 0																#请只给列表等UI使用
var SltINI
var 按钮被触碰 = false
#————————————————————————————————#————————————————————————————————#—————————————#
var 文本
var 本体																			#请只给下拉选择栏等UI使用
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func _process(delta: float) -> void:
	if 数据是否读取完成 == true :
		call_deferred("设置UI")
		数据是否读取完成 = false

	if UI类型_string == "SelectButton" :											#如果UI类型是 SelectButton
		if 本体.布尔按钮状态_bool == true :										#请只给下拉选择栏等UI使用
			self.texture = UI贴图_原本的贴图
		else :																	#(下拉选择栏按钮，点击开关按钮)
			self.texture = UI贴图_被触碰的贴图
	if UI类型_string == "SltBoxBtn" :
		if 本体.UI类型_string == "SltBoxBtn" :
			if 本体.按钮被触碰 == true:
				self.texture = UI贴图_被触碰的贴图
				if UI贴图_文本_被触碰的贴图 != null && 文本 != null:
					文本.texture = UI贴图_文本_被触碰的贴图
			if 本体.按钮被触碰 == false:
				self.texture = UI贴图_原本的贴图
				if UI贴图_文本_原本的贴图 != null  && 文本 != null:
					文本.texture = UI贴图_文本_原本的贴图
	if UI类型_string == "ListBoxBtn":
		if  本体.当前选择的选项 == 物体编号_int :
			self.texture = UI贴图_被触碰的贴图
			if 文本 != null && UI贴图_文本_被触碰的贴图 != null :
				文本.texture = UI贴图_文本_被触碰的贴图
		else :
			self.texture = UI贴图_原本的贴图
			if 文本 != null && UI贴图_文本_原本的贴图 != null :
				文本.texture = UI贴图_文本_原本的贴图
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 设置UI ():
	if UI类型_string != "SltBoxBtn" && UI类型_string != "ListBoxBtn" && UI类型_string != "ListBoxBtn_Text":
		for i in ini数据.size():													#根据ini设置UI
			var 当前行数_内容_string = ini数据[i].substr (ini数据[i].find ("=") + 1)#提取出当前行数的内容

			if ini数据[i].find ("Texture=") != -1 :								#如果有"Texture="
																				#(修改原本的贴图)
				var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
				var image  = Image.new()										#创建image
				image.load( 文件路径)												#读取贴图
				var texture = ImageTexture.create_from_image(image)				#将image设置为texture
				UI贴图_原本的贴图 = texture										#保存贴图文件到变量
				self.texture = UI贴图_原本的贴图

			if ini数据[i].find ("Texture_c=") != -1 :							#如果有"Texture_c="
																				#(修改被触碰的贴图)
				var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																					#获取文件路径
				var image  = Image.new()											#创建image
				image.load( 文件路径)													#读取贴图
				var texture = ImageTexture.create_from_image(image)					#将image设置为texture
				UI贴图_被触碰的贴图 = texture											#保存贴图文件到变量

			if ini数据[i].find ("Location=") != -1 :									#如果有"Location="
				var 坐标 = Vector2 (float(当前行数_内容_string.substr (0 , 当前行数_内容_string.find (",")  ) ) , 0)
																					#设置X的值
				坐标 = Vector2 (坐标.x , float(当前行数_内容_string.substr (当前行数_内容_string.find (",") +1 ) ) )
																					#设置Y的值
				self.position = 坐标													#设置位置

			if ini数据[i].find ("Size=") != -1 :										#如果有"Size="
				var 大小 = Vector2 (float(当前行数_内容_string.substr (0 , 当前行数_内容_string.find (",")  ) ) , 0)
																					#设置X的值
				大小 = Vector2 (大小.x , float(当前行数_内容_string.substr (当前行数_内容_string.find (",") +1 ) ) )
																					#设置Y的值
				self.size = 大小														#设置位置

			if UI类型_string != "SelectButton" :										#如果UI类型不是SelectButton

				if ini数据[i].find ("Text=") != -1 :									#如果有"Text="
																					#(修改原本的贴图)
					var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																					#获取文件路径
					var image  = Image.new()										#创建image
					image.load( 文件路径)												#读取贴图
					var texture = ImageTexture.create_from_image(image)				#将image设置为texture
					UI贴图_文本_原本的贴图 = texture									#保存贴图文件到变量
					if 文本 == null :
						文本 = TextureRect.new()
						add_child (文本)
					文本.name = "文本"
					文本.size = self.size
					文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
					文本.texture = UI贴图_文本_原本的贴图

				if ini数据[i].find ("Text_c=") != -1 :								#如果有"Text_c="
																					#(修改被触碰的贴图)
					var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																					#获取文件路径
					var image  = Image.new()										#创建image
					image.load( 文件路径)												#读取贴图
					var texture = ImageTexture.create_from_image(image)				#将image设置为texture
					UI贴图_文本_被触碰的贴图 = texture									#保存贴图文件到变量

				if ini数据[i].find ("Click=") != -1 :								#如果有"Click="
																					#(修改被点击的功能)
					被点击效果 = 当前行数_内容_string.split ( ">" , false )				#分段处理成列表

			if UI类型_string == "Select" :
				if ini数据[i].find ("SltButton=") != -1 :							#如果有"SelectButton="
																					#(SelectButton)
					call_deferred ("创建子UI" , 当前行数_内容_string , "SelectButton" )

				if ini数据[i].find ("SltBox=") != -1 :								#如果有"SelectBox="
																					#(创建SelectBox)
					call_deferred ("创建子UI" , 当前行数_内容_string , "SelectBox" )
				if 文本 == null :
					文本 = TextureRect.new()
					add_child (文本)
				文本.name = "文本"
				文本.size = self.size
				文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

			if ini数据[i].find ("SltINI=") != -1 :									#如果有"SltINI="
				SltINI = 当前行数_内容_string													#设置SltINI

	if UI类型_string != "SelectButton" && UI类型_string != "ListBoxBtn" && UI类型_string != "ListBoxBtn_Text" :
																				#如果UI类型不是SelectButton
																				#ListBoxBtn
																				#ListBoxBtn_Text
		mouse_entered.connect (鼠标悬停)
		mouse_exited.connect (鼠标移开)

	if UI类型_string != "ListBoxBtn_Text" :
		gui_input.connect(被左键点击)

	if UI类型_string == "SltBoxBtn" || UI类型_string == "ListBoxBtn" || UI类型_string == "ListBoxBtn_Text" :
		if 文本 == null :
			文本 = TextureRect.new()
			add_child (文本)
		文本.name = "文本"
		文本.size = self.size
		文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		文本.texture = UI贴图_文本_原本的贴图
		self.texture = UI贴图_原本的贴图
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 被左键点击 (event):
	# 检测鼠标左键点击
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if UI类型_string != "SelectButton" && UI类型_string != "Select":
			for 循环次数 in 被点击效果.size():
				if 被点击效果 [循环次数].find ("Page:") != -1 :
					var 节点 = get_node("/root/场景/UI")
					节点.问答页面 = 被点击效果 [循环次数].substr (被点击效果 [循环次数].find ("Page:") + 5 ) 
					节点.call_deferred("切换页面")
				if 被点击效果 [循环次数].find ("Options:") != -1 :
					if 本体.UI类型_string == "List" || 本体.UI类型_string == "SelectBox" :
						本体.当前选择的选项 = int (被点击效果 [循环次数].substr  (被点击效果 [循环次数].find (":") + 1) )

		if UI类型_string == "Select":
			if 布尔按钮状态_bool == true :
				布尔按钮状态_bool = false
			else :
				布尔按钮状态_bool = true
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 鼠标悬停 ():
	self.texture = UI贴图_被触碰的贴图
	if UI贴图_文本_被触碰的贴图 != null :
		文本.texture = UI贴图_文本_被触碰的贴图
	# 可选：播放音效或动画
	# $AudioStreamPlayer.play()
	按钮被触碰 = true
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 鼠标移开 ():
	self.texture = UI贴图_原本的贴图
	if UI贴图_文本_原本的贴图 != null :
		文本.texture = UI贴图_文本_原本的贴图
	按钮被触碰 = false
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 删除UI ():
	queue_free()
	if 文本 != null :
		文本.queue_free()
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 创建子UI (按钮ini名称 : String ,UI类型 : String):
	var ini_string = get_node ("/root/场景/UI") . UI_txt_文件数据					#获取ini内容
	var 当前ini行数_int = ini_string.find ("[" + 按钮ini名称 + "]")				#定位到 [@UI名称]的位置
	当前ini行数_int = 当前ini行数_int + 1											#当前ini行数_int 数值+1
																				#为了忽略 [@UI名称]

	var 复制的UI = TextureRect.new()												#创建UI
	复制的UI.name = 按钮ini名称													#设置名称 为了方便查找错误
	if UI类型 == "SelectButton" :
		复制的UI.set_script (load ("res://代码/UI_按钮代码.gd") )					#挂载代码

	if UI类型 == "SelectBox" :

		复制的UI.set_script (load ("res://代码/UI_列表代码.gd") )					#挂载代码
		#复制的UI.texture=load("res://loadingscreen1.png")
		复制的UI.position=Vector2(-1280,-1280)
		复制的UI.scale = Vector2(-1,-1)
		复制的UI.ListINI = SltINI

	复制的UI.UI类型_string = UI类型												#设置UI类型

	while ini_string[当前ini行数_int].substr (0 , 1) != "[" :
		复制的UI.ini数据.append (ini_string [当前ini行数_int] )						#添加到物体自己的ini数据
		当前ini行数_int = 当前ini行数_int + 1
	复制的UI.本体 = self

	if UI类型 == "SelectBox" :
		get_node ("/root/场景/UI").add_child (复制的UI)							#实例化物体
	else :
		add_child (复制的UI)														#实例化物体

	get_node ("/root/场景/UI").UI列表.append (复制的UI)							#添加到UI列表
	复制的UI.数据是否读取完成 = true												#允许运行这个UI
#————————————————————————————————#————————————————————————————————#—————————————#
