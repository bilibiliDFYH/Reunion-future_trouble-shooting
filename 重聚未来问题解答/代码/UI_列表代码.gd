extends Control

#————————————————————————————————#————————————————————————————————#—————————————#
var ini数据 = []
var ini附加数据 = []
var 列表选择框的数据 = []
#————————————————————————————————#————————————————————————————————#—————————————#
var 位置 = Vector2 ( 0 , 0 )
var 大小 = Vector2 ( 0 , 0 )
#————————————————————————————————#————————————————————————————————#—————————————#
var 下拉栏选择框贴图上
var 下拉栏选择框贴图中
var 下拉栏选择框贴图下
var 下拉栏选择框贴图只有一个
var 下拉栏选择框贴图上_c
var 下拉栏选择框贴图中_c
var 下拉栏选择框贴图下_c
var 下拉栏选择框贴图只有一个_c
var 选项贴图 = []
var 当前选择的选项 = 0
var 当前选择的选项_2 = 0
var 最大项目数 = -1
#————————————————————————————————#————————————————————————————————#—————————————#
var 索引列表物体_node
var 索引列表选中选项_int = 0
var 索引列表选中选项_int_上一帧 = 0
#————————————————————————————————#————————————————————————————————#—————————————#
var 数据是否读取完成 = false
var UI类型_string
var ListINI
																				#(下拉选择栏按钮，点击开关按钮)
#————————————————————————————————#————————————————————————————————#—————————————#
var 本体																			#请只给下拉选择栏等UI使用
var 所有选项物体_node = []
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func _process(delta: float) -> void:
	if 数据是否读取完成 == true :
		call_deferred("设置UI")
		if UI类型_string == "SelectBox" :
			self.position=Vector2(-1280,-1280)
			self.scale = Vector2(-1,-1)
		else  :
			self.position=位置
		数据是否读取完成 = false

	if UI类型_string == "SelectBox" :											#如果UI类型是 SltButton
		if 本体.布尔按钮状态_bool == false :										#请只给下拉选择栏等UI使用
			self.position=位置
			self.scale = Vector2(1,1)
		else :																	#(下拉选择栏按钮，点击开关按钮)
			self.position=Vector2(-1280,-1280)
			self.scale = Vector2(-1,-1)

	if 当前选择的选项_2 != 当前选择的选项 :
		if UI类型_string == "SelectBox" :
			本体.文本.texture = 选项贴图 [当前选择的选项]

	if 索引列表物体_node != null :
		索引列表选中选项_int = 索引列表物体_node.当前选择的选项

	if 索引列表选中选项_int != 索引列表选中选项_int_上一帧 :
		call_deferred ("刷新列表_显示")

	当前选择的选项_2 = 当前选择的选项
	
	if 索引列表物体_node != null :
		索引列表选中选项_int_上一帧 = 索引列表物体_node.当前选择的选项
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func 设置UI ():
	if UI类型_string == "List" :
		for i in ini数据.size():													#根据ini设置UI
			var 当前行数_内容_string = ini数据[i].substr (ini数据[i].find ("=") + 1)#提取出当前行数的内容
			if ini数据[i].find ("ListINI=") != -1 :								#如果有"Texture="
																				#(修改原本的贴图)
				ListINI = 当前行数_内容_string

			当前行数_内容_string = ini数据[i].substr (ini数据[i].find ("=") + 1)#提取出当前行数的内容
			if ini数据[i].find ("Index=") != -1 :								#如果有"Texture="
																				#(修改原本的贴图)
				var UI主节点 = get_node ("/root/场景/UI")
				for a in UI主节点.UI列表.size () :
					if UI主节点.UI列表[a].name == 当前行数_内容_string :
						索引列表物体_node = UI主节点.UI列表[a]
				call_deferred ("重复获取索引列表物体" , 当前行数_内容_string)

	var ini文本文件 = FileAccess.open (OS.get_executable_path().get_base_dir() + ListINI , FileAccess.READ )
																				#读取文件
	ini附加数据 = ini文本文件.get_as_text ()										#提取数据
	ini文本文件.close ()															#关闭文件
	ini附加数据 = ini附加数据.split ( "\n" , false )								#按换行符分割成数组
	ini附加数据.append ( "[" )													#添加结束末尾

	var 读取的位置开头 = ini附加数据.find ( "[Optional]" )							#分析位置为[Optional]的位置
	var 临时变量1 = 1
	var 当前行数的内容 = ini附加数据[ 读取的位置开头 + 临时变量1 ]						#获取当前行数的内容
	var 当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )	#获取当前行数的内容的值

	var 选项列表 = []

	while 当前行数的内容.substr (0 , 1) != "[" :
		选项列表.append (当前行数的内容的值)

#————————————————————————————————#以下内容是结尾部分，负责更新数据。
		临时变量1 = 临时变量1 + 1
		当前行数的内容 = ini附加数据[ 读取的位置开头 + 临时变量1 ]						#更新当前行数的内容
		当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )		#更新当前行数的内容的值

	for 选项列表的第N项 in 选项列表.size () :

		var 当前行_数据_string = 选项列表[选项列表的第N项]							#选项列表是所有选项的列表
																				#在ini的[Optional]里面

		if UI类型_string == "List" :
			if 当前行_数据_string.find ( ":" ) != -1 :
				读取的位置开头 = ini附加数据.find ( "[" + 当前行_数据_string.substr (0 , 当前行_数据_string.find ( ":" ) ) + "]" )
																				#分析位置为[当前行_数据_string]的位置
			else :
				读取的位置开头 = ini附加数据.find ( "[" + 当前行_数据_string + "]" )	#分析位置为[当前行_数据_string]的位置
			var 第N行 = 0
			当前行数的内容 = ini附加数据[ 读取的位置开头 + 第N行 + 1 ]					#获取当前行数的内容
			当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )
																				#获取当前行数的内容的值

			var Text
			var 索引

			while 当前行数的内容.substr (0 , 1) != "[" :
				if 当前行数的内容.find ("Text=") != -1 :
					Text = 当前行数的内容的值.split ( ">" , false )
				#————————————————————————————————#以下内容是结尾部分，负责更新数据。
				第N行 = 第N行 + 1
				当前行数的内容 = ini附加数据[ 读取的位置开头 + 第N行 + 1 ]				#更新当前行数的内容
				当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )		#更新当前行数的内容的值
				if 当前行数的内容.find ("Index=") != -1 :
					索引 = 当前行数的内容的值

			#————————————————#设置Text
			for i in Text.size () :
				if 当前行_数据_string.find ( ":" ) != -1 :
	
					if 当前行_数据_string.find ( ":Text" ) != -1 :
						列表选择框的数据.append (Text[i] + ";" + str (选项列表的第N项) + ":Text" + ">" + 索引)
	
					if 当前行_数据_string.find ( ":Optional" ) != -1 :
						列表选择框的数据.append (Text[i] + ";" + str (选项列表的第N项) + ":Optional" + ">" + 索引)
	
				else :
					列表选择框的数据.append (Text[i] + ";" + str (选项列表的第N项) + ":Optional" + ">" + 索引)
			#————————————————#————————————————#

		if UI类型_string == "SelectBox" :
			读取的位置开头 = ini附加数据.find ( "[" + 当前行_数据_string + "]" )		#分析位置为[当前行_数据_string]的位置
			var 第N行 = 0
			当前行数的内容 = ini附加数据[ 读取的位置开头 + 第N行 + 1 ]					#获取当前行数的内容
			当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )
																				#获取当前行数的内容的值

			var Text
			var Text_Title

			while 当前行数的内容.substr (0 , 1) != "[" :
				if 当前行数的内容.find ("Text=") != -1 :
					Text = 当前行数的内容的值.split ( ">" , false )
				if 当前行数的内容.find ("Text_Title=") != -1 :
					Text_Title = 当前行数的内容的值
				#————————————————————————————————#以下内容是结尾部分，负责更新数据。
				第N行 = 第N行 + 1
				当前行数的内容 = ini附加数据[ 读取的位置开头 + 第N行 + 1 ]				#更新当前行数的内容
				当前行数的内容的值 = 当前行数的内容.substr ( 当前行数的内容.find ( "=" ) + 1 )		#更新当前行数的内容的值

			#————————————————#设置Text
			for i in Text.size () :
				列表选择框的数据.append (Text[i] + ";" + str (选项列表的第N项) + ":Optional" )
			#————————————————#————————————————#

			#————————————————#Text_Title
			for i in 1 :
				var 文件路径 = OS.get_executable_path().get_base_dir() + Text_Title
																					#获取文件路径
				var image  = Image.new()											#创建image
				image.load (文件路径)													#读取贴图
				var texture = ImageTexture.create_from_image(image)					#将image设置为texture
				选项贴图.append(texture)
			#————————————————#————————————————#

	for i in ini数据.size():														#根据ini设置UI
		var 当前行数_内容_string = ini数据[i].substr (ini数据[i].find ("=") + 1)	#提取出当前行数的内容

#————————————————————————————————#以下内容是贴图部分，负责列表选项的贴图
		if ini数据[i].find ("TextureTop=") != -1 :								#如果有"TextureTop="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图上 = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureTop_c=") != -1 :								#如果有"TextureTop_c="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图上_c = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureMiddle=") != -1 :							#如果有"TextureBottom="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图中 = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureMiddle_c=") != -1 :							#如果有"TextureBottom_cv="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图中_c = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureBottom=") != -1 :							#如果有"TextureMiddle="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图下 = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureBottom_c=") != -1 :							#如果有"TextureMiddle_c="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图下_c = texture											#保存贴图文件到变量

		if ini数据[i].find ("TextureOnlyOne=") != -1 :							#如果有"TextureOnlyOne="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图只有一个 = texture										#保存贴图文件到变量

		if ini数据[i].find ("TextureOnlyOne_c=") != -1 :							#如果有"TextureOnlyOne_c="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图只有一个_c = texture										#保存贴图文件到变量

		if ini数据[i].find ("Texture=") != -1 :							#如果有"TextureOnlyOne_c="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图上 = texture											#保存贴图文件到变量
			下拉栏选择框贴图中 = texture											#保存贴图文件到变量
			下拉栏选择框贴图下 = texture											#保存贴图文件到变量
			下拉栏选择框贴图只有一个 = texture										#保存贴图文件到变量

		if ini数据[i].find ("Texture_c=") != -1 :							#如果有"TextureOnlyOne_c="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			下拉栏选择框贴图上_c = texture											#保存贴图文件到变量
			下拉栏选择框贴图中_c = texture											#保存贴图文件到变量
			下拉栏选择框贴图下_c = texture											#保存贴图文件到变量
			下拉栏选择框贴图只有一个_c = texture										#保存贴图文件到变量
#————————————————————————————————#以上内容是贴图部分，负责列表选项的贴图

		if ini数据[i].find ("Location=") != -1 :									#如果有"Location="
			var 坐标 = Vector2 (float(当前行数_内容_string.substr (0 , 当前行数_内容_string.find (",")  ) ) , 0)
																				#设置X的值
			坐标 = Vector2 (坐标.x , float(当前行数_内容_string.substr (当前行数_内容_string.find (",") +1 ) ) )
																				#设置Y的值
			位置 = 坐标													#设置位置
			if UI类型_string != "SelectBox" :
				self.position=位置

		if ini数据[i].find ("Size=") != -1 :										#如果有"Size="
			var 大小 = Vector2 (float(当前行数_内容_string.substr (0 , 当前行数_内容_string.find (",")  ) ) , 0)
																				#设置X的值
			大小 = Vector2 (大小.x , float(当前行数_内容_string.substr (当前行数_内容_string.find (",") +1 ) ) )
																				#设置Y的值
			self.大小 = 大小														#设置位置

		if ini数据[i].find ("MaxItem=") != -1 :										#如果有"Size="
			最大项目数 = int (当前行数_内容_string)

	call_deferred ("创建可选选项_数据处理")
	gui_input.connect(被左键点击)

	if UI类型_string == "SelectBox" :
		本体.文本.texture = 选项贴图 [当前选择的选项] 
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func 创建可选选项_数据处理 ():
	var 要生成的选项数据_list = []

	var 生成的选项数 = 0
	for 循环次数 in 列表选择框的数据.size () :
		var 当前行数据_string = 列表选择框的数据[循环次数]
		if UI类型_string == "List" :
			if 最大项目数 != -1 && 生成的选项数 == 最大项目数:
				break
			var 索引 = 当前行数据_string.substr (当前行数据_string.find (">") + 1)
			索引 = int (索引)
			if 索引 == 索引列表选中选项_int :
				要生成的选项数据_list.append (当前行数据_string.substr (0 , 当前行数据_string.find (">")))
				生成的选项数 = 生成的选项数 + 1
		if UI类型_string == "SelectBox" :
			if 最大项目数 != -1 && 生成的选项数 == 最大项目数:
				break
			要生成的选项数据_list.append (当前行数据_string)
			生成的选项数 = 生成的选项数 + 1

	if 生成的选项数 != 0 :
		var 复制的UI
		var 多行文本的父级物体

		var 当前生成的选项 = 要生成的选项数据_list[0]
		var 文本贴图_string = 当前生成的选项.substr (0 , 当前生成的选项.find (";") )
		var 编号_int = 当前生成的选项.substr (当前生成的选项.find (";") + 1 , 当前生成的选项.find (":") - 当前生成的选项.find (";") - 1 )
		编号_int = int(编号_int)
		var 类型_string = 当前生成的选项.substr (当前生成的选项.find (":") + 1)
		var 编号_int_上一个 = 编号_int

		for 生成的第n个选项 in 生成的选项数 :
			当前生成的选项 = 要生成的选项数据_list[生成的第n个选项]
			文本贴图_string = 当前生成的选项.substr (0 , 当前生成的选项.find (";") )
			编号_int = 当前生成的选项.substr (当前生成的选项.find (";") + 1 , 当前生成的选项.find (":") - 当前生成的选项.find (";") - 1 )
			编号_int = int(编号_int)
			类型_string = 当前生成的选项.substr (当前生成的选项.find (":") + 1)
			复制的UI = TextureRect.new()												#创建UI
			复制的UI.name = str (编号_int)										#设置名称
			复制的UI.set_script (load ("res://代码/UI_按钮代码.gd") )					#挂载代码
			if UI类型_string == "SelectBox" :
				复制的UI.UI类型_string = "SltBoxBtn"									#设置UI类型
				复制的UI.被点击效果.append ("Options:" + str(编号_int) )
			if UI类型_string == "List" :
				if 类型_string == "Text" :
					复制的UI.UI类型_string = "ListBoxBtn_Text"						#设置UI类型
				elif 类型_string == "Optional" :
					复制的UI.UI类型_string = "ListBoxBtn"
					复制的UI.被点击效果.append ("Options:" + str(编号_int) )
			
			复制的UI.物体编号_int = int(编号_int)										#设置编号

			复制的UI.position = Vector2 ( 0 , 大小.y * 生成的第n个选项 )
			if 生成的选项数 == 1:
				复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图只有一个
				复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图只有一个_c
			else :
				if 生成的第n个选项 == 0 :
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图上
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图上_c
				elif 生成的第n个选项 == 生成的选项数 - 1:
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图下
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图下_c
				else :
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图中
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图中_c

			复制的UI.size = 大小
			var 文件路径 = OS.get_executable_path().get_base_dir() + 文本贴图_string
			var image  = Image.new()												#创建image
			image.load (文件路径)														#读取贴图
			var 文本贴图_texture = ImageTexture.create_from_image(image)						#将image设置为texture
			复制的UI.UI贴图_文本_原本的贴图 = 文本贴图_texture
			复制的UI.UI贴图_文本_被触碰的贴图 = 文本贴图_texture

			if 生成的第n个选项 != 0 && 编号_int == 编号_int_上一个 :
				if UI类型_string == "SelectBox" :
					复制的UI.本体 = 多行文本的父级物体
				if UI类型_string == "List" :
					复制的UI.本体 = self
			else :
				复制的UI.本体 = self

			self.size = Vector2 (大小.x , 大小.y * 列表选择框的数据.size () )

			if 生成的第n个选项 != 0 && 编号_int == 编号_int_上一个 :
				多行文本的父级物体.add_child (复制的UI)									#实例化物体
				复制的UI.position = Vector2 ( 0 , 大小.y)
			else :
				add_child (复制的UI)													#实例化物体

			复制的UI.数据是否读取完成 = true											#允许运行这个UI

			if 编号_int != 编号_int_上一个 :
				多行文本的父级物体 = 复制的UI

			所有选项物体_node.append (复制的UI)

			if UI类型_string == "SelectBox" :
				本体.文本.texture = 选项贴图 [当前选择的选项]

			编号_int_上一个 = 编号_int
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func 刷新列表_显示 ():
	var 要生成的选项数据_list = []

	var 生成的选项数 = 0
	for 循环次数 in 列表选择框的数据.size () :
		var 当前行数据_string = 列表选择框的数据[循环次数]
		if UI类型_string == "List" :
			if 最大项目数 != -1 && 生成的选项数 == 最大项目数:
				break
			var 索引 = 当前行数据_string.substr (当前行数据_string.find (">") + 1)
			索引 = int (索引)
			if 索引 == 索引列表选中选项_int :
				要生成的选项数据_list.append (当前行数据_string.substr (0 , 当前行数据_string.find (">")))
				生成的选项数 = 生成的选项数 + 1
		if UI类型_string == "SelectBox" :
			if 最大项目数 != -1 && 生成的选项数 == 最大项目数:
				break
			要生成的选项数据_list.append (当前行数据_string)
			生成的选项数 = 生成的选项数 + 1

	if 要生成的选项数据_list.size () != 所有选项物体_node.size () :
		if 要生成的选项数据_list.size () > 所有选项物体_node.size () :
			for i in 要生成的选项数据_list.size () - 所有选项物体_node.size () :
				所有选项物体_node.append (null)
		if 所有选项物体_node.size () > 要生成的选项数据_list.size () :
			for i in 所有选项物体_node.size () - 要生成的选项数据_list.size () :
				所有选项物体_node[所有选项物体_node.size () - 1].call_deferred ("删除UI")
				所有选项物体_node.resize (所有选项物体_node.size () - 1)

	if 生成的选项数 != 0 :
		var 复制的UI
		var 多行文本的父级物体

		var 当前生成的选项 = 要生成的选项数据_list[0]
		var 文本贴图_string = 当前生成的选项.substr (0 , 当前生成的选项.find (";") )
		var 编号_int = 当前生成的选项.substr (当前生成的选项.find (";") + 1 , 当前生成的选项.find (":") - 当前生成的选项.find (";") - 1 )
		编号_int = int(编号_int)
		var 类型_string = 当前生成的选项.substr (当前生成的选项.find (":") + 1)
		var 编号_int_上一个 = 编号_int

		for 生成的第n个选项 in 生成的选项数 :
			复制的UI = 所有选项物体_node [生成的第n个选项]
			当前生成的选项 = 要生成的选项数据_list[生成的第n个选项]
			文本贴图_string = 当前生成的选项.substr (0 , 当前生成的选项.find (";") )
			编号_int = 当前生成的选项.substr (当前生成的选项.find (";") + 1 , 当前生成的选项.find (":") - 当前生成的选项.find (";") - 1 )
			编号_int = int(编号_int)
			类型_string = 当前生成的选项.substr (当前生成的选项.find (":") + 1)
			if 复制的UI == null :
				复制的UI = TextureRect.new()											#创建UI
				复制的UI.set_script (load ("res://代码/UI_按钮代码.gd") )				#挂载代码

			复制的UI.name = str (编号_int)											#设置名称
			if UI类型_string == "SelectBox" :
				复制的UI.UI类型_string = "SltBoxBtn"									#设置UI类型
				复制的UI.被点击效果.append ("Options:" + str(编号_int) )
			if UI类型_string == "List" :
				if 类型_string == "Text" :
					复制的UI.UI类型_string = "ListBoxBtn_Text"						#设置UI类型
				elif 类型_string == "Optional" :
					复制的UI.UI类型_string = "ListBoxBtn"
					复制的UI.被点击效果.append ("Options:" + str(编号_int) )

			复制的UI.物体编号_int = int(编号_int)										#设置编号

			复制的UI.position = Vector2 ( 0 , 大小.y * 生成的第n个选项 )
			if 生成的选项数 == 1:
				复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图只有一个
				复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图只有一个_c
			else :
				if 生成的第n个选项 == 0 :
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图上
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图上_c
				elif 生成的第n个选项 == 生成的选项数 - 1:
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图下
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图下_c
				else :
					复制的UI.UI贴图_原本的贴图 = 下拉栏选择框贴图中
					复制的UI.UI贴图_被触碰的贴图 = 下拉栏选择框贴图中_c

			if 所有选项物体_node [生成的第n个选项] != null :
				if 生成的第n个选项 != 0 && 编号_int == 编号_int_上一个 :
					复制的UI.get_parent().remove_child(复制的UI)
					多行文本的父级物体.add_child(复制的UI)
					复制的UI.position = Vector2 ( 0 , 大小.y)

			复制的UI.size = 大小
			var 文件路径 = OS.get_executable_path().get_base_dir() + 文本贴图_string
			var image  = Image.new()												#创建image
			image.load (文件路径)														#读取贴图
			var 文本贴图_texture = ImageTexture.create_from_image(image)						#将image设置为texture
			复制的UI.UI贴图_文本_原本的贴图 = 文本贴图_texture
			复制的UI.UI贴图_文本_被触碰的贴图 = 文本贴图_texture

			if 生成的第n个选项 != 0 && 编号_int == 编号_int_上一个 :
				if UI类型_string == "SelectBox" :
					复制的UI.本体 = 多行文本的父级物体
				if UI类型_string == "List" :
					复制的UI.本体 = self
			else :
				复制的UI.本体 = self

			self.size = Vector2 (大小.x , 大小.y * 列表选择框的数据.size () )

			if 所有选项物体_node [生成的第n个选项] == null :
				所有选项物体_node [生成的第n个选项] = 复制的UI
				if 生成的第n个选项 != 0 && 编号_int == 编号_int_上一个 :
					多行文本的父级物体.add_child (复制的UI)									#实例化物体
					复制的UI.position = Vector2 ( 0 , 大小.y)
				else :
					add_child (复制的UI)													#实例化物体

			复制的UI.数据是否读取完成 = true											#允许运行这个UI

			if 编号_int != 编号_int_上一个 :
				多行文本的父级物体 = 复制的UI

			if UI类型_string == "SelectBox" :
				本体.文本.texture = 选项贴图 [当前选择的选项]

			编号_int_上一个 = 编号_int
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func 被左键点击 (event):
	# 检测鼠标左键点击
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if UI类型_string == "SelectBox" :											#如果UI类型是 SltButton
			if 本体.布尔按钮状态_bool == false :									#请只给下拉选择栏等UI使用
				本体.布尔按钮状态_bool = true
			else :																#(下拉选择栏按钮，点击开关按钮)
				本体.布尔按钮状态_bool = true
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 删除UI ():
	queue_free()
	for i in 所有选项物体_node.size () :
		所有选项物体_node [i].queue_free ()
#————————————————————————————————#————————————————————————————————#—————————————#

#————————————————————————————————#————————————————————————————————#—————————————#
func 重复获取索引列表物体 (索引列表物体name_string):
	if 索引列表物体_node == null && 索引列表物体name_string != "" :
		var UI主节点 = get_node ("/root/场景/UI")
		for a in UI主节点.UI列表.size () :
			if UI主节点.UI列表[a].name == 索引列表物体name_string :
				索引列表物体_node = UI主节点.UI列表[a]
		if 索引列表物体_node == null :
			call_deferred ("重复获取索引列表物体" , 索引列表物体name_string)
#————————————————————————————————#————————————————————————————————#—————————————#
