class PodcastsController < ApplicationController
  before_action :set_active_tab

  def index
    @podcasts = Podcast.all
  end

  def show
    @podcast = Podcast.find(params.expect(:id))
  end

  private

  def set_active_tab
    @active_tab = :podcasts
  end
end
