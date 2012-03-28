class Pomodoro < ActiveRecord::Base

  belongs_to :user
  scope :running, where(:stopped_at => nil)

  def time_left
    (started_at + user.pomodoro_length_in_minutes * 1.minute) - Time.now
  end

end
