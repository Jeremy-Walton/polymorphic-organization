class FeedsController < ApplicationController
  before_action :set_active_tab

  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params.expect(:id))
  end

  private

  def set_active_tab
    @active_tab = :feeds
  end
end
