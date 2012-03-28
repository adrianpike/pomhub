class UserDecorator < ApplicationDecorator
  decorates :user
  decorates_association :pomodoros

  def to_s
    model.to_s
  end

  def avatar
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
  end

  def active_pomodoro
    pomodoros.running.last
  end

  def time_left
    if active_pomodoro then
      time = PomodoroDecorator.decorate(active_pomodoro).time_left
      minutes, seconds = (time.divmod(1.minute))
      "#{minutes}:#{"%02d" % seconds.floor}"
    else
      '--:--'
    end
  end

  def pomodoro_description
    if active_pomodoro then
      PomodoroDecorator.decorate(pomodoros.running.last).try(:githubbed_description)
    else
      ''
    end
  end

end