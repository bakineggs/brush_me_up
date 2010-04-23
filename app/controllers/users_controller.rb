class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes params[:user]
    redirect_to :controller => :memos, :action => :index
  end
end
