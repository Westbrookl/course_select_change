require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@course = Course.new(name:"name", course_type:"class_type", course_time:"course_time", course_week:"course_week", class_room:"class_room",
  		                credit:"credit", teaching_type:"teaching_type", exam_type:"exam_type")
  end

  test "should be valid" do
    assert  @course.valid?
  end

  test "name should be present" do
    @course.name = "     "
    assert_not @course.valid?
  end


  test "course_type should be present" do
    @course.course_type = "     "
    assert_not @course.valid?
  end

  
  test "course_time should be present" do
    @course.course_time = "     "
    assert_not @course.valid?
  end

  test "course_week should be present" do
    @course.course_week = "     "
    assert_not @course.valid?
  end

  test "class_room should be present" do
    @course.class_room = "     "
    assert_not @course.valid?
  end

  test "credit should be present" do
    @course.credit = "     "
    assert_not @course.valid?
  end

  test "teaching_type should be present" do
    @course.teaching_type = "     "
    assert_not @course.valid?
  end

  test "exam_type should be present" do
    @course.exam_type = "     "
    assert_not @course.valid?
  end

end
