class Authentication < ActiveRecord::Base

  belongs_to :user

  def self.find_or_create_by_hash(auth_hash)
    auth = self.where({
      :provider => auth_hash['provider'],
      :provider_id => auth_hash['info']['uid']
    }).first
    unless auth and auth.user then
      auth ||= self.new({
        :provider => auth_hash['provider'],
        :provider_id => auth_hash['info']['uid']
      })
      user = User.find_or_create_by_email(auth_hash['info']['email'])
#      user.name = auth_hash['info']['name']
      user.username = auth_hash['info']['nickname']
      auth.user = user
      auth.save!
    end

    auth
  end

end
