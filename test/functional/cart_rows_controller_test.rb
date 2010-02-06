require 'test_helper'

class CartRowsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_rows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_row" do
    assert_difference('CartRow.count') do
      post :create, :cart_row => { }
    end

    assert_redirected_to cart_row_path(assigns(:cart_row))
  end

  test "should show cart_row" do
    get :show, :id => cart_rows(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cart_rows(:one).to_param
    assert_response :success
  end

  test "should update cart_row" do
    put :update, :id => cart_rows(:one).to_param, :cart_row => { }
    assert_redirected_to cart_row_path(assigns(:cart_row))
  end

  test "should destroy cart_row" do
    assert_difference('CartRow.count', -1) do
      delete :destroy, :id => cart_rows(:one).to_param
    end

    assert_redirected_to cart_rows_path
  end
end
