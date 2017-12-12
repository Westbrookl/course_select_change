class AccountActivationsController < ApplicationController




	def edit
	  user = User.find_by(email: parmas[:email])
	  if user && !user.activated? && user.authenticated?(:activation,params[:id])
	  	user.update_attribute(:activated,true)
	  	user.update_attribute(:activated_at,Time.zone.now)
	  	log_in user
	  	flash[:success] = "验证成功"
	  	redirecte_to user
	  else
 		flash[:danger] = "无效的链接"
 	    redirecte_to root_url
 	   end
	  	# user.activated = true对于属性值需要使用方法update——attribute
	  	# user.activated_at = Time.zone.now
	  end
	 end
end
