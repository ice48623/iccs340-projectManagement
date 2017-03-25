require 'test_helper'

class TcommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tcomment = tcomments(:one)
  end

  test "should get index" do
    get tcomments_url
    assert_response :success
  end

  test "should get new" do
    get new_tcomment_url
    assert_response :success
  end

  test "should create tcomment" do
    assert_difference('Tcomment.count') do
      post tcomments_url, params: { tcomment: { content: @tcomment.content, task_id: @tcomment.task_id, user_id: @tcomment.user_id } }
    end

    assert_redirected_to tcomment_url(Tcomment.last)
  end

  test "should show tcomment" do
    get tcomment_url(@tcomment)
    assert_response :success
  end

  test "should get edit" do
    get edit_tcomment_url(@tcomment)
    assert_response :success
  end

  test "should update tcomment" do
    patch tcomment_url(@tcomment), params: { tcomment: { content: @tcomment.content, task_id: @tcomment.task_id, user_id: @tcomment.user_id } }
    assert_redirected_to tcomment_url(@tcomment)
  end

  test "should destroy tcomment" do
    assert_difference('Tcomment.count', -1) do
      delete tcomment_url(@tcomment)
    end

    assert_redirected_to tcomments_url
  end
end
