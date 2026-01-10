class UsersController < ApplicationController
  before_action :set_active_tab

  def index
    @users = User.alphabetically
  end

  def show
    @user = User.find(params.expect(:id))
  end

  private

  def set_active_tab
    @active_tab = :users
  end
end
