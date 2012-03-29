class Membership < ActiveRecord::Base
  STATUSES = {
    :pending_user => 0,
    :pending_org => 1,
    :active => 2
  }

  belongs_to :organization
  belongs_to :user

  validates_presence_of :user_id
  validates_uniqueness_of :user_id, :scope => :organization_id

  scope :pending, where('status != ?', STATUSES[:active])
  scope :pending_user, where(:status => STATUSES[:pending_user])
  scope :pending_org, where(:status => STATUSES[:pending_org])
  scope :active, where(:status => STATUSES[:active])

  def friendly_status # TODO: decorate
    STATUSES.invert[status]
  end

  attr_accessor :email
  before_validation :fetch_user_by_email
  def fetch_user_by_email
    unless self.user or self.user_id then
      self.user = User.find_or_create_by_email(self.email)
      raise Exception unless self.user
    end
  end

  after_create :send_email_notification
  def send_email_notification

  end
end
