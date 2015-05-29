class SessionsController < ApplicationController

  def create
    session[:user_token] = env['omniauth.auth']['credentials']['token']
    session[:user_secret] = env['omniauth.auth']['credentials']['secret']
uid = env['omniauth.auth']['uid']
session[:user_id] = uid
user = User.find_or_create_by(twitter_id: uid)

user.update_attributes(name: env['omniauth.auth']['info']['name'],
                        email: env['omniauth.auth']['info']['email'],
                        nickname: env['omniauth.auth']['info']['nickname'].downcase,
                        user_token: env['omniauth.auth']['credentials']['token'],
                        user_token_secret: env['omniauth.auth']['credentials']['secret'])

    redirect_to root_path, notice: "You're logged in!"
  end

end
