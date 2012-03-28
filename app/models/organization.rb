class Organization < ActiveRecord::Base

  has_many :memberships
  has_many :users, :through => :memberships

  belongs_to :owner, :class_name => 'User'

  after_create :create_owner_membership!
  def create_owner_membership!
    Membership.create({
      :user => owner,
      :organization => self,
      :status => 3
    })
  end

end
