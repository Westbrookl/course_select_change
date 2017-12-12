class CoursesController < ApplicationController

  before_action :student_logged_in, only: [:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    redirect_to courses_path, flash: {:success => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    redirect_to courses_path, flash: {:success => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #-------------------------for students----------------------

  def list
    #-------QiaoCode--------
    @courses = Course.where(:open=>true).paginate(page: params[:page], per_page: 4)
    @course = @courses-current_user.courses
    tmp=[]
    @course.each do |course|
      if course.open==true
        tmp<<course
      end
    end
    @course=tmp
  end

  def describe
    @course = Course.find_by_id(params[:id])
    render '/courses/description'   #@course.description 
  end

  def select

      flag = nil
      @courses = current_user.courses
      @course = Course.find_by_id(params[:id])
      #-----------------------------add_degree_course
      degree_course_value = params[:flag]
      # flash[:success] = degree_course_value
      if(degree_course_value)
      @course.update_attribute(:course_degree,degree_course_value)
      end
      #-----------------------
       @courses.each do |course|
        temp = timeSplit(course.course_time.to_s,"(")##weekday
        temp1 = timeSplit(temp[1].to_s,")")###9-11  第2-20周
        temp2 = timeSplit(@course.course_time.to_s,"(")#周一(9-11)
        temp3 = timeSplit(temp2[1].to_s,")")##7-9
        temp4 = timeSplit(temp1[0].to_s,"-")
        temp5 = timeSplit(temp3[0].to_s,"-")
        temp6 = time_conflict(temp4[0].to_i,temp4[1].to_i,temp5[0].to_i,temp5[1].to_i)###上课时间判断
        is_week_conflict = timeSplit(course.course_week,"-")
        num12 = is_week_conflict[1].to_i###20
        is_week_conflict_temp = timeSplit(is_week_conflict[0].to_s,"第")
        num11 = is_week_conflict_temp[1].to_i
        now_course_week =timeSplit(@course_week,"-")
        num14 = now_course_week[1].to_i
        now_course_week_temp = timeSplit(now_course_week[0],"第")
        num13 = now_course_week_temp[1].to_i
        @temp7 = time_conflict(num11,num12,num13,num14)

         if(temp[0] == temp2[0] && temp6.nil? && @temp7.nil?)
           flash[:danger] = "时间冲突"                                                                                                                                                                                                  
           flag = true
           redirect_to courses_path
           break                                                                                                                                                                                             
         end

        end
      if(flag.nil? && @course.student_num <= @course.limit_num && !@temp7.nil?)
        student_num=@course.student_num
        student_num += 1
        @course.update_attribute(:student_num,student_num)
        # @course.student_num = student_num
        current_user.courses<<@course
        flash={:suceess => "成功选择课程: #{@course.name}"}
       redirect_to courses_path, flash: flash
       elsif(@course.student_num > @course.limit_num)
        flash={:danger => "选课人数已满"}
        redirect_to courses_path, flash: flash
      end



    # flag = true
    # @courses = current_user.courses
    # @course=Course.find_by_id(params[:id])
    # # @degree_course = params[:choice]
    # # if(!@degree_course)
    # #   flash={:danger => "#{@degree_course}"}
    # #   redirect_to courses_path,flash:flash
    # # elsif
    #  @courses.each do |i|
    #   temp = timeSplit(i.course_time.to_s,"(")##weekday
    #   temp1 = timeSplit(temp[1].to_s,")")###9-11
    #   temp2 = timeSplit(@course.course_time.to_s,"(")
    #   temp3 = timeSplit(temp2[1].to_s,")")##7-9
    #   temp4 = timeSplit(temp1[0].to_s,"-")
    #   temp5 = timeSplit(temp3[0].to_s,"-")
    #   temp6 = searchTime(temp4[0].to_i,temp4[1].to_i,temp5[0].to_i,temp5[1].to_i)
    #    if(temp[0] == temp2[0] && temp6 )
    #     flash[:danger] = "time     conflict"                                                                                                                                                                                                  
    #     flag = nil
    #     redirect_to courses_path
    #    end
 end    

  def quit
    @course=Course.find_by_id(params[:id])
    student_num=@course.student_num
    student_num -= 1
    @course.update_attribute(:student_num,student_num)
    current_user.courses.delete(@course)
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @course=current_user.teaching_courses.paginate(page: params[:page], per_page: 4) if teacher_logged_in?
    @course=current_user.courses.paginate(page: params[:page], per_page: 4) if student_logged_in?
    total_scores = 0
    total_degree_score = 0
     @course.each do |course|
      temp = timeSplit(course.credit,"/")
      total_scores += temp[1].to_i
      if(course.course_degree)
        total_degree_score += temp[1].to_i
      end
     end
     @total_scores =total_scores
     @total_degree_score = total_degree_score
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week,:description)
  end
  

  def timeSplit(strings,symbol)
    # return string.split(symbol)
    strings.to_s.split(symbol)
  end

  def time_conflict(num1,num2,num3,num4)##Fnum ==Frist num Snum=Second num Tnum=Third num FO=fourth num
     flag1 = false

    (num1..num2).each do |time1|
      (num3..num4).each do|time2|
        if (time1 == time2)
          flag1 = true
          return nil
          break
        end
       end
       if(flag1)
        break
       end

    end
  end



end
