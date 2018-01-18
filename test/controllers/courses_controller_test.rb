require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get new" do
    get :new 
    assert_response :success
  end

  test "should get create" do
    @course = Course.all.first
    patch :create ,course: { id: 2,name: 'coursename1',open: true }
    assert_response :success
  end

  test "should get edit" do
    get :edit ,id: 2
    assert_response :success
  end

  test "should get update" do
    @course = Course.all.first
    patch :update ,id: @course,course: {id: 2,name: 'coursename1',open: true }
    assert_redirected_to courses_path
  end

  # test "should get destroy" do
  #   get :destroy ,id: 2
  #   assert_redirected_to courses_path
  # end

  test "should open course" do
    get :open ,id: 2
    assert_redirected_to courses_path
  end

  test "should close course" do
    get :close ,id: 2
    assert_redirected_to courses_path
  end

  # test "should select" do
  #   get :select , id: 2
  #   assert_redirected_to courses_path
  # end

  # test "should quit" do
  #   get :quit , id: 2
  #   assert_redirected_to courses_path
  # end
  
end
