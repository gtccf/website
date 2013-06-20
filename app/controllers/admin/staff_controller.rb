class Admin::StaffController < Admin::AdminController
  def index
    @staff = Staff.all
  end

  def show
    @staff = StaffDecorator.decorate(Staff.find params[:id])
  end

  def new
    @staff = Staff.create(name: "New Hire")
    redirect_to :back
  end

  def up
    staff = Staff.find(params[:staff_id])
    staff.weight -= 1
    staff.save
    redirect_to :back
  end

  def edit
    @staff = Staff.find params[:id]
  end

  def reset_sort
    Staff.all.each {|s| s.update_attribute :weight, 0}
    redirect_to :back
  end

  def update
    @staff = Staff.find params[:id]
    s = params[:staff]
    @staff.name = s[:name]
    @staff.title = s[:title]
    @staff.email = s[:email]
    @staff.portrait = s[:portrait]
    @staff.about = s[:about]
    respond_to do |format|
      if @staff.save
        flash[:success] = 'Updated staff successfully'
        format.html { redirect_to [:admin, @staff] }
      else
        format.html { render 'new', status: 400 }
      end
    end
  end

  def create
    @staff = Staff.new(params[:staff])

    respond_to do |format|
      if @staff.save
        flash[:success] = 'Successfully created staff'
        format.html { redirect_to [:admin, @staff] }
      else
        format.html { render 'new', status: 400 }
      end
    end
  end

  def destroy
    @staff = Staff.find params[:id]
    @staff.destroy

    respond_to do |format|
      flash[:success] = 'Deleted staff successfully'
      format.html { redirect_to admin_staff_index_path }
    end
  end
end
