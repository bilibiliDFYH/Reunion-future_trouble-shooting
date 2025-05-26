extends Control

#————————————————————————————————#————————————————————————————————#—————————————#
var ini数据 = []
#————————————————————————————————#————————————————————————————————#—————————————#
var UI贴图_原本的贴图
var UI贴图_文本_原本的贴图
#————————————————————————————————#————————————————————————————————#—————————————#
var 数据是否读取完成 = false
var UI类型_string
#————————————————————————————————#————————————————————————————————#—————————————#
var 文本
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func _process(delta: float) -> void:
	if 数据是否读取完成 == true :
		call_deferred("设置UI")
		数据是否读取完成 = false
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 设置UI ():
	for i in ini数据.size():														#根据ini设置UI
		var 当前行数_内容_string = ini数据[i].substr (ini数据[i].find ("=") + 1)	#提取出当前行数的内容

		if ini数据[i].find ("Texture=") != -1 :									#如果有"Texture="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			UI贴图_原本的贴图 = texture											#保存贴图文件到变量
			self.texture = UI贴图_原本的贴图

		if ini数据[i].find ("Location=") != -1 :									#如果有"Location="
			pass
			var 坐标 = Vector2 (float(当前行数_内容_string.substr (0 , 当前行数_内容_string.find (",")  ) ) , 0)
																				#设置X的值
			坐标 = Vector2 (坐标.x , float(当前行数_内容_string.substr (当前行数_内容_string.find (",") +1 ) ) )
																				#设置Y的值
			self.position = 坐标													#设置位置

		if ini数据[i].find ("Text=") != -1 :										#如果有"Text="
																				#(修改原本的贴图)
			var 文件路径 = OS.get_executable_path().get_base_dir() + 当前行数_内容_string
																				#获取文件路径
			var image  = Image.new()											#创建image
			image.load( 文件路径)													#读取贴图
			var texture = ImageTexture.create_from_image(image)					#将image设置为texture
			UI贴图_文本_原本的贴图 = texture										#保存贴图文件到变量
			文本 = TextureRect.new()
			文本.name = "文本"
			add_child (文本)
			文本.size = self.size
			文本.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			文本.texture = UI贴图_文本_原本的贴图
#————————————————————————————————#————————————————————————————————#—————————————#


#————————————————————————————————#————————————————————————————————#—————————————#
func 删除UI ():
	queue_free()
#————————————————————————————————#————————————————————————————————#—————————————#
