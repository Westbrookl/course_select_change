require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "homepage layout links" do
    get root_path
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", "/site/87?a=6c7df663e7874160b91a2805b236ce90"
    assert_select "a[href=?]", "/site/87?a=833fc2b8a0ee441593a7b90633daffd4"
    assert_select "a[href=?]", "/site/87?a=ba35c9045997416aa4a1a738afb4fd84"
  end

end
