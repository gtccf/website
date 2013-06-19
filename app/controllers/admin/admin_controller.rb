class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!, :require_admin!
  layout 'admin'

  def index
  end

  private
  def require_admin!
    unless current_user.admin?
      flash[:notice] = 'You must be an administrator to do that'
      redirect_to root_path
    end
  end
end
