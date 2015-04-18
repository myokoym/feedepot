class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def render_error(status_code, message)
    response_body = {
      error: {
        code: "0001-#{status_code}",
        message: message,
        time: Time.now,
      },
    }
    render json: response_body, status: status_code
  end
end
