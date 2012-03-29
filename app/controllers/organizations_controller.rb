class OrganizationsController < ApplicationController

  before_filter :authenticate_user!

  respond_to :html

  def index
    @organizations = Organization.public.all
  end

  def show
    @organization = Organization.find(params[:id])
    @users = UserDecorator.decorate(@organization.memberships.active.collect(&:user).flatten)
  end

  def new
    @organization = current_user.owned_organizations.build
  end

  def create
    @organization = current_user.owned_organizations.create(params[:organization])
    respond_with(@organization)
  end

  def edit
    @organization = current_user.owned_organizations.find(params[:id])
    respond_with(@organization)
  end

  def update
    @organization = current_user.owned_organizations.find(params[:id])
    @organization.update_attributes(params[:organization])
    respond_with(@organization)
  end

end