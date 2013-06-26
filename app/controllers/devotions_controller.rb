class DevotionsController < ApplicationController
  before_action :set_devotion, only: [:show]

  # GET /devotions
  def index
    @devotions = Devotion.latest
  end

  def today
    @devotion = Devotion.today.decorate
  end

  # GET /devotions/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devotion
      @devotion = Devotion.find(params[:id])
      @devotion = DevotionDecorator.decorate(@devotion)
    end

    # Only allow a trusted parameter "white list" through.
    def devotion_params
      params.require(:devotion).permit(:title, :release_date, :body)
    end
end
