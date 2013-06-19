class StaffController < ApplicationController
  def index
    @staff = StaffDecorator.decorate(Staff.all)
  end
  
  def show
  end
end
