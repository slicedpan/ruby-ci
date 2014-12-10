require 'test_helper'

class ExamplesControllerTest < ActionController::TestCase
  setup do
    @example = examples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create example" do
    assert_difference('Example.count') do
      post :create, example: { description: @example.description, filename: @example.filename, line_number: @example.line_number, status: @example.status, test_run_id: @example.test_run_id }
    end

    assert_redirected_to example_path(assigns(:example))
  end

  test "should show example" do
    get :show, id: @example
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @example
    assert_response :success
  end

  test "should update example" do
    patch :update, id: @example, example: { description: @example.description, filename: @example.filename, line_number: @example.line_number, status: @example.status, test_run_id: @example.test_run_id }
    assert_redirected_to example_path(assigns(:example))
  end

  test "should destroy example" do
    assert_difference('Example.count', -1) do
      delete :destroy, id: @example
    end

    assert_redirected_to examples_path
  end
end
