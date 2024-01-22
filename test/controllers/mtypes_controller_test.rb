require "test_helper"

class MtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mtype = mtypes(:one)
  end

  test "should get index" do
    get mtypes_url
    assert_response :success
  end

  test "should get new" do
    get new_mtype_url
    assert_response :success
  end

  test "should create mtype" do
    assert_difference("Mtype.count") do
      post mtypes_url, params: { mtype: { name: @mtype.name } }
    end

    assert_redirected_to mtype_url(Mtype.last)
  end

  test "should show mtype" do
    get mtype_url(@mtype)
    assert_response :success
  end

  test "should get edit" do
    get edit_mtype_url(@mtype)
    assert_response :success
  end

  test "should update mtype" do
    patch mtype_url(@mtype), params: { mtype: { name: @mtype.name } }
    assert_redirected_to mtype_url(@mtype)
  end

  test "should destroy mtype" do
    assert_difference("Mtype.count", -1) do
      delete mtype_url(@mtype)
    end

    assert_redirected_to mtypes_url
  end
end
