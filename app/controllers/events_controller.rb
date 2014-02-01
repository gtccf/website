class EventsController < ApplicationController
  def index

    respond_to do |format|
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.timezone do
          timezone_id "America/New_York"
        end
        EventDecorator.decorate_collection(Event.all).each do |event|
          calendar.add_event(event.to_ics)
        end
        calendar.publish
        render text: calendar.to_ical
      end
      format.html do
        @events = EventDecorator.decorate_collection(Event.future)
      end
      format.json { render json: Event.all }
    end
  end

  def show
    @event = Event.find(params[:id]).decorate
  end
end
