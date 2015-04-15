class SessionsController < ApplicationController
  def new
    render :layout =>  'login'
  end

  def create
    render 'new'
  end

  def destroy
  end
end
