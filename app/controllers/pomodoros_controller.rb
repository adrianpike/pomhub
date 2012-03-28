class PomodorosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!

  respond_to :html

  def start
    @pomodoro = current_user.pomodoros.create(params[:pomodoro].merge({
      :started_at => Time.now
    }))
    respond_with([current_user, @pomodoro])
  end

  def stop
    @pomodoro = current_user.pomodoros.running.last
    @pomodoro.stopped_at = Time.now
    @pomodoro.save
    respond_with([current_user, @pomodoro])
  end

  def new
    @pomodoro = current_user.pomodoros.build
    respond_with(@pomodoro)
  end

  def create
    @pomodoro = current_user.pomodoros.create(params[:pomodoro].merge({
      :started_at => Time.now
    }))
    respond_with(current_user)
  end

  def destroy
    @pomodoro = current_user.pomodoros.find(params[:id])
    @pomodoro.destroy

    respond_with(current_user)
  end

end