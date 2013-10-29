require 'test_helper'

class MovementsControllerTest < ActionController::TestCase
  setup do
    @movement = movements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movement" do
    assert_difference('Movement.count') do
      post :create, movement: { account_amount: @movement.account_amount, account_id: @movement.account_id, amount: @movement.amount, description: @movement.description, is_transfer: @movement.is_transfer, mdate: @movement.mdate, movement_id: @movement.movement_id, mtype_id: @movement.mtype_id, name: @movement.name }
    end

    assert_redirected_to movement_path(assigns(:movement))
  end

  test "should show movement" do
    get :show, id: @movement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movement
    assert_response :success
  end

  test "should update movement" do
    patch :update, id: @movement, movement: { account_amount: @movement.account_amount, account_id: @movement.account_id, amount: @movement.amount, description: @movement.description, is_transfer: @movement.is_transfer, mdate: @movement.mdate, movement_id: @movement.movement_id, mtype_id: @movement.mtype_id, name: @movement.name }
    assert_redirected_to movement_path(assigns(:movement))
  end

  test "should destroy movement" do
    assert_difference('Movement.count', -1) do
      delete :destroy, id: @movement
    end

    assert_redirected_to movements_path
  end
end
