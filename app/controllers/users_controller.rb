class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]

  respond_to :html

  def index
    @users = UserDecorator.decorate(User.public.all)
  end

  def show
    @user = UserDecorator.decorate(User.find(params[:id]))
  end

  def edit
    @user = UserDecorator.decorate(current_user)
  end

  def update
    @user = UserDecorator.decorate(current_user)
    @user.update_attributes(params[:user])
    respond_with(@user)
  end

end
