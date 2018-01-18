# CourseSelect [![Build Status](https://travis-ci.org/Westbrookl/course_select_change.svg?branch=master)](https://www.travis-ci.org/Westbrookl/course_select_change)
基于高级软件工程的提供的选课系统，对选课系统增加了一些功能。

## 云部署

项目部署在了腾讯云服务器上

公网地址为：http://111.230.224.216:8080/

### 部署过程
1. 安装和配置PostgreSQL
2. 安装rbenv工具
3. 安装Ruby
4. 安装Rails
5. 利用github将项目源码clone到服务器111.230.224.216
6. 进入项目路径下分别执行bundle install、rake db:migrate、rake db:seed
7. 启动项目rails server -b 111.230.224.216:8080 &
### 原有功能：

* 多角色登陆（学生，老师，管理员）
* 学生动态选课，退课
* 老师动态增加，删除课程
* 老师对课程下的学生添加、修改成绩
* 权限控制：老师和学生只能看到自己相关课程信息



### 新加功能
* 处理选课冲突、控制选课人数
* 统计选课学分，学位课等
* 显示个人课表
* 显示出选课学生的个人信息
* 详细介绍课程详情的页面
* 显示出选课人数

### 截图

<img src="/lib/screenshot1.png" width="700">  

<img src="/lib/screenshot2.png" width="700">

<img src="/lib/screenshot3.png" width="700">   

<img src="/lib/screenshot4.png" width="700">

* 统计选课学分，学位课等
<img src="/lib/图片1.png" width="700"> 
<img src="/lib/图片2.png" width="700"> 
* 处理选课冲突、控制选课人数
<img src="/lib/图片5.png" width="700"> 
<img src="/lib/图片6.png" width="700"> 
<img src="/lib/图片7.png" width="700"> 
<img src="/lib/图片8.png" width="700"> 

* 显示个人课表
<img src="/lib/图片10.png" width="700"> 
<img src="/lib/图片9.png" width="700"> 
* 显示出选课人数
<img src="/lib/图片11.png" width="700"> 
<img src="/lib/图片12.png" width="700"> 






