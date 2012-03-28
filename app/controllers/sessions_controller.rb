class SessionsController < ApplicationController
  def create
    @auth = Authentication.find_or_create_by_hash(auth_hash)

    if @auth then
      @auth.provider_token = auth_hash['credentials']['token']
      @auth.raw_details = auth_hash
      @auth.save

      sign_in(@auth.user)
      flash[:notice] = I18n.t('auth.success')
    else
      flash[:notice] = I18n.t('auth.failed')
    end
    redirect_to @auth.user
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end