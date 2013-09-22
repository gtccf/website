class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id]).decorate
  end
end
