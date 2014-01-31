class Admin::EventsController < Admin::AdminController
  def index
    @events = EventDecorator.decorate_collection(Event.all)
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id]).decorate
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.tag_ids = params[:event][:tag_ids]
    if @event.update(event_params)
      flash[:success] = "Updated event"
      redirect_to [:admin, @event]
    else
      render 'edit', status: 400
    end
  end
  def create
    @event = Event.new(event_params)
    @event.tag_ids = params[:event][:tag_ids]

    if @event.save
      flash[:success] = "Event created"
      redirect_to [:admin, @event]
    else
      render 'new', status: 400
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Event destroyed"
      redirect_to admin_event_path
    else
      render 'show', status: 400
    end
  end

  private
  def event_params
    params.require(:event).permit(
      :title, :short_description, :description, :time, :tag_ids
    )
  end
end
