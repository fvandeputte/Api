require 'test_helper'

class NoticiaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @noticium = noticia(:one)
  end

  test "should get index" do
    get noticia_url, as: :json
    assert_response :success
  end

  test "should create noticium" do
    assert_difference('Noticium.count') do
      post noticia_url, params: { noticium: { body: @noticium.body, subtitle: @noticium.subtitle, title: @noticium.title } }, as: :json
    end

    assert_response 201
  end

  test "should show noticium" do
    get noticium_url(@noticium), as: :json
    assert_response :success
  end

  test "should update noticium" do
    patch noticium_url(@noticium), params: { noticium: { body: @noticium.body, subtitle: @noticium.subtitle, title: @noticium.title } }, as: :json
    assert_response 200
  end

  test "should destroy noticium" do
    assert_difference('Noticium.count', -1) do
      delete noticium_url(@noticium), as: :json
    end

    assert_response 204
  end
end
