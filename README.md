# LaLaLaRemove

for 玉美酱

##ViewController


一共三个场景：Device - Brand - Remove, 先选择电器，再选择品牌，出现按钮界面

分别对应 DeviceTableViewController - BrandTableViewController - RemoveViewController



##DataBase


####sqlite

项目使用的是SQLite数据库。

####fmdb

[fmdb](https://github.com/ccgus/fmdb)是github上的开源项目，是对一系列SQLite API进行了分装的库。 所有FM开头的文件都是fmdb的文件。

####lalalaDataBase

这个文件包含了所有我们对数据库的查询的函数

##Model

- WaveSerVice 生成音频数据 
- AudioPlay 播放音频

##Other

- GUAAAlertView 动态弹框效果
- DC开头的文件 按钮动态效果的文件
- Information DeviceItem BrandItem BrandItemGroup 都是对数据的分装
