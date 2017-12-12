class AddDescriptionToCourses < ActiveRecord::Migration
  def change
  	add_column :courses,:description,:string,default: '暂时还没有添加对于该课程的描述'

  end
end
