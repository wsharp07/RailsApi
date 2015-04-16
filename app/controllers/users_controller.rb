class UsersController < ApplicationController

  layout 'login', :only => [:new]

  def new
    @user = User.new
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])

  end
end
