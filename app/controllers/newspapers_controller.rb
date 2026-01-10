class NewspapersController < ApplicationController
  before_action :set_active_tab

  def index
    @newspapers = Newspaper.all
  end

  def show
    @newspaper = Newspaper.find(params.expect(:id))
  end

  private

  def set_active_tab
    @active_tab = :newspapers
  end
end
