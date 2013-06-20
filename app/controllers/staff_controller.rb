class StaffController < ApplicationController
  def index
    @staff = StaffDecorator.decorate_collection(Staff.all)
  end
  
  def show
  end
end
