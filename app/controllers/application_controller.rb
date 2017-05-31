class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    render html: "payam is here"
  end
end
