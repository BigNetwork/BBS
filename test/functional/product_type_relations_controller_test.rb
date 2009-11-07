require 'test_helper'

class ProductTypeRelationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_type_relations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_type_relation" do
    assert_difference('ProductTypeRelation.count') do
      post :create, :product_type_relation => { }
    end

    assert_redirected_to product_type_relation_path(assigns(:product_type_relation))
  end

  test "should show product_type_relation" do
    get :show, :id => product_type_relations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => product_type_relations(:one).to_param
    assert_response :success
  end

  test "should update product_type_relation" do
    put :update, :id => product_type_relations(:one).to_param, :product_type_relation => { }
    assert_redirected_to product_type_relation_path(assigns(:product_type_relation))
  end

  test "should destroy product_type_relation" do
    assert_difference('ProductTypeRelation.count', -1) do
      delete :destroy, :id => product_type_relations(:one).to_param
    end

    assert_redirected_to product_type_relations_path
  end
end
