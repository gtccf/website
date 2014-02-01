class EventsController < ApplicationController
  def index
    @events = EventDecorator.decorate_collection Event.future

    respond_to do |format|
      format.html # show.html.erb
      format.ics do
        calendar = Icalendar::Calendar.new
        @events.each do |event|
          calendar.add_event(event.to_ics)
        end
        calendar.publish
        render text: calendar.to_ical
      end
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.find(params[:id]).decorate
  end
end
