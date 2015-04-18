class ResourcesController < ApplicationController
  def index
    render json: {}
  end

  def show
    render json: {}
  end

  def create
    begin
      columns = Resource.parse(params[:url])
    rescue
      render_error(400, $!.message)
      return
    end
    resource = Resource.create(columns)

    response_body = {
      resource: resource.attributes.compact
    }

    render json: response_body
  end

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
