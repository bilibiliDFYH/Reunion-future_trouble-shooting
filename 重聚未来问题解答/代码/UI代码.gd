extends Control
#var 名字
#var UI类型
#
#var UI贴图
#var UI悬停贴图
#var UI文本
#var UI悬停文本
#
#var 下拉栏按钮ini
#var 下拉栏状态 = "关"
#var 下拉栏按钮贴图
#var 下拉栏按钮贴图_c
#
#var 下拉栏选择框ini
#var 下拉栏选择框大小
#var 下拉栏选择框贴图上
#var 下拉栏选择框贴图中
#var 下拉栏选择框贴图下
#var 下拉栏选择框贴图只有一个
#var 下拉栏选择框贴图上_c
#var 下拉栏选择框贴图中_c
#var 下拉栏选择框贴图下_c
#var 下拉栏选择框贴图只有一个_c
#
#var SltINI
#var 下拉栏选择框可选选项 = []
#var 下拉栏选择框可选选项标题文本 = []
#var 下拉栏选择框可选选项文本 = []
#var 下拉栏选择框可选选项当前的选择 = 0
#var 可以显示下拉栏选择框可选选项标题文本 = false
#
#var 位置 = Vector2 (0 , 0)
#var 大小 = Vector2 (0 , 0)
#
#var 被点击功能 = []
#
var 数据是否读取完成 = false
#
#var 文本#物体
#var 下拉栏按钮#物体


func _process (delta: float) -> void:
	if 数据是否读取完成 == true :
		print("aaa")
		#call_deferred("设置UI")
		数据是否读取完成 = false
#
	#if 可以显示下拉栏选择框可选选项标题文本 == true :
		#文本.texture = 下拉栏选择框可选选项标题文本 [下拉栏选择框可选选项当前的选择]

#func 设置UI ():
	#self.texture = UI贴图
	#self.position = 位置
	#self.size = 大小
	#self.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
#
	#if UI类型 == "Button" :
		#mouse_entered.connect (鼠标悬停)
		#mouse_exited.connect (鼠标移开)
		#gui_input.connect(被左键点击)

	#if UI类型 == "Select" :
		#gui_input.connect(被左键点击)
		#下拉栏按钮 = TextureRect.new ()
		#下拉栏按钮.name = "下拉栏按钮"
		#add_child (下拉栏按钮)
		#下拉栏按钮.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

		#var UI_txt_文件数据 = get_node ("/root/场景/UI") .UI_txt_文件数据
		#var 读取的位置开头 = UI_txt_文件数据.find ( "[" + 下拉栏按钮ini + "]" )
		#var 临时变量1 = 1
		#var 临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]
		#while 临时变量2.substr (0 , 1) != "[" :									#下拉栏按钮
			#if 临时变量2.find ("Texture=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏按钮贴图 = texture

			#if 临时变量2.find ("Location=") != -1 :#修改位置
				#下拉栏按钮.position = Vector2 (float(临时变量2.substr (临时变量2.find ("=") + 1 , 临时变量2.find (",") - 临时变量2.find ("=") - 1) ) , 0)
				#下拉栏按钮.position = Vector2 (下拉栏按钮.position.x , float(临时变量2.substr (临时变量2.find (",") + 1) ) )

			#if 临时变量2.find ("Texture_c=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏按钮贴图_c = texture

			#if 临时变量2.find ("Size=") != -1 :#修改大小
				#下拉栏按钮.size = Vector2(float(临时变量2.substr (临时变量2.find ("=") + 1 , 临时变量2.find (",") - 临时变量2.find ("=") - 1) ) , 0)
				#下拉栏按钮.size = Vector2(下拉栏按钮.size.x , float(临时变量2.substr (临时变量2.find (",") + 1) ) )

			#临时变量1 = 临时变量1 + 1
			#临时变量2 = UI_txt_文件数据[读取的位置开头+临时变量1]
		#下拉栏按钮.texture = 下拉栏按钮贴图
#
		#读取的位置开头 = UI_txt_文件数据.find ( "[" + 下拉栏选择框ini + "]" )
		#临时变量1 = 1
		#临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]
		#while 临时变量2.substr (0 , 1) != "[" :									#下拉栏选择框
			#if 临时变量2.find ("TextureTop=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图上 = texture
#
			#if 临时变量2.find ("TextureTop_c=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图上_c = texture
#
			#if 临时变量2.find ("TextureMiddle=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图中 = texture
#
			#if 临时变量2.find ("TextureMiddle_c=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图中_c = texture
#
			#if 临时变量2.find ("TextureBottom=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图下 = texture
#
			#if 临时变量2.find ("TextureBottom_c=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图下_c = texture
#
			#if 临时变量2.find ("TextureOnlyOne=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图只有一个 = texture
#
			#if 临时变量2.find ("TextureOnlyOne_c=") != -1 :#修改贴图
				#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				#var image  = Image.new()
				#image.load( 文件路径)
				#var texture = ImageTexture.create_from_image(image)
				#下拉栏选择框贴图只有一个_c = texture
#
			#if 临时变量2.find ("Size=") != -1 :#修改贴图
				#下拉栏选择框大小 = Vector2(float(临时变量2.substr (临时变量2.find ("=") + 1 , 临时变量2.find (",") - 临时变量2.find ("=") - 1) ) , 0)
				#下拉栏选择框大小 = Vector2(下拉栏选择框大小.x , float(临时变量2.substr (临时变量2.find (",") + 1) ) )
#
#
			#临时变量1 = 临时变量1 + 1
			#临时变量2 = UI_txt_文件数据[读取的位置开头+临时变量1]
#
		#读取的位置开头 = SltINI.find ( "[Optional]" )								#读取ini的选项
		#临时变量1 = 1
		#临时变量2 = SltINI [ 读取的位置开头 + 临时变量1 ]
		#while 临时变量2.substr (0 , 1) != "[" :									#下拉栏选择框内容
			#下拉栏选择框可选选项 .append ( 临时变量2.substr (临时变量2.find ("=") + 1) )
			#临时变量1 = 临时变量1 + 1
			#临时变量2 = SltINI[读取的位置开头+临时变量1]
#
		#var 临时int1_int=0
		#for i in 下拉栏选择框可选选项.size() :
			#读取的位置开头 = SltINI.find ( "[" + 下拉栏选择框可选选项 [i] + "]" )
			#临时变量1 = 1
			#临时变量2 = SltINI [ 读取的位置开头 + 临时变量1 ]
			#var 临时变量2_文本内容 = 临时变量2.substr (临时变量2.find ("=") + 1 ) 
			#下拉栏选择框可选选项[i] = 下拉栏选择框可选选项[i] + "<Text="
			#while 临时变量2.substr (0 , 1) != "[" :								#下拉栏选择框文本行数
				#临时变量2_文本内容 = 临时变量2.substr (临时变量2.find ("=") + 1 ) 
				#if 临时变量2.find ("Text=") != -1 :								#修改文本贴图
					#var 临时列表1 = []
					#临时列表1 = 临时变量2_文本内容 .split ( ">" , false )
					#for a in 临时列表1.size () :
						#var 文件路径 = OS.get_executable_path ().get_base_dir () + 临时列表1 [a]
						#var image  = Image.new()
						#image.load( 文件路径)
						#var texture = ImageTexture.create_from_image(image)
						#下拉栏选择框可选选项文本.append (texture)
						#下拉栏选择框可选选项[i] = 下拉栏选择框可选选项[i] + ">" + str(临时int1_int)
						#临时int1_int = 临时int1_int + 1
				#
				#if 临时变量2.find ("Text_Title=") != -1 :								#修改文本贴图
					#var 文件路径 = OS.get_executable_path ().get_base_dir () + 临时变量2_文本内容
					#var image  = Image.new()
					#image.load( 文件路径 )
					#var texture = ImageTexture.create_from_image(image)
					#下拉栏选择框可选选项标题文本.append (texture)
#
				#临时变量2_文本内容 = 临时变量2.substr (临时变量2.find ("=") + 1 ) 
				#临时变量1 = 临时变量1 + 1
				#临时变量2 = SltINI [读取的位置开头 + 临时变量1]
#
		#临时int1_int = 0
		#for i in 下拉栏选择框可选选项.size () :										#创建下拉栏选择框并设置贴图
			#var 临时字符串1_string = 下拉栏选择框可选选项[i].substr (下拉栏选择框可选选项[i].find ("<Text=>") + 7 )
			##获取 下拉栏选择框可选选项 每一项的 "<Text=>" 后面的部分
			#var 临时列表1_list = 临时字符串1_string.split ( ">" , false )
			##将 临时字符串1_string 的内容变成列表
			#var 开头物体_node
			##获取开头物体
#
			#for j in 临时列表1_list.size () :
			##重复执行 临时列表1_list 的项数次
#
				#var 下拉栏box = TextureRect.new ()
				#下拉栏box.name = "下拉栏box" + str (i + j)
				##创建物体
				#下拉栏box.set_script (load ("res://代码/下拉选择框.gd") )
				##附加代码
				#if j == 0 :
					#开头物体_node = 下拉栏box
					#get_node ("/root/场景/UI").add_child (下拉栏box)
					#下拉栏box.父级 = null
					#下拉栏box.位置 = Vector2( 位置.x , 下拉栏选择框大小.y * 临时int1_int + 位置.y + 大小.y )
				#else :
					#开头物体_node.add_child (下拉栏box)
					#下拉栏box.父级 = 开头物体_node
					#下拉栏box.位置 = Vector2( 0 , 下拉栏选择框大小.y * j )
#
				#下拉栏box.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
				#下拉栏box.position = Vector2 ( -1280 * 2 , -720 * 2 )
				#if 下拉栏选择框可选选项.size () == 1 && 临时列表1_list.size () == 1 :
					#下拉栏box.贴图 = 下拉栏选择框贴图只有一个
					#下拉栏box.贴图_c = 下拉栏选择框贴图只有一个_c
				#elif i == 0 && j == 0 :
					#下拉栏box.贴图 = 下拉栏选择框贴图上
					#下拉栏box.贴图_c = 下拉栏选择框贴图上_c
				#elif i == 下拉栏选择框可选选项.size () - 1 && j == 临时列表1_list.size () - 1:
					#下拉栏box.贴图 = 下拉栏选择框贴图下
					#下拉栏box.贴图_c = 下拉栏选择框贴图上_c
				#else :
					#下拉栏box.贴图 = 下拉栏选择框贴图中
					#下拉栏box.贴图_c = 下拉栏选择框贴图上_c
				#下拉栏box.本体 = self
				#下拉栏box.UI文本 = 下拉栏选择框可选选项文本 [int (临时列表1_list [j]) ]
				#下拉栏box.数据是否读取完成 = true
				#下拉栏box.被选择效果 = i
#
				#临时int1_int = 临时int1_int + 1
#
		#文本 = TextureRect.new()
		#文本.name = "文本"
		#add_child (文本)
		#文本.size = self.size
		#文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		#文本.texture = 下拉栏选择框可选选项标题文本 [下拉栏选择框可选选项当前的选择]
		#可以显示下拉栏选择框可选选项标题文本 = true
#
	#if UI文本 != null :
		#文本 = TextureRect.new()
		#文本.name = "文本"
		#add_child (文本)
		#文本.size = self.size
		#文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		#文本.texture = UI文本
#
#func 被左键点击 (event):
	## 检测鼠标左键点击
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#if UI类型 == "Button" :
			#for 循环次数 in 被点击功能.size():
				#if 被点击功能 [循环次数].find ("Page:") != -1 :
					#var 节点 = get_node("/root/场景/UI")
					#节点.问答页面 = 被点击功能 [循环次数].substr (被点击功能 [循环次数].find (":") + 1 ) 
					#节点.call_deferred("切换页面")
		#
		#if UI类型 == "Select" :
			#if 下拉栏状态 == "开" :
				#下拉栏状态 = "关"
				#下拉栏按钮.texture = 下拉栏按钮贴图
			#else :
				#下拉栏状态 = "开"
				#下拉栏按钮.texture = 下拉栏按钮贴图_c
#
#func 鼠标悬停 ():
	#self.texture = UI悬停贴图
	#if UI悬停文本 != null :
		#文本.texture = UI悬停文本
	## 可选：播放音效或动画
	## $AudioStreamPlayer.play()
#
#func 鼠标移开 ():
	#self.texture = UI贴图
	#if UI文本 != null :
		#文本.texture = UI文本
#
#func 删除UI ():
	#queue_free()
