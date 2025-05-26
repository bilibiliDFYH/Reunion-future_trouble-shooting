extends Control
var UI列表 = []

var UI_txt_文件
var UI_txt_文件数据																#ini

var 背景

var 问答页面 = "主页面"
# Called when the node enters the scene tree for the first time.
func _ready () -> void:
	UI_txt_文件 = FileAccess.open (OS.get_executable_path().get_base_dir() + "/ini/UI.ini" , FileAccess.READ )#读取文件
	UI_txt_文件数据 = UI_txt_文件.get_as_text ()				#提取数据
	UI_txt_文件.close ()										#关闭文件
	UI_txt_文件数据 = UI_txt_文件数据.split ( "\n" , false )	#按换行符分割成数组
	UI_txt_文件数据.append ( "[" )							#添加结束末尾
	背景 = TextureRect.new()	#创建TextureRect节点
	背景.name = "背景"		#设置名称
	add_child (背景)			#实例化到场景

	if UI_txt_文件数据.find ("[Paginate]") != -1 :				#如果有[Paginate]，多ini读取
		var 读取的位置开头 = UI_txt_文件数据.find ( "[Paginate]" )	#定位到[Paginate]
		var 临时变量1 = 1										#设置临时变量1，作用是为了读取[Paginate]后面的n行
		var 临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]	#设置文本为[Paginate]后面第的n行
		var 临时变量2_结果

		while 临时变量2.substr (0 , 1) != "[" :				#重复执行知道[Paginate]后面第的n行的开头是[

			if 临时变量2.find ("Location=") != -1 :
				var 临时文件位置 = 临时变量2.substr (临时变量2.find ("=") + 1 )
				var 读取的文件 = FileAccess.open ( OS.get_executable_path().get_base_dir() + 临时文件位置 , FileAccess.READ )#读取文件
				var 读取的文件数据 = 读取的文件.get_as_text ()			#提取数据
				读取的文件.close ()									#关闭文件
				读取的文件数据 = 读取的文件数据.split ( "\n" , false )	#按换行符分割成数组
				for i in 读取的文件数据.size() :					#重复执行列表数量次，为了把ini内容添加到ini数据列表
					UI_txt_文件数据.append ( 读取的文件数据 [i] )	#把ini内容添加到ini数据列表

			临时变量1 = 临时变量1 + 1									#临时变量1+1，记录循环次数
			临时变量2 = UI_txt_文件数据[读取的位置开头+临时变量1]			#设置文本为[Paginate]后面第的n行
	UI_txt_文件数据.append ( "[" )	#添加结束末尾
	
	call_deferred ("切换页面")		#设置页面

func 分析ini (UI名称: String , UI类型: String) -> void:
	var 读取的位置开头 = UI_txt_文件数据.find ( "[" + UI名称 + "]" )		#设置读取的[]
	var 临时变量1 = 1
	var 临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]
	
	var 复制的UI = TextureRect.new()
	复制的UI.name = UI名称

	if UI类型 == "Button" || UI类型 == "Select" :
		复制的UI.set_script (load ("res://代码/UI_按钮代码.gd") )
		复制的UI.UI类型_string = UI类型

	if UI类型 == "List" :
		复制的UI.set_script (load ("res://代码/UI_列表代码.gd") )
		复制的UI.UI类型_string = UI类型

	if UI类型 == "Texture" :
		复制的UI.set_script (load ("res://代码/UI_贴图代码.gd") )

	while 临时变量2.substr (0 , 1) != "[" :
		复制的UI.ini数据.append(临时变量2)
		临时变量1 = 临时变量1 + 1
		临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]

	add_child (复制的UI)
	UI列表.append (复制的UI)

	复制的UI.数据是否读取完成 = true

	#var 在UI列表的位置 = 0
	#for i in UI列表.size():
		#if UI列表 [ i ].名字 == UI名称:
			#在UI列表的位置 = i

	#while 临时变量2.substr (0 , 1) != "[" :
		#if 临时变量2.find ("Texture=") != -1 :#修改贴图
			#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
			#var image  = Image.new()
			#image.load( 文件路径)
			#var texture = ImageTexture.create_from_image(image)
			#UI列表 [ 在UI列表的位置 ].UI贴图 = texture

		#if 临时变量2.find ("Location=") != -1 :#修改位置
			#UI列表 [ 在UI列表的位置 ].位置 = Vector2 (float(临时变量2.substr (临时变量2.find ("=") + 1 , 临时变量2.find (",") - 临时变量2.find ("=") - 1) ) , 0)
			#UI列表 [ 在UI列表的位置 ].位置 = Vector2 (UI列表 [ 在UI列表的位置 ].位置.x , float(临时变量2.substr (临时变量2.find (",") + 1) ) )

		#if 临时变量2.find ("Texture_c=") != -1 :#修改贴图
			#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
			#var image  = Image.new()
			#image.load( 文件路径)
			#var texture = ImageTexture.create_from_image(image)
			#UI列表 [ 在UI列表的位置 ].UI悬停贴图 = texture

		#if 临时变量2.find ("Text=") != -1 :#修改文本
			#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
			#var image  = Image.new()
			#image.load( 文件路径)
			#var texture = ImageTexture.create_from_image(image)
			#UI列表 [ 在UI列表的位置 ].UI文本 = texture

		#if 临时变量2.find ("Text_c=") != -1 :#修改文本
			#var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
			#var image  = Image.new()
			#image.load( 文件路径)
			#var texture = ImageTexture.create_from_image(image)
			#UI列表 [ 在UI列表的位置 ].UI悬停文本 = texture

		#if 临时变量2.find ("Click=") != -1 :#修改点击效果
			#var 临时字符串1 = 临时变量2.substr (临时变量2.find ("=") + 1 )
			#var 临时列表 = 临时字符串1.split ( ">" , false )
			#UI列表 [ 在UI列表的位置 ].被点击功能 = 临时列表

		#if 临时变量2.find ("SltButton=") != -1 :#修改下拉栏按钮
			#UI列表 [ 在UI列表的位置 ].下拉栏按钮ini = 临时变量2.substr (临时变量2.find ("=") + 1 )

		#if 临时变量2.find ("Size=") != -1 :#修改大小
			#UI列表 [ 在UI列表的位置 ].大小 = Vector2(float(临时变量2.substr (临时变量2.find ("=") + 1 , 临时变量2.find (",") - 临时变量2.find ("=") - 1) ) , 0)
			#UI列表 [ 在UI列表的位置 ].大小 = Vector2(UI列表 [ 在UI列表的位置 ].大小.x , float(临时变量2.substr (临时变量2.find (",") + 1) ) )

		#if 临时变量2.find ("SltBox=") != -1 :#修改下拉栏按钮
			#UI列表 [ 在UI列表的位置 ].下拉栏选择框ini = 临时变量2.substr (临时变量2.find ("=") + 1 )

		#if 临时变量2.find ("SltINI=") != -1 :#修改下拉栏按钮
			#var 读取的文件 = FileAccess.open (OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1 ) , FileAccess.READ )		#读取文件
			#var 读取的文件的数据 = 读取的文件.get_as_text ()								#提取数据
			#读取的文件.close ()														#关闭文件
			#读取的文件的数据 = 读取的文件的数据.split ( "\n" , false )					#按换行符分割成数组
			#读取的文件的数据.append ( "[" )											#添加结束末尾
			#UI列表 [ 在UI列表的位置 ].SltINI = 读取的文件的数据

		#临时变量1 = 临时变量1 + 1
		#临时变量2 = UI_txt_文件数据[读取的位置开头+临时变量1]

	#UI列表 [ 在UI列表的位置 ].数据是否读取完成 = true

func 切换页面 () :
	for i in UI列表.size () :
		UI列表 [i].call_deferred ("删除UI")
	UI列表 = []
	
	var 读取的位置开头 = UI_txt_文件数据.find ( "[" + 问答页面 + "]" )	#定位到[主页面]
	var 临时变量1 = 1
	var 临时变量2 = UI_txt_文件数据[ 读取的位置开头 + 临时变量1 ]
	
	if 读取的位置开头 != -1 :
		while 临时变量2.substr (0 , 1) != "[" :
			if 临时变量2.find("Texture=") != -1 :#修改贴图
				var 文件路径 = OS.get_executable_path().get_base_dir() + 临时变量2.substr (临时变量2.find ("=") + 1)
				var image  = Image.new()
				image.load( 文件路径)
				var texture = ImageTexture.create_from_image(image)
				背景.texture = texture

			if 临时变量2.find("NewUi=") != -1 :#新建UI
				var UI名称 = 临时变量2.substr(临时变量2.find ("=") + 1 , 临时变量2.find (":")- 临时变量2.find ("=") - 1)
				var UI类型 = 临时变量2.substr (临时变量2.find (":") + 1)

				call_deferred("分析ini" , UI名称 ,UI类型)

			临时变量1 = 临时变量1 + 1
			临时变量2 = UI_txt_文件数据[读取的位置开头+临时变量1]
