class UsersController < ApplicationController
  def index
    @users = User.alphabetically
  end

  def show
    @user = User.find(params.expect(:id))
  end
end
