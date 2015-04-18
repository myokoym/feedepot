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
end
