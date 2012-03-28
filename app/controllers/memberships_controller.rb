class MembershipsController < ApplicationController

  before_filter :authenticate_user!

  respond_to :html

  def create
    @organization = current_user.owned_organizations.find(params[:organization_id])
    @membership = @organization.memberships.create(params[:membership])
    respond_with(@organization)
  end

  def approve
    @organization = Organization.find(params[:organization_id])
    @membership = find_manageable_membership

    @membership.status = Membership::STATUSES[:active]
    @membership.save
    respond_with(@organization)
  end

  def reject
    @organization = Organization.find(params[:organization_id])
    @membership = find_manageable_membership
    @membership.destroy

    respond_with(@organization)
  end

  private

  def find_manageable_membership
    @membership = @organization.memberships.pending.find(params[:id])

    case @membership.status
    when Membership::STATUSES[:pending_user]
      raise ActiveRecord::NotFound unless @membership.user == current_user
    when Membership::STATUSES[:pending_org]
      raise ActiveRecord::NotFound unless current_user.owned_organizations.find(@organization.id)
    end

    @membership
  end

end