require 'test_helper'

class CodesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    # get "show"
    assert_response :success
  end

  test "test codes routes" do
    assert_generates("/codes", :controller => "codes", :action => "index")
  end

  test "test codes ajax route" do
    assert_generates("/codes/ajax_query", :controller => "codes", :action => "ajax_query", :method => "post")
  end

end
