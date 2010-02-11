require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deliveries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery" do
    assert_difference('Delivery.count') do
      post :create, :delivery => { :product_type_id => 1, :quantity => 1 }
    end

    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should show delivery" do
    get :show, :id => deliveries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => deliveries(:one).to_param
    assert_response :success
  end

  test "should update delivery" do
    put :update, :id => deliveries(:one).to_param, :delivery => { }
    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should destroy delivery" do
    assert_difference('Delivery.count', -1) do
      delete :destroy, :id => deliveries(:one).to_param
    end

    assert_redirected_to deliveries_path
  end
end
