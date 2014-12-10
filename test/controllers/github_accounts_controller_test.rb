require 'test_helper'

class GithubAccountsControllerTest < ActionController::TestCase
  setup do
    @github_account = github_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:github_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create github_account" do
    assert_difference('GithubAccount.count') do
      post :create, github_account: { client_id: @github_account.client_id, client_secret: @github_account.client_secret, name: @github_account.name, url: @github_account.url }
    end

    assert_redirected_to github_account_path(assigns(:github_account))
  end

  test "should show github_account" do
    get :show, id: @github_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @github_account
    assert_response :success
  end

  test "should update github_account" do
    patch :update, id: @github_account, github_account: { client_id: @github_account.client_id, client_secret: @github_account.client_secret, name: @github_account.name, url: @github_account.url }
    assert_redirected_to github_account_path(assigns(:github_account))
  end

  test "should destroy github_account" do
    assert_difference('GithubAccount.count', -1) do
      delete :destroy, id: @github_account
    end

    assert_redirected_to github_accounts_path
  end
end
