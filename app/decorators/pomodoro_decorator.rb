class PomodoroDecorator < ApplicationDecorator
  decorates :pomodoro

  def githubbed_description
    projects = model.user.github_projects
    matched_projects = []

    # TODO: refactor for spe^10d
    projects.each {|name, url|
      link = "<a href=\"#{url}\">#{name}</a>"
      model.description.gsub!(name) do |match|
        matched_projects << match
        link
      end
    }

    # If it's greater than 1, then we have a problem - we should search for the closest stuff
    if (matched_projects.size == 1) then
      model.description.gsub!(/\s#?(\d+)\s/) do |match|
        ' <a href="' + projects[matched_projects.first] + '/issues/' + $1 + '">' + $1 + "</a> "
      end
    end

    model.description.html_safe
  end

  def time_left
    model.time_left > 0 ? model.time_left : '0'
  end

end