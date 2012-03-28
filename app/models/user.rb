require 'digest/md5'


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :public, :pomodoro_length_in_minutes

  before_save :ensure_authentication_token

  scope :public, where(:public => true)

  has_many :pomodoros
  has_many :authentications

  has_many :owned_organizations, :class_name => 'Organization', :foreign_key => 'owner_id'
  has_many :memberships
  has_many :organizations, :through => :memberships

  validates_presence_of :email
  validates_length_of :email, :in => 2..128
  # validates_format_of email not suck # TODO

  def github_projects
    Rails.cache.fetch("/users/#{self.id}/github_projects", :expires_in => 1.day) {
      gh = Github.new(authentications.where(:provider => 'github').first.provider_token)
      gh.repos
    }
  end

  # This stuff isn't in the decorator, because it's used for current_user, which isn't decorated.
  def to_s
    username || sanitized_email || 'Anonymous'
  end

  def sanitized_email
    email.split('@').first
  end

end
