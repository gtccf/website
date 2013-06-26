class Admin::DevotionsController < Admin::AdminController
  before_action :set_devotion, only: [:show, :edit, :update, :destroy]

  # GET /devotions
  def index
    @devotions = Devotion.all
  end

  # GET /devotions/1
  def show
  end

  # GET /devotions/new
  def new
    @devotion = Devotion.new
  end

  # GET /devotions/1/edit
  def edit
  end

  # POST /devotions
  def create
    @devotion = Devotion.new(devotion_params)

    if @devotion.save
      redirect_to [:admin, @devotion], notice: 'Devotion was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /devotions/1
  def update
    if @devotion.update(devotion_params)
      redirect_to [:admin, @devotion], notice: 'Devotion was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /devotions/1
  def destroy
    @devotion.destroy
    redirect_to devotions_url, notice: 'Devotion was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devotion
      @devotion = Devotion.find(params[:id])
      @devotion = DevotionDecorator.decorate @devotion
    end

    # Only allow a trusted parameter "white list" through.
    def devotion_params
      params.require(:devotion).permit(:title, :release_date, :body)
    end
end
