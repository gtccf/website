class DevotionsController < ApplicationController
  before_action :set_devotion, only: [:show]

  # GET /devotions
  def index
    @devotions = Devotion.latest
  end

  def today
    @devotion = Devotion.today
    @devotion = DevotionDecorator.decorate(@devotion) if @devotion
  end

  # GET /devotions/1
  def show
  end

  private
  def set_devotion
    @devotion = Devotion.find(params[:id])
    @devotion = DevotionDecorator.decorate(@devotion)
  end
end
